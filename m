Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B013B8412
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 23:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783552751; cv=none; b=S7fQM+zXbGRHgNmw5MyKDXOIhFPrfzaWAxx2FV3hhUySTrZ6niPjQww57oN1FKtCHx72PCtJCWlwqEyn2Lksxnl8bpzINQNAa93JIYj94kElV8nF1IKE6nIThxquO2txQR41mQ2T1VL21asDA92Qe7MFHiKUQkdQmfQxpRNZ32c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783552751; c=relaxed/simple;
	bh=movNesAEHVFAEjnO4NNsk8Xj90oYrmuDq5ixpOPmQ6E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d+NGQ4V1yp42lRrx5tBsE3YX9445dOnEH4mW0N/WaGSkanqsB5CWGYFEG4cZakLuODu77sLeiTRS1zJB9wVq+DvJjveET1jSbV1r9i+qgB0ZjoMGSPdG9SV9D7de4VgsHrvzNgKcLmixKnOgZo7SVFIoo2HMs0nRkGIZv5vUT7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g/5i3agr; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/5i3agr"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-848568a6f62so492842b3a.0
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 16:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783552748; x=1784157548; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EWFZv7+Z1/EOUntDJrKuup7CmxaHTp/ELEciBYwm9Sg=;
        b=g/5i3agrr6CGThwJz7oR+OsMJ+nWlAoUSrv7iTc+o0IyHz+5o1kV8/FLQmw6aMBs2Q
         PcABVMlmE/WAtCLZLyxBkCWWV7N6+7Wr1DJL4fTyYFjnfyla11s7LBPyiWFkdTJHVe/m
         kt6pHrnEh2k/MQr058cwKZtg/Gh/qabOjXcRpvUInGZtOOyu7YWrbbd5gbZ9z0OQXkuh
         ZDC421tt39N2NAYWg0LS0rF9mT1SqbfRLRdRtWHmaEp3hIKbe+T170PmkZJj7/P0+KnC
         NSN8+MajN1WNTDM9g5jknxbKO1IGBSxLLAoP8cZDlOTwDx9jxxbj2pdDnR1bvsMgZdx+
         fOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783552748; x=1784157548;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EWFZv7+Z1/EOUntDJrKuup7CmxaHTp/ELEciBYwm9Sg=;
        b=Lnm0aBTeJfN5gCqXSYpVyjkgW1JmlovbO1iORG/ipNVTkE6QDEyC5vFO48joqxr9eq
         dtMnpW9ga7Bz8cRP0LyQqwx7dih3EY2d4oBwXHkPyyBQ63yDcEgtiryJQCgQDu4qcZf0
         xzSlOjkwnI8rWRqfZ5Wj0FH+mQR5SD9+q47DZKlXrv2sYCQBqRy3ERC0CcSSV0s+jPLC
         3Ug47uSCH39xY4sI22IS97hkanxaQg/4pkX6njZrfHAtFBbIdeB9a2u3F5giXLnASRJi
         ewQp1nWWDC+st5u8kBkcKFoThebwfi+clbl2D/7z4+8T/jYcK7cP8CrkIKdnsHBDpJUy
         aLpg==
X-Forwarded-Encrypted: i=1; AHgh+Rrj2vttWcOPYuuBtyTgcy7go7xjgPC8Zy83OpAh2uDgZZmx5LsKy6w1XIXOme1BG5SeDQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFpLf6zevJHMiBn4p9tZkqcka252WJwnYeL3WKzrj/nWUPaiKN
	jh1TCfPColAlqoCozfU3C1Xd3hub0xI5ugjri+8ibjt2lHypcL1bEQ2CPS8iIBk7dNsRW4r9rRk
	jD7nqfLGN
X-Received: from pfbfh4.prod.google.com ([2002:a05:6a00:3904:b0:848:2ec8:662f])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8f0b:b0:847:8ccc:d7cd
 with SMTP id d2e1a72fcca58-84842fc46a6mr4786321b3a.37.1783552747777; Wed, 08
 Jul 2026 16:19:07 -0700 (PDT)
Date: Wed, 08 Jul 2026 23:18:55 +0000
In-Reply-To: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260708-igb_v3_b4-v3-8-1272650ca614@google.com>
Subject: [PATCH v3 8/9] vfio: selftests: igb: Factor hardware programming into igb_hw_init()
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"

From: Alex Williamson <alex.williamson@nvidia.com>

Split the device register programming out of igb_init() into a new
igb_hw_init() helper so that the same sequence can be re-run after a
VFIO_DEVICE_RESET to restore the registers that CTRL.RST clears.  No
functional change for the initial path.

igb_init() now performs the one-shot setup: region size assertion, BAR
mapping, CTRL.RST + IMC mask-all to put the device into a known state,
and vfio_pci_msix_enable() to set up the kernel-side IRQ trigger.
igb_hw_init() does the rest: ring pointer setup and IOVA calc,
CTRL_EXT, PCI bus master, GCR, PHY loopback, descriptor rings, RCTL,
TCTL, GPIE/EIAC/EIAM/EIMS/IVAR, and driver-state initialization.

vfio_pci_msix_enable() moves from after RCTL/TCTL to before all
device-side programming.  Its only side effects are the VFIO kernel
IRQ trigger setup and the PCI MSI-X capability bits in config space;
neither has any ordering dependency on the 82576 device register
writes performed in igb_hw_init().  Performing it once in igb_init()
keeps igb_hw_init() reusable from the reset recovery path (which uses
vfio_pci_irq_reenable() to re-arm the existing trigger).

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
Reviewed-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 61 ++++++++++++++--------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index a7a30660b23e..46207f018358 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -177,7 +177,13 @@ static int igb_probe(struct vfio_pci_device *device)
 	return 0;
 }
 
-static void igb_init(struct vfio_pci_device *device)
+/*
+ * Program the device into a usable state.  Split out of igb_init() so it
+ * can be reused after a device reset to re-program the registers that
+ * CTRL.RST clears.  Expects bar0 to be mapped and MSI-X already enabled
+ * via VFIO.
+ */
+static void igb_hw_init(struct vfio_pci_device *device)
 {
 	struct igb *igb = to_igb_state(device);
 	u64 iova_tx, iova_rx;
@@ -185,26 +191,9 @@ static void igb_init(struct vfio_pci_device *device)
 	u16 cmd_reg;
 	int retries;
 
-	VFIO_ASSERT_GE(device->driver.region.size, sizeof(struct igb));
-
-	/* Set up rings and calculate IOVAs */
-	igb->bar0 = device->bars[0].vaddr;
-
 	iova_tx = to_iova(device, igb->tx_ring);
 	iova_rx = to_iova(device, igb->rx_ring);
 
-	/* Reset device and disable all interrupts */
-	igb_write32(igb, E1000_CTRL, igb_read32(igb, E1000_CTRL) | E1000_CTRL_RST);
-	/*
-	 * Must wait at least 1 millisecond after setting the reset bit before
-	 * checking if this device is ready to be used (82576 datasheet section
-	 * 4.2.1.6.1).
-	 */
-	usleep(1000);
-	while (igb_read32(igb, E1000_CTRL) & E1000_CTRL_RST)
-		usleep(10);
-	igb_write32(igb, E1000_IMC, 0xFFFFFFFF);
-
 	/* Signal that the driver is loaded */
 	ctrl = igb_read32(igb, E1000_CTRL_EXT);
 	ctrl |= E1000_CTRL_EXT_DRV_LOAD;
@@ -289,9 +278,6 @@ static void igb_init(struct vfio_pci_device *device)
 	igb_write32(igb, E1000_RCTL, rctl);
 	igb_write32(igb, E1000_TCTL, E1000_TCTL_EN);
 
-	/* Enable MSI-X with 1 vector for the test */
-	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
-
 	/*
 	 * Program MSI-X interrupt routing per 82576 datasheet:
 	 *
@@ -331,6 +317,39 @@ static void igb_init(struct vfio_pci_device *device)
 	device->driver.msi = MSIX_VECTOR;
 }
 
+static void igb_init(struct vfio_pci_device *device)
+{
+	struct igb *igb = to_igb_state(device);
+
+	VFIO_ASSERT_GE(device->driver.region.size, sizeof(struct igb));
+
+	igb->bar0 = device->bars[0].vaddr;
+
+	/* Reset device and disable all interrupts. */
+	igb_write32(igb, E1000_CTRL, igb_read32(igb, E1000_CTRL) | E1000_CTRL_RST);
+	/*
+	 * Must wait at least 1 millisecond after setting the reset bit before
+	 * checking if this device is ready to be used (82576 datasheet section
+	 * 4.2.1.6.1).
+	 */
+	usleep(1000);
+	while (igb_read32(igb, E1000_CTRL) & E1000_CTRL_RST)
+		usleep(10);
+	igb_write32(igb, E1000_IMC, 0xFFFFFFFF);
+
+	/*
+	 * Enable MSI-X via VFIO before device-side register programming.
+	 * vfio_pci_msix_enable() only touches the VFIO IRQ machinery and the
+	 * PCI MSI-X capability via config space; it has no ordering
+	 * dependency on the device-side writes performed by igb_hw_init().
+	 * Placing it here keeps igb_hw_init() reusable from the reset
+	 * recovery path (which calls vfio_pci_irq_reenable() instead).
+	 */
+	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
+
+	igb_hw_init(device);
+}
+
 static void igb_remove(struct vfio_pci_device *device)
 {
 	struct igb *igb = to_igb_state(device);

-- 
2.55.0.795.g602f6c329a-goog

