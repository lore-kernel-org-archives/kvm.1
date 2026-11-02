Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641522;
	b=TAbZkV2yy3DXWwmr+g6GmxGvvUtY2m8UfaTDCKeRGv5XuHbUHAI28i7kBkTfheLDVoII
	 PO89wfaefOp0rsxroZY7jvAsbvVd51pGFtyqMticHp1e/BJxNbrQnevWPMjkfJECyoEyc
	 YI6mxFN5vKx6C5yIJJw4/GWv/TRTngmYZPUjarETWcj2ryf3mRPUicU4nd9PBoDrH6LtF
	 GFuANFEbOcQUrcrOU2MVsLMclxVcJukK+eudVT2kJRNnAeTQqtzvql5rxteUrOvnuGpOL
	 /1leweziU2+l7nO3hCfv2MCaXntWNzGKaBvNiPwIT5HiDDaGVDOjqwOqM8cvXkSi0dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641522;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=gTz+zfSafSTg/8FlhG23rE8eZhrjZcbiyz7l+m4X9nM=;
	b=PV0xdkPJoUPECNIN7upyrB2/watDdtrDcJYgCqoY+lCtUr8867VTpl2UPYKgZGNWzA0G
	 /0eQk+MIhXgUkvhU+Tk0HEhumK9hTpAR3LuoGbfqFeEqLF7mO5HkBLogonOvyt6BRwJLN
	 +WdxlvB9Hu64125d9KbVaV1OR7gZh9H4OjsLsVYdsh0V0zh9E3RmefLf4epD9dqTL/BhV
	 VJaIipHVLacuJ74kXmbOFsrBsONlNf2m3K5IsZbmLM5MfHYpLSVw3xRTnDsh6JjmyzkOH
	 2bEFla8KRXsJ8dXlkcxIghS6dhM5ySCdTtz687BpGwCQEsynEKFV+lnyvLfNvhJW5mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fB2YZpfk;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC825606E03E
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC825606E03E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fB2YZpfk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTz+zfSafSTg/8FlhG23rE8eZhrjZcbiyz7l+m4X9nM=;
	b=fB2YZpfkD6EqZjXgHsodnBsIUUc4Ps53uBnOdw0ffUjw/hMQV23P7nq5L0hac5ucE3LZ0Z
	X/S5xTyX9RUfcanI//4fBxh6MU0ZPEPgPsQolXBHZR3xSVmgeyfXMFwSYvTpC0PtSbLI15
	N0rM6SVIXVe1ZmAwPD4XThk8z3K19k4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-gwM268WBMx-En4d1BDdUbQ-1; Mon,
 02 Nov 2026 12:45:14 -0500
X-MC-Unique: gwM268WBMx-En4d1BDdUbQ-1
X-Mimecast-MFC-AGG-ID: gwM268WBMx-En4d1BDdUbQ_1793641513
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5FB719560A2;
	Mon,  2 Nov 2026 17:45:13 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 514231956087;
	Mon,  2 Nov 2026 17:45:13 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 17/45] KVM: Introduce NR/NW/NX memory attributes
Date: Mon,  2 Nov 2026 12:44:44 -0500
Message-ID: <20261102174512.8903-1-pbonzini@redhat.com>
In-Reply-To: <20261102174130.8779-1-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Nicolas Saenz Julienne <nsaenz@amazon.com>

Introduce memory attributes to map guest physical memory regions as
non-readable, non-writable, and/or non-executable. Only a subset of flag
combinations is supported. Notably write and exec permissions require
read permission, and memory protection attributes are incompatible with
private memory.

As mentioned in 5a475554db1e ("KVM: Introduce per-page memory attributes",
2023-11-13), bits 0-2 of the memory attributes were reserved for RWX
protection; they are negated to support current memory attribute users
which use 0 to indicate no special treatment.  Since 0 is not available,
a non-negated version of the flags would need an extra bit to express
no-access (R=0/W=0/X=0) mappings.

Unfortunately this precaution did not age too well; KVM now supports
MBEC/GMET and adding mode-based memory protections will require a
non-contiguous bit.  But that's something left for later.

Different architectures may have different limitations on the set of
valid protections, for example execution-only and XU=0 mappings are
supported by Intel but not AMD processors[1].  So, add an architecture-specific
callback and add a basic implementation for x86.

[1] When adding support for MBEC/GMET, since NX would remain to mean no
    execution at all, it is possible to use either an NXS bit or two
    separate NXS/NXU bits in addition to NX.  The former would only
    support permissions that are available with either MBEC or GMET.

Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://patch.msgid.link/20260918135030.171564-14-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/virt/kvm/api.rst  | 29 +++++++++++++--
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/Kconfig            |  2 +-
 arch/x86/kvm/mmu/mmu.c          | 63 ++++++++++++++++++++++++---------
 arch/x86/kvm/x86.c              |  2 --
 include/linux/kvm_host.h        | 28 +++++++++++++++
 include/uapi/linux/kvm.h        |  3 ++
 virt/kvm/kvm_main.c             | 46 ++++++++++++++++++++----
 8 files changed, 145 insertions(+), 29 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index d0f91687bdb9..ac8cd51bdada 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6445,15 +6445,38 @@ of guest physical memory.
 	__u64 flags;
   };
 
+  #define KVM_MEMORY_ATTRIBUTE_NR                (1ULL << 0)
+  #define KVM_MEMORY_ATTRIBUTE_NW                (1ULL << 1)
+  #define KVM_MEMORY_ATTRIBUTE_NX                (1ULL << 2)
   #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
 
 The address and size must be page aligned.  The supported attributes can be
 retrieved via ioctl(KVM_CHECK_EXTENSION) on KVM_CAP_MEMORY_ATTRIBUTES.  If
 executed on a VM, KVM_CAP_MEMORY_ATTRIBUTES precisely returns the attributes
 supported by that VM.  If executed at system scope, KVM_CAP_MEMORY_ATTRIBUTES
-returns all attributes supported by KVM.  The only attribute defined at this
-time is KVM_MEMORY_ATTRIBUTE_PRIVATE, which marks the associated gfn as being
-guest private memory.
+returns all attributes supported by KVM.  The attribute defined at this
+time are:
+
+ - KVM_MEMORY_ATTRIBUTE_NR/NW/NX - Respectively marks the memory region as
+   non-read, non-write and/or non-exec.  Note that write-only, exec-only
+   and write-exec mappings are not supported.  When accesses to page are
+   denied by memory attributes, KVM **can** inform userspace through a
+   KVM_EXIT_MEMORY_FAULT exit, and userspace is allowed to restart the
+   VM after fixing the issue.
+
+   Note however that while KVM tries to report failures as
+   KVM_EXIT_MEMORY_FAULT in as many cases as possible, in some cases such
+   accesses are not recoverable.  KVM can report these accesses in the same
+   way as accesses to unmapped regions, for example as KVM_EXIT_SHUTDOWN,
+   KVM_EXIT_INTERNAL_ERROR, inject exceptions, or even by returning -EIO.
+   For exit reasons other than KVM_EXIT_MEMORY_FAULT, resetting the
+   attribute does not guarantee that execution can safely resume.
+
+   These attributes must therefore not be used as a replacement for
+   userfaultfd.
+
+ - KVM_MEMORY_ATTRIBUTE_PRIVATE - Which marks the associated gfn as being guest
+   private memory.
 
 Note, there is no "get" API.  Userspace is responsible for explicitly tracking
 the state of a gfn/page as needed.
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 25256d59cfde..6a35fd384a74 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1882,6 +1882,7 @@ enum kvm_intr_type {
 #define kvm_arch_has_gmem_convert() (!!kvm_x86_ops.gmem_make_private)
 #endif
 
+#define kvm_arch_has_memory_protection_attr(kvm) (!(kvm)->arch.has_private_mem)
 #define kvm_arch_has_readonly_mem(kvm) (!(kvm)->arch.has_protected_state)
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 1719059570fb..3cde8bc5ff01 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -44,6 +44,7 @@ config KVM_X86
 	select KVM_GENERIC_PRE_FAULT_MEMORY
 	select KVM_WERROR if WERROR
 	select KVM_GUEST_MEMFD if X86_64
+	select KVM_VM_MEMORY_ATTRIBUTES
 
 config KVM
 	tristate "Kernel-based Virtual Machine (KVM) support"
@@ -79,7 +80,6 @@ config KVM_WERROR
 config KVM_PRIVATE_MEMATTR_VM
 	bool "Enable per-VM PRIVATE vs. SHARED attributes (for CoCo VMs)"
 	depends on KVM_SW_PROTECTED_VM || KVM_INTEL_TDX || KVM_AMD_SEV
-	select KVM_VM_MEMORY_ATTRIBUTES
 	default KVM_INTEL_TDX || KVM_AMD_SEV
 	help
 	  Enable support for tracking PRIVATE vs. SHARED memory using per-VM
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b89517794034..6348669bf882 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -8190,7 +8190,6 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
 		vhost_task_stop(kvm->arch.nx_huge_page_recovery_thread);
 }
 
-#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 static bool hugepage_test_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
 				int level)
 {
@@ -8213,19 +8212,27 @@ bool kvm_arch_pre_set_vm_memory_attributes(struct kvm *kvm,
 					   struct kvm_gfn_range *range)
 {
 	struct kvm_memory_slot *slot = range->slot;
+	bool flush = false;
 	int level;
 
 	/*
-	 * Zap SPTEs even if the slot can't be mapped PRIVATE.  KVM x86 only
-	 * supports KVM_MEMORY_ATTRIBUTE_PRIVATE, and so it *seems* like KVM
-	 * can simply ignore such slots.  But if userspace is making memory
-	 * PRIVATE, then KVM must prevent the guest from accessing the memory
-	 * as shared.  And if userspace is making memory SHARED and this point
-	 * is reached, then at least one page within the range was previously
-	 * PRIVATE, i.e. the slot's possible hugepage ranges are changing.
-	 * Zapping SPTEs in this case ensures KVM will reassess whether or not
-	 * a hugepage can be used for affected ranges.
+	 * For KVM_MEMORY_ATTRIBUTE_PRIVATE:
+	 *  Zap SPTEs even if the slot can't be mapped PRIVATE.  KVM x86 only
+	 *  supports KVM_MEMORY_ATTRIBUTE_PRIVATE, and so it *seems* like KVM
+	 *  can simply ignore such slots.  But if userspace is making memory
+	 *  PRIVATE, then KVM must prevent the guest from accessing the memory
+	 *  as shared.  And if userspace is making memory SHARED and this point
+	 *  is reached, then at least one page within the range was previously
+	 *  PRIVATE, i.e. the slot's possible hugepage ranges are changing.
+	 *  Zapping SPTEs in this case ensures KVM will reassess whether or not
+	 *  a hugepage can be used for affected ranges.
+	 *
+	 * For KVM_MEMORY_ATTRIBUTE_NR/NW/NX:
+	 *  Zap even when loosening restrictions R=>RW, which is not strictly
+	 *  necessary, but will allow KVM to reasses whether a hugepage can be
+	 *  used for the affected pages.
 	 */
+
 	if (WARN_ON_ONCE(range->end <= range->start))
 		return false;
 
@@ -8259,12 +8266,17 @@ bool kvm_arch_pre_set_vm_memory_attributes(struct kvm *kvm,
 	}
 
 	/* Unmap the old attribute page. */
-	if (range->arg.attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE)
-		range->attr_filter = KVM_FILTER_SHARED;
-	else
-		range->attr_filter = KVM_FILTER_PRIVATE;
+	range->attr_filter = KVM_FILTER_SHARED;
+	if ((kvm_supported_vm_mem_attributes(kvm) & ~KVM_MEMORY_ATTRIBUTE_PRIVATE) ||
+	    (range->arg.attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE))
+		flush |= kvm_unmap_gfn_range(kvm, range);
 
-	return kvm_unmap_gfn_range(kvm, range);
+	range->attr_filter = KVM_FILTER_PRIVATE;
+	if (kvm->arch.has_private_mem &&
+	    !(range->arg.attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE))
+		flush |= kvm_unmap_gfn_range(kvm, range);
+
+	return flush;
 }
 
 
@@ -8386,4 +8398,23 @@ void kvm_mmu_init_memslot_memory_attributes(struct kvm *kvm,
 		}
 	}
 }
-#endif
+
+/* The bits are flipped but remain in the same position.  */
+#define KVM_PROT_READ  KVM_MEMORY_ATTRIBUTE_NR
+#define KVM_PROT_WRITE KVM_MEMORY_ATTRIBUTE_NW
+#define KVM_PROT_EXEC  KVM_MEMORY_ATTRIBUTE_NX
+
+bool kvm_arch_mem_attributes_supported_prot(struct kvm *kvm, unsigned long attrs)
+{
+	unsigned long prot = (attrs & KVM_MEMORY_ATTRIBUTE_PROT) ^ KVM_MEMORY_ATTRIBUTE_PROT;
+
+        /* Private memory and access permissions are incompatible */
+	if (attrs & KVM_MEMORY_ATTRIBUTE_PRIVATE)
+		return false;
+
+	/* For now do now support exec-only, even though EPT can handle it.  */
+	if (prot && !(prot & KVM_PROT_READ))
+		return false;
+
+	return true;
+}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c7970bcfdc24..63d48ac4e1c6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10263,9 +10263,7 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
 		}
 	}
 
-#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 	kvm_mmu_init_memslot_memory_attributes(kvm, slot);
-#endif
 
 	if (kvm_page_track_create_memslot(kvm, slot, npages))
 		goto out_free;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3d0293ebc864..8442fb29a1ee 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -726,6 +726,15 @@ static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
 }
 #endif
 
+#ifdef kvm_arch_has_memory_protection_attr
+bool kvm_arch_mem_attributes_supported_prot(struct kvm *kvm, unsigned long attrs);
+#else
+static inline bool kvm_arch_has_memory_protection_attr(struct kvm *kvm)
+{
+	return false;
+}
+#endif
+
 #ifndef kvm_arch_has_readonly_mem
 static inline bool kvm_arch_has_readonly_mem(struct kvm *kvm)
 {
@@ -2577,12 +2586,31 @@ static inline bool kvm_memslot_is_gmem_only(const struct kvm_memory_slot *slot)
 	return slot->flags & KVM_MEMSLOT_GMEM_ONLY;
 }
 
+#define KVM_MEMORY_ATTRIBUTE_PROT \
+	(KVM_MEMORY_ATTRIBUTE_NR | KVM_MEMORY_ATTRIBUTE_NW | KVM_MEMORY_ATTRIBUTE_NX)
+
+static inline bool kvm_mem_attributes_may_read(u64 attrs)
+{
+	return !(attrs & KVM_MEMORY_ATTRIBUTE_NR);
+}
+
+static inline bool kvm_mem_attributes_may_write(u64 attrs)
+{
+	return !(attrs & KVM_MEMORY_ATTRIBUTE_NW);
+}
+
+static inline bool kvm_mem_attributes_may_exec(u64 attrs)
+{
+	return !(attrs & KVM_MEMORY_ATTRIBUTE_NX);
+}
+
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 static inline unsigned long kvm_get_vm_memory_attributes(struct kvm *kvm, gfn_t gfn)
 {
 	return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
 }
 
+bool kvm_vm_mem_attributes_valid(struct kvm *kvm, unsigned long attrs);
 bool kvm_range_has_vm_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 					unsigned long mask, unsigned long attrs);
 bool kvm_arch_pre_set_vm_memory_attributes(struct kvm *kvm,
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 4e0bab3db95c..5cced8e4aa21 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1673,6 +1673,9 @@ struct kvm_memory_attributes2 {
 	__u64 reserved[11];
 };
 
+#define KVM_MEMORY_ATTRIBUTE_NR		       (1ULL << 0)
+#define KVM_MEMORY_ATTRIBUTE_NW		       (1ULL << 1)
+#define KVM_MEMORY_ATTRIBUTE_NX		       (1ULL << 2)
 #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
 
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 17341c689d11..717d7aec9a6c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2473,13 +2473,28 @@ static u64 kvm_supports_private_mem(struct kvm *kvm)
 #define kvm_supports_private_mem(kvm) false
 #endif
 
+
+#ifdef kvm_arch_has_memory_protection_attr
+static u64 kvm_supports_memory_protection_attr(struct kvm *kvm)
+{
+	return !kvm || kvm_arch_has_memory_protection_attr(kvm);
+}
+#else
+#define kvm_supports_private_mem(kvm) false
+#endif
+
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 u64 kvm_supported_vm_mem_attributes(struct kvm *kvm)
 {
-	if (gmem_in_place_conversion || !kvm_supports_private_mem(kvm))
-		return 0;
+	u64 supported_attrs = 0;
 
-	return KVM_MEMORY_ATTRIBUTE_PRIVATE;
+	if (kvm_supports_memory_protection_attr(kvm))
+		supported_attrs |= KVM_MEMORY_ATTRIBUTE_PROT;
+
+	if (!gmem_in_place_conversion && kvm_supports_private_mem(kvm))
+		supported_attrs |= KVM_MEMORY_ATTRIBUTE_PRIVATE;
+
+	return supported_attrs;
 }
 
 /*
@@ -2600,9 +2615,7 @@ static bool kvm_pre_set_vm_memory_attributes(struct kvm *kvm,
 {
 	/*
 	 * Unconditionally add the range to the invalidation set, regardless of
-	 * whether or not the arch callback actually needs to zap SPTEs.  E.g.
-	 * if KVM supports RWX attributes in the future and the attributes are
-	 * going from R=>RW, zapping isn't strictly necessary.  Unconditionally
+	 * whether or not the arch callback actually needs to zap SPTEs.  Always
 	 * adding the range allows KVM to require that MMU invalidations add at
 	 * least one range between begin() and end(), e.g. allows KVM to detect
 	 * bugs where the add() is missed.  Relaxing the rule *might* be safe,
@@ -2678,6 +2691,25 @@ static int kvm_set_vm_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 
 	return r;
 }
+
+bool __weak kvm_arch_mem_attributes_supported_prot(struct kvm *kvm, unsigned long attrs)
+{
+	WARN_ONCE(true, "KVM_MEMORY_ATTRIBUTE_PROT requires kvm_arch_mem_attributes_supported_prot()");
+	return false;
+}
+
+bool kvm_vm_mem_attributes_valid(struct kvm *kvm, unsigned long attrs)
+{
+	if (attrs & ~kvm_supported_vm_mem_attributes(kvm))
+		return false;
+
+	if ((attrs & KVM_MEMORY_ATTRIBUTE_PROT) &&
+	    !kvm_arch_mem_attributes_supported_prot(kvm, attrs))
+		return false;
+
+	return true;
+}
+
 static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
 					   struct kvm_memory_attributes *attrs)
 {
@@ -2686,7 +2718,7 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
 	/* flags is currently not used. */
 	if (attrs->flags)
 		return -EINVAL;
-	if (attrs->attributes & ~kvm_supported_vm_mem_attributes(kvm))
+	if (!kvm_vm_mem_attributes_valid(kvm, attrs->attributes))
 		return -EINVAL;
 	if (attrs->size == 0 || attrs->address + attrs->size < attrs->address)
 		return -EINVAL;
-- 
2.52.0


