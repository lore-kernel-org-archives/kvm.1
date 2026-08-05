Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC4546983C;
	Wed,  5 Aug 2026 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927855; cv=none; b=t8pNCBRarZ3NjMylX0tFqdDN1v8sOo5yeZbSwYJuVE9wplM1QEGFcU2eSo2XpMXmEIzR8+IO/iJhPM/dqxHbxQpYDPmv1azPGYYlVfxcPDbOEyvNekjfW0vIlg9H0ZkkJtzXwOpjR92zV3u60EjEx+Ixhst6VO9FMCyRb9hzRGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927855; c=relaxed/simple;
	bh=pyKS7+F0zwetOCNSEOXtWXwvWirtCIBTLIx9T8AhX8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgGfZJEjLj0yzoKjSBhLZ5nT/pzBgZsmlF+rMQj0JXmpKhH4GA3Smf54+PDJpTTSGujH5HIOg9oS6iqpIDuvcWm71cnHwZTZClbkg+LXNO9hTHKnHZHW12feao/1GtkB5EX56028BgPmBudBd1Y4gmVz5O3BOpz+LZvo78ed75o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CJlBgF8l; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CJlBgF8l"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id D0DFB20B716A;
	Wed,  5 Aug 2026 04:03:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D0DFB20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927831;
	bh=dl2+i7STnM4/26bHF7J69Rp6JVzOlj+gj+sfuPNR6s8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CJlBgF8lev9RS7nfdVY4Vpj2J4+DZg2iLqrSaQxFGTNGPDGpPTv5UG+0XNnaV2R98
	 /Z7MGecRVQElK9jfGkRu9rWCHJ6yMqsTwIXCsF46CfFen9IV+6nR12q7zC20y1oOy7
	 HZRUqPtvmBZMM2CrlZ6I+SWc8gVH/vfdMlLW7Qw0=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 35/42] KVM: x86: deny normal-plane access to secure-plane memory
Date: Wed,  5 Aug 2026 04:03:17 -0700
Message-ID: <20260805110324.25067-36-snambakam@linux.microsoft.com>
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

VM planes share one guest physical address space (one set of memslots),
so today the normal plane (plane 0) can read the secure plane's RAM.
Add per-plane access control so a higher-privilege plane can hide its
memory from a lower one:

 - Encode the plane into union kvm_mmu_page_role (the previously spare
   4 bits) so each plane gets its own TDP/EPT root instead of sharing
   one set of page tables.

 - Give each struct kvm_plane its own access_attr_array (xarray),
   independent of kvm->mem_attr_array, to avoid coupling with the
   private/CoCo memory-attribute machinery.

 - Add KVM_MEMORY_ATTRIBUTE_NO_READ.  NO_READ cannot be expressed as a
   present-but-unreadable EPT entry on all hardware, so it is enforced
   in the fault path: kvm_mmu_faultin_pfn() refuses to map a NO_READ
   gfn (and a write to a NO_WRITE gfn) for the faulting plane and exits
   with KVM_EXIT_MEMORY_FAULT instead of building an SPTE the access
   would immediately re-fault on.  NO_WRITE/NO_EXEC continue to be
   stripped in kvm_plane_filter_pte_access().

 - KVM_HC_VBS_SET_MEM_ATTRS lets a plane >0 apply NO_READ/NO_WRITE/
   NO_EXEC to the plane directly below it (the secure plane cannot issue
   the host KVM_SET_MEMORY_ATTRIBUTES ioctl).  a2 is an allow-mask:
   bit0 read, bit1 write, bit2 exec; a cleared bit adds the matching
   restriction, a2 == 0 hides the range entirely.

drivers/virt/secure_monitor.c uses this to seal the secure plane's own
RAM (walk_system_ram_range -> SET_MEM_ATTRS with perms 0) from the
normal plane before handing control back, so plane 0 can no longer read
plane 1.
---
 drivers/virt/secure_monitor.c | 79 +++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/drivers/virt/secure_monitor.c b/drivers/virt/secure_monitor.c
index 2d181c32c439..028ae222037a 100644
--- a/drivers/virt/secure_monitor.c
+++ b/drivers/virt/secure_monitor.c
@@ -25,11 +25,15 @@
  * Because all planes of a VM share the same memslots (struct kvm_plane has no
  * memslots of its own; they live in struct kvm), the secure plane sees the
  * same guest-physical address space as the normal plane and can read the
- * calling area and the GPAs referenced by each request directly.
+ * calling area and the GPAs referenced by each request directly.  This same
+ * sharing means the secure plane must explicitly hide its own RAM from the
+ * normal plane: on startup it walks its system RAM and asks KVM (via
+ * KVM_HC_VBS_SET_MEM_ATTRS) to deny the normal plane read/write/exec access,
+ * so plane 0 cannot read secure-plane memory.
  *
  * For now every VTL call is acknowledged as a no-op so the normal plane can
- * make progress; the real per-call handlers (self-protection, HEKI memory
- * protection, kernel sealing, …) are plumbed in incrementally.
+ * make progress; the remaining per-call handlers (HEKI memory protection,
+ * kernel sealing, …) are plumbed in incrementally.
  *
  * Activated by the "secure_monitor" kernel command-line option; without it
  * this kernel boots normally and never parks.
@@ -41,10 +45,13 @@
 #include <linux/init.h>
 #include <linux/kthread.h>
 #include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/err.h>
+#include <linux/vbs.h>
 #include <linux/kvm_para.h>
 #include <asm/kvm_para.h>
 
@@ -85,12 +92,78 @@ static u64 secmon_vtl_return(long status)
 	return kvm_hypercall1(KVM_HC_VBS_VTL_RETURN, (unsigned long)status);
 }
 
+/*
+ * Apply EPT permissions on a normal-plane GPA range from the secure plane.
+ *
+ * The secure plane cannot issue the host KVM_SET_MEMORY_ATTRIBUTES ioctl, so
+ * it asks KVM to do it via the KVM_HC_VBS_SET_MEM_ATTRS hypercall, which KVM
+ * honours only for a higher-privilege plane (it applies the attributes to the
+ * plane directly below the caller).  @perms carries the access bits the
+ * normal plane should retain (VBS_MEM_*); KVM translates a cleared
+ * read/write/exec bit into NO_READ / NO_WRITE / NO_EXEC.  @perms == 0 hides
+ * the range entirely.
+ */
+static int secmon_apply_attrs(u64 gpa, u64 size, u32 perms)
+{
+	long ret;
+
+	pr_debug("apply_attrs gpa=0x%llx size=0x%llx perms=%c%c%c\n",
+		 gpa, size,
+		 (perms & VBS_MEM_READ)  ? 'r' : '-',
+		 (perms & VBS_MEM_WRITE) ? 'w' : '-',
+		 (perms & VBS_MEM_EXEC)  ? 'x' : '-');
+
+	ret = kvm_hypercall3(KVM_HC_VBS_SET_MEM_ATTRS, gpa, size, perms);
+	if (ret)
+		return (int)ret;
+
+	return 0;
+}
+
+/*
+ * Hide one range of this plane's RAM from the normal plane.  perms = 0 means
+ * "retain no access" (no read/write/exec), so the normal plane faults and is
+ * denied if it tries to touch secure-plane memory.
+ */
+static int secmon_hide_range(unsigned long start_pfn, unsigned long nr_pages,
+			     void *arg)
+{
+	unsigned long gpa = start_pfn << PAGE_SHIFT;
+	unsigned long size = nr_pages << PAGE_SHIFT;
+	int r;
+
+	r = secmon_apply_attrs(gpa, size, 0);
+	if (r)
+		pr_warn("failed to protect RAM [0x%lx+0x%lx]: %d\n",
+			gpa, size, r);
+	else
+		pr_info("protected RAM [0x%lx+0x%lx] from normal plane\n",
+			gpa, size);
+
+	/* Continue with the remaining ranges even if one fails. */
+	return 0;
+}
+
+/*
+ * Deny the normal plane access to all of the secure plane's own RAM.  Runs
+ * while the normal plane is frozen in the KVM_RUN that switched to us, so
+ * there is no window during which the memory is both populated and still
+ * readable by the normal plane.
+ */
+static void secmon_protect_self(void)
+{
+	walk_system_ram_range(0, max_pfn, NULL, secmon_hide_range);
+}
+
 static int secmon_monitor_fn(void *unused)
 {
 	long status = 0;
 
 	pr_info("secure monitor started\n");
 
+	/* Seal our memory from the normal plane before handing control back. */
+	secmon_protect_self();
+
 	for (;;) {
 		struct vbs_kvm_ca *ca;
 		u64 ca_gpa;
-- 
2.55.0

