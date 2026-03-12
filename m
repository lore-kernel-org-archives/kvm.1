Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2574A2C032C
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 20:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345804; cv=none; b=PQ69CgZEhi6uOLmuTHe3G9uFdBjUJY5nsYyBsaGnPjm6oZx9JdrOK9TKSuYhFEKsIqf/b7K2eOBD290Zk6COroIGZjE8QOohRaOAemSEbfJgyjhytcLGYN0wLmFYK/MBa4eg0MMq9FP4Yk/X65tuhDlU/6n8AmSRgtVoIL86i1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345804; c=relaxed/simple;
	bh=4mzQOACoR1SXAKMApIXspWdQnM0eiPQnLgDe72F+Cj8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KUsRT4O3+BVsUjfRpKuyYlWkDRyC+XeQy0KN0TTafYqKbxxgapyMg1sNf0mbVFCpT6rq4MXS3v4/kpY9QYLAST8veRUe7iUGKDXgLgsJhdfL2s8ISB3P8SfGj5/AtORsLxjSl8fdgudHvw4iduKlwCnzi8Y2WuJa1WQoYcKWe3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dOuGw3GG; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dOuGw3GG"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aeaabedbc3so99317745ad.3
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 13:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773345802; x=1773950602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fzRMUqUecGDSBHAcwJN0t8ltOHITxxaCaYOGOkxKkYE=;
        b=dOuGw3GG69uiWLxSe3CkVwvPvw7kGvu6wMBRcNsOEVuRNxpXMNnulwsLt7WAvt94sV
         xzFH1ZoCCuc2CiKAhYl63e+CpxqJqKWrDtpvp32wiqhqduXZehHv1GGNVjCxLSTxU5Vg
         Sre56hjwJMmLvHNzgiBJHbcljxx+UjgeSXR6WEP96p2KsgxCr6Xosx0zZPuKJVuU+Ilf
         /aO5iSFfz3MSb7jE2AFwqMy9beNLMTHBQ4ZEX4RMDmujRhhMn60f5FUyZbvGcFl05jrm
         Hf1ZisTgXoyvjCLEQ8vNhYpxSLVuuDNdOkch6xYLlVonBlBjUlhWcYX36PF21eFA44fJ
         u5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773345802; x=1773950602;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fzRMUqUecGDSBHAcwJN0t8ltOHITxxaCaYOGOkxKkYE=;
        b=IlTCBHBxprzxObfi3GpV88nhw989NtCdgAmayJtCWKHusjupfiiI/CYbFuqm3Y9Ilg
         ZfYN/ZGePZHLiYQot4E89YC1gGifwwgrgTgo1uo1Pd6hIxBwadD/OtiONvcsgYLqtKCJ
         jsFmF89o04D1xtMnweH9GvI5Hy1RK5+8NT35HUV1wKorJI0tRhaki2QM2rCwtu108Dii
         ZgJH9v8ru+TvvSHrltpHVXSJxCPIQxHxrPngsdkBVYiF3tF1fsbH2VrBK4U0EbklA3Gd
         /WEFgHK8K6n1J3fhP4m1rh3FWEx0T4YxnaH3/7IDHk4dYPH6GbTj7ndpmzSafY4SZqQH
         276w==
X-Gm-Message-State: AOJu0YzR24vBb35G1wI4qBvf1GtwutquGYHw0fznprhkVpQV4qgSVnbi
	QXg8bWqitlFEAjVrSt6zeorqiDmzLQOuskcpsGyPSId/cyHmflayLmn0FBBS9xFFDaMmG9Yj4qh
	aVVCJn7f3rrptQ32f1zoxZs9/2GFAHvAKY2v7X1ua31BlqFrYlr760ps4Alj+GWBMh9vSHbAD/3
	zspLyG3pi93tYbaW8vXbjw+XNHce/nJjiB+LDOvet31ro=
X-Received: from pltt20.prod.google.com ([2002:a17:902:d154:b0:29f:1c3a:7fed])
 (user=chengkev job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:ac7:b0:2ae:5a76:e26c with SMTP id d9443c01a7336-2aecac82939mr6024225ad.55.1773345802172;
 Thu, 12 Mar 2026 13:03:22 -0700 (PDT)
Date: Thu, 12 Mar 2026 20:03:05 +0000
In-Reply-To: <20260312200308.3089379-1-chengkev@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260312200308.3089379-1-chengkev@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312200308.3089379-8-chengkev@google.com>
Subject: [kvm-unit-tests PATCH v3 07/10] x86/svm: Add NPT ignored bits test
From: Kevin Cheng <chengkev@google.com>
To: kvm@vger.kernel.org
Cc: yosry@kernel.org, andrew.jones@linux.dev, thuth@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"

Bits 62:59 are ignored if memory protection keys are disabled via the
PKE CR4 bit. Verify that accesses are allowed when these bits are set
while memory protection keys are disabled.

Bits 52:58 are available so test that those are ignored as well.

Signed-off-by: Kevin Cheng <chengkev@google.com>
---
 x86/svm_npt.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/x86/svm_npt.c b/x86/svm_npt.c
index 6ecaf32a8d75..39e8b01965f2 100644
--- a/x86/svm_npt.c
+++ b/x86/svm_npt.c
@@ -372,6 +372,35 @@ static void npt_rwx_test(void)
 	npt_access_test_cleanup();
 }
 
+static void npt_ignored_bit(int bit)
+{
+	/* Set the bit. */
+	npt_access_allowed(0, 1ul << bit, OP_READ);
+	npt_access_allowed(0, 1ul << bit, OP_WRITE);
+	npt_access_allowed(0, 1ul << bit, OP_EXEC);
+
+	/* Clear the bit. */
+	npt_access_allowed(1ul << bit, 0, OP_READ);
+	npt_access_allowed(1ul << bit, 0, OP_WRITE);
+	npt_access_allowed(1ul << bit, 0, OP_EXEC);
+}
+
+static void npt_ignored_bits_test(void)
+{
+	ulong saved_cr4 = read_cr4();
+
+	/* Setup must be called first because it saves the original cr4 state */
+	npt_access_test_setup();
+
+	write_cr4(saved_cr4 & ~X86_CR4_PKE);
+
+	for (int i = 52; i <= 62; i++)
+		npt_ignored_bit(i);
+
+	write_cr4(saved_cr4);
+	npt_access_test_cleanup();
+}
+
 static void npt_rw_pfwalk_prepare(struct svm_test *test)
 {
 
@@ -833,6 +862,7 @@ static struct svm_test npt_tests[] = {
 	NPT_V2_TEST(npt_ro_test),
 	NPT_V2_TEST(npt_rw_test),
 	NPT_V2_TEST(npt_rwx_test),
+	NPT_V2_TEST(npt_ignored_bits_test),
 	{ NULL, NULL, NULL, NULL, NULL, NULL, NULL }
 };
 
-- 
2.53.0.851.ga537e3e6e9-goog

