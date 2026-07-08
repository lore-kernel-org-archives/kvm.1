Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EB03B4EBD
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 23:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783552749; cv=none; b=fWrzHOy/OGoW1ed2zHWhJpe83wM+1tELkM95ktcyk6YkgVh7ZoZhVfZXaU7zA1eoHuB9t9MVrQZGmjMcIcnXnAlSVUJd/ZwI1Pj/YpyAf0WNJSjMZjWjxMdsrNutdLqXRmhCbF6CcbOdx3Yq289tPqMWc65zUW5WUWs/NsnyiMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783552749; c=relaxed/simple;
	bh=YW5RyQU5o9OBhh9jhOLqy2BLQ4mW4jnepu221Af6evA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WA814Krcve4jNT9EP9BuNmu23F+sgRyCr4rajQwBiHjeI24aN3NdZjQGlZmkoXIEsXg9j0+CeasBry/b1cVQz1fc+Q84+i+d94Ybf7FTFjJXTejddybBK5m+hzL9W8wfgiAYEC3Zlc5exXM4Ih1K4+Gf6/+WJiYEjPaoTCFKK6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qkOfEd0B; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qkOfEd0B"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423f544944so1174272b3a.3
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 16:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783552747; x=1784157547; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cm9aCzqOXkPalEf3rO5p1tnL2oSXVIGbLiKDcdTayQI=;
        b=qkOfEd0BndOZpouu6j3h6fki4vdq31Ndfv4BvEyW3nU9+/eUaoFbN3Qeo1Jl1s9MCA
         IoPykWwpLm+0qdt337pXr9SpISKh7/r5u3/kyB+P+PXKr2Ke36tMyI2rFdWLgsWaA+tX
         uAYjOQx1e9hUUG+GH2G9p1fKgxCsjpK9KX8qccBb1qNOcAxG5EoV4EmkD9enBI3wCWxL
         xWWGjKgxGZ3H1i+9ozCKU3Wlo8wxCX5HSZYiRgBiMATaSw1vFPpyRIXNszaJbQsrcf7C
         qoopWVZCKmAzxUG672qHtu19FpTWTD8FGR/XeAT+BNOInsEN1pMt0q/G9LrUzX9rorAZ
         8I1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783552747; x=1784157547;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cm9aCzqOXkPalEf3rO5p1tnL2oSXVIGbLiKDcdTayQI=;
        b=WoRlk4aanTcV30MMOQkgziri6H9DEzKZJEy+pWEX/+p5k/w/vFk1BoYFgrqXFDyYgh
         FNkcGJUk0eOSH+3CemRATrqrNlFnQrmD2y9KeIWxk5f59zKkyx9tFjBrDwpd5wK649NE
         7ISaXnb22CfDXXLzbfjpkWalqLpEshEAriQ7itZiwx3lZ48hDok8Ls9eMb8xFHjNC/F2
         E+cWtSzypgochSTCiGf5BUqANJqHafaDDSlGiOfThbJ8ZF6Na3/HrKUGY4KhXP1i8Nrh
         POx5LX5iD9Ajc+okBzqtNbxvHLmECPEm712Kf0Ne+7iXnv2mJNs7iX95l29ztaMSn3CA
         xrhg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/U2S8HBoku//hrM9pnK1jqAyLG3cNU9Qy4CVaXK5xA6q0q0ZnXmu+2ien3gP+uqMU20M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd8y7MKf+YS3tED1Ocvkl8BR4Bsk4htrft9peVD/9idFTIJR2Q
	QVW6E6oylnWeqYZ8XrXh/d4194x+a2QmwMK9B6QDCSCaqJ2LIcWZJnZS+T+z1yXGqmGQ7wfXcCD
	y6vuWHHsw
X-Received: from pfll17.prod.google.com ([2002:a05:6a00:1591:b0:847:7d90:188e])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4508:b0:848:2f74:d8d8
 with SMTP id d2e1a72fcca58-84843003f77mr4143084b3a.73.1783552746805; Wed, 08
 Jul 2026 16:19:06 -0700 (PDT)
Date: Wed, 08 Jul 2026 23:18:54 +0000
In-Reply-To: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260708-igb_v3_b4-v3-7-1272650ca614@google.com>
Subject: [PATCH v3 7/9] vfio: selftests: Add helpers to re-enable interrupts
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
2.55.0.795.g602f6c329a-goog

