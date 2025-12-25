# Project: Virtual Threads and Structured Concurrency Demo

This project started as a simple Spring Boot application to demonstrate virtual threads and structured concurrency in Java. It includes a basic REST controller and is built with Maven.

## Presentation Feature

As part of this project, a web-based presentation on Java Virtual Threads was developed. This presentation is a static single-page application built with HTML, CSS, and JavaScript, located in the `/docs` directory for easy deployment via GitHub Pages.

The presentation's content is dynamically loaded from an external Markdown file (`docs/slide.md`), and it features a dark theme with green text.

### Development History

The development of the presentation involved several key steps and troubleshooting:

1.  **Initial Creation & Deployment Strategy:** The presentation was first created to be served by the Spring Boot application but was later moved to a `/docs` directory to be deployed on GitHub Pages.

2.  **Dynamic Content Loading:** To make the presentation easily editable, the content was externalized into `slide.md`. A script in `index.html` was created to fetch this file, parse the Markdown using `marked.js`, and dynamically generate the slides.

3.  **Troubleshooting & Refinement:**
    *   **CSS & Layout:** Initial layout and styling issues on GitHub Pages were resolved by refining the CSS to ensure proper centering and visibility of content.
    *   **Content Parsing:** A significant challenge was the incorrect rendering of a table and the improper splitting of slides. This was traced back to how the `slide.md` content was being split. The issue was resolved by switching from a simple string split (`---`) to a more robust regular expression (`\n---\n`) to ensure that only dedicated slide separators were used.

4.  **Recent Enhancements:**
    *   **Error Handling:** Added robust error handling to the `fetch` call in `index.html` to gracefully handle cases where `slide.md` might be missing or fail to load.
    *   **Code Readability:** Added detailed comments to `index.html` and `style.css` to improve code readability and maintainability.
    *   **Syntax Highlighting:** Implemented syntax highlighting for Java code blocks using Prism.js to improve the visual presentation of code snippets.
    *   **Keyboard Navigation:** Added keyboard support for slide navigation (Arrow keys for next/previous, 'Home' or 'R' to restart).
    *   **Code Refactoring:** Refactored the JavaScript in `index.html` to reduce code repetition by creating dedicated functions for slide navigation (`nextSlide()`, `prevSlide()`, `goToStart()`).

The final result is a polished, functional presentation that is decoupled from the main Spring Boot application.

# Building and Running the Spring Boot App

The original Spring Boot application can be built and run using the Maven wrapper.

**To run the application:**

```bash
./mvnw spring-boot:run
```

The application will be available on port 8080.