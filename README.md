Note to self: Below are some self-imposed rules to reduce headaches using NixOS. They must be followed to ensure reusability and non-spaghettification of the config.

#### 1. Don't use Home Manager
- Confusing syntax that forces you to break DRY
- Too much additional complexity for things I don't need

#### 2. Don't use Flakes
- Package-locking makes updating tedious
- Locking is pointless if I design the system well

#### 3. Divide by hosts and modules
- Common convention and easy to maintain
- Adding a new system is as simple as making a new host file

#### 4. Setup only one user
- For my purposes, I will never need more than one user account
- Simplifies modules that need to modify user groups
