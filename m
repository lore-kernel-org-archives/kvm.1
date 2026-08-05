Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBE943B3F6;
	Wed,  5 Aug 2026 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927838; cv=none; b=IS5LvE6DeGXnkV2SiDKTUpX4pmwBv9zv0isLWGvwHTxit5EJkFKBQPpdiocOQZfcVCz4IMhZDikWvSfrHVZT6YsyN4ZHVTNPNghHQCR3ojKTJ2/rsJFAjGNXEOZbF9JfuZgkItpg6icBeccxSjd15tmo3SV27/CpO7Fg5kdzWho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927838; c=relaxed/simple;
	bh=fw/3m2gOCBD7tgMqLnrxTv3DXia3LDwXiPtZQbSdaRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQkmynk4PAx0PBlKS8aG3NY8O2sLadhETuiRcVZevz6ZYCdGyY+ZG8shAatV7ewNfeSgDC84HTUglapeOoQOJVaywgRrSw8bTbiG+kI7vjK0UHi0cgw9gzvgUwGx9SVNJ5BEzK90XWKz8LN1YV6YDeZEXUu+1BcwaJICAKGHT+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Xos5SIf9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Xos5SIf9"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 23F4E20B716B;
	Wed,  5 Aug 2026 04:03:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 23F4E20B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927815;
	bh=TSibJLeuOC2oppqd3yILeAKE37LPNTC/8+9Siv/5++Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xos5SIf9TUNAuQYOC5PmtCgbbdWDojfZmqkibp8DwnZFSQpWxLBGoi9UEkfTDL11v
	 egDWDVYsEl1eyrwILA/I3VmomXkKEbEK9jr/2uHtkJ9HxFneZ+Kw8m03VYAU4+GuxL
	 CK5J90dvQQhZLj1ZdWuPUO8DWUCZ3MThM9x30Hhk=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 14/42] KVM: Add per-plane memory attribute support for cross-plane EPT protection
Date: Wed,  5 Aug 2026 04:02:56 -0700
Message-ID: <20260805110324.25067-15-snambakam@linux.microsoft.com>
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

Extend the KVM memory attributes framework to support per-plane
R/W/X permission control, enabling a higher-privilege plane (e.g.,
plane-1 / secure kernel) to restrict a lower-privilege plane's
(e.g., plane-0) EPT permissions.

This is the KVM equivalent of the AMD SEV-SNP RMP (Reverse Map Table):
each plane has its own mem_attr_array, and attributes like NO_WRITE
and NO_EXEC are enforced by filtering pte_access bits during SPTE
creation.

Changes:
- include/uapi/linux/kvm.h: Add KVM_MEMORY_ATTRIBUTE_NO_WRITE (bit 4)
  and KVM_MEMORY_ATTRIBUTE_NO_EXEC (bit 5). Add struct
  kvm_plane_memory_attributes and KVM_SET_PLANE_MEMORY_ATTRIBUTES
  ioctl (0xd6) for targeting a specific plane's address space.

- virt/kvm/kvm_main.c: Extend kvm_supported_mem_attributes() to
  return NO_WRITE|NO_EXEC when CONFIG_KVM_MAX_NR_VCPU_PLANES is
  enabled. Add KVM_SET_PLANE_MEMORY_ATTRIBUTES ioctl handler that
  validates the target plane and delegates to the existing
  kvm_vm_ioctl_set_mem_attributes() infrastructure.

- arch/x86/kvm/mmu/spte.h: Add kvm_plane_filter_pte_access() helper
  that reads the plane's mem_attr_array for a GFN and strips W/X
  from pte_access when NO_WRITE/NO_EXEC are set.

- arch/x86/kvm/mmu/tdp_mmu.c, arch/x86/kvm/mmu/mmu.c: Wire
  kvm_plane_filter_pte_access() into both TDP and shadow MMU SPTE
  creation paths, filtering pte_access before calling make_spte().
---
 arch/x86/kvm/mmu/mmu.c     |  4 +++-
 arch/x86/kvm/mmu/spte.h    | 33 +++++++++++++++++++++++++++++++++
 arch/x86/kvm/mmu/tdp_mmu.c |  4 +++-
 include/uapi/linux/kvm.h   | 23 +++++++++++++++++++++++
 4 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a0d9a0a33c5f..3b861a42a712 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3107,7 +3107,9 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 		return RET_PF_EMULATE;
 	}
 
-	wrprot = make_spte(vcpu, sp, slot, pte_access, gfn, pfn, *sptep, prefetch,
+	wrprot = make_spte(vcpu, sp, slot,
+			   kvm_plane_filter_pte_access(vcpu, gfn, pte_access),
+			   gfn, pfn, *sptep, prefetch,
 			   false, host_writable, &spte);
 
 	if (*sptep == spte) {
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 13eea94dd212..421836fd3932 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -579,4 +579,37 @@ static inline u64 restore_acc_track_spte(u64 spte)
 void __init kvm_mmu_spte_module_init(void);
 void kvm_mmu_reset_all_pte_masks(void);
 
+/*
+ * Apply per-plane memory protection attributes to pte_access.
+ * If the plane's mem_attr_array has NO_WRITE or NO_EXEC set for a GFN,
+ * strip the corresponding access bits before building the SPTE.
+ */
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+static inline unsigned int kvm_plane_filter_pte_access(struct kvm_vcpu *vcpu,
+						       gfn_t gfn,
+						       unsigned int pte_access)
+{
+	struct kvm_plane *plane = vcpu_to_plane(vcpu);
+	unsigned long attrs;
+
+	if (!plane)
+		return pte_access;
+
+	attrs = kvm_get_plane_memory_attributes(plane, gfn);
+	if (attrs & KVM_MEMORY_ATTRIBUTE_NO_WRITE)
+		pte_access &= ~ACC_WRITE_MASK;
+	if (attrs & KVM_MEMORY_ATTRIBUTE_NO_EXEC)
+		pte_access &= ~ACC_EXEC_MASK;
+
+	return pte_access;
+}
+#else
+static inline unsigned int kvm_plane_filter_pte_access(struct kvm_vcpu *vcpu,
+						       gfn_t gfn,
+						       unsigned int pte_access)
+{
+	return pte_access;
+}
+#endif
+
 #endif
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 4503558211fd..0603445377aa 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1140,7 +1140,9 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
 	if (unlikely(!fault->slot))
 		new_spte = make_mmio_spte(vcpu, iter->gfn, sp->role.access);
 	else
-		wrprot = make_spte(vcpu, sp, fault->slot, sp->role.access, iter->gfn,
+		wrprot = make_spte(vcpu, sp, fault->slot,
+				   kvm_plane_filter_pte_access(vcpu, iter->gfn, sp->role.access),
+				   iter->gfn,
 				   fault->pfn, iter->old_spte, fault->prefetch,
 				   false, fault->map_writable, &new_spte);
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index de670bd836bf..82189353ef35 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1687,6 +1687,29 @@ struct kvm_memory_attributes {
 
 #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
 
+/*
+ * Per-plane memory protection attributes (VM planes / VBS).
+ * These control EPT R/W/X permissions enforced by the hypervisor on
+ * behalf of a higher-privilege plane (e.g., plane-1 restricting plane-0).
+ */
+#define KVM_MEMORY_ATTRIBUTE_NO_WRITE          (1ULL << 4)
+#define KVM_MEMORY_ATTRIBUTE_NO_EXEC           (1ULL << 5)
+
+/*
+ * Set memory attributes on a specific plane's address space.
+ * Used by a higher-privilege plane to restrict a lower-privilege plane's
+ * EPT permissions (e.g., plane-1 making plane-0 kernel text read-only).
+ */
+struct kvm_plane_memory_attributes {
+	__u32 plane;        /* target plane index                        */
+	__u32 flags;        /* must be 0                                 */
+	__u64 address;      /* GPA (page-aligned)                        */
+	__u64 size;         /* size in bytes (page-aligned)              */
+	__u64 attributes;   /* KVM_MEMORY_ATTRIBUTE_NO_WRITE / NO_EXEC   */
+};
+
+#define KVM_SET_PLANE_MEMORY_ATTRIBUTES	_IOW(KVMIO, 0xd6, struct kvm_plane_memory_attributes)
+
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
 #define GUEST_MEMFD_FLAG_MMAP		(1ULL << 0)
 #define GUEST_MEMFD_FLAG_INIT_SHARED	(1ULL << 1)
-- 
2.55.0

