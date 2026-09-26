Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064BE36AB57
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790400784; cv=none; b=sw5oOlbMlob8ykihw484+hIwYtjC7ZFYJbO0zTygx4/h10EY+1piIfYuUuvTp3TVJT+QTrTnJEFK+GmcqFaO/SPqlv0R0ZcSlmfYoMZtIyik1fCqr4Q28wSkAyIEJvXpcvcrb3qMK6I4uBOMxaby3GkSJN6DzR/AyaETMbRwp0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790400784; c=relaxed/simple;
	bh=LP1Mo/+qtlNiDbET+icLfCVVnZivL4paAfEKkoG9vcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rKIysGB9swU7E9RWZ78xHZXawxycpOAKV9Tau/mKYOx3IrLctB8hIdiTUK3zW5rfi0eC8BrL05rtvhWTPVm3YlTwCRpiwjsqveo+L1YtplOBoIW/377UcUcJN9kYUahP6w/TJx3Tji7otvBj/xJZAaoMUiAvPUEZBBisxRVn/Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gzhQPRBd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzhQPRBd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790400782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k+mFmNWrgUdoHUEMI2VAYZJLdPonHlkU8azhPXbczd0=;
	b=gzhQPRBd7CEzBtovz4Hw1sODPISNcabfhZR+Uo7TY9hSiCcqAFYfJqTffVNR1BsgtHwM3R
	Rp+SOQ4Oek0n5tn74RpqJj8aF4L1a61KwYh2gSUDOtv5LKCTwdDBxKfs26HqRwKRDV9O4P
	oaXpEstZ3mb9Fpubmc7axCVbDodUC/8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-Hcta0zbcOm-jLNcFpjSWhQ-1; Sat,
 26 Sep 2026 01:32:58 -0400
X-MC-Unique: Hcta0zbcOm-jLNcFpjSWhQ-1
X-Mimecast-MFC-AGG-ID: Hcta0zbcOm-jLNcFpjSWhQ_1790400777
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54BCD180062F;
	Sat, 26 Sep 2026 05:32:57 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA7C31956086;
	Sat, 26 Sep 2026 05:32:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 03/11] KVM: SVM: Don't mark ASID fields as dirty when setting control.tlb_ctl
Date: Sat, 26 Sep 2026 01:32:45 -0400
Message-ID: <20260926053253.195597-4-pbonzini@redhat.com>
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

Don't mark the ASID as dirty in the VMCB when requesting a TLB flush via
control.tlb_ctl.  Per "15.15.3 VMCB Clean Field" of the July 2026, Revision
3.45 version of the APM:

  The following are explicitly not cached and not represented by Clean bits:

    * TLB_Control

Fixes: 7e8e6eed75e2 ("KVM: SVM: Move asid to vcpu_svm")
Suggested-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260904170642.3291466-4-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 1 -
 arch/x86/kvm/svm/svm.c | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6aa86a78711e..3448d56520c6 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3620,7 +3620,6 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
 
 	sd->sev_vmcbs[asid] = svm->vmcb;
 	svm->vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
-	vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b63e7c69aa1c..830ace75e986 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4527,10 +4527,8 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 		svm->vmcb->control.asid = svm->asid;
 		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
 	}
-	if (this_cpu_ptr(&svm_data)->flush_all_asids) {
+	if (this_cpu_ptr(&svm_data)->flush_all_asids)
 		svm->vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ALL_ASID;
-		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
-	}
 
 	svm->vmcb->save.cr2 = vcpu->arch.cr2;
 
-- 
2.52.0


