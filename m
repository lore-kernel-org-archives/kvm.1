Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B9B353A74
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 05:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790400783; cv=none; b=tEGQ6RF2VTfODH1pA0Eb7XSlKcOU81yzsSESCvHW/TavNev3S/SQ295CLUrwZlFqJ+00p4Wlgw4/VAvgV0ie+zHnUulkQPBhfjOiMGY+laeiDjKVxFDvlc3/Eq9qKPmnna92/1DguLR4ZnO6D7JmjRDOIBimhK8Ev0yPW5igwKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790400783; c=relaxed/simple;
	bh=sSWnGSSx+2MzgqSedXBivc+bYxWK/rlqlfMUmAoFK/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKeSvHGzU4mGHnOtBUXXY5up6xnE1vwDfOIFA2YlMDzpj6BenV6kx4zprVMAhZ/ij6rJuTuiVYLju14Hx0FzwPAJrCwyXNjBnJ6ZE+eJ84TPb+eonagqk4Hubyi9UzB6bU00y2EcIg8l7tAEVHLyxYQyU2t5twRyG9zJxYFAIDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NuBRZB4b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NuBRZB4b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790400781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLh/jWHSJt4+u5rPO8oam8ng5lJ2R0H8ueCuvrITFnE=;
	b=NuBRZB4bhy7uJH47LulZlPNu7VQs1dpKebxBb6FuAxs7b8ehOXJo5sZHpbk9shv1vrZ56F
	Gfgzeml9lm4FA+ehyhK6/Ws2lfbyeGNPQbhC3/w2FqKOH5JzWETBNC2LxPLNCiT0+bHiho
	y8jvoPhEajpp9PAKRbeJjyE/D5Iz4po=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-5qBm6yqbM1K8jh5LVlJTag-1; Sat,
 26 Sep 2026 01:32:58 -0400
X-MC-Unique: 5qBm6yqbM1K8jh5LVlJTag-1
X-Mimecast-MFC-AGG-ID: 5qBm6yqbM1K8jh5LVlJTag_1790400778
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEBD11956070;
	Sat, 26 Sep 2026 05:32:57 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B6EF1956086;
	Sat, 26 Sep 2026 05:32:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>
Subject: [PATCH 04/11] KVM: SVM: Sync guest's PERF_CNTR_GLOBAL_CTL from h/w only on successful VMRUN
Date: Sat, 26 Sep 2026 01:32:46 -0400
Message-ID: <20260926053253.195597-5-pbonzini@redhat.com>
In-Reply-To: <20260926053253.195597-1-pbonzini@redhat.com>
References: <20260926053253.195597-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Sean Christopherson <seanjc@google.com>

Don't (re)read PERF_CNTR_GLOBAL_CTL from hardware on a failed VMRUN, as the
purpose of the read is to synchronize KVM's cache with any writes done by
the guest, and the guest can't possibly have modified the MSR if it never
got a chance to run.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260904170642.3291466-5-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 830ace75e986..f4f488328ea4 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4632,6 +4632,10 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 			svm->vmcb->control.erap_ctl &= ~ERAP_CONTROL_CLEAR_RAP;
 
 		vmcb_mark_all_clean(svm->vmcb);
+
+		if (!msr_write_intercepted(svm, MSR_AMD64_PERF_CNTR_GLOBAL_CTL))
+			rdmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
+			       vcpu_to_pmu(vcpu)->global_ctrl);
 	}
 
 	/* if exit due to PF check for async PF */
@@ -4641,9 +4645,6 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 
 	kvm_clear_available_registers(vcpu, SVM_REGS_LAZY_LOAD_SET);
 
-	if (!msr_write_intercepted(svm, MSR_AMD64_PERF_CNTR_GLOBAL_CTL))
-		rdmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, vcpu_to_pmu(vcpu)->global_ctrl);
-
 	trace_kvm_exit(vcpu, KVM_ISA_SVM);
 
 	svm_complete_interrupts(vcpu);
-- 
2.52.0


