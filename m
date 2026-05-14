Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B68131F99F
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 20:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778791224; cv=none; b=Aqj3AKMAT8gCnScCn2fTr1X+J9k6x76yxswbE7wRjUg/mF4E9Fbx7nwMHwfpIcE2yBlyPQQhzc2B3Ymw+BdbfkzlcHnGQwEk+q2EJZMx7QQIrnHUtEGktz05CP8SE2TS5KopbvmGLltJfy0hCgAXDZFN6ZH8YtZr/EID4Lxe0ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778791224; c=relaxed/simple;
	bh=ZenW5OoUrZmp90yF1Y1NwaHJt5/PKApKqVaLLk4C6qA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p97jAeZK05ARCDvwenAvwFp1lrvIROhDLFsNiA5SbOEVWaKFWvm7pD3/k9xw1BpfkZNYwaBAl9AQeHHc8QDkrXQ/CT+t9gT/ddqszYodaxcAxrVBa6p+9IQkNABkxTCRX6HOZa+fowvFjSjFrMKEqWgHbAMeOH6vkAmBGF+Nh2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sUPbj+t+; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUPbj+t+"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-837cc5bc6deso5754267b3a.3
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 13:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778791222; x=1779396022; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUhInrlFypsdtpltXopXp70F7zR6hdFoXnOPVPVgU8w=;
        b=sUPbj+t+xc9/lZquBY1xUhcm2CRQKfvmUlqg8ML9bRKvYMmHq04BNSRFtIe2FEMHb6
         KHlrtx0HTq4e7OEVIAhuOozJqOjeyYT+TPDXKBCKsFDEJZ9onIof0jJsV6K+X9xL2cw6
         S5paUlyUq3PtL/aHgVrp4Qx8F67A+ow4hI18sxjRllvrUCqplW0BjjPCZqlxUKuX8xDL
         aeDj1xIV50WbfAb5xUFR5CbEg82q/AIIQkRyWBhQekmcREFiNngQG9RVuHvuVM7ZIKvm
         zJPg+vIOysYQy/Dh64g7gvxMBCtvCf7hwCTC3/5Ehv2E0LwPwaOgiXDklpwWQPeA87ly
         V5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778791222; x=1779396022;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TUhInrlFypsdtpltXopXp70F7zR6hdFoXnOPVPVgU8w=;
        b=laXTRRzhgkuCgURo4hrnaaFmLkzr/DYsGVpM/5E+QkR+OyGjsS89LKN4diFZc5XdpZ
         /P6YVUZskzSqPKMpm9+LvyIQ5AjsGbhm/1Y6/1P/H1j2erSDIfddYv7ELn6TEV1xIc/E
         FCKns+c2pXVo5ywdNFyIjEW5vIZve+oDho9HCrIAbfQWeBcIYc3whuCaf2pNI1Vz7mWV
         vHUHmJPGh18X6ei2NQXDPRPFlOTQEDFAx3gNefkZ6gGU3ZO7Hl9Ce7U9b3BQMiVWPgfk
         GjCqJiPQObT36CVs78dpN2zPSpnZ0xxUaR+Vs/Giwyg6E8vGSwWBrDaGzFdGYHt7iIl4
         8LCg==
X-Gm-Message-State: AOJu0YwHp9F3GwRYAOkoUoRzO9josqBqQH0IZGDuETCQ55dFsxB3aS+0
	P5jGlSOQTt772gEHsLXCfwkmS4GALMTWJbHPvKczoStXuwuJeg9+IPw6cMWQ5N66BZcSGfjNuVP
	dZrXUug==
X-Received: from pfll21.prod.google.com ([2002:a05:6a00:1595:b0:82f:93e5:c64c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:21ca:b0:83e:c8fb:54dc
 with SMTP id d2e1a72fcca58-83f33b36821mr1134115b3a.19.1778791221932; Thu, 14
 May 2026 13:40:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 13:40:20 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514204020.1614792-1-seanjc@google.com>
Subject: [kvm-unit-tests PATCH] x86/xsave: Extend VMOVDQA testing to also
 cover VMOVNTDQA
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Extend the XSAVE test's VMOVDQA coverage to also validate KVM's recently
added (and initially broken) emulation of VMOVNTDQA instructions.  Despite
the seemingly generic and all-too-similar names, VMOVNTDQ and VMOVNTDQA
are unidirectional instructions with opposite semantics: VMOVNTDQ *always*
stores to memory, whereas VMOVNTDQA *always* loads from memory.

Rework the checking to use a buffer that is never written as part of the
testcase itself for the source of truth.  KVM's bug was that it mixed up
the direction of VMOVNTDQA, i.e. KVM was loading from registers and storing
to memory.  Comparing the src and dst buffers on a:

  src => reg => dst

sequence won't detect mismatches due to such bugs, i.e. if KVM wrongly
does:

  reg => src, reg => dst

ecause by the end, src == dst, but with the wrong values.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/xsave.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/x86/xsave.c b/x86/xsave.c
index 254f9fde..0a40f466 100644
--- a/x86/xsave.c
+++ b/x86/xsave.c
@@ -2,6 +2,7 @@
 #include "desc.h"
 #include "processor.h"
 
+char __attribute__((aligned(32))) v32_0[32];
 char __attribute__((aligned(32))) v32_1[32];
 char __attribute__((aligned(32))) v32_2[32];
 char __attribute__((aligned(32))) v32_3[32];
@@ -11,14 +12,40 @@ static void initialize_avx_buffers(void)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(v32_1); i++)
-		v32_1[i] = (char)rdtsc();
+		v32_0[i] = (char)rdtsc();
 
+	memcpy(v32_1, v32_0, sizeof(v32_2));
 	memset(v32_2, 0, sizeof(v32_2));
 	memset(v32_3, 0, sizeof(v32_3));
+
+	asm volatile("vzeroall" ::: "memory");
 }
 
+#define __TEST_VMOVNTDQA(reg1, reg2, FEP)				\
+do {									\
+	initialize_avx_buffers();					\
+									\
+	asm volatile(FEP "vmovntdqa v32_1(%%rip), %%" #reg1 "\n"	\
+		     FEP "vmovdqa %%" #reg1 ", %%" #reg2 "\n"		\
+		     FEP "vmovntdq %%" #reg2 ", v32_2(%%rip)\n"		\
+		     "vmovdqa %%" #reg2 ", v32_3(%%rip)\n"		\
+		     ::: "memory", #reg1, #reg2);			\
+									\
+	report(!memcmp(v32_0, v32_1, sizeof(v32_0)),			\
+	       "%s VMOVNTDQ{A} original memory, " #reg1 " and " #reg2,	\
+	       strlen(FEP) ? "Emulated" : "Native");			\
+	report(!memcmp(v32_0, v32_2, sizeof(v32_0)),			\
+	       "%s VMOVNTDQ{A} using " #reg1 " and " #reg2,		\
+	       strlen(FEP) ? "Emulated" : "Native");			\
+	report(!memcmp(v32_0, v32_3, sizeof(v32_0)),			\
+	       "%s VMOVNTDQ{A} using " #reg1 " and " #reg2,		\
+	       strlen(FEP) ? "Emulated+Native" : "Native");		\
+} while (0)
+
 #define __TEST_VMOVDQA(reg1, reg2, FEP)					\
 do {									\
+	initialize_avx_buffers();					\
+									\
 	asm volatile(FEP "vmovdqa v32_1(%%rip), %%" #reg1 "\n"		\
 		     FEP "vmovdqa %%" #reg1 ", %%" #reg2 "\n"		\
 		     FEP "vmovdqa %%" #reg2 ", v32_2(%%rip)\n"		\
@@ -35,12 +62,15 @@ do {									\
 
 #define TEST_VMOVDQA(r1, r2)						\
 do {									\
-	initialize_avx_buffers();					\
-									\
 	__TEST_VMOVDQA(ymm##r1, ymm##r2, "");				\
 									\
 	if (is_fep_available)						\
 		__TEST_VMOVDQA(ymm##r1, ymm##r2, KVM_FEP);		\
+									\
+	__TEST_VMOVNTDQA(ymm##r1, ymm##r2, "");				\
+									\
+	if (is_fep_available)						\
+		__TEST_VMOVNTDQA(ymm##r1, ymm##r2, KVM_FEP);		\
 } while (0)
 
 static void test_write_xcr0(u64 val)

base-commit: 9eb6c57313060d34f7e5b2ac6f90bb5873bbe2ff
-- 
2.54.0.563.g4f69b47b94-goog

