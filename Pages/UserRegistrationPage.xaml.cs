using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using WarehouseManagement.ApplicationData;

namespace WarehouseManagement.Pages
{
    public partial class UserRegistrationPage : Page
    {
        public UserRegistrationPage() { InitializeComponent(); }
        private void btnBack_Click(object s, RoutedEventArgs e) { AppFrame.frmMain.GoBack(); }

        private bool ValidateForm()
        {
            var ok = true;
            string error;
            error = InputValidationHelper.ValidateFullName(txtName.Text); InputValidationHelper.Mark(txtName, errName, error); ok &= error == null;
            error = InputValidationHelper.ValidateLogin(txtLogin.Text.Trim()); InputValidationHelper.Mark(txtLogin, errLogin, error); ok &= error == null;
            error = InputValidationHelper.ValidatePassword(txtPassword.Password); InputValidationHelper.Mark(txtPassword, errPassword, error); ok &= error == null;
            error = txtPassword.Password == txtPasswordRepeat.Password ? null : "Пароли не совпадают: повторите пароль точно так же."; InputValidationHelper.Mark(txtPasswordRepeat, errPasswordRepeat, error); ok &= error == null;
            error = InputValidationHelper.ValidateEmail(txtEmail.Text); InputValidationHelper.Mark(txtEmail, errEmail, error); ok &= error == null;
            error = InputValidationHelper.ValidatePhone(txtPhone.Text); InputValidationHelper.Mark(txtPhone, errPhone, error); ok &= error == null;
            return ok;
        }

        private void ValidateRegistrationField(object sender, TextChangedEventArgs e) { if (IsLoaded) ValidateForm(); }
        private void ValidateRegistrationPassword(object sender, RoutedEventArgs e) { if (IsLoaded) ValidateForm(); }

        private void btnRegister_Click(object s, RoutedEventArgs e)
        {
            if (!ValidateForm()) { MessageBox.Show("Исправьте подсвеченные поля: под каждым полем есть объяснение ошибки."); return; }
            if (AppConnect.model01.Users.Any(x => x.Login == txtLogin.Text.Trim())) { InputValidationHelper.Mark(txtLogin, errLogin, "Логин занят: выберите другой логин."); return; }
            var role = AppConnect.model01.UserRoles.First(x => x.RoleName == "Менеджер");
            var u = new Users { FullName = txtName.Text.Trim(), Login = txtLogin.Text.Trim(), Password = txtPassword.Password, Email = txtEmail.Text.Trim(), Phone = InputValidationHelper.NormalizePhone(txtPhone.Text), RoleID = role.RoleID, CreatedAt = DateTime.Now, IsBlocked = false };
            AppConnect.model01.Users.Add(u); AppConnect.model01.SaveChanges(); MessageBox.Show("Пользователь создан"); AppFrame.frmMain.GoBack();
        }
    }
}
