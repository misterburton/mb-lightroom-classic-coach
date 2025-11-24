# Lightroom Classic Coach

**Your AI teaching assistant inside Lightroom**

Lightroom Classic Coach is a plugin that helps you learn photo editing while you work. Instead of applying automatic filters that hide the process, it shows you what professional editors do and explains why each adjustment improves your image.

The plugin uses Google's **Gemini 3** and **Nano Banana Pro** AI models to analyze your photos and answer technical questions. When it makes edits, every change appears in your Lightroom History panel. You can step through each adjustment to see exactly which sliders moved and understand the reasoning behind them.

---

## How it works

### Visual analysis and coaching
Click **"Analyze & Coach"** and the AI evaluates your selected photo. You'll get specific feedback on composition, exposure, and color, along with a proposed editing strategy tailored to that image.

### Natural language queries
Ask questions as you edit:

> *"How do I use the Tone Curve to fade the blacks?"*  
> *"What is the difference between Texture and Clarity?"*  
> *"Give this photo a cinematic, moody look."*

### Transparent learning
When the Coach adjusts your photo—brightening shadows, warming white balance, or refining contrast—it documents each step in Lightroom's History panel. You can rewind through the edits to see which parameters changed and replicate the technique on future photos.

---

## Installation

### What you need
* Adobe Lightroom Classic (v12.0 or later)
* Google Gemini API key with **Pay-as-you-go billing** (free tier keys don't work)

### Get your API key
1. Go to [Google AI Studio](https://aistudio.google.com/app/apikey)
2. Set up billing and select the **Pay-as-you-go** plan
3. Create a new API key in your paid project

### Install the plugin
1. Download the `LightroomCoach.lrplugin` file
2. Open Adobe Lightroom Classic
3. Go to **File > Plug-in Manager**
4. Click **Add** in the bottom left
5. Select the `LightroomCoach.lrplugin` folder

### Configure your key
1. In the Plug-in Manager, select **Lightroom Coach** from the left panel
2. Find the **Gemini API Key** field on the right
3. Paste your Pay-as-you-go API key
4. Verify the status shows "Valid"

### Start using it
1. Select a photo in the Develop module
2. Go to **File > Plug-in Extras > Lightroom Coach**
3. Ask questions or click "Analyze & Coach" to begin