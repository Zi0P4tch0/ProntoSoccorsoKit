# ProntoSoccorsoKit

## Usage

```swift
//Fetches list of health institutes for Regione Lazio.

ProntoSoccorso.region(.lazio).fetch { result in
    // Handle result
}

ProntoSoccorso.regions([.lazio, .friuliVeneziaGiulia]).fetch { result in
    // Handle result
}

```

## Available regions / municipalities

- [X] Lazio 
- [X] Friuli-Venezia Giulia
- [ ] Puglia
    - [X] Taranto
- [ ] Trentino-Alto Adige
    - [X] Trento
- [ ] Lombardia
    - [X] Valtellina E Alto Lario

## Scraping

Most of the data is scraped from websites, hence loading times may vary.

## Installation

```
```

## Contribute

```
```

## License

