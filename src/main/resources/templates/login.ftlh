<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Log in</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="bg-gray-50 min-h-screen">

<div class="flex flex-col justify-center items-center min-h-screen py-12 px-4 sm:px-6 lg:px-8">
    <div class="w-full max-w-sm">
        <div class="border border-gray-200 p-9 mb-5 bg-white rounded-lg shadow-sm">
            <form action="/login" method="post" class="flex flex-col gap-2.5">
                <h1 class="text-3xl font-medium text-center mb-6">Log in</h1>

                <div class="mb-4">
                    <input
                            type="text"
                            id="username"
                            name="username"
                            placeholder="Username"
                            required
                            class="w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
                    />
                </div>

                <div class="mb-4">
                    <input
                            type="password"
                            id="password"
                            name="password"
                            placeholder="Password"
                            required
                            class="w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
                    />
                </div>

                <#if error??>
                    <p class="text-red-500 text-sm mb-2">${error}</p>
                </#if>

                <button type="submit"
                        class="my-4 bg-amber-50 text-gray-700 p-2 border rounded-2xl cursor-pointer hover:text-black hover:bg-amber-100 transition-colors">
                    Log in
                </button>

                <a href="/reset-password" class="self-center text-sm text-blue-400 hover:text-blue-600 transition-colors">
                    Forgot the password?
                </a>
            </form>
        </div>

        <div class="flex flex-col items-center p-3.5 border border-gray-200 w-full bg-white rounded-lg shadow-sm">
            <p class="text-gray-600">No account yet?</p>
            <a href="/register" class="text-blue-400 hover:text-blue-500 transition-colors">Register</a>
        </div>
    </div>

    <div class="fixed left-0 bottom-0 w-full py-4 px-4 bg-blue-600 text-white text-center">
        <div class="container mx-auto">
            Copyright © 2025. All rights reserved. Suslike.
        </div>
    </div>
</div>

</body>
</html>