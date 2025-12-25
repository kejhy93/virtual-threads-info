# Understanding Java's Virtual Threads
## A New Era of Concurrency

---

## What are Virtual Threads?

Introduced in Java 19 as a preview feature and finalized in Java 21, virtual threads are a lightweight implementation of threads provided by the JDK rather than the OS.

They are a solution to the "one thread per request" model's scalability issues, allowing for millions of threads to be created.

---

## Key Benefits

- **High Throughput:** Run a massive number of concurrent tasks with minimal overhead.
- **Simplified Code:** Write clear, synchronous, blocking code that remains highly scalable. No more "callback hell".
- **Resource Efficiency:** Virtual threads consume significantly less memory than traditional platform threads.
- **Easy Adoption:** Minimal changes are needed to existing code to take advantage of virtual threads.

---

## Platform vs. Virtual Threads

| Feature          | Platform Threads                                  | Virtual Threads                                     |
|------------------|---------------------------------------------------|-------------------------------------------------------|
| **Mapping**      | 1:1 with OS threads                               | M:N with OS threads (many virtual to few platform)    |
| **Creation Cost**| Heavyweight (OS-level)                            | Lightweight (JDK-managed)                             |
| **Scalability**  | Limited by OS thread count                        | Can create millions                                   |
| **Pooling**      | Often required                                    | Generally not needed                                  |

---

## Code Example

Creating a virtual thread is simple:

```java
Thread.startVirtualThread(() -> {
    System.out.println("Hello from a virtual thread!");
});
```

Using a `StructuredTaskScope` for concurrent tasks:

```java
try (var scope = new StructuredTaskScope.ShutdownOnFailure()) {
    Future<String> user = scope.fork(() -> findUser());
    Future<Integer> order = scope.fork(() -> fetchOrder());

    scope.join();
    scope.throwIfFailed();

    System.out.println(user.resultNow() + ", " + order.resultNow());
}
```

---

## Conclusion

Virtual threads and structured concurrency represent a major advancement in Java, enabling developers to build highly scalable and maintainable concurrent applications with simpler, more traditional code.

### Thank you!