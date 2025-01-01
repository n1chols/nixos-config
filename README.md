Note to self: Below are some self-imposed rules to reduce headaches using NixOS. These are unpopular conclusions but you have already determined that everybody else is wrong so don't change them.

#### 1. Don't use Home Manager
- Confusing syntax that forces you to break DRY
- Too much additional complexity for things I don't need

#### 2. Don't use Flakes
- Package-locking makes updating tedious
- Locking is pointless if I design the system well
