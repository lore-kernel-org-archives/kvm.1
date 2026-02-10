Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1831FAC42
	for <kvm@vger.kernel.org>; Tue, 10 Feb 2026 23:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770767179; cv=none; b=CS10I4mcx1m5CT+rTo788ay2AOalSlDeRh+fkX+26iZKO0ecGkoWpcwbsMHrz56KkSCm7sACiXtesDqufuEfdJnkpDxVtWi56+yFlXpbWo0uIWr4XU/USOHz9SBa9ee3su0JhbwUteFW53SYdZkUzHx//yXSjSpdBwsEZdDNYZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770767179; c=relaxed/simple;
	bh=io0j3T7gVq7+8CIMOZ1xD2dlmsVdkJx8rgyMSLO0bqw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Bw4XdZ10F0ec2Pt+PMks6fRhziZ3GZstvMgbt/iHT+LGDFg0FD3rjw3Z4JTV5hGKI3DEAW/CM+wfWoG7wemsfF5ooORqwqjYYtg8YnRxGDi+umgM6W6mT/KYZgEX+Gz+6NbZbJGnyW5AYUnYIY1KCWivEq/FG4VC0FyA09bZSmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rUSaQ6c6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rUSaQ6c6"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3562370038dso1056203a91.3
        for <kvm@vger.kernel.org>; Tue, 10 Feb 2026 15:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770767178; x=1771371978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9DhTawsZmRz3nzyhK8/Lugi87Ht2DdYYWmF9HyMvN+Y=;
        b=rUSaQ6c6otC5IvJpa/fCVbxt/ILACTOv7ymklo2ZPdSBtBJ84sy3VsESTt8SDJd0UD
         aRT1tUezQ+f5Ww4iP3voiQ7GAggYJncgwi3iIO3inEkjHMKLzyIW+iPv4vSv/MHJnURm
         LtgTJWmx4JPTy7C/vNiYlYRYnOw/J8xFJnQ0gk2ehE33XHK+uaj2ij1jzRZCS0+riG/a
         kF+8q9i8huQP/7leRjbRx3NZy6IgQEoz8Vpl+YCxe+ZkSV1V24fXNhTK03lOJGAdr7SR
         4Uav9t7x8+tdiglfcQoyTtahb8q7vYCi0zd1pZLqFUZo4kTUIXVm/fLLQn4U+ZQ8Jf0P
         42nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770767178; x=1771371978;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9DhTawsZmRz3nzyhK8/Lugi87Ht2DdYYWmF9HyMvN+Y=;
        b=D0mMOcxl40Fgrt0VutxCuJr0b85UEjv4nDlX6YM6z4TuZf5sf2kqX6UYsr2yZfljSI
         mtuXRMWW/PbiDCTiiXSwpcQf54e1qPyygyj2LjMv2U3PT3Tofwv4B8/+Eu5cq/YM4zoq
         z0waLJbQ3uzHDOmoIMWyKykh1EYpZIEaUX6p2J5Z0dZ7ZvL9S4Je49JBdspO9JvyfXLK
         LLcZiDmwEATDLBoRkcwCcw/aI8c+u/8RgiyvqZIwl0fUpqUurYndXk4cwKXbgKTlq9Kc
         ADW83JwVwV8wV8km9YjS4A+m1hCaU3swpG17vge59w3xmTNEcnherfyF2+rw2Som3+vi
         +Dzw==
X-Forwarded-Encrypted: i=1; AJvYcCWAEHZ7iOJgosf86YsmHb8iHB1adycCKgJEGZXsyFvVu90rC4F6docTZ+J+FZSSYsm+cd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/WhBwW2P6JA2AQa2o78IGsZw4vxJW5q2FITUW6OmYW4AU+Kv7
	HvQ+cfid9Fm7lfO23PQzlPVXSdaJZBETpwKbMSj0gz59h98TJX5PCbqUF8bC8nXoRGbKcdr4lf9
	OeN9jN0cslr//Cw==
X-Received: from pjbfz3.prod.google.com ([2002:a17:90b:243:b0:356:1edc:b2a])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5188:b0:341:315:f4ed with SMTP id 98e67ed59e1d1-354b3c84188mr12837061a91.10.1770767177895;
 Tue, 10 Feb 2026 15:46:17 -0800 (PST)
Date: Tue, 10 Feb 2026 15:45:42 -0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260210234613.1383279-1-jmattson@google.com>
Subject: [PATCH] KVM: x86: Ignore cpuid faulting in SMM
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jamie Liu <jamieliu@google.com>
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

The Intel Virtualization Technology FlexMigration Application Note says,
"When CPUID faulting is enabled, all executions of the CPUID instruction
outside system-management mode (SMM) cause a general-protection exception
(#GP(0)) if the current privilege level (CPL) is greater than 0."

Always allow the execution of CPUID in SMM.

Fixes: db2336a80489 ("KVM: x86: virtualize cpuid faulting")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/cpuid.c   | 3 ++-
 arch/x86/kvm/emulate.c | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 7fe4e58a6ebf..863ce81023e9 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -2157,7 +2157,8 @@ int kvm_emulate_cpuid(struct kvm_vcpu *vcpu)
 {
 	u32 eax, ebx, ecx, edx;
 
-	if (cpuid_fault_enabled(vcpu) && !kvm_require_cpl(vcpu, 0))
+	if (!is_smm(vcpu) && cpuid_fault_enabled(vcpu) &&
+	    !kvm_require_cpl(vcpu, 0))
 		return 1;
 
 	eax = kvm_rax_read(vcpu);
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c8e292e9a24d..4b7289a82bf8 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3583,10 +3583,10 @@ static int em_cpuid(struct x86_emulate_ctxt *ctxt)
 	u64 msr = 0;
 
 	ctxt->ops->get_msr(ctxt, MSR_MISC_FEATURES_ENABLES, &msr);
-	if (msr & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
-	    ctxt->ops->cpl(ctxt)) {
+	if (!ctxt->ops->is_smm(ctxt) &&
+	    (msr & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
+	     ctxt->ops->cpl(ctxt)))
 		return emulate_gp(ctxt, 0);
-	}
 
 	eax = reg_read(ctxt, VCPU_REGS_RAX);
 	ecx = reg_read(ctxt, VCPU_REGS_RCX);
-- 
2.53.0.239.g8d8fc8a987-goog

