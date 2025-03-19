<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Search</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body class="bg-gray-50 min-h-screen">

<div class="flex justify-center w-full min-h-[calc(100vh-120px)] py-5">
    <div class="flex flex-col w-full max-w-2xl px-4">
        <header class="text-center font-bold text-xl mb-4">Search</header>

        <main class="flex flex-col h-auto min-h-[500px] rounded-lg bg-white shadow-sm border border-gray-200">
            <form action="/user/search" method="POST" class="m-4">
                <div class="flex items-center p-3 bg-gray-50 rounded-lg border border-gray-200">
                    <i data-lucide="search" class="w-5 h-5 text-gray-500 mr-2"></i>

                    <input type="text"
                           name="search"
                           placeholder="Type username or email..."
                           class="w-full bg-transparent outline-none"
                           onkeyup="performSearch(this.value)" />

                    <button type="button" onclick="toggleFilters()">
                        <i data-lucide="sliders-horizontal" class="w-5 h-5 text-gray-500"></i>
                    </button>
                </div>

                <div id="filters" class="hidden mt-3 p-3 bg-gray-50 rounded-lg border border-gray-200">
                    <div class="text-sm font-medium mb-2">Filter by:</div>
                    <div class="flex flex-wrap gap-2">
                        <label class="flex items-center">
                            <input type="checkbox" name="filterUsername" class="mr-1" />
                            Username
                        </label>
                        <label class="flex items-center">
                            <input type="checkbox" name="filterEmail" class="mr-1" />
                            Email
                        </label>
                    </div>
                </div>
            </form>

            <div id="loading" class="hidden flex justify-center items-center py-10">
                <div class="animate-spin rounded-full h-10 w-10 border-b-2 border-gray-900"></div>
            </div>

            <div id="searchResults" class="flex flex-col">
                <#if users?? && users?size gt 0>
                    <#list users as user>
                        <div class="flex justify-between items-center p-5 <#if user?index != 0>border-t border-gray-200</#if>">
                            <#if user.profile_picture_url?? || user.avatar??>
                                <img src="${user.profile_picture_url?? ? user.profile_picture_url : '/api/post/${user.avatar}'}"
                                     alt="${user.username}'s avatar"
                                     class="w-12 h-12 mr-4 rounded-full object-cover border border-gray-300" />
                            <#else>
                                <img src="https://images.squarespace-cdn.com/content/v1/54b7b93ce4b0a3e130d5d232/1519987020970-8IQ7F6Z61LLBCX85A65S/icon.png?format=500w"
                                     alt="${user.username}'s avatar"
                                     class="w-12 h-12 mr-4 rounded-full object-cover border border-gray-300" />
                            </#if>

                            <div class="flex-grow">
                                <div class="font-bold">
                                    <a href="/user/profile/${user.username}">${user.username}</a>
                                </div>
                                <#if user.description??>
                                    <div class="text-sm text-gray-600">${user.description}</div>
                                </#if>
                            </div>

                            <div>
                                <button onclick="subscribeToUser('${user.username}')"
                                        class="bg-amber-50 text-gray-700 px-4 py-2 rounded-2xl border border-gray-200 hover:bg-amber-100 transition-colors">
                                    Subscribe
                                </button>
                            </div>
                        </div>
                    </#list>
                <#elseif searchPerformed?? && searchPerformed>
                    <div class="flex justify-center items-center py-10 text-gray-500">
                        No users found matching your search.
                    </div>
                </#if>
            </div>
        </main>
    </div>
</div>

<div class="fixed left-0 bottom-0 w-full py-4 px-4 bg-blue-600 text-white text-center">
    <div class="container mx-auto">
        Copyright © 2025. All rights reserved. Suslike.
    </div>
</div>

<script>
    lucide.createIcons();

    let searchTimeout;

    function performSearch(query) {
        const loadingIndicator = document.getElementById('loading');
        const searchResults = document.getElementById('searchResults');

        clearTimeout(searchTimeout);

        if (query.length < 2) {
            return;
        }

        searchTimeout = setTimeout(async () => {
            try {
                loadingIndicator.classList.remove('hidden');

                const response = await fetch(`/api/search-users/${encodeURIComponent(query)}`);

                if (response.ok) {
                    window.location.href = `/user/search?query=${encodeURIComponent(query)}`;
                } else {
                    throw new Error('Search failed');
                }
            } catch (error) {
                console.error('Error searching:', error);
            } finally {
                loadingIndicator.classList.add('hidden');
            }
        }, 500);
    }

    function toggleFilters() {
        const filters = document.getElementById('filters');
        filters.classList.toggle('hidden');
    }

    function subscribeToUser(username) {
        fetch(`/api/subscribe/${username}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            }
        })
            .then(response => {
                if (response.ok) {
                    alert(`Successfully subscribed to ${username}`);
                } else {
                    throw new Error('Failed to subscribe');
                }
            })
            .catch(error => {
                console.error('Error subscribing:', error);
                alert('Failed to subscribe. Please try again later.');
            });
    }
</script>
</body>
</html>