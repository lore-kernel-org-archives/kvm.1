Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281AB3D811C
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512027; cv=none; b=KM80pPFUZZV7sIhMeL5DsZXQb68b2c2O+D5l2kQd/+UDl5YASo2N5o+8IgFvCwsZzfskgGGAiU7ffo6wBqXWtHzIOH42D+dCrvfhpeppmpHHwjGfNiv4ksPTQf/XoJv6pHhpDblGF6y1lim//PrM8ht0qmDHz1vBtleP9zmhmOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512027; c=relaxed/simple;
	bh=0dQSFK9LjTBMEOYdhizcosh+ydHJ764WMFdiHiIUYpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nFld7OuA6LhrNBn92O++jHT5g8CKb8VHZqsupW4uiFoh8p0b8s1+wdxgcgbmNfbSTw/7f9tVrXuScTZUR4tg0SyhFWlaDOypvY8CZk21Ap16tMZUJZs298Oq/pOYLLQuvGHScV/0sedI8MITi7A8eM6AYkcQQB9C5FO7/wNIJbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GlS/KLSc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlS/KLSc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778512024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEssg3xMy+HeTd/RvSqnTuw1vCIXQm+kT38m2953+gM=;
	b=GlS/KLScUROPUotRqSdfz0g5eAdW9rCbjenDvQ81zjULCap9DmYWCulyi3Yt3y9GoG+cZw
	zg0AObTVUtALy+/m2bwmSVX+fn7UZBvlYeX1btXtPnN94AICeHZ6Q9u+3S+qOtUSzTbl0Q
	gqo0vHjZJFpMUWbXCJs818pq0jDdmbw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-IqSUN42gMCWxDlGXZZ_DJg-1; Mon,
 11 May 2026 11:07:01 -0400
X-MC-Unique: IqSUN42gMCWxDlGXZZ_DJg-1
X-Mimecast-MFC-AGG-ID: IqSUN42gMCWxDlGXZZ_DJg_1778512020
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 320561800753;
	Mon, 11 May 2026 15:07:00 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 705C91800762;
	Mon, 11 May 2026 15:06:59 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	mtosatti@redhat.com
Subject: [PATCH 13/22] KVM: x86/mmu: pass struct kvm_pagewalk to kvm_mmu_invalidate_addr
Date: Mon, 11 May 2026 11:06:39 -0400
Message-ID: <20260511150648.685374-14-pbonzini@redhat.com>
In-Reply-To: <20260511150648.685374-1-pbonzini@redhat.com>
References: <20260511150648.685374-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

kvm_mmu_invalidate_addr only needs to know if what's being invalidated
is a GVA or GPA.  This will ultimately be represented by two different
kvm_pagewalk structs, so adjust the type of the parameter.

For now the GVA case is represented by both root_mmu and nested_mmu.
Since nested_mmu never has a sync_spte callback, it would exit at its
check; but really nested_mmu should not be a kvm_mmu in the first place
and the container_of() would be bogus, so introduce a separate check
for whether the invalidation is happening for a nested GVA.  In that
case there's nothing needed beyond kvm_x86_call(flush_tlb_gva).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/mmu/mmu.c          | 12 ++++++++----
 arch/x86/kvm/vmx/nested.c       |  2 +-
 arch/x86/kvm/x86.c              |  2 +-
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3172aaff6744..a1a09b59ac0b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2384,7 +2384,7 @@ int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 error_code,
 		       void *insn, int insn_len);
 void kvm_mmu_print_sptes(struct kvm_vcpu *vcpu, gpa_t gpa, const char *msg);
 void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva);
-void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
+void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 			     u64 addr, unsigned long roots);
 void kvm_mmu_invpcid_gva(struct kvm_vcpu *vcpu, gva_t gva, unsigned long pcid);
 void kvm_mmu_new_pgd(struct kvm_vcpu *vcpu, gpa_t new_pgd);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index cc58b6157118..967c2226cba0 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6596,22 +6596,26 @@ static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu
 	write_unlock(&vcpu->kvm->mmu_lock);
 }
 
-void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
+void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 			     u64 addr, unsigned long roots)
 {
+	struct kvm_mmu *mmu;
 	int i;
 
 	WARN_ON_ONCE(roots & ~KVM_MMU_ROOTS_ALL);
 
 	/* It's actually a GPA for vcpu->arch.guest_mmu.  */
-	if (mmu != &vcpu->arch.guest_mmu) {
+	if (w != &vcpu->arch.guest_mmu.w) {
 		/* INVLPG on a non-canonical address is a NOP according to the SDM.  */
 		if (is_noncanonical_invlpg_address(addr, vcpu))
 			return;
 
 		kvm_x86_call(flush_tlb_gva)(vcpu, addr);
+		if (w == &vcpu->arch.nested_mmu.w)
+			return;
 	}
 
+	mmu = container_of(w, struct kvm_mmu, w);
 	if (!mmu->sync_spte)
 		return;
 
@@ -6637,7 +6641,7 @@ void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva)
 	 * be synced when switching to that new cr3, so nothing needs to be
 	 * done here for them.
 	 */
-	kvm_mmu_invalidate_addr(vcpu, vcpu->arch.walk_mmu, gva, KVM_MMU_ROOTS_ALL);
+	kvm_mmu_invalidate_addr(vcpu, &vcpu->arch.walk_mmu->w, gva, KVM_MMU_ROOTS_ALL);
 	++vcpu->stat.invlpg;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_invlpg);
@@ -6659,7 +6663,7 @@ void kvm_mmu_invpcid_gva(struct kvm_vcpu *vcpu, gva_t gva, unsigned long pcid)
 	}
 
 	if (roots)
-		kvm_mmu_invalidate_addr(vcpu, mmu, gva, roots);
+		kvm_mmu_invalidate_addr(vcpu, &mmu->w, gva, roots);
 	++vcpu->stat.invlpg;
 
 	/*
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 50edd7ffac24..af773b4e008b 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -407,7 +407,7 @@ static void nested_ept_invalidate_addr(struct kvm_vcpu *vcpu, gpa_t eptp,
 			roots |= KVM_MMU_ROOT_PREVIOUS(i);
 	}
 	if (roots)
-		kvm_mmu_invalidate_addr(vcpu, vcpu->arch.mmu, addr, roots);
+		kvm_mmu_invalidate_addr(vcpu, &vcpu->arch.guest_mmu.w, addr, roots);
 }
 
 static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c53d954e6367..c2de39ad7595 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1002,7 +1002,7 @@ void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 	 */
 	if ((fault->error_code & PFERR_PRESENT_MASK) &&
 	    !(fault->error_code & PFERR_RSVD_MASK))
-		kvm_mmu_invalidate_addr(vcpu, fault_mmu, fault->address,
+		kvm_mmu_invalidate_addr(vcpu, &fault_mmu->w, fault->address,
 					KVM_MMU_ROOT_CURRENT);
 
 	fault_mmu->w.inject_page_fault(vcpu, fault);
-- 
2.52.0


