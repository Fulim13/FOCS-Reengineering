<%@ Page Title="" Language="C#" MasterPageFile="~/Client/MasterPage/MasterPage.Master" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="SEMASGN.Client.Home.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #scrollContainer {
            -ms-overflow-style: none; /* IE and Edge */
            scrollbar-width: none; /* Firefox */
        }

            #scrollContainer::-webkit-scrollbar {
                display: none; /* Chrome, Safari, Opera */
            }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="mt-0.5 relative" style="height:800px;">
        <div class="inset-0 from-blue-900 to-blue-700 absolute opacity-80"></div>
        <div class="text-white px-4 ml-28 relative z-10 flex h-full items-center">
            <div class="max-w-3xl">
                <div class="mb-6">
                    <h3 class="text-yellow-400 mb-2 font-semibold">Tunku Abdul Rahman University of Management and Technology (TAR UMT)</h3>
                </div>
                <h1 class="mb-6 text-4xl font-bold md:text-5xl">Faculty of Computing and Information Technology (FOCS)</h1>
                <h2 class="mb-6 text-3xl font-bold md:text-4xl">Your Path to IT & CS Excellence Starts Here</h2>
                <p class="mb-8">Join the groundbreaking IT & CS Programme and earn a prestigious qualification from Tunku Abdul Rahman University of Management and Technology (TAR UMT)</p>
                <button class="bg-yellow-400 text-blue-900 py-2 px-6 rounded-full font-bold transition duration-300 hover:bg-yellow-300">
                    Learn More
                </button>
            </div>
        </div>
        <img src="../../image/focs.jpg" alt="Engineering student working" class="inset-0 absolute h-full w-full object-cover" />
    </div>

    <div class="px-4 mt-12 container mx-auto">
        <h1 class="mb-6 text-4xl font-bold">YOUR JOURNEY STARTS HERE</h1>

        <p class="mb-8 text-gray-700">
            Whether you aspire to lead in the business world, innovate in cutting-edge technologies, or make a difference in global challenges, our diverse range of programmes offers the ideal pathway for your aspirations.
        </p>

        <div class="space-x-4 space-x-4 pb-4 flex w-full overflow-hidden" id="scrollContainer">
            <!-- First Card -->
            <div class="w-96 bg-white flex-shrink-0 rounded-lg shadow-md">
                <asp:Image ID="Image3" runat="server" ImageUrl="~/image/home1.jpg" alt="TARUMT Logo" class="h-56 w-full rounded-t-lg object-cover" />
                <div class="p-4">
                    <h3 class="mb-2 text-xl font-semibold">Explore All Programmes</h3>
                    <p class="text-gray-600 mb-4">Learn beyond a formal education. Develop your learning muscle while pursuing various degrees.</p>
                    <a href="#" class="text-blue-600 hover:underline">Learn More &rarr;</a>
                </div>
            </div>

            <!-- Second Card -->
            <div class="w-96 bg-white flex-shrink-0 rounded-lg shadow-md">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/image/home1.jpg" alt="TARUMT Logo" class="h-56 w-full rounded-t-lg object-cover" />
                <div class="p-4">
                    <h3 class="mb-2 text-xl font-semibold">Undergraduate Scholarships</h3>
                    <p class="text-gray-600 mb-4">Benefit from scholarships designed for the brightest talents.</p>
                    <a href="#" class="text-blue-600 hover:underline">Learn More &rarr;</a>
                </div>
            </div>

            <!-- Third Card (Half-visible) -->
            <div class="w-96 bg-white flex-shrink-0 rounded-lg shadow-md">
                <asp:Image ID="Image2" runat="server" ImageUrl="~/image/home1.jpg" alt="TARUMT Logo" class="h-56 w-full rounded-t-lg object-cover" />
                <div class="p-4">
                    <h3 class="mb-2 text-xl font-semibold">Community</h3>
                    <p class="text-gray-600 mb-4">Join our community, supported by peers and mentors.</p>
                    <a href="#" class="text-blue-600 hover:underline">Learn More &rarr;</a>
                </div>
            </div>

            <!-- Third Card (Half-visible) -->
            <div class="w-96 bg-white flex-shrink-0 rounded-lg shadow-md">
                <asp:Image ID="Image4" runat="server" ImageUrl="~/image/home1.jpg" alt="TARUMT Logo" class="h-56 w-full rounded-t-lg object-cover" />
                <div class="p-4">
                    <h3 class="mb-2 text-xl font-semibold">Community</h3>
                    <p class="text-gray-600 mb-4">Join our community, supported by peers and mentors.</p>
                    <a href="#" class="text-blue-600 hover:underline">Learn More &rarr;</a>
                </div>
            </div>
        </div>
    </div>
    <div class="px-4 py-2 mt-5 container mx-auto">
        <!-- Top Divider Line -->
        <hr class="border-gray-200 mb-10 border-t">

        <!-- Appointment Text Section -->
        <p class="text-gray-700 mb-4 text-lg">
            Schedule an appointment to get an online counselling session where you can ask anything about our programmes and the wide range of scholarships for exceptional students!
        </p>

        <!-- CTA Button Section -->
        <div class="space-x-4 flex items-center">
            <!-- Red Rounded Icon (Left) -->
            <div class="w-12 h-12 border-yellow-500 flex items-center justify-center rounded-full border-2">
                <span class="text-yellow-500 text-xl">&#x279C;</span>
                <!-- Arrow Icon -->
            </div>

            <!-- Button Text (Right) -->
            <a href="#" class="text-gray-900 text-xl font-bold hover:text-yellow-500">SCHEDULE APPOINTMENT
            </a>
        </div>
           <!-- Top Divider Line -->
   <hr class="border-gray-100 mt-10 border-b">
    </div>
     <div class="py-10 px-6 container mx-auto">

    <!-- Container for title and stats -->
    <div class="flex items-start justify-between">
      <!-- Title Section aligned to the left -->
      <div class="text-left">
        <h1 class="text-4xl font-bold">FOCS at a Glance</h1>
        <div class="w-16 h-1 bg-black mt-2"></div>
      </div>

      <!-- Stats Section aligned to the right -->
      <div class="gap-8 grid grid-cols-2 text-center md:grid-cols-3 lg:grid-cols-6">
        <!-- Founded -->
        <div class="flex flex-col items-center">
          <h2 class="text-5xl font-bold">1972</h2>
          <p class="text-gray-500 mt-2 text-sm uppercase">Founded</p>
        </div>

        <!-- Departments -->
        <div class="flex flex-col items-center">
          <h2 class="text-5xl font-bold">5</h2>
          <p class="text-gray-500 mt-2 text-sm uppercase">Departments</p>
        </div>

        <!-- Programmes -->
        <div class="flex flex-col items-center">
          <h2 class="text-5xl font-bold">16</h2>
          <p class="text-gray-500 mt-2 text-sm uppercase">Programmes</p>
        </div>

        <!-- Research Centres -->
        <div class="flex flex-col items-center">
          <h2 class="text-5xl font-bold">6</h2>
          <p class="text-gray-500 mt-2 text-sm uppercase">Research Centres</p>
        </div>

        <!-- Active Students -->
        <div class="flex flex-col items-center">
          <h2 class="text-5xl font-bold">3500+</h2>
          <p class="text-gray-500 mt-2 text-sm uppercase">Active Students</p>
        </div>

        <!-- Faculty Recognition -->
        <div class="flex flex-col items-center">
          <h2 class="text-5xl font-bold">1<sup>st</sup></h2>
          <p class="text-gray-500 mt-2 text-sm uppercase">Faculty<br>MDEC PDTI Recognition</p>
        </div>

        <!-- Programmes MDEC Recognition -->
        <div class="flex flex-col items-center">
          <h2 class="text-5xl font-bold">10</h2>
          <p class="text-gray-500 mt-2 text-sm uppercase">Programmes<br>MDEC PDTI Recognition</p>
        </div>

        <!-- Centres of Excellence -->
        <div class="flex flex-col items-center">
          <h2 class="text-5xl font-bold">2</h2>
          <p class="text-gray-500 mt-2 text-sm uppercase">Centres of Excellence</p>
        </div>
      </div>
    </div>
  </div>

    <script>
        const scrollContainer = document.getElementById('scrollContainer');

        let isDown = false;
        let startX;
        let scrollLeft;

        scrollContainer.addEventListener('mousedown', (e) => {
            isDown = true;
            scrollContainer.classList.add('cursor-grabbing');
            startX = e.pageX - scrollContainer.offsetLeft;
            scrollLeft = scrollContainer.scrollLeft;
        });

        scrollContainer.addEventListener('mouseleave', () => {
            isDown = false;
            scrollContainer.classList.remove('cursor-grabbing');
        });

        scrollContainer.addEventListener('mouseup', () => {
            isDown = false;
            scrollContainer.classList.remove('cursor-grabbing');
        });

        scrollContainer.addEventListener('mousemove', (e) => {
            if (!isDown) return;
            e.preventDefault();
            const x = e.pageX - scrollContainer.offsetLeft;
            const walk = (x - startX) * 2; // Adjust scrolling speed here
            scrollContainer.scrollLeft = scrollLeft - walk;
        });
</script>
</asp:Content>
