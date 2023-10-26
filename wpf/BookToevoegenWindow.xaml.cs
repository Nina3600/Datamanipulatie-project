using dal;
using models;
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
using System.Windows.Shapes;

namespace wpf
{
    /// <summary>
    /// Interaction logic for BookToevoegenWindow.xaml
    /// </summary>
    public partial class BookToevoegenWindow : Window
    {
        private readonly BookControl _mainWindow;
        private IBoekRepository BoekRepository = new BoekRepository();

        public BookToevoegenWindow(BookControl mainWindow)
        {
            InitializeComponent();
            ResizeMode = ResizeMode.NoResize; //Zorgt ervoor dat je je scherm niet van grootte kan veranderen
            cmbAuteurs.ItemsSource = BoekRepository.OphalenAuteurs(); //Combobox opvullen met de juiste gegevens
            cmbIllustrators.ItemsSource = BoekRepository.OphalenIllustrators(); //Combobox opvullen met de juiste gegevens
            _mainWindow = mainWindow;
        }

        private void Toevoegen_Click(object sender, RoutedEventArgs e)
        {
            //De value van tekstvakken in variabele steken
            string titel = textTitel.Text;
            string isbnNummer = textISBNnummer.Text;
            string beschrijving = textBeschrijving.Text;
            Auteur auteur = cmbAuteurs.SelectedItem as Auteur; //Casten
            Illustrator illustrator = cmbIllustrators.SelectedItem as Illustrator; //Casten

            //Validaties of elk verplicht tekstvak ingevuld is
            if (string.IsNullOrEmpty(titel) || string.IsNullOrWhiteSpace(titel))
            {
                MessageBox.Show("Titel is een verplicht in te vullen veld!");
            }
            else if (string.IsNullOrEmpty(isbnNummer) || string.IsNullOrWhiteSpace(isbnNummer))
            {
                MessageBox.Show("ISBN-Nummer is een verplicht in te vullen veld!");
            }
            else if (string.IsNullOrEmpty(beschrijving) || string.IsNullOrWhiteSpace(beschrijving))
            {
                MessageBox.Show("Beschrijving is een verplicht in te vullen veld!");
            }
            else if (cmbAuteurs.SelectedItem == null)
            {
                MessageBox.Show("Auteur is een verplicht in te vullen veld!");
            }
            else if (cmbIllustrators.SelectedItem == null)
            {
                MessageBox.Show("Illustrator is een verplicht in te vullen veld!");
            }
            else
            {
                //Nieuw object van boek wordt aangemaakt en wordt toegevoegd aan de lijst in de mainwindow
                Boek boek = new Boek(titel, isbnNummer, beschrijving, auteur, illustrator);
                BoekRepository.ToevoegenBoek(boek);
                Close();
                _mainWindow.LoadBooks();
            }
        }
    }
}