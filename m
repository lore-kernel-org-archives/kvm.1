Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E8C23D291
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 00:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209558; cv=none; b=ktD+w09JwSXj/DAVvKr0KsIF0/kCrbol1WMnaEp9URpm1DZAc5y+Jj1bSNt/fVKB0AcVfe1wzog8vjC479QINwQyEkwJwrwCcXswJNRc6DS4G2Y0kVI97gsuZxazRmfXIi7S7wThjgI2jGY/s9YZDcwShaGHoCFDuD1MMNmlEXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209558; c=relaxed/simple;
	bh=20s750AZyJ6AuoaDZl//pQa5Coi9qzlUv/FwrTE1vgY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dZKT5601W5loGuix9S8iHg9lsx2M8ZL+LhrsBE9aw5WRIqa5Zx9h/JoSRCL0qKNmN13YQNdpaBT9trkKyy3kwoWjtmMqQ9TiI0hEHyUUSIm6yBnOFE3wBZgDFinmhSyy1wmJZXkBxJd2KS3qVM6YrGWOztmu+0gHQ9YMmjZEkiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QsJn1pQ2; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QsJn1pQ2"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-862a0aa7d2aso1159352b3a.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 17:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790209555; x=1790814355; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uM6Oh64YX8bMZ7uBf0Og489cgMWoz35uyTpErdBKlDc=;
        b=QsJn1pQ2F6LmE6YNLsehgLfms4P97f4XhEc+zJLuzKR4nQF6BzTJr5QNu1DVBM41+7
         857tirHqM59lZ3A03tvqiBQZK1sTXJiIlqAPx8ruBuxTKuOj3xgbJGWn0ccjiTrc5FHw
         bgxrYFJ1UlRShzqYcOYvHgGV4FjU6yRdpY9kKJ482HQRf7Rxvdma2GOig44cTq6iZrmb
         QjE0WVu1GfRUpHUp46tfDsg9f5lecs07gBvo4UXVV3XM2qIhEm8VnB9xlR20LjOzfmTh
         3NlweknPxjmXb95Od59vS07DGzR/BC7uYA3ED9aC/KInPDpUSr75UIP5Nd/oYTOVRjUT
         5l9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790209555; x=1790814355;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uM6Oh64YX8bMZ7uBf0Og489cgMWoz35uyTpErdBKlDc=;
        b=nJbroC55a4322krS7tEQxKlENeE1u+oZ2SHhzmb7uTrSHTFzgY1Vt4Fx0ZhPojmeSQ
         UHhPNywoR4mttZw8ULcDtrvs5bEbYmjWlBYwir/7XeR67mdlKmU2taSV4+u3/xoQvbiR
         UAGW1fLumDEjZNWk/PTWGxfHoLwAW0RRMyTEsBY1a5JL/szhhB0P51S9iEV03zd7IHF3
         +L8on/g+duqbvoDFpJm4+C8hInn3JWsYWphM0ZVLXNYePFWcXHWNasT1FHWThWqBAISD
         cLxMShqHoiG38YdOSKyeUjT/N6kM3G3rs29EzqUPRiwuGvhMod255hBXobf3Zo+vauqD
         nEYg==
X-Gm-Message-State: AFuF++nFMocww6FDqKMbJUuEfKZzDBdMkFkBJxs1eWCX7SIKBMR2Wa+C
	gYvvQX0d7fyxKeRW5jmolP54Qcb7ZcIxQsniGFu1dgZhXSvqsTSXjWQdarJPkppjcGsBtRMMyEc
	OklorTX4E/u5ZMg==
X-Received: from pga8.prod.google.com ([2002:a05:6a02:4f88:b0:cc7:66f5:c110])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:a109:b0:3dd:85a9:55b3 with SMTP id adf61e73a8af0-3de0e7730e0mr661723637.30.1790209555098;
 Wed, 23 Sep 2026 17:25:55 -0700 (PDT)
Date: Wed, 23 Sep 2026 17:25:42 -0700
In-Reply-To: <cover.1790208413.git.jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790208413.git.jmattson@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <e23e296991fdad02cb00601509771317307bb074.1790208413.git.jmattson@google.com>
Subject: [PATCH v2 1/4] KVM: x86: Advertise EFER_LMSLE_MBZ when KVM disallows EFER.LMSLE
From: Jim Mattson <jmattson@google.com>
To: seanjc@google.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, nikunj@amd.com, 
	yosry@kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Set EFER_LMSLE_MBZ, CPUID.80000008H:EBX[bit 20], in KVM's supported CPUID
whenever KVM refuses to set EFER.LMSLE, not just when hardware enumerates the
defeature.  KVM allows EFER.LMSLE if and only if nested SVM is supported, but
passes through hardware's EFER_LMSLE_MBZ as-is, i.e. KVM tells userspace that
long mode segment limits are available on an Intel CPU, and on an AMD CPU with
kvm_amd.nested=0, and then rejects WRMSR(EFER) with EFER.LMSLE=1.  The bit
means precisely "EFER.LMSLE must be zero."

Note, this is purely an enumeration change.  EFER.LMSLE is already gated on
nested SVM: kvm_setup_efer_caps() adds EFER_LMSLE to supported_efer_bits only
if X86_FEATURE_SVM is supported, and svm_set_cpu_caps() sets X86_FEATURE_SVM
if and only if "nested" is true.  KVM's handling of EFER is unchanged; only
what KVM tells userspace changes.

Note #2, KVM now sets the defeature on Intel CPUs as well.  That is no
different than KVM setting NullSelectorClearsBase, another AMD-defined bit, on
CPUs that don't have the errata.  And LMSLE's dependency on nested SVM is a
historical artifact of commit eec4b140c924 ("KVM: SVM: Allow EFER.LMSLE to be
set with nested svm"), not an architectural requirement.

Be aware that this changes KVM_GET_SUPPORTED_CPUID on all Intel hosts and on
AMD hosts with kvm_amd.nested=0, i.e. userspace that reflects KVM's supported
CPUID into the guest will start enumerating EFER_LMSLE_MBZ=1 to newly created
guests.  That's the correct enumeration, and it takes away only an EFER bit
that KVM has never allowed to be set on such hosts, but it *is* guest visible.
Deliberately omit a Fixes: tag: the misenumeration is benign in practice, as
KVM's WRMSR(EFER) behavior is and always has been correct, and backporting a
guest-visible CPUID change isn't worth the risk.

Opportunistically key the EFER_LMSLE decision off kvm_cpu_cap_has() instead of
boot_cpu_has(), as PASSTHROUGH_F() sets EFER_LMSLE_MBZ based on *raw* CPUID,
i.e. "clearcpuid=13:20" would otherwise get KVM to enumerate the defeature and
allow EFER.LMSLE=1, which is guaranteed to fail on VMRUN.

Document KVM's enumeration of the defeature in api.rst.

Assisted-by: LLM
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 Documentation/virt/kvm/api.rst | 11 +++++++++++
 arch/x86/kvm/cpuid.c           |  4 ++++
 arch/x86/kvm/svm/svm.c         | 10 ++++++++++
 arch/x86/kvm/vmx/vmx.c         |  7 +++++++
 arch/x86/kvm/x86.c             |  9 ++++++++-
 5 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e0430cc750c9..3c5bcdb0923f 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -9635,6 +9635,17 @@ On older versions of Linux, CPU[EAX=1]:ECX[24] (TSC_DEADLINE) is not reported by
 is present and the kernel has enabled in-kernel emulation of the local APIC.
 On newer versions, ``KVM_GET_SUPPORTED_CPUID`` does report the bit as available.
 
+Long mode segment limits
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+CPU[EAX=0x80000008]:EBX[20] (EFER_LMSLE_MBZ) is a "defeature" bit: it is set
+when the CPU does *not* support long mode segment limits, and so requires
+EFER.LMSLE to be zero.  KVM reports the bit via ``KVM_GET_SUPPORTED_CPUID`` if
+and only if KVM refuses to set EFER.LMSLE, i.e. if the CPU doesn't support long
+mode segment limits, or if nested SVM is unsupported.  KVM therefore reports
+the bit on all Intel hosts, as KVM allows EFER.LMSLE only when nested SVM is
+enabled.
+
 CPU topology
 ~~~~~~~~~~~~
 
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 851f151efb35..dbe20d5e6f80 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1171,6 +1171,10 @@ void kvm_initialize_cpu_caps(void)
 		F(AMD_STIBP),
 		F(AMD_STIBP_ALWAYS_ON),
 		F(AMD_IBRS_SAME_MODE),
+		/*
+		 * Vendor code also sets EFER_LMSLE_MBZ if KVM itself
+		 * can't support EFER.LMSLE, e.g. if nested SVM is disabled.
+		 */
 		PASSTHROUGH_F(EFER_LMSLE_MBZ),
 		F(AMD_PSFD),
 		F(AMD_IBPB_RET),
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7d59d301e1e5..58768e49505e 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5571,6 +5571,16 @@ static __init void svm_set_cpu_caps(void)
 	    boot_cpu_has(X86_FEATURE_AMD_SSBD))
 		kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD);
 
+	/*
+	 * Tell userspace that EFER.LMSLE must be zero if nested SVM is
+	 * disabled, as KVM allows EFER.LMSLE if and only if nested SVM is
+	 * supported (a historical artifact of commit eec4b140c924 ("KVM: SVM:
+	 * Allow EFER.LMSLE to be set with nested svm"), not an architectural
+	 * requirement).
+	 */
+	if (!nested)
+		kvm_cpu_cap_set(X86_FEATURE_EFER_LMSLE_MBZ);
+
 	if (enable_pmu) {
 		/*
 		 * Enumerate support for PERFCTR_CORE if and only if KVM has
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 612ab07d4100..f144c1e1c63f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8137,6 +8137,13 @@ static __init void vmx_set_cpu_caps(void)
 		kvm_cpu_cap_clear(X86_FEATURE_IBT);
 	}
 
+	/*
+	 * CPUID 0x80000008.  Tell userspace that EFER.LMSLE must be zero; KVM
+	 * never allows EFER.LMSLE to be set on Intel CPUs, as KVM supports long
+	 * mode segment limits only in conjunction with nested SVM.
+	 */
+	kvm_cpu_cap_set(X86_FEATURE_EFER_LMSLE_MBZ);
+
 	kvm_setup_xss_caps();
 	kvm_finalize_cpu_caps();
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 79468ddfe473..830cb9320d89 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6930,7 +6930,14 @@ static void kvm_setup_efer_caps(void)
 
 	if (kvm_cpu_cap_has(X86_FEATURE_SVM)) {
 		kvm_caps.supported_efer_bits |= EFER_SVME;
-		if (!boot_cpu_has(X86_FEATURE_EFER_LMSLE_MBZ))
+
+		/*
+		 * Enumerating EFER_LMSLE_MBZ and allowing EFER.LMSLE=1
+		 * would be nonsensical.  Note, vendor code sets the defeature
+		 * if KVM can't support EFER.LMSLE for any reason, i.e. this
+		 * needs to consult KVM's capabilities, not just raw CPUID.
+		 */
+		if (!kvm_cpu_cap_has(X86_FEATURE_EFER_LMSLE_MBZ))
 			kvm_caps.supported_efer_bits |= EFER_LMSLE;
 	}
 }
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

