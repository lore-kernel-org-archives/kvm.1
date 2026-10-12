Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9609394462;
	Mon, 12 Oct 2026 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848209; cv=none; b=pSLH3Oo4+hPyuUGQ3WY0L82J9lzocSBr6X5holezmKdzGV74NmLDmfBs5s4SDs25+0IVm/rc5KUx196zWyD2ky0rJqbc6uSpFBe3eZnSYKD36fADIU1v6oT0ZePxL6L1WHbA34Y3706utw8aYXBvxGmp2fK7DxxHyRt224QXy0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848209; c=relaxed/simple;
	bh=amVWWUN5rpHOjWkI1RO+rznJ3bqHpJhiiqIpF15eTjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENG3xqKuJB7at3qAyoI2yR854ycnGLXNQE3R5WsUxOlQw6HRfdpWu+9zLo8eAhT7xG+wR7Rh/l8cGYXTGWg+SMjS/rLOCzTwHRe1TX2RbfribyqYxq8QZbuiFMkQWVKB9qk92PRGjbifg3oCC3eUQjJL/o3Qo+V8IpwQ28M8Krs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmO6XhEx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmO6XhEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7A71F008A4;
	Mon, 12 Oct 2026 23:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848207;
	bh=jZF5PmLSKMhczl4qsvAUjYB8e0P0nm2RYjou6Iamgwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dmO6XhExl8apbtxakG/rQBodXXoHuMwyXpfhuMEy1gDU9hg7FNQ6ReEzgN0zGmFUp
	 sD97uRleIWeDhBuzzCnizjnJuSxDjDZX3vqf/iNvEb5TcwATBUaDf3MAtcnS7QTep5
	 SKlKhWSJAnfJtMzqQNCsmilgEDxeYbJ8aq09eNCm9sPtGbnT05SDebhYM8NvkBz60v
	 Rq+iFodoT0rxk5UD3U1lKVPpk/bM8VGXEg5yrFlrUpEYdfwCjrnpXHtbYQOICWLoU4
	 LJi2AN6BogVNzBMZZIwR3Dyj5shALnMTN9+cz/zOWdteSJqMeIbQE04LbRbbSGll45
	 Bfn2K+NDAI6Nw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 03/27] KVM: VMX: Generalize VPID allocation to be vendor-neutral
Date: Mon, 12 Oct 2026 23:36:14 +0000
Message-ID: <20261012233638.2546339-4-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261012233638.2546339-1-yosry@kernel.org>
References: <20261012233638.2546339-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for sharing with SVM, generalize the VMX VPID allocation
code and move it to common code as a TLB tags allocator. Parameterize
the TLB tags allocator by the number of tags, and allocate the bitmap
dynamically. Opportunisitcally use guards to acquire the lock instead of
spin_{lock/unlock}().

Keep the number of allowed tags capped at VMX's hardware cap, to avoid
allocating a huge bitmap if L0 advertises a huge number of ASIDs to an
L1 KVM. Realistically, the number of actual hardware ASIDs wouldn't be
that large so there is no benefit.

Initialize the TLB tags allocator during hardware setup/unsetup, and
reserve tag=0 during initialziation, similar to how VPID=0 is currently
reserved in the VMX-specific bitmap during hardware setup.

Allow nr=0 to allow allocating all ASIDs to SEV on AMD without failing
hardware setup, if at all possible, in which case any tag allocation
fails (SEV won't use the tag allocator).  The number of tags includes
tag=0, which is not usable. The interface is a little confusing in that
regard, but this will be changed soon when reserved tags are explicitly
introduced.

Keep allocate_vpid() and free_vpid() as wrapper that check enable_vpid
to avoid checking at all callsites, and add init_vpids() and
destroy_vpids() to wrap init/destroy calls as well.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/mmu.h     |  8 +++++
 arch/x86/kvm/mmu/mmu.c | 78 ++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c | 40 +++++-----------------
 arch/x86/kvm/vmx/vmx.h | 28 ++++++++++++---
 4 files changed, 119 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 2ae7f9ed4cf86..de79e002edf8f 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -410,4 +410,12 @@ static inline bool kvm_is_gfn_alias(struct kvm *kvm, gfn_t gfn)
 {
 	return gfn & kvm_gfn_direct_bits(kvm);
 }
+
+typedef unsigned int kvm_tlb_tag_t;
+
+int kvm_init_tlb_tags(unsigned int nr);
+void kvm_destroy_tlb_tags(void);
+kvm_tlb_tag_t kvm_alloc_tlb_tag(void);
+void kvm_free_tlb_tag(kvm_tlb_tag_t tag);
+
 #endif
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index aadd5bdc2c97a..97d49247d9d82 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -8178,6 +8178,84 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
 		vhost_task_stop(kvm->arch.nx_huge_page_recovery_thread);
 }
 
+static struct {
+	spinlock_t	lock;
+	unsigned long	*bitmap;
+	unsigned int	nr;
+} tlb_tags;
+
+int kvm_init_tlb_tags(unsigned int nr)
+{
+	/*
+	 * Limit the number of TLB tags to VMX's hardcoded maximum of 0x10000
+	 * to avoid wasting memory for the bitmap in the unlikely scenario the
+	 * CPU supports an inordinate number of ASIDs (on AMD).  If userspace
+	 * wants to concurrently run tens of thousands of vCPUs, they'll likely
+	 * need a solution that works for both Intel and AMD.
+	 */
+	const unsigned int MAX_NR_TLB_TAGS = VMX_NR_VPIDS;
+
+	if (!nr)
+		return 0;
+
+	if (nr > MAX_NR_TLB_TAGS) {
+		pr_warn_once("Number of TLB tags capped (%u instead of %u)\n",
+			     MAX_NR_TLB_TAGS, nr);
+		nr = MAX_NR_TLB_TAGS;
+	}
+
+	tlb_tags.bitmap = bitmap_zalloc(nr, GFP_KERNEL);
+	if (!tlb_tags.bitmap)
+		return -ENOMEM;
+
+	/*
+	 * 0 is the host's TLB tag for both VMX's VPID and SVM's ASID, and is
+	 * returned on failed allocations (e.g. no more tags left).
+	 */
+	__set_bit(0, tlb_tags.bitmap);
+
+	tlb_tags.nr = nr;
+	spin_lock_init(&tlb_tags.lock);
+	return 0;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init_tlb_tags);
+
+void kvm_destroy_tlb_tags(void)
+{
+	bitmap_free(tlb_tags.bitmap);
+	tlb_tags.bitmap = NULL;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_destroy_tlb_tags);
+
+kvm_tlb_tag_t kvm_alloc_tlb_tag(void)
+{
+	kvm_tlb_tag_t tag;
+
+	if (!tlb_tags.bitmap)
+		return 0;
+
+	guard(spinlock)(&tlb_tags.lock);
+
+	tag = find_first_zero_bit(tlb_tags.bitmap, tlb_tags.nr);
+	if (tag >= tlb_tags.nr)
+		return 0;
+
+	__set_bit(tag, tlb_tags.bitmap);
+	return tag;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_alloc_tlb_tag);
+
+void kvm_free_tlb_tag(kvm_tlb_tag_t tag)
+{
+	if (!tag || WARN_ON_ONCE(tag >= tlb_tags.nr))
+		return;
+
+	guard(spinlock)(&tlb_tags.lock);
+
+	__clear_bit(tag, tlb_tags.bitmap);
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_free_tlb_tag);
+
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 static bool hugepage_test_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
 				int level)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b341af4c6057a..a1caa2bd04d7a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -598,9 +598,6 @@ DEFINE_PER_CPU(struct vmcs *, current_vmcs);
  */
 static DEFINE_PER_CPU(struct list_head, loaded_vmcss_on_cpu);
 
-static DECLARE_BITMAP(vmx_vpid_bitmap, VMX_NR_VPIDS);
-static DEFINE_SPINLOCK(vmx_vpid_lock);
-
 struct vmcs_config vmcs_config __ro_after_init;
 struct vmx_capability vmx_capability __ro_after_init;
 
@@ -4092,31 +4089,6 @@ static void seg_setup(int seg)
 	vmcs_write32(sf->ar_bytes, ar);
 }
 
-int allocate_vpid(void)
-{
-	int vpid;
-
-	if (!enable_vpid)
-		return 0;
-	spin_lock(&vmx_vpid_lock);
-	vpid = find_first_zero_bit(vmx_vpid_bitmap, VMX_NR_VPIDS);
-	if (vpid < VMX_NR_VPIDS)
-		__set_bit(vpid, vmx_vpid_bitmap);
-	else
-		vpid = 0;
-	spin_unlock(&vmx_vpid_lock);
-	return vpid;
-}
-
-void free_vpid(int vpid)
-{
-	if (!enable_vpid || vpid == 0)
-		return;
-	spin_lock(&vmx_vpid_lock);
-	__clear_bit(vpid, vmx_vpid_bitmap);
-	spin_unlock(&vmx_vpid_lock);
-}
-
 static void vmx_msr_bitmap_l01_changed(struct vcpu_vmx *vmx)
 {
 	/*
@@ -8415,6 +8387,8 @@ void vmx_hardware_unsetup(void)
 
 	if (nested)
 		nested_vmx_hardware_unsetup();
+
+	destroy_vpids();
 }
 
 void vmx_vm_destroy(struct kvm *kvm)
@@ -8640,8 +8614,6 @@ __init int vmx_hardware_setup(void)
 	kvm_caps.has_bus_lock_exit = cpu_has_vmx_bus_lock_detection();
 	kvm_caps.has_notify_vmexit = cpu_has_notify_vmexit();
 
-	set_bit(0, vmx_vpid_bitmap); /* 0 is reserved for host */
-
 	if (enable_ept)
 		kvm_mmu_set_ept_masks(enable_ept_ad_bits);
 	else
@@ -8681,6 +8653,10 @@ __init int vmx_hardware_setup(void)
 
 	vmx_set_cpu_caps();
 
+	r = init_vpids();
+	if (r)
+		return r;
+
 	/*
 	 * Configure nested capabilities after core CPU capabilities so that
 	 * nested support can be conditional on base support, e.g. so that KVM
@@ -8688,8 +8664,10 @@ __init int vmx_hardware_setup(void)
 	 */
 	if (nested) {
 		r = nested_vmx_hardware_setup(kvm_vmx_exit_handlers);
-		if (r)
+		if (r) {
+			destroy_vpids();
 			return r;
+		}
 	}
 	vmx_nested_ops.enabled = nested;
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 6c9dd5b2365d5..a8df797163ecc 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -182,7 +182,7 @@ struct nested_vmx {
 	u64 pre_vmenter_ssp;
 	u64 pre_vmenter_ssp_tbl;
 
-	u16 vpid02;
+	kvm_tlb_tag_t vpid02;
 	u16 last_vpid;
 
 	int tsc_autostore_slot;
@@ -256,7 +256,7 @@ struct vcpu_vmx {
 			u32 ar;
 		} seg[8];
 	} segment_cache;
-	int vpid;
+	kvm_tlb_tag_t vpid;
 
 	/* Support for a guest hypervisor (nested VMX) */
 	struct nested_vmx nested;
@@ -297,9 +297,29 @@ struct kvm_vmx {
 	u64 *pid_table;
 };
 
+static __always_inline int init_vpids(void)
+{
+	return enable_vpid ? kvm_init_tlb_tags(VMX_NR_VPIDS) : 0;
+}
+
+static __always_inline void destroy_vpids(void)
+{
+	if (enable_vpid)
+		kvm_destroy_tlb_tags();
+}
+
+static __always_inline kvm_tlb_tag_t allocate_vpid(void)
+{
+	return enable_vpid ? kvm_alloc_tlb_tag() : 0;
+}
+
+static __always_inline void free_vpid(kvm_tlb_tag_t vpid)
+{
+	if (enable_vpid)
+		kvm_free_tlb_tag(vpid);
+}
+
 void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu);
-int allocate_vpid(void);
-void free_vpid(int vpid);
 void vmx_set_constant_host_state(struct vcpu_vmx *vmx);
 void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu);
 void vmx_set_host_fs_gs(struct vmcs_host_state *host, u16 fs_sel, u16 gs_sel,
-- 
2.56.0.385.gd3acb90ef8-goog

