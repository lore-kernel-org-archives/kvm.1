Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013819;
	b=stectrt7ZBBv67962fD976hzd+fLJTgEPjD1DdOwcv50aRmaCXxQRuL/CLv2J5qG3xlZ
	 uLhuuwadsMcEGqUJxDXKlXvtMV9zpD+Y7RjNqPJor7gGnoBO4k3j97lFcgjcLu+weUr/A
	 aLoYEK4YIwqd3+GYUKLyi/RIg+fxq6xAHetauIeu93xvy0KrOJE917QQuz1zn3PyQBhai
	 UUtWNzs7ye3BPasD5jNt+MxN1AapH/jo6sbZfdX6Jn2juCYUUeWwe067x/LyKzcsvwgS1
	 Tv2UW4J0R7R5ybdzTs4kcXw73woiD/Dz6mYzCJIMCHPWyURvQAsMmI/bNB+8BLXIkng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=hi7Sr5AhOZnPq35jxQMZKgyIjGd6gqHdfbAHtpf8ZRc=;
	b=SzZtGYVCWGlAUjwxCwgIdYZMdgmTWGsZDm+nz6MeBmGvIpzDOPpJpIOWGat541px9n42
	 4dJyS11bs4pxC2Vg4u7Dx2svfgyzF3Sfq+fRtlpfFgAoIcfpI4bgr+BYrXpmSf1asHhx2
	 j4Q1SiRHSCNqG40X018mPlF4Q8AHti7O1hBylB/UiBbxncermnlTt+UzhCfg0lYUqDmST
	 F611uUM72EJHVl8c1KIlfsuhksrlwwthlIWU6jxt003jduK9v4zdWFUE+StLn/PRpbTcc
	 asHwlHw9YKMryG6A8W+HMnEpVOUQyvM/MCjKDFGFw/x18NI7iQaBySucMeNU0wzWhRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ggtyAlK5;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7228B606A334
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 11:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7228B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ggtyAlK5
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so20123295e9.1
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 04:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013818; x=1793618618; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hi7Sr5AhOZnPq35jxQMZKgyIjGd6gqHdfbAHtpf8ZRc=;
        b=ggtyAlK5d+ZGKZ2b0k2afzMY/YeLK5gUpsHdBkcfs2+quVkigOVOMhTvVD3MfyY+VJ
         RhWb0GBZLYPua1DoXaoxKgGc2mSi31SO0cai/wzdMHK8Sk+AsYOAjQAbAJrFBHgNXPct
         +WSBhk5OEc2o/k2cdeUYmIxwWVx5yRyuZCb/iUXXPTvltGSiXphRVfmRpREcKSBpVOyL
         t9XKQYzKdTjGhCLZVMd/m2wOxMmIcHHe0pPn5GKumaBo3q+rCRc5KFV7C7lSMFMkftcq
         iKNFgnH40VRzdUTnx8O80viDLN0VAhj568VfjBtf52NiBLYkdXyrDfOAtB9vtFKgcfDA
         PJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013818; x=1793618618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hi7Sr5AhOZnPq35jxQMZKgyIjGd6gqHdfbAHtpf8ZRc=;
        b=18SM7BNvzHhzLI5PuzNIgo9QxR9xqcPas1ynJeHzwEhIcu4Cr+Knpmp0Ri/iZdd1KZ
         s3/rvhPjVAwi38FY0ONxO1iziwnX69b2VjKwWAUe9nNkb5CEqZHJuT7FD0uDrPR9bJ/C
         mannc/W22fnSYy4uJ+ehLHm/gUWkV95wthwt1vy2zuhUZ2uJIBCb4WWJdIkfiG7cA9gZ
         EzfmQ9dyq3KTzcKiuP74i8GVSE0OpICXPAgp5NusTWT9paLnxv3wbdAORY+uDwDQJfLo
         jIU6NdjQZhHkuonhc1rz/29+sdk7k050lyBPjpbOYSlNZhEaRKYw1s+n4CdnKDuhkVTf
         Lebg==
X-Forwarded-Encrypted: i=1; AKwUvBw//NBel3/HzyNxhTjDtcgcv4IGo7N9U0pCrCs9fh/qfkseBi2Nfj0wqgXcWj0fAWpTLL8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLq5Y+hV9hEqv0lg5zd8On/LCwdwQ1x7p7rO4A1N4a4DkGKkyzr
	1VVzYQeA9xH6Z9b7mj6pTwKip0lB7330/3K8kXi1taUnY9pnLub6n9OG
X-Gm-Gg: AYBFou3WpKGkhYTAPVCIQHEwrtPt+mCmaq1Yzloarz9IaXhXr8F/FVsiRycLo6L5gIz
	ALQnDjC4sZBEL0XyOTlZ06Zrb/SuB1WxiqDjQP1egpi1fu4gZL9nDAQHL+kVxxUqF4RT+OoPxeE
	2N2iuXITBTL+BBViaXbZejOeUPx1RiAzL2jm5uIe1/5g4oxkSgdA39vhNVg79fmPIQiuYJVliZZ
	uhsBnCb3u/qFcTqAJ8JEDBFSKe0j5oDvUFfD1Pry7P+7xdX8yozrHPNUIK+nIrvCcPnDpRPNWgb
	ayKgoffzN1Bx1icdiCIkcOqyQuA5kUz3dE8T6MHxtDfUBI9FnUk4uOG24MIDBZTDPBTEamZeEEx
	EjQFEbHTO5oLAUZgxeF452qIphILzMumW3YnpHXS5rc9yzkiBZF6+g0p8/UxHnLQ0gnPXPhGi9x
	uCGcAFLDiBTcbN8LbZxk9ZLz9QACizWg3lfdZfzuJK9zwDMC+RY4NtimwHJONDqbbBCRaUsRopQ
	aqw3pbiQv8O+mWjG8k2z3GDitfmKRz9fA1KS5yXsBfnkOJYwrA4orRNj0hQVymUrI7tRwRD61QP
	tpjWHXmOUU/zpd4u4pM=
X-Received: by 2002:a05:600c:80ca:b0:4a2:5ef:1400 with SMTP id 5b1f17b1804b1-4a35ac9a7a3mr79652025e9.12.1793013817664;
        Mon, 26 Oct 2026 04:23:37 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:482f:657c:9770:475e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfb8esm15959263f8f.54.2026.10.26.04.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:23:37 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
Date: Mon, 26 Oct 2026 11:23:33 +0000
Subject: [PATCH v3 1/4] serial: sh-sci: Drop TE disable at end of
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
Message-Id: <20261026-g2ul_sci-v3-1-b3097163edd5@bp.renesas.com>
References: <20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com>
In-Reply-To: <20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, x86@kernel.org, 
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793013815; l=1401;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=Ii4p8OHUuRr+409dJC7XNZ8wHyl0UhxZWbqcu7AjCfM=;
 b=QPOwAoyUkoWS9Bqp2w2X70DfqejfizPDZXdsQkJEafZxIQD29eClU0HtB39i56Y/RJtVqGMco
 7idJP3hdNJxB+CdRDa70bI2O2JYk8pvtPqPW2OopCkZ4Ge+olw0piyX
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
v2->v3:
 * No change.
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

