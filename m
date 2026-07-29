Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E10449B01
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 22:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785364034; cv=none; b=WXC2heiOuKNwve8mYY8QkGK2SD/V/r87qo1amXGxbIwHf+uEXSKAM7qGI04OFOSpyV2x4/FeBRau/GTNy8rX6hk8GWEUacNfmmvwlaea/BbwvigM4hW28+cA1pmbbGEg0nf+yrtnDPp+H5m2B9Z7rHkVDOiRKxXMxNe05QL/wTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785364034; c=relaxed/simple;
	bh=lGkrKT9/9Ew0IKaXTGFVzH1tnSEh/k/7aacZK72GMd8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CvtfzmWuLl7iHfvbqNW4NyKFtilpYlzq3l0VGvtgouAxmOyf+BEwCALMaKXaR9I46G6LC3lu1UYmA5psahAkUn/eoMYnV5VQ098aKqcpgVL+FHia/Hd9YExWmI0Stirda79CtD7Ah8BZ0dlLUWusAVbFba3u+Djoep7t0tyM4OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H2222HWs; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H2222HWs"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8487ed7f7beso1542892b3a.0
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 15:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785364031; x=1785968831; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dYSUOVi/YcPFHLGdsUg+6qIajHpp6dbl/W50j1kiKQU=;
        b=H2222HWsmlLrMlp5zfH5Dz6Zv7/pItUr5Io+Z0Y+mT2Qd9a9KAjZ2UOOZWWx8qV6G4
         otFT6U+AaWaaglZy0bMEfEI75RlCBqdcm5j9ApeZX7HH/I80WjqiZJzvZ1sXidC7ko2b
         6v51cWP/ePVdElOp7q2XQXORfgtGcnhdtH/JxW/vH3SS8qOQf/FHjoeK9zD3k+dsD0EZ
         yYYwOgyIs8bZnCcHfu5W1sNnhwmoJqBijhCz8noz4mlYuZbx+3SEiqoltNkRkZ1w2V2O
         yGHqKCfX8k0BwoIqMMy9dqF7jJuhRzrQr9yUy3QrIQ2r9p6+qeXqEUQr5uaHJePPLTO2
         Tnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785364031; x=1785968831;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dYSUOVi/YcPFHLGdsUg+6qIajHpp6dbl/W50j1kiKQU=;
        b=S+ewMEsTZjEv6tsSFG18UCh0GaTGteFdIlrH0W+MOoFGw9tG3qdbGLErKon0HsqnkZ
         FEduL+ju9fNtch0JNZyDHTs092xaTLXP4kZxfadfkvpSxxSha2Izv+6vJb9BTqcL4X4q
         DN8+Ync6G+OKMN6IAEIi0AnlZ5Pr40MycROhtEB7JW5BOIVeFTKstpxSNVAkBsu41x04
         kWsjgrU37wMqptYVMbH21rgfgr5qCXUCOYby90pLUOKnuUHiUynR2Btjnhtj5rdDM5iP
         oUCH1LkB5VPM2BBRkSJ5PPOdZnKdN6MeBcLAjJKeCexKQxHMbGw4tMx8ydI94cIfNexq
         NRag==
X-Forwarded-Encrypted: i=1; AHgh+Ro8s+wm6ZHh8tPbHHv3/mPI+QzZSYqi1mszygQdhsl7PjjFWtQ5ZqtlEjSuiK69FLQEkqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYSL8bhW+Xjj8nsmGAy2oBx73mAE15wlLHOvVREi84Q0fhsQmL
	tuU3PBi1owj5Qz0g5/TmFzCug2mHbsScvnrszqsPQNEnPbaWX+74MHffYdzVEmQ/d9j3UiP2K30
	TtDgi5wCl
X-Received: from pfwz9.prod.google.com ([2002:a05:6a00:1d89:b0:847:926b:dc17])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:e13:b0:848:438d:3665
 with SMTP id d2e1a72fcca58-84ebc3ddc5dmr138466b3a.41.1785364030976; Wed, 29
 Jul 2026 15:27:10 -0700 (PDT)
Date: Wed, 29 Jul 2026 22:27:01 +0000
In-Reply-To: <20260729-igb_v3_b4-v8-0-3ed236272b4e@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260729-igb_v3_b4-v8-0-3ed236272b4e@google.com>
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785364025; l=4430;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=UBcl8gUyQtUwJkhFbO1LHBTsapqjS6lR0WFKGzbETtI=; b=eFIZsSOClpkIO21dUN00oLj3idNkOQtKSMeC3Z1lg5ws2dNR3DUpmj1ZGAqlAYvWe5yFkwf2m
 3nbGfDKRTJxAf3YByZZOKuWUbk709zSniEPPlNbbgrr4T+B/DMbSbyD
X-Mailer: b4 0.14.3
Message-ID: <20260729-igb_v3_b4-v8-6-3ed236272b4e@google.com>
Subject: [PATCH v8 6/6] vfio: selftests: igb: Recover after DMA-read faults
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

Call this from igb_memcpy_wait() on completion timeout. Lock contention
during reset (e.g. if PCIe/IOMMU/AER error handling triggered by the
just-observed DMA fault holds the device lock) is handled by the retry
logic now present inside vfio_pci_device_reset(). The failed memcpy still
returns -ETIMEDOUT; reset recovery only ensures the next operation starts
from a usable device state.

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
2.55.0.508.g3f0d502094-goog

