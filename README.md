Note to self: Below are some self-imposed rules to reduce headaches using NixOS. They must be followed to ensure reusability and non-spaghettification of the config.

#### 1. Don't use Home Manager
- Confusing syntax that forces you to break DRY
- Too much additional complexity for things I don't need

#### 2. Don't use Flakes
- Package-locking makes updating tedious
- Locking is pointless if I design the system well
