using System;
using System.Data.Entity;
using System.Globalization;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using WarehouseManagement.ApplicationData;

namespace WarehouseManagement.Pages
{
    public partial class ShipmentsPage : Page
    {
        public ShipmentsPage()
        {
            InitializeComponent();
            LoadLookups();
            LoadShipments();
        }

        private void LoadLookups()
        {
            cmbClient.ItemsSource = AppConnect.model01.Clients.OrderBy(x => x.ClientName).ToList();
            cmbProduct.ItemsSource = AppConnect.model01.Products.Where(x => x.IsActive).OrderBy(x => x.ProductName).ToList();
            if (cmbClient.Items.Count > 0) cmbClient.SelectedIndex = 0;
            if (cmbProduct.Items.Count > 0) cmbProduct.SelectedIndex = 0;
        }

        private void LoadLocations()
        {
            var product = cmbProduct.SelectedItem as Products;
            if (product == null)
            {
                cmbLocation.ItemsSource = null;
                return;
            }

            var balancesByLocation = AppConnect.model01.StockBalances
                .Where(x => x.ProductID == product.ProductID)
                .ToList()
                .GroupBy(x => x.LocationID)
                .ToDictionary(x => x.Key, x => x.Sum(b => b.Quantity));

            var locations = AppConnect.model01.StorageLocations
                .Include(x => x.StorageZones.Warehouses)
                .OrderBy(x => x.StorageZones.Warehouses.WarehouseName)
                .ThenBy(x => x.StorageZones.ZoneName)
                .ThenBy(x => x.LocationCode)
                .ToList()
                .Select(x =>
                {
                    var quantity = balancesByLocation.ContainsKey(x.LocationID) ? balancesByLocation[x.LocationID] : 0;
                    return new LocationChoice
                    {
                        Location = x,
                        Quantity = quantity,
                        DisplayName = BuildLocationDisplayName(x, quantity)
                    };
                })
                .ToList();

            cmbLocation.ItemsSource = locations;
            if (locations.Count > 0) cmbLocation.SelectedIndex = 0;
            txtPrice.Text = product.SalePrice.ToString(CultureInfo.CurrentCulture);
        }

        private static string BuildLocationDisplayName(StorageLocations location, int quantity)
        {
            var warehouseName = location.StorageZones == null || location.StorageZones.Warehouses == null
                ? "Склад не указан"
                : location.StorageZones.Warehouses.WarehouseName;
            var zoneName = location.StorageZones == null
                ? "зона не указана"
                : location.StorageZones.ZoneName;

            return warehouseName + " / " + zoneName + " / " + location.LocationCode + " — остаток " + quantity;
        }

        private void LoadShipments()
        {
            lvShipments.ItemsSource = AppConnect.model01.Shipments
                .Include(x => x.Clients)
                .Include(x => x.ShipmentItems)
                .OrderByDescending(x => x.ShipmentDate)
                .ToList()
                .Select(x => new ShipmentRow
                {
                    ShipmentID = x.ShipmentID,
                    ShipmentNumber = x.ShipmentNumber,
                    ClientName = x.Clients == null ? "Клиент не указан" : x.Clients.ClientName,
                    DateText = x.ShipmentDate.ToString("dd.MM.yyyy HH:mm"),
                    ItemsCount = x.ShipmentItems.Count,
                    TotalText = x.ShipmentItems.Sum(i => i.Quantity * i.UnitPrice).ToString("0.## ₽"),
                    Comment = x.Comment
                })
                .ToList();
        }

        private void LoadShipmentItems(int shipmentId)
        {
            lvShipmentItems.ItemsSource = AppConnect.model01.ShipmentItems
                .Include(x => x.Products)
                .Include(x => x.StorageLocations)
                .Where(x => x.ShipmentID == shipmentId)
                .ToList()
                .Select(x => new
                {
                    ProductName = x.Products.ProductName,
                    LocationCode = x.StorageLocations.LocationCode,
                    x.Quantity,
                    PriceText = x.UnitPrice.ToString("0.## ₽"),
                    TotalText = (x.Quantity * x.UnitPrice).ToString("0.## ₽")
                })
                .ToList();
        }

        private Employees GetCurrentEmployee()
        {
            if (AppConnect.CurrentUser.EmployeeID.HasValue)
            {
                var employee = AppConnect.model01.Employees.Find(AppConnect.CurrentUser.EmployeeID.Value);
                if (employee != null) return employee;
            }
            return AppConnect.model01.Employees.FirstOrDefault(x => x.IsActive) ?? AppConnect.model01.Employees.FirstOrDefault();
        }

        private void btnBack_Click(object sender, RoutedEventArgs e)
        {
            AppFrame.frmMain.GoBack();
        }

        private void btnRefresh_Click(object sender, RoutedEventArgs e)
        {
            LoadLookups();
            LoadShipments();
            lvShipmentItems.ItemsSource = null;
            tbStatus.Text = "Списки обновлены.";
        }

        private void cmbProduct_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            LoadLocations();
            if (IsLoaded) { int quantity; decimal price; ValidateForm(out quantity, out price); }
        }

        private bool ValidateForm(out int quantity, out decimal price)
        {
            var ok = true;
            string error;
            quantity = 0;
            price = 0;
            ok &= InputValidationHelper.ValidateCombo(cmbClient, errClient, "Клиент");
            ok &= InputValidationHelper.ValidateCombo(cmbProduct, errProduct, "Товар");
            ok &= InputValidationHelper.ValidateCombo(cmbLocation, errLocation, "Место хранения");
            ok &= InputValidationHelper.TryParseQuantity(txtQuantity.Text, out quantity, out error); InputValidationHelper.Mark(txtQuantity, errQuantity, error);
            ok &= InputValidationHelper.TryParsePrice(txtPrice.Text, out price, out error); InputValidationHelper.Mark(txtPrice, errPrice, error);
            error = txtComment.Text.Length > 300 ? "Комментарий слишком длинный: максимум 300 символов." : null; InputValidationHelper.Mark(txtComment, errComment, error); ok &= error == null;
            return ok;
        }

        private void ValidateShipmentField(object sender, TextChangedEventArgs e) { if (!IsLoaded) return; int quantity; decimal price; ValidateForm(out quantity, out price); }
        private void ValidateShipmentSelection(object sender, SelectionChangedEventArgs e) { if (!IsLoaded) return; int quantity; decimal price; ValidateForm(out quantity, out price); }

        private void btnCreateShipment_Click(object sender, RoutedEventArgs e)
        {
            var client = cmbClient.SelectedItem as Clients;
            var product = cmbProduct.SelectedItem as Products;
            var choice = cmbLocation.SelectedItem as LocationChoice;
            var employee = GetCurrentEmployee();
            int quantity;
            decimal price;

            if (!ValidateForm(out quantity, out price) || employee == null)
            {
                tbStatus.Text = "Исправьте подсвеченные поля новой отгрузки.";
                return;
            }

            var shipment = new Shipments
            {
                ShipmentNumber = "SHP-" + DateTime.Now.ToString("yyyyMMddHHmmss"),
                ClientID = client.ClientID,
                EmployeeID = employee.EmployeeID,
                ShipmentDate = DateTime.Now,
                Comment = txtComment.Text.Trim()
            };

            AppConnect.model01.Shipments.Add(shipment);
            if (!WarehouseService.TryAddShipmentItem(shipment, product, choice.Location, quantity, price, out var error))
            {
                AppConnect.model01.Shipments.Remove(shipment);
                tbStatus.Text = error;
                return;
            }

            AppConnect.model01.SaveChanges();
            WarehouseService.Log("Создание", "Shipments", shipment.ShipmentID, "Создана отгрузка " + shipment.ShipmentNumber);
            tbStatus.Text = "Отгрузка " + shipment.ShipmentNumber + " создана, остаток товара уменьшен.";
            txtQuantity.Text = "1";
            txtComment.Clear();
            LoadLocations();
            LoadShipments();
        }

        private void lvShipments_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var row = lvShipments.SelectedItem as ShipmentRow;
            if (row == null) return;
            tbDetailsTitle.Text = "Состав отгрузки " + row.ShipmentNumber;
            LoadShipmentItems(row.ShipmentID);
        }

        private class LocationChoice
        {
            public StorageLocations Location { get; set; }
            public int Quantity { get; set; }
            public string DisplayName { get; set; }
        }

        private class ShipmentRow
        {
            public int ShipmentID { get; set; }
            public string ShipmentNumber { get; set; }
            public string ClientName { get; set; }
            public string DateText { get; set; }
            public int ItemsCount { get; set; }
            public string TotalText { get; set; }
            public string Comment { get; set; }
        }
    }
}
