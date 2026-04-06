Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D1139EF2D
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 22:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775516044; cv=none; b=OsM6vZGsvWohDRUkYvlZH029cdD+O32+2qA4eixUHeIxnzd9JTwWjCZOKHEXMF35bXUg0M0L7Zzly7rx9SOwPQKmk5R9IFAILFc38jBNlFplY2cetNOVm/cvrh1pP+Wk1owRdIzoM6QD68FZ7r0b24ySwQTyAS/qdNTuiPZrKZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775516044; c=relaxed/simple;
	bh=MuoBagMWt/jDcUgfLpJaGKUrnLGqM8jeOkFxXnsMjRM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cn1R8CcANtTrFaWIvd/AaJrU8yxPkeF29O8CnBBbBIB+gjSHVIjAXwatpLwZUHPBKFe9wyLhzpLgBsgnS7TjKtyfqDAKYlDpjmnluNS5JPL1n80v5X+8Ktf/pHy2MkmzqeazDgyuHNTCoD19Ccr+hDU5ZQAP9EdM8Vy+8LhBMek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FnUoBFCK; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FnUoBFCK"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82cf8dcd079so3103986b3a.1
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 15:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775516043; x=1776120843; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yEGEx+La+PH+2Jiph98j/xu2MhRe4olp8x4K7K50o+s=;
        b=FnUoBFCKSic0cqprdMKncQlJKd5R52FDiRS0SdJZ/gmN27rGoD8VZRbFAa/rD9kc6y
         hidzFzMEj10YWutD7W2uLI7sctxergJP4oxNxePU1Z8avsCr7ppoa6pDpYE5ojdmd8c1
         8fXBpSVs4HX4WJTlYVwvSasy/5grgpVQe23dWg2Xc4jfkHvtophz+rJpulNzh9Ynpb2/
         2H9IyNGGTnaueZxLygMRy6eHLvf6+V9rOhNM3T+ntZ9HkMlxImqsBa3qtBwpPeFL+H+0
         EV3mX7LlMse2KIivU8Z2IiChtsNebuQ9YYGTGydHgHLr/+zn7+fnUeHQGfSkIGIWW76H
         Tt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775516043; x=1776120843;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEGEx+La+PH+2Jiph98j/xu2MhRe4olp8x4K7K50o+s=;
        b=mJrdZm2iR4ay2unioODKtMiZX8ivSnxQoXUN1TWWqYV0mnsdk6/6CDquecewTFaeJw
         ZP5wGW66NvbtRtBkC5Xfg5VfcP0JVxU9xZTiFK5skbulTfTrmTXV24/v0+yMkuC92E6r
         0mD5C7kzUVCFUyCzm7696JYkBtm1djU476nPnHs3mZ6ApVCX5p5/NX74TYuD4dGv1uO6
         skr+KIJcT/ORbpiYDfwCbCkDAf++Tnc5mX6bqdTvhx5Y6sZcDlJ2GsjpiTSa5hlzpnkR
         LjI+5BAkGZXPPjk/wrhxwAqT+P30SmIBjWFrzPCPr00+MxtpS7aW+0YNyy3VVKp7QSRU
         Y0Cg==
X-Gm-Message-State: AOJu0Yw2sqxeCvQjji5QDD09we8TeUALCW8weKnhK18dxnVYlmIafcM/
	r6/fOjkUlYNXVHvsMrxqo9ycq0uSfzlsOcRdhkd5FjtLLb6/L3LKe/YqWF1AMVk7LSbiNrvU7VZ
	NF78/5w==
X-Received: from pfbic15.prod.google.com ([2002:a05:6a00:8a0f:b0:82a:6195:3c55])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3926:b0:7f7:2f82:9904
 with SMTP id d2e1a72fcca58-82d0da2c50cmr14753321b3a.5.1775516042723; Mon, 06
 Apr 2026 15:54:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon,  6 Apr 2026 15:53:56 -0700
In-Reply-To: <20260406225359.1245490-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260406225359.1245490-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260406225359.1245490-2-seanjc@google.com>
Subject: [PATCH v3 1/3] KVM: x86: Don't leave APF half-enabled on bad APF data GPA
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+bc0e18379a290e5edfe4@syzkaller.appspotmail.com, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Ethan Yang <ethan.yang.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ethan Yang <ethan.yang.kernel@gmail.com>

kvm_pv_enable_async_pf() updates vcpu->arch.apf.msr_en_val before
initializing the APF data gfn_to_hva cache. If userspace provides an
invalid GPA, kvm_gfn_to_hva_cache_init() fails, but msr_en_val stays
enabled and leaves APF state half-initialized.

Later APF paths can then try to use the empty cache and trigger
WARN_ON() in kvm_read_guest_offset_cached().

Determine the new APF enabled state from the incoming MSR value, do cache
initialization first on the enable path, and commit msr_en_val only after
successful initialization. Keep the disable path behavior unchanged.

Reported-by: syzbot+bc0e18379a290e5edfe4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bc0e18379a290e5edfe4
Fixes: 344d9588a9df ("KVM: Add PV MSR to enable asynchronous page faults delivery.")
Link: https://lore.kernel.org/r/aHfD3MczrDpzDX9O@google.com
Suggested-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Ethan Yang <ethan.yang.kernel@gmail.com>
[sean: don't bother with a local "enable" variable]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0a1b63c63d1a..c35d359b56dd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1043,11 +1043,16 @@ bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_require_dr);
 
-static bool kvm_pv_async_pf_enabled(struct kvm_vcpu *vcpu)
+static bool __kvm_pv_async_pf_enabled(u64 data)
 {
 	u64 mask = KVM_ASYNC_PF_ENABLED | KVM_ASYNC_PF_DELIVERY_AS_INT;
 
-	return (vcpu->arch.apf.msr_en_val & mask) == mask;
+	return (data & mask) == mask;
+}
+
+static bool kvm_pv_async_pf_enabled(struct kvm_vcpu *vcpu)
+{
+	return __kvm_pv_async_pf_enabled(vcpu->arch.apf.msr_en_val);
 }
 
 static inline u64 pdptr_rsvd_bits(struct kvm_vcpu *vcpu)
@@ -3647,18 +3652,19 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
 	if (!lapic_in_kernel(vcpu))
 		return data ? 1 : 0;
 
+	if (__kvm_pv_async_pf_enabled(data) &&
+	    kvm_gfn_to_hva_cache_init(vcpu->kvm, &vcpu->arch.apf.data, gpa,
+				      sizeof(u64)))
+		return 1;
+
 	vcpu->arch.apf.msr_en_val = data;
 
-	if (!kvm_pv_async_pf_enabled(vcpu)) {
+	if (!__kvm_pv_async_pf_enabled(data)) {
 		kvm_clear_async_pf_completion_queue(vcpu);
 		kvm_async_pf_hash_reset(vcpu);
 		return 0;
 	}
 
-	if (kvm_gfn_to_hva_cache_init(vcpu->kvm, &vcpu->arch.apf.data, gpa,
-					sizeof(u64)))
-		return 1;
-
 	vcpu->arch.apf.send_always = (data & KVM_ASYNC_PF_SEND_ALWAYS);
 	vcpu->arch.apf.delivery_as_pf_vmexit = data & KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT;
 
-- 
2.53.0.1213.gd9a14994de-goog

