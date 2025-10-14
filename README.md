# MANI FISZKI

## App to learn English

This project aims to provide an interactive and effective way to improve English skills. Currently, it contains two modules: Flashcards and Sentences. This is a Ruby on Rails 8 application built with Hotwire.

It is available here: https://mani-fiszki.fly.dev/

![Mani Fiszki Image 1](/app/assets/images/mf-1.png)

### Flashcards
The module allows users to learn new words quickly by flipping flashcards and navigating through sets of vocabulary.

![Mani Fiszki Image 2](/app/assets/images/mf-2.png)

### Sentences
The module helps users practice by filling in missing words in sentences.

![Mani Fiszki Image 3](/app/assets/images/mf-3.png)

### Access & Management
The app follows a one-teacher, multiple-students model. A single user (a teacher) can manage flashcards and sentences after logging in.
Students can access the app without any restrictions and use it to learn English.

![Mani Fiszki Image 4](/app/assets/images/mf-4.png)


## Tech stack

- **Ruby**: 3.3.x
- **Rails**: 8 (edge, from `rails/rails` main)
- **Hotwire**: Turbo + Stimulus
- **Asset bundling**: Importmap (no Node.js required)
- **CSS**: Tailwind CSS (`tailwindcss-rails`)
- **Persistence**: SQLite3 (development/test), PostgreSQL (production)

## Local development

### Prerequisites

- Ruby 3.3.x

### Setup

```bash
bundle install
```

### Run the app

Option A (recommended): single command with Foreman

```bash
bin/dev         # runs Rails server and tailwind watcher
```

Option B: run processes separately

```bash
bin/rails server
bin/rails tailwindcss:watch
```

Visit `http://localhost:3000`.

### Database commands

```bash
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
```

### Tests

```bash
bin/rails test
```
