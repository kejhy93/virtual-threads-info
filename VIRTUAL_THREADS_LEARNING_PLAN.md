# A Plan to Get Familiar with Virtual Threads in Java

This plan will guide you through the process of understanding and using virtual threads in Java. It's designed to be a step-by-step guide, starting with the theory and moving on to practical examples.

## 1. Understand the Core Concepts

Before you start writing code, it's important to understand the "why" behind virtual threads.

*   **What are virtual threads?** They are lightweight threads managed by the JVM, not the OS. This makes them much cheaper to create and manage than traditional "platform" threads.
*   **Why were they introduced?** To simplify writing high-throughput concurrent applications. They allow you to write code in a simple, blocking style, while still achieving high levels of concurrency.
*   **How do they work?** The JVM "mounts" virtual threads onto a small pool of platform threads. When a virtual thread blocks (e.g., on I/O), the JVM "unmounts" it and runs another virtual thread on the same platform thread.

**Resources:**

*   [JEP 444: Virtual Threads](https://openjdk.org/jeps/444)
*   [Baeldung: A Guide to Virtual Threads in Java](https://www.baeldung.com/java-virtual-threads)

## 2. Set Up Your Environment

To use virtual threads, you'll need a recent version of Java.

*   **Install Java 21 or later:** Virtual threads were introduced as a preview feature in Java 19 and are a full feature in Java 21.
*   **Set up a new project:** Create a new Maven or Gradle project. You can use the existing project in this directory as a starting point.

## 3. Write Your First Virtual Thread

Now it's time to write some code.

*   **Create a simple virtual thread:** Use the `Thread.ofVirtual().start()` method to create and start a virtual thread.

```java
Thread.startVirtualThread(() -> {
    System.out.println("Hello from a virtual thread!");
});
```

*   **Experiment with a large number of virtual threads:** Create a large number of virtual threads to see how lightweight they are.

```java
for (int i = 0; i < 100_000; i++) {
    Thread.startVirtualThread(() -> {
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    });
}
```

## 4. Explore Structured Concurrency

Structured concurrency is a new feature that simplifies concurrent programming by treating multiple tasks running in different threads as a single unit of work.

*   **Use a `StructuredTaskScope`:** This is the main entry point for structured concurrency. It allows you to create a scope in which you can fork new threads and then join them.

```java
try (var scope = new StructuredTaskScope.ShutdownOnFailure()) {
    Future<String> user = scope.fork(() -> findUser());
    Future<Integer> order = scope.fork(() -> fetchOrder());

    scope.join();           // Join both forks
    scope.throwIfFailed();  // ... and propagate errors

    // Here, both forks have succeeded, so compose their results
    System.out.println(user.resultNow() + " " + order.resultNow());
}
```

**Resources:**

*   [JEP 453: Structured Concurrency (Preview)](https://openjdk.org/jeps/453)

## 5. Next Steps

*   **Explore the `ExecutorService` with virtual threads:** Use `Executors.newVirtualThreadPerTaskExecutor()` to create an `ExecutorService` that creates a new virtual thread for each task.
*   **Read more about the differences between platform and virtual threads:** Understand when to use each type of thread.
*   **Experiment with different I/O operations:** See how virtual threads behave when performing different types of I/O operations (e.g., network requests, file I/O).
