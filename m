Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FD3314A98
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 00:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784679352; cv=none; b=SL9QNEGF2MbQKKghkv6LXhJiG0KcFFjtS2JkeBEuayiQ0dR7EK2Yz4eU44eyGDqObAHPLLNsWbPigTAglesqpOUBcuE7pPHkx3rNaJAZh3MdGWbI2tBfCSvR6gfNTfNlNwmyIRw9IbBrtC+V70O6pZ/dF7aoUaoSO+MRy4kUe6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784679352; c=relaxed/simple;
	bh=+u92+edGzJUogIivEKHvjJM5J721kuk7QGsl9GsyiVA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YN5wevAKruMTuEsmLrbUbclKdytFEWWAd3t0JDjlEzNrueTNHLjO6pLkQyPdNp2NhdmE1Yjy+niM67NWBFmqNZanUZM3MjI3Fh3oF+D81WTijG8ntAEjSpGRW784FP1aH3sbxSgN0Kilpe1maWs2n+vXDIwkVwfbAGdN2AR/Ih8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hb+af4dw; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hb+af4dw"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso147340195ad.0
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 17:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784679346; x=1785284146; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RPmtr/TNEphr6iJROeMyjAAqcZVr5NPU0l3kEo6G8jw=;
        b=Hb+af4dwxJ2MONl287btlm2st8bDJahde+XGVcdNKEcPwq/Agm8Jw/B5huCKMO0E08
         ioCwwEnNjk4Fa0F70TiGHbuHKfpVV1nRrzWYU1uOW+sr4BgGxJQkZVuX65q6UwqqJ37t
         HVsMaQY4rWRzvDvRY2Sos+8fnFvYYSmsl6b1bb4cN0H389Tisw4WUrw9WeGruNCM2/xM
         Sm+kMyDTLZ/+fe+0jwsQiH6/xBpjUrRC/DdPbcHCOrBOe9BA8/VbritSkM+lAotwMT/G
         Fuc84+97ZiNmA7boq0XalNv/WeJpiVYZWDqWZTwMDmZW71r3JzA4OJtksEcdOgXL935V
         zJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784679346; x=1785284146;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RPmtr/TNEphr6iJROeMyjAAqcZVr5NPU0l3kEo6G8jw=;
        b=ph1vSNdChGV/tCmkFoYRme8+MUAljLukBjhAtSimxhYzxe5YELwutvDNPaNO2UQQ6Z
         Xr8qEQ7anvYCVvHGzO+ROyV57D5JKcx41o8/VJbd+BD/jW/Q9IYsA01q8JuPDO7LKcHv
         uFpXChPJdjVpOi1b2nA4x3kGN+FTKHbp+HfyG3JIpRrwD1lMc10zQjehvoNmx/tWhL3D
         ZMI/IFH2yyEWejmBSXSgH8d2nB8g1VTW33gJbJUdW2QnfcWtH7d8PmNaCwZBrM6pkKsk
         f5hGhdiTQjyNR5SdXoc4gsYn2Fyfo8ciaUUtkwvrZx0mKTWR0IFXSmuWin+p2UGs0iR1
         b9BQ==
X-Forwarded-Encrypted: i=1; AHgh+RowiYHD+LrHm3KrUd2fspNucLeYfyjHfOQsS1165FPQt0Ix0U+ZBfS7CjOTqdkDfQJVB2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS02asK5jR2BEA8CXsQTmuOgQ1nnZ3d0wJYIbSPCpDcwbWmXzo
	sB7teqVfbNMsdIGbRoCK4yvhuUVFA5VvgEBX6avQOHvGDdKTp52+wGwQIoAcZv/Jm9VR3JLLlOG
	x11LTsBq6
X-Received: from pgcp18.prod.google.com ([2002:a63:7412:0:b0:c9a:4ffc:3456])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a103:b0:3c0:9c1a:8941
 with SMTP id adf61e73a8af0-3c3ada59cd5mr21741694637.73.1784679345554; Tue, 21
 Jul 2026 17:15:45 -0700 (PDT)
Date: Wed, 22 Jul 2026 00:15:39 +0000
In-Reply-To: <20260722-igb_v3_b4-v6-0-0be1d29918d4@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-igb_v3_b4-v6-0-0be1d29918d4@google.com>
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784679337; l=4049;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=3HaO+LlIH5EQwYBLepHXt1276V0e3otp2TZx5sNJQxA=; b=4EgBrBNIcrg+NHGZ5nkD3MnsDofc8PMsdapr/842JIP2bDaGYrH15xDznsSmgyiLoO8X7z9El
 aD1bo0i0JvQDXiyvjPK8mzZfohuPAiyLS8MVb3xgODFbOwmrpYZPAP1
X-Mailer: b4 0.14.3
Message-ID: <20260722-igb_v3_b4-v6-4-0be1d29918d4@google.com>
Subject: [PATCH v6 4/6] vfio: selftests: igb: Factor hardware programming into igb_hw_init()
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
index 2b444be4bdfe..8eaf120330dc 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -202,7 +202,13 @@ static void igb_reset(struct igb *igb)
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
@@ -210,15 +216,10 @@ static void igb_init(struct vfio_pci_device *device)
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
@@ -312,9 +313,6 @@ static void igb_init(struct vfio_pci_device *device)
 	igb_write32(igb, E1000_RCTL, rctl);
 	igb_write32(igb, E1000_TCTL, E1000_TCTL_EN);
 
-	/* Enable MSI-X with 1 vector for the test */
-	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
-
 	/*
 	 * Program MSI-X interrupt routing per 82576 datasheet:
 	 *
@@ -354,6 +352,29 @@ static void igb_init(struct vfio_pci_device *device)
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
2.55.0.229.g6434b31f56-goog

