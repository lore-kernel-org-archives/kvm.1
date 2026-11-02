Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633836;
	b=fXYA9XdDo26hd/f2lWJY+Kb4/gLvu7nrcBzWJCxHNQ+A0tRUiwdbfjiH/oXF9iKgfK3E
	 b1n9vQb9fOZM1tMNsQJGZo04T6ZTvQ/dgvTV7pV6oTNNrkXdg/n4nrInoL9gKdrp25Xdu
	 Hqa2EKyYJOgKL9P/D0eq+oXb0J1+9JbVP6OakVwGFkZPUXE5lMk1PA0ThWqVUOu4DBKdp
	 AZo/91gnjl4c8PfYvIUGowh/IAFZByZtFb917PE2jy6I39goN5dSq3nQ4sUuajRYX6qb0
	 4UaxnnMh3lQaNCZ07JWMmEYSJughO5PCWud+FjVQo2AdFlI69OviX3uBEC6sX+HDRJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633836;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=7oNMxFcokvWOq1vpjD6EaSwY983MmsMnjeXj/vNf0HQ=;
	b=l+IwGE84DVUAGdFuHnFIrA9bzvQdWjVT4+okyAzxYMI0rgv+qq/HMILEMWyX/gXwrcVc
	 157TURSUpL0lb6I3mrnhTik+apEtdC1+YMYW0aei2DskcTPQKk3DI0ye+mWGH4Qm3acTX
	 zu0p07goGAN+yB5XOw0ZXoy9lhNweaf9JAeqlQR4Pq+cVLt3kL84acqCW+gcxFShx/7oN
	 gRJKGFixIudEEsCtzZszuwMGqThb6H24y1INqIzGpS8oeWoCFThy49JP1STS8hdfL5F0m
	 IuuVZUttGaZgAEWHi8lE3YPTk6mp42gJ2Shq9KXF8qnUA8h7dvoQfnomjogtIisNWvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ByU106m3;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC2960E6E51
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 15:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CC2960E6E51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ByU106m3
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e987ec84afso27013735ad.3
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 07:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633835; x=1794238635; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7oNMxFcokvWOq1vpjD6EaSwY983MmsMnjeXj/vNf0HQ=;
        b=ByU106m3EGLrZcaE1aVefm8Q4KaxNoV6SHq20WrhC+8XmDCEwVSCBSd6EDo5a+upZC
         wCtZqbsKa5enxoEsZ9fYfB1YZcwHUYyAeDWwmmmO9WsKjGdR7Gictl5C3cAnr8QI9AZ3
         2OYpfYnIryEz43W0oC0yAzmLQndbzCr5MNJRyCen2kWozbsX4Cyg5Ps4B12KlpofWJye
         L0bM04x+BV0Pmw9bxrQcnUmZ82BpkaRxORuLeH5YmFl+br5mTrlT5N80xtvids/tuRq0
         fBIwjTpHNku0OjpGkkhkRLe+qFBS+b9V4GjRE/smcuh/5AZRa5mwIlpW+Y020oFfDz9M
         fHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633835; x=1794238635;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7oNMxFcokvWOq1vpjD6EaSwY983MmsMnjeXj/vNf0HQ=;
        b=kOvChsUB8vvWypZ6nWSMLo+vhk9+b+PK416YMgQmMMG9uNSal3FGJl7+vUW9CzFCjW
         7M3tEHQOwBm+VCWGw6ZmXfkqQZcubd7MEeRb57ro1N/clP3VFUsgZZXiipGS2dEHNCsd
         Q21pXtdx8w/VyOK/74BG1mjcCRj26VLxEUarp8t9hcaCh7bEAonkvJgWD1A3DLoS7m4o
         uefOUMYi7QKaqxQIP92Z84FnMPhfXhzGTjKY9AC0cFnyBZx7V5wudzGdZIaueXcJQvw8
         Dqh9dsCHFJJ9lctH2Fotu2EsKQJ6fzdzT9rMi6PXhoXNMOnDNsOmVwmJ3gcHbKq52MXq
         t6FA==
X-Forwarded-Encrypted: i=1; AKwUvBz1ARHi6fPsqP97iMvzDuViaV9Uhj8uDbFSqam4pjWMNjRc4kEj0tZJm6416dKrCLgx3iQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jd5bFlbicu9cEVRC1ICt9NXFEFjW815KARYMmv+KtU8pQW9+u
	1Eqb1tXUcHlQlJ2W94F5+FBOD3i2GS8luxuqGhQTGObUVpBiliYX6wuAmaY/Tqx8QcAhzfiTGjf
	L0pcOETbzaQ==
X-Received: from plbkn5.prod.google.com ([2002:a17:903:785:b0:2e9:6e08:e249])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:390d:b0:2e2:dd98:59e8
 with SMTP id d9443c01a7336-2eb36395c06mr94444135ad.3.1793633834806; Mon, 02
 Nov 2026 07:37:14 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:43 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-15-vipinsh@google.com>
Subject: [PATCH v6 14/27] vfio/pci: Take over preserved devices without
 resetting them
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

When userspace binds a retrieved VFIO cdev file descriptor via
VFIO_DEVICE_BIND_IOMMUFD after kexec, take over the running device in
vfio_pci_core_enable() via vfio_pci_liveupdate_take_over() without
resetting it or clearing bus mastering:

- Skip pci_clear_master(), pci_try_reset_function(), and
  pci_save_state().
- Save PCI_COMMAND before pci_enable_device() and restore the memory and
  I/O decode bits afterwards so pci_enable_device() does not re-enable
  BAR decode (such as I/O port decode) that was disabled before kexec.
- Also restore PCI_COMMAND_INTX_DISABLE, which freeze() set before
  kexec, when vfio-pci uses PCI 2.3 INTx masking for the device
  (vdev->pci_2_3) or masks its broken INTx (vdev->nointx), so INTx stays
  masked until userspace configures interrupts. Otherwise vfio-pci masks
  INTx at the interrupt controller (e.g. with vfio_pci.nointxmask=1), so
  leave DisINTx cleared by pci_enable_device() as a normal open does.
- Build pci_config_map via vfio_config_init(), verify that it matches
  the preserved config map snapshot, and overlay the preserved vconfig
  snapshot onto vdev->vconfig.
- Perform all fallible take-over setup before adopting the preserved
  state. If take-over fails before the device is claimed, leave the
  running device untouched (keeping bus mastering, decode bits, and
  liveupdate_incoming intact) so userspace can retry binding the
  retrieved FD or let the session finish/close reset the unclaimed
  device.
- Once vfio_pci_liveupdate_take_over() succeeds, adopt the preserved
  pci_saved_state and reset_works flag, clear liveupdate_kept_running,
  and free the temporary incoming state; any subsequent error or final
  device close follows the normal vfio_pci_core_disable() path and
  resets the device.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c       | 117 +++++++++++++++++++++----
 drivers/vfio/pci/vfio_pci_liveupdate.c |  23 ++++-
 drivers/vfio/pci/vfio_pci_priv.h       |  23 ++++-
 3 files changed, 141 insertions(+), 22 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 828d620cf836..63f484c0654c 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -595,8 +595,68 @@ static const struct dev_pm_ops vfio_pci_core_pm_ops = {
 			   NULL)
 };
 
+/*
+ * Take over a device that was kept running across a Live Update. The device
+ * is enabled only after every step that can fail, because unwinding with
+ * pci_disable_device() would clear bus mastering on the running device. A
+ * failed take-over thus leaves the device untouched and can be retried.
+ */
+static int vfio_pci_liveupdate_take_over(struct vfio_pci_core_device *vdev,
+					 struct vfio_pci_liveupdate_incoming *in)
+{
+	const u8 *vconfig = in->data;
+	const u8 *config_map = in->data + in->cfg_size;
+	struct pci_dev *pdev = vdev->pdev;
+	u16 orig, cmd, keep;
+	int ret;
+
+	if (in->cfg_size != pdev->cfg_size ||
+	    memcmp(config_map, vdev->pci_config_map, in->cfg_size)) {
+		pci_warn(pdev,
+			 "Config map mismatch during Live Update take-over\n");
+		return -EINVAL;
+	}
+
+	pci_read_config_word(pdev, PCI_COMMAND, &orig);
+	ret = pci_enable_device(pdev);
+
+	/*
+	 * pci_enable_device() enables memory and I/O decode for all assigned
+	 * BARs and clears PCI_COMMAND_INTX_DISABLE. Restore the decode settings
+	 * the device was running with and keep INTx masked, as freeze() left
+	 * it, until userspace configures interrupts. If vfio-pci does not use
+	 * PCI 2.3 INTx masking for the device, it masks INTx at the interrupt
+	 * controller instead, so leave PCI_COMMAND_INTX_DISABLE as a normal
+	 * open does. If enabling failed, restore everything.
+	 */
+	keep = PCI_COMMAND_IO | PCI_COMMAND_MEMORY;
+	if (ret || vdev->pci_2_3 || vdev->nointx)
+		keep |= PCI_COMMAND_INTX_DISABLE;
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	if ((cmd ^ orig) & keep)
+		pci_write_config_word(pdev, PCI_COMMAND,
+				      (cmd & ~keep) | (orig & keep));
+	if (ret)
+		return ret;
+
+	memcpy(vdev->vconfig, vconfig, in->cfg_size);
+	/*
+	 * Redo the virtual BAR fixup: the snapshot may hold a BAR sizing write
+	 * not fixed up yet, or a fixup half done by a config read racing with
+	 * freeze(), as config reads do not take vdev->igate.
+	 */
+	vdev->bardirty = true;
+	cmd = le16_to_cpu(*(__le16 *)&vdev->vconfig[PCI_COMMAND]);
+	vdev->virq_disabled = !!(cmd & PCI_COMMAND_INTX_DISABLE);
+	vdev->reset_works = in->reset_works;
+
+	return 0;
+}
+
 int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 {
+	struct vfio_pci_liveupdate_incoming *in =
+		vfio_pci_liveupdate_incoming(vdev);
 	struct pci_dev *pdev = vdev->pdev;
 	int ret;
 	u16 cmd;
@@ -608,23 +668,30 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 			return ret;
 	}
 
-	/* Don't allow our initial saved state to include busmaster */
-	pci_clear_master(pdev);
+	/*
+	 * A device kept running across a Live Update is enabled later, without
+	 * a reset, by vfio_pci_liveupdate_take_over().
+	 */
+	if (!in) {
+		/* Don't allow our initial saved state to include busmaster */
+		pci_clear_master(pdev);
 
-	ret = pci_enable_device(pdev);
-	if (ret)
-		goto out_power;
+		ret = pci_enable_device(pdev);
+		if (ret)
+			goto out_power;
 
-	/* If reset fails because of the device lock, fail this path entirely */
-	ret = pci_try_reset_function(pdev);
-	if (ret == -EAGAIN)
-		goto out_disable_device;
+		/* If reset fails because of the device lock, fail this path entirely */
+		ret = pci_try_reset_function(pdev);
+		if (ret == -EAGAIN)
+			goto out_disable_device;
 
-	vdev->reset_works = !ret;
-	pci_save_state(pdev);
-	vdev->pci_saved_state = pci_store_saved_state(pdev);
-	if (!vdev->pci_saved_state)
-		pci_dbg(pdev, "%s: Couldn't store saved state\n", __func__);
+		vdev->reset_works = !ret;
+		pci_save_state(pdev);
+		vdev->pci_saved_state = pci_store_saved_state(pdev);
+		if (!vdev->pci_saved_state)
+			pci_dbg(pdev, "%s: Couldn't store saved state\n",
+				__func__);
+	}
 
 	if (likely(!vdev->nointxmask)) {
 		if (vfio_pci_nointx(pdev)) {
@@ -635,10 +702,12 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 			vdev->pci_2_3 = pci_intx_mask_supported(pdev);
 	}
 
-	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
-	if (vdev->pci_2_3 && (cmd & PCI_COMMAND_INTX_DISABLE)) {
-		cmd &= ~PCI_COMMAND_INTX_DISABLE;
-		pci_write_config_word(pdev, PCI_COMMAND, cmd);
+	if (!in) {
+		pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+		if (vdev->pci_2_3 && (cmd & PCI_COMMAND_INTX_DISABLE)) {
+			cmd &= ~PCI_COMMAND_INTX_DISABLE;
+			pci_write_config_word(pdev, PCI_COMMAND, cmd);
+		}
 	}
 
 	ret = vfio_pci_zdev_open_device(vdev);
@@ -649,6 +718,12 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (ret)
 		goto out_free_zdev;
 
+	if (in) {
+		ret = vfio_pci_liveupdate_take_over(vdev, in);
+		if (ret)
+			goto out_free_config;
+	}
+
 	msix_pos = pdev->msix_cap;
 	if (msix_pos) {
 		u16 flags;
@@ -675,13 +750,17 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 
 	return 0;
 
+out_free_config:
+	vfio_config_free(vdev);
 out_free_zdev:
 	vfio_pci_zdev_close_device(vdev);
 out_free_state:
 	kfree(vdev->pci_saved_state);
 	vdev->pci_saved_state = NULL;
 out_disable_device:
-	pci_disable_device(pdev);
+	/* A take-over enables the device only once nothing can fail. */
+	if (!in)
+		pci_disable_device(pdev);
 out_power:
 	if (!vdev->disable_idle_d3)
 		pm_runtime_put(&pdev->dev);
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index ad757acac400..00c008117259 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -120,7 +120,28 @@
  *
  * ``LIVEUPDATE_SESSION_RETRIEVE_FD`` validates the handed-over serialized state
  * and returns a new unbound VFIO cdev file descriptor. The device is claimed on
- * the first ``VFIO_DEVICE_BIND_IOMMUFD`` on that file descriptor.
+ * the first ``VFIO_DEVICE_BIND_IOMMUFD`` on that file descriptor without
+ * resetting it or clearing ``PCI_COMMAND_MASTER``:
+ *
+ *  * ``vfio_pci_core_enable()`` skips ``pci_clear_master()``,
+ *    ``pci_try_reset_function()``, and ``pci_save_state()``. It builds
+ *    ``pci_config_map`` normally via ``vfio_config_init()`` and verifies that
+ *    it matches the preserved snapshot before it enables the device. It keeps
+ *    the memory and I/O decode settings and ``PCI_COMMAND_MASTER`` the device
+ *    was running with, and keeps physical INTx masked until userspace
+ *    configures interrupts. On devices for which vfio-pci does not use PCI
+ *    2.3 INTx masking (e.g. with ``vfio_pci.nointxmask=1``), vfio-pci masks
+ *    INTx at the interrupt controller, so ``PCI_COMMAND_INTX_DISABLE`` is left
+ *    as on a normal open. It then overlays the preserved ``vconfig`` snapshot
+ *    and adopts the preserved ``pci_saved_state`` and ``reset_works`` flag for
+ *    subsequent resets or device close.
+ *
+ *  * If the take-over in ``vfio_pci_core_enable()`` fails,
+ *    ``VFIO_DEVICE_BIND_IOMMUFD`` fails and leaves the device running
+ *    untouched, and userspace can retry the bind. If the ioctl fails after
+ *    the device was claimed, it closes the device, which resets it like any
+ *    other close. A device that is never claimed is reset when the session
+ *    is finished or closed, as described below.
  *
  * ``LIVEUPDATE_SESSION_FINISH`` (or closing a retrieved session file
  * descriptor) always completes:
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 39ea26402312..2549a5321fce 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -203,6 +203,12 @@ vfio_pci_liveupdate_check_noiommu(struct vfio_pci_core_device *vdev)
 	}
 }
 
+static inline struct vfio_pci_liveupdate_incoming *
+vfio_pci_liveupdate_incoming(struct vfio_pci_core_device *vdev)
+{
+	return vdev->liveupdate_incoming;
+}
+
 static inline void
 vfio_pci_liveupdate_free_incoming(struct vfio_pci_core_device *vdev)
 {
@@ -219,6 +225,8 @@ vfio_pci_liveupdate_free_incoming(struct vfio_pci_core_device *vdev)
 static inline void
 vfio_pci_liveupdate_claim_incoming(struct vfio_pci_core_device *vdev)
 {
+	struct vfio_pci_liveupdate_incoming *in = vdev->liveupdate_incoming;
+
 	/*
 	 * A reset that finish() left for unbind is not needed once the device
 	 * is opened after finish(): the open resets the device if it can, and
@@ -226,10 +234,15 @@ vfio_pci_liveupdate_claim_incoming(struct vfio_pci_core_device *vdev)
 	 */
 	vdev->liveupdate_reset_pending = false;
 
-	if (!vdev->liveupdate_incoming)
+	if (!in)
 		return;
 
-	vfio_pci_liveupdate_free_incoming(vdev);
+	vdev->pci_saved_state = in->saved_state;
+	if (!vdev->pci_saved_state)
+		pci_dbg(vdev->pdev, "%s: Couldn't store saved state\n",
+			__func__);
+	kfree(in);
+	vdev->liveupdate_incoming = NULL;
 	vdev->liveupdate_kept_running = false;
 }
 
@@ -288,6 +301,12 @@ vfio_pci_liveupdate_check_noiommu(struct vfio_pci_core_device *vdev)
 {
 }
 
+static inline struct vfio_pci_liveupdate_incoming *
+vfio_pci_liveupdate_incoming(struct vfio_pci_core_device *vdev)
+{
+	return NULL;
+}
+
 static inline void
 vfio_pci_liveupdate_free_incoming(struct vfio_pci_core_device *vdev)
 {
-- 
2.56.0.317.g454f8302e1-goog

