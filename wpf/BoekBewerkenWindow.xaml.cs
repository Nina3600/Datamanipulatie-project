using dal;
using models;
using System;
using System.Collections.Generic;
using System.Reflection.Metadata;
using System.Security.Policy;
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
    /// Interaction logic for BoekBewerkenWindow.xaml
    /// </summary>
    public partial class BoekBewerkenWindow : Window
    {
        private readonly BookControl _mainWindow;
        private Boek _wijzigBoek;
        private IBoekRepository BoekRepository = new BoekRepository();

        public BoekBewerkenWindow(BookControl mainWindow, Boek boek)
        {
            InitializeComponent();
            ResizeMode = ResizeMode.NoResize; //Zorgt ervoor dat je je scherm niet van grootte kan veranderen
            _mainWindow = mainWindow;
            _wijzigBoek = boek;
            GetData(); //Haalt de juiste data op
            SetData(); //Zorgt ervoor dat de juiste data ingevuld is
        }

        private void Bewerken_Click(object sender, RoutedEventArgs e)
        {
            //Validaties of elk verplicht tekstvak ingevuld is
            if (string.IsNullOrEmpty(textTitel.Text) || string.IsNullOrWhiteSpace(textTitel.Text))
            {
                MessageBox.Show("Titel is een verplicht in te vullen veld!");
            }
            else if (string.IsNullOrEmpty(textISBNnummer.Text) || string.IsNullOrWhiteSpace(textISBNnummer.Text))
            {
                MessageBox.Show("ISBN-Nummer is een verplicht in te vullen veld!");
            }
            else if (string.IsNullOrEmpty(textBeschrijving.Text) || string.IsNullOrWhiteSpace(textBeschrijving.Text))
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
                //De nieuwe waardes koppelen aan het geselecteerde boek
                _wijzigBoek.Titel = textTitel.Text;
                _wijzigBoek.ibnNummer = textISBNnummer.Text;
                _wijzigBoek.Beschrijving = textBeschrijving.Text;
                _wijzigBoek.Auteur = cmbAuteurs.SelectedItem as Auteur; //Casten
                _wijzigBoek.Illustrator = cmbIllustrators.SelectedItem as Illustrator; //Casten

                BoekRepository.BewerkenBoek(_wijzigBoek);
                Close();
                _mainWindow.LoadBooks();
            }
        }

        private void GetData()
        {
            cmbAuteurs.ItemsSource = BoekRepository.OphalenAuteurs();
            cmbAuteurs.SelectedValuePath = "Id";
            cmbIllustrators.ItemsSource = BoekRepository.OphalenIllustrators();
            cmbIllustrators.SelectedValuePath = "Id";
        }

        private void SetData()
        {
            textTitel.Text = _wijzigBoek.Titel;
            textISBNnummer.Text = _wijzigBoek.ibnNummer;
            textBeschrijving.Text = _wijzigBoek.Beschrijving;
            cmbAuteurs.SelectedValue = _wijzigBoek.Auteur.Id;
            cmbIllustrators.SelectedValue = _wijzigBoek.Illustrator.Id;
        }
    }
}