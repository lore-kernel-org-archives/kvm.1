Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792570837;
	b=iKUSxEmqSyKNfltd5WIB9tEF2R7rhUYyqwKmdRP6tt13CFm98E88Ycz2iIPOKa+n/F2l
	 obE6hn11tgmovJ7gCOT16xLgv94L5t15B1dk/zCaz0o0gGk3t6PUQd97hHsudqVDuQk4B
	 5YMg277CMQQX2lKTJFyeIW9t+n1WuhcxMAXjarz7f6Y0uIOTe8gt1moqqpnl8SvkF/oni
	 ONcxbQVzM3Tx82WLWIcU3Mr3cpUE7rmHIpXEKtFN8vuq+fLH+oydFxzBJ1I691RulKlPm
	 x81VgbbU9lmH2acb5etDSoJil658ba7mi/U/fJumiCi/cRTYuNrnyuwtjuFo247+CVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792570837;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=r4YCCOLhSRRmYuPUoyj2n+2KtkP5M+gmnMQ5btPgJ48=;
	b=hDOTTuTnTIkOuYqyiimTgJ4w2CBEb8GjV5i/zUk5R8ruimybY8fHMwXmMneF/xAIHwE5
	 J3dnMhFEAH7ZOaEzoUlHanTf3AMsqLeoCVXk1/RKVh+07/rGGjfGuEnwY6a2nmSUw1Od6
	 59Ppzqg9NCSaIsqgNZPwf/N9m1JQ+1ir7C53i0/o9IidEVrh+Zx0oHXIYP0FQezgE3pgC
	 ESn17GmZS8rPxefgkXOu+M3HKAl+wP5NzHiXRmC6holIh9bYVmgNmeu+8CE7LTSe1uuRe
	 LD/EA2NoAy+SQtcqWHg0IYC/ImvShBOaGQGmjyClOXbqfpc+AVvpKYIOqlBzv6bD/Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OhA5a1no;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ETZ94OzI;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C893606A319
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 08:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C893606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OhA5a1no;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ETZ94OzI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792570835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r4YCCOLhSRRmYuPUoyj2n+2KtkP5M+gmnMQ5btPgJ48=;
	b=OhA5a1no6qWdtfenbOD33CN/TdMf/HH4Bdg6MIG+b21q4xfSBW04sa7hKScMdsD8JDHruh
	HttdSGIsLJMaUtS8YJZwYPHhwAQlHRjiZRwLVXbfgD4ADj/LIFJ0cclUS6fQqnvB5ifLtX
	0TLMHATbCs1pmZ7V2Zd7HifQeCZvDCI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-R_8riUoXP2aMFwA2ylJzcQ-1; Wed, 21 Oct 2026 08:20:34 +0000
X-MC-Unique: R_8riUoXP2aMFwA2ylJzcQ-1
X-Mimecast-MFC-AGG-ID: R_8riUoXP2aMFwA2ylJzcQ_1792570833
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e011829easo295118f8f.3
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 01:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792570833; x=1793175633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r4YCCOLhSRRmYuPUoyj2n+2KtkP5M+gmnMQ5btPgJ48=;
        b=ETZ94OzIe/3Sgzo73y7xBaVAdkmi9e9EgQ+8y2y9Cr+NM5U/1G8HFiJCTzg3edJn86
         h5rKTEVUsq/j7UvJmPt/ILQUi4qFcHqkbyZTAF1rTw6xPQEpwB0dVG+UordLoB4mc5aT
         N0NJUdyHeG8XYCTH1s0CNfDT/hc2DV3elrr0I+Dv1BAC2X1kajB6el/y0mMOU6xnxaci
         43uNXf4O0k1+dM+JHxZis/6kOFbvadKq8wEw+1x8Js7/6Xk+Xte+JG0Mul8UPde4pwVR
         hTiWWW/kzFBDjtNYYeVEI5k3VLQ55tmB1biswi5WSKaOe1RoR9cjfetwpb4v6gtxbN0x
         ZX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792570833; x=1793175633;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r4YCCOLhSRRmYuPUoyj2n+2KtkP5M+gmnMQ5btPgJ48=;
        b=hQtMIVsPvmjs2kFxn1bRbfvtu415sQV10F/C2kgqQLLKcj6IbKJYcVqJf+VSsQiqh4
         5FMkW6sEi9OUDG1IGqP6u2H+QnpecA6y+ziy/imFgk3ndgVKoE5DzcZSQOPOpY5aZdmn
         S0vAx3SWTFCOmsnZ3KT3woH+L/nqv8nFuwXzoeglw/grui7Z2RMAUGtLQJzLrdzCU0b+
         wTnt1AebCrS+8mVn+pf275tpAbtCiHg6z2vUTgp2vhsd2vlFHNU58E/7ikwgFeAWXW9L
         1/OlqIijVAjRB88ycc80hQUfIveRjgEXtrlXq+kemJCVnj0QV2cPp1B7RxChV+AoCEL5
         5qwg==
X-Forwarded-Encrypted: i=1; AKwUvBy6IPTR4alZwFDCh8FKy6TJPL4lJyhMZmwNmj9De/0zYKNTrkyaDA+MEi1NgGs4JCwAX5A=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTux1+sD1A+BSx0/QZaTG6BHm0Q9UGTiKKFsw16iolFU5Yh8h8
	43gAWJpBmaUsHsaNHCYrRKHFrfj2KhfG23qya0BRdcvvZqB5zwA2esQv6Ls3l2ke5RXiaiPBlFi
	bL6fnXw2wt+zAh6FYCOdniU4Lale6ghsUCYtq8AsPWqcWMKqMIsA9aGPYeUuo+A==
X-Gm-Gg: AYBFou3LE5leZOkf6AoPFV4QjEXRvmItkvxWzMWOzoLVBMZSMc4Pj4VUN6uxwIfXTjb
	gNv35hlLmvquOhsVH9pdF0GsCOl9l7tNyh5Nhc3dPrv5/NYIkTXsXbE2rILoZ+P4L+XPP6O9bPP
	DQUxOrNo2Sy4mN30ZsEq7Tni/PagZyQ2Vcqi0HQBs6Fe7XXCmDb1wKFoHKnmfZNLD0RUxxRkS0a
	AhsRZ3qtGU17fzqaBIn6BhWJBDq0nH4HcPKd2nETugAVtt5oq3XfWz9VNaqnXhGo8k4sak38C6A
	UvExjAmZbp9O8U84mbE4xXgkWrWcWmNC+BuBTRo1BJQ+vjHcFDVBre63fwVRbWawDuOWog==
X-Received: by 2002:a05:600c:3512:b0:4a1:ddca:8b66 with SMTP id 5b1f17b1804b1-4a1fdd44b0bmr23463365e9.31.1792570832647;
        Wed, 21 Oct 2026 01:20:32 -0700 (PDT)
X-Received: by 2002:a05:600c:3512:b0:4a1:ddca:8b66 with SMTP id 5b1f17b1804b1-4a1fdd44b0bmr23462695e9.31.1792570832027;
        Wed, 21 Oct 2026 01:20:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258427cesm3886461f8f.52.2026.10.21.01.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:20:31 -0700 (PDT)
Date: Wed, 21 Oct 2026 04:20:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org
Subject: [PATCH v2 2/2] vfio/pci: read ROM via ACPI _ROM when hardware ROM is
 unreadable
Message-ID: <8ab8fdfe47a8d9c9f10680ddb4a03bccad43f7c5.1792566536.git.mst@redhat.com>
References: <c5d91752c7bbd40d89f5fce5da8582f1673cdfc3.1792566536.git.mst@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5d91752c7bbd40d89f5fce5da8582f1673cdfc3.1792566536.git.mst@redhat.com>

Some GPUs (e.g. NVIDIA Quadro P2000 Mobile in an old laptop I found)
have a ROM BAR that exists but is unreadable because the GPU was never
POSTed by the system BIOS. On these systems the VBIOS is available via
the ACPI _ROM method provided by the platform firmware.

Add an ACPI _ROM fallback in the VFIO PCI ROM region handler, tried
after both pci_map_rom() and the boot loader ROM stash (pdev->rom)
fail. 

Note: the ACPI spec defines _ROM for display devices and prefers it over
the BAR image when present. This patch does not go as far, I am afraid
to break some setups.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Notes (changelog):
    v1->v2:
        probe the _ROM image size once and cache it in the device:
        reads no longer rescan the whole ROM per syscall, and the read
        bound now follows the probed image size instead of the BAR size
        cap the probe at 16 MiB so firmware that keeps returning full
        4K chunks cannot loop forever
        keep _ROM requests page-aligned, since some firmware only
        supports aligned requests
        reads past the image now return 0xff like a ROM BAR instead of
        depending on firmware end-of-image behaviour
        expose the ROM BAR in config space when the ROM is only
        available via _ROM, so VMMs that size the BAR through config
        space can see the region

 drivers/vfio/pci/vfio_pci_config.c |  18 ++-
 drivers/vfio/pci/vfio_pci_core.c   |   9 ++
 drivers/vfio/pci/vfio_pci_priv.h   |   9 ++
 drivers/vfio/pci/vfio_pci_rdwr.c   | 189 ++++++++++++++++++++++++++++-
 include/linux/vfio_pci_core.h      |   2 +
 5 files changed, 219 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index a10ed733f0e3..a775a19bb97b 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -504,9 +504,11 @@ static void vfio_bar_fixup(struct vfio_pci_core_device *vdev)
 	vbar = (__le32 *)&vdev->vconfig[PCI_ROM_ADDRESS];
 
 	/*
-	 * NB. REGION_INFO will have reported zero size if we weren't able
-	 * to read the ROM, but we still return the actual BAR size here if
-	 * it exists (or the shadow ROM space).
+	 * NB. When the ROM is readable, REGION_INFO reports the BAR size;
+	 * when it is not, it reports the platform ROM image size rounded
+	 * up to a power of two.  We still return the actual BAR size here
+	 * if it exists (or the shadow ROM space), so the ROM BAR and the
+	 * region can differ when the BAR is unreadable.
 	 */
 	if (pci_resource_start(pdev, PCI_ROM_RESOURCE)) {
 		mask = ~(pci_resource_len(pdev, PCI_ROM_RESOURCE) - 1);
@@ -517,7 +519,15 @@ static void vfio_bar_fixup(struct vfio_pci_core_device *vdev)
 		mask |= PCI_ROM_ADDRESS_ENABLE;
 		*vbar &= cpu_to_le32((u32)mask);
 	} else {
-		*vbar = 0;
+		size_t rom_size = vfio_pci_rom_acpi_size(vdev);
+
+		if (rom_size) {
+			mask = ~(roundup_pow_of_two(rom_size) - 1);
+			mask |= PCI_ROM_ADDRESS_ENABLE;
+			*vbar &= cpu_to_le32((u32)mask);
+		} else {
+			*vbar = 0;
+		}
 	}
 
 	vdev->bardirty = false;
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 630474d03e3b..2269eee60387 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1136,6 +1136,15 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
 			info->size = roundup_pow_of_two(pdev->romlen);
 		}
 
+		if (!info->size) {
+			size_t acpi_size = vfio_pci_rom_acpi_size(vdev);
+
+			if (acpi_size) {
+				info->flags = VFIO_REGION_INFO_FLAG_READ;
+				info->size = roundup_pow_of_two(acpi_size);
+			}
+		}
+
 		break;
 	}
 	case VFIO_PCI_VGA_REGION_INDEX:
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index fca9d0dfac90..8759745661b7 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -44,6 +44,15 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite);
 
+#ifdef CONFIG_ACPI
+size_t vfio_pci_rom_acpi_size(struct vfio_pci_core_device *vdev);
+#else
+static inline size_t vfio_pci_rom_acpi_size(struct vfio_pci_core_device *vdev)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_VFIO_PCI_VGA
 ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite);
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 6e47d529cbb9..6d653f1c0388 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -10,6 +10,7 @@
  * Author: Tom Lyon, pugs@cisco.com
  */
 
+#include <linux/acpi.h>
 #include <linux/fs.h>
 #include <linux/pci.h>
 #include <linux/uaccess.h>
@@ -211,6 +212,163 @@ int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_setup_barmap);
 
+#ifdef CONFIG_ACPI
+
+/* No known option ROM comes close; caps the _ROM size probe. */
+#define VFIO_PCI_ROM_MAX_SIZE		(16 * 1024 * 1024)
+
+static acpi_handle vfio_pci_acpi_rom_handle(struct pci_dev *pdev)
+{
+	acpi_handle handle, rom_handle;
+
+	handle = ACPI_HANDLE(&pdev->dev);
+	if (!handle)
+		return NULL;
+
+	if (ACPI_FAILURE(acpi_get_handle(handle, "_ROM", &rom_handle)))
+		return NULL;
+
+	return rom_handle;
+}
+
+static int vfio_pci_acpi_rom_read(acpi_handle rom_handle, void *buf,
+				  loff_t offset, size_t length)
+{
+	acpi_status status;
+	union acpi_object rom_arg[2];
+	struct acpi_object_list rom_args;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+
+	rom_args.count = 2;
+	rom_args.pointer = rom_arg;
+	rom_arg[0].type = ACPI_TYPE_INTEGER;
+	rom_arg[0].integer.value = offset;
+	rom_arg[1].type = ACPI_TYPE_INTEGER;
+	rom_arg[1].integer.value = length;
+
+	status = acpi_evaluate_object(rom_handle, NULL, &rom_args, &buffer);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	obj = buffer.pointer;
+	if (obj->type != ACPI_TYPE_BUFFER) {
+		kfree(buffer.pointer);
+		return -EIO;
+	}
+
+	length = min(length, (size_t)obj->buffer.length);
+	memcpy(buf, obj->buffer.pointer, length);
+	kfree(buffer.pointer);
+	return length;
+}
+
+/*
+ * _ROM returns at most 4K per call; read whole pages until a short
+ * chunk marks the end of the image.
+ */
+static size_t vfio_pci_acpi_rom_probe(struct vfio_pci_core_device *vdev)
+{
+	acpi_handle rom_handle = vfio_pci_acpi_rom_handle(vdev->pdev);
+	void *buf;
+	size_t size = 0;
+	int ret;
+
+	if (!rom_handle)
+		return 0;
+
+	buf = kmalloc(0x1000, GFP_KERNEL);
+	if (!buf)
+		return 0;
+
+	do {
+		ret = vfio_pci_acpi_rom_read(rom_handle, buf, size, 0x1000);
+		if (ret > 0)
+			size += ret;
+	} while (ret == 0x1000 && size < VFIO_PCI_ROM_MAX_SIZE);
+
+	kfree(buf);
+	return size;
+}
+
+/*
+ * The image behind _ROM is static firmware data, so probe it once and
+ * cache the result.  Racing callers may probe concurrently, but they
+ * store the same value.
+ */
+size_t vfio_pci_rom_acpi_size(struct vfio_pci_core_device *vdev)
+{
+	/* Read the flag before the size: pairs with the store below. */
+	if (!smp_load_acquire(&vdev->rom_acpi_probed)) {
+		vdev->rom_acpi_size = vfio_pci_acpi_rom_probe(vdev);
+		/* Store the size before the flag: pairs with the load above. */
+		smp_store_release(&vdev->rom_acpi_probed, true);
+	}
+
+	return vdev->rom_acpi_size;
+}
+
+/*
+ * Serve the ROM region from _ROM one page at a time: the method
+ * returns at most 4K, and some implementations only accept
+ * page-aligned requests.  Reads past the image return 0xff, like the
+ * unused space of a ROM BAR.  The caller has probed the image and
+ * cached its size in vdev.
+ */
+static ssize_t vfio_pci_acpi_rom_rw(struct vfio_pci_core_device *vdev,
+				    char __user *buf, size_t count,
+				    loff_t pos, bool iswrite)
+{
+	acpi_handle rom_handle = vfio_pci_acpi_rom_handle(vdev->pdev);
+	size_t rom_size = vdev->rom_acpi_size;
+	void *chunk;
+	ssize_t done = 0;
+	int ret;
+
+	if (iswrite)
+		return -EINVAL;
+
+	if (!rom_handle || !rom_size)
+		return -ENODEV;
+
+	chunk = kmalloc(0x1000, GFP_KERNEL);
+	if (!chunk)
+		return -ENOMEM;
+
+	while (count) {
+		size_t off = pos & (0x1000 - 1);
+		size_t n = min_t(size_t, count, 0x1000 - off);
+		size_t image = 0;
+
+		if (pos - off < rom_size) {
+			ret = vfio_pci_acpi_rom_read(rom_handle, chunk,
+						     pos - off, 0x1000);
+			if (ret <= 0) {
+				if (ret < 0 && !done)
+					done = ret;
+				break;
+			}
+			image = min_t(size_t, ret, rom_size - (pos - off));
+		}
+
+		memset(chunk + image, 0xff, 0x1000 - image);
+
+		if (copy_to_user(buf, chunk + off, n)) {
+			done = done ? done : -EFAULT;
+			break;
+		}
+
+		buf += n;
+		pos += n;
+		done += n;
+		count -= n;
+	}
+
+	kfree(chunk);
+	return done;
+}
+#endif /* CONFIG_ACPI */
+
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite)
 {
@@ -221,16 +379,23 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 	resource_size_t end;
 	void __iomem *io = NULL;
 	bool rom_is_mapped = false;
+	size_t rom_size = 0;
 	struct resource *res = &vdev->pdev->resource[bar];
 	ssize_t done;
 	enum vfio_pci_io_width max_width = VFIO_PCI_IO_WIDTH_8;
 
-	if (pci_resource_start(pdev, bar))
+	if (pci_resource_start(pdev, bar)) {
 		end = pci_resource_len(pdev, bar);
-	else if (bar == PCI_ROM_RESOURCE && pdev->rom && pdev->romlen)
+	} else if (bar == PCI_ROM_RESOURCE && pdev->rom && pdev->romlen) {
 		end = roundup_pow_of_two(pdev->romlen);
-	else
+	} else if (bar == PCI_ROM_RESOURCE) {
+		rom_size = vfio_pci_rom_acpi_size(vdev);
+		if (!rom_size)
+			return -EINVAL;
+		end = roundup_pow_of_two(rom_size);
+	} else {
 		return -EINVAL;
+	}
 
 	if (bar == PCI_ROM_RESOURCE) {
 		/*
@@ -247,7 +412,8 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 		/*
 		 * The BAR can also exist but be unreadable, e.g. on a GPU
 		 * that was never POSTed.  Fall back to the ROM image stashed
-		 * by the boot loader; the region then follows the image size
+		 * by the boot loader (pdev->rom) or provided by the platform
+		 * firmware (_ROM); the region then follows the image size
 		 * rather than the BAR, so bound the access only after the
 		 * source of the ROM content is known.
 		 */
@@ -256,6 +422,12 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			io = ioremap(pdev->rom, pdev->romlen);
 			x_start = pdev->romlen;
 		}
+
+		if (!io && !(pdev->rom && pdev->romlen)) {
+			rom_size = vfio_pci_rom_acpi_size(vdev);
+			if (rom_size)
+				end = roundup_pow_of_two(rom_size);
+		}
 	}
 
 	if (pos >= end)
@@ -263,6 +435,15 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 
 	count = min(count, (size_t)(end - pos));
 
+#ifdef CONFIG_ACPI
+	if (bar == PCI_ROM_RESOURCE && rom_size) {
+		done = vfio_pci_acpi_rom_rw(vdev, buf, count, pos, iswrite);
+		if (done >= 0)
+			*ppos += done;
+		return done;
+	}
+#endif
+
 	if (bar == PCI_ROM_RESOURCE) {
 		if (!io)
 			return -ENOMEM;
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 89165b769e5c..64f86ed8d6b0 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -115,6 +115,8 @@ struct vfio_pci_core_device {
 	u16			msix_size;
 	u32			msix_offset;
 	u32			rbar[7];
+	size_t			rom_acpi_size; /* _ROM image size, if any */
+	bool			rom_acpi_probed;
 	bool			has_dyn_msix:1;
 	bool			pci_2_3:1;
 	bool			virq_disabled:1;
-- 
MST

