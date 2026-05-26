Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A9C3E7BC4
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 23:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779839704; cv=none; b=qP0tN0OJRQoVhNRctCb4e8+D/zOyA8gDth00RQvzBC1OLyzHCVIhW5ZY+cpYH6Wm0iPQ1oyCbVgxSSTB0VIUPr7JoC/sXObswSuCRzIcFfkXiJFbvzlI1Y7PcndLDETzLOhsAD1/yhqHEWr0oowfsyry9zqJG2J7n1q1VL1pBcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779839704; c=relaxed/simple;
	bh=oKAGiCEez1guitxAB0c+dRZEQNdemvDrxj+Wsr4GpQY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VrJFs+mj5P7jIs+09/u7WKLqJXnuXPN1MGE5GoUewH+t+lr+BdCz2fm2u5tmRFuITgIWIQyir/aM49/iSISeUl/a84QmfDOWJiWBxNadESpkr7nC2t3S8EIAIQiX1cpRfqYupig8gGoOZ36MHo7XaU+dx97VVYTpsP9ywrkmMTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YTQfqNgU; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YTQfqNgU"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b9a3c3c4eeso112626035ad.3
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 16:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779839685; x=1780444485; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1vMyA9EZK7kcD8bOsSBJdErzXn6fW4e6Ma8FcXvmHE=;
        b=YTQfqNgUvHh2uIf165H/h8YrC8nJ2S0baLA8vo8CTuMHsp2tbDodSnanlFQrGxroOn
         y3WGEwg/GKSLEcvqnYK5oknKniF+JGohfqaHKui+1C1JJWlnuj7c2HGZMaH4RwSE1+z1
         YUPKN2wDcb/svlAgFLxYv5yYlgAr7gvq53svK0nH4sPXNAU6ZPEMX6A3NM808YKmdxVU
         mfbCEOZtvGx7qDCwDU1T10HRv5JPPLysieGWXGvetPmdIjKO6yuj9XNaGlKwwjbDI2V1
         MAYkqU8KpmQiVQ82F0+LkfmL+8YQAEm9W5Thc22Ys3yNV+WW+iM74hxJT12rS4Wf+QTl
         fBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779839685; x=1780444485;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1vMyA9EZK7kcD8bOsSBJdErzXn6fW4e6Ma8FcXvmHE=;
        b=dA5GInT9WjocO1NlCz2Eeoy/qK7+7DE+KOvQSnXvrY41VShcwM98BdiIZKJI+xRrHO
         l0H3V3E7leqfvHXbXEM6wsf5KEm5l2jzai60Ep6H0Ahvlee0UND+GQnTIWOdi5s6speu
         /kOm+DmP0J7iBGoDYRSL3eGa8kyIgVLXokgCawU7LTS+fFAsOtAD5V3+B1qGtxYwfXK8
         7oeG8hkSc3EgO9OOKdWDVjjVPFSsFv7BgqvV/xOctGfCjOjj08U7F27NPHjqoeDcTbAV
         8UrZm4CDb9VmrBgyUzwVsGfCpNi/gc44Sb1/5XwbFFGJqWs+fhINA46S8QPyvgn/LNw6
         ZiAA==
X-Forwarded-Encrypted: i=1; AFNElJ/qqs9vZH78B4wlQSr8B17WhgwPh4f6mPBKFEJm/f36EslSvBH205Gcmi75SD9/Twl8Yaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVLQggSHJlrXPWKgYsI6Z0CqB+P1NP5SjZ2lxzmJ6neaUiX9zV
	hEiQgpWVZEAfs/01Cpsiq1r+QFcdz7BsoHh+udZq/USeYsswTc4eM2yvIPlV61kyahCzXSd7/+f
	sHjqpHWAW
X-Received: from pgbcb21.prod.google.com ([2002:a05:6a02:715:b0:c80:22ee:7357])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f60f:b0:2b0:5795:9ead
 with SMTP id d9443c01a7336-2beb02cb6bamr225455725ad.0.1779839685352; Tue, 26
 May 2026 16:54:45 -0700 (PDT)
Date: Tue, 26 May 2026 23:54:11 +0000
In-Reply-To: <20260526235417.2058313-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526235417.2058313-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526235417.2058313-5-jrhilke@google.com>
Subject: [PATCH v2 04/10] selftests/vfio: igb: Program MSI-X interrupt routing
From: Josh Hilke <jrhilke@google.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

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
 .../selftests/vfio/lib/drivers/igb/igb.c      | 40 ++++++++++++++++---
 .../vfio/lib/drivers/igb/registers.h          | 11 ++++-
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index c0f9cefb23e5..a8f2072b6820 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -271,11 +271,32 @@ static void igb_init(struct vfio_pci_device *device)
 	/* Enable MSI-X with 1 vector for the test */
 	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
 
-	/* Enable auto-masking of interrupts to avoid storms without a real ISR */
-	igb_write32(igb, IGB_GPIE, IGB_GPIE_EIAME);
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
+	igb_write32(igb, IGB_GPIE, IGB_GPIE_MULTIPLE_MSIX | IGB_GPIE_EIAME);
+	igb_write32(igb, IGB_EIAC, IGB_EICR_VEC0);
+	igb_write32(igb, IGB_EIAM, IGB_EICR_VEC0);
 
 	/* Enable interrupts on vector 0 */
-	igb_write32(igb, IGB_EIMS, 1);
+	igb_write32(igb, IGB_EIMS, IGB_EICR_VEC0);
 
 	/* Map vector 0 to interrupt cause 0 and mark it valid */
 	igb_write32(igb, IGB_IVAR0, IGB_IVAR_VALID);
@@ -302,17 +323,24 @@ static void igb_remove(struct vfio_pci_device *device)
 
 static void igb_irq_disable(struct igb *igb)
 {
-	igb_write32(igb, IGB_EIMC, 1);
+	igb_write32(igb, IGB_EIMC, IGB_EICR_VEC0);
 }
 
 static void igb_irq_enable(struct igb *igb)
 {
-	igb_write32(igb, IGB_EIMS, 1);
+	igb_write32(igb, IGB_EIMS, IGB_EICR_VEC0);
 }
 
 static void igb_irq_clear(struct igb *igb)
 {
-	igb_read32(igb, IGB_EICR);
+	/*
+	 * Use write-to-clear (datasheet 7.3.4.2).  In MSI-X mode with EIAC
+	 * programmed, section 8.8.5 explicitly states "If any bits are set
+	 * in EIAC, the EICR register should not be read", which rules out
+	 * the read-to-clear path in 7.3.4.3.  Bits not in EIAC are still
+	 * cleared by writing 1.
+	 */
+	igb_write32(igb, IGB_EICR, 0xFFFFFFFF);
 }
 
 static void igb_memcpy_start(struct vfio_pci_device *device, iova_t src,
diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/registers.h b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
index 9a8b0f830f89..a133a208ed08 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
@@ -3,6 +3,8 @@
 #ifndef _IGB_REGISTERS_H_
 #define _IGB_REGISTERS_H_
 
+#include <linux/bits.h>
+
 /* Register Offsets (Intel 82576EB Datasheet) */
 #define IGB_CTRL 0x00000 /* Device Control */
 #define IGB_STATUS 0x00008 /* Device Status */
@@ -76,12 +78,18 @@
 #define IGB_VMOLR_BAM 0x08000000 /* Broadcast Accept Mode */
 #define IGB_RAH_POOL_1 0x00040000 /* Pool 1 assignment */
 
-#define IGB_EIMS 0x01524 /* Extended Interrupt Mask Set */
 #define IGB_EICS 0x01520 /* Extended Interrupt Cause Set */
+#define IGB_EIMS 0x01524 /* Extended Interrupt Mask Set */
 #define IGB_EIMC 0x01528 /* Extended Interrupt Mask Clear */
+#define IGB_EIAC 0x0152C /* Extended Interrupt Auto Clear */
+#define IGB_EIAM 0x01530 /* Extended Interrupt Auto Mask Enable */
+#define IGB_EICR_VEC0 BIT(0) /* MSI-X cause/vector 0 */
 #define IGB_CTRL_GIO_MASTER_DISABLE (1 << 2) /* GIO Master Disable */
 #define IGB_STATUS_GIO_MASTER_ENABLE (1 << 19) /* GIO Master Enable */
 #define IGB_GPIE 0x01514 /* General Purpose Interrupt Enable */
+/* GPIE fields per 82576 datasheet section 7.3.2.11, Table 7-47 */
+#define IGB_GPIE_MULTIPLE_MSIX BIT(4)  /* Multi-vector MSI-X mode */
+#define IGB_GPIE_EIAME         BIT(30) /* Apply EIAM on MSI-X assertion */
 #define IGB_TXDCTL0_Q_EN (1 << 25) /* Transmit Queue Enable */
 #define IGB_RXDCTL0_Q_EN (1 << 25) /* Receive Queue Enable */
 #define IGB_MRQC 0x05818 /* Multiple Receive Queues Command */
@@ -99,7 +107,6 @@
 #define IGB_PHY_CTRL_FULL_DUPLEX	0x0100 /* bit 8 */
 #define IGB_PHY_CTRL_LOOPBACK		0x4000 /* bit 14 */
 
-#define IGB_GPIE_EIAME 0x10 /* Extended Interrupt Auto Mask Enable */
 #define IGB_IVAR_VALID 0x80 /* Valid bit for IVAR register */
 
 /*
-- 
2.54.0.794.g4f17f83d09-goog

