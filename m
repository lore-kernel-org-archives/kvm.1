Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792858827;
	b=bpra6kbgV7kNg7xq98UN5B/t5SzzQdZFMAeXWmAdTxrvdOffDfn/Xnk2TZVQVFe37aop
	 KU9SEZapzWlHsAZ8qU2CVcjakfkzhohe8FgISiaR3gJlQXAAhV9v3R4RQSQXlbNctRegL
	 enocVBarMJ5lpcLuqAuev8kaD07FUj8EErm39qdZnMbUjTMK6FljeVVb+iRS4t5OyLMsT
	 fzctYR/wVNZoJtxNprSx75C1MmYILIbAJWBOi1cMqte621WGQJaXXm1hCJM/i29zlDURi
	 +kfpPT7nAicyNBSaBsSgLG4KkHsO2QJ/bys3OP5Jni0OZvml8VQlzUKn76WV2SbmbYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792858827;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=2tZvnoPMNast8sg8P9s907+bbFghLSFF53ZiDLSPY2E=;
	b=wawkmRdyt34lvUad0QkwraB9axkwjyY79rHRGkjz799Gy9X/jAR+ZAOSa6MMsewnf04y
	 1aEMw4nJPhjt7Wijp5hFotdVZYLbzigUjncRmJHEKGwAZweFHfZzm8+Y/+0xTC+HrrLnK
	 dIWBkrYRT6Bo7TEJgCLRYGKlU9OkI6Eq3cp/vrNuEyrfP8wl/lNlbX7EOd05OHMwiF0k0
	 eRu7ZjNMB3EhtXWHjw+A6uPFLqhUW1dfXieuS3F6QDZimA6swiugXjji/GyfEnNufis2L
	 d5l+6MwlWKPDqN/iPyVYwj84BA3boL7ZScFkMSVgKAbaYc7UQwTZ2XHLRykzeFRoy2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=CKaHeis9;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA94606A332
	for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 16:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DA94606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=CKaHeis9
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49953abe51fso13466175e9.1
        for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 09:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792858825; x=1793463625; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2tZvnoPMNast8sg8P9s907+bbFghLSFF53ZiDLSPY2E=;
        b=CKaHeis9xLYzZLuktBujtjpZsL+ZEVoElzo0iRPdS4m74GEPLzHRN23uTels4UFN7w
         e7A8sTRAcJpA7RLPW5HqzUAZBGZMDjTliR1Mlm0E5b7F7Yi/cKtepdCD4Q4tavjnJwZ5
         AyYJ+GMEOuEYVMSKYbybjtLbnpXz1h1k+7uAHJwox++TJNDlScb9oSqufFOAI5BeyuRp
         kIbvlxrPqPTCGA1vbCtOkja6xM9jdmaYmUuLuxhm3xe6mFBWu/LXl978J6GXdolP8BUL
         r02yb8iMY5LuIy1Lv1C3jhVOSewraUmVyh0mL9VP7Rj5LyIE0X28ZHW6bUwcfkwPHFbb
         jQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792858825; x=1793463625;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2tZvnoPMNast8sg8P9s907+bbFghLSFF53ZiDLSPY2E=;
        b=pJ99E9jhpd1qeK2GE2hJysVNoBA71FV2hxR1hkwPYNZ+dOKIqOOkj4Py73PfL6kzvA
         V95SEyxYw7+ojWAuTahW1wToUNH7XPufcLPXrfun7aoqwEpsAe7+YI3ggBemUcWEBjui
         CZLfroLGLH2lLTacGrk/idFpYs3kGwzaj6fGSeQLmi+tFKqpEQxFnOabJhasfk6JsMw8
         OY/Tcufiskg+P7vpnYeQoaRAD8fwRAZ0M/OrUDFn+WCWgqJIlVg3JMq1Xi2TCwIMp2uc
         ntdcVneoMTLGCYGqHMlWn5vFwwkqf7PvpD3GvnOjYoVQqZyeJVjNETNJ9P2FR8AGCztn
         h1bg==
X-Gm-Message-State: AFq9FYLERG63HXHw502JWimIJTE4lOfk97rUvQjauayUeYZwtUPxnJe7
	bygKMoYjP782v9FfarnaLp5YsH4u45e8krnczeNqLCcKgvY6VobXqN+YuMPnC+uW3oU68MGobPb
	a9jf6pXjvdGYteEa313XKVp0QCmq+Runi1UBGLorprDP3Nvi+nEd2bcVhC22KrShZJOTTmK1D+w
	O4L5PowkSrGGeD7eKVan+x57r1UvK+hXACuHlQSDhu2rI=
X-Received: from wmgi7.prod.google.com ([2002:a05:600c:2d87:b0:4a1:f4c2:f6c7])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b09:b0:4a1:7e76:d02f with SMTP id 5b1f17b1804b1-4a35aca4a0cmr35044485e9.14.1792858824796;
 Sat, 24 Oct 2026 09:20:24 -0700 (PDT)
Date: Sat, 24 Oct 2026 16:19:00 +0000
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
Message-ID: <20261024161902.2093581-8-smostafa@google.com>
Subject: [PATCH kvmtool 7/9] vfio: Add basic support for vfio-platform
From: Mostafa Saleh <smostafa@google.com>
To: kvm@vger.kernel.org
Cc: will@kernel.org, julien.thierry.kdev@gmail.com, praan@google.com, 
	eric.auger@redhat.com, alex@shazbot.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

A VFIO device can be assigned to a guest with new cmdline
--vfio-platform ${dev} , where ${dev} is the name of the device under
/sys/bus/platform.

The device is expected to be bound to vfio-platform driver before
running the tool.

The MMIO regions of the device are mapped into the guest address
space reserved for VFIO, and described in a device tree node.
The node only carries reg, so no guest driver binds to it yet.
Interrupts and the rest of the node are added in the next patches.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 Makefile           |   1 +
 builtin-run.c      |   3 +
 include/kvm/vfio.h |   3 +
 vfio/core.c        |  22 +++++++
 vfio/platform.c    | 158 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 187 insertions(+)
 create mode 100644 vfio/platform.c

diff --git a/Makefile b/Makefile
index 1c0e7f5..8d1c0d9 100644
--- a/Makefile
+++ b/Makefile
@@ -65,6 +65,7 @@ OBJS	+= pci.o
 OBJS	+= term.o
 OBJS	+= vfio/core.o
 OBJS	+= vfio/pci.o
+OBJS	+= vfio/platform.o
 OBJS	+= virtio/blk.o
 OBJS	+= virtio/scsi.o
 OBJS	+= virtio/console.o
diff --git a/builtin-run.c b/builtin-run.c
index 81f255f..b09fc2e 100644
--- a/builtin-run.c
+++ b/builtin-run.c
@@ -261,6 +261,9 @@ static int loglevel_parser(const struct option *opt, const char *arg, int unset)
 	OPT_GROUP("VFIO options:"),					\
 	OPT_CALLBACK('\0', "vfio-pci", NULL, "[domain:]bus:dev.fn",	\
 		     "Assign a PCI device to the virtual machine",	\
+		     vfio_device_parser, kvm),				\
+	OPT_CALLBACK('\0', "vfio-platform", NULL, "device",		\
+		     "Assign a platform device to the virtual machine",	\
 		     vfio_device_parser, kvm),				\
 									\
 	OPT_GROUP("Debug options:"),					\
diff --git a/include/kvm/vfio.h b/include/kvm/vfio.h
index 0b2b105..f641292 100644
--- a/include/kvm/vfio.h
+++ b/include/kvm/vfio.h
@@ -24,6 +24,7 @@
 
 enum vfio_device_type {
 	VFIO_DEVICE_PCI,
+	VFIO_DEVICE_PLATFORM,
 };
 
 /* MSI/MSI-X capability enabled */
@@ -146,5 +147,7 @@ void vfio_irq_disable(struct kvm *kvm, struct vfio_device *vdev,
 		      unsigned int index, struct vfio_irq *irq);
 int vfio_pci_setup_device(struct kvm *kvm, struct vfio_device *device);
 void vfio_pci_teardown_device(struct kvm *kvm, struct vfio_device *vdev);
+int vfio_platform_setup_device(struct kvm *kvm, struct vfio_device *device);
+void vfio_platform_teardown_device(struct kvm *kvm, struct vfio_device *vdev);
 
 #endif /* KVM__VFIO_H */
diff --git a/vfio/core.c b/vfio/core.c
index aa124d2..6823a95 100644
--- a/vfio/core.c
+++ b/vfio/core.c
@@ -41,6 +41,19 @@ static int vfio_device_pci_parser(const struct option *opt, char *arg,
 	return 0;
 }
 
+/* @arg is the name of the device under /sys/bus/platform/devices */
+static int vfio_device_platform_parser(const struct option *opt, char *arg,
+				       struct vfio_device_params *dev)
+{
+	dev->type = VFIO_DEVICE_PLATFORM;
+	dev->bus = "platform";
+	dev->name = strdup(arg);
+	if (!dev->name)
+		return -ENOMEM;
+
+	return 0;
+}
+
 int vfio_device_parser(const struct option *opt, const char *arg, int unset)
 {
 	int ret = -EINVAL;
@@ -72,6 +85,8 @@ int vfio_device_parser(const struct option *opt, const char *arg, int unset)
 
 	if (!strcmp(opt->long_name, "vfio-pci"))
 		ret = vfio_device_pci_parser(opt, cur, dev);
+	else if (!strcmp(opt->long_name, "vfio-platform"))
+		ret = vfio_device_platform_parser(opt, cur, dev);
 	else
 		ret = -EINVAL;
 
@@ -433,6 +448,10 @@ static int vfio_configure_device(struct kvm *kvm, struct vfio_device *vdev)
 		BUG_ON(!(vdev->info.flags & VFIO_DEVICE_FLAGS_PCI));
 		ret = vfio_pci_setup_device(kvm, vdev);
 		break;
+	case VFIO_DEVICE_PLATFORM:
+		BUG_ON(!(vdev->info.flags & VFIO_DEVICE_FLAGS_PLATFORM));
+		ret = vfio_platform_setup_device(kvm, vdev);
+		break;
 	default:
 		BUG_ON(1);
 		ret = -EINVAL;
@@ -703,6 +722,9 @@ static void vfio_device_exit(struct kvm *kvm, struct vfio_device *vdev)
 	case VFIO_DEVICE_PCI:
 		vfio_pci_teardown_device(kvm, vdev);
 		break;
+	case VFIO_DEVICE_PLATFORM:
+		vfio_platform_teardown_device(kvm, vdev);
+		break;
 	default:
 		vfio_dev_warn(vdev, "no teardown function for device");
 	}
diff --git a/vfio/platform.c b/vfio/platform.c
new file mode 100644
index 0000000..c5b447f
--- /dev/null
+++ b/vfio/platform.c
@@ -0,0 +1,158 @@
+#include "linux/sizes.h"
+
+#include "kvm/kvm.h"
+#include "kvm/vfio.h"
+
+#include <errno.h>
+
+#include <sys/ioctl.h>
+#include <stdlib.h>
+#include "kvm/fdt.h"
+
+static u64 vfio_mmio_io_space_next = KVM_VFIO_MMIO_AREA;
+
+static int vfio_mmio_alloc_io_space(u64 size, u64 *addr)
+{
+	u64 align = max_t(u64, PAGE_SIZE, MAX_PAGE_SIZE);
+	u64 end = KVM_VFIO_MMIO_AREA + KVM_VFIO_MMIO_SIZE;
+
+	vfio_mmio_io_space_next = ALIGN(vfio_mmio_io_space_next, align);
+	size = ALIGN(size, align);
+	if (size > end - vfio_mmio_io_space_next)
+		return -ENOSPC;
+
+	*addr = vfio_mmio_io_space_next;
+	vfio_mmio_io_space_next += size;
+
+	return 0;
+}
+
+#ifdef CONFIG_HAS_LIBFDT
+static void generate_mmio_fdt_node(void *fdt,
+				   struct device_header *dev_hdr,
+				   fdt_irq_fn generate_irq_prop)
+{
+	struct vfio_device *vdev = container_of(dev_hdr,
+						struct vfio_device, dev_hdr);
+	unsigned int i, num_regions = vdev->info.num_regions;
+	char node_name[PATH_MAX];
+	u64 *reg_prop;
+
+	reg_prop = calloc(num_regions, 2 * sizeof(*reg_prop));
+	if (!reg_prop)
+		die("Failed to allocate the reg property");
+
+	for (i = 0; i < num_regions; i++) {
+		reg_prop[2 * i] = cpu_to_fdt64(vdev->regions[i].guest_phys_addr);
+		reg_prop[2 * i + 1] = cpu_to_fdt64(vdev->regions[i].info.size);
+	}
+
+	snprintf(node_name, sizeof(node_name), "%s@%llx",
+		 vdev->params->name, vdev->regions[0].guest_phys_addr);
+
+	_FDT(fdt_begin_node(fdt, node_name));
+	_FDT(fdt_property(fdt, "reg", reg_prop,
+			  2 * sizeof(*reg_prop) * num_regions));
+	_FDT(fdt_end_node(fdt));
+
+	free(reg_prop);
+}
+#endif /* CONFIG_HAS_LIBFDT */
+
+static void vfio_platform_unmap_regions(struct kvm *kvm,
+					struct vfio_device *vdev,
+					unsigned int nr_regions)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr_regions; i++)
+		vfio_unmap_region(kvm, &vdev->regions[i]);
+}
+
+static int vfio_platform_configure_regs(struct kvm *kvm,
+					struct vfio_device *vdev)
+{
+	int ret = 0;
+	unsigned int i = 0;
+	struct vfio_region *region;
+	struct vfio_region_info *info;
+
+	if (!vdev->info.num_regions)
+		return -ENODEV;
+
+	for (i = 0; i < vdev->info.num_regions; i++) {
+		info = &vdev->regions[i].info;
+		*info = (struct vfio_region_info) {
+			.argsz = sizeof(*info),
+			.index = i,
+		};
+
+		if (ioctl(vdev->fd, VFIO_DEVICE_GET_REGION_INFO, info)) {
+			ret = -errno;
+			vfio_dev_err(vdev, "failed to get info for region[%u]", i);
+			goto err_unmap;
+		}
+
+		if (!info->size) {
+			ret = -EINVAL;
+			goto err_unmap;
+		}
+
+		region = &vdev->regions[i];
+		region->vdev = vdev;
+		region->is_ioport = false;
+		ret = vfio_mmio_alloc_io_space(region->info.size,
+					       &region->guest_phys_addr);
+		if (ret) {
+			vfio_dev_err(vdev, "no guest address space left for region[%u] (0x%llx bytes)",
+				     i, info->size);
+			goto err_unmap;
+		}
+
+		ret = vfio_map_region(kvm, vdev, region);
+		if (ret) {
+			vfio_dev_err(vdev, "failed to map region[%u] at 0x%llx", i, info->offset);
+			goto err_unmap;
+		}
+	}
+
+	return 0;
+
+err_unmap:
+	vfio_platform_unmap_regions(kvm, vdev, i);
+	return ret;
+}
+
+int vfio_platform_setup_device(struct kvm *kvm, struct vfio_device *vdev)
+{
+	int ret;
+
+	ret = vfio_platform_configure_regs(kvm, vdev);
+	if (ret) {
+		vfio_dev_err(vdev, "failed to configure regs");
+		return ret;
+	}
+
+	vdev->dev_hdr = (struct device_header) {
+		.bus_type	= DEVICE_BUS_MMIO,
+#ifdef CONFIG_HAS_LIBFDT
+		.data		= generate_mmio_fdt_node,
+#endif
+	};
+
+	ret = device__register(&vdev->dev_hdr);
+	if (ret) {
+		vfio_dev_err(vdev, "failed to register VFIO device");
+		vfio_platform_unmap_regions(kvm, vdev, vdev->info.num_regions);
+		return ret;
+	}
+
+	return 0;
+}
+
+void vfio_platform_teardown_device(struct kvm *kvm, struct vfio_device *vdev)
+{
+	vfio_platform_unmap_regions(kvm, vdev, vdev->info.num_regions);
+
+	device__unregister(&vdev->dev_hdr);
+}
-- 
2.56.0.307.g5fe7bd680c-goog

