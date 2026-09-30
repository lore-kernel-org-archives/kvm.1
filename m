Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E3134E75A
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 01:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790730820; cv=none; b=En7WLYJGucJUcpvqpfTx8f1TtZ1ihjZZ0NqMYFai3MTngpt8QxEDthHdpPPcKG7JwuLuRfG5tIc5XHB4ltdHOK1j1mQn6cMeVbfQ+ZfPf6KrcU0ifMlttdqzVT5FCA4zqzxxFV3qv6RckpOCel9NPw04kPp1D52XHBI6HfQT5xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790730820; c=relaxed/simple;
	bh=MSuuc/cocbqG6Hsb1NWDCs84MFsTBnA7k6WbI0Ly02c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hn8yqNMelQifo8RW/IgkC8nsY+YvQ98aYJR8UJHpoXYrUHfTWj1S5zORWpWRtcf3YSW4hdsaz9x+rsZh8tAFVdMjQuTP+Suotkvcv/Ae5r+nCoofs8JYOoZzlvAwKcv0ov9+v7fMA19J4am5VauOkaV9s2PDePCn18bQNEYteJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C02+AWsT; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C02+AWsT"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39b77130a7fso5095257a91.2
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 18:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790730807; x=1791335607; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b4O4inbQYDjTuXf1AXWgPFLW4HG4gSKfcYxNlQZJdQM=;
        b=C02+AWsT+F6IU1Q/cWcLU9pQnMKk8b8Wn7jYPQpX0xbaQoznvSLtVk1LzdMsTgeE9b
         MKNwZVx6HqaPsag3GH/2mt/0eHsxwvF/dRb178wum52tmxDvUl9nAoi0/FG17XrbhD5t
         CZNfXRxLNC1mJ3HThTauWFMapCWJcdCZRau+f/Y30jSeCs7HjgrBnDXMn3C7+JUnCLDx
         wQF9O/6pckvnOhRrHYp4dtx8YHEIFhioGHcSpbFxVkS5EaohZRgXCIgOvxbPhr8r5AuT
         noqw+3G1ZbInqnrNQVKv6C32VNaonoiIlvEBfNBl5DclMjwjfXz8eSxQ/ItgBBuAsuMr
         W1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790730807; x=1791335607;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b4O4inbQYDjTuXf1AXWgPFLW4HG4gSKfcYxNlQZJdQM=;
        b=ZnJo+EEF9Xtn1Bj0WAhkGPGNE9niFchpKDuVqo7hKUfPv43nSKRWxW40EQrkuc/BZ1
         kkzadNp8i6RysKnK0aZIxNnYrKm0Zfz2qtnD45f2Vvf3Oo+xHdTHFWYYZq/Gc4rNjzPI
         Y6vGYMsc+442hOTxT3Z8b0dhOqBAf4L1DVbuK82u9md51wSxdlsLRQ7gptJCYo0U0P7t
         zUSfREOCd3iRurBpIa5o3BLb21Dc4+IpsnEcq30EQvfYyIaG0Ymr0o0MUN5/mnP6gzkb
         Hxth5Z4YiNWeHQOMEthrQ97TY/+5ivAYo6so4uEOKtavUNcT/mF1/wlgDxt06YcSvExS
         U7tA==
X-Gm-Message-State: AFq9FYIw4AASUq+ELg21QIvJMOG9Mdi3W4B17X7f86SiIVnPjNZeptdH
	Fdz8edEvjvBip/D/Pnbdn+5mfnlR0Fbwzix3nQdjQrP7kOiMzlPD+uZUbLAtFD+24LQvk6xiVJP
	u5hkB/Q==
X-Received: from pgbeu25.prod.google.com ([2002:a05:6a02:4799:b0:cc7:ac48:5288])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5826:b0:3a0:abe7:f0f3
 with SMTP id 98e67ed59e1d1-3a4bf67a802mr891804a91.0.1790730806186; Tue, 29
 Sep 2026 18:13:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Sep 2026 18:13:10 -0700
In-Reply-To: <20260930011313.3197688-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930011313.3197688-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930011313.3197688-10-seanjc@google.com>
Subject: [PATCH v5 09/12] KVM: nSVM: Open code check on LBR virtualization
 being enabled in vmcb12
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

Now that KVM clears ENABLE_V_LBR if LBR virtualization isn't supported when
caching vmcb12 control fields, i.e. now that the logic is a simple
one-liner, open the check and drop the now-superfluous wrapper.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index aca2bbc66f47..d3f249cd0f2d 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -738,11 +738,6 @@ static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 	return 0;
 }
 
-static bool nested_vmcb12_has_lbrv(struct kvm_vcpu *vcpu)
-{
-	return to_svm(vcpu)->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR;
-}
-
 static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
 {
 	struct vmcb_ctrl_area_cached *control = &svm->nested.ctl;
@@ -817,7 +812,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
 		vmcb_mark_dirty(vmcb02, VMCB_DR);
 	}
 
-	if (nested_vmcb12_has_lbrv(vcpu)) {
+	if (control->misc_ctl2 & SVM_MISC2_ENABLE_V_LBR) {
 		/*
 		 * Reserved bits of DEBUGCTL are ignored.  Be consistent with
 		 * svm_set_msr's definition of reserved bits.
@@ -1310,7 +1305,7 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
 		vmcb12->control.next_rip  = vmcb02->control.next_rip;
 
-	if (nested_vmcb12_has_lbrv(vcpu))
+	if (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR)
 		svm_copy_lbrs(&vmcb12->save, &vmcb02->save);
 
 	vmcb12->control.event_inj	  = 0;
@@ -1387,7 +1382,7 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	if (!nested_exit_on_intr(svm))
 		kvm_make_request(KVM_REQ_EVENT, &svm->vcpu);
 
-	if (!nested_vmcb12_has_lbrv(vcpu)) {
+	if (!(svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR)) {
 		svm_copy_lbrs(&vmcb01->save, &vmcb02->save);
 		vmcb_mark_dirty(vmcb01, VMCB_LBR);
 	}
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

