using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace wpf
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            ResizeMode = ResizeMode.NoResize; //Zorgt ervoor dat je je scherm niet van grootte kan veranderen
        }

        private void TabControl_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            //Controleren welke tab geselecteerd is en die in een variabele steken
            string geselecteerdTabblad = (tabControl.SelectedItem as TabItem).Name;
            switch (geselecteerdTabblad)
            {
                //Controleren welke tab geselecteerd is en aan de hand daarvan de juiste control laten zien
                case "tabBooks":
                    ContentWindow.Content = new BookControl();
                    break;

                default:
                    ContentWindow.Content = new MovieControl();
                    break;
            }
        }
    }
}