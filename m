Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EBB2F9D98
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561767; cv=none; b=RZfSpVu0LoQ6YGS/5qFWOJzXnzNmupVcjegi6vCmAtubyKLmryFXV1pOLwLYrMcayAVCFYyaC4CpAf1KQKvOuinZX5XcAc951KKGJenq97K3U68lxVM2KWxwY5+Abf580iVFELxAGCHhdqDKFmtXDNIBqRN0jAok+w4ThS0OHmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561767; c=relaxed/simple;
	bh=L4cH2dT588gSAN7U+hs6x9Lbsg5mnNLb6qtEQXg9v+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKFu6RMFeMePAxR80jmmL9GWLvctqh2KyhYAKUtlRz1KLydZFzuVkk4P3zhNk1CuHEIgCMIuhHAphGPyUg0sO4oi/iAE9PTvoZaVD16BhH9HOjTtQcrUB06RGV/4pPD8JBaSXoStk1nOOMCjcbSKRCcrtjMfjX5Kc4+D31ba9F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ea4ddqim; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ea4ddqim"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777561752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqgTbHba1w1SDsi4GMvguZqLQWEvB+kbaiyrWxLdXpU=;
	b=ea4ddqimoIT8pn4we7e9XcHtoefteaiAnirND7JDzvvJinyt0FBXnQ5TodHP4UoSmOBDsN
	S+hT/OV6a+sAJJ1Pb4VsRB/+sGJY36XklBt5FLH6BblPfgcYbL0zR2FC2PJaHrm2fSnH+1
	jYtlkuZkKxYA3Wu4mw5pc6p2yUyOmxU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-eFQN5iRiP0a6mZoOAArfoQ-1; Thu,
 30 Apr 2026 11:08:25 -0400
X-MC-Unique: eFQN5iRiP0a6mZoOAArfoQ-1
X-Mimecast-MFC-AGG-ID: eFQN5iRiP0a6mZoOAArfoQ_1777561690
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DED2018001FA;
	Thu, 30 Apr 2026 15:08:08 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 584B2180034F;
	Thu, 30 Apr 2026 15:08:08 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 24/28] KVM: x86/mmu: hard code more bits in kvm_init_shadow_npt_mmu
Date: Thu, 30 Apr 2026 11:07:43 -0400
Message-ID: <20260430150747.76749-25-pbonzini@redhat.com>
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

The host CR0 does not really reflect onto the NPT format because
hCR0.PG=1 must be set and hCR0.WP is ignored.  Carve that in stone
by removing the cr0 argument from kvm_init_shadow_npt_mmu.

Pass in WP=1 as well; it does not matter for GMET disabled because
PFERR_USER_MASK is always set, but a cleared W bit in the nested page
tables cannot be overridden in supervisor mode when GMET is enabled,
either.  In fact, since CR0.WP=0 is the weird "extra accesses allowed"
mode, it is acutally easier think about it being always set.

Likewise, clear X86_CR4_SMAP to avoid that KVM erroneously faults on
supervisor accesses to an U=1 page.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu.h        | 4 ++--
 arch/x86/kvm/mmu/mmu.c    | 8 ++++----
 arch/x86/kvm/svm/nested.c | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index e1e3869f568b..1b354e1f2d81 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -96,8 +96,8 @@ void kvm_mmu_set_me_spte_mask(u64 me_value, u64 me_mask);
 void kvm_mmu_set_ept_masks(bool has_ad_bits);
 
 void kvm_init_mmu(struct kvm_vcpu *vcpu);
-void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
-			     unsigned long cr4, u64 efer, gpa_t nested_cr3);
+void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr4,
+			     u64 efer, gpa_t nested_cr3);
 void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 			     int huge_page_level, bool accessed_dirty,
 			     bool mbec, gpa_t new_eptp);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 93f96673d02a..32845edd14fa 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5939,13 +5939,13 @@ static void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu,
 	shadow_mmu_init_context(vcpu, context, cpu_role, root_role);
 }
 
-void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
-			     unsigned long cr4, u64 efer, gpa_t nested_cr3)
+void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr4,
+			     u64 efer, gpa_t nested_cr3)
 {
 	struct kvm_mmu *context = &vcpu->arch.guest_mmu;
 	struct kvm_mmu_role_regs regs = {
-		.cr0 = cr0,
-		.cr4 = cr4 & ~X86_CR4_PKE,
+		.cr0 = X86_CR0_PG | X86_CR0_WP,
+		.cr4 = cr4 & ~(X86_CR4_PKE | X86_CR4_SMAP),
 		.efer = efer,
 	};
 	union kvm_cpu_role cpu_role = kvm_calc_cpu_role(vcpu, &regs);
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index df232153eb24..a1cffd274000 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -93,7 +93,7 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 	 * when called via KVM_SET_NESTED_STATE, that state may _not_ match current
 	 * vCPU state.  CR0.WP is explicitly ignored, while CR0.PG is required.
 	 */
-	kvm_init_shadow_npt_mmu(vcpu, X86_CR0_PG, svm->vmcb01.ptr->save.cr4,
+	kvm_init_shadow_npt_mmu(vcpu, svm->vmcb01.ptr->save.cr4,
 				svm->vmcb01.ptr->save.efer,
 				svm->nested.ctl.nested_cr3);
 	vcpu->arch.mmu->get_guest_pgd     = nested_svm_get_tdp_cr3;
-- 
2.52.0


