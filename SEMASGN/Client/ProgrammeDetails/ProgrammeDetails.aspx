<%@ Page Language="C#" MasterPageFile="~/Client/MasterPage/MasterPage.Master" AutoEventWireup="true" CodeBehind="ProgrammeDetails.aspx.cs" Inherits="SEMASGN.Client.ProgrammeDetails.ProgrammeDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <asp:HiddenField ID="userTypeHiddenField" runat="server" />
        <!-- Hero Section -->
        <div class="bg-gray-900 text-white relative">
            <div class="inset-0 absolute bg-cover bg-center" style="background-image: url('../../image/programme.jpeg');"></div>
            <div class="inset-0 bg-black absolute opacity-50"></div>
            <div class="px-4 py-16 container relative z-10 mx-auto">
                <h1 class="mb-4 text-4xl font-bold md:text-6xl">
                    <asp:Literal ID="programmeName" runat="server" />
                </h1>
                <p class="mb-8 text-xl">Study computation and automation, learn the digital language.</p>
            </div>
        </div>

        <!-- Main Content -->
        <div class="px-4 py-8 container mx-auto">
            <!-- Shape Your Future Section -->
            <section class="bg-white p-6 mb-8 rounded-lg shadow-md">
                <h2 class="text-gray-800 mb-4 text-3xl font-bold">Shape Your Future in Computer Science</h2>
                <p class="text-gray-600 mb-4">
                    <asp:Literal ID="programmeDescription" runat="server" />
                </p>
                <button class="bg-blue-500 text-white py-2 px-4 rounded font-bold hover:bg-blue-600" onclick="window.location.href='~/Client/FOCS/Chat.aspx';">
                    CHAT TO US
                </button>

            </section>

            <!-- Program Details Section -->
            <section class="gap-4 mb-8 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4">
                <div class="bg-indigo-900 text-white p-6 rounded-lg">
                    <h3 class="mb-2 font-bold">Location:</h3>
                    <p>
                        <asp:Literal ID="programmeCampus" runat="server" />
                    </p>
                </div>
                <div class="bg-blue-500 text-white p-6 rounded-lg">
                    <h3 class="mb-2 font-bold">Duration:</h3>
                    <p>
                        <asp:Literal ID="programmeDuration" runat="server" />
                        years
                    </p>
                </div>
                <div class="bg-teal-500 text-white p-6 rounded-lg">
                    <h3 class="mb-2 font-bold">Intakes:</h3>
                    <p>
                        <asp:Literal ID="programmeIntake" runat="server" />
                    </p>
                </div>
                <div class="bg-green-500 text-white p-6 rounded-lg">
                    <h3 class="mb-2 font-bold">Tuition Fee:</h3>
                    <p>
                        RM <span id="tuitionFee" class="notranslate">
                            <asp:Literal ID="programmeFees" runat="server" /></span>
                    </p>
                    <p class="convert">
                        <span>Converted Fees for Your Region:</span> <span id="convertedFees" class="font-bold"></span>
                    </p>
                </div>
            </section>

            <!-- Minimum Entry Requirements Section -->
            <section class="mb-8 max-w-7xl">
                <h2 class="text-gray-800 mb-6 text-3xl font-bold"><span id="ut"></span>Students Minimum Entry Requirements</h2>
                <div class="bg-white p-6 rounded-lg shadow-lg">
                    <p class="text-gray-700">
                        <asp:Literal ID="requirement" runat="server" />
                    </p>
                </div>
            </section>

            <!-- Modules Section -->
            <section class="bg-white p-6 mb-8 rounded-lg shadow-md">
                <h2 class="text-gray-800 mb-4 text-3xl font-bold">Programme Outline</h2>
                <div class="gap-4 grid grid-cols-1 md:grid-cols-2">
                    <div>
                        <h3 class="mb-2 font-bold">Main Courses: </h3>
                        <ul class="pl-5 space-y-1 list-disc">
                            <asp:Literal ID="programmeMainCourses" runat="server" />
                        </ul>
                    </div>
                    <div>
                        <h3 class="mb-2 font-bold">Language, MPU and Co-curricular Courses:</h3>
                        <ul class="pl-5 space-y-1 list-disc">
                            <asp:Literal ID="programmeMpuCourses" runat="server" />
                        </ul>
                        <h3 class="mt-4 mb-2 font-bold"><span id="ut"></span>Student Specific Subject Requirements: </h3>
                        <ul class="pl-5 space-y-1 list-disc">
                            <asp:Literal ID="Literal1" runat="server" />
                        </ul>
                    </div>

                </div>
            </section>

            <!-- Future Career Section -->
            <section class="bg-white p-6 mb-8 rounded-lg shadow-md">
                <h2 class="text-gray-800 mb-4 text-3xl font-bold">Your Future Career</h2>
                <p class="text-gray-600 mb-4">
                    Computer technologies are integral to modern day life and essential to nearly all modern businesses. Today, we see advanced movements towards some form of digitisation in all aspects of life. As a computational engineering graduate, you will be in high demand across many industries, including IT, software engineering, information technology, web design, and more.
                </p>
                <div class="bg-gray-100 p-4 mb-4 rounded-lg">
                    <h3 class="mb-2 font-bold">Potential graduate opportunities:</h3>
                    <p>
                        <asp:Literal ID="programmeCareers" runat="server" />
                    </p>
                </div>
                <p class="text-gray-600 mb-4">
                    As a student at our institution, you will be supported by our Career Centre, which provides personalised career support and development.      
                </p>
                <button class="bg-blue-500 text-white py-2 px-4 rounded font-bold hover:bg-blue-600">
                    MORE ABOUT OUR CAREER CENTRE
                </button>
            </section>
        </div>

    <script type="text/javascript">
        $(document).ready(function () {
            var userType = $('#<%= userTypeHiddenField.ClientID %>').val();

            var userTypeField = $('#<%= userTypeHiddenField.ClientID %>');
            $('#ut').text(userType);
            if (!userTypeField.val()) {
                $.getJSON('https://ipapi.co/json/', function (ipData) {
                    var userCountryCode = ipData.country_code; // Example: "MY" for Malaysia
                    var userType = userCountryCode === 'MY' ? "Local" : "International";

                    // Set the hidden field value
                    userTypeField.val(userType);

                    document.forms[0].submit();  // This will post the form back to the server
                }).fail(function () {
                    alert("Error detecting IP address.");
                });
            }
        });
    </script>
    <script>
        $(document).ready(function () {
            // Get the fee value from the ASP.NET Literal
            let feeText = $('#tuitionFee').text().trim();  // Retrieve the text inside the span
            console.log("Raw fee text: ", feeText);

            // Remove the comma and parse the numeric value
            let parsedFee = parseFloat(feeText.replace(/,/g, ''));  // Remove any commas

            // Fetch user's country and currency using ipapi.co
            $.getJSON('https://ipapi.co/json/', function (ipData) {
                var userCountryCode = ipData.country_code;  // Example: "MY" for Malaysia
                var userCurrency = ipData.currency;  // Get the user's currency (if available)

                // Determine if user is local or international
                if (userCountryCode === 'MY') {
                    // Local students, no conversion needed
                    $('.convert').hide();
                    $('#convertedFees').text(`RM ${parsedFee.toFixed(2)}`);
                } else {
                    // International students, fetch exchange rate and convert fees
                    $('.convert').show();
                    fetchExchangeRate(parsedFee, userCurrency);
                }
            }).fail(function () {
                alert("Error detecting IP address and currency.");
            });
        });

        // Function to fetch and display international fees with exchange rate conversion
        function fetchExchangeRate(fee, userCurrency) {
            const API_URL = `https://v6.exchangerate-api.com/v6/85aa42352dfdb6ca6baf406e/latest/MYR`; // Convert from MYR to user currency
            fetch(API_URL)
                .then(response => response.json())
                .then(data => {
                    console.log("Exchange rate data received:", data);  // Log the data received from the API

                    // Log available conversion rates
                    console.log("Available conversion rates:", Object.keys(data.conversion_rates));

                    const rate = data.conversion_rates[userCurrency];  // Get the rate for the user's currency
                    if (!rate) {
                        console.error(`No exchange rate found for currency: ${userCurrency}`);
                        $('#convertedFees').text('Exchange rate unavailable.');
                        return;
                    }

                    const convertedAmount = (fee * rate).toFixed(2);  // Convert based on exchange rate
                    $('#convertedFees').text(`${convertedAmount} ${userCurrency}`);  // Display the result
                })
                .catch(error => {
                    console.error("Error fetching exchange rate:", error);
                    $('#convertedFees').text('Error fetching exchange rate.');
                });
        }
    </script>
</asp:Content>
