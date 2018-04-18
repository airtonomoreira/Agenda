
using System;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class _Default : System.Web.UI.Page
{

    protected void Button1_Click(object sender, EventArgs e)
    {
        
        string FilterExpression = string.Concat(DropDownList1.SelectedValue, " LIKE '%{0}%'");
        SqlDataSource1.FilterParameters.Clear();
        SqlDataSource1.FilterParameters.Add(new ControlParameter(DropDownList1.SelectedValue, "TextBox1", "Text"));
        SqlDataSource1.FilterExpression = FilterExpression;

    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        TextBox1.Text = "";
        SqlDataSource1.SelectParameters.Clear();
    }
    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
        Label1.Visible = false;
        Label2.Visible = false;
        if (nome.Text.Trim() == "")
        {
            Label1.Visible = true;
            return;
        }

        if (TelefoneResidencial.Text.Trim() == "")
        {
            Label2.Visible = true;
            return;
        }

                Executar(Convert.ToString(nome.Text), Convert.ToString(Endereco.Text), Convert.ToString(TelefoneResidencial.Text).Substring(1,2), Convert.ToString(TelefoneResidencial.Text).Replace("-", "").Substring(5,9), Convert.ToString(Celular.Text).Substring(1, 2), Convert.ToString(Celular.Text).Replace("-", "").Substring(5, 9), Convert.ToString(TelefoneOutros.Text).Substring(1, 2), Convert.ToString(TelefoneOutros.Text).Replace("-", "").Substring(5, 9), Convert.ToString(EmailPessoal.Text), Convert.ToString(EmailComl.Text), Convert.ToString(EmailOutros.Text), Convert.ToString(Nascimento.Text), Convert.ToString(ID.Text), BtnSubmit.Text);
        if (BtnSubmit.Text == "Alterar")
        {
            BtnExcluir.Visible = false;
            BtnSubmit.Text = "Inserir";
        }
        Response.Redirect("~/Default.aspx");
    }

    private void Executar(string Id)
    {
        try
        {
            string connectionString = "Data Source=LAPTOP-HPTOUPH7;Initial Catalog=master;Integrated Security=True";
            SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();

            SqlCommand cmd = new SqlCommand
            {
                Connection = conn,
                CommandText = "DELETE Pessoas WHERE Id = @ID"
        };

           cmd.Parameters.Add("@ID", SqlDbType.VarChar).Value = Id;

            cmd.ExecuteNonQuery();
            conn.Close();
        }
        catch (System.Data.SqlClient.SqlException ex_msg)
        {
            string msg = "Ocorreu um erro durante a inclusão dos dados.";
            msg += ex_msg.Message;
            throw new Exception(msg);
        }
    }

    private void Executar(string nome, string Endereco, string DDDResidencial, string TelefoneResidencial, string DDDCelular, string Celular, string DDDOutros, string TelefoneOutros, string EmailPessoal, string EmailComl, string EmailOutros, string Nascimento, string Id, string Acao)
    {
        try
        {
            string connectionString = "Data Source=LAPTOP-HPTOUPH7;Initial Catalog=master;Integrated Security=True";
            SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();
            string Incluir = "INSERT INTO Pessoas (Nome, Endereco, DDDResidencial,TelefoneResidencial, DDDCelular, Celular, DDDOutros, TelefoneOutros, EmailPessoal, EmailComl, EmailOutros, Nascimento) VALUES (@Nome, @Endereco,@DDDResidencial,@TelefoneResidencial,@DDDCelular,@Celular,@DDDOutros,@TelefoneOutros,@EmailPessoal, @EmailComl,@EmailOutros,@Nascimento)";
            string Alterar = "UPDATE Pessoas set Nome =@Nome, Endereco=@Endereco, DDDResidencial=@DDDResidencial,TelefoneResidencial=@TelefoneResidencial,DDDCelular=@DDDCelular,Celular=@Celular,DDDOutros=@DDDOutros,TelefoneOutros=@TelefoneOutros,  EmailPessoal=@EmailPessoal,EmailComl=@EmailComl, EmailOutros=@EmailOutros,Nascimento=@Nascimento WHERE Id = @ID";

            SqlCommand cmd = new SqlCommand
            {
                Connection = conn,
                CommandText = (Acao == "Inserir") ? Incluir: Alterar
            };

            cmd.Parameters.Add("@Nome", SqlDbType.VarChar).Value = nome;
            cmd.Parameters.Add("@Endereco", SqlDbType.VarChar).Value = Endereco;
            cmd.Parameters.Add("@DDDResidencial", SqlDbType.VarChar).Value = DDDResidencial;
            cmd.Parameters.Add("@TelefoneResidencial", SqlDbType.VarChar).Value = TelefoneResidencial;
            cmd.Parameters.Add("@DDDCelular", SqlDbType.VarChar).Value = DDDCelular;
            cmd.Parameters.Add("@Celular", SqlDbType.VarChar).Value = Celular;
            cmd.Parameters.Add("@DDDoutros", SqlDbType.VarChar).Value = DDDOutros;
            cmd.Parameters.Add("@TelefoneOutros", SqlDbType.VarChar).Value = TelefoneOutros;
            cmd.Parameters.Add("@EmailPessoal", SqlDbType.VarChar).Value = EmailPessoal;
            cmd.Parameters.Add("@EmailComl", SqlDbType.VarChar).Value = EmailComl;
            cmd.Parameters.Add("@EmailOutros", SqlDbType.VarChar).Value = EmailOutros;
            cmd.Parameters.Add("@Nascimento", SqlDbType.VarChar).Value = Nascimento;
            if (Acao == "Alterar")
                cmd.Parameters.Add("@ID", SqlDbType.VarChar).Value = Id;

            cmd.ExecuteNonQuery();
            conn.Close();
        }
        catch (System.Data.SqlClient.SqlException ex_msg)
        {
            string msg = "Ocorreu um erro durante a inclusão dos dados.";
            msg += ex_msg.Message;
            throw new Exception(msg);
        }
    }


    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        BtnSubmit.Text = "Alterar";
        BtnExcluir.Visible = true;
        ID.Text = GridView1.SelectedRow.Cells[0].Text;
        nome.Text = GridView1.SelectedRow.Cells[1].Text;
        Endereco.Text = GridView1.SelectedRow.Cells[2].Text;
        TelefoneResidencial.Text = "("+ GridView1.SelectedRow.Cells[3].Text + ") " + GridView1.SelectedRow.Cells[4].Text;
        Celular.Text = "(" + GridView1.SelectedRow.Cells[5].Text + ") " + GridView1.SelectedRow.Cells[6].Text;
        TelefoneOutros.Text = "(" + GridView1.SelectedRow.Cells[7].Text + ") " + GridView1.SelectedRow.Cells[8].Text;
        EmailPessoal.Text =GridView1.SelectedRow.Cells[9].Text;
        EmailComl.Text = GridView1.SelectedRow.Cells[10].Text;
        EmailOutros.Text = GridView1.SelectedRow.Cells[11].Text;
        Nascimento.Text = GridView1.SelectedRow.Cells[12].Text;

    }

    protected void BtnExcluir_Click(object sender, EventArgs e)
    {
        Executar(Convert.ToString(ID.Text));
        Response.Redirect("~/Default.aspx");
    }


    protected void Page_Load(object sender, EventArgs e)
    {
       
    }
}