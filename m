Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D27317166
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561692; cv=none; b=JeWzoSpptYbAk3Ga5YnbVQ80CudR4VHmS9Jqek4fUr/sPomxiG5L9eMjXOWQM3bmCUTDoiO7ak88IyKtD55tR6QfTxXbD3aYChuVm1PsLNDRm01wAat4yYA7SXGhZc/XQLxzjr+d6JYyLwnZfrvpfRNJzyDLEZAvm9LpzRyuFiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561692; c=relaxed/simple;
	bh=35oJC/GFObw9teYQb0y/VjRC1YMrNqwMKCmR2K0ave8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVektxW7xJUCTHXZwRmGC9Cp0j8Mxg9k90z0pq6v3mcLxGzKdFj43so2DJ/uzSBly/UIQVsuC5kyvCEeZtbIeeAgv6fDJvCsbxJ+Uhsg8eLAatmhfJ2ljS0jV+B5+DLkdjeUHg2Fx14gszUGtUym8HgOTmM0mBHsD+OgRx/01J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CPb5xhUb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPb5xhUb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777561687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MBcY9e96Aa/BbabXbf6e88iFvY8eREiLagxnvP8M/Dg=;
	b=CPb5xhUbf0GNdP4dtY7wNTySxi2Xm6SeUy/9nUeYLtOdV+IDmbNYo9CrJ+ZZNTze4ay/9k
	NJbTERSWVtjNXe9mU6jFUQXovpotKjuAZzkdhifcX3cruFF2qLxFkKF+kypajyAPQPSQ3e
	6zLYDf1qdTJaK5LYa2rCuPEKhnxn1ss=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-97Rt56zQMxyCZS6sXrR37g-1; Thu,
 30 Apr 2026 11:08:05 -0400
X-MC-Unique: 97Rt56zQMxyCZS6sXrR37g-1
X-Mimecast-MFC-AGG-ID: 97Rt56zQMxyCZS6sXrR37g_1777561684
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50EC9180049F;
	Thu, 30 Apr 2026 15:08:04 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BBE1E1955D84;
	Thu, 30 Apr 2026 15:08:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 19/28] KVM: nVMX: advertise MBEC to nested guests
Date: Thu, 30 Apr 2026 11:07:38 -0400
Message-ID: <20260430150747.76749-20-pbonzini@redhat.com>
In-Reply-To: <20260430150747.76749-1-pbonzini@redhat.com>
References: <20260430150747.76749-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Jon Kohler <jon@nutanix.com>

Advertise SECONDARY_EXEC_MODE_BASED_EPT_EXEC (MBEC) to userspace, which
allows userspace to expose and advertise the feature to the guest.

When MBEC is enabled by the guest, it is passed to the MMU via cr4_smep,
and to the processor by the merging of vmcs12->secondary_vm_exec_control
into the VMCS02's secondary VM execution controls.

Signed-off-by: Jon Kohler <jon@nutanix.com>
Message-ID: <20251223054806.1611168-9-jon@nutanix.com>
Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu.h        |  2 +-
 arch/x86/kvm/mmu/mmu.c    |  7 ++++---
 arch/x86/kvm/mmu/spte.c   | 10 ++++++----
 arch/x86/kvm/vmx/nested.c | 11 +++++++++++
 4 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 23bc5b18efd0..e1e3869f568b 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -100,7 +100,7 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
 			     unsigned long cr4, u64 efer, gpa_t nested_cr3);
 void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 			     int huge_page_level, bool accessed_dirty,
-			     gpa_t new_eptp);
+			     bool mbec, gpa_t new_eptp);
 bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu);
 int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
 				u64 fault_address, char *insn, int insn_len);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index fe87eee43b09..27776d0b2ad9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5959,7 +5959,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init_shadow_npt_mmu);
 
 static union kvm_cpu_role
 kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
-				   bool execonly, u8 level)
+				   bool execonly, u8 level, bool mbec)
 {
 	union kvm_cpu_role role = {0};
 
@@ -5969,6 +5969,7 @@ kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
 	 */
 	WARN_ON_ONCE(is_smm(vcpu));
 	role.base.level = level;
+	role.base.cr4_smep = mbec;
 	role.base.has_4_byte_gpte = false;
 	role.base.direct = false;
 	role.base.ad_disabled = !accessed_dirty;
@@ -5984,13 +5985,13 @@ kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
 
 void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 			     int huge_page_level, bool accessed_dirty,
-			     gpa_t new_eptp)
+			     bool mbec, gpa_t new_eptp)
 {
 	struct kvm_mmu *context = &vcpu->arch.guest_mmu;
 	u8 level = vmx_eptp_page_walk_level(new_eptp);
 	union kvm_cpu_role new_mode =
 		kvm_calc_shadow_ept_root_page_role(vcpu, accessed_dirty,
-						   execonly, level);
+						   execonly, level, mbec);
 
 	if (new_mode.as_u64 != context->cpu_role.as_u64) {
 		/* EPT, and thus nested EPT, does not consume CR0, CR4, nor EFER. */
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 09e6f494dcf4..9b5ce4d1fa65 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -517,10 +517,12 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits)
 	 * host's MBEC setting does not matter.  On hardware without MBEC
 	 * the XU bit is reserved-as-ignored, and setting it does no harm.
 	 *
-	 * For nested EPT MBEC is not supported, but bit 10 of the gPTE has
-	 * no effect because (a) is_present_gpte() does not treat it as a
-	 * present bit, and (b) permission_fault() uses an mmu->permissions[]
-	 * array that effectively ignores ACC_USER_EXEC_MASK.
+	 * For nested EPT, when MBEC is disabled by L1, correctness relies
+	 * on (a) ignoring bit 10 of the gPTE in is_present_gpte(), rather
+	 * than treating it as a present bit, and (b) permission_fault()
+	 * using an mmu->permissions[] array that effectively ignores
+	 * ACC_USER_EXEC_MASK.  Bit 10 of the gPTE does end up mirrored
+	 * in the sPTEs but is ignored because L2 runs with MBEC disabled.
 	 */
 	shadow_xu_mask		= VMX_EPT_USER_EXECUTABLE_MASK;
 	shadow_present_mask	= VMX_EPT_SUPPRESS_VE_BIT;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 84f5c25a1f12..bc1046f32ebc 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -469,6 +469,13 @@ static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
 	vmcs12->guest_physical_address = fault->address;
 }
 
+static inline bool nested_ept_mbec_enabled(struct kvm_vcpu *vcpu)
+{
+	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
+
+	return nested_cpu_has2(vmcs12, SECONDARY_EXEC_MODE_BASED_EPT_EXEC);
+}
+
 static void nested_ept_new_eptp(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -477,6 +484,7 @@ static void nested_ept_new_eptp(struct kvm_vcpu *vcpu)
 
 	kvm_init_shadow_ept_mmu(vcpu, execonly, ept_lpage_level,
 				nested_ept_ad_enabled(vcpu),
+				nested_ept_mbec_enabled(vcpu),
 				nested_ept_get_eptp(vcpu));
 }
 
@@ -7257,6 +7265,9 @@ static void nested_vmx_setup_secondary_ctls(u32 ept_caps,
 			msrs->ept_caps |= VMX_EPT_AD_BIT;
 		}
 
+		if (enable_mbec)
+			msrs->secondary_ctls_high |=
+				SECONDARY_EXEC_MODE_BASED_EPT_EXEC;
 		/*
 		 * Advertise EPTP switching irrespective of hardware support,
 		 * KVM emulates it in software so long as VMFUNC is supported.
-- 
2.52.0


