# Lightroom Classic Coach Product Requirements Document (PRD)
**Project:** Lightroom Classic AI Coach Plug-in  
**Author:** misterburton  
**Date:** 2025-10-04  
**Version:** 1.0

---

## 1. Overview
The **Lightroom Classic AI Coach** is a plug-in that embeds a floating **chat window** directly inside Adobe Lightroom Classic. It allows users to ask questions about Lightroom features, menus, tools, and editing workflows, and get **real-time guidance** powered by the OpenAI API.

- **Primary Goal:** Provide photographers with an in-app AI assistant that helps them locate features, learn editing techniques, and optionally apply edits.  
- **Audience:** Professional and enthusiast photographers using Lightroom Classic.  
- **Motivation:** Reduce time spent searching for features or tutorials, and give personalized editing guidance without leaving Lightroom.

---

## 2. Key Features
### Core (MVP)
1. **Floating Chat Palette**
   - Opens via *File ▸ Plug-in Extras ▸ Lightroom Coach…*
   - Displays transcript of user ↔ AI conversation.
   - Input box + “Send” button.

2. **OpenAI Integration**
   - Calls OpenAI’s **Responses API** (`/v1/responses`).
   - System prompt defines assistant as “Lightroom Coach”.
   - Sends user’s question + lightweight Lightroom context (module, selection size, sample develop settings).

3. **User API Key Input**
   - On first launch, user enters their **OpenAI API key** in Plug-in Manager preferences.
   - Key stored locally in Lightroom preferences (never hard-coded).

4. **Action Handling**
   - AI replies with text guidance.
   - If JSON action is detected (e.g., `{"action":"apply_develop_settings"}`), plug-in executes supported actions:
     - `apply_develop_settings` → adjusts exposure, contrast, etc. on selected photos.

---

### Nice-to-Have (Future)
- Step-through teaching mode with overlay instructions.  
- “Virtual copy” editing for safe experiments.  
- RAG mode using local doc index for official manual/forum Q&A.  
- Export/Import AI recipes.  

---

## 3. Technical Architecture
### Lightroom Plug-in
- **Language:** Lua (Adobe Lightroom SDK).  
- **Packaging:** `.lrplugin` bundle.  
- **UI:** `LrDialogs.presentFloatingDialog()` + `LrView`.  
- **Networking:** `LrHttp.post` for OpenAI API.  
- **Persistence:** `LrPrefs.prefsForPlugin()` for API key.  
- **Threading:** `LrTasks.startAsyncTask()` for async API calls.  

### Files
```
LightroomCoach.lrplugin/
├─ Info.lua             -- Plug-in metadata
├─ PluginInit.lua       -- Registers menu command
├─ ChatDialog.lua       -- Floating chat UI
├─ OpenAI.lua           -- Handles API calls
├─ Actions.lua          -- Parses/executed AI actions
├─ Prefs.lua            -- API key preferences UI
└─ JSON.lua             -- Tiny JSON parser (3rd party)
```

---

## 4. User Experience
### First Run
1. Install plug-in via *File ▸ Plug-in Manager*.  
2. Enter OpenAI API Key in Preferences.  
3. Menu item appears: *File ▸ Plug-in Extras ▸ Lightroom Coach…*.  

### Daily Use
1. User opens Coach window.  
2. Types: *“How do I mask the sky only?”*  
3. Assistant explains step-by-step.  
4. If possible, provides JSON action (e.g., apply exposure adjustment).  
5. Plug-in executes action and confirms.

---

## 5. API Details
**Endpoint:**  
`POST https://api.openai.com/v1/responses`

**Headers:**  
```
Authorization: Bearer {API_KEY}
Content-Type: application/json
```

**Body Example:**
```json
{
  "model": "gpt-5.1-mini",
  "input": [{"role": "user", "content": "How do I adjust white balance?"}],
  "system": "You are Lightroom Coach, an expert on Adobe Lightroom Classic."
}
```

**Response Handling:**
- Use `data.output_text` for transcript.  
- If response includes valid JSON block → parse and execute via `Actions.lua`.

---

## 6. Testing Plan
### A. Environment Setup
1. Install Lightroom Classic + SDK.  
2. Create `LightroomCoach.lrplugin` folder with files above.  
3. In Lightroom, open *Plug-in Manager*, click **Add**, select folder.  

### B. Functional Tests
1. **Open Plug-in**
   - Verify *Lightroom Coach* appears under *File ▸ Plug-in Extras*.  
   - Floating dialog opens.

2. **API Key Input**
   - Remove/replace key via Plug-in Manager.  
   - Confirm stored in preferences, not hard-coded.  

3. **Chat Flow**
   - Ask: *“Where is lens corrections?”*  
   - Expect textual guidance.  

4. **Action Handling**
   - Ask: *“Brighten this photo by 0.25 exposure.”*  
   - Model outputs JSON → plug-in applies settings.  
   - Confirm via Develop histogram.

5. **Error Handling**
   - Disconnect internet, send query.  
   - Verify error message shown (no crash).  
   - Wrong API key → proper error shown.  

### C. Edge Cases
- Multiple photo selection → edits applied to all.  
- No photo selected → friendly message.  
- Long responses → scroll bar functional.  

### D. Performance
- Verify UI does not freeze during API call.  
- Transcript grows gracefully (no crashes with long chats).

---

## 7. Deliverables
- `.lrplugin` folder with working MVP.  
- README.md with install/setup instructions.  
- User testing feedback loop for expanding supported actions.  

---

## 8. Timeline
- **Week 1:** Setup plug-in skeleton, Info.lua, prefs UI.  
- **Week 2:** Build chat UI + API call.  
- **Week 3:** Implement `apply_develop_settings` action.  
- **Week 4:** QA with photographers; refine system prompt.  

---

## 9. Success Criteria
- Plug-in installs cleanly in Lightroom.  
- Users can enter their own OpenAI API key.  
- Chat works with OpenAI API and gives accurate responses.  
- At least one editing action (`apply_develop_settings`) works end-to-end.  

---

# Appendix
- [Adobe Lightroom Classic SDK Guide](https://developer.adobe.com/lightroom/).  
- [OpenAI Responses API Reference](https://platform.openai.com/docs/guides/responses).  
