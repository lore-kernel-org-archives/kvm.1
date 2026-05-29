Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C402C332610
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084247; cv=none; b=D1LO7DDc4HkkpADU/mWPPrXHtMgvpkcrARIuALDIOQBwJjJp9lS2F5COHgMNOvqskmqHuSqf7g4w9Mu76sc6KzK1PYiVCewR7ci11FBRmRqcqGpuX7D19Yhl1ZE0XQ5rEQoiiuztVXUC/DOAL9OUqGN8yRdp5PpPSXyb5xSw7Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084247; c=relaxed/simple;
	bh=0x7jhX9lSLA0LHWRAr87+KHxDenBeoYc+ASg3qTeNjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+D18gYn2U2TAaxiwdx0XCvKckCFp1o5v1vuhDKiiUi8rwZaNLkfykl14OuaSgUfjOCEeD9kPw/Gp3n1rjKE6EZlNcorBwmKV0Stq6YBLTM8MMbxI0YGntvBa4W6/vCjoAVeWLnRbc+siL8PW4jv4779Fl+EtpgueK4oNr8QHHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uF2lxMqy; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uF2lxMqy"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49050ff7cbdso69040105e9.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 12:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780084244; x=1780689044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTEurkffFP4f5HtctBBlTf0KhJxPmE6GCKl/0QMxQlY=;
        b=uF2lxMqyJ4oCudZgz6xBQcbz7ZIqJwTYmFp3LgBiv+vDTOHjRkTYZOBdzUonXKxiNl
         azJE0sV1L8YbnrT3kGbjhhf0DiWfI/H6oU0I6zeVYoDr4HrN06fWrxi9pt6U/OyzvaTM
         pA2LuPmjBxyyCPvVGyz8EVu7H8RC0vg4PL0q8IHY/Xw4sD84n6L/lGHTGoa0E+LDTEVg
         ZafWOjBBXkmsK7N/AA41BoqoLxkXtK9toyl7kSz4yIpIfMpXKgCVycmZjZQiv79N69GL
         Ss16I8fIioXUz2CzyFCh6W5RzQzo/SCMTqLZ/J50PPal78uwAMcz6Linz7JbeNvNVrGQ
         1hLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084244; x=1780689044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HTEurkffFP4f5HtctBBlTf0KhJxPmE6GCKl/0QMxQlY=;
        b=k3P5QkAeq/o+BoqzLPro6YGvzdP7NDvMWi66XRY3yMTln5a61z4mce47bYjfX+MQmh
         d4X0+WEw0Ck+uP20RaOQ23xD7VWKhqC2mNBLHxsF6W9W/ZtH72HqRtacAWGpBQhk976m
         RCow3iFOQY5u8+EVx/qxsEy7v92mp2t1rQ8nEMvAlvUcyraVeLIdeDcVgoXBUtkpq/YD
         MUdcSToCif9vJoBV/eKIOgScXkWh1HbrkW0oG6snFUWl8M1BaHGGMnxIgYaQAurco2t1
         ZSfTi0F7RGo/ECcbWXR3z6RqAh9umaSvn8gx0Yxr6ali0ry12kUYgpaWBpnxdZitzlNc
         SGxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+NBt8s/nEJaxkBwTLb7y25agxPF71uhBig+GAoOD9cfnSN3ep+uvvNtZRTC+feQN3SaCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoD5R2FZSjEJJw+Llz2cGuyrNYjLEIW2AfSrzvUPwAm2U+krM2
	QsogRCV2G+yAKtR1/K4QfrF+5473LHkjde2Hva2N7XgzsGaiBHOzBt4UGAWrc6aqHOw=
X-Gm-Gg: Acq92OElbgknh3Ib172pzb0HyPbPycvg9xBxgxJ5uV/hhxXII+fCcg+qYXm4nx6w2aF
	VD0wadsxoCTUd+4OXwunQu3v3H0qR5xA4XMIzkDIxeae52CGWC2/5DUQbrK9Z6SzfgibfRVQiMd
	LCuVNSQ7WU2Mnxst0MOuWn4SwMwZXkCabu2DCZInsiBsSSubEEgLogPQeTCR6Z3Qn9KQt4c/08V
	JCAa59AZVqO7FV2D5PZMpjSNDrCx0VqTX08gD+j6AanHRWFIxrShMe6nkJna0KD8ELGYQE9k2UK
	MTicwetYpEeDJUGG7/5ZtHbDeJ1zLVqdvTfcKAu93qbJsfOGk5QOLpLq1i9aYm5tnNMzW0WScu/
	g5U1xeFxAU4jILD/AvDxt0A8wnujwdjU/DzK9EsEynj84gS1xY4SiDJC9rv8ZXzRIatwxpHapmR
	A9HKLl85M2Ns2M4aQGs+gdZC8NEtyTKMyJGMpz7dgeiRQgDVCQ2WSoE/ibd75WJA0OQg==
X-Received: by 2002:a05:600c:818c:b0:490:81cb:d7a with SMTP id 5b1f17b1804b1-490a297085emr16599145e9.29.1780084244117;
        Fri, 29 May 2026 12:50:44 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6f35f8sm52943695e9.13.2026.05.29.12.50.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 12:50:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	kvm@vger.kernel.org,
	qemu-s390x@nongnu.org,
	Chao Liu <chao.liu.zevorn@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Song Gao <gaosong@loongson.cn>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anton Johansson <anjo@rev.ng>,
	Claudio Fontana <cfontana@suse.de>,
	Eric Farman <farman@linux.ibm.com>,
	Alexander Graf <agraf@csgraf.de>,
	Chinmay Rath <rathc@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	qemu-arm@nongnu.org,
	qemu-ppc@nongnu.org,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	qemu-riscv@nongnu.org,
	Roman Bolshakov <rbolshakov@ddn.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Phil Dennis-Jordan <phil@philjordan.eu>,
	Reinoud Zandijk <reinoud@netbsd.org>,
	Halil Pasic <pasic@linux.ibm.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/17] accel/whpx: Convert AccelCPUClass -> AccelOpsClass::cpu_instance_init
Date: Fri, 29 May 2026 21:49:29 +0200
Message-ID: <20260529194940.97143-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529194940.97143-1-philmd@linaro.org>
References: <20260529194940.97143-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Register the new AccelOpsClass::cpu_instance_init hook.

ACCEL_CPU_NAME("whpx") TypeInfo is now empty, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 accel/whpx/whpx-accel-ops.c |  2 ++
 accel/whpx/whpx-common.c    | 17 -----------------
 target/arm/whpx/whpx-all.c  |  1 -
 target/i386/whpx/whpx-all.c |  1 -
 4 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/accel/whpx/whpx-accel-ops.c b/accel/whpx/whpx-accel-ops.c
index b8f41544cbe..099e8ef6da3 100644
--- a/accel/whpx/whpx-accel-ops.c
+++ b/accel/whpx/whpx-accel-ops.c
@@ -98,6 +98,8 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->handle_interrupt = generic_handle_interrupt;
     ops->supports_guest_debug = whpx_supports_guest_debug;
 
+    ops->cpu_instance_init = whpx_cpu_instance_init;
+
     ops->synchronize_post_reset = whpx_cpu_synchronize_post_reset;
     ops->synchronize_post_init = whpx_cpu_synchronize_post_init;
     ops->synchronize_state = whpx_cpu_synchronize_state;
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 247e12db812..25c5d84fd30 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -24,7 +24,6 @@
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-visit-common.h"
 #include "migration/blocker.h"
-#include "accel/accel-cpu-target.h"
 #include <winerror.h>
 
 #include "system/whpx-internal.h"
@@ -505,21 +504,6 @@ static void whpx_set_hyperv(Object *obj, Visitor *v,
     }
 }
 
-static void whpx_cpu_accel_class_init(ObjectClass *oc, const void *data)
-{
-    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
-
-    acc->cpu_instance_init = whpx_cpu_instance_init;
-}
-
-static const TypeInfo whpx_cpu_accel_type = {
-    .name = ACCEL_CPU_NAME("whpx"),
-
-    .parent = TYPE_ACCEL_CPU,
-    .class_init = whpx_cpu_accel_class_init,
-    .abstract = true,
-};
-
 static void whpx_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
@@ -569,7 +553,6 @@ static const TypeInfo whpx_accel_type = {
 static void whpx_type_init(void)
 {
     type_register_static(&whpx_accel_type);
-    type_register_static(&whpx_cpu_accel_type);
 }
 
 bool init_whp_dispatch(void)
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 3079c6293c8..16040f102a3 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -23,7 +23,6 @@
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-visit-common.h"
 #include "migration/blocker.h"
-#include "accel/accel-cpu-target.h"
 #include <winerror.h>
 
 #include "syndrome.h"
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index e626acef2f0..1b68f13a7dd 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -33,7 +33,6 @@
 #include "qapi/qapi-visit-common.h"
 #include "migration/blocker.h"
 #include "host-cpu.h"
-#include "accel/accel-cpu-target.h"
 #include <winerror.h>
 
 #include "system/whpx-internal.h"
-- 
2.53.0

