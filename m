Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891BB3B3C1A
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064755; cv=none; b=smU7et6Zug2FdgQEApkt9e9pFOa/GdtE+6HovGWepHb8rummILcataJHR3hIhEU9/GJdA7ixcvOnuSxOqyIJUDTWgG/h4Y4SaOu4bewWnhT7Buf1weS/iK2Jy/9cPv5tGUPKgKXpXhvfT2lRppW+08eNRITcw6/Cpv8ShLUTLp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064755; c=relaxed/simple;
	bh=NRFYtMZR0xP9G4xodvce9W7O1UMR+jBkjCHnKPUofZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ba2BLsndkD356c6rANGKOuL0tqaAePmFkNZwz+O12Zr/0o9ZDWg46GTB3k0MlpAP+aREHn6DiSz6rMZIiXqEJZ5+J4PtH+T7reXorv8PKznDGtOf1hCtGubB/rGIbylHW9CuckD58DVRAmgPmQxWrhqnqHbeUXXY2cYxfn76lyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qR/iCsMW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qR/iCsMW"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso71985195e9.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780064751; x=1780669551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWzkQMOFrGlqEcHz0n7zXBP32rozO6O28cZDds3tjf0=;
        b=qR/iCsMW+XL9w4SIID8cdNqvbOYeSZmAGhJQLdropgmNnYBmDkXcvUHosHGe4CGAfJ
         d7zRALxv6fDB7PrfZu2WxZoKB/9fuG78HtE32bTdeyDrk7PMw7ny8Vx9bLPW60Qaw0dw
         JsFZHpVKjeCB9YVZRug5I/s43S+qg5Xrg9jb83z7Q9IWSVT8MIBCO0K/xNUdGuMN0goi
         OVQsKqopj2anIANHQkgiwDJlOdyIX/48kYblql/tHTaatGCKRUkoKveoxUEFR4tPqj0a
         NP2Mk/KWg/oPolqVooH5KZ+ddOmJM3TiYbJYf3AxzAzf07jwTVyBp16izg+u7ThsZc0H
         jpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780064751; x=1780669551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NWzkQMOFrGlqEcHz0n7zXBP32rozO6O28cZDds3tjf0=;
        b=O00VXTT7DV4O0LSM8+JxGDtlOxIh8nBqINK28iWoFZb3XN62n4yR3Xur4Q9i+r4xpb
         SUupekjxvP4AUok7JLHmeqSfEDN9HqO/KWz92UY0YXjKq+KIhR6g1CGphtUwrtFukumB
         cidWWdlSLhzxixeYmX5RP11u3KVhZVVhMM3azPWxg0zLHGbWxb5Jvc09T4pR3pP3J4Uo
         YXD3yNY2W60ggeQRNk8Svg9iqrdyTZZ7EVEzjfxK/jIYVMBK9mQJ2d2XgCrgSK+muW9q
         05x3zrkrRdSiCIb2tTy4lg0oSblm819uMD/jgCHBSoUX77sCL9sqBCh6rSNR8BvYy8eA
         lkdw==
X-Forwarded-Encrypted: i=1; AFNElJ8Cq56Rebk3PVsLLZuCKoezE7DCeYlwWkHZtn7h69OV0ohKrdSTRxRyRJIGwOH9u7dklBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhG7zUdgHlDD9xb7lnyqloGY6t8H0NgG3bjNrSyyIuP8xFYqs7
	x7wBDVv8lIG0ouqEc9Y7Xp/XLyRw7vJSiD5TIa3Rej3r91U6eznNwoSP6k2iUQjoBjo=
X-Gm-Gg: Acq92OGmGyo+Pnt9jzO3Ai2+K3sPge+33zditaHgfrI77VDmEkXAghKHskqs/ddvmjy
	DS7RkCeshKDLCVLk5A0yX3NK5HfOn+2tUoLv+y6GfriyJDY07qxky+DoG9jeD3ONg9J7C+eE0s9
	XtOKsgdPZgeTNqhg0TChHGDjwtXzU1gd7LzK8PTDji9nIHl8nNwTq6AofgTJGeKQcHyDdrEENL7
	Q1v8pTvAhyf+ezOCoblgYdhVYj0OkCDtTnT0qyf/WZiXxRwmb2FCAekxT74zxg/Pmtkl78ms1s4
	K8tn9pW/lwKsttjhVa67PAb6HaAhYnBMDTifH60H3xfwMP7u5ukddXrUwh7yCL+OGC3xDtDzl3e
	edmIVUwSSkpoAv/HLxkwruptT/krwUcqddx6eZYNn2adodw8bDxS3achmdmGz2yuni4l50MrRwj
	UcV7wAJVWSYOte7oFLoT4noo/hxOUM2Fol6QWC3U09PrkZamsK7NGRRyNPErTPtiQBKw==
X-Received: by 2002:a05:600c:6d8:b0:48a:7a10:4f17 with SMTP id 5b1f17b1804b1-4909c092cecmr33812615e9.6.1780064750811;
        Fri, 29 May 2026 07:25:50 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c10376asm15283585e9.23.2026.05.29.07.25.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 07:25:49 -0700 (PDT)
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
Subject: [PATCH 09/17] accel/hvf: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
Date: Fri, 29 May 2026 16:24:25 +0200
Message-ID: <20260529142434.87880-10-philmd@linaro.org>
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

HVF cpu_instance_init() was only implemented for X86.
Add a stub for ARM, allowing to register as generic
AccelOpsClass::cpu_instance_init hook.

X86's ACCEL_CPU_NAME("hvf") TypeInfo is now empty, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/hvf_int.h  |  1 +
 accel/hvf/hvf-accel-ops.c |  1 +
 target/arm/hvf/hvf.c      |  4 ++++
 target/i386/hvf/hvf-cpu.c | 25 +------------------------
 4 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index d5eaf26dda8..cb8abbc7cc9 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -109,6 +109,7 @@ int hvf_update_guest_debug(CPUState *cpu);
  */
 bool hvf_arch_supports_guest_debug(void);
 
+void hvf_arch_cpu_instance_init(CPUState *cpu);
 bool hvf_arch_cpu_realize(CPUState *cpu, Error **errp);
 uint32_t hvf_arch_get_default_ipa_bit_size(void);
 uint32_t hvf_arch_get_max_ipa_bit_size(void);
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 6edc2242ed9..a9c9d5d9a81 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -356,6 +356,7 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
+    ops->cpu_instance_init = hvf_arch_cpu_instance_init;
     ops->cpu_realize = hvf_arch_cpu_realize;
 
     ops->create_vcpu_thread = hvf_start_vcpu_thread;
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index d88cbe7c82a..b825a1ae6d4 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1504,6 +1504,10 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     return 0;
 }
 
+void hvf_arch_cpu_instance_init(CPUState *cpu)
+{
+}
+
 bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(cs);
diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
index 35f6bddbc0e..5d74ca6fd56 100644
--- a/target/i386/hvf/hvf-cpu.c
+++ b/target/i386/hvf/hvf-cpu.c
@@ -14,7 +14,6 @@
 #include "system/system.h"
 #include "hw/core/boards.h"
 #include "system/hvf.h"
-#include "accel/accel-cpu-target.h"
 #include "hvf-i386.h"
 
 static void hvf_cpu_max_instance_init(X86CPU *cpu)
@@ -56,7 +55,7 @@ static void hvf_cpu_xsave_init(void)
     }
 }
 
-static void hvf_cpu_instance_init(CPUState *cs)
+void hvf_arch_cpu_instance_init(CPUState *cpu)
 {
     X86CPU *cpu = X86_CPU(cs);
     X86CPUClass *xcc = X86_CPU_GET_CLASS(cpu);
@@ -77,25 +76,3 @@ bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
 {
     return host_cpu_realizefn(cs, errp);
 }
-
-static void hvf_cpu_accel_class_init(ObjectClass *oc, const void *data)
-{
-    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
-
-    acc->cpu_instance_init = hvf_cpu_instance_init;
-}
-
-static const TypeInfo hvf_cpu_accel_type_info = {
-    .name = ACCEL_CPU_NAME("hvf"),
-
-    .parent = TYPE_ACCEL_CPU,
-    .class_init = hvf_cpu_accel_class_init,
-    .abstract = true,
-};
-
-static void hvf_cpu_accel_register_types(void)
-{
-    type_register_static(&hvf_cpu_accel_type_info);
-}
-
-type_init(hvf_cpu_accel_register_types);
-- 
2.53.0

