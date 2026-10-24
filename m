Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792858828;
	b=NkfhzdTnyR7UVyt3wNn8k4cqzr/ar5KKeQK6Wx3s1RcZ9MSxHQonh8sQYTxZY8FKBQ5F
	 qsWgfRfwMz2gsxVjpHny23BfoBaU/w87NHazltGi7WNbZ/Br5UG4y6HZoMzv6em/MiEg/
	 /J6I2RJfv6tId9koenjufqZL30Ad4QTeuX3T+dGkA4i6gwuDwPruZrKxMXqclAHLpFpTM
	 VbbV/vVcSk5qIkHmUUFZnt72cWXHibk2rucabcaIpgZNuM/lz5X2Y60ccW3U1zS1h9Lob
	 EAIfQYgUADYfEt1wn0erZfjqBvJS9NryM3NZHQVaPjUlA3T52c2CXs5Wt7+pHnV8cjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792858828;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=5pj9fOOF/mi3F1Ls5HUgWx9NY7TSN/+QNNZHnWOqpiM=;
	b=aIpxiA/UnXuAX+y7bKZ5SplxixOpbxBPbIz/q3/qI0AZ/UjsGy8hqaeK9WcfaaVprqxh
	 k8jE4ouSJC+MKp+QOPs7sC1b2DWQIDd0Ca/C22uwvux5CUKC5KIFaSEzIz0WzaxG66QCZ
	 P5IxktGsuMeDVpb22Y7eyZntNNAC2vkjoPWj0DvM4nGKcvb3M3Tv7+sTOA9z3kYz2A5Tf
	 ytXCsLVMcvusQfg7mrPq8GjP7kWjrWbgrr8WGX64mlu3ppbERlBmeYVzjSqQwbpkCv488
	 tR8dJwNazlEKqHCM2yO4++r693WHx5C4ueDB952iuw7MvLSALPFETuEQuLsReRFnH/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b="vvn/yYdc";
	arc=none smtp.remote-ip=209.85.218.72
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3369606A337
	for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 16:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3369606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=vvn/yYdc
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c40aa03ded8so181075666b.2
        for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 09:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792858826; x=1793463626; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5pj9fOOF/mi3F1Ls5HUgWx9NY7TSN/+QNNZHnWOqpiM=;
        b=vvn/yYdcv4QvN4Mlr25pZ/VowA7q6MCaqf1UC1KWr2E7FQYE2Vd5xqEBxt3aKuCRDf
         GQBKPogRob1hnNJ68lmYiY2+l/s0iNl4J5jI+k3CJAk4KAuLkZRce7UpBGkmwevO4rk/
         zXs1DaXUgGBfSjz1aWcFAliVX7I+OtgH/2kxPtYpxJY13n6c9qx2stBQbztR5mYg4I9I
         iWIzFu3pzn4jEadaBUxIBnSqHEp7I2eoBXob3cv4ToA+dRRO7DLQj4Bq+CiWgnr0UMqo
         IZto8rmCPaMv8JGAc57tugH2zuBXCCqC4VkpldWLHWN1IUEcIRE5mvBg8hi7eIDTEil3
         lmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792858826; x=1793463626;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5pj9fOOF/mi3F1Ls5HUgWx9NY7TSN/+QNNZHnWOqpiM=;
        b=AAfcJfLos3V50HKZUvofphViSSHd/u1P733o0Lmosw+MxmezWu8+0MWEWOeDITtQfN
         D2beRU1rG2ELAtc+FzKnLaYxtmc5zanGLTqvIzA1GsJTaWggLWAcpeghKTILf9TvbeIT
         9lgjAePBxb3bA9nulhkeA9Ssq3V8WYvvWrWP+hkVwJHWWkiQI+vIYmiQYt5ZG2pcWY91
         //ZQ01G+y3EaPA9f5X/27OG5jKIxuImYfP2Lsh/jUHIYQYunAl5nzBSfltYDRHtysM7c
         NjDj82GBUuA0+Av8MB3CxYEjoq/Qtrh3aCy6AfyaPQojVCPShpRPAmi+4tzVljPg+FQW
         P2nA==
X-Gm-Message-State: AFq9FYKthYNVwRModfy4CKkL3X6W2I6bB+2KJnHm6xEMtav2Bb6BlYnP
	DEScMs2RXeuepM8NvdZi7r+W6z1rwsGvr9Km2QyHzIwsaOlA4WbRvorRef0bviZn/NBSfXnNXoq
	PZt2zNWoA2UCAIe44JyrPamaZFgmxTapwZxbXwPp1xlGfNRP0jkAXeniqRLzgiybPQLLWf57DeI
	E2P6f6ul4azAkta4Fz4/oBjVFwzx8uCvJ7qHIUzVv8wL0=
X-Received: from ejcv8.prod.google.com ([2002:a17:906:3808:b0:c3f:7ad9:156a])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7fa8:b0:c33:923b:ad51 with SMTP id a640c23a62f3a-c46bdfffda2mr269466066b.45.1792858825841;
 Sat, 24 Oct 2026 09:20:25 -0700 (PDT)
Date: Sat, 24 Oct 2026 16:19:01 +0000
In-Reply-To: <20261024161902.2093581-1-smostafa@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261024161902.2093581-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261024161902.2093581-9-smostafa@google.com>
Subject: [PATCH kvmtool 8/9] vfio: platform: Add interrupts support
From: Mostafa Saleh <smostafa@google.com>
To: kvm@vger.kernel.org
Cc: will@kernel.org, julien.thierry.kdev@gmail.com, praan@google.com, 
	eric.auger@redhat.com, alex@shazbot.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Configures interrupts of the device, relying on the new common
VFIO interrupt code.

And generated the dt node for interrupts.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 include/kvm/vfio.h |   9 +++-
 vfio/platform.c    | 113 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 119 insertions(+), 3 deletions(-)

diff --git a/include/kvm/vfio.h b/include/kvm/vfio.h
index f641292..b3034a0 100644
--- a/include/kvm/vfio.h
+++ b/include/kvm/vfio.h
@@ -89,6 +89,10 @@ struct vfio_pci_device {
 	struct vfio_pci_msix_pba	msix_pba;
 };
 
+struct vfio_platform_device {
+	struct vfio_irq			*irqs;
+};
+
 struct vfio_region {
 	struct vfio_region_info		info;
 	struct vfio_device		*vdev;
@@ -109,7 +113,10 @@ struct vfio_device {
 
 	char				*sysfs_path;
 
-	struct vfio_pci_device		pci;
+	union {
+		struct vfio_pci_device		pci;
+		struct vfio_platform_device	platform;
+	};
 };
 
 struct vfio_device_params {
diff --git a/vfio/platform.c b/vfio/platform.c
index c5b447f..22052a6 100644
--- a/vfio/platform.c
+++ b/vfio/platform.c
@@ -1,5 +1,6 @@
 #include "linux/sizes.h"
 
+#include "kvm/irq.h"
 #include "kvm/kvm.h"
 #include "kvm/vfio.h"
 
@@ -28,6 +29,36 @@ static int vfio_mmio_alloc_io_space(u64 size, u64 *addr)
 }
 
 #ifdef CONFIG_HAS_LIBFDT
+static void generate_interrupts_prop(void *fdt, struct vfio_device *vdev,
+				     fdt_irq_fn generate_irq_prop)
+{
+	struct vfio_platform_device *pdev = &vdev->platform;
+	unsigned int i, num_irqs = vdev->info.num_irqs;
+	enum irq_type *irq_types = NULL;
+	u8 *irqs = NULL;
+
+	if (num_irqs) {
+		irqs = calloc(num_irqs, sizeof(*irqs));
+		irq_types = calloc(num_irqs, sizeof(*irq_types));
+		if (!irqs || !irq_types)
+			die("Failed to allocate the interrupts property");
+
+		for (i = 0; i < num_irqs; i++) {
+			struct vfio_irq *irq = &pdev->irqs[i];
+
+			irqs[i] = irq->gsi + KVM_IRQ_OFFSET;
+			irq_types[i] = irq->unmask_fd >= 0 ?
+				       IRQ_TYPE_LEVEL_HIGH :
+				       IRQ_TYPE_EDGE_RISING;
+		}
+	}
+
+	generate_irq_prop(fdt, irqs, irq_types, num_irqs);
+
+	free(irqs);
+	free(irq_types);
+}
+
 static void generate_mmio_fdt_node(void *fdt,
 				   struct device_header *dev_hdr,
 				   fdt_irq_fn generate_irq_prop)
@@ -53,6 +84,7 @@ static void generate_mmio_fdt_node(void *fdt,
 	_FDT(fdt_begin_node(fdt, node_name));
 	_FDT(fdt_property(fdt, "reg", reg_prop,
 			  2 * sizeof(*reg_prop) * num_regions));
+	generate_interrupts_prop(fdt, vdev, generate_irq_prop);
 	_FDT(fdt_end_node(fdt));
 
 	free(reg_prop);
@@ -123,8 +155,65 @@ err_unmap:
 	return ret;
 }
 
+static int vfio_platform_setup_irq(struct kvm *kvm, struct vfio_device *vdev,
+				   unsigned int index)
+{
+	struct vfio_irq *irq = &vdev->platform.irqs[index];
+	struct vfio_irq_info irq_info = {
+		.argsz	= sizeof(irq_info),
+		.index	= index,
+	};
+	int ret;
+
+	if (ioctl(vdev->fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info)) {
+		ret = -errno;
+		vfio_dev_err(vdev, "failed to get irq[%u] info", index);
+		return ret;
+	}
+
+	if (!(irq_info.flags & VFIO_IRQ_INFO_EVENTFD)) {
+		vfio_dev_err(vdev, "irq[%u] is not eventfd capable", index);
+		return -EINVAL;
+	}
+
+	irq->gsi = irq__alloc_line() - KVM_IRQ_OFFSET;
+	irq->trigger_fd = -1;
+
+	return vfio_irq_enable(kvm, vdev, index,
+			       irq_info.flags & VFIO_IRQ_INFO_AUTOMASKED, irq);
+}
+
+static int vfio_platform_configure_dev_irqs(struct kvm *kvm, struct vfio_device *vdev)
+{
+	struct vfio_platform_device *pdev = &vdev->platform;
+	unsigned int i, num_irqs = vdev->info.num_irqs;
+	int ret;
+
+	if (!num_irqs)
+		return 0;
+
+	pdev->irqs = calloc(num_irqs, sizeof(*pdev->irqs));
+	if (!pdev->irqs)
+		return -ENOMEM;
+
+	for (i = 0; i < num_irqs; i++) {
+		ret = vfio_platform_setup_irq(kvm, vdev, i);
+		if (ret)
+			goto err_teardown;
+	}
+
+	return 0;
+
+err_teardown:
+	while (i--)
+		vfio_irq_disable(kvm, vdev, i, &pdev->irqs[i]);
+	free(pdev->irqs);
+	return ret;
+}
+
 int vfio_platform_setup_device(struct kvm *kvm, struct vfio_device *vdev)
 {
+	unsigned int i;
 	int ret;
 
 	ret = vfio_platform_configure_regs(kvm, vdev);
@@ -133,6 +222,12 @@ int vfio_platform_setup_device(struct kvm *kvm, struct vfio_device *vdev)
 		return ret;
 	}
 
+	ret = vfio_platform_configure_dev_irqs(kvm, vdev);
+	if (ret) {
+		vfio_dev_err(vdev, "failed to configure IRQs");
+		goto err_unmap;
+	}
+
 	vdev->dev_hdr = (struct device_header) {
 		.bus_type	= DEVICE_BUS_MMIO,
 #ifdef CONFIG_HAS_LIBFDT
@@ -143,16 +238,30 @@ int vfio_platform_setup_device(struct kvm *kvm, struct vfio_device *vdev)
 	ret = device__register(&vdev->dev_hdr);
 	if (ret) {
 		vfio_dev_err(vdev, "failed to register VFIO device");
-		vfio_platform_unmap_regions(kvm, vdev, vdev->info.num_regions);
-		return ret;
+		goto err_teardown_irqs;
 	}
 
 	return 0;
+
+err_teardown_irqs:
+	for (i = 0; i < vdev->info.num_irqs; i++)
+		vfio_irq_disable(kvm, vdev, i, &vdev->platform.irqs[i]);
+	free(vdev->platform.irqs);
+err_unmap:
+	vfio_platform_unmap_regions(kvm, vdev, vdev->info.num_regions);
+	return ret;
 }
 
 void vfio_platform_teardown_device(struct kvm *kvm, struct vfio_device *vdev)
 {
+	size_t i;
+	struct vfio_platform_device *pdev = &vdev->platform;
+
 	vfio_platform_unmap_regions(kvm, vdev, vdev->info.num_regions);
 
+	for (i = 0; i < vdev->info.num_irqs; ++i)
+		vfio_irq_disable(kvm, vdev, i, &pdev->irqs[i]);
+
 	device__unregister(&vdev->dev_hdr);
+	free(pdev->irqs);
 }
-- 
2.56.0.307.g5fe7bd680c-goog

