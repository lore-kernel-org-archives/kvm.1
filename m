Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C3D3E1720
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 23:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779839717; cv=none; b=jV+cXu3wBTHydu64N/7wha5NSZ24ph5RnDRiHlwxvjCz94LcFDDuroTjDvNKGzPkiwP0psjMTsrFbJM8OhQO+i4Z9/MdZ4fvGYrxn0guiKJYW2xeE55Pdvfs47+01wtpQa1VelM/hs/CEoqMC0NkUoL6Zprj7Hrg8sz5ibjhKf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779839717; c=relaxed/simple;
	bh=RKwcPju0D0Ae4XZ710mOGXvpKtL6dEpFyW+llO09pUM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ogeMWafOdr8RV3j86M8FFyxyuVrfTPoI30Xsw5VcPKyquiJ8CUPjMQdz9/MpdsBUDv7Gfm6hGXKfwSstTHSi+62KWNqCDOv3hZ49x1DS2/SthBCfV7vy5iH9CeUffGYnPO3LSLNKYdwhU1nSbDhbpTw8QmWAy0WmWQ3vQ0ACux4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DhCqF7Dv; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DhCqF7Dv"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd1dbcccf6so50955815ad.2
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 16:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779839694; x=1780444494; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vz+KkZ7tOk5JamYD7WNPE7hLMS/iYVa3Afqf95yRfgQ=;
        b=DhCqF7Dv1tBhvcQeQhwEDfrs+nRTLrrhlEoQg109XAxq9KcqLtpljvA8EgwJJRIqoI
         vrdF0LFyyQMuJXq9H7DyRvwh2XivD0AapiXAyHJKcsyZJ4kiop1n6vCX2cZ3I0L+sCOs
         27jhMXSNcJGzM38EwaR/BZlcEamTyDFD/XcRwf2BUquuvQsiv6/kx56f+76Rh8nfKoqV
         BcN3o0BfpagpMHE9YE6dsLkAVyJz1jcAnj23zpb5YBpmjq9XZF/bKGUx6wAEn21qh8F8
         miUHzc4HK/HJLdxIUDFLeAPBRm2a6eWzHLH0qnOoZUzF6vSf5kAGYbUvKX/uYR95kYU5
         b8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779839694; x=1780444494;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vz+KkZ7tOk5JamYD7WNPE7hLMS/iYVa3Afqf95yRfgQ=;
        b=aVVoA6pAE6Lx/Qp2sLd/oEPsWcoZoiwAynYzi91fnr0z2Oh9cZ9lW6XoWrZ6+NfzSs
         aEYi1behALvomj1u3wUalNSwo2oGtp/oJaIPeKikTroquPXcR0OtroJjeT+op6yikj8s
         d0fxudRl1ikWLkfGwILJerAjMss6QXcZOVe9BgCsX6nUBNR8KpaNoWUmh/5n/6QDhluU
         5rA9XUK+XywpcSwOg4+okRe+/KGtj8TTjVj8PhhvUEsJT3p2nMKckCJOrByQjDk6IuV6
         J2kVUuwy1FobgHiHSgQiQuzmxvcSOmNTQjt2J5uxEWTTmZAicysHSlqMPE8bzy225UFC
         vAnQ==
X-Forwarded-Encrypted: i=1; AFNElJ/+6fjPDS51zg3q3chif7rZB7P0F8aNvWBdgRpwHwRwxyQORkSrI+JGWMm8LBOzi/hMeDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7MdtHQBE5YTPOxg8/rTkWJnS5eXGWFcUBQX22jJCDZ0lzxu5l
	SM5iZ+VARp0DE1KfOMzPxHb9ryK2N5mFixRA1zlUlZkNKZO9ngVwJON071upkCJWXYY5rkPAA68
	+3HlyycX+
X-Received: from pgbbz34.prod.google.com ([2002:a05:6a02:622:b0:c79:2263:366d])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e545:b0:3b2:a8cd:ef4b
 with SMTP id adf61e73a8af0-3b328e5ae80mr19811991637.25.1779839694283; Tue, 26
 May 2026 16:54:54 -0700 (PDT)
Date: Tue, 26 May 2026 23:54:16 +0000
In-Reply-To: <20260526235417.2058313-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526235417.2058313-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526235417.2058313-10-jrhilke@google.com>
Subject: [PATCH v2 09/10] selftests/vfio: igb: Recover after DMA-read faults
From: Josh Hilke <jrhilke@google.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

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
---
 .../selftests/vfio/lib/drivers/igb/igb.c      | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index 1ac0a32523ea..5568b463c2f2 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -423,6 +423,28 @@ static void igb_memcpy_start(struct vfio_pci_device *device, iova_t src,
 	igb_write32(igb, IGB_TDT0, igb->tx_tail);
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
+	vfio_pci_irq_reenable(device, VFIO_PCI_MSIX_IRQ_INDEX, MSIX_VECTOR, 1);
+	igb_hw_init(device);
+}
+
 static int igb_memcpy_wait(struct vfio_pci_device *device)
 {
 	struct igb *igb = to_igb_state(device);
@@ -458,6 +480,24 @@ static int igb_memcpy_wait(struct vfio_pci_device *device)
 	if (rx->wb.status_error & 1)
 		return 0;
 
+	/*
+	 * The descriptor never completed.  On real 82576 hardware this
+	 * typically follows a DMA-read fault from one of the intentional
+	 * unmapped-IOVA tests; the fault leaves the descriptor engine
+	 * unable to service subsequent valid descriptors.  CTRL.RST alone
+	 * reinitializes the queue registers but leaves the engine wedged
+	 * for the current process, so a broader VFIO_DEVICE_RESET (FLR)
+	 * is required.
+	 *
+	 * Delay before requesting reset so PCIe/IOMMU/AER error handling
+	 * triggered by the just-observed DMA fault can release the device
+	 * lock VFIO_DEVICE_RESET contends for.  The 10 ms value is
+	 * heuristic.  The current memcpy still fails with -ETIMEDOUT;
+	 * recovery only ensures the next memcpy starts from a usable state.
+	 */
+	usleep(10000);
+	igb_error_reset_and_reinit(device);
+
 	return -ETIMEDOUT;
 }
 
-- 
2.54.0.794.g4f17f83d09-goog

