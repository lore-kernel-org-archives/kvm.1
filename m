Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FB02192F9;
	Tue, 28 Jul 2026 00:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198966; cv=none; b=A6n6dlEfCx3DRAzbP7lP1IEt28dt1or31Jbbt8mEtypbSdKA//tDGIAvqBZrs1IO5UovD+o1v6Tbqlchf69P53GnGXVVoavjyR8pdh2TcLu1jpyr7kY4rd94k9uPVPezaqpTluXE4eJ8RryzKHpnnIt++OvhTi1InwxU9kk/SAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198966; c=relaxed/simple;
	bh=9yNiQU0LmNKLyAUp7ER+iCeX6P3w7zQHVHejxVDF/+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDv5aJJROGkeEXM8cYn8cF6VKFXGF0xyOTHfCy3xw5/s/WD2DLiFPxMyvSJZ3JbtJvotjORzOlLKashYZLLEiPazthaMfPLBU1l2zmW3Pswt8sBxD7V3jFZN7LgxxBXJfa+cpdE/Y3Mrp17UymXJ9Qj0vxJ4iboHXmxKXXoLsjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAzJfWIP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAzJfWIP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C332C1F00A3F;
	Tue, 28 Jul 2026 00:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198965;
	bh=Hr3hQ3exy/0QFE3N/Kwj9ooRGwezCw45AF9aMr5GeQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CAzJfWIPzL8uyYlWkH89tI93ei1jr9Q5Lva/xt59J2m6TPrOHioNji5J28vl/oTfj
	 rtgWT4nD6KFcaGvefDiq8JKUoMRUH5PlpcxfANVivv78CH2582V8XCtNnrBKuaDqTx
	 sKkpjAY+GNTTPqYmm6/cbLP6BxsimyZuk2n1oJL7AN5hRVlyFkDtVL1JzZBQLR8k02
	 ehRLdNVUiuzT9ObfeuvfGyp0T3t3B11b4eVxf27ocw+40PjlCqXxI8lBfsjjvbYd6b
	 nNjO+W76pcRxE3tuRRecX3ngUS+S9Q1YVOMx7KeRW54gtKrnK8LJzJpFo6VD89AGwX
	 SRFpR8jej9lOg==
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
Subject: [PATCH v1 03/28] KVM: VMX: Generalize VPID allocation to be vendor-neutral
Date: Tue, 28 Jul 2026 00:35:32 +0000
Message-ID: <20260728003557.1136583-4-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260728003557.1136583-1-yosry@kernel.org>
References: <20260728003557.1136583-1-yosry@kernel.org>
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
index ecf9e39aed5a3..d9edba502cac7 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -8069,6 +8069,84 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
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
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 static bool hugepage_test_mixed(struct kvm_memory_slot *slot, gfn_t gfn,
 				int level)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e4b9ac7fed9f0..ec28da31dd96b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -595,9 +595,6 @@ DEFINE_PER_CPU(struct vmcs *, current_vmcs);
  */
 static DEFINE_PER_CPU(struct list_head, loaded_vmcss_on_cpu);
 
-static DECLARE_BITMAP(vmx_vpid_bitmap, VMX_NR_VPIDS);
-static DEFINE_SPINLOCK(vmx_vpid_lock);
-
 struct vmcs_config vmcs_config __ro_after_init;
 struct vmx_capability vmx_capability __ro_after_init;
 
@@ -4077,31 +4074,6 @@ static void seg_setup(int seg)
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
@@ -8486,6 +8458,8 @@ void vmx_hardware_unsetup(void)
 
 	if (nested)
 		nested_vmx_hardware_unsetup();
+
+	destroy_vpids();
 }
 
 void vmx_vm_destroy(struct kvm *kvm)
@@ -8711,8 +8685,6 @@ __init int vmx_hardware_setup(void)
 	kvm_caps.has_bus_lock_exit = cpu_has_vmx_bus_lock_detection();
 	kvm_caps.has_notify_vmexit = cpu_has_notify_vmexit();
 
-	set_bit(0, vmx_vpid_bitmap); /* 0 is reserved for host */
-
 	if (enable_ept)
 		kvm_mmu_set_ept_masks(enable_ept_ad_bits);
 	else
@@ -8777,6 +8749,10 @@ __init int vmx_hardware_setup(void)
 
 	vmx_set_cpu_caps();
 
+	r = init_vpids();
+	if (r)
+		return r;
+
 	/*
 	 * Configure nested capabilities after core CPU capabilities so that
 	 * nested support can be conditional on base support, e.g. so that KVM
@@ -8784,8 +8760,10 @@ __init int vmx_hardware_setup(void)
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
index dc8517f15bc46..3de3ee53ccbdc 100644
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
@@ -341,9 +341,29 @@ static __always_inline u32 vmx_get_intr_info(struct kvm_vcpu *vcpu)
 	return vt->exit_intr_info;
 }
 
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
2.55.0.229.g6434b31f56-goog

