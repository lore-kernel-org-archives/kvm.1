Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792715841;
	b=v2E6MvmzU3RNGTg1mlgYALvTYBnxPXC+DIV/SsittOrZkM3d4iHVWhoiLzr+7NJ6SXEh
	 ayJ036S8x7WZFsxLS9A9xR0TQjUbaWx0pvs0aLCUpnRcEwQTXBv/G+CXnnWfJtaluKamh
	 JIelbcFcDkbIANsNYeS2MgbToPL8+muMyboFGrkDlovedvrAn5lX0EzTzoCwxJInvIRgu
	 GysIw9GHl2dDOPPw/517/w+4H4GxdlWCxz0RAj1t83a0nUeOG9pyUeyVyyNJwmA/4OY2L
	 vG2HMTUbXP0aTndJ8vlJ1JIhsr7Fwly56CR8V5B1ArKOPlxbek+Zlxf8yom9ta0i3sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792715841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ekHro9xAtxRzjQSxLihJ+G5gJFsdRypjIV1jZ3KARnY=;
	b=IactllXlWjNJXsCHyknlu+WsFNgSMyOLQswwbAjAe4qK8lIf2LMR5HBvHr9vcwMuIaSP
	 hKacmHKyap17Vnoei5HP0KSDop0NgAPIKWgeYNstQb1KuGCnjn8KoTVKT2y4aCdsiFrqs
	 Yh0JeToE/GhCj6p6fZcy9PUcX/xfJwAJ6OLA1xFuxaYcO4y9ZaH64IlPYVrbnXM8pSj7Y
	 B7zYSCLXoZxQsW6Nys06rP9VG8QGxQjkhZfA3R4oeXUv9WSF4NSHqHqhkhBEEzxDnZaLp
	 CWNHvaeYaJpLQYl3sjOp9Nvah0owNTkhoUDmPFKV6Hpe79o15r7bvodpMkLj8liZhZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rQ6+ZyUm;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C88606A325
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 00:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50C88606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rQ6+ZyUm
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd6a7b62ce8so153209a12.0
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 17:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792715841; x=1793320641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ekHro9xAtxRzjQSxLihJ+G5gJFsdRypjIV1jZ3KARnY=;
        b=rQ6+ZyUmouL0GWJIvHRIjW6eRebs9l7gK7S+MhxgOpdbt45sArF1c9wHWf6PBXrO47
         vpOga/4XbC2R2Cd96IhPLOjE2RqOPVTIxYshEUCRouDUT2J4uo1oq4Ww0A6bKsKl2vBE
         xNkaXuYq0RKPuwSyVZKJ9IKD2t6w7ygjNu3R7Wo2yMZ0XqpqKLx1YEaRRRRbfUn7ZFpM
         eot2qhR8ZW+TCgYJj/gLE0YJegKIcob2qKABGtnMgSI4wfmmlwZSirr2pPgJzCxsNI7R
         /UPmZmh8I8QnuhyTt0lI3KtqYMkPvIm7qJF/wluT90cFkpQTBeRrh7q6uKgfe0SCOO7y
         uJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792715841; x=1793320641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ekHro9xAtxRzjQSxLihJ+G5gJFsdRypjIV1jZ3KARnY=;
        b=zznfnTa2fPY68eYONH3gJbemX8osoEofec4LPVbsdAwXKfjRrmxeoWN9PktptV5j1R
         767E9kPspKoxOBjed/S5qYfiX4eOfh9SCYjlnKNsbMPvwLr+sSAmW4DaPHI5E63sL3/s
         ToPb7T51oGUQCfnURZc1XHldjalA5YYlOYNDiIcjb8cRNtkt1IYT7j2AnM40ZQQjEaGl
         ppRDx0f2mNz2M2fA/HfFOgSHqP11Fg3dTNldemXybp7tmYse/123TJzVsDx5kYR8ZzQG
         d7UqDeyWtjhzmuLeCdZrDChuv+SbKr0AsKgBmSnXWS/o1sawKinzMFxeRun4OTmpRfmZ
         YP9A==
X-Gm-Message-State: AFq9FYJjTFOhyGdkhXE+RYGTtGEpORijBYxpznQiEuc4mG5+tz38Bw+o
	tgxpFfDphMuYXAzt2WxBu5CaMV3fF6ohedttErhx+hhefK82ycaHzYoU
X-Gm-Gg: AYBFou2OReJcEXiuer2WNBwesXoqY2W9qLHwWOQtR3i7pdAvdTd17kG7J/LD0g5PMXT
	twuqElIs9DHaA002KQlT3rnW6J9/Q/eE8uYukM1uaOrsJymfCDFP3n4OAzHuOaLi79igk2x1xD1
	D99KGSBoqyCz3D0YYAkVsUGP8wlmFKa6q1BStZ6fR8fH8wAuUzdz5DBE++0hRDPsno0ghu0PFaz
	hzkSyF2HTi3xNiMeLiSAWlxLVSrVPqS2as2FQy6TudNCskC+U7HZDKismhI8KSnd7UDYws8c/7w
	PQvWuSXCQzAAIYMyNLtpZF06mD2KQnoa5oBlUoTcH86NurJE3z6kEpT/VWTAHrsgr9+jV6H4f/R
	XD029cDnGEGu4V0lBCggzrzijjhvLH2GmHy1CSi7eIfBVgqX/a/VfweoTRwgv+1PTqoR3zN4bLK
	Ogo5IEtmQmEzWp6GAD5Iw62LSARpUWKcczV4deY8rdfAbiseY6pFWStBtq66gdyaQcWXGAB5n/e
	AWg8DhNpUG1WPhKlRjoB5h81Au/oGiY6xEKmiQmiw/HjS0sDrN+/7DRi4EXlqEgb+sERCRFcD/x
	ILcsciJIrHc5SJJbRxbrUyyeNgO5zfngKYQXrQtXDGxrDAlWfZjKbtKAouvTKRtU1bA=
X-Received: by 2002:a17:90b:2f8b:b0:3ac:a203:e092 with SMTP id 98e67ed59e1d1-3adce0d002amr472765a91.1.1792715840497;
        Thu, 22 Oct 2026 17:37:20 -0700 (PDT)
Received: from monk.wireless.sfu.ca (border-p1.nat.sfu.ca. [192.75.244.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adcb0a28f3sm964360a91.3.2026.10.22.17.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 17:37:20 -0700 (PDT)
From: ma.mandourr@gmail.com
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ma.mandourr@gmail.com
Subject: [PATCH v2 3/3] KVM: selftests: Verify nested VM-Exits while vectoring INT3 and INTn
Date: Thu, 22 Oct 2026 17:37:03 -0700
Message-ID: <20261023003703.450577-4-ma.mandourr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023003703.450577-1-ma.mandourr@gmail.com>
References: <20261023003703.450577-1-ma.mandourr@gmail.com>
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

Verify that a VM-Exit while L2 is vectoring INT3 or INTn through the
empty IDT reports the event and its instruction length, and leaves the
VM-Entry instruction length alone. Only VMX is tested, as both lengths
are VMX fields.

Assisted-by: LLM
Signed-off-by: Mahmoud Abumandour <ma.mandourr@gmail.com>
---
 .../kvm/x86/nested_exceptions_test.c          | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
index f47432526ea1..9311af590566 100644
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
@@ -127,6 +150,18 @@ static void vmx_run_l2(void *l2_code, int vector, u32 error_code)
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
 	prepare_for_vmx_operation(vmx);
@@ -146,6 +181,10 @@ static void l1_vmx_code(struct vmx_pages *vmx)
 	vmx_run_l2(l2_ss_injected_gp_test, GP_VECTOR,
 		   host_cpu_is_zhaoxin ? GP_ERROR_CODE_ZHAOXIN : GP_ERROR_CODE_INTEL);
 
+	/* INT3 and INTn also #GP, due to the empty IDT. */
+	vmx_run_l2_soft_int(l2_int3_test, INTR_TYPE_SOFT_EXCEPTION, BP_VECTOR, 1);
+	vmx_run_l2_soft_int(l2_intn_test, INTR_TYPE_SOFT_INTR, INTN_VECTOR, 2);
+
 	vmwrite(EXCEPTION_BITMAP, INTERCEPT_SS_DF);
 	vmx_run_l2(l2_ss_injected_df_test, DF_VECTOR, DF_ERROR_CODE);
 
-- 
2.43.0

