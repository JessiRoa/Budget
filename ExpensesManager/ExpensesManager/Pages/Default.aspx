<%-- The following 4 lines are ASP.NET directives needed when using SharePoint components --%>

<%@ Page Inherits="Microsoft.SharePoint.WebPartPages.WebPartPage, Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" MasterPageFile="~masterurl/default.master" Language="C#" %>

<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%-- The markup and script in the following Content element will be placed in the <head> of the page --%>
<asp:Content ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <script src="../Scripts/jquery-3.1.1.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <script src="../Scripts/bootstrap-dialog.js"></script>
    <script src="../Scripts/materialize/materialize.min.js"></script>
    <script src="../Scripts/moment-with-locales.min.js"></script>

    <script src="../Scripts/App.js"></script>

    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/bootstrap-dialog.css" rel="stylesheet" />
    <link href="../Content/materialize/css/materialize.min.css" rel="stylesheet" />
    <link href="../Content/App.css" rel="stylesheet" />
</asp:Content>

<%-- The markup in the following Content element will be placed in the TitleArea of the page --%>
<asp:Content ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server">
    Page Title
</asp:Content>

<%-- The markup and script in the following Content element will be placed in the <body> of the page --%>
<asp:Content ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <div class="container">
        <div class="col s12">
            <div class="row">
                <%--Show total incomst, payments and balance--%>
                 <table id="detailList">
                    <thead>
                        <tr>
                            <th>Title</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Incomster: +</td>
                            <td id="totalIncomster"></td>
                        </tr>
                        <tr>
                            <td>Payments: -</td>
                            <td id="totalPayment"></td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td>Balance:</td>
                            <td id="balance"></td>
                        </tr>
                    </tfoot>
                </table>
            </div> <!-- end row -->
            <div class="row">
                <div class="col s12">
                    <a class="waves-effect waves-light btn" id="addIncome" onclick='addNewItem();' data-toggle="modal" data-target="#newIncome">Add Income</a>
                    <a class="waves-effect waves-light btn" id="addPayment" onclick='addNewItem();' data-toggle="modal" data-target="#newPayment">Add Payment</a>
                    <a class="waves-effect waves-light btn" id="myMovements" onclick='getLists();' data-toggle="modal" data-target="#movements">Movements</a>
                </div>
            </div><!-- end row -->
        </div> <!-- end col s12 -->
    </div> <!-- end container -->

        <!-- Modal incomes dialog -->
        <div class="modal fade" id="newIncome">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="myModalLabel">New Income</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <form class="col s12">
                              <div class="row">
                                <div class="input-field col s12">
                                  <input id="nameField" type="text" class="validate">
                                  <label for="nameField">Name</label>
                                </div>
                              </div><!-- end row -->
                              <div class="row">
                                <div class="input-field col s12">
                                  <input id="amountField" type="number" class="validate">
                                  <label for="amountField">Amount</label>
                                </div>
                              </div><!-- end row -->
                             <div class="row">
                                <div class="input-field col s12">
                                    <input type="text" id="descriptionField" class="validate">
                                  <label for="descriptionField">Description</label>
                                </div>
                              </div><!-- end row -->
                                <div class="row">
                                <div class="input-field col s12">
                                    <input type="date" id="dateField" class="datepicker">
                                  <label for="dateField">Date</label>
                                </div>
                              </div><!-- end row -->
                                <div class="row">
                                    <div class="input-field col s12">
                                        <select  id="categories">
                                          <option value="" disabled selected>Choose category</option>
                                         
                                        </select>
                                        <label>Category</label>
                                  </div>
                                </div><!-- end row -->
                            </form>
                          </div><!-- end row -->
                    </div><!-- end modal-body -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" id="submitForm">Save</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

        <!-- Modal payment dialog -->
        <div class="modal fade" id="newPayment">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="myModalLabel">New Payment</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <form class="col s12">
                              <div class="row">
                                <div class="input-field col s12">
                                  <input id="nameField" type="text" class="validate">
                                  <label for="nameField">Name</label>
                                </div>
                              </div><!-- end row -->
                              <div class="row">
                                <div class="input-field col s12">
                                  <input id="amountField" type="number" class="validate">
                                  <label for="amountField">Amount</label>
                                </div>
                              </div><!-- end row -->
                             <div class="row">
                                <div class="input-field col s12">
                                    <input type="text" id="descriptionField" class="validate">
                                  <label for="descriptionField">Description</label>
                                </div>
                              </div><!-- end row -->
                                <div class="row">
                                <div class="input-field col s12">
                                    <input type="date" id="dateField" class="datepicker">
                                  <label for="dateField">Date</label>
                                </div>
                              </div><!-- end row -->
                                <div class="row">
                                    <div class="input-field col s12">
                                        <select  id="categories2">
                                          <option value="" disabled selected>Choose category</option>
                                         
                                        </select>
                                        <label>Category</label>
                                  </div>
                                </div><!-- end row -->
                            </form>
                          </div><!-- end row -->
                    </div><!-- end modal-body -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" id="submitForm">Save</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

     <!-- Modal movements dialog -->
        <div class="modal fade" id="movements">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="myModalLabel">Movements</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <table id="myMovementList">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Date</th>
                                        <th>Category</th>
                                        <th>Amount</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div><!-- end row -->
                    </div><!-- end modal-body -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" id="submitForm">Save</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

     <script type="text/javascript">
        $('.datepicker').pickadate({
            selectMonths: true, // Creates a dropdown to control month
            selectYears: 15 // Creates a dropdown of 15 years to control year
        });


        
    </script>
</asp:Content>
