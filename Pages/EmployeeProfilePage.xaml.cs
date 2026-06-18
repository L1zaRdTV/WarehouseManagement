using System;
using System.Windows;
using System.Windows.Controls;
using WarehouseManagement.ApplicationData;

namespace WarehouseManagement.Pages
{
    public partial class EmployeeProfilePage : Page
    {
        private bool isEditing;

        public EmployeeProfilePage()
        {
            InitializeComponent();
            LoadProfile();
        }

        private void LoadProfile()
        {
            var user = AppConnect.CurrentUser;
            tbFullName.Text = "ФИО: " + user.FullName;
            tbLogin.Text = "Логин: " + user.Login;
            tbEmail.Text = "Email: " + user.Email;
            tbPhone.Text = "Телефон: " + user.Phone;
            tbRole.Text = "Роль: " + (user.UserRoles == null ? "не указана" : user.UserRoles.RoleName);
            tbCreatedAt.Text = "Дата регистрации: " + user.CreatedAt.ToString("dd.MM.yyyy HH:mm");

            txtFullName.Text = user.FullName;
            txtEmail.Text = user.Email;
            txtPhone.Text = user.Phone;
        }

        private void SetEditMode(bool value)
        {
            isEditing = value;
            spReadOnlyInfo.Visibility = value ? Visibility.Collapsed : Visibility.Visible;
            spEditInfo.Visibility = value ? Visibility.Visible : Visibility.Collapsed;
            btnCancelEdit.Visibility = value ? Visibility.Visible : Visibility.Collapsed;
            btnEditProfile.Content = value ? "Сохранить" : "Изменить данные";
        }

        private void btnBack_Click(object sender, RoutedEventArgs e)
        {
            AppFrame.frmMain.GoBack();
        }

        private bool ValidateForm()
        {
            var ok = true;
            string error;
            error = InputValidationHelper.ValidateFullName(txtFullName.Text); InputValidationHelper.Mark(txtFullName, errFullName, error); ok &= error == null;
            error = InputValidationHelper.ValidateEmail(txtEmail.Text); InputValidationHelper.Mark(txtEmail, errEmail, error); ok &= error == null;
            error = InputValidationHelper.ValidatePhone(txtPhone.Text); InputValidationHelper.Mark(txtPhone, errPhone, error); ok &= error == null;
            return ok;
        }

        private void ValidateProfileField(object sender, TextChangedEventArgs e) { if (IsLoaded && isEditing) ValidateForm(); }

        private void btnEditProfile_Click(object sender, RoutedEventArgs e)
        {
            if (!isEditing)
            {
                SetEditMode(true);
                ValidateForm();
                return;
            }

            if (!ValidateForm())
            {
                MessageBox.Show("Исправьте подсвеченные поля профиля.");
                return;
            }

            var user = AppConnect.CurrentUser;
            user.FullName = txtFullName.Text.Trim();
            user.Email = txtEmail.Text.Trim();
            user.Phone = InputValidationHelper.NormalizePhone(txtPhone.Text);
            AppConnect.model01.SaveChanges();
            WarehouseService.Log("Изменение", "Users", user.UserID, "Пользователь обновил данные профиля");
            LoadProfile();
            SetEditMode(false);
        }

        private void btnCancelEdit_Click(object sender, RoutedEventArgs e)
        {
            LoadProfile();
            SetEditMode(false);
        }
    }
}
