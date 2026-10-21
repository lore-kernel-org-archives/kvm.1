Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588399;
	b=bQKPZ+b90e+TislfUSmW0d6LLy0F+UHVN1eOxSCJkIyTPkomL8o4jRt50llzuw5+GRyg
	 3ffxMR+G1ocjx/ePDiOSVix1n7RWd5TXBhDj2bXXjIzEeZWrLePunJsVgfPQBdLRK48Fc
	 W3Rwyo4HATX7ZKQPemNGr2TsqGLtyLIVM4C85bvg7Luc2U0tlrDaqoBlhF9S7QDmqSqhc
	 TYkM6oD1FDQeOZBRsVI4chv2h4d7q+9dCnOH3fZbOdO1WWesPB74sxXexTkPDm5tBKMPW
	 c00MXOUTCih+d+YT5PybKep2qsoSF8gvWP/k/AwEIY48+n+z0kO44B2eBipT8/UnALA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=o6p3pCo7kCCnsjGIBt4vEqtv3jWVT9ZqbdZWvk7buQ0=;
	b=NcX/+P3HnNdaydwweB4SaZercnq52c/V5DLCeFJmy0P3PPq2zFQKZz1K1ZcH/4Ru2Um2
	 D6fOBcYnj31JwYR71ydcdIWnYr8ovy26iP1KLOQE530T+1rQDbvPNaXN0aj0OSiSTgkPO
	 4PoBnWMjEbQJPMCKlTy4VeJ5v7+I7569ZhqfACVg+n3SbKP5+Dxh27tA6gPbgcEKrNV0c
	 bBVgqxINJOQ6u3ktFD/6fin21LpvUE8RfVIaBbnOwSGHWPWi9drI5eERlwMinZGdPO5IC
	 B6vsSoKcico4FElEkVuD7VPMEKsRukjbH7gs5xtCRWVNPQfN3doEnwVmJc497u+6AdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fyhfHnL2;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9C4606A31F
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 13:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE9C4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fyhfHnL2
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e0d885929so564497f8f.3
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 06:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792588397; x=1793193197; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o6p3pCo7kCCnsjGIBt4vEqtv3jWVT9ZqbdZWvk7buQ0=;
        b=fyhfHnL2vgB+Al2ATPFZaHH0oxN/5vfVtER8IQWKhOYBhNJT4FtRou7YxivrUyj3q/
         /nwzcxONL7tsdzu6Con8f7CAM2xMdFNlVyJAqfTIW8sh39WNInede+Y4Eg5Zh69OrGiJ
         IQM7UkpIOOctEq/2BwM7PDIPIPVVttoace+kvL4WGfc77/2A9+D6MtupCMTxRab/2Z8/
         Q2XNYMeslEdmJm0KY049Qy7mSASaa7hbwVcH5y0T1XQlCBZZ4M8Dd7wVCZBZmvJEzzf0
         fisK+iTfplb8kdiLOX/yhWZKbgqC3t4uWVJNU0xNe47VQ6+kMk8546NoIBfKmNiK2NI+
         XwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792588397; x=1793193197;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o6p3pCo7kCCnsjGIBt4vEqtv3jWVT9ZqbdZWvk7buQ0=;
        b=pl1ZWiyBXBacmQbm+c0x0EBAG/56xLUx5IfDz0+5JoNVocsTVwawCYUAO/ra8e2h0G
         Y5poDOL4ilqlQHcmgasLGcpx0TWmEmIhp/WrmiFicA5cTct3/qvsRvJ8I6CnX4U7TG19
         p+fGiQGvKTbC66wcB5gcLOHmo7REGG7C9r6Y0N3AKxZQtUGTv5Y0t1iam6vG+bBcY7do
         Hqs6aYj21ouI8KvIe6EiR4A2cksr7IaAvkxEJzGKYe+FCd/c/7sBb4bv9tI5tp3Ytlr9
         o4+0Ahe31LUgpgqU36lnZllrs3KwyrsUBJcnrMXGTBpP6D57E+s8x40hLek39fQZkKB1
         7eQA==
X-Forwarded-Encrypted: i=1; AKwUvBy0F6JM5SUCDX3cTF8IUpzSQCs1nYfWEwUQPSnwVARZrCRs7S/nJKsnjTLBvbqImZegucE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFrln7OMsgU1Eb3BsJKIS7m3ESHNUAipSipsKkgyfIUL0cLkW1
	jPD8EBv9qt11nCjkhqhxG9+JDG+LgKHrxtVp2fCouGW1WiG2WTMDJSA5
X-Gm-Gg: AYBFou0VTwJslcpyxnFxY10n33T4jX2PQRRhGR218lRzw9vnmVOcKWdETWdogbbLmuc
	o9l/NLDbDO0Q8DdPUDJJHyLarNf4UuGnvvrxGddUg5wRxfOoYRZkwrSR0mQS5JfOyJ4G0JUu4bY
	mn7QgecggEiWfeEY1OG/R4iEM6lxeakGc4GuGTon9lGXVs1RAY5zht3i9AyGpwk9Vh08JXyJAs3
	HcWSgWF6uOn3x5jBSLOOHww1PIYZ56Yihu31GyZPRIkb1P6VgzPShE7gbadKq3mXg8wqU2X7eUW
	+w7dZ93czpluzUUa+ecnlGSexvSmTqp6gTYN0eiXrAFm9z9I/QOGQlIAgBJahkk4dtIMGw6G27o
	5P+MHDGtSxl6uHw1pE+4jz9NNDks18+808Hj/dcN7scpxOiBeurz2qOvoM27t1TSgkp53X5g5oU
	/CWky8lL2Dnvvr0jcYXCAeruvQKKW3C+9k3eTIbSCOSs+ew44NEU345yB6jw07NjLCZXR+q/jHj
	lVHnDZ2qP1H/Jm6XkdZevUOe9ZSWCl7UZUBQXEev2tiIAxyvMQjhpltJVG34eeHC4AMb4GpPD90
	AyGspY/QM9yrH2zb
X-Received: by 2002:a5d:584d:0:b0:48e:28bd:e010 with SMTP id ffacd0b85a97d-48e28bde4b0mr2656500f8f.7.1792588396895;
        Wed, 21 Oct 2026 06:13:16 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:39f4:e118:e272:79d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258358c1sm5655560f8f.43.2026.10.21.06.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:13:16 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 0/4] Fix transmit handling on SCI/RSCI ports
Date: Wed, 21 Oct 2026 14:13:12 +0100
Message-Id: <20261021-g2ul_sci-v2-0-b4e038220018@bp.renesas.com>
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
X-B4-Tracking: v=1; b=H4sIAGm62GoC/y3Myw6CMBCF4Vchs7ZNW+TmyvcwxNAywhAF0hGik
 r67lbj8Tk7+DRg9IcMp2cDjSkzTGGEOCbi+GTsU1EaDUSbXyijRmeV+ZUfCRucqxyazGcT77PF
 Grz11qaN74ufk33t51b/1H9GVLpROK3ks0lKVQgtLwyLbhuXwOdtZehyRo9z0gDqE8AUHqvtvp
 QAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, x86@kernel.org, 
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>, Au Dang <au.dang.jx@renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792588395; l=2681;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=UKJg4b3SfR4kpP4oWIhEOgnGd98EBh9C3fKOCKd2yt0=;
 b=1NJHANvhrv+QQW8+t8rXZ8HELSt/2/6SELbVExz3/VnizRqtcgP50eKAy6UNf7GUmJoRz4YZ+
 q/+dgXcBcwsClSnKfz2cjoBWXVbYCRRGKs/PsjrY89rZYZBKgXjI3nE
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

To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org
CC: linux-renesas-soc@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-coco@lists.linux.dev
Cc: kvm@vger.kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

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

 drivers/tty/serial/rsci.c          |  2 ++
 drivers/tty/serial/sh-sci-common.h |  4 ++++
 drivers/tty/serial/sh-sci.c        | 45 +++++++++++++++++++++++++-------------
 3 files changed, 36 insertions(+), 15 deletions(-)
---
base-commit: 8f7df005a7564bd7ffa75da9c3085d5b996f1e16
change-id: 20261020-g2ul_sci-b610606ea5b5

Best regards,
-- 
Biju Das <biju.das.jz@bp.renesas.com>

