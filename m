Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792858829;
	b=W6PFdYo+sQWwyAAPVNpePsbYX6gNhZFG3sSkUxKDGqISQKQgNBekM3N1flg4CUO21p8K
	 nMYZPqfuen6tGJr7Il5kC3uffgtFSJEPdm2Z4k9pQR7tlFjO8IDkhcFTbN2LhlyuTh9Wj
	 bc6O0sazUqRVlq92fFW5t16fxzouRuBmYa5Ml8hkQPA69orgVI7g31YkBd4eTZLL1nrcX
	 32AMMDb6m/tHy+JR9qcLPm2v49q1v5vfyQkjpS9Oj1xpUEU7D9e2/vWJrJViYUfvY981z
	 JZbNFAbH6WiWr0NKSj2SfsRlcHAfgQQmoPScOUc+EunlwSA/OKiOPvau/cubUVaTY9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792858829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=88WKBlUqVVmJ8sAxDXKBYyR66azm4Q01VkqQlySlKgg=;
	b=k1vFi/baRoHHPqJjNR9BE/fFfj9PLJk6YszUq3rDd6ozM8qnGgf8MQbDuKxcP5kXFezQ
	 UNfsk1y81Y3JZ787Hxrfq9vsNX1+9Mssw0iQCEr9nbjD0sJ7Q3zaIWE+ycafJF8KkF6sB
	 WQtLlj71P5CkKDl9j/K+0AZgwt+up6w5dU2+uLm2DGIo6CObQawa8RH+/Rfx/ZrRC3wqW
	 JPcUlIh871E0RHUVALWXm8mivOiH6PetWTc+r6NHlGrI9VDKY9IdC9sqVAGbHfpyhcQhe
	 yAYK/iAJ+ITiaWzVzPimd26a468oik03inEQkzzbkaJwX1TlKjp3ztZaJcrvmBZMwaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GvqEDRoo;
	arc=none smtp.remote-ip=209.85.208.70
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B04606A332
	for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 16:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28B04606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GvqEDRoo
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6b20352f43eso1629966a12.1
        for <kvm@vger.kernel.org>; Sat, 24 Oct 2026 09:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792858827; x=1793463627; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=88WKBlUqVVmJ8sAxDXKBYyR66azm4Q01VkqQlySlKgg=;
        b=GvqEDRoow15aEvJ9PvCqNidmxoj6Q7G38PDKqcN/ph8SlpVwGjNHnKEZR9grTZwJHC
         W6CmWVSlDWEDIX9qGyjiJColuev6Lf5DTjsVFJpzViKbtbDFTRKwxyPENNdPdirvjsAt
         V1LtIXkTFHJ9J5yu8hOYsigT6sz1M9P1Zu4oyzwfxdR186igcoURaZNEh3CHSAouxYoM
         Ddga/THukx/rj/F1p63lVy7oCUx6F76CWHMoMqcyZv16/pN9qeC7RcYNeyOTd1AsZrob
         qb3ZxN9TlKsbICUcDVuPKhUjQ3KKhyyg2apFsU0PvTiQ4dDGCUzc3wDYJT/WnhXQe+mY
         F3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792858827; x=1793463627;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=88WKBlUqVVmJ8sAxDXKBYyR66azm4Q01VkqQlySlKgg=;
        b=0VJbstfgnl70EPSTJvi3ozSYYUes/L63p/XzDOqPmAYOj/IEcL7gnifDDyX/wgT2Ev
         f2xobqclhkwo4QHZEqrWvRp2qQQi8SfSZimwB3oIMrWFDkwuDF75bsD9R0f6G+H1LsbH
         DjuEyfztpU4CBVx/1lry+Qy4oMiGaxcpwFO0D+h9HFPDlfmAiKmgY753ehl4zYlQemN4
         HlLG8apu3tIP2q0TFVNHZpxkYWqs/3FlybGRvDIcU+72c6rLZqwlpvkye5zxmeR772IR
         Kk414KvShp3p3ziwv6RN2liqNnu3sYtWyWzqmQJfreczJ9W5cHx0Ug9I74ZcLk0umrN6
         K0Bg==
X-Gm-Message-State: AFq9FYIXVXmfRby6GlwkDf0vwwSDHX9SWLJrFGW+3C6ZAKY3PaouYCIr
	2vcLUllC8/1hcYQsujATCQug1Zvn8m2gnBe2Oug0vEAie3Po7cTsfNq5nSLyEsXtoTr+xgqpXl8
	fzVamXX/XaL5pcDQkObEMBUbYayv2/e6hBiWPMFS/5OQS9X/275t2Yohv3de157eag0E+EPJzSM
	3cpGQfHVkoa7RDoGcKgzGbeDQD+tKR9tE2hSzeOz6hCGk=
X-Received: from ejom1.prod.google.com ([2002:a17:906:79c1:b0:c3a:a8e1:ecae])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:6d0a:b0:c42:4f89:13 with SMTP id a640c23a62f3a-c46bdc13042mr243050866b.15.1792858827113;
 Sat, 24 Oct 2026 09:20:27 -0700 (PDT)
Date: Sat, 24 Oct 2026 16:19:02 +0000
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
Message-ID: <20261024161902.2093581-10-smostafa@google.com>
Subject: [PATCH kvmtool 9/9] vfio: platform: Take the guest node from a device
 tree template
From: Mostafa Saleh <smostafa@google.com>
To: kvm@vger.kernel.org
Cc: will@kernel.org, julien.thierry.kdev@gmail.com, praan@google.com, 
	eric.auger@redhat.com, alex@shazbot.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

At this point the device node has interrupts and regs, which is not
enough to probe a driver in the guest, it at least needs a compatible
string and other device bindings.
To avoid hardcoding those, let the user supply them as a compiled
device tree blob:

  --vfio-platform <device>[,<template.dtb>]

Every property of the template's root node, and every subnode, is
copied into the generated node with fdt__copy_node().

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 builtin-run.c      |  2 +-
 include/kvm/vfio.h |  2 ++
 vfio/core.c        | 16 ++++++++++++++-
 vfio/platform.c    | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/builtin-run.c b/builtin-run.c
index b09fc2e..a6fd8ec 100644
--- a/builtin-run.c
+++ b/builtin-run.c
@@ -262,7 +262,7 @@ static int loglevel_parser(const struct option *opt, const char *arg, int unset)
 	OPT_CALLBACK('\0', "vfio-pci", NULL, "[domain:]bus:dev.fn",	\
 		     "Assign a PCI device to the virtual machine",	\
 		     vfio_device_parser, kvm),				\
-	OPT_CALLBACK('\0', "vfio-platform", NULL, "device",		\
+	OPT_CALLBACK('\0', "vfio-platform", NULL, "device[,template.dtb]",	\
 		     "Assign a platform device to the virtual machine",	\
 		     vfio_device_parser, kvm),				\
 									\
diff --git a/include/kvm/vfio.h b/include/kvm/vfio.h
index b3034a0..de24ba1 100644
--- a/include/kvm/vfio.h
+++ b/include/kvm/vfio.h
@@ -121,6 +121,8 @@ struct vfio_device {
 
 struct vfio_device_params {
 	char				*name;
+	/* Platform devices: DTB whose root node is copied into the guest node */
+	char				*dt_template;
 	const char			*bus;
 	enum vfio_device_type		type;
 };
diff --git a/vfio/core.c b/vfio/core.c
index 6823a95..3ce1ffd 100644
--- a/vfio/core.c
+++ b/vfio/core.c
@@ -41,16 +41,30 @@ static int vfio_device_pci_parser(const struct option *opt, char *arg,
 	return 0;
 }
 
-/* @arg is the name of the device under /sys/bus/platform/devices */
+/*
+ * @arg is the name of the device under /sys/bus/platform/devices, optionally
+ * followed by ",<template.dtb>".
+ */
 static int vfio_device_platform_parser(const struct option *opt, char *arg,
 				       struct vfio_device_params *dev)
 {
+	char *dt_template = strtok(NULL, ",");
+
 	dev->type = VFIO_DEVICE_PLATFORM;
 	dev->bus = "platform";
+	dev->dt_template = NULL;
 	dev->name = strdup(arg);
 	if (!dev->name)
 		return -ENOMEM;
 
+	if (dt_template) {
+		dev->dt_template = strdup(dt_template);
+		if (!dev->dt_template) {
+			free(dev->name);
+			return -ENOMEM;
+		}
+	}
+
 	return 0;
 }
 
diff --git a/vfio/platform.c b/vfio/platform.c
index 22052a6..2d08f73 100644
--- a/vfio/platform.c
+++ b/vfio/platform.c
@@ -8,7 +8,11 @@
 
 #include <sys/ioctl.h>
 #include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/stat.h>
 #include "kvm/fdt.h"
+#include "kvm/read-write.h"
 
 static u64 vfio_mmio_io_space_next = KVM_VFIO_MMIO_AREA;
 
@@ -29,6 +33,48 @@ static int vfio_mmio_alloc_io_space(u64 size, u64 *addr)
 }
 
 #ifdef CONFIG_HAS_LIBFDT
+static void vfio_platform_generate_fdt_from_template(void *fdt,
+						     struct vfio_device *vdev)
+{
+	int fd;
+	struct stat st;
+	void *tmp_fdt;
+	int root_offset;
+
+	if (!vdev->params->dt_template)
+		return;
+
+	fd = open(vdev->params->dt_template, O_RDONLY);
+	if (fd < 0)
+		die("Failed to open device tree template '%s'", vdev->params->dt_template);
+
+	if (fstat(fd, &st) < 0)
+		die("Failed to stat device tree template");
+
+	if (st.st_size < (off_t)sizeof(struct fdt_header))
+		die("Invalid device tree blob (DTB) provided in '%s'",
+		    vdev->params->dt_template);
+
+	tmp_fdt = malloc(st.st_size);
+	if (!tmp_fdt)
+		die("Failed to allocate memory for device tree template");
+
+	if (read_in_full(fd, tmp_fdt, st.st_size) != st.st_size)
+		die("Failed to read device tree template");
+
+	if (fdt_check_header(tmp_fdt))
+		die("Invalid DTB: '%s'", vdev->params->dt_template);
+
+	root_offset = fdt_path_offset(tmp_fdt, "/");
+	if (root_offset < 0)
+		die("Failed to parse device tree template");
+
+	fdt__copy_node(fdt, tmp_fdt, root_offset);
+
+	free(tmp_fdt);
+	close(fd);
+}
+
 static void generate_interrupts_prop(void *fdt, struct vfio_device *vdev,
 				     fdt_irq_fn generate_irq_prop)
 {
@@ -82,6 +128,9 @@ static void generate_mmio_fdt_node(void *fdt,
 		 vdev->params->name, vdev->regions[0].guest_phys_addr);
 
 	_FDT(fdt_begin_node(fdt, node_name));
+	/* Extra user supplied binding. */
+	vfio_platform_generate_fdt_from_template(fdt, vdev);
+
 	_FDT(fdt_property(fdt, "reg", reg_prop,
 			  2 * sizeof(*reg_prop) * num_regions));
 	generate_interrupts_prop(fdt, vdev, generate_irq_prop);
@@ -264,4 +313,5 @@ void vfio_platform_teardown_device(struct kvm *kvm, struct vfio_device *vdev)
 
 	device__unregister(&vdev->dev_hdr);
 	free(pdev->irqs);
+	free(vdev->params->dt_template);
 }
-- 
2.56.0.307.g5fe7bd680c-goog

