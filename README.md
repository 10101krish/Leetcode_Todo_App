# LeetCode Todo App
 
## Streamline Your LeetCode Practice (Flutter & Dart)

This project, "LeetCode Todo App," is a mobile application built using Flutter and Dart to transform your LeetCode practice experience. It offers a comprehensive suite of functionalities designed to streamline question management, automate data gathering, and personalize your practice schedule, allowing you to focus on mastering coding challenges.

**Key Features:**

1. **Effortless Question Setup:** LeetCode Todo App eliminates the tedious task of manually entering question details. Provide a LeetCode question link, and the app leverages **WebView** technology to automatically extract the question's title, description, and difficulty level. WebView acts as a web browser embedded within your Flutter application, allowing the app to interact with the LeetCode website and scrape the necessary data. This not only saves you valuable time but also ensures accuracy in your data.

2. **Intelligent Practice Scheduling:** Move beyond generic practice routines. LeetCode Todo App empowers you to set personalized practice reminders based on your confidence level for each question.  Confidence levels range from low to high, with corresponding practice intervals strategically designed to optimize knowledge retention. For example, questions marked with low confidence will trigger reminders more frequently (e.g., every seven days) to solidify your understanding. Conversely, high-confidence questions will be revisited at less frequent intervals (e.g., every 21 days) to maintain mastery. This data is securely stored within a Sqflite database, ensuring persistence and enabling the app to generate efficient practice schedules tailored to your needs.

3. **Intuitive User Interface:** The app prioritizes a user-centric design that promotes clarity and ease of use. Upon launch, the app intelligently retrieves all questions approaching their practice due date from the Sqflite database and presents them as actionable tiles on the landing page. Each tile displays vital information about the question, allowing you to prioritize your practice quickly. Clicking on these tiles directly opens the question on the LeetCode website, eliminating unnecessary navigation steps and allowing you to transition into practice mode seamlessly.

4. **Dynamic Practice Adaptation:** LeetCode Todo App goes beyond static reminders and continuously incorporates a feedback loop to refine your practice schedule. Once you complete a question, a pop-up prompts you to update your confidence level. This user input is vital in dynamically recalculating your next practice due date. By reflecting on your performance, you can adjust the reminder frequency to make sure focused repetition aligns with your current concept understanding. This approach maximizes your learning potential by prioritizing questions requiring more attention while allowing you to revisit concepts you've grasped efficiently. The updated confidence level is then saved back to the Sqflite database, maintaining data integrity and ensuring the accuracy of your future practice schedules.

**In essence, the LeetCode Todo App is an invaluable companion for LeetCode users. By automating data collection, personalizing practice schedules, and incorporating user feedback, the app empowers you to streamline your practice management, improve focus, and ultimately achieve your coding proficiency goals.**

**Technologies Used:**

* **Flutter:** A free and open-source framework by Google for building beautiful, natively compiled mobile, web, desktop, and embedded mobile applications from a single codebase.
* **Dart:** A client-optimized, object-oriented, garbage-collected programming language used to build web, mobile, server, desktop, and embedded applications.
* **WebView:** A core component for the web scraping functionality. It allows the app to interact with the LeetCode website and extract question details.
* **Flutter Riverpod:** A state management solution for Flutter applications inspired by Provider.
* **String Validator:** A library for validating user input strings against various criteria.
* **URL Launcher:** A library for launching external URLs (like LeetCode question links) from your Flutter application.
* **Sqflite:** A lightweight embedded SQL database library for Flutter applications.

This combination of technologies allows for a robust, efficient, and user-friendly mobile application that effectively complements your LeetCode practice journey.
