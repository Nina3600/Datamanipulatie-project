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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace wpf
{
    /// <summary>
    /// Interaction logic for MovieControl.xaml
    /// </summary>
    public partial class MovieControl : UserControl
    {
        private IFilmRepository FilmRepository = new FilmRepository();

        public MovieControl()
        {
            InitializeComponent();
            LoadData(); //Zorgt ervoor dat alle boeken meteen ingeladen worden zodra de appelicatie opstart
        }

        public void LoadMovies()
        {
            //Haalt alle films op + refreshed de lijst van de films
            IEnumerable<Film> films = FilmRepository.OphalenFilms();

            lbMovies.ItemsSource = films;
            lbMovies.Items.Refresh();
        }

        private void Bewerken_Click(object sender, RoutedEventArgs e)
        {
            //Als er geen film geselecteerd is wordt er een messagebox getoond anders opent de second window voor bewerken
            if (lbMovies.SelectedItem != null)
            {
                MovieBewerkenWindow secondWindow = new MovieBewerkenWindow(this, lbMovies.SelectedItem as Film);
                secondWindow.Show();
            }
            else
            {
                MessageBox.Show("Je moet eerst een film selecteren!");
            }
        }

        private void Details_Click(object sender, RoutedEventArgs e)
        {
            //Als er geen film geselecteerd is wordt er een messagebox getoond anders worden de details van
            //de geselecteerde film weergegeven
            if (!(lbMovies.SelectedItem is Film film))
            {
                MessageBox.Show("Gelieve een film te selecteren om de details van te bekijken.");
            }
            else
            {
                MessageBox.Show(film.ToonDetails());
            }
        }

        private void Filter_Click(object sender, RoutedEventArgs e)
        {
            //Roept de methode voor gefilterde films op waarbij je de ingegeven titel meegeeft
            string titel = textFilter.Text;

            lbMovies.ItemsSource = FilmRepository.OphalenGefilterdeFilms(titel);
        }

        private void LoadData()
        {
            //Haalt alle films op en zet ze in de lijst
            lbMovies.ItemsSource = FilmRepository.OphalenFilms();
        }

        private void Toevoegen_Click(object sender, RoutedEventArgs e)
        {
            //Opent de second window voor toevoegen
            MovieToevoegenWindow secondWindow = new MovieToevoegenWindow(this);
            secondWindow.Show();
        }

        private void Verwijderen_Click(object sender, RoutedEventArgs e)
        {
            //Als er geen film geselecteerd is wordt er een messagebox getoond om er 1 te selecteren, anders wordt de film
            //verwijdert en als dat gelukt is een messabox om te laten weten dat de film verwijdert is
            if (!(lbMovies.SelectedItem is Film film))
            {
                MessageBox.Show("Gelieve een film te selecteren om te verwijderen.");
            }
            else
            {
                if (FilmRepository.VerwijderenFilm(((Film)lbMovies.SelectedItem).Id))
                {
                    MessageBox.Show("Film werd verwijderd.");
                    LoadMovies();
                }
            }
        }
    }
}