Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9413A5E91
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 23:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775779007; cv=none; b=Z9JApvaxVGgeS3Mkxd10iyXDK87sjiTOYMRf/B0ZpigM2vl64DM5TkBclk2ABxqfBBazKiouqaKWpPfVaFJoK58TIVHvgjNQkWiPwuSRbwAkcfUyOOuIab5iMSPzZUGdJ7dcSk0bAoJ/3UKulLO7Gt2GCqSj41jI9e6GoCqJHYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775779007; c=relaxed/simple;
	bh=FzKu0OplO/x9QZxtsn2/t8O/sWHDPaNkNqVuS6SOMm8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fjEeUGpkYctGfUP0hHS72g/7FggIogD2rvgyxOazx4dv/VHuJxwyJ/CkYRgAl6GVhLWfQmOoz7cftE/u4d9GACNpig4uCAGu7oV0BHQ+WJ89qYUKguwYNzLLBYiRulP6hu3PChg6AhAsH84SpGRjjq91J4Fk/02M+1iwWHxxBpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NCWtRs7s; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NCWtRs7s"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c76b06f37a7so904923a12.0
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 16:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775779005; x=1776383805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6pa7uOXW0iVK999jHvqL3WwweCQCgdlv9Jsr1DM564M=;
        b=NCWtRs7shMyEWDsWcnnSIaiJ9jZN/RkTmm2GzeS7ueFLURYjMR8r9m6k84EdqsUkeJ
         fgmxZT0Ou1CXGCk6H9C8bq5N/XeW+5rklo28lN81/+NfrLkkARNBV73uDdt7G2wa2Gwm
         hx7YVdVOM80qSRJ+rT79qzXwtJ/tGK6S9x4fljv8DyYgqh1mI7Li0Ek9jStbVP2Qbw6H
         ii7rifCu8kfZ99KKqE+DbjTKeMYuqI/37s3b4o7G4iS3if7OMUqZivp8qPE+nC1C3D/t
         oh/maTiw/uOHP4LQR2PtZ/JMtwg+I8dYLUzW9AUx7bs0wZrNjnZe81OUm4qtXZJp9FPU
         tPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775779005; x=1776383805;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6pa7uOXW0iVK999jHvqL3WwweCQCgdlv9Jsr1DM564M=;
        b=FgZmQ4IJKg6hTphRvW95V3D5YUNe5vd0KQ7ef3+ijmMAiq5lzIUH1XVnyvwNAH96Ti
         ask4q+OeYkbXv75cgSccH352XSyMcxQxwDMwCvT74kYgb5esOLSlVw5O1kp0b/YWlIvp
         1yXaL/y+knYoQra9Ad/tW93TyxfoFil6uLqfwm/SoDuK67U1dm0lceqt9utuhPHXSEt7
         9BrtVESpw56z+tVIXjp73vcqzG36MgKPVTJ52pJB9V0lyVmK0Bo9450un22yYOhXOsRY
         C0fPwxWRTp9oSyKM5T5l1WiPRJTWsoP2Cw7soAOFNLzzIki+GDIDS5HnknXrapbnK/2B
         eMBw==
X-Gm-Message-State: AOJu0Yyq8DbN1+sdccnzp4ydwvH2UVPayGwYHApGDHtfPNR+ed03Omlb
	dW1b5AVPmkcAHZymnVjekOkHNxsbxRiL5gohwzrehMp4u7eJNY4uaqzymQdL0mFreCQrvPKyWjw
	X06np4A==
X-Received: from pfbhc13.prod.google.com ([2002:a05:6a00:650d:b0:82f:3b6:9332])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2290:b0:827:4bca:f1a2
 with SMTP id d2e1a72fcca58-82f0c12f440mr1133195b3a.10.1775779005043; Thu, 09
 Apr 2026 16:56:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Apr 2026 16:56:20 -0700
In-Reply-To: <20260409235622.2052730-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409235622.2052730-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409235622.2052730-10-seanjc@google.com>
Subject: [PATCH 09/11] KVM: nSVM: Use kvm_rax_read() now that it's mode-aware
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Now that kvm_rax_read() truncates the output value to 32 bits if the
vCPU isn't in 64-bit mode, use it instead of the more verbose (and very
technically slower) kvm_register_read().

Note!  VMLOAD, VMSAVE, and VMRUN emulation are still technically buggy,
as they can use EAX (versus RAX) in 64-bit mode via an operand size
prefix.  Don't bother trying to handle that case, as it would require
decoding the code stream, which would open an entirely different can of
worms, and in practice no sane guest would shove garbage into RAX[63:32]
and then execute VMLOAD/VMSAVE/VMRUN with just EAX.

No functional change intended.

Cc: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 2 +-
 arch/x86/kvm/svm/svm.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 00de9375c836..7bea5ad02805 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1113,7 +1113,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 	if (WARN_ON_ONCE(!svm->nested.initialized))
 		return -EINVAL;
 
-	vmcb12_gpa = kvm_register_read(vcpu, VCPU_REGS_RAX);
+	vmcb12_gpa = kvm_rax_read(vcpu);
 	if (!page_address_valid(vcpu, vmcb12_gpa)) {
 		kvm_inject_gp(vcpu, 0);
 		return 1;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0e2e7a803d64..79d5982cf294 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2187,7 +2187,7 @@ static int intr_interception(struct kvm_vcpu *vcpu)
 
 static int vmload_vmsave_interception(struct kvm_vcpu *vcpu, bool vmload)
 {
-	u64 vmcb12_gpa = kvm_register_read(vcpu, VCPU_REGS_RAX);
+	u64 vmcb12_gpa = kvm_rax_read(vcpu);
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb12;
 	struct kvm_host_map map;
@@ -2295,7 +2295,7 @@ static int gp_interception(struct kvm_vcpu *vcpu)
 		if (nested_svm_check_permissions(vcpu))
 			return 1;
 
-		if (!page_address_valid(vcpu, kvm_register_read(vcpu, VCPU_REGS_RAX)))
+		if (!page_address_valid(vcpu, kvm_rax_read(vcpu)))
 			goto reinject;
 
 		/*
-- 
2.53.0.1213.gd9a14994de-goog

