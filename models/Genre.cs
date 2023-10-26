using System;
using System.Collections.Generic;
using System.Text;

namespace models
{
    public class Genre
    {
        public int Id { get; set; }
        public string Naam { get; set; }

        public override string ToString()
        {
            return $"{Naam}";
        }
    }
}