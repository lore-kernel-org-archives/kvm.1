Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978C43F660E
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778260048; cv=none; b=uCsbHuK2EvgzmW0rv2Y2Eq4v0zHiPsv7feDE1B+Vdxc5igdUvcM97XuhR6EvHdSsPAdm2YjU3FhldKQ5PfKKs+m5+a3Ehrca5hQfgfa+QT5ATsxxdENv0f62cp0qD7XMLMi6t/c0bTMAHLf8FZWhJUAYZV40jODsBpExKlT0eDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778260048; c=relaxed/simple;
	bh=o9f9jO84OCJa0WZgWeC13Nym6FnQBtWqM5hYOE31yWw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qRZidHYQQsUSYJqEZ5FOPILt6Pq5bS4thXB/oNFT9kWgLxOfBJ9NtkKB++7jp06+0JvHy2wEQt2ytDZhRcid5/LkNLg+gMbU03+kMc+JAxKjs/b/lOL019VqS6cAVBB72hVJB2mJVz8iSrF3tPpm39jTHbUWBg6R57od7LXMLJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OJbwjA6i; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OJbwjA6i"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36615b95e7aso2213677a91.1
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 10:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778260044; x=1778864844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WTcWclaBrFY7lmTfxYojZT9xYgxKLfO3eM6ShqstUZo=;
        b=OJbwjA6ilOyoBymUZ0u8bZUS6+UMYv1BcPS6xbPttJEYnQiZtRWBeMjIuog2GTOnmb
         6VYGelv+oUVuAXHD/L47ukxcfUyXSkL6L8irk0PZj4hj7rEOm1VwtIAVSJI5KpD6JseY
         JEwPbZ5Onnkl4PQODQPsC5CxIy9MQMPskIZ76j9SN8LZEFHQZ8n2yigrhoRm2ojvSGlO
         JAzeUGG0MNZq6FRrEyPzPAS4R5MPpg3E57ZW4SoK7qltnZGu3AKhMi9gUelAglftdVHJ
         x4DcLxCTWWBwhxlaIUG44pNiR+0pPZanQ1sFex4ylhsALiDgxD2/WRKent/+VrU5vJIP
         DHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778260044; x=1778864844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTcWclaBrFY7lmTfxYojZT9xYgxKLfO3eM6ShqstUZo=;
        b=KXo/Y5+/XuCSG/kn8nEpTXILdE+nbDWqRJm6PXGbqarzVQJQT7Ejo7eB9nsCLlnA1O
         LdRiyjkRBWyAqYJJJ1/AVdkQp5GJsL/u6159wvKKHX6lgnB2HiH98PxdmK6Pr6PZDf7A
         +tV2rOvnVnh5aTQE47x/PcoU29U6pEZffo7fM/qOlWpJ1Xbfz4EwT3YQvWpdYPOs518c
         eGuLh6RYNMLPjNhY99cwTFnryqMULx8tjxc4o7ZL7Tc1XRqcSWnyBZ+m8paXupnnjy/s
         PeMYkZL1PNSg1UUSp4Hs+DsJY8ySZfnIdcpZjrLFscSNwmjwLPJnVoSYdmg4UeEwstAe
         xW2g==
X-Forwarded-Encrypted: i=1; AFNElJ93VLeRDc1/MvJJ9piqDeIXcPigrCxTjxMVxP82Dq/dSNG+uiGrzQyXLCyXU4NqfdpfXAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvwJNAJjcYs67tBr8eKsHvGeVOfC7vXD08ksMdFmGAaI0CuFqK
	gT7rj4YgAn7UhM/2QM+vAkf5V+bPTl+AKGp1GSDordyGXsVl5lZ7cabBKDjYBTsZZB+F7fKNkcX
	yL3ky3M0iMx20GA==
X-Received: from pjbsk11.prod.google.com ([2002:a17:90b:2dcb:b0:364:a306:a903])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3d0b:b0:35e:577c:c9f with SMTP id 98e67ed59e1d1-365abcdf135mr14784898a91.9.1778260043856;
 Fri, 08 May 2026 10:07:23 -0700 (PDT)
Date: Fri,  8 May 2026 10:07:02 -0700
In-Reply-To: <20260508170714.489136-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508170714.489136-1-jmattson@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508170714.489136-2-jmattson@google.com>
Subject: [PATCH v2 1/3] KVM: x86: Remove supports_cpuid_fault() helper
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Clayton Pence <ctpence@google.com>
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

The function, supports_cpuid_fault(), tests specifically for guest support
of Intel's CPUID faulting feature. It does not test for guest support of
AMD's CPUID faulting feature.

To avoid confusion, remove the helper.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/cpuid.h | 5 -----
 arch/x86/kvm/x86.c   | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 039b8e6f40ba..8b64d863e19c 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -181,11 +181,6 @@ static inline int guest_cpuid_stepping(struct kvm_vcpu *vcpu)
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
index 0a1b63c63d1a..7d5b66287593 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4264,7 +4264,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_MISC_FEATURES_ENABLES:
 		if (data & ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT ||
 		    (data & MSR_MISC_FEATURES_ENABLES_CPUID_FAULT &&
-		     !supports_cpuid_fault(vcpu)))
+		     !(vcpu->arch.msr_platform_info & MSR_PLATFORM_INFO_CPUID_FAULT)))
 			return 1;
 		vcpu->arch.msr_misc_features_enables = data;
 		break;
-- 
2.54.0.563.g4f69b47b94-goog

