using System.Globalization;
using System.Text.RegularExpressions;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;

namespace WarehouseManagement.ApplicationData
{
    public static class InputValidationHelper
    {
        private static readonly Regex LoginRegex = new Regex(@"^[A-Za-z0-9._-]{3,50}$", RegexOptions.Compiled);
        private static readonly Regex EmailRegex = new Regex(@"^[^\s@]+@[^\s@]+\.[^\s@]+$", RegexOptions.Compiled | RegexOptions.IgnoreCase);
        private static readonly Regex PhoneDigitsRegex = new Regex(@"^[+\d\s()\-]+$", RegexOptions.Compiled);
        private static readonly Regex PhoneRegex = new Regex(@"^\+7\d{10}$", RegexOptions.Compiled);
        private static readonly Regex IntegerRegex = new Regex(@"^\d+$", RegexOptions.Compiled);
        private static readonly Regex DecimalRegex = new Regex(@"^\d+([\.,]\d{1,2})?$", RegexOptions.Compiled);
        private static readonly Brush DefaultBorderBrush = new SolidColorBrush(Color.FromRgb(122, 138, 121));
        private static readonly Brush ErrorBorderBrush = new SolidColorBrush(Color.FromRgb(176, 48, 40));
        private static readonly Brush SuccessBorderBrush = new SolidColorBrush(Color.FromRgb(65, 116, 62));

        public static string Required(string value, string fieldName)
        {
            return string.IsNullOrWhiteSpace(value) ? fieldName + " обязательно для заполнения." : null;
        }

        public static string ValidateFullName(string fullName)
        {
            if (string.IsNullOrWhiteSpace(fullName)) return "ФИО обязательно: укажите фамилию и имя.";
            if (fullName.Trim().Length < 5) return "ФИО слишком короткое: укажите минимум 5 символов.";
            if (Regex.IsMatch(fullName, @"\d")) return "ФИО не должно содержать цифры: используйте только буквы, пробелы и дефисы.";
            return null;
        }

        public static string ValidateLogin(string login)
        {
            if (string.IsNullOrWhiteSpace(login)) return "Логин обязателен: введите 3-50 символов.";
            if (!LoginRegex.IsMatch(login)) return "Логин введён неверно: разрешены латинские буквы, цифры и . _ -; длина 3-50 символов.";
            return null;
        }

        public static string ValidatePassword(string password)
        {
            if (string.IsNullOrEmpty(password)) return "Пароль обязателен.";
            if (password.Length < 6) return "Пароль слишком короткий: минимум 6 символов.";
            return null;
        }

        public static string ValidateEmail(string email)
        {
            if (string.IsNullOrWhiteSpace(email)) return "Email обязателен: например name@example.com.";
            if (!EmailRegex.IsMatch(email)) return "Email введён неверно: проверьте символ @ и домен, например name@example.com.";
            return null;
        }

        public static string ValidateOptionalEmail(string email)
        {
            return string.IsNullOrWhiteSpace(email) ? null : ValidateEmail(email);
        }

        public static string ValidatePhone(string phone)
        {
            if (string.IsNullOrWhiteSpace(phone)) return "Телефон обязателен: введите номер в формате +79990009900.";
            if (!PhoneDigitsRegex.IsMatch(phone)) return "Телефон содержит буквы или лишние символы: разрешены цифры, +, пробелы, скобки и дефисы.";
            if (!PhoneRegex.IsMatch(NormalizePhone(phone))) return "Телефон введён неверно: нужен российский номер +7 и 10 цифр после него, например +79990009900.";
            return null;
        }

        public static string NormalizePhone(string phone)
        {
            return (phone ?? string.Empty).Replace(" ", string.Empty).Replace("-", string.Empty).Replace("(", string.Empty).Replace(")", string.Empty);
        }

        public static void Mark(Control control, TextBlock errorBlock, string error)
        {
            if (control == null) return;
            control.BorderBrush = string.IsNullOrEmpty(error) ? SuccessBorderBrush : ErrorBorderBrush;
            control.BorderThickness = string.IsNullOrEmpty(error) ? new Thickness(1) : new Thickness(2);
            control.ToolTip = error;
            if (errorBlock != null)
            {
                errorBlock.Text = error ?? string.Empty;
                errorBlock.Visibility = string.IsNullOrEmpty(error) ? Visibility.Collapsed : Visibility.Visible;
            }
        }

        public static bool ValidateCombo(ComboBox comboBox, TextBlock errorBlock, string fieldName)
        {
            var error = comboBox.SelectedItem == null ? fieldName + " обязательно: выберите значение из списка." : null;
            Mark(comboBox, errorBlock, error);
            return error == null;
        }

        public static bool TryParsePrice(string rawPrice, out decimal price, out string errorMessage)
        {
            price = 0; errorMessage = null;
            if (string.IsNullOrWhiteSpace(rawPrice)) { errorMessage = "Цена обязательна: введите число, например 1499.90."; return false; }
            if (!DecimalRegex.IsMatch(rawPrice.Trim())) { errorMessage = "Цена введена неверно: разрешены только цифры и десятичный разделитель, до 2 знаков после запятой."; return false; }
            if (!decimal.TryParse(rawPrice.Trim().Replace(',', '.'), NumberStyles.Number, CultureInfo.InvariantCulture, out price)) { errorMessage = "Цена введена неверно: введите число, например 1499.90."; return false; }
            if (price < 0) { errorMessage = "Цена не может быть отрицательной."; return false; }
            return true;
        }

        public static bool TryParseQuantity(string rawQuantity, out int quantity, out string errorMessage)
        {
            quantity = 0; errorMessage = null;
            if (string.IsNullOrWhiteSpace(rawQuantity)) { errorMessage = "Количество обязательно: введите целое число."; return false; }
            if (!IntegerRegex.IsMatch(rawQuantity.Trim())) { errorMessage = "Количество введено неверно: разрешены только целые цифры без букв и знаков."; return false; }
            if (!int.TryParse(rawQuantity.Trim(), out quantity)) { errorMessage = "Количество слишком большое или введено неверно."; return false; }
            if (quantity <= 0) { errorMessage = "Количество должно быть больше нуля."; return false; }
            return true;
        }

        public static bool TryParseDate(string rawDate, out System.DateTime date, out string errorMessage)
        {
            date = default(System.DateTime); errorMessage = null;
            if (!System.DateTime.TryParseExact(rawDate, "dd.MM.yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out date))
            { errorMessage = "Дата введена неверно: ожидается формат дд.ММ.гггг, например 20.10.2009."; return false; }
            return true;
        }
    }
}
