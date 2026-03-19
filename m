Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34003C8713
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773919220; cv=none; b=MHPpnnPejyTZmXtrr1WPHkbrmaCl1SyAoJAx/sV8vRezuW5FNcwZ34IotOw/q71N0ediBo73XFE7o62VPRsVlGUW9wHHr33lMttbDQSFeunVRZrYL0KjHIWDrDd4VrPaes1lQ3Hu+aKEglyE+tTndH7J04Mn/AS5eaAx2wR84ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773919220; c=relaxed/simple;
	bh=MGlKqoD/nXSTKWjmyB/eWLp6UTZHp3uel9fvFUrYrZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDOiK6tgRbf1O+DjP6ONujrQkOPu2PgbUFVbat36KfhqT7RlJxOgJgubyOGvsP1I8KKTU6zqIC6AxSqGnif8AVy0LTZg+3o2HM+S+pC8P7g4c9gcHAAwGEyzkxyEslyed1T7jMJNmmQbNZTdv799UzRDxb5l8dUgIipC3bDbfJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ssQbHmLO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ssQbHmLO"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486fd27754bso1607245e9.3
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 04:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773919217; x=1774524017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kV6UJs6uJ+gJwq/B/WXu0vSWOly3L8qb+FvxJ/ow/Lw=;
        b=ssQbHmLOXIU9wijqMGCploV8taPKt5i7hNyif5UWGmFQv4Bv13ojr9n3iaIX4BQpes
         3rIrPSj5O8SDK5qzPwvndYIjKO6e8fm9XsabvqWxPss78arT7tDB/KosX7bb2ybNr0Go
         O+v1Ou8dz9NnKKzmCSQBLcZ1nVAeclNv6KjpyS4zSRIvL2chN6Sqiyc54xoJLzpAs2PV
         g97syfHc25HGBSB9B0siYBECbVNCmcBS/duMHhQjI1byCaL84YmoN8++a2e3Pu2VpfI0
         5OlVk57WU44gqiRwPVadPkGn1k8gl4/UfIajnN3G/57oKWfgcXmpTbJ/GPtWVBaEyIQy
         Xhug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773919217; x=1774524017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kV6UJs6uJ+gJwq/B/WXu0vSWOly3L8qb+FvxJ/ow/Lw=;
        b=RlKG6q+UEwsxFk2RtydIq89zMLJ5B69hZEq1zeEJw8bG8ExXQb7iDaV0ngbZOltOib
         9jFIvedgwH/ohW7JnvyBdB8BO0EqPnXsMbsS9/Ly3/RrRYoXfDtd7dPb5jbM1EZafg7p
         xRQA5n2TXJrpRLWHQKF9FrPgP9JV0unYt276MEJJTpNMbbcnq5jZhgwrF3KPl4UVwUM0
         INYv/J+E+YQpbkrQ8DpzydXatGcHuG5ov+1sUBAWEJdW2Dw2hzQcXx2fwgpn20awa9BJ
         12hyH0sndmX9Gg5AxTakv9jsDq1QIMJZP+yREexzF/GppacTndt1aRoi/f3d5oJUAWJ+
         qRhA==
X-Forwarded-Encrypted: i=1; AJvYcCXJbiTDPRiDbLlr4K71rWcUtliFmyFK0R8U25vh7v02YO8CZWT8rhNIakZlidvHYrd89WE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY4KB36YEM/A1og2AZqFSDVUAX2zx5BuioFyZebnjSoYDfqlVM
	r23qNflCb+p2xIc8oJPA1pqf2aSFY4r4I5j4q0OA0ehqG8wVVK5dLCaVF+3jWPMGtPU=
X-Gm-Gg: ATEYQzxQlevU3hmEC6RITAUbuNWN2M2nupVuIO7DA9VYqbtcQsV5pJacxB8OuaQWmzx
	tXLGzqsoXOMMJ70COChLxJFGxBTwkOBPtY+xOJc8tURG8gE5vJsRv2VDPcEcXdxO1XY1wfFsejL
	ACEtGHZbj6Y7et2ZBqAoTqnKxpBUEKqfcvtRxnpvQ1H/fVuY4CDW/zLlLn+T1Xa+cM4RZwWzVnK
	jqvOtfl9aB9VQdHsD9fHoAFSRK7zLnpc1Bj8z6lnLjE8R4rv/S12Fk9Sh511PB8iIrPr0T1f815
	GUTLzEMbYpWsk5JZwnQHYoHToICPInwjTdNz1bPUJrKHM/S0XazUk8il0c2N3YWM9W6VczhsPDq
	cST+j0nhJ/shsalvvmhgxMlmv2qxB45MUiJU94l0DhLbHOqsZ6iLpkGddRnhRlllNLYyfzCvuWd
	1akP8cojii6KTYgeROSRY1DxMU+uTsB4xsoIMEPmvQmxdlDR0DqN1PNHcQaGSH4liUTG9WbtQu
X-Received: by 2002:a05:600c:810c:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-486f4475342mr112999585e9.20.1773919216971;
        Thu, 19 Mar 2026 04:20:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b949e1sm103571465e9.9.2026.03.19.04.20.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 04:20:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	BALATON Zoltan <balaton@eik.bme.hu>,
	Nicholas Piggin <npiggin@gmail.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	kvm@vger.kernel.org,
	qemu-ppc@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	Chinmay Rath <rathc@linux.ibm.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/8] target/ppc/mmu: Replace legacy ld/st_phys() -> address_space_ld/st()
Date: Thu, 19 Mar 2026 12:19:33 +0100
Message-ID: <20260319111936.68041-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319111936.68041-1-philmd@linaro.org>
References: <20260319111936.68041-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Prefer the address_space_ld/st API over the legacy ld_phys()
because it allow checking for bus access fault.

This code however doesn't check for fault, so we simply inline
the calls (not specifying any memory transaction attribute nor
expecting transation result) per the definition in
"system/memory_ldst_phys_endian.h.inc":

 27 static inline uint32_t LD_PHYS(l)(ARG1_DECL, hwaddr addr)
 28 {
 29     return ADDRESS_SPACE_LD(l)(ARG1, addr, MEMTXATTRS_UNSPECIFIED, NULL);
 30 }

 28 static inline void glue(stb_phys, SUFFIX)(ARG1_DECL, hwaddr addr, uint8_t val)
 29 {
 30     glue(address_space_stb, SUFFIX)(ARG1, addr, val,
 31                                     MEMTXATTRS_UNSPECIFIED, NULL);
 32 }

No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu.c        |  3 ++-
 target/ppc/mmu-hash32.c | 14 ++++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index f24801a9731..89fad5356b4 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -110,7 +110,8 @@ uint64_t ppc_load_epr(CPUPPCState *env)
 {
     CPUState *cs = env_cpu(env);
 
-    return ldl_phys(cs->as, env->mpic_iack);
+    return address_space_ldl(cs->as, env->mpic_iack,
+                             MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 #if defined(TARGET_PPC64)
diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 08c9f63a132..81fa7336b76 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -23,6 +23,7 @@
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "system/kvm.h"
+#include "system/memory.h"
 #include "kvm_ppc.h"
 #include "internal.h"
 #include "mmu-hash32.h"
@@ -205,14 +206,17 @@ static target_ulong ppc_hash32_load_hpte0(PowerPCCPU *cpu, hwaddr pte_offset)
 {
     target_ulong base = ppc_hash32_hpt_base(cpu);
 
-    return ldl_phys(CPU(cpu)->as, base + pte_offset);
+    return address_space_ldl(CPU(cpu)->as, base + pte_offset,
+                             MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 static target_ulong ppc_hash32_load_hpte1(PowerPCCPU *cpu, hwaddr pte_offset)
 {
     target_ulong base = ppc_hash32_hpt_base(cpu);
 
-    return ldl_phys(CPU(cpu)->as, base + pte_offset + HASH_PTE_SIZE_32 / 2);
+    return address_space_ldl(CPU(cpu)->as,
+                             base + pte_offset + HASH_PTE_SIZE_32 / 2,
+                             MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 static hwaddr ppc_hash32_pteg_search(PowerPCCPU *cpu, hwaddr pteg_off,
@@ -253,7 +257,8 @@ static void ppc_hash32_set_r(PowerPCCPU *cpu, hwaddr pte_offset, uint32_t pte1)
     hwaddr offset = pte_offset + 6;
 
     /* The HW performs a non-atomic byte update */
-    stb_phys(CPU(cpu)->as, base + offset, ((pte1 >> 8) & 0xff) | 0x01);
+    address_space_stb(CPU(cpu)->as, base + offset, ((pte1 >> 8) & 0xff) | 0x01,
+                      MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 static void ppc_hash32_set_c(PowerPCCPU *cpu, hwaddr pte_offset, uint64_t pte1)
@@ -262,7 +267,8 @@ static void ppc_hash32_set_c(PowerPCCPU *cpu, hwaddr pte_offset, uint64_t pte1)
     hwaddr offset = pte_offset + 7;
 
     /* The HW performs a non-atomic byte update */
-    stb_phys(CPU(cpu)->as, base + offset, (pte1 & 0xff) | 0x80);
+    address_space_stb(CPU(cpu)->as, base + offset, (pte1 & 0xff) | 0x80,
+                      MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
 static hwaddr ppc_hash32_htab_lookup(PowerPCCPU *cpu,
-- 
2.53.0

