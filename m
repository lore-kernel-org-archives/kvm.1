Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585373;
	b=kO8eMc39fEA6zxL07rh8CITA66lwq/TtbJ7WGgxQPXFmbtMWe63HYqM+Bsl4cQSLB981
	 JP9gJwjxYVANnlcciPf8J1NZNQsQi5t/95I60ETn75QGD2MrPRUUCaK0jyOoCzsK6pyOE
	 5RyZtNqHlNE2aAnIDv75/+f6nw6YZ3+L3rPhnnb98VS+RM1UiUbP1EfQ8EgOGbTJxDnWj
	 FbEZZHWdO+rhmissYicWEpo+fp3AWeb3RMxN1bf0bnM6tmiVTUDKArASW/MAbt7zQCjOg
	 3osjNs4BEk0w9UXpcGLzSjue5JxQHu0/dbHMFwPI1yOWzn5tgvLZYOg222gA33qkyrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KCWQLV59SSkBVEyRi73YWJ7kvOmA9/flLQSro0VYOqA=;
	b=prgzcn84dm6RiTVuCTUNOgJtTfmm71S4uBTGXSEwPNtZYWnoQclRNqfGF+g2WmiPcf3w
	 eij0utqXEFFM2mY7l+POVMdzJxG9NTS4Ipk/m8Yf20TGI9BCGCyVd7tRqH8c0uUM2dOkM
	 tmMe0pUtDlZ5k1Y5sanFpLju/GaWGN+WLEw0ljGXiVbHidTQ09kFLgMs+xl/B6PY3gUWn
	 o+YxORP048xP1FKGrKUDATFRQyLKi4Kt+xF/dT6nlO04U0I9LVRhP7Lui5VfQOHJQ5HmG
	 6KMEJM3e0QEwWIZbZgUGPoXjteMhca1Fc/Mudxf28nworAadmWLr4DWNXclR0Ybg77A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=uXHklBYE;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DBD606AE25
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 15:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7DBD606AE25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=uXHklBYE
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b581b6b0e9so1689703a12.2
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 07:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1794585371; x=1795190171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KCWQLV59SSkBVEyRi73YWJ7kvOmA9/flLQSro0VYOqA=;
        b=uXHklBYEpWMLRXQHwKuLvydJg/KWSyTceGlGKPNQucAtESrumouDSUc5zs9m2zY+mQ
         akYl5GUokhmC+EE3nFnK8cqP2QrfMWLQ1C8Mml/eUscVK/vq+gR1ssbGjPxbKiJ4NIrx
         PYN/kF79+ml0tYKxkiFeAZK4r+YEXXi71vBi7Bz6KVpcCYzJk/Kmp9ImX3k8DsPqLluE
         iPHRDiTPRsy1u6svxg1FwAlUv0nryAngTCyZFOzNOmcuKiEepbY09u/9cmPTmUH5ywED
         quipRZCnt3hUd22ldx3aN0coJmuFOIjWU/Gc8tD4hDspD2Swx5liqnNSe7rP1enP+6zH
         ChCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585371; x=1795190171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KCWQLV59SSkBVEyRi73YWJ7kvOmA9/flLQSro0VYOqA=;
        b=JLYH0NVLHtc9KGeVHoHWiCTS5g7nOkGj3R7EPihlXLWTe6YGhl/ys9VC6aIc2ByYB/
         eVwp/xeoyBd/faBLy/Lh8ifLW2AAHUEIiTDSUH8vPBAV4kPtD4Pq64zveZ4kS0RM0v4e
         CwoMlfC6ziTrqDrMfxrrNgSDQtITOA4dkX44L2HxCyMbo2beJVTu/6QcfEQKLbnt+aGD
         IlmJVHWtWNreZWWXqE5Y6CjI/sT8G8bobp2QnMCEf5N9D8tjkxTs+wSxtElXqoL2m6OG
         Hxcl0sG7Z1UvN2A7eT7q90i4vNnOdSKcpPh4wNQYLl8AdE5ZmNW6HZPNBzjO7hXiQWHP
         /dtw==
X-Forwarded-Encrypted: i=1; AL+hErGaBwTHs862KOQUTgzlPSEiOvws9ZfSXjWoqiEA4Zrdl6gFSFkKfuZT8Afk3Dzhw48Tk3c=@vger.kernel.org
X-Gm-Message-State: APuU4Z95XfPhSc+DReiqxwZz6Dcr/InhTfJ6e4hLl7z4+AxNv3fnQSJG
	x4Ws7i8q07QhnOschbsNzNOOdk67vPVylN8Ke2rX1yaVgstCWlDjdqv7uF8q68/mzlc=
X-Gm-Gg: AYBFou22psA0ZsWhSyEyq+luIK69J/R74kvdgp9It8MOBF/2H4aufFy8jP8eOcyxzl/
	ltaI8Vy9Ym4nnhhVGXQTT1W8a+EvqoIXigiKUo4Oe2E4lIydpVx6iM+nQqcDqyhmmF2kMluhhJf
	iBoquM1xr8Lf56NNUDJQd6F+h0giV1Sd9dKYisKZdFNqQTsNoVGwC8ijc0DFOuOHW8q4ZABdI7W
	msvr1sn7qnETAZHGrv19jI61maxUohWaZjXSoe3sUbjAqJxSvtAFtHJaHyezlNbZ4Ue8zXfRb+I
	SDmrjj7nfYIW4U9oek2sQrTz93yTfTkt68kdfPoKWaI7XTbevbrqfOflPTxfCxIn7s6qAdGvwf/
	FhUElQyoq1rEjMV2CvKIZy7XK6h/BxUUCJI0USAf0kIKN4H3yqqKGOXUneqwN2ebXUHeV9mCDB0
	2sms1/sb5fbA1OYmw3G4NTOgmaeFdzjThkxC5yp+/3v/AjUXn7JXq2qk0jkFbLIIn0ImpHYFDAo
	rJtpJMEYY3X8B29T8kjGu1l4cREfHCa/Yuq3GHbUWEXTF/KmKQLQDsvStoaupoDEsh9j4c7zYWl
	S7+l3h+75MuM+6JBimJrw7MUChm5Ii8JlUKOE6h9
X-Received: by 2002:a17:907:868f:b0:c50:5545:b66f with SMTP id a640c23a62f3a-c5096419c32mr273901166b.23.1794585371027;
        Fri, 13 Nov 2026 07:56:11 -0800 (PST)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b40831sm118888166b.42.2026.11.13.07.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:56:10 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-coco@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	jgg@ziepe.ca,
	david.quigley@intel.com,
	lukas@wunner.de,
	ksinyuk@kernel.org,
	rodrigo.vivi@intel.com,
	cedric.xing@intel.com,
	sameo@meta.com,
	drdeeglaze@gmail.com,
	James.Bottomley@HansenPartnership.com,
	aik@amd.com,
	jpiotrowski@nvidia.com,
	qinkun@google.com,
	pgonda@google.com,
	jic23@kernel.org,
	alistair.francis@wdc.com,
	ankita@nvidia.com,
	suzuki.poulose@arm.com,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	elena.reshetova@intel.com,
	dave.hansen@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	peter.fang@intel.com,
	jarkko@kernel.org,
	zohar@linux.ibm.com,
	yeoreum.yun@arm.com,
	aneesh.kumar@kernel.org,
	dave.jiang@intel.com,
	nik.borisov@suse.com,
	sergii.dmytruk@3mdeb.com
Subject: [PATCH RFC v2 12/15] ctlv: Add character device nodes
Date: Fri, 13 Nov 2026 16:55:11 +0100
Message-ID: <20261113155515.2510194-13-jiri@resnulli.us>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113155515.2510194-1-jiri@resnulli.us>
References: <20261113155515.2510194-1-jiri@resnulli.us>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Give a subsystem's device a node of the subsystem's own class, whose
file operations are the CTLV ones. The subsystem registers the class
with CTLV, which takes its device numbers, and embeds a struct
ctlv_device beside the instance.

Assisted-by: Cursor: GPT-5.6 Sol
Assisted-by: Cursor: Claude Opus 5.5
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
RFC->RFCv2:
- split out of the device and operation dispatch patch
- made a library each subsystem's class builds its nodes with, and
  dropped the ctlv class
---
 include/linux/ctlv_device.h |  57 ++++++++++++
 lib/ctlv/Makefile           |   2 +-
 lib/ctlv/core.c             |  17 ++++
 lib/ctlv/device.c           | 179 ++++++++++++++++++++++++++++++++++++
 lib/ctlv/internal.h         |   2 +
 5 files changed, 256 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/ctlv_device.h
 create mode 100644 lib/ctlv/device.c

diff --git a/include/linux/ctlv_device.h b/include/linux/ctlv_device.h
new file mode 100644
index 000000000000..9ff10ce7368f
--- /dev/null
+++ b/include/linux/ctlv_device.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES
+ *
+ * Character device nodes of CTLV instances, in a subsystem's own class.
+ */
+#ifndef _LINUX_CTLV_DEVICE_H
+#define _LINUX_CTLV_DEVICE_H
+
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/idr.h>
+#include <linux/types.h>
+
+struct ctlv;
+struct module;
+
+/**
+ * struct ctlv_device_class - The class of a subsystem's nodes.
+ * @class: the class, whose dev_release frees a node's structure; CTLV sets
+ *	its dev_uevent
+ * @max_devices: how many nodes the class may have at once
+ */
+struct ctlv_device_class {
+	struct class class;
+	unsigned int max_devices;
+	/* private: */
+	struct module *owner;
+	dev_t devt;
+	struct ida ids;
+};
+
+/**
+ * struct ctlv_device - The node of one instance.
+ * @dev: the node's device, named for its class and a number of its own
+ *
+ * Embedded beside the instance in the subsystem's device structure.
+ */
+struct ctlv_device {
+	struct device dev;
+	/* private: */
+	struct cdev cdev;
+	struct ctlv *ctlv;
+	struct ctlv_device_class *cls;
+};
+
+int __ctlv_device_class_register(struct ctlv_device_class *cls, struct module *owner);
+#define ctlv_device_class_register(cls) __ctlv_device_class_register(cls, THIS_MODULE)
+void ctlv_device_class_unregister(struct ctlv_device_class *cls);
+
+int ctlv_device_init(struct ctlv_device *ctlvdev, struct ctlv_device_class *cls,
+		     struct device *parent, struct ctlv *ctlv);
+void ctlv_device_fini(struct ctlv_device *ctlvdev);
+int ctlv_device_add(struct ctlv_device *ctlvdev);
+void ctlv_device_del(struct ctlv_device *ctlvdev);
+
+#endif /* _LINUX_CTLV_DEVICE_H */
diff --git a/lib/ctlv/Makefile b/lib/ctlv/Makefile
index 73acdbdf387d..e783ad450c12 100644
--- a/lib/ctlv/Makefile
+++ b/lib/ctlv/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CTLV) += ctlv.o
 
-ctlv-y += blob.o blob_desc.o builder.o core.o introspection.o \
+ctlv-y += blob.o blob_desc.o builder.o core.o device.o introspection.o \
 	  message.o schema.o ctlv_gen.o
diff --git a/lib/ctlv/core.c b/lib/ctlv/core.c
index 605f191de77b..eb493104da62 100644
--- a/lib/ctlv/core.c
+++ b/lib/ctlv/core.c
@@ -1034,6 +1034,23 @@ static int ctlv_uevent_check(const struct ctlv_family *family)
 	return ret;
 }
 
+/**
+ * ctlv_uevent - Add the family variables to a device uevent.
+ * @ctlv: instance
+ * @env: uevent environment
+ *
+ * Return: 0, or a negative error.
+ */
+int ctlv_uevent(const struct ctlv *ctlv, struct kobj_uevent_env *env)
+{
+	/* Read unlocked: a uevent may be asked for under the registration lock. */
+	const struct ctlv_family *family = READ_ONCE(ctlv->family);
+
+	if (!family)
+		return 0;
+	return ctlv_uevent_families(env, family);
+}
+
 /**
  * ctlv_init - Prepare an embedded instance for one family.
  * @ctlv: zeroed instance
diff --git a/lib/ctlv/device.c b/lib/ctlv/device.c
new file mode 100644
index 000000000000..b761739e5442
--- /dev/null
+++ b/lib/ctlv/device.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES
+ *
+ * Character device nodes of CTLV instances.
+ */
+#include <linux/bug.h>
+#include <linux/cdev.h>
+#include <linux/cleanup.h>
+#include <linux/container_of.h>
+#include <linux/ctlv.h>
+#include <linux/ctlv_device.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/idr.h>
+#include <linux/kdev_t.h>
+#include <linux/module.h>
+#include <linux/rwsem.h>
+
+#include "internal.h"
+
+static int ctlv_device_open(struct inode *inode, struct file *filp)
+{
+	struct ctlv_device *ctlvdev = container_of(inode->i_cdev, struct ctlv_device, cdev);
+	struct ctlv_file *cfile;
+
+	cfile = ctlv_file_open(ctlvdev->ctlv, filp);
+	if (IS_ERR(cfile))
+		return PTR_ERR(cfile);
+	filp->private_data = cfile;
+	return 0;
+}
+
+static int ctlv_device_release(struct inode *inode, struct file *filp)
+{
+	ctlv_file_close(filp->private_data);
+	return 0;
+}
+
+static long ctlv_device_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	return ctlv_file_ioctl(filp->private_data, cmd, arg);
+}
+
+static const struct file_operations ctlv_device_operations = {
+	.owner = THIS_MODULE,
+	.open = ctlv_device_open,
+	.release = ctlv_device_release,
+	.unlocked_ioctl = ctlv_device_ioctl,
+	/* Every ioctl field is fixed width, so one entry point serves both. */
+	.compat_ioctl = compat_ptr_ioctl,
+};
+
+static int ctlv_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
+{
+	const struct ctlv_device *ctlvdev = container_of_const(dev, struct ctlv_device, dev);
+
+	return ctlv_uevent(ctlvdev->ctlv, env);
+}
+
+/**
+ * __ctlv_device_class_register - Register a class of nodes.
+ * @cls: class, its name, dev_release and max_devices set
+ * @owner: module of the dev_release, held while a node is open
+ *
+ * Called as ctlv_device_class_register(), which passes the calling module.
+ *
+ * Return: 0, or a negative error.
+ */
+int __ctlv_device_class_register(struct ctlv_device_class *cls, struct module *owner)
+{
+	int ret;
+
+	if (WARN_ON(!cls->max_devices))
+		return -EINVAL;
+	ret = alloc_chrdev_region(&cls->devt, 0, cls->max_devices, cls->class.name);
+	if (ret)
+		return ret;
+	cls->owner = owner;
+	cls->class.dev_uevent = ctlv_device_uevent;
+	ida_init(&cls->ids);
+	ret = class_register(&cls->class);
+	if (ret)
+		unregister_chrdev_region(cls->devt, cls->max_devices);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(__ctlv_device_class_register, "CTLV");
+
+/**
+ * ctlv_device_class_unregister - Unregister a class of nodes.
+ * @cls: class whose nodes are all released
+ */
+void ctlv_device_class_unregister(struct ctlv_device_class *cls)
+{
+	class_unregister(&cls->class);
+	unregister_chrdev_region(cls->devt, cls->max_devices);
+	ida_destroy(&cls->ids);
+}
+EXPORT_SYMBOL_NS_GPL(ctlv_device_class_unregister, "CTLV");
+
+/**
+ * ctlv_device_init - Prepare the node of an instance.
+ * @ctlvdev: zeroed node, in the structure the class's dev_release frees
+ * @cls: registered class
+ * @parent: parent device, or NULL
+ * @ctlv: instance, for ctlv_init() with the node's device
+ *
+ * From here on, put_device() unwinds, whether or not this succeeds.
+ *
+ * Return: 0, or a negative error.
+ */
+int ctlv_device_init(struct ctlv_device *ctlvdev, struct ctlv_device_class *cls,
+		     struct device *parent, struct ctlv *ctlv)
+{
+	int devnum;
+
+	device_initialize(&ctlvdev->dev);
+	ctlvdev->dev.class = &cls->class;
+	ctlvdev->dev.parent = parent;
+	ctlvdev->ctlv = ctlv;
+	cdev_init(&ctlvdev->cdev, &ctlv_device_operations);
+	ctlvdev->cdev.owner = cls->owner;
+
+	devnum = ida_alloc_max(&cls->ids, cls->max_devices - 1, GFP_KERNEL);
+	if (devnum < 0)
+		return devnum;
+	ctlvdev->cls = cls;
+	ctlvdev->dev.devt = MKDEV(MAJOR(cls->devt), devnum);
+	return dev_set_name(&ctlvdev->dev, "%s%d", cls->class.name, devnum);
+}
+EXPORT_SYMBOL_NS_GPL(ctlv_device_init, "CTLV");
+
+/**
+ * ctlv_device_fini - Free the node's number.
+ * @ctlvdev: node
+ *
+ * For the class's dev_release, before it frees the node.
+ */
+void ctlv_device_fini(struct ctlv_device *ctlvdev)
+{
+	if (ctlvdev->cls)
+		ida_free(&ctlvdev->cls->ids, MINOR(ctlvdev->dev.devt));
+}
+EXPORT_SYMBOL_NS_GPL(ctlv_device_fini, "CTLV");
+
+/**
+ * ctlv_device_add - Add the node.
+ * @ctlvdev: node, whose instance was initialized with its device and published
+ *
+ * The node may be opened as soon as it appears, so its instance is published
+ * before and unpublished after ctlv_device_del().
+ *
+ * Return: 0, or a negative error.
+ */
+int ctlv_device_add(struct ctlv_device *ctlvdev)
+{
+	struct ctlv *ctlv = ctlvdev->ctlv;
+	bool published;
+
+	scoped_guard(rwsem_read, &ctlv->registration_lock)
+		published = ctlv->registered;
+	if (WARN_ON(ctlv->dev != &ctlvdev->dev || !published))
+		return -EINVAL;
+	return cdev_device_add(&ctlvdev->cdev, &ctlvdev->dev);
+}
+EXPORT_SYMBOL_NS_GPL(ctlv_device_add, "CTLV");
+
+/**
+ * ctlv_device_del - Remove the node.
+ * @ctlvdev: added node
+ *
+ * A file still open keeps the node's device until it is closed.
+ */
+void ctlv_device_del(struct ctlv_device *ctlvdev)
+{
+	cdev_device_del(&ctlvdev->cdev, &ctlvdev->dev);
+}
+EXPORT_SYMBOL_NS_GPL(ctlv_device_del, "CTLV");
diff --git a/lib/ctlv/internal.h b/lib/ctlv/internal.h
index 2e1e36799a17..8fb5f0abdc47 100644
--- a/lib/ctlv/internal.h
+++ b/lib/ctlv/internal.h
@@ -23,6 +23,7 @@
 #define CTLV_ASSERT(cond) BUILD_BUG_ON_INVALID(cond)
 #endif
 
+struct kobj_uevent_env;
 struct task_struct;
 
 #define CTLV_ERROR_MESSAGE_LEN 256
@@ -81,5 +82,6 @@ struct ctlv_op_ctx {
 };
 
 struct ctlv_op_entry *ctlv_op_find(struct ctlv *ctlv, u64 op_id);
+int ctlv_uevent(const struct ctlv *ctlv, struct kobj_uevent_env *env);
 
 #endif /* _CTLV_INTERNAL_H */
-- 
2.56.0

