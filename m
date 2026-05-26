Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EEC3E5568
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 23:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779839709; cv=none; b=QOjvCTwkDhmTU4TeO5go01tVLddTFoaz2Apjnjqh34i8KM0ySsbuJI5s+Rrhz/e9A7mDHfVluNJh4J5kSdinZjy/bl0l+h8HxV3raQG4WwVhqFapCxLwbc39kmTvClUOwa9MENWsIE/B3yG2vgk6Iq6DEMxCVRJ/UXFukZ+A09U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779839709; c=relaxed/simple;
	bh=Wj9df1szS9/kT1rzr/EtPxra8c14r7DuBU6rpuFO448=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RqsPArUIMqhbTLjmgr9TQ2gmvtcPZmBmTk4mtp8CC+w7S2cRP2Q68mMBalZpBQjCEq3V+wbCFlONVivARpnjZ/u90BGznKgkwwWTpsSrnpwrVDlD5AidMnK03a/qRTFa4aDDUV0N0CTzdlcM+k9SDC7RLxtKr8Wp397H0cUqqXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d72+VKWo; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d72+VKWo"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2babbeff9e4so120893685ad.0
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 16:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779839693; x=1780444493; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1NrFBJ11gsgCePhIlkwlcLBiFQeOIBZUOncUF8BLrg=;
        b=d72+VKWoqqaTzjkFoeo5+yUz7k/YzQJp7M/WDRZf1IdrzWyaGXrBgRITY/oZ21/01L
         9RgmRTWNJKLyEP09TWz0xDYoUWvibqHOadyE2WsTwWxULa0kjpHWMIWHnp3h84+x3qd4
         9Ae+OMwBy9mmapo/odgbygdK8oc6Gb4C9QSP87bjpX5lxaiRVPs8FyQ7Rv1chnCYOW6o
         2NPDP7Y04FBLEhgLvH1aBCGvn1Hplf69bblFGvn/oPHhmjwyEbb5JaLpHziQxeteo/fw
         hQ6lUEHWWjqKW+mKyf4Ay8B4sv6KdXcULIf1hu1plLLFJPQL11mHxIWptpgltXoPJi+r
         Tqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779839693; x=1780444493;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1NrFBJ11gsgCePhIlkwlcLBiFQeOIBZUOncUF8BLrg=;
        b=WEQHoKfoeGtoCcnJ8w/m0SAm3VHKhNBdEJQiozYFcWy+DzdS12HqdISQ64EFjJbXaK
         YNcVotDXW74J/dP6u/IU4ZFcyyjPAM4M0Dr73MurfPg8bJomCsoAQ9WYgY484gCOHz3g
         APlt1EvgkaWpSwKBd7W+aiTfLIRZJ2on6/2wPRgEqevgizapfnoU0aN7KL4nhF8pHmhW
         pRDPCAprgfrKakZT3yUf26ZhMUConH3QMfu+o0tHNrQ8Df58411Wt9UoPPD+T6ltaRxE
         cyceghrjojrIpbMucBC2P/J8V4JOEiMoeA5oXBxuRfbF+uE2Tf3hymyWUSTGaWl3Ag1j
         vkaQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Un7SM+75ClpgNOCosoR9mNU3P8aw5X6oiFHTtwIzPPbupU/RajAyI44T0JRtdH62gTn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcvWQlarOYLVVoBBo0dLBt8jNHa3akRhQqbzgyJRsNAaVPrMfz
	oi4Tb2ynKxN23VLDWIzbmoQuwfk62i3qckTPiYMNjzLs4EczRc5PAHL2BDAEv8EgQ74BJbgymLo
	nyNiPWYQs
X-Received: from plpl14.prod.google.com ([2002:a17:903:3dce:b0:2bd:9574:2958])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:11c9:b0:2b0:506b:e6f8
 with SMTP id d9443c01a7336-2bea20a2d54mr221168225ad.5.1779839692555; Tue, 26
 May 2026 16:54:52 -0700 (PDT)
Date: Tue, 26 May 2026 23:54:15 +0000
In-Reply-To: <20260526235417.2058313-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526235417.2058313-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526235417.2058313-9-jrhilke@google.com>
Subject: [PATCH v2 08/10] selftests/vfio: igb: Factor hardware programming
 into igb_hw_init()
From: Josh Hilke <jrhilke@google.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

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
---
 .../selftests/vfio/lib/drivers/igb/igb.c      | 44 +++++++++++++------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index 89537f8345d1..1ac0a32523ea 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -175,7 +175,13 @@ static int igb_probe(struct vfio_pci_device *device)
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
@@ -183,19 +189,10 @@ static void igb_init(struct vfio_pci_device *device)
 	u16 cmd_reg;
 	int retries;
 
-	VFIO_ASSERT_GE(device->driver.region.size, sizeof(struct igb));
 
-	/* Set up rings and calculate IOVAs */
-	igb->bar0 = device->bars[0].vaddr;
 
 	iova_tx = to_iova(device, igb->tx_ring);
 	iova_rx = to_iova(device, igb->rx_ring);
-
-	/* Reset device and disable all interrupts */
-	igb_write32(igb, IGB_CTRL, igb_read32(igb, IGB_CTRL) | IGB_CTRL_RST);
-	usleep(20000);
-	igb_write32(igb, IGB_IMC, 0xFFFFFFFF);
-
 	/* Signal that the driver is loaded */
 	ctrl = igb_read32(igb, IGB_CTRL_EXT);
 	ctrl |= IGB_CTRL_EXT_DRV_LOAD;
@@ -280,9 +277,6 @@ static void igb_init(struct vfio_pci_device *device)
 	igb_write32(igb, IGB_RCTL, rctl);
 	igb_write32(igb, IGB_TCTL, IGB_TCTL_EN);
 
-	/* Enable MSI-X with 1 vector for the test */
-	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
-
 	/*
 	 * Program MSI-X interrupt routing per 82576 datasheet:
 	 *
@@ -322,7 +316,31 @@ static void igb_init(struct vfio_pci_device *device)
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
+	igb_write32(igb, IGB_CTRL, igb_read32(igb, IGB_CTRL) | IGB_CTRL_RST);
+	usleep(20000);
+	igb_write32(igb, IGB_IMC, 0xFFFFFFFF);
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
 
+	igb_hw_init(device);
+}
 static void igb_remove(struct vfio_pci_device *device)
 {
 	struct igb *igb = to_igb_state(device);
-- 
2.54.0.794.g4f17f83d09-goog

