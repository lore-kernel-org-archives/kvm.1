Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793330999;
	b=3b0/Vww6M8gkcSJaPSFwFmpeaatyBPO4xR+vikmlnomkPI0dhnooc1Kl+42EIYfwT3SC
	 qfKgCQoLgWVcr28oIvNBrNnpWBW+pO0+oLBkz87jPJYunD/gkRqmVBamlOeAp74O33Din
	 IEqSpggf3iZvaxms0nE1Q2/LAFfyvkRYz6TV8LOS626RhGx1R3Csqc1IC/2MzX7sREW6v
	 Jv6tL+MQy/0KOXG2XToPf2h0uw/qjqvmU40LwzsuRC+Vbrw8qOCnF6XfenM/mjcdlAeaw
	 eUxYdqP2nYqBg4a/kk+70Ag5GKDHK+MCzMP+FU+9PRYLWVOVS7WiIAIWuu1t9kpzCjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793330999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KlleBVM3i1uLVt+wBeFSTUPaEiDOxCnK0ld617cCPMg=;
	b=5W4bP2h/p4mMBrfADdofMnqJxNdOSsUvRPdKsG1oNfaMsCHcUAFI6Ti34qhyNBdn6AJ3
	 gyH4tn/nAgY8HR7lEx/xrIp8Zhb1h8T2tbEI5xS7FU5uVhBbHmwxh9W0tlFemSSjt0raT
	 arlXe+F+Wf851yuPYLhUj43/RwPjzh75cDrpMLvxKu0Eh8r7QfIQcWDM1lUD1d5FChx0i
	 ky9kl7oWaB93ntFL1aSVPg3O5u3cgXOGXQ4VgxPDuoxQ2ZifHStfeLoyExjsWM8ZIq1FP
	 L7ycJUtT8Xm6V/Q1FRapOKUk4nDMydJQlPwK7g4sMXOAqZCUVOXoUa1j4bHYdvqeMpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YklNh9K3;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B55606A31D
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 03:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83B55606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YklNh9K3
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a070755c8cso78041b3a.0
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 20:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793330994; x=1793935794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KlleBVM3i1uLVt+wBeFSTUPaEiDOxCnK0ld617cCPMg=;
        b=YklNh9K3MNu4Vqr2OGSUyszMcNshYyCz+G4TnKQ583DrOxN09+x+RB20wf41XXl7v5
         AT+hhJGPZtMQQYR8hGbDqZzZmKnQ9YH5RWY1ez44ZBV4tLQZzugxpslI0YNEP0TUeVPA
         6S2aytsLc0XFTZw7+9Ea7eYhjadLfrrMU9WcYVSsQM0Ixi6pcJvZF9WiHGDTb9tctyQo
         Aj1skvWVWD0KPpFVFFCSQWGhhAN5VqO+HorNghoGkyjCG6DCEKVoaFcOAlFGk77Oi57P
         zgL87C5KlyDPRd/ye4xHc5YWFuIs67PsCf+HVH15zlnq6NPtkgXZQya7chtOSpfi0jgO
         k/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793330994; x=1793935794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KlleBVM3i1uLVt+wBeFSTUPaEiDOxCnK0ld617cCPMg=;
        b=BAdwYVvzyKBAREFs9BSm9PtGD9O1hN+yT5BougkHbqCxCj2TlNSpOne359M52BshA+
         1Nv//66KZgwvqfc9aX24j9GgcHiofUY6bUzND5w+TXsPGi+i9hAlshSkApxrP0gn/2Du
         UHQzaHYwTdcWA/Ft8RxtqczO24vV0UgRi8S+po8SdutDCM5SIiljuSdER+8MVoP+XoZf
         2QVRRDP/f1XUZVeMYc18xGLeGdRTteWLv4mtlIX5coH+J45SMlMFDUrc1hHSwHTiW2bA
         lWwT0WIiaasXZjfKWQOUJr/pNRDeerGf3xY9EuhDI5X1q+KMZQ4eYNJ5ayxFOHLrEQUG
         z5Xw==
X-Gm-Message-State: AFq9FYJWCpaOjpa1oWviszW+1HJ1J6Rn8QuGhsQKKWSDD5Uw7S3Ll4KW
	U34+/7bHshYmByyYTBradTCECtJMjbvoFRhWP8js1X0ERLQAoPumkfQ4
X-Gm-Gg: AYBFou1nAoiOxe4X4/okJlQ6E0ocgRA+Y23gh2SwWDmJIb0I+faouLkj9hMzl1qxWzF
	t7ornymFoqNXJqDm6vXEGz36B+Kv64766UkMHBFizklt58+DMUyhctEZWOXkPdiatae6xPRtmyz
	OhDQhH+C+TwQsDU1w0xLuM4YTvy6fa7z4T2Us2u+NdZnoxuUfJjYtTMuX2Fy4kt4IA75464PKry
	/31kfx4NtkJmCCeDd6bQgTOxxAcZ5ub9AvpN39uXVeUniZ8lYFo7tweFvZqqagUfWL03zMDWgR6
	sNSPonNvlC6tsEFenA9N0VV6UeFjD7VlJ/F2b64UuZg53RYBa80EpKRi8qfQ6J+GYf2WGOWGnLn
	df9eZHlXOh4WoauN3faGGrrdkEc57nggcnzyW+htfnA1V95feJZdj2zfTGI3OSR9SNoPrUL7Uqy
	YHYtH5c4XGPSiRcw6R8Yz3cy9ABQUgvshKrCR5zeOlKJG7nOSq5C7UOQXnEcBGjObQlGYuJRgCi
	jwehvLOpmO4xP5uGKGr6tx8PkB1i0Xvlew5OgK+LdX9y/D6oJQGWm+PJukiBLRfBKURWhoX6Wfj
	KC0Ljsbm2NuzOrj+DE5WI3F5vswUXqUp7iGmPr/GJmY8RkQut/JnokfVw3Yja0V96aazwAzpDhW
	DAKMnPkhY0vI9a2fm6Ejcp3v02InKdI51BUCFffZGSDgMIR39bPdaruqYGzAGRGuy2VhHGBVW
X-Received: by 2002:a05:6a20:b096:b0:3e2:9dee:42cd with SMTP id adf61e73a8af0-3e928d22422mr943709637.36.1793330993793;
        Thu, 29 Oct 2026 20:29:53 -0700 (PDT)
Received: from localhost.localdomain (S0106e0dbd1c8af8c.vc.shawcable.net. [24.85.96.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb0981c5desm111713a12.27.2026.10.29.20.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 20:29:53 -0700 (PDT)
From: Mahmoud Abumandour <ma.mandourr@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mahmoud Abumandour <ma.mandourr@gmail.com>
Subject: [PATCH v2 2/2] KVM: selftests: Verify that L2's LMSW leaves L1-owned
 CR0 bits alone
Date: Thu, 29 Oct 2026 20:29:37 -0700
Message-Id: <20261030032937.2813-3-ma.mandourr@gmail.com>
X-Mailer: git-send-email 2.40.1.windows.1
In-Reply-To: <20261030032937.2813-1-ma.mandourr@gmail.com>
References: <20261030032937.2813-1-ma.mandourr@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Verify that an LMSW in L2 that exits to L0 only leaves an L1-owned CR0.TS=0D
set, and that L2 reads an L1-owned CR0.NE from the read shadow.=0D
=0D
Assisted-by: LLM=0D
Signed-off-by: Mahmoud Abumandour <ma.mandourr@gmail.com>=0D
---=0D
 .../kvm/x86/nested_exceptions_test.c          | 36 +++++++++++++++++++=0D
 1 file changed, 36 insertions(+)=0D
=0D
diff --git a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c b/too=
ls/testing/selftests/kvm/x86/nested_exceptions_test.c=0D
index f47432526e..e33d2e0db0 100644=0D
--- a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c=0D
+++ b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c=0D
@@ -109,6 +109,40 @@ static void l1_svm_code(struct svm_test_data *svm)=0D
 	GUEST_DONE();=0D
 }=0D
 =0D
+static u64 l2_cr0;=0D
+=0D
+static void l2_lmsw_test(void)=0D
+{=0D
+	/* Toggle CR0.MP, which KVM intercepts and L1 doesn't. */=0D
+	asm volatile("lmsw %w0" : : "r" (get_cr0() ^ X86_CR0_MP));=0D
+	l2_cr0 =3D get_cr0();=0D
+	asm volatile("fnop" ::: "memory");=0D
+	GUEST_FAIL("L2's FNOP didn't take #NM");=0D
+}=0D
+=0D
+/*=0D
+ * L1 owns CR0.TS (set) and CR0.NE, both with a read shadow of 0.  L2's LM=
SW=0D
+ * must leave both alone: FNOP takes #NM and L2 reads both as 0.=0D
+ */=0D
+static void vmx_run_l2_lmsw(void)=0D
+{=0D
+	u64 cr0 =3D vmread(GUEST_CR0);=0D
+=0D
+	vmwrite(CR0_GUEST_HOST_MASK, X86_CR0_TS | X86_CR0_NE);=0D
+	vmwrite(CR0_READ_SHADOW, cr0 & ~(X86_CR0_TS | X86_CR0_NE));=0D
+	vmwrite(GUEST_CR0, cr0 | X86_CR0_TS);=0D
+	vmwrite(EXCEPTION_BITMAP, BIT(NM_VECTOR));=0D
+	vmwrite(GUEST_RIP, (u64)l2_lmsw_test);=0D
+	vmresume();=0D
+=0D
+	GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_EXCEPTION_NMI);=0D
+	GUEST_ASSERT_EQ(vmread(VM_EXIT_INTR_INFO) & 0xff, NM_VECTOR);=0D
+	GUEST_ASSERT_EQ(l2_cr0, (cr0 & ~(X86_CR0_TS | X86_CR0_NE)) ^ X86_CR0_MP);=
=0D
+=0D
+	vmwrite(CR0_GUEST_HOST_MASK, 0);=0D
+	vmwrite(GUEST_CR0, cr0);=0D
+}=0D
+=0D
 static void vmx_run_l2(void *l2_code, int vector, u32 error_code)=0D
 {=0D
 	vmwrite(GUEST_RIP, (u64)l2_code);=0D
@@ -149,6 +183,8 @@ static void l1_vmx_code(struct vmx_pages *vmx)=0D
 	vmwrite(EXCEPTION_BITMAP, INTERCEPT_SS_DF);=0D
 	vmx_run_l2(l2_ss_injected_df_test, DF_VECTOR, DF_ERROR_CODE);=0D
 =0D
+	vmx_run_l2_lmsw();=0D
+=0D
 	vmwrite(EXCEPTION_BITMAP, INTERCEPT_SS);=0D
 	vmx_run_l2(l2_ss_injected_tf_test, FAKE_TRIPLE_FAULT_VECTOR, 0);=0D
 	GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_TRIPLE_FAULT);=0D
-- =0D
2.25.1=0D
=0D
