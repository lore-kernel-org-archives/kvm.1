Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB387388E66
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776720014; cv=none; b=gutPwl6YkDSfUcdLgUHCmyC2Io+349X51nDSOZUCZnhc2xPGlcdsJphxj8juFlOhA2Il4zGxQwW7nvTzFIoDTE3ciDrAcrwOgsJsEHTc0ys2S8HI6SfzXHnpo0EE3RlF2OeHhmeKuAyAPHJbKcKJFSRARAtdHlSP9xNvLlRHYX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776720014; c=relaxed/simple;
	bh=nfE8K5Wu/vbugdCgGfmuXxSc4u8oMhTZAmH8cfZgOX4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F0CgQq8LLYiffwurZncxCuFNOHrTXRZU92hMLtN9NKFSKiVoC2yj0Kj0VTIObE6LJxujL8DHpokyHxxBpqd9UZZIxov39ISpRvjlqRwYxcj41af5qRJZYmNoSwXZogHrjdWiFRGWtJWE2cz/GI32aoDkkKEWnKWdJBMilgGJ6wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tRO8LwII; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tRO8LwII"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa1c94b37so1754713b3a.0
        for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 14:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776720012; x=1777324812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=sEgidxfCrHeWAn/iqKdfWB4mQGqG7JFMt/kzEyBGoSw=;
        b=tRO8LwII5RyI0pRtJjQfLRiboZmdlSxkpGY8N5Qc5B7voPA2j28IIGoQQIMpCTCwBC
         +h4dTKIaieFo0Zfbfh5ri2P0AiU+8ZixMgPpDKWT7QQBqIvGOmKbWSMtHtVa9Xu+S24b
         w9/+Wc1yth2fy9uoyZGMbEfB1Lloj/F8d1L/hnzodCAdCkzUCFoD6WZVYxDJh+DUIR6f
         JSEE36kEgixE5cYB1Y7Pa0+rwPeSmq0f0dgIUp0YE9yVrzGsqd5R8xnQ7u3ResI+SO+a
         E/F2emIHz4p3A/jQlxuB/m34sY6IMT4zg4YJRR6Fx7XZkJcysnG1nk0Vvz0gXgK2sHDq
         0KQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776720012; x=1777324812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sEgidxfCrHeWAn/iqKdfWB4mQGqG7JFMt/kzEyBGoSw=;
        b=I+7PHjDh/MXo6GDvOxlYke/tJdutgmCc7E4savUWBLWNVAEbMCjTED0ju1t4q6+woR
         k2IcV1S+jk8JABJ+qo1d4v7V1GTS3CYswfsvRB9W1kuvddiin4t0ORd271XkWoVU285E
         Vcc42QIwZI/qXkyDT7ENvB/yL/SzhOidS6jcq39Yri4sfBP2j3dcZFpyjnJyFWvn2tK0
         iBrE25bt4r4yNeg5M13WgON8pZEiX5sV7ZNvDnXMHdnbuOe5ZHFAgUq6tC0zmcBW0jz4
         47Z1sf8Cy0+fCCNDTf+oO+fMxsWvQXYUX3wP+Gb0/CxITPZ58d6XoqE1r/5/yYFZSe2X
         H0UQ==
X-Gm-Message-State: AOJu0YzWcMkRIxdycIiJv+/G5k0YfQV2ExAetegmpN2ZejgN4mY0MhVu
	N1LRyHUKGsdk8xnHFdlBC7w/KIpw+OrEAPNaJ5Z6rpQ/M0dEaKCPuxdPUe+or69RJGIBMB4scRT
	ZNrVHow==
X-Received: from pfbli8.prod.google.com ([2002:a05:6a00:7188:b0:82f:54e9:c13e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:27ab:b0:82f:6eca:563e
 with SMTP id d2e1a72fcca58-82f8b573171mr11858630b3a.34.1776720011915; Mon, 20
 Apr 2026 14:20:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 20 Apr 2026 14:19:48 -0700
In-Reply-To: <20260420212004.3938325-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260420212004.3938325-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260420212004.3938325-4-seanjc@google.com>
Subject: [PATCH v3 03/19] KVM: selftests: Use gpa_t for GPAs in Hyper-V selftests
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Fix various Hyper-V selftests to use gpa_t for variables that contain
guest physical addresses, rather than gva_t.  In practice, the bugs are
benign as both gva_t and gpa_t are u64 typedefs, i.e. gpa_t and gva_t are
interchangeable from a functional perspective, the code is just confusing.

No functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
[sean: call out that both are u64 typedefs]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86/hyperv_evmcs.c    | 2 +-
 tools/testing/selftests/kvm/x86/hyperv_features.c | 2 +-
 tools/testing/selftests/kvm/x86/hyperv_ipi.c      | 6 +++---
 tools/testing/selftests/kvm/x86/hyperv_svm_test.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
index c2de5ac799ee..2d1733f9303a 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
@@ -76,7 +76,7 @@ void l2_guest_code(void)
 }
 
 void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
-		gva_t hv_hcall_page_gpa)
+		gpa_t hv_hcall_page_gpa)
 {
 #define L2_GUEST_STACK_SIZE 64
 	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
diff --git a/tools/testing/selftests/kvm/x86/hyperv_features.c b/tools/testing/selftests/kvm/x86/hyperv_features.c
index 1059fcc460e3..0360fa5915c0 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_features.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_features.c
@@ -82,7 +82,7 @@ static void guest_msr(struct msr_data *msr)
 	GUEST_DONE();
 }
 
-static void guest_hcall(gva_t pgs_gpa, struct hcall_data *hcall)
+static void guest_hcall(gpa_t pgs_gpa, struct hcall_data *hcall)
 {
 	u64 res, input, output;
 	uint8_t vector;
diff --git a/tools/testing/selftests/kvm/x86/hyperv_ipi.c b/tools/testing/selftests/kvm/x86/hyperv_ipi.c
index 7d648219833c..5369867efac3 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_ipi.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_ipi.c
@@ -45,13 +45,13 @@ struct hv_send_ipi_ex {
 	struct hv_vpset vp_set;
 };
 
-static inline void hv_init(gva_t pgs_gpa)
+static inline void hv_init(gpa_t pgs_gpa)
 {
 	wrmsr(HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
 	wrmsr(HV_X64_MSR_HYPERCALL, pgs_gpa);
 }
 
-static void receiver_code(void *hcall_page, gva_t pgs_gpa)
+static void receiver_code(void *hcall_page, gpa_t pgs_gpa)
 {
 	u32 vcpu_id;
 
@@ -85,7 +85,7 @@ static inline void nop_loop(void)
 		asm volatile("nop");
 }
 
-static void sender_guest_code(void *hcall_page, gva_t pgs_gpa)
+static void sender_guest_code(void *hcall_page, gpa_t pgs_gpa)
 {
 	struct hv_send_ipi *ipi = (struct hv_send_ipi *)hcall_page;
 	struct hv_send_ipi_ex *ipi_ex = (struct hv_send_ipi_ex *)hcall_page;
diff --git a/tools/testing/selftests/kvm/x86/hyperv_svm_test.c b/tools/testing/selftests/kvm/x86/hyperv_svm_test.c
index e0caf5ea14bd..54a1a6dad4d5 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_svm_test.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_svm_test.c
@@ -67,7 +67,7 @@ void l2_guest_code(void)
 
 static void __attribute__((__flatten__)) guest_code(struct svm_test_data *svm,
 						    struct hyperv_test_pages *hv_pages,
-						    gva_t pgs_gpa)
+						    gpa_t pgs_gpa)
 {
 	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
 	struct vmcb *vmcb = svm->vmcb;
-- 
2.54.0.rc1.555.g9c883467ad-goog

