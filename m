Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793396276;
	b=Mu/s0ugL1ZRIOOZv1HRGvJ4BukbwXl95IodvKMX/b0uBqIoFhhACGGb1FmNJawEl/GML
	 5iDCL7z+FujfRoXKJ12dx3ldndT2zsSPFmNYtcrAcNTyJsX4E8C+v+LIVlJFaasm5iDxp
	 8PiJKHyELfR1kZzyiFfvWeEtoKReSOSW5UnJJKhLHld9T/upEzeYCP73ZPXjForca6kgT
	 GzbniLdvrQHDH3mr3iY05y6kBPxjml42tPNt6sCQTuqpPUm4DZfCTqR3BvAoKN5PYBvkd
	 YO0rivsowLNg/Rgd4/iKtZkuf5d+Ux11igyzU1ZQuwCL9zdrBGk9CmTkKfs4fpSnxSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793396276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Reply-To:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=E7HZ4wC4+K8HOqXkfuQZ8aAkOprR4TOij0W58WTuCRM=;
	b=SkQ0Gr7WCIkH2S5+XNy7TrlBrzfapapvWCv+qLxf9aT8KoBAYMX9ImZ/Lg9i7vw++zPV
	 6ylzWa94znZmClgKuDcU9v9HcKb2MAgkwjrYVazOeFHppOSKHdP7Ao6Zahc8/dORCeamw
	 tqFW1Vk3LkgmOvlyY/V+xmftKp/RtjnefPVx5nA6Uygo0Nfb1DA+sZEQoThZHbpYdB2jc
	 Oymh1Goq3LQGUb0SER2lTnZ/mVRHgIqV9VZrzLplzTejuWxHKmk4Ym15KdWdoA1fooJmI
	 V+iQM8QPhQBdNtuNzdHb/+joTveek4uuOP4cxwwuwyELU5l/ief0yr5nOP7Dh6ei1Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M2WXBWVf;
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3393A60A2609
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3393A60A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=M2WXBWVf
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-89f84753b43so847930b3a.1
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793396276; x=1794001076; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=E7HZ4wC4+K8HOqXkfuQZ8aAkOprR4TOij0W58WTuCRM=;
        b=M2WXBWVfQnzoYtkEiq4qRiUEB80cqDxbGVORrPlRrQdg5ECEQJ+c6YUu1Y1KTM8vS9
         tLFjJ7tILed7bh/ZK+jGkOhcv4P4nUOtVnw2+IktaKhTswdiXsCNE2CjY0ugTzOJpaWQ
         rRwHzzDu4Uqp38Opt50xqagv5mteQXM5XWEk7BCgyehgzQRgdXwhJ6z2S5uyXERFHnJJ
         HnfhrOJZpAoinktGcy0Ef2u+Lop4vgCuK/AjAr8ZevD7gm+vALhT+5S2jL3vbi4jdEXe
         YypnDpjaK4hGZ33GrbS2sDyzYoSzx35baOlbZN7ZRfMOwmXQmKCO/t3av/FRsj7RaOgf
         Pi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793396276; x=1794001076;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E7HZ4wC4+K8HOqXkfuQZ8aAkOprR4TOij0W58WTuCRM=;
        b=eQY/Ak9GI2C5nNye2Swd26jicdlrs+U8mICatQMHAefYC5+SILG7Q9WnLZpzhXgXU5
         MqT2VzfmwVP+9hNCSd7kdgG/D/+/CH6nCY1mtLWBwF+/UMgZxHpQzHx9y69T11YiWePZ
         nUVt1LEQRaq2OonaFTtwMt3SRpKZ4nU8Qn2A1iWE6fa2zp4hj5ODhYYo9FMIXapRWUYV
         HJvZcpOdFWU5A/oCL/CbScVBswlN5UKIhTyGtyDBR7sqwRAnFCahLFUQpLwmDCQMCQo/
         jJhAVsAiz2SkjAePT3GgZDrvq6tbE9Dw6t1oVUkF61tDaAbkpR4Wo9OJ7fMSZP7BCk5A
         hrHg==
X-Gm-Message-State: AFq9FYLSGfT3x5jjuGviz1kqCr8LTzD0VcDmmlEwAdOSUi1ToZJAR2xc
	TO5IbWN1ZUWorX4DCysB7ARZPLvqrSKC/XHmzJ6U1o1xC7jIIwfjfVVd546BUhdAYskJklAQQmm
	ObCpveg==
X-Received: from pfst39.prod.google.com ([2002:aa7:8fa7:0:b0:884:7cdd:23d1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3c90:b0:880:4b56:dc2c
 with SMTP id d2e1a72fcca58-8a9bdcc679cmr2516978b3a.34.1793396275335; Fri, 30
 Oct 2026 14:37:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:37:47 -0700
In-Reply-To: <20261030213747.2611815-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030213747.2611815-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030213747.2611815-6-seanjc@google.com>
Subject: [PATCH v3 5/5] KVM: selftests: Verify KVM handling of L1-owned CR0
 bits on writes from L2
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mahmoud Abumandour <ma.mandourr@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Mahmoud Abumandour <ma.mandourr@gmail.com>

Expand the nested exceptions test to verify KVM's handling of VMX's CR0
guest/host masks, i.e. of VMX's conditional interception of CR0 writes.
LMSW in particular is nasty, as it preserves bits 31:4 as well as CR0.PE
if it was already set.

Verify that MOV CR0 and LMSW in L2 that exits to L0, i.e. isn't intercepted
by L1, doesn't modify an L1-owned bits and reads the correct value from the
read shadow.  Use CR0.TS to do the bulk of validation, as its value in
hardware can be easily inferred by triggering an #NM in L2.  Specifically,
run with CR0.TS=1 in hardware but CR0.TS=0 in the read shadow, and verify
that non-intercepted writes to CR0 from L2 preserve the CR0.TS values in
hardware *and* the shadow.

Note, the downside of using CR0.TS is that any SIMD instructions in L2 will
hit a #NM, which is especially problematic since ucall(), e.g. for guest
prints and asserts, includes a memset(), for which the compiler likes to
generate SSE instructions.  To avoid false passes and false failures, have
L2 snapshot the CR0 it sees, but do the actual validation in L1.  E.g. if
L2 observed the wrong value, then doing GUEST_ASSERT_EQ() could get a false
pass as memset() would trigger the #NM expected by L1 (when L2 is trying to
report the failure).

Include CR0.NE and CR0.PE in the divergent shadow/hardware values as well
for extra coverage, e.g. CR0.NE is a must-be-1 bit, and CR0.PE is preserved
by LMSW, but if and only if it's already '1'.

Signed-off-by: Mahmoud Abumandour <ma.mandourr@gmail.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86/processor.h     |  5 ++
 .../kvm/x86/nested_exceptions_test.c          | 73 +++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 5898a277a2e0..79c4b502b00c 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -617,6 +617,11 @@ static inline void set_cr0(u64 val)
 	__asm__ __volatile__("mov %0, %%cr0" : : "r" (val) : "memory");
 }
 
+static inline void lmsw(u8 val)
+{
+	__asm__ __volatile__("lmsw %w0" : : "r" (val) : "memory");
+}
+
 static inline u64 get_cr2(void)
 {
 	u64 cr2;
diff --git a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
index f47432526ea1..e83c1f41703d 100644
--- a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
@@ -109,6 +109,51 @@ static void l1_svm_code(struct svm_test_data *svm)
 	GUEST_DONE();
 }
 
+static u64 l2_cr0;
+
+static void l2_vmx_cr0_test(bool use_lmsw)
+{
+	/*
+	 * DANGER!!!  DO NOT add anything that might cause the compiler to emit
+	 * a "string" operation, e.g. memset().  Compilers often generate SIMD
+	 * instructions for memset() and friends, and so will hit an #NM due to
+	 * CR0.TS being set in hardware.  Note, all ucalls trigger memset()!
+	 */
+	u64 cr0 = (get_cr0() ^ X86_CR0_MP);
+
+	if (use_lmsw)
+		lmsw(cr0);
+	else
+		set_cr0(cr0);
+
+	/*
+	 * Snapshot CR0 and let L1 check the value; as above, attempting to use
+	 * GUEST_ASSERT_EQ() => ucall will likely trigger a premature #NM and
+	 * result in a false pass (L1 will see the #NM and think all is well).
+	 */
+	l2_cr0 = get_cr0();
+
+	/* FNOP should #NM as CR0.TS is set vmcs12.CR0 and thus vmcs02. */
+	asm volatile("fnop" ::: "memory");
+
+	/*
+	 * Signal failure with a #UD, again to avoid ucall/memset().  If FNOP
+	 * somehow succeeds but then #NM is triggered by a SIMD instruction in
+	 * memset(), the test will get a false pass.
+	 */
+	asm volatile("ud2");
+}
+
+static void l2_mov_cr0_test(void)
+{
+	l2_vmx_cr0_test(false);
+}
+
+static void l2_lmsw_test(void)
+{
+	l2_vmx_cr0_test(true);
+}
+
 static void vmx_run_l2(void *l2_code, int vector, u32 error_code)
 {
 	vmwrite(GUEST_RIP, (u64)l2_code);
@@ -129,6 +174,8 @@ static void vmx_run_l2(void *l2_code, int vector, u32 error_code)
 
 static void l1_vmx_code(struct vmx_pages *vmx)
 {
+	unsigned long cr0;
+
 	prepare_for_vmx_operation(vmx);
 
 	load_vmcs(vmx);
@@ -153,6 +200,32 @@ static void l1_vmx_code(struct vmx_pages *vmx)
 	vmx_run_l2(l2_ss_injected_tf_test, FAKE_TRIPLE_FAULT_VECTOR, 0);
 	GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_TRIPLE_FAULT);
 
+	/*
+	 * Validate KVM's CR0 mask+shadow emulation, for both MOV CR and LMSW.
+	 * Set TS and NE in the value loaded in hardware, to verify that doing
+	 * e.g. FNOP generates an #NM in L2, but clear the bits in L2's read
+	 * shadow and verify that L2 always sees '0' and can't set those bits.
+	 */
+	cr0 = vmread(GUEST_CR0) | X86_CR0_TS | X86_CR0_NE;
+	vmwrite(CR0_GUEST_HOST_MASK, X86_CR0_TS | X86_CR0_NE | X86_CR0_PE);
+	vmwrite(CR0_READ_SHADOW, cr0 & ~(X86_CR0_TS | X86_CR0_NE));
+	vmwrite(GUEST_CR0, cr0);
+	vmwrite(EXCEPTION_BITMAP, BIT_ULL(NM_VECTOR));
+
+	vmx_run_l2(l2_mov_cr0_test, NM_VECTOR, 0);
+	GUEST_ASSERT_EQ(l2_cr0, (cr0 & ~(X86_CR0_TS | X86_CR0_NE)) ^ X86_CR0_MP);
+	GUEST_ASSERT_EQ(vmread(GUEST_CR0), cr0 ^ X86_CR0_MP);
+
+	/*
+	 * LMSW preserves CR0.PE *if* CR0.PE=1.  Clear the bit in the shadow to
+	 * validate that KVM preserves CR0.PE in "hardware" even if L2 attempts
+	 * to clear CR0.PE via LMSW.
+	 */
+	vmwrite(CR0_READ_SHADOW, cr0 & ~(X86_CR0_TS | X86_CR0_NE | X86_CR0_PE));
+	vmx_run_l2(l2_lmsw_test, NM_VECTOR, 0);
+	GUEST_ASSERT_EQ(l2_cr0, cr0 & ~(X86_CR0_TS | X86_CR0_NE | X86_CR0_PE));
+	GUEST_ASSERT_EQ(vmread(GUEST_CR0), cr0);
+
 	GUEST_DONE();
 }
 
-- 
2.56.0.385.gac671c819a-goog

