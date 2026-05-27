Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493413D5258
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883569; cv=none; b=lnhq2GLw/nWCi2DFej/wlaaTYZ6IqtFpsDHyJOd/mZ4bbI9H/mxImb7kgSklllCt3QfvrIn4WcRyoUjKnqTkGVVFdv6K3uaSolmP2YUvUBMk/1Kp/ft+YJU23poyg4365Lsp4cdOIfWJzeI1ihFicBqYtcaIszhdPQbDz5+WEaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883569; c=relaxed/simple;
	bh=hcnMy0pk5y4k5dWyzFYhPys6XtCcu6uR92E9DHF9ysg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPM1ALU9Qj8ADq0DwNrjUCXc24Xet16+58AH19d0K/fWI7iotQ41oBPXB/wOCnZeFg5v9DsdUcC1RBe7pDzvgJsvUi6bCsw6LIzu8F809BmxU3rZ0AAs8VciuNxn+5E7Pu3wL+fWDRXHXWA3g2DIK+NlvQYCBNKejB6RmP5TiPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FfOStOft; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfOStOft"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779883567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9+0F9zn7InsarGAuIZCAI//xzyMzOUExsQx9OexxrE=;
	b=FfOStOft9MRC7QLNoCiPBTyYqTtM97FINaVwFE7SVRp7nE1r/TE7+9xfWas6X8QZRjHawk
	IunXkBg7DfsP9tKaAwly71G3PIn8/gdUI7N7dQYEjAWBNAoRrPtzu7Cl7tZE2T+GptclV5
	YhZK2NOr449x1bScNdwdHnzu+gh7kU0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-UxCoixJqOmaIDa5fxcNbYw-1; Wed,
 27 May 2026 08:06:04 -0400
X-MC-Unique: UxCoixJqOmaIDa5fxcNbYw-1
X-Mimecast-MFC-AGG-ID: UxCoixJqOmaIDa5fxcNbYw_1779883563
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D8151956094;
	Wed, 27 May 2026 12:06:03 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D729A1681;
	Wed, 27 May 2026 12:06:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 3/4] KVM: nSVM: invalidate cached PDPTRs across nested NPT transitions
Date: Wed, 27 May 2026 08:05:59 -0400
Message-ID: <20260527120600.20696-4-pbonzini@redhat.com>
In-Reply-To: <20260527120600.20696-1-pbonzini@redhat.com>
References: <20260527120600.20696-1-pbonzini@redhat.com>
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


