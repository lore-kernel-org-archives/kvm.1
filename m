Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D203AA9D1
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783552745; cv=none; b=Nczr1WUeNG9HD23VArnrKNp23f+svC/UedwzhevZR6tTlE19tFMx5r1gNr24HV+MFvyyTgZGAB0arwURFpZkOh66DHsrBH4/B/TYJOpuVGl9sw8AuK0xK7IELLiDMh/VG27eUdtpKjJC9kbUIQq6QemFNMm6qTF3Db+HtNspuEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783552745; c=relaxed/simple;
	bh=yHEV4sJlkKdRJpVUIMEHRMkv695nL1XjpbBwrODRFZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gKSELcphMkCC/WisD2f8WEGsDoBBSd9CYh/886n/ru8XW+hi6PbdtEZ2alDJ5xsl0XNFf0hoGNkECEZrkwTRhBWePedltAuYWPadWwGnVNk2C3NsBHlVS9oWBcUxjA+Tcq6Od882Pd5u2D6zzzmx+cmUTvrFEztS4RqzxjjkvCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fkdw/pvc; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fkdw/pvc"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8482df30da4so486902b3a.2
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 16:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783552743; x=1784157543; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FHotkZwUvWDYR+6isUryjHM+EirIZK4cPZxfJX+WjKI=;
        b=Fkdw/pvcgoNXQ3yNfazMYjFoonqzvA9XXciQEfqqI8q61JjOUTS9ERmQC30XypvVoj
         12XPmom7Lbpuo9DhMQ30BlzWCTgGg5eXbmiW1izxQd1f7VU60gZoPR1HjG3VkOe1XbPM
         g1EB4Ck5/VonCAXLVKiZ7AzoQ7f7HzklYm2BTDGfQztkUcjALc0WgEFykb0sXPQ6Faxy
         eSctcZtL7dgI2q/ed/xat3/6lzcXqJFNk6330IBoR8Ratq5r4wW9BOkDwyZvUJjmdrwJ
         CNKp4wL5PgsKGJQFtcza50kYyy6yot2RAriCyxbjyfOOIOHuXWFDa0fKBrBw9E2DQgtb
         angA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783552743; x=1784157543;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FHotkZwUvWDYR+6isUryjHM+EirIZK4cPZxfJX+WjKI=;
        b=OFjFFe4yLLGTsd2DRkWYwjkpK6EoEyimC87YJkJh7K0ugRUdzNmrn2BJobKzMxE7uR
         3l20JxdMe6WGnHMO5PznONTxnAxsyBqL6HbQc0ycOR22QeWuW1GwrVuL9JW0EKrFpmTT
         rcHHO6rhcTVQRoCCT1367zo/1x5DLaR96+f8v3A/aXhkM0TQv4jpu+hLPr4TUbZ7vuN+
         JGt+LTk4g1c/75HWov7nojDNBfpHMZ3BJpWkxjzEKoxL3PpCxL+mZ694t+hTEnM6Gt7v
         ay9tC6assu+ec/ENJYy51h30YKEzaw+ph83++MNP4ZhqEmE1xYz8UHZhNqdl1nggfzyy
         YpgQ==
X-Forwarded-Encrypted: i=1; AHgh+RpyMGL+8pC2CKuxhdBcUmqDtUqY5nIIpO/NKCD6qloxHbE5B2HHYzmbrJBNEOYDYvCLEJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPdiAP/KpVe6x3iLUN+zVFvR0+6P5UHsMp7+4jaB/LX6nIImjU
	FVvRnUo9McwYYmXlOSnpEssQfTTsCQN3bQEqLxBWiaJpNcitO8K73o+KC1RPN3Fm1JaK32f9KMn
	IFGfhX0kC
X-Received: from pfbcr5.prod.google.com ([2002:a05:6a00:f05:b0:847:84b8:2db6])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d8d:b0:848:30c4:3fe8
 with SMTP id d2e1a72fcca58-84842ec1e48mr4443595b3a.1.1783552743169; Wed, 08
 Jul 2026 16:19:03 -0700 (PDT)
Date: Wed, 08 Jul 2026 23:18:51 +0000
In-Reply-To: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260708-igb_v3_b4-v3-4-1272650ca614@google.com>
Subject: [PATCH v3 4/9] vfio: selftests: igb: Program MSI-X interrupt routing
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"

From: Alex Williamson <alex.williamson@nvidia.com>

The submitted driver writes only GPIE.EIAME (with a register value of
0x10, which is actually GPIE.Multiple_MSIX, bit 4) and clears EICR by
reading it.  On QEMU this works because the emulated loopback path is
synchronous and EICR is implemented as read-to-clear unconditionally.
Real 82576 hardware needs the full MSI-X programming sequence.

Per 82576 datasheet section 7.3.2.11 Table 7-47, MSI-X mode requires:

  GPIE.Multiple_MSIX (bit 4): route causes through IVAR.
  GPIE.EIAME (bit 30): apply EIAM on MSI-X assertion.  Without EIAME,
    section 7.3.2.11 specifies EIAM only takes effect on EICR
    read/write, which is not the path used here.

Configure auto-clear and auto-mask for vector 0:

  EIAC (section 8.8.5): auto-clear of EICR cause bit on MSI-X assertion.
  EIAM (section 8.8.6): with EIAME set, auto-mask of EIMS on MSI-X
    assertion.  This guarantees one interrupt per memcpy batch and
    prevents repeat delivery if the cause re-asserts before EIMS is
    restored.

Replace the read-to-clear of EICR with write-to-clear.  Section 8.8.5
states "If any bits are set in EIAC, the EICR register should not be
read", and section 7.3.4.3 cautions against read-to-clear in MSI-X
mode in general.  Write-to-clear (section 7.3.4.2) is unconditional.

Replace the magic '1' values written to EIMS/EIMC with IGB_EICR_VEC0,
add the GPIE/EIAC/EIAM macros, and drop the wrong-valued IGB_GPIE_EIAME
macro (the new definition lives next to IGB_GPIE_MULTIPLE_MSIX).

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 40 ++++++++++++++++++----
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index f4f6d2ee262d..637d05e872de 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -280,11 +280,32 @@ static void igb_init(struct vfio_pci_device *device)
 	/* Enable MSI-X with 1 vector for the test */
 	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
 
-	/* Enable auto-masking of interrupts to avoid storms without a real ISR */
-	igb_write32(igb, E1000_GPIE, E1000_GPIE_EIAME);
+	/*
+	 * Program MSI-X interrupt routing per 82576 datasheet:
+	 *
+	 * GPIE (section 7.3.2.11, Table 7-47): set Multiple_MSIX (bit 4) to
+	 * route interrupt causes through IVAR mapping, and EIAME (bit 30)
+	 * to apply EIAM on MSI-X assertion (without EIAME, EIAM only
+	 * applies on EICR read/write).
+	 *
+	 * EIAC (section 8.8.5): enable auto-clear of EICR for vector 0.
+	 * Without auto-clear the cause stays set after delivery and the
+	 * test can see spurious interrupts on the next memcpy batch.
+	 *
+	 * EIAM (section 8.8.6): enable auto-mask of EIMS for vector 0 on
+	 * MSI-X assertion (effective because EIAME is set), so a single
+	 * interrupt is delivered per memcpy batch even if the cause
+	 * re-asserts before software re-enables the mask.
+	 *
+	 * IVAR (section 7.3.1.2, register definition in 8.8.13): map RX
+	 * cause 0 to MSI-X vector 0 and mark the entry valid.
+	 */
+	igb_write32(igb, E1000_GPIE, E1000_GPIE_MSIX_MODE | E1000_GPIE_EIAME);
+	igb_write32(igb, E1000_EIAC, E1000_EICR_RX_QUEUE0);
+	igb_write32(igb, E1000_EIAM, E1000_EICR_RX_QUEUE0);
 
 	/* Enable interrupts on vector 0 */
-	igb_write32(igb, E1000_EIMS, 1);
+	igb_write32(igb, E1000_EIMS, E1000_EICR_RX_QUEUE0);
 
 	/* Map vector 0 to interrupt cause 0 and mark it valid */
 	igb_write32(igb, E1000_IVAR0, E1000_IVAR_VALID);
@@ -310,17 +331,24 @@ static void igb_remove(struct vfio_pci_device *device)
 
 static void igb_irq_disable(struct igb *igb)
 {
-	igb_write32(igb, E1000_EIMC, 1);
+	igb_write32(igb, E1000_EIMC, E1000_EICR_RX_QUEUE0);
 }
 
 static void igb_irq_enable(struct igb *igb)
 {
-	igb_write32(igb, E1000_EIMS, 1);
+	igb_write32(igb, E1000_EIMS, E1000_EICR_RX_QUEUE0);
 }
 
 static void igb_irq_clear(struct igb *igb)
 {
-	igb_read32(igb, E1000_EICR);
+	/*
+	 * Use write-to-clear (datasheet 7.3.4.2).  In MSI-X mode with EIAC
+	 * programmed, section 8.8.5 explicitly states "If any bits are set
+	 * in EIAC, the EICR register should not be read", which rules out
+	 * the read-to-clear path in 7.3.4.3.  Bits not in EIAC are still
+	 * cleared by writing 1.
+	 */
+	igb_write32(igb, E1000_EICR, 0xFFFFFFFF);
 }
 
 static void igb_memcpy_start(struct vfio_pci_device *device, iova_t src,

-- 
2.55.0.795.g602f6c329a-goog

