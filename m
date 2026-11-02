Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641297;
	b=UJQsziRBU864yiHWLOUhc9B186uFsvSQ1pkNQABepcjSznK8L0BERLMZXYdJKL9aE+hI
	 5kjRnppqR2E8ziuQ11ABknxf/3EkeikegoT5QrEhgJNuUjGz7BtVI9UZwDuKkZmR1ZqGL
	 wx/mBChdF9i8FuOa8jimXF0rSZest+6a6TchS8Mmn9yLnrlce34J769BB2ITScKDK2vaA
	 3Wu1StNHwLcJTOpl9B7sQTs2OF5rTsdDnjjSgCGkUyO2pp1mjm6TpyEJbMAFoVN9+v7L5
	 bihaRO5c7BmkPWYtTAZe3cqi1GOV6qMOrsle59Mw/cSkefNkETid/5NW27i2NqKkBKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641297;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=3R8j+/Fwjb1Rqr262GkW/KC7QfaJNPUx+Sg20voYf/0=;
	b=AOOWLhFzPSnc1Qv0+Ks25Vj/chEkM1A5SU2tgeWaSh0jutSRv8FVTUaYD34sBt+vYgYX
	 IfwcwWDy9PHGrmIbibzfFYhNTRHYiSZV08ErKBaZH0PSG4SIdAvO2Hl6HosyZcrZLiTaG
	 4VTO9rsU4bBtnb0vwCOBB8sa8Ql2oR4YxlO0snlsEyp5ZvmDHDBQ/1M5KxzK1vGrPQqBA
	 tAnTd/xNzEyS4/URI9T+IKEVBRcLQCNFeEc2YTLZSWCWOn4TWTernaRv5ewMRYRLVPcy+
	 nPZTNjjLSXwkHoWGAOQ+xvB0rK/w3R5muTl96EVxQgdhwZhq/Hz3gNegZkm9+lCIf3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GUFpPdQ9;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BA96070C80
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0BA96070C80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GUFpPdQ9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3R8j+/Fwjb1Rqr262GkW/KC7QfaJNPUx+Sg20voYf/0=;
	b=GUFpPdQ9HN9ObaTj9GZpdfgG8ImnPTafzBuxXXohQ0WlkLp83CVDe1d9k1U/xUGyBMji0+
	AiyAjpvZuhZKkY4YN74DlGg7JxRgeLM3J3d4tvJggkC45vOQ6GiFp7bzu5LgwWwYozTyH/
	iiNc3hugAP9NcR3LjAC5RcIMhVPLLVg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-eYYdhgxXOWigscH3ubHrAQ-1; Mon,
 02 Nov 2026 12:41:32 -0500
X-MC-Unique: eYYdhgxXOWigscH3ubHrAQ-1
X-Mimecast-MFC-AGG-ID: eYYdhgxXOWigscH3ubHrAQ_1793641291
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C185A1800BC5;
	Mon,  2 Nov 2026 17:41:31 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E06C30000E3;
	Mon,  2 Nov 2026 17:41:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 01/45] KVM: nVMX/nSVM: check unconditionally whether CR3 is valid
Date: Mon,  2 Nov 2026 12:40:45 -0500
Message-ID: <20261102174130.8779-2-pbonzini@redhat.com>
In-Reply-To: <20261102174130.8779-1-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

nested_vmcb_check_save() checks CR3 legality only if long mode is active,
but it really needs to be checked in all cases - the check uses must be
zero bits of the host, and indeed nested_svm_load_cr3() later will
reject illegal CR3 in every mode.  Move the check earlier, and thus out
of nested_svm_load_cr3().

Likewise for nested_vmx_load_cr3() and nested_vmx_check_guest_state().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 9 +++------
 arch/x86/kvm/vmx/nested.c | 8 ++------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index af0ef678433d..fedddcd1cc96 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -443,7 +443,8 @@ static bool nested_vmcb_check_save(struct kvm_vcpu *vcpu,
 		return false;
 
 	if (CC((save->cr0 & X86_CR0_CD) == 0 && (save->cr0 & X86_CR0_NW)) ||
-	    CC(save->cr0 & ~0xffffffffULL))
+	    CC(save->cr0 & ~0xffffffffULL) ||
+	    CC(!kvm_vcpu_is_legal_cr3(vcpu, save->cr3)))
 		return false;
 
 	if (CC(!kvm_dr6_valid(save->dr6)) || CC(!kvm_dr7_valid(save->dr7)))
@@ -456,8 +457,7 @@ static bool nested_vmcb_check_save(struct kvm_vcpu *vcpu,
 	 */
 	if ((save->efer & EFER_LME) && (save->cr0 & X86_CR0_PG)) {
 		if (CC(!(save->cr4 & X86_CR4_PAE)) ||
-		    CC(!(save->cr0 & X86_CR0_PE)) ||
-		    CC(!kvm_vcpu_is_legal_cr3(vcpu, save->cr3)))
+		    CC(!(save->cr0 & X86_CR0_PE)))
 			return false;
 
 		if (CC((save->cs.attrib & SVM_SELECTOR_L_MASK) &&
@@ -717,9 +717,6 @@ static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
 static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 			       bool nested_npt, bool reload_pdptrs)
 {
-	if (CC(!kvm_vcpu_is_legal_cr3(vcpu, cr3)))
-		return -EINVAL;
-
 	if (reload_pdptrs && is_pae_paging(vcpu)) {
 		if (nested_npt)
 			kvm_register_mark_for_reload(vcpu, VCPU_REG_PDPTR);
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 9b0bfa2f854c..b133e53fde39 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1235,11 +1235,6 @@ static int nested_vmx_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 			       bool nested_ept, bool reload_pdptrs,
 			       enum vm_entry_failure_code *entry_failure_code)
 {
-	if (CC(!kvm_vcpu_is_legal_cr3(vcpu, cr3))) {
-		*entry_failure_code = ENTRY_FAIL_DEFAULT;
-		return -EINVAL;
-	}
-
 	/*
 	 * If PAE paging and EPT are both on, CR3 is not used by the CPU and
 	 * must not be dereferenced.
@@ -3323,7 +3318,8 @@ static int nested_vmx_check_guest_state(struct kvm_vcpu *vcpu,
 	*entry_failure_code = ENTRY_FAIL_DEFAULT;
 
 	if (CC(!nested_guest_cr0_valid(vcpu, vmcs12->guest_cr0)) ||
-	    CC(!nested_guest_cr4_valid(vcpu, vmcs12->guest_cr4)))
+	    CC(!nested_guest_cr4_valid(vcpu, vmcs12->guest_cr4)) ||
+	    CC(!kvm_vcpu_is_legal_cr3(vcpu, vmcs12->guest_cr3)))
 		return -EINVAL;
 
 	if (CC(vmcs12->guest_cr4 & X86_CR4_CET && !(vmcs12->guest_cr0 & X86_CR0_WP)))
-- 
2.52.0


