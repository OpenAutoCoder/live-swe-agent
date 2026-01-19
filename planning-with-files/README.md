# Planning with Files

> **Work like Manus** — the AI agent company Meta acquired for **$2 billion**.

## Thank You

To everyone who starred, forked, and shared this skill — thank you. This project blew up in less than 24 hours, and the support from the community has been incredible.

If this skill helps you work smarter, that's all I wanted.

---

A Claude Code plugin containing an [Agent Skill](https://code.claude.com/docs/en/skills) that transforms your workflow to use persistent markdown files for planning, progress tracking, and knowledge storage — the exact pattern that made Manus worth billions.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code Plugin](https://img.shields.io/badge/Claude%20Code-Plugin-blue)](https://code.claude.com/docs/en/plugins)
[![Claude Code Skill](https://img.shields.io/badge/Claude%20Code-Skill-green)](https://code.claude.com/docs/en/skills)
[![Cursor Rules](https://img.shields.io/badge/Cursor-Rules-purple)](https://docs.cursor.com/context/rules-for-ai)
[![Version](https://img.shields.io/badge/version-2.0.1-brightgreen)](https://github.com/OthmanAdi/planning-with-files/releases)

## Versions

| Version | Branch | Features | Install |
|---------|--------|----------|---------|
| **v2.0.0** (current) | `master` | Hooks, templates, scripts | `/plugin install planning-with-files@planning-with-files` |
| **v1.0.0** (legacy) | `legacy` | Core 3-file pattern | `git clone -b legacy https://github.com/OthmanAdi/planning-with-files.git` |

## What's New in v2.0.0

- **Hooks Integration** — Automatic plan re-reading and completion verification
- **Templates** — Structured templates for task_plan.md, findings.md, progress.md
- **Scripts** — Helper scripts for initialization and completion checks
- **Enhanced Documentation** — 2-Action Rule, 3-Strike Protocol, 5-Question Reboot Test

See [CHANGELOG.md](CHANGELOG.md) for details. Upgrading from v1.x? See [MIGRATION.md](MIGRATION.md).

## Why This Skill?

On December 29, 2025, [Meta acquired Manus for $2 billion](https://techcrunch.com/2025/12/29/meta-just-bought-manus-an-ai-startup-everyone-has-been-talking-about/). In just 8 months, Manus went from launch to $100M+ revenue. Their secret? **Context engineering**.

This skill implements Manus's core workflow pattern:

> "Markdown is my 'working memory' on disk. Since I process information iteratively and my active context has limits, Markdown files serve as scratch pads for notes, checkpoints for progress, building blocks for final deliverables."
> — Manus AI

## The Problem

Claude Code (and most AI agents) suffer from:

- **Volatile memory** — TodoWrite tool disappears on context reset
- **Goal drift** — After 50+ tool calls, original goals get forgotten
- **Hidden errors** — Failures aren't tracked, so the same mistakes repeat
- **Context stuffing** — Everything crammed into context instead of stored

## The Solution: 3-File Pattern

For every complex task, create THREE files:

```
task_plan.md      → Track phases and progress
findings.md       → Store research and findings
progress.md       → Session log and test results
```

### The Core Principle

```
Context Window = RAM (volatile, limited)
Filesystem = Disk (persistent, unlimited)

→ Anything important gets written to disk.
```

<details>
<summary><strong>Workflow Diagram</strong> (click to expand)</summary>

This diagram shows how the three files work together and how hooks interact with them:

```
┌─────────────────────────────────────────────────────────────────┐
│                    TASK START                                    │
│  User requests a complex task (>5 tool calls expected)          │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
         ┌───────────────────────────────┐
         │  STEP 1: Create task_plan.md │
         │  (NEVER skip this step!)      │
         └───────────────┬───────────────┘
                         │
                         ▼
         ┌───────────────────────────────┐
         │  STEP 2: Create findings.md   │
         │  STEP 3: Create progress.md   │
         └───────────────┬───────────────┘
                         │
                         ▼
    ┌────────────────────────────────────────────┐
    │         WORK LOOP (Iterative)              │
    │                                            │
    │  ┌──────────────────────────────────────┐ │
    │  │  PreToolUse Hook (Automatic)         │ │
    │  │  → Reads task_plan.md before        │ │
    │  │    Write/Edit/Bash operations       │ │
    │  │  → Refreshes goals in attention      │ │
    │  └──────────────┬───────────────────────┘ │
    │                 │                          │
    │                 ▼                          │
    │  ┌──────────────────────────────────────┐ │
    │  │  Perform work (tool calls)          │ │
    │  │  - Research → Update findings.md    │ │
    │  │  - Implement → Update progress.md    │ │
    │  │  - Make decisions → Update both     │ │
    │  └──────────────┬───────────────────────┘ │
    │                 │                          │
    │                 ▼                          │
    │  ┌──────────────────────────────────────┐ │
    │  │  After 2 view/browser operations:    │ │
    │  │  → MUST update findings.md           │ │
    │  │    (2-Action Rule)                   │ │
    │  └──────────────┬───────────────────────┘ │
    │                 │                          │
    │                 ▼                          │
    │  ┌──────────────────────────────────────┐ │
    │  │  After completing a phase:            │ │
    │  │  → Update task_plan.md status        │ │
    │  │  → Update progress.md with details   │ │
    │  └──────────────┬───────────────────────┘ │
    │                 │                          │
    │                 ▼                          │
    │  ┌──────────────────────────────────────┐ │
    │  │  If error occurs:                    │ │
    │  │  → Log in task_plan.md               │ │
    │  │  → Log in progress.md                │ │
    │  │  → Document resolution               │ │
    │  └──────────────┬───────────────────────┘ │
    │                 │                          │
    │                 └──────────┐               │
    │                            │               │
    │                            ▼               │
    │              ┌──────────────────────┐     │
    │              │  More work to do?    │     │
    │              └──────┬───────────────┘     │
    │                     │                     │
    │              YES ───┘                     │
    │              │                            │
    │              └──────────┐                 │
    │                         │                 │
    └─────────────────────────┘                 │
                                                 │
                         NO                      │
                         │                       │
                         ▼                       │
         ┌──────────────────────────────────────┐
         │  Stop Hook (Automatic)               │
         │  → Checks if all phases complete     │
         │  → Verifies task_plan.md status      │
         └──────────────┬───────────────────────┘
                         │
                         ▼
         ┌──────────────────────────────────────┐
         │  All phases complete?                │
         └──────────────┬───────────────────────┘
                         │
              ┌──────────┴──────────┐
              │                     │
            YES                    NO
              │                     │
              ▼                     ▼
    ┌─────────────────┐    ┌─────────────────┐
    │  TASK COMPLETE  │    │  Continue work  │
    │  Deliver files  │    │  (back to loop) │
    └─────────────────┘    └─────────────────┘
```

**Key Interactions:**
- **PreToolUse Hook**: Automatically reads `task_plan.md` before Write/Edit/Bash operations (attention manipulation)
- **Stop Hook**: Automatically verifies all phases are complete before stopping
- **2-Action Rule**: After every 2 view/browser/search operations, update `findings.md`
- **Phase Completion**: Update both `task_plan.md` (status) and `progress.md` (details)
- **Error Handling**: Log errors in both `task_plan.md` and `progress.md`

</details>

## Installation

### As a Claude Code Plugin (Recommended)

Install directly using the Claude Code CLI:

```
/plugin marketplace add OthmanAdi/planning-with-files
/plugin install planning-with-files@planning-with-files
```

### Manual Installation

Clone or copy this repository into your project's `.claude/plugins/` directory:

```bash
# Option 1: Clone into plugins directory
mkdir -p .claude/plugins
git clone https://github.com/OthmanAdi/planning-with-files.git .claude/plugins/planning-with-files

# Option 2: Add as git submodule
git submodule add https://github.com/OthmanAdi/planning-with-files.git .claude/plugins/planning-with-files

# Option 3: Use --plugin-dir flag
git clone https://github.com/OthmanAdi/planning-with-files.git
claude --plugin-dir ./planning-with-files
```

### Legacy Installation (Skills Only)

Copy the `skills/` directory contents into your `.claude/skills/` folder:

```bash
git clone https://github.com/OthmanAdi/planning-with-files.git
cp -r planning-with-files/skills/* ~/.claude/skills/
```

### Cursor Installation

Copy the `.cursor/rules/` directory into your project:

```bash
git clone https://github.com/OthmanAdi/planning-with-files.git
cp -r planning-with-files/.cursor .cursor
```

Or manually create `.cursor/rules/planning-with-files.mdc` in your project with the content from this repo.

> **Note:** Hooks (PreToolUse, Stop) are Claude Code specific and won't work in Cursor. The core planning workflow still applies.

### One-Line Installer (Skills Only)

Extract just the skill directly into your current directory:

```bash
curl -L https://github.com/OthmanAdi/planning-with-files/archive/master.tar.gz | tar -xzv --strip-components=2 "planning-with-files-master/skills/planning-with-files"
```

Then move `planning-with-files/` to `~/.claude/skills/`.

## Usage

Once installed, Claude will automatically:

1. **Create `task_plan.md`** before starting complex tasks
2. **Re-read plan** before major decisions (via hooks)
3. **Update progress** with checkboxes after each phase
4. **Store findings** in `findings.md` instead of stuffing context
5. **Log errors** for future reference
6. **Verify completion** before stopping (via hooks)

### Key Rules

1. **Create Plan First** — Never start without `task_plan.md`
2. **The 2-Action Rule** — Save findings after every 2 view/browser operations
3. **Log ALL Errors** — They help avoid repetition
4. **Never Repeat Failures** — Track attempts, mutate approach

## Quick Start: Your First Task

Follow these 5 simple steps to use the planning-with-files pattern:

### Step 1: Create Your Planning Files

**When:** Before starting any work on a complex task

**Action:** Create all three files using the templates:

```bash
# Option 1: Use the init script (if available)
./scripts/init-session.sh

# Option 2: Copy templates manually
cp templates/task_plan.md task_plan.md
cp templates/findings.md findings.md
cp templates/progress.md progress.md
```

**Update:** Fill in the Goal section in `task_plan.md` with your task description.

---

### Step 2: Plan Your Phases

**When:** Right after creating the files

**Action:** Break your task into 3-7 phases in `task_plan.md`

**Example:**
```markdown
### Phase 1: Requirements & Discovery
- [ ] Understand user intent
- [ ] Research existing solutions
- **Status:** in_progress

### Phase 2: Implementation
- [ ] Write core code
- **Status:** pending
```

**Update:**
- `task_plan.md`: Define your phases
- `progress.md`: Note that planning is complete

---

### Step 3: Work and Document

**When:** Throughout the task

**Action:** As you work, update files:

| What Happens | Which File to Update | What to Add |
|--------------|---------------------|-------------|
| You research something | `findings.md` | Add to "Research Findings" |
| You view 2 browser/search results | `findings.md` | **MUST update** (2-Action Rule) |
| You make a technical decision | `findings.md` | Add to "Technical Decisions" with rationale |
| You complete a phase | `task_plan.md` | Change status: `in_progress` → `complete` |
| You complete a phase | `progress.md` | Log actions taken, files modified |
| An error occurs | `task_plan.md` | Add to "Errors Encountered" table |
| An error occurs | `progress.md` | Add to "Error Log" with timestamp |

**Example workflow:**
```
1. Research → Update findings.md
2. Research → Update findings.md (2nd time - MUST update now!)
3. Make decision → Update findings.md "Technical Decisions"
4. Implement code → Update progress.md "Actions taken"
5. Complete phase → Update task_plan.md status to "complete"
6. Complete phase → Update progress.md with phase summary
```

---

### Step 4: Re-read Before Decisions

**When:** Before making major decisions (automatic with hooks in Claude Code)

**Action:** The PreToolUse hook automatically reads `task_plan.md` before Write/Edit/Bash operations

**Manual reminder (if not using hooks):** Before important choices, read `task_plan.md` to refresh your goals

**Why:** After many tool calls, original goals can be forgotten. Re-reading brings them back into attention.

---

### Step 5: Complete and Verify

**When:** When you think the task is done

**Action:** Verify completion:

1. **Check `task_plan.md`**: All phases should have `**Status:** complete`
2. **Check `progress.md`**: All phases should be logged with actions taken
3. **Run completion check** (if using hooks, this happens automatically):
   ```bash
   ./scripts/check-complete.sh
   ```

**If not complete:** The Stop hook (or script) will prevent stopping. Continue working until all phases are done.

**If complete:** Deliver your work! All three planning files document your process.

---

### Quick Reference: When to Update Which File

```
┌─────────────────────────────────────────────────────────┐
│  task_plan.md                                            │
│  Update when:                                            │
│  • Starting task (create it first!)                      │
│  • Completing a phase (change status)                    │
│  • Making a major decision (add to Decisions table)     │
│  • Encountering an error (add to Errors table)          │
│  • Re-reading before decisions (automatic via hook)      │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│  findings.md                                             │
│  Update when:                                            │
│  • Discovering something new (research, exploration)    │
│  • After 2 view/browser/search operations (2-Action!)   │
│  • Making a technical decision (with rationale)          │
│  • Finding useful resources (URLs, docs)                 │
│  • Viewing images/PDFs (capture as text immediately!)   │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│  progress.md                                             │
│  Update when:                                            │
│  • Starting a new phase (log start time)                 │
│  • Completing a phase (log actions, files modified)      │
│  • Running tests (add to Test Results table)            │
│  • Encountering errors (add to Error Log with timestamp)│
│  • Resuming after a break (update 5-Question Check)     │
└─────────────────────────────────────────────────────────┘
```

---

### Common Mistakes to Avoid

❌ **Starting work without creating `task_plan.md`**
✅ Always create the plan file first

❌ **Forgetting to update `findings.md` after 2 browser operations**
✅ Set a reminder: "2 view/browser ops = update findings.md"

❌ **Not logging errors because you fixed them quickly**
✅ Log ALL errors, even ones you resolved immediately

❌ **Repeating the same failed action**
✅ If something fails, log it and try a different approach

❌ **Only updating one file**
✅ The three files work together - update them as a set

---

For a complete walkthrough example, see [examples/README.md](examples/README.md).

## Troubleshooting

### Planning files created in wrong directory

**Issue:** When using `/plan`, the files (`task_plan.md`, `findings.md`, `progress.md`) are created in the skill installation directory instead of your project.

**Why this happens:** When the skill runs as a subagent, it may not inherit your terminal's current working directory.

**Solutions:**

1. **Specify your project path when invoking:**
   ```
   /plan - I'm working in /path/to/my-project/, create all files there
   ```

2. **Add context before invoking:**
   ```
   I'm working on the project at /path/to/my-project/
   ```
   Then run `/plan`.

3. **Create a CLAUDE.md in your project root:**
   ```markdown
   # Project Context

   All planning files (task_plan.md, findings.md, progress.md)
   should be created in this directory.
   ```

4. **Use the skill directly without subagent:**
   ```
   Help me plan this task using the planning-with-files approach.
   Create task_plan.md, findings.md, and progress.md here.
   ```

**Fixed in v2.0.1:** The skill instructions now explicitly specify that planning files should be created in your project directory, not the skill installation folder.

---

### Files not persisting between sessions

**Issue:** Planning files seem to disappear or aren't found when resuming work.

**Solution:** Make sure the files are in your project root, not in a temporary location. Check with:
```bash
ls -la task_plan.md findings.md progress.md
```

---

### Hooks not triggering

**Issue:** The PreToolUse hook (which reads task_plan.md before actions) doesn't seem to run.

**Solution:**
1. Ensure you're using Claude Code v1.0.18 or later
2. Verify the skill is installed correctly: `ls ~/.claude/skills/planning-with-files/`
3. Check that `task_plan.md` exists in your current directory

---

### Need help?

Open an issue at [github.com/OthmanAdi/planning-with-files/issues](https://github.com/OthmanAdi/planning-with-files/issues) with:
- Your Claude Code version (`claude --version`)
- The command you ran
- What happened vs what you expected

## File Structure

```
planning-with-files/
├── .claude-plugin/
│   ├── plugin.json          # Plugin manifest
│   └── marketplace.json     # Marketplace listing
├── .cursor/
│   └── rules/
│       └── planning-with-files.mdc  # Cursor rules file
├── skills/
│   └── planning-with-files/
│       ├── SKILL.md         # Main skill definition
│       ├── reference.md     # Manus principles
│       ├── examples.md      # Usage examples
│       ├── templates/       # File templates
│       │   ├── task_plan.md
│       │   ├── findings.md
│       │   └── progress.md
│       └── scripts/         # Helper scripts
│           ├── init-session.sh
│           └── check-complete.sh
├── CHANGELOG.md             # Version history
├── MIGRATION.md             # Upgrade guide
├── LICENSE
└── README.md
```

## The Manus Principles

This skill implements these key context engineering principles:

| Principle | Implementation |
|-----------|----------------|
| Filesystem as memory | Store in files, not context |
| Attention manipulation | Re-read plan before decisions (hooks) |
| Error persistence | Log failures in plan file |
| Goal tracking | Checkboxes show progress |
| Completion verification | Stop hook checks all phases |

## When to Use

**Use this pattern for:**
- Multi-step tasks (3+ steps)
- Research tasks
- Building/creating projects
- Tasks spanning many tool calls
- Anything requiring organization

**Skip for:**
- Simple questions
- Single-file edits
- Quick lookups

## Community Forks

Extensions built by the community:

| Fork | Author | Features |
|------|--------|----------|
| [multi-manus-planning](https://github.com/kmichels/multi-manus-planning) | [@kmichels](https://github.com/kmichels) | Multi-project support, separate planning/source paths, SessionStart git sync |

*Built something? Open an issue to get listed!*

## Acknowledgments

- **Manus AI** — For pioneering context engineering patterns
- **Anthropic** — For Claude Code, Agent Skills, and the Plugin system
- **Lance Martin** — For the detailed Manus architecture analysis
- Based on [Context Engineering for AI Agents](https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus)

## Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## License

MIT License — feel free to use, modify, and distribute.

---

**Author:** [Ahmad Othman Ammar Adi](https://github.com/OthmanAdi)

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=OthmanAdi/planning-with-files&type=Date)](https://star-history.com/#OthmanAdi/planning-with-files&Date)
