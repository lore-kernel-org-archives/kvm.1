Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C4C3E2752
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781809069; cv=none; b=SR+aiFKwPgLhI+Ub2qXReMtR82whJCOxFlpPcXAPEBgAdeU+Xg8O2ZG6Ibt0fpCnMSBD4r4LlUX8Ez/MXx9+yPxMO+0ZwbH4C7Nvl4c9sQokUxc1i8N3J99PmxHvvhoiG/OWCPSVAJ4/JWGyIv3nJ5jKSD7xEhqEZ6If70MFNxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781809069; c=relaxed/simple;
	bh=py7MQuy0S7siRplUy2+/e8TsqyKHJJRmnIvIe4TCPII=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gmF8d3r52IcHKtiUOvFL/yrHY/9BHjhJuKokYE8OwYI9K5B84uuWEz8IcxSgJ+wO64xhInqy4w3Oz3OHzQ2tSrH3C+eE0w9FuJHYU9RFKXA06vMFi+ulw4BInVwuI+kbnO+lKmiyUJIbLkf/R64H/TPa0n97RjG66IAM25r1nDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ByNdXZ4Z; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ByNdXZ4Z"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c2b64850easo26539085ad.1
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 11:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781809067; x=1782413867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZ1GTFxb1Ow96qVZrCxGwuuaR1ChhefSmDJIgPYjMY4=;
        b=ByNdXZ4ZOIpE9xK7tiP2XUZRpBAtVGMz/WcKXmZMlg3W+tbJgKEschUQXLCizBW3Sr
         LbVOS2Xv+DLJG3zRSnsnDBF38HjB3tQcku5gw4VET6ts+79zYmOq9OD/MpPPK+AT9FcP
         sJVVUiSRl+/vO1Zz/9XmaYgfYPZqifqOXgqdCSiSGuoyZLPAhwmj6lnvLIHkwOf/waEZ
         ODehUUIRdkaPObnunzTDXLV5RpG8DCYAzQ0RbkuIih394b4n7bPDicKlFk4IOJBU789K
         xRuPjN03umUYl9U8AUZKahaCka2X6+ENGECWtDkvA691E56zaaWf98OKr9nvbTv6VDTx
         WBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781809067; x=1782413867;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mZ1GTFxb1Ow96qVZrCxGwuuaR1ChhefSmDJIgPYjMY4=;
        b=sg7HJ86bruuKNr/iqhwOR1SmKT2TAQbneN3zMh8ncDm4GrBZSpJGzYAhlFaIlMLy7q
         75i5u7axYRkMHrtMgnrbW+khU3yBZzeLVL+Tw799GH/4HlivCb89/uxCd7X2FEfWEHLa
         ZywBi4p0LtLay3OSYaBAY2aPkv8CCux2TqSE6PAmLGiU6k8U/KMcoYhv6GPy6Ngu3/jw
         v60VBZ3DHMgsWtTImL2NrCzDDgNkKoxtc/DtgihoxXPk5U++KUnDF1AUM8BABf/7C0I2
         vTcoDtxshawI/IjP2QdltJy4+IwoaWEhf6BC/yEexye3RxLsdYUxNfEdHQ6t2ynuyVbx
         nOGQ==
X-Gm-Message-State: AOJu0YxCYVA9DYsfKitcbNtkgHNaKpGX8ZFleaZWT8dDSiBZHQJfRx1e
	EpI3OXDjDPRB9l/VfZNKR4ForF6YIjz7S9rgEYe8fVM+RhXtXk4cBwol79Pty9UigBIF42QEq9X
	ztR+10g==
X-Received: from plbla14.prod.google.com ([2002:a17:902:fa0e:b0:2c6:a033:d607])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc43:b0:2bd:907:2cf0
 with SMTP id d9443c01a7336-2c718f417f0mr5985345ad.32.1781809067054; Thu, 18
 Jun 2026 11:57:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Jun 2026 11:57:45 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <20260618185746.2023283-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: Replace BUG_ON() with WARN_ON_ONCE() on "bad"
 nested GPA translation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If KVM attempts to translate what it thinks is an L2 GPA with a non-nested
MMU, simply WARN and return the GPA, i.e. trust the MMU more than the
caller, as there is zero reason to potentially panic the host kernel just
because KVM misused an API.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 3 ++-
 arch/x86/kvm/vmx/nested.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 9aedb88c832d..3e6c671a8dc2 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -2152,7 +2152,8 @@ static gpa_t svm_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
 
-	BUG_ON(!mmu_is_nested(vcpu));
+	if (WARN_ON_ONCE(!mmu_is_nested(vcpu)))
+		return gpa;
 
 	/* Non-GMET walks are always user-walks */
 	if (!(svm->nested.ctl.misc_ctl & SVM_MISC_ENABLE_GMET))
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 3a293640d58c..6957bb6f5cf7 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -7470,7 +7470,8 @@ static gpa_t vmx_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 {
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
 
-	BUG_ON(!mmu_is_nested(vcpu));
+	if (WARN_ON_ONCE(!mmu_is_nested(vcpu)))
+		return gpa;
 
 	/*
 	 * MBEC differentiates based on the effective U/S bit of

base-commit: 9d4853b044beefa21c4ee3e18c40653601a64ced
-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog

