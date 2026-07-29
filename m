Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5BB4432F6
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785364030; cv=none; b=OY9ajfqQSIMgrI9fY772ZyswLb5Mpf2fqWZ/52EZHb4nl3A76JeN/IpzGODmv4AxxpovKYzqdNPp5Joq93kNij8JxiJ9KlVFZgOGbjilmHdYq6Y6qGTwKaR/pBZcuu9iJQPf+awl8+dzybamKdMMWzOu3y687CvAqu7RT4kStMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785364030; c=relaxed/simple;
	bh=ublbwVHLjHuOf8bVYVmCdOrHqxq2uRZG3/nm81yew10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZHQHCyeRdyj2G7lWmWDDjq5oRM3cQgH6yBHA6ZVwNkndbGBhQ6MyE+SxcvK405Pzs40ST2Kg0s1+66oBK1H5wj/xbtKWJLSCcBN/d7KHbvKQ8rQQK4e56N1JH04na9gv2/BWANEBF8gMxGjiuwZRasDlx6aB/PRe6ZYBq05Y2v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CVqLRo4G; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CVqLRo4G"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb4cdf95b5aso2408786a12.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 15:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785364028; x=1785968828; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nlzv4T5EPdxCuqpzeUzIfaHaVhUbOQL/hylAagCwky0=;
        b=CVqLRo4GLRAPqwlM0iMzG+X2XF87j1Fk4A5GagzxbN7Oi80ncpeByHlaQ1VrpqtJeY
         nyLq7iRstApPbGR7lS2mGvbIbPkNaoAWfRIrfV33YF7i05xser5ZrnsaawP0AsZE+pSq
         iHcn7NNc1HADRBqlatOzvtL9+m4Hc8Q6EH0BI7ruWN6C+tH6f84w/ftT/KcmXSQ518C3
         AX0C6jacnRHl5TQQK+Ndgr9qTf2H7S1/DfR7thA48QEUb+5d1QPC4OYEoiEPpWxW+MsF
         wOxTGYFP1mc+lwSg/PIX8aH9TsSMDpil1h19QevQtq422TwLM1Bi6Js9EGBbhz8NIMV6
         h3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785364028; x=1785968828;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nlzv4T5EPdxCuqpzeUzIfaHaVhUbOQL/hylAagCwky0=;
        b=HJrnCxl8F11G+S7o3Vmj4AIWf18w4nki0WPqcqNn7fuEllbLBisMyfkSyN5N79UpT1
         TO/Xt5acsdYwW/7r9JZN62XB/qWyuBd9gOI11HtELCqgabF4vX/eBT2NyzzYDU1SNjPN
         nuitD54kjVhmknUYZUZPKzrGaTOX58iqzedv8n43j+H9khkzjwvsjqnIPocfyw+c7+Cb
         dMVItcqvFb9ffkImvX+y33Z3TM2lY42Yow/EidSY4tuY4OMCnPoMss0uE2afTbdiNdOw
         H2aChrgfzoUMUbIl3sl6Jiox3pwHlmwxaGJcajssHc7td05PWZedLqxz4pt384Bm5xDm
         g/Dw==
X-Forwarded-Encrypted: i=1; AHgh+Rrf/bt1DA3IT3t5fahsouzpYK5+m+iQxJnxeoGEwu4SzQSW1RYwoJFR6fUOKOHFe81Il40=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYWxz9HA5fE/He5DECHe5MXJFMPXrDIgGniAfe2w0jiDRXTY6L
	X9tGxnf1GuqwAgf62dtnaLI5stSvL2DyYLwXMJeitiVGNqy/MD9MWNeNjNJ8K1No2DEZpOUz8hZ
	bYWLtac/P
X-Received: from pfes15.prod.google.com ([2002:aa7:8d4f:0:b0:846:5d01:2319])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3491:b0:84e:5e4:b9a2
 with SMTP id d2e1a72fcca58-84ebc424a22mr152132b3a.36.1785364028454; Wed, 29
 Jul 2026 15:27:08 -0700 (PDT)
Date: Wed, 29 Jul 2026 22:26:58 +0000
In-Reply-To: <20260729-igb_v3_b4-v8-0-3ed236272b4e@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260729-igb_v3_b4-v8-0-3ed236272b4e@google.com>
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785364025; l=4427;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=B6453uAm0x21xn2hczpE7cBMG1HF/KExFh4AJ1PCGzA=; b=jLx0sNOYJzSxbt9SSqJVUMG8VZvlF+cSD27JDsjw2JFZeP/BuufOxxvul+vBueCE57jH8/w+P
 etAQGF5Q8hkABHtEdmJmzXg9QMLC5qTNsROW9pC5cVouYiYwqkm6ivW
X-Mailer: b4 0.14.3
Message-ID: <20260729-igb_v3_b4-v8-3-3ed236272b4e@google.com>
Subject: [PATCH v8 3/6] vfio: selftests: Add helpers to re-enable interrupts
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

