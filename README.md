# DevOps Incident Lab

Break/fix training on two local VMs. A hidden script breaks something;
you get only the ticket, like an on-call engineer.

## Requirements
- VirtualBox 7.x and Vagrant 2.4+
- About 2 GB free RAM and 6 GB disk

## Start
```
vagrant up            # first time 10-15 min
vagrant ssh web
lab list
sudo lab break 1
```

## Rules
1. Write down every command and what it told you.
2. 30 minutes before `lab hint N`. Level 2 before `lab solution N`.
3. `sudo lab check N` must say RESOLVED.
4. Write `postmortems/NN.md` from `postmortems/TEMPLATE.md`, then commit.
5. Do not read `scenarios/*/*.b64`. Decoding them is cheating only yourself.

## Reset everything
```
vagrant destroy -f && vagrant up
```
Scenarios assume a healthy server. If an old incident is still broken,
fix it or reset before starting the next.

## Scenarios
| # | VM | Ticket |
| --- | --- | --- |
| 1 | web | Customers see a strange page instead of the shop |
| 2 | web | Disk full, but no big files anywhere |
| 3 | db | App cannot connect to the database |
| 4 | web | Server cannot install packages |
| 5 | web | Website returns 403 Forbidden |
| 6 | web | Server slow, CPU at 100%, problem keeps coming back |
| 7 | web | New orders-api service keeps restarting |
