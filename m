Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF9443E9C5;
	Wed,  5 Aug 2026 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927841; cv=none; b=rDzMauVESzCqEIEEpKilmfBavuS6kxJyCTOPboFqPzKE1cZ457enAwf0MGFqM2NDBKywPK5ZMKCcWZKQzsgJEUor3F7Z/LxPieXabuSY9pI+WxfsigUb3CwDpGsIq8aFomvl/1kKQLZ327rBZweQucvavATarBl6kAvAn48ZDJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927841; c=relaxed/simple;
	bh=NYoFCJs7hcwY6WkT5Rnwoy1VBXTXZnunw8e1HMzEKBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hXKj2MTZw2K/fk5WZmWLJqlP0i6kUNMdroW3il74Evo3IWa2ZUdHzB88HxeuFT84L1qpfWr6z8iZwgTa3PZToCVNQiP6vkFgsTVBBIVpSby/vp1TkW12fFP5fDXFDT2c9qGeII+8YVZESNjra4MTOJysXuRc7kbivmsqUcaAPr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AqmyHShP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AqmyHShP"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7FD0020B716B;
	Wed,  5 Aug 2026 04:03:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7FD0020B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927818;
	bh=dTRcKNCHeBGgLTvtUT3mS37PqtwLmSq7VZWMho7DmDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AqmyHShPKsLZWg6hrykMQ0zUwrOUwVSlyzMGzd+NJLJggTIxLPWosaHXkI2axthP+
	 DTuokXAWrTsMBQ9ZaXPz/s/JtFEerPvNcWQYItuwlRhLo1mQR1vNwBEUa8u4ui/Rk7
	 dvuZLS4pBMAGZTTXW8KrnY08eG7+TJug4c/YlgW8=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 18/42] vbs: Add kexec validation and make module auth non-fatal
Date: Wed,  5 Aug 2026 04:03:00 -0700
Message-ID: <20260805110324.25067-19-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110324.25067-1-snambakam@linux.microsoft.com>
References: <20260805110324.25067-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add VBS/HEKI kexec validation hooks so the secure kernel (plane-1) can
approve or reject kexec kernel images before they are loaded.

kexec_file.c:
  - After signature verification passes, call vbs_kexec_validate() to
    send the kernel image GPA, size, and sig_ok flag to the secure
    kernel via the VTL call interface.
  - If the secure kernel rejects the image, kexec_file_load fails.

kexec_core.c:
  - In kimage_free(), call vbs_kexec_invalidate() to notify the secure
    kernel that a previously validated kexec image is being freed.

security/vbs/heki.h:
  - Add struct vbs_kexec_validate_req (kernel_gpa, kernel_size,
    sig_ok, flags).

security/vbs/kvm_planes.c:
  - Implement kvm_planes_kexec_validate(): translates the vmalloc
    kernel buffer to a GPA, populates the request, and issues the
    VTL call to plane-1.
  - Implement kvm_planes_kexec_invalidate(): issues the VTL call
    with no payload.

kernel/module/main.c:
  - Change VBS module validation from fatal to non-fatal.  If the
    secure kernel rejects a module, log a warning but allow loading
    to continue.  This prevents unsigned modules (common at boot)
    from blocking the system.  A strict policy can be enforced later.

Signed-off-by: Sriram Nambakam <snambakam@linux.microsoft.com>
---
 kernel/kexec_core.c       |  5 +++++
 kernel/kexec_file.c       | 20 ++++++++++++++++++++
 kernel/module/main.c      |  9 +++++----
 security/vbs/heki.h       | 14 ++++++++++++++
 security/vbs/kvm_planes.c | 24 +++++++++++++++++++++++-
 5 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index dc770b9a6d05..a7bdbfaf68c8 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -43,6 +43,7 @@
 #include <linux/kmsg_dump.h>
 #include <linux/dma-map-ops.h>
 #include <linux/sysfs.h>
+#include <linux/vbs.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -580,6 +581,10 @@ void kimage_free(struct kimage *image)
 	if (!image)
 		return;
 
+	/* Notify the secure kernel that a kexec image is being freed */
+	if (vbs_available())
+		vbs_kexec_invalidate();
+
 #ifdef CONFIG_CRASH_DUMP
 	if (image->vmcoreinfo_data_copy) {
 		crash_update_vmcoreinfo_safecopy(NULL);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 2bfbb2d144e6..81cf454ab516 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -27,6 +27,7 @@
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
 #include <linux/dma-map-ops.h>
+#include <linux/vbs.h>
 #include "kexec_internal.h"
 
 #ifdef CONFIG_KEXEC_SIG
@@ -243,6 +244,25 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	if (ret)
 		goto out;
 #endif
+
+	/*
+	 * If VBS is available, ask the secure kernel (plane-1) to
+	 * validate the kexec kernel image.  Pass sig_ok based on
+	 * whether CONFIG_KEXEC_SIG is enabled and the check passed.
+	 */
+	if (vbs_available()) {
+		int sig_ok = 0;
+#ifdef CONFIG_KEXEC_SIG
+		sig_ok = 1;  /* we got here, so sig check passed */
+#endif
+		ret = vbs_kexec_validate(image->kernel_buf,
+					 image->kernel_buf_len,
+					 NULL, sig_ok);
+		if (ret) {
+			pr_warn("vbs: kexec kernel rejected by secure kernel (%d)\n", ret);
+			goto out;
+		}
+	}
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
 		ret = kernel_read_file_from_fd(initrd_fd, 0, &image->initrd_buf,
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 2d0232fccf18..3b46d6c0fb41 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3487,11 +3487,12 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	if (vbs_available()) {
 		err = vbs_validate_module(info->hdr, info->len,
 					  NULL, info->sig_ok ? 1 : 0);
-		if (err) {
-			pr_warn("vbs: module '%s' rejected by secure kernel (%ld)\n",
+		if (err)
+			pr_warn("vbs: module '%s' validation returned (%ld) — continuing\n",
 				mod->name, err);
-			goto unlink_mod;
-		}
+		/* Non-fatal: allow loading to continue even if VBS rejects.
+		 * A strict policy can be enforced later by changing this. */
+		err = 0;
 	}
 
 	/*
diff --git a/security/vbs/heki.h b/security/vbs/heki.h
index 5b7fa92bce21..fb485f171045 100644
--- a/security/vbs/heki.h
+++ b/security/vbs/heki.h
@@ -82,6 +82,20 @@ struct vbs_unload_module_req {
 	char	name[56];	/* module name (null-terminated)          */
 } __packed;
 
+/* ── Kexec validation ─────────────────────────────────────────────────── */
+
+/*
+ * VBS_CALL_KEXEC_VALIDATE payload — plane-0 sends the GPA and size of
+ * the kexec kernel image for plane-1 validation before allowing the
+ * kexec to proceed.
+ */
+struct vbs_kexec_validate_req {
+	__u64	kernel_gpa;	/* GPA of the kernel image buffer         */
+	__u64	kernel_size;	/* size of the kernel image               */
+	__u32	sig_ok;		/* 1 if kernel's sig check passed         */
+	__u32	flags;		/* reserved, must be 0                   */
+} __packed;
+
 /* ── x86-64 page table walker (for plane-1 auditing) ─────────────────── */
 
 /* Classification of a guest-physical page based on page table walk */
diff --git a/security/vbs/kvm_planes.c b/security/vbs/kvm_planes.c
index 1114adfbd46c..061163a4d303 100644
--- a/security/vbs/kvm_planes.c
+++ b/security/vbs/kvm_planes.c
@@ -282,12 +282,34 @@ static int kvm_planes_send_certs(const void *certs, size_t certs_size)
 static int kvm_planes_kexec_validate(const void *kernel, size_t kernel_size,
 				     const void *sig, size_t sig_size)
 {
+	struct vbs_kexec_validate_req req = {};
+	struct page *page;
+
+	if (!kernel || !kernel_size)
+		return -EINVAL;
+
+	/*
+	 * sig_size is repurposed: 1 = kernel's sig check passed,
+	 * 0 = unsigned or failed (same pattern as module validation).
+	 */
+	req.sig_ok = sig_size ? 1 : 0;
+	req.kernel_size = kernel_size;
+
+	/* Get GPA of the kernel image buffer (first page) */
+	page = vmalloc_to_page(kernel);
+	if (page)
+		req.kernel_gpa = page_to_phys(page) + offset_in_page(kernel);
+
+	pr_info("vbs-kvm: kexec_validate gpa=0x%llx size=0x%llx sig_ok=%u\n",
+		req.kernel_gpa, req.kernel_size, req.sig_ok);
+
 	return kvm_planes_vtl_call(VBS_CALL_KEXEC_VALIDATE,
-				   NULL, 0, NULL, 0);
+				   &req, sizeof(req), NULL, 0);
 }
 
 static int kvm_planes_kexec_invalidate(void)
 {
+	pr_info("vbs-kvm: kexec_invalidate\n");
 	return kvm_planes_vtl_call(VBS_CALL_KEXEC_INVALIDATE,
 				   NULL, 0, NULL, 0);
 }
-- 
2.55.0

