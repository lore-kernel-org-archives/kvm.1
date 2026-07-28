Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCDE47ACCF
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 23:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785281093; cv=none; b=XGgI4EZjPSlX591VjcB2lUQyUdPMWjomQClnALwKEuQq6Z+l8/3Yty83/9tXUTXmb1gXvyBzg3i4hZ5Q/OuBGiFWXyTeQ1juFXDbIgsu2emjfgCsVkvj5inIvTFEd1I285PlwV9q0JNL3wlCJRM/RmHpZaRQ/Jkwj/3u8DOuS80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785281093; c=relaxed/simple;
	bh=CNEjZGm6XOJKjg1XDa3JuFya9nU2rTolgcz77GUddG0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hEA7DGjfQOgZ/BdP6Xz+d7SSmt2L2mXLjLDKEumB0RmTkgb78W5lgpF7snm4P6eRybxQ9RMcztNvYRa8SGHqgXE4I6eAPY1A4SGEFv7vVLtKLYxGYIwMMDTBEYx9n9epOue6jBDuyRNHJzu4xQhiAlDJDxHhGcmjstZpXySnljA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZJRKF3XO; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZJRKF3XO"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-381250979d5so357633a91.0
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 16:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785281090; x=1785885890; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PL+yCbMYeb2vDt21oqq8Wk84XUCQR+QR8uSeLGmJoFQ=;
        b=ZJRKF3XOQgbqpVe2h8y49FuDeBCvbIlaOYaE6h0wLmqKQNqVkYHs3InWQUpHU+wmSs
         rg8uagkjyzAezeTuQxorJO4CkBqZtDGuxzu9lxO7IycdtfpOuVQx3wxDEfOe/HPNSWh5
         b+nRWeDaVjg6XmTSBgllxBpqeQpA9gKsnjXOi6STNJMYh/vP/jHosQeFR5+fOWeDJvaf
         7PVhHPAFSRLMPUuWqqtwscE1qzY0AmS0+1D5S51ucb7HZXpHQ/algMtBwXwR5CcQpEKK
         5Yjn0IrRYY8NEP72wMQX/aV7kFeq2IgWC3MowItsjU0bsdx+71efCMpDmD7MXe4vo2o/
         uK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785281090; x=1785885890;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PL+yCbMYeb2vDt21oqq8Wk84XUCQR+QR8uSeLGmJoFQ=;
        b=Rjdvc4VSeHSkUCl6RSIrLU4sGodB6Y9/t3efwj8wk9QjkRyriikWuxEzo70TfbrcGF
         OKy8UvSRt8yp41h5ElOVNM6jPWY750IkOCwl+UGtI1oqC8DKnZqwJ2s7rDIsQ+fHaIBi
         i9YsBu6z0gq2Coljv/C+CKwyXlsMrPWKcI8hKfiozwDvN1Eh4kjT3y2QaiihqBK0coym
         44ScR8aZWNUlee2SVkWUCOT5O+UFij5z66Rl//BKWoyvp1is77VOVYzZThwQwDfMHXX9
         4surLtcNvjq+Q1pIDeRK22x6osZNr0ZFUSq6VMeEJ09v0t/kIDzOgAYkn+81NIf5yssr
         F2AQ==
X-Forwarded-Encrypted: i=1; AHgh+RrRwJ+yQ1vIp97CQ2hvikfemwqSkUNrL+Vn2dLQomg302MIw2v+BNDbhSW2CiKpbS0YcB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfh6I/YFaOLYXRk7UlqFjlS8zb4rFUUElYNDlDuXjvtlcFTc6g
	/qIZbVJcPxaj7g4YdV20tfAJaypZUIbe/MfJ2n0icDeZOE3uaEM+mrXuACWaI5bazLrRDUCcwtu
	tgyYXAd2O
X-Received: from pjd13.prod.google.com ([2002:a17:90b:54cd:b0:380:f969:825e])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:47:b0:37f:9cdf:f03e
 with SMTP id 98e67ed59e1d1-38f6a427cc5mr4616277a91.33.1785281089613; Tue, 28
 Jul 2026 16:24:49 -0700 (PDT)
Date: Tue, 28 Jul 2026 23:24:29 +0000
In-Reply-To: <20260728-igb_v3_b4-v7-0-4616c3745796@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728-igb_v3_b4-v7-0-4616c3745796@google.com>
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785281084; l=4049;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=DDeLZleCjdmHXzE6kbgiq69I8h1p3F5RXXWU8wYy6YU=; b=84AW0Ywvpd/bE8OLbiFcZ37MVoDzjJ6yXIQJaP9QdS/kAg9SgDwH5rIGEV9lhMjxSz69cRNQX
 L7T4sWUbCaDDPIOt/mcMyi3ac4Urc1P4yqvOSD7G93YvYslF5WbylUm
X-Mailer: b4 0.14.3
Message-ID: <20260728-igb_v3_b4-v7-4-4616c3745796@google.com>
Subject: [PATCH v7 4/6] vfio: selftests: igb: Factor hardware programming into igb_hw_init()
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
2.55.0.487.gaf234c4eb3-goog

