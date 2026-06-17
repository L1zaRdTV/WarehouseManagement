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

        private void btnSave_Click(object s, RoutedEventArgs e)
        {
            decimal price;
            int min;
            if (!decimal.TryParse(txtPrice.Text, out price) || !int.TryParse(txtQuantity.Text, out min) || cmbCategory.SelectedItem == null || cmbBrand.SelectedItem == null || cmbStatus.SelectedItem == null || string.IsNullOrWhiteSpace(txtName.Text))
            {
                MessageBox.Show("Проверьте корректность полей");
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
