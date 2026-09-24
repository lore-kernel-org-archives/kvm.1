Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DFE2EACF9
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 00:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209558; cv=none; b=Q0Rdgja5eTytwxs/gmIaBFV3dKzNffSmLO5vxi6ofrSqckYsdZB31h9cyMhAuCPRHiYS7/XUn5zTgBUJj0YDgWgeyr6xwoJa/9Xk8yDUwtYbI/bIuZXduqxfOsfIJWP0Ia7UIIRVIJa+zAd+UE8Y6F6ERTaGOcf1IUk5bn3DFS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209558; c=relaxed/simple;
	bh=YSrpIK2pVF/5FNDzNmbXXp4qlqZW/WMDSRuIs2fpCGI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HjgqNHHDa4UFjkIFhoWd9HuhCwDWqE/QWu4oEVDxfmyYX0FkmCQY3OqiEcwXM5ag3bg+3CfwJ+JHltwIqf+TgBMcYeqCoXdb9SHYe8sIj+n5vvBzCDFRPceRI2w3cu0/bGL5K8k8/p/I67ZKAWPL3Z5/g5fFB9MgL5ll4X2eYIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UkqBIMER; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UkqBIMER"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc73895c7d5so1905301a12.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 17:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790209556; x=1790814356; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r+yU0a+PweSOLITCJc4zym8U6EzzEmx8B9YTHY0q+B0=;
        b=UkqBIMERU7OjqszGAva34vYyKMIQ3uLY0PK/2FrD8tkEGvGGkASx3Z6KoSbKpAs4WZ
         t66Qz0GEJ6J2WOcg7uS5tK05JKwSVkqcsDsGGFAJr1fCYQdmsH8dtKBksNUJZ4QaHVgE
         epaS4yW/K6o3Xk+uoq9Xpv7n8wt/E/sB9XBMP6tH6RdeFj/W+g4oKgRYB7ex2rQibfKB
         eTcU2KNsfbN+3MgbTmGffRaGInhBhZGoT94dJBOic29HCwsmHn4gmyr4fyy/g5DLQTqj
         JKSYK0JXz2Gx6zC7jrewUIcmxmrO+uRkdKtsgnRHhpGaADL/2JGKg9Yph27+HiAVWxZm
         EibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790209556; x=1790814356;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r+yU0a+PweSOLITCJc4zym8U6EzzEmx8B9YTHY0q+B0=;
        b=Gw4m0x92ToOg7vHkLdDkL/oaDjFvgFxVAu0BSF9OqPRQSAVq2uj5bxj0lZ31We+5Pz
         QPvRSunRGY0L/wM8ctJwMT7qvVRugMQxpBhMCCqtf3dyC3PbeCzt73If8yV/LSGyklNs
         tm0WpcubFlgi7D4fVD5U+rsZ8k1AleqMu8UvtnSFQy2v679XMbSYQPLcomuyYaeu6HRa
         dALyNmTN6zGdn+QyB4Z7mHbYt7YGl631vIvzJOrf1Jnf9B8U9PssKekTyqfgk/iDhAWO
         O+xvO0l1c94MztY6TcJycSoEhQx7cWwV0ggWDr23HIdfPVjvFwP6CQMvFhzgZZ1rY9ll
         JWqQ==
X-Gm-Message-State: AFuF++m79R192vv3FKeCIMt1ZyC2H15h7SvnESeaM83zfRQ/Q1svoPxh
	4yM69bRGDD32EsKBwNzlHuDOEaibyhskaYyLk+7paczvTLt/2nFr+rEETSEh1azXq4aPgEwoxIX
	T8Ev4X3/0HLxLbQ==
X-Received: from pga22.prod.google.com ([2002:a05:6a02:4f96:b0:cc4:33fd:a4f7])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:4492:b0:3dd:85aa:452c with SMTP id adf61e73a8af0-3de0e770a3bmr694890637.30.1790209555955;
 Wed, 23 Sep 2026 17:25:55 -0700 (PDT)
Date: Wed, 23 Sep 2026 17:25:43 -0700
In-Reply-To: <cover.1790208413.git.jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790208413.git.jmattson@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <48e96e1a917a4bc543142014fa27a2357b114b60.1790208413.git.jmattson@google.com>
Subject: [PATCH v2 2/4] KVM: x86: Honor the guest's EFER_LMSLE_MBZ
From: Jim Mattson <jmattson@google.com>
To: seanjc@google.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, nikunj@amd.com, 
	yosry@kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Reject guest attempts to set EFER.LMSLE if userspace enumerates
EFER_LMSLE_MBZ, CPUID.80000008H:EBX[bit 20], in guest CPUID, so that userspace
can hide long mode segment limits from the guest even on CPUs that support
LMSLE, e.g. for migration compatibility between Rome and Milan.

Enumerate the defeature as *partially* emulated, i.e. as supported by KVM but
never advertised, so that kvm_vcpu_after_set_cpuid() propagates userspace's bit
into vcpu->arch.cpu_caps.  Checking guest_cpu_cap_has() in __kvm_valid_efer()
doesn't suffice on its own, because KVM clears the defeature in kvm_cpu_caps
precisely on the CPUs where it needs to be emulated, i.e. cpu_caps would never
hold the bit no matter what userspace puts in guest CPUID.  Don't advertise the
defeature in KVM_GET_SUPPORTED_CPUID, as that would take EFER.LMSLE away from
userspace that blindly stuffs KVM's supported CPUID into KVM_SET_CPUID2.
MONITOR/MWAIT gets the same treatment.

Enforce the defeature only for guest-initiated writes, as it's a guest CPUID
consistency check, not a host capability.  See commit 11988499e62b ("KVM: x86:
Skip EFER vs. guest CPUID checks for host-initiated writes").  Note,
KVM_SET_SREGS does reject EFER.LMSLE, as it runs the full set of guest CPUID
checks, as does nested VMRUN, i.e. L1 can't sneak EFER.LMSLE into L2 via
vmcb12.

Mask EFER_LMSLE out of the value consumed by efer_trap(), which handles
SVM_EXIT_EFER_WRITE_TRAP.  EFER writes are *trapped*, not intercepted, i.e.
hardware has already committed the write by the time KVM gains control, and
the trap is enabled if and only if the guest is SEV-ES, whose EFER lives in
the encrypted VMSA and so can't be fixed up by KVM.  Rejecting the write would
inject a #GP *and* leave EFER.LMSLE set in the guest, which is strictly worse
than honoring a write that hardware itself allowed.  EFER_SVME is already
masked out for a similar "KVM can't enforce this here" reason.

Opportunistically fix the whitespace damage around __kvm_valid_efer().

Document the resulting two-level contract in api.rst, i.e. that userspace may
set the defeature even when KVM doesn't enumerate it.

Suggested-by: Sean Christopherson <seanjc@google.com>
Assisted-by: LLM
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 Documentation/virt/kvm/api.rst | 14 ++++++++++++++
 arch/x86/kvm/cpuid.c           | 16 ++++++++++++++++
 arch/x86/kvm/msrs.c            | 12 +++++++++++-
 arch/x86/kvm/svm/svm.c         | 11 ++++++++++-
 4 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 3c5bcdb0923f..2852bf94828b 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -9646,6 +9646,20 @@ mode segment limits, or if nested SVM is unsupported.  KVM therefore reports
 the bit on all Intel hosts, as KVM allows EFER.LMSLE only when nested SVM is
 enabled.
 
+KVM never reports the bit via ``KVM_GET_EMULATED_CPUID``, but userspace may set
+it via ``KVM_SET_CPUID2`` even on a host where KVM doesn't report it.  KVM
+honors the guest's enumeration and rejects EFER.LMSLE=1 accordingly.  That lets
+userspace defeature a vCPU on a host that *does* support long mode segment
+limits, so that the vCPU can later be migrated to a host that doesn't, e.g. so
+that a vCPU created on AMD Rome can be migrated to Milan and later, which
+dropped support for long mode segment limits.  The opposite direction needs no
+emulation, as a host that lacks long mode segment limits already enumerates the
+defeature.
+
+Note, ``KVM_SET_MSRS`` is exempt from the check, as host-initiated MSR writes
+skip guest CPUID checks so that userspace can set MSRs before it sets guest
+CPUID.  ``KVM_SET_SREGS`` and nested VMRUN are not exempt.
+
 CPU topology
 ~~~~~~~~~~~~
 
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index dbe20d5e6f80..53d205eda335 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1419,6 +1419,22 @@ static int cpuid_func_emulated(struct kvm_cpuid_entry2 *entry, u32 func, u32 ind
 		if (kvm_cpu_cap_has(X86_FEATURE_RDTSCP))
 			entry->ecx = feature_bit(RDPID);
 		return 1;
+	case 0x80000008:
+		/*
+		 * Honor the guest's EFER_LMSLE_MBZ even if the underlying CPU
+		 * allows setting EFER.LMSLE, e.g. to allow migrating a vCPU
+		 * between hosts with and without EFER.LMSLE support.  To avoid
+		 * breaking existing setups that reflect KVM's supported CPUID
+		 * into the guest, KVM doesn't advertise EFER_LMSLE_MBZ unless
+		 * KVM *can't* support EFER.LMSLE=1.
+		 */
+		if (include_partially_emulated &&
+		    !kvm_cpu_cap_has(X86_FEATURE_EFER_LMSLE_MBZ)) {
+			entry->ebx |= feature_bit(EFER_LMSLE_MBZ);
+			return 1;
+		}
+		/* Nothing in 0x80000008 is fully emulated, don't emit an entry. */
+		return 0;
 	default:
 		return 0;
 	}
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index dd3bb04878ca..b519fb90776e 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -598,9 +598,19 @@ static bool __kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 	if (efer & EFER_NX && !guest_cpu_cap_has(vcpu, X86_FEATURE_NX))
 		return false;
 
-	return true;
+	/*
+	 * EFER_LMSLE_MBZ is a "defeature" bit, i.e. is set when the CPU does
+	 * *not* support long mode segment limits, and so is the only EFER
+	 * check whose polarity is inverted: EFER.LMSLE is legal if and only if
+	 * the guest does *not* have the defeature.
+	 */
+	if (efer & EFER_LMSLE &&
+	    guest_cpu_cap_has(vcpu, X86_FEATURE_EFER_LMSLE_MBZ))
+		return false;
 
+	return true;
 }
+
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
 {
 	if (efer & ~kvm_caps.supported_efer_bits)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 58768e49505e..90a80aad672f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2759,10 +2759,19 @@ static int efer_trap(struct kvm_vcpu *vcpu)
 	 * bit in svm_set_efer(), but __kvm_valid_efer() checks it against
 	 * whether the guest has X86_FEATURE_SVM - this avoids a failure if
 	 * the guest doesn't have X86_FEATURE_SVM.
+	 *
+	 * Clear EFER_LMSLE for a related reason: EFER writes are *trapped*,
+	 * not intercepted, i.e. hardware has already committed the write by
+	 * the time KVM gains control, and the trap is enabled if and only if
+	 * the guest is SEV-ES, whose EFER lives in the encrypted VMSA and so
+	 * can't be fixed up by KVM.  Rejecting EFER.LMSLE=1 would inject a #GP
+	 * *and* leave EFER.LMSLE set in the guest, which is strictly worse
+	 * than honoring a write that hardware itself allowed.
 	 */
 	msr_info.host_initiated = false;
 	msr_info.index = MSR_EFER;
-	msr_info.data = to_svm(vcpu)->vmcb->control.exit_info_1 & ~EFER_SVME;
+	msr_info.data = to_svm(vcpu)->vmcb->control.exit_info_1 &
+			~(EFER_SVME | EFER_LMSLE);
 	ret = kvm_set_msr_common(vcpu, &msr_info);
 
 	return kvm_complete_insn_gp(vcpu, ret);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

