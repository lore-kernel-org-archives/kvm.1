Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793396275;
	b=Vrl0Cd+FreEh89e13PoKVrl9bPIDX1sL7xmVUB/LZAxpWKKo8Gb226rJrRcGRNKpi9Ig
	 kuAx5mlQpQ0jVCzfUk+6NsXTmYSoXm+oH4lM0F1ZTcoFKu+TBiUQ2GknyeGAPX6xqkd4K
	 KmSHujdm56VKxM+gTXhA5vJJlWepJsHgvpliuOJeGSjPWHwYyTJGWjlpfCKwiWYY8phnF
	 032UcJVuXHHg8mehRkbwt7AhJWzr0iZ0Uh8HpwxGbO18yc6EKYo4buzkGrw6N2RyG08QJ
	 dC0VKTCZQW8dBoNxUqPah9RxfmUaD3VBJXjgdA95OuDoH/YFSSGh0GtZGxs7w9/IlSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793396275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=bAp1oLLc4NylX44ka1QJP/C4krDFDu3MTt3wwDG+pYk=;
	b=QcKpbbwLmaLu8bl3FAMd32q1omP/UFh7b8MjoL/7tIkwx4uAiOUXUUZB9Q33dx1w2hGb
	 Y8CEoP8vJeMQDs2UG8XvXfFcTCxk4aQOPLkZ76SlirezmPhuRU5Q3kKdwGXljzhJFxp7U
	 lBWXb9d1RKwYuQgNLI3r39we8DQOL+WhglE5oUtC/ISEnpM0Uz6xJedHkZrTA9/jDeyzH
	 stwWAGT27kSUtUlGpj13nrGonms9Gsh/3xXp4EIJyzO88xgL+NbAqg1h0NBoqCsh4q64W
	 ZOGxjU7z96pKbk2Bfa5U7pUsjqIGGCpkIrHOrznvWT9vl/Xba4ngjoadUCcoTgRx81A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="eE0/MGBx";
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC31B606A322
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC31B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eE0/MGBx
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ae1d132d52so1032518a91.0
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793396274; x=1794001074; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bAp1oLLc4NylX44ka1QJP/C4krDFDu3MTt3wwDG+pYk=;
        b=eE0/MGBx/HeDEwIQ4OLnVT9ULzBqSdVHAn25tQS1IJbCeUmRoZAsKaVSJd2Lc4iSZU
         ALURzp+tT1Q6PfnoGoASNRiK6I8QIJBEH01p8ud/Kyagi29J0DtkYi5gR8adJOUzpuIp
         ytUDo3oO4e6AGngK53nMQwPVIr3WIG/hKEl0cEuxcOEkxLxBL+6ZCV1uZGLi6qbLx4KJ
         SBQqRgHwqrHuNGI7OQBjIfwdk+bAtpT5WqnTDI/eyUJXfXgp8uwGqfV4E3usL+ZtZQTR
         lXXw4/abVtyw6GR4UY1pzGzOJCatq3Cvx50xlYG55akje4Se+fHy5rI61ZGyxJw3pKnJ
         PqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793396274; x=1794001074;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bAp1oLLc4NylX44ka1QJP/C4krDFDu3MTt3wwDG+pYk=;
        b=EibSS1DKUfx16F0cXkbgOfDlW6PVtNTAHWhcOoQ16igH5D/PiJNALltiVPHALJ63rR
         J3k1YHiPWeUpQQP/bQWEm8XcqOiehBnYQ68NBowIaOzGqshC9FvtcRH6lH9Y1AtwFIMd
         LZ02Iodokyrmiyciz1ab+mDfqvciJWz64sqBvAMa475REdin/WrvsNc50fqkJxGPUqGr
         l9F0J/LIjUaqWrHhuOOPCKX6w9aOa8tEySXCVFlpPDIYUwSIbyMxZLyU9XtgLyrFY86w
         wO7MtbivNf/UmwbsyoExBK5mcMWranGUp6d6l26TPmFvoXzIJGJLHi/ZAKbiFDyitqdz
         II7A==
X-Gm-Message-State: AFq9FYLp9pvceGsGkrLbyugxxgmPDAb8hryySbZgGU28Z+Tzm6KIosnc
	zz6ImPqbYgAk2vG5qGQgvbZ86/eTYOIDxuYcgxjLSLRWwa6daBeDDBRsLCPiXYMF9ZZTVZJ8iPo
	LTOt7JQ==
X-Received: from pjva15.prod.google.com ([2002:a17:90a:d80f:b0:3ad:4a1f:14aa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c44:b0:3ae:6fda:789f
 with SMTP id 98e67ed59e1d1-3ae897c3efbmr2699410a91.54.1793396274166; Fri, 30
 Oct 2026 14:37:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:37:46 -0700
In-Reply-To: <20261030213747.2611815-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030213747.2611815-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030213747.2611815-5-seanjc@google.com>
Subject: [PATCH v3 4/5] KVM: nVMX: Take full ownership of the post-VMXON
 CR{0,4} must-be-1 bits
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mahmoud Abumandour <ma.mandourr@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Effectively drop support for restoring/stuffing fixed-0 CR{0,4} MSRs, as
restoring to anything other than KVM's hardcoded value is broken, and is
absolutely not worth fixing.  KVM doesn't adjust the "guest owned" masks
based on the MSR values, and so if userspace were to require any of the
passed-through bits to be '1', KVM would fail to prevent the guest from
clearing a must-be-1 bit.

Even worse, if userspace disables KVM_X86_QUIRK_STUFF_FEATURE_MSRS without
ever setting the CR{0,4} FIXED0 MSRs, then KVM would allow running with an
impossible configuration, as KVM would advertise to L1 that there are *no*
must-be-1 bits, but couldn't honor that because VM-Entry would fail due to
the bits still being must-be-1 in real hardware.  E.g. KVM would tell the
guest that CR4.VMXE can be toggled at will, in complete violation of VMXON.

Don't try to fix KVM, as no known VMM sets values other than KVM's own
hardcoded value.  KVM already requires the incoming value be a superset of
KVM's value, i.e. KVM doesn't allowed reducing the set of must-be-1 bits,
and so it's only possible for userspace to require *extra* bits to always
be 1.  Drop KVM's "support" before anyone tries to utilize it, e.g. to
harden a guest or something, as honoring things like CR0.TS in particular
would be painful, e.g. KVM would need to handle CLTS interception.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 Documentation/virt/kvm/api.rst                |  9 +++---
 arch/x86/kvm/vmx/nested.c                     | 30 ++-----------------
 arch/x86/kvm/vmx/vmx.c                        |  3 ++
 .../selftests/kvm/x86/feature_msrs_test.c     |  2 +-
 4 files changed, 11 insertions(+), 33 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e95c9cda085d..c9f7284f76b4 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8764,10 +8764,11 @@ KVM_X86_QUIRK_STUFF_FEATURE_MSRS           By default, at vCPU creation, KVM set
                                            i.e. treats the feature MSRs like CPUID
                                            leaves and gives userspace full control of
                                            the vCPU model definition.  This quirk does
-                                           not affect VMX MSRs CR0/CR4_FIXED1 (0x487
-                                           and 0x489), as KVM does now allow them to
-                                           be set by userspace (KVM sets them based on
-                                           guest CPUID, for safety purposes).
+                                           not affect VMX MSRs CR0/CR4_FIXED{0,1}
+                                           (0x486 - 0x489), as KVM does now allow them
+                                           to be set by userspace (KVM sets them based
+                                           on the virtual CPU model, for simplicity and
+                                           safety purposes).
 
 KVM_X86_QUIRK_IGNORE_GUEST_PAT             By default, on Intel platforms, KVM ignores
                                            guest PAT and forces the effective memory
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 9b0bfa2f854c..a5547ec78846 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1508,33 +1508,6 @@ static int vmx_restore_vmx_ept_vpid_cap(struct vcpu_vmx *vmx, u64 data)
 	return 0;
 }
 
-static u64 *vmx_get_fixed0_msr(struct nested_vmx_msrs *msrs, u32 msr_index)
-{
-	switch (msr_index) {
-	case MSR_IA32_VMX_CR0_FIXED0:
-		return &msrs->cr0_fixed0;
-	case MSR_IA32_VMX_CR4_FIXED0:
-		return &msrs->cr4_fixed0;
-	default:
-		BUG();
-	}
-}
-
-static int vmx_restore_fixed0_msr(struct vcpu_vmx *vmx, u32 msr_index, u64 data)
-{
-	const u64 *msr = vmx_get_fixed0_msr(&vmcs_config.nested, msr_index);
-
-	/*
-	 * 1 bits (which indicates bits which "must-be-1" during VMX operation)
-	 * must be 1 in the restored value.
-	 */
-	if (!is_bitwise_subset(data, *msr, -1ULL))
-		return -EINVAL;
-
-	*vmx_get_fixed0_msr(&vmx->nested.msrs, msr_index) = data;
-	return 0;
-}
-
 /*
  * Called when userspace is restoring VMX MSRs.
  *
@@ -1577,8 +1550,9 @@ int vmx_set_vmx_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 data)
 	case MSR_IA32_VMX_MISC:
 		return vmx_restore_vmx_misc(vmx, data);
 	case MSR_IA32_VMX_CR0_FIXED0:
+		return data && data != vmcs_config.nested.cr0_fixed0;
 	case MSR_IA32_VMX_CR4_FIXED0:
-		return vmx_restore_fixed0_msr(vmx, msr_index, data);
+		return data && data != vmcs_config.nested.cr4_fixed0;
 	case MSR_IA32_VMX_CR0_FIXED1:
 	case MSR_IA32_VMX_CR4_FIXED1:
 		/*
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 68c1361a92d1..4afbb3986a4c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7712,7 +7712,10 @@ static void nested_vmx_cr_fixed1_bits_update(struct kvm_vcpu *vcpu)
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct kvm_cpuid_entry2 *entry;
 
+	vmx->nested.msrs.cr0_fixed0 = vmcs_config.nested.cr0_fixed0;
 	vmx->nested.msrs.cr0_fixed1 = 0xffffffff;
+
+	vmx->nested.msrs.cr4_fixed0 = vmcs_config.nested.cr4_fixed0;
 	vmx->nested.msrs.cr4_fixed1 = X86_CR4_PCE;
 
 #define cr4_fixed1_update(_cr4_mask, _reg, _cpuid_mask) do {		\
diff --git a/tools/testing/selftests/kvm/x86/feature_msrs_test.c b/tools/testing/selftests/kvm/x86/feature_msrs_test.c
index d56d0ddb3a57..837fee78835c 100644
--- a/tools/testing/selftests/kvm/x86/feature_msrs_test.c
+++ b/tools/testing/selftests/kvm/x86/feature_msrs_test.c
@@ -14,7 +14,7 @@
 
 static bool is_kvm_controlled_msr(u32 msr)
 {
-	return msr == MSR_IA32_VMX_CR0_FIXED1 || msr == MSR_IA32_VMX_CR4_FIXED1;
+	return msr >= MSR_IA32_VMX_CR0_FIXED0 && msr <= MSR_IA32_VMX_CR4_FIXED1;
 }
 
 /*
-- 
2.56.0.385.gac671c819a-goog

