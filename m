Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B728B3DB310
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 22:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783721225; cv=none; b=tATWf1Dwh7REFfT8MCyXEXfFpWIyz0lSnlJ7vvbWYV2S2YQor8z0ZFw93iNdDEe8KfZjtfiagOFgC6+SBJE99Ly5UtohJ1QoKe/gnymgeMaguTznBgQMi3wYjOt1+kvo6fxikpKew9Qvc3dO0/x49xBv1jiS1tnhMwprSltbf7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783721225; c=relaxed/simple;
	bh=VQFmUAlim5jQu8woDrKlC6bOAbFrCCqDsh3j5t6QW9I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lCg2o9WQDmIrFZTUrpeH6D9SOf1oc2WBkyYdiC6yejkZV8ly/lnBvw3E7EmLLW1VcamakjAVgZzrt8CjSC4rlisU+zqlAnoKUSsS+W8IhuER6u4j/iCLHenoPbk9Rp2hipZ4tK7Qk4VbZbX4E1xEykBzTSH1ZT7gJ27d+s7vMyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uTj1N3yl; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uTj1N3yl"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2cc6dd43737so27828965ad.2
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 15:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783721217; x=1784326017; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7jWCHK+Mcfe3aW0kz1paSAUghYLWj0BILc9NRBI8+lI=;
        b=uTj1N3ylB04TB6YyXQhzbg4FjTCp+7HDQCTPrZf/D2mty341uWGLlrssznW9HnK05z
         7tlnKYBfINyCTENUqQwV6aM3d19qCp62e1Qco6gXCqytIctKAo154apC34URQG6cI/h9
         hCCeky+iUrJKPXOWsSx+wmJyRPj1qPBDHVT6HG+sIbE0tYd0+TuwhFbAGfBWqML7rkyh
         IQDMXqZsphxklkXQMGacQAeh9kD6HeUr+m5Nlb3orR8vNHVBRqSgiNxq3WETPQgGi30c
         VbaxxzEbuHmY2d9pxXbYnwN5o8IDs8ezOxodZEP3hZRk2eFhI3uAw6eor2+e8CY5iJei
         nJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783721217; x=1784326017;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7jWCHK+Mcfe3aW0kz1paSAUghYLWj0BILc9NRBI8+lI=;
        b=HwLEAxMz5QJCvJiztpyN1qDDqUpamFqObs6yH1IgO3uDNaoU74O3MNEyby23kvx7Lc
         c/+pPCClWmhcb9wYgcd2MWW3vQ9xybE5ABbBDj6xRa+cMZ6IhdX4J5hZczlRKxti+NZh
         KN/3EjFeHtoSiyJfU+7JZStsl7/0F4IzaNBu45NbxNvmOErrDePLHf6uuR5kJ6mfTTpR
         ckcJVcodF28OXnzhyEMzg7+IpXgjSctibi9JCzWlfUkUk+ye7PRRXjkAT0fUc9x/weEQ
         9aN1bU4h361AxBdpzwaB/tfXX1fGJ5ngF7OXq94VMd4f7yEVQRfDBeqWAMo5WZCA7/07
         uvdA==
X-Forwarded-Encrypted: i=1; AHgh+RopBpCKRrCd32NjkFHEfRxydCqljvG/gjCC5qNaBxB/BmB/p9ZkJRmN8tvAs7da3bSN5fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfpjOqssyfLwZ7iTCQ++ow9n4JfHorwo9Jbflh5+cVe0p+4Xmg
	3kaMoirHLIDmM9L+0k0bOGqujjannUIXRlqr5qSfSA+AZLQjWZCf75bgz7NuhrtHLokH6KlZCOA
	1ZrsPYPG9
X-Received: from plgv1.prod.google.com ([2002:a17:902:e8c1:b0:2cc:7044:4346])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2983:b0:2ca:d666:df72
 with SMTP id d9443c01a7336-2ce9ead1556mr8008955ad.21.1783721217228; Fri, 10
 Jul 2026 15:06:57 -0700 (PDT)
Date: Fri, 10 Jul 2026 22:06:53 +0000
In-Reply-To: <20260710-igb_v3_b4-v4-0-56e7e2576cc1@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710-igb_v3_b4-v4-0-56e7e2576cc1@google.com>
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783721208; l=4873;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=SybNIe800vS/azPYYOHHfOsE4B9hb1uiVaknYMjZzyw=; b=ylIW6ZAisGRB0cPzbwFGJTZ7ARz05XJiKCCX+flh9NIpfGkjb55JbgdLAW4MmdxUZNAtSLOtz
 7OoeDATb+JzDwCNGeZTH5JQm6vuhhrNbdCN9xZWPq2cbbYI+4HE2fDY
X-Mailer: b4 0.14.3
Message-ID: <20260710-igb_v3_b4-v4-9-56e7e2576cc1@google.com>
Subject: [PATCH v4 9/9] vfio: selftests: igb: Recover after DMA-read faults
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
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 45 +++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index 23d924b791d3..206a1e6489c2 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -448,6 +448,28 @@ static void igb_memcpy_start(struct vfio_pci_device *device, iova_t src,
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
@@ -490,7 +512,28 @@ static int igb_memcpy_wait(struct vfio_pci_device *device)
 
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
+	return -ETIMEDOUT;
 }
 
 static void igb_send_msi(struct vfio_pci_device *device)

-- 
2.55.0.795.g602f6c329a-goog

