# Klub_Stal_Stalowa_Wola

Projekt zaliczeniowy z tworzenia aplikacji internetowych. Jest to kompleksowy system obsługujący stronę klubu piłkarskiego Stal Stalowa Wola. Aplikacja pozwala na zarządzanie terminarzem, biletami oraz kadrą, a także posiada dedykowany panel administracyjny.

## Dane projektu

- Autor: Jakub Pelic
- Numer albumu: 134957
- Technologia: Laravel, PHP, PostgreSQL, Blade, Tailwind CSS
- Baza danych: `Klub_Stal_Stalowa_Wola`

## Glowne funkcje

- Strona glowna pokazuje dane z bazy: najblizsze mecze oraz czolowke tabeli.
- Terminarz wyswietla mecze z relacja do tabeli druzyn.
- Tabela ligowa sortuje zespoly wedlug punktow, bilansu bramek i liczby strzelonych bramek.
- Kadra ma wyszukiwanie, filtrowanie i sortowanie pilkarzy.
- Bilety mozna kupowac tylko po zalogowaniu.
- Jeden kibic moze miec maksymalnie jeden bilet na jeden mecz.
- Prezes widzi pelne dane kibicow kupujacych bilety i moze zarzadzac danymi.
- Hasla sa przechowywane w bazie jako hash, nie jawnie.

## Konto prezesa

```text
E-mail: prezes@stal.pl
Haslo: 1938St@lowka
```

## Uruchomienie

1. Skopiuj plik `.env.example` jako `.env`.
2. Ustaw dane polaczenia z PostgreSQL w pliku `.env`.
3. Zainstaluj zaleznosci:

```bash
composer install
```

4. Wygeneruj klucz aplikacji:

```bash
php artisan key:generate
```

5. Wykonaj migracje i seedery:

```bash
php artisan migrate --seed
```

6. Uruchom serwer:

```bash
php artisan serve
```

Po uruchomieniu aplikacja jest dostepna pod adresem:

```text
http://127.0.0.1:8000
```

## Baza danych

Do repozytorium dolaczony jest plik SQL z eksportem bazy. Mozna go zaimportowac w pgAdmin albo przez PostgreSQL, a nastepnie ustawic w `.env` nazwe bazy:

```env
DB_DATABASE=Klub_Stal_Stalowa_Wola
```

## Dokumentacja

Szczegóły techniczne: Pełny opis architektury znajduje się w pliku Dokumentacja.md.
Obsługa aplikacji: Podstawowe informacje, jak poruszać się po gotowym systemie, znajdziesz w pliku Podrecznik_Uzytkownika.txt.
