Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842F6381AE4
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225715; cv=none; b=fqI7kqqU3zo/ZrDoZEYAzNVEjjtVTsHMjMCqdVWq5q0ghhV3HlZlCBUMhsGuILYHNw+LyFvw2ti0Z8/ZMB7HPtc5dzkBq1xltdj2yPFupvmbRYN+omtEEpEmryGBWB1TqTpoZ6Q1JI0V52U4OZDZ14EXgGI895UPE38gnFJTtt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225715; c=relaxed/simple;
	bh=eEza9SAclNDjEeSbNvKxGGfBlR++oqUO6WMBMW+L2pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Co3zEonqSyEFxunZlsUUtlwp9bOk6VRG6oJBhvtz4mYYlN1MaN35fZ+fT8xmcxgU+RdaCPk9Gu7iGUFAYJPt2EsMyEaDuwyes2fFU+PVQdO6X8ahbKryTy0qUjYeF8eLa7LCu2x4QaHGP8FmhmpWB3PTWT6EDLsZ5SIpabXZlN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YvXOVWdF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvXOVWdF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784225708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ywHgIy2wj+S8WnAk9F643i7jhZecJqHJ9G3mfZTAtw=;
	b=YvXOVWdF95amuzZCer+MT4Acvastd2rGPhdMg22bgca7HrQHy6Ct3AxjRQ61E1HMVhFBhk
	nxJCghEkUlzjQPyMFmZXCckrqf/YgQJpoKqdkOqfyIhrioqHTWl1QIxKz09KcukyV8Y3ca
	HrELBt2m4YDWd5fMqdfW9tSRDgKUtDU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-QEAVmtG_OeCjROLMAosSxQ-1; Thu,
 16 Jul 2026 14:15:04 -0400
X-MC-Unique: QEAVmtG_OeCjROLMAosSxQ-1
X-Mimecast-MFC-AGG-ID: QEAVmtG_OeCjROLMAosSxQ_1784225703
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A92591800677;
	Thu, 16 Jul 2026 18:15:03 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 38872195604E;
	Thu, 16 Jul 2026 18:15:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com
Subject: [PATCH 09/24] KVM: Introduce NR/NW/NX memory attributes
Date: Thu, 16 Jul 2026 14:14:41 -0400
Message-ID: <20260716181456.402786-10-pbonzini@redhat.com>
In-Reply-To: <20260716181456.402786-1-pbonzini@redhat.com>
References: <20260716181456.402786-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
---
 Documentation/virt/kvm/api.rst  | 14 +++++++---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/Kconfig            |  4 +--
 arch/x86/kvm/mmu/mmu.c          | 47 +++++++++++++++++++++++++--------
 arch/x86/kvm/x86.c              |  2 --
 include/linux/kvm_host.h        | 28 +++++++++++++++++++-
 include/uapi/linux/kvm.h        |  3 +++
 virt/kvm/kvm_main.c             | 32 +++++++++++++++++++---
 8 files changed, 107 insertions(+), 24 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 1be1bc0de5d2..d11142c5eca1 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6394,15 +6394,23 @@ of guest physical memory.
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
+   non-read, non-write and/or non-exec.  Note that write-only, exec-only and
+   write-exec mappings are not supported.
+ - KVM_MEMORY_ATTRIBUTE_PRIVATE - Which marks the associated gfn as being guest
+   private memory.
 
 Note, there is no "get" API.  Userspace is responsible for explicitly tracking
 the state of a gfn/page as needed.
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 5d329fbb8acb..268e98a36643 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2005,6 +2005,7 @@ enum kvm_intr_type {
 	 (!!in_nmi() == ((vcpu)->arch.handling_intr_from_guest == KVM_HANDLING_NMI)))
 
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#define kvm_arch_has_memory_protection_attributes(kvm) (!(kvm) || !(kvm)->arch.has_private_mem)
 #define kvm_arch_has_private_mem(kvm) (!(kvm) || (kvm)->arch.has_private_mem)
 #endif
 
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 801bf9e520db..d9c5bd71e1c5 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -48,6 +48,7 @@ config KVM_X86
 	select KVM_GENERIC_PRE_FAULT_MEMORY
 	select KVM_WERROR if WERROR
 	select KVM_GUEST_MEMFD if X86_64
+	select KVM_GENERIC_MEMORY_ATTRIBUTES
 
 config KVM
 	tristate "Kernel-based Virtual Machine (KVM) support"
@@ -84,7 +85,6 @@ config KVM_SW_PROTECTED_VM
 	bool "Enable support for KVM software-protected VMs"
 	depends on EXPERT
 	depends on KVM_X86 && X86_64
-	select KVM_GENERIC_MEMORY_ATTRIBUTES
 	help
 	  Enable support for KVM software-protected VMs.  Currently, software-
 	  protected VMs are purely a development and testing vehicle for
@@ -135,7 +135,6 @@ config KVM_INTEL_TDX
 	bool "Intel Trust Domain Extensions (TDX) support"
 	default y
 	depends on INTEL_TDX_HOST
-	select KVM_GENERIC_MEMORY_ATTRIBUTES
 	select HAVE_KVM_ARCH_GMEM_POPULATE
 	help
 	  Provides support for launching Intel Trust Domain Extensions (TDX)
@@ -159,7 +158,6 @@ config KVM_AMD_SEV
 	depends on KVM_AMD && X86_64
 	depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
 	select ARCH_HAS_CC_PLATFORM
-	select KVM_GENERIC_MEMORY_ATTRIBUTES
 	select HAVE_KVM_ARCH_GMEM_PREPARE
 	select HAVE_KVM_ARCH_GMEM_INVALIDATE
 	select HAVE_KVM_ARCH_GMEM_POPULATE
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 80f581afb6a0..b6463b0b0b6d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -8056,7 +8056,6 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
 		vhost_task_stop(kvm->arch.nx_huge_page_recovery_thread);
 }
 
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 static bool hugepage_test_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
 				int level)
 {
@@ -8088,16 +8087,23 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 	}
 
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
+	 *  Zap even when loosening restrictions R=>RW, which is nost strictly
+	 *  necessary, but will allow KVM to reasses whether a hugepage can be
+	 *  used for the affected pages.
 	 */
+
 	if (WARN_ON_ONCE(range->end <= range->start))
 		return false;
 
@@ -8262,4 +8268,23 @@ void kvm_mmu_init_memslot_memory_attributes(struct kvm *kvm,
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
index 352d289076f6..e2240f817c22 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10084,9 +10084,7 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
 		}
 	}
 
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 	kvm_mmu_init_memslot_memory_attributes(kvm, slot);
-#endif
 
 	if (kvm_page_track_create_memslot(kvm, slot, npages))
 		goto out_free;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4731e8a9e6db..2dd1b65799e4 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -722,7 +722,9 @@ static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
 }
 #endif
 
-#ifndef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+bool kvm_arch_mem_attributes_supported_prot(struct kvm *kvm, unsigned long attrs);
+#else
 static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
 {
 	return false;
@@ -2540,7 +2542,25 @@ static inline bool kvm_memslot_is_gmem_only(const struct kvm_memory_slot *slot)
 	return slot->flags & KVM_MEMSLOT_GMEM_ONLY;
 }
 
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
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#define KVM_MEMORY_ATTRIBUTE_PROT \
+	(KVM_MEMORY_ATTRIBUTE_NR | KVM_MEMORY_ATTRIBUTE_NW | KVM_MEMORY_ATTRIBUTE_NX)
+
 static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
 {
 	return xa_to_value(xa_load(&kvm->mem_attr_array, gfn));
@@ -2552,6 +2572,7 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 					struct kvm_gfn_range *range);
 bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 					 struct kvm_gfn_range *range);
+bool kvm_mem_attributes_valid(struct kvm *kvm, unsigned long attrs);
 u64 kvm_supported_mem_attributes(struct kvm *kvm);
 
 static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
@@ -2559,6 +2580,11 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 	return kvm_get_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
 }
 #else
+static inline bool kvm_mem_attributes_valid(struct kvm *kvm,
+					       unsigned long attrs)
+{
+	return false;
+}
 static inline u64 kvm_supported_mem_attributes(struct kvm *kvm)
 {
 	return 0;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 3b235e953923..6a96eb3218dc 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1653,6 +1653,9 @@ struct kvm_memory_attributes {
 	__u64 flags;
 };
 
+#define KVM_MEMORY_ATTRIBUTE_NR		       (1ULL << 0)
+#define KVM_MEMORY_ATTRIBUTE_NW		       (1ULL << 1)
+#define KVM_MEMORY_ATTRIBUTE_NX		       (1ULL << 2)
 #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
 
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index fa4473d7c920..a47b62c2c9ce 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2421,10 +2421,15 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 u64 kvm_supported_mem_attributes(struct kvm *kvm)
 {
-	if (kvm_arch_has_private_mem(kvm))
-		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
+	u64 supported_attrs = 0;
 
-	return 0;
+	if (kvm_arch_has_memory_protection_attributes(kvm))
+		supported_attrs |= KVM_MEMORY_ATTRIBUTE_PROT;
+
+	if (kvm_arch_has_private_mem(kvm))
+		supported_attrs |= KVM_MEMORY_ATTRIBUTE_PRIVATE;
+
+	return supported_attrs;
 }
 
 /*
@@ -2596,6 +2601,25 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 
 	return r;
 }
+
+bool __weak kvm_arch_mem_attributes_supported_prot(struct kvm *kvm, unsigned long attrs)
+{
+	WARN_ON_ONCE("KVM_MEMORY_ATTRIBUTE_PROT requires kvm_arch_mem_attributes_supported_prot()");
+	return false;
+}
+
+bool kvm_mem_attributes_valid(struct kvm *kvm, unsigned long attrs)
+{
+	if (attrs & ~kvm_supported_mem_attributes(kvm))
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
@@ -2604,7 +2628,7 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
 	/* flags is currently not used. */
 	if (attrs->flags)
 		return -EINVAL;
-	if (attrs->attributes & ~kvm_supported_mem_attributes(kvm))
+	if (!kvm_mem_attributes_valid(kvm, attrs->attributes))
 		return -EINVAL;
 	if (attrs->size == 0 || attrs->address + attrs->size < attrs->address)
 		return -EINVAL;
-- 
2.52.0


