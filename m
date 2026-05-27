Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5074534A2
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903850; cv=none; b=nSzsS7VfmLCxSbJmnj5ojxMqU0XNMbKqZyNyljD47ghgcgaV5PR225d0bnyN22Vw97taYlOwko5sXwkUVf5jaiIrWOtrTww97cjBSdtxPFwFuLPF8O00a5k1rstE4St2L1fjElXKiYtE81KMyLmxzAQDnXDwAvCHK2d700tGWqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903850; c=relaxed/simple;
	bh=77ZuH98Z/7cwSOPku138FSNXa6+3lR22DIlZyZ/iZdU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u7ec1FcEaiHOAuVl/86Y7O+zchEEgu4A+BxSMhvDkiSXOqpiLrY7gjL9VejJsHUzpQMI1eZa4tccSeR2oNPjkA6M1gyHwMuHASS/UgmyHLq5tfzSVO7krJQInpRFbUFAf0P6Ml3hwFvZDKuvGsdQt4Y4BNpU4kfNoJ0IBMVX8w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K73a8olv; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K73a8olv"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b7aba0af02so114737805ad.2
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 10:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779903847; x=1780508647; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O7VlkQudn+G7xM0z/ouPzrwYiSQV/Sy22jTIFn2bz+c=;
        b=K73a8olvk3exIXE3XtX0zm8DdFXDZEh21iOfYy4tWd5kxu8HRSfSBnCfVoAeIDlozU
         q9ER81R+SDzc9nxC5PTKzTLGqRxrjpcFvdufSziAWcD7yjTcJfFeUFuiGMQgNibuDpIy
         NwIClkkIxE6uFptUtLW62Zl2Gerfxt6b0nNEd/VX5ApeVHunjMbHcWfD1+7ef2T6rbiO
         Beag8V9xjM8zgc/LsubV9EDbd3OUN1J5K1cAZyDgVHdZCieCC0J1U8WKOlEQmcKs3ych
         JONQgrEm19EnklUI3y/vPKLXohQczQvp6IWA09svUUopLhDUdNsVNstBwcAyEn07nAmR
         IXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779903847; x=1780508647;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7VlkQudn+G7xM0z/ouPzrwYiSQV/Sy22jTIFn2bz+c=;
        b=JNE26WnMuSKK5yf1qCGmbux9CKaytOSyYUcV1wzjch4EclFHplxIDqsJplYFvSJ1So
         UrV8l4UjefXMCqngdlA8Hz0Gvl3aiDmyzzP/f3Fb6Gdw1NtOhTf8gtxd7NtQAx+7ugcM
         b5S+gbY+SvA9DGNlMYlSQvxlbmleIk9uurboDgyMYClCcyFdKL8xnmCfwP2m/bpMoJYi
         YXH0DYTjo48Wqfj90hqEyDSlAsQkDDQXithJiTDZFukZMZ8G0QL8j8MmGA/A5CSx+2Ct
         RppTDhcC1KctvK2pLhAhQ0hDsoX7IwweWrQUwNSzXyTCGUuXZRU+lt9qQkKj1wVx2Cnv
         Mhfw==
X-Forwarded-Encrypted: i=1; AFNElJ/RKIwZ8LTEkXEZ+H+HeQtkjmx4Qjmpj3H1q7RKQUBNxN83cNtSAM88pA7nvuLgZztSgFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvoY81iAkDQtWI4D+IqZeTXxR7xzsJwCbEMq8YsuSdPR/g8ODP
	opT2J1eOGdit2S1qqv0T8uaxT1Z9ZdLl3m+SXS9jXJkBI4Gzl8zsoo6bqCXn93ckmg695bF0rOK
	ErWzXUv+GcLTGwQ==
X-Received: from plkz6.prod.google.com ([2002:a17:902:7086:b0:2b2:488e:b71])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ebcd:b0:2b7:88d8:efde with SMTP id d9443c01a7336-2beb0365d7bmr270523025ad.7.1779903846519;
 Wed, 27 May 2026 10:44:06 -0700 (PDT)
Date: Wed, 27 May 2026 10:43:47 -0700
In-Reply-To: <20260527174347.2356165-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527174347.2356165-1-jmattson@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260527174347.2356165-6-jmattson@google.com>
Subject: [PATCH v4 5/5] KVM: selftests: Update hwcr_msr_test for CPUID
 faulting bit
From: Jim Mattson <jmattson@google.com>
To: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	shuah@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ctpence@google.com, David.Kaplan@amd.com, 
	binbin.wu@linux.intel.com
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Add BIT_ULL(35) (CpuidUserDis) to the valid mask in hwcr_msr_test, now that
KVM accepts writes to this bit when the guest CPUID advertises
CpuidUserDis.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 tools/testing/selftests/kvm/include/x86/processor.h | 1 +
 tools/testing/selftests/kvm/x86/hwcr_msr_test.c     | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 06878e7c7347..513e4a1075fa 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -226,6 +226,7 @@ struct kvm_x86_cpu_feature {
 #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
 #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
 #define X86_FEATURE_SEV_SNP		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 4)
+#define	X86_FEATURE_GP_ON_USER_CPUID	KVM_X86_CPU_FEATURE(0x80000021, 0, EAX, 17)
 #define	X86_FEATURE_PERFMON_V2		KVM_X86_CPU_FEATURE(0x80000022, 0, EAX, 0)
 #define	X86_FEATURE_LBR_PMC_FREEZE	KVM_X86_CPU_FEATURE(0x80000022, 0, EAX, 2)
 
diff --git a/tools/testing/selftests/kvm/x86/hwcr_msr_test.c b/tools/testing/selftests/kvm/x86/hwcr_msr_test.c
index 8e20a03b3329..53b7971aa072 100644
--- a/tools/testing/selftests/kvm/x86/hwcr_msr_test.c
+++ b/tools/testing/selftests/kvm/x86/hwcr_msr_test.c
@@ -11,12 +11,17 @@
 void test_hwcr_bit(struct kvm_vcpu *vcpu, unsigned int bit)
 {
 	const u64 ignored = BIT_ULL(3) | BIT_ULL(6) | BIT_ULL(8);
-	const u64 valid = BIT_ULL(18) | BIT_ULL(24);
-	const u64 legal = ignored | valid;
+	u64 valid = BIT_ULL(18) | BIT_ULL(24);
 	u64 val = BIT_ULL(bit);
 	u64 actual;
+	u64 legal;
 	int r;
 
+	if (kvm_cpu_has(X86_FEATURE_GP_ON_USER_CPUID))
+		valid |= BIT_ULL(35);
+
+	legal = ignored | valid;
+
 	r = _vcpu_set_msr(vcpu, MSR_K7_HWCR, val);
 	TEST_ASSERT(val & ~legal ? !r : r == 1,
 		    "Expected KVM_SET_MSRS(MSR_K7_HWCR) = 0x%lx to %s",
-- 
2.54.0.794.g4f17f83d09-goog

