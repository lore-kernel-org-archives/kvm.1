Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5571F395D86;
	Tue, 11 Aug 2026 01:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786413187; cv=none; b=c1pzupoyuzOhK3tya7osbcAqQNLNKzgLYdKFjJKlxq1joWVy0Ul1zOUhirvwgMlOWd7VWW88vSKcWNhUDL39KhZdi0PpNe5HC3SMurnulPIDrYyQuSxOQwJ5qvpprfa1x7RDx+PGkyMLdTMUamXJJZ4twcW5XJW3U81vxNgEgu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786413187; c=relaxed/simple;
	bh=6OVOtGTA+sjya6LwVxpYHYQdTEbProZZVAaovAUfrJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XptKdz086hjQtTBT0afikBVYqi/Q7ZiMvHeWePQ1kscqy0t4DlEaNS7az/hhrltrWtoNvWzd3MaRAKRhtvLpUL9shjHR5Wc0pMmcAb8pQwaYhoTv0OEFJPS0VRhvmGu7vBgBqzPibCjbq2i0cj53J/ihh6vKfPNB1PaRXgFW4No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lp5/9gbV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lp5/9gbV"
Received: from fedora (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9A0A620B710C;
	Mon, 10 Aug 2026 18:52:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9A0A620B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786413160;
	bh=G0+h7b+JA2RKfzrEGJ1icedRhM5cCmsBT1fq7WO/dkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lp5/9gbVoqN2af8dk6ywRu1hkAdxc7PhnZNWZmMCj4ucURce+AD/GavqMG+WgiZQA
	 cQ88AiSwsz65QRn4XdrZGwsgILarNK9qehxXzsFE0EfJFxFxeReT7OKnIqPJ5DJX5/
	 UBXoYnfMEX2owMGXQp+uqYmS/zpVtRCp6w7c5B3s=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 6/8] vm_planes: add hypervisor-assisted plane bootstrap
Date: Mon, 10 Aug 2026 18:52:41 -0700
Message-ID: <20260811015243.188486-7-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811015243.188486-1-snambakam@linux.microsoft.com>
References: <20260811015243.188486-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the guest-side VM-planes bootstrap under CONFIG_VM_PLANES.  It reads
the per-plane configuration (config-vm-planes) and the plane kernel images
from the initramfs, allocates plane memory and creates the planes via the
KVM_HC_VM_PLANES_CONFIG / KVM_HC_VM_PLANES_ACTIVATE paravirt hypercalls,
and loads RAW or ELF plane kernels into plane memory.

The orchestration is exposed as vm_planes_bootstrap() so a consumer can
drive it at the right point in boot; the x86 hypercall wrappers
alloc_vm_planes() / activate_vm_planes() live in cpu/common.c.

Only software planes are supported; there is no memory protection or
sealing here.
---
 arch/x86/kernel/cpu/common.c |  64 ++++
 include/linux/vm_planes.h    |  46 +++
 init/Kconfig                 |  18 +
 init/Makefile                |   4 +
 init/vm_planes.c             | 636 +++++++++++++++++++++++++++++++++++
 5 files changed, 768 insertions(+)
 create mode 100644 include/linux/vm_planes.h
 create mode 100644 init/vm_planes.c

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a3df21d26460..2489af105c18 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -28,8 +28,11 @@
 #include <linux/stackprotector.h>
 #include <linux/utsname.h>
 #include <linux/efi.h>
+#include <linux/kvm_para.h>
+#include <linux/vm_planes.h>
 
 #include <asm/alternative.h>
+#include <asm/kvm_para.h>
 #include <asm/cmdline.h>
 #include <asm/cpuid/api.h>
 #include <asm/perf_event.h>
@@ -2664,3 +2667,64 @@ void __init arch_cpu_finalize_init(void)
 	 */
 	mem_encrypt_init();
 }
+
+#ifdef CONFIG_VM_PLANES
+int __init alloc_vm_planes(unsigned int plane_count,
+			   struct vm_plane_config *plane_cfg)
+{
+	phys_addr_t phys;
+	long ret;
+
+	if (!plane_count || !plane_cfg)
+		return -EINVAL;
+
+	if (!kvm_para_available()) {
+		pr_warn("vm_planes: hypercall interface unavailable\n");
+		return -ENODEV;
+	}
+
+	phys = virt_to_phys((void *)plane_cfg);
+
+	if (sizeof(unsigned long) < sizeof(phys_addr_t) && phys > ULONG_MAX) {
+		pr_warn("vm_planes: shared config address exceeds hypercall register width\n");
+		return -EOVERFLOW;
+	}
+
+	ret = kvm_hypercall2(KVM_HC_VM_PLANES_CONFIG,
+			     (unsigned long)phys,
+			     plane_count);
+	if (ret < 0) {
+		pr_warn("vm_planes: hypercall failed: %ld\n", ret);
+		return (int)ret;
+	}
+
+	return 0;
+}
+
+int __init activate_vm_planes(unsigned int plane_count,
+			      struct vm_plane_config *plane_cfg)
+{
+	phys_addr_t phys;
+	long ret;
+
+	if (!plane_count || !plane_cfg)
+		return -EINVAL;
+
+	if (!kvm_para_available()) {
+		pr_warn("vm_planes: hypercall interface unavailable\n");
+		return -ENODEV;
+	}
+
+	phys = virt_to_phys((void *)plane_cfg);
+
+	ret = kvm_hypercall2(KVM_HC_VM_PLANES_ACTIVATE,
+			     (unsigned long)phys,
+			     plane_count);
+	if (ret < 0) {
+		pr_warn("vm_planes: activate hypercall failed: %ld\n", ret);
+		return (int)ret;
+	}
+
+	return 0;
+}
+#endif /* CONFIG_VM_PLANES */
diff --git a/include/linux/vm_planes.h b/include/linux/vm_planes.h
new file mode 100644
index 000000000000..e76cbfd99c6d
--- /dev/null
+++ b/include/linux/vm_planes.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_VM_PLANES_H
+#define _LINUX_VM_PLANES_H
+
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+
+#ifdef CONFIG_VM_PLANES
+
+#define VM_PLANE_KERNEL_NAME_MAX	128
+#define VM_PLANE_CMDLINE_MAX		512
+
+enum vm_plane_kernel_format {
+	VM_PLANE_KFMT_RAW = 0,
+	VM_PLANE_KFMT_BZIMAGE,
+	VM_PLANE_KFMT_ELF,
+};
+
+struct vm_plane_config {
+	phys_addr_t load_offset;
+	phys_addr_t memory_size;
+	phys_addr_t entry_point;
+	unsigned int kernel_format;
+	char kernel[VM_PLANE_KERNEL_NAME_MAX];
+	char cmdline[VM_PLANE_CMDLINE_MAX];
+};
+
+int __init load_vm_plane_kernels(unsigned int plane_count,
+				 struct vm_plane_config *plane_cfg);
+
+int __init alloc_vm_planes(unsigned int plane_count,
+			   struct vm_plane_config *plane_cfg);
+
+int __init activate_vm_planes(unsigned int plane_count,
+			      struct vm_plane_config *plane_cfg);
+
+int __init vm_planes_bootstrap(void);
+
+#else /* !CONFIG_VM_PLANES */
+
+static inline int vm_planes_bootstrap(void) { return -ENODEV; }
+
+#endif /* CONFIG_VM_PLANES */
+
+#endif /* _LINUX_VM_PLANES_H */
diff --git a/init/Kconfig b/init/Kconfig
index 10f2013b5321..bdb692f38a90 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2259,6 +2259,24 @@ source "kernel/Kconfig.kexec"
 
 source "kernel/liveupdate/Kconfig"
 
+config VM_PLANES
+	bool "Enable VM planes early boot support" if EXPERT
+	depends on KVM_GUEST
+	default n
+	help
+	  Enable hypervisor-assisted multi-kernel (VM planes) support.
+
+	  When enabled, and when the VBS backend requests it, the kernel sets
+	  up the configured planes from the VBS enable path (late_initcall,
+	  after device drivers and before userspace).  The plane configuration
+	  and per-plane kernel images are read from the initramfs.
+
+	  The initrd config-vm-planes file is expected to provide per-plane
+	  entries for PLANE_<id>_KERNEL, PLANE_<id>_LOAD_OFFSET, and
+	  PLANE_<id>_MEMORY_SIZE.
+
+	  If unsure, say N.
+
 endmenu		# General setup
 
 source "arch/Kconfig"
diff --git a/init/Makefile b/init/Makefile
index d6f75d8907e0..100b3fcda37a 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -14,6 +14,10 @@ endif
 obj-$(CONFIG_GENERIC_CALIBRATE_DELAY) += calibrate.o
 obj-$(CONFIG_INITRAMFS_TEST)   += initramfs_test.o
 
+# vm_planes.o must link AFTER initramfs.o so that it reads the plane config
+# and kernels from the populated rootfs.
+obj-$(CONFIG_VM_PLANES)                += vm_planes.o
+
 obj-y                          += init_task.o
 
 mounts-y			:= do_mounts.o
diff --git a/init/vm_planes.c b/init/vm_planes.c
new file mode 100644
index 000000000000..27994e4a915a
--- /dev/null
+++ b/init/vm_planes.c
@@ -0,0 +1,636 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/init.h>
+#include <linux/initrd.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/kstrtox.h>
+#include <linux/string.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/kvm_para.h>
+#include <linux/vm_planes.h>
+#include <linux/elf.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <asm/cpu.h>
+#include <asm/kvm_para.h>
+
+#ifdef CONFIG_VM_PLANES
+
+#define VM_PLANES_CONFIG_FILE		"config-vm-planes"
+#define VM_PLANES_DEFAULT_COUNT		1
+
+struct vm_plane_parse_state {
+	phys_addr_t load_offset;
+	phys_addr_t memory_size;
+	unsigned int kernel_format;
+	char kernel[VM_PLANE_KERNEL_NAME_MAX];
+	char cmdline[VM_PLANE_CMDLINE_MAX];
+};
+
+#define VM_PLANES_UNSET_VALUE	((phys_addr_t)~0)
+
+/*
+ * Read a file from the rootfs into a newly allocated buffer.
+ * Caller must kfree(*out_data) when done.
+ */
+static int __init vm_planes_read_file(const char *path,
+				      void **out_data, loff_t *out_size)
+{
+	struct file *fp;
+	loff_t fsize;
+	void *buf;
+	ssize_t rd;
+
+	fp = filp_open(path, O_RDONLY, 0);
+	if (IS_ERR(fp))
+		return PTR_ERR(fp);
+
+	fsize = i_size_read(file_inode(fp));
+	if (fsize <= 0) {
+		fput(fp);
+		return -ENODATA;
+	}
+
+	buf = kvmalloc(fsize, GFP_KERNEL);
+	if (!buf) {
+		fput(fp);
+		return -ENOMEM;
+	}
+
+	rd = kernel_read(fp, buf, fsize, &(loff_t){0});
+	fput(fp);
+
+	if (rd != fsize) {
+		kvfree(buf);
+		return (rd < 0) ? (int)rd : -EIO;
+	}
+
+	*out_data = buf;
+	*out_size = fsize;
+	return 0;
+}
+
+/* ---- Config file parser (unchanged) ---- */
+
+static int __init parse_plane_count_line(const char *line, size_t len,
+					 unsigned int *plane_count)
+{
+	const char *keys[] = { "PLANE_COUNT=", "CONFIG_PLANE_COUNT=" };
+	unsigned int i;
+
+	while (len && (*line == ' ' || *line == '\t')) {
+		line++;
+		len--;
+	}
+
+	if (!len || *line == '#')
+		return -ENOENT;
+
+	for (i = 0; i < ARRAY_SIZE(keys); i++) {
+		size_t key_len = strlen(keys[i]);
+		size_t val_len = 0;
+		char tmp[32];
+
+		if (len <= key_len || strncmp(line, keys[i], key_len))
+			continue;
+
+		line += key_len;
+		len -= key_len;
+		while (val_len < len && line[val_len] != ' ' &&
+		       line[val_len] != '\t' && line[val_len] != '#')
+			val_len++;
+
+		if (!val_len || val_len >= sizeof(tmp))
+			return -EINVAL;
+
+		memcpy(tmp, line, val_len);
+		tmp[val_len] = '\0';
+
+		if (kstrtouint(tmp, 0, plane_count))
+			return -EINVAL;
+		if (!*plane_count)
+			return -EINVAL;
+
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+static int __init parse_plane_count_kconfig(const char *buf, size_t len,
+					    unsigned int *plane_count)
+{
+	const char *p = buf;
+	const char *end = buf + len;
+
+	while (p < end) {
+		const char *eol = memchr(p, '\n', end - p);
+		size_t line_len = eol ? (size_t)(eol - p) : (size_t)(end - p);
+		int ret = parse_plane_count_line(p, line_len, plane_count);
+
+		if (!ret)
+			return 0;
+
+		p += line_len;
+		if (p < end && *p == '\n')
+			p++;
+	}
+
+	return -ENOENT;
+}
+
+static int __init parse_plane_cfg_line(const char *line, size_t len,
+				       unsigned int plane_count,
+				       struct vm_plane_config *plane_cfg,
+				       struct vm_plane_parse_state *state)
+{
+	char tmp[VM_PLANE_CMDLINE_MAX + 64];
+	char *p, *key, *val;
+	unsigned int plane_id;
+	u64 parsed_u64;
+	phys_addr_t parsed;
+
+	if (len >= sizeof(tmp))
+		return -E2BIG;
+
+	memcpy(tmp, line, len);
+	tmp[len] = '\0';
+
+	p = strim(tmp);
+	if (!*p || *p == '#')
+		return -ENOENT;
+
+	val = strchr(p, '#');
+	if (val)
+		*val = '\0';
+	p = strim(p);
+	if (!*p)
+		return -ENOENT;
+
+	if (!strncmp(p, "CONFIG_", 7))
+		p += 7;
+
+	if (strncmp(p, "PLANE_", 6))
+		return -ENOENT;
+	p += 6;
+
+	key = strchr(p, '_');
+	if (!key)
+		return -ENOENT;
+	*key++ = '\0';
+
+	if (kstrtouint(p, 10, &plane_id) || plane_id >= plane_count)
+		return -EINVAL;
+
+	val = strchr(key, '=');
+	if (!val)
+		return -EINVAL;
+	*val++ = '\0';
+
+	key = strim(key);
+	val = strim(val);
+	if (!*val)
+		return -EINVAL;
+
+	if (!strcmp(key, "KERNEL")) {
+		size_t val_len = strlen(val);
+
+		if (val[0] == '"') {
+			if (val_len < 2 || val[val_len - 1] != '"')
+				return -EINVAL;
+			val[val_len - 1] = '\0';
+			val++;
+			val = strim(val);
+		}
+
+		if (!*val)
+			return -EINVAL;
+
+		if (strscpy(plane_cfg[plane_id].kernel, val,
+			    sizeof(plane_cfg[plane_id].kernel)) < 0)
+			return -EINVAL;
+
+		strscpy(state[plane_id].kernel, val,
+			sizeof(state[plane_id].kernel));
+		return 0;
+	}
+
+	if (!strcmp(key, "KERNEL_FORMAT")) {
+		unsigned int fmt;
+
+		if (!strcasecmp(val, "raw"))
+			fmt = VM_PLANE_KFMT_RAW;
+		else if (!strcasecmp(val, "bzimage"))
+			fmt = VM_PLANE_KFMT_BZIMAGE;
+		else if (!strcasecmp(val, "elf"))
+			fmt = VM_PLANE_KFMT_ELF;
+		else
+			return -EINVAL;
+
+		plane_cfg[plane_id].kernel_format = fmt;
+		state[plane_id].kernel_format = fmt;
+		return 0;
+	}
+
+	if (!strcmp(key, "CMDLINE")) {
+		size_t val_len = strlen(val);
+
+		if (val_len >= 2 && val[0] == '"') {
+			if (val[val_len - 1] != '"')
+				return -EINVAL;
+			val[val_len - 1] = '\0';
+			val++;
+		}
+
+		if (strscpy(plane_cfg[plane_id].cmdline, val,
+			    sizeof(plane_cfg[plane_id].cmdline)) < 0)
+			return -E2BIG;
+
+		strscpy(state[plane_id].cmdline, val,
+			sizeof(state[plane_id].cmdline));
+		return 0;
+	}
+
+	if (kstrtou64(val, 0, &parsed_u64))
+		return -EINVAL;
+
+	if (parsed_u64 > (u64)VM_PLANES_UNSET_VALUE)
+		return -ERANGE;
+
+	parsed = (phys_addr_t)parsed_u64;
+
+	if (!strcmp(key, "LOAD_OFFSET")) {
+		plane_cfg[plane_id].load_offset = parsed;
+		state[plane_id].load_offset = parsed;
+		return 0;
+	}
+
+	if (!strcmp(key, "MEMORY_SIZE")) {
+		plane_cfg[plane_id].memory_size = parsed;
+		state[plane_id].memory_size = parsed;
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+static int __init parse_vm_planes_kconfig(const char *buf, size_t len,
+				  unsigned int *plane_count,
+				  struct vm_plane_config **plane_cfg)
+{
+	const char *p = buf;
+	const char *end = buf + len;
+	struct vm_plane_parse_state *state;
+	unsigned int i;
+	int ret;
+
+	ret = parse_plane_count_kconfig(buf, len, plane_count);
+	if (ret)
+		return ret;
+
+	if (*plane_count > UINT_MAX / sizeof(**plane_cfg))
+		return -E2BIG;
+
+	*plane_cfg = kzalloc(*plane_count * sizeof(**plane_cfg), GFP_KERNEL);
+	if (!*plane_cfg)
+		return -ENOMEM;
+
+	state = kzalloc(*plane_count * sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	for (i = 0; i < *plane_count; i++) {
+		state[i].load_offset = VM_PLANES_UNSET_VALUE;
+		state[i].memory_size = VM_PLANES_UNSET_VALUE;
+		state[i].kernel[0] = '\0';
+		state[i].cmdline[0] = '\0';
+	}
+
+	while (p < end) {
+		const char *eol = memchr(p, '\n', end - p);
+		size_t line_len = eol ? (size_t)(eol - p) : (size_t)(end - p);
+
+		ret = parse_plane_cfg_line(p, line_len, *plane_count,
+					   *plane_cfg, state);
+		if (ret && ret != -ENOENT)
+			return ret;
+
+		p += line_len;
+		if (p < end && *p == '\n')
+			p++;
+	}
+
+	for (i = 1; i < *plane_count; i++) {
+		if (state[i].load_offset == VM_PLANES_UNSET_VALUE ||
+		    state[i].memory_size == VM_PLANES_UNSET_VALUE ||
+		    !state[i].kernel[0])
+			return -EINVAL;
+	}
+
+	kfree(state);
+	return 0;
+}
+
+/* ---- Config loading via VFS ---- */
+
+static int __init vm_planes_get_cfg(unsigned int *plane_count,
+				    struct vm_plane_config **plane_cfg)
+{
+	void *buf;
+	loff_t size;
+	int ret;
+
+	ret = vm_planes_read_file("/" VM_PLANES_CONFIG_FILE, &buf, &size);
+	if (ret) {
+		pr_err("vm_planes: cannot read /%s: %d\n",
+		       VM_PLANES_CONFIG_FILE, ret);
+		return ret;
+	}
+
+	ret = parse_vm_planes_kconfig(buf, (size_t)size, plane_count, plane_cfg);
+	kvfree(buf);
+	return ret;
+}
+
+/* ---- Kernel loading ---- */
+
+static int __init copy_to_early_mem(phys_addr_t dest, const void *src,
+				    unsigned long size)
+{
+	void *p;
+
+	if (!size)
+		return 0;
+	p = memremap(dest, size, MEMREMAP_WB);
+	if (!p)
+		return -ENOMEM;
+	memcpy(p, src, size);
+	memunmap(p);
+	return 0;
+}
+
+static int __init zero_early_mem(phys_addr_t dest, unsigned long size)
+{
+	void *p;
+
+	if (!size)
+		return 0;
+	p = memremap(dest, size, MEMREMAP_WB);
+	if (!p)
+		return -ENOMEM;
+	memset(p, 0, size);
+	memunmap(p);
+	return 0;
+}
+
+static int __init load_plane_kernel_elf(const u8 *data, u32 size,
+					struct vm_plane_config *cfg)
+{
+	const Elf64_Ehdr *ehdr;
+	const Elf64_Phdr *phdr;
+	unsigned int i;
+	int ret;
+
+	if (size < sizeof(*ehdr)) {
+		pr_err("vm_planes: ELF image too small (%u bytes)\n", size);
+		return -EINVAL;
+	}
+
+	ehdr = (const Elf64_Ehdr *)data;
+
+	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG)) {
+		pr_err("vm_planes: not a valid ELF image\n");
+		return -EINVAL;
+	}
+
+	if (ehdr->e_ident[EI_CLASS] != ELFCLASS64 ||
+	    ehdr->e_ident[EI_DATA] != ELFDATA2LSB ||
+	    ehdr->e_type != ET_EXEC ||
+	    ehdr->e_machine != EM_X86_64) {
+		pr_err("vm_planes: unsupported ELF format (need x86_64 ET_EXEC LE)\n");
+		return -EINVAL;
+	}
+
+	if (!ehdr->e_phnum || ehdr->e_phentsize != sizeof(Elf64_Phdr)) {
+		pr_err("vm_planes: invalid ELF program headers\n");
+		return -EINVAL;
+	}
+
+	if (ehdr->e_phoff + (u64)ehdr->e_phnum * sizeof(Elf64_Phdr) > size) {
+		pr_err("vm_planes: ELF program headers extend beyond file\n");
+		return -EINVAL;
+	}
+
+	phdr = (const Elf64_Phdr *)(data + ehdr->e_phoff);
+
+	for (i = 0; i < ehdr->e_phnum; i++, phdr++) {
+		phys_addr_t dest;
+		u64 bss_size;
+
+		if (phdr->p_type != PT_LOAD)
+			continue;
+
+		if (!phdr->p_memsz)
+			continue;
+
+		/*
+		 * Bias the ELF physical address by load_offset so that the
+		 * kernel's link-time p_paddr values are treated as offsets
+		 * within the plane's memory region.
+		 */
+		dest = cfg->load_offset + phdr->p_paddr;
+
+		if (dest < cfg->load_offset ||
+		    dest + phdr->p_memsz > cfg->load_offset + cfg->memory_size) {
+			pr_err("vm_planes: ELF PT_LOAD at 0x%llx+0x%llx outside plane [0x%llx..0x%llx]\n",
+			       (unsigned long long)dest,
+			       (unsigned long long)phdr->p_memsz,
+			       (unsigned long long)cfg->load_offset,
+			       (unsigned long long)(cfg->load_offset + cfg->memory_size));
+			return -EINVAL;
+		}
+
+		if (phdr->p_offset + phdr->p_filesz > size) {
+			pr_err("vm_planes: ELF PT_LOAD file data beyond image\n");
+			return -EINVAL;
+		}
+
+		if (phdr->p_filesz) {
+			ret = copy_to_early_mem(dest, data + phdr->p_offset,
+						phdr->p_filesz);
+			if (ret)
+				return ret;
+		}
+
+		bss_size = phdr->p_memsz - phdr->p_filesz;
+		if (bss_size) {
+			ret = zero_early_mem(dest + phdr->p_filesz, bss_size);
+			if (ret)
+				return ret;
+		}
+
+		/*
+		 * Compute the physical entry point: if e_entry falls within
+		 * this segment's virtual range, convert vaddr→paddr and bias.
+		 * Also handle kernels where e_entry is already a physical
+		 * address by checking the p_paddr range as a fallback.
+		 */
+		if (ehdr->e_entry >= phdr->p_vaddr &&
+		    ehdr->e_entry < phdr->p_vaddr + phdr->p_memsz)
+			cfg->entry_point = cfg->load_offset +
+				phdr->p_paddr + (ehdr->e_entry - phdr->p_vaddr);
+		else if (ehdr->e_entry >= phdr->p_paddr &&
+			 ehdr->e_entry < phdr->p_paddr + phdr->p_memsz)
+			cfg->entry_point = cfg->load_offset + ehdr->e_entry;
+
+		pr_info("vm_planes: ELF PT_LOAD: paddr=0x%llx filesz=0x%llx memsz=0x%llx\n",
+			(unsigned long long)dest,
+			(unsigned long long)phdr->p_filesz,
+			(unsigned long long)phdr->p_memsz);
+	}
+
+	if (!cfg->entry_point) {
+		pr_err("vm_planes: ELF entry point 0x%llx not in any PT_LOAD segment\n",
+		       (unsigned long long)ehdr->e_entry);
+		return -EINVAL;
+	}
+	pr_info("vm_planes: ELF entry point: 0x%llx (virt 0x%llx)\n",
+		(unsigned long long)cfg->entry_point,
+		(unsigned long long)ehdr->e_entry);
+
+	return 0;
+}
+
+static int __init load_plane_kernel_raw(const u8 *data, u32 size,
+					struct vm_plane_config *cfg)
+{
+	if (size > cfg->memory_size) {
+		pr_err("vm_planes: raw kernel image (%u bytes) exceeds plane memory (%llu bytes)\n",
+		       size, (unsigned long long)cfg->memory_size);
+		return -ENOMEM;
+	}
+
+	cfg->entry_point = cfg->load_offset;
+	return copy_to_early_mem(cfg->load_offset, data, size);
+}
+
+int __init load_vm_plane_kernels(unsigned int plane_count,
+				 struct vm_plane_config *plane_cfg)
+{
+	unsigned int i;
+	int err = 0;
+
+	for (i = 1; i < plane_count; i++) {
+		void *data;
+		loff_t fsize;
+		int ret;
+
+		ret = vm_planes_read_file(plane_cfg[i].kernel, &data, &fsize);
+		if (ret) {
+			pr_err("vm_planes: plane %u: kernel '%s' not found: %d\n",
+			       i, plane_cfg[i].kernel, ret);
+			err = ret;
+			continue;
+		}
+
+		switch (plane_cfg[i].kernel_format) {
+		case VM_PLANE_KFMT_RAW:
+			ret = load_plane_kernel_raw(data, (u32)fsize,
+						    &plane_cfg[i]);
+			break;
+		case VM_PLANE_KFMT_ELF:
+			ret = load_plane_kernel_elf(data, (u32)fsize,
+						    &plane_cfg[i]);
+			break;
+		case VM_PLANE_KFMT_BZIMAGE:
+			pr_err("vm_planes: plane %u: bzImage format not yet supported\n",
+			       i);
+			err = -ENOSYS;
+			kvfree(data);
+			continue;
+		default:
+			pr_err("vm_planes: plane %u: unknown kernel format %u\n",
+			       i, plane_cfg[i].kernel_format);
+			err = -EINVAL;
+			kvfree(data);
+			continue;
+		}
+
+		if (ret) {
+			pr_err("vm_planes: plane %u: failed to load kernel: %d\n",
+			       i, ret);
+			err = ret;
+		} else {
+			pr_info("vm_planes: plane %u: loaded '%s' (%lld bytes) at 0x%llx\n",
+				i, plane_cfg[i].kernel, fsize,
+				(unsigned long long)plane_cfg[i].load_offset);
+		}
+
+		kvfree(data);
+	}
+
+	return err;
+}
+
+/* ---- Activation ---- */
+
+int __init __weak alloc_vm_planes(unsigned int plane_count,
+				   struct vm_plane_config *plane_cfg) { return -ENOSYS; }
+
+int __init __weak activate_vm_planes(unsigned int plane_count,
+				      struct vm_plane_config *plane_cfg) { return -ENOSYS; }
+
+/*
+ * Set up VM planes during boot.
+ *
+ * Invoked from the VBS enable path at late_initcall: after device drivers
+ * have initialised (so the rootfs is populated and the plane config and
+ * kernels can be read) and before userspace starts, so the secure plane
+ * vcpu exists by the time the first VTL call is issued.
+ */
+int __init vm_planes_bootstrap(void)
+{
+	unsigned int plane_count = VM_PLANES_DEFAULT_COUNT;
+	struct vm_plane_config *plane_cfg;
+	int ret;
+
+	/* Ensure any asynchronous initramfs unpacking has completed. */
+	wait_for_initramfs();
+
+	if (!kvm_para_available()) {
+		pr_info("vm_planes: KVM paravirt unavailable, skipping plane setup\n");
+		return -ENODEV;
+	}
+
+	ret = vm_planes_get_cfg(&plane_count, &plane_cfg);
+	if (ret) {
+		pr_warn("vm_planes: failed to parse %s: %d\n",
+			VM_PLANES_CONFIG_FILE, ret);
+		return ret;
+	}
+
+	pr_info("vm_planes: enabling %u planes (ids 0..%u)\n",
+		plane_count, plane_count - 1);
+
+	ret = alloc_vm_planes(plane_count, plane_cfg);
+	if (ret) {
+		pr_err("vm_planes: failed to allocate planes: %d\n", ret);
+		return ret;
+	}
+
+	ret = load_vm_plane_kernels(plane_count, plane_cfg);
+	if (ret) {
+		pr_err("vm_planes: failed to load plane kernels: %d\n", ret);
+		return ret;
+	}
+
+	ret = activate_vm_planes(plane_count, plane_cfg);
+	if (ret)
+		pr_err("vm_planes: failed to activate planes: %d\n", ret);
+
+	return ret;
+}
+
+#endif /* CONFIG_VM_PLANES */
-- 
2.55.0

