Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F903CEB9F
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177529; cv=none; b=sOj3FpTk5C3AzrOrTtPhYte4xAYcdY0bIHf9CTcQWde9T8hntQcHnjG7M0IyBoPWZhiqil1rUUXScdzYedh0Dvq5NEg8x+pgm2G+HgVFZH2Wce+Q+QAkhDY5mtcRCVFUDOH4ERKQoLulcYvTT4401S45MMQodzxUq701XzrsAuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177529; c=relaxed/simple;
	bh=S28QJn+u1A8OcvWhjc0WAILTje35U++nn5RVQ8+xR3o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SxPnoj1Ca52etqauJeiryKBFlFGoa/UNLGKJ6HCK8U8FWtOOEvjsvokWL6OhdkMTJQTgxmZYmcDYsKMHsyAY29xVnypCd2I9niSJo2bzQQrpHJrkFXlQrn2X8kTM5OyqRE9APqoJ+JdGzqh31ujNUt7GYbdXFyv3fdxAkaEinag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SwkK/XzT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SwkK/XzT"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c73c065dd15so966677a12.0
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 14:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773177528; x=1773782328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=THf9TwDgXJYxAu1jZZpzuHjdOYvQ3dk9jwWqO8cyEKU=;
        b=SwkK/XzT01SJVbRukGFmtsMHsxHQVk31YvSWHSXx7awWHSasb6NtkVcBLtovR/Nk+D
         eXdK7zKDdpzvZX7Yb9peU3/1oriPOIE7PiLhLkcfvRNDSrXfX2RY5eg2QMcd4/eEvJ89
         cH2wMvD+X/EYcYnD9rx+ZlvWcpaOZMxhyyjlcpKWYxQl4hk7I9w8fjBxcl/7qMPtUWMO
         OEvGtBcmRBch/tSks4Dmp16KyR4hUDwSAcqWN4fQwFzk68+Efr2OjT5jVe5FoznSD7Pb
         Ht1KY4/YXVsgr8Vr1UcjlamoPeXzYCdO2WNUIhtMeiBhlPPpRz8grrOiPfESe2DxTZ+H
         Pbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773177528; x=1773782328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=THf9TwDgXJYxAu1jZZpzuHjdOYvQ3dk9jwWqO8cyEKU=;
        b=mw/Dhwrj3kpMVr77OYWldE6gtCw0Y2o4nQuk0zSDDi0nqtuABwioAf0e1B25IezSUN
         9GpwprJskJDinUzS4gl0MtRonShG+uJp8r4r0+8Ypr1DdCNyb93uAOGMweQuyO8lZVOG
         05oGS87vGo7vyE7fvoJqfALzf43p1IBycRh+62DAWhHP9H90e8kpXdGdwhSoAoTxDnHf
         EVsGo8u03OztGTAqMKQxwkf4ntX1neUC1Tux5r49bWrZbHd4rYbPkRq4v3WaRPBmBkUq
         Y7AH0oa59Xsz36XdWnEgzB3LbSPhB4nntAod7wRSRzI8bBANeB2aD3wjp0N4KM8/OYk4
         x4Kg==
X-Gm-Message-State: AOJu0YxZXWjWCC+ftdPjeLiC34zpM/4UFhRT1jtYXgU6tgdUuoIkrGF+
	t1clqwguJS9jsGQaoNaVA4RaVrTm39P5h5ClRQRy/T9t2skfuXjcFnSu8d7ZcMMRbPjzmTiOU+h
	H9AQw5Q==
X-Received: from pgki21.prod.google.com ([2002:a63:e455:0:b0:c73:9c8b:4186])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7a43:b0:38b:de3d:d542
 with SMTP id adf61e73a8af0-398c61a3b08mr47855637.51.1773177527756; Tue, 10
 Mar 2026 14:18:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 14:18:41 -0700
In-Reply-To: <20260310211841.2552361-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310211841.2552361-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310211841.2552361-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: selftests: Verify SEV+ guests can read and write
 EFER, CR0, CR4, and CR8
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Srikanth Aithal <sraithal@amd.com>, Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add "do no harm" testing of EFER, CR0, CR4, and CR8 for SEV+ guests to
verify that the guest can read and write the registers, without hitting
e.g. a #VC on SEV-ES guests due to KVM incorrectly trying to intercept a
register.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86/processor.h     | 23 ++++++++++++++
 .../selftests/kvm/x86/sev_smoke_test.c        | 30 +++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 4ebae4269e68..469a22122157 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -557,6 +557,11 @@ static inline uint64_t get_cr0(void)
 	return cr0;
 }
 
+static inline void set_cr0(uint64_t val)
+{
+	__asm__ __volatile__("mov %0, %%cr0" : : "r" (val) : "memory");
+}
+
 static inline uint64_t get_cr3(void)
 {
 	uint64_t cr3;
@@ -566,6 +571,11 @@ static inline uint64_t get_cr3(void)
 	return cr3;
 }
 
+static inline void set_cr3(uint64_t val)
+{
+	__asm__ __volatile__("mov %0, %%cr3" : : "r" (val) : "memory");
+}
+
 static inline uint64_t get_cr4(void)
 {
 	uint64_t cr4;
@@ -580,6 +590,19 @@ static inline void set_cr4(uint64_t val)
 	__asm__ __volatile__("mov %0, %%cr4" : : "r" (val) : "memory");
 }
 
+static inline uint64_t get_cr8(void)
+{
+	uint64_t cr8;
+
+	__asm__ __volatile__("mov %%cr8, %[cr8]" : [cr8]"=r"(cr8));
+	return cr8;
+}
+
+static inline void set_cr8(uint64_t val)
+{
+	__asm__ __volatile__("mov %0, %%cr8" : : "r" (val) : "memory");
+}
+
 static inline void set_idt(const struct desc_ptr *idt_desc)
 {
 	__asm__ __volatile__("lidt %0"::"m"(*idt_desc));
diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index 86ad1c7d068f..8bd37a476f15 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -13,6 +13,30 @@
 #include "linux/psp-sev.h"
 #include "sev.h"
 
+static void guest_sev_test_msr(uint32_t msr)
+{
+	uint64_t val = rdmsr(msr);
+
+	wrmsr(msr, val);
+	GUEST_ASSERT(val == rdmsr(msr));
+}
+
+#define guest_sev_test_reg(reg)			\
+do {						\
+	uint64_t val = get_##reg();		\
+						\
+	set_##reg(val);				\
+	GUEST_ASSERT(val == get_##reg());	\
+} while (0)
+
+static void guest_sev_test_regs(void)
+{
+	guest_sev_test_msr(MSR_EFER);
+	guest_sev_test_reg(cr0);
+	guest_sev_test_reg(cr3);
+	guest_sev_test_reg(cr4);
+	guest_sev_test_reg(cr8);
+}
 
 #define XFEATURE_MASK_X87_AVX (XFEATURE_MASK_FP | XFEATURE_MASK_SSE | XFEATURE_MASK_YMM)
 
@@ -24,6 +48,8 @@ static void guest_snp_code(void)
 	GUEST_ASSERT(sev_msr & MSR_AMD64_SEV_ES_ENABLED);
 	GUEST_ASSERT(sev_msr & MSR_AMD64_SEV_SNP_ENABLED);
 
+	guest_sev_test_regs();
+
 	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
 	vmgexit();
 }
@@ -34,6 +60,8 @@ static void guest_sev_es_code(void)
 	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ENABLED);
 	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ES_ENABLED);
 
+	guest_sev_test_regs();
+
 	/*
 	 * TODO: Add GHCB and ucall support for SEV-ES guests.  For now, simply
 	 * force "termination" to signal "done" via the GHCB MSR protocol.
@@ -47,6 +75,8 @@ static void guest_sev_code(void)
 	GUEST_ASSERT(this_cpu_has(X86_FEATURE_SEV));
 	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ENABLED);
 
+	guest_sev_test_regs();
+
 	GUEST_DONE();
 }
 
-- 
2.53.0.473.g4a7958ca14-goog

