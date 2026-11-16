Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794868242;
	b=uDyGPAlIp57U+ilK31iUvmFcRdSEWDnCDAH4Enj5GV5ulKg1W2J4sLTu3LHA/KYHhsW7
	 3fXLag65nlcmiZ0BQLHEiGUWQYaptRU4RH0Ioy0cyaZpEj6+r+JA2I7K0gIFrasVxvflY
	 LgKtcikVTgRcpW1NSKrRoWNLSVOmF3vB2Qb/niI70SSA/VLoYWSWzv37eEs5w2F30k7Dw
	 VU6ocqqngOoP3lg/9x76h/9IkKOHn3YLO2MssA1XbFG4gxZ89Ktj6/PzUYE9nPQ2iKein
	 tBUsxzc60MgfI86iSbvxa8sRP1mSR+iahZdtIauaZZeA81C02z72qxzVELR+dnlV05g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794868242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5atNcJoBdEtptme6+SR91pcU1M0d4t/oMezPf2d482w=;
	b=4jCdcUtq+kfKk+4htbfhwTvvn8lxQJs0i+8uo+V0pPbhQLXlP3jwoCpkVE7dL+gMqdbU
	 BvC7JiQcSpjPCfCtzY9bu5fC8lQ374HgcRq2k7I82/kqMHk46hnaPJqwVxU4VZjME0axM
	 7LJcb8ZmLa2EmL7fVx83gdjvBhLPBtaT5+py5G+AlIjJirNV54N2YeFrG+Abw7rHX6Cyn
	 +SkpisReJcws6kozDQz2mvQOxtpDR1mfCTc3yTyLWEozX1d+7dY3baIg8HppBY4GfsZTY
	 zg/Qdtenmj2RB0JJH85blvf4f2ZO9jgnSYTaQKvnG3ecza5dk689vljfDMxyX7/DyPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="r/IJKTnJ";
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C263606A8A1
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 22:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C263606A8A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r/IJKTnJ
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso1724930a12.1
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 14:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794868241; x=1795473041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5atNcJoBdEtptme6+SR91pcU1M0d4t/oMezPf2d482w=;
        b=r/IJKTnJGlY99qpX6VddAxkL5v4GeQ1yIpdA9HfLMjKMsL094Rvfx5OXB8Dtjkh5Yx
         sfX84FtrkYmcY9vDcpic83FrjRXw69vCiSjlFsbAbowH2WMVU2KwcqYTeEX3Nm733Op9
         NKK6MaCUD9hl0KLTXdLRF9ZM9cu8g8jBciU/4f9j2960V+3hHf01M3u5Ux3tYrVKB0tT
         52JMRj6xuKZ7eg2N4qXT7/Gydb4w6PIX2rSBIiZT4UywNScb3CZW7qTQDw02q5qCal8S
         TyStT+uYqIkV80iV/YYl+7+BzM+zL1jPzItU9zBWJATfjuk+YzXVjeXzG21V3iImpnDR
         X7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794868241; x=1795473041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5atNcJoBdEtptme6+SR91pcU1M0d4t/oMezPf2d482w=;
        b=0qzK8ZzgHFmhN9JlxP8sJYBaM+7y1ZmBLZ0xxwptSd7hrMNg+7Amu3HYx1CzBZSU94
         qO27nhvsh6ZdWl4Dx9q9Zro1l6o1lUOMUMuU7kfD6w88t3flcTMx4YkzhRy1KRRoZL7i
         2vaa4WPT3sYut+Qgsf4zZlNrhMb4HarUEMKo/Nm5KZruPyp5iT8xFZjPSCypMEuDcjI5
         sSZuhpbdTqu0SKj8dsRZ33R2nfX5TH3hBevr05b76eUA1u+LU08Eszobxa6S7pves4E6
         Cukw1uDlovtfWZfLiwwpdwbvXOSRmWy7jy7rDMPSjVTt4ADkVeI/uQ1xH0WYAs6rpQ7W
         ZnVQ==
X-Gm-Message-State: APuU4Z+NlN6Q+sFeI6pdQibOqWbAMn+rrkCHMbyN6mffBoe3D5G+ygmh
	QPkzUY5V4eJ2hwxacTbnYvPck1jhwoedQUmc7f/YRDKvocReit71Lgr4
X-Gm-Gg: AZFdTZenKNk7JU7NRF086ILKOQ8ddlXBKhPQsaRDsIRSJF1r1BLKya1cVQgIzmdVtyi
	QVJt6U95NY0o8rROcM7W+uGjhpkpp4CLCHxUdZ95KDjrmnchFKGTJiOLUOEqnUS02PmDZJDHpP0
	b070PEO3elP0P9j8FgyvZ/Oju8QIYgoRxoYZU1a1OSuTlxXVkC8PyipbR4E0esYmWt46JwFMBEt
	84qs9N4lqzwKSVdsHa8y2JMslBClVqvcjDTpu4L7OxFsHc+zbahW842M8YBjbZgM11ETuxUzW5s
	Ig/zEzZQlj0iOa3CwAsNNMG8NNMUvsfHQsbR/Vh7bpQ3ytvEtMf+YofOJOxGuBoHrXI94yGqQmt
	tSn5pEMMGqUIAs5NULdjHIgNmlhoXr1/U7on60t2MU9YcsqyO1jFL9hSB+0MmsKJB3GlXyzVbGM
	Rr1urDZbiMr9g7ppBZa6WbgANwDP8skI0QG4wvu8TzU+SF+nSjBA73D6hEdGc0uhOQ3c7HCAjx7
	34hkYnotr2tjoczOPwRda+5t5JUcBbO2Q6MEh6mEoRuwKjptp9zJ4srLKFDbawXkpNBl5KG6+CU
	8MHQH5djnyudcmiTBKop52XnDL4d2APn+F87wgSHPivwJT9k3lIiji7ueSDk3dchP297jGTzakf
	3zJoEnscqyVlD9NoqtyI7rcYyEFBlhykRyXeKfSylK4uU/rYyHBCucw8RSnw70EMJS+3Qng0=
X-Received: by 2002:a17:90b:5546:b0:3b0:9e2c:9b61 with SMTP id 98e67ed59e1d1-3b1b0a46d3emr10963616a91.35.1794868240317;
        Mon, 16 Nov 2026 14:30:40 -0800 (PST)
Received: from cs-arch-srv04.cmpt.sfu.ca (cs-arch-srv04.cmpt.sfu.ca. [142.58.10.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac255634sm944375a91.5.2026.11.16.14.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:30:39 -0800 (PST)
From: Mahmoud Abumandour <ma.mandourr@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mahmoud Abumandour <ma.mandourr@gmail.com>
Subject: [PATCH v3 3/3] KVM: selftests: Verify nested VM-Exits while vectoring INT3 and INTn
Date: Mon, 16 Nov 2026 14:30:33 -0800
Message-Id: <20261116223033.3866283-4-ma.mandourr@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261116223033.3866283-1-ma.mandourr@gmail.com>
References: <20261116223033.3866283-1-ma.mandourr@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Verify that a VM-Exit while L2 is vectoring INT3 or INTn through the
empty IDT reports the event and its instruction length, and leaves the
VM-Entry instruction length alone. Only VMX is tested, as both lengths
are VMX fields.

Signed-off-by: Mahmoud Abumandour <ma.mandourr@gmail.com>
---
 .../kvm/x86/nested_exceptions_test.c          | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
index e83c1f4170..26dbd8cdbf 100644
--- a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
@@ -40,12 +40,25 @@
 #define GP_ERROR_CODE_INTEL ((SS_VECTOR * 8) | ERROR_CODE_IDT_FLAG | ERROR_CODE_EXT_FLAG)
 #define GP_ERROR_CODE_ZHAOXIN ((SS_VECTOR * 8) | ERROR_CODE_IDT_FLAG)
 
+/* No "External event" flag, as INT3 and INTn are software events. */
+#define GP_ERROR_CODE_SOFT_INT(vector) (((vector) * 8) | ERROR_CODE_IDT_FLAG)
+
 /*
  * Intel and AMD both shove '0' into the error code on #DF, regardless of what
  * led to the double fault.
  */
 #define DF_ERROR_CODE 0
 
+/* Arbitrary, any vector #GPs with the empty IDT. */
+#define INTN_VECTOR		0x40
+
+#define INTR_INFO_VALID_MASK		BIT(31)
+#define INTR_TYPE_SOFT_INTR		(4 << 8)
+#define INTR_TYPE_SOFT_EXCEPTION	(6 << 8)
+
+/* Arbitrary, but not the length of INT3 or INTn. */
+#define VM_ENTRY_INSN_LEN	7
+
 #define INTERCEPT_SS		(BIT_ULL(SS_VECTOR))
 #define INTERCEPT_SS_DF		(INTERCEPT_SS | BIT_ULL(DF_VECTOR))
 #define INTERCEPT_SS_GP_DF	(INTERCEPT_SS_DF | BIT_ULL(GP_VECTOR))
@@ -70,6 +83,16 @@ static void l2_ss_injected_tf_test(void)
 	GUEST_SYNC(FAKE_TRIPLE_FAULT_VECTOR);
 }
 
+static void l2_int3_test(void)
+{
+	asm volatile("int3");
+}
+
+static void l2_intn_test(void)
+{
+	asm volatile("int $" __stringify(INTN_VECTOR));
+}
+
 static void svm_run_l2(struct svm_test_data *svm, void *l2_code, int vector,
 		       u32 error_code)
 {
@@ -172,6 +195,18 @@ static void vmx_run_l2(void *l2_code, int vector, u32 error_code)
 	GUEST_ASSERT(!vmread(GUEST_INTERRUPTIBILITY_INFO));
 }
 
+static void vmx_run_l2_soft_int(void *l2_code, u32 type, int vector,
+				u32 insn_len)
+{
+	vmwrite(VM_ENTRY_INSTRUCTION_LEN, VM_ENTRY_INSN_LEN);
+	vmx_run_l2(l2_code, GP_VECTOR, GP_ERROR_CODE_SOFT_INT(vector));
+
+	GUEST_ASSERT_EQ(vmread(IDT_VECTORING_INFO_FIELD),
+			INTR_INFO_VALID_MASK | type | vector);
+	GUEST_ASSERT_EQ(vmread(VM_EXIT_INSTRUCTION_LEN), insn_len);
+	GUEST_ASSERT_EQ(vmread(VM_ENTRY_INSTRUCTION_LEN), VM_ENTRY_INSN_LEN);
+}
+
 static void l1_vmx_code(struct vmx_pages *vmx)
 {
 	unsigned long cr0;
@@ -193,6 +228,10 @@ static void l1_vmx_code(struct vmx_pages *vmx)
 	vmx_run_l2(l2_ss_injected_gp_test, GP_VECTOR,
 		   host_cpu_is_zhaoxin ? GP_ERROR_CODE_ZHAOXIN : GP_ERROR_CODE_INTEL);
 
+	/* INT3 and INTn also #GP, due to the empty IDT. */
+	vmx_run_l2_soft_int(l2_int3_test, INTR_TYPE_SOFT_EXCEPTION, BP_VECTOR, 1);
+	vmx_run_l2_soft_int(l2_intn_test, INTR_TYPE_SOFT_INTR, INTN_VECTOR, 2);
+
 	vmwrite(EXCEPTION_BITMAP, INTERCEPT_SS_DF);
 	vmx_run_l2(l2_ss_injected_df_test, DF_VECTOR, DF_ERROR_CODE);
 
-- 
2.25.1

