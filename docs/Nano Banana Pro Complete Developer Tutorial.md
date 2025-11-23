# Nano Banana Pro: Complete Developer Tutorial

You loved [Nano-Banana](https://dev.to/googleai/how-to-build-with-nano-banana-complete-developer-tutorial-646)? Created figurine images of all your friends and ghost faces behind all your foes? Here now comes the not-so-nano "[Gemini 3 Pro Image](https://deepmind.google/models/gemini-image/pro/)" model, that you will all prefer calling **Nano Banana Pro**!

While the Flash model (Nano Banana) brought speed and affordability, the Pro version introduces "thinking" capabilities, search grounding, and high-fidelity 4K output. It's time to go bananas with complex creative tasks!

This guide will walk you through the advanced features of Nano Banana Pro using the [Gemini Developer API](https://ai.google.dev/).

This guide will cover:

1.  Using Nano Banana Pro in Google AI Studio
2.  Project setup
3.  Initialize the Client
4.  Basic Generation (The Classics)
5.  The "Thinking" Process
6.  Search Grounding
7.  High-Resolution 4K Generation
8.  Multilingual Capabilities
9.  Advanced Image Mixing
10.  Pro-Exclusive Demos

> **Note**: for an interactive version of this post, checkout the [python cookbook](https://colab.sandbox.google.com/github/google-gemini/cookbook/blob/main/quickstarts/Get_Started_Nano_Banana.ipynb) or the AI Studio's [Javascript Notebook](https://ai.studio/apps/bundled/get_started_image_out?fullscreenApplet=true).

## [](https://dev.to/googleai/introducing-nano-banana-pro-complete-developer-tutorial-5fc8#1-using-nano-banana-pro-in-google-ai-studio)1) Using Nano Banana Pro in Google AI Studio

While end-users can access Nano Banana Pro in the [Gemini app](https://gemini.google.com/), the best environment for developers to prototype and test prompts is [Google AI Studio](https://aistudio.google.com/banana-pro). AI Studio is a playground to experiment with all available AI models before writing any code, and it's also the entry point for building with the Gemini API.

You can use Nano Banana Pro within AI Studio. To get started, go to [aistudio.google.com](https://aistudio.google.com/banana-pro), sign in with your Google account, and select **Nano Banana Pro** (Gemini 3 Pro Image) from the model picker.

Contrary to Nano-Banana, the pro version **doesn't have a free tier**, which means you need to select an API key with billing enabled (see "project setup" section below).

[![Get started with Nano Banana Pro on AI Studio](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fidqeymcwrtjlk416q2ag.png)](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fidqeymcwrtjlk416q2ag.png)

> **Tip**: You can also vibe code Nano Banana web apps directly in AI Studio at [ai.studio/apps](https://ai.studio/apps), or explore the code and remix one of the [existing apps](https://aistudio.google.com/apps?source=showcase&showcaseTag=nano-banana).

## [](https://dev.to/googleai/introducing-nano-banana-pro-complete-developer-tutorial-5fc8#2-project-setup)2) Project setup

To follow this guide, you will need the following:

-   An API key from [Google AI Studio](https://aistudio.google.com/).
-   Billing set up for your project.
-   The Google Gen AI SDK for [Python](https://github.com/googleapis/python-genai) or [JavaScript/TypeScript](https://github.com/googleapis/js-genai).

If you already are a hardcore Gemini API user with all of that, great! just skip this section and move to the next one. Otherwise, here's how to get started:

### [](https://dev.to/googleai/introducing-nano-banana-pro-complete-developer-tutorial-5fc8#step-a-get-your-api-key)Step A: Get your API Key

When you first log in on AI Studio, a Google Cloud project and an API key should be automatically created.

Open the [API key management screen](https://aistudio.google.com/api-keys) and click on the "copy" icon to copy your API key.

[![Copy your API key](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fkwglctk5jiunm7gdi207.png)](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fkwglctk5jiunm7gdi207.png)

### [](https://dev.to/googleai/introducing-nano-banana-pro-complete-developer-tutorial-5fc8#step-b-enable-billing)Step B: Enable Billing

Since Nano Banana Pro doesn't have a free tier. You must enable billing on your Google Cloud project.

In the [API key management screen](https://aistudio.google.com/projects), click **Set up billing** next to your project and follow the on-screen instructions.

[![Set up billing](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fn7wi4ygjj4utb8lrntsl.png)](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fn7wi4ygjj4utb8lrntsl.png)

#### [](https://dev.to/googleai/introducing-nano-banana-pro-complete-developer-tutorial-5fc8#how-much-does-nano-banana-pro-cost)How much does Nano Banana Pro cost?

Image generation with Nano Banana Pro is more expensive than the Flash version, especially for 4K images. At the time this post is published, a 1K or 2K image costs **$0.134**, while a 4K one costs **$0.24** (plus the token cost of the input and the text output).

Check the [pricing](https://ai.google.dev/gemini-api/docs/pricing#gemini-3-pro-image-preview) in the documentation for the latest details.

> **Pro tip:** To save 50% on your generation costs, you can use the [Batch API](https://ai.google.dev/gemini-api/docs/image-generation?batch=file#batch-api). In exchange you might have to wait up to 24h before getting your images.

### [](https://dev.to/googleai/introducing-nano-banana-pro-complete-developer-tutorial-5fc8#step-c-install-the-sdk)Step C: Install the SDK

Choose the SDK for your preferred language.

**Python:**  

```
pip <span data-best-reader-view-id="1-1-32-1-1-1">install</span> <span data-best-reader-view-id="1-1-32-1-1-2">-U</span> google-genai
<span data-best-reader-view-id="1-1-32-1-1-3"># Install the Pillow library for image manipulation</span>
pip <span data-best-reader-view-id="1-1-32-1-1-4">install </span>Pillow
```

**JavaScript / TypeScript:**  

```
npm <span data-best-reader-view-id="1-1-34-1-1-1">install</span> @google/genai
```

> **Note**: The following examples use the Python SDK for demonstration. Equivalent code snippets to use Nano Banana in JavaScript are provided in this **[JS Notebook](https://ai.studio/apps/bundled/get_started_image_out?fullscreenApplet=true)**.

## [](https://dev.to/googleai/introducing-nano-banana-pro-complete-developer-tutorial-5fc8#3-initialize-the-client)3) Initialize the Client

To use the Pro model, you'll need to use the **`gemini-3-pro-image-preview`** model ID.  

```
<span data-best-reader-view-id="1-1-38-1-1-1">from</span> <span data-best-reader-view-id="1-1-38-1-1-2">google</span> <span data-best-reader-view-id="1-1-38-1-1-3">import</span> <span data-best-reader-view-id="1-1-38-1-1-4">genai</span>
<span data-best-reader-view-id="1-1-38-1-1-5">from</span> <span data-best-reader-view-id="1-1-38-1-1-6">google.genai</span> <span data-best-reader-view-id="1-1-38-1-1-7">import</span> <span data-best-reader-view-id="1-1-38-1-1-8">types</span>

<span data-best-reader-view-id="1-1-38-1-1-9"># Initialize the client
</span><span data-best-reader-view-id="1-1-38-1-1-10">client</span> <span data-best-reader-view-id="1-1-38-1-1-11">=</span> <span data-best-reader-view-id="1-1-38-1-1-12">genai</span><span data-best-reader-view-id="1-1-38-1-1-13">.</span><span data-best-reader-view-id="1-1-38-1-1-14">Client</span><span data-best-reader-view-id="1-1-38-1-1-15">(</span><span data-best-reader-view-id="1-1-38-1-1-16">api_key</span><span data-best-reader-view-id="1-1-38-1-1-17">=</span><span data-best-reader-view-id="1-1-38-1-1-18">"</span><span data-best-reader-view-id="1-1-38-1-1-19">YOUR_API_KEY</span><span data-best-reader-view-id="1-1-38-1-1-20">"</span><span data-best-reader-view-id="1-1-38-1-1-21">)</span>

<span data-best-reader-view-id="1-1-38-1-1-22"># Set the model ID
</span><span data-best-reader-view-id="1-1-38-1-1-23">PRO_MODEL_ID</span> <span data-best-reader-view-id="1-1-38-1-1-24">=</span> <span data-best-reader-view-id="1-1-38-1-1-25">"</span><span data-best-reader-view-id="1-1-38-1-1-26">gemini-3-pro-image-preview</span><span data-best-reader-view-id="1-1-38-1-1-27">"</span>
```

## [](https://dev.to/googleai/introducing-nano-banana-pro-complete-developer-tutorial-5fc8#4-basic-generation-the-classics)4) Basic Generation (The Classics)

Before we get into the fancy stuff, let's look at a standard generation. You can control the output using `response_modalities` (to get text and images or only images) and `aspect_ratio`.  

```
<span data-best-reader-view-id="1-1-41-1-1-1">prompt</span> <span data-best-reader-view-id="1-1-41-1-1-2">=</span> <span data-best-reader-view-id="1-1-41-1-1-3">"</span><span data-best-reader-view-id="1-1-41-1-1-4">Create a photorealistic image of a siamese cat with a green left eye and a blue right one</span><span data-best-reader-view-id="1-1-41-1-1-5">"</span>
<span data-best-reader-view-id="1-1-41-1-1-6">aspect_ratio</span> <span data-best-reader-view-id="1-1-41-1-1-7">=</span> <span data-best-reader-view-id="1-1-41-1-1-8">"</span><span data-best-reader-view-id="1-1-41-1-1-9">16:9</span><span data-best-reader-view-id="1-1-41-1-1-10">"</span> <span data-best-reader-view-id="1-1-41-1-1-11"># "1:1","2:3","3:2","3:4","4:3","4:5","5:4","9:16","16:9" or "21:9"
</span>
<span data-best-reader-view-id="1-1-41-1-1-12">response</span> <span data-best-reader-view-id="1-1-41-1-1-13">=</span> <span data-best-reader-view-id="1-1-41-1-1-14">client</span><span data-best-reader-view-id="1-1-41-1-1-15">.</span><span data-best-reader-view-id="1-1-41-1-1-16">models</span><span data-best-reader-view-id="1-1-41-1-1-17">.</span><span data-best-reader-view-id="1-1-41-1-1-18">generate_content</span><span data-best-reader-view-id="1-1-41-1-1-19">(</span>
    <span data-best-reader-view-id="1-1-41-1-1-20">model</span><span data-best-reader-view-id="1-1-41-1-1-21">=</span><span data-best-reader-view-id="1-1-41-1-1-22">PRO_MODEL_ID</span><span data-best-reader-view-id="1-1-41-1-1-23">,</span>
    <span data-best-reader-view-id="1-1-41-1-1-24">contents</span><span data-best-reader-view-id="1-1-41-1-1-25">=</span><span data-best-reader-view-id="1-1-41-1-1-26">prompt</span><span data-best-reader-view-id="1-1-41-1-1-27">,</span>
    <span data-best-reader-view-id="1-1-41-1-1-28">config</span><span data-best-reader-view-id="1-1-41-1-1-29">=</span><span data-best-reader-view-id="1-1-41-1-1-30">types</span><span data-best-reader-view-id="1-1-41-1-1-31">.</span><span data-best-reader-view-id="1-1-41-1-1-32">GenerateContentConfig</span><span data-best-reader-view-id="1-1-41-1-1-33">(</span>
        <span data-best-reader-view-id="1-1-41-1-1-34">response_modalities</span><span data-best-reader-view-id="1-1-41-1-1-35">=</span><span data-best-reader-view-id="1-1-41-1-1-36">[</span><span data-best-reader-view-id="1-1-41-1-1-37">'</span><span data-best-reader-view-id="1-1-41-1-1-38">Text</span><span data-best-reader-view-id="1-1-41-1-1-39">'</span><span data-best-reader-view-id="1-1-41-1-1-40">,</span> <span data-best-reader-view-id="1-1-41-1-1-41">'</span><span data-best-reader-view-id="1-1-41-1-1-42">Image</span><span data-best-reader-view-id="1-1-41-1-1-43">'</span><span data-best-reader-view-id="1-1-41-1-1-44">],</span> <span data-best-reader-view-id="1-1-41-1-1-45"># Or just ['Image']
</span>        <span data-best-reader-view-id="1-1-41-1-1-46">image_config</span><span data-best-reader-view-id="1-1-41-1-1-47">=</span><span data-best-reader-view-id="1-1-41-1-1-48">types</span><span data-best-reader-view-id="1-1-41-1-1-49">.</span><span data-best-reader-view-id="1-1-41-1-1-50">ImageConfig</span><span data-best-reader-view-id="1-1-41-1-1-51">(</span>
            <span data-best-reader-view-id="1-1-41-1-1-52">aspect_ratio</span><span data-best-reader-view-id="1-1-41-1-1-53">=</span><span data-best-reader-view-id="1-1-41-1-1-54">aspect_ratio</span><span data-best-reader-view-id="1-1-41-1-1-55">,</span>
        <span data-best-reader-view-id="1-1-41-1-1-56">)</span>
    <span data-best-reader-view-id="1-1-41-1-1-57">)</span>
<span data-best-reader-view-id="1-1-41-1-1-58">)</span>

<span data-best-reader-view-id="1-1-41-1-1-59"># Save the image
</span><span data-best-reader-view-id="1-1-41-1-1-60">for</span> <span data-best-reader-view-id="1-1-41-1-1-61">part</span> <span data-best-reader-view-id="1-1-41-1-1-62">in</span> <span data-best-reader-view-id="1-1-41-1-1-63">response</span><span data-best-reader-view-id="1-1-41-1-1-64">.</span><span data-best-reader-view-id="1-1-41-1-1-65">parts</span><span data-best-reader-view-id="1-1-41-1-1-66">:</span>
    <span data-best-reader-view-id="1-1-41-1-1-67">if</span> <span data-best-reader-view-id="1-1-41-1-1-68">image</span><span data-best-reader-view-id="1-1-41-1-1-69">:</span><span data-best-reader-view-id="1-1-41-1-1-70">=</span> <span data-best-reader-view-id="1-1-41-1-1-71">part</span><span data-best-reader-view-id="1-1-41-1-1-72">.</span><span data-best-reader-view-id="1-1-41-1-1-73">as_image</span><span data-best-reader-view-id="1-1-41-1-1-74">():</span>
        <span data-best-reader-view-id="1-1-41-1-1-75">image</span><span data-best-reader-view-id="1-1-41-1-1-76">.</span><span data-best-reader-view-id="1-1-41-1-1-77">save</span><span data-best-reader-view-id="1-1-41-1-1-78">(</span><span data-best-reader-view-id="1-1-41-1-1-79">"</span><span data-best-reader-view-id="1-1-41-1-1-80">cat.png</span><span data-best-reader-view-id="1-1-41-1-1-81">"</span><span data-best-reader-view-id="1-1-41-1-1-82">)</span>
```

[![Siamese cat](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fqrqb18ptavkufaqav7o5.png)](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fqrqb18ptavkufaqav7o5.png)

Chat mode is also an option (it's actually what I would recommend for multi-turn editing). Check the 8th example, "Polyglot Banana", for an example.

## [](https://dev.to/googleai/introducing-nano-banana-pro-complete-developer-tutorial-5fc8#5-the-thinking-process-its-alive)5) The "Thinking" Process (It's alive!)

Nano Banana Pro isn't just drawing; it's _thinking_. This means it can reason through your most complex, twisted prompts before generating an image. And the best part? You can peek into its brain!

To enable this, set `include_thoughts=True` in the `thinking_config`.  

```
<span data-best-reader-view-id="1-1-47-1-1-1">prompt</span> <span data-best-reader-view-id="1-1-47-1-1-2">=</span> <span data-best-reader-view-id="1-1-47-1-1-3">"</span><span data-best-reader-view-id="1-1-47-1-1-4">Create an unusual but realistic image that might go viral</span><span data-best-reader-view-id="1-1-47-1-1-5">"</span>
<span data-best-reader-view-id="1-1-47-1-1-6">aspect_ratio</span> <span data-best-reader-view-id="1-1-47-1-1-7">=</span> <span data-best-reader-view-id="1-1-47-1-1-8">"</span><span data-best-reader-view-id="1-1-47-1-1-9">16:9</span><span data-best-reader-view-id="1-1-47-1-1-10">"</span>

<span data-best-reader-view-id="1-1-47-1-1-11">response</span> <span data-best-reader-view-id="1-1-47-1-1-12">=</span> <span data-best-reader-view-id="1-1-47-1-1-13">client</span><span data-best-reader-view-id="1-1-47-1-1-14">.</span><span data-best-reader-view-id="1-1-47-1-1-15">models</span><span data-best-reader-view-id="1-1-47-1-1-16">.</span><span data-best-reader-view-id="1-1-47-1-1-17">generate_content</span><span data-best-reader-view-id="1-1-47-1-1-18">(</span>
    <span data-best-reader-view-id="1-1-47-1-1-19">model</span><span data-best-reader-view-id="1-1-47-1-1-20">=</span><span data-best-reader-view-id="1-1-47-1-1-21">PRO_MODEL_ID</span><span data-best-reader-view-id="1-1-47-1-1-22">,</span>
    <span data-best-reader-view-id="1-1-47-1-1-23">contents</span><span data-best-reader-view-id="1-1-47-1-1-24">=</span><span data-best-reader-view-id="1-1-47-1-1-25">prompt</span><span data-best-reader-view-id="1-1-47-1-1-26">,</span>
    <span data-best-reader-view-id="1-1-47-1-1-27">config</span><span data-best-reader-view-id="1-1-47-1-1-28">=</span><span data-best-reader-view-id="1-1-47-1-1-29">types</span><span data-best-reader-view-id="1-1-47-1-1-30">.</span><span data-best-reader-view-id="1-1-47-1-1-31">GenerateContentConfig</span><span data-best-reader-view-id="1-1-47-1-1-32">(</span>
        <span data-best-reader-view-id="1-1-47-1-1-33">response_modalities</span><span data-best-reader-view-id="1-1-47-1-1-34">=</span><span data-best-reader-view-id="1-1-47-1-1-35">[</span><span data-best-reader-view-id="1-1-47-1-1-36">'</span><span data-best-reader-view-id="1-1-47-1-1-37">Text</span><span data-best-reader-view-id="1-1-47-1-1-38">'</span><span data-best-reader-view-id="1-1-47-1-1-39">,</span> <span data-best-reader-view-id="1-1-47-1-1-40">'</span><span data-best-reader-view-id="1-1-47-1-1-41">Image</span><span data-best-reader-view-id="1-1-47-1-1-42">'</span><span data-best-reader-view-id="1-1-47-1-1-43">],</span>
        <span data-best-reader-view-id="1-1-47-1-1-44">image_config</span><span data-best-reader-view-id="1-1-47-1-1-45">=</span><span data-best-reader-view-id="1-1-47-1-1-46">types</span><span data-best-reader-view-id="1-1-47-1-1-47">.</span><span data-best-reader-view-id="1-1-47-1-1-48">ImageConfig</span><span data-best-reader-view-id="1-1-47-1-1-49">(</span>
            <span data-best-reader-view-id="1-1-47-1-1-50">aspect_ratio</span><span data-best-reader-view-id="1-1-47-1-1-51">=</span><span data-best-reader-view-id="1-1-47-1-1-52">aspect_ratio</span><span data-best-reader-view-id="1-1-47-1-1-53">,</span>
        <span data-best-reader-view-id="1-1-47-1-1-54">),</span>
        <span data-best-reader-view-id="1-1-47-1-1-55">thinking_config</span><span data-best-reader-view-id="1-1-47-1-1-56">=</span><span data-best-reader-view-id="1-1-47-1-1-57">types</span><span data-best-reader-view-id="1-1-47-1-1-58">.</span><span data-best-reader-view-id="1-1-47-1-1-59">ThinkingConfig</span><span data-best-reader-view-id="1-1-47-1-1-60">(</span>
            <span data-best-reader-view-id="1-1-47-1-1-61">include_thoughts</span><span data-best-reader-view-id="1-1-47-1-1-62">=</span><span data-best-reader-view-id="1-1-47-1-1-63">True</span> <span data-best-reader-view-id="1-1-47-1-1-64"># Enable thoughts
</span>        <span data-best-reader-view-id="1-1-47-1-1-65">)</span>
    <span data-best-reader-view-id="1-1-47-1-1-66">)</span>
<span data-best-reader-view-id="1-1-47-1-1-67">)</span>

<span data-best-reader-view-id="1-1-47-1-1-68"># Save the image and thoughts
</span><span data-best-reader-view-id="1-1-47-1-1-69">for</span> <span data-best-reader-view-id="1-1-47-1-1-70">part</span> <span data-best-reader-view-id="1-1-47-1-1-71">in</span> <span data-best-reader-view-id="1-1-47-1-1-72">response</span><span data-best-reader-view-id="1-1-47-1-1-73">.</span><span data-best-reader-view-id="1-1-47-1-1-74">parts</span><span data-best-reader-view-id="1-1-47-1-1-75">:</span>
  <span data-best-reader-view-id="1-1-47-1-1-76">if</span> <span data-best-reader-view-id="1-1-47-1-1-77">part</span><span data-best-reader-view-id="1-1-47-1-1-78">.</span><span data-best-reader-view-id="1-1-47-1-1-79">thought</span><span data-best-reader-view-id="1-1-47-1-1-80">:</span>
    <span data-best-reader-view-id="1-1-47-1-1-81">print</span><span data-best-reader-view-id="1-1-47-1-1-82">(</span><span data-best-reader-view-id="1-1-47-1-1-83">f</span><span data-best-reader-view-id="1-1-47-1-1-84">"</span><span data-best-reader-view-id="1-1-47-1-1-85">Thought: </span><span data-best-reader-view-id="1-1-47-1-1-86">{</span><span data-best-reader-view-id="1-1-47-1-1-87">part</span><span data-best-reader-view-id="1-1-47-1-1-88">.</span><span data-best-reader-view-id="1-1-47-1-1-89">text</span><span data-best-reader-view-id="1-1-47-1-1-90">}</span><span data-best-reader-view-id="1-1-47-1-1-91">"</span><span data-best-reader-view-id="1-1-47-1-1-92">)</span>
  <span data-best-reader-view-id="1-1-47-1-1-93">elif</span> <span data-best-reader-view-id="1-1-47-1-1-94">image</span><span data-best-reader-view-id="1-1-47-1-1-95">:</span><span data-best-reader-view-id="1-1-47-1-1-96">=</span> <span data-best-reader-view-id="1-1-47-1-1-97">part</span><span data-best-reader-view-id="1-1-47-1-1-98">.</span><span data-best-reader-view-id="1-1-47-1-1-99">as_image</span><span data-best-reader-view-id="1-1-47-1-1-100">():</span>
    <span data-best-reader-view-id="1-1-47-1-1-101">image</span><span data-best-reader-view-id="1-1-47-1-1-102">.</span><span data-best-reader-view-id="1-1-47-1-1-103">save</span><span data-best-reader-view-id="1-1-47-1-1-104">(</span><span data-best-reader-view-id="1-1-47-1-1-105">"</span><span data-best-reader-view-id="1-1-47-1-1-106">viral.png</span><span data-best-reader-view-id="1-1-47-1-1-107">"</span><span data-best-reader-view-id="1-1-47-1-1-108">)</span>
```

And you should get something like:  

```
<span data-best-reader-view-id="1-1-49-1-1-1">## Imagining Llama Commuters</span>

I'm focusing on the llamas now. The goal is to capture them as
daily commuters on a bustling bus in La Paz, Bolivia. My plan
involves a vintage bus crammed with amused passengers. The image
will highlight details like one llama looking out the window,
another interacting with a passenger, all while people take
photos.

[IMAGE]

<span data-best-reader-view-id="1-1-49-1-1-2">## Visualizing the Concept</span>

I'm now fully immersed in the requested scenario. My primary
focus is on the "unusual yet realistic" aspects. The scene is
starting to take shape with the key elements established.
```

[![Viral image](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fmi6pn0b3tuqnm37o85n8.jpg)](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fmi6pn0b3tuqnm37o85n8.jpg)

This transparency helps you understand how the model interpreted your request. It's like having a conversation with your artist!

## [](https://dev.to/googleai/introducing-nano-banana-pro-complete-developer-tutorial-5fc8#6-search-grounding-realtime-magic)6) Search Grounding (Real-time magic)

One of the most game-changing features is **Search Grounding**. Nano Banana Pro isn't stuck in the past; it can access real-time data from Google Search to generate accurate, up-to-date images. Want the weather? You got it.

For example, you can ask it to visualize the _current_ weather forecast:  

```
<span data-best-reader-view-id="1-1-55-1-1-1">prompt</span> <span data-best-reader-view-id="1-1-55-1-1-2">=</span> <span data-best-reader-view-id="1-1-55-1-1-3">"</span><span data-best-reader-view-id="1-1-55-1-1-4">Visualize the current weather forecast for the next 5 days in Tokyo as a clean, modern weather chart. add a visual on what i should wear each day</span><span data-best-reader-view-id="1-1-55-1-1-5">"</span>

<span data-best-reader-view-id="1-1-55-1-1-6">response</span> <span data-best-reader-view-id="1-1-55-1-1-7">=</span> <span data-best-reader-view-id="1-1-55-1-1-8">client</span><span data-best-reader-view-id="1-1-55-1-1-9">.</span><span data-best-reader-view-id="1-1-55-1-1-10">models</span><span data-best-reader-view-id="1-1-55-1-1-11">.</span><span data-best-reader-view-id="1-1-55-1-1-12">generate_content</span><span data-best-reader-view-id="1-1-55-1-1-13">(</span>
    <span data-best-reader-view-id="1-1-55-1-1-14">model</span><span data-best-reader-view-id="1-1-55-1-1-15">=</span><span data-best-reader-view-id="1-1-55-1-1-16">PRO_MODEL_ID</span><span data-best-reader-view-id="1-1-55-1-1-17">,</span>
    <span data-best-reader-view-id="1-1-55-1-1-18">contents</span><span data-best-reader-view-id="1-1-55-1-1-19">=</span><span data-best-reader-view-id="1-1-55-1-1-20">prompt</span><span data-best-reader-view-id="1-1-55-1-1-21">,</span>
    <span data-best-reader-view-id="1-1-55-1-1-22">config</span><span data-best-reader-view-id="1-1-55-1-1-23">=</span><span data-best-reader-view-id="1-1-55-1-1-24">types</span><span data-best-reader-view-id="1-1-55-1-1-25">.</span><span data-best-reader-view-id="1-1-55-1-1-26">GenerateContentConfig</span><span data-best-reader-view-id="1-1-55-1-1-27">(</span>
        <span data-best-reader-view-id="1-1-55-1-1-28">response_modalities</span><span data-best-reader-view-id="1-1-55-1-1-29">=</span><span data-best-reader-view-id="1-1-55-1-1-30">[</span><span data-best-reader-view-id="1-1-55-1-1-31">'</span><span data-best-reader-view-id="1-1-55-1-1-32">Text</span><span data-best-reader-view-id="1-1-55-1-1-33">'</span><span data-best-reader-view-id="1-1-55-1-1-34">,</span> <span data-best-reader-view-id="1-1-55-1-1-35">'</span><span data-best-reader-view-id="1-1-55-1-1-36">Image</span><span data-best-reader-view-id="1-1-55-1-1-37">'</span><span data-best-reader-view-id="1-1-55-1-1-38">],</span>
        <span data-best-reader-view-id="1-1-55-1-1-39">image_config</span><span data-best-reader-view-id="1-1-55-1-1-40">=</span><span data-best-reader-view-id="1-1-55-1-1-41">types</span><span data-best-reader-view-id="1-1-55-1-1-42">.</span><span data-best-reader-view-id="1-1-55-1-1-43">ImageConfig</span><span data-best-reader-view-id="1-1-55-1-1-44">(</span>
            <span data-best-reader-view-id="1-1-55-1-1-45">aspect_ratio</span><span data-best-reader-view-id="1-1-55-1-1-46">=</span><span data-best-reader-view-id="1-1-55-1-1-47">"</span><span data-best-reader-view-id="1-1-55-1-1-48">16:9</span><span data-best-reader-view-id="1-1-55-1-1-49">"</span><span data-best-reader-view-id="1-1-55-1-1-50">,</span>
        <span data-best-reader-view-id="1-1-55-1-1-51">),</span>
        <span data-best-reader-view-id="1-1-55-1-1-52">tools</span><span data-best-reader-view-id="1-1-55-1-1-53">=</span><span data-best-reader-view-id="1-1-55-1-1-54">[{</span><span data-best-reader-view-id="1-1-55-1-1-55">"</span><span data-best-reader-view-id="1-1-55-1-1-56">google_search</span><span data-best-reader-view-id="1-1-55-1-1-57">"</span><span data-best-reader-view-id="1-1-55-1-1-58">:</span> <span data-best-reader-view-id="1-1-55-1-1-59">{}}]</span> <span data-best-reader-view-id="1-1-55-1-1-60"># Enable Google Search
</span>    <span data-best-reader-view-id="1-1-55-1-1-61">)</span>
<span data-best-reader-view-id="1-1-55-1-1-62">)</span>

<span data-best-reader-view-id="1-1-55-1-1-63"># Save the image
</span><span data-best-reader-view-id="1-1-55-1-1-64">for</span> <span data-best-reader-view-id="1-1-55-1-1-65">part</span> <span data-best-reader-view-id="1-1-55-1-1-66">in</span> <span data-best-reader-view-id="1-1-55-1-1-67">response</span><span data-best-reader-view-id="1-1-55-1-1-68">.</span><span data-best-reader-view-id="1-1-55-1-1-69">parts</span><span data-best-reader-view-id="1-1-55-1-1-70">:</span>
    <span data-best-reader-view-id="1-1-55-1-1-71">if</span> <span data-best-reader-view-id="1-1-55-1-1-72">image</span><span data-best-reader-view-id="1-1-55-1-1-73">:</span><span data-best-reader-view-id="1-1-55-1-1-74">=</span> <span data-best-reader-view-id="1-1-55-1-1-75">part</span><span data-best-reader-view-id="1-1-55-1-1-76">.</span><span data-best-reader-view-id="1-1-55-1-1-77">as_image</span><span data-best-reader-view-id="1-1-55-1-1-78">():</span>
        <span data-best-reader-view-id="1-1-55-1-1-79">image</span><span data-best-reader-view-id="1-1-55-1-1-80">.</span><span data-best-reader-view-id="1-1-55-1-1-81">save</span><span data-best-reader-view-id="1-1-55-1-1-82">(</span><span data-best-reader-view-id="1-1-55-1-1-83">"</span><span data-best-reader-view-id="1-1-55-1-1-84">weather.png</span><span data-best-reader-view-id="1-1-55-1-1-85">"</span><span data-best-reader-view-id="1-1-55-1-1-86">)</span>

<span data-best-reader-view-id="1-1-55-1-1-87"># Display sources (you must always do that)
</span><span data-best-reader-view-id="1-1-55-1-1-88">print</span><span data-best-reader-view-id="1-1-55-1-1-89">(</span><span data-best-reader-view-id="1-1-55-1-1-90">response</span><span data-best-reader-view-id="1-1-55-1-1-91">.</span><span data-best-reader-view-id="1-1-55-1-1-92">candidates</span><span data-best-reader-view-id="1-1-55-1-1-93">[</span><span data-best-reader-view-id="1-1-55-1-1-94">0</span><span data-best-reader-view-id="1-1-55-1-1-95">].</span><span data-best-reader-view-id="1-1-55-1-1-96">grounding_metadata</span><span data-best-reader-view-id="1-1-55-1-1-97">.</span><span data-best-reader-view-id="1-1-55-1-1-98">search_entry_point</span><span data-best-reader-view-id="1-1-55-1-1-99">.</span><span data-best-reader-view-id="1-1-55-1-1-100">rendered_content</span><span data-best-reader-view-id="1-1-55-1-1-101">)</span>
```

[![Weather in Tokyo](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fbgg57xg6mvtzk521zslw.jpg)](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fbgg57xg6mvtzk521zslw.jpg)

## [](https://dev.to/googleai/introducing-nano-banana-pro-complete-developer-tutorial-5fc8#7-go-big-or-go-home-4k-generation)7) Go Big or Go Home: 4K Generation

Need print-quality images? Nano Banana Pro supports 4K resolution. Because sometimes, bigger _is_ better.  

```
<span data-best-reader-view-id="1-1-59-1-1-1">prompt</span> <span data-best-reader-view-id="1-1-59-1-1-2">=</span> <span data-best-reader-view-id="1-1-59-1-1-3">"</span><span data-best-reader-view-id="1-1-59-1-1-4">A photo of an oak tree experiencing every season</span><span data-best-reader-view-id="1-1-59-1-1-5">"</span>
<span data-best-reader-view-id="1-1-59-1-1-6">resolution</span> <span data-best-reader-view-id="1-1-59-1-1-7">=</span> <span data-best-reader-view-id="1-1-59-1-1-8">"</span><span data-best-reader-view-id="1-1-59-1-1-9">4K</span><span data-best-reader-view-id="1-1-59-1-1-10">"</span> <span data-best-reader-view-id="1-1-59-1-1-11"># Options: "1K", "2K", "4K", be careful lower case do not work.
</span>
<span data-best-reader-view-id="1-1-59-1-1-12">response</span> <span data-best-reader-view-id="1-1-59-1-1-13">=</span> <span data-best-reader-view-id="1-1-59-1-1-14">client</span><span data-best-reader-view-id="1-1-59-1-1-15">.</span><span data-best-reader-view-id="1-1-59-1-1-16">models</span><span data-best-reader-view-id="1-1-59-1-1-17">.</span><span data-best-reader-view-id="1-1-59-1-1-18">generate_content</span><span data-best-reader-view-id="1-1-59-1-1-19">(</span>
    <span data-best-reader-view-id="1-1-59-1-1-20">model</span><span data-best-reader-view-id="1-1-59-1-1-21">=</span><span data-best-reader-view-id="1-1-59-1-1-22">PRO_MODEL_ID</span><span data-best-reader-view-id="1-1-59-1-1-23">,</span>
    <span data-best-reader-view-id="1-1-59-1-1-24">contents</span><span data-best-reader-view-id="1-1-59-1-1-25">=</span><span data-best-reader-view-id="1-1-59-1-1-26">prompt</span><span data-best-reader-view-id="1-1-59-1-1-27">,</span>
    <span data-best-reader-view-id="1-1-59-1-1-28">config</span><span data-best-reader-view-id="1-1-59-1-1-29">=</span><span data-best-reader-view-id="1-1-59-1-1-30">types</span><span data-best-reader-view-id="1-1-59-1-1-31">.</span><span data-best-reader-view-id="1-1-59-1-1-32">GenerateContentConfig</span><span data-best-reader-view-id="1-1-59-1-1-33">(</span>
        <span data-best-reader-view-id="1-1-59-1-1-34">response_modalities</span><span data-best-reader-view-id="1-1-59-1-1-35">=</span><span data-best-reader-view-id="1-1-59-1-1-36">[</span><span data-best-reader-view-id="1-1-59-1-1-37">'</span><span data-best-reader-view-id="1-1-59-1-1-38">Text</span><span data-best-reader-view-id="1-1-59-1-1-39">'</span><span data-best-reader-view-id="1-1-59-1-1-40">,</span> <span data-best-reader-view-id="1-1-59-1-1-41">'</span><span data-best-reader-view-id="1-1-59-1-1-42">Image</span><span data-best-reader-view-id="1-1-59-1-1-43">'</span><span data-best-reader-view-id="1-1-59-1-1-44">],</span>
        <span data-best-reader-view-id="1-1-59-1-1-45">image_config</span><span data-best-reader-view-id="1-1-59-1-1-46">=</span><span data-best-reader-view-id="1-1-59-1-1-47">types</span><span data-best-reader-view-id="1-1-59-1-1-48">.</span><span data-best-reader-view-id="1-1-59-1-1-49">ImageConfig</span><span data-best-reader-view-id="1-1-59-1-1-50">(</span>
            <span data-best-reader-view-id="1-1-59-1-1-51">aspect_ratio</span><span data-best-reader-view-id="1-1-59-1-1-52">=</span><span data-best-reader-view-id="1-1-59-1-1-53">"</span><span data-best-reader-view-id="1-1-59-1-1-54">1:1</span><span data-best-reader-view-id="1-1-59-1-1-55">"</span><span data-best-reader-view-id="1-1-59-1-1-56">,</span>
            <span data-best-reader-view-id="1-1-59-1-1-57">image_size</span><span data-best-reader-view-id="1-1-59-1-1-58">=</span><span data-best-reader-view-id="1-1-59-1-1-59">resolution</span>
        <span data-best-reader-view-id="1-1-59-1-1-60">)</span>
    <span data-best-reader-view-id="1-1-59-1-1-61">)</span>
<span data-best-reader-view-id="1-1-59-1-1-62">)</span>
```

[![Oak tree experiencing all seasons](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F7d7g9bjm3w1mtu5oa9pr.jpg)](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F7d7g9bjm3w1mtu5oa9pr.jpg)

_Note: 4K generation comes at a higher cost, so use it wisely!_

## [](https://dev.to/googleai/introducing-nano-banana-pro-complete-developer-tutorial-5fc8#8-polyglot-banana-multilingual-capabilities)8) Polyglot Banana (Multilingual Capabilities)

The model can generate and even translate text within images across over a dozen languages. It's basically a universal translator for your eyes.  

```
<span data-best-reader-view-id="1-1-64-1-1-1"># Generate an infographic in Spanish
</span><span data-best-reader-view-id="1-1-64-1-1-2">message</span> <span data-best-reader-view-id="1-1-64-1-1-3">=</span> <span data-best-reader-view-id="1-1-64-1-1-4">"</span><span data-best-reader-view-id="1-1-64-1-1-5">Make an infographic explaining Einstein</span><span data-best-reader-view-id="1-1-64-1-1-6">'</span><span data-best-reader-view-id="1-1-64-1-1-7">s theory of General Relativity suitable for a 6th grader in Spanish</span><span data-best-reader-view-id="1-1-64-1-1-8">"</span>

<span data-best-reader-view-id="1-1-64-1-1-9">response</span> <span data-best-reader-view-id="1-1-64-1-1-10">=</span> <span data-best-reader-view-id="1-1-64-1-1-11">chat</span><span data-best-reader-view-id="1-1-64-1-1-12">.</span><span data-best-reader-view-id="1-1-64-1-1-13">send_message</span><span data-best-reader-view-id="1-1-64-1-1-14">(</span><span data-best-reader-view-id="1-1-64-1-1-15">message</span><span data-best-reader-view-id="1-1-64-1-1-16">,</span>
    <span data-best-reader-view-id="1-1-64-1-1-17">config</span><span data-best-reader-view-id="1-1-64-1-1-18">=</span><span data-best-reader-view-id="1-1-64-1-1-19">types</span><span data-best-reader-view-id="1-1-64-1-1-20">.</span><span data-best-reader-view-id="1-1-64-1-1-21">GenerateContentConfig</span><span data-best-reader-view-id="1-1-64-1-1-22">(</span>
        <span data-best-reader-view-id="1-1-64-1-1-23">image_config</span><span data-best-reader-view-id="1-1-64-1-1-24">=</span><span data-best-reader-view-id="1-1-64-1-1-25">types</span><span data-best-reader-view-id="1-1-64-1-1-26">.</span><span data-best-reader-view-id="1-1-64-1-1-27">ImageConfig</span><span data-best-reader-view-id="1-1-64-1-1-28">(</span><span data-best-reader-view-id="1-1-64-1-1-29">aspect_ratio</span><span data-best-reader-view-id="1-1-64-1-1-30">=</span><span data-best-reader-view-id="1-1-64-1-1-31">"</span><span data-best-reader-view-id="1-1-64-1-1-32">16:9</span><span data-best-reader-view-id="1-1-64-1-1-33">"</span><span data-best-reader-view-id="1-1-64-1-1-34">)</span>
    <span data-best-reader-view-id="1-1-64-1-1-35">)</span>
<span data-best-reader-view-id="1-1-64-1-1-36">)</span>

<span data-best-reader-view-id="1-1-64-1-1-37"># Save the image
</span><span data-best-reader-view-id="1-1-64-1-1-38">for</span> <span data-best-reader-view-id="1-1-64-1-1-39">part</span> <span data-best-reader-view-id="1-1-64-1-1-40">in</span> <span data-best-reader-view-id="1-1-64-1-1-41">response</span><span data-best-reader-view-id="1-1-64-1-1-42">.</span><span data-best-reader-view-id="1-1-64-1-1-43">parts</span><span data-best-reader-view-id="1-1-64-1-1-44">:</span>
    <span data-best-reader-view-id="1-1-64-1-1-45">if</span> <span data-best-reader-view-id="1-1-64-1-1-46">image</span><span data-best-reader-view-id="1-1-64-1-1-47">:</span><span data-best-reader-view-id="1-1-64-1-1-48">=</span> <span data-best-reader-view-id="1-1-64-1-1-49">part</span><span data-best-reader-view-id="1-1-64-1-1-50">.</span><span data-best-reader-view-id="1-1-64-1-1-51">as_image</span><span data-best-reader-view-id="1-1-64-1-1-52">():</span>
        <span data-best-reader-view-id="1-1-64-1-1-53">image</span><span data-best-reader-view-id="1-1-64-1-1-54">.</span><span data-best-reader-view-id="1-1-64-1-1-55">save</span><span data-best-reader-view-id="1-1-64-1-1-56">(</span><span data-best-reader-view-id="1-1-64-1-1-57">"</span><span data-best-reader-view-id="1-1-64-1-1-58">relativity.png</span><span data-best-reader-view-id="1-1-64-1-1-59">"</span><span data-best-reader-view-id="1-1-64-1-1-60">)</span>
```

[![General Relativity in Spanish](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fvw5sj8d1e33wdu0kdxbc.jpg)](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fvw5sj8d1e33wdu0kdxbc.jpg)  

```
<span data-best-reader-view-id="1-1-66-1-1-1"># Translate it to Japanese
</span><span data-best-reader-view-id="1-1-66-1-1-2">message</span> <span data-best-reader-view-id="1-1-66-1-1-3">=</span> <span data-best-reader-view-id="1-1-66-1-1-4">"</span><span data-best-reader-view-id="1-1-66-1-1-5">Translate this infographic in Japanese, keeping everything else the same</span><span data-best-reader-view-id="1-1-66-1-1-6">"</span>
<span data-best-reader-view-id="1-1-66-1-1-7">response</span> <span data-best-reader-view-id="1-1-66-1-1-8">=</span> <span data-best-reader-view-id="1-1-66-1-1-9">chat</span><span data-best-reader-view-id="1-1-66-1-1-10">.</span><span data-best-reader-view-id="1-1-66-1-1-11">send_message</span><span data-best-reader-view-id="1-1-66-1-1-12">(</span><span data-best-reader-view-id="1-1-66-1-1-13">message</span><span data-best-reader-view-id="1-1-66-1-1-14">)</span>

<span data-best-reader-view-id="1-1-66-1-1-15"># Save the image
</span><span data-best-reader-view-id="1-1-66-1-1-16">for</span> <span data-best-reader-view-id="1-1-66-1-1-17">part</span> <span data-best-reader-view-id="1-1-66-1-1-18">in</span> <span data-best-reader-view-id="1-1-66-1-1-19">response</span><span data-best-reader-view-id="1-1-66-1-1-20">.</span><span data-best-reader-view-id="1-1-66-1-1-21">parts</span><span data-best-reader-view-id="1-1-66-1-1-22">:</span>
    <span data-best-reader-view-id="1-1-66-1-1-23">if</span> <span data-best-reader-view-id="1-1-66-1-1-24">image</span><span data-best-reader-view-id="1-1-66-1-1-25">:</span><span data-best-reader-view-id="1-1-66-1-1-26">=</span> <span data-best-reader-view-id="1-1-66-1-1-27">part</span><span data-best-reader-view-id="1-1-66-1-1-28">.</span><span data-best-reader-view-id="1-1-66-1-1-29">as_image</span><span data-best-reader-view-id="1-1-66-1-1-30">():</span>
        <span data-best-reader-view-id="1-1-66-1-1-31">image</span><span data-best-reader-view-id="1-1-66-1-1-32">.</span><span data-best-reader-view-id="1-1-66-1-1-33">save</span><span data-best-reader-view-id="1-1-66-1-1-34">(</span><span data-best-reader-view-id="1-1-66-1-1-35">"</span><span data-best-reader-view-id="1-1-66-1-1-36">relativity_JP.png</span><span data-best-reader-view-id="1-1-66-1-1-37">"</span><span data-best-reader-view-id="1-1-66-1-1-38">)</span>
```

[![General Relativity in Japanese](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F1z8v17jqcxi9rp4vafdo.jpg)](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F1z8v17jqcxi9rp4vafdo.jpg)

## [](https://dev.to/googleai/introducing-nano-banana-pro-complete-developer-tutorial-5fc8#9-mix-it-up-advanced-image-mixing)9) Mix it up! (Advanced Image Mixing)

While the Flash model can mix up to 3 images, the Pro model can handle up to **14 images**! That's a whole party in one prompt. Perfect for creating complex collages or showing off your entire product line.  

```
<span data-best-reader-view-id="1-1-70-1-1-1"># Mix multiple images
</span><span data-best-reader-view-id="1-1-70-1-1-2">response</span> <span data-best-reader-view-id="1-1-70-1-1-3">=</span> <span data-best-reader-view-id="1-1-70-1-1-4">client</span><span data-best-reader-view-id="1-1-70-1-1-5">.</span><span data-best-reader-view-id="1-1-70-1-1-6">models</span><span data-best-reader-view-id="1-1-70-1-1-7">.</span><span data-best-reader-view-id="1-1-70-1-1-8">generate_content</span><span data-best-reader-view-id="1-1-70-1-1-9">(</span>
    <span data-best-reader-view-id="1-1-70-1-1-10">model</span><span data-best-reader-view-id="1-1-70-1-1-11">=</span><span data-best-reader-view-id="1-1-70-1-1-12">PRO_MODEL_ID</span><span data-best-reader-view-id="1-1-70-1-1-13">,</span>
    <span data-best-reader-view-id="1-1-70-1-1-14">contents</span><span data-best-reader-view-id="1-1-70-1-1-15">=</span><span data-best-reader-view-id="1-1-70-1-1-16">[</span>
        <span data-best-reader-view-id="1-1-70-1-1-17">"</span><span data-best-reader-view-id="1-1-70-1-1-18">An office group photo of these people, they are making funny faces.</span><span data-best-reader-view-id="1-1-70-1-1-19">"</span><span data-best-reader-view-id="1-1-70-1-1-20">,</span>
        <span data-best-reader-view-id="1-1-70-1-1-21">PIL</span><span data-best-reader-view-id="1-1-70-1-1-22">.</span><span data-best-reader-view-id="1-1-70-1-1-23">Image</span><span data-best-reader-view-id="1-1-70-1-1-24">.</span><span data-best-reader-view-id="1-1-70-1-1-25">open</span><span data-best-reader-view-id="1-1-70-1-1-26">(</span><span data-best-reader-view-id="1-1-70-1-1-27">'</span><span data-best-reader-view-id="1-1-70-1-1-28">John.png</span><span data-best-reader-view-id="1-1-70-1-1-29">'</span><span data-best-reader-view-id="1-1-70-1-1-30">),</span>
        <span data-best-reader-view-id="1-1-70-1-1-31">PIL</span><span data-best-reader-view-id="1-1-70-1-1-32">.</span><span data-best-reader-view-id="1-1-70-1-1-33">Image</span><span data-best-reader-view-id="1-1-70-1-1-34">.</span><span data-best-reader-view-id="1-1-70-1-1-35">open</span><span data-best-reader-view-id="1-1-70-1-1-36">(</span><span data-best-reader-view-id="1-1-70-1-1-37">'</span><span data-best-reader-view-id="1-1-70-1-1-38">Jane.png</span><span data-best-reader-view-id="1-1-70-1-1-39">'</span><span data-best-reader-view-id="1-1-70-1-1-40">),</span>
        <span data-best-reader-view-id="1-1-70-1-1-41"># ... add up to 14 images
</span>    <span data-best-reader-view-id="1-1-70-1-1-42">],</span>
<span data-best-reader-view-id="1-1-70-1-1-43">)</span>

<span data-best-reader-view-id="1-1-70-1-1-44"># Save the image
</span><span data-best-reader-view-id="1-1-70-1-1-45">for</span> <span data-best-reader-view-id="1-1-70-1-1-46">part</span> <span data-best-reader-view-id="1-1-70-1-1-47">in</span> <span data-best-reader-view-id="1-1-70-1-1-48">response</span><span data-best-reader-view-id="1-1-70-1-1-49">.</span><span data-best-reader-view-id="1-1-70-1-1-50">parts</span><span data-best-reader-view-id="1-1-70-1-1-51">:</span>
    <span data-best-reader-view-id="1-1-70-1-1-52">if</span> <span data-best-reader-view-id="1-1-70-1-1-53">image</span><span data-best-reader-view-id="1-1-70-1-1-54">:</span><span data-best-reader-view-id="1-1-70-1-1-55">=</span> <span data-best-reader-view-id="1-1-70-1-1-56">part</span><span data-best-reader-view-id="1-1-70-1-1-57">.</span><span data-best-reader-view-id="1-1-70-1-1-58">as_image</span><span data-best-reader-view-id="1-1-70-1-1-59">():</span>
        <span data-best-reader-view-id="1-1-70-1-1-60">image</span><span data-best-reader-view-id="1-1-70-1-1-61">.</span><span data-best-reader-view-id="1-1-70-1-1-62">save</span><span data-best-reader-view-id="1-1-70-1-1-63">(</span><span data-best-reader-view-id="1-1-70-1-1-64">"</span><span data-best-reader-view-id="1-1-70-1-1-65">group_picture.png</span><span data-best-reader-view-id="1-1-70-1-1-66">"</span><span data-best-reader-view-id="1-1-70-1-1-67">)</span>
```

[![ ](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F5gpi2avw16veccv9leyv.jpeg)](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F5gpi2avw16veccv9leyv.jpeg)

_Note: If you want very high fidelity for your characters, limit yourself to 5, which is already more than enough for a party night!_

## [](https://dev.to/googleai/introducing-nano-banana-pro-complete-developer-tutorial-5fc8#10-show-off-time-proexclusive-demos)10) Show off time! (Pro-Exclusive Demos)

Here are some examples of what's possible only with Nano Banana Pro. Prepare to be amazed:

### [](https://dev.to/googleai/introducing-nano-banana-pro-complete-developer-tutorial-5fc8#personalized-pixel-art-search-grounding)Personalized Pixel Art (Search Grounding)

_Prompt: "Search the web then generate an image of isometric perspective, detailed pixel art that shows the career of Guillaume Vernade"_

This uses search grounding to find specific information about a person and visualizes it in a specific style.

[![Guillaume Vernade career](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fcor096x1iq8jlct5nvl1.jpg)](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fcor096x1iq8jlct5nvl1.jpg)

### [](https://dev.to/googleai/introducing-nano-banana-pro-complete-developer-tutorial-5fc8#complex-text-integration)Complex Text Integration

_Prompt: "Show me an infographic about how sonnets work, using a sonnet about bananas written in it, along with a lengthy literary analysis of the poem. Good vintage aesthetics"_

The model can generate coherent, lengthy text and integrate it perfectly into a complex layout.

[![ ](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fp0xg8dnb2x567xtmzpl7.jpg)](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fp0xg8dnb2x567xtmzpl7.jpg)

### [](https://dev.to/googleai/introducing-nano-banana-pro-complete-developer-tutorial-5fc8#highfidelity-mockups)High-Fidelity Mockups

_Prompt: "A photo of a program for the Broadway show about TCG players on a nice theater seat, it's professional and well made, glossy, we can see the cover and a page showing a photo of the stage."_

Create photorealistic mockups of print materials with accurate lighting and texture.

[![ ](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fh0xb4n9fn0rvlt6s5ljj.jpg)](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fh0xb4n9fn0rvlt6s5ljj.jpg)

## [](https://dev.to/googleai/introducing-nano-banana-pro-complete-developer-tutorial-5fc8#11-best-practices-and-prompting-tips-for-nano-banana-and-nano-banana-pro)11) Best Practices and prompting tips for Nano Banana and Nano Banana Pro

To achieve the best results with the Nano Banana models, follow these prompting guidelines:

**Be Hyper-Specific:** The more detail you provide about subjects, colors, lighting, and composition, the more control you have over the output.  
**Provide Context and Intent:** Explain the purpose or desired mood of the image. The model's understanding of context will influence its creative choices.  
**Iterate and Refine:** Don't expect perfection on the first try. Use the model's conversational ability to make incremental changes and refine your image.  
**Use Step-by-Step Instructions:** For complex scenes, break your prompt into a series of clear, sequential instructions.  
**Use Positive Framing:** Instead of negative prompts like "no cars," describe the desired scene positively: "an empty, deserted street with no signs of traffic."  
**Control the Camera:** Use photographic and cinematic terms to direct the composition, such as "wide-angle shot", "macro shot", or "low-angle perspective".  
**Use search grounding to your advantage:** When you know that you want the model to use real-time or real-world data, be very precise about it. "Search the web about the last Olympic Lyonnais's game and make an infographics" will work better than just "an infographics of the OL last games" (which should still work, but don't take chances).  
**Use the [Batch API](https://ai.google.dev/gemini-api/docs/image-generation?batch=file#batch-api) to lower your costs and get more quota**: The batch API is a way to send small or very large batches of requests together. They might take up to 24 to be processed, but in exchange you can save 50% on your generation costs. And the quota is also higher!

For a deeper dive into best practices, check the [prompting guide](https://ai.google.dev/gemini-api/docs/image-generation#prompt-guide) in the documentation and the [prompting best practices](https://developers.googleblog.com/en/how-to-prompt-gemini-2-5-flash-image-generation-for-the-best-results/) for Nano Banana published on the official blog.

## [](https://dev.to/googleai/introducing-nano-banana-pro-complete-developer-tutorial-5fc8#wrap-up)Wrap up

Nano Banana Pro (Gemini 3 Pro Image) opens up a new frontier for AI image generation. With its ability to think, search, and render in 4K, it's a tool for serious creators (and serious fun).

Ready to try it out? Head over to [Google AI Studio](https://aistudio.google.com/), try or customize our [Apps](https://aistudio.google.com/apps?source=showcase&showcaseTag=nano-banana) or check out the [cookbook](https://colab.sandbox.google.com/github/google-gemini/cookbook/blob/main/quickstarts/Get_Started_Nano_Banana.ipynb).

[![ ](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fcng2t1e9qmky91on2k7h.jpeg)](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fcng2t1e9qmky91on2k7h.jpeg)
