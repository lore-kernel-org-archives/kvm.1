Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5FC421F14
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484301; cv=none; b=N8KAE7D9PsyGZU2Hd0LlKzeZHFQyQCKRfXLm83vz75gOo/OISI5DRp8PBITHD0x1Bioxa33gyBEyeGW/wRwiZfQcBtN7z3s9jeFOD64ejF29rmQcEZhsfkAsc/fVlD8E67gG9R9gqlgpP/Zfaa0owQUdkrDtgLEa7DCpUjwKD1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484301; c=relaxed/simple;
	bh=6ZbOr0gKHxAYTpvFZnZxiMjWEtVGHjzS16uPjJSmNJw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gud3zmgaeCbwuTHQJ+M09+bE8Out2ww9s6jwLBZShh3mK5zE/0WZ+LV/XSYdJBQ3vc7sk222mqcB7WrD9FkDw8j4Wl+zebBXu/D/sR6Ebg/ssrYIHKWzUw/xxCzHFge01tBjdK+yis8nOJ8PYxCo1DuuaWX7ks+LnzLHz+yyHm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EVnd5UVA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVnd5UVA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780484299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEvCRcct3nMsP/Y2MLDDtJZ+e6IxGPXMrxmH4YuafcE=;
	b=EVnd5UVAcONaEuoXEADIVAlXTy5yUhVAAABxecSewXgpyT/lazK0xk021OzWMc/Ky874s0
	x4fHchEJZl2leje+au+oAvnSWiJvk/KC4tYEHo7R92jLknVykC1L0fHSvCW1n46CBUDXCc
	nh15v2pMTOw04iDdEWmiXzqR7gpzhSw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-qaLnXK71NRizvw-bQfumxg-1; Wed,
 03 Jun 2026 06:58:18 -0400
X-MC-Unique: qaLnXK71NRizvw-bQfumxg-1
X-Mimecast-MFC-AGG-ID: qaLnXK71NRizvw-bQfumxg_1780484297
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44DEA1800473;
	Wed,  3 Jun 2026 10:58:17 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE021404;
	Wed,  3 Jun 2026 10:58:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 03/24] KVM: nSVM: invalidate cached PDPTRs across nested NPT transitions
Date: Wed,  3 Jun 2026 06:57:53 -0400
Message-ID: <20260603105814.10236-4-pbonzini@redhat.com>
In-Reply-To: <20260603105814.10236-1-pbonzini@redhat.com>
References: <20260603105814.10236-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

When L2 runs under nested NPT and uses PAE paging, KVM's cached PDPTRs
in mmu->pdptrs[] can hold stale or wrong values after nested
transitions and across migration restore, because both
nested_svm_load_cr3() and svm_get_nested_state_pages() only refresh
PDPTRs on the !nested_npt path.

The user-visible bug is on migration restore of an L2 running with nested
NPT and 32-bit PAE paging, if userspace uses KVM_SET_SREGS rather than
KVM_SET_SREGS2.  In that case, load_pdptrs() leaves VCPU_EXREG_PDPTR
marked as available, and kvm_pdptr_read() will use a stale translation
that used L1 GPAs instead of L2 nGPAs.  svm_get_nested_state_pages()
runs on first KVM_RUN but skips the refresh because nested_npt_enabled()
is true.  The CPU itself reads L2's PDPTRs correctly from memory via
L1's NPT, but KVM-side walking of guest PAE page tables uses the bogus
cached values.

Unlike Intel's GUEST_PDPTR0..3 fields in the VMCS, SVM has no
VMCB-cached PDPTR state: the in-memory PDPTEs at the current CR3 are
the only source of truth, and svm_cache_reg(VCPU_EXREG_PDPTR) simply
reloads them from memory via load_pdptrs().  Clearing the avail
bit (and the dirty bit because !avail/dirty is invalid) to force
a reload when PDPTRs as needed fixes the bug.

Do the same for nested_svm_load_cr3()'s nested_npt branch, so that
the invariant "PDPTRs need reloading" is handled similarly for both
immediate and deferred loading.

Note that SVM's usage of pdptrs is overall doubtful, because load_pdptrs()
will return 0 without updating mmu->pdptrs in case of failures but
marks the register as available before the load attempt.  Probably,
nSVM shouldn't be using kvm_get_pdptr() at all.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/kvm_cache_regs.h |  8 ++++++++
 arch/x86/kvm/svm/nested.c     | 27 ++++++++++++++++++---------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
index 2ae492ad6412..6bae5db5a54e 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -77,6 +77,14 @@ static inline bool kvm_register_is_dirty(struct kvm_vcpu *vcpu,
 	return test_bit(reg, vcpu->arch.regs_dirty);
 }
 
+static inline void kvm_register_mark_for_reload(struct kvm_vcpu *vcpu,
+					       enum kvm_reg reg)
+{
+	kvm_assert_register_caching_allowed(vcpu);
+	__clear_bit(reg, vcpu->arch.regs_avail);
+	__clear_bit(reg, vcpu->arch.regs_dirty);
+}
+
 static inline void kvm_register_mark_available(struct kvm_vcpu *vcpu,
 					       enum kvm_reg reg)
 {
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 3d1fd1776e19..aa5a1d8ea136 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -680,9 +680,12 @@ static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 	if (CC(!kvm_vcpu_is_legal_cr3(vcpu, cr3)))
 		return -EINVAL;
 
-	if (reload_pdptrs && !nested_npt && is_pae_paging(vcpu) &&
-	    CC(!load_pdptrs(vcpu, cr3)))
-		return -EINVAL;
+	if (reload_pdptrs && is_pae_paging(vcpu)) {
+		if (nested_npt)
+			kvm_register_mark_for_reload(vcpu, VCPU_REG_PDPTR);
+		else if (CC(!load_pdptrs(vcpu, cr3)))
+			return -EINVAL;
+	}
 
 	vcpu->arch.cr3 = cr3;
 
@@ -2055,15 +2058,21 @@ static bool svm_get_nested_state_pages(struct kvm_vcpu *vcpu)
 	if (WARN_ON(!is_guest_mode(vcpu)))
 		return true;
 
-	if (!vcpu->arch.pdptrs_from_userspace &&
-	    !nested_npt_enabled(to_svm(vcpu)) && is_pae_paging(vcpu))
+	if (is_pae_paging(vcpu)) {
 		/*
-		 * Reload the guest's PDPTRs since after a migration
-		 * the guest CR3 might be restored prior to setting the nested
-		 * state which can lead to a load of wrong PDPTRs.
+		 * After migration, CR3 may have been restored before
+		 * KVM_SET_NESTED_STATE, so the PDPTR load into mmu->pdptrs[]
+		 * may have treated CR3 as an L1 GPA. For nNPT, drop the
+		 * cache so the next access reloads them with the proper
+		 * nGPA translation. For !nNPT, reload eagerly unless userspace
+		 * already supplied authoritative PDPTRs via KVM_SET_SREGS2.
 		 */
-		if (CC(!load_pdptrs(vcpu, vcpu->arch.cr3)))
+		if (nested_npt_enabled(to_svm(vcpu)))
+			kvm_register_mark_for_reload(vcpu, VCPU_REG_PDPTR);
+		else if (!vcpu->arch.pdptrs_from_userspace &&
+			 CC(!load_pdptrs(vcpu, vcpu->arch.cr3)))
 			return false;
+	}
 
 	if (!nested_svm_merge_msrpm(vcpu)) {
 		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-- 
2.52.0


