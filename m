Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792664931;
	b=FYs5Zlvp49G8S/0ypVaE8Z9G6LY/wOyY6Xdm8IRnz9ANkAWIY/WNuGBxh5oGS8ufC//+
	 QvpejKuyybg0purn6FkrHnmNRGvaNR59upk/Jp/CR8okuSz2XEH20XxhR3AM7+u2IuScH
	 QFC4FRDVGgl2pobscO8Rdh8bs5Nd07IEh6HWg/dAObs1r23jbxFhW1lbBTGr2oUakw+mK
	 XGE8esX2CcBrxvgm2GGJc/4tH+4XOGgjZcHPDNiJLQKg+pnx1EmhI+DxtOOA60bXqMK61
	 Gf3e7GkrQyYIhn7SJRdXN5MoNJ9ldH7vp8V22nPMwAA9E+DVcHTJfRymTCXqBkJwVtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6CF33eXmXdf4Wc/z+SGcXu47kHs9TcOdOxXud5wQjXA=;
	b=Yusy1dRdN9cp1fWuM6atZT6MFDHfqiNJPxnTQ048dTqNdVp1TrPIVAsKp6YQgkuaVUuH
	 oK3nlT2H1bu4wmVtKGU+7ZNgNT3Snemxv+9E7i9/aLw7GKMbLhVwKAAzg8jkeeszJQ/Cy
	 liSLfXlz0unb4r9/Hz4gKQWumvQPnpKhSaI1S4UMdkhO0c8OEfTL3FOulno0KltbTyZOv
	 jqdrOnEBkEIxEf2Lc1T1apdRAg61eMcsFOurQ/3WmvDRI6HNtBppODdmEehdFlM3Oi5u9
	 ls9GrWlFEKX3dyHySammKXozWMDsBPspjouQkDBTZIpn06q2VKTVcnfkno3uuUU9YVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IykMffJA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCC0606A322
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 10:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBCC0606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IykMffJA
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8ab38a051aaso16669067b3.3
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 03:28:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792664929; cv=none;
        d=google.com; s=arc-20260327;
        b=ekVYbQU9YASA+i5Kv3c+7GqO3vZu4qpgkyCA8fE9AkRCBz7mIkKiPZTxjtNlSnXoYn
         lZy6toGRr6nCl1MBkezV3u829OMYBQnehSDXxSNqsfc2nAANJzPY//lBwds6Z2ED6s5Z
         Hj8DDp5rTCH6sC5XG2DtW6BxkB8nKNX8ew0sHS/Vm52PKvbUzsA7G2Q7X7dyFXOsSeRt
         Lorkr2RAh3Bhqqra2AKcuAuKLRZ1gA8E8ZxCYuzpE6ho8FT9Aa4tWeHBDL5NKkQi260T
         /BrKgP5zWufwJs1Gpuv14fvig+JiSyo9avN+Xjo5ZexGGUq+RWA7rptQ9pL+Qtxo86sB
         QOPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6CF33eXmXdf4Wc/z+SGcXu47kHs9TcOdOxXud5wQjXA=;
        fh=gW61tx9YOeVZWSsKUgMbavuWRjtCnPfRMTvYDfMhhBo=;
        b=X3vT6fR7adz9yNeY5QVkEaGImWKNy/pJQg6IGAQ6wK53vW43L0oRbyCYngnOzJvayO
         KNaoKc4fxl8UbYV9OdXFS2dAWnarJ6Zov9sbJGK+NPpMM6ziwPUhKy1z1tPWNnjlpa2w
         +l0iXVROR3m112ZUJtN9TYlkWQqs9+DeAdftmy/55F5H95cj4imssHKzfDLk2f0dYYF8
         n9+B6OUfj0udz3jAEgcee75siWIqk4V8NTFNZPLeOoMLkEP/nr0PVp6hhlIrGZFSmRQM
         kvEaXb8+q07KAH59G2FpXQBl1/3fLHixBxj3oQEw5n662QL6qM2rI4Mx6gJJmiXRrqzl
         bjiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792664929; x=1793269729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6CF33eXmXdf4Wc/z+SGcXu47kHs9TcOdOxXud5wQjXA=;
        b=IykMffJAuUpPwuV2jq4VR+6jcZSq90vxBgRwl1P2vCo1jyFJqHyqQGFZ8vpeQguzc3
         +2guTUGYzgK01vznWqzJKtpRooluq1UH7gs4iO0JX9zAw+telAZSnEbztG29PsrjcLDi
         NZp1Ss9d6Cpxye0ebozrJOjhQ/D6iMnevCHJaV9j5OMWF9qn50AwUoV2p6m9wkRWrZjz
         /IoZ+FRhKvRzKlWzbVqai2zGs9FjQTIuqGaWjUZ33faV2oSLgN6qGDUo5owhW8BIlwRs
         ZDI9LS6vWomab54tcpj8EO4hqvzai7huquhoK9AsSEExH7UVIwc8JdAmPFiMYy++8/xO
         2FTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792664929; x=1793269729;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6CF33eXmXdf4Wc/z+SGcXu47kHs9TcOdOxXud5wQjXA=;
        b=EjDUtQPmpMcTVCFf4nkMBZgj26gtGbBqzeVBCrY3f5qoU30HWMlke+5fYcOybCXluC
         d/oFkDK9Z909hly1Z4+jiTfO9FUghbPLeVmeynebnjk8D/l1A+vut41j2AOAecqe6cWy
         IOD4CbjtYQwmOS/CsZuQ+owANqe6NKrJEGuaT302YKImwKH+bYDne0b1TmdNTMW8zwfo
         aP7FtePMWrEdP8r47qzdzbHgrt3j8PGkawJqCfOA4gV909HiwQ8HpPLFNdNDh/Hj9Pbo
         zjFSpsSLNWZ3WcxUujvElzLTMHrf660mKbK+8HIlDpBYrwoCp7FmveIYynleZtn4UGM8
         HDZw==
X-Forwarded-Encrypted: i=1; AKwUvByZ8Ys10jqwkvbqRtGH5LfK7BDXZQ0ButoxUEI03purFCfDZdvyc0G9h7RkVNqzww1QT+A=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCH16kqIrJxjuDI9VSNl7l3WNLQoj91etT6slapbEcfOWHHC7P
	3BPtj54pywBoaxKOdgi2BAj2ZWf3LiDXE70AAbMnbsygXM+oFelQGUSMAx04uSAO/4c9Jcn5P3O
	6wKMjRtJ1clqc0Rp/M4O1l0MrEZJi4Tc=
X-Gm-Gg: AYBFou24d3glxTm134w1bNr5u07agdrDe4lXw9YgtQoK7gQWkMcbdH5/Wsj1Q+cixw+
	dQSfEr4wC/zCtHk0gLTaCyVjf7rCJzVyxKUtrw9DQ715nFor6y/9j2YL1XG9P2g+1xXQt6kLhAe
	qwv1sQ397dl7M9iOjgtMIyL5YFEGQtj1P0SVAn4qbXPfI3cx8IDWA2I5XKYIcoTwkaEA9/pDrSj
	Y1xNLpJy0vg3cTyzeNB1iqEULUqWn4DF/TWXtgFbcGRAbs+wwms8NOgPG5whXLGOQAbYTnewf+p
	JEOax4LLozNX5ON9AKYSZI5r6fQR5DhubeOLPrxXzEz39naWxOb05bW/TGOPpwbeYLr7GgPpWl2
	T7GhWCoTx3WbOMjmNKJK8EY/sARchVqy6k4NhTI+X/zTriPGkg4ekVHlULzziczMoZGlrp7DFfG
	hovW5FsSy11NXfkA3R
X-Received: by 2002:a05:690c:6b12:b0:890:659e:3c84 with SMTP id
 00721157ae682-8b133f861cfmr30266177b3.57.1792664928818; Thu, 22 Oct 2026
 03:28:48 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021-g2ul_sci-v2-0-b4e038220018@bp.renesas.com>
 <20261021-g2ul_sci-v2-2-b4e038220018@bp.renesas.com> <sashiko-outbox-180317@kernel.org>
In-Reply-To: <sashiko-outbox-180317@kernel.org>
From: Biju Das <biju.das.au@gmail.com>
Date: Thu, 22 Oct 2026 11:28:36 +0100
X-Gm-Features: AclHuK-AinZtZpEbw8ja_Ez1_fDlTzuBgrsh9qdoyukinCDoeNVZ4fuD5VuBoyY
Message-ID: <CADT+UeCyngEgqPwU1w=9Kh3AxGsFmEUDxb4Z8zWw0xg0zmTpRA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] serial: sh-sci: Keep TX enabled on TEI while data
 is pending
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org, kvm@vger.kernel.org, 
	wsa+renesas@sang-engineering.com, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 2:38=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [High] serial: sh-sci: TX stall in sci_tx_end_interrupt() on x_char whe=
n stopped
> - [High] serial: sh-sci: lock drop race in sci_tx_end_interrupt() before =
TX handoff
> - [Medium] serial: sh-sci: sci_tx_end_interrupt() clears TE without check=
ing TEND
> --
>
> commit 24fb279b2944cfab75c45c919854637a4575564b
> Author: Biju Das <biju.das.jz@bp.renesas.com>
>
> serial: sh-sci: Keep TX enabled on TEI while data is pending
>
> This commit updates sci_tx_end_interrupt() to check for pending transmit =
data
> under the port lock before disabling the transmitter, handing over to
> sci_tx_interrupt() when data is waiting. It also adds tie and teie bit ma=
sks
> to struct sci_port_params_bits for the supported port variants.
>
> > diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> > index 9eb297dbc9010..58120b523ca1e 100644
> > --- a/drivers/tty/serial/sh-sci.c
> > +++ b/drivers/tty/serial/sh-sci.c
>
> [ ... ]
>
> > @@ -2012,6 +2016,7 @@ static irqreturn_t sci_tx_end_interrupt(int irq, =
void *ptr)
> >  {
> >       struct uart_port *port =3D ptr;
> >       struct sci_port *s =3D to_sci_port(port);
> > +     struct tty_port *tport =3D &port->state->port;
> >       const struct sci_common_regs *regs =3D s->params->common_regs;
> >       unsigned long flags;
> >       u32 ctrl;
> > @@ -2020,8 +2025,17 @@ static irqreturn_t sci_tx_end_interrupt(int irq,=
 void *ptr)
> >               return sci_tx_interrupt(irq, ptr);
> >
> >       uart_port_lock_irqsave(port, &flags);
> > -     ctrl =3D s->ops->read_reg(port, regs->control) &
> > -             ~(s->params->param_bits->te_clear);
> > +     ctrl =3D s->ops->read_reg(port, regs->control);
> > +     if (port->x_char || (!kfifo_is_empty(&tport->xmit_fifo) &&
> > +                          !uart_tx_stopped(port))) {
> > +             ctrl &=3D ~(s->params->param_bits->teie);
> > +             ctrl |=3D s->params->param_bits->tie;
> > +             s->ops->write_reg(port, regs->control, ctrl);
>
> [Severity: High]
> What happens here when port->x_char is non-zero while uart_tx_stopped(por=
t)
> is true and tport->xmit_fifo is not empty?
>
> In that case, sci_tx_end_interrupt() clears param_bits->teie, sets
> param_bits->tie, and calls sci_tx_interrupt() -> s->ops->transmit_chars(p=
ort).
> In both drivers/tty/serial/sh-sci.c:sci_transmit_chars() and
> drivers/tty/serial/rsci.c:rsci_transmit_chars(), the loop sends port->x_c=
har,
> clears port->x_char =3D 0, and breaks out on the next iteration because s=
topped
> is true:
>
>         do {
>                 unsigned char c;
>
>                 if (port->x_char) {
>                         c =3D port->x_char;
>                         port->x_char =3D 0;
>                 } else if (stopped || !kfifo_get(&tport->xmit_fifo, &c)) =
{
>                         break;
>                 }
>
> However, at the end of sci_transmit_chars() and rsci_transmit_chars(),
> param_bits->tie is only cleared and param_bits->teie is only re-enabled w=
hen
> tport->xmit_fifo is empty:
>
> drivers/tty/serial/sh-sci.c:sci_transmit_chars() {
>         ...
>         if (kfifo_is_empty(&tport->xmit_fifo)) {
>                 if (s->type =3D=3D PORT_SCI) {
>                         ctrl =3D sci_serial_in(port, SCSCR);
>                         ctrl &=3D ~SCSCR_TIE;
>                         ctrl |=3D SCSCR_TEIE;
>                         sci_serial_out(port, SCSCR, ctrl);
>                 }
>
>                 sci_stop_tx(port);
>         }
> }
>
> drivers/tty/serial/rsci.c:rsci_transmit_chars() {
>         ...
>         if (kfifo_is_empty(&tport->xmit_fifo)) {
>                 ctrl =3D rsci_serial_in(port, CCR0);
>                 ctrl &=3D ~CCR0_TIE;
>                 ctrl |=3D CCR0_TEIE;
>                 rsci_serial_out(port, CCR0, ctrl);
>         }
> }
>
> Because tport->xmit_fifo is still non-empty while the port is stopped,
> param_bits->tie remains set and param_bits->teie remains cleared after
> port->x_char has been written:
>
> 1. On sci ports without hardware status auto-clear, when the transmit dat=
a
>    register empties and triggers sci_tx_interrupt() again with
>    port->x_char =3D=3D 0 and stopped =3D=3D 1, sci_transmit_chars() break=
s out of the
>    loop without writing a new byte and calls s->ops->clear_SCxSR(), causi=
ng
>    the hardware to repeatedly re-transmit the stale byte in the data regi=
ster
>    in an interrupt loop.
>
> 2. On both sci and rsci ports, because param_bits->teie is cleared,
>    sci_tx_end_interrupt() never fires after port->x_char finishes shiftin=
g
>    out, so transmit-enable is never cleared. When the port is later unsto=
pped
>    and uart_start() calls sci_start_tx() or rsci_start_tx(), transmit-ena=
ble
>    and param_bits->tie are already set in regs->control, producing no ris=
ing
>    edge to trigger the transmit interrupt and stalling the remaining data=
 in
>    tport->xmit_fifo.
>
> Could sci_transmit_chars() and rsci_transmit_chars() also switch back fro=
m
> param_bits->tie to param_bits->teie when stopped is true?
>
> > +             uart_port_unlock_irqrestore(port, flags);
> > +             return sci_tx_interrupt(irq, ptr);
> > +     }
>
> [Severity: High]
> Does dropping port->lock here before calling sci_tx_interrupt() introduce=
 a
> race window with concurrent port operations?
>
> sci_tx_interrupt() immediately re-acquires port->lock to invoke
> s->ops->transmit_chars(port):
>
> drivers/tty/serial/sh-sci.c:sci_tx_interrupt() {
>         ...
>         uart_port_lock_irqsave(port, &flags);
>         s->ops->transmit_chars(port);
>         uart_port_unlock_irqrestore(port, flags);
>         ...
> }
>
> Between uart_port_unlock_irqrestore() in sci_tx_end_interrupt() and
> uart_port_lock_irqsave() in sci_tx_interrupt(), another processor can acq=
uire
> port->lock:
>
> 1. In drivers/tty/serial/sh-sci.c:sci_shutdown():
>
>         uart_port_lock_irqsave(port, &flags);
>         s->port.ops->stop_rx(port);
>         s->port.ops->stop_tx(port);
>         s->ops->shutdown_complete(port);
>         uart_port_unlock_irqrestore(port, flags);
>
>    If sci_shutdown() runs during the unlock window before sci_free_irq(s)=
,
>    sci_tx_interrupt() will subsequently run s->ops->transmit_chars(port)
>    after shutdown_complete(), writing to the transmit data register and
>    re-arming transmit interrupts on a shut-down port.
>
> 2. If uart_stop() runs in the window, it sets tty->flow.stopped and calls
>    stop_tx() to clear param_bits->tie. When s->ops->transmit_chars(port)
>    then runs with stopped set and a non-empty tport->xmit_fifo, no byte i=
s
>    written and param_bits->teie is not set, leaving transmit-enable set w=
ith
>    both param_bits->tie and param_bits->teie cleared so a later
>    sci_start_tx() or rsci_start_tx() sees no rising edge on transmit-enab=
le
>    and stalls.
>
> 3. If uart_flush_buffer() or a concurrent sci_tx_interrupt() drains
>    tport->xmit_fifo during the window, s->ops->transmit_chars(port) runs =
with
>    an empty fifo and clears status without writing a new byte.
>
> Could sci_tx_end_interrupt() call s->ops->transmit_chars(port) directly w=
hile
> still holding port->lock instead of unlocking and calling sci_tx_interrup=
t()?
>
> > +
> > +     ctrl &=3D ~(s->params->param_bits->te_clear);
> >       s->ops->write_reg(port, regs->control, ctrl);
> >       uart_port_unlock_irqrestore(port, flags);
>
> [Severity: Medium]
> Can clearing param_bits->te_clear here cut off a byte that was just writt=
en
> to the transmit register by a concurrent sci_tx_interrupt()?
>
> When sci_transmit_chars() or rsci_transmit_chars() writes the final byte =
from
> tport->xmit_fifo, it clears param_bits->tie and sets param_bits->teie whi=
le
> the byte is still draining. If uart_write() queues a new byte before that
> transmission finishes, drivers/tty/serial/sh-sci.c:sci_start_tx():
>
>                 if (s->type =3D=3D PORT_SCI)
>                         ctrl |=3D SCSCR_TE;
>
>                 sci_serial_out(port, SCSCR, ctrl | SCSCR_TIE);
>
> and drivers/tty/serial/rsci.c:rsci_start_tx():
>
>         ctrl =3D rsci_serial_in(port, CCR0);
>         ctrl |=3D CCR0_TIE | CCR0_TE;
>         rsci_serial_out(port, CCR0, ctrl);
>
> set param_bits->tie without clearing param_bits->teie.
>
> If the previous byte finishes shifting out and triggers
> sci_tx_end_interrupt() while sci_tx_interrupt() runs on another processor=
 and
> moves the newly queued byte from tport->xmit_fifo into the data register
> (leaving tport->xmit_fifo empty again), sci_tx_end_interrupt() will see
> port->x_char =3D=3D 0 and kfifo_is_empty(&tport->xmit_fifo) and clear
> param_bits->te_clear while the new byte is still in the hardware register=
.
>
> Should sci_tx_end_interrupt() verify that param_bits->poll_sent_bits is s=
till
> set in regs->status before clearing param_bits->te_clear (or should
> sci_start_tx() and rsci_start_tx() clear param_bits->teie)?
>
> >
>
> >       return IRQ_HANDLED;
> >  }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-g2ul_sci=
-v2-0-b4e038220018@bp.renesas.com?part=3D2

Modified patch based on rhe above review.

From 4ebe5978f806e7cbf6690ecab116d660c210929b Mon Sep 17 00:00:00 2001
From: Biju Das <biju.das.jz@bp.renesas.com>
Date: Mon, 19 Oct 2026 18:01:10 +0100
Subject: [PATCH 2/4] serial: sh-sci: Keep TX enabled on TEI while data is
 pending

sci_tx_end_interrupt() handles the transmit-end interrupt (TEI) on
SCI and RSCI ports by clearing TE and TEIE, which turns the
transmitter off. It does this unconditionally, even if the xmit kfifo
was refilled, or an x_char was queued, after the last byte was written
to the data register and before TEI fired. The pending data is then not
sent until the transmitter is re-enabled, so output stalls or is lost.

Check for pending data (x_char, or a non-empty xmit kfifo on a port
that is not stopped) before shutting the transmitter down. If there is
any, clear TEIE, set TIE and hand over to the port's transmit_chars()
op so transmission continues normally. The existing TE/TEIE teardown
path only runs once nothing is left to send.

When the port is stopped with data still queued, the transmit_chars()
paths (sci_transmit_chars() and rsci_transmit_chars()) now also swap
TIE for TEIE, as they already did for an empty kfifo. Without this, TIE
would keep firing with nothing the driver is allowed to send, and TEI
would never be raised to complete the transmission.

To keep the handler independent of the register layout, add tie and
teie masks to struct sci_port_params_bits and populate them for the
SCI, SCIF and RSCI variants.

Fixes: d61ae331d6f3 ("tty: serial: sh-sci: Add support for tx end
interrupt handling")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/rsci.c          |  4 ++-
 drivers/tty/serial/sh-sci-common.h |  2 ++
 drivers/tty/serial/sh-sci.c        | 47 +++++++++++++++++++++++-------
 3 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 40db9daa4272..0391111db8ae 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -465,7 +465,7 @@ static void rsci_transmit_chars(struct uart_port *port)
  if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
  uart_write_wakeup(port);

- if (kfifo_is_empty(&tport->xmit_fifo)) {
+ if (kfifo_is_empty(&tport->xmit_fifo) || stopped) {
  ctrl =3D rsci_serial_in(port, CCR0);
  ctrl &=3D ~CCR0_TIE;
  ctrl |=3D CCR0_TEIE;
@@ -627,6 +627,8 @@ static const struct sci_port_params_bits
rsci_port_param_bits =3D {
  .rxtx_enable =3D CCR0_RE | CCR0_TE,
  .te_clear =3D CCR0_TE | CCR0_TEIE,
  .poll_sent_bits =3D CSR_TDRE | CSR_TEND,
+ .tie =3D CCR0_TIE,
+ .teie =3D CCR0_TEIE
 };

 static const struct sci_port_params rsci_rzg3e_port_params =3D {
diff --git a/drivers/tty/serial/sh-sci-common.h
b/drivers/tty/serial/sh-sci-common.h
index 01ff9fced803..273856fbc20b 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -56,6 +56,8 @@ struct sci_port_params_bits {
  unsigned int rxtx_enable;
  unsigned int te_clear;
  unsigned int poll_sent_bits;
+ unsigned int tie;
+ unsigned int teie;
 };

 struct sci_common_regs {
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 9eb297dbc901..6df25fef5a5f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -261,13 +261,17 @@ static bool sci_uart_earlycon_dev_probing;
 static const struct sci_port_params_bits sci_sci_port_params_bits =3D {
  .rxtx_enable =3D SCSCR_RE | SCSCR_TE,
  .te_clear =3D SCSCR_TE | SCSCR_TEIE,
- .poll_sent_bits =3D SCI_TDRE | SCI_TEND
+ .poll_sent_bits =3D SCI_TDRE | SCI_TEND,
+ .tie =3D SCSCR_TIE,
+ .teie =3D SCSCR_TEIE
 };

 static const struct sci_port_params_bits sci_scif_port_params_bits =3D {
  .rxtx_enable =3D SCSCR_RE | SCSCR_TE,
  .te_clear =3D SCSCR_TE | SCSCR_TEIE,
- .poll_sent_bits =3D SCIF_TDFE | SCIF_TEND
+ .poll_sent_bits =3D SCIF_TDFE | SCIF_TEND,
+ .tie =3D SCSCR_TIE,
+ .teie =3D SCSCR_TEIE
 };

 static const struct sci_common_regs sci_common_regs =3D {
@@ -1007,6 +1011,20 @@ static int sci_rxfill(struct uart_port *port)
  *                   the interrupt related routines                       =
*
  * ********************************************************************** =
*/

+static void sci_clr_tie_set_teie(struct uart_port *port)
+{
+ struct sci_port *s =3D to_sci_port(port);
+ unsigned short ctrl;
+
+ if (s->type !=3D PORT_SCI)
+ return;
+
+ ctrl =3D sci_serial_in(port, SCSCR);
+ ctrl &=3D ~SCSCR_TIE;
+ ctrl |=3D SCSCR_TEIE;
+ sci_serial_out(port, SCSCR, ctrl);
+}
+
 static void sci_transmit_chars(struct uart_port *port)
 {
  struct tty_port *tport =3D &port->state->port;
@@ -1050,14 +1068,10 @@ static void sci_transmit_chars(struct uart_port *po=
rt)
  if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
  uart_write_wakeup(port);
  if (kfifo_is_empty(&tport->xmit_fifo)) {
- if (s->type =3D=3D PORT_SCI) {
- ctrl =3D sci_serial_in(port, SCSCR);
- ctrl &=3D ~SCSCR_TIE;
- ctrl |=3D SCSCR_TEIE;
- sci_serial_out(port, SCSCR, ctrl);
- }
-
+ sci_clr_tie_set_teie(port);
  sci_stop_tx(port);
+ } else if (stopped) {
+ sci_clr_tie_set_teie(port);
  }
 }

@@ -2012,6 +2026,7 @@ static irqreturn_t sci_tx_end_interrupt(int irq,
void *ptr)
 {
  struct uart_port *port =3D ptr;
  struct sci_port *s =3D to_sci_port(port);
+ struct tty_port *tport =3D &port->state->port;
  const struct sci_common_regs *regs =3D s->params->common_regs;
  unsigned long flags;
  u32 ctrl;
@@ -2020,8 +2035,18 @@ static irqreturn_t sci_tx_end_interrupt(int
irq, void *ptr)
  return sci_tx_interrupt(irq, ptr);

  uart_port_lock_irqsave(port, &flags);
- ctrl =3D s->ops->read_reg(port, regs->control) &
- ~(s->params->param_bits->te_clear);
+ ctrl =3D s->ops->read_reg(port, regs->control);
+ if (port->x_char || (!kfifo_is_empty(&tport->xmit_fifo) &&
+      !uart_tx_stopped(port))) {
+ ctrl &=3D ~(s->params->param_bits->teie);
+ ctrl |=3D s->params->param_bits->tie;
+ s->ops->write_reg(port, regs->control, ctrl);
+ s->ops->transmit_chars(port);
+ uart_port_unlock_irqrestore(port, flags);
+ return IRQ_HANDLED;
+ }
+
+ ctrl &=3D ~(s->params->param_bits->te_clear);
  s->ops->write_reg(port, regs->control, ctrl);
  uart_port_unlock_irqrestore(port, flags);

--=20
2.43.0
