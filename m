Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3554733F5B5
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064745; cv=none; b=Wm9zsxoq+8t4CnM1OdmyLExB8lEFm0vIHBGbm46rVroparr5wae6EsjcK6sD6vOnq2f7ADBD+0+RLGpfvjmJXftyBtCFzJztallPJslc80liydYjbujfQv18TjcuNKc9p9XF5Jnsf9GSURvCxcX1pPMqI5+KXWL/dciA7bmUTxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064745; c=relaxed/simple;
	bh=FfykZfju36kP+sMAeqdFjITFjyPin1gWAD45l+HgwI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7nJgmrRRgc6xlkcAYzxPfDEvvHn4lwwRrm38XGmy+zRPrU7HcnJg+jIHEKbhuAp1la+imjHM1ckDLTqLM0PsDjkhRNouGucnmXkqQTgrY4iFkR8a01qYvuIdK6KnDQyh/ftJVYfx89tMm1dDb9Tg4k4nwKGM4txTbFPjQzkZno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p0ySgooY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p0ySgooY"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso94982695e9.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780064742; x=1780669542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKn4RQHGDomnnmi9l8u/n3j933cMw6QUVCqU0AdCGPc=;
        b=p0ySgooYNIP/4AwWrhsY7GQuz7pkofyDCmEEjzIeqk8tK1bfD6RJfx21DnMct9z/aP
         nqujy4TGc5qBuySf9S20LzAMf8eOkRCDCVZIZ6Mb4WuG5Ku6OGPly9yfSmk+O4xlWvR0
         PWxwGFFSAoQfTcdrQntPf0bSOBCoo3K/LMa6TGtjuO5NOvIH2ktG9o8aQJvxpt7Fn8e+
         3k808U7ehc3285ul/5qLAHnBXwuHUnxOkib0+y7uKWFHckhkFe11/cVHn40p69+xXACj
         Q1hS8bM+nLD96iC7M7WJUR8mYjkiGarFpWlr/qSXnWl+Osp/1zdigjsQzThYa2qP6HE0
         OZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780064742; x=1780669542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LKn4RQHGDomnnmi9l8u/n3j933cMw6QUVCqU0AdCGPc=;
        b=g32pOUSVZ+FET7eVhsQZoSv8SVnsTBArc9AEj/tzolVb26S/aSJG4f2Cr5Upxis/Qn
         9yoeGsBjhplZXl+b/vg5fW68V//MtQ1Psl//FXq4vJpwuqfHXPcFFW1O0Lq0/7ZFFpse
         eULCk7JdKY8TurwX4BkIh7+jYIR5Ng/+rNNo/VNY3wY+ebnjNCiw3+Z9AemQwpu+7nbd
         PUpS4JeXW/ARkzz3bj/7qp58P1AH91z91e4W/PNpa8OhqCeRAOi9EEa5S16A8MBLRHfr
         P3Ex1GydeJeAe6fRu2UbCHrefAl+xZnkqBI5MwwEKRUeB5ZjNMs7YNM3kR1NWOSq4YNQ
         h7vA==
X-Forwarded-Encrypted: i=1; AFNElJ9GSooC3hzAHClFpxpvYut1xb2ubPjfvGRmOZlvjBtKWuhrqjNzTBsDq4oYzb47sjVx0XI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiRMusjD6X3Af12WzIMGLlRr6c5G5Z33njxw2SEedZQxxFrwy6
	wEFh+HDkUTSPB03+Z3fuK9+8ewSOx3NFEai8k1eQY3tluVqRHaFtEymLDQagtDfXQto=
X-Gm-Gg: Acq92OGa2R5taHU1SzXRCNvwRDBFduZmn1ff5ktyrVm6eREVdXWiHbU2MistqPtZ/zc
	1zg1LRLeKoB4hNgz8BJ4UR5MSixny+pZnaaXq0CCGYxFxydB/pduEe3FwW0GoH/J9nIxhIcCndR
	HFkpuBL5V0QJZSTQZfD3oNObys+DdXTDxdkFZFBZqm5cZKy0Y9ryEfkRb3GRtA5GnXhultDvaBh
	E7RidRj/QH6UGjHbRX1KNGlkDic60tAJcZihl2ccqdXMwDCNAmOJ2RMiz9Ft5KDOvtvdqym6A32
	AybJfqlXYBsQZN/yfIbZJ8ZNz5cqfPLUe395vIDjjKbXkKV2G1f8h0uhEsZ+wM5PsSLgDIMTAm+
	BlQNLYtnqTNv3lRyxiXwLlEFXrN1AcxKb+S0PriiyFdTOhn6XfJn3TT2GdI8hETcOum873oxKul
	aiIiUWlhWtbqi7ex7Job8DvsrXAU9P61kFjmn3MFxE3EbynBbmJgysXR07rHT1NerO3w==
X-Received: by 2002:a05:600c:897:b0:48e:6f39:f7be with SMTP id 5b1f17b1804b1-4909c07f9e7mr33215785e9.10.1780064742579;
        Fri, 29 May 2026 07:25:42 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d68b853sm45850685e9.3.2026.05.29.07.25.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 07:25:41 -0700 (PDT)
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
Subject: [PATCH 08/17] accel/nvmm: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
Date: Fri, 29 May 2026 16:24:24 +0200
Message-ID: <20260529142434.87880-9-philmd@linaro.org>
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

Register the new AccelOpsClass::cpu_instance_init hook.

ACCEL_CPU_NAME("nvmm") TypeInfo is now empty, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/nvmm/nvmm-accel-ops.h |  2 ++
 target/i386/nvmm/nvmm-accel-ops.c |  2 ++
 target/i386/nvmm/nvmm-all.c       | 19 +------------------
 3 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/target/i386/nvmm/nvmm-accel-ops.h b/target/i386/nvmm/nvmm-accel-ops.h
index 931bb5ca243..f2a78c12110 100644
--- a/target/i386/nvmm/nvmm-accel-ops.h
+++ b/target/i386/nvmm/nvmm-accel-ops.h
@@ -16,6 +16,8 @@ int nvmm_init_vcpu(CPUState *cpu);
 int nvmm_vcpu_exec(CPUState *cpu);
 void nvmm_destroy_vcpu(CPUState *cpu);
 
+void nvmm_arch_cpu_instance_init(CPUState *cpu);
+
 void nvmm_cpu_synchronize_state(CPUState *cpu);
 void nvmm_cpu_synchronize_post_reset(CPUState *cpu);
 void nvmm_cpu_synchronize_post_init(CPUState *cpu);
diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index dd5d5428b1c..60044b83527 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -87,6 +87,8 @@ static void nvmm_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->kick_vcpu_thread = nvmm_kick_vcpu_thread;
     ops->handle_interrupt = generic_handle_interrupt;
 
+    ops->cpu_instance_init = nvmm_arch_cpu_instance_init;
+
     ops->synchronize_post_reset = nvmm_cpu_synchronize_post_reset;
     ops->synchronize_post_init = nvmm_cpu_synchronize_post_init;
     ops->synchronize_state = nvmm_cpu_synchronize_state;
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 8a1af35ed32..10ab7b2a4dc 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -22,7 +22,6 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu/queue.h"
-#include "accel/accel-cpu-target.h"
 #include "host-cpu.h"
 #include "migration/blocker.h"
 #include "strings.h"
@@ -1212,33 +1211,17 @@ static const TypeInfo nvmm_accel_type = {
     .class_init = nvmm_accel_class_init,
 };
 
-static void nvmm_cpu_instance_init(CPUState *cs)
+void nvmm_arch_cpu_instance_init(CPUState *cpu)
 {
     X86CPU *cpu = X86_CPU(cs);
 
     host_cpu_instance_init(cpu);
 }
 
-static void nvmm_cpu_accel_class_init(ObjectClass *oc, const void *data)
-{
-    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
-
-    acc->cpu_instance_init = nvmm_cpu_instance_init;
-}
-
-static const TypeInfo nvmm_cpu_accel_type = {
-    .name = ACCEL_CPU_NAME("nvmm"),
-
-    .parent = TYPE_ACCEL_CPU,
-    .class_init = nvmm_cpu_accel_class_init,
-    .abstract = true,
-};
-
 static void
 nvmm_type_init(void)
 {
     type_register_static(&nvmm_accel_type);
-    type_register_static(&nvmm_cpu_accel_type);
 }
 
 type_init(nvmm_type_init);
-- 
2.53.0

