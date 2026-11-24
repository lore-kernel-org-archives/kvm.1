Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795555727;
	b=mAQzjbLn1B/ftwWIzJQ9CIqtrhsAVq9CPXn3xl6w7qaUfJClIcuCuA0xPvkkqFbdQmTv
	 F6CJdtZaLeT1XI/+kWRQBLbqBGg5iqsKEBHZSgugcKsNOQMmwsO1wFLTI/3ojwVgJJhr5
	 I6gDklvzo9Vc84elNnlLmHrz7t+00ufo1++hRy+R7U8njN00ldoPzmnFJ4ecU0yCLng/A
	 rm+zkAZkKEhUXXmExrvL9i79YpmdwHY0Y/V9XJU3G6cXnGli+rLs905hZEIxjkQVeBrPl
	 Ek1dx5G2MHCbs3tw3eVLutbbbxWsI6WfVvZgc0QTsI4lZ8FhxSO41yPRvHy7RCv96SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795555727;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=LH7xbAaioyaoYiHQ6xeOXhOEgpjuNa84XhYKEVkAJ48=;
	b=QndNAWhwRySbjTRjyieKjIkEfPVAUM934X1XPcN+0ikz7ZPCBuZHUz2iI2LawdPJrnpt
	 vQdPMeVoRu6LxrODNlWsgWeR2zbJKuaUkF/5UVOmxHgkOJ8BmPTU/XPbPem6O088w4YdL
	 jtq485GA/zZ75c7RQ8xYixAMiwthfSgGGkIauCIJoo5Vt6tB9zX70cNWsMT47mftHacOh
	 GGJ0jUYPRi/P1FzvcUPIMQo73dqaW7gS9STE2qYN2LcR0LcKeFVFbqGhDyPPMDN7u3VBG
	 vEHyOoLvpER9d4FPPOGSygzDyF+xurqKMNbfOIBD66HeL7xPZW0NVwxOxmPJHpBKtHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=f9ZC6EjX;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3D2606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 21:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA3D2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=f9ZC6EjX
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4cc89e86e9eso6041862b6e.3
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 13:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795555725; x=1796160525; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LH7xbAaioyaoYiHQ6xeOXhOEgpjuNa84XhYKEVkAJ48=;
        b=f9ZC6EjXRbzHoHel5Gs2YLlS6npZo8QaHMvOOt8bTGivYZ8bi2I2rSSM2c8r5x9ygO
         VnttM9J9WEcAz7kd6hJwBH7ETT8GytejJahVu9kAoyn1+YvIMs2zWH+6V66uW17Lk5Rz
         EU2yMoeL4YZKqWLWYpgCb++ctuau6x221iaLl1mOD2fjU75Gpppvm7TV9BfSXmthkuql
         slPDxe5OeX+VdQP/HaQKa94c0cpeFKZS379dqngMBYmak5yqAGPYUQCB2o7XXWZRfegS
         doeHNZTDflxJEdJySianvOtWPL4U3mnGT1mAJKPI08SKTL31tQIMjFhPclMEha0L1TQh
         zHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795555725; x=1796160525;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LH7xbAaioyaoYiHQ6xeOXhOEgpjuNa84XhYKEVkAJ48=;
        b=svzRgLROtdZA4T59K+coPcFM1XUBjkwL6ubfq6pY1nrsfi5zDYUWvJrGHSkvsAh2/+
         hKssKDMLNK+lLRYemxv8bZCHSWE6/mkNibodE8Wfo8JuqZnCoEWkubLG1J1Mfz5OxY0d
         tXqGuZ+kduOvh56ZDmOVx1hQe/NUt1ug36q4M4WA7mNc3mETTBgpxTHgYgmj0xpbkOdO
         hQ6wTwcSnsbJTYdIREI0X8lQChFx9Pd7ClxNYQ7kmodNISuAzVWoeURAcBPSXMTomxZE
         nw25BmrXYRX4SX4KzvkBf5dpwPsxbRVxtATn6TFrcWVhZCWab5kVGHlBMinCJ9Gt02QT
         AIRA==
X-Forwarded-Encrypted: i=1; AL+hErFFFEvCEni4ZctPwoWh4FeYXRFFCR9lnj8K3+CkDPQECHiBYrZZIJmzUnbwmwYcPsNb4+w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SKqiN3U2Tpjo5Wjw9zO2YX+ANY/8h0P+Lt+xKoXPR5NP6d6g3
	ANrMuInZqfOxXbQArUxXJ19tjs5+JOXYPOhHQC+R0T3Nevn9NI7w6W2VQYgYoGYnHdel891qyga
	APu4ob/6P7CIMmg==
X-Received: from iojj12.prod.google.com ([2002:a05:6602:820c:b0:9c7:7732:c3c1])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:151f:b0:4d5:295c:a82c with SMTP id 5614622812f47-57a0c9c65b1mr17326090b6e.57.1795555725290;
 Tue, 24 Nov 2026 13:28:45 -0800 (PST)
Date: Tue, 24 Nov 2026 21:28:42 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124212842.1934651-1-skhawaja@google.com>
Subject: [PATCH v2] vfio/pci: Only lock the upstream bridge if the reset may
 need it
From: Samiullah Khawaja <skhawaja@google.com>
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Anthony Pighin <anthony.pighin@nokia.com>, Dave Jiang <dave.jiang@intel.com>, 
	Dan Williams <djbw@kernel.org>, Ionut Nechita <ionut.nechita@windriver.com>, kvm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Samiullah Khawaja <skhawaja@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 962ae6892d8b ("vfio/pci: Lock upstream bridge for
vfio_pci_core_disable()") makes vfio_pci_core_disable() trylock the
upstream bridge before resetting the device, and skips the reset if the
trylock fails.

All VFs of a PF have the same upstream bridge. Take a device with two
VFs, both used by one process. When the process is killed, both VFs can
be released at the same time. The first one takes the bridge lock and
does its FLR, the second one fails the trylock and is never reset.

The bridge lock is only needed for a bus reset, which is done through
the bridge. Add pci_reset_function_needs_bridge_lock(), which returns
false if there is no upstream bridge, if bus resets are disabled for the
device, or if the device is a VF. Use it in vfio_pci_core_disable() and
pci_reset_function() to only lock the bridge when it is needed.

Fixes: 962ae6892d8b ("vfio/pci: Lock upstream bridge for vfio_pci_core_disable()")
Cc: stable@vger.kernel.org
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
v2:
- Replace pci_reset_needs_bridge_lock() with
  pci_reset_function_needs_bridge_lock() as suggested by Alex, and use it
  in pci_reset_function() too.
---
 drivers/pci/pci.c                | 25 ++++++++++++++++++++++---
 drivers/vfio/pci/vfio_pci_core.c |  3 ++-
 include/linux/pci.h              |  1 +
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba8144..cc6647d091f7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5256,6 +5256,24 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
 
+/**
+ * pci_reset_function_needs_bridge_lock - check whether a function reset of
+ * @dev may need the upstream bridge to be locked
+ * @dev: PCI device to check
+ *
+ * A bus reset of @dev is done through its upstream bridge, so the caller must
+ * hold the bridge lock. The bridge doesn't need to be locked if there is no
+ * upstream bridge, if bus resets are disabled for @dev, or if @dev is a VF.
+ *
+ * Return: true if a function reset of @dev may be a bus reset.
+ */
+bool pci_reset_function_needs_bridge_lock(struct pci_dev *dev)
+{
+	return pci_upstream_bridge(dev) &&
+	       !(dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET) && !dev->is_virtfn;
+}
+EXPORT_SYMBOL_GPL(pci_reset_function_needs_bridge_lock);
+
 /**
  * pci_init_reset_methods - check whether device can be safely reset
  * and store supported reset mechanisms.
@@ -5313,10 +5331,11 @@ int pci_reset_function(struct pci_dev *dev)
 		return -ENOTTY;
 
 	/*
-	 * If there's no upstream bridge, no locking is needed since there is
-	 * no upstream bridge configuration to hold consistent.
+	 * The upstream bridge only needs to be locked if the reset may be a
+	 * bus reset, which is done through the bridge.
 	 */
-	bridge = pci_upstream_bridge(dev);
+	bridge = pci_reset_function_needs_bridge_lock(dev) ?
+		 pci_upstream_bridge(dev) : NULL;
 	if (bridge)
 		pci_dev_lock(bridge);
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index fcbb2da860e2..5dcbefd2eba4 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -777,7 +777,8 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	 * overwrite the previously restored configuration information.
 	 */
 	if (vdev->reset_works) {
-		bridge = pci_upstream_bridge(pdev);
+		bridge = pci_reset_function_needs_bridge_lock(pdev) ?
+			 pci_upstream_bridge(pdev) : NULL;
 		if (bridge && !pci_dev_trylock(bridge))
 			goto out_restore_state;
 		if (pci_dev_trylock(pdev)) {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index aa3765a20a96..aee6a178a535 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1486,6 +1486,7 @@ void pcie_print_link_status(struct pci_dev *dev);
 int pcie_reset_flr(struct pci_dev *dev, bool probe);
 int pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
+bool pci_reset_function_needs_bridge_lock(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
 int pci_reset_function_locked(struct pci_dev *dev);
 int pci_try_reset_function(struct pci_dev *dev);

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.56.1.831.g720f3f5937-goog

