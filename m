Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E29426EB7
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080248; cv=none; b=LsQw2zNKeXB9t0N5vekOnjU3ZzPkKGCwtP6i0P1nqeZ2FL/AwaUEmaYrJbca/8OXJucljD/czFIig1U1jvcbwa7zpViysq7UzDoO0bkjUGCZBiUuhrhlTRDr6ZfgABfUYRHvu2sovt2GITWcdwbSdTqe9osE8k7R8pmL1s8VBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080248; c=relaxed/simple;
	bh=J+jkhnGVw3vvhDoqG6FR+sdYUrS5qCP0EWyTOgkwu1c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EUiigW5jaIzkeDwVSoaykwgwpkrrQwbmxhunAxoO/m7HEdo+Q2K7lyAlU6/hnTsWRbs6qF3dG120S6FGz6A/pDQDBqI8SHJtj/12pB8H7eS4KZ6W1nE50SZifr7VmdE3dKv5hE1z4T6w0ctXRQnBlNhOb+YvPyLqEXoQIv8nY2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fcTff0QM; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaltinay.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fcTff0QM"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35fb6be0f9fso1392122eec.0
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792080233; x=1792685033; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IxNJDyDJG3p3TODXcLYOqAKzmxTypvEoRRB1/QzaNZI=;
        b=fcTff0QMjnfZvDjFX9F0c0xMb4WvtiTVRP6ua6mdV9DKM+uMxXSLiry24pNReAJChm
         IW7O2mreWQAooeuvxbdUAiSrZKl0S7jR8iFJneUc/LkTm3I+WiWI5zs79+HWtTPgH4B7
         /0SBlYBZ2xSKM5vdLPGeNMIvCEpUxwPtaGXFTwUtBPbNtx6NOmincq+0BiXisBKcaKXm
         5hROISHONnOaVOE5QsYfFWvG1unFo0uBXCKk1w9wsdLomju0grVkZ3bO7sKkQmwztNsI
         jRS7WnsRZtVpB+npjzjUjBdtkmcbzzbaZWjt51mt8nn+H94XSy38SCK2qzLkTnaz07Lj
         u1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792080233; x=1792685033;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IxNJDyDJG3p3TODXcLYOqAKzmxTypvEoRRB1/QzaNZI=;
        b=nQkg03sG/yqe0pTMFJ22XcAoPrjNlMGRpkoWxWHHShkWTtFRo1fow+jWS801qhZLJQ
         HW9Kqxhv68+GUkeM7qWoXLhVq6/eJ9I1NkR/iLSSe/05bwkx36CpVkqCrB9ZKXMA4Q+k
         rbHbMydh6oPDSg9hTgigmiHdy616a+seeyl8L07ujF6VDIEtAbfyST2PgCrQU9woh0EN
         nlXCY9/x8HcYtQYKEDmCW3JKq+Qm9MV3FEidGntrtXDdA+YLPhLqU9uFIquelEYZqsrC
         QwvlMapD7Mead3FBkarGXRBhZccjdYYhZg9X8QNiJ2uRY2Pu5saVxiRJRGg7BMR8k0bN
         6c4A==
X-Forwarded-Encrypted: i=1; AKwUvByjlbbvPsHQkEg/MkgmbwoDL51D9d7mMRbN5BTfOV8nTzNM7X2DzMffyx3zOOBB0AJ9TrI=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7lbCwy7jr3kPAP8JuMTDc3lf1Vnal0ePTxebu38tg4mw8pG4P
	PtGkN8mefwZdWP2lu/qePFJTiHCST7h7JphtnXodTVvNPqBQ/EOIfSnVRZf8v4XRZOn/vGpi8R9
	qHY4jmZGwrv6G+Q==
X-Received: from dli6-n2.prod.google.com ([2002:a05:7022:286:20b0:15c:6a90:d4ff])
 (user=aaltinay job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2806:b0:137:5b9d:cf87 with SMTP id a92af1059eb24-16a4e6cb97cmr28450678c88.0.1792080231948;
 Thu, 15 Oct 2026 09:03:51 -0700 (PDT)
Date: Thu, 15 Oct 2026 16:03:44 +0000
In-Reply-To: <20261015160346.181835-1-aaltinay@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261015160346.181835-1-aaltinay@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261015160346.181835-5-aaltinay@google.com>
Subject: [PATCH 6.18.y v2 4/6] KVM: x86: Remove supports_cpuid_fault() helper
From: Anil Altinay <aaltinay@google.com>
To: stable@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Anil Altinay <aaltinay@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jim Mattson <jmattson@google.com>

commit d1bc99885a59d89e408f52f4c147b07bca9a686f upstream.

The function, supports_cpuid_fault(), tests specifically for guest support
of Intel's CPUID faulting feature. It does not test for guest support of
AMD's CPUID faulting feature.

To avoid confusion, remove the helper.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Link: https://patch.msgid.link/20260527174347.2356165-4-jmattson@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Anil Altinay <aaltinay@google.com>
---
 arch/x86/kvm/cpuid.h | 5 -----
 arch/x86/kvm/x86.c   | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index c5399ab7e5ae..872bc99c55ed 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -175,11 +175,6 @@ static inline int guest_cpuid_stepping(struct kvm_vcpu *vcpu)
 	return x86_stepping(best->eax);
 }
 
-static inline bool supports_cpuid_fault(struct kvm_vcpu *vcpu)
-{
-	return vcpu->arch.msr_platform_info & MSR_PLATFORM_INFO_CPUID_FAULT;
-}
-
 static inline bool cpuid_fault_enabled(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.msr_misc_features_enables &
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6f76290e79c9..a91599e5d8db 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3913,7 +3913,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_MISC_FEATURES_ENABLES:
 		if (data & ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT ||
 		    (data & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
-		     !supports_cpuid_fault(vcpu)))
+		     !(vcpu->arch.msr_platform_info & MSR_PLATFORM_INFO_CPUID_FAULT)))
 			return 1;
 		vcpu->arch.msr_misc_features_enables = data;
 		break;
-- 
2.56.0.385.gd3acb90ef8-goog

