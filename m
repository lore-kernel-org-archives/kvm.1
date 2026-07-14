Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4EE495534
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042115; cv=none; b=cqhvdEpeoXizubHl67N0777aD0l3AVpx4VmItteYrLtIosYMneAaFzMBuLKy7RGZzjHqs2FgLPFiCRO8AD9CSeWtk/8qSQrYN2AbFDFCeLD6uGS3J3x+c+gF3hgmWYVk/XTYvDPgqhZJIE5w4/bBSh/fGqrDPsojs/dBxXKwn28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042115; c=relaxed/simple;
	bh=uKsEEI4F1niy9EceQWdXOHKPYFI0RfY+kBMdOL+Yuj0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JO36pZrIWu9pD2Ikh0HRe/F+QgZdUtl3+ZT+UmnmYi7DdwtfS1gBx8xTTm9yJGihISx1mTVdItXbITs5RKVLWdXr9sf4t7oIMICT5zjAlw88175XRt89SBfPTu1S1u+OgXYnlpu7700lOJcFWhZyw1UwvJ0T/p+6Wt9vT+YLW1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S/tgKfnt; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/tgKfnt"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8487eb67173so6998253b3a.2
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 08:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042112; x=1784646912; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S1UFdHONMaUW3i8xUAtShYLn0EA7imz4HjKdEgIKF0Q=;
        b=S/tgKfntKJGsHupLkgX4KDgVgp3BZnxow2AJi8vFPRSYHrx5HBe6WxVtthoTfFxsb4
         219tKk1LOdYrue0WgvcRqYEkzpCs5N7X9Df4ngRAz1XJ/tt6PfrhVNW7guLGCucDb3Kb
         C+5LeDKj+KvY6C3D1CZstCu1E1eUFYOMsU40IzRNSAqt7agXaSWDYrl1OmHlpdfe/rcu
         aQ2C1Ek5rKiqAHvniYo/aQCJ2npm+iA3yBEvzavtT39wUgNFLger/mqOBmXdscX72eyO
         LLC5D0QyTI1vv5aaQRSR3boV9VDbAkPqEpmNrBW7KmLAWdeHx9uwup/N+/jGeHcUQIp7
         rArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042112; x=1784646912;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S1UFdHONMaUW3i8xUAtShYLn0EA7imz4HjKdEgIKF0Q=;
        b=KMj5nv4P4A5FRL6jrL8l4bfm3vN6tkgKWrH9V8pyBmQ6duAJtPkAA/jLuOO0khwa58
         itgaILYWOJ2VPtvSzRHDjSbGl4jF3S8vlsNmg/83d94dTTUzVt+ku/MsESrmn3fdo5Tz
         PYYiz9PAeAOdTO5kXGlB8KzoTrD/EXBfpzBzaGEQpv705NXn8WWW7uOjXrTFU3ifiI85
         g/9gnvj0yaRhQXG8x1/bcxPHbSkoVtV/Zk3JUdV+pkzX7vZN2XUYAjJSodyvjXhPTIf8
         apLbdSm88CnQo/6I+yqqTyBK5Zp55kBLgjM3zGgGwng3nBRwUQTtIML++AaPl69uyKUy
         SeQg==
X-Forwarded-Encrypted: i=1; AHgh+RoyaxlnFhEa2fNleuDQIqbZGiPALEgbDg8LaIH3Pxo/g4o4eUpdzBdAHO7jhYqmqo9tPWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCKpGdDSeqUN2O6DSwAGeFXrcPZk/XdPW6NnPSJ+S2/FwMK+oX
	VxT46UJXWJZWOaSraApaLNDgZL8uOY3zAMs/hgADFa7T1Ml2AsoIurvqag8jG/NRyzKN0MUmajk
	tcNtKud120Q==
X-Received: from pfbdi5.prod.google.com ([2002:a05:6a00:4805:b0:848:4690:d658])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e93:b0:848:19f4:3b52
 with SMTP id d2e1a72fcca58-84a516062d4mr3676620b3a.38.1784042111640; Tue, 14
 Jul 2026 08:15:11 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:47 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-3-vipinsh@google.com>
Subject: [PATCH v5 02/20] vfio: Export various helpers from VFIO
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

The upcoming VFIO live update feature needs to access various helper
functions for its logic which are not exported by default.

Export these functions and variable for other modules to use them.
Remove static from their declaration and add them in
include/linux/vfio.h and drivers/vfio/pci/vfio_pci_priv.h header files.

No functional change intended.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/vfio_pci.c      | 2 +-
 drivers/vfio/pci/vfio_pci_core.c | 6 ++++--
 drivers/vfio/pci/vfio_pci_priv.h | 5 +++++
 drivers/vfio/vfio_main.c         | 3 ++-
 include/linux/vfio.h             | 1 +
 5 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 0c771064c0b8..1fb4b276afe7 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -125,7 +125,7 @@ static int vfio_pci_open_device(struct vfio_device *core_vdev)
 	return 0;
 }
 
-static const struct vfio_device_ops vfio_pci_ops = {
+const struct vfio_device_ops vfio_pci_ops = {
 	.name		= "vfio-pci",
 	.init		= vfio_pci_core_init_dev,
 	.release	= vfio_pci_core_release_dev,
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3c8b990ee92f..f31e59e5badb 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -623,7 +623,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_enable);
 
-static void vfio_pci_core_try_reset(struct vfio_pci_core_device *vdev)
+void vfio_pci_core_try_reset(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
 	struct pci_dev *bridge;
@@ -674,6 +674,7 @@ static void vfio_pci_core_try_reset(struct vfio_pci_core_device *vdev)
 out_restore_state:
 	pci_restore_state(pdev);
 }
+EXPORT_SYMBOL_GPL(vfio_pci_core_try_reset);
 
 void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 {
@@ -1657,7 +1658,7 @@ ssize_t vfio_pci_core_write(struct vfio_device *core_vdev, const char __user *bu
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_write);
 
-static void vfio_pci_zap_bars(struct vfio_pci_core_device *vdev)
+void vfio_pci_zap_bars(struct vfio_pci_core_device *vdev)
 {
 	struct vfio_device *core_vdev = &vdev->vdev;
 	loff_t start = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_BAR0_REGION_INDEX);
@@ -1666,6 +1667,7 @@ static void vfio_pci_zap_bars(struct vfio_pci_core_device *vdev)
 
 	unmap_mapping_range(core_vdev->inode->i_mapping, start, len, true);
 }
+EXPORT_SYMBOL_GPL(vfio_pci_zap_bars);
 
 void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev)
 {
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index fca9d0dfac90..85bc1666cb0e 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -11,6 +11,8 @@
 /* Cap maximum number of ioeventfds per device (arbitrary) */
 #define VFIO_PCI_IOEVENTFD_MAX		1000
 
+extern const struct vfio_device_ops vfio_pci_ops;
+
 struct vfio_pci_ioeventfd {
 	struct list_head	next;
 	struct vfio_pci_core_device	*vdev;
@@ -73,6 +75,9 @@ u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev);
 void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev,
 					u16 cmd);
 
+void vfio_pci_zap_bars(struct vfio_pci_core_device *vdev);
+void vfio_pci_core_try_reset(struct vfio_pci_core_device *vdev);
+
 #ifdef CONFIG_VFIO_PCI_IGD
 bool vfio_pci_is_intel_display(struct pci_dev *pdev);
 int vfio_pci_igd_init(struct vfio_pci_core_device *vdev);
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 5e0422014523..2437af031169 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1467,7 +1467,7 @@ const struct file_operations vfio_device_fops = {
 #endif
 };
 
-static struct vfio_device *vfio_device_from_file(struct file *file)
+struct vfio_device *vfio_device_from_file(struct file *file)
 {
 	struct vfio_device_file *df = file->private_data;
 
@@ -1475,6 +1475,7 @@ static struct vfio_device *vfio_device_from_file(struct file *file)
 		return NULL;
 	return df->device;
 }
+EXPORT_SYMBOL_GPL(vfio_device_from_file);
 
 /**
  * vfio_file_is_valid - True if the file is valid vfio file
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 31b826efba00..cf0d941d0410 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -378,6 +378,7 @@ static inline bool vfio_file_has_dev(struct file *file, struct vfio_device *devi
 bool vfio_file_is_valid(struct file *file);
 bool vfio_file_enforced_coherent(struct file *file);
 void vfio_file_set_kvm(struct file *file, struct kvm *kvm);
+struct vfio_device *vfio_device_from_file(struct file *file);
 
 #define VFIO_PIN_PAGES_MAX_ENTRIES	(PAGE_SIZE/sizeof(unsigned long))
 
-- 
2.55.0.795.g602f6c329a-goog

