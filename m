Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC163478E51
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 23:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454307; cv=none; b=AbwDJYUxXY1wxZYsw0SZaLYqgcg6xIXSZ2SnZu19WgZKugHwlldxXHQ9Wo/1AqXS3AWNxSdvvogfE9OVgLDNXRmwW1NiapTnI1U7TeKE9tHRhYAGHD0Ct9CBbfVutDxSpQmJdGEmpoAnhgiUlaykJJLzFx8hbEt+5gzAPQ1v+oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454307; c=relaxed/simple;
	bh=sJhRgHvX8tBha5mC3eCgdsV+r/MYo/kYj1lH6RiFCcs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q7kl3JgCAFsZ6SK3IzcpNduTXiV6Y9gxixCJOne4ACtnCR6SJ9LFJAR5srjmU0dyQZMGKimnp1pjKQPLNjqTkAajOAjVPC/C3ImTFW0Pu8DXPyvmBOMYabxFQmhRtIBPm1K+aTt22003oLjXJ1m90t8VBukcRAHz7lztymJOTk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pkQAkI0n; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pkQAkI0n"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e13b57b2cso505189b3a.1
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 16:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785454301; x=1786059101; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=btLau37SdYXavQnsMTJhTLhwoXJbJ/QrxI+9IfAtvg0=;
        b=pkQAkI0noXObvkI8t4JZHfxtr9ZyFk2ISWTbJrjEXJqVszaeRbJlbgx7E93rwpq5wq
         bnnz8CEc+ARR+tj/TgORXszEyYfKMzXTFzOorQ51jSrm1zrib+cDNEwtlOwHe9CaQHzh
         9/v3+A4gtXm8gmZ16t0wumMRrTmItGdzoqq/COYeMOABOOPWTfblKko4mghMtnID9i76
         a2rG5/iLQt2l0VauAER4toy8lTJJSGiKh+cEvFQE1QtP5IJVdX2bBqC+4c7LN107xkfp
         5jxV6yV/o1JNi/PbP75ixr8Qp9CaVXnXYTfmmzZ8NefRSoFa9Szv/zsVMSaocgVse//o
         H24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785454301; x=1786059101;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=btLau37SdYXavQnsMTJhTLhwoXJbJ/QrxI+9IfAtvg0=;
        b=jvPFbgvU9QYKuq0+7hIGwgXurwqW1RrYVcLdzpEDWh4S7ZcJK5MVb6VeS3r/R3GAjl
         iqL+ntIBn3wJvRSH5KxcuJcSErvWACJX6ROrN+sh0BG7RpgxaczsefJkNVbBUSzeBigR
         skLrVE0HvVb9VViXNrUEIStFde6QpxGFxBsxu6TJOCTzW18Z18HuBs++BAMPs0IVopYI
         f7C6tH7bCR41882yqGD1Bbj4d62En73sgRihEmKGvF+nInEKc0spPA7I9jB42vALisJK
         DPRmvmNMSo2RWotjnWRt9bbNXHgOxjVr+ojJWbv3cjhfiSQ4uSUE/uZ5HGY74z/6lJVh
         o3BQ==
X-Forwarded-Encrypted: i=1; AHgh+RpnqmvgF0Ng81oYaI1yq4zCZnOPtyHVSF/CgcMRDqqRxiVK4txs1j6YAhmHkVp/v2MR2Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6uhV3wMY/0fK5fuyVcOCaDeBwpv7s9gHOM6QTi6HmKPLtZcr5
	and0H6b3fnAYQ6OW1g6ku0p3kthMeGL+6RRRLIr2fB8Gl5CcCvSeyHGlTMCMZpvQ2QLI7JAaBaL
	NGXD3WhC3
X-Received: from pgt8.prod.google.com ([2002:a63:1348:0:b0:c9b:5bf6:f971])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1da7:b0:846:1b9:cb63
 with SMTP id d2e1a72fcca58-84ecb949dc5mr1490291b3a.62.1785454300475; Thu, 30
 Jul 2026 16:31:40 -0700 (PDT)
Date: Thu, 30 Jul 2026 23:31:33 +0000
In-Reply-To: <20260730-igb_v3_b4-v9-0-9e4d8682437e@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260730-igb_v3_b4-v9-0-9e4d8682437e@google.com>
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785454295; l=4430;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=41LjLP/2rciQRYafRn3V+L7ivh82IZYVKjRAxCqGtWA=; b=UxoBRLTGL+7K8DB9vJ07CknESqYl0cacEHYNjsFr4eocS0GeO32yWa5IHX+x8pVqipkWZ7hR5
 HINHh7L9jnLANNxabmqVQ5C+uZOWJrj2wK8WxctOcmm2sYMKSHXqHhl
X-Mailer: b4 0.14.3
Message-ID: <20260730-igb_v3_b4-v9-5-9e4d8682437e@google.com>
Subject: [PATCH v9 5/5] vfio: selftests: igb: Recover after DMA-read faults
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
index ac7b52d89757..97a2f29aade3 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -478,6 +478,28 @@ static void igb_memcpy_start(struct vfio_pci_device *device, iova_t src,
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
@@ -520,7 +542,21 @@ static int igb_memcpy_wait(struct vfio_pci_device *device)
 
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

