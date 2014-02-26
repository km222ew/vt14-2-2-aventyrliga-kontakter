using aventyrliga_kontakter.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

//http://support.microsoft.com/kb/2890857

namespace aventyrliga_kontakter
{
    public partial class Default : System.Web.UI.Page
    {
        private Service _service;

        private Service Service
        {
            get { return _service ?? (_service = new Service()); }
        }

        private string MessageStatus
        {
            get { return Session["MessageStatus"] as string; }
            set { Session["MessageStatus"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (MessageStatus != null)
            {
                successPanel.Visible = true;
                successLabel.Text = MessageStatus;
                Session.Clear();
            }
        }

        public IEnumerable<Contact> ListView_GetDataPageWise(int maximumRows, int startRowIndex, out int totalRowCount)
        {
            return Service.GetContactsPageWise(maximumRows, startRowIndex, out totalRowCount);
        }

        public void ListView_InsertItem(Contact contact)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    Service.SaveContact(contact);
                    Session["success"] = true;
                    MessageStatus = "The contact was added successfully.";
                    Response.Redirect("/Default.aspx");
                }
                catch (Exception)
                {
                    ModelState.AddModelError(String.Empty, "An error occured when trying to create a new contact.");
                }
            }
        }

        public void ListView_UpdateItem(int contactId)
        {
            try
            {
                var contact = Service.GetContact(contactId);
                if (contact == null)
                {
                    ModelState.AddModelError(String.Empty, String.Format("The contact could not be found"));
                    return;
                }
                
                if (TryUpdateModel(contact))
                {
                    Service.SaveContact(contact);
                    MessageStatus = "The contact was updated successfully.";
                    Response.Redirect("/Default.aspx");
                }
            }
            catch (Exception)
            {
                ModelState.AddModelError(String.Empty, "An error occured when trying to update a contact.");
            }
        }

        public void ListView_DeleteItem(int contactId)
        {
            try
            {
                Service.DeleteContact(contactId);
                MessageStatus = "The contact was deleted successfully.";
                Response.Redirect("/Default.aspx");
            }
            catch (Exception)
            {
                ModelState.AddModelError(String.Empty, "An error occured when trying to delete a contact.");
            }
        }

        protected void closeMessage_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("/Default.aspx");
        }
    }
}