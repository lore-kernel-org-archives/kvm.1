Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B381347A895
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 23:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785281108; cv=none; b=UCIqFEkGbp4Hur5iAz/OFAqhIsGk3f0uPVjMUxpbs8d1FQPCuf2eRh7iIJGK18XZU0HX8dclSggmqJ6HstacLvZwTbgI3SIlha1w8SP+K94aWz8i5cHCt5hSLgySx9TdTGxER/E1ruZkkW1fI7QqG8PFwWXajANemLoSY/aD+Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785281108; c=relaxed/simple;
	bh=dyYR4j0zngCVqz+x+KInh1jMKE2XJF+qPGyngQa99D0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V6MPCVxgCIo9UmAAVG+wFBprwcA8pCExiJGiuN9bbDZOM8IsgzlALmBxco15DRB4QV+V95tMVMGY/g6YLytiLw0J5FEvsYsOV7G03txhsYQB0Jif6uH+dANv61FpWGlKjlgOldl/HJF04aohUSwi4mIqaMVeKoQirCMNK9sz2PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NRKNhaoZ; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRKNhaoZ"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848474825ffso389574b3a.0
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 16:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785281092; x=1785885892; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JEPKiAtBKWiVcPuC99zePwKy+gegS5+5igZvq8x13Ho=;
        b=NRKNhaoZBY/u6aZQ/7NiNdkmpRAFT/sVss4mOrrA59GPKWTe6ZTV/+rC/ySPUHRey0
         EfQxJhN39I1sXI4LacRiGIgWxdsQIu+TdVT9tlk5mr+mx32mFiOTTinEWeDySaIh2AVv
         3Lf9wKFtAGvw+4eewtcSBjFTY82soXPLIXrWt8ZqNxN+fOSsFeCELxoV73qsNBBMwRX2
         6HOUpe2siX+/KKJWzTUJUTZH1Du9izqg5cCOZTxzCvtBSE0clQ4llgRr+aS10gbHOysu
         NVBYxXsekc7CipQgzUsuX/q9ajjzaDM3dZgf6ejFyLV7udiZfa1ApGkTLzw5YzDHjiuX
         p2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785281092; x=1785885892;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JEPKiAtBKWiVcPuC99zePwKy+gegS5+5igZvq8x13Ho=;
        b=IKWInwHzbWi2tm4hHeBNJsUJgXHDz84PLTYl4bxx8BRfk756Txgjs5bYjL8Yv9ohGB
         zCTAFe0tQlHMd7P89bsH3u7vowkpZv3b9BRmyFo5XIzCHX7BLeqVbqKJB0KQ6bkaBbNq
         rhWAjp3rslQ9VF1cDT5H2koz2g/r6BvryYybvSUuFD0LSItRckGyC/3QkG9+yNanMMp5
         0tSel+S3YFA8YS/SPOV3CxsVCbvjdCV7dKTpL/blPk9DaJ8pz/KuWOFeQGFi6ptjeUO3
         rTnKYclBZtHniH5hyU4m85lixztVbkvPDiQHeY6laRHompAYSKzW5ehKQRbwMBhah//2
         a2Nw==
X-Forwarded-Encrypted: i=1; AHgh+Rq1noo+bsDj+fgdNcbdPAKQtuw4oN88Vb8cc4/Tb0RaXudmKgDGqgZMl3u7YTR+mXP5UNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmQVLd4ytegFz9+ckl8ZuJsbSl42kxZj2ncVJuFcZCkgWRRoJP
	+THWeIZj3C1mNm4YCklCvw7ptF59PeUAP9YDfhgu6eTvEEV2QmFsmQsh396H25UnW03d+dA+C/b
	F6M1cXdz0
X-Received: from pfmy25.prod.google.com ([2002:aa7:8059:0:b0:848:866d:f119])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:8896:0:b0:848:3576:3204
 with SMTP id d2e1a72fcca58-84e932afca1mr4278256b3a.34.1785281091851; Tue, 28
 Jul 2026 16:24:51 -0700 (PDT)
Date: Tue, 28 Jul 2026 23:24:31 +0000
In-Reply-To: <20260728-igb_v3_b4-v7-0-4616c3745796@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728-igb_v3_b4-v7-0-4616c3745796@google.com>
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785281084; l=4509;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=/AMwUytczq1xkCFYAVp2jMCbUjAqxn98ZchniM81g6U=; b=ibJXjRQiGPdwLKIeX5VV7+iX2ZSUuop/p87JCWvShSvPdThiYY47fZx/7n37/D10MeRTYxAIT
 jT6a1qQCv4bBhSG3NM8A+TN6ZoxpBRS60M1JgPDnnsUHMpA0I8Df/hx
X-Mailer: b4 0.14.3
Message-ID: <20260728-igb_v3_b4-v7-6-4616c3745796@google.com>
Subject: [PATCH v7 6/6] vfio: selftests: igb: Recover after DMA-read faults
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"

From: Alex Williamson <alex.williamson@nvidia.com>

The mix_and_match test intentionally submits a TX descriptor with an
unmapped source IOVA so that the DMA read fails.  On real 82576
hardware the resulting fault leaves the descriptor engine unable to
service subsequent valid descriptors, so the next memcpy in the same
test iteration times out.

The 82576 datasheet (section 4.2.1.6.1) describes CTRL.RST as the
software mechanism to recover from a hung device.  Empirically
CTRL.RST alone is not sufficient in this state: the visible queue
registers are reinitialized, but the next valid memcpy still posts
descriptors without any TDH/TDT progress in the same process.  A
fresh device open after the failure works, which points to a reset
scope broader than CTRL.RST being required.  The 82576 advertises
PCIe FLR; VFIO_DEVICE_RESET drives FLR and supplies that scope while
preserving the selftest process and its DMA mappings.

Add igb_error_reset_and_reinit() implementing the recovery sequence:
issue VFIO_DEVICE_RESET, re-arm the kernel-side MSI-X trigger against
the still-valid eventfd via vfio_pci_irq_reenable() (this does not
touch the eventfd, which test fixtures may have cached), and
re-program the device via igb_hw_init().  FLR clears EICR and leaves
EIMS=0, so no explicit interrupt mask or cause writes are needed.
igb_hw_init() resets tx_tail/rx_tail to 0 and igb_memcpy_start() zeros
each descriptor before submission, so no ring memset is needed either.

Call this from igb_memcpy_wait() on completion timeout, preceded by a
10 ms delay so that PCIe/IOMMU/AER error handling triggered by the
just-observed DMA fault can release the device lock VFIO_DEVICE_RESET
contends for.  The delay is heuristic and tied to the fault path, so
it lives at the call site rather than inside the reset helper.  The
failed memcpy still returns -ETIMEDOUT; reset recovery only ensures
the next operation starts from a usable device state.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
Reviewed-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 38 +++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index 12fce3d69025..4adad15f16a0 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -480,6 +480,28 @@ static void igb_memcpy_start(struct vfio_pci_device *device, iova_t src,
 	igb_write32(igb, E1000_TDT(0), igb->tx_tail);
 }
 
+/*
+ * Reset the device via VFIO_DEVICE_RESET (PCIe FLR on the 82576) and
+ * re-program it.  VFIO_DEVICE_RESET tears down the kernel-side MSI-X
+ * trigger but leaves user-side eventfds intact, so re-arm the trigger
+ * via vfio_pci_irq_reenable() before reprogramming so any caller-cached
+ * eventfd remains valid.
+ *
+ * FLR clears device-side state to power-on reset values (datasheet
+ * 4.2.1.5.1: a PF FLR is "equivalent to a D0->D3->D0 transition"), so
+ * EIMS and EICR come back as 0 from their register-defined initial
+ * values, and igb_hw_init() resets tx_tail/rx_tail to 0.  The next
+ * igb_memcpy_start() will memset each descriptor it touches before
+ * submission, so no explicit IMC/EICR writes or ring memsets are
+ * needed here.
+ */
+static void igb_error_reset_and_reinit(struct vfio_pci_device *device)
+{
+	vfio_pci_device_reset(device);
+	vfio_pci_msix_reenable(device, MSIX_VECTOR, 1);
+	igb_hw_init(device);
+}
+
 static int igb_memcpy_wait(struct vfio_pci_device *device)
 {
 	struct igb *igb = to_igb_state(device);
@@ -522,7 +544,21 @@ static int igb_memcpy_wait(struct vfio_pci_device *device)
 
 	igb_irq_enable(igb);
 
-	return (status & 1) ? 0 : -ETIMEDOUT;
+	if (status & 1)
+		return 0;
+
+	/*
+	 * The descriptor never completed.  On real 82576 hardware this
+	 * typically follows a DMA-read fault from one of the intentional
+	 * unmapped-IOVA tests; the fault leaves the descriptor engine
+	 * unable to service subsequent valid descriptors.  CTRL.RST alone
+	 * reinitializes the queue registers but leaves the engine wedged
+	 * for the current process, so a broader VFIO_DEVICE_RESET (FLR)
+	 * is required.
+	 */
+	igb_error_reset_and_reinit(device);
+
+	return -ETIMEDOUT;
 }
 
 static void igb_send_msi(struct vfio_pci_device *device)

-- 
2.55.0.487.gaf234c4eb3-goog

