Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38A93CF68E
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792722; cv=none; b=rTwoKhYyJaQN3qf682JGhtLLB+sqeVUAjmcbp8MY8OepBsgghQDjC94Te1Qe0uR+6/Wu11MTGVUmAu7WTiRjbAznwt2M7m5hS2Dr6BsGafvuqHAK89dz8NOCvWaPdt8HZLY+pBAb/nIbMyMty7c6v43kCuDSda1WCqfQjS3JOYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792722; c=relaxed/simple;
	bh=bqwBfS/g6nEZKyfvREWE7UnmS3OJYtppsGptbuS9d9U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ptEhUqzW6tWmLIYF9Zl2fQcowHiY2Qx0AJjqdPU4FzJ8rDKIaTyHi7pnpnJd3NQIAhY0gXTIVjPg0jR37zOkWxg1X0NZdT8yFxXj0YkT42v1OqWSa+xMYq4Uss5pav6+e5Y8MnncvZU/yJSMMMlaoF3Sf45sAw/+o/i5vSRaTBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=md3iTYN5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="md3iTYN5"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b9b8137828so89952795ad.0
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778792720; x=1779397520; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7QGZPQNrBZYi2J8vz2A1a2BHpEfzzemFW1UzvzwOG+E=;
        b=md3iTYN5yrEzFqRTvcLntcQDfBuFinhqgTOhrJp9tVgxccyf5nNDub/5Ze7rk2hCW5
         Srv5vr7O98dijJhjM4je60tPvOMkSZjPzlWWJZhYHVoejoTaLl5ToDbuBnT60PCB5uO7
         Not1lF+IdpCYEonMb/c3xhmo0Sk7rCE0yDce4+pvB04IlCSi7OjHRYiOiJKiX1wTiC68
         OaGD9Wb3mxTesVTVcAc2aYws17PHdxm1wli0ztujPAloXuQOn71+wuxXpsQmH+6fZboB
         ZNdMuysvABngeBRbxhzZvc8IpDEH7umcwB3CGS2RGdevvB2lAMX9KwKct1itOQLSlZDa
         n33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778792720; x=1779397520;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7QGZPQNrBZYi2J8vz2A1a2BHpEfzzemFW1UzvzwOG+E=;
        b=Y87mW//kKNHE5vbz84u3cCKNrTVYCBwpU43wnZvX3Tw2mhtV0GcZFn6Ej5GEDf9ljN
         vmA/td2dloyhL095sNjyprIQuu3rSFsmC1XMG1UOnmz5Mfb6QdJEqWH67cDkyLdhtq+t
         oFnkTli294wxAjT1K2IxrWTSi1LYDzBMBtqqobPnzIZi0DkoMIvJ4ZlMFklCIf7UiwkA
         Pz5DXPw/wgvM/YghwIjEGM51XGQ7Vy7PoxOG1qXF6X0Rkm7Qy2Gi8/lcVnAvU80BDuPP
         UGwJaSjGj4JA22DQsZtgQRgpvstb9o0nWzR0uPM0i/DoAtITJn66gnQoc68MCYaI8mgK
         CWPg==
X-Gm-Message-State: AOJu0Yw8f7VcNl242uwgoQHhAL4s0vDIfxAKHfLypHSDPVKCuJlX5MG5
	Fyxv9s8AtO/rfYNjPJsy1ZUjgLQ50A1uE5SO9Xf0x5fkwR02pOme63WTa76UQpgcMFDhK9i4VLk
	YWnNCRQ==
X-Received: from pgbcs7.prod.google.com ([2002:a05:6a02:4187:b0:c79:6160:f8d4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a24:b0:39c:241:65a3
 with SMTP id adf61e73a8af0-3b22e6668b2mr965192637.1.1778792719865; Thu, 14
 May 2026 14:05:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:04:55 -0700
In-Reply-To: <20260514210500.1626871-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514210500.1626871-16-seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 15/20] x86/kvmclock: Skip kvmclock test when
 not running on KVM with CLOCKSOURCE2
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Mathias Krause <minipli@grsecurity.net>, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Skip the kvmclock test if the (virtual) CPU isn't running on KVM and/or
doesn't have CLOCKSOURCE2.  Presumably non-KVM environments simply don't
run the test, but checking for kvmclock support is easy enough.  E.g. with

  -cpu host,-kvmclock,kvm-pv-enforce-cpuid

the test will die on WRMSR #GPs without the checks, but generate

  SKIP: CPU not running on KVM with CLOCKSOURCE2
  SUMMARY: 1 tests, 1 skipped

with the appropriate checks.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 lib/x86/processor.h | 15 +++++++++++++++
 x86/kvmclock.h      |  2 ++
 x86/kvmclock_test.c |  9 ++++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/lib/x86/processor.h b/lib/x86/processor.h
index 32ce08e2..ba7065f7 100644
--- a/lib/x86/processor.h
+++ b/lib/x86/processor.h
@@ -317,6 +317,7 @@ struct x86_cpu_feature {
 #define X86_FEATURE_XSAVE		X86_CPU_FEATURE(0x1, 0, ECX, 26)
 #define X86_FEATURE_OSXSAVE		X86_CPU_FEATURE(0x1, 0, ECX, 27)
 #define X86_FEATURE_RDRAND		X86_CPU_FEATURE(0x1, 0, ECX, 30)
+#define X86_FEATURE_HYPERVISOR		X86_CPU_FEATURE(0x1, 0, ECX, 31)
 #define X86_FEATURE_MCE			X86_CPU_FEATURE(0x1, 0, EDX, 7)
 #define X86_FEATURE_APIC		X86_CPU_FEATURE(0x1, 0, EDX, 9)
 #define X86_FEATURE_CLFLUSH		X86_CPU_FEATURE(0x1, 0, EDX, 19)
@@ -351,6 +352,7 @@ struct x86_cpu_feature {
 /*
  * KVM defined leafs
  */
+#define KVM_FEATURE_CLOCKSOURCE2	X86_CPU_FEATURE(0x40000001, 0, EAX, 3)
 #define KVM_FEATURE_ASYNC_PF		X86_CPU_FEATURE(0x40000001, 0, EAX, 4)
 #define KVM_FEATURE_ASYNC_PF_INT	X86_CPU_FEATURE(0x40000001, 0, EAX, 14)
 
@@ -449,6 +451,7 @@ struct x86_cpu_property {
 #define X86_PROPERTY_AMX_NR_TILE_REGS		X86_CPU_PROPERTY(0x1d, 1, EBX, 16, 31)
 #define X86_PROPERTY_AMX_MAX_ROWS		X86_CPU_PROPERTY(0x1d, 1, ECX, 0,  15)
 
+#define KVM_SIGNATURE "KVMKVMKVM\0\0\0"
 #define X86_PROPERTY_MAX_KVM_LEAF		X86_CPU_PROPERTY(0x40000000, 0, EAX, 0, 31)
 
 #define X86_PROPERTY_MAX_EXT_LEAF		X86_CPU_PROPERTY(0x80000000, 0, EAX, 0, 31)
@@ -506,6 +509,18 @@ static __always_inline bool this_cpu_has_p(struct x86_cpu_property property)
 	return max_leaf >= property.function;
 }
 
+static inline bool this_cpu_has_kvm(void)
+{
+	struct cpuid signature;
+
+	if (!this_cpu_has(X86_FEATURE_HYPERVISOR) ||
+	    !this_cpu_has_p(X86_PROPERTY_MAX_KVM_LEAF))
+		return false;
+
+	signature = cpuid(X86_PROPERTY_MAX_KVM_LEAF.function);
+	return !memcmp(KVM_SIGNATURE, &signature.b, 12);
+}
+
 static inline u8 cpuid_maxphyaddr(void)
 {
 	if (!this_cpu_has_p(X86_PROPERTY_MAX_PHY_ADDR))
diff --git a/x86/kvmclock.h b/x86/kvmclock.h
index 1a40a7c0..bde9a21f 100644
--- a/x86/kvmclock.h
+++ b/x86/kvmclock.h
@@ -1,6 +1,8 @@
 #ifndef X86_KVMCLOCK_H
 #define X86_KVMCLOCK_H
 
+#include "libcflat.h"
+
 #define MSR_KVM_WALL_CLOCK_NEW  0x4b564d00
 #define MSR_KVM_SYSTEM_TIME_NEW 0x4b564d01
 
diff --git a/x86/kvmclock_test.c b/x86/kvmclock_test.c
index d21c6c72..659be870 100644
--- a/x86/kvmclock_test.c
+++ b/x86/kvmclock_test.c
@@ -108,6 +108,11 @@ int main(int ac, char **av)
 	int ncpus;
 	int i;
 
+	if (!this_cpu_has_kvm() || !this_cpu_has(KVM_FEATURE_CLOCKSOURCE2)) {
+		report_skip("CPU not running on KVM with CLOCKSOURCE2");
+		goto out;
+	}
+
 	if (ac > 1)
 		loops = atol(av[1]);
 	if (ac > 2)
@@ -151,5 +156,7 @@ int main(int ac, char **av)
 
 	on_cpus(kvm_clock_clear, NULL);
 
-	return nerr > 0 ? 1 : 0;
+	report(!nerr, "%u time warps detected", nerr);
+out:
+	return report_summary();
 }
-- 
2.54.0.563.g4f69b47b94-goog

