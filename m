Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802B4402455
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374624; cv=none; b=QbUOlmpiHTBmo23s3ceEjl6twUvBbL9YL+Y+VYSRr0yR4kqf7LLrehrUU8nlxDJ6HdmLzC3fpYTSNnWh0SCVBles6HeTMk3QvbZ+X89PS0gj8nXG36vt3JtOWvmcyoRwLrPMaAFfoeqx5erfAQ1aoyRMViAGancnmy0kuEDIGg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374624; c=relaxed/simple;
	bh=9YKrVHMy/Is4wk0GV6lHiSaj/teDs4EBo29b2+RM9G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oA0xnwgqxPY6V/WkcNgZ26PYiJhfHkVxD1knFvAWrXk2myuL0HhO+5iBeHf5aS2/txg5grO1HIMzgl7xeIaF5SG1Btx7XiIssn3xJErN1BR1Gh45oBFcz4y4VlZWVmSHW8NCr5maD8IRfoenQkzJSLewKzRTt+J5vB/uKpwuZEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NKrY7PiH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKrY7PiH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bX86XKGVtckHkBiIxzqAKcxicpJAva5O8kkQH2k0ltk=;
	b=NKrY7PiHrieHwI+HpmIJdSe342Mqb/qXXM1G5JIrX0ewxqf/0i3IYvLwDinXGu6v83PAFe
	an9a+IHo5yOBd5lmm5GRc6D1TvpnjHhBBOgca/EswJ7e+nF5i51bnu38D4/tB4KRTvL10l
	HaVDMY6Sy2Lkbu7XGQCsPobEUESgXPA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-cXda99BJO7-TXY2qCP_fMw-1; Tue,
 28 Apr 2026 07:10:16 -0400
X-MC-Unique: cXda99BJO7-TXY2qCP_fMw-1
X-Mimecast-MFC-AGG-ID: cXda99BJO7-TXY2qCP_fMw_1777374615
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0315A180034F;
	Tue, 28 Apr 2026 11:10:15 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6EA4719560B1;
	Tue, 28 Apr 2026 11:10:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	d.riley@proxmox.com
Subject: [PATCH 28/28] KVM: nSVM: enable GMET for guests
Date: Tue, 28 Apr 2026 07:09:46 -0400
Message-ID: <20260428110946.11466-29-pbonzini@redhat.com>
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

All that needs to be done is moving the GMET bit from vmcs12 to vmcs02.
The only new thing is that __nested_copy_vmcb_control_to_cache now
ensures that ignored-if-unavailable bits are zero in svm->nested.ctl.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 7 +++++++
 arch/x86/kvm/svm/svm.c    | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index a28c5e8d017b..1d791918efb3 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -508,6 +508,12 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 	to->exit_int_info       = from->exit_int_info;
 	to->exit_int_info_err   = from->exit_int_info_err;
 	to->event_inj           = from->event_inj & ~SVM_EVTINJ_RESERVED_BITS;
+
+	to->misc_ctl		= from->misc_ctl;
+	if (!gmet_enabled || !guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))
+		to->misc_ctl &= ~SVM_MISC_ENABLE_GMET;
+
+	to->event_inj           = from->event_inj;
 	to->event_inj_err       = from->event_inj_err;
 	to->next_rip            = from->next_rip;
 	to->nested_cr3          = from->nested_cr3;
@@ -898,6 +904,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	/* Use vmcb01 MMU and format if guest does not use nNPT */
 	if (nested_npt_enabled(svm)) {
 		vmcb02->control.misc_ctl &= ~SVM_MISC_ENABLE_GMET;
+		vmcb02->control.misc_ctl |= (svm->nested.ctl.misc_ctl & SVM_MISC_ENABLE_GMET);
 
 		nested_svm_init_mmu_context(vcpu);
 	}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index fd79874c5f4b..a82471a6d3ea 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5504,6 +5504,9 @@ static __init void svm_set_cpu_caps(void)
 		if (boot_cpu_has(X86_FEATURE_PFTHRESHOLD))
 			kvm_cpu_cap_set(X86_FEATURE_PFTHRESHOLD);
 
+		if (gmet_enabled)
+			kvm_cpu_cap_set(X86_FEATURE_GMET);
+
 		if (vgif)
 			kvm_cpu_cap_set(X86_FEATURE_VGIF);
 
-- 
2.52.0

