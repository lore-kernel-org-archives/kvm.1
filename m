Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854FD4334D3;
	Wed,  5 Aug 2026 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927832; cv=none; b=hO9sV3B2Jw07MjxS67O19Z1itx/McdRSNuCILrqohNTN9OSxgZFOt54EXFW+uPleA7ZcRB/lOJHM+HBe6cywnsc1wJMWpa+yTy704pMRBU6UrK1gKA8lYnynbeH07BQK04pXUKgaQA3l7kpwtw2jAL86sVUncLpsH23e55kN1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927832; c=relaxed/simple;
	bh=MHcbeTX2dK1GEG7Bqjd2QyfuOrt9zKlxkq7qViV9rR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/9Wm1tRAc1ERAwjTPLVqDbCmLye19PBePLrn+jVPG8+nB3HXKjFWNAuJEBfo+GVuqhyt4/jJ9yE0Fhq+w6PKjlmXSAk6/J4hxOqRVk/jgArbnRNXsgr447hYIeFiTDZ6Go8vp4DxmPvk8EVgfCQ81oto1BulnXmNDvNTj1tjhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eGdVrYuy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eGdVrYuy"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 81B2120B716A;
	Wed,  5 Aug 2026 04:03:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 81B2120B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927809;
	bh=K4mWSHsUdER4mUqbyNOHd9q3VHmmNBWDaskxeQLhVsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eGdVrYuyo7R1JWp/rnoEi4g5c0CQaCeho36nQk/xQEa2IEprBQ7y7c6T0aT+s225e
	 A1jiJTc9tqnW1elfLfb5yD+2S9HPh4eDiEZN+aaZ6n5YqcUzKOsVEcntmKQV3oODGK
	 BDt9wzVzvuVJbGDtn5WGiT3J1OQiX08eQ1T7KQzA=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 09/42] Activate the VM Planes through the Hypervisor - Using KVM as the VMM
Date: Wed,  5 Aug 2026 04:02:51 -0700
Message-ID: <20260805110324.25067-10-snambakam@linux.microsoft.com>
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

---
 arch/x86/include/asm/cpu.h   |   3 +-
 arch/x86/kernel/cpu/common.c |  39 ++++++--
 include/linux/vm_planes.h    |   4 +-
 init/vm_planes.c             | 179 ++++++++++++++++++++++++++++++++++-
 4 files changed, 212 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 8ab76adf14a9..52e80c6ac8f0 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -13,8 +13,9 @@
 #ifdef CONFIG_VM_PLANES
 struct vm_plane_config;
 
-void __init alloc_vm_planes(unsigned int plane_count,
+int __init alloc_vm_planes(unsigned int plane_count,
 			    struct vm_plane_config *plane_cfg);
+int __init activate_vm_planes(unsigned int plane_count);
 #endif
 
 #ifndef CONFIG_SMP
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 166597204739..9912208d2010 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -82,7 +82,9 @@
 
 #ifdef CONFIG_VM_PLANES
 /* Private hypercall number for early VM plane configuration. */
-#define KVM_HC_VM_PLANES_CONFIG	0x1000
+#define KVM_HC_VM_PLANES_CONFIG		0x1000
+/* Private hypercall number to activate all configured planes. */
+#define KVM_HC_VM_PLANES_ACTIVATE	0x1001
 #endif
 
 DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
@@ -2674,31 +2676,56 @@ void __init arch_cpu_finalize_init(void)
 }
 
 #ifdef CONFIG_VM_PLANES
-void __init alloc_vm_planes(unsigned int plane_count,
+int __init alloc_vm_planes(unsigned int plane_count,
 			    struct vm_plane_config *plane_cfg)
 {
 	phys_addr_t phys;
 	long ret;
 
 	if (!plane_count || !plane_cfg)
-		return;
+		return -EINVAL;
 
 	if (!kvm_para_available()) {
 		pr_warn("vm_planes: hypercall interface unavailable\n");
-		return;
+		return -ENODEV;
 	}
 
 	phys = virt_to_phys((void *)plane_cfg);
 
 	if (sizeof(unsigned long) < sizeof(phys_addr_t) && phys > ULONG_MAX) {
 		pr_warn("vm_planes: shared config address exceeds hypercall register width\n");
-		return;
+		return -EOVERFLOW;
 	}
 
 	ret = kvm_hypercall2(KVM_HC_VM_PLANES_CONFIG,
 			     (unsigned long)phys,
 			     plane_count);
-	if (ret < 0)
+	if (ret < 0) {
 		pr_warn("vm_planes: hypercall failed: %ld\n", ret);
+		return (int)ret;
+	}
+
+	return 0;
+}
+
+int __init activate_vm_planes(unsigned int plane_count)
+{
+	long ret;
+
+	if (!plane_count)
+		return -EINVAL;
+
+	if (!kvm_para_available()) {
+		pr_warn("vm_planes: hypercall interface unavailable\n");
+		return -ENODEV;
+	}
+
+	ret = kvm_hypercall1(KVM_HC_VM_PLANES_ACTIVATE, plane_count);
+	if (ret < 0) {
+		pr_warn("vm_planes: activate hypercall failed: %ld\n", ret);
+		return (int)ret;
+	}
+
+	return 0;
 }
 #endif
diff --git a/include/linux/vm_planes.h b/include/linux/vm_planes.h
index 6d0066f70349..5850c9e0d097 100644
--- a/include/linux/vm_planes.h
+++ b/include/linux/vm_planes.h
@@ -24,8 +24,8 @@ struct vm_plane_config {
 };
 
 void __init arch_init_vm_planes(void);
-void __init load_vm_plane_kernels(unsigned int plane_count,
-				  struct vm_plane_config *plane_cfg);
+int __init load_vm_plane_kernels(unsigned int plane_count,
+				 struct vm_plane_config *plane_cfg);
 
 #endif /* CONFIG_VM_PLANES */
 
diff --git a/init/vm_planes.c b/init/vm_planes.c
index da9c17de4a44..6fac52af4b77 100644
--- a/init/vm_planes.c
+++ b/init/vm_planes.c
@@ -11,7 +11,7 @@
 #include <linux/elf.h>
 #include <asm/cpu.h>
 #include <asm/kvm_para.h>
-#include <asm/io.h>
+#include <asm-generic/early_ioremap.h>
 
 #ifdef CONFIG_VM_PLANES
 static bool __initdata enable_vm_planes_requested;
@@ -405,6 +405,159 @@ static int __init vm_planes_get_cfg_from_initrd(unsigned int *plane_count,
 	return -ENOENT;
 }
 
+static int __init find_initrd_file(const char *filename,
+				   const u8 **out_data, u32 *out_size)
+{
+	const u8 *p = (const u8 *)(unsigned long)initrd_start;
+	const u8 *end = (const u8 *)(unsigned long)initrd_end;
+
+	if (!initrd_start || !initrd_end || initrd_end <= initrd_start)
+		return -ENOENT;
+
+	while (p + sizeof(struct cpio_newc_header) <= end) {
+		const struct cpio_newc_header *hdr;
+		const char *name;
+		const u8 *data;
+		u32 namesize, filesize;
+		u32 name_align, data_align;
+		int ret;
+
+		hdr = (const struct cpio_newc_header *)p;
+		if (memcmp(hdr->c_magic, "070701", 6) &&
+		    memcmp(hdr->c_magic, "070702", 6))
+			return -EINVAL;
+
+		ret = parse_hex_field(hdr->c_namesize,
+				      sizeof(hdr->c_namesize), &namesize);
+		if (ret)
+			return ret;
+
+		ret = parse_hex_field(hdr->c_filesize,
+				      sizeof(hdr->c_filesize), &filesize);
+		if (ret)
+			return ret;
+
+		if (!namesize)
+			return -EINVAL;
+
+		p += sizeof(*hdr);
+		if (p + namesize > end)
+			return -EINVAL;
+
+		name = (const char *)p;
+		name_align = ALIGN(namesize, 4);
+		if (p + name_align > end)
+			return -EINVAL;
+
+		data = p + name_align;
+		if (data + filesize > end)
+			return -EINVAL;
+
+		if (!strcmp(name, "TRAILER!!!"))
+			break;
+
+		if (cpio_name_match(name, namesize, filename)) {
+			*out_data = data;
+			*out_size = filesize;
+			return 0;
+		}
+
+		data_align = ALIGN(filesize, 4);
+		if (data + data_align < data || data + data_align > end)
+			return -EINVAL;
+
+		p = data + data_align;
+	}
+
+	return -ENOENT;
+}
+
+static int __init copy_to_early_mem(phys_addr_t dest, const void *src,
+				    unsigned long size)
+{
+	unsigned long slop, clen;
+	char *p;
+
+	while (size) {
+		slop = offset_in_page(dest);
+		clen = size;
+		if (clen > PAGE_SIZE - slop)
+			clen = PAGE_SIZE - slop;
+		p = early_memremap(dest & PAGE_MASK, clen + slop);
+		if (!p)
+			return -ENOMEM;
+		memcpy(p + slop, src, clen);
+		early_memunmap(p, clen + slop);
+		dest += clen;
+		src += clen;
+		size -= clen;
+	}
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
+		const u8 *data;
+		u32 size;
+		int ret;
+
+		ret = find_initrd_file(plane_cfg[i].kernel, &data, &size);
+		if (ret) {
+			pr_err("vm_planes: plane %u: kernel image '%s' not found in initrd\n",
+			       i, plane_cfg[i].kernel);
+			err = ret;
+			continue;
+		}
+
+		switch (plane_cfg[i].kernel_format) {
+		case VM_PLANE_KFMT_RAW:
+			ret = load_plane_kernel_raw(data, size,
+						    &plane_cfg[i]);
+			break;
+		case VM_PLANE_KFMT_BZIMAGE:
+		case VM_PLANE_KFMT_ELF:
+			pr_err("vm_planes: plane %u: kernel format not yet supported\n",
+			       i);
+			err = -ENOSYS;
+			continue;
+		default:
+			pr_err("vm_planes: plane %u: unknown kernel format %u\n",
+			       i, plane_cfg[i].kernel_format);
+			err = -EINVAL;
+			continue;
+		}
+
+		if (ret) {
+			pr_err("vm_planes: plane %u: failed to load kernel image: %d\n",
+			       i, ret);
+			err = ret;
+		} else {
+			pr_info("vm_planes: plane %u: loaded '%s' (%u bytes) at 0x%llx\n",
+				i, plane_cfg[i].kernel,
+				size, (unsigned long long)plane_cfg[i].load_offset);
+		}
+	}
+
+	return err;
+}
+
 static int __init parse_enable_vm_planes(char *str)
 {
 	bool enable;
@@ -423,13 +576,16 @@ static int __init parse_enable_vm_planes(char *str)
 
 early_param("enable-vm-planes", parse_enable_vm_planes);
 
-void __init __weak alloc_vm_planes(unsigned int plane_count,
-				   struct vm_plane_config *plane_cfg) { }
+int __init __weak alloc_vm_planes(unsigned int plane_count,
+				   struct vm_plane_config *plane_cfg) { return -ENOSYS; }
+
+int __init __weak activate_vm_planes(unsigned int plane_count) { return -ENOSYS; }
 
 void __init arch_init_vm_planes(void)
 {
 	unsigned int plane_count = VM_PLANES_DEFAULT_COUNT;
 	struct vm_plane_config *plane_cfg;
+	int ret;
 
 	if (!enable_vm_planes_requested)
 		return;
@@ -445,7 +601,22 @@ void __init arch_init_vm_planes(void)
 
 	pr_info("vm_planes: enabling %u planes (ids 0..%u)\n",
 		plane_count, plane_count - 1);
-	alloc_vm_planes(plane_count, plane_cfg);
+
+	ret = alloc_vm_planes(plane_count, plane_cfg);
+	if (ret) {
+		pr_err("vm_planes: failed to allocate planes: %d\n", ret);
+		return;
+	}
+
+	ret = load_vm_plane_kernels(plane_count, plane_cfg);
+	if (ret) {
+		pr_err("vm_planes: failed to load plane kernels: %d\n", ret);
+		return;
+	}
+
+	ret = activate_vm_planes(plane_count);
+	if (ret)
+		pr_err("vm_planes: failed to activate planes: %d\n", ret);
 }
 
 #endif /* CONFIG_VM_PLANES */
-- 
2.55.0

