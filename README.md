<div align="center">
<a href="https://mini-swe-agent.com/latest/"><img src="https://raw.githubusercontent.com/live-swe-agent/live-swe-agent.github.io/refs/heads/main/img/livesweagent.png" alt="mini-swe-agent banner" style="height: 8em"/></a>
</div>

# Live-SWE-agent: live, self-evolving software agent

<p align="center">
    <a href="https://live-swe-agent.github.io/"><img src="https://img.shields.io/badge/%F0%9F%8F%86-leaderboard-8A2BE2?style=for-the-badge"></a>
    <a href="https://arxiv.org/abs/2511.13646"><img src="https://img.shields.io/badge/📃-Arxiv-a8324c.svg?style=for-the-badge"></a>
</p>

<p align="center">
    <big><a href="#-news">📣News</a></big> |
    <big><a href="#-comparison">📊Comparison</a></big> | 
    <big><a href="#-setup">🚀Setup</a></big> |
    <big><a href="#-artifacts">⚙️Artifacts</a></big> |
    <big><a href="#-attribution">📜Attribution</a></big> |
    <big><a href="#-acknowledgements">🙏Acknowledgements</a></big>
</p>


Live-SWE-agent is the **first *live*, runtime self-evolving software engineering agent** that expands and revises its own capabilities *on the fly* while working on a real-world issue. 
Our key insight is that **software agents are themselves software systems**, and modern LLM-based agents already possess the intrinsic capability to extend or modify their own behavior at runtime. 

## 📣 News

- **[Nov 20th, 2025]**: Gemini 3 Pro + Live-SWE-agent scores 77.4% on SWE-bench Verified, outperforming all available models (including Claude 4.5)!!
- **[Nov 17th, 2025]**: Live-SWE-agent achieves the new state-of-the-art solve rate of 45.8% on SWE-Bench Pro!
- **[Nov 17th, 2025]**: We've released Live-SWE-agent 1.0.0!

## 📊 Comparison

Below shows the comparison graph between Live-SWE-agent and state-of-the-art open-source solutions and proprietary commercial agent scaffolds on SWE-bench Verified and SWE-Bench Pro.


<p align="center">
<img src="./assets/comparison.png" style="width:75%; margin-left: auto; margin-right: auto;">
</p>

## 🚀 Setup

We built Live-SWE-agent on top of the popular [mini-swe-agent]() framework with very minimal modifications.

To use Live-SWE-agent, simply install mini-swe-agent first using this [guide]() and use the custom Live-SWE-agent config:

```shell
mini --config config/livesweagent.yaml # using custom Live-SWE-agent config
```

See the `config` folder for more details.

## ⚙️ Artifacts

You can download the complete trajectories, patches, and results of Live-SWE-agent in our [v1.0.0 release](https://github.com/OpenAutoCoder/live-swe-agent/releases/tag/v1.0.0):
- `swebench_verified`: complete runs on SWE-bench Verified
- `swebench_pro`: complete runs on SWE-Bench Pro

## 📜 Attribution

```bibtex
@article{livesweagent,
  author    = {Xia, Chunqiu Steven and Wang, Zhe and Yang, Yan and Wei, Yuxiang and Zhang, Lingming},
  title     = {Live-SWE-agent: Can Software Engineering Agents Self-Evolve on the Fly?},
  year      = {2025},
  journal   = {arXiv preprint},
}
```

## 🙏 Acknowledgements

- [mini-swe-agent](https://github.com/SWE-agent/mini-swe-agent)
- [SWE-bench](https://www.swebench.com/)
- [SWE-Bench Pro](https://scale.com/blog/swe-bench-pro/)
