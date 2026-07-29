Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E89D44213C
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 22:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785364032; cv=none; b=p3p98nlDwVfYXfD3nuEHs86VhiW1cF158t8QC+RAlFB6eYeDsGtVh+PvzyTlgd2EreFQ+tht5PaUEw+WVzz8yCsV74Jbgs4psyJejxaozuaUsZRLOS5qnSiMpTOKt0FqeIH65eyp1uAzQHPqlXvK+NDEGKs7v4IYGwz1e2o9Bko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785364032; c=relaxed/simple;
	bh=csNfI2x3QFOxWu8//tOsVOV5MX41CnuakyKKVjHijvY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WAQ0hgf3BEDBMy4y/qIdrgaG2hR39jFNlabyDb6H9n0OIpktE/RJKyiIckU597TpQE+a+l4HrWp+sfZL1K1QNKt6b3tACNf1E9CQke8xv5uN26a3Eg1KDPQBTCAuCH7mX6vdHeWSTEyWC2+CuGglFqyntwS8IJM0oSPaRJmBjj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cmv7DvGj; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cmv7DvGj"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848860def2cso1665459b3a.2
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 15:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785364029; x=1785968829; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GDe8oeRL5a94RlFUSwVHUk33PWIzE3GpJG7iNPEVeWk=;
        b=Cmv7DvGjVG2GJguC8WSntX9KPCd8ZUi7pvXxt4tCP2xnhWj7xmbQSmGqx5rnKoGyDH
         cB5jrjcmvO3Mu4NOEsGJTrDaF4IjCTUi81riN3s3tFSFy/U3IPi+j4dYMEeF0y5sT+nI
         5qQSqxLGtS5qesBoKW1Er246//jK9SdOkime6liC03oMaIUYUkePIjvn1qy1U3/kXJpq
         5H/Xh9WsIs3ZXnA1nIeE9g13Depl+iPTRrRgWVB43WTyhfzYjrDzTohLKW7nrbG5aBo0
         MkOmBFUeAmUxVkvQqL92He6tKnqoN3ueTSAXCtGGLFwMMb8fuQ6y28/bYz17RriFDqPs
         zIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785364029; x=1785968829;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GDe8oeRL5a94RlFUSwVHUk33PWIzE3GpJG7iNPEVeWk=;
        b=XGZa0jGSJoxBlGxpY+ag2eZ8Fnp8vcukiFnup0xIfpiCpUWP6TiFFnEUqk2gCFItEE
         RuwQinz5Xfod5IBcI7Ww90KMH10j0LJ+Wx+FDygMQQrhpmym0s+pCgCFF/x2zzfxR48r
         8LRN3pKX2Em01TWq+cCz3qtlmIg3lQw+VkZXzKO6K2tKJT1G8mPXGthCTYGizCzVU4UW
         thM9XcFwIk2vPgTXCVwWz9cTYS599KSBW0cYTaLTKewhNQ+8N2lXk5wE90VbyneJG+nP
         +NqXYByTiWUnYJ6KQxrVvWfLZAteGArc7pZSB5fk+uCiVA9Q96mX5febuxDc2pJgX3Qt
         Mquw==
X-Forwarded-Encrypted: i=1; AHgh+RqvRYYijojMLp4UahmmDJemDKXHq9ub/et6MURnFBQLvC/XN1SC1a3K8SCZFIjzwKB/04k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd8eecaTuqELf+U5oHOhcE9t0XUb2sJhnmljlzZ3K3b7M1tRgh
	hn1qqZ+rt6aKoKc5ISHELePJjrDQ823Xi1pI4lgHubt3K+6My+XjGfgNva+RNiVn02rOcc0BlEX
	MXhdlDKNe
X-Received: from pfst19.prod.google.com ([2002:aa7:8f93:0:b0:848:3e69:4b98])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4fca:b0:84e:88dd:5942
 with SMTP id d2e1a72fcca58-84ebc3b8e18mr139942b3a.41.1785364029245; Wed, 29
 Jul 2026 15:27:09 -0700 (PDT)
Date: Wed, 29 Jul 2026 22:26:59 +0000
In-Reply-To: <20260729-igb_v3_b4-v8-0-3ed236272b4e@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260729-igb_v3_b4-v8-0-3ed236272b4e@google.com>
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785364025; l=4049;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=BkK3gSify0AS5os7OLWEXHnTn8ob/INwrMqvv/F9yzY=; b=yevyfa6RY6TaePfBNr6cYPcvjnvvR1Dp5QbSa2AhEL+G+WGH55gWi9Y9TpoLwhkQRk2cRbusM
 BM0MDOKhh14C00b2a7jBOd6xF7wyQYF8ESZhrDAZiMfahLqqPkA5ETv
X-Mailer: b4 0.14.3
Message-ID: <20260729-igb_v3_b4-v8-4-3ed236272b4e@google.com>
Subject: [PATCH v8 4/6] vfio: selftests: igb: Factor hardware programming into igb_hw_init()
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
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 41 ++++++++++++++++------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index 1b30a188a864..12fce3d69025 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -224,7 +224,13 @@ static void igb_reset(struct igb *igb)
 	igb_write32(igb, E1000_IMC, 0xFFFFFFFF);
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
@@ -232,15 +238,10 @@ static void igb_init(struct vfio_pci_device *device)
 	u16 cmd_reg;
 	int retries;
 
-	VFIO_ASSERT_GE(device->driver.region.size, sizeof(struct igb));
-
-	/* Set up rings and calculate IOVAs */
-	igb->bar0 = device->bars[0].vaddr;
-
 	iova_tx = to_iova(device, igb->tx_ring);
 	iova_rx = to_iova(device, igb->rx_ring);
 
-	igb_reset(igb);
+
 
 	/* Signal that the driver is loaded */
 	ctrl = igb_read32(igb, E1000_CTRL_EXT);
@@ -334,9 +335,6 @@ static void igb_init(struct vfio_pci_device *device)
 	igb_write32(igb, E1000_RCTL, rctl);
 	igb_write32(igb, E1000_TCTL, E1000_TCTL_EN);
 
-	/* Enable MSI-X with 1 vector for the test */
-	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
-
 	/*
 	 * Program MSI-X interrupt routing per 82576 datasheet:
 	 *
@@ -376,6 +374,29 @@ static void igb_init(struct vfio_pci_device *device)
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
+	igb_reset(igb);
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
2.55.0.508.g3f0d502094-goog

