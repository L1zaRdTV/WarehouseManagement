using Microsoft.Win32;
using System;
using System.IO;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media.Imaging;
using WarehouseManagement.ApplicationData;

namespace WarehouseManagement.Pages
{
    public partial class ProductCardPage : Page
    {
        private const string PlaceholderImagePath = "https://placehold.co/320x220/png?text=No+Photo";
        private Products product;

        public ProductCardPage(Products p)
        {
            InitializeComponent();
            product = p;
            cmbCategory.ItemsSource = AppConnect.model01.Categories.ToList();
            cmbCategory.DisplayMemberPath = "CategoryName";
            cmbBrand.ItemsSource = AppConnect.model01.Suppliers.ToList();
            cmbBrand.DisplayMemberPath = "SupplierName";
            cmbStatus.ItemsSource = AppConnect.model01.Units.ToList();
            cmbStatus.DisplayMemberPath = "ShortName";

            if (p != null)
            {
                tbTitle.Text = "Редактирование товара";
                txtName.Text = p.ProductName;
                txtDescription.Text = p.Description;
                txtPrice.Text = p.SalePrice.ToString();
                txtQuantity.Text = p.MinStock.ToString();
                txtImagePath.Text = p.ImagePath;
                cmbCategory.SelectedItem = cmbCategory.Items.Cast<Categories>().FirstOrDefault(x => x.CategoryID == p.CategoryID);
                cmbBrand.SelectedItem = cmbBrand.Items.Cast<Suppliers>().FirstOrDefault(x => x.SupplierID == p.SupplierID);
                cmbStatus.SelectedItem = cmbStatus.Items.Cast<Units>().FirstOrDefault(x => x.UnitID == p.UnitID);
            }

            RefreshPreview();
        }

        private void btnBack_Click(object s, RoutedEventArgs e) { AppFrame.frmMain.GoBack(); }

        private bool ValidateForm(out decimal price, out int min)
        {
            var ok = true;
            string error;
            price = 0;
            min = 0;
            error = InputValidationHelper.Required(txtName.Text, "Название товара"); InputValidationHelper.Mark(txtName, errName, error); ok &= error == null;
            error = txtDescription.Text.Trim().Length > 200 ? "Описание слишком длинное: максимум 200 символов." : null; InputValidationHelper.Mark(txtDescription, errDescription, error); ok &= error == null;
            ok &= InputValidationHelper.TryParsePrice(txtPrice.Text, out price, out error); InputValidationHelper.Mark(txtPrice, errPrice, error);
            ok &= InputValidationHelper.TryParseQuantity(txtQuantity.Text, out min, out error); InputValidationHelper.Mark(txtQuantity, errQuantity, error);
            ok &= InputValidationHelper.ValidateCombo(cmbCategory, errCategory, "Категория");
            ok &= InputValidationHelper.ValidateCombo(cmbBrand, errBrand, "Поставщик");
            ok &= InputValidationHelper.ValidateCombo(cmbStatus, errStatus, "Единица измерения");
            return ok;
        }

        private void ValidateProductField(object sender, TextChangedEventArgs e) { if (!IsLoaded) return; decimal price; int min; ValidateForm(out price, out min); }
        private void ValidateProductSelection(object sender, SelectionChangedEventArgs e) { if (!IsLoaded) return; decimal price; int min; ValidateForm(out price, out min); }

        private void btnSave_Click(object s, RoutedEventArgs e)
        {
            decimal price;
            int min;
            if (!ValidateForm(out price, out min))
            {
                MessageBox.Show("Исправьте подсвеченные поля товара.");
                return;
            }

            if (product == null)
            {
                product = new Products { Sku = "SKU-" + DateTime.Now.Ticks.ToString().Substring(10), IsActive = true, PurchasePrice = price, StockBalances = null };
                AppConnect.model01.Products.Add(product);
            }

            product.ProductName = txtName.Text.Trim();
            product.Description = txtDescription.Text.Trim();
            product.SalePrice = price;
            product.MinStock = min;
            product.ImagePath = txtImagePath.Text.Trim();
            product.CategoryID = ((Categories)cmbCategory.SelectedItem).CategoryID;
            product.SupplierID = ((Suppliers)cmbBrand.SelectedItem).SupplierID;
            product.UnitID = ((Units)cmbStatus.SelectedItem).UnitID;
            AppConnect.model01.SaveChanges();
            WarehouseService.Log("Изменение", "Products", product.ProductID, product.ProductName);
            MessageBox.Show("Товар сохранён");
            AppFrame.frmMain.GoBack();
        }

        private void btnChooseImage_Click(object sender, RoutedEventArgs e)
        {
            var dialog = new OpenFileDialog
            {
                Title = "Выберите фотографию товара",
                Filter = "Изображения (*.jpg;*.jpeg;*.png;*.bmp)|*.jpg;*.jpeg;*.png;*.bmp|Все файлы (*.*)|*.*"
            };

            if (dialog.ShowDialog() != true) return;

            Directory.CreateDirectory("ProductImages");
            var extension = Path.GetExtension(dialog.FileName);
            var fileName = "product-" + DateTime.Now.Ticks + extension;
            var targetPath = Path.Combine("ProductImages", fileName);
            File.Copy(dialog.FileName, targetPath, true);
            txtImagePath.Text = targetPath;
        }

        private void btnClearImage_Click(object sender, RoutedEventArgs e) { txtImagePath.Text = string.Empty; }
        private void txtImagePath_TextChanged(object sender, TextChangedEventArgs e) { RefreshPreview(); }

        private void RefreshPreview()
        {
            var source = string.IsNullOrWhiteSpace(txtImagePath.Text) ? PlaceholderImagePath : txtImagePath.Text.Trim();
            try
            {
                imgProduct.Source = new BitmapImage(new Uri(source, UriKind.RelativeOrAbsolute));
            }
            catch
            {
                imgProduct.Source = new BitmapImage(new Uri(PlaceholderImagePath, UriKind.Relative));
            }
        }

        private void btnAddCategory_Click(object s, RoutedEventArgs e) { MessageBox.Show("Категории добавляются SQL-скриптом или администратором БД"); }
        private void btnAddBrand_Click(object s, RoutedEventArgs e) { MessageBox.Show("Поставщики ведутся в разделе поставщиков"); }
    }
}
