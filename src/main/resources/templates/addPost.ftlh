<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Add Post</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body class="bg-gray-50 min-h-screen">
<div class="container mx-auto px-4 py-10">
    <div class="max-w-md mx-auto bg-white p-6 rounded-lg shadow-sm border border-gray-200">
        <h1 class="text-center text-4xl mb-6">
            <b class="text-red-500">SUS</b>like
        </h1>

        <form action="/posts" method="POST" enctype="multipart/form-data" class="post-form">
            <div class="mb-4">
                    <textarea
                            name="text"
                            placeholder="Write something..."
                            class="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 min-h-[120px]"
                    >
                    </textarea>
            </div>

            <div class="mb-4">
                <label for="imageUpload" class="inline-flex items-center gap-2 cursor-pointer px-3 py-2 bg-gray-50 hover:bg-gray-100 text-gray-700 rounded-lg border border-gray-200 transition-colors">
                    <i data-lucide="image-plus" class="w-5 h-5"></i>
                    <span>Add Image</span>
                    <input
                            type="file"
                            id="mFile"
                            name="mFile"
                            class="hidden"
                            onchange="previewImage(this)"
                    >
                </label>

                <div id="imagePreview" class="mt-3 hidden">
                    <img id="preview" src="#" alt="Preview" class="w-40 h-40 object-cover rounded-lg">
                </div>
            </div>

            <#if error??>
                <div class="text-red-500 mb-4">${error}</div>
            </#if>

            <#if success??>
                <div class="text-green-500 mb-4">${success}</div>
            </#if>

            <div class="text-center">
                <button
                        type="submit"
                        class="bg-amber-50 text-gray-700 px-6 py-2 border rounded-2xl cursor-pointer hover:text-black hover:bg-amber-100 transition-colors"
                >
                    Post
                </button>
            </div>
        </form>
    </div>
</div>

<div class="fixed left-0 bottom-0 w-full py-4 px-4 bg-blue-600 text-white text-center">
    <div class="container mx-auto">
        Copyright © 2025. All rights reserved. Suslike.
    </div>
</div>

<script>
    // Initialize Lucide icons
    lucide.createIcons();

    // Image preview functionality
    function previewImage(input) {
        const preview = document.getElementById('preview');
        const previewDiv = document.getElementById('imagePreview');

        if (input.files && input.files[0]) {
            const reader = new FileReader();

            reader.onload = function(e) {
                preview.src = e.target.result;
                previewDiv.classList.remove('hidden');
            }

            reader.readAsDataURL(input.files[0]);
        } else {
            preview.src = '';
            previewDiv.classList.add('hidden');
        }
    }
</script>
</body>
</html>