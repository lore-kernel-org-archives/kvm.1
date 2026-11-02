Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633834;
	b=BJ8+eVUKs7B3qlmdVrai4Z42YLq/fAMW6/dQqXEARTuVYlLAcmQH2gASLOPfcI+qh97u
	 il8e0lpZ2sMP3w1Fdod9ENYOHRh3j8lXZvLeQNqetFCQyUg95ThAK5tyF7phM04ICbvox
	 oEilUeZPer4gza9rUm02c0DkBXgJ37TQixjo9BlHVO5bcavNGcIqhLrezmWfzaFIt6zDH
	 pRl7XxCEPpXxWv6C474cKhYyxKhfBM6CsLmkIiSXenhobVPZt7pRkGSYGKrhH5Mn7QauD
	 8lXpymgi3oXtLwlxUijGHddoNFNLqRcqBqxgoI7BqhmJ/7hs7kSUI5Oc08TzT+6hQag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Vbe7YkQSNXb/9uNAV7c/nc8RXxVT9Eq1KsmaqI9CwRI=;
	b=K3WoCD4iV4jcHeX2SqtREB+hirzprxBmlfyV1LNOux2Gk6lItyIi9xyXp5Ix62+CPVte
	 L0pzhhLdSiMmeWyPrOYYOpxltmoE2XbqjWaP6//3j6II5I+Y6kKOXxFoL/2nY+nnOT7X4
	 R5pQmy3o2OVmTRFDyjaAsUum+8QUWB9FEzxPMu860aHFNzPBNMBJCLf//e97AC+BRL2WG
	 jykeq9kyM3LbKrMZq8ZUvLKHGeYw9KtgkXPNkNiTqS1tWsLIZcrkO/BPGWr6k5oDatxpE
	 izYg/bpOxOlAI48KaaS1B6OcVTZ5k60Vfnepx5nC64rg85ZSc97xAH9G7FguuN2ohvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k0paF0+c;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E90760E6E75
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 15:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E90760E6E75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k0paF0+c
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eaae62796dso36849885ad.0
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 07:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633834; x=1794238634; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vbe7YkQSNXb/9uNAV7c/nc8RXxVT9Eq1KsmaqI9CwRI=;
        b=k0paF0+cl+3NAGxfv2D2u6PAY7A3D8a18oP0uo5sPXaPtHYej2ZlcbpfmYBoqpvQ6Z
         7vDCFiGZNWFtaup5nJyv+/piQjj5owz4xEnarcnvMVM0i85KYumxwHwEuJWIGDBHH2Q8
         2vAMoBAoZLhxeKU14m8aHP4yqxI5YOAhskt7j9AzhpOkK43GLGdn3gRfWu4L0VIVRZ5D
         XUaftghRLi2QstlCQULJKpMN0NU24MDNcRLB6MQZwPp8fNwrCpdjG1XoI/Bxv4hOxEkY
         K0fKAXgyI+L695ITCy26rLR8QewAykRHDpFJrzq7W+v29al1Xx8PGx7+1reSJg0un0si
         EoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633834; x=1794238634;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vbe7YkQSNXb/9uNAV7c/nc8RXxVT9Eq1KsmaqI9CwRI=;
        b=miiCEMb9HpbEXgJzRMyfML8H1J+AQ3wJiR11EN3b+0TlfNgLORithKSBlScdX2beHL
         awhEdyZ47BNjEdXeG5zT+0G4XRaxxNZqOvKD01M7/Z2Kg+n/prMPwoiOBGzh/B8RJ5cZ
         1i0wlCCwIYLKG1O0QLSq+B57macpCN2ZijTsKkIGfq0TGrgiynXuH0QhZgEKtbN5Z9Ji
         syi5nEQkG1n8CyabdCsOAnj80LhTF1GaswNuWdjvSBpg3J0NTHlg+sRMgF784lhg8pW3
         4PrJyqPAkIncsyC/wL9fRHEmctDhdAiZp7bX+MTedrrQSr2fahggmT7A245lTBz0NnOR
         Du/A==
X-Forwarded-Encrypted: i=1; AKwUvBz0sVoz6LjtzUnGFAFlM3ZSB8th4GwzgPq0XefNGjE0vzNEMWopTIiFquJPnm68q2gOC7s=@vger.kernel.org
X-Gm-Message-State: APuU4Z/v+rTk+XIdK3EJE4iDIs4lzFHrTwi8NLITdFWPkjVaFp3ZALBv
	J20IeB/QjRMZT2wYRknTu9F5aciXab8qamCdIYEpTfmi3k8Ve+4SppcwspCdt5mj8fbpN27l1wx
	0/urp8I0vQw==
X-Received: from plkg13.prod.google.com ([2002:a17:903:19cd:b0:2e8:1f84:7c18])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da8c:b0:2e9:4bf3:37a1
 with SMTP id d9443c01a7336-2eb36506822mr91361225ad.63.1793633833691; Mon, 02
 Nov 2026 07:37:13 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:42 -0800
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
Message-ID: <20261102153656.1431701-14-vipinsh@google.com>
Subject: [PATCH v6 13/27] vfio/pci: Protect incoming preserved devices until
 they finish Live Update
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

Protect incoming preserved devices that were kept running across kexec
from being disturbed before userspace either claims them or finishes the
Live Update session:

 * Runtime PM idle D3: In vfio_pci_init_dev(), when
   pci_liveupdate_is_incoming(pdev) is true, latch
   vdev->disable_idle_d3 = true and vdev->liveupdate_kept_running = true.
   Without this, vfio_pci_core_register_device() drops the runtime PM
   reference and allows the PCI runtime PM core to transition an idle
   incoming device into D3hot, stopping bus mastering and potentially
   triggering an internal reset on NoSoftRst- devices.

 * Non-noiommu boot fallback: In vfio_pci_core_register_device(), after
   vfio_register_group_dev() determines whether the device is in noiommu
   mode, if an incoming kept-running device is not in noiommu mode in
   this kernel, log a pci_warn(), clear PCI_COMMAND_MASTER immediately to
   stop untranslated DMA, and record liveupdate_stopped_early so
   finish() resets it without printing a duplicate warning.

 * Bus/slot reset guards: Refuse vfio_pci_dev_set_needs_reset() and
   vfio_pci_dev_set_hot_reset() (-EBUSY) while any device in the dev_set
   has liveupdate_kept_running set, preventing another device in the same
   dev_set from resetting an unclaimed kept-running device. When an
   unclaimed device finishes Live Update and no device in its dev_set is
   open, invoke vfio_pci_dev_set_try_reset() after clearing
   liveupdate_kept_running so devices without function-level reset still
   receive a bus/slot reset.

 * Unbind before finish: In vfio_pci_core_unregister_device(), if a
   still-unclaimed incoming device is unbound from vfio-pci before the
   session finishes (or if a concurrent finish() deferred its function
   reset via liveupdate_reset_pending), clear bus mastering, reset the
   function and restore config state via
   vfio_pci_core_liveupdate_reset_locked() under the device lock already
   held by remove(), and call pci_liveupdate_finish().

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/vfio_pci.c            |  1 +
 drivers/vfio/pci/vfio_pci_core.c       | 19 +++++++-
 drivers/vfio/pci/vfio_pci_liveupdate.c | 16 +++++--
 drivers/vfio/pci/vfio_pci_priv.h       | 62 ++++++++++++++++++++++++--
 include/linux/vfio_pci_core.h          |  3 +-
 5 files changed, 91 insertions(+), 10 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 9d48b250a5e8..d01b5cc9d4d2 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -139,6 +139,7 @@ static int vfio_pci_init_dev(struct vfio_device *core_vdev)
 	 */
 	vdev->nointxmask = nointxmask;
 	vdev->disable_idle_d3 = disable_idle_d3;
+	vfio_pci_liveupdate_init_dev(vdev);
 #ifdef CONFIG_VFIO_PCI_VGA
 	vdev->disable_vga = disable_vga;
 #endif
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 60ada3bbb6ff..828d620cf836 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -768,6 +768,15 @@ bool vfio_pci_core_liveupdate_reset(struct vfio_pci_core_device *vdev,
 	vdev->reset_works = reset_works;
 	vfio_pci_core_try_reset(vdev);
 
+	/*
+	 * Like vfio_pci_core_disable(), try a bus or slot reset for the devices
+	 * in the set that still need one, e.g. this device if it has no usable
+	 * function reset, or others whose reset was deferred while this device
+	 * was kept running. This device is not open, so none in the set may be.
+	 */
+	if (!vfio_device_set_open_count(vdev->vdev.dev_set))
+		vfio_pci_dev_set_try_reset(vdev->vdev.dev_set);
+
 	return !vdev->needs_reset;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_liveupdate_reset);
@@ -2399,6 +2408,8 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 	if (ret)
 		goto out_power;
 
+	vfio_pci_liveupdate_check_noiommu(vdev);
+
 	vfio_pci_core_debugfs_init(vdev);
 
 	return 0;
@@ -2642,7 +2653,8 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list) {
 		bool owned;
 
-		if (vfio_pci_dev_is_frozen(vdev)) {
+		if (vfio_pci_dev_is_frozen(vdev) ||
+		    vfio_pci_dev_is_kept_running(vdev)) {
 			ret = -EBUSY;
 			break;
 		}
@@ -2744,8 +2756,11 @@ static bool vfio_pci_dev_set_needs_reset(struct vfio_device_set *dev_set)
 	if (vfio_device_set_open_count(dev_set) > 1)
 		return false;
 
-	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list)
+	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list) {
+		if (vfio_pci_dev_is_kept_running(cur))
+			return false;
 		needs_reset |= cur->needs_reset;
+	}
 	return needs_reset;
 }
 
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 64810010f983..ad757acac400 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -457,7 +457,7 @@ vfio_pci_liveupdate_attach_incoming(struct vfio_pci_core_device *vdev,
 {
 	guard(mutex)(&vdev->vdev.dev_set->lock);
 
-	if (vdev->liveupdate_incoming || vdev->liveupdate_claimed ||
+	if (vdev->liveupdate_incoming || !vdev->liveupdate_kept_running ||
 	    !pci_liveupdate_is_incoming(vdev->pdev))
 		return -EBUSY;
 
@@ -558,8 +558,7 @@ static void vfio_pci_liveupdate_finish_vdev(struct vfio_pci_core_device *vdev,
 	bool was_reset;
 
 	scoped_guard(mutex, &vdev->vdev.dev_set->lock) {
-		if (!vdev->liveupdate_claimed &&
-		    pci_liveupdate_is_incoming(pdev)) {
+		if (vdev->liveupdate_kept_running) {
 			if (vdev->liveupdate_incoming) {
 				saved_state = vdev->liveupdate_incoming->saved_state;
 				vdev->liveupdate_incoming->saved_state = NULL;
@@ -572,6 +571,17 @@ static void vfio_pci_liveupdate_finish_vdev(struct vfio_pci_core_device *vdev,
 					saved_state = NULL;
 			}
 
+			/*
+			 * The device is stopped below, so stop shielding it from
+			 * the dev_set resets, including the fallback done by
+			 * vfio_pci_core_liveupdate_reset().
+			 */
+			vdev->liveupdate_kept_running = false;
+
+			/* A device stopped early was logged when it was stopped. */
+			if (vdev->liveupdate_stopped_early)
+				reason = NULL;
+
 			/*
 			 * An unbind of the device waits for the reference held
 			 * by finish() with the device lock held, so the reset
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index d8670dc51bb4..39ea26402312 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -169,6 +169,40 @@ static inline bool vfio_pci_dev_is_frozen(struct vfio_pci_core_device *vdev)
 	return smp_load_acquire(&vdev->liveupdate_frozen);
 }
 
+static inline bool vfio_pci_dev_is_kept_running(struct vfio_pci_core_device *vdev)
+{
+	return vdev->liveupdate_kept_running;
+}
+
+static inline void vfio_pci_liveupdate_init_dev(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = to_pci_dev(vdev->vdev.dev);
+
+	if (pci_liveupdate_is_incoming(pdev)) {
+		vdev->disable_idle_d3 = true;
+		vdev->liveupdate_kept_running = true;
+	}
+}
+
+/*
+ * Called by probe once the device is registered, with the device lock held.
+ * retrieve() and finish() look the device up with that lock held, see
+ * vfio_pci_liveupdate_find_probed(), so they see the result of this check.
+ */
+static inline void
+vfio_pci_liveupdate_check_noiommu(struct vfio_pci_core_device *vdev)
+{
+	guard(mutex)(&vdev->vdev.dev_set->lock);
+
+	if (vdev->liveupdate_kept_running &&
+	    !vfio_device_is_noiommu(&vdev->vdev)) {
+		pci_warn(vdev->pdev,
+			 "Stopping device kept running across Live Update: not in noiommu mode\n");
+		pci_clear_master(vdev->pdev);
+		vdev->liveupdate_stopped_early = true;
+	}
+}
+
 static inline void
 vfio_pci_liveupdate_free_incoming(struct vfio_pci_core_device *vdev)
 {
@@ -196,7 +230,7 @@ vfio_pci_liveupdate_claim_incoming(struct vfio_pci_core_device *vdev)
 		return;
 
 	vfio_pci_liveupdate_free_incoming(vdev);
-	vdev->liveupdate_claimed = true;
+	vdev->liveupdate_kept_running = false;
 }
 
 static inline void
@@ -206,11 +240,17 @@ vfio_pci_liveupdate_unregister_dev(struct vfio_pci_core_device *vdev)
 
 	scoped_guard(mutex, &vdev->vdev.dev_set->lock) {
 		/*
-		 * Complete a reset that finish() could not do, see
-		 * vfio_pci_liveupdate_finish_vdev().
+		 * Reset a device unbound before finish(), or whose reset
+		 * finish() could not do, see vfio_pci_liveupdate_finish_vdev().
 		 */
-		if (vdev->liveupdate_reset_pending) {
+		if (vdev->liveupdate_kept_running ||
+		    vdev->liveupdate_reset_pending) {
+			if (vdev->liveupdate_kept_running &&
+			    !vdev->liveupdate_stopped_early)
+				pci_warn(pdev,
+					 "Resetting device not taken over after Live Update (vfio-pci unbound)\n");
 			vfio_pci_core_liveupdate_reset_locked(vdev);
+			vdev->liveupdate_kept_running = false;
 			vdev->liveupdate_reset_pending = false;
 		}
 		vfio_pci_liveupdate_free_incoming(vdev);
@@ -234,6 +274,20 @@ static inline bool vfio_pci_dev_is_frozen(struct vfio_pci_core_device *vdev)
 	return false;
 }
 
+static inline bool vfio_pci_dev_is_kept_running(struct vfio_pci_core_device *vdev)
+{
+	return false;
+}
+
+static inline void vfio_pci_liveupdate_init_dev(struct vfio_pci_core_device *vdev)
+{
+}
+
+static inline void
+vfio_pci_liveupdate_check_noiommu(struct vfio_pci_core_device *vdev)
+{
+}
+
 static inline void
 vfio_pci_liveupdate_free_incoming(struct vfio_pci_core_device *vdev)
 {
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index f5c279d0df1e..9bdbc8099bda 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -152,7 +152,8 @@ struct vfio_pci_core_device {
 #ifdef CONFIG_VFIO_PCI_LIVEUPDATE
 	bool			liveupdate_frozen;
 	bool			liveupdate_intx_disabled;
-	bool			liveupdate_claimed;
+	bool			liveupdate_kept_running;
+	bool			liveupdate_stopped_early;
 	bool			liveupdate_reset_pending;
 	struct vfio_pci_liveupdate_incoming *liveupdate_incoming;
 #endif
-- 
2.56.0.317.g454f8302e1-goog

