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
    Expenses manager
</asp:Content>

<%-- The markup and script in the following Content element will be placed in the <body> of the page --%>
<asp:Content ContentPlaceHolderID="PlaceHolderMain" runat="server">
  <div class="container">
     <!--Nav with a jumbotron!!-->
   <div class="jumbotron">
    <div class="container text-center">
        <div class="col s12 id="display">
            <div class="row id="list">
                <%--Show total incomst, payments and balance--%>
                 <table class="bordered" id="detailList">
                    <thead>
                        <tr>
                            <th>March + Remainings</th>
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
                </div>
               </div>
            </div>
        </div>
     </div> <!-- end row -->
           
            <!--AppParts-->
           <div class="row">
             <div class="col-sm-3">
                <div class="panel panel-danger">
                    <div class="panel-heading"><a class="waves-effect waves-light btn" id="addIncome" onclick='addNewFile();' data-toggle="modal" data-target="#newIncome">Add Income</a></div>
                        <div class="panel-body"><img src="../Images/income.png" class="img-responsive" style="width:100%" alt="Image"></div>
                          <div class="panel-footer"></div>
          </div>
       </div>
                  <div class="row">
             <div class="col-sm-3">
                <div class="panel panel-danger">
                    <div class="panel-heading"><a class="waves-effect waves-light btn" id="addPayment" data-toggle="modal" data-target="#newPayment">Add Payment</a></div>
                        <div class="panel-body"><img src="../Images/payment.png" class="img-responsive" style="width:100%" alt="Image"></div>
                          <div class="panel-footer"></div>
          </div>
       </div>

                  <div class="row">
             <div class="col-sm-3">
                <div class="panel panel-danger">
                    <div class="panel-heading"> <a class="waves-effect waves-light btn" id="addMovement" data-toggle="modal" data-target="#myMovement">Movement List</a></div>
                        <div class="panel-body"><img src="../Images/statisk.png" class="img-responsive" style="width:100%" alt="Image"></div>
                          <div class="panel-footer"></div>
          </div>
       </div>

                      <div class="row">
             <div class="col-sm-3">
                <div class="panel panel-danger">
                    <div class="panel-heading"> <a class="waves-effect waves-light btn" id="addSettings" data-toggle="modal" data-target="#mysettings">Settings</a></div>
                        <div class="panel-body"><img src="../Images/sett.png" class="img-responsive" style="width:100%" alt="Image"></div>
                          <div class="panel-footer"></div>
          </div>
       </div>
   </div>

<footer class="container-fluid text-center">
  <form class="form-inline">Extense managment
    <input type="email" class="form-control" size="30" placeholder="Email Address">
    <button type="button" class="btn btn-danger">Sign in</button>
  </form>
</footer>
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
        <div class="modal fade" id="myMovement">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="myModalLabel">Movements</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                                <table id="myMovementList" border="0" cellspacing="5" cellpadding="5">
                    <tbody><tr>
                        <td>Minimum mount:</td>
                        <td><input type="text" id="min" name="min" /></td>
                    </tr>
                    <tr>
                        <td>Maximum mount:</td>
                        <td><input type="text" id="max" name="max"></td>
                    </tr>
                </tbody>
            </table>
            <table id="example" class="display" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Category</th>
                            <th>Date</th>
                            <th>Amount</th>
                        </tr>
                    </thead>
                    <tfoot>
                        <tr>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Category</th>
                            <th>Date</th>
                            <th>Amount</th>
                        </tr>
                    </tfoot>
                    <tbody>
                        <tr>
                            <td>Car</td>
                            <td>System</td>
                            <td>Food</td>
                            <td>2011/04/25</td>
                            <td>7.000kr</td>
                        </tr>
                        <tr>
                            <td>Fuel</td>
                            <td>Transport</td>
                            <td>Automobile</td>
                            <td>2011/04/25</td>
                            <td>3.200kr</td>
                        </tr>
                        <tr>
                            <td>Dinner</td>
                            <td>Middag</td>
                            <td>Food</td>
                            <td>2011/04/25</td>
                            <td>300kr</td>
                        </tr>
                        </tbody>
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

              <!--Settings-->
         <div class="modal fade" id="mysettings">
             <div class="modal-dialog">
                 <div class="modal-content">
                     <div class="modal-header">
                         <h4 class="modal-title" id="myModalLabel"></h4>
                     </div>
                     <div class="modal-body">
                         <div class="row">
                             <div id="filter">
                                 <a class="waves-effect waves-yellow btn" id="dag1">Account managment</a>
                                 <a class="waves-effect waves-yellow btn" id="dag2">Password</a>
                                 <a class="waves-effect waves-yellow btn" id="dag3">Payment type</a>
                                 <a class="waves-effect waves-yellow btn" id="dag3">Current format</a>
                                 <a class="waves-effect waves-yellow btn" id="dag3">Help</a>
                             </div>
                         </div>
                         <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" id="submitForm">Save</button>
                    </div>
                     </div>
                 </div>
             </div>
          </div>
              <!--end-->
               <script type="text/javascript">
                   $('.datepicker').pickadate({
                       selectMonths: true, // Creates a dropdown to control month
                       selectYears: 15 // Creates a dropdown of 15 years to control year
                   });
        
    </script>
</asp:Content>
