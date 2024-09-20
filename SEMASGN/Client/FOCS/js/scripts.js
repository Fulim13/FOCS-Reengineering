document.addEventListener("DOMContentLoaded", function () {
    // Elements
    const textarea = document.getElementById("autoGrowingTextarea");
    const submitButton = document.getElementById("submitMessage");

    // Autoresize textarea when typing a long message
    function autoGrowingTextarea() {
        if (textarea) {
            textarea.style.height = "auto"; // Reset the height
            textarea.style.height = textarea.scrollHeight + "px"; // Set the height to scroll height
            updateConversationPadding(textarea.scrollHeight);
            scrollToLatestMessage(); // Scroll to the latest message whenever the height changes
            checkTextareaEmpty(); // Check if textarea is empty to enable/disable submit button
        }
    }

    // Update padding-bottom of the conversation div based on textarea height plus an additional 16px
    // Ensure the padding does not exceed 232px (equals the size of the maximum textarea height + 16px additional space)
    function updateConversationPadding(textAreaHeight) {
        const maxPadding = 236;
        const additionalPadding = 16;
        const calculatedPadding = textAreaHeight + additionalPadding;

        const conversationDiv = document.getElementById("conversation");
        if (conversationDiv) {
            conversationDiv.style.paddingBottom =
                Math.min(calculatedPadding, maxPadding) + "px";
        }
    }

    // Scroll to the latest message
    function scrollToLatestMessage() {
        var container = document.getElementById("conversation");
        if (container) {
            container.scrollTop = container.scrollHeight;
        }
    }

    // Check if the textarea is empty and disable or enable the submit button
    function checkTextareaEmpty() {
        if (textarea.value.trim() === "") {
            submitButton.disabled = true;
        } else {
            submitButton.disabled = false;
        }
    }

    if (textarea) {
        textarea.addEventListener("input", autoGrowingTextarea);
        autoGrowingTextarea(); // Initial resize if there's any text already
    }

    // Update the agent's status according to business hours.
    // TODO: Re-check that it works with winter/summer time adjustments.
    function updateAgentStatus() {
        // Get current time in UTC
        const nowUTC = Date.now();
        const today = new Date();
        const year = today.getUTCFullYear();
        const month = today.getUTCMonth();
        const day = today.getUTCDate();

        // Convert business hours in UTC
        const startHour = 9;
        const endHour = 17;
        const offset = -4;
        const startUTC = Date.UTC(year, month, day, startHour - offset, 0, 0);
        const endUTC = Date.UTC(year, month, day, endHour - offset, 0, 0);

        // Cache agentAvailability element selection
        var agentAvailability = document.getElementById("agentAvailability");

        // Create offline div
        var offlineDiv = document.createElement("div");
        offlineDiv.classList.add("availability", "offline");
        offlineDiv.innerHTML = `<img src="./icons/time.svg" />Available: ${startHour}:00—${endHour}:00 (New York)<div class="agent-status"></div>`;

        // Check if current time is within business hours
        if (nowUTC >= startUTC && nowUTC <= endUTC) {
            offlineDiv.classList.replace("offline", "online");
            offlineDiv.innerHTML =
                '<img src="./icons/time.svg" />Available Now<div class="agent-status"></div>';
        }

        // Append offlineDiv to agentAvailability
        agentAvailability.appendChild(offlineDiv);
    }

    // Format timestamp
    function formatTimestamp(timestamp) {
        const now = new Date();
        const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
        const yesterday = new Date(
            now.getFullYear(),
            now.getMonth(),
            now.getDate() - 1
        );

        const date = new Date(timestamp);
        const messageDate = new Date(
            date.getFullYear(),
            date.getMonth(),
            date.getDate()
        );

        const hours = date.getHours();
        const minutes = date.getMinutes();
        const time = `${hours.toString().padStart(2, "0")}:${minutes
            .toString()
            .padStart(2, "0")}`;

        if (messageDate.getTime() === today.getTime()) {
            return time;
        } else if (messageDate.getTime() === yesterday.getTime()) {
            return `Yesterday · ${time}`;
        } else {
            const options = {
                weekday: "short",
                month: "short",
                day: "numeric",
                hour: "numeric",
                minute: "numeric",
            };
            const formattedDate = new Intl.DateTimeFormat("en-US", options).format(
                date
            );
            const parts = formattedDate.split(", ");
            const dayOfWeek = parts[0];
            const monthAndDay = parts[1].split(" ");
            const formattedMonthAndDay = `${monthAndDay[0]} ${monthAndDay[1]}`;

            return `${dayOfWeek}, ${formattedMonthAndDay} · ${time}`;
        }
    }

    // Toggle message details when clicking on a message
    function toggleDetails(textDiv) {
        var details = textDiv.parentElement.nextElementSibling;
        if (details) {
            details.style.display =
                details.style.display === "none" ? "flex" : "none";
        }
    }

    // Copy message text to clipboard
    function copyText(text, element) {
        navigator.clipboard
            .writeText(text)
            .then(() => {
                element.innerHTML = `
          <img src="./icons/checkmark.svg" title="Copied to clipboard" />
          <div class="copy-label copied">Copied!</div>
        `;

                setTimeout(() => {
                    element.innerHTML = `
            <img src="./icons/copy.svg" title="Copy message" />
            <div class="copy-label">Copy</div>
          `;
                }, 2000);
            })
            .catch((err) => {
                console.error("Failed to copy: ", err);
            });
    }

    // Track scroll position to toggle the scroll-to-bottom button
    const scrollButton = document.querySelector(".scroll-to-bottom");
    const conversation = document.getElementById("conversation");

    if (conversation) {
        const offset = 200;
        conversation.addEventListener("scroll", function () {
            if (
                conversation.scrollHeight - conversation.scrollTop - offset <=
                conversation.clientHeight
            ) {
                scrollButton.style.display = "none";
            } else {
                scrollButton.style.display = "flex";
            }
        });
    }

    // Handle click on the scroll-to-bottom button
    if (scrollButton) {
        scrollButton.addEventListener("click", scrollToLatestMessage);
    }

    // Split the name into initials
    function getInitials(name) {
        const words = name.split(" ");
        const firstLetters = words.map((word) => word.charAt(0)).join("");
        return firstLetters;
    }

    updateAgentStatus();
    checkTextareaEmpty(); // Initial check to see if the textarea is empty

    const messagesContainer = document.getElementById("messages-dedicated-agent");
    const loadingIndicator = document.createElement('div');
    loadingIndicator.className = 'message loading-indicator';
    loadingIndicator.innerHTML = `
        <div class="loading-indicator-content">
            <div class="loading-dots"><div></div><div></div><div></div></div>
            <span class="loading-text">Response is generating</span>
        </div>
    `;
    loadingIndicator.style.display = 'none';

    // Function to show loading indicator
    function showLoadingIndicator() {
        loadingIndicator.style.display = 'block';
        messagesContainer.appendChild(loadingIndicator); // Move indicator to the bottom
        textarea.disabled = true;
        submitButton.disabled = true;
        scrollToLatestMessage();
    }

    // Function to hide loading indicator
    function hideLoadingIndicator() {
        loadingIndicator.style.display = 'none';
        if (loadingIndicator.parentNode === messagesContainer) {
            messagesContainer.removeChild(loadingIndicator);
        }
        textarea.disabled = false;
        checkTextareaEmpty(); // Re-enable submit button if there's text
    }

    // New function to send message to backend
    async function sendMessageToBackend(message) {
        showLoadingIndicator();
        try {
            const response = await fetch('http://fulim.social:8000/test/', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ message: message }),
            });

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const data = await response.json();
            console.log(data);
            return data.data;
        } catch (error) {
            console.error('Error:', error);
            return 'Sorry, there was an error processing your request.';
        } finally {
            hideLoadingIndicator();
        }
    }

    // Function to add a message to the chat
    function addMessageToChat(message, isOutgoing) {
        // Create and append the style element to the head
        const style = document.createElement('style');
        style.textContent = `
        /* Style for <a> tags to have a blue underline */
        a {
            color: blue;
            text-decoration: underline;
        }
        
        /* Preserve newlines and other whitespace in message text */
        .message .text {
            white-space: pre-wrap; /* Preserve whitespace and line breaks */
        }
    `;
        document.head.appendChild(style);

        const messagesContainer = document.getElementById("messages-dedicated-agent");
        if (messagesContainer) {
            const messageElement = document.createElement('div');
            messageElement.className = `message${isOutgoing ? " outgoing" : ""}`;

            // Use innerHTML to insert the message as HTML
            messageElement.innerHTML = `
            <div class="message-container">
                <div class="message-inner">
                    <div class="text">${message}</div> <!-- Render HTML content here -->
                </div>
                <div class="details" style="display: none;">
                    ${formatTimestamp(Date.now())}
                    <div class="copy-text">
                        <div><img src="./icons/copy.svg" title="Copy message" /></div>
                        <div class="copy-label">Copy</div>
                    </div>
                </div>
            </div>
        `;

            // Remove loading indicator if it exists
            if (loadingIndicator.parentNode === messagesContainer) {
                messagesContainer.removeChild(loadingIndicator);
            }

            messagesContainer.appendChild(messageElement);

            // Attach event listeners
            const textDiv = messageElement.querySelector('.text');
            textDiv.addEventListener("click", () => toggleDetails(textDiv));

            const copyDiv = messageElement.querySelector('.copy-text');
            copyDiv.addEventListener("click", () => copyText(message, copyDiv));
        }
    }


    // Function to add the introduction message and buttons
    function addIntroductionAndButtons() {
        const introMessage = "Hello! I'm Jamie, your assistant from TARUMT. I'm here to assist you with any questions you may have about FOCS university courses. How may I assist you today?";

        // Add the introduction message to the chat
        addMessageToChat(introMessage, false);

        // Add the buttons with questions
        const messagesContainer = document.getElementById("messages-dedicated-agent");
        if (messagesContainer) {
            const buttonContainer = document.createElement('div');
            buttonContainer.className = 'message buttons';

            buttonContainer.innerHTML = `
            <button id="question1" type="button" class="rounded-md border border-transparent py-2 px-4 flex items-center text-center text-sm transition-all text-slate-600 hover:bg-slate-100 focus:bg-slate-100 active:bg-slate-100 disabled:pointer-events-none disabled:opacity-50 disabled:shadow-none" type="button">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-4 h-4 ml-1.5">
                <path fill-rule="evenodd" d="M16.72 7.72a.75.75 0 0 1 1.06 0l3.75 3.75a.75.75 0 0 1 0 1.06l-3.75 3.75a.75.75 0 1 1-1.06-1.06l2.47-2.47H3a.75.75 0 0 1 0-1.5h16.19l-2.47-2.47a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
                </svg>
                &nbsp; &nbsp;
                What is the Minimum Requirement for Diploma In Computer Science ?
            </button>
            <button id="question2" type="button" class="rounded-md border border-transparent py-2 px-4 flex items-center text-center text-sm transition-all text-slate-600 hover:bg-slate-100 focus:bg-slate-100 active:bg-slate-100 disabled:pointer-events-none disabled:opacity-50 disabled:shadow-none" type="button">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-4 h-4 ml-1.5">
                <path fill-rule="evenodd" d="M16.72 7.72a.75.75 0 0 1 1.06 0l3.75 3.75a.75.75 0 0 1 0 1.06l-3.75 3.75a.75.75 0 1 1-1.06-1.06l2.47-2.47H3a.75.75 0 0 1 0-1.5h16.19l-2.47-2.47a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
                </svg>
                &nbsp; &nbsp;
                What is the Fee of Bachelor of Degree in Software Engineering ?
            </button>
            <button id="question3" type="button" class="rounded-md border border-transparent py-2 px-4 flex items-center text-center text-sm transition-all text-slate-600 hover:bg-slate-100 focus:bg-slate-100 active:bg-slate-100 disabled:pointer-events-none disabled:opacity-50 disabled:shadow-none" type="button">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-4 h-4 ml-1.5">
                <path fill-rule="evenodd" d="M16.72 7.72a.75.75 0 0 1 1.06 0l3.75 3.75a.75.75 0 0 1 0 1.06l-3.75 3.75a.75.75 0 1 1-1.06-1.06l2.47-2.47H3a.75.75 0 0 1 0-1.5h16.19l-2.47-2.47a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
                </svg>
                &nbsp; &nbsp;
                What is the Intake month for Foundation in Computing ?
            </button>
        `;

            messagesContainer.appendChild(buttonContainer);

            // Attach click events to the buttons
            document.getElementById('question1').addEventListener('click', () => sendPredefinedQuestion('What is the Minimum Requirement for Diploma In Computer Science ?'));
            document.getElementById('question2').addEventListener('click', () => sendPredefinedQuestion('What is the Fee of Bachelor of Degree in Software Engineering ?'));
            document.getElementById('question3').addEventListener('click', () => sendPredefinedQuestion('What is the Intake month for Foundation in Computing ?'));
        }
    }


    // Function to send predefined questions to the backend
    async function sendPredefinedQuestion(question) {
        addMessageToChat(question, true);
        textarea.value = '';
        autoGrowingTextarea();
        checkTextareaEmpty();

        showLoadingIndicator();
        const botResponse = await sendMessageToBackend(question);
        hideLoadingIndicator();

        addMessageToChat(botResponse, false);
        scrollToLatestMessage();
    }

    // Add the introduction and buttons on page load
    addIntroductionAndButtons();



    // Update the submit button click event
    if (submitButton) {
        submitButton.addEventListener("click", async function () {
            const userMessage = textarea.value.trim();
            if (userMessage) {
                addMessageToChat(userMessage, true);
                textarea.value = '';
                autoGrowingTextarea();
                checkTextareaEmpty();

                showLoadingIndicator();
                const botResponse = await sendMessageToBackend(userMessage);
                hideLoadingIndicator();

                addMessageToChat(botResponse, false);
                scrollToLatestMessage();
            }
        });
    }

    // Initial message display (if needed)
    //displayMessages([]);  // You can pass an empty array or remove this if not needed

    // Render messages (modified to work with the new addMessageToChat function)
    function displayMessages(data) {
        const messagesContainer = document.getElementById("messages-dedicated-agent");
        if (messagesContainer) {
            messagesContainer.innerHTML = '';  // Clear existing messages
            data.forEach(message => {
                addMessageToChat(message.text, message.outgoing);
            });
        }
    }
});