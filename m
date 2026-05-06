Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B4D4963B3
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 18:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778093289; cv=none; b=G1bKk4+vdizyptG6Il+F+NcypYbq6arAfd3n5eqMBAQNHiDvlY7YQh27bUSuoL2SsbOv1HkPqAZQtimfnkakfpij3d0A1AnyNelfWx9YPWyiBy2ZIABPW7yUU2PnxB68zX3IKNqAlJavwtA/3Rxfu1NlFKONmPezv+IuHB5c7aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778093289; c=relaxed/simple;
	bh=rMIMJB8JzDNn3PuYuXxKZMHkLp+CM+YXysYSQ/hAPfU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J6dGQ9nCapmzMkzA9JsEa83fny1KYoiRVTtqXqnOxYcsNsUfrJBGJsv0sAkKvHRw7TF3WJMpDAiHWbtIDbILrarXTtycabGgB3GZbER2KydFFcxzhPJum1TBoT+ywSLq2A+VUo2p1kCwGhk4clc8orQ//s7OeV7hgdGwSvbT2pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iof/d07S; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iof/d07S"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-837d0d71c61so1695896b3a.1
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 11:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778093274; x=1778698074; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KvMyVkcWMbTxJ7Bd2nFyp3035fU2GDYEl6F9WaNhqqA=;
        b=Iof/d07S1L/qqUH6r7RuqDz5n5y04eV8/+jg9GuEbaLsvmPra2kDXDGFouh0DWpZwL
         DO7ucWZK9S6FR9b8drHBHOI0/D5LJPWRiGxheruLYx7yQIgveMiC2tIvMiYJzL9noY/U
         w/XtgcOs2gq44OZWDmvlPcXnabwje6DOBlC0+qggV82crf3NC53imBk1S6xvGxHqTLFo
         FULhAZwGvN9g5MiT/4bwgn76GQF5NV1IYobX9dm60UsCjK+o6h+b5QRm4JfuqPyLxFVo
         vDjl7DJvzrNIIRvLJZmAQooXpBhisABMYvm8TddRLVkZNWvIxUovzFkq21fUv9DtW7Ir
         FeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778093274; x=1778698074;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KvMyVkcWMbTxJ7Bd2nFyp3035fU2GDYEl6F9WaNhqqA=;
        b=VUdxEIHHXueLsQb801YXLy4fouGBsGxd2Amj/UV9LHVJ0Flocd4xQ+M+qctb7f2/RB
         YxQ5wPIdaf2GOYBx4sS7M8F/VjxFH1O/p0MgurIzhAgDFYOMne0VdU8lmz8c42zDgur7
         to8MQHkEX+kguGvsCcrG2eTT7VHD1pGqJB/oaMw6VWrY2r8Z1afXcDFQY0/sWEgcfVKQ
         mFkpGWMZL244zkIBrHtJyUFFSOX3TY3NaIcDUXakeFnAPV8dbGlUJtuNwIpvbtxBewjL
         CClxZ8LXK61biAeVPqhTwVz/w1IfWAiRrlwzbipulbFq6hWkaEdl70ZRE9DNcAtkqnPt
         Ygrg==
X-Gm-Message-State: AOJu0Yw4cJUHdQ2KbfO9xsWBtEOkK60RZlff/YAMsO/wyTP4HprZG7rI
	QTpQNwXe5aMSiwBCZgHfHvyS1oaN8R7zEu9Q2YuzrIQd9b9aTvZWEzTH83SARJhvked0bm4M9gg
	ocvy9MA==
X-Received: from pfbf4.prod.google.com ([2002:a05:6a00:ad84:b0:82f:96ee:b9ab])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:440e:b0:82c:215d:5e9d
 with SMTP id d2e1a72fcca58-83a5dc5acd2mr4633198b3a.32.1778093274070; Wed, 06
 May 2026 11:47:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 May 2026 11:47:46 -0700
In-Reply-To: <20260506184746.2719880-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506184746.2719880-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260506184746.2719880-6-seanjc@google.com>
Subject: [PATCH v2 5/5] *** DO NOT MERGE *** KVM: selftests: Add hacky test to
 verify x2APIC MSR interception
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Not-signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/x86/apic.h  |  84 ++++++-
 .../selftests/kvm/x86/fix_hypercall_test.c    |   2 +-
 .../selftests/kvm/x86/xapic_ipi_test.c        |   4 +-
 .../selftests/kvm/x86/xapic_state_test.c      | 217 ++++++++++++++++++
 4 files changed, 296 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/apic.h b/tools/testing/selftests/kvm/include/x86/apic.h
index 31887bdc3d6c..3c3e362f2b98 100644
--- a/tools/testing/selftests/kvm/include/x86/apic.h
+++ b/tools/testing/selftests/kvm/include/x86/apic.h
@@ -23,21 +23,64 @@
 
 #define APIC_BASE_MSR	0x800
 #define X2APIC_ENABLE	(1UL << 10)
+
+#define APIC_DELIVERY_MODE_FIXED	0
+#define APIC_DELIVERY_MODE_LOWESTPRIO	1
+#define APIC_DELIVERY_MODE_SMI		2
+#define APIC_DELIVERY_MODE_NMI		4
+#define APIC_DELIVERY_MODE_INIT		5
+#define APIC_DELIVERY_MODE_EXTINT	7
+
 #define	APIC_ID		0x20
+
 #define	APIC_LVR	0x30
-#define		GET_APIC_ID_FIELD(x)	(((x) >> 24) & 0xFF)
+#define		APIC_LVR_MASK		0xFF00FF
+#define		APIC_LVR_DIRECTED_EOI	(1 << 24)
+#define		GET_APIC_VERSION(x)	((x) & 0xFFu)
+#define		GET_APIC_MAXLVT(x)	(((x) >> 16) & 0xFFu)
+#ifdef CONFIG_X86_32
+#  define	APIC_INTEGRATED(x)	((x) & 0xF0u)
+#else
+#  define	APIC_INTEGRATED(x)	(1)
+#endif
+#define		APIC_XAPIC(x)		((x) >= 0x14)
+#define		APIC_EXT_SPACE(x)	((x) & 0x80000000)
 #define	APIC_TASKPRI	0x80
+#define		APIC_TPRI_MASK		0xFFu
+#define	APIC_ARBPRI	0x90
+#define		APIC_ARBPRI_MASK	0xFFu
 #define	APIC_PROCPRI	0xA0
-#define	GET_APIC_PRI(x) (((x) & GENMASK(7, 4)) >> 4)
-#define	SET_APIC_PRI(x, y) (((x) & ~GENMASK(7, 4)) | (y << 4))
+#define		GET_APIC_PRI(x) (((x) & GENMASK(7, 4)) >> 4)
+#define		SET_APIC_PRI(x, y) (((x) & ~GENMASK(7, 4)) | (y << 4))
 #define	APIC_EOI	0xB0
+#define		APIC_EOI_ACK		0x0 /* Docs say 0 for future compat. */
+#define	APIC_RRR	0xC0
+#define	APIC_LDR	0xD0
+#define		APIC_LDR_MASK		(0xFFu << 24)
+#define		GET_APIC_LOGICAL_ID(x)	(((x) >> 24) & 0xFFu)
+#define		SET_APIC_LOGICAL_ID(x)	(((x) << 24))
+#define		APIC_ALL_CPUS		0xFFu
+#define	APIC_DFR	0xE0
+#define		APIC_DFR_CLUSTER		0x0FFFFFFFul
+#define		APIC_DFR_FLAT			0xFFFFFFFFul
 #define	APIC_SPIV	0xF0
+#define		APIC_SPIV_DIRECTED_EOI		(1 << 12)
 #define		APIC_SPIV_FOCUS_DISABLED	(1 << 9)
 #define		APIC_SPIV_APIC_ENABLED		(1 << 8)
 #define	APIC_ISR	0x100
-#define APIC_IRR	0x200
+#define	APIC_ISR_NR     0x8     /* Number of 32 bit ISR registers. */
+#define	APIC_TMR	0x180
+#define	APIC_IRR	0x200
+#define	APIC_ESR	0x280
+#define		APIC_ESR_SEND_CS	0x00001
+#define		APIC_ESR_RECV_CS	0x00002
+#define		APIC_ESR_SEND_ACC	0x00004
+#define		APIC_ESR_RECV_ACC	0x00008
+#define		APIC_ESR_SENDILL	0x00020
+#define		APIC_ESR_RECVILL	0x00040
+#define		APIC_ESR_ILLREGA	0x00080
+#define 	APIC_LVTCMCI	0x2f0
 #define	APIC_ICR	0x300
-#define	APIC_LVTCMCI	0x2f0
 #define		APIC_DEST_SELF		0x40000
 #define		APIC_DEST_ALLINC	0x80000
 #define		APIC_DEST_ALLBUT	0xC0000
@@ -61,16 +104,41 @@
 #define		APIC_DM_EXTINT		0x00700
 #define		APIC_VECTOR_MASK	0x000FF
 #define	APIC_ICR2	0x310
-#define		SET_APIC_DEST_FIELD(x)	((x) << 24)
-#define APIC_LVTT	0x320
+#define		GET_XAPIC_DEST_FIELD(x)	(((x) >> 24) & 0xFF)
+#define		SET_XAPIC_DEST_FIELD(x)	((x) << 24)
+#define	APIC_LVTT	0x320
+#define	APIC_LVTTHMR	0x330
+#define	APIC_LVTPC	0x340
+#define	APIC_LVT0	0x350
 #define		APIC_LVT_TIMER_ONESHOT		(0 << 17)
 #define		APIC_LVT_TIMER_PERIODIC		(1 << 17)
 #define		APIC_LVT_TIMER_TSCDEADLINE	(2 << 17)
 #define		APIC_LVT_MASKED			(1 << 16)
+#define		APIC_LVT_LEVEL_TRIGGER		(1 << 15)
+#define		APIC_LVT_REMOTE_IRR		(1 << 14)
+#define		APIC_INPUT_POLARITY		(1 << 13)
+#define		APIC_SEND_PENDING		(1 << 12)
+#define		APIC_MODE_MASK			0x700
+#define		GET_APIC_DELIVERY_MODE(x)	(((x) >> 8) & 0x7)
+#define		SET_APIC_DELIVERY_MODE(x, y)	(((x) & ~0x700) | ((y) << 8))
+#define			APIC_MODE_FIXED		0x0
+#define			APIC_MODE_NMI		0x4
+#define			APIC_MODE_EXTINT	0x7
+#define	APIC_LVT1	0x360
+#define	APIC_LVTERR	0x370
 #define	APIC_TMICT	0x380
 #define	APIC_TMCCT	0x390
 #define	APIC_TDCR	0x3E0
-#define	APIC_SELF_IPI	0x3F0
+#define APIC_SELF_IPI	0x3F0
+#define		APIC_TDR_DIV_TMBASE	(1 << 2)
+#define		APIC_TDR_DIV_1		0xB
+#define		APIC_TDR_DIV_2		0x0
+#define		APIC_TDR_DIV_4		0x1
+#define		APIC_TDR_DIV_8		0x2
+#define		APIC_TDR_DIV_16		0x3
+#define		APIC_TDR_DIV_32		0x8
+#define		APIC_TDR_DIV_64		0x9
+#define		APIC_TDR_DIV_128	0xA
 
 #define APIC_VECTOR_TO_BIT_NUMBER(v) ((unsigned int)(v) % 32)
 #define APIC_VECTOR_TO_REG_OFFSET(v) ((unsigned int)(v) / 32 * 0x10)
diff --git a/tools/testing/selftests/kvm/x86/fix_hypercall_test.c b/tools/testing/selftests/kvm/x86/fix_hypercall_test.c
index 753a0e730ea8..ad61da99ee4c 100644
--- a/tools/testing/selftests/kvm/x86/fix_hypercall_test.c
+++ b/tools/testing/selftests/kvm/x86/fix_hypercall_test.c
@@ -63,7 +63,7 @@ static void guest_main(void)
 
 	memcpy(hypercall_insn, other_hypercall_insn, HYPERCALL_INSN_SIZE);
 
-	ret = do_sched_yield(GET_APIC_ID_FIELD(xapic_read_reg(APIC_ID)));
+	ret = do_sched_yield(GET_XAPIC_DEST_FIELD(xapic_read_reg(APIC_ID)));
 
 	/*
 	 * If the quirk is disabled, verify that guest_ud_handler() "returned"
diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
index 39ce9a9369f5..75b87f850abc 100644
--- a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
@@ -91,7 +91,7 @@ static void halter_guest_code(struct test_data_page *data)
 	verify_apic_base_addr();
 	xapic_enable();
 
-	data->halter_apic_id = GET_APIC_ID_FIELD(xapic_read_reg(APIC_ID));
+	data->halter_apic_id = GET_XAPIC_DEST_FIELD(xapic_read_reg(APIC_ID));
 	data->halter_lvr = xapic_read_reg(APIC_LVR);
 
 	/*
@@ -147,7 +147,7 @@ static void sender_guest_code(struct test_data_page *data)
 	 * set data->halter_apic_id.
 	 */
 	icr_val = (APIC_DEST_PHYSICAL | APIC_DM_FIXED | IPI_VECTOR);
-	icr2_val = SET_APIC_DEST_FIELD(data->halter_apic_id);
+	icr2_val = SET_XAPIC_DEST_FIELD(data->halter_apic_id);
 	data->icr = icr_val;
 	data->icr2 = icr2_val;
 
diff --git a/tools/testing/selftests/kvm/x86/xapic_state_test.c b/tools/testing/selftests/kvm/x86/xapic_state_test.c
index 637bb90c1d93..3c7c6a5485e4 100644
--- a/tools/testing/selftests/kvm/x86/xapic_state_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_state_test.c
@@ -222,6 +222,221 @@ static void test_x2apic_id(void)
 	kvm_vm_free(vm);
 }
 
+#define X2APIC_MSR(r) (0x800 + ((r) >> 4))
+
+static bool is_x2apic_mode = true;
+
+static bool is_ro_only_reg(int reg)
+{
+	switch (reg) {
+	case APIC_ID:
+	case APIC_LVR:
+	case APIC_PROCPRI:
+	case APIC_LDR:
+	case APIC_ARBPRI:
+	case APIC_ISR:
+	case APIC_TMR:
+	case APIC_IRR:
+	case APIC_TMCCT:
+		return true;
+	}
+	return false;
+}
+
+static bool is_xapic_only_reg(int reg)
+{
+	return reg == APIC_ARBPRI || reg == APIC_DFR || reg == APIC_ICR2;
+}
+
+static bool is_accelerated_reg(int reg, bool write)
+{
+	if (!write)
+		return reg != APIC_TMCCT;
+
+	switch (reg) {
+	case APIC_TASKPRI:
+	case APIC_EOI:
+	case APIC_SELF_IPI:
+	case APIC_ICR:
+		return true;
+	default:
+		break;
+	}
+	return false;
+}
+
+static void x2apic_msr_guest_code(void)
+{
+	const u32 xapic_regs[] = {
+		APIC_ID,
+		APIC_LVR,
+		APIC_TASKPRI,
+		APIC_PROCPRI,
+		APIC_LDR,
+		APIC_SPIV,
+		APIC_ISR,
+		APIC_TMR,
+		APIC_IRR,
+		APIC_ESR,
+		APIC_LVTT,
+		APIC_LVTTHMR,
+		APIC_LVTPC,
+		APIC_LVT0,
+		APIC_LVT1,
+		APIC_LVTERR,
+		APIC_TMICT,
+		APIC_TMCCT,
+		APIC_TDCR,
+
+		// APIC_EOI,
+		// APIC_SELF_IPI,
+		// APIC_ICR,
+
+		APIC_ARBPRI,
+		APIC_DFR,
+		APIC_ICR2,
+	};
+	int i, j;
+	u64 val;
+	u32 msr;
+	u8 vec;
+
+	cli();
+
+	if (is_x2apic_mode)
+		x2apic_enable();
+
+	GUEST_SYNC(0xbeef);
+
+	for (i = 0; i < ARRAY_SIZE(xapic_regs); i++) {
+		int nr_regs;
+		u8 rd, wr;
+
+		if (!is_x2apic_mode || is_xapic_only_reg(xapic_regs[i])) {
+			rd = wr = GP_VECTOR;
+		} else {
+			rd = 0;
+			wr = is_ro_only_reg(xapic_regs[i]) ? GP_VECTOR : 0;
+		}
+
+		if (xapic_regs[i] == APIC_IRR ||
+		    xapic_regs[i] == APIC_ISR ||
+		    xapic_regs[i] == APIC_TMR)
+			nr_regs = APIC_ISR_NR;
+		else
+			nr_regs = 1;
+
+		for (j = 0; j < nr_regs; j++) {
+			msr = X2APIC_MSR(xapic_regs[i] + j * 0x10);
+
+			vec = rdmsr_safe(msr, &val);
+			__GUEST_ASSERT(vec == rd,
+				       "Wanted %s on RDMSR(%x), got %s",
+				       ex_str(rd), msr, ex_str(vec));
+			GUEST_SYNC3(xapic_regs[i], false, vec);
+
+			vec = wrmsr_safe(msr, 0);
+			__GUEST_ASSERT(vec == wr,
+				       "Wanted %s on WRMSR(%x), got %s",
+				       ex_str(wr), msr, ex_str(vec));
+
+			GUEST_SYNC3(xapic_regs[i], true, vec);
+		}
+	}
+	GUEST_DONE();
+}
+
+static void test_x2apic_msr_intercepts(void)
+{
+	u64 last_guest, last_io, last_msr, guest_exits, io_exits, msr_exits;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	vm = vm_create_with_one_vcpu(&vcpu, x2apic_msr_guest_code);
+
+	TEST_ASSERT_EQ(vcpu_get_stat(vcpu, guest_induced_exits), 0);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_SYNC);
+
+	for ( ;; ) {
+		last_guest = vcpu_get_stat(vcpu, guest_induced_exits);
+		last_io = vcpu_get_stat(vcpu, io_exits);
+		last_msr = vcpu_get_stat(vcpu, msr_exits);
+
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		guest_exits = vcpu_get_stat(vcpu, guest_induced_exits);
+		io_exits = vcpu_get_stat(vcpu, io_exits);
+		msr_exits = vcpu_get_stat(vcpu, msr_exits);
+
+		TEST_ASSERT_EQ(io_exits, last_io + 1);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_SYNC: {
+			int vector = uc.args[2];
+			bool write = uc.args[1];
+			u32 reg = uc.args[0];
+
+			printf("reg = %x, write = %u, fault = %u\n", reg, write, vector);
+			if (vector || !is_accelerated_reg(reg, write)) {
+				TEST_ASSERT_EQ(msr_exits, last_msr + 1);
+				TEST_ASSERT_EQ(guest_exits - last_guest,
+					       io_exits - last_io + msr_exits - last_msr);
+			} else {
+				TEST_ASSERT_EQ(msr_exits, last_msr);
+				TEST_ASSERT_EQ(guest_exits - last_guest,
+					       io_exits - last_io);
+			}
+			// printf("On msr = %x\n", msr);
+			break;
+		}
+		case UCALL_DONE:
+			goto test_xapic;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		}
+	}
+
+test_xapic:
+	kvm_vm_free(vm);
+
+	vm = vm_create_with_one_vcpu(&vcpu, x2apic_msr_guest_code);
+	vcpu_clear_cpuid_feature(vcpu, X86_FEATURE_X2APIC);
+	is_x2apic_mode = false;
+	sync_global_to_guest(vm, is_x2apic_mode);
+
+	for ( ;; ) {
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		// vcpu_get_stat(vcpu, io_exits);
+		// vcpu_get_stat(vcpu, msr_exits);
+		// vcpu_get_stat(vcpu, guest_induced_exits);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_SYNC:
+			// u32 msr = uc.args[1];
+
+			// printf("On msr = %x\n", msr);
+			break;
+		case UCALL_DONE:
+			goto done;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		}
+	}
+done:
+}
+
 int main(int argc, char *argv[])
 {
 	struct xapic_vcpu x = {
@@ -230,6 +445,8 @@ int main(int argc, char *argv[])
 	};
 	struct kvm_vm *vm;
 
+	test_x2apic_msr_intercepts();
+
 	vm = vm_create_with_one_vcpu(&x.vcpu, x2apic_guest_code);
 	test_icr(&x);
 	kvm_vm_free(vm);
-- 
2.54.0.545.g6539524ca2-goog

