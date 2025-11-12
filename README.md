# Firebase Concurrency Issue - MCVE

This is a Minimal, Complete, and Verifiable Example for demonstrating a Firebase authentication issue where multiple refresh token requests are sent simultaneously.

## Issue Description

When the Firebase authentication token expires, multiple simultaneous refresh token requests can be triggered concurrently instead of being properly queued or deduplicated.

## Reproducing the Issue

1. **Prerequisites**: The previous token needs to be expired in order to reproduce the issue.

2. **Login**: Use the following credentials:
   - Email: `test@example.com`
   - Password: `Example123`

3. **Wait for Token Expiration**: Wait for the first ID token to become invalid (typically expires after 1 hour) in order to observe refresh token calls.

4. **Observe Network Activity**: Use tools like Proxyman or Charles Proxy to monitor network requests and observe the multiple simultaneous refresh token calls being made.
