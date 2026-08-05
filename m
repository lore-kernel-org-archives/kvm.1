Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC468431A23;
	Wed,  5 Aug 2026 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927849; cv=none; b=mXcwUZstLNFHV1kyeaDdDwMBjsXz325feyEctcuiAo7y9yU8zlhE8w56u2Z0zwv0ukH5INlvB0B+ruhT2XWGONjL6uVpWGI1rXfAzuzA/3W0VHaZNySrTr7Ji4twBHT3DvvVhk8pK1qRrcA6LIObXpmO/VX/lhw7KFDNfercY7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927849; c=relaxed/simple;
	bh=EKXx8RcCnMkNFoQA8erndqmfSfcs71xAzEYOPAn++tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlbUfTDx5IC9ANEXXOJ2dB5mpynwtkXFrMmwcszrypp3Kz46QddBmx4al90kXQlL8W6hk2CjiVl3tC0GS/Ipbm7jm/hLGIp25iYYpihlfbKnx4isj3096cv77nwxoQTuyTlO1cgojPrGD38kzkU9McGvjIcCM2FsVGrT6S7arA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aWeEDzYA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aWeEDzYA"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id CDE9920B716A;
	Wed,  5 Aug 2026 04:03:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CDE9920B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927826;
	bh=LCof4AolZjngCYSNX1ZFL4j1gUXtjHh6tmKkZT1PHOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aWeEDzYA7b/eKCiXp9CVR2QoUQ8AyAIWEN8zIZTCTYPe7sFo7aC7CbPTYwK+qa7kv
	 vWBY9ZtR260rTRQvgloQX7O0vM9T6kh9DcKj+Wr/7K4ZQHI/XVXjcfF+BGJn113Wv1
	 WfhGBxqfIoxMlZ1rSaSOg9Z5ly4YoBaR3oRojBFA=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 29/42] init/vm_planes: set up planes from rootfs_initcall and load ELF payloads
Date: Wed,  5 Aug 2026 04:03:11 -0700
Message-ID: <20260805110324.25067-30-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110324.25067-1-snambakam@linux.microsoft.com>
References: <20260805110324.25067-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move plane setup out of start_kernel()/kernel_init_freeable() and into a
self-registering rootfs_initcall. Link vm_planes.o after initramfs.o so
populate_rootfs() has unpacked the initramfs (which carries the
config-vm-planes file and the plane kernels) before arch_init_vm_planes()
runs. arch_init_vm_planes() becomes static and no longer needs a
declaration in vm_planes.h.

Also load the plane kernels as ELF payloads, copying loadable segments
into the reserved plane memory and zeroing the BSS, replacing the
early_ioremap path with a plain io.h mapping.

Signed-off-by: Sriram Nambakam <snambakam@linux.microsoft.com>
---
 include/linux/vm_planes.h |  1 -
 init/Kconfig              |  5 ++-
 init/Makefile             |  5 ++-
 init/main.c               |  4 --
 init/vm_planes.c          | 88 +++++++++++++++++++++------------------
 5 files changed, 54 insertions(+), 49 deletions(-)

diff --git a/include/linux/vm_planes.h b/include/linux/vm_planes.h
index 1130557cf5aa..e33fa03d1d4a 100644
--- a/include/linux/vm_planes.h
+++ b/include/linux/vm_planes.h
@@ -25,7 +25,6 @@ struct vm_plane_config {
 	char cmdline[VM_PLANE_CMDLINE_MAX];
 };
 
-void __init arch_init_vm_planes(void);
 int __init load_vm_plane_kernels(unsigned int plane_count,
 				 struct vm_plane_config *plane_cfg);
 
diff --git a/init/Kconfig b/init/Kconfig
index 23d9cca334ba..5d76fe852376 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1720,8 +1720,9 @@ config VM_PLANES
 	  Enable hypervisor enabled multi-kernel support.
 
 	  This allows processing the kernel command-line parameter
-	  "enable-vm-planes" and, when requested, calling
-	  arch_init_vm_planes() during start_kernel().
+	  "enable-vm-planes" and, when requested, setting up the configured
+	  planes from a rootfs_initcall (after the initramfs is populated and
+	  before device drivers and late_initcalls run).
 
 	  The initrd config-vm-planes file is expected to provide per-plane
 	  entries for PLANE_<id>_KERNEL, PLANE_<id>_LOAD_OFFSET, and
diff --git a/init/Makefile b/init/Makefile
index 113133c8cdd7..f6ac312f1e98 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -6,12 +6,15 @@
 ccflags-y := -fno-function-sections -fno-data-sections
 
 obj-y                          := main.o version.o mounts.o
-obj-y                          += vm_planes.o
 ifneq ($(CONFIG_BLK_DEV_INITRD),y)
 obj-y                          += noinitramfs.o
 else
 obj-$(CONFIG_BLK_DEV_INITRD)   += initramfs.o
 endif
+# vm_planes.o must link AFTER initramfs.o so that, at rootfs_initcall level,
+# populate_rootfs() (which unpacks the initramfs) runs before
+# arch_init_vm_planes() reads the plane config and kernels from the rootfs.
+obj-y                          += vm_planes.o
 obj-$(CONFIG_GENERIC_CALIBRATE_DELAY) += calibrate.o
 obj-$(CONFIG_INITRAMFS_TEST)   += initramfs_test.o
 
diff --git a/init/main.c b/init/main.c
index 1c779f6d60cc..be188e67c556 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1663,10 +1663,6 @@ static noinline void __init kernel_init_freeable(void)
 	wait_for_initramfs();
 	console_on_rootfs();
 
-#ifdef CONFIG_VM_PLANES
-	arch_init_vm_planes();
-#endif
-
 	/*
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work
diff --git a/init/vm_planes.c b/init/vm_planes.c
index 10c7facdb1af..64d5ff19a736 100644
--- a/init/vm_planes.c
+++ b/init/vm_planes.c
@@ -12,9 +12,9 @@
 #include <linux/vm_planes.h>
 #include <linux/elf.h>
 #include <linux/mm.h>
+#include <linux/io.h>
 #include <asm/cpu.h>
 #include <asm/kvm_para.h>
-#include <asm-generic/early_ioremap.h>
 
 #ifdef CONFIG_VM_PLANES
 static bool __initdata enable_vm_planes_requested;
@@ -360,44 +360,29 @@ static int __init vm_planes_get_cfg(unsigned int *plane_count,
 static int __init copy_to_early_mem(phys_addr_t dest, const void *src,
 				    unsigned long size)
 {
-	unsigned long slop, clen;
-	char *p;
-
-	while (size) {
-		slop = offset_in_page(dest);
-		clen = size;
-		if (clen > PAGE_SIZE - slop)
-			clen = PAGE_SIZE - slop;
-		p = early_memremap(dest & PAGE_MASK, clen + slop);
-		if (!p)
-			return -ENOMEM;
-		memcpy(p + slop, src, clen);
-		early_memunmap(p, clen + slop);
-		dest += clen;
-		src += clen;
-		size -= clen;
-	}
+	void *p;
+
+	if (!size)
+		return 0;
+	p = memremap(dest, size, MEMREMAP_WB);
+	if (!p)
+		return -ENOMEM;
+	memcpy(p, src, size);
+	memunmap(p);
 	return 0;
 }
 
 static int __init zero_early_mem(phys_addr_t dest, unsigned long size)
 {
-	unsigned long slop, clen;
-	char *p;
-
-	while (size) {
-		slop = offset_in_page(dest);
-		clen = size;
-		if (clen > PAGE_SIZE - slop)
-			clen = PAGE_SIZE - slop;
-		p = early_memremap(dest & PAGE_MASK, clen + slop);
-		if (!p)
-			return -ENOMEM;
-		memset(p + slop, 0, clen);
-		early_memunmap(p, clen + slop);
-		dest += clen;
-		size -= clen;
-	}
+	void *p;
+
+	if (!size)
+		return 0;
+	p = memremap(dest, size, MEMREMAP_WB);
+	if (!p)
+		return -ENOMEM;
+	memset(p, 0, size);
+	memunmap(p);
 	return 0;
 }
 
@@ -616,23 +601,41 @@ int __init __weak alloc_vm_planes(unsigned int plane_count,
 int __init __weak activate_vm_planes(unsigned int plane_count,
 				      struct vm_plane_config *plane_cfg) { return -ENOSYS; }
 
-void __init arch_init_vm_planes(void)
+/*
+ * Set up VM planes during boot.
+ *
+ * This must run after the initramfs is populated (it reads the plane config
+ * and plane kernels from the rootfs) and, crucially, *before* any consumer
+ * that issues a plane switch -- in particular the VBS backend init/seal, and
+ * before any device driver, module, or userspace can touch a plane.  A
+ * rootfs_initcall satisfies all of these: it runs immediately after
+ * populate_rootfs() (initramfs ready) and before every device_initcall and
+ * late_initcall.  Because init/ links before security/, this also runs before
+ * the VBS probe/HEKI rootfs_initcalls, so the secure plane vcpu exists by the
+ * time the first VTL call is issued.
+ */
+static int __init arch_init_vm_planes(void)
 {
 	unsigned int plane_count = VM_PLANES_DEFAULT_COUNT;
 	struct vm_plane_config *plane_cfg;
 	int ret;
 
 	if (!enable_vm_planes_requested)
-		return;
+		return 0;
 
-	if (!kvm_para_available())
-		return;
+	/* Ensure any asynchronous initramfs unpacking has completed. */
+	wait_for_initramfs();
+
+	if (!kvm_para_available()) {
+		pr_info("vm_planes: KVM paravirt unavailable, skipping plane setup\n");
+		return 0;
+	}
 
 	ret = vm_planes_get_cfg(&plane_count, &plane_cfg);
 	if (ret) {
 		pr_warn("vm_planes: failed to parse %s: %d\n",
 			VM_PLANES_CONFIG_FILE, ret);
-		return;
+		return 0;
 	}
 
 	pr_info("vm_planes: enabling %u planes (ids 0..%u)\n",
@@ -641,18 +644,21 @@ void __init arch_init_vm_planes(void)
 	ret = alloc_vm_planes(plane_count, plane_cfg);
 	if (ret) {
 		pr_err("vm_planes: failed to allocate planes: %d\n", ret);
-		return;
+		return 0;
 	}
 
 	ret = load_vm_plane_kernels(plane_count, plane_cfg);
 	if (ret) {
 		pr_err("vm_planes: failed to load plane kernels: %d\n", ret);
-		return;
+		return 0;
 	}
 
 	ret = activate_vm_planes(plane_count, plane_cfg);
 	if (ret)
 		pr_err("vm_planes: failed to activate planes: %d\n", ret);
+
+	return 0;
 }
+rootfs_initcall(arch_init_vm_planes);
 
 #endif /* CONFIG_VM_PLANES */
-- 
2.55.0

