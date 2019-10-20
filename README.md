<p align="center">
<img src="img/framework.png" width="300">
</p>

Artwork & demo app icon kindly provided by [Alessandro Vercellino](mailto:independentdesign@outlook.it).

## Usage

```swift
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

Most of the data is scraped from websites, hence fetching times may vary.

Scraping is done by adding a hidden `WKWebView` behind all other views in the `keyWindow`.
Once the web view finishes loading, the post-render HTML is then parsed with `SwiftSoup` and the data populated.

# Demo App

![app-icon](img/app-icon.png)

A demo app is included to show the currently availble data, and how to fetch it.

# Installation

ProntoSoccorsoKit can easily be integrated via SwiftPM, Carthage or Cocoapods.

## SwiftPM

Add this github repo to Xcode 11.x
> File -> Swift Packages -> Add Swift Dependency

and enter:

`https://github.com/Zi0P4tch0/ProntoSoccorsoKit`

Link **ProntoSoccorsoKit** against your app target.

## Carthage

`github "Zi0P4tch0/ProntoSoccorsoKit" "0.1.0"`

## Cocoapods

```ruby
target YourApp do
    pod "ProntoSoccorsoKit", "~>0.1.0"
end
```

## App Transport Security

```
```
# Contribute

```
```

# License

>Copyright (c) 2019 Matteo Pacini
>
>Permission is hereby granted, free of charge, to any person obtaining a copy
>of this software and associated documentation files (the "Software"), to deal
>in the Software without restriction, including without limitation the rights
>to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>copies of the Software, and to permit persons to whom the Software is
>furnished to do so, subject to the following conditions:
>
>The above copyright notice and this permission notice shall be included in all
>copies or substantial portions of the Software.
>
>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
>AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>SOFTWARE.