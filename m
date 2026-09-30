Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B484350E594
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803281; cv=none; b=Ov/VNMYkw/aoMVVCRXAVAVFzJquYMmg+0jPQqSm6zw1zKLgvMjUbxd/qQkq0Wf/PlqxqtOc2aijdQzQqp0NcBdiW34VusrCAQS64sENJ9koUkpegfykHDKkbXHu6UDH2+Z4TVJX0cCTlWaIjr91A4HDucfnjF1OD1h5wc/41HBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803281; c=relaxed/simple;
	bh=KaAF/v3VWbZrGBLzY9WT3PcXnY3Ty/aFuFU/6bcxqdI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P14n4KX0NKwkR2tqgXIU10n4jtuIak8zXyAaLdZaMaHavd7wQ37t4PQCUwjdcGAwGbj/6JZI1xvb2IFk42zq8vZDvvLf5n/ZpSIP+zB8AHWAtGn9MwAwhnaqGUUKTtVQRhjmXqqB8rXylN1XrgbNV53KppAj0SzuRrLD+1fJcTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ccwLrYMX; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ccwLrYMX"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccb687f82eso38260095ad.3
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 14:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790803279; x=1791408079; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4/IESgckvzjX33EzLxU5hh6B1Za3iDvpzFI7EQmNi78=;
        b=ccwLrYMX26LCcr8cBOxmJzt1mq0kFwicUolIFKBLu1fPzbX/Zqc52B4YpugdXFk8ta
         v2Kiarh4+3EprfLQt64PuXAO3V/ekKv3gQQa4Jz2gJvLkHYVN9aF1snOMu5D3V1ysCeQ
         txHqFkINabH7X7jSaZPJZ0X9k/sY4BBTeSZHr9aQ5ZACscLM2fEm8nZIAF3+CHNNQMFi
         fNXjd2iEWOSlpBoGP3T2UDiz6JBOQiIvNJhgkhaqBUJPQz4LIQ1tNzRw1IX2pcMBNlek
         B4bOxuSwTxZcbCtwYQJsZtzwQyS3aTAFMpwN4P+wfdvTe0jSey+uh929kRopfbp90rgv
         EOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790803279; x=1791408079;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4/IESgckvzjX33EzLxU5hh6B1Za3iDvpzFI7EQmNi78=;
        b=REJJ8Dkt4W7mtaC/q0tpDngasOioCQdJPP8YjDKCGRQCq/CyAQfa4/9+5llsz0fxd3
         g7Feil5cbjbbRmDOCpM9aW0PJ79220nQybqeaExqKf+F2FRXrMDMArYlyh1Ud1nvq3Xd
         5pxE+Ubb2FfuytnwUBlN7qIMXJQ0sy+V7j6I/8H3o74bfLiSX6JB1i+hl5WFcS+zH7f2
         rYC4sAnXLNKy6plcagc+3N3o6Y8yOP9YcZLDkL0kh117gRSmyxr8bDDLXBynFWGM3p9d
         JdYpCsKwcMircNElZlw8xCa7ZtzTD6SNrjSSw/wmknuj8egRX/8POZYBrGl+N9ljK+ti
         o5/Q==
X-Gm-Message-State: AFq9FYIiWLB408oaHJBfBfttfTEk+08vnEGt4huv4ODM66FPaEXyfj36
	om3bWrVd66YaXVJVUBjL8I5bajJ1ejd9/eNkYZjTIDV7vNtomqM+v4bl0qWze7TsNDLCVgAmz7F
	TJh9nVg==
X-Received: from plbjk22.prod.google.com ([2002:a17:903:3316:b0:2e3:433:71db])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db0a:b0:2dd:b837:48f7
 with SMTP id d9443c01a7336-2e2e4a27db9mr20271485ad.25.1790803278837; Wed, 30
 Sep 2026 14:21:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 14:21:11 -0700
In-Reply-To: <20260930212114.3500045-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930212114.3500045-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930212114.3500045-3-seanjc@google.com>
Subject: [PATCH v4 2/5] KVM: x86: Honor the guest's EFER_LMSLE_MBZ
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jim Mattson <jmattson@google.com>

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
Signed-off-by: Sean Christopherson <seanjc@google.com>
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
 
+	/*
+	 * EFER_LMSLE_MBZ is a "defeature" bit, i.e. is set when the CPU does
+	 * *not* support long mode segment limits, and so is the only EFER
+	 * check whose polarity is inverted: EFER.LMSLE is legal if and only if
+	 * the guest does *not* have the defeature.
+	 */
+	if (efer & EFER_LMSLE &&
+	    guest_cpu_cap_has(vcpu, X86_FEATURE_EFER_LMSLE_MBZ))
+		return false;
+
 	return true;
-
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

