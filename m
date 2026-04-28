Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2B23B2FFC
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374318; cv=none; b=Tr/fXoBUdnie1vB/fzZl12tlli8GzTWBFNiy+DWXmnjxsrVFW6pWoR5OCOvevtH3XCbfyM6wgn8ELHvHJu89aiwPsNRnCzC5zBJ2zHKJ3zHqPhICiYbpMYogPk4m3Hk1StS2CahR99r9Gb0LRt+dIngP1vQpcSC38HUtvv5dCg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374318; c=relaxed/simple;
	bh=L/bGiwcB2+tzqGnM1xrPKnFxS7fmHor44rVb5u+BC1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOPdRGfwi53QT6Hy5TTJkIdplfrv04xCwJmMGJOzJRc5w1n3G+H793wrp9tbz0fVaM8w35G4ff3wrwQXflwvBhJv7Lbp7+kNUwG9fXVIwwTi5zTOPiEC4xavfYXORNSrKvGj4zRsHooieQjWmzWhOKmKx1ddkI62eDIhj97smFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MkZQAx90; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkZQAx90"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXJK+NILD++ngcNyFEJ+TF8xLG0zwpODMztUPty1LQU=;
	b=MkZQAx90A5Ine5onIOCR1V3mY6Xfn2JQizkuC1r+8vS5v7JU50Xq9CuPIl0SiiSrQVuNne
	j+pbeFnlJJGHN7WbOsRGhf4Hs+cwm8h9EOKBrRbFlZOjMk03o5DwotlSgb7YutDMZZUBgQ
	RYCNgSaqPLXg97zAc0twz/yTfdaDNNQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-CmA1RToIMaeLazl9YswofQ-1; Tue,
 28 Apr 2026 07:05:14 -0400
X-MC-Unique: CmA1RToIMaeLazl9YswofQ-1
X-Mimecast-MFC-AGG-ID: CmA1RToIMaeLazl9YswofQ_1777374312
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAAF119560AF;
	Tue, 28 Apr 2026 11:05:12 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 18FE0180047F;
	Tue, 28 Apr 2026 11:05:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Binbin Wu <binbin.wu@linux.intel.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 4/8] KVM: SVM: pass struct vcpu_svm to msr_write_intercepted
Date: Tue, 28 Apr 2026 07:05:03 -0400
Message-ID: <20260428110507.11248-5-pbonzini@redhat.com>
In-Reply-To: <20260428110507.11248-1-pbonzini@redhat.com>
References: <20260428110507.11248-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Remove an unnecessary difference between Intel and AMD.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e7fdd7a9c280..0a2b85db8977 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -661,7 +661,7 @@ static void clr_dr_intercepts(struct vcpu_svm *svm)
 	svm_mark_intercepts_dirty(svm);
 }
 
-static bool msr_write_intercepted(struct kvm_vcpu *vcpu, u32 msr)
+static bool msr_write_intercepted(struct vcpu_svm *svm, u32 msr)
 {
 	/*
 	 * For non-nested case:
@@ -672,8 +672,7 @@ static bool msr_write_intercepted(struct kvm_vcpu *vcpu, u32 msr)
 	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
 	 * save it.
 	 */
-	void *msrpm = is_guest_mode(vcpu) ? to_svm(vcpu)->nested.msrpm :
-					    to_svm(vcpu)->msrpm;
+	void *msrpm = is_guest_mode(&svm->vcpu) ? svm->nested.msrpm : svm->msrpm;
 
 	return svm_test_msr_bitmap_write(msrpm, msr);
 }
@@ -2764,7 +2763,7 @@ static bool sev_es_prevent_msr_access(struct kvm_vcpu *vcpu,
 {
 	return is_sev_es_guest(vcpu) && vcpu->arch.guest_state_protected &&
 	       msr_info->index != MSR_IA32_XSS &&
-	       !msr_write_intercepted(vcpu, msr_info->index);
+	       !msr_write_intercepted(to_svm(vcpu), msr_info->index);
 }
 
 static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
@@ -4414,7 +4413,7 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 {
 	bool force_immediate_exit = run_flags & KVM_RUN_FORCE_IMMEDIATE_EXIT;
 	struct vcpu_svm *svm = to_svm(vcpu);
-	bool spec_ctrl_intercepted = msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL);
+	bool spec_ctrl_intercepted = msr_write_intercepted(svm, MSR_IA32_SPEC_CTRL);
 
 	trace_kvm_entry(vcpu, force_immediate_exit);
 
@@ -4556,7 +4555,7 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 
 	vcpu->arch.regs_avail &= ~SVM_REGS_LAZY_LOAD_SET;
 
-	if (!msr_write_intercepted(vcpu, MSR_AMD64_PERF_CNTR_GLOBAL_CTL))
+	if (!msr_write_intercepted(svm, MSR_AMD64_PERF_CNTR_GLOBAL_CTL))
 		rdmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, vcpu_to_pmu(vcpu)->global_ctrl);
 
 	trace_kvm_exit(vcpu, KVM_ISA_SVM);
-- 
2.52.0


