Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793317847;
	b=xBzKaNMS0MAr9wYJhzkfdQ0vTF6mdrLQmk+KZAuMNxE2l9P9X5BQ7CZtNxagowa4kv+h
	 /b0tft7S6CjncxSMxJvm6lHDw1V60k2MKwFT+I7UHBy1jGdnhp3Y49pTGzYXqCxfw2QDI
	 uHRFPXOPkUdUEvmT6q3NcFPMPbWz6JLLBgaGvItJpQ4z87udANYp8C/E7rrS0Jj009WrE
	 NxJqn8tqoXGCvJ4NPwwcroN/XVX2KSHCgg3qyI2cGEL1Na/XmmKa+Z27c9gBt2OSrGaHb
	 TV17/5nrILqshTVlrQ9y4cSSe1O6yR5vnW+ndaIKOoTu/aGO/1Kq/1Ng2eoWFkjj5Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793317847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7emnZQPruQD3bCi62a8Jg+jSwhOmw8TI3bWaMqwE/HU=;
	b=g/2VBHZuezwOYc8xtp/NOVTw0xHlUpSzBwZ5ZinFG4cbBgTo17APsO1gKpTWMVTB77DD
	 /LDVZwIF81Qw5C/1riSuHE3RWZD2tqrKbsQ/bbC3aicXYF/mfSFigL3fwj/A9ytTnA19j
	 105CYRKseLI94ijUvnycpq15hyT3t+vbDIficSuz/fQP0RZ1uX4mJnRm7bnKyyWf6mfSJ
	 +MdPXAiyIrZSRfiJfud5v2H+jBI/O5axYXqrEym2T8SyfHRezHPRNgGPNFrWVk8bZIu5S
	 C9AsouH2PkLXmcVR8PTl2ZSE5Tbxxo33bB/AiqIo7dBnuGvcd1sfFc9IdC90v8pd5Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IZlxMmUW;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2AC606A32D
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 23:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A2AC606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IZlxMmUW
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ea759cc9b6so694715ad.3
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 16:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793317847; x=1793922647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7emnZQPruQD3bCi62a8Jg+jSwhOmw8TI3bWaMqwE/HU=;
        b=IZlxMmUWdYcy7ERhlT3Z14UvSpdnQ+jTXPPXHMUX2Y3c18QPQZuUn0ulJFClPv5Z8K
         s4B5kfys8FPWT+BuruXDvY3whl815gJo50GnUwml/KNJZqxlHmF/x8JYkUyp+pDBswxC
         pDCOLf8OXPo1DZRZnuS20JKwT3nsLiw643PzADUUupxs1GDEFXebfCak7zGo7dhEgju0
         93Jy3azKAJ6HT6+p7Iw9cynWGLpELyuW8ilefOHU+gw83b2SGWajVvLjaIW8rF8Zjd4O
         3AWpXud8GVczcc4JKAHGXk3i9LSCtwamFxja/ocdkrhfw5mwcRnjcCCzkdRQcN6t1BJK
         MVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793317847; x=1793922647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7emnZQPruQD3bCi62a8Jg+jSwhOmw8TI3bWaMqwE/HU=;
        b=VvxlRD6icVoGPHkMd5ehJ6ZYI2QHlCLudfR2N/LcU4UtK88vYadszQ6ckSrAtKCf/v
         cl4wivawa93vXKRqRvAQTR+1lini+ld5Xbv2+3fQg9rr7YfsPLtYdpiUwkSpV+4IVwgJ
         ewJKyEqLm0v20psTSm7VWxaMF3n9a/1Wdhb55JemUC0rtaqjwqtE6VH0auoe3Yq/1hqD
         EZlYidfd5ucRMh+VryFftz24qdpEDqIX7f7iv0Xd3kF4QiV10A29fprxTx5xwWeH2CR8
         S9aaxXysle+2+MDUDsnojww6siZsuEGgFB+J1xbXvlWw+YwrMhwdnYhg204KEE/LO90G
         sEWg==
X-Gm-Message-State: AFq9FYISET9VPOFMFfcvYmJHatN4UGcFqvpfJDvm1BrdrLcVA9H/Nu65
	+R2cW5Wls/Nkj5soUJV0TGZr1vYmC9j6tbjFOazjjgfBI0bkuiq5ZhlE
X-Gm-Gg: AYBFou1tr8mIbgnipQzgOsD3Q2VA3PppDLzmHAHnvODh2zXi4y84H44nMI57svmkzJm
	Prg6z2tWBUnlJr36wmCJ4QUFpaRB9CTc0pNWn0qt/J6SExNKk01sn9W7HWetSZ1WEOPD7jIEOKG
	jn6cYfMpZi932AXLGymaxG1S1pDrvPWGRzYMiwHGqRZgxRf+l5cvqdl7yFPL3D9NMAzIfJt4BTh
	EXFHVGiNN5i8XOOp5qjaQOIGjjtQMNrbQ14FFLrosryuchPMg2efKzUI0wmqcPdaU8I/funiHUe
	gWtWLxLSISnjnbt4ZJstLW9DhY16FkchW9+6GOipR+yY38jMrEbUrtu5hBDsLv5wbsXqHeE5YXb
	d8OvwM7Ya0d2PuwFnXrU6m/GunsDQXwjAKu7/qp6p5Pj+1VYdp1LMsAHeWP0NavVgoxEI/zxLy7
	0Y1kvFBVYNRMbvY7HQXFnUWuOBMnnt2fUmINc09FXQCVPPteg6uq2r/oprmaaDdEm3eOIAChch2
	U2V5d/OCnZuKs8dc/rU+A8k5mcCymFT9vhMtNWAVoOGXn4o+LJq+SsIoHi2dUKYCUd+QFKY8Jw6
	xh2fEaT81PkjrbhZVayFm8XqY4kRrgpiLg5kxcre0bdvWdY62Y72qbaDEJjVoi396WlhWNyj+qi
	gryvryHV1oQ==
X-Received: by 2002:a17:903:1b0e:b0:2e9:6790:212c with SMTP id d9443c01a7336-2eb3649f446mr8766755ad.30.1793317846670;
        Thu, 29 Oct 2026 16:50:46 -0700 (PDT)
Received: from monk.. ([2604:3d08:8e80:f800:3c86:745c:97f1:5486])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39266f42sm384225ad.40.2026.10.29.16.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:50:46 -0700 (PDT)
From: ma.mandourr@gmail.com
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mahmoud Abumandour <ma.mandourr@gmail.com>
Subject: [PATCH 2/2] KVM: selftests: Verify that L2's LMSW leaves L1-owned CR0 bits alone
Date: Thu, 29 Oct 2026 16:50:40 -0700
Message-ID: <20261029235040.12013-3-ma.mandourr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029235040.12013-1-ma.mandourr@gmail.com>
References: <20261029235040.12013-1-ma.mandourr@gmail.com>
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

From: Mahmoud Abumandour <ma.mandourr@gmail.com>

Verify that an LMSW in L2 that exits to L0 only leaves an L1-owned CR0.TS
set, and that L2 reads an L1-owned CR0.NE from the read shadow.

Assisted-by: LLM
Signed-off-by: Mahmoud Abumandour <ma.mandourr@gmail.com>
---
 .../kvm/x86/nested_exceptions_test.c          | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
index f47432526e..7113018ee6 100644
--- a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
@@ -109,6 +109,40 @@ static void l1_svm_code(struct svm_test_data *svm)
 	GUEST_DONE();
 }
 
+static u64 l2_cr0;
+
+static void l2_lmsw_test(void)
+{
+	/* Toggle CR0.MP, which KVM intercepts and L1 doesn't. */
+	asm volatile("lmsw %w0" : : "r" (get_cr0() ^ X86_CR0_MP));
+	l2_cr0 = get_cr0();
+	asm volatile("fnop");
+	GUEST_FAIL("L2's FNOP didn't take #NM");
+}
+
+/*
+ * L1 owns CR0.TS (set) and CR0.NE, both with a read shadow of 0.  L2's LMSW
+ * must leave both alone: FNOP takes #NM and L2 reads NE as 0.
+ */
+static void vmx_run_l2_lmsw(void)
+{
+	u64 cr0 = vmread(GUEST_CR0);
+
+	vmwrite(CR0_GUEST_HOST_MASK, X86_CR0_TS | X86_CR0_NE);
+	vmwrite(CR0_READ_SHADOW, cr0 & ~(X86_CR0_TS | X86_CR0_NE));
+	vmwrite(GUEST_CR0, cr0 | X86_CR0_TS);
+	vmwrite(EXCEPTION_BITMAP, BIT(NM_VECTOR));
+	vmwrite(GUEST_RIP, (u64)l2_lmsw_test);
+	vmresume();
+
+	GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_EXCEPTION_NMI);
+	GUEST_ASSERT_EQ(vmread(VM_EXIT_INTR_INFO) & 0xff, NM_VECTOR);
+	GUEST_ASSERT(!(l2_cr0 & X86_CR0_NE));
+
+	vmwrite(CR0_GUEST_HOST_MASK, 0);
+	vmwrite(GUEST_CR0, cr0);
+}
+
 static void vmx_run_l2(void *l2_code, int vector, u32 error_code)
 {
 	vmwrite(GUEST_RIP, (u64)l2_code);
@@ -149,6 +183,8 @@ static void l1_vmx_code(struct vmx_pages *vmx)
 	vmwrite(EXCEPTION_BITMAP, INTERCEPT_SS_DF);
 	vmx_run_l2(l2_ss_injected_df_test, DF_VECTOR, DF_ERROR_CODE);
 
+	vmx_run_l2_lmsw();
+
 	vmwrite(EXCEPTION_BITMAP, INTERCEPT_SS);
 	vmx_run_l2(l2_ss_injected_tf_test, FAKE_TRIPLE_FAULT_VECTOR, 0);
 	GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_TRIPLE_FAULT);
-- 
2.25.1

