Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D033E4519
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305285; cv=none; b=SPB7m0VYptMlnefSOWeDsDdndxRnnLnkKbVzvXJ7rMs0tHG+LLiO29FOJl4Wz6+gs06C8xgIFeEtqOX/IxuXD/swg93rKFbjNcb1/kxnpb2WKXgdVF/jpincHz2n5V9GO/V7R3y9kdljCZR4xBA0d99chlvZ+uXCD/NnLjf1y0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305285; c=relaxed/simple;
	bh=H4vBG2iUmPAuOsJstakj8lF6mNh1ClWZl8eh7QQk8F8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ms2gNu5m5MsxknMz5Ku2ESQMLCG+S2D+dYHNOp8xuLN7Ypoxy8qqJ2LpWree/1cbT0nblkYw0b9paxXANe3Ga/M2pP6RMpo210tGzwR8aaI5422WN7oWz4Sl1S0vtusSnc4xrWTy2jmJdOB9nXagIAY5+FD6RuZmq8vIuJilqVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nat7hNvE; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nat7hNvE"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85a2f1d1e5so760101a12.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 16:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781305283; x=1781910083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=S/dlKn0jdURDcje9Hbkr7fjcEiFdPKEbz7gr0eyyyQU=;
        b=Nat7hNvE0LA5UgJFUzbCPDpPnEIXRbMkY8Hw3KDq4U0dza7HIFGlY/bnVoyJUpJ7Vm
         tYBrbCZyQadixmpdC5fyzkkkBQ93/zTKSSL64ro3gEvUqmWusHFfqqwu60/748hPAkEY
         pxQiyMPdlFu9g3b4GXEItCnLx8CC+w+ZQA/pZYFGkWBuILSln+OQy1JreSyMll7fsHr8
         OlbyrdV0T8+Y4ziXEDz3mKycglW3IOOMJUlALe1z9g+CHx5Pbc/PTsPUTTYYvFImdSUa
         u/XkimAYPU2TC2BjvUNFS9gGU7QSfH/OH00JxacTA++ps3P3Bmon3fGksp1XrzKYDe8s
         Xbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781305283; x=1781910083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/dlKn0jdURDcje9Hbkr7fjcEiFdPKEbz7gr0eyyyQU=;
        b=qVuBoiw4yanUJ4Fu05hEaEyJougDYi+a+XMnCWqaho/qV6BrgQfQnCqPLjiQuElqhL
         1VPvlTMsS8H5llOSTYKImhWlsJEFzqdh8fTypXOQf6Py26QL0t6dAnnWYNr0OGY4UHEP
         +jajDwPU4uRdm+tWg0ZcRTHJ8foqnpo3eBh5UFf6NstOZLxc8L/FNAGMBLnvQs7V7FiR
         zcVdZWNyjfXFz2ulPsjmh+BynxEKB3tqwxnuVYWWn6Ne6IhEr/79O8/G5kRX3q5Y8dkr
         KEoCAbKjYk5XgfJY7MeBlvLuMSeZ6Q7ZhmYzKYiBCZnR4FMZ6/GfUx7OaEG4Fd2+/5hU
         Z0+g==
X-Gm-Message-State: AOJu0Ywu33OF1u13K/7T6iJOtRxgOHqb/c1lRcBZA9YlTM0An7QDY9mo
	B1c/gquktbtwjzcB7IfuPR794cXAQCmTatr4FJ1CcFk/zKNRuNQuKrnsZqkZsPsoDP8cOwh5rX0
	LAgoB1g==
X-Received: from pfff14.prod.google.com ([2002:a05:6a00:bd0e:b0:842:3b07:6355])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e82:b0:842:48ae:1d56
 with SMTP id d2e1a72fcca58-8434d0cdb37mr4989915b3a.35.1781305283197; Fri, 12
 Jun 2026 16:01:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 16:01:10 -0700
In-Reply-To: <20260612230113.684301-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612230113.684301-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612230113.684301-6-seanjc@google.com>
Subject: [PATCH v3 5/8] KVM: VMX: Prioritize DR7.GD=1 #DB over CPL>0 #GP on Intel
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>, "Maciej W . Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"

When emulating a MOV DR on Intel with DR7.GD=1 at CPL>0, prioritize the #DB
due to DR7.GD over the #GP due to CPL>0, as empirical testing shows that
Intel CPUs (Skylake, Icelake and Emerald Rapids) prioritize the DR7.GD #DB
over all #GPs, whereas AMD CPUs prioritize the CPL>0 #GP (but not illegal
value #GPs) over the #DB.

Outside of the emulator, don't bother trying to provide the "correct"
priority based on the virtual CPU model, as it's simply impossible to do
so without intercepting *all* MOV DR accesses, which would result in a
massive, unacceptable performance hit.  Note, getting the priority right
when advertising Intel on AMD would also require intercepting #GP, as SVM
prioritizes all exceptions over the instruction intercept.

Note, neither Intel's SDM nor AMD's APM says anything about the relative
priority, hence the empirical testing.  Arguably Intel's description of
DR7.GD:

  causes a debug exception to be generated prior to any MOV instruction
  that accesses a debug register.

implies that DR7.GD has higher priority.  But that's a fairly weak argument
as the statement would still hold true if the #GP due to CPL>0 had higher
priority, as the #GP would prevent any access to a DR.

Fixes: 3b88e41a4134 ("KVM: SVM: Add intercept check for accessing dr registers")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c | 7 ++++++-
 arch/x86/kvm/vmx/vmx.c | 6 +++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 127a21eeef66..b4dc57fe0bc9 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3834,6 +3834,7 @@ static int check_cr_access(struct x86_emulate_ctxt *ctxt)
 
 static int check_dr_read(struct x86_emulate_ctxt *ctxt)
 {
+	bool is_intel = ctxt->ops->guest_cpuid_is_intel_compatible(ctxt);
 	int dr = ctxt->modrm_reg;
 	u64 cr4;
 
@@ -3844,12 +3845,16 @@ static int check_dr_read(struct x86_emulate_ctxt *ctxt)
 	if ((cr4 & X86_CR4_DE) && (dr == 4 || dr == 5))
 		return emulate_ud(ctxt);
 
-	if (ctxt->ops->cpl(ctxt))
+	/* Intel CPUs prioritize the DR7.GD=1 #DB over the CPL>0 #GP. */
+	if (!is_intel && ctxt->ops->cpl(ctxt))
 		return emulate_gp(ctxt, 0);
 
 	if (ctxt->ops->get_effective_dr7(ctxt) & DR7_GD)
 		return emulate_db(ctxt, DR6_BD);
 
+	if (is_intel && ctxt->ops->cpl(ctxt))
+		return emulate_gp(ctxt, 0);
+
 	return X86EMUL_CONTINUE;
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c548f22375ad..2f13d3163367 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5750,9 +5750,6 @@ static int handle_dr(struct kvm_vcpu *vcpu)
 	if (!kvm_require_dr(vcpu, dr))
 		return 1;
 
-	if (vmx_get_cpl(vcpu) > 0)
-		goto out;
-
 	dr7 = vmcs_readl(GUEST_DR7);
 	if (dr7 & DR7_GD) {
 		/*
@@ -5773,6 +5770,9 @@ static int handle_dr(struct kvm_vcpu *vcpu)
 		}
 	}
 
+	if (vmx_get_cpl(vcpu) > 0)
+		goto out;
+
 	if (vcpu->guest_debug == 0) {
 		exec_controls_clearbit(to_vmx(vcpu), CPU_BASED_MOV_DR_EXITING);
 
-- 
2.54.0.1136.gdb2ca164c4-goog

