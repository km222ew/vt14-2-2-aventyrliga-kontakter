using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace aventyrliga_kontakter.Model
{
    public class Contact
    {

        public int ContactId { get; set; }

        [Required(ErrorMessage = "You have to provide an email address."), EmailAddress(ErrorMessage = "You have to provide a valid email address.")]
        public string EmailAddress { get; set; }

        [Required(ErrorMessage = "You have to provide a first name."), StringLength(50, ErrorMessage = "First name can not be longer than 50 characters.")]
        public string FirstName { get; set; }

        [Required(ErrorMessage = "You have to provide a last name."), StringLength(50, ErrorMessage = "Last name can not be longer than 50 characters.")]
        public string LastName { get; set; }
    }
}