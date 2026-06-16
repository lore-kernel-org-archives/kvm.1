Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5382627603A;
	Tue, 16 Jun 2026 00:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570545; cv=none; b=JRDRchFwbkEYLnugPypEZTFddz2rV8V1OP91weeM/jFiPQi/2LSvXg/Hi1rpADZSjCHR+euEZZnApRB8BKNvBJEFWZjmVQqLdez+IwBal7aDzH9fDHS0JYdSK3dsZe8LiXLjvqD4NtVwMRyV30yYUshad/H62wrwWlYuZtQ2dsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570545; c=relaxed/simple;
	bh=hlaFTpgngX2CjfISCmtu4r59/sfS8G8WdpGAAkroD/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VcAbb75tDe483s2CQnxVCvoxsuZ+AQXKQMVr0TIYbV9kRv07Jm74+lhMQPDcBlXqT8xLMhBaf9QPi1alWDv1cjyeX6IYEIFoGMfbmp3yPJVRYh3VkrZkzvWibvFM1rjNBl06MN126PeoiFRKlsRUlbQDZ54DlNe8uJwlVqb39oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRofNHRC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRofNHRC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6851F00A3E;
	Tue, 16 Jun 2026 00:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570543;
	bh=V9GCU8bK+pMxYj+smCaR1jtznQvVK7pnxC//PZI5UgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hRofNHRCIOkeIjvC9vEc5aLdRFHvz/nxLU5q0Ndwc9kPWVxiCJC+K+gytczhWUq+t
	 gZyIBWvS/vQflklhGCgqMQ5ksJLXo3BtRZ7CsSqI8kInvyT3j6qMAV255GvmJaX1s4
	 6Ba8tbN25aY8HHfIdGXn2ok3pLx2jKcl3tnpJ/sn8tsVyPmZB2YUt3xgDoL1FIloCY
	 XN2qWWkKP3vV2PHHgVEV48IXP3/4Ex/lBOqNWkX26e1+Y5mfQ8AtzghsxA78V/Dm2L
	 UkB+G/X6KMuS8hgOtZWz7Tn+mGUvDUSRMEVPVwmEajfzhx49w6SCvqefeAK7nPMcPo
	 0xvcVAxSAtDyQ==
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
Subject: [RFC PATCH v2 03/25] KVM: VMX: Generalize VPID allocation to be vendor-neutral
Date: Tue, 16 Jun 2026 00:41:32 +0000
Message-ID: <20260616004155.1435766-4-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616004155.1435766-1-yosry@kernel.org>
References: <20260616004155.1435766-1-yosry@kernel.org>
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

The number of tags includes tag=0, which is not usable. The interface is
a little confusing in that regard, but this will be changed with the
introducing of a minimum tag later.

Initialize the TLB tags allocator during hardware setup/unsetup, and
reserve tag=0 during initialziation, similar to how VPID=0 is currently
reserved in the VMX-specific bitmap during hardware setup.

Keep allocate_vpid() and free_vpid() as wrapper that check enable_vpid
to avoid checking at all callsites, and add init_vpids() and
destroy_vpids() to wrap init/destroy calls as well.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/mmu.h     |  8 ++++++
 arch/x86/kvm/mmu/mmu.c | 64 ++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c | 40 ++++++--------------------
 arch/x86/kvm/vmx/vmx.h | 28 +++++++++++++++---
 4 files changed, 105 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index e1bb663ebbd58..9a2916012cbff 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -334,4 +334,12 @@ static inline bool kvm_is_gfn_alias(struct kvm *kvm, gfn_t gfn)
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
index 9368a71336fe4..e021ed562502f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -8192,4 +8192,68 @@ void kvm_mmu_init_memslot_memory_attributes(struct kvm *kvm,
 		}
 	}
 }
+
+static struct {
+	spinlock_t	lock;
+	unsigned long	*bitmap;
+	unsigned int	nr;
+} tlb_tags;
+
+int kvm_init_tlb_tags(unsigned int nr)
+{
+	if (WARN_ON_ONCE(!nr))
+		return -EINVAL;
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
+	if (WARN_ON_ONCE(!tlb_tags.bitmap))
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
 #endif
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c548f22375ad6..e1fd1c95ee8cc 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -594,9 +594,6 @@ DEFINE_PER_CPU(struct vmcs *, current_vmcs);
  */
 static DEFINE_PER_CPU(struct list_head, loaded_vmcss_on_cpu);
 
-static DECLARE_BITMAP(vmx_vpid_bitmap, VMX_NR_VPIDS);
-static DEFINE_SPINLOCK(vmx_vpid_lock);
-
 struct vmcs_config vmcs_config __ro_after_init;
 struct vmx_capability vmx_capability __ro_after_init;
 
@@ -4067,31 +4064,6 @@ static void seg_setup(int seg)
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
@@ -8474,6 +8446,8 @@ void vmx_hardware_unsetup(void)
 
 	if (nested)
 		nested_vmx_hardware_unsetup();
+
+	destroy_vpids();
 }
 
 void vmx_vm_destroy(struct kvm *kvm)
@@ -8699,8 +8673,6 @@ __init int vmx_hardware_setup(void)
 	kvm_caps.has_bus_lock_exit = cpu_has_vmx_bus_lock_detection();
 	kvm_caps.has_notify_vmexit = cpu_has_notify_vmexit();
 
-	set_bit(0, vmx_vpid_bitmap); /* 0 is reserved for host */
-
 	if (enable_ept)
 		kvm_mmu_set_ept_masks(enable_ept_ad_bits);
 	else
@@ -8765,6 +8737,10 @@ __init int vmx_hardware_setup(void)
 
 	vmx_set_cpu_caps();
 
+	r = init_vpids();
+	if (r)
+		return r;
+
 	/*
 	 * Configure nested capabilities after core CPU capabilities so that
 	 * nested support can be conditional on base support, e.g. so that KVM
@@ -8772,8 +8748,10 @@ __init int vmx_hardware_setup(void)
 	 */
 	if (nested) {
 		r = nested_vmx_hardware_setup(kvm_vmx_exit_handlers);
-		if (r)
+		if (r) {
+			destroy_vpids();
 			return r;
+		}
 	}
 
 	kvm_set_posted_intr_wakeup_handler(pi_wakeup_handler);
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index de9de0d2016ca..d6d35637d94f8 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -175,7 +175,7 @@ struct nested_vmx {
 	u64 pre_vmenter_ssp;
 	u64 pre_vmenter_ssp_tbl;
 
-	u16 vpid02;
+	kvm_tlb_tag_t vpid02;
 	u16 last_vpid;
 
 	int tsc_autostore_slot;
@@ -249,7 +249,7 @@ struct vcpu_vmx {
 			u32 ar;
 		} seg[8];
 	} segment_cache;
-	int vpid;
+	kvm_tlb_tag_t vpid;
 
 	/* Support for a guest hypervisor (nested VMX) */
 	struct nested_vmx nested;
@@ -334,9 +334,29 @@ static __always_inline u32 vmx_get_intr_info(struct kvm_vcpu *vcpu)
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
2.54.0.1136.gdb2ca164c4-goog

