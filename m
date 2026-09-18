Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F2E44AB8A
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719369; cv=none; b=k//O0+cJAxWTpn323RaN7rfAb4IZO+UVlzsjjsoyuDF+dI19mYIW751DovY1CvmJ5Ls9gCt5vcmj33hCxUlVLe3WQQDrKc6V8XKt0gKR/TdUGFboMN5vXQXREuRyrqNfA3udSx6xbr1kfmCRVmdG7GyBJi7TRiOcL61sPM09Wpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719369; c=relaxed/simple;
	bh=YU1RSB3tZW4H9GuENgsxEPTL++6T6u9XlO8HNcE2XWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tmtrjc1KYd+QZpPuQg5JmadxPeVFlP5jerBBOHxNgHa5j0g6NykPBXjhFgTDhPU3UgFfUj9FSLc/7pzGvCrce7l5q4TrKdZcWZNAiTHoeWtwOoCfriNTlvEa3Z/Pvg13RARUEGIfmzt8fbLkP9TwcBjEJ99myHjRObTCP+9liDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xig2iW/h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xig2iW/h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789719359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sR53KYSP3YZe5CDWYlXVBqA1sDrK0TUryY4DDJSrDG4=;
	b=Xig2iW/hbibXzCwRnb2+VBU2nUf9s78IqaWgt0nTYIbvQAg6hGFKmCk5ohz3fUdGVJVHPB
	48khfbwktncUDOtCFXlGr9SjtQBGvx3BrRyiC/x7TVPB30mSg6tQrwluU+cKeVK4L+Ox3/
	R1ppjOrCUnPpwTdj6Tv3HehX17GKhI8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-JNQ_VpuqNQmDIQplP0LB3w-1; Fri,
 18 Sep 2026 04:15:56 -0400
X-MC-Unique: JNQ_VpuqNQmDIQplP0LB3w-1
X-Mimecast-MFC-AGG-ID: JNQ_VpuqNQmDIQplP0LB3w_1789719355
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E96A19560BB;
	Fri, 18 Sep 2026 08:15:55 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B73430001A2;
	Fri, 18 Sep 2026 08:15:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH v2 12/28] KVM: Introduce NR/NW/NX memory attributes
Date: Fri, 18 Sep 2026 04:15:27 -0400
Message-ID: <20260918081543.139871-13-pbonzini@redhat.com>
In-Reply-To: <20260918081543.139871-1-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
index abc2ff1f8c84..81126ac11bf8 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6414,15 +6414,23 @@ of guest physical memory.
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
index c619552740a8..52c432f9bc66 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1853,6 +1853,7 @@ enum kvm_intr_type {
 	 (!!in_nmi() == ((vcpu)->arch.handling_intr_from_guest == KVM_HANDLING_NMI)))
 
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+#define kvm_arch_has_memory_protection_attributes(kvm) (!(kvm) || !(kvm)->arch.has_private_mem)
 #define kvm_arch_has_private_mem(kvm) (!(kvm) || (kvm)->arch.has_private_mem)
 #endif
 
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 538ed1e80332..4c630fd64fd2 100644
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
 	select HAVE_KVM_ARCH_GMEM_CONVERT
 	select HAVE_KVM_ARCH_GMEM_RECLAIM
 	select HAVE_KVM_ARCH_GMEM_INVALIDATE
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 77d9c62d2a07..797b18201d98 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -8104,7 +8104,6 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
 		vhost_task_stop(kvm->arch.nx_huge_page_recovery_thread);
 }
 
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 static bool hugepage_test_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
 				int level)
 {
@@ -8130,16 +8129,23 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
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
+	 *  Zap even when loosening restrictions R=>RW, which is nost strictly
+	 *  necessary, but will allow KVM to reasses whether a hugepage can be
+	 *  used for the affected pages.
 	 */
+
 	if (WARN_ON_ONCE(range->end <= range->start))
 		return false;
 
@@ -8299,4 +8305,23 @@ void kvm_mmu_init_memslot_memory_attributes(struct kvm *kvm,
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
index c10b3fd48b65..416b2ebf1c70 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10163,9 +10163,7 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
 		}
 	}
 
-#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 	kvm_mmu_init_memslot_memory_attributes(kvm, slot);
-#endif
 
 	if (kvm_page_track_create_memslot(kvm, slot, npages))
 		goto out_free;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index acffb2f79b3e..c215e3bdf043 100644
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
@@ -2567,7 +2569,25 @@ static inline bool kvm_memslot_is_gmem_only(const struct kvm_memory_slot *slot)
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
@@ -2579,6 +2599,7 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 					struct kvm_gfn_range *range);
 bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 					 struct kvm_gfn_range *range);
+bool kvm_mem_attributes_valid(struct kvm *kvm, unsigned long attrs);
 u64 kvm_supported_mem_attributes(struct kvm *kvm);
 
 static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
@@ -2586,6 +2607,11 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
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
index c23f1ea62eaf..ffbc68a6e2c9 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1657,6 +1657,9 @@ struct kvm_memory_attributes {
 	__u64 flags;
 };
 
+#define KVM_MEMORY_ATTRIBUTE_NR		       (1ULL << 0)
+#define KVM_MEMORY_ATTRIBUTE_NW		       (1ULL << 1)
+#define KVM_MEMORY_ATTRIBUTE_NX		       (1ULL << 2)
 #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
 
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 85fdd33c51ab..f98104169862 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2422,10 +2422,15 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
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
@@ -2599,6 +2604,25 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 
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
@@ -2607,7 +2631,7 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
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


