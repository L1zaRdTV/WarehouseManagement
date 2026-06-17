using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media.Imaging;
using WarehouseManagement.ApplicationData;

namespace WarehouseManagement.Pages
{
    public partial class StockItemDetailsPage : Page
    {
        private Products product;

        public StockItemDetailsPage(Products p)
        {
            InitializeComponent();
            product = AppConnect.model01.Products.Include("Categories").Include("Suppliers").Include("Units").Include("StockBalances.StorageLocations").First(x => x.ProductID == p.ProductID);
            tbName.Text = product.ProductName;
            tbPrice.Text = "Цена: " + product.SalePrice + " ₽";
            tbCategory.Text = "Категория: " + product.Categories.CategoryName;
            tbBrand.Text = "Поставщик: " + product.Suppliers.SupplierName;
            tbStatus.Text = "Ед. изм.: " + product.Units.ShortName;
            tbQuantity.Text = "Остаток: " + product.QuantityInStock;
            tbDescription.Text = product.Description;
            SetMainImage(product.DisplayImagePath);
            icImages.ItemsSource = new List<string> { product.DisplayImagePath };
        }

        private void btnBack_Click(object s, RoutedEventArgs e) { AppFrame.frmMain.GoBack(); }
        private void btnAddToCart_Click(object s, RoutedEventArgs e) { AppFrame.frmMain.Navigate(new ShipmentsPage()); }

        private void btnThumbnail_Click(object s, RoutedEventArgs e)
        {
            if (((Button)s).Tag is string imagePath) SetMainImage(imagePath);
        }

        private void SetMainImage(string imagePath)
        {
            imgMain.Source = new BitmapImage(new System.Uri(imagePath, System.UriKind.RelativeOrAbsolute));
        }
    }
}
