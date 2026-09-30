Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AA24D4888
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797016; cv=none; b=nl/j8zPWyCT1fwLVJK/8zMRcia9+DMzfpeX6bIiIhAfA2bWGtqALqGwZtle8eF3MOBNux4tB1iIDedDaUyUKZzfQMFaBw7vOb6TpodZUUu2p3A/TjYhJJhiZOvIh6lxgYbq6eU4sWVTMyOowZzbIQz7czn/6iIQGa67iJViMlYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797016; c=relaxed/simple;
	bh=Jgndf1FLVPtw1RjeBvHSK/j9YvB+rS6M1T9+7Mb9Hxw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qOjuyy1gFztBIfyZFrKVzrVqF+y7ayabb02l8/oKj7b/rbkdJ4Y86ovxDYZPfF2X7Lb7rpfNMyCO2+Mb9abf5inRntpntpkn3eLU4pidDxMj6vT6+kg4Ui1kresELlPwbIBAw+222GP2foLMTNBHXNIcyeFZWkMm7VIRz3ibTfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vfKuo4hb; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vfKuo4hb"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d001671a54so57308845ad.2
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 12:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790797014; x=1791401814; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5ZPdaAVKbCuct+Drs4hq/dXnJoZKDoPUJjaVzhPw8KY=;
        b=vfKuo4hbwNLfmDjS2UikM8pr8u6kt147HBAnmycH1kXJNtn87sMEc/ZGDnE006fHhc
         h0uhh5H9R8w6au3DB7qd6Sk4eyqc9gUykZHlvMjvr5qFQ0a/6Wl1lB06/+xrvKS9Xyvf
         2854Ib1SN9zQT3jXCNS2LlfIMmlI/5mP6fjceUZS+Yegd05ci8blHehgZzhhvrcYQzbP
         NCXRG7Y0dLQD7jNf1DMsak3UEwxLrGPDxKS2p6pxQ63qatwXWgtv1y/lNd4yfTpJiHQs
         M9YmE4I0ETPHaaLpXtmg8yBFyVd6nzYebm6zd91ZnD74hq6goqgBckEhtdvd+3+3W8Px
         X9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790797014; x=1791401814;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5ZPdaAVKbCuct+Drs4hq/dXnJoZKDoPUJjaVzhPw8KY=;
        b=cBbzFv867VWLU1yeoHybAWcEKvS6O5YMPhwewWIP3C8Guo9moJ/rp1Q0oS2EIiiHiN
         14Hf9jnDKAdAZr+EvzvNVC5LKbQ9RxB1IlPW2eq01n+BeFbVhCAvAUdrfHgVYj2OgeeD
         XxGUj4O3sidHd24ASFhW1puST2y/y6nMoHzsYOL1oIrRrJCefFlrpS3Kn0+HByMF5noC
         Ykm8nzw1LwWQcWVg8/Mzp3OX+MVrbIXOjkDgSBG+rM1aBGN0shz22bcHVy+JXdAxyI2+
         q5ehbkgedU3hQhh3BAtbcSzR9XH9kGEDI++h1x/6K3QW5AJcGZnX5qU65/6kTcSrnbqF
         uv7g==
X-Gm-Message-State: AFq9FYKdtK8FIzzdUIw3Obt0QBvZNFzFCfiJsFjXTYIcHLAyZ44iIWQ5
	9T5RwGcdj400Ixpvu1WKEKF4kUQ8oumV8AAMYmfvKgYGuNt2BMNZblWsMbGF1m0c7DA7fP5yjY6
	tMpH8BA==
X-Received: from plaw3.prod.google.com ([2002:a17:902:c783:b0:2e2:f0cb:c185])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:228e:b0:2e2:c459:2ed
 with SMTP id d9443c01a7336-2e2e4b551bfmr18928225ad.42.1790797014291; Wed, 30
 Sep 2026 12:36:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 12:36:34 -0700
In-Reply-To: <20260930193634.3415089-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930193634.3415089-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930193634.3415089-13-seanjc@google.com>
Subject: [PATCH v6 12/12] KVM: SVM: Add support for virtualizating Bus Lock Detect
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ravi Bangoria <ravi.bangoria@amd.com>

Advertise support for virtualizing Bus Lock Detect and allow the guest to
enable BUS_LOCK_DETECT if LBR Virtualization is enabled (Bus Lock Detect is
enabled through MSR_IA32_DEBUGCTLMSR, which context-switched if and only if
LBR Virtualization is enabled).

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Co-developed-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
[sean: massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 12 ++++++++++--
 arch/x86/kvm/svm/svm.h |  7 ++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 1e58ad8691e9..e7c296c52591 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -879,7 +879,7 @@ static bool svm_need_lbr_virtualization(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	if (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR)
+	if (svm->vmcb->save.dbgctl & (DEBUGCTLMSR_LBR | DEBUGCTLMSR_BUS_LOCK_DETECT))
 		return true;
 
 	return is_guest_mode(vcpu) &&
@@ -5712,9 +5712,17 @@ static __init void svm_set_cpu_caps(void)
 	 * Clear capabilities that are automatically configured by common code,
 	 * but that require explicit SVM support (that isn't yet implemented).
 	 */
-	kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
 	kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM);
 
+	/*
+	 * LBR Virtualization must be enabled to support BusLockTrap inside the
+	 * guest, since BusLockTrap is enabled through MSR_IA32_DEBUGCTLMSR and
+	 * MSR_IA32_DEBUGCTLMSR is virtualized only if LBR Virtualization is
+	 * enabled.
+	 */
+	if (!lbrv)
+		kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
+
 	kvm_setup_xss_caps();
 	kvm_finalize_cpu_caps();
 }
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index c3380d865b75..6d0242966dc8 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -789,7 +789,12 @@ BUILD_SVM_MSR_BITMAP_HELPERS(void, set, __set)
 
 static inline u64 svm_get_supported_debugctl(struct kvm_vcpu *vcpu)
 {
-	return DEBUGCTLMSR_LBR;
+	u64 debugctl = DEBUGCTLMSR_LBR;
+
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
+		debugctl |= DEBUGCTLMSR_BUS_LOCK_DETECT;
+
+	return debugctl;
 }
 
 /* svm.c */
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

