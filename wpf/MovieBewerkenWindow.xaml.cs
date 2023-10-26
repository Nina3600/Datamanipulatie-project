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
    /// Interaction logic for MovieBewerkenWindow.xaml
    /// </summary>
    public partial class MovieBewerkenWindow : Window
    {
        private readonly MovieControl _mainWindow;
        private Film _wijzigFilm;
        private IFilmRepository FilmRepository = new FilmRepository();

        public MovieBewerkenWindow(MovieControl mainwindow, Film film)
        {
            InitializeComponent();
            ResizeMode = ResizeMode.NoResize; //Zorgt ervoor dat je je scherm niet van grootte kan veranderen
            _mainWindow = mainwindow;
            _wijzigFilm = film;
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
            else if (cmbGenres.SelectedItem == null)
            {
                MessageBox.Show("Genre is een verplicht in te vullen veld!");
            }
            else if (string.IsNullOrEmpty(textInhoud.Text) || string.IsNullOrWhiteSpace(textInhoud.Text))
            {
                MessageBox.Show("Inhoud is een verplicht in te vullen veld!");
            }
            else
            {
                //De nieuwe waardes koppelen aan de geselecteerde film
                DateTime productieDatum;
                DateTime uitgaveDatum;
                _wijzigFilm.Titel = textTitel.Text;

                if (DateTime.TryParse(textProductieDatum.Text, out productieDatum))
                {
                    _wijzigFilm.ProductieDatum = productieDatum;
                }
                else
                {
                    MessageBox.Show("Productiedatum is niet correcht ingevuld!");
                }

                if (DateTime.TryParse(textUitgaveDatum.Text, out uitgaveDatum))
                {
                    _wijzigFilm.UitgaveDatum = uitgaveDatum;
                }
                else
                {
                    MessageBox.Show("Uitgavedatum is niet correcht ingevuld!");
                }

                _wijzigFilm.Genre = cmbGenres.SelectedItem as Genre; //Casten
                _wijzigFilm.Inhoud = textInhoud.Text;

                FilmRepository.BewerkenFilm(_wijzigFilm);
                Close();
                _mainWindow.LoadMovies();
            }
        }

        private void GetData()
        {
            cmbGenres.ItemsSource = FilmRepository.OphalenGenres();
            cmbGenres.SelectedValuePath = "Id";
        }

        private void SetData()
        {
            textTitel.Text = _wijzigFilm.Titel;
            textProductieDatum.Text = _wijzigFilm.ProductieDatum.ToString();
            textUitgaveDatum.Text = _wijzigFilm.UitgaveDatum.ToString();
            cmbGenres.SelectedValue = _wijzigFilm.Genre.Id;
            textInhoud.Text = _wijzigFilm.Inhoud;
        }
    }
}