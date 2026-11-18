Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=129.187.255.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009087;
	b=baE4Mwec1vqBB/k9yxJrEv2p3QlkgQncSe2cwPxKV+qSSdNhwoF3+5sOingUYFrodL8M
	 Nrqm9QUtu4E+DwNAbaByF69G6eXDKDwp2ujR0guptXbS01QYuzJmXoPf1bfgLlwwKQ9ml
	 wXB0qH5aF9h57F3kgTCqtqmBjaDu5TAohRhUNzhuNljSMZ1OLmyhhw2VPzcnOIBfTa9Wc
	 5BxsflfhnXA4EvYOF1NrEawRf52k4XlSvFL3X0Jq/qaC9Uhg0Q3voNMHTjGTSM1QtwSwh
	 dW4baxkThdrbLnkoKHr6WIaYalqVRsTPQYFqGmmkrwZ8JXbs4Ha71SZuJ9wVf22qVOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009087;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Spam-Status:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8//k5ttdYzeGKTkiWS5uRFawlJ8TOcPxa6C8o51o7eg=;
	b=yqa3fFyWk8IBapcq1pjMjEronCglCoDhsQ5no87rXQe2wR9zP04HFck3bYf4+GEEPwmV
	 4/xP90erbudCwhiX4F6g0NnyuS3qTgKUufYrONZcM5Napr/nVcvJNJ4g9B5SxZFEsVL1k
	 zDyV+SrxgM28ip6CNeU1V99DKAr6E1pCumaRrEKi1n7xtPVI+5yXfytyj9Jvf1xGj22wU
	 GFG8hCC0w0OV1IqdEhH/4Mthvi2FM8KhPyNhF3lBG1FaNw8BxYUtm52J4ouL734GHcV2l
	 DyOjh5tDHmjWC0rMJ0sOQwQVpWcIIc2ndAvyyeNt1BTiyNpGgJUJRNEV1Vm7bDiZXNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tum.de;
	spf=pass smtp.mailfrom=tum.de;
	dkim=pass header.d=tum.de header.i=@tum.de header.a=rsa-sha256 header.s=tu-postout21 header.b=VzDe3s0r;
	arc=none smtp.remote-ip=129.187.255.137
Received: from postout1.mail.lrz.de (postout1.mail.lrz.de [129.187.255.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3A1606A32C
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 13:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD3A1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tum.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tum.de header.i=@tum.de header.a=rsa-sha256 header.s=tu-postout21 header.b=VzDe3s0r
Received: from lxmhs51.srv.lrz.de (localhost [127.0.0.1])
	by postout1.mail.lrz.de (Postfix) with ESMTP id 4jV2jK4FKqzyWm;
	Wed, 18 Nov 2026 14:37:57 +0100 (CET)
Authentication-Results: postout.lrz.de (amavis); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tum.de; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:to:from:from:received:received; s=
	tu-postout21; t=1795009077; bh=8//k5ttdYzeGKTkiWS5uRFawlJ8TOcPxa
	6C8o51o7eg=; b=VzDe3s0rbJigDD1b0sqE0YzekkZJAVSwzmWrJcZ7aq45eXnqW
	+nJltaPD/x+k+5Vnvv5rEzsKxSOwG3jVeAD3w9qDT0I1/g48yS0X5qjY2F0vZvSo
	d6ZuDlo4VjctRK8ViunEqsoVnujg+HWJ+Y3b0H3z2Lbrozmsg3HP/HGmamKnK3bz
	fD/NPuLRDfTglP0Gz0X6XXnoxouQh9QUqdoWge+tinF3PHW9UHfLUoaczLw5Sau+
	EBrJuJA+QqULJvQZ+Y/feOWRg9H4XoPjR2muiJkM0ib1mob9CSylZ9j9wIKKR+qt
	YS4Dg9Rp8Jq1snlSh+6DVi1gPsMNNT208KKzg==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs51.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.876
X-Spam-Level:
Received: from postout1.mail.lrz.de ([127.0.0.1])
 by lxmhs51.srv.lrz.de (lxmhs51.srv.lrz.de [127.0.0.1]) (amavis, port 20024)
 with LMTP id JPgjm0QOOB-K; Wed, 18 Nov 2026 14:37:57 +0100 (CET)
Received: from ovo.fritz.box (unknown [IPv6:2a02:2455:1b1c:5000:a2c4:f9c8:74:1614])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by postout1.mail.lrz.de (Postfix) with ESMTPSA id 4jV2jJ6fqjzyVW;
	Wed, 18 Nov 2026 14:37:56 +0100 (CET)
From: Manuel Andreas <manuel.andreas@tum.de>
To: kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	Manuel Andreas <manuel.andreas@tum.de>
Subject: [PATCH] KVM: nSVM: Reject EVENTINJ of #BR/#OF into a 64-bit L2
Date: Wed, 18 Nov 2026 14:37:41 +0100
Message-ID: <20261118133741.1185904-1-manuel.andreas@tum.de>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nested_svm_event_inj_valid_exept() treats BR_VECTOR and OF_VECTOR as
unconditionally valid for TYPE=3 (exception) injection.  However, the APM
(Vol 2, 15.20) states that injecting an event that is impossible for the
guest mode, e.g. #BR into a guest in 64-bit mode, makes VMRUN fail with
VMEXIT_INVALID.  BOUND and INTO are both invalid in 64-bit mode.

Because the check depends on both the control area (EVENTINJ) and the save
area (EFER/CR0/CS), add it to nested_svm_check_cached_vmcb12(), which covers
both nested VMRUN and RSM, rather than to nested_vmcb_check_controls().

Fixes: 7e79f71bca5c ("KVM: nSVM: Add missing consistency check for EVENTINJ")
Signed-off-by: Manuel Andreas <manuel.andreas@tum.de>
---
 arch/x86/kvm/svm/nested.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 1cecb82702e2..c69d334e3c3c 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -378,6 +378,8 @@ static bool nested_svm_event_inj_valid_exept(struct kvm_vcpu *vcpu, u8 vector)
  * set and:
  * - The type of event_inj is not one of the defined values.
  * - The type is SVM_EVTINJ_TYPE_EXEPT, but the vector is not a valid exception.
+ * - The event is impossible in the guest's mode. However this depends on
+ *   save state, see nested_svm_check_event_inj_mode().
  */
 static bool nested_svm_check_event_inj(struct kvm_vcpu *vcpu, u32 event_inj)
 {
@@ -398,6 +400,31 @@ static bool nested_svm_check_event_inj(struct kvm_vcpu *vcpu, u32 event_inj)
 	return true;
 }
 
+/*
+ * #BR and #OF are invalid in 64-bit mode, but not in compatibility mode,
+ * hence the CS.L check. VMRUN ignores EFER.LMA and derives
+ * long mode from EFER.LME, CR0.PG and CR4.PAE, so do the same.
+ */
+static bool nested_svm_check_event_inj_mode(u32 event_inj,
+					    struct vmcb_save_area_cached *save)
+{
+	u32 type = event_inj & SVM_EVTINJ_TYPE_MASK;
+	u8 vector = event_inj & SVM_EVTINJ_VEC_MASK;
+
+	if (!(event_inj & SVM_EVTINJ_VALID))
+		return true;
+
+	if (!((save->efer & EFER_LME) && (save->cr0 & X86_CR0_PG) &&
+	     (save->cr4 & X86_CR4_PAE) && (save->cs.attrib & SVM_SELECTOR_L_MASK)))
+		return true;
+
+	if (type == SVM_EVTINJ_TYPE_EXEPT &&
+	    (vector == BR_VECTOR || vector == OF_VECTOR))
+		return false;
+
+	return true;
+}
+
 static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
 				       struct vmcb_ctrl_area_cached *control)
 {
@@ -488,6 +515,11 @@ int nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu)
 	    !nested_vmcb_check_controls(vcpu, &svm->nested.ctl))
 		return -EINVAL;
 
+	/* This check requires both save and control state. */
+	if (CC(!nested_svm_check_event_inj_mode(svm->nested.ctl.event_inj,
+						&svm->nested.save)))
+		return -EINVAL;
+
 	return 0;
 }
 

base-commit: cbe54fc3462b3949ab27b9ae81fb9ddb509040c7
-- 
2.56.0

