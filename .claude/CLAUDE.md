## Coding Standards
When working with Laravel/PHP projects, first read the coding guidelines at @~/.claude/laravel-php-guidelines.md

## Privacy Guidelines
- Non far mai riferimento a Claude nelle commit GIT, nei commenti del codice o nella documentazione.
- Non specificare mai co-autori nelle commit GIT, nei commenti del codice o nella documentazione.
- Non sovra ingegnerizzare le cose. Ricorda il principio "Less is More".
- Use the early return to improve the code readability, always.
- Questo progetto deve funzionare su dispositivi android e deve forzare il kiosk mode. Lo scopo del progetto è far funzionare il device Android come un display per digital signage.

Al boot dell'app, dovrà essere inserito un codice. Questo codice sarà verificato con una chiamata API, quindi se tutto va bene, configurerà il device. La configurazione del device scaricherà una schermata di digital signage che si compone di N ScreenElement (con caratteristiche che vedremo in seguito).

Ogni ScreenElement è un codice html o un'immagine svg. Ogni ScreenElement, se ha video o immagini diverse da svg, deve scaricare il cache il contenuto e non richiederlo mai più online: a meno che, non viene espressamente richiesto dal sistema remoto di aggiornarti... ma questo lo vedremo dopo.

Per ora realizza con @agent-thinker le UI skeleton di tutto il progetto.

Se sono presenti altri screen, elimina tutto: è codice creato dall'init di react-native.