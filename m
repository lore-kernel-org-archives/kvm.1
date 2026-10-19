Received: from mta1.migadu.com (out-242.mta1.migadu.com [95.215.58.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5379F4C8466
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420993; cv=none; b=r1gH9pLn+JYMcPmTcfybG29XPxwLWkTeAYNG8dGL9TgDjTJ5QQ/qhUxjLgcY7uHXc5xyawhscyeSfp0kDjlT2EwXwlipC2zFXLjMH7Fi0B2f2+WKIrG8F1PD2t2dlYkJgMCRhDefHHG/V3pTkObsilYgGNZuAxPDymZ+SB3AgV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420993; c=relaxed/simple;
	bh=yAzZlMG9yyqlRb+Q8VS1SI9X4mbkrMtuzvvRVXOI/o4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPLTnmVn0hN3+iEHSI02AlD5Mn88Lz3VQTZGG+t2OeCvJENAUtku/z5xaMHza9lfUmahqMR1EfFeVFbLwQhe/nEQIorau5HiOLTtzp68/954pH7Wb4FzvApwUolqRDwl9pn6YB7AvnOvm5uGJY8SjbAKvdwMxkVOLHcFgqdpYa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Eq2Q/oIq; arc=none smtp.client-ip=95.215.58.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Eq2Q/oIq"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yAzZlMG9yyqlRb+Q8VS1SI9X4mbkrMtuzvvRVXOI/o4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792420989; v=1; x=1793025789;
 b=Eq2Q/oIqSHKVdGihDgA6d5YqFLgZdM6/7LiEN2Uoe2E6fANdsQLc67fLWsb9ZUfyN/hV1QR0
 X+R3x/MtiA4a6sRRDOSBnmVZNXpm4CKxdnGgq2DlSuWOhgsIH1qleKbC/ZG8V5iGh/Iv91/STvk
 s2LJzeLblxFM30gpOcbT7ejU=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 609bfc4a7ea223cb;
	Mon, 19 Oct 2026 14:43:08 +0000
X-Mizu-Trace-ID: 609bfc4a7ea223cb
X-Migadu-Flow: FLOW_OUT
From: Andrew Jones <andrew.jones@linux.dev>
To: kvm@vger.kernel.org,
	will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: kvm-riscv@lists.infradead.org,
	Anup Patel <anup@brainfault.org>
Subject: [PATCH kvmtool] riscv: Place the FDT after the kernel's image_size
Date: Mon, 19 Oct 2026 16:43:04 +0200
Message-ID: <20261019144304.2678066-1-andrew.jones@linux.dev>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FDT is placed relative to the end of the kernel image file, but a
kernel's memory footprint includes its BSS, which isn't in the file. When
the BSS is large enough, e.g. with lockdep enabled, the FDT lands inside
it and is wiped when the kernel clears BSS, leaving the guest hung with no
console output. Use the image_size from the Image header, as arm64 does.

Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
---
 riscv/include/asm/image.h | 40 +++++++++++++++++++++++++++++++++++++++
 riscv/kvm.c               | 26 ++++++++++++++++++++++---
 2 files changed, 63 insertions(+), 3 deletions(-)
 create mode 100644 riscv/include/asm/image.h

diff --git a/riscv/include/asm/image.h b/riscv/include/asm/image.h
new file mode 100644
index 000000000000..0deb74ddd9d4
--- /dev/null
+++ b/riscv/include/asm/image.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_IMAGE_H
+#define __ASM_IMAGE_H
+
+#define RISCV_IMAGE_MAGIC	"RISCV\0\0\0"
+#define RISCV_IMAGE_MAGIC2	"RSC\x05"
+
+/*
+ * struct riscv_image_header - riscv kernel image header
+ * See Documentation/arch/riscv/boot-image-header.rst for details
+ *
+ * @code0:		Executable code
+ * @code1:		Executable code
+ * @text_offset:	Image load offset (little endian)
+ * @image_size:		Effective Image size (little endian)
+ * @flags:		kernel flags (little endian)
+ * @version:		version
+ * @res1:		reserved
+ * @res2:		reserved
+ * @magic:		Magic number (RISC-V specific; deprecated)
+ * @magic2:		Magic number 2 (to match the ARM64 'magic' field pos)
+ * @res3:		reserved (will be used for PE COFF offset)
+ */
+
+struct riscv_image_header {
+	u32 code0;
+	u32 code1;
+	__le64 text_offset;
+	__le64 image_size;
+	__le64 flags;
+	u32 version;
+	u32 res1;
+	u64 res2;
+	u64 magic;
+	u32 magic2;
+	u32 res3;
+};
+
+#endif /* __ASM_IMAGE_H */
diff --git a/riscv/kvm.c b/riscv/kvm.c
index 1d494792de79..fc192af34435 100644
--- a/riscv/kvm.c
+++ b/riscv/kvm.c
@@ -4,9 +4,11 @@
 #include "kvm/virtio-console.h"
 #include "kvm/fdt.h"
 
+#include <linux/byteorder.h>
 #include <linux/kernel.h>
 #include <linux/kvm.h>
 #include <linux/sizes.h>
+#include <asm/image.h>
 
 struct kvm_ext kvm_req_ext[] = {
 	{ DEFINE_KVM_EXT(KVM_CAP_ONE_REG) },
@@ -100,6 +102,22 @@ void kvm__arch_init(struct kvm *kvm)
 	riscv__irqchip_create(kvm);
 }
 
+/*
+ * The kernel's memory footprint, including BSS, is the image_size in the
+ * Image header, which may be larger than the file.
+ */
+static u64 kvm__arch_get_kernel_size(void *kernel, ssize_t file_size)
+{
+	struct riscv_image_header *hdr = kernel;
+
+	if ((size_t)file_size < sizeof(*hdr) ||
+	    (memcmp(&hdr->magic2, RISCV_IMAGE_MAGIC2, sizeof(hdr->magic2)) &&
+	     memcmp(&hdr->magic, RISCV_IMAGE_MAGIC, sizeof(hdr->magic))))
+		return file_size;
+
+	return max_t(u64, le64_to_cpu(hdr->image_size), file_size);
+}
+
 #define FDT_ALIGN	SZ_4M
 #define INITRD_ALIGN	8
 bool kvm__arch_load_kernel_image(struct kvm *kvm, int fd_kernel, int fd_initrd,
@@ -108,6 +126,7 @@ bool kvm__arch_load_kernel_image(struct kvm *kvm, int fd_kernel, int fd_initrd,
 	void *pos, *kernel_end, *limit;
 	unsigned long guest_addr, kernel_offset;
 	ssize_t file_size;
+	u64 kernel_size;
 
 	/*
 	 * Linux requires the initrd and dtb to be mapped inside lowmem,
@@ -132,9 +151,10 @@ bool kvm__arch_load_kernel_image(struct kvm *kvm, int fd_kernel, int fd_initrd,
 
 		die_perror("kernel read");
 	}
-	kernel_end = pos + file_size;
-	pr_debug("Loaded kernel to 0x%llx (%zd bytes)",
-		 kvm->arch.kern_guest_start, file_size);
+	kernel_size = kvm__arch_get_kernel_size(pos, file_size);
+	kernel_end = pos + kernel_size;
+	pr_debug("Loaded kernel to 0x%llx (%zd bytes, %llu in memory)",
+		 kvm->arch.kern_guest_start, file_size, kernel_size);
 
 	/* Place FDT just after kernel at FDT_ALIGN address */
 	pos = kernel_end + FDT_ALIGN;
-- 
2.56.0

