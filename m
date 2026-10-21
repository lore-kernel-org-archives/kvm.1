Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588403;
	b=2LCkPDcmjnKDVslbj6OlhhppkqFSskbgvb54EZb2rn2AJiWb+cweK4uADT4mjSq3Fxw7
	 RaA7eI29m6ZR24jCrxX+Kirwlwt8J02nnMEIzoM+Sjqg3lV2tpWOByuThIury5cHQerhK
	 Dhw9FiylIvT3hzW72DgcOXkf8qVbe+pAZ4BfhbAa+DKnCZL1PrP0ykBxEJphDZIcnrzOk
	 5cPYn72D2jlPVcVC3cFxIztGn7dbaNArBQ9EwOMm9WS2LrXIpj9nO9E7ZYVP5K6Jb1ekP
	 9A1B6onlidxi2TJM+E9NqRDUzeripVAXP6n3yG4zLCYOLucI5W4AlMowf8RD0UtZ4qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=N5RE4VrUqgRrVxPGuEVRRhHI7VFdRUfeZKkkzZJ3khE=;
	b=UcSaw3nspvAO3V796J09Uaq4S4kkX89t1TXO4Hg1e86LzFSFKVJHLaef0/UAud1UtXEA
	 j36gGpVjIXtjQrXCes8EWs8SZbsUZV0ta+snW+kN6voPQ5WQW9UCLyLclg4oyKXU6mgyC
	 WpyYU7ciDtSEZwuuvxDfJytD5FojK4PYOHWknCvHiZf5hT9fts1yyrH6wnaoJv3KhcB5B
	 pMSuy0DYdZv14C37AA26eEfxWxgBA94NM/W0/AMdvnay+vQ9V0Em7EZrohrYNwgVBW4bY
	 mABiwh45E7MU7gu+7IA7YhBiQFLExXNWtzvp8NHxEqPw46BjTfkOP4xSFDt3XuVKWXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dftScbiC;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE2360A263C
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 13:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EE2360A263C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dftScbiC
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1fe9efc0eso7244605e9.2
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 06:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792588401; x=1793193201; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N5RE4VrUqgRrVxPGuEVRRhHI7VFdRUfeZKkkzZJ3khE=;
        b=dftScbiCP6a1eeHD6IgOv+dKCjqK1dz6x1afgj7VzlVqPUjsONvI6Q3epm+bf8uCm9
         DCSI1YdG54tNCbuIrxPP+BCLMm30oJ1Pxk20zK1EvYVfmoviRWhbxk842sdHQa23ogYK
         iM9UlyPPdCNuwdG8zQSw9vZnW0REm3+X0N5OS8G4r1Dt8UULxCpiEsSHbo+1nzL32Sev
         wtqp1xXvO68YaKo8vgYEFw5FEXt+CfU6k3fgF1DH6pPr1fsF8CdS7Jrt4pgOtue+R2ho
         YEsG/OP7Hknq6sDgOQ79L6++ZMXPv2kX+Wl2fFmJcxFpJETI1KvtI7LJBXzy4bXVPaSM
         HwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792588401; x=1793193201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N5RE4VrUqgRrVxPGuEVRRhHI7VFdRUfeZKkkzZJ3khE=;
        b=gge/onkLLnCkFZBka9vlijGUxRwe9DzHQ8K5mZj7PfGoXweMRSPBlDNTtAO6DLvLf8
         Uhxh3G7WXES2QPZD2DvNo0wXc0nkFgNeYvoRc51CyHRcssuqi21k706jYSRVuq23MY8S
         x3GIaKxh8mYMVSxNEX2TD0XB+I6plHnF+dDTy5MvuIE9fLIaHluBXqab1EZ5Yg+HLCfc
         7NI8lc6k6lN2GwsCxrmDzsfPgINPm0LePQEV31RMIrrBR3q4UNwgfpKtR/gYCfsGFLxL
         hsCzXTWR+nVYyzglnSSPTOQZJmgpfPniFKv63mkNelGvC7CIJGj1wHb4gDiUbdKzKe3G
         03Ag==
X-Forwarded-Encrypted: i=1; AKwUvBzd2/nWb9zuAz/obQjm/OCd5xgwPBw+tZzNExAa+erCc6kWrzWL1pRNOWqONf0KN9UIZ9w=@vger.kernel.org
X-Gm-Message-State: AFq9FYLV3IRgYeoL7FhpMbRdAU0KIif52NrlOSCz3RXgEOYx1Kq72DjP
	s2ilrczi+BCChn/vqnO+Z72EMzE2QZVULd/0/XTlC7Revrf61PqCjWPt
X-Gm-Gg: AYBFou1/KFSdNUNXW1a4Si7e6VtWbyDVav/q4GmQc/z6LDFWtJZ0eRV1lOyjEwmL+Yk
	ULqzUsrIyqV2J9o39+DBSVOhlnfvqvjwKfdy3HVZRQavt5UK6MmPH+zK5aejGJ82Bo4sEemscRL
	WbJIInRZnND/qBaBNIWC22wsxH2XqotcnPuq0Fb052aZVDtt1/PpRtNZLNvJkWov7EjhoZ6zIYy
	CL+CL12/6nAf9UrWM5PgJut32etiNvTh0axFmiR+OO9pK6srS6qg5g5raMj3r7q7pwyaonCPlrw
	taIq+v/rqOKq/8Bn9iMl7jdW7SjMIVUIVH3L+MDQ9KIwe26SPMif6evzolN+Z95rXVJeRl5RCXW
	cV22fB2qlr80Ugs+LUO+kmKRM8xjUdWEJR1dtrELbFl1nuhLBM6kIy+L34st2Nzs+2DSuruqmOm
	1p5PxVwTcOkObIxZJFgtKYkUVVnyd5LIsK+7pdEdTVffF8Bk/3ByDA6mzwuwN1ljUVD7/emFOYh
	73fLNXez3dKJSwQb9T0QuAbZHTigfT2zM55AJNKl7oVIMIywULaTbEO6u4lYElzOUZIRyvEzY4S
	Uzt1tcD+M+aOIs/B
X-Received: by 2002:a05:600c:6385:b0:4a1:e0d5:293e with SMTP id 5b1f17b1804b1-4a1fdb0d18amr43127735e9.21.1792588401415;
        Wed, 21 Oct 2026 06:13:21 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:39f4:e118:e272:79d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258358c1sm5655560f8f.43.2026.10.21.06.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:13:20 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
Date: Wed, 21 Oct 2026 14:13:16 +0100
Subject: [PATCH v2 4/4] serial: sh-sci: Toggle TE when restoring SCSCR in
 console write on SCI
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
Message-Id: <20261021-g2ul_sci-v2-4-b4e038220018@bp.renesas.com>
References: <20261021-g2ul_sci-v2-0-b4e038220018@bp.renesas.com>
In-Reply-To: <20261021-g2ul_sci-v2-0-b4e038220018@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, x86@kernel.org, 
 linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
 Biju Das <biju.das.jz@bp.renesas.com>, Au Dang <au.dang.jx@renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792588395; l=2226;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=eBrM0bnW7fIX8UCFI1hlYQ/wtkJYAm4pg8SckFVkEUs=;
 b=exl2dPJM3XU3wI5tFcxqpq6psM/OOHvMBfuNGCmAkHHVsJCMgohqkx0TMdcopVTGQWyvYfu0t
 KyfEFkkCt8LDahY+xr6F+zNevV3lVMvOV6VbljzJgEP0kTpOCw/fEYj
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

From: Au Dang <au.dang.jx@renesas.com>

When SCI0 (PORT_SCI) is the system console on RZ/G2UL, the board can
hang at the serial console output stage during boot.

ftrace shows the following sequence:

1. sci_transmit_chars() is draining the TX kfifo through TXI
   interrupts with SCSCR=0xf0 (TE=1, TIE=1, RE=1, RIE=1).

2. serial_console_write() runs in the middle of that drain. It saves
   SCSCR=0xf0, switches to polling by writing SCSCR=0x30 (TE=1, TIE=0)
   and outputs the characters with sci_poll_put_char().

3. It then restores SCSCR=0xf0 in a single write. TE is 1 both before
   and after, so there is no TE transition.

4. sci_start_tx() is then called repeatedly with SCSCR unchanged, but
   no TXI is ever raised again, so the drain never resumes and the
   console hangs.

The RZ/G2UL User's Manual (section 23.3.6, "SCI Initialization") notes
that changing SCR.TE from 1 to 0 or from 0 to 1 while SCR.TIE is 1
generates a TXI interrupt request. Without a TE transition, the TXI
that would restart the drain is never generated.

For PORT_SCI, restore SCSCR in two steps: first with TE cleared, then
with the full saved value. This forces the TE 1->0->1 transition while
TIE is being re-enabled, so TXI fires and the interrupted drain
resumes.

Signed-off-by: Au Dang <au.dang.jx@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index aa179c787487..993f330e6881 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3445,10 +3445,14 @@ static void serial_console_write(struct console *co, const char *s,
 		cpu_relax();
 
 	/* restore the SCSCR */
-	if (sci_port->ops->finish_console_write)
+	if (sci_port->ops->finish_console_write) {
 		sci_port->ops->finish_console_write(port, ctrl);
-	else
+	} else {
+		if (to_sci_port(port)->type == PORT_SCI)
+			sci_port->ops->write_reg(port, regs->control, ctrl & ~SCSCR_TE);
+
 		sci_port->ops->write_reg(port, regs->control, ctrl);
+	}
 
 	if (locked)
 		uart_port_unlock_irqrestore(port, flags);

-- 
2.43.0

