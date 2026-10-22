Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792665030;
	b=sDefnbEAtPeArNdKWY3XBPOWfgGAwkU42WNg60lPCSUkDQg5JAXyMKCFMwC/A60B57o8
	 LvINH0kKJ7Mvh/CjCmbBHYWf+TiA5snnkBdACsNMgaT8e4W4qkwzrsKO6XakASHKt/iQy
	 y1SB6VqEUQNf+L0PPlC3Z5L7eyulbzn5DVPfiMPVSeWAo3nklThqnlQYuXJFlwTtmK6QN
	 d0mtb2IJwRLay1R1gveMw+WazxxjdlBlA8HhvqDjuScaSBL4Xin+HHFrv8vDCsr3qJVrW
	 n64mxZS1z6z+4DijCealGaWOG8Z1YiodEU1WdftoHnmNXT+xRuCK8U+qZj/tJsLQa0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792665030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BEhHwxYzSMiJvLdiI5HQibRaFl5gonBn5xrnfJkUhrQ=;
	b=de8UIH+w+fXmCZiAoVuqx4GXAX883U6aghZ0a34i/RYAczGS8uL/lW5lcaN73ONvY9U4
	 obkk7QtTuZPxrPm4RpiShW8olrJHa18+T7qi/3zu3il6t7iQEhrZ0lDmOqwRACEm3r2aX
	 7conZBaow8XNNOJO7PENwqJ6sYXoNtcijDbcs3bTyt7KGUoPgoPSQdreYC+YnGkkivufA
	 GBVbHH3T6wN73iaPBzHMqL4zTWhYzKYOtI2AMKugDrGhQ/YT+vJSh12+YP+Iguzv+mDr8
	 XvlGli55MVUAxhWRygho2yTLmewhmLsrBbQYMdo0u/SKENx+SOwxX9cG45PR2bvN8KQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nN9VfXDM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE4E606A321
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 10:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EE4E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nN9VfXDM
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b0f59a5fdaso14089487b3.3
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 03:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792665029; cv=none;
        d=google.com; s=arc-20260327;
        b=sih4PGKO4dq8iwBg1ecB1NHuwBjq38ANHafBDXgo2ojqy6vJRTm/DrYK4YyeXoMEcu
         /afON0vUw+s5SoUhFaMSDm91CA6A5KPxuSfxkxC0T/xYT4/j/fUepnQb2J7ZfuzmVH6g
         lPLmnmAvYNKVOim/LExz/g49Ovzt11FcBPArC4T8IwfAT29LaB3VAbMLLXAMNtSoaA28
         XDLbuQ8OUUp1jAbTCgkiiTxeuica5YNWcWT8qcla5w4edjRTPbrnSljPXWGBOXTsSlna
         TCNZDT/imO2eQFXKGBZJCFt5sVbmG2HskVr7NEg587Y2sW3tzs+4JcRJum3G71d/HJ2s
         EHog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BEhHwxYzSMiJvLdiI5HQibRaFl5gonBn5xrnfJkUhrQ=;
        fh=+/ALEMzVliZ7ScxqaPJC38NZQmQXPkKdRGFMKizh2wU=;
        b=Hf+CEakY0ItxPnvNdjZFeq+x06IGev55o4/Zi6ojPlmNzX0R5t2luQtefar3n+tlZq
         NjZhKP67/5Ndq3HdNDglyh0w0rfLQABW7034Ix1kSlJONGXe8LvpeBtzTH9Q8oS3GOyA
         uw+BWO02qKfrMwK67dB1fBDFjAtrHzgYx2aKhHUKWtYwlne65Q+MVysKsi8UYDSAYksB
         ++KGhAb2ZN7K8ce6boCh+jL+8shTX+pKh8Y6//IWeE2JDOZ0aCAhIcJpeo85mRyRyCdn
         HewaW5sVC3rhcHLWNQ5tyPEtU6TxdLC/n7H0VNPMhwUe5ByYCYUR91vViMdxW7O64AP9
         HYVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792665029; x=1793269829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BEhHwxYzSMiJvLdiI5HQibRaFl5gonBn5xrnfJkUhrQ=;
        b=nN9VfXDM0FsUz/mrgy4GZLzQ3MXPeOinIlG5V7+8d+qY0GDkEDX3vx7k5ULeH3SX87
         n4tDI1qa2sGwlUL2bC1psW5uXmYXP1jTWLPm2j/eBKEzGO4TNP8CGXcCSB0TYQQKoNrf
         K31SH4scmVzJCb3yVmwYF9bQC89rcwL3F1V3QYEcYJ1k/lvXd0GrXzHCHp+ef7aGRPDQ
         xjjW75TtK3W/5KkYjbUXiKEdXLqaARPOt7Eabp1zA5WF/KHwkgc+3sPkSVZJn6NV0vtr
         XhbFcwwkxKudvC4WN0nQ+p9qLLxmeMBNkGz8tLilb+cV+q5VXo5xVWj+erxEV0+jgNgB
         fDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792665029; x=1793269829;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BEhHwxYzSMiJvLdiI5HQibRaFl5gonBn5xrnfJkUhrQ=;
        b=V5HLe21gcBTW3bunsJ9yAVBS0QnfKv6U5dYPDfm3qE37M5DhGZ3KgrRv4Rf6Fju49X
         ZvXPgN6gNxrQNC2vyl6usg0NmMUs6jcNZ11uGp2HXTSMnuXj7cu2aNDKdgNAD1Bo0gOc
         JpjEXCZcIrudRwrFp+g6RwU7MLfeDqOd09tZP6rVNp48usHBaolC4Wc5VSMlDA8hNpjx
         fIbxLKxYo+wrcWGEjgMar9SpvYnB8klG7I5m1crmeDyglScq8Su/Ewbyq9uvg2re2+b4
         aFZT0R+QFiKTdfXeyQ6ucrfTS88PJhrLWADxEfACT179R8nYO34+gc5uaNk9I+/UAhFA
         D/Pg==
X-Forwarded-Encrypted: i=1; AKwUvBySOBvNcuc1RqUoyhl8IxVXZGkmCr9A1glXfOD2RNIXJqyO+AUPUTn4OW2f1RtmDYgvbPE=@vger.kernel.org
X-Gm-Message-State: AFq9FYI61SuTB6LkhWDdFGSGagJL6ZA0Aq3rrCwHS09H+ZxiDZemfIJu
	8XhBXbH1T1vqarDZq/PXv5G0/rNHJSx+wiMlsXiBaNV19agmkPfifjh8ZQ4g0XO/cvP9r71Rauw
	yLDQHE7Hj0Yx4xg/XPrS7IYnCnmFGI71EkGDv
X-Gm-Gg: AYBFou1ann7hgBRhykENykvzvTCqd7p0tPd+v4S74QMHa7tyAfvgbGjVh1qqxJMWboV
	eYv+akuUopYz8RwtYrg5icalefmw+VTf94essztwII58o1sLVCq9InOfnYZxiM+4JMj+hLoePNv
	GYAeOaBfUJSPsyavS3nkiAY7eTKqExGNMM4AaZF0Pn1g1rb1AFwqwRISe6UYvZM0LXDDX/zaALE
	raxS+PPrmBC+ZykBtIbPEKtWg0KNi2M4wNM+/dwtMNSgKtI2tLAnCF+NsNkHqkS20AWxWnbdnQr
	QM+aBgA0lxoEcPQUo6X12KBgyuVs/Q3+6aXvV7RGsJrygcdTS8QiiNDNx1EddIlP1cOe1L+9vFt
	x4WHnTGNA/U+qRjswpNtF/9RKIN4Xc2izvSVu3Bo05LiVGOaBPEs/MdMJVH2seoNuyCn+54Y=
X-Received: by 2002:a05:690c:6e83:b0:88a:4770:c2e9 with SMTP id
 00721157ae682-8b133cab00emr32482837b3.14.1792665028968; Thu, 22 Oct 2026
 03:30:28 -0700 (PDT)
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
 <20261021-g2ul_sci-v2-3-b4e038220018@bp.renesas.com> <sashiko-outbox-180298@kernel.org>
In-Reply-To: <sashiko-outbox-180298@kernel.org>
From: Biju Das <biju.das.au@gmail.com>
Date: Thu, 22 Oct 2026 11:29:57 +0100
X-Gm-Features: AclHuK9NxPFgx-jqOft8MHFpJQqezzJagWJDKOJP_AqiRF8xMdXQyhKNm1Uf3MY
Message-ID: <CADT+UeA_z=6o32GdhHD9KrmMpW3WRcujcED_ZvCGSoi38jrg+w@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] serial: sh-sci: Skip TDxE clear when hardware
 clears it automatically
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org, kvm@vger.kernel.org, 
	wsa+renesas@sang-engineering.com, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 2:22=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] serial: sh-sci: missing has_tdxe_auto_clear init in scix_early=
_console_setup()
> --
>
> commit 7c4175b5ac1e1b0c0d116921a097acf598dc7be1
> Author: Au Dang <au.dang.jx@renesas.com>
>
> serial: sh-sci: Skip TDxE clear when hardware clears it automatically
>
> This commit adds a tdxe_auto_clear flag to struct sci_of_data and propaga=
tes
> it to struct sci_port as has_tdxe_auto_clear to skip software clearing of
> TDxE in sci_transmit_chars() and sci_poll_put_char() on PORT_SCI variants=
.
>
> > diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> > index 58120b523ca1e..aa179c7874878 100644
> > --- a/drivers/tty/serial/sh-sci.c
> > +++ b/drivers/tty/serial/sh-sci.c
> > @@ -913,7 +913,8 @@ static void sci_poll_put_char(struct uart_port *por=
t, unsigned char c)
> >       } while (!(status & SCxSR_TDxE(port)));
> >
> >       sci_serial_out(port, SCxTDR, c);
> > -     s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(po=
rt));
> > +     if (!s->has_tdxe_auto_clear)
> > +             s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR=
_TEND(port));
> >  }
> >  #endif /* CONFIG_CONSOLE_POLL || CONFIG_SERIAL_SH_SCI_CONSOLE ||
> >         CONFIG_SERIAL_SH_SCI_EARLYCON */
>
> [ ... ]
>
> > @@ -3791,6 +3794,7 @@ static struct plat_sci_port *sci_parse_dt(struct =
platform_device *pdev,
> >       sp->ops =3D data->ops;
> >       sp->port.ops =3D data->uart_ops;
> >       sp->params =3D data->params;
> > +     sp->has_tdxe_auto_clear =3D data->tdxe_auto_clear;
>
> [Severity: Medium]
> Should scix_early_console_setup() in drivers/tty/serial/sh-sci.c also cop=
y
> data->tdxe_auto_clear to sci_ports[0].has_tdxe_auto_clear?
>
> When earlycon is enabled on a renesas,sci port, sci_early_console_setup()=
 ->
> scix_early_console_setup() initializes sci_ports[0] from of_sci_sci, but
> leaves has_tdxe_auto_clear unset:
>
> drivers/tty/serial/sh-sci.c:scix_early_console_setup() {
>         ...
>         sci_ports[0].cfg =3D &port_cfg;
>         sci_ports[0].params =3D data->params;
>         sci_ports[0].ops =3D data->ops;
>         sci_ports[0].port.ops =3D data->uart_ops;
>         sci_uart_earlycon =3D true;
>         ...
> }
>
> During early console output via serial_console_write() ->
> uart_console_write() -> serial_console_putchar() -> sci_poll_put_char(),
> s->has_tdxe_auto_clear will still be false on sci_ports[0], causing
> s->ops->clear_SCxSR() to be called in software instead of being skipped.
>
> >
> >       sp->has_rtscts =3D of_property_read_bool(np, "uart-has-rtscts");
> >
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-g2ul_sci=
-v2-0-b4e038220018@bp.renesas.com?part=3D3

Modified patch based on above review.

From 0efbe7abe7fc1ec3354fcdc1f4c02b77eaac7904 Mon Sep 17 00:00:00 2001
From: Au Dang <au.dang.jx@renesas.com>
Date: Mon, 19 Oct 2026 18:01:11 +0100
Subject: [PATCH 3/4] serial: sh-sci: Skip TDxE clear when hardware clears i=
t
 automatically

On some SCI variants, the TDxE (Transmit Data Empty) flag in SCxSR is
cleared by hardware when data is written to TDR. Clearing it again from
software via clear_SCxSR() generates a spurious TXI interrupt, causing
the last character to be transmitted twice.

Add a tdxe_auto_clear flag to struct sci_of_data, propagate it to struct
sci_port as has_tdxe_auto_clear, and skip the clear_SCxSR() call in
sci_transmit_chars() and sci_poll_put_char() when it is set. Enable the
flag for the PORT_SCI (of_sci_sci) variant.

Signed-off-by: Au Dang <au.dang.jx@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Updated commit header and description.
 * Replaced the PORT_SCI check with a has_tdxe_auto_clear flag in
   struct sci_port, set from the new tdxe_auto_clear field in
   struct sci_of_data.
---
 drivers/tty/serial/sh-sci-common.h | 2 ++
 drivers/tty/serial/sh-sci.c        | 9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci-common.h
b/drivers/tty/serial/sh-sci-common.h
index 273856fbc20b..b75e5e1d3075 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -108,6 +108,7 @@ struct sci_of_data {
  const struct sci_port_ops *ops;
  unsigned short regtype;
  unsigned short type;
+ bool tdxe_auto_clear;
 };

 struct sci_port {
@@ -163,6 +164,7 @@ struct sci_port {
  bool has_rtscts;
  bool autorts;
  bool tx_occurred;
+ bool has_tdxe_auto_clear;
 };

 #define to_sci_port(uart) container_of((uart), struct sci_port, port)
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6df25fef5a5f..1a4d9467d2be 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -913,7 +913,8 @@ static void sci_poll_put_char(struct uart_port
*port, unsigned char c)
  } while (!(status & SCxSR_TDxE(port)));

  sci_serial_out(port, SCxTDR, c);
- s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
+ if (!s->has_tdxe_auto_clear)
+ s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
 }
 #endif /* CONFIG_CONSOLE_POLL || CONFIG_SERIAL_SH_SCI_CONSOLE ||
    CONFIG_SERIAL_SH_SCI_EARLYCON */
@@ -1063,7 +1064,8 @@ static void sci_transmit_chars(struct uart_port *port=
)
  port->icount.tx++;
  } while (--count > 0);

- s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port));
+ if (!s->has_tdxe_auto_clear)
+ s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port));

  if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
  uart_write_wakeup(port);
@@ -3664,6 +3666,7 @@ static const struct sci_of_data of_sci_sci =3D {
  .ops =3D &sci_port_ops,
  .uart_ops =3D &sci_uart_ops,
  .params =3D &sci_port_params[SCIx_SCI_REGTYPE],
+ .tdxe_auto_clear =3D true,
 };

 static const struct of_device_id of_sci_match[] __maybe_unused =3D {
@@ -3802,6 +3805,7 @@ static struct plat_sci_port *sci_parse_dt(struct
platform_device *pdev,
  sp->ops =3D data->ops;
  sp->port.ops =3D data->uart_ops;
  sp->params =3D data->params;
+ sp->has_tdxe_auto_clear =3D data->tdxe_auto_clear;

  sp->has_rtscts =3D of_property_read_bool(np, "uart-has-rtscts");

@@ -4088,6 +4092,7 @@ int __init scix_early_console_setup(struct
earlycon_device *device,
  sci_ports[0].params =3D data->params;
  sci_ports[0].ops =3D data->ops;
  sci_ports[0].port.ops =3D data->uart_ops;
+ sci_ports[0].has_tdxe_auto_clear =3D data->tdxe_auto_clear;
  sci_uart_earlycon =3D true;
  regs =3D sci_ports[0].params->common_regs;

--=20
2.43.0
