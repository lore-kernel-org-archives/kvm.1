Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013818;
	b=r0aEiw0mBSc/hMfU76cfHMIxRad4ofRfAjmBcvFQYfFQYVlVpgjz+e+V7U0dJBfcF0P8
	 /azo9NmG6CTSM8IIe7YrU8V5WJqGNyTgtQEP2MFyzl1TQkbS+Dybw3czZnFhj/STc05iD
	 WgSa+yARTu2WMHiw0CFrfqMf9dD+PqgHQH/Mr2MA9u02ZIkrIS24mUeRYyCSHwWOOeFBQ
	 8VXoQJ67O3e7qAMWOOq7YFOc+r8FXYdesOupbtHuTIJh7eiYASavFaxtFsUddver6/6Ug
	 kNl56pfclTC4Tw7ZKP1QmlrbJj0DOYmYkBCL+q25KuurLpc4Wr2GEYExzu74LS2EUrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ABdqyAeHZvZveh3ZqFvCBY4Fgn7+If+125igGtBDhBw=;
	b=43FCqoFWLp8jpzDvl7IRVXGAD0xHPK3yVRkWSaigRIv88lyo867U8HfdnPG3aFuFCBwc
	 AjXV1kyNB/skrtegHPkdAxT75OZyZtuGHpXAI/oOG8sqjI7WdW7IFmwhzmcQc6F2jefss
	 TJTtugjgD35uCyCBf1HMEsPxLt6YZl823O65OZOG8i3+GrMkFBjFhrZgX7vvVk0cCk1fT
	 bq8hMLxIEGbR+QHLp5EF4S/ec1RFVcXF+H2Dh9AhABy7gwHmJ89gdbQy4gaJGdPN1L5Nf
	 hREJhlChshSFOEdk/WppAJRZanTSE/qqap2u41xwS6Dz+6NiQ86e2xoWN5nkkHjN8+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KR8VGpzR;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE7E606A31A
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 11:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AE7E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KR8VGpzR
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso12956295e9.2
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 04:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793013817; x=1793618617; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ABdqyAeHZvZveh3ZqFvCBY4Fgn7+If+125igGtBDhBw=;
        b=KR8VGpzRcoJbMGE3hDYlf/800hJfTHsSb5HsFaYRtZmeMHHGtwJEBa1TTmsttW1ZIl
         4wYlNiHNSOcDxGnvOkqLtny6Rh1CFyl+0xOCPUwpT1X1vqB0wB2XiJ+26UlenQ39Kppm
         G+khUwxvCnESmNAJlOW8yIS40RmzMc3Q7Q6gjfLVHyHtrcPbLQD76pgOEXB1SNLb/54/
         M7jkuV/JzdTeaPJaxz6eIf9HHBk1cpsIN7eDqEFB8GFBmqgnmGcESKD7Aoj32/rx6GAW
         sibEeyLnx9s5k2mqw2IZXB63x1qsCe4I85qdshdNFcx6bNfNIG84az/ZDEOqhvJqUg5/
         evEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793013817; x=1793618617;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ABdqyAeHZvZveh3ZqFvCBY4Fgn7+If+125igGtBDhBw=;
        b=A2D7BzPuQ/KlDHftKfAKsTgKtgPke6eMdwANb6UT6Deffb/GkM/zxdckNyuyltzhav
         jk626NzVGKeQVvpsdRFBTlWtWkoKNTvmEGujCrubD5PujMLXfIHea0IshDXwnk+FQYKT
         Y3Tx/+fNibtLL7AsA2roviQaXV7fLItApz1t+YxADVmKIZ19vuJVn6A9GDBFZ4hVC932
         /w6wjPrVC16//l9CYY1PS3jb0XjD5TGL7Anb/6khfRGy+DpWpxE5TTqwEVtHKHiSX13w
         WYkT6VOhLOYSHtZTxUpnlbt9MyqEm6aDy5pA5HRb9mCRDafxMcQrUuVSAGCCAdAf0xwJ
         E+Og==
X-Forwarded-Encrypted: i=1; AKwUvBwcXfFSve875Tavryl6dA4HdfPLBSNHmigWGul4XGJj6ToZTZzMAjo+7fNfhJ+wWoFoYXw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLD6XsNRpY5BzEBcKmpp1A9KUx5i317AhdfTb6tccVA75+WVdUJ
	EHnmEqsI6dR6eV6WnlhmDTRgZ5/b4itpY5EnZmcAsP2DuMFiekFUOfP6
X-Gm-Gg: AYBFou2u7c1qpDigxswVKD3jHD4YiFDGJsbcJyoM8/Cwlm9z4Rd3HI3n6uPai4oSVZg
	0bVVE6EKpsM/oYJMSpUHIzR0XCD+5lPTRO7LkuJ+SVyzX6vqW49BO1HaT5MaBZtm/P22FJlrTmr
	cNrZvwujJXx4LeOY9H5r1ywtaVcg99PTaysUX+kLaRm0AWIaltoMGUz2QzAtaB/i0ltQ9nSS/Q6
	CaDiu+rt23LBj8irL4VhYDetv5W7opzdh5v2fthX0e+u44prYcUX69nqYlclRYW0CX2ik4VTJyR
	uetRx5MTttDC7eTy8L71bxZ4a2ztaEh3PNAKT9Rk2cH30kVqAJhLZE7RCHHyJPsH4spGqszUcig
	s81jSFkVH3zEZWvU4vxFRl7+3DzPVpdWiF/3NBaELKB3S6t5IWTR8tPFMkuHLLbe5VWPfEvEvGu
	Lig+llT8R/BRZgyZg3AzBkmLOpXH0tgoOvLe2zg0w3jykF41XMcBt6kTIYuBW5uMsO/3TCAqas1
	2JtpIf2fKqedcvQgt4A1wBoLasbh6c95rDFLC39gnyt/PeRL0RD3xrkgPsMn/2v6ShoBqpQWxQ8
	BSN4cipEKlrabVZtvg==
X-Received: by 2002:a05:600c:6098:b0:49f:ce78:356d with SMTP id 5b1f17b1804b1-4a35acc431dmr111151135e9.30.1793013816492;
        Mon, 26 Oct 2026 04:23:36 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:482f:657c:9770:475e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfb8esm15959263f8f.54.2026.10.26.04.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:23:36 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 0/4] Fix transmit handling on SCI/RSCI ports
Date: Mon, 26 Oct 2026 11:23:32 +0000
Message-Id: <20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com>
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
X-B4-Tracking: v=1; b=H4sIADQ432oC/2WO2wrCMBBEf6Xk2YTNplef/A8Radq1TdG2JDaop
 f9uWgQFH88wc5iZObKGHNtHM7PkjTNDH0DtIla1Zd8QN3VghoCpBATe4HQ9u8pwHTiFlMpEJyz
 UR0sX89hUx1Pg1rj7YJ+b2cs1/UhkITOQqhBxpnLIueTadJOoSye610GPwlJPLlA13Nhq8vizR
 vm94JED1zGByhEBZP63XpblDbRAkubjAAAA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, x86@kernel.org, 
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>, Au Dang <au.dang.jx@renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793013815; l=3074;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=zW64mN/4d2OmJaD7t1D7UB4oZpTj3P+t9X3dcAB7rtU=;
 b=gOp99iXwRCnJN0msXpKCv/GRpEYHrf7Os4oduYopAncMX/9qUjdeKcRQHas85XQ62sv8Yls1h
 dADbeEyGwleAPP1Llu7XjfmkxHVqzQXltxEDw0YYs68pre99kVhVnLC
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

Hi All,

This series fixes several transmit problems on the SCI (PORT_SCI) and
RSCI ports of the sh-sci driver, seen on Renesas RZ SoCs:

 - Patch 1 removes the code that disables TE at the end of a
   transmission on SCI, which the hardware manual does not describe.
 - Patch 2 stops the TEI handler from turning the transmitter off
   while the xmit kfifo still holds data, which could stall or lose
   output. It also covers the TE handling that patch 1 no longer does
   in sci_transmit_chars().
 - Patch 3 skips the software clear of the TDxE flag on SCI, since
   hardware clears it on a TDR write and the extra clear caused a
   spurious TXI and a duplicated last character.
 - Patch 4 forces a TE toggle when restoring SCSCR in the console
   write path on SCI, so the TXI that restarts an interrupted drain is
   generated. Without it the RZ/G2UL console can hang during boot.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Changes in v3:
 * Updated commit description for patch#2
 * When the port is stopped with data still queued, the transmit_chars()
   paths (sci_transmit_chars() and rsci_transmit_chars()) now also swap
   TIE for TEIE, as they already did for an empty kfifo. Without this, TIE
   would keep firing with nothing the driver is allowed to send, and TEI
   would never be raised to complete the transmission.
 * Replaced sci_tx_interrupt() with port's transmit_chars() to avoid
   lock drop race in sci_tx_end_interrupt() before TX handoff.
 * Added missing has_tdxe_auto_clear init in scix_early_console_setup().
 * Replaced to_sci_port(port)->type with sci_port->type in
   serial_console_write().
- Link to v2: https://lore.kernel.org/r/20261021-g2ul_sci-v2-0-b4e038220018@bp.renesas.com
Changes in v2:
 * Updated commit header and description for patch#2 and #3.
 * Take the port lock before reading the control register, so the
   read-modify-write in sci_tx_end_interrupt() is protected.
 * Extended the pending-data check in sci_tx_end_interrupt() to cover
   x_char and a stopped port, not only a non-empty xmit kfifo.
 * Replaced the PORT_SCI check with a has_tdxe_auto_clear flag in
   struct sci_port, set from the new tdxe_auto_clear field in
   struct sci_of_data.
- Link to v1: https://lore.kernel.org/r/20261019170139.473808-1-biju.das.jz@bp.renesas.com

---
Au Dang (2):
      serial: sh-sci: Skip TDxE clear when hardware clears it automatically
      serial: sh-sci: Toggle TE when restoring SCSCR in console write on SCI

Biju Das (2):
      serial: sh-sci: Drop TE disable at end of transmission on SCI
      serial: sh-sci: Keep TX enabled on TEI while data is pending

 drivers/tty/serial/rsci.c          |  4 ++-
 drivers/tty/serial/sh-sci-common.h |  4 +++
 drivers/tty/serial/sh-sci.c        | 71 ++++++++++++++++++++++++++------------
 3 files changed, 56 insertions(+), 23 deletions(-)
---
base-commit: 8f7df005a7564bd7ffa75da9c3085d5b996f1e16
change-id: 20261020-g2ul_sci-b610606ea5b5

Best regards,
-- 
Biju Das <biju.das.jz@bp.renesas.com>

