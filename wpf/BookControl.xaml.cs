using System;
using System.Collections.Generic;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using models;
using dal;
using System.Globalization;
using static System.Reflection.Metadata.BlobBuilder;

namespace wpf
{
    /// <summary>
    /// Interaction logic for BookControl.xaml
    /// </summary>
    public partial class BookControl : UserControl
    {
        private IBoekRepository BoekRepository = new BoekRepository();

        public BookControl()
        {
            InitializeComponent();
            LoadData(); //Zorgt ervoor dat alle boeken meteen ingeladen worden zodra de appelicatie opstart
        }

        public void LoadBooks()
        {
            //Haalt alle boeken op + refreshed de lijst van de boeken
            IEnumerable<Boek> boeken = BoekRepository.OphalenBoeken();

            lbBooks.ItemsSource = boeken;
            lbBooks.Items.Refresh();
        }

        private void Bewerken_Click(object sender, RoutedEventArgs e)
        {
            //Als er geen boek geselecteerd is wordt er een messagebox getoond anders opent de second window voor bewerken
            if (lbBooks.SelectedItem != null)
            {
                BoekBewerkenWindow secondWindow = new BoekBewerkenWindow(this, lbBooks.SelectedItem as Boek);
                secondWindow.Show();
            }
            else
            {
                MessageBox.Show("Je moet eerst een boek selecteren!");
            }
        }

        private void Details_Click(object sender, RoutedEventArgs e)
        {
            //Als er geen boek geselecteerd is wordt er een messagebox getoond anders worden de details van
            //het geselecteerde boek weergegeven
            if (!(lbBooks.SelectedItem is Boek boek))
            {
                MessageBox.Show("Gelieve een boek te selecteren om de details van te bekijken.");
            }
            else
            {
                MessageBox.Show(boek.ToonDetails());
            }
        }

        private void Filter_Click(object sender, RoutedEventArgs e)
        {
            //Roept de methode voor gefilterde boeken op waarbij je de ingegeven titel meegeeft
            string titel = textFilter.Text;

            lbBooks.ItemsSource = BoekRepository.OphalenGefilterdeBoeken(titel);
        }

        private void LoadData()
        {
            //Haalt alle boeken op en zet ze in de lijst
            lbBooks.ItemsSource = BoekRepository.OphalenBoeken();
        }

        private void Toevoegen_Click(object sender, RoutedEventArgs e)
        {
            //Opent de second window voor toevoegen
            BookToevoegenWindow secondWindow = new BookToevoegenWindow(this);
            secondWindow.Show();
        }

        private void Verwijderen_Click(object sender, RoutedEventArgs e)
        {
            //Als er geen boek geselecteerd is wordt er een messagebox getoond om er 1 te selecteren, anders wordt het boek
            //verwijdert en als dat gelukt is een messabox om te laten weten dat het boek verwijdert is
            if (!(lbBooks.SelectedItem is Boek boek))
            {
                MessageBox.Show("Gelieve een boek te selecteren om te verwijderen.");
            }
            else
            {
                if (BoekRepository.VerwijderenBoek(((Boek)lbBooks.SelectedItem).Id))
                {
                    MessageBox.Show("Boek werd verwijderd.");
                    LoadBooks();
                }
            }
        }
    }
}