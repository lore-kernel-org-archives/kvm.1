Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32A542BC2A
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062689; cv=none; b=ZCa/rMWLx9Ex2gpcCtL0z4JLkAdb0vDWqUgRkLAg7E0XxxJelSs7GKb2hwDXXF86tqYvGuzUo4A6jRfejUtNdMiAv0FpEQU0wEL/dFwXTY/x3zLDu/OXchq9OGkweW1kk92U2RHJ3z7MZqHdcjzHyT/GM5R/UCcybY9/N3H1z/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062689; c=relaxed/simple;
	bh=FSq5U/UC7VwBZGVwhMUFBjIeaq81KngHtqc8zuealas=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XwJ1XkV66Dicsw7nAjkkF3NDhaV5nHwlb31N2+eDkIMdZekGFDrzNUuoRJgGGM2IIQKeCvZS6hKf0xPo7bCgikoAtYEEsPrBOk4a0QWg9DIou0Or1T0eBLnGVBUjBSLT5GU8ybmxIw8rmuSEcIvgL6XkUpV83tIfkqSkb6kg510=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OoEIfzbL; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OoEIfzbL"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cca3673560so87763765ad.1
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 13:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784062682; x=1784667482; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3pJ39X61lk/6Nbe8kyvmOauMbOhUHTpo7eMvr2Ik9iA=;
        b=OoEIfzbLxj7B8Kroa2pzUZX40yIUYtCUiRLbVqM9AbG8qk3yeGkh3rf/cRApv0wa5d
         idMbdNnPSVxJCGSamgh0EL6vW18ndaugDFvBEt+xonulds6DLBlkGUhITZbOvL8wraN0
         B8Xuyqay6pt7J8lxA0406gH4+mQ6RH7QuRKi4Li1fdg0anZtS9m2U17iiT2s1Oj/lUpU
         l5/AVgRn8BzyG+e2Dg7H1RR2XFCxEDhqRUTHz+AcMWeJ9ewA8+UhBCWUep6YqZ7Zsa22
         4iOfa/Oqz5AkXXsUKgExN475Arp7HN1N1+ThgDUN19xIOrnK1WY5V+vU/24PR8sUKsPJ
         GxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784062682; x=1784667482;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3pJ39X61lk/6Nbe8kyvmOauMbOhUHTpo7eMvr2Ik9iA=;
        b=QTM0yKVlNnsE7ChFnR+4e2yHUWK8rtWZ79EV3fCAXkclwHU12D7TJZ5srtaN12bw6W
         pxVCiVi/+k/6fkub9dp/TQoSH4Sxw5TFnNewxVYZXB5DvMD4Jo/GJ2D1aaVijEqrlnxM
         VRLjM5b60kCrRJiEQEGravR36YdjqqFlEZkQi2+YyOsFuQtoxvKYmvlKL2cKuRh+NQEL
         oZ3rjCJCKpsnD9IWdH8YMAzp74qtsoq9xjpCBLv5fRAbNSGOUrDfBzNFAqZoafABIVu/
         5ZTKT1GCh6zE3oupSVpq+GWP+uosBuX/ql1JmVFXbl0A5UcKO7/LteDIFPFzUI1jI8ZV
         apNA==
X-Forwarded-Encrypted: i=1; AHgh+RpnYscvmKAv8wnhmjDl42fArshs2nNI/0WZr6bEtnbHR6Br7BqsOcdwpZdOClvxohhYYLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1tuDXPNX/NrPVWbTVTotLsg2zX12LCUq7ZI7staoc2+zpnAye
	CVjce0HUn1dmuk0EhngP4kmdNwPdTr4bh0psZ8H5aeDfkwhrSdGtkq/nTncyI4GPYPtZS/rk0GE
	NMFgu6I+A
X-Received: from plco9.prod.google.com ([2002:a17:902:e289:b0:2ca:b907:d842])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:8cb:b0:2ce:88d7:a233
 with SMTP id d9443c01a7336-2cef13311f6mr44803885ad.33.1784062682045; Tue, 14
 Jul 2026 13:58:02 -0700 (PDT)
Date: Tue, 14 Jul 2026 20:57:41 +0000
In-Reply-To: <20260714-igb_v3_b4-v5-0-91503eddb98b@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714-igb_v3_b4-v5-0-91503eddb98b@google.com>
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784062676; l=4873;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=+iHZ7lIltR6iEJkTR5SPoykNEkzMCprb3kOJfZ1WzSs=; b=SvTAJ5lh+jqzjtQjw5tqGFdEAC2BtBfJX/ISYfKx+g9bQdIRYlf9gmRwRIFOpl+P7YkB44eKg
 K89WSQK2plKDBCv6e70fhMA9wBj58du/OIppwzEw7jhnky7g1XJgckk
X-Mailer: b4 0.14.3
Message-ID: <20260714-igb_v3_b4-v5-5-91503eddb98b@google.com>
Subject: [PATCH v5 5/5] vfio: selftests: igb: Recover after DMA-read faults
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
index 8eaf120330dc..f50d450d3e94 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -458,6 +458,28 @@ static void igb_memcpy_start(struct vfio_pci_device *device, iova_t src,
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
@@ -500,7 +522,28 @@ static int igb_memcpy_wait(struct vfio_pci_device *device)
 
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
2.55.0.141.g00534a21ce-goog

