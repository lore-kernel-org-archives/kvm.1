Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1236A3B83FB
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 23:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787787565; cv=none; b=un+2+Iwa8kVj5xKBf7WW2/1IqiajxCPgZAl0cYn2jHL1nytla5yA7tLZO5WgdfhxZSjp6n6KKUDwWynLhjTqUMvtY6qAyiRG3H+fdFvGtQtMudy/zKVy7SH/Q7eNDEASSeYHuMh8/NJpN/kRHpJN9AkctAlv0g+MxN7rfFLcnuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787787565; c=relaxed/simple;
	bh=LBn4L8NUDl0yvODO+6G9Egy3RyVXyCAyGY5Rk7DQUAo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FidpJ4gEy5Fgujn2V/Nq6r+io7KCBr1PbdfIzGSv9z3E9r+/Da60X6wSPhrBnbN8npcxVbBVegOMYm3rb2LXlkarbyKdwzKFdPaizf6r5/umWsmzAH9LGj/6wCJF+wbXRq5iD1wiDKvzrrm8P+PfNHzpIzDRAuztVPOV+4Q9Dyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HtJI+7WD; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HtJI+7WD"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so2523605a91.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787787563; x=1788392363; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5AUNZFgs1KdCrvguiFO2LLkObL9OkQrih/oCexn450g=;
        b=HtJI+7WD3sG/O8u4+8NREzlKU9H2GKGk60/o7LEDw5gYq4MyfhE0Z/wrobAiCcpcEW
         3CdUTg++kzZG/wlIC0bhGF0nfibr6fzxHp3MGSaH2jtScdNs4j0Tj/m5gqSq43wpuZ8i
         UqCxjvfm0HBkKcnoba32oRU8RUxnYg53Vf01YgCXpS4I89Z+YwwOr8IOB14t/zi3Dnkc
         HvdmYqSrLxxR7ZWyP0w2qDcxlToUAercVGqEdO8OaUR89YL0sLrzXTfo0jh2APo7iCYO
         arOp9TyFpsjSOe9b2M5KEN+MhCVi60Yj+tynud+m7v9846nL/sAu8yF+nAM0F5Xp1k35
         QqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787787563; x=1788392363;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5AUNZFgs1KdCrvguiFO2LLkObL9OkQrih/oCexn450g=;
        b=d39GBEFoqeNBqm13jDNcIPZ6gYymO8lnWEuPR4EhDR1oHfA+XgeZKYhKuFmXqKEhNH
         b432AnEC/s4/G1hPEsZrIpSIxwWmZf9aZIOyxgtWPdeAl+p8OHsIa8AOhu2JkANoNTrM
         sx3Rq1E5pEl9WlDLGJGL1ixlgQoca/do/vlZ5nMwDJkTRBgJ4zTCKAl2O5mynVB8v5li
         4wOlYDicvx2BpPYccaaAk5wmBuZMsy5S3D/mBZXmexKGR5I95i9NGJLOkrocTJkgJuXZ
         3+/DxFSGy4edcnoBNymnxJ8jPRHjTUCJ9/zZGVUFlHmnPrA+36bXWYGR6rpa/1OD1kmm
         +3zw==
X-Gm-Message-State: AFuF++m+7a1JzQk43mgcAE8LwXxJsYK8nFukVGamkQoodWNiAP0aeMIk
	KWoAOCCJuUkYQNDFqGRZMyODjRbx/z1KTcP5oN9D3V/MbYNl3hbDIylM/CC6huSz6Lms2nLE4ob
	wQkj6Dg==
X-Received: from pgbcf9.prod.google.com ([2002:a05:6a02:849:b0:cc1:b96e:df3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e290:b0:3d1:66cb:d49
 with SMTP id adf61e73a8af0-3d166cb0e18mr244423637.4.1787787563139; Wed, 26
 Aug 2026 16:39:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 16:39:08 -0700
In-Reply-To: <20260826233919.998904-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826233919.998904-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826233919.998904-3-seanjc@google.com>
Subject: [PATCH v3 02/13] KVM: nVMX: Make VMPTRST return eVMCS GPA when it is used
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, f734222792@gmail.com, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Vitaly Kuznetsov <vkuznets@redhat.com>

VMPTRST with active eVMCS is currently forbidden, however, returning 1
without skipping the instruction will likely result in L1 getting
stuck. While TLFS does not specify the expected behavior, genuine Hyper-V
seems to be returning eVMCS GPA. Implement the same behavior in KVM.

Reported-by: f734222792@gmail.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221841
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index ad3726fd4fda..3058efa65c82 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5964,7 +5964,7 @@ static int handle_vmptrst(struct kvm_vcpu *vcpu)
 {
 	unsigned long exit_qual = vmx_get_exit_qual(vcpu);
 	u32 instr_info = vmcs_read32(VMX_INSTRUCTION_INFO);
-	gpa_t current_vmptr = to_vmx(vcpu)->nested.current_vmptr;
+	gpa_t current_vmptr;
 	struct x86_exception e;
 	gva_t gva;
 	int r;
@@ -5972,8 +5972,16 @@ static int handle_vmptrst(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	if (unlikely(nested_vmx_is_evmptr12_valid(to_vmx(vcpu))))
-		return 1;
+	/*
+	 * Hyper-V TLFS does not specify the behavior of VMPTRST when eVMCS is used
+	 * but genuine Hyper-V seems to be returning eVMCS GPA.
+	 */
+#ifdef CONFIG_KVM_HYPERV
+	if (nested_vmx_is_evmptr12_valid(to_vmx(vcpu)))
+		current_vmptr = to_vmx(vcpu)->nested.hv_evmcs_vmptr;
+	else
+#endif
+		current_vmptr = to_vmx(vcpu)->nested.current_vmptr;
 
 	if (get_vmx_mem_address(vcpu, exit_qual, instr_info,
 				true, sizeof(gpa_t), &gva))
-- 
2.55.0.887.g758fc8c411-goog

