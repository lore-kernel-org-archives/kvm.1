Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1E0401A35
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345809; cv=none; b=MrpLiGUlyGRqzlPKehy9Tc3ql2NSoiC11Z6di9RTQrLyLYb+Ye2BI60KKXFvC/P7KgihSn4cKc81huE067l2Yk8vyoM0AXwuu/8lA6BbtVcbnTqVwGPsz/BSn6hV/nAbO4f9qoxwyxVWGC+sDlvFbYMMpeEXPjT6i4tQTp/8coY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345809; c=relaxed/simple;
	bh=heVrQKqRjqdxHgSQjWh+CRXzIjNwT83texskm88F9e4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DrfrUGLgnJqOS7MPMrorKtboEz9fK3fa///NxNtP10PWahJjoB5w6/JPUPYyV2YN73I4sk5hFkaT1nMdp80KwQ7EQNpydX/v0g2fEREHHfhH6ljKX3rblSnGcR/id1/YMTErRiPWr1OGRrPdmYpyxJ1eerf8VQ3Bpde1eoXFZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uUH9OA8v; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uUH9OA8v"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae48a21d12so10320945ad.1
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773345807; x=1773950607; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vYbUBKcoJVLVwsYIYNxtEY37h14CgHD16JtThHbFRR8=;
        b=uUH9OA8vy9FvG/384S6/qHKdcutOlF3jn5GUprLtIgPM3pmemzvsdSqj2SZX58gVxV
         Cp5PP0zVITn4y1Ij0C3U+lu+qxDSqgGS5N6u04oInejglZM5lSm9mGjgxI4XG2SI6Vp0
         A02kOmeVAJdFnBix+mE7mBqYRH31pkBOltzLNV2MBA5SJZ+YUMWp6thhHMa/gy85oFdJ
         VEGqpxtWFIKCFq6j3zwdZy3DeVvUIbKsZNe4PFe8i6S0yq8LCvaU2gn8dzBKH/7/moPj
         4oxYYXkZkuQeJRl00bX1CVbfzeK61E1UxoFgddcX6IKZICaytIcr3pKeVM4vrE19P+tZ
         UC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773345807; x=1773950607;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYbUBKcoJVLVwsYIYNxtEY37h14CgHD16JtThHbFRR8=;
        b=wdwA9chuCnpH+HiQq8jaHJSNfvHKxz+V4NLBDP6GU1qdlWd7e4e1xgl7GaFgVwNbN8
         d3bUG+A1qbe08kL86G51nBgEacrE/PVHCgWoDFKrZrXHN2Xa2mCmG4o1qcvwBVlBpu3Z
         vPqs8TdgnY45ZTrJq5m5B9jBd+RS6NJ8ihoNLbToOGb0gJhgTSvagS+p6iDpyN0hSHzW
         mDIzNCsRtcWkiFEEaLCP39TfKFlEnSl7AYrWtQLMbVi5nALMXg/ev5SL1WXTDf9+EHP1
         k7BPEUmY5pzBXyLVeSuvlB9EsRTgqIvuEgorU2XZcm+GmVILGqmOsu+JvopsJmmRoBWo
         lskQ==
X-Gm-Message-State: AOJu0Yw/k+zIAnwGgU8Q/YuFltQSMIfExMog9NVWAqVzOHSk9Uayd/84
	nt6G6SpBi6tViIdq9P+vqGpFGQRv25q5Fat7kMci+3b3EZYKC5K3AWfbduHWDbKu5vK1gJWn2rx
	36CDAfmsk3lffpcpZyf1y77t/ykd4KAlm6zNWTYV5QN6F/owfNwEErKNN5UUBTzmLCnz1fyJuzN
	mlDScdL5wKqpqW9StZTmdL5vQ9ftOibqT6hUoPheNd5eI=
X-Received: from pgbl2.prod.google.com ([2002:a63:5702:0:b0:c73:9183:9ef6])
 (user=chengkev job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ced0:b0:2ae:c3f6:70d7 with SMTP id d9443c01a7336-2aecaa4e30emr6477165ad.27.1773345806565;
 Thu, 12 Mar 2026 13:03:26 -0700 (PDT)
Date: Thu, 12 Mar 2026 20:03:08 +0000
In-Reply-To: <20260312200308.3089379-1-chengkev@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260312200308.3089379-1-chengkev@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312200308.3089379-11-chengkev@google.com>
Subject: [kvm-unit-tests PATCH v3 10/10] x86/svm: Add test for #UD when EFER.SVME=0
From: Kevin Cheng <chengkev@google.com>
To: kvm@vger.kernel.org
Cc: yosry@kernel.org, andrew.jones@linux.dev, thuth@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"

When EFER.SVME is set to 0 VMRUN, VMSAVE, VMLOAD, CLGI, VMMCALL, and
INVLPGA generate a #UD. STGI generates a #UD if SVME is not enabled and
neither SVM Lock nor the device exclusion vector (DEV) are supported.

Add a test to verify that disabling EFER.SVME
makes the listed instructions generate a #UD when executed.

Signed-off-by: Kevin Cheng <chengkev@google.com>
---
 x86/svm_tests.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/x86/svm_tests.c b/x86/svm_tests.c
index 5d2728612933..3d5ac09b1193 100644
--- a/x86/svm_tests.c
+++ b/x86/svm_tests.c
@@ -2804,6 +2804,22 @@ static void svm_insn_intercept_test(void)
 	}
 }
 
+static void svm_ud_test(void)
+{
+	u64 efer = rdmsr(MSR_EFER);
+
+	wrmsr(MSR_EFER, efer & ~EFER_SVME);
+
+	asm_safe_report_ex(UD_VECTOR, "invlpga %0, %1", "a"(0), "c"(0));
+	asm_safe_report_ex(UD_VECTOR, "clgi");
+	asm_safe_report_ex(UD_VECTOR, "stgi");
+	asm_safe_report_ex(UD_VECTOR, "vmrun %0", "a"(0));
+	asm_safe_report_ex(UD_VECTOR, "vmsave %0", "a"(0));
+	asm_safe_report_ex(UD_VECTOR, "vmload %0", "a"(0));
+
+	wrmsr(MSR_EFER, efer);
+}
+
 /* TODO: verify if high 32-bits are sign- or zero-extended on bare metal */
 #define	TEST_BITMAP_ADDR(save_intercept, type, addr, exit_code,		\
 			 msg) {						\
@@ -4217,6 +4233,7 @@ struct svm_test svm_tests[] = {
 	TEST(svm_shutdown_intercept_test),
 	TEST(svm_insn_intercept_test),
 	TEST(svm_event_injection),
+	TEST(svm_ud_test),
 	{ NULL, NULL, NULL, NULL, NULL, NULL, NULL }
 };
 
-- 
2.53.0.851.ga537e3e6e9-goog

