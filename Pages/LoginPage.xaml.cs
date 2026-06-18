using System.Linq;
using System.Data.Entity;
using System.Windows;
using System.Windows.Controls;
using WarehouseManagement.ApplicationData;

namespace WarehouseManagement.Pages
{
    public partial class LoginPage : Page
    {
        public LoginPage() { InitializeComponent(); }
        private bool ValidateForm()
        {
            var e1 = InputValidationHelper.ValidateLogin(txtLogin.Text.Trim()); InputValidationHelper.Mark(txtLogin, errLogin, e1);
            var e2 = string.IsNullOrWhiteSpace(txtPassword.Password) ? "Пароль обязателен: введите пароль аккаунта." : null; InputValidationHelper.Mark(txtPassword, errPassword, e2);
            return e1 == null && e2 == null;
        }
        private void ValidateLoginField(object s, TextChangedEventArgs e) { if (IsLoaded) ValidateForm(); }
        private void ValidatePasswordField(object s, RoutedEventArgs e) { if (IsLoaded) ValidateForm(); }
        private void btnLogin_Click(object s, RoutedEventArgs e)
        {
            if (!ValidateForm()) return;
            var login = txtLogin.Text.Trim(); var pass = txtPassword.Password;
            var u = AppConnect.model01.Users.Include("UserRoles").FirstOrDefault(x => x.Login == login && x.Password == pass);
            if (u == null || u.IsBlocked) { MessageBox.Show("Неверный логин, пароль или пользователь заблокирован"); return; }
            AppConnect.CurrentUser = u; WarehouseService.Log("Вход", "Users", u.UserID, "Авторизация в системе"); AppFrame.frmMain.Navigate(new InventoryOverviewPage());
        }
        private void btnReg_Click(object s, RoutedEventArgs e) { AppFrame.frmMain.Navigate(new UserRegistrationPage()); }
    }
}
