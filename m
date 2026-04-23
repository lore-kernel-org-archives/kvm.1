Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2273806C8
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776961595; cv=none; b=c/qTIsC6NaMCXPobfr0wE1wDgXwyWH64Boet2vzoOQWTLHIqER+KbUg2ogEtdOK439zrIbe+S0JAaH8kYPS6mHWPdqDGYDcI4TuZDXvbYH/XqMl341t60nbMtmsA/Euu2KZfHydWPW8MIsTpoC90Wenuoaw1QuB569gLJpJ+xjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776961595; c=relaxed/simple;
	bh=mLYv8WZqZbpdK7gb+Jc9DDETesX8Ne4WD9MXv4JEr9Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ElEAQUCyTnpsKqL9qwAkGlhZRwhc0SoFVWWZ7aHHLnO6pmHY1C0E/RWwetFrPu5ZelprIne9wPJy+9ZIXH9DLQodV4HrlQOVSh4m36TeT2fX/cCu4BKcOLYEn8ZZYxzVIKN4P8BjwAlIt8eMAlpBBSEe4ae9M5tUYalbHKv7Vag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ubJePkEO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ubJePkEO"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35fbb57764aso8279726a91.1
        for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 09:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776961594; x=1777566394; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4t9k99Hk+Nxw6lMwotfPJxna6r0dcmYdL1wJ+beGW5I=;
        b=ubJePkEO1AHEnwv+NUROYzYOj1rvXS3WbwYSbnLHTlKIgp+AVWHhAW0qMaAxRaTIsT
         OV0LmVBXGR3KK7YC5sloX3x9fICzaYBXXehnWc9W5vwbbauMGHAXCdIklRt6DJIU80uB
         DmPeXTA0UTANVM9Dh+RFwQWOEsyJxz7aCV51jtywFzq0kDOVoP03MtZmYhGxhFdvOmvM
         4v8blJ0TITaHKB8K789yjbIPCFOv6L/NRFbg9z8P4m9vUcPha9jzinXeKpBwPNa4IB4f
         IqpzMj76C223KwrmJ6XQf6QCBsNqrBnP4/Xggbup4fp4IHLJaTNYaP0KgkA0rd/fBm4a
         +yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776961594; x=1777566394;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4t9k99Hk+Nxw6lMwotfPJxna6r0dcmYdL1wJ+beGW5I=;
        b=hTzeZDKkTbB3DVTyLeS5IqqIZZ9WwLtk0YRLOxW3d92wMbgF5gigg1zrPOfvGABvpV
         fGhH9w8HacdADIlXQ0gHL58c++n/YrEDOHU/pucZ6dNAcI4NIW/ulwCaANWnN8WxlrMg
         Xhnr6TyW/NqvOKRBNuEYxt368kUFNgn1bfEt3jeihcsZDfOEtD7KjInvNTColX0wU3cT
         5O9ROTdr+vJzTi9qKkFKGxf05Ss6xIHRxrWkQab3Kn2gMbKhhX2c3YJi4KV6/sML0+Po
         U48MB5rYTq/sNzh5GJW+7X7crlTEkGGjfvrCy/u7CDYbaEv1/LOGEqMII5rPIBrIYov7
         B7EA==
X-Gm-Message-State: AOJu0YxEKZvcTVrN2fn6nFTjQGOTp2YtuuS8WZLkd3uegFLTNfct52tt
	IIE8kOHUUF9q7XLOKxt8QAR9WWKiFdL/WQtw4wfGHAojw7gxLlt7HmqQdQ2xnKGzbfd1l1h0DR1
	t1Q3bAg==
X-Received: from plte11.prod.google.com ([2002:a17:902:744b:b0:2b4:6527:7f6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2c8d:b0:359:84a3:1942
 with SMTP id 98e67ed59e1d1-361402eaf94mr26630578a91.13.1776961593615; Thu, 23
 Apr 2026 09:26:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Apr 2026 09:26:28 -0700
In-Reply-To: <20260423162628.490962-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423162628.490962-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423162628.490962-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: SVM: Refresh vcpu->arch.cr{0,3} prior to invoking
 fastpath handler
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Nikunj A . Dadhania" <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

Refresh KVM's copies of CR0 and CR3 from the VMCB prior to (potentially)
invoking a fastpath handler to ensure that KVM doesn't consume stale
state.  While it's unlikely KVM will ever consume CR3 or CR0.{TS,MP} in
the fastpath, grabbing the values from the VMCB is inexpensive, i.e. the
risk of subtle bugs far outweighs the reward of deferring reads for a
small subset of VM-Exits.

Note, KVM doesn't currently consume CR3 or CR0.{TS,MP} in the fastpath,
as KVM requires next_rip to be valid (i.e. KVM doesn't read CR3 to decode
the instruction), CR0.MP is never consumed, and CR0.TS is only consumed by
the full emulator.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index eb351ca4dd82..df0bd132edf7 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3644,14 +3644,6 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_run *kvm_run = vcpu->run;
 
-	/* SEV-ES guests must use the CR write traps to track CR registers. */
-	if (!is_sev_es_guest(vcpu)) {
-		if (!svm_is_intercept(svm, INTERCEPT_CR0_WRITE))
-			vcpu->arch.cr0 = svm->vmcb->save.cr0;
-		if (npt_enabled)
-			vcpu->arch.cr3 = svm->vmcb->save.cr3;
-	}
-
 	if (unlikely(exit_fastpath == EXIT_FASTPATH_EXIT_USERSPACE))
 		return 0;
 
@@ -4505,11 +4497,17 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 	if (!static_cpu_has(X86_FEATURE_V_SPEC_CTRL))
 		x86_spec_ctrl_restore_host(svm->virt_spec_ctrl);
 
+	/* SEV-ES guests must use the CR write traps to track CR registers. */
 	if (!is_sev_es_guest(vcpu)) {
 		vcpu->arch.cr2 = svm->vmcb->save.cr2;
 		vcpu->arch.regs[VCPU_REGS_RAX] = svm->vmcb->save.rax;
 		vcpu->arch.regs[VCPU_REGS_RSP] = svm->vmcb->save.rsp;
 		vcpu->arch.regs[VCPU_REGS_RIP] = svm->vmcb->save.rip;
+
+		if (!svm_is_intercept(svm, INTERCEPT_CR0_WRITE))
+			vcpu->arch.cr0 = svm->vmcb->save.cr0;
+		if (npt_enabled)
+			vcpu->arch.cr3 = svm->vmcb->save.cr3;
 	}
 	vcpu->arch.regs_dirty = 0;
 
-- 
2.54.0.545.g6539524ca2-goog

