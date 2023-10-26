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
    /// Interaction logic for MovieToevoegenWindow.xaml
    /// </summary>
    public partial class MovieToevoegenWindow : Window
    {
        private readonly MovieControl _mainWindow;
        private IFilmRepository FilmRepository = new FilmRepository();

        public MovieToevoegenWindow(MovieControl mainwindow)
        {
            InitializeComponent();
            ResizeMode = ResizeMode.NoResize; //Zorgt ervoor dat je je scherm niet van grootte kan veranderen
            cmbGenres.ItemsSource = FilmRepository.OphalenGenres(); //Combobox opvullen met de juiste gegevens
            _mainWindow = mainwindow;
        }

        private void Toevoegen_Click(object sender, RoutedEventArgs e)
        {
            //De value van tekstvakken in variabele steken
            string titel = textTitel.Text;
            DateTime productieDatum = DateTime.Parse(textProductieDatum.Text);
            DateTime uitgaveDatum = DateTime.Parse(textUitgaveDatum.Text);
            Genre genre = cmbGenres.SelectedItem as Genre; //Casten
            string inhoud = textInhoud.Text;

            //Validaties of elk verplicht tekstvak ingevuld is
            if (string.IsNullOrEmpty(titel) || string.IsNullOrWhiteSpace(titel))
            {
                MessageBox.Show("Titel is een verplicht in te vullen veld!");
            }
            else if (cmbGenres.SelectedItem == null)
            {
                MessageBox.Show("Genre is een verplicht in te vullen veld!");
            }
            else if (string.IsNullOrEmpty(inhoud) || string.IsNullOrWhiteSpace(inhoud))
            {
                MessageBox.Show("Inhoud is een verplicht in te vullen veld!");
            }
            else
            {
                //Nieuw object van boek wordt aangemaakt en wordt toegevoegd aan de lijst in de mainwindow
                Film film = new Film(titel, productieDatum, uitgaveDatum, genre, inhoud);
                FilmRepository.ToevoegenFilm(film);
                Close();
                _mainWindow.LoadMovies();
            }
        }
    }
}