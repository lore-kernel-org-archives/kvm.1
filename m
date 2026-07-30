Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AD3477E55
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 23:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454302; cv=none; b=T3drqAKwuZKaWnHlLNmoWOi8jV0gtCCISsBBDRaDTjNKPFcfNeHdkDYPO06EQX5EVTYh/cR0WO9LipOS+p0Ri4z/1MveD6UJo1mCFOoZS+ZSiHxpQ+t4LnOtQn6YvL1fk6Hbbo0qgMYX93orQ2w7sctqaGDV/pDtQHEkwmjLobA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454302; c=relaxed/simple;
	bh=ublbwVHLjHuOf8bVYVmCdOrHqxq2uRZG3/nm81yew10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qHf4bJ7yk3No/PjAj6NBpqeZIXqn1fo8bx1DkIxyFdYfBhM8kBw3BXzo+IMo4PTEBJrqlQigozFy+RjYUN7vXqj2YTxop4C97d/j9TLHTx3kp8wp2cdDSmunDqg6aCWRxQNjWOCVXzrGQdRiEoOImDpgI7EzC6ERcdo1D8ztaBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K3VKG6pZ; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K3VKG6pZ"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc6dd43737so6596475ad.2
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 16:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785454298; x=1786059098; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nlzv4T5EPdxCuqpzeUzIfaHaVhUbOQL/hylAagCwky0=;
        b=K3VKG6pZV1EAd4Chd/QKNtTZKzTaD73bC0wi9sEMfQi/cTZukQNrpx7e3Z09fqFPf2
         bimpSstkWsENCQQMFj3SKfEZTpZk9Z2nG3FjzawNKU1FZX4Fzt36+soohHeqJAKR/vLi
         iNdk4j6okZt9YOZSyIGpvYZT1tKZskWYs9npwXGqPdzv7yyF3xWex2X/WgYD4H5cLZoz
         lcbXSHPkAwzK1aw1gqf+buszwmnLh/eK0tpPnTVtyhH3z6PoW2Xgd/kwqiag/Zat9BoF
         Go0C8CvfFMP1L6uAAskEAgLUH9qc2j+JlNS7Sjq41j2KGtrinzfO2cn7bu/vPF947BRq
         R92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785454298; x=1786059098;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nlzv4T5EPdxCuqpzeUzIfaHaVhUbOQL/hylAagCwky0=;
        b=QY9XYmWUPwt7wSRWgt6skH9u7Qe+zxuszV30iq8unY2rj15zTk1lkorrkP6F7D7Db7
         1tsdOQOK6OxxA7VmBpenzKBc3kdDS1qJW0G/Nq2v6qYSUYmU2DOJeC0EPi/iNGVvk8Gk
         nEg/rGifj8WjOL1I5kk6+stVkxOstyNLy7D8yjQv3eIKIMPcqRXhr4mdpZjTFMWMos1+
         LijmsCihJRDzSfKslOlQtgOsGeG9gyeGyG1cQksK+oF0UhvtiwSFSuArtR2QZp0wpIAM
         2jUe7eeugFR9+N2mGNJDZZq/EcxOLYAeYbC5MGdXoXzDeft+eelWo7rzdZ5jGWOCihag
         w6Hw==
X-Forwarded-Encrypted: i=1; AHgh+RoTxsE221VS1OtL8bmT5bdA5tKMGDLJsw+7rv8ky0PdIfsCNAGqIS58LkdtZm66taKZB7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YztrcM4rwXmXtWdVL6cojqtXb9FOYdrQji7b+TyB4pEvznCd2uw
	OspyHcr7Mo66YXoFoQfVrn1v472wSZiwxji+8k/XJPmTgVwKrKOxNGeMtQ/4JxE7h9E+1NMnkq0
	qc7A5ZRf1
X-Received: from plgc17.prod.google.com ([2002:a17:902:d491:b0:2ca:ddb3:59fc])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c402:b0:2ca:2753:f3cc
 with SMTP id d9443c01a7336-2d03ddf14c1mr20409835ad.33.1785454297712; Thu, 30
 Jul 2026 16:31:37 -0700 (PDT)
Date: Thu, 30 Jul 2026 23:31:30 +0000
In-Reply-To: <20260730-igb_v3_b4-v9-0-9e4d8682437e@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260730-igb_v3_b4-v9-0-9e4d8682437e@google.com>
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785454295; l=4427;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=B6453uAm0x21xn2hczpE7cBMG1HF/KExFh4AJ1PCGzA=; b=g2PCw6WmbxMryikacBQlab1AmSdHT/hW/HSti6ogqKBKNLMffZ5gSma59UqlI+4Ee0g57YoIH
 /RET25wKMHSC989nxPSrHlnzrVaLBjb9e2r7ZCfDz4Y3jgoHIw3WQTy
X-Mailer: b4 0.14.3
Message-ID: <20260730-igb_v3_b4-v9-2-9e4d8682437e@google.com>
Subject: [PATCH v9 2/5] vfio: selftests: Add helpers to re-enable interrupts
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"

From: Alex Williamson <alex.williamson@nvidia.com>

Selftest drivers that recover from a fault by issuing VFIO_DEVICE_RESET
need to re-arm device interrupts afterwards.  VFIO_DEVICE_RESET tears
down the kernel-side IRQ trigger so a subsequent VFIO_DEVICE_SET_IRQS
is required, but the user-side eventfds (and any fd cached in a test
fixture) are still valid and must be preserved.

vfio_pci_irq_enable() refuses to be called for vectors that already
have an eventfd (VFIO_ASSERT_LT), and vfio_pci_irq_disable() closes
all eventfds before resetting the trigger, so neither is suitable.

Add vfio_pci_irq_reenable(device, index, vector, count) which asserts
that the requested range has existing eventfds and re-issues
VFIO_DEVICE_SET_IRQS using them.  Signature mirrors vfio_pci_irq_enable().

Add vfio_pci_msi{,x}_reenable() wrappers around vfio_pci_irq_reenable()
for additional ease of use and readability.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
Reviewed-by: David Matlack <dmatlack@google.com>
---
 .../vfio/lib/include/libvfio/vfio_pci_device.h     | 14 ++++++++++++++
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 22 ++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 59acef381d05..89a039ab3075 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -84,6 +84,8 @@ static inline void vfio_pci_cmd_clear(struct vfio_pci_device *device, u16 bits)
 void vfio_pci_irq_enable(struct vfio_pci_device *device, u32 index,
 			 u32 vector, int count);
 void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index);
+void vfio_pci_irq_reenable(struct vfio_pci_device *device, u32 index,
+			   u32 vector, int count);
 void vfio_pci_irq_trigger(struct vfio_pci_device *device, u32 index, u32 vector);
 
 static inline void fcntl_set_nonblock(int fd)
@@ -108,6 +110,12 @@ static inline void vfio_pci_msi_disable(struct vfio_pci_device *device)
 	vfio_pci_irq_disable(device, VFIO_PCI_MSI_IRQ_INDEX);
 }
 
+static inline void vfio_pci_msi_reenable(struct vfio_pci_device *device,
+					 u32 vector, int count)
+{
+	vfio_pci_irq_reenable(device, VFIO_PCI_MSI_IRQ_INDEX, vector, count);
+}
+
 static inline void vfio_pci_msix_enable(struct vfio_pci_device *device,
 					u32 vector, int count)
 {
@@ -119,6 +127,12 @@ static inline void vfio_pci_msix_disable(struct vfio_pci_device *device)
 	vfio_pci_irq_disable(device, VFIO_PCI_MSIX_IRQ_INDEX);
 }
 
+static inline void vfio_pci_msix_reenable(struct vfio_pci_device *device,
+					  u32 vector, int count)
+{
+	vfio_pci_irq_reenable(device, VFIO_PCI_MSIX_IRQ_INDEX, vector, count);
+}
+
 static inline int __to_iova(struct vfio_pci_device *device, void *vaddr, iova_t *iova)
 {
 	return __iommu_hva2iova(device->iommu, vaddr, iova);
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 28868343f2ab..65a4fffb480c 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -105,6 +105,28 @@ void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index)
 	vfio_pci_irq_set(device, index, 0, 0, NULL);
 }
 
+/*
+ * Re-issue VFIO_DEVICE_SET_IRQS for an already-enabled vector range using
+ * the existing eventfds.  Intended for drivers that need to re-arm device
+ * interrupts after a VFIO_DEVICE_RESET, which tears down the kernel-side
+ * IRQ trigger but leaves user-side eventfds intact.  Recreating the
+ * eventfds would invalidate any test-fixture cache of the fd, so this
+ * helper deliberately preserves them.
+ */
+void vfio_pci_irq_reenable(struct vfio_pci_device *device, u32 index,
+			   u32 vector, int count)
+{
+	int i;
+
+	check_supported_irq_index(index);
+
+	for (i = vector; i < vector + count; i++)
+		VFIO_ASSERT_GE(device->msi_eventfds[i], 0,
+			       "vector %d eventfd not allocated\n", i);
+
+	vfio_pci_irq_set(device, index, vector, count, device->msi_eventfds + vector);
+}
+
 static void vfio_pci_irq_get(struct vfio_pci_device *device, u32 index,
 			     struct vfio_irq_info *irq_info)
 {

-- 
2.55.0.508.g3f0d502094-goog

