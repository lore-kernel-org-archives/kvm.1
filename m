Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016313FFADA
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374620; cv=none; b=QW66ARegMyrSiBDzvcvxNygp5K5iacsR9YRt86msD/fa6LOq8iic9YnQzvcOyxEYasPm8jnW/Fk4sko4PrKJNoWhkQRlIassth0RvGCnWQrWWk0jfTuOemfKQ6OLnU8sYFd454f+LVL7i3rJcvegICzrUyCINIYsm42zbAALY9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374620; c=relaxed/simple;
	bh=+9/MBdn3/HXIcU82TkwlbEMRTavJuREuP3RSFkLHOcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjuLG6JPZO41eDMoCK6FjWauCCf6BMaj7P9/r04tFeKTvMfNZIs9hzli7C2tjHnz3TBN9Xqa4j6NjPzMGv/KqzBvmmTCOpExNH+ruL6X2Qf3PQI157pQSjZVRugYS+5QzsesQahVoD9/fBK/IfZT7NYNYQs1qV1nf7NXLvUA+A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J8xsMwJt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8xsMwJt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Xq5JwhvAgFZv5T+bpA+ShHdO+d4ms6wcusJmPMECzA=;
	b=J8xsMwJtiNZ7SessTL1VIaZJX/JqSj5pcXrErH6Q4zwvijyB/VgbFILIxOvi/tvnxq/Cf6
	6LkNMJmr2iCcuf+Ft8rq5HkuwSDSK/wUS2ytwzWX54Wphfs6IEwGtpn0v7EioywNyfGCsW
	aAocnQRWSLexYSEQaJKpJGn3/wJx8x8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-kIGohtFZMVWXqtP021DCWQ-1; Tue,
 28 Apr 2026 07:10:13 -0400
X-MC-Unique: kIGohtFZMVWXqtP021DCWQ-1
X-Mimecast-MFC-AGG-ID: kIGohtFZMVWXqtP021DCWQ_1777374612
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B06E19560BB;
	Tue, 28 Apr 2026 11:10:12 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 912FB19560B1;
	Tue, 28 Apr 2026 11:10:11 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	d.riley@proxmox.com
Subject: [PATCH 24/28] KVM: x86/mmu: set CR0.WP=1 for shadow NPT MMU
Date: Tue, 28 Apr 2026 07:09:42 -0400
Message-ID: <20260428110946.11466-25-pbonzini@redhat.com>
In-Reply-To: <20260428110946.11466-1-pbonzini@redhat.com>
References: <20260428110946.11466-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The host CR0 does not really reflect onto the NPT format because
hCR0.PG=1 must be set and hCR0.WP is ignored.  Carve that in stone
by removing the cr0 argument from kvm_init_shadow_npt_mmu, and while
at it pass in WP=1 as well.  It does not matter for GMET disabled because
PFERR_USER_MASK is always set, but a cleared W bit in the nested page
tables cannot be overridden in supervisor mode when GMET is enabled,
either.  In fact, since CR0.WP=0 is the weird "extra accesses allowed"
mode, it is actually easier think about it being always set.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu.h        | 4 ++--
 arch/x86/kvm/mmu/mmu.c    | 6 +++---
 arch/x86/kvm/svm/nested.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 9031f7ef8e4e..29aa3994a8c2 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -96,8 +96,8 @@ void kvm_mmu_set_me_spte_mask(u64 me_value, u64 me_mask);
 void kvm_mmu_set_ept_masks(bool has_ad_bits, bool has_mbec);
 
 void kvm_init_mmu(struct kvm_vcpu *vcpu);
-void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
-			     unsigned long cr4, u64 efer, gpa_t nested_cr3);
+void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr4,
+			     u64 efer, gpa_t nested_cr3);
 void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 			     int huge_page_level, bool accessed_dirty,
 			     bool mbec, gpa_t new_eptp);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 07b64df8519d..432f0d3ce632 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5933,12 +5933,12 @@ static void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu,
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
+		.cr0 = X86_CR0_PG | X86_CR0_WP,
 		.cr4 = cr4 & ~X86_CR4_PKE,
 		.efer = efer,
 	};
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


