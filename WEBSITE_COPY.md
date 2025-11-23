# Lightroom Classic Coach

**Your AI-Powered Mentor Inside Lightroom.**

Lightroom Classic Coach is an intelligent teaching assistant that lives directly inside Adobe Lightroom Classic, designed to help you master photo editing while you work. Unlike "magic button" tools that hide the process, this plugin actively teaches you the craft.

Using Google's **Gemini 3** and **Nano Banana Pro** AI models, Lightroom Coach analyzes your photos, answers your technical questions, and executes complex edits, all while explaining the "why" behind every decision so you can learn to replicate professional results yourself.

---

## How It Works

### 1. Visual Coaching & Analysis
Click the **"Analyze & Coach"** button, and the AI "looks" at your currently selected photo. It provides a professional critique of your composition, exposure, and color balance, then formulates a custom editing strategy to maximize your image's potential.

### 2. Ask Anything
Stuck on a specific tool? Just ask.
> *"How do I use the Tone Curve to fade the blacks?"*
> *"What is the difference between Texture and Clarity?"*
> *"Give this photo a cinematic, moody look."*

### 3. Learn by Seeing
When the Coach suggests an edit (like brightening exposure or warming the white balance), it doesn't just happen in the background. The plugin applies the settings non-destructively, and importantly, **logs every step in your Lightroom History panel**.

You can roll back through the history to see exactly which sliders moved and why, turning every automated edit into a learning opportunity.

---

## Installation Guide

### Prerequisites
*   Adobe Lightroom Classic (v12.0 or later)
*   A Google Gemini API Key (**Pay-as-you-go** plan required)

### Step 1: Get Your API Key
1.  Go to [Google AI Studio](https://aistudio.google.com/app/apikey).
2.  **Important:** You must set up billing and select the **Pay-as-you-go** plan. The free tier key is not supported.
3.  Create a new API key in your paid project.

### Step 2: Install the Plugin
1.  Download the `LightroomCoach.lrplugin` file.
2.  Open **Adobe Lightroom Classic**.
3.  Go to **File > Plug-in Manager**.
4.  Click the **Add** button in the bottom left.
5.  Navigate to and select the `LightroomCoach.lrplugin` folder.

### Step 3: Configure
1.  In the Plug-in Manager, select **Lightroom Coach** from the list on the left.
2.  Find the **Gemini API Key** section on the right.
3.  Paste your **Pay-as-you-go** API key into the field.
4.  Status should change to "Valid".

### Step 4: Start Coaching
1.  Select a photo in your Library or Develop module.
2.  Go to **File > Plug-in Extras > Lightroom Coach...**
3.  Start chatting using natural language or click "Analyze & Coach" for automated teaching and editing.
