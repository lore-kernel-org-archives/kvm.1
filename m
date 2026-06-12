Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAAD2773F9
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 18:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781290504; cv=none; b=MWerJ65HBZ7n85pyeYjchKPRkQp8BfU1+YEnApgO2E4L/Dg6jY5uraPfVIPGqFeCy2NqG2hXnVJbvasFt3hce72aDqq51oEjEkJMsqYhI+lMJMJR+PJ7/hhgn3RD1ZgDowlmhW2DCYxALzs2YrS2v+ZfLVID65t/Gk4KaaQB84g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781290504; c=relaxed/simple;
	bh=FLSzrcbZC0Rq37JiVsN00hJeJOk6aysg8AxMXnvBqr0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=j9gVAV+aryWCKdpNn4p8R0Ybl2H+hxTOJdMLW4EkDOeyE9GQuy8xMSX9rixOcsR8oluFHyP9YZzzqetE4BeRs/vKaoqJyrs6V3Bjg2BtcLrfOXt2q3MBOZLimfmYQUQPCFl5bVpY7Zd/qhLlrWS/ZFKIkghWzMJhBziGIL5WtYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B3ROeSVH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B3ROeSVH"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c354050c34so12267035ad.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 11:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781290503; x=1781895303; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJ95UxHgyKJcdVZWK9EtRNno+4oyBie0o34zJZDCnLI=;
        b=B3ROeSVHe2XUKM+llkZ4CXSF/zsiEK2/3eBcLWk5d+FXFOt3JasPi1+r9pMuLir2Ov
         40aoFArr00Nn7K1+a/QEMesqngdYiqPDnjrczPeUBIIVgsGwJZkLfgxaTStd/tf8FZYV
         f87uHsRJ1zlB7d20hnQeyDMZhh2tPy6lUjPToBcE1GM8UIoRwPikI2cf+Uvp1Y8J5j8T
         EIY7Ffcm/99BmliFg+9aLmn+TP+8KjfNGAXDZ6GqPJ50NUK3tILRDFgebQTO1oF4Tk1Z
         mbpHUVrsAHox6fD0/R10Vcqn/Sx1HbMI2f+qMHXn1WmfUr9HytWFUu/+YvaBKaZexaV2
         h9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781290503; x=1781895303;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ95UxHgyKJcdVZWK9EtRNno+4oyBie0o34zJZDCnLI=;
        b=A6xviPqOP3h+5txXH9zPjI7/YJfdDifR0TEwCCpNFXkHk+RczMYcF77OIBcQB2pjNf
         JeNOF3HTA+FZjZ08Lh4ew+EzfGdEDrs6+QWT+soZUlnfq+2oQKsMeNDQ2iykC1aV5hto
         X10vtnSgbZCioaytapbWn5BULwd0NxEvTMSJQbRnNd4uXzlYzloJrO3jnDMA4YyRlYCp
         YXf59cJjHjatUaySse7wwXyViNGu/7rj4ualTNHcxRDUefQpHCsZQGhS00NU2nF262Nj
         XMeNGuScV9uW/QUiK04dbq6KMoYqpUPeHhZinxpSEhbaeIBtRd0FJp1HP7Gey9wNf54Q
         wCLQ==
X-Forwarded-Encrypted: i=1; AFNElJ+C5+FQczQuYRkARpQLCFQLveyyk0Sm3WnQFURrniZs41F+DOo4btCjAvxR7q2SZvHu2V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR14HqKl1+Z2tTFNW3yiJkffCniWoIx5pl6i2Qs5NA2L12G1zy
	peCrM/KeYGgvCoYzEXzMINr2FhrXOUi3CcBmn8UzLt6FpIRTD6T1UBvI5xQbDvhRgU201rDpX5I
	1nBJHdg==
X-Received: from plhn15.prod.google.com ([2002:a17:903:110f:b0:2bd:7dc:3354])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec7:b0:2c1:f29a:b554
 with SMTP id d9443c01a7336-2c664271df6mr8414615ad.21.1781290502338; Fri, 12
 Jun 2026 11:55:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 11:54:59 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612185459.591892-1-seanjc@google.com>
Subject: [PATCH] x86/apic: KVM: Use cpu_physical_id() to get APIC ID of
 running vCPU for AVIC
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Use cpu_physical_id() instead of default_cpu_present_to_apicid() when
getting the APIC ID of the pCPU on which a vCPU is running/loaded, as the
kernel has gone way off the rails if a vCPU is loaded on a pCPU that has
been physically removed from the system.  Even if the impossible were to
happen, the absolutely worst case scenario is that hardware will ring the
AIVC doorbell on the wrong pCPU, i.e. a severely broken system will
experience mild performance issues.

Kill off KVM's superfluous kvm_cpu_get_apicid() wrapper along with the
for-KVM export of default_cpu_present_to_apicid(), as they existed purely
for the wonky AVIC usage.

Cc: Kai Huang <kai.huang@intel.com>
Cc: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

Tip tree folks, I'd like to take this through the kvm-x86 tree (in 7.3) for
obvious reasons.  I assume the odds of a conflict on the removal of
EXPORT_SYMBOL_FOR_KVM() are tiny.

 arch/x86/include/asm/kvm_host.h    | 10 ----------
 arch/x86/kernel/apic/apic_common.c |  1 -
 arch/x86/kvm/svm/avic.c            |  6 +++---
 3 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3886b536c8a5..2389e43e2f82 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2526,16 +2526,6 @@ static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu)
 	kvm_x86_call(vcpu_unblocking)(vcpu);
 }
 
-static inline int kvm_cpu_get_apicid(int mps_cpu)
-{
-#ifdef CONFIG_X86_LOCAL_APIC
-	return default_cpu_present_to_apicid(mps_cpu);
-#else
-	WARN_ON_ONCE(1);
-	return BAD_APICID;
-#endif
-}
-
 int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages);
 
 #define KVM_CLOCK_VALID_FLAGS						\
diff --git a/arch/x86/kernel/apic/apic_common.c b/arch/x86/kernel/apic/apic_common.c
index 2ed3b5c88c7f..45e6b816353e 100644
--- a/arch/x86/kernel/apic/apic_common.c
+++ b/arch/x86/kernel/apic/apic_common.c
@@ -26,7 +26,6 @@ u32 default_cpu_present_to_apicid(int mps_cpu)
 	else
 		return BAD_APICID;
 }
-EXPORT_SYMBOL_FOR_KVM(default_cpu_present_to_apicid);
 
 /*
  * Set up the logical destination ID when the APIC operates in logical
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 0726f88e679a..58e493a80cb0 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -460,8 +460,8 @@ void avic_ring_doorbell(struct kvm_vcpu *vcpu)
 	int cpu = READ_ONCE(vcpu->cpu);
 
 	if (cpu != get_cpu()) {
-		wrmsrq(MSR_AMD64_SVM_AVIC_DOORBELL, kvm_cpu_get_apicid(cpu));
-		trace_kvm_avic_doorbell(vcpu->vcpu_id, kvm_cpu_get_apicid(cpu));
+		wrmsrq(MSR_AMD64_SVM_AVIC_DOORBELL, cpu_physical_id(cpu));
+		trace_kvm_avic_doorbell(vcpu->vcpu_id, cpu_physical_id(cpu));
 	}
 	put_cpu();
 }
@@ -1013,7 +1013,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu,
 			     enum avic_vcpu_action action)
 {
 	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
-	int h_physical_id = kvm_cpu_get_apicid(cpu);
+	int h_physical_id = cpu_physical_id(cpu);
 	struct vcpu_svm *svm = to_svm(vcpu);
 	unsigned long flags;
 	u64 entry;

base-commit: c1f7303302927f9cbf4efedf70f0512cde168c65
-- 
2.54.0.1136.gdb2ca164c4-goog

