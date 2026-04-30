Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50E043E480
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561698; cv=none; b=b//Q/8hjKhpcxpTBarFr/UidYnoshl6cBtp43uKbzUHbt13NVKOGMe+7sYzo7zsvwfHuoigQOqgzcV8MRrDYP7961+6TSIGWcQbdiKxqmvBeVNcVCI+vzVnVoaTI86eLBJwLUbHpHnSrqsAit3LAciGjBdxAj0jgYP/n6LeswIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561698; c=relaxed/simple;
	bh=i3LHV97Zl4iJ8M728cR5ScJiyeerLmUokWWhG56QOA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QYoI88skb/xTbfw72x3ewSejzVDAXOmHOJKyOeIXSC/YtYLh7vglzqRrkz6S+6t0jSPzmEQMkBTSOkeNZ+OjIwcGrzjhFldZQQRJ1+Wvru9dC+D01NrKiUriJVYPGFDpFqEkYsl4kQbNifZ0BVAUgOl/G1y3o4eI06Owc5hmvUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FnGlbkMr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FnGlbkMr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777561694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mTPB8p8VgH0WxNWI3+gmQlsmxKMQQtISoOqn9ka2noU=;
	b=FnGlbkMrW5A2PUAsqOlyymZkMCdfX2qPnXYNPVu18TzOUMS8699tR3p2U+R5D94phby9O8
	0wW2pHkXNIuv4RrpN9SNJoq92/Irmn6fnFJddkQkj98yaR3FZaAq4XJRJvNaraud87sprb
	4Ligzo3Og79BoWXtS2NrbderfnDNj7U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-e_aF1ppaOnGspVLdF_O2Pw-1; Thu,
 30 Apr 2026 11:08:11 -0400
X-MC-Unique: e_aF1ppaOnGspVLdF_O2Pw-1
X-Mimecast-MFC-AGG-ID: e_aF1ppaOnGspVLdF_O2Pw_1777561690
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51DB019560AF;
	Thu, 30 Apr 2026 15:08:10 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BFA0D180045E;
	Thu, 30 Apr 2026 15:08:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 26/28] KVM: SVM: enable GMET and set it in MMU role
Date: Thu, 30 Apr 2026 11:07:45 -0400
Message-ID: <20260430150747.76749-27-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Set the GMET bit in the nested control field.  This has effectively
no impact as long as NPT page tables are changed to have U=0.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c    |  6 +++++-
 arch/x86/kvm/svm/nested.c |  9 ++++++---
 arch/x86/kvm/svm/svm.c    | 16 ++++++++++++++++
 arch/x86/kvm/svm/svm.h    |  1 +
 4 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 015085ef6e46..31c1803d9d15 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5855,7 +5855,6 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu,
 {
 	union kvm_mmu_page_role role = {0};
 
-	role.access = ACC_ALL;
 	role.cr0_wp = true;
 	role.cr4_smep = kvm_x86_call(tdp_has_smep)(vcpu->kvm);
 	role.efer_nx = true;
@@ -5866,6 +5865,11 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu,
 	role.direct = true;
 	role.has_4_byte_gpte = false;
 
+	/* All TDP pages are supervisor-executable */
+	role.access = ACC_ALL;
+	if (role.cr4_smep && shadow_user_mask)
+		role.access &= ~ACC_USER_MASK;
+
 	return role;
 }
 
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 7adfa7da210d..74a1df1cb84f 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -858,7 +858,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	 * the latter, L1 runs L2 with shadow page tables that translate L2 GVAs
 	 * to L1 GPAs, so the same NPTs can be used for L1 and L2.
 	 */
-	vmcb02->control.misc_ctl = vmcb01->control.misc_ctl & SVM_MISC_ENABLE_NP;
+	vmcb02->control.misc_ctl = vmcb01->control.misc_ctl & (SVM_MISC_ENABLE_NP | SVM_MISC_ENABLE_GMET);
 	vmcb02->control.iopm_base_pa = vmcb01->control.iopm_base_pa;
 	vmcb02->control.msrpm_base_pa = vmcb01->control.msrpm_base_pa;
 	vmcb_mark_dirty(vmcb02, VMCB_PERM_MAP);
@@ -895,9 +895,12 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	/* Also overwritten later if necessary.  */
 	vmcb02->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
 
-	/* nested_cr3.  */
-	if (nested_npt_enabled(svm))
+	/* Use vmcb01 MMU and format if guest does not use nNPT */
+	if (nested_npt_enabled(svm)) {
+		vmcb02->control.misc_ctl &= ~SVM_MISC_ENABLE_GMET;
+
 		nested_svm_init_mmu_context(vcpu);
+	}
 
 	vcpu->arch.tsc_offset = kvm_calc_nested_tsc_offset(vcpu->arch.l1_tsc_offset,
 							   vmcb12_ctrl->tsc_offset,
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e7fdd7a9c280..3895d8794366 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -138,6 +138,9 @@ module_param(pause_filter_count_max, ushort, 0444);
 bool __ro_after_init npt_enabled = true;
 module_param_named(npt, npt_enabled, bool, 0444);
 
+bool gmet_enabled = true;
+module_param_named(gmet, gmet_enabled, bool, 0444);
+
 /* allow nested virtualization in KVM/SVM */
 static int __ro_after_init nested = true;
 module_param(nested, int, 0444);
@@ -1209,6 +1212,10 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 		save->g_pat = vcpu->arch.pat;
 		save->cr3 = 0;
 	}
+
+	if (gmet_enabled)
+		control->misc_ctl |= SVM_MISC_ENABLE_GMET;
+
 	svm->current_vmcb->asid_generation = 0;
 	svm->asid = 0;
 
@@ -4612,6 +4619,11 @@ svm_patch_hypercall(struct kvm_vcpu *vcpu, unsigned char *hypercall)
 	hypercall[2] = 0xd9;
 }
 
+static bool svm_tdp_has_smep(struct kvm *kvm)
+{
+	return gmet_enabled;
+}
+
 /*
  * The kvm parameter can be NULL (module initialization, or invocation before
  * VM creation). Be sure to check the kvm parameter before using it.
@@ -5355,6 +5367,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.write_tsc_multiplier = svm_write_tsc_multiplier,
 
 	.load_mmu_pgd = svm_load_mmu_pgd,
+	.tdp_has_smep = svm_tdp_has_smep,
 
 	.check_intercept = svm_check_intercept,
 	.handle_exit_irqoff = svm_handle_exit_irqoff,
@@ -5588,6 +5601,9 @@ static __init int svm_hardware_setup(void)
 	if (!boot_cpu_has(X86_FEATURE_NPT))
 		npt_enabled = false;
 
+	if (!npt_enabled || !boot_cpu_has(X86_FEATURE_GMET))
+		gmet_enabled = false;
+
 	/* Force VM NPT level equal to the host's paging level */
 	kvm_configure_mmu(npt_enabled, get_npt_level(),
 			  get_npt_level(), PG_LEVEL_1G);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index a10668d17a16..dd93b3daefa9 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -44,6 +44,7 @@ static inline struct page *__sme_pa_to_page(unsigned long pa)
 #define	IOPM_SIZE PAGE_SIZE * 3
 #define	MSRPM_SIZE PAGE_SIZE * 2
 
+extern bool gmet_enabled;
 extern bool npt_enabled;
 extern int nrips;
 extern int vgif;
-- 
2.52.0


