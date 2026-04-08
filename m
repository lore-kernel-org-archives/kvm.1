Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D235A3DD520
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662969; cv=none; b=i8hhN7aXL/PRE22zjggYcaHAuMdVUBK1HBr6IA1mUWnFbMkF80Cs9FexjoKFwudPB5HmycY4J7yWvla33dCZQyzu8E+/rzxmJH8pIeGQoJDkIAsGp0UMNE6tQnp9uDGNHMzD1lCEdYTad9ZsYvZEBLWn8H8jKTuMe2jte9VLtf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662969; c=relaxed/simple;
	bh=BMiY9SiICmWSoHzZVLcNnq8HoiYaPMGBivIEdIwdKrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NpG+7jlgOZOuQK+PIgrHjzpiNA5LFYLi/8KsAPwLOfPuXzaCgGFCGxCQImAqhdkmIUvhinTRWFNYIFw20s9Oru66+u6fcRbPiLAPRa62zS5DcPjo5vJDhX4MZzXlRlwkIz7oazPRAJx8wwt17QvseHj9Mr5hO0ncDh5dsXlxwMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dPRpXInL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPRpXInL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775662964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+yvyFVMIPBwVIFiykHWuVesiCmwNgYaaVARbhRufRic=;
	b=dPRpXInLgJ5HxUHyW28BrXa1ejmPiOwnAvKH3V7skjbghXQaY1P++2ZDK2pvdLE6gmOhUc
	bxLR1DyNhYbbNWSYde8j0t65G9jA1DkQVfrH9Bd06Us7Y+LGlEJKium7dOocAJEvPXIEAW
	LiwvU1eTt+Zvv3TzB/zNYRt3MQi9QwA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-uEkhpNdtMaKajM5X1QU0iQ-1; Wed,
 08 Apr 2026 11:42:42 -0400
X-MC-Unique: uEkhpNdtMaKajM5X1QU0iQ-1
X-Mimecast-MFC-AGG-ID: uEkhpNdtMaKajM5X1QU0iQ_1775662958
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 682D0180034E;
	Wed,  8 Apr 2026 15:42:38 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 850C319560A6;
	Wed,  8 Apr 2026 15:42:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 19/27] KVM: nVMX: advertise MBEC to nested guests
Date: Wed,  8 Apr 2026 11:42:09 -0400
Message-ID: <20260408154217.458420-20-pbonzini@redhat.com>
In-Reply-To: <20260408154217.458420-1-pbonzini@redhat.com>
References: <20260408154217.458420-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Jon Kohler <jon@nutanix.com>

Advertise SECONDARY_EXEC_MODE_BASED_EPT_EXEC (MBEC) to userspace, which
allows userspace to expose and advertise the feature to the guest.

When MBEC is enabled by the guest, it is passed to the MMU via cr4_smep,
and to the processor by the merging of vmcs12->secondary_vm_exec_control
into the VMCS02's secondary VM execution controls.

Signed-off-by: Jon Kohler <jon@nutanix.com>
Message-ID: <20251223054806.1611168-9-jon@nutanix.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu.h        |  2 +-
 arch/x86/kvm/mmu/mmu.c    |  7 ++++---
 arch/x86/kvm/vmx/nested.c | 11 +++++++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index d15f908d048f..9031f7ef8e4e 100644
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
index 07bdc8f9b0cb..3ecc571a1de0 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5944,7 +5944,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init_shadow_npt_mmu);
 
 static union kvm_cpu_role
 kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
-				   bool execonly, u8 level)
+				   bool execonly, u8 level, bool mbec)
 {
 	union kvm_cpu_role role = {0};
 
@@ -5954,6 +5954,7 @@ kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
 	 */
 	WARN_ON_ONCE(is_smm(vcpu));
 	role.base.level = level;
+	role.base.cr4_smep = mbec;
 	role.base.has_4_byte_gpte = false;
 	role.base.direct = false;
 	role.base.ad_disabled = !accessed_dirty;
@@ -5969,13 +5970,13 @@ kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
 
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
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 925dfa7f54df..564165262073 100644
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
 
@@ -7255,6 +7263,9 @@ static void nested_vmx_setup_secondary_ctls(u32 ept_caps,
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


