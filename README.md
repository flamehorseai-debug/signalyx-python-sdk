# Signalyx Python SDK

Official Python client for the [Signalyx Crypto API](https://signalyx.eu) — trading signals, technical analysis, whale tracking, and market correlation.

## Installation

```bash
pip install signalyx
```

For WebSocket streaming (Pro/Expert plans):

```bash
pip install signalyx[websockets]
```

## Quick Start

```python
from signalyx import SignalyxClient

client = SignalyxClient(api_key="sk_live_your_api_key_here")

# Get trading signal
signals = client.signals.get("BTCUSDT", timeframe="1h")
for s in signals:
    print(f"{s['symbol']} → {s['signal']} (confidence: {s['confidence']}%)")

# Full technical analysis
report = client.analysis.report("ETHUSDT", timeframe="4h")
print(report["summary"])
print(f"RSI: {report['indicators']['rsi']}")
print(f"Support: {report['levels']['support']}")

# Whale activity
whales = client.whales.get("BTCUSDT")
for tx in whales["transactions"]:
    print(f"{tx['side'].upper()} ${tx['value_usd']:,.0f}")

# Market correlation
corr = client.correlation.matrix(["BTCUSDT", "ETHUSDT", "SOLUSDT"])
print(corr["matrix"])

# Check usage
usage = client.assets.usage()
print(f"API calls today: {usage['daily_used']} / {usage['daily_limit']}")
```

## WebSocket Streaming

Real-time signal streaming requires **Pro or Expert** plan.

```python
import asyncio
from signalyx import SignalyxClient

client = SignalyxClient(api_key="sk_live_your_api_key_here")

async def main():
    async for signal in client.ws.stream(symbols=["BTCUSDT", "ETHUSDT"], timeframe="1h"):
        print(f"{signal['symbol']}: {signal['signal']} @ ${signal['price']}")

asyncio.run(main())
```

## API Reference

### `client.signals`

| Method | Description |
|--------|-------------|
| `get(symbol, timeframe, limit)` | Get signals for a symbol |
| `batch(symbols, timeframe)` | Get signals for multiple symbols |
| `supported()` | List supported trading pairs |

### `client.analysis`

| Method | Description |
|--------|-------------|
| `report(symbol, timeframe)` | Full technical analysis report |
| `summary(symbol, timeframe)` | Short text summary |

### `client.whales`

| Method | Description |
|--------|-------------|
| `get(symbol, min_value, limit)` | Large transactions for a symbol |

### `client.correlation`

| Method | Description |
|--------|-------------|
| `matrix(symbols, timeframe, period)` | Correlation matrix |
| `pair(symbol_a, symbol_b, ...)` | Correlation between two assets |

### `client.assets`

| Method | Description |
|--------|-------------|
| `list()` | Supported trading pairs on your plan |
| `usage()` | Current API usage stats |

## Supported Timeframes

`15m` · `1h` · `4h` · `1d`

## Error Handling

```python
from signalyx import SignalyxClient, AuthenticationError, RateLimitError, APIError

client = SignalyxClient(api_key="sk_live_...")

try:
    signals = client.signals.get("BTCUSDT")
except AuthenticationError:
    print("Invalid API key — check your key at https://signalyx.eu/account")
except RateLimitError as e:
    print(f"Rate limit exceeded. Retry after {e.retry_after}s")
except APIError as e:
    print(f"API error {e.status_code}: {e}")
```

## Plans

| Plan | Price | Daily Requests | Assets | WebSocket |
|------|-------|---------------|--------|-----------|
| Free | €0 | 100 | Top 5 | ✗ |
| Starter | €29/mo | 1,000 | Top 20 | ✗ |
| Pro | €69/mo | 10,000 | All 50+ | ✓ |
| Expert | €219/mo | Unlimited | All 50+ | ✓ |

Get your API key at [signalyx.eu](https://signalyx.eu).

## License

MIT License. See [LICENSE](LICENSE) for details.
