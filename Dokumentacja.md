# Temat projektu

**Klub_Stal_Stalowa_Wola** to aplikacja internetowa przygotowana dla klubu piłkarskiego Stal Stalowa Wola, jego kibiców oraz osoby zarządzającej klubem. Głównym zastosowaniem systemu jest prezentowanie najważniejszych informacji klubowych oraz obsługa podstawowych działań związanych z terminarzem, tabelą ligową, kadrą i rezerwacją biletów.

Aplikacja udostępnia publiczne podstrony dla gości, pozwala zalogowanym kibicom kupować bilety, a prezesowi daje możliwość zarządzania danymi z poziomu panelu administracyjnego.

Repozytorium: https://github.com/KubaP43/Aplikajce_Intenetowe_projekt-

## Lista pytań pomocniczych

**Jaki problem rozwiązuje nasza aplikacja?**

Aplikacja porządkuje informacje dotyczące klubu w jednym miejscu. Kibic nie musi szukać osobno terminarza, tabeli, kadry, historii i kontaktu. Może też zarezerwować bilet bez ręcznego kontaktowania się z klubem. Prezes może aktualizować dane przez formularze, bez bezpośredniego wpisywania rekordów w pgAdmin.

**Jeśli istnieją podobne rozwiązania, to czym nasza aplikacja się wyróżnia?**

Projekt wyróżnia się prostym podziałem na role i połączeniem części informacyjnej z panelem zarządzania. Gość może przeglądać dane, kibic po zalogowaniu kupuje bilet, a prezes zarządza terminarzem, tabelą, kadrą i rezerwacjami. Dane są trzymane w relacyjnej bazie PostgreSQL. Formularze posiadają walidację po stronie klienta i walidację po stronie serwera.

---

## Uruchomienie projektu (developer)

Instrukcja uruchomienia projektu dla developera obejmuje instalację zależności, konfigurację pliku .env, połączenie z PostgreSQL, migracje, dane startowe i uruchomienie serwera lokalnego.

Poniższa tabela przedstawia technologie użyte do zbudowania i uruchomienia aplikacji w wersji deweloperskiej.

| Technologia | Dokładna wersja | Zastosowanie | Oficjalna strona |
| :--- | :--- | :--- | :--- |
| **PHP** | 8.5.6 | środowisko uruchomieniowe backendu | [php.net](https://php.net) |
| **Laravel** | 13.11.2 | główny framework aplikacji | [laravel.com](https://laravel.com) |
| **PostgreSQL** | 18.1 | relacyjna baza danych | [postgresql.org](https://postgresql.org) |
| **Composer** | 2.9.8 | menedżer zależności PHP | [getcomposer.org](https://getcomposer.org) |
| **Blade** | zintegrowany z Laravel 13.11.2 | silnik widoków HTML | [laravel.com/docs/blade](https://laravel.com/docs/blade) |
| **Tailwind CSS** | 4.0.0 | stylowanie interfejsu | [tailwindcss.com](https://tailwindcss.com) |
| **Vite** | 8.0.0 | obsługa zasobów frontendowych | [vite.dev](https://vite.dev) |

### Wymagania programowe

Przed uruchomieniem projektu na czystym komputerze należy przygotować:

- **System operacyjny:** Windows 10/11.
- **Środowisko uruchomieniowe:** PHP 8.5.6 z rozszerzeniami wymaganymi przez Laravel i PostgreSQL, m.in. `pdo_pgsql`, `openssl`, `mbstring`, `xml`.
- **Menedżer zależności:** Composer 2.9.8.
- **Silnik bazy danych:** PostgreSQL 18.1.
- **Dodatkowe narzędzia:** terminal, Visual Studio Code lub inny edytor, przeglądarka internetowa.

### Proces instalacji

1. **Pobranie projektu z repozytorium**

```bash
git clone https://github.com/KubaP43/Aplikajce_Intenetowe_projekt-.git
```

2. **Wejście do folderu projektu**

```bash
cd Aplikajce_Intenetowe_projekt-
```

3. **Instalacja zależności backendowych**

```bash
composer install
```

4. **Utworzenie pliku środowiskowego**

```bash
copy .env.example .env
```

5. **Wygenerowanie klucza aplikacji**

```bash
php artisan key:generate
```

### Proces konfiguracji

1. **Konfiguracja zmiennych środowiskowych**

W głównym katalogu projektu należy utworzyć plik `.env` na podstawie `.env.example`. Plik `.env` jest plikiem lokalnym i nie powinien trafiać do repozytorium, ponieważ zawiera dane środowiska oraz konfigurację połączenia z bazą.

2. **Połączenie z bazą danych**

W pliku `.env` należy ustawić dane PostgreSQL. Przykładowa konfiguracja lokalna:

```env
DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
DB_PORT=5433
DB_DATABASE=Klub_Stal_Stalowa_Wola
DB_USERNAME=postgres
DB_PASSWORD=postgres
SESSION_DRIVER=database
```

Jeśli PostgreSQL działa na innym porcie, np. `5432`, należy zmienić wartość `DB_PORT`.

3. **Migracje i dane startowe**

Strukturę bazy oraz dane startowe można utworzyć komendą:

```bash
php artisan migrate --seed
```

W folderze dokumentacji znajduje się także bezpieczny eksport bazy danych `Klub_Stal_Stalowa_Wola.sql`. Plik zawiera strukturę oraz publiczne dane startowe, ale nie zawiera pliku `.env`, prywatnych sesji ani przypadkowych rezerwacji biletów.

4. **Dane początkowe i dostęp do panelu prezesa**

Domyślne konta testowe:

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

Konta testowe są tworzone przez seedery. Hasła w bazie są zapisane jako hash, a nie jako jawny tekst.

### Uruchomienie projektu w terminalu

Aby uruchomić lokalny serwer deweloperski, należy wpisać:

```bash
php artisan serve
```

Po poprawnym uruchomieniu aplikacja jest dostępna pod adresem:

```text
http://127.0.0.1:8000
```

---

## Uruchomienie projektu (user)

Ta sekcja jest przeznaczona dla użytkownika końcowego, którego nie interesuje kod źródłowy.

- **Aplikacja webowa lokalna:** projekt działa lokalnie po uruchomieniu serwera przez developera. Użytkownik korzysta z aplikacji w przeglądarce pod adresem `http://127.0.0.1:8000`.
- **Wymagania sprzętowe:** wystarczy komputer, laptop albo tablet z aktualną przeglądarką internetową, włączoną obsługą cookies i JavaScriptu.
- **Baza danych:** do pełnego działania aplikacji wymagana jest lokalna baza PostgreSQL.

---

## Podręcznik użytkownika

### Role w systemie i uprawnienia

Dostęp do funkcji aplikacji zależy od roli użytkownika.

- **Gość:** może przeglądać stronę główną, terminarz, tabelę, kadrę, bilety jako komunikat, historię i kontakt. Nie może dodawać, edytować ani usuwać danych.
- **Kibic:** po zalogowaniu może kupić bilet, zobaczyć swoje bilety i anulować własną rezerwację. Nie ma dostępu do edycji danych klubowych.
- **Prezes:** posiada panel administracyjny. Może dodawać, edytować i usuwać mecze, drużyny, zawodników oraz zarządzać rezerwacjami biletów.

Panel prezesa jest zabezpieczony przez middleware `auth` oraz `prezes`. Samo zalogowanie jako zwykły kibic nie wystarcza do zarządzania meczami lub tabelą.

### Kluczowe ścieżki użytkownika (User Flow)

**1. Przeglądanie informacji jako gość**

Użytkownik wchodzi na stronę główną i może przejść do publicznych zakładek: `Terminarz`, `Tabela`, `Kadra`, `Bilety`, `Historia` i `Kontakt`. Terminarz, tabela i kadra pobierają dane z bazy. Gość widzi dane, ale nie widzi przycisków administracyjnych.

**2. Zakup biletu jako kibic**

Kibic zakłada konto lub loguje się do systemu. Następnie przechodzi do zakładki `Bilety`, wybiera mecz, trybunę i typ biletu. Po zapisaniu formularza system generuje kod biletu, np. `STAL-1234-XYZ`. Jeden kibic może kupić maksymalnie jeden bilet na jeden mecz.

**3. Zarządzanie terminarzem jako prezes**

Prezes loguje się na konto `prezes@stal.pl`, przechodzi do zakładki `Terminarz` i widzi przyciski `Dodaj mecz`, `Edytuj` oraz `Usuń`. Przy dodawaniu meczu wybiera przeciwnika z listy drużyn, ustawia datę i określa, czy mecz jest domowy czy wyjazdowy. System sprawdza dane i zapisuje rekord w bazie.

**4. Zarządzanie tabelą ligową**

Prezes może dodać, edytować i usunąć drużynę w zakładce `Tabela`. Może zmienić liczbę punktów, rozegranych meczów oraz bilans bramkowy. Po aktualizacji tabela układa drużyny według punktów.

**5. Przeglądanie i filtrowanie kadry**

Użytkownik może wyszukiwać osoby po imieniu, nazwisku albo numerze, filtrować po pozycji i sortować po statystykach. Prezes może dodatkowo dodawać i edytować zawodników oraz członków sztabu.

### Udokumentowany CRUD zależny od drugiego zasobu

Głównym przykładem CRUD w projekcie są **mecze**, które są powiązane z **drużynami**. W bazie tabela `mecze` posiada kolumnę `druzyna_id`, która wskazuje rekord z tabeli `druzyny`. Dzięki temu formularz meczu korzysta z listy drużyn, a użytkownik nie wpisuje ręcznie identyfikatora.

- **CREATE:** prezes dodaje mecz przez formularz. Wybiera drużynę z listy, podaje datę i typ meczu.
- **READ:** terminarz jest publiczną listą meczów pobieranych z bazy razem z powiązaną drużyną.
- **UPDATE:** prezes może edytować dane meczu. Przy zapisie działa ta sama walidacja co przy dodawaniu.
- **DELETE:** prezes może usunąć mecz przez formularz z metodą `DELETE` i tokenem CSRF.

Gość oraz zwykły kibic mogą przeglądać terminarz, ale nie mogą dodawać, edytować ani usuwać meczów. Gość nie może dodawać, nie może edytować i nie może usuwać zasobów administracyjnych.

### Obsługa przypadków brzegowych i walidacja

Aplikacja posiada walidację po stronie klienta i walidację po stronie serwera. Formularze HTML blokują część błędów od razu w przeglądarce, a kontrolery Laravel sprawdzają dane ponownie przed zapisem do bazy.

System obsługuje m.in. następujące przypadki:

- błędny PESEL przy rejestracji,
- imię albo nazwisko złożone z cyfr,
- zbyt słabe hasło,
- data meczu z przeszłości,
- data meczu dalsza niż rok do przodu,
- numer zawodnika poza zakresem,
- ujemne punkty lub statystyki,
- nazwa drużyny złożona wyłącznie z cyfr,
- próba kupienia drugiego biletu na ten sam mecz,
- próba wejścia do panelu prezesa bez roli prezesa.

Jeżeli użytkownik wpisze błędne dane, system nie zapisze formularza i pokaże komunikat z informacją, co trzeba poprawić.

---


## Kontrola danych i sortowanie

Walidacja po stronie klienta działa w formularzach HTML i ogranicza błędy przed wysłaniem danych. Walidacja po stronie serwera działa w kontrolerach Laravel i chroni bazę danych przed niepoprawnymi wartościami. Sortowanie jest używane m.in. w tabeli ligowej, kadrze oraz biletach.

---
## Wizualny opis interfejsu

Aplikacja ma responsywny layout, który dopasowuje elementy do ekranów komputerów, laptopów i tabletów. Poniższe zrzuty pokazują najważniejsze widoki systemu.

![Strona główna aplikacji](zdjecia/strona_glowna.png)
*Strona główna aplikacji widoczna dla gościa. Pokazuje podstawowe informacje o klubie oraz dane pobierane z bazy, np. najbliższy mecz.*

![Ekran logowania](zdjecia/panel_logowania.png)
*Ekran logowania do systemu. Po poprawnym zalogowaniu aplikacja rozpoznaje rolę użytkownika i pokazuje odpowiednie opcje.*

![Terminarz dla gościa](zdjecia/terminarz.png)
*Publiczny terminarz meczów. Gość może przeglądać dane, ale nie widzi przycisków edycji ani usuwania.*

![Terminarz dla prezesa](zdjecia/terminarz_prezes.png)
*Terminarz po zalogowaniu jako prezes. Widoczne są akcje administracyjne: dodawanie, edycja i usuwanie meczów.*

![Formularz dodawania meczu](zdjecia/formularz_mecz.png)
*Formularz CRUD dla meczu. Prezes wybiera drużynę z listy, ustawia datę i miejsce rozgrywania meczu. Formularz ma walidację po stronie klienta i serwera.*

![Tabela ligowa](zdjecia/tabela.png)
*Tabela ligowa Betclic 2. Ligi. Drużyny są uporządkowane według punktów, a Stal Stalowa Wola jest wyróżniona.*

![Panel edycji tabeli](zdjecia/tabela_edycja_prezes.png)
*Widok prezesa w tabeli ligowej. Prezes może edytować punkty, mecze rozegrane i bramki oraz usuwać drużyny.*

![Kadra zespołu](zdjecia/pilkarze.png)
*Zakładka kadry. Użytkownik może wyszukiwać, filtrować i sortować zawodników oraz członków sztabu.*

![Bilety dla gościa](zdjecia/bilety_gosc.png)
*Widok zakładki Bilety dla niezalogowanego użytkownika. System zachęca do logowania lub rejestracji, ponieważ zakup biletu wymaga konta.*

![Formularz biletu dla kibica](zdjecia/bilety_kibic.png)
*Formularz zakupu biletu. Kibic wybiera mecz, trybunę i typ biletu.*

![Zakupione bilety](zdjecia/bilety_zakupione.png)
*Lista biletów kibica. Rezerwacje są sortowane od najbliższego meczu do najdalszego.*

![Bilety w panelu prezesa](zdjecia/bilety_prezes.png)
*Widok prezesa z rezerwacjami. Prezes widzi pełniejsze dane kibica i może zarządzać rezerwacjami.*

![Walidacja podwójnego biletu](zdjecia/zabezpieczenie_podwojne_bilety.png)
*Przykład walidacji biznesowej. System blokuje zakup drugiego biletu na ten sam mecz przez tego samego kibica.*

![Walidacja numeru zawodnika](zdjecia/zabezpieczenie_numer_zawodnika.png)
*Przykład walidacji danych kadry. Niepoprawny numer zawodnika nie zostaje zapisany.*

![Responsywność](zdjecia/strona_glowna2.png)
*Widok strony na mniejszym ekranie. Układ dopasowuje się do szerokości okna, dzięki czemu aplikacja pozostaje czytelna.*

---

## Baza danych i przechowywane informacje

Dane są przechowywane w PostgreSQL w osobnych tabelach. Najważniejsze tabele to:

- `uzytkownicy` - konta użytkowników, role i zahashowane hasła,
- `druzyny` - drużyny używane w terminarzu oraz tabeli,
- `mecze` - terminarz meczów powiązany z drużynami,
- `pilkarze` - zawodnicy i sztab,
- `statystyki_pilkarzy` - statystyki powiązane z zawodnikami,
- `bilety` - rezerwacje i wygenerowane kody biletów,
- `sessions` - sesje zalogowanych użytkowników.

![Tabele w bazie danych](zdjecia/baza_danych_tabele.png)
*Widok tabel w pgAdmin. Pokazuje strukturę bazy używaną przez aplikację.*

![Dane w bazie](zdjecia/baza_danych_wglad.png)
*Przykładowy wgląd w dane. Dane są rozdzielone na tabele, aby ograniczyć powtarzanie informacji.*

---

## Bezpieczeństwo

W projekcie poprawiono elementy wskazane podczas sprawdzania:

- dodawanie i aktualizacja meczów są dostępne tylko dla prezesa,
- zwykły zalogowany kibic nie może zmieniać danych klubowych,
- plik `.env` nie jest publikowany
- operacje na bazie wykonują modele Eloquent,
- formularze mają walidację backendową,
- hasła są przechowywane jako hash,
- formularze zapisu, edycji i usuwania korzystają z tokenów CSRF.

![Zabezpieczenie logowania](zdjecia/zabezpieczenie_logowanie.png)
*Przykład zabezpieczenia dostępu. Użytkownik bez odpowiednich uprawnień jest kierowany do logowania albo nie widzi opcji administracyjnych.*

![Zabezpieczenie tras meczów](zdjecia/zabezpieczenie_mecze.png)
*Przykład zabezpieczenia tras związanych z meczami. Operacje administracyjne są przeznaczone tylko dla prezesa.*

---

## Plany rozbudowy

Pierwsza wersja projektu spełnia podstawowe wymagania CRUD i obsługi ról, ale można ją dalej rozwijać. W kolejnej wersji warto dodać:

- **Płatności online:** integrację z systemem płatności, aby rezerwacja biletu była połączona z realną opłatą.
- **Bilet PDF i e-mail:** automatyczne wysyłanie biletu na adres użytkownika oraz możliwość pobrania biletu w formacie PDF.
- **Raporty sprzedaży:** panel statystyk dla prezesa, np. liczba sprzedanych biletów według meczu, trybuny i typu biletu.
- **Automatyczne aktualizowanie tabeli:** możliwość wpisywania wyniku meczu i automatycznego przeliczania punktów oraz bilansu bramkowego.
- **Optymalizacja wydajności:** dodanie cache dla publicznych danych, które nie zmieniają się często, np. historii klubu lub kontaktu.

---

## Podsumowanie spełnienia wymagań na ocenę 3.0

Projekt spełnia wymagania na ocenę 3.0, ponieważ udostępnia publiczne zasoby, posiada role użytkowników oraz umożliwia wykonywanie operacji CRUD z panelu prezesa. Udokumentowany CRUD dotyczy meczów, które są powiązane z drużynami przez relację w bazie danych. Formularze posiadają walidację po stronie klienta i serwera, a dostęp do operacji administracyjnych jest ograniczony do prezesa. Gość może przeglądać dane, ale nie może ich edytować ani usuwać.

