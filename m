Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0EA37DEA8
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776961594; cv=none; b=XfGSboQUWlp02VqBE8vSAItn72pVBL2LZWYDPyckApxGn/hVl+bhrOR9rcYRIw1oReHYhRyJC2urDAL+MtdGy7YOrY2iJhBwTkYXpxDu4Q9nwfQvDnUHFKgELPfh6s5jCpfYrH1NJVNCTXf2BR2GtVd3vPXOpXGs8E7HjlWxVV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776961594; c=relaxed/simple;
	bh=+sHcNeW5LGYxEMASXp78quDxR4fsZAKAoVzQNC5fElk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HrVQsyYPTNFpd+N2a25oJzl01uHVeEWe9psMDQbCqebS+jWD9ok+n/MAtwa4H/w+otM+/CJMFnnXqz0CPAkkEIJoWdJ4ZLcwmTwsIvaN7u9iS0PzWy3XKemgRtJRr5lgmBM3RaaVhvPZZO+CreuNxYi8EngCaotO9DfKN7IREDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tryILKMV; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tryILKMV"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b241be0126so134713135ad.3
        for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 09:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776961592; x=1777566392; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=178Sl2Pz7vfzNqL8EoR9/QLtRB+UOblPI2eBUX1bVH4=;
        b=tryILKMVmUeG0pdYY7kwI38WCrAjle9lSQRnmnChxwd7zVOG1VcFvGT6ebHOj/Ov6N
         a8I+ltheq4y03wnm59eU6LpKhFA+fqHmi0O+Z7tay3NnlMkMlOleZe1W90+CvkM+q6g9
         mmJ6NhbZ0JA7kTxnUY0b85waPNwSXkIaIudy4B4IpYG+3XlgaLhwAZYCnYTzKWA1zud2
         9q98AAbyXSvy/adECTVJSNQTsEd4oWSkZH66wJgbVFflB7B+szwjvxMhlb+PWAJF8CYm
         iiCG2v8mdNzItHGmVjwGvrPsvI+Z3gOhszRlUph7Hw7J/f/jfpAUX3tGD+5bbIM44iTQ
         uZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776961592; x=1777566392;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=178Sl2Pz7vfzNqL8EoR9/QLtRB+UOblPI2eBUX1bVH4=;
        b=g0gvwSRsSktwfRDVSV36Pa7Cgo8K+ycsEyV/LQgcurpwjk771NlU46QVJYyogQen3S
         78XuRW+0GJHgTratgvo4Rq03g8KvMeDfJT6ovXLrsxXMSVA/1R17GH6kBaLS4WwjmMTn
         DLvgbUENpVRdkcpibhoJ3Ft/J+Fk23zLutqZCE1AvyL5hKyjIX0JFZ5xFOiKlzpq0M/t
         l57xgpUw1Py2pYCbErpMpgiDttzXDNClgu66E9SzbgIwHGJuEh/q8wSbfjkDx1ksKTdn
         S/XLFcyVsEc2/EPUqU/N2GUDPbF0LAPhl+eK9mAPmtp8WSPbbPbOpAfwta+v8ePaTFNp
         MOLQ==
X-Gm-Message-State: AOJu0Yyxw6Bsg8diA5Nr5DWkz6VB6C1VGRszskfVnmHSpRpAKe0kiWdc
	6RyQxPty2Fc4WdV93hRHmmkFW9pnsK8uir18vlKqgJNECzMxJzBcikIqsa4WDrC+IKo7pdCDVmR
	FSJ3rdA==
X-Received: from plhx4.prod.google.com ([2002:a17:903:2c04:b0:2b0:ad22:aebd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c24:b0:2b7:a3bf:b2a0
 with SMTP id d9443c01a7336-2b7a3bfb415mr42481585ad.5.1776961591975; Thu, 23
 Apr 2026 09:26:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Apr 2026 09:26:27 -0700
In-Reply-To: <20260423162628.490962-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423162628.490962-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423162628.490962-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: x86: Ensure vendor's exit handler runs before
 fastpath userspace exits
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Nikunj A . Dadhania" <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

Move the handling of fastpath userspace exits into vendor code to ensure
KVM runs vendor specific operations that need to run before userspace gains
control of the vCPU.  E.g. for VMX (and soon to be for SVM as well), KVM
needs to flush the PML buffer prior to exiting to userspace, otherwise any
memory written by the final KVM_RUN might never be flagged as dirty.

Note, waiting to snapshot CR0 and CR3 until svm_handle_exit() is flawed in
general, as that risks consuming stale state in a fastpath handler.  That
will be addressed in a future change.

Fixes: f7f39c50edb9 ("KVM: x86: Exit to userspace if fastpath triggers one on instruction skip")
Cc: stable@vger.kernel.org
Cc: Nikunj A. Dadhania <nikunj@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 3 +++
 arch/x86/kvm/vmx/vmx.c | 3 +++
 arch/x86/kvm/x86.c     | 3 ---
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e7fdd7a9c280..eb351ca4dd82 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3652,6 +3652,9 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 			vcpu->arch.cr3 = svm->vmcb->save.cr3;
 	}
 
+	if (unlikely(exit_fastpath == EXIT_FASTPATH_EXIT_USERSPACE))
+		return 0;
+
 	if (is_guest_mode(vcpu)) {
 		int vmexit;
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a29896a9ef14..4cb355ecfe46 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6687,6 +6687,9 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	if (enable_pml && !is_guest_mode(vcpu))
 		vmx_flush_pml_buffer(vcpu);
 
+	if (unlikely(exit_fastpath == EXIT_FASTPATH_EXIT_USERSPACE))
+		return 0;
+
 	/*
 	 * KVM should never reach this point with a pending nested VM-Enter.
 	 * More specifically, short-circuiting VM-Entry to emulate L2 due to
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0a1b63c63d1a..9ad7ec3bf0f1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11602,9 +11602,6 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.apic_attention)
 		kvm_lapic_sync_from_vapic(vcpu);
 
-	if (unlikely(exit_fastpath == EXIT_FASTPATH_EXIT_USERSPACE))
-		return 0;
-
 	r = kvm_x86_call(handle_exit)(vcpu, exit_fastpath);
 	return r;
 
-- 
2.54.0.545.g6539524ca2-goog

