<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Harmonogram MŚ 2026</title>
    <style>
        :root {
            --bg-color: #0f172a;
            --card-bg: #1e293b;
            --accent-color: #38bdf8;
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
            --border-color: #334155;
            --live-color: #ef4444;
            
            /* Countdown status colors */
            --timer-safe: #10b981;
            --timer-warn: #f59e0b;
            --timer-danger: #ef4444;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-main);
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        header {
            text-align: center;
            margin-bottom: 30px;
        }

        h1 {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 10px;
        }

        .subtitle {
            color: var(--text-muted);
            font-size: 1.1rem;
        }

        /* Fixed / Sticky Top Global Panel */
        .countdown-container {
            background-color: rgba(17, 24, 39, 0.95);
            border: 2px solid var(--timer-safe);
            border-radius: 12px;
            padding: 15px 20px;
            text-align: center;
            margin-bottom: 30px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5);
            position: sticky;
            top: 10px;
            z-index: 1000;
            backdrop-filter: blur(8px);
            transition: border-color 0.5s ease, box-shadow 0.5s ease;
        }

        .countdown-title {
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--text-muted);
            margin-bottom: 5px;
        }

        .countdown-match {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--text-main);
            margin-bottom: 10px;
        }

        .countdown-timer {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-bottom: 10px;
        }

        .countdown-segment {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            padding: 8px 12px;
            border-radius: 8px;
            min-width: 55px;
        }

        .countdown-number {
            font-size: 1.8rem;
            font-weight: 800;
            color: var(--timer-safe);
            display: block;
            transition: color 0.5s ease;
        }

        .countdown-label {
            font-size: 0.7rem;
            color: var(--text-muted);
            text-transform: uppercase;
        }

        .milestone-badge {
            display: inline-block;
            background-color: rgba(255, 255, 255, 0.1);
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--text-main);
            border: 1px solid transparent;
            transition: all 0.3s ease;
        }

        @keyframes pulse-danger {
            0% { box-shadow: 0 0 0 0 rgba(239, 68, 68, 0.7); }
            70% { box-shadow: 0 0 0 15px rgba(239, 68, 68, 0); }
            100% { box-shadow: 0 0 0 0 rgba(239, 68, 68, 0); }
        }

        .danger-mode {
            animation: pulse-danger 1.5s infinite;
        }

        .controls {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
            flex-wrap: wrap;
            margin-top: 20px;
        }

        .search-box, .filter-box {
            flex: 1;
            min-width: 250px;
        }

        input, select {
            width: 100%;
            padding: 12px 16px;
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 8px;
            color: var(--text-main);
            font-size: 1rem;
            box-sizing: border-box;
        }

        .day-section {
            margin-bottom: 40px;
        }

        .day-title {
            font-size: 1.5rem;
            font-weight: 700;
            border-bottom: 2px solid var(--border-color);
            padding-bottom: 10px;
            margin-bottom: 20px;
            color: var(--accent-color);
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 25px;
        }

        /* Match Card Configuration */
        .match-card {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 20px;
            padding-top: 50px; /* Space for the transparent label on top */
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            position: relative;
            overflow: hidden;
            background-repeat: no-repeat;
            background-size: 80px;
            background-position: calc(100% - 10px) calc(100% - 20px);
        }

        .match-card * {
            position: relative;
            z-index: 2;
        }

        .match-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: linear-gradient(45deg, rgba(30,41,59,1) 60%, rgba(30,41,59,0.1) 100%);
            z-index: 1;
        }

        /* Transparent Embedded Top Status Label */
        .card-top-countdown {
            position: absolute;
            top: 12px;
            left: 0;
            right: 0;
            background: transparent; /* Removed background */
            border: none;
            text-align: center;
            padding: 0 10px;
            font-size: 0.85rem;
            font-weight: 700;
            color: var(--accent-color);
            z-index: 3;
            letter-spacing: 0.5px;
        }

        .match-card.finished {
            opacity: 0.4;
        }

        .match-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .time {
            font-size: 1.25rem;
            font-weight: 700;
        }

        .group-badge {
            background-color: rgba(56, 189, 248, 0.1);
            color: var(--accent-color);
            padding: 4px 8px;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .teams {
            font-size: 1.2rem;
            font-weight: 700;
            margin-bottom: 15px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.5);
        }

        .venue {
            font-size: 0.85rem;
            color: var(--text-muted);
            border-top: 1px solid var(--border-color);
            padding-top: 10px;
        }

        .no-results {
            text-align: center;
            color: var(--text-muted);
            font-size: 1.2rem;
            display: none;
        }
    </style>
</head>
<body>

<div class="container">
    <header>
        <h1>MISTRZOSTWA ŚWIATA 2026</h1>
        <div class="subtitle">Terminarz fazy grupowej według czasu polskiego</div>
    </header>

    <div class="countdown-container" id="countdown-panel">
        <div class="countdown-title" id="countdown-status">Najbliższy mecz za:</div>
        <div class="countdown-match" id="countdown-match-teams">Ładowanie danych...</div>
        <div class="countdown-timer">
            <div class="countdown-segment"><span class="countdown-number" id="cd-d">00</span><span class="countdown-label">Dni</span></div>
            <div class="countdown-segment"><span class="countdown-number" id="cd-h">00</span><span class="countdown-label">Godz</span></div>
            <div class="countdown-segment"><span class="countdown-number" id="cd-m">00</span><span class="countdown-label">Min</span></div>
            <div class="countdown-segment"><span class="countdown-number" id="cd-s">00</span><span class="countdown-label">Sek</span></div>
        </div>
        <div class="milestone-badge" id="countdown-milestone">Sprawdzanie statusu...</div>
    </div>

    <div class="controls">
        <div class="search-box">
            <input type="text" id="search" placeholder="Szukaj reprezentacji..." oninput="filterMatches()">
        </div>
        <div class="filter-box">
            <select id="group-filter" onchange="filterMatches()">
                <option value="all">Wszystkie grupy</option>
                <option value="grupa A">Grupa A</option>
                <option value="grupa B">Grupa B</option>
                <option value="grupa C">Grupa C</option>
                <option value="grupa D">Grupa D</option>
                <option value="grupa E">Grupa E</option>
                <option value="grupa F">Grupa F</option>
                <option value="grupa G">Grupa G</option>
                <option value="grupa H">Grupa H</option>
                <option value="grupa I">Grupa I</option>
                <option value="grupa J">Grupa J</option>
                <option value="grupa K">Grupa K</option>
                <option value="grupa L">Grupa L</option>
            </select>
        </div>
    </div>

    <div id="schedule">
        <div class="day-section" data-day="11 czerwca">
            <div class="day-title">11 czerwca</div>
            <div class="grid">
                <div class="match-card" data-group="grupa A" data-teams="Meksyk RPA" data-time="2026-06-11T21:00:00" style="background-image: url('https://flagcdn.com/w160/mx.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">21:00</span><span class="group-badge">Grupa A</span></div>
                    <div class="teams">Meksyk – RPA</div>
                    <div class="venue">Stadion: Mexico City</div>
                </div>
            </div>
        </div>

        <div class="day-section" data-day="12 czerwca">
            <div class="day-title">12 czerwca</div>
            <div class="grid">
                <div class="match-card" data-group="grupa A" data-teams="Korea Południowa Czechy" data-time="2026-06-12T04:00:00" style="background-image: url('https://flagcdn.com/w160/kr.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">04:00</span><span class="group-badge">Grupa A</span></div>
                    <div class="teams">Korea Południowa – Czechy</div>
                    <div class="venue">Stadion: Guadalajara</div>
                </div>
                <div class="match-card" data-group="grupa B" data-teams="Kanada Bośnia i Hercegowina" data-time="2026-06-12T21:00:00" style="background-image: url('https://flagcdn.com/w160/ca.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">21:00</span><span class="group-badge">Grupa B</span></div>
                    <div class="teams">Kanada – Bośnia i Hercegowina</div>
                    <div class="venue">Stadion: Toronto</div>
                </div>
            </div>
        </div>

        <div class="day-section" data-day="13 czerwca">
            <div class="day-title">13 czerwca</div>
            <div class="grid">
                <div class="match-card" data-group="grupa D" data-teams="USA Paragwaj" data-time="2026-06-13T03:00:00" style="background-image: url('https://flagcdn.com/w160/us.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">03:00</span><span class="group-badge">Grupa D</span></div>
                    <div class="teams">USA – Paragwaj</div>
                    <div class="venue">Stadion: Los Angeles</div>
                </div>
                <div class="match-card" data-group="grupa B" data-teams="Katar Szwajcaria" data-time="2026-06-13T21:00:00" style="background-image: url('https://flagcdn.com/w160/qa.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">21:00</span><span class="group-badge">Grupa B</span></div>
                    <div class="teams">Katar – Szwajcaria</div>
                    <div class="venue">Stadion: Santa Clara</div>
                </div>
            </div>
        </div>

        <div class="day-section" data-day="14 czerwca">
            <div class="day-title">14 czerwca</div>
            <div class="grid">
                <div class="match-card" data-group="grupa C" data-teams="Brazylia Maroko" data-time="2026-06-14T00:00:00" style="background-image: url('https://flagcdn.com/w160/br.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">00:00</span><span class="group-badge">Grupa C</span></div>
                    <div class="teams">Brazylia – Maroko</div>
                    <div class="venue">Stadion: New Jersey</div>
                </div>
                <div class="match-card" data-group="grupa C" data-teams="Haiti Szkocja" data-time="2026-06-14T03:00:00" style="background-image: url('https://flagcdn.com/w160/ht.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">03:00</span><span class="group-badge">Grupa C</span></div>
                    <div class="teams">Haiti – Szkocja</div>
                    <div class="venue">Stadion: Boston</div>
                </div>
                <div class="match-card" data-group="grupa D" data-teams="Australia Turcja" data-time="2026-06-14T06:00:00" style="background-image: url('https://flagcdn.com/w160/au.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">06:00</span><span class="group-badge">Grupa D</span></div>
                    <div class="teams">Australia – Turcja</div>
                    <div class="venue">Stadion: Vancouver</div>
                </div>
                <div class="match-card" data-group="grupa E" data-teams="Niemcy Curacao" data-time="2026-06-14T19:00:00" style="background-image: url('https://flagcdn.com/w160/de.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">19:00</span><span class="group-badge">Grupa E</span></div>
                    <div class="teams">Niemcy – Curacao</div>
                    <div class="venue">Stadion: Houston</div>
                </div>
                <div class="match-card" data-group="grupa F" data-teams="Holandia Japonia" data-time="2026-06-14T22:00:00" style="background-image: url('https://flagcdn.com/w160/nl.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">22:00</span><span class="group-badge">Grupa F</span></div>
                    <div class="teams">Holandia – Japonia</div>
                    <div class="venue">Stadion: Dallas</div>
                </div>
            </div>
        </div>

        <div class="day-section" data-day="15 czerwca">
            <div class="day-title">15 czerwca</div>
            <div class="grid">
                <div class="match-card" data-group="grupa E" data-teams="Wybrzeże Kości Słoniowej Ekwador WKS" data-time="2026-06-15T01:00:00" style="background-image: url('https://flagcdn.com/w160/ci.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">01:00</span><span class="group-badge">Grupa E</span></div>
                    <div class="teams">Wybrzeże Kości Słoniowej – Ekwador</div>
                    <div class="venue">Stadion: Filadelfia</div>
                </div>
                <div class="match-card" data-group="grupa F" data-teams="Szwecja Tunezja" data-time="2026-06-15T04:00:00" style="background-image: url('https://flagcdn.com/w160/se.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">04:00</span><span class="group-badge">Grupa F</span></div>
                    <div class="teams">Szwecja – Tunezja</div>
                    <div class="venue">Stadion: Monterrey</div>
                </div>
                <div class="match-card" data-group="grupa h" data-teams="Hiszpania Republika Zielonego Przylądka" data-time="2026-06-15T18:00:00" style="background-image: url('https://flagcdn.com/w160/es.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">18:00</span><span class="group-badge">Grupa H</span></div>
                    <div class="teams">Hiszpania – Republika Zielonego Przylądka</div>
                    <div class="venue">Stadion: Atlanta</div>
                </div>
                <div class="match-card" data-group="grupa g" data-teams="Belgia Egipt" data-time="2026-06-15T21:00:00" style="background-image: url('https://flagcdn.com/w160/be.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">21:00</span><span class="group-badge">Grupa G</span></div>
                    <div class="teams">Belgia – Egipt</div>
                    <div class="venue">Stadion: Seattle</div>
                </div>
            </div>
        </div>

        <div class="day-section" data-day="16 czerwca">
            <div class="day-title">16 czerwca</div>
            <div class="grid">
                <div class="match-card" data-group="grupa h" data-teams="Arabia Saudyjska Urugwaj" data-time="2026-06-16T00:00:00" style="background-image: url('https://flagcdn.com/w160/sa.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">00:00</span><span class="group-badge">Grupa H</span></div>
                    <div class="teams">Arabia Saudyjska – Urugwaj</div>
                    <div class="venue">Stadion: Miami</div>
                </div>
                <div class="match-card" data-group="grupa g" data-teams="Iran Nowa Zelandia" data-time="2026-06-16T03:00:00" style="background-image: url('https://flagcdn.com/w160/ir.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">03:00</span><span class="group-badge">Grupa G</span></div>
                    <div class="teams">Iran – Nowa Zelandia</div>
                    <div class="venue">Stadion: Los Angeles</div>
                </div>
                <div class="match-card" data-group="grupa i" data-teams="Francja Senegal" data-time="2026-06-16T21:00:00" style="background-image: url('https://flagcdn.com/w160/fr.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">21:00</span><span class="group-badge">Grupa I</span></div>
                    <div class="teams">Francja – Senegal</div>
                    <div class="venue">Stadion: New Jersey</div>
                </div>
            </div>
        </div>

        <div class="day-section" data-day="17 czerwca">
            <div class="day-title">17 czerwca</div>
            <div class="grid">
                <div class="match-card" data-group="grupa i" data-teams="Irak Norwegia" data-time="2026-06-17T00:00:00" style="background-image: url('https://flagcdn.com/w160/iq.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">00:00</span><span class="group-badge">Grupa I</span></div>
                    <div class="teams">Irak – Norwegia</div>
                    <div class="venue">Stadion: Boston</div>
                </div>
                <div class="match-card" data-group="grupa j" data-teams="Argentyna Algieria" data-time="2026-06-17T03:00:00" style="background-image: url('https://flagcdn.com/w160/ar.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">03:00</span><span class="group-badge">Grupa J</span></div>
                    <div class="teams">Argentyna – Algieria</div>
                    <div class="venue">Stadion: Kansas City</div>
                </div>
                <div class="match-card" data-group="grupa j" data-teams="Austria Jordania" data-time="2026-06-17T06:00:00" style="background-image: url('https://flagcdn.com/w160/at.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">06:00</span><span class="group-badge">Grupa J</span></div>
                    <div class="teams">Austria – Jordania</div>
                    <div class="venue">Stadion: Santa Clara</div>
                </div>
                <div class="match-card" data-group="grupa k" data-teams="Portugalia DR Konga" data-time="2026-06-17T19:00:00" style="background-image: url('https://flagcdn.com/w160/pt.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">19:00</span><span class="group-badge">Grupa K</span></div>
                    <div class="teams">Portugalia – DR Konga</div>
                    <div class="venue">Stadion: Houston</div>
                </div>
                <div class="match-card" data-group="grupa l" data-teams="Anglia Chorwacja" data-time="2026-06-17T22:00:00" style="background-image: url('https://flagcdn.com/w160/gb-eng.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">22:00</span><span class="group-badge">Grupa L</span></div>
                    <div class="teams">Anglia – Chorwacja</div>
                    <div class="venue">Stadion: Dallas</div>
                </div>
            </div>
        </div>

        <div class="day-section" data-day="18 czerwca">
            <div class="day-title">18 czerwca</div>
            <div class="grid">
                <div class="match-card" data-group="grupa l" data-teams="Ghana Panama" data-time="2026-06-18T01:00:00" style="background-image: url('https://flagcdn.com/w160/gh.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">01:00</span><span class="group-badge">Grupa L</span></div>
                    <div class="teams">Ghana – Panama</div>
                    <div class="venue">Stadion: Boston</div>
                </div>
                <div class="match-card" data-group="grupa k" data-teams="Uzbekistan Kolumbia" data-time="2026-06-18T04:00:00" style="background-image: url('https://flagcdn.com/w160/uz.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">04:00</span><span class="group-badge">Grupa K</span></div>
                    <div class="teams">Uzbekistan – Kolumbia</div>
                    <div class="venue">Stadion: Mexico City</div>
                </div>
                <div class="match-card" data-group="grupa A" data-teams="Czechy RPA" data-time="2026-06-18T18:00:00" style="background-image: url('https://flagcdn.com/w160/cz.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">18:00</span><span class="group-badge">Grupa A</span></div>
                    <div class="teams">Czechy – RPA</div>
                    <div class="venue">Stadion: Atlanta</div>
                </div>
                <div class="match-card" data-group="grupa B" data-teams="Szwajcaria Bośnia i Hercegowina" data-time="2026-06-18T21:00:00" style="background-image: url('https://flagcdn.com/w160/ch.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">21:00</span><span class="group-badge">Grupa B</span></div>
                    <div class="teams">Szwajcaria – Bośnia i Hercegowina</div>
                    <div class="venue">Stadion: Los Angeles</div>
                </div>
            </div>
        </div>

        <div class="day-section" data-day="19 czerwca">
            <div class="day-title">19 czerwca</div>
            <div class="grid">
                <div class="match-card" data-group="grupa B" data-teams="Kanada Katar" data-time="2026-06-19T00:00:00" style="background-image: url('https://flagcdn.com/w160/ca.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">00:00</span><span class="group-badge">Grupa B</span></div>
                    <div class="teams">Kanada – Katar</div>
                    <div class="venue">Stadion: Vancouver</div>
                </div>
                <div class="match-card" data-group="grupa A" data-teams="Meksyk Korea Południowa" data-time="2026-06-19T03:00:00" style="background-image: url('https://flagcdn.com/w160/mx.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">03:00</span><span class="group-badge">Grupa A</span></div>
                    <div class="teams">Meksyk – Korea Południowa</div>
                    <div class="venue">Stadion: Guadalajara</div>
                </div>
                <div class="match-card" data-group="grupa D" data-teams="USA Australia" data-time="2026-06-19T21:00:00" style="background-image: url('https://flagcdn.com/w160/us.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">21:00</span><span class="group-badge">Grupa D</span></div>
                    <div class="teams">USA – Australia</div>
                    <div class="venue">Stadion: Seattle</div>
                </div>
            </div>
        </div>

        <div class="day-section" data-day="20 czerwca">
            <div class="day-title">20 czerwca</div>
            <div class="grid">
                <div class="match-card" data-group="grupa C" data-teams="Szkocja Maroko" data-time="2026-06-20T00:00:00" style="background-image: url('https://flagcdn.com/w160/gb-sct.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">00:00</span><span class="group-badge">Grupa C</span></div>
                    <div class="teams">Szkocja – Maroko</div>
                    <div class="venue">Stadion: Boston</div>
                </div>
                <div class="match-card" data-group="grupa C" data-teams="Brazylia Haiti" data-time="2026-06-20T03:00:00" style="background-image: url('https://flagcdn.com/w160/br.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">03:00</span><span class="group-badge">Grupa C</span></div>
                    <div class="teams">Brazylia – Haiti</div>
                    <div class="venue">Stadion: Filadelfia</div>
                </div>
                <div class="match-card" data-group="grupa D" data-teams="Turcja Paragwaj" data-time="2026-06-20T05:00:00" style="background-image: url('https://flagcdn.com/w160/tr.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">05:00</span><span class="group-badge">Grupa D</span></div>
                    <div class="teams">Turcja – Paragwaj</div>
                    <div class="venue">Stadion: Santa Clara</div>
                </div>
                <div class="match-card" data-group="grupa F" data-teams="Holandia Szwecja" data-time="2026-06-20T19:00:00" style="background-image: url('https://flagcdn.com/w160/nl.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">19:00</span><span class="group-badge">Grupa F</span></div>
                    <div class="teams">Holandia – Szwecja</div>
                    <div class="venue">Stadion: Houston</div>
                </div>
                <div class="match-card" data-group="grupa E" data-teams="Niemcy Wybrzeże Kości Słoniowej WKS" data-time="2026-06-20T22:00:00" style="background-image: url('https://flagcdn.com/w160/de.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">22:00</span><span class="group-badge">Grupa E</span></div>
                    <div class="teams">Niemcy – WKS</div>
                    <div class="venue">Stadion: Toronto</div>
                </div>
            </div>
        </div>

        <div class="day-section" data-day="21 czerwca">
            <div class="day-title">21 czerwca</div>
            <div class="grid">
                <div class="match-card" data-group="grupa E" data-teams="Ekwador Curacao" data-time="2026-06-21T02:00:00" style="background-image: url('https://flagcdn.com/w160/ec.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">02:00</span><span class="group-badge">Grupa E</span></div>
                    <div class="teams">Ekwador – Curacao</div>
                    <div class="venue">Stadion: Kansas City</div>
                </div>
                <div class="match-card" data-group="grupa F" data-teams="Tunezja Japonia" data-time="2026-06-21T06:00:00" style="background-image: url('https://flagcdn.com/w160/tn.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">06:00</span><span class="group-badge">Grupa F</span></div>
                    <div class="teams">Tunezja – Japonia</div>
                    <div class="venue">Stadion: Monterrey</div>
                </div>
                <div class="match-card" data-group="grupa h" data-teams="Hiszpania Arabia Saudyjska" data-time="2026-06-21T18:00:00" style="background-image: url('https://flagcdn.com/w160/es.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">18:00</span><span class="group-badge">Grupa H</span></div>
                    <div class="teams">Hiszpania – Arabia Saudyjska</div>
                    <div class="venue">Stadion: Atlanta</div>
                </div>
                <div class="match-card" data-group="grupa g" data-teams="Belgia Iran" data-time="2026-06-21T21:00:00" style="background-image: url('https://flagcdn.com/w160/be.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">21:00</span><span class="group-badge">Grupa G</span></div>
                    <div class="teams">Belgia – Iran</div>
                    <div class="venue">Stadion: Los Angeles</div>
                </div>
            </div>
        </div>

        <div class="day-section" data-day="22 czerwca">
            <div class="day-title">22 czerwca</div>
            <div class="grid">
                <div class="match-card" data-group="grupa h" data-teams="Urugwaj Republika Zielonego Przylądka" data-time="2026-06-22T00:00:00" style="background-image: url('https://flagcdn.com/w160/uy.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">00:00</span><span class="group-badge">Grupa H</span></div>
                    <div class="teams">Urugwaj – Republika Zielonego Przylądka</div>
                    <div class="venue">Stadion: Miami</div>
                </div>
                <div class="match-card" data-group="grupa g" data-teams="Nowa Zelandia Egipt" data-time="2026-06-22T03:00:00" style="background-image: url('https://flagcdn.com/w160/nz.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">03:00</span><span class="group-badge">Grupa G</span></div>
                    <div class="teams">Nowa Zelandia – Egipt</div>
                    <div class="venue">Stadion: Vancouver</div>
                </div>
                <div class="match-card" data-group="grupa j" data-teams="Argentyna Austria" data-time="2026-06-22T19:00:00" style="background-image: url('https://flagcdn.com/w160/ar.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">19:00</span><span class="group-badge">Grupa J</span></div>
                    <div class="teams">Argentyna – Austria</div>
                    <div class="venue">Stadion: Dallas</div>
                </div>
                <div class="match-card" data-group="grupa i" data-teams="Francja Irak" data-time="2026-06-22T23:00:00" style="background-image: url('https://flagcdn.com/w160/fr.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">23:00</span><span class="group-badge">Grupa I</span></div>
                    <div class="teams">Francja – Irak</div>
                    <div class="venue">Stadion: Filadelfia</div>
                </div>
            </div>
        </div>

        <div class="day-section" data-day="23 czerwca">
            <div class="day-title">23 czerwca</div>
            <div class="grid">
                <div class="match-card" data-group="grupa i" data-teams="Norwegia Senegal" data-time="2026-06-23T02:00:00" style="background-image: url('https://flagcdn.com/w160/no.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">02:00</span><span class="group-badge">Grupa I</span></div>
                    <div class="teams">Norwegia – Senegal</div>
                    <div class="venue">Stadion: New Jersey</div>
                </div>
                <div class="match-card" data-group="grupa j" data-teams="Jordania Algieria" data-time="2026-06-23T05:00:00" style="background-image: url('https://flagcdn.com/w160/jo.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">05:00</span><span class="group-badge">Grupa J</span></div>
                    <div class="teams">Jordania – Algieria</div>
                    <div class="venue">Stadion: Santa Clara</div>
                </div>
                <div class="match-card" data-group="grupa k" data-teams="Portugalia Uzbekistan" data-time="2026-06-23T19:00:00" style="background-image: url('https://flagcdn.com/w160/pt.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">19:00</span><span class="group-badge">Grupa K</span></div>
                    <div class="teams">Portugalia – Uzbekistan</div>
                    <div class="venue">Stadion: Houston</div>
                </div>
                <div class="match-card" data-group="grupa l" data-teams="Anglia Ghana" data-time="2026-06-23T22:00:00" style="background-image: url('https://flagcdn.com/w160/gb-eng.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">22:00</span><span class="group-badge">Grupa L</span></div>
                    <div class="teams">Anglia – Ghana</div>
                    <div class="venue">Stadion: Boston</div>
                </div>
            </div>
        </div>

        <div class="day-section" data-day="24 czerwca">
            <div class="day-title">24 czerwca</div>
            <div class="grid">
                <div class="match-card" data-group="grupa l" data-teams="Panama Chorwacja" data-time="2026-06-24T01:00:00" style="background-image: url('https://flagcdn.com/w160/pa.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">01:00</span><span class="group-badge">Grupa L</span></div>
                    <div class="teams">Panama – Chorwacja</div>
                    <div class="venue">Stadion: Toronto</div>
                </div>
                <div class="match-card" data-group="grupa k" data-teams="Kolumbia DR Konga" data-time="2026-06-24T04:00:00" style="background-image: url('https://flagcdn.com/w160/co.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">04:00</span><span class="group-badge">Grupa K</span></div>
                    <div class="teams">Kolumbia – DR Konga</div>
                    <div class="venue">Stadion: Guadalajara</div>
                </div>
                <div class="match-card" data-group="grupa B" data-teams="Szwajcaria Kanada" data-time="2026-06-24T21:00:00" style="background-image: url('https://flagcdn.com/w160/ch.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">21:00</span><span class="group-badge">Grupa B</span></div>
                    <div class="teams">Szwajcaria – Kanada</div>
                    <div class="venue">Stadion: Vancouver</div>
                </div>
                <div class="match-card" data-group="grupa B" data-teams="Bośnia i Hercegowina Katar" data-time="2026-06-24T21:00:00" style="background-image: url('https://flagcdn.com/w160/ba.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">21:00</span><span class="group-badge">Grupa B</span></div>
                    <div class="teams">Bośnia i Hercegowina – Katar</div>
                    <div class="venue">Stadion: Seattle</div>
                </div>
            </div>
        </div>

        <div class="day-section" data-day="25 czerwca">
            <div class="day-title">25 czerwca</div>
            <div class="grid">
                <div class="match-card" data-group="grupa C" data-teams="Maroko Haiti" data-time="2026-06-25T00:00:00" style="background-image: url('https://flagcdn.com/w160/ma.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">00:00</span><span class="group-badge">Grupa C</span></div>
                    <div class="teams">Maroko – Haiti</div>
                    <div class="venue">Stadion: Atlanta</div>
                </div>
                <div class="match-card" data-group="grupa C" data-teams="Szkocja Brazylia" data-time="2026-06-25T00:00:00" style="background-image: url('https://flagcdn.com/w160/gb-sct.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">00:00</span><span class="group-badge">Grupa C</span></div>
                    <div class="teams">Szkocja – Brazylia</div>
                    <div class="venue">Stadion: Miami</div>
                </div>
                <div class="match-card" data-group="grupa A" data-teams="RPA Korea Południowa" data-time="2026-06-25T03:00:00" style="background-image: url('https://flagcdn.com/w160/za.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">03:00</span><span class="group-badge">Grupa A</span></div>
                    <div class="teams">RPA – Korea Południowa</div>
                    <div class="venue">Stadion: Monterrey</div>
                </div>
                <div class="match-card" data-group="grupa A" data-teams="Czechy Meksyk" data-time="2026-06-25T03:00:00" style="background-image: url('https://flagcdn.com/w160/cz.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">03:00</span><span class="group-badge">Grupa A</span></div>
                    <div class="teams">Czechy – Meksyk</div>
                    <div class="venue">Stadion: Mexico City</div>
                </div>
                <div class="match-card" data-group="grupa E" data-teams="Curacao Wybrzeże Kości Słoniowej WKS" data-time="2026-06-25T22:00:00" style="background-image: url('https://flagcdn.com/w160/cw.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">22:00</span><span class="group-badge">Grupa E</span></div>
                    <div class="teams">Curacao – WKS</div>
                    <div class="venue">Stadion: Filadelfia</div>
                </div>
                <div class="match-card" data-group="grupa E" data-teams="Ekwador Niemcy" data-time="2026-06-25T22:00:00" style="background-image: url('https://flagcdn.com/w160/ec.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">22:00</span><span class="group-badge">Grupa E</span></div>
                    <div class="teams">Ekwador – Niemcy</div>
                    <div class="venue">Stadion: New Jersey</div>
                </div>
            </div>
        </div>

        <div class="day-section" data-day="26 czerwca">
            <div class="day-title">26 czerwca</div>
            <div class="grid">
                <div class="match-card" data-group="grupa F" data-teams="Japonia Szwecja" data-time="2026-06-26T01:00:00" style="background-image: url('https://flagcdn.com/w160/jp.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">01:00</span><span class="group-badge">Grupa F</span></div>
                    <div class="teams">Japonia – Szwecja</div>
                    <div class="venue">Stadion: Dallas</div>
                </div>
                <div class="match-card" data-group="grupa F" data-teams="Tunezja Holandia" data-time="2026-06-26T01:00:00" style="background-image: url('https://flagcdn.com/w160/tn.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">01:00</span><span class="group-badge">Grupa F</span></div>
                    <div class="teams">Tunezja – Holandia</div>
                    <div class="venue">Stadion: Kansas City</div>
                </div>
                <div class="match-card" data-group="grupa D" data-teams="Paragwaj Australia" data-time="2026-06-26T04:00:00" style="background-image: url('https://flagcdn.com/w160/py.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">04:00</span><span class="group-badge">Grupa D</span></div>
                    <div class="teams">Paragwaj – Australia</div>
                    <div class="venue">Stadion: Santa Clara</div>
                </div>
                <div class="match-card" data-group="grupa D" data-teams="Turcja USA" data-time="2026-06-26T04:00:00" style="background-image: url('https://flagcdn.com/w160/tr.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">04:00</span><span class="group-badge">Grupa D</span></div>
                    <div class="teams">Turcja – USA</div>
                    <div class="venue">Stadion: Los Angeles</div>
                </div>
                <div class="match-card" data-group="grupa i" data-teams="Norwegia Francja" data-time="2026-06-26T21:00:00" style="background-image: url('https://flagcdn.com/w160/no.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">21:00</span><span class="group-badge">Grupa I</span></div>
                    <div class="teams">Norwegia – Francja</div>
                    <div class="venue">Stadion: Boston</div>
                </div>
                <div class="match-card" data-group="grupa i" data-teams="Senegal Irak" data-time="2026-06-26T21:00:00" style="background-image: url('https://flagcdn.com/w160/sn.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">21:00</span><span class="group-badge">Grupa I</span></div>
                    <div class="teams">Senegal – Irak</div>
                    <div class="venue">Stadion: Toronto</div>
                </div>
            </div>
        </div>

        <div class="day-section" data-day="27 czerwca">
            <div class="day-title">27 czerwca</div>
            <div class="grid">
                <div class="match-card" data-group="grupa h" data-teams="Republika Zielonego Przylądka Arabia Saudyjska" data-time="2026-06-27T02:00:00" style="background-image: url('https://flagcdn.com/w160/cv.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">02:00</span><span class="group-badge">Grupa H</span></div>
                    <div class="teams">Republika Zielonego Przylądka – Arabia Saudyjska</div>
                    <div class="venue">Stadion: Houston</div>
                </div>
                <div class="match-card" data-group="grupa h" data-teams="Urugwaj Hiszpania" data-time="2026-06-27T02:00:00" style="background-image: url('https://flagcdn.com/w160/uy.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">02:00</span><span class="group-badge">Grupa H</span></div>
                    <div class="teams">Urugwaj – Hiszpania</div>
                    <div class="venue">Stadion: Guadalajara</div>
                </div>
                <div class="match-card" data-group="grupa g" data-teams="Egipt Iran" data-time="2026-06-27T05:00:00" style="background-image: url('https://flagcdn.com/w160/eg.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">05:00</span><span class="group-badge">Grupa G</span></div>
                    <div class="teams">Egipt – Iran</div>
                    <div class="venue">Stadion: Seattle</div>
                </div>
                <div class="match-card" data-group="grupa g" data-teams="Nowa Zelandia Belgia" data-time="2026-06-27T05:00:00" style="background-image: url('https://flagcdn.com/w160/nz.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">05:00</span><span class="group-badge">Grupa G</span></div>
                    <div class="teams">Nowa Zelandia – Belgia</div>
                    <div class="venue">Stadion: Vancouver</div>
                </div>
                <div class="match-card" data-group="grupa l" data-teams="Chorwacja Ghana" data-time="2026-06-27T23:00:00" style="background-image: url('https://flagcdn.com/w160/hr.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">23:00</span><span class="group-badge">Grupa L</span></div>
                    <div class="teams">Chorwacja – Ghana</div>
                    <div class="venue">Stadion: Filadelfia</div>
                </div>
                <div class="match-card" data-group="grupa l" data-teams="Panama Anglia" data-time="2026-06-27T23:00:00" style="background-image: url('https://flagcdn.com/w160/pa.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">23:00</span><span class="group-badge">Grupa L</span></div>
                    <div class="teams">Panama – Anglia</div>
                    <div class="venue">Stadion: New Jersey</div>
                </div>
            </div>
        </div>

        <div class="day-section" data-day="28 czerwca">
            <div class="day-title">28 czerwca</div>
            <div class="grid">
                <div class="match-card" data-group="grupa k" data-teams="DR Konga Uzbekistan" data-time="2026-06-28T01:30:00" style="background-image: url('https://flagcdn.com/w160/cd.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">01:30</span><span class="group-badge">Grupa K</span></div>
                    <div class="teams">DR Konga – Uzbekistan</div>
                    <div class="venue">Stadion: Atlanta</div>
                </div>
                <div class="match-card" data-group="grupa k" data-teams="Kolumbia Portugalia" data-time="2026-06-28T01:30:00" style="background-image: url('https://flagcdn.com/w160/co.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">01:30</span><span class="group-badge">Grupa K</span></div>
                    <div class="teams">Kolumbia – Portugalia</div>
                    <div class="venue">Stadion: Miami</div>
                </div>
                <div class="match-card" data-group="grupa j" data-teams="Algieria Austria" data-time="2026-06-28T04:00:00" style="background-image: url('https://flagcdn.com/w160/dz.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">04:00</span><span class="group-badge">Grupa J</span></div>
                    <div class="teams">Algieria – Austria</div>
                    <div class="venue">Stadion: Kansas City</div>
                </div>
                <div class="match-card" data-group="grupa j" data-teams="Jordania Argentyna" data-time="2026-06-28T04:00:00" style="background-image: url('https://flagcdn.com/w160/jo.png');">
                    <div class="card-top-countdown"></div>
                    <div class="match-header"><span class="time">04:00</span><span class="group-badge">Grupa J</span></div>
                    <div class="teams">Jordania – Argentyna</div>
                    <div class="venue">Stadion: Dallas</div>
                </div>
            </div>
        </div>
    </div>

    <div id="no-results" class="no-results">Nie znaleziono meczów.</div>
</div>

<script>
    let allMatches = [];

    function initLiveSystem() {
        const cards = document.querySelectorAll('.match-card');
        allMatches = Array.from(cards).map(card => {
            return {
                element: card,
                topClock: card.querySelector('.card-top-countdown'),
                timestamp: new Date(card.getAttribute('data-time')).getTime(),
                teams: card.querySelector('.teams').innerText
            };
        });
        
        updateLiveStatus();
        setInterval(updateLiveStatus, 1000);
    }

    function updateLiveStatus() {
        const now = Date.now();
        let nextMatch = null;

        // Reset elements clear state before assigning current active labels
        allMatches.forEach(match => {
            match.topClock.innerText = ""; 
        });

        allMatches.forEach(match => {
            const matchDuration = 120 * 60 * 1000; // 2 hours
            const diff = match.timestamp - now;

            if (now > match.timestamp + matchDuration) {
                // MATCH FINISHED
                match.element.classList.add('finished');
                match.element.style.borderColor = 'var(--border-color)';
                match.topClock.innerText = "KONIEC SPOTKANIA";
                match.topClock.style.color = "var(--text-muted)";
            } else if (now >= match.timestamp && now <= match.timestamp + matchDuration) {
                // MATCH LIVE NOW
                match.element.classList.remove('finished');
                match.element.style.borderColor = 'var(--live-color)';
                match.topClock.innerText = "🔴 TRWA MECZ (LIVE)";
                match.topClock.style.color = "var(--live-color)";
            } else {
                // UPCOMING MATCH
                match.element.classList.remove('finished');
                match.element.style.borderColor = 'var(--border-color)';

                // Track the closest next match globally
                if (!nextMatch || match.timestamp < nextMatch.timestamp) {
                    nextMatch = match;
                }
            }
        });

        // --- APPLY COUNTDOWN ONLY TO THE NEAREST UPCOMING MATCH ---
        if (nextMatch) {
            const diff = nextMatch.timestamp - now;
            const d = Math.floor(diff / (1000 * 60 * 60 * 24));
            const h = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            const m = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
            const s = Math.floor((diff % (1000 * 60)) / 1000);

            let countdownString = "";
            if (d > 0) countdownString += `${d}d `;
            countdownString += `${String(h).padStart(2, '0')}g ${String(m).padStart(2, '0')}m ${String(s).padStart(2, '0')}s`;

            nextMatch.topClock.innerText = `ZACZNIE SIĘ ZA: ${countdownString}`;
            nextMatch.topClock.style.color = "var(--accent-color)";
        }

        // --- GLOBAL STICKY DASHBOARD CONTAINER SYNC ---
        const panel = document.getElementById('countdown-panel');
        const statusTxt = document.getElementById('countdown-status');
        const teamsTxt = document.getElementById('countdown-match-teams');
        const milestoneTxt = document.getElementById('countdown-milestone');
        const timerNumbers = document.querySelectorAll('.countdown-number');

        if (nextMatch) {
            panel.style.display = 'block';
            teamsTxt.innerText = nextMatch.teams;
            
            const diff = nextMatch.timestamp - now;
            const totalMinutes = Math.floor(diff / (1000 * 60));
            const totalHours = diff / (1000 * 60 * 60);

            const days = Math.floor(diff / (1000 * 60 * 60 * 24));
            const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
            const seconds = Math.floor((diff % (1000 * 60)) / 1000);

            document.getElementById('cd-d').innerText = String(days).padStart(2, '0');
            document.getElementById('cd-h').innerText = String(hours).padStart(2, '0');
            document.getElementById('cd-m').innerText = String(minutes).padStart(2, '0');
            document.getElementById('cd-s').innerText = String(seconds).padStart(2, '0');

            let currentColor = 'var(--timer-safe)';
            let milestoneMessage = 'Oczekiwanie na mecz';
            panel.classList.remove('danger-mode');

            if (totalMinutes <= 10) {
                currentColor = 'var(--timer-danger)';
                milestoneMessage = '🚨 OSTATNIE 10 MINUT! Zaraz zaczynamy!';
                panel.classList.add('danger-mode');
            } else if (totalMinutes <= 15) {
                currentColor = 'var(--timer-danger)';
                milestoneMessage = '⏱️ Tylko 15 minut do meczu! Piłkarze w tunelu!';
            } else if (totalMinutes <= 30) {
                currentColor = 'var(--timer-warn)';
                milestoneMessage = '⏳ Pół godziny do pierwszego gwizdka!';
            } else if (totalHours <= 1.0) {
                currentColor = 'var(--timer-warn)';
                milestoneMessage = '📢 Została niespełna godzina! Sprawdź składy!';
            } else if (totalHours <= 6.0) {
                milestoneMessage = '🔥 Mniej niż 6 godzin! Emocje rosną!';
            } else if (totalHours <= 12.0) {
                milestoneMessage = '⚡ Wielkie starcie już za niecałe 12 godzin!';
            } else if (totalHours <= 24.0) {
                milestoneMessage = '📅 Odliczanie rozpoczęte: Ostatnia doba do meczu!';
            } else {
                milestoneMessage = '⚽ Do meczu zostało jeszcze trochę czasu.';
            }

            panel.style.borderColor = currentColor;
            timerNumbers.forEach(num => num.style.color = currentColor);
            milestoneTxt.innerText = milestoneMessage;
            milestoneTxt.style.borderColor = currentColor;

        } else {
            statusTxt.innerText = "Faza grupowa zakończona";
            teamsTxt.innerText = "Brak nadchodzących spotkań.";
            milestoneTxt.innerText = "Koniec meczów w tej fazie.";
            document.getElementById('cd-d').innerText = "00";
            document.getElementById('cd-h').innerText = "00";
            document.getElementById('cd-m').innerText = "00";
            document.getElementById('cd-s').innerText = "00";
        }
    }

    function filterMatches() {
        const searchText = document.getElementById('search').value.toLowerCase().trim();
        const selectedGroup = document.getElementById('group-filter').value.toLowerCase();
        const daySections = document.querySelectorAll('.day-section');
        const noResults = document.getElementById('no-results');
        let totalVisibleMatches = 0;

        daySections.forEach(section => {
            const cards = section.querySelectorAll('.match-card');
            let visibleInSection = 0;

            cards.forEach(card => {
                const cardGroup = card.getAttribute('data-group').toLowerCase();
                const cardTeams = card.getAttribute('data-teams').toLowerCase();
                const matchesSearch = cardTeams.includes(searchText);
                const matchesGroup = (selectedGroup === 'all' || cardGroup === selectedGroup);

                if (matchesSearch && matchesGroup) {
                    card.style.display = 'flex';
                    visibleInSection++;
                    totalVisibleMatches++;
                } else {
                    card.style.display = 'none';
                }
            });

            section.style.display = visibleInSection > 0 ? 'block' : 'none';
        });

        noResults.style.display = totalVisibleMatches === 0 ? 'block' : 'none';
    }

    window.addEventListener('DOMContentLoaded', initLiveSystem);
</script>

</body>
</html>
