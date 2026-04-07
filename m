Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE1E2C326D
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 19:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775588632; cv=none; b=ltZVmmwi4xVAAw4f+oDwNkrfjHrSMMVDswrcGVJgj9WySLpRqti7we57buPG3rYGZNiGlDP3FrUn1tR0SaAeBYjBEz4RjWskC0WWlmzE/mlmDMGzPu2o19LrjZJMuLL8eJGALhA/VJCoORVXG0Om2p967KFlvBinHi/UfGwO1IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775588632; c=relaxed/simple;
	bh=RMLXRX6bryDm4ssDlq8UbOECM6LQpUjVfXUQ610XxdM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G2rFPJkwi47lz+QFvi+/L3aprxWfI84+LLnKSkZ6hPYg4ZBSPQdHJUGSuBEJYv/GCsmCMG5X51qplLXM52y5OKUhmdLGav/RI+p5j/aam2P772P3pVizadmfe4Dno0rYKYk34C25PnSd74gN4yuBb70vHra8Hc2kJctrbP1sioQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tjzPp25M; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tjzPp25M"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35842aa350fso12619037a91.0
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 12:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775588631; x=1776193431; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kBcYO2kAvzs3vHcpFTqX2V/VJxlQwy4kCc06fOqIhDc=;
        b=tjzPp25MEyrHqFD/g83z9PQsZyxECBJ3HEXa6t3+C/8/w6osDhSAkLVHmJnB9qFCfC
         rBv0hwO3XexOp/XV+HF/SxNIG1236BaIsTvp7rjSI4Y33AY4CPMjx2N54yr8E0nlK/yB
         647AID5BJoa3zYdTnp+G30FXUehA/bsK6/Nx5KOjb+opS2J4ESYL5k+/r2p6R1sJSleJ
         jyvbLaWCrW6hGkMaGSIR/0vSi9OWNjlR1S7i4Vn3F0kK8rMgl68mnOVeT8+N4o34Zxvv
         Cf32K3YBUmtzbmTNr3V0djiw3IRS21cOFB6I3H35SZSdmvnZMrmQ1nN7n7ZyMWFk1wVW
         rErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775588631; x=1776193431;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBcYO2kAvzs3vHcpFTqX2V/VJxlQwy4kCc06fOqIhDc=;
        b=cSEKYphEyI5dcJZnvpLx3DJt5s3nBeqwaaS5X8+v+PjhsD6TaXC1dNBYNKRh8qioj9
         iEKWVc9Ewg0FvPe2k2UC1tkeqawUx8yqX2d/Eqr8I5s+x6T9tMJzseWEGHtc4D6dI1nJ
         BMQGKjmn1dMe2zOKwIbP9XBDmQfVkbzSs9YStf9x+AXNZl/CtzD8QANIEbAn7oX9U7HH
         QdIZg5vKgSE1HLpq23ARS/Vj3QElVhMOuzVd0Pz59jjSp19X9ypHHJkWXgeo2cV8wETz
         W7fxE6ifE1cJ6saV96DJ1t31YaDAodR6HjCRSwOXqgTBR4WkzZoTGsYz9T8gX7uRk6cE
         qvxg==
X-Forwarded-Encrypted: i=1; AJvYcCWdUqXztz2Qa5tHypWbR7jPqmOmhS/k3zmYQItIzlrg2hO4qgOzr6hgJUjcgKvg+FygtHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzCejda9EajyGqyetBb5W/xSAhTyoymojtTFLMSFkiast+NH4D
	gcg5jaAIqLfzwuXPh1rUirsih2JOUZDyfSbJuK0SPZbPQQRHtm/KAR2M5GRnr9AfOW85pxMui//
	e8XdJVkiWsJm4Lg==
X-Received: from pfar12.prod.google.com ([2002:a05:6a00:a90c:b0:823:b9a:9230])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:734b:b0:39f:216:f3f7 with SMTP id adf61e73a8af0-39f2ee497ddmr17525986637.21.1775588630674;
 Tue, 07 Apr 2026 12:03:50 -0700 (PDT)
Date: Tue,  7 Apr 2026 12:03:25 -0700
In-Reply-To: <20260407190343.325299-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407190343.325299-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407190343.325299-3-jmattson@google.com>
Subject: [PATCH v8 2/8] KVM: x86: nSVM: Clear VMCB_NPT clean bit when updating
 hPAT from guest mode
From: Jim Mattson <jmattson@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

When running an L2 guest and writing to MSR_IA32_CR_PAT, the host PAT value
is stored in both vmcb01's g_pat field and vmcb02's g_pat field, but the
clean bit was only being cleared for vmcb02.

Introduce the helper vmcb_set_gpat() which sets vmcb->save.g_pat and marks
the VMCB dirty for VMCB_NPT. Use this helper in both svm_set_msr() for
updating vmcb01 and in nested_vmcb02_compute_g_pat() for updating vmcb02,
ensuring both VMCBs' NPT fields are properly marked dirty.

Fixes: 4995a3685f1b ("KVM: SVM: Use a separate vmcb for the nested L2 guest")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c | 2 +-
 arch/x86/kvm/svm/svm.c    | 3 +--
 arch/x86/kvm/svm/svm.h    | 6 ++++++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 961804df5f45..3575c9386e94 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -697,7 +697,7 @@ void nested_vmcb02_compute_g_pat(struct vcpu_svm *svm)
 		return;
 
 	/* FIXME: merge g_pat from vmcb01 and vmcb12.  */
-	svm->nested.vmcb02.ptr->save.g_pat = svm->vmcb01.ptr->save.g_pat;
+	vmcb_set_gpat(svm->nested.vmcb02.ptr, svm->vmcb01.ptr->save.g_pat);
 }
 
 static bool nested_vmcb12_has_lbrv(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e7fdd7a9c280..56b6bd5dfdca 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2970,10 +2970,9 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		if (ret)
 			break;
 
-		svm->vmcb01.ptr->save.g_pat = data;
+		vmcb_set_gpat(svm->vmcb01.ptr, data);
 		if (is_guest_mode(vcpu))
 			nested_vmcb02_compute_g_pat(svm);
-		vmcb_mark_dirty(svm->vmcb, VMCB_NPT);
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr->host_initiated &&
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index a91942269f6a..dfb0a73be606 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -453,6 +453,12 @@ static inline bool vmcb12_is_dirty(struct vmcb_ctrl_area_cached *control, int bi
 	return !test_bit(bit, (unsigned long *)&control->clean);
 }
 
+static inline void vmcb_set_gpat(struct vmcb *vmcb, u64 data)
+{
+	vmcb->save.g_pat = data;
+	vmcb_mark_dirty(vmcb, VMCB_NPT);
+}
+
 static __always_inline struct vcpu_svm *to_svm(struct kvm_vcpu *vcpu)
 {
 	return container_of(vcpu, struct vcpu_svm, vcpu);
-- 
2.53.0.1213.gd9a14994de-goog

