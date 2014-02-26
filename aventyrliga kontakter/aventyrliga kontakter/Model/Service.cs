using aventyrliga_kontakter.Model.DAL;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using aventyrliga_kontakter.App_Infrastructure;

namespace aventyrliga_kontakter.Model
{
    public class Service
    {
        private ContactDAL _contactDAL;

        private ContactDAL ContactDAL
        {
            get { return _contactDAL ?? (_contactDAL = new ContactDAL()); }
        }

        public void DeleteContact(int contactId)
        {
            ContactDAL.DeleteContact(contactId);
        }

        public Contact GetContact(int contactId)
        {
            return ContactDAL.GetContactById(contactId);
        }

        public IEnumerable<Contact> GetContacts()
        {
            return ContactDAL.GetContacts();
        }

        public IEnumerable<Contact> GetContactsPageWise(int maximumRows, int startRowIndex, out int totalRowCount)
        {
            return ContactDAL.GetContactsPageWise(maximumRows, startRowIndex, out totalRowCount);
        }

        public void SaveContact(Contact contact)
        {
            ICollection<ValidationResult> validationResults;
            if (!contact.Validate(out validationResults))
            {
                var ex = new ValidationException("The object did not pass the validation.");
                ex.Data.Add("ValidationResult", validationResults);
                throw ex;
            }

            if (contact.ContactId == 0)
            {
                ContactDAL.InsertContact(contact);
            }
            else
            {
                ContactDAL.UpdateContact(contact);
            }
        }
    }
}