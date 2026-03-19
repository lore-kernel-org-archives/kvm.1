Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF193C73C1
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 11:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773919198; cv=none; b=bK6RmJJIPzz2zY/kuuuNP6tbThoJZzn5BiI7RQYDAZ+6AbdQTZcjYG2P0HgCRFcm01X9dc/TxYKo2wvk2m6Xs35QGlBlO+Lw3y/x4M8FxAyJtK1nHDmLJBQm/CGF+/e9+hjXbPFPmIhYeJ/2cnK1/m4ypMGTLesz6vzOhm1PskQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773919198; c=relaxed/simple;
	bh=O1kJSzW56xtGVuhE6LABiXBSB7EnryZ6wSKNghsi110=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWNGtCLMwIEGvHX/tPmgyw94RS1ZEg+k6bsxESFa8XYfyIbrxv65UtczanqBbHs01Nq0QeUKNqfKg5o2sDHI7Z/9h15/ydvkq2mCVUEnX/xrBln717WI8FdPSOOIq/X2DwmZTAxWxmLvzHonqRHyX2pHRXFtzZGf4cnhi7oD4yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jkLl1yzP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jkLl1yzP"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-485345e1013so13939145e9.1
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 04:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773919195; x=1774523995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EF35YN3CJ8u12H8BkNu2tiJ6lwUGD01EvYz7GmtlEg=;
        b=jkLl1yzPjaIkJOtdZDcewJEXggwXwfgYUlpkPh/u+Blj29XBsFTmBqu1+TYFruim8c
         SojV3CGvQ16/Q5pWt+FUpTIg/f80T8xxVu6fA9FxnzESF5U0fe+TDnPTQ3g7bEvty1P7
         a4NBL+JsBpIyLjkRFWtGD58qRRYWxLyHSKbF2T2gd5bKh8J4vOJ0KwBAfML58B4bCA4s
         1a6YgOkCRjUnGX1h3WPVLUmLsrEpoMkRDXxDrWpRterYUeUy3QFlzRHNoGsGGyjxCp5A
         6+hKDOzayt+3FDft29kEIWT2PiQrhxz0Y2UNsFYTCXOXwy6BxLL5ZwMBokb9hKS/FBRX
         u2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773919195; x=1774523995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1EF35YN3CJ8u12H8BkNu2tiJ6lwUGD01EvYz7GmtlEg=;
        b=RLViR5Q3pIVYpetSJl75YolE5XkBJ6FGHb46CeHLaSTm8IjWaM5q31nYDGAVX9KIT+
         k99xvXtHTAeq+x+qVP9tqvu3RG0T5Ms0KAb7u6AR3wne+0Et3UBWITeOsZkx7UdqR17K
         iGX4FzvhTo9+FopBUQIQHgNp+ElVq5KpjEZE3zDNFMxgxYUl9nXhy4EMzv75a+RjG024
         p4ywkt8xzghBfgqlUo/ridUwTXrQ3VqoxFs5X+0UVrKPLJ1lMqFbONaLpGigAHAvpi9M
         Jnl1vWCFc7xY/Ju9+LhO5hOOyIQQcl8wMJM/K+Y4NzpEyjKrmVJavbJHhNI6xj8LWxB5
         gI5A==
X-Forwarded-Encrypted: i=1; AJvYcCXjGyIVppMLod1OxUqGMvhh3RLGX87U76r/LVFlEsiwn+/E8+kK8SRGUARq+s88sP+9CEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZmtCJUvkEPn+cjSeh+tq/GndAcJCs6e5Qwo7kk0j214F7t3cH
	BKw+Z/Tqqzug8C0UPZtj6z3/WP15cXoyJFAxlk7llvvp8Sx+Vo3GXIiwIXgD4RsK4jM=
X-Gm-Gg: ATEYQzzwJDq58f0rqIRXDzL9xbQzFDry9IPBSLlG03c28/+OKpSxg2zyeBeNmsn9jps
	03NRN5oII+eguCDTrfU2DeUDiDaX2j+0F4Wn19BNC4H4eG8qGBZnJ+Q/zhZ77UYAsOTxuVn8uIr
	ENjEOP25cHhxc9AkeOaPyNF5mkf9zutlYZu2+KW6fwakGy2fBXCPsQqxs+dJ3bSDONl56WC1eUE
	DRothG/FEUBoclK2Kbu+lzNxMPCjyPG6p57NvkU0ZTOWYWloy95cQgu9ehIQEimmZJU401vBZJW
	fLetrwoLZZD154vgnGmzoyjqhGCCG9wGsLBMRxDrfsAin61IO1/NpqsShQh91P/Ew72/lZNfTfX
	p3v2FpUDF022BRP24yR/a+C2wslky4oAoK27njdA7T4HIlROALH89mT+TKDoLf1vijVvBvXAYE/
	DjWiWvocNL1Y388wzmWniXLuc9oNOJlFCZmI0L7dMcQ3ONBnfcrpzQDU//4E2Xff/xkn9k8FYE
X-Received: by 2002:a05:600c:8b10:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-486f8b46651mr48087815e9.10.1773919195014;
        Thu, 19 Mar 2026 04:19:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8bd9d78sm19811235e9.5.2026.03.19.04.19.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 04:19:53 -0700 (PDT)
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
Subject: [PATCH 2/8] target/ppc: Factor common ppc_load_epr() helper out
Date: Thu, 19 Mar 2026 12:19:30 +0100
Message-ID: <20260319111936.68041-3-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu.h         | 2 ++
 target/ppc/cpu.c         | 8 ++++++++
 target/ppc/excp_helper.c | 3 +--
 target/ppc/kvm.c         | 2 +-
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index d637a50798f..e3e4bce91b7 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2822,6 +2822,8 @@ enum {
 target_ulong cpu_read_xer(const CPUPPCState *env);
 void cpu_write_xer(CPUPPCState *env, target_ulong xer);
 
+uint64_t ppc_load_epr(CPUPPCState *env);
+
 /*
  * All 64-bit server processors compliant with arch 2.x, ie. 970 and newer,
  * have PPC_SEGMENT_64B.
diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index 4d8faaddee2..f24801a9731 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -26,6 +26,7 @@
 #include "fpu/softfloat-helpers.h"
 #include "mmu-hash64.h"
 #include "helper_regs.h"
+#include "system/memory.h"
 #include "system/tcg.h"
 
 target_ulong cpu_read_xer(const CPUPPCState *env)
@@ -105,6 +106,13 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val)
     ppc_maybe_interrupt(env);
 }
 
+uint64_t ppc_load_epr(CPUPPCState *env)
+{
+    CPUState *cs = env_cpu(env);
+
+    return ldl_phys(cs->as, env->mpic_iack);
+}
+
 #if defined(TARGET_PPC64)
 void ppc_update_ciabr(CPUPPCState *env)
 {
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 6d05b865058..3b476c145ab 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1166,9 +1166,8 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_EXTERNAL:  /* External input                           */
         if (env->mpic_proxy) {
-            CPUState *cs = env_cpu(env);
             /* IACK the IRQ on delivery */
-            env->spr[SPR_BOOKE_EPR] = ldl_phys(cs->as, env->mpic_iack);
+            env->spr[SPR_BOOKE_EPR] = ppc_load_epr(env);
         }
         break;
     case POWERPC_EXCP_ALIGN:     /* Alignment exception                      */
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 41bd03ec2a2..3bff75b7f54 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1692,7 +1692,7 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 #endif
     case KVM_EXIT_EPR:
         trace_kvm_handle_epr();
-        run->epr.epr = ldl_phys(cs->as, env->mpic_iack);
+        run->epr.epr = ppc_load_epr(env);
         ret = 0;
         break;
     case KVM_EXIT_WATCHDOG:
-- 
2.53.0

