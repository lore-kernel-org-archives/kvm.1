Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672C749551A
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042114; cv=none; b=VESSDioZenvND2dtnppLRuOZmnBbd6iKOlL+01V7UdRzPiP5Prdiy8ch5mooHD+NYG03em3J6pTN7uiBCMNalMTjeNInFjeNHd5RjCt0wiKJyNbZhYly50NWhlOCmE7dIycKUsKBgMVquTWRt5LDICs5DBrweKRGMesa8vKfep8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042114; c=relaxed/simple;
	bh=zNaX3o4Q+PMjJkfE7ZeWse4rtkQ12e9AdpLMHhDvtQA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tQt3sbOdV/npStxuchc17t0/AYUoAwZmUyOyd8v+5Azj7sjidfPk+B648ZndiwFqk3VIODjojd+p8jUzDqwd0WsG8oti6RszPSIntFXvqEC7+GL/on0QTx1reuiD5rEuFT5SryIvjfuGdXdFozXGtFdT8/Mc3hNvvTlLmgkk7VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RtvF1jnw; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RtvF1jnw"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ccb687f82eso68594025ad.3
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 08:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042111; x=1784646911; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OET28Pw7Tm9U8SptXyUJqzCGyMYvQ/PVMzqx3Tt4yN8=;
        b=RtvF1jnwUVPbVVyENKs2UnEkfbOjjQybzx1a17V0LwoMW+w9/3kNSPfNWYB9gUiliU
         5xAFqgv5VypxX8zoPIeCD641En74yU2bL1vII4AxP6A3friE1qQbono9GBHvKXsZSeig
         H3FmsBOjiNkzdyCruVpa8ycYSOOwwHWK85UhxVk0+WNElhZ7/W80m+4BvPwz1bEZ+Nk5
         Uq/TMm8gSxOwpuy2xZMNAMIuFw7PLfE/4GKjskKjxX62YRa9kKhMkMxd9QYk4YshIwFR
         zgkaddaBDpio0947CJBcBmWwxaItwD/9zuC30mqExlVY4U7DSqLsm2zC29Xr3guBX8nm
         lCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042111; x=1784646911;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OET28Pw7Tm9U8SptXyUJqzCGyMYvQ/PVMzqx3Tt4yN8=;
        b=dgrR7QTPf4TptbdPDJHCphQXUtLuxAGlK+awuMpR5BqjZf1c/I3P+3FHbLQTMe4+Z6
         cccK+cmh06NL17/HZLb2xDgTrNQTLpCXIPN8xp7im5xrtu/wKzwE+hvjAhAm8uUatbv8
         3D/hGJs5hNzGQm4tddVMlICFzTeLwKEqpTUBbMgtTPv6ijbzavQKTcIgHaoT7/YOiZfW
         vPiz45ZgiIB+rJTXDhQB9Trxv8lmpVLph6IynQYAVnBc3Xg4cMm+T1EnT5dLopKQHRXR
         siy+3eGC7ZG07xhUOehSeAudu10matzy97cDPSsx8IjlIsDzEroQPPS12M/KniJnNbud
         hShA==
X-Forwarded-Encrypted: i=1; AHgh+RrP/oejkCkuR2K4u/bqrP/9pSRVxrFxXBavgLYra5ue5iZggHM59ARVkLDUU+cwSNn2UQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdIfy2qjhtiSwStRQRGjV24tMfRHLoWHoyzOVuBXKZKBuqYNpj
	5oZWQJy+dnJy/2QlfPxO4ug7oQ+mhI0SKFYDVlC9y0q/cIiKaMiWffRQu0CZ9VwvLd9vL9ULiP+
	kwfUM3gDm3Q==
X-Received: from pldu11.prod.google.com ([2002:a17:903:108b:b0:2c7:e06e:86f6])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b85:b0:2c9:ae0b:61e3
 with SMTP id d9443c01a7336-2ce9e9a6ed8mr116458815ad.2.1784042110624; Tue, 14
 Jul 2026 08:15:10 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:46 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-2-vipinsh@google.com>
Subject: [PATCH v5 01/20] vfio/pci: Factor out the reset logic in VFIO PCI
 device close path
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com, 
	rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vipinsh@google.com, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

vfio_pci_core_disable() is a very long function doing multiple things
like exiting runtime power management, setting device to D0 power,
clearing bus master, clearing irqs, freeing eventfds, releasing device
regions, unmapping PCI bars, and performing device/bus resets.

The upcoming VFIO Liveupdate feature will also need to utilize same
reset logic.

Extract device reset code to a new helper function,
vfio_pci_core_try_reset(), and update vfio_pci_core_disable() to use
this new function.

No functional change intended.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 100 ++++++++++++++++---------------
 1 file changed, 53 insertions(+), 47 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index a28f1e99362c..3c8b990ee92f 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -623,9 +623,60 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_enable);
 
-void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
+static void vfio_pci_core_try_reset(struct vfio_pci_core_device *vdev)
 {
+	struct pci_dev *pdev = vdev->pdev;
 	struct pci_dev *bridge;
+
+	vdev->needs_reset = true;
+
+	/*
+	 * If we have saved state, restore it.  If we can reset the device,
+	 * even better.  Resetting with current state seems better than
+	 * nothing, but saving and restoring current state without reset
+	 * is just busy work.
+	 */
+	if (pci_load_and_free_saved_state(pdev, &vdev->pci_saved_state)) {
+		pci_info(pdev, "%s: Couldn't reload saved state\n", __func__);
+
+		if (!vdev->reset_works)
+			return;
+
+		pci_save_state(pdev);
+	}
+
+	/*
+	 * Disable INTx and MSI, presumably to avoid spurious interrupts
+	 * during reset.  Stolen from pci_reset_function()
+	 */
+	pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
+
+	/*
+	 * Try to get the locks ourselves to prevent a deadlock. The
+	 * success of this is dependent on being able to lock the device,
+	 * which is not always possible.
+	 * We can not use the "try" reset interface here, which will
+	 * overwrite the previously restored configuration information.
+	 */
+	if (vdev->reset_works) {
+		bridge = pci_upstream_bridge(pdev);
+		if (bridge && !pci_dev_trylock(bridge))
+			goto out_restore_state;
+		if (pci_dev_trylock(pdev)) {
+			if (!__pci_reset_function_locked(pdev))
+				vdev->needs_reset = false;
+			pci_dev_unlock(pdev);
+		}
+		if (bridge)
+			pci_dev_unlock(bridge);
+	}
+
+out_restore_state:
+	pci_restore_state(pdev);
+}
+
+void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
+{
 	struct pci_dev *pdev = vdev->pdev;
 	struct vfio_pci_dummy_resource *dummy_res, *tmp;
 	struct vfio_pci_ioeventfd *ioeventfd, *ioeventfd_tmp;
@@ -700,54 +751,9 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 		kfree(dummy_res);
 	}
 
-	vdev->needs_reset = true;
-
 	vfio_pci_zdev_close_device(vdev);
 
-	/*
-	 * If we have saved state, restore it.  If we can reset the device,
-	 * even better.  Resetting with current state seems better than
-	 * nothing, but saving and restoring current state without reset
-	 * is just busy work.
-	 */
-	if (pci_load_and_free_saved_state(pdev, &vdev->pci_saved_state)) {
-		pci_info(pdev, "%s: Couldn't reload saved state\n", __func__);
-
-		if (!vdev->reset_works)
-			goto out;
-
-		pci_save_state(pdev);
-	}
-
-	/*
-	 * Disable INTx and MSI, presumably to avoid spurious interrupts
-	 * during reset.  Stolen from pci_reset_function()
-	 */
-	pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
-
-	/*
-	 * Try to get the locks ourselves to prevent a deadlock. The
-	 * success of this is dependent on being able to lock the device,
-	 * which is not always possible.
-	 * We can not use the "try" reset interface here, which will
-	 * overwrite the previously restored configuration information.
-	 */
-	if (vdev->reset_works) {
-		bridge = pci_upstream_bridge(pdev);
-		if (bridge && !pci_dev_trylock(bridge))
-			goto out_restore_state;
-		if (pci_dev_trylock(pdev)) {
-			if (!__pci_reset_function_locked(pdev))
-				vdev->needs_reset = false;
-			pci_dev_unlock(pdev);
-		}
-		if (bridge)
-			pci_dev_unlock(bridge);
-	}
-
-out_restore_state:
-	pci_restore_state(pdev);
-out:
+	vfio_pci_core_try_reset(vdev);
 	pci_disable_device(pdev);
 
 	vfio_pci_dev_set_try_reset(vdev->vdev.dev_set);
-- 
2.55.0.795.g602f6c329a-goog

