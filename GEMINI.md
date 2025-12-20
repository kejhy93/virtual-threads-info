# Project Overview

This is a Spring Boot project that serves as a demonstration for virtual threads and structured concurrency in Java. It's a simple web application built with Maven. The project includes a simple REST controller with a `/hello` endpoint and is configured with liveness and readiness probes.

# Building and Running

The project can be built and run using the Maven wrapper.

**To run the application:**

```bash
./mvnw spring-boot:run
```

The application will be available on port 8080, and the actuator endpoints will be available on port 8088.

**To run the application and check its health:**

```bash
./run_and_check.sh
```

This script will start the application, wait for it to be healthy, and then exit.

# Development Conventions

The project uses the standard Spring Boot project structure.

*   **Source code:** `src/main/java`
*   **Resources:** `src/main/resources`
*   **Tests:** `src/test/java`

The project uses the Maven wrapper, so there is no need to install Maven separately.
