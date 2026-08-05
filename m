Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9BA361947
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 00:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785889265; cv=none; b=ush5Q4s1bkf9l7qQn3jyEle/1YG483j435bsVmFsMBp2DVI+Y2XWRAA8t1AsCyGNp+8507D0jq37f3aayBAKV5WmVZGaLx7ui8ikSXADsaTNltdDGGKZmt1bGaLDpKis7TiNaX99VKtZoiWkXcppc3xt8TB8VpL7JmhqHlA+4oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785889265; c=relaxed/simple;
	bh=/s/WutWgBkDkoqWk1gtwHnk/Af6S+Dr8yUYiF5uC5uE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tY58baIrKdrYXP3YOYUXIhAJebYYP1UPMNx9Sk+ctQ1fP13EZeJB2oTebfl1CatZsF5Pr3WNbWPFKPKYnK1ymbgDhCyyhYL2O8CyVS1k7n0XyDgtI4TIg52k3HRgTbndfPQ/bUYWR/SHlzarhMDF0A1dIc4m4aR0bHDTJA2l/sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jm8j/9CR; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jm8j/9CR"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e22137fb3so515862a91.0
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 17:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785889263; x=1786494063; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=siogvW8DGq9Kjt0WBylwgP+rzy7WuNyV/ARa/oJc9U4=;
        b=Jm8j/9CRg7TQ5nmacWlytTIjQ9N4ScPxlmdobKjSweEJXKiiYRWn86yhfN3tYp91Wj
         WhmffRz5zY9IQW8hjC5hAhyk9r6hPAa4YQkD1PYIKPJfCoYfNpkYulsh4ucwnc3K0LnR
         ZHwutDRP22R8QYCipmvOYMlgbuVMDj9qiEooXmTlipTTuKeiid9wV1HE4ExWrCpmycgH
         t173JdS+s4Ix4qVu4ca88c2DfY4MfN3e9yrMX3W1WG50jLx6vyRmUASnauVh5STsuHST
         7CW0MZIOzv/GdGIkoMhDF+QQxbuVi1gYsPNNdSAFRaKJJbfxP25y96/1MQ0TruOEZXuV
         SJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785889263; x=1786494063;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=siogvW8DGq9Kjt0WBylwgP+rzy7WuNyV/ARa/oJc9U4=;
        b=OLL5jB5xr2yGcFJL3274XBV0XTSCu+70Z8raFh/8etFh6gP6l+anmAQ0LrxzSbGr+6
         hMTDNYGicLER0z1B0JXekeKXsic9wlBBfc0veIMNtzwwJrJw2i7PaOMZPOyOaqTfb+lQ
         a+JSW275C1vRj9bn3XFhtMW8Cv5T2DSd0GHamGzmq6z0KrTF+K7kzQzEf4WwPB5NSkbj
         gOW3eAjhJAr9ZakLvzQ5WhQ5q32HUOm63Yn1U/tpOwHFGFCs4BazBXR6aTGu2hrg3ITK
         /5fRDXpGPPluGhGsXtSFHNGhjbgxtb4y90yu3rjUd+iIRtmaf8Yi68nwW1yZiCDENmOU
         Q/jQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp6xU2cCWFyCw2ST1Nr73CY1D728E6MsG4rl43vLNkWe6LhoLsq4H8HhjDZo+8NrPsLyJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqB1UPhIx7vzIfcpnfZ7lOEuFjzvqkaN4OVZ5QDTT05Zne3FRE
	T+pso8wvZuo6mXXXCWAf+QuOW95eE4ItI6LAOff2jm0HK6r3Jz2PCB5imKXA96+AzdtjzHowfP8
	SbIREYRM2
X-Received: from pjcc15.prod.google.com ([2002:a17:90b:574f:b0:384:f6e1:ff87])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a8d:b0:38e:57a3:f218
 with SMTP id 98e67ed59e1d1-3903c5b9f70mr2337359a91.13.1785889263273; Tue, 04
 Aug 2026 17:21:03 -0700 (PDT)
Date: Wed, 05 Aug 2026 00:20:58 +0000
In-Reply-To: <20260805-igb_v3_b4-v10-0-9c86dc849c0d@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260805-igb_v3_b4-v10-0-9c86dc849c0d@google.com>
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785889261; l=4427;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=MlKUyD/iWnX4HMtGpIO1fGxO+tR5jQHpAHxHPe4ktOs=; b=YP1lLaWRuUfua8sT8yiH96WEn4Jt3QeI9RmH5Gtd6f+QJuJXSb04Hgv7aeu24lvoH9nFaKwvz
 pdEMFnQdUSLAAHO3op5B83LCSfitMvmUc/32CQVhI+y89c08qVwQhh6
X-Mailer: b4 0.14.3
Message-ID: <20260805-igb_v3_b4-v10-1-9c86dc849c0d@google.com>
Subject: [PATCH v10 1/3] vfio: selftests: Add helpers to re-enable interrupts
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
2.55.0.571.g244d577d93-goog

