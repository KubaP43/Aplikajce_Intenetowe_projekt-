# Klub_Stal_Stalowa_Wola

Projekt aplikacji internetowej klubu piłkarskiego Stali Stalowa Wola występującego na co dzień w 2 lidze. Aplikacja obsługuje stronę klubu piłkarskiego Stal Stalowa Wola: stronę główną, terminarz, tabelę ligową, kadrę, bilety oraz panel prezesa.

## Dane projektu

- Autor: Jakub Pelic
- Numer albumu: 134957
- Technologia: PHP, Laravel, PostgreSQL, Blade, Tailwind CSS
- Baza danych: `Klub_Stal_Stalowa_Wola`

## Główne funkcje

- Strona główna pokazuje dane z bazy: najbliższe mecze i "czołówkę" tabeli.
- Terminarz korzysta z relacji mecz - drużyna.
- Tabela ligowa sortuje zespoły według punktów, bilansu bramek i strzelonych bramek.
- Kadra posiada wyszukiwanie, filtrowanie i sortowanie.
- Kibic może kupić maksymalnie jeden bilet na jeden mecz.
- Prezes zarządza meczami, drużynami, kadrą i rezerwacjami.

## Konta testowe

```text
Prezes:
E-mail: prezes@stal.pl
Hasło: 1938St@lowka

Kibic 1:
E-mail: test@test.pl
Hasło: Test@123456

Kibic 2:
E-mail: kibic@stal.pl
Hasło: Stalow@123
```

(Aby utworzć konta należy wpisać seeder `database/seeders/UzytkownikSeeder.php`.)

## Uruchomienie

1. Należy rozpakowac `Klub_Stal_Stalowa_Wola_Laravel_poprawiony.zip`.
2. Skopiować `.env.example` jako `.env`.
3. Ustawic dane połączenia z PostgreSQL w `.env`, najważniesze:

```env
DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
DB_PORT=5433
DB_DATABASE=Klub_Stal_Stalowa_Wola
DB_USERNAME=postgres
DB_PASSWORD=postgres
```

Jeśli PostgreSQL działa na innym porcie, np. `5432`, należy zmienić `DB_PORT`.

4. Zainstaluj zależności:

```bash
composer install
```

5. Wygeneruj klucz aplikacji:

```bash
php artisan key:generate
```

6. Utwórz pustą bazę `Klub_Stal_Stalowa_Wola` i zaimportuj plik `Klub_Stal_Stalowa_Wola.sql` w pgAdmin Query Tool.

7. Utwórz konta testowe:

```bash
php artisan db:seed --class=UzytkownikSeeder
```

8. Uruchom aplikację:

```bash
php artisan serve
```

Aplikacja będzie dostępna pod adresem `http://127.0.0.1:8000`.

## Dokumentacja

Dokumentacja techniczna jest dostępna jako osobny plik `Dokumentacja_Klub_Stal_Stalowa_Wola.docx`. Pełny zestaw dokumentacji, czyli Markdown, Word, podręcznik użytkownika oraz zrzuty ekranu, znajduje się także w pliku `Dokumentacja.zip`.

## Bezpieczeństwo

Do repozytorium nie należy wrzucać pliku `.env`, katalogu `vendor`, katalogu `node_modules`, logów, cache ani prywatnych sesji użytkowników.



