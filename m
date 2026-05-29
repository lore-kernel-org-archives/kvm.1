Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5E52F8E8D
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084312; cv=none; b=knXiJTYWA3ALixPM4j1kLvjojz4vWslmlWDhZRxixRS8tJCZWeKBjVxvbRfoh5gvVmCrNaQhRH2EbdqYD01S1X6IWxF8sceKcMqwdj6RkqoBaOjltKb4gOHvkxQ1XJV02bo75FyUi4yu8A5KStBkdLaNtH+N6ztAkSX+YitCPHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084312; c=relaxed/simple;
	bh=2ocG4cDnLIv6ePI5Mt2HeU68DoX2p5WBBGxfPohsl0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BV60ogVLUmXi/K2QH9xHckMsMdO5nvfUkdIQCuiC+ltMGEX7uLqKb7r6YgT+URi+Tem10FvK+WGl/k01S4EioCBNEM5i7DrhzSUfF9WAD/tTEDI3oIfyEVf/OGM28CydH60irndTBBAEtJOgzl84vgGMq0aoM3caX8IS0R6zHzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IX+nBmuI; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IX+nBmuI"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48d146705b4so150800905e9.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 12:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780084310; x=1780689110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/8lHSi3EP+6l9bUS/wKfhybD6uSaQVMlqXN20XnJKM=;
        b=IX+nBmuIwX6Q9QzuzkAFRAjB+2lv6BNQ3ueZ2PyWaWsbR3KIHKzasU8BpytmSl5ZIo
         ahMWh5FsGjwJY/t0mfbcKks7UuQkHUCTr3uOjwNOC0rjqOQPRHBHDLvLQnAWZnEDzpRB
         DqsfXPrBM7OuZihmzr6h09nlKcXe5SxdgbIh40DR0Q/NLn/ThAYfiXsVhutymkycOqzo
         GzoHHhcIy4pzxS71j6rAE5pVpImn0atdJEHm6FRs6H6mQV5hv1xPG4X5GzvXkC3FbXwR
         EBH8juW0SZssP1vt+u3Gu1/FhW30krU5j9fUjC8SfAffclV+h5ztBQ9IccBxcJMBHnpP
         p+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084310; x=1780689110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g/8lHSi3EP+6l9bUS/wKfhybD6uSaQVMlqXN20XnJKM=;
        b=RTwV+kG6kTmYLZ/IxBMdMBv5j3IWjqGa4ngjs63TjEGo+JaiADvYTS/li5qWVwHYcd
         yJWq/7WkYBWQL3bng7rk+BoAH7lTrAoP1jjYo5gr5ngNuACWLe030fwZqJ1rn3sMQcCL
         gqUMUX6lFQbGe/smKZW/gwDNjTC7iw6v8YOUH48gZg0feS3qNrEEnsvohoLgdsWW/IE1
         Zan7T+dFuadTXB/Lc1TFLMWCbVckCoEdbBvGsut6OuTxSo8grkEKPJ3cl6cSJIPISJXQ
         Qfe0thzXN6/o35bjOegI4+XqH+KqzZ4NRDlveNOka8+x08ZtKTrCeyy+cVwYO+yLh9U6
         RurQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2Q6iNF7N4F2xWW+OBR3PrQQrce7qtj0bmx/aYH9K4WPGgpk4pUyGf6UE11PyfkoHoIvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6U6RFCqLP5kw/cfOhyhmHcL5dIYQltSOyT4zF7T3dsTQf88HY
	rITwR4blbrL53fda+6ebt6PDTVKDvHOcFShyzIMf1hZjyLEDvw7kMsNdS7MbRGyxh9Q=
X-Gm-Gg: Acq92OEGEfdWzDpCWL3kFI95Vupd1HEBgiN5jtN3Y6zT6CW6VrAWQkr0i6gEy84JzjW
	E8U54fqxucXFNxPlogBWk3ZDfGE9KYucTrvQI1qsfC4tJdKSJYurJUiGJYjybzJLmOFtwENDTa2
	eV3tbEnca8W/Ra3VGcFRU+OProm5oSLEuDZ1lHSleFVl9utCLmraTQcjEV4L1J9sdkn3RApdzci
	3moEpll1p/7W0AXg3tNB/A4c6f3zJ5Hokv2Vtva2j+YTe8yv5eElYf2Hy3suzlNshznV+Gq6rMH
	Q3KFguDU7nd/L2tNJrzyf8L0VG/5h0xambLpc5OmWqzlHWhAiAhim89TGEaMrfdGl/as735CJcs
	KOOqc6Tqq74N7UcZoLUsZaLYnw8w2IWHI7VFqPwBltKOw/t2dUAz6E/ghq+sjNQ3bpxgElNjBEp
	egM1w3voU8vZr8Dt87KRSTgWJVzyq/O70LlIQjR6/N2NnhyNXhEI+P2DXGjAEDL6hBpw==
X-Received: by 2002:a05:600c:4f08:b0:490:5149:a242 with SMTP id 5b1f17b1804b1-490a290d4f9mr16749005e9.5.1780084309682;
        Fri, 29 May 2026 12:51:49 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d68980csm69622085e9.1.2026.05.29.12.51.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 12:51:48 -0700 (PDT)
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
Subject: [PATCH v2 15/17] accel/tcg: Convert RISCV AccelCPUClass -> TCGCPUOps::cpu_realize
Date: Fri, 29 May 2026 21:49:37 +0200
Message-ID: <20260529194940.97143-16-philmd@linaro.org>
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

Register AccelCPUClass::cpu_target_realize as
riscv_tcg_ops::cpu_realize. RISCV's ACCEL_CPU_NAME("tcg")
TypeInfo is now empty, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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

