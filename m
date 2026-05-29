Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D319B2472AF
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064801; cv=none; b=r1rTrjCWhDDnx9sh/cEJ69Hv+VWNE6BzeIU8NtS9R/EJ9Crd2Wk570Gbw/62mgbIRAXSAe0oy9sHEzK1n2AZRLhOQ00It2gLH1/yOUBqbmLMwWbpRSBaMlsJxAra5aKMrPEDKSgPTBTKb8Nrh3g9BewYk0NVvmHpam7VdKzISXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064801; c=relaxed/simple;
	bh=zYeCvYim9wyQa6VV7TU1ZmBatrYPS1EuSWivUEVuijI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EcpHYGR+IJG9vc96K850dveSTEMureXkTQ4G9nr2bpOLRPgUM1YApx8NA3IPVGzqnZowlj+YL3nsRs3Wr27ViQf7GYRw34pHZ1oAyFd7p3xh/GxWhydn0pahOo9P2u2m3ZEf7g5w/Si77tbp4A4pMrCptAYiYqeId3VQza/8WSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hSqdmplz; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hSqdmplz"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45e8a834cc2so8692160f8f.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780064798; x=1780669598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbRLYretApx2XFNweDx4MjqL1BkYigncE9vMgvnIk44=;
        b=hSqdmplzPlBWfNO7DlQ2cBe5G1t6Yy8WIoky2Tcm2bpWTLKvdaLsRMGYj/OyGE9QiS
         xtJCZ/HejuC6qtLN8UHJFf9sik4Y+YYRky3F38lMy3rmpHO0Tz/GMYMScvXHjwvfeg1G
         vYzd8DTQAQD4MovJeRYNIrnXO8rGghABFQuYl4hExWlSXFB3uhPzUeHAzKpHlbiGmLAI
         y9kPUY4YmR6foql+GJKynlTNnxwaBnHK12Z6fsWTiYwahD29ZZKtWKoeeSqcsQ8/mgil
         2vKaXAz9M52hvXDBpEyFLexahW99vhj4NbJJUb2hMeTsPKZ1dX9lSjAGtO7QLXam279p
         Bn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780064798; x=1780669598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GbRLYretApx2XFNweDx4MjqL1BkYigncE9vMgvnIk44=;
        b=j4rJWunBdtvTp8cQVc6vLhmOYy5nZba5cdJfnlqTMkvwFP6Qxi1LfYPBUfheE36dEr
         F2sPUPalSuDqNgD41wJBuz/WSZSHrGLKEOVIJ10gpwf26TPZ9e8QpnlbTNH+3k4tWWNa
         snzS3GgKd80Hx/mzaxIZoZ+S65e/CDtMhiLPK1nuqc2MCxgKx1yQukWZdwJbhK1HuP+B
         mXds6Jl2MThYyk1WfMhI2NxCZRL+kM6EJgETsLtKGleRlZcYEz6dXiz6Rc/isVr22LK+
         M6tpNMastp7WSBEMvcjTP0wQyFlTiSqBZTqwvfL0RDeeBfQon6i1qFGtDm9s2yMSAwaN
         l9Bw==
X-Forwarded-Encrypted: i=1; AFNElJ8zE0Yh2FFCq9LJMoUycEIGH8MQy1S1DpPhbqmK+l5e6oJVie1/oP6gSO/iEVykBZuq538=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVeJtAGGy9e+7T0YvK3xUPqvY5cLZuNsKzUsURuJjyB8Fv1UhM
	cg30Hk/4QvzHC6NDECmlMhSXOlhbAoUzbJLab1NaRWW1wjor3J7fITWjc8GIibmCwa8=
X-Gm-Gg: Acq92OFRIDj2xVDH3SO77A34+BclaAdI9mzFlrMVB6zkLWQfUneFZwLF+RKJPKo99b0
	l+lEZAfUYdk6qhjJxYjpYmeWZPlVaCSe91EiPBjbezuexuXbdIiiNuch1Y3uY419R8VX4B9Et+G
	n3pGxpbiitUKkjDyHhWhJWkHzh3nF2B5Vs2/QXk7JO3el/MQZfyp7p87S1X2+Qo9zR46BxDwUwT
	okIKWcJH14DHn1NnedhKnFIc7myfRoGnKHQr5QtuAGUpvZNBsq86VdVhKkl+j+YNTozR3nR6Q7p
	N4SLlPKppF5czI+3UmiGH4OFSfGeR98G5Qjjhc7dcUBw7AUTiu7ydTJK3n2pQyMJ+UB3Q9xGnfB
	9pIERadymXk2s7TZzODMJMQxLf8xDyXLYwFweXPUoCAYY48IRcKvdgWx5ADNxbVTtziGMLUrrMT
	dYmrkSriHn1Q2NpE7E6LyYBc/miOpWEjgp5TJeQvTstbDZIcFFOoDZFEXMWV56AMq/UQ==
X-Received: by 2002:adf:e7cc:0:b0:45d:b14b:23fb with SMTP id ffacd0b85a97d-45ef6b24f8dmr59899f8f.11.1780064798213;
        Fri, 29 May 2026 07:26:38 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3556f51sm3823250f8f.25.2026.05.29.07.26.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 07:26:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	Alexander Graf <agraf@csgraf.de>,
	Peter Maydell <peter.maydell@linaro.org>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	qemu-arm@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Roman Bolshakov <rbolshakov@ddn.com>,
	Anton Johansson <anjo@rev.ng>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Song Gao <gaosong@loongson.cn>,
	qemu-riscv@nongnu.org,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Phil Dennis-Jordan <phil@philjordan.eu>,
	Alistair Francis <alistair.francis@wdc.com>,
	qemu-ppc@nongnu.org,
	Weiwei Li <liwei1518@gmail.com>,
	Chao Liu <chao.liu.zevorn@gmail.com>,
	kvm@vger.kernel.org,
	Claudio Fontana <cfontana@suse.de>,
	Chinmay Rath <rathc@linux.ibm.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 15/17] accel/tcg: Convert RISCV AccelCPUClass -> TCGCPUOps::cpu_realize
Date: Fri, 29 May 2026 16:24:31 +0200
Message-ID: <20260529142434.87880-16-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529142434.87880-1-philmd@linaro.org>
References: <20260529142434.87880-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Register AccelCPUClass::cpu_target_realize as
riscv_tcg_ops::cpu_realize. RISCV's ACCEL_CPU_NAME("tcg")
TypeInfo is now empty, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/tcg/tcg-cpu.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 703c2d9bd0a..c885af6c03f 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -30,7 +30,6 @@
 #include "qemu/accel.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
-#include "accel/accel-cpu-target.h"
 #include "accel/tcg/cpu-ops.h"
 #include "tcg/tcg.h"
 #ifndef CONFIG_USER_ONLY
@@ -269,6 +268,7 @@ static vaddr riscv_pointer_wrap(CPUState *cs, int mmu_idx,
 #endif
 
 static void riscv_tcg_cpu_instance_init(CPUState *cs);
+static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp);
 
 const TCGCPUOps riscv_tcg_ops = {
     .mttcg_supported = true,
@@ -276,6 +276,7 @@ const TCGCPUOps riscv_tcg_ops = {
 
     .initialize = riscv_translate_init,
     .cpu_instance_init = riscv_tcg_cpu_instance_init,
+    .cpu_realize = riscv_tcg_cpu_realize,
     .translate_code = riscv_translate_code,
     .get_tb_cpu_state = riscv_get_tb_cpu_state,
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
@@ -1676,24 +1677,3 @@ static void riscv_tcg_cpu_instance_init(CPUState *cs)
         riscv_init_max_cpu_extensions(obj);
     }
 }
-
-static void riscv_tcg_cpu_accel_class_init(ObjectClass *oc, const void *data)
-{
-    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
-
-    acc->cpu_target_realize = riscv_tcg_cpu_realize;
-}
-
-static const TypeInfo riscv_tcg_cpu_accel_type_info = {
-    .name = ACCEL_CPU_NAME("tcg"),
-
-    .parent = TYPE_ACCEL_CPU,
-    .class_init = riscv_tcg_cpu_accel_class_init,
-    .abstract = true,
-};
-
-static void riscv_tcg_cpu_accel_register_types(void)
-{
-    type_register_static(&riscv_tcg_cpu_accel_type_info);
-}
-type_init(riscv_tcg_cpu_accel_register_types);
-- 
2.53.0

