Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346CB3909B5
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778712395; cv=none; b=Z4R0L7oktXxpaZoUduvIyTZe6eXF7fsMW/97oeHaydnR/2z/VAMo2vmh6doBA5V366X49hvlfUkrRQGqCVmhQeNmA3I8jLm7y+o6W1ZY+0q+MFgs539PAcv1ObxcnjLQkWS5RIf9D3shBYznO6al2F9zidywDWqzvRKFERjGvWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778712395; c=relaxed/simple;
	bh=D6+vtA6oqq9QHjVTZjWcZYnfHZoAg8FIDl1q7NITCek=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ioI37cVAn0Ay6SLZE+QLHtm+r0IbythcbWxDr20etrK2ksoK3anzutq4QGWJnNI0IWLlYt3lvqHtJhQ9p1uydQrj9Ro0paRiOLXKPokeJN9WdqJzv3HIIml0AgWZ6sfJjXxyj2QcM20lwXWK1bNwy9dRrj4gSiY6g7wGUAXNwgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=frtc1gIJ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="frtc1gIJ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba115ab6bbso71087995ad.3
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 15:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778712393; x=1779317193; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x38x6m7+ElGIFPb2Qfy6/0i8M+SSTcotIalc20avhps=;
        b=frtc1gIJ/xEAfeIJRY8tjyZc525/3qd/nKeMaYPkkZ0fbklqO6MUbqiShxk/U4gVI1
         +AkKBP32iCpTsEhMD4SrZjS9Dr1EEXDwx/zxyX9sXOmKOE5VxXRAILuEDFeWOlaa6maY
         zMCXmuu/ONS/FQmCqzCTQiRcYZlEVT64VMOwj/u+I/oyV+ltju4917H2pOsJNKqmrRfa
         +YCdGQ68z+r3RHe9ivQoaKJBz6I/QcCE9wWyb9qyZ2BaZTD5dNnte0fTKWmkQeNzAshN
         LCVmV0VPWAx2jj0W4iLi4vQzyThwWN0BIqzS/H4WIiRr08r1Yn7QJlFrICP/fvpdW6zm
         HgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778712393; x=1779317193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x38x6m7+ElGIFPb2Qfy6/0i8M+SSTcotIalc20avhps=;
        b=JgpEQc7CzfT5+04Q/ZZd/6TRZK6fGT4lGl9/xjbRwASbx6sXVJSJgZAYpD5e4R0RDQ
         rCA1F/Zm9jaKmmlv9a3aUa7HdB2juHUP8yZl4IvP4kVh0/L01S4MW7sWluun0Im+YO2j
         63pxcUeTnaaDxDBHjZYX1dRVa23XYhnx76pUkL3SAQe+OkRF02FAodp4VvumzuWS2ewD
         XAbOvJ2pJ4jd3fq51xpdLIBnlLbiIV8L/cQuE/D7gmY0bcTwEu4ntIRH7DfJ0y5/REXQ
         0LVAq/TYv7U3H49UvHVAApbZuZs29fKmbQDi8skPDUFVtr3I5eaQ08X9gOd0d//HIX7c
         w5tg==
X-Forwarded-Encrypted: i=1; AFNElJ+lVn/6licAf7lYKTOACP6YyUqkyjXgPTEo//3GdthV3HHdhovVt321oiYRg94XG3o/1pY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeMfgGI+hpTZnEzHqLoDwoTtsRf+TL82z5x7k4ZN7KsBqHlW04
	kKjZDVX9OLR06blsun2rjQYikGazRbVOdw/+YlWiZVvoQKq3zmAnf1/IAR2n55SReWaAZehtUQj
	KvHqDzuddniNXQA==
X-Received: from plhq16.prod.google.com ([2002:a17:903:11d0:b0:2b2:43c2:a183])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:249:b0:2b2:58c7:2ce1 with SMTP id d9443c01a7336-2bd276f32fbmr51626805ad.36.1778712393238;
 Wed, 13 May 2026 15:46:33 -0700 (PDT)
Date: Wed, 13 May 2026 15:46:07 -0700
In-Reply-To: <20260513224608.1859737-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513224608.1859737-1-jmattson@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260513224608.1859737-5-jmattson@google.com>
Subject: [PATCH v3 4/4] KVM: selftests: Update hwcr_msr_test for CPUID
 faulting bit
From: Jim Mattson <jmattson@google.com>
To: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	shuah@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ctpence@google.com
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
index 77f576ee7789..9cb1efd910ec 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -209,6 +209,7 @@ struct kvm_x86_cpu_feature {
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
2.54.0.631.ge1b05301d1-goog

