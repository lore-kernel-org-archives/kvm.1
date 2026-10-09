Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C815D3DE43D
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 20:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579046; cv=none; b=euK/KxomoA03JEQeqR5NbZzjCzAnyceLp7P22idofHQJLVChAWWBAEETx4B6soHnx8leKqtfxhJA22VJa1s+R//sg/1DcX5QDQlYLC1Pp58Pzo3Z9/Ml4hHakA48v8+fQVkA9200rUmal0k7Zopteay7B1BeQ0/N3lGOk4cXizU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579046; c=relaxed/simple;
	bh=8Gs1d740/WG62XMlf0EOI35ECZVTTmQ0jDWyGyhy+FE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oC34nEP8M4qX/iA/cKJqZLIU+bgDipCqadCc/aJ/OfKJpnE7/QF1Pt9urWa9PT/8DbQcMZDzl10BXSgdRt7TK94y7Gt3Unzfknqcc9rAaXzE+46uXB98/4883ZLC7symSp3SD9m1mVaM6YLLSzMcVwyBb+y2/6G1QURXugeDlCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FDLkKNP5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDLkKNP5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791579043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=goJ42vVa/6g/ckeQD9hR1HE5AR+RatDSYAG7UDCyL6U=;
	b=FDLkKNP5J08NjcVgcD9Bz8GE05d8hwzfhc2CzzV0gAxT15y6rF36ciyGvdpzXY+bRnLadX
	5E33MsQP/1cPEu2OHBaK2k5BPdhxv2LSOtpXaxSu/Thl/KkzjRAZK4rm1bbXMQ7Q2MXB6S
	wPOtfTSn182GeR4j2a87WgFnX0HNSuA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-HFsqf8mNMJy1kjSxIem0uA-1; Fri,
 9 Oct 2026 20:50:42 +0000
X-MC-Unique: HFsqf8mNMJy1kjSxIem0uA-1
X-Mimecast-MFC-AGG-ID: HFsqf8mNMJy1kjSxIem0uA_1791579041
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FA3719540FC;
	Fri,  9 Oct 2026 20:50:41 +0000 (UTC)
Received: from mlevitsk-thinkpadt14gen3.ibmmarkh.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3ED6E18004D4;
	Fri,  9 Oct 2026 20:50:40 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 2/2] KVM: nVMX: avoid losing the posted notification interrupt when exiting L2
Date: Fri,  9 Oct 2026 16:50:36 -0400
Message-ID: <20261009205036.672523-3-mlevitsk@redhat.com>
In-Reply-To: <20261009205036.672523-1-mlevitsk@redhat.com>
References: <20261009205036.672523-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

While delivering a nested posted interrupt notification
(see vmx_deliver_nested_posted_interrupt), KVM assumes that,
as long as the target vCPU is in the guest mode, KVM can send the
special POSTED_INTR_NESTED_VECTOR, which will either trigger APICv ucode
to inject all interrupts into L2 or cause a VM exit, after which
vmx_complete_nested_posted_interrupt is supposed to finish the job.

However, a third case is possible: if the target vCPU is about to exit
to L1, the posted notification interrupt must be instead injected
to L1' APIC, but KVM doesn't do this.

Detect this case in the nested VM exit path and act accordingly.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 2142e25c9b6c..4d8bb7f7fcd4 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2445,7 +2445,7 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct loaded_vmcs *vmcs0
 			 ~PIN_BASED_VMX_PREEMPTION_TIMER);
 
 	/* Posted interrupts setting is only taken from vmcs12.  */
-	vmx->nested.pi_pending = false;
+	WARN_ON_ONCE(vmx->nested.pi_pending);
 	if (nested_cpu_has_posted_intr(vmcs12)) {
 		vmx->nested.posted_intr_nv = vmcs12->posted_intr_nv;
 	} else {
@@ -5162,6 +5162,14 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 	kvm_clear_exception_queue(vcpu);
 	kvm_clear_interrupt_queue(vcpu);
 
+	if (lapic_in_kernel(vcpu) && vmx->nested.pi_pending) {
+		vmx->nested.pi_pending = 0;
+		if (!WARN_ON_ONCE(vmx->nested.posted_intr_nv == -1)) {
+			kvm_lapic_set_irr(vmx->nested.posted_intr_nv, vcpu->arch.apic);
+			kvm_make_request(KVM_REQ_EVENT, vcpu);
+		}
+	}
+
 	vmx_switch_vmcs(vcpu, &vmx->vmcs01);
 
 	kvm_nested_vmexit_handle_ibrs(vcpu);
-- 
2.54.0

