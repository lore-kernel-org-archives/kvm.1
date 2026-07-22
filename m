Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C654B3126AD
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784679350; cv=none; b=vGi4M6rGGD4KuuUY+zygkLIaaL8+j/hmfZqJGNsbI3iXlsZTz6LsEkOCXTlzJIKn6XjPk8XArSb+jjA3uanRpMsJHNT/70vDloHtmdTF2s0BibdSaWODU04VolqwwTGVxJGltRUXQ9o1K2oCHQ4FJJz9jt1H0ijME50GRJrtGJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784679350; c=relaxed/simple;
	bh=9dzLlS9AuJaT6xRIQC67AQ/17hTq/GvFHM3M5jcaNRE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RKVERYIxtVyF0uA7mkULwjovU4S1SbSGzS5PsXkIpOumn/ydWXV2TMPYovTT+Pxgc85EuVmm6iSDII+oi/ZC+/0+Md5Wf6loKhV6GUKjuTai19FtsfmsYdx/moHc67huC+qhpVzszx4kSQAC2lJ2yc/qpUC70iiyat4v/SAJfLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ULT9WZCr; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ULT9WZCr"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8484f26852dso8242123b3a.1
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 17:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784679342; x=1785284142; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TNalfHPNu/4hggAaxfIKgXNij2eI570gq4T5V2Wg4yw=;
        b=ULT9WZCr9m4y9Pck0qrYCRMe+Yepy10J3GZo5mWmh97+EVHenX3afmc78bOtEHVzSY
         IucinAkdf3uoyYZhs9aJK9C85HN2NqBrCjxHQEBICDbJQa0VCCHNo/P00mVVRt1IwQwg
         C7UgpC+xrE2z5kjtIAMkt0bucMtAkGX4GRsEkE4ZNirlofXoWOLlTjGy1cEJQqx1sI0y
         2SbsLcuNqG9HU3JTzCXnvjuwUrRHFqU/yhYmY3x8p426DFkt+54K4PddScQvRMPZRZmy
         cEKyRYnqQT3uvxD8ROlaH6Jt6gOQnbBWyQ6jKtEp7//dAptGH9kOw8pW/NA/dlamK5Tv
         0T0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784679342; x=1785284142;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TNalfHPNu/4hggAaxfIKgXNij2eI570gq4T5V2Wg4yw=;
        b=H22DjKwo1V2oct3NZ5LVaFlZQcyuDqO3+o27YYX18oWDRgJOIsLi0MU6sJgB174wjl
         Bdla2MJpzke71g99+9MBNlEnPKnUJ8yALV2sTJEloLEtFWbitSlmE2ccE2PJQVBOuL1b
         S3oqtKPEN6faw5FoAMdYHAN6OqmqIkZ0gwv5bpiPRGqML2GJQ3pc2SppPfQxy/1PZ3MS
         YyiejbyRfvO2qCGysuv+Y18wQKmsrfG46Wb0NnRkteMfp6gxXDpYmgEq7k5EBFPtofxT
         k0EBprzQIY2iLjxYWVNl5UNUwXfMgtjt5Opw6Z5qdRUQ4IFr1h9ScknE+hUd8JbhFxuK
         V+CA==
X-Forwarded-Encrypted: i=1; AHgh+RpDI39ZYLVL5254nM4oGyHQtf6l4u883EF23mNP/ih5lAMvVeBQ6QMtTpcE+W4CMPpB9xM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN9012F0AHFYmDAs7UdpN8SXpVBBfCGiCB20Z8U4LS6NIxY6Jt
	ul2sr3eQYIGheofW2SOPgtV4y7eMEsQ4DhoeIWAWgq/fn1A5lPhxTD4W486LY/pjKMabwZjitzY
	cU6S3Cj4I
X-Received: from pfem16.prod.google.com ([2002:a05:6a00:c090:b0:847:99d5:ef10])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1943:b0:847:759e:f61c
 with SMTP id d2e1a72fcca58-84c295013fdmr21103131b3a.47.1784679341869; Tue, 21
 Jul 2026 17:15:41 -0700 (PDT)
Date: Wed, 22 Jul 2026 00:15:38 +0000
In-Reply-To: <20260722-igb_v3_b4-v6-0-0be1d29918d4@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-igb_v3_b4-v6-0-0be1d29918d4@google.com>
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784679337; l=4367;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=AJ0ZiImWQV3xIvutXWoT8SQkfP3+vR/ectign90lbW8=; b=Ma1Ca3e8tybbqM2WNpPBXIYN+xtY78hltH796r3rOkE+EJM5O2/kOmRwFvOL4KkAuhoTrcfJa
 Ztf4iGedGlcAKY2nsPUHfNqw8mgVpAVHckB8QkOpvh+LA990bo+Gur2
X-Mailer: b4 0.14.3
Message-ID: <20260722-igb_v3_b4-v6-3-0be1d29918d4@google.com>
Subject: [PATCH v6 3/6] vfio: selftests: Add helpers to re-enable interrupts
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
---
 .../vfio/lib/include/libvfio/vfio_pci_device.h     | 14 ++++++++++++++
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 22 ++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 2858885a89bb..2e67afc0d580 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -68,6 +68,8 @@ void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
 void vfio_pci_irq_enable(struct vfio_pci_device *device, u32 index,
 			 u32 vector, int count);
 void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index);
+void vfio_pci_irq_reenable(struct vfio_pci_device *device, u32 index,
+			   u32 vector, int count);
 void vfio_pci_irq_trigger(struct vfio_pci_device *device, u32 index, u32 vector);
 
 static inline void fcntl_set_nonblock(int fd)
@@ -92,6 +94,12 @@ static inline void vfio_pci_msi_disable(struct vfio_pci_device *device)
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
@@ -103,6 +111,12 @@ static inline void vfio_pci_msix_disable(struct vfio_pci_device *device)
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
index fc75e04ef010..7b8394d0ac50 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -106,6 +106,28 @@ void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index)
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
2.55.0.229.g6434b31f56-goog

