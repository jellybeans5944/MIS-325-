Imports System.Data 'allows us to use object datatable

Partial Class MIS_325_Homework_HW4_Heneghan_Assignment4
    Inherits System.Web.UI.Page

    'Global variables 
    Public Shared gintNumberofDays, gintDailyTotalCost, gintReservation As Integer
    Public Shared FourDoorSedan, EightPassengerVan, PickUpTruck, gintTotalRentalCost As Decimal
    Public Shared intDailyCarRentalCost As Integer
    Public Shared dtRentalInvoices As New DataTable 'is this supposed to be a string??? 

#Region "Calculations, error checking, and output"

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        'Variable Deckarations 
        Dim decFlatRate As Decimal = 0.25
        Dim decCleaningFee As Decimal = 25.0
        Dim TS As TimeSpan
        Dim dr As DataRow = dtRentalInvoices.NewRow
        Dim intTotalMileage As Integer

        'helps page noy scroll back up 
        Page.MaintainScrollPositionOnPostBack = True

        'error chekcing for Rental list (radio button list) 
        If RblRentalType.SelectedIndex = -1 Then
            txtOutput1.Text = "Please select a rental vechicle"
            Exit Sub
        End If

        'error cheching for exercise list 
        If ChkReturnDirty.Checked = True Then
            gintTotalRentalCost = gintTotalRentalCost + decCleaningFee
        End If
        If ChkReturnDirty.Checked = -1 Then
            txtOutput1.Text = "Was the car retuned Clean?" & vbNewLine & vbNewLine
        End If

        'error checking for MIleage textbox 
        If txtTotalMileage.Text = Nothing OrElse IsNumeric(txtTotalMileage.Text) = False Then
            Response.Write("Please ensure values are numeric")
            Exit Sub
        Else
            intTotalMileage = Convert.ToDecimal(txtTotalMileage.Text)
        End If


        'Setting variable for radiobutton list 
        intDailyCarRentalCost = RblRentalType.SelectedValue


        'Calculations and parsing textboxwes
        Dim pickupDate As Date = DateTime.Parse(txtRentalDropoff.Text)
        Dim dropoffDate As Date = DateTime.Parse(txtPickupDate.Text)
        TS = DateTime.Parse(txtRentalDropoff.Text) - DateTime.Parse(txtPickupDate.Text)

        dr.Item("Dropoffdate") = DateTime.Parse(txtRentalDropoff.Text) 'ToString("mm/dd/yy")
        dr.Item("Pickupdate") = DateTime.Parse(txtPickupDate.Text).ToShortDateString


        gintDailyTotalCost = TS.TotalDays * (intTotalMileage * decFlatRate) 'days*milage = daily rental charge

        gintTotalRentalCost = gintDailyTotalCost + decCleaningFee 'total rental cost 

        'putting values for the car tyoe to data table 
        dr("CarType") = RblRentalType.SelectedItem.Text
        dr("RentalRate") = RblRentalType.SelectedValue
        dr("RentalDuration") = TS.TotalDays
        dr("MilageCharge") = gintDailyTotalCost
        dr("TotalRentalCost") = gintTotalRentalCost

        'updating running totals for radiobutton lists 
        gintReservation += 1

        dtRentalInvoices.Rows.Add(dr)

        'add the column to the data table
        GridView1.DataSource = dtRentalInvoices
        GridView1.DataBind()

        'output 
        txtOutput1.Text = "Total Reservations " & gintReservation.ToString & vbNewLine

    End Sub
#End Region

#Region "Adding and creating columns of array"

    Private Sub MIS_325_Homework_HW4_Heneghan_Assignment4_Init(sender As Object, e As EventArgs) Handles Me.Init


        'error cheching for data table
        If dtRentalInvoices.Columns.Count > 0 OrElse dtRentalInvoices.Columns.Count > 0 Then
            Exit Sub
        End If

        'adduing columns to array
        With dtRentalInvoices
            .Columns.Add("ReservationID", GetType(Integer))
            .Columns.Add("PickUpDate", GetType(String))
            .Columns.Add("DropOffDate", GetType(String))
            .Columns.Add("CarType", GetType(String))
            .Columns.Add("RentalRate", GetType(Integer))
            .Columns.Add("RentalDuration", GetType(Integer))
            .Columns.Add("MilageCharge", GetType(Decimal))
            .Columns.Add("TotalRentalCost", GetType(Decimal))
        End With

        'contraint, auto numbering and intiial vlaues 
        dtRentalInvoices.Columns("ReservationID").AutoIncrement = True
        dtRentalInvoices.Columns("ReservationID").AutoIncrementSeed = 1
        dtRentalInvoices.Columns("ReservationID").AutoIncrementStep = 1


    End Sub

#End Region
End Class
