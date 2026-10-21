Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588400;
	b=dEdpoi2YjucyYa01BlkRiQ6sJTCdDg7eSTLEIbjB8dZ7P0nuaufOBXzMDawjpIh++zjX
	 GCWKbVHJWQXZ8tvMqR8iQizwv9/WE5MkueaX3tiwoeGpLrCYE8c+3bW1Odtcq7IJEOMPX
	 6s/iFKhqpN8gvAHnOrNmURlSHdmhTeJkuW0/kCQjEdiCpa/orRnipNn/tRlQQstltw1pw
	 o0VZcx7RmDF8AmspZg3MzDbAN49NOFuhWX7RDpDZ9D2ztom+l9v7TgeWKyiG0oLJSaK91
	 Yf99TL0aNUDdisP2/5Y48vOeKQ0pdgvySFia/lIulq3TDhp9TjGDKttLtirIvB02EVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=XhDg8QClMZJOayDv8bj/xO5vbSdeZvK1hnpn/RI7Gj0=;
	b=t59yULrIBHLrQZ/6RikjJF0kHRKWjGDBsf448I4Ayb1G4pN5sLEEfnK7eXRaQ9GJDsdN
	 843zkqqqYaq+90VCsWWAOWdEYUU727KKh/ykWla7hgR8xn0cllxXa1vaEEZKbyKJRybYl
	 RZfuV1v9uUQvRNtRm71N8WKVxtPhFMf7twM5XhwQhvdfxhX3wdCYdsk/1PG4EOBEBBCrt
	 w5x9qRdI7F8zYgifvHJFMzx34r+dJU+0gwWlC8t0Z8kslj230r9CtCBCQlE0mD0Ou2NeS
	 /dWa55WY7oGQDSlHyWiQPXIP70sbZ5HwT3l1wnWpcTmHIBkO+HYVb0IvFoE774uhpeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FCEmyVSw;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D383606A323
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 13:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D383606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FCEmyVSw
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso492152f8f.1
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 06:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792588398; x=1793193198; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XhDg8QClMZJOayDv8bj/xO5vbSdeZvK1hnpn/RI7Gj0=;
        b=FCEmyVSwyMIhgeTMCMdf9r23TjhNj0veKXSrM/ESw4hf4Bz7ZIqD1y8TaEBp44tsoP
         yRgWBIUPNTqNe8io8dF2Vv/JsYPX+h8UkBnn/pt7yV5z743+FGCRp89YZrZvfUoE9TZh
         8PlaYsq2kAvy9foYDpeD5OHutjRLZbCax4NToL+sI0DJYrmhPV2TvrHMoBvAHmn6DfnR
         9jWSOLCzWyT4SP8kWpzb/+q/rj7xtIf5tuJ8/VmA+MN9kvyJG09eQztgLD8TOihfKOM4
         qH3gqr0qt3XyfFJ4XJPa8aVIgpPxKl8eSlcvlUTGPSJE4GG3gZtaJfZoCo23ocXN+Ktp
         7KNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792588398; x=1793193198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XhDg8QClMZJOayDv8bj/xO5vbSdeZvK1hnpn/RI7Gj0=;
        b=b4NSDWJZfORg+S4X7JZKzi0tzz9vKMimGgrGcf4P5ipexzIOUG0wnsy6vrkmoMciM3
         OK48+YqJRCDuc45f5HuS3Yu2KcHJbwfusf4D2d9VWFffnvyXCkXqP6OWJxxsKThhGjR2
         NraE2IZHSuJWivrW+FatFKDiXSrztRzKvu2VaIK8pOBz8ZtKUNkRRtXVL74CMxqffWtr
         vDMJBWQEO6Hi1u5q3RaA9t87ddcUurM9S3iyyp7ZAdy2l78uNGO9bKjYXN2GVW+ZLoG4
         KRgJXc/VJoouvOrm64gB0cG5wr6hAJkFn0On6HEPetyYlCtQmNs9lUwPGX35Q+T0da3S
         6C3Q==
X-Forwarded-Encrypted: i=1; AKwUvBz/ARMM07EX0++X2KEOrryO7MlDmC50oC9X0lJU89sC5f6xP9CXArYRrG4G08vl+dif9uQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUo0ArCvtmWQ+Om52ZHKnoSchcY8xvO06DjD6yFfzbXBwKT2pS
	E+l9eT9tDPpzLHcjCFKWUqS8Cyh8O3goWrsgw1HRyfpypINEYRxr3PA1
X-Gm-Gg: AYBFou0URkEx+i2TN3APFwmCVQpgrb7lIYWVwqPSg0iA1q/SRg6LS15Fma2JZXgZwqJ
	y71CmP7D0Ukxrms5gOYykBps4b0qAzJbtK/DP4E/+JoHtQaVnIZzwtc7qH9kQcN6umGrBTqdDct
	0eiwfbnONSluVLUMEk2TiDYAQgWRMICViJedsBnjn43RJ4xLI1WxBuoVBmLcsFWwxYegNlE1YYD
	slXBteXvJIUkOeDStKUEw0j8PHgJc7MD3zdKSzpN5KrrKYfqN1OWVNVI00lQ2E9XNB0Inzpd6D0
	7OQ24kgzqRbSAKMtP4Sbuwtdh448aExn/BYTCCZAauGUujZsjPtvAfx4MkaYx1+jc1heun1EqNS
	UrKQ6bjNGD34cM/a8Aba4X8BsfibHTkpOO8c09B4PqzInLKOdPl6HUnKOExfhL6DcK4VrwrDcB7
	cM52dI2FsMJKi+IUNJNjVb8JR/tnLRtA9Fr79xjG4fpXvkyLrnrPrfwPGZZmz9iTStIlGtKtlLj
	xMjc6BKeZmrlnuBs/2RSqeso/sf2E4sfJqD8WYpAEsSKUnM8SAWBk8UZ2T6MFKfvaKxsUDltZLz
	hJJ9FymMlJ2HX3VQ
X-Received: by 2002:a05:6000:178d:b0:48e:b8f:f7d9 with SMTP id ffacd0b85a97d-48e2644eba3mr4823249f8f.6.1792588397791;
        Wed, 21 Oct 2026 06:13:17 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:39f4:e118:e272:79d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258358c1sm5655560f8f.43.2026.10.21.06.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:13:17 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
Date: Wed, 21 Oct 2026 14:13:13 +0100
Subject: [PATCH v2 1/4] serial: sh-sci: Drop TE disable at end of
 transmission on SCI
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-g2ul_sci-v2-1-b4e038220018@bp.renesas.com>
References: <20261021-g2ul_sci-v2-0-b4e038220018@bp.renesas.com>
In-Reply-To: <20261021-g2ul_sci-v2-0-b4e038220018@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, x86@kernel.org, 
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792588395; l=1377;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=3weoth6w6Xdl5b6WOfiDQxw3Mye7WCDgh2tqKrLoXnc=;
 b=pfNldyHMgPcqhzkFa1o+cms2Op0v6z0MqVAr8fWkcLhT21/2XnwoWjrKs6qWVj5+gpFwTXWbJ
 sRDd6avqjMtA8nT5XfTmxuB80Ps12Jq+DvQdSjgwz9YuPZJv0R/r4sM
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

From: Biju Das <biju.das.jz@bp.renesas.com>

Commit f06c2a9000eb ("tty: serial: sh-sci: Fix end of transmission on
SCI") made sci_transmit_chars() clear SCSCR.TE and return early on
PORT_SCI once the transmit FIFO is empty.

The hardware manual does not describe disabling the transmitter to end
a transmission, so this special case has no basis in the documented
programming sequence. Remove it and let SCI follow the same path as the
other port types. A plain revert no longer applies because the driver
now uses a kfifo, so the code is removed by hand.

Fixes: f06c2a9000eb ("tty: serial: sh-sci: Fix end of transmission on SCI")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index bd58bbfa65aa..9eb297dbc901 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1036,13 +1036,6 @@ static void sci_transmit_chars(struct uart_port *port)
 			c = port->x_char;
 			port->x_char = 0;
 		} else if (stopped || !kfifo_get(&tport->xmit_fifo, &c)) {
-			if (s->type == PORT_SCI &&
-			    kfifo_is_empty(&tport->xmit_fifo)) {
-				ctrl = sci_serial_in(port, SCSCR);
-				ctrl &= ~SCSCR_TE;
-				sci_serial_out(port, SCSCR, ctrl);
-				return;
-			}
 			break;
 		}
 

-- 
2.43.0

