<#macro layout>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Suslike</title>
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
        <script src="https://unpkg.com/lucide@latest"></script>
        <style>
            .nav-icon {
                width: 28px;
                height: 28px;
                stroke-width: 1.5;
                color: #6b7280;
                transition: color 0.2s, transform 0.2s;
            }

            .nav-icon:hover, .active-nav .nav-icon {
                color: #111827;
                transform: scale(1.1);
            }

            .content-with-sidebar {
                margin-left: 80px;
                width: calc(100% - 80px);
            }

            @media (max-width: 640px) {
                .nav-sidebar {
                    width: 100%;
                    height: auto;
                    position: fixed;
                    bottom: 0;
                    left: 0;
                    z-index: 50;
                }

                .nav-sidebar ul {
                    flex-direction: row;
                    justify-content: space-around;
                    width: 100%;
                    padding: 0.5rem;
                }

                .content-with-sidebar {
                    margin-left: 0;
                    width: 100%;
                    padding-bottom: 60px;
                }
            }
        </style>
    </head>
    <body class="bg-gray-50 min-h-screen">
    <#-- Check if user is logged in -->
    <#assign known = SPRING_SECURITY_CONTEXT??>
    <#if known>
        <#assign username = SPRING_SECURITY_CONTEXT.authentication.name>
        <#assign myProfileUrl = "/user/profile/${username}">
    <#else>
        <#assign myProfileUrl = "/login">
    </#if>

    <#-- Get current URL for active link detection -->
    <#assign currentUrl = request.requestURI>

    <!-- Navigation Sidebar -->
    <nav class="nav-sidebar w-20 h-screen bg-white shadow-sm fixed left-0 top-0 flex flex-col items-center justify-center py-6 border-r border-gray-200">
        <div class="text-2xl font-bold mb-10 hidden sm:block">S</div>
        <ul class="flex flex-col gap-8">
            <li>
                <a href="/" class="<#if currentUrl == "/">active-nav</#if>">
                    <i data-lucide="home" class="nav-icon"></i>
                </a>
            </li>
            <li>
                <a href="/search" class="<#if currentUrl?starts_with("/search")>active-nav</#if>">
                    <i data-lucide="search" class="nav-icon"></i>
                </a>
            </li>
            <li>
                <a href="/create-post">
                    <i data-lucide="plus-circle" class="nav-icon"></i>
                </a>
            </li>
            <li>
                <a href="/favorites" class="<#if currentUrl?starts_with("/favorites")>active-nav</#if>">
                    <i data-lucide="heart" class="nav-icon"></i>
                </a>
            </li>
            <li>
                <a href="${myProfileUrl}" class="<#if currentUrl?starts_with("/user/profile")>active-nav</#if>">
                    <i data-lucide="user" class="nav-icon"></i>
                </a>
            </li>
        </ul>
    </nav>

    <!-- Main Content -->
    <div class="content-with-sidebar">
        <main class="container mx-auto px-4 py-5">
            <#nested>
        </main>

        <div class="py-4 px-4 bg-blue-600 text-white text-center mt-10">
            <div class="container mx-auto">
                Copyright © 2025. All rights reserved. Suslike.
            </div>
        </div>
    </div>

    <script>
        // Initialize Lucide icons
        lucide.createIcons();

        // Additional JavaScript for active link detection in case server-side detection fails
        document.addEventListener('DOMContentLoaded', function() {
            const currentPath = window.location.pathname;
            const navLinks = document.querySelectorAll('nav a');

            navLinks.forEach(link => {
                const href = link.getAttribute('href');
                if (currentPath === href ||
                    (href !== '/' && currentPath.startsWith(href))) {
                    link.classList.add('active-nav');
                }
            });
        });
    </script>
    </body>
    </html>
</#macro>