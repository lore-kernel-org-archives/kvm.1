Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1953A3D9031
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064795; cv=none; b=GyiBkCliengFPjm75UBxV2wVtfH1MmXPddWKhgU27vt8Zgu6eCooa5pdb9tnD2mmIewXqbDAZrXQZOD6f5F9/Gs+Od0Oxugy9aqCy8fVjx/2v3AWccfIQBPp8kBIHq3coj21MvUWS9Y2s7l+Nw1XYtDbs8Gyg+GM4KoY5T/UfUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064795; c=relaxed/simple;
	bh=Jj7wudeyCg8nEMe9n55jb/h3RVwjmIFYQ4s1Qiyut7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdbDgT6UaYWHBSlm8z59Jfsil7IvRfdjaexCQ5YE/KvMZuX6VxwqOyGvBkqu0UIPY7cEJWycew4JAn3T3ir5dg/AtmIg+eQXyL0/mN5T2AoEgNks+DmyS5PjNy85K2qds9Hbud5ZUz4YkwOvvTQh0RWCk0gvlkuKfZQns/xK0MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gELeR3Ut; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gELeR3Ut"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so145506085e9.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780064790; x=1780669590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+YM3QmRUdwOukM/MeGpefVIWU6iLYxgHP+iBzBx3U8=;
        b=gELeR3UtUQ5Xdk4srLkMTqCYqpl13xuAyUUL5FDwe/D8AUv9ftBLkN7eFM/UW0oR5u
         4xDjxdA+vg98emVEK00EFAGJQyXQGQQXC9TPMT8LhpXqp7CMA/7Jb7TTe7o5E4bFni4P
         U/qIo0z7Ls3Wzsn+MRKCNV8yM8zh8+3z4oht7I0Ppod4lrlaNsf7iOXl5VzHUvnmGkwY
         6zhZ0iqDcqZsGZTbmxXHjEYLeTd0F9tT6kiCFWypFKG9V7MQZOOgI7mqxLMyPZmTIiIX
         VyzCM6UVb6uD2+SpI5/Erzmid9lxus+ORyMhoy63zVR+5FSbDbs0xowV7UyOyB/GBwel
         bW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780064790; x=1780669590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K+YM3QmRUdwOukM/MeGpefVIWU6iLYxgHP+iBzBx3U8=;
        b=LRdxUpqrOHVHJypafqA6igPc50ZvP7DmpCR4b79++F9Oy1dRUHzU1ng+Xg5ur/1tRK
         NVSDLRtZifswTUujUxk8+tO+EWT1vZ1RaCEcV7NPacY5Y1/cFYt9ltHq9eH8uAdWTNVg
         lDdkwI1SEUWlrDG0LR3UxzRAlYfWV1j7ErcUjM+S94zli8+touF3ppTi0+a17qtYOJB/
         4VuzxnFX1DScLLxOrFDegC2uZgJ7xdmdl2PeLPIZ10Ibn5CcaNyAQMwW0PioTEdhQWyc
         uQQNgeYfv4FInJ7ttT/faKTcki/TUX0H+pVhLGRD90GVndIc7gjRrdB3UN7FYZW6d7Q4
         U0+g==
X-Forwarded-Encrypted: i=1; AFNElJ9mwsBwk073SzBmKlVCp12NBb1dlokd6MaGnaZ8y39/PSQ4Y6Aokp36XpRheWzgutu01ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJWS6wMz0MDxkoGD93kIwnHsazF/w2TAmYyAFg/UgHwyPAyrV8
	AYl/CW9ibI8IC2Txu6fGFy6v1QhyYJyxGgvG0gNRUHoxYITyiaeBMKf45TX6ngLq/zk=
X-Gm-Gg: Acq92OH8GrSIar20xC/9BCktyiYRaQqgPBjJOdqlPzVylT8iW2mU3PbJ/LDlgtEC3W0
	I7XmgFeL2sLVseZ2yCtRbOkeZJMPooPMLiCOSPYxtdKwqIC44JYhtM4MiXKd07VPJIewEtf/9rF
	oa/ULtgDR2qzEgIc1ktWMNFxAnRi1c/b3QdqoiEHAHJ6FiiXsmP9671vDaJ3s3wMMcuO9BAG4QH
	QWQp6aWyoYO2tchwQsTM1AUQqQbqzi4xUsWOh1nrVnxbEYuuEQOWvQPD/EHisC5bmtbm91rkbiX
	gzss1vgqo9BLNEvd6Tp0oKOOdtw5LF/CSG1I/ptduTMAFMqMFxQjVT6Zmmq4F4h5mk7Q6HFX1op
	ai1RcqTo0bnXP9hpUrSudHiGmCjVw0G8hLN6kSHxZcmbYl4PJ6adjcmgIEAXaOMPSylfYg51Z9y
	j50g2+MhztjDCUrUFLIjtK6zOemo5bfW/P5uW0HDvIUMowDMhbOybK303KdP+9jcMpwQ==
X-Received: by 2002:a05:600c:3b10:b0:490:5872:e641 with SMTP id 5b1f17b1804b1-4909c0cfe40mr56255845e9.18.1780064790272;
        Fri, 29 May 2026 07:26:30 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909dff2a80sm49531525e9.3.2026.05.29.07.26.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 07:26:29 -0700 (PDT)
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
Subject: [PATCH 14/17] accel/tcg: Convert X86 AccelCPUClass -> TCGCPUOps::cpu_realize
Date: Fri, 29 May 2026 16:24:30 +0200
Message-ID: <20260529142434.87880-15-philmd@linaro.org>
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

Register AccelCPUClass::cpu_target_realize as x86_tcg_ops::cpu_realize.
X86's ACCEL_CPU_NAME("tcg") TypeInfo is now empty, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/tcg/tcg-cpu.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 04bb9787575..2a61de7f610 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -21,7 +21,6 @@
 #include "cpu.h"
 #include "helper-tcg.h"
 #include "qemu/accel.h"
-#include "accel/accel-cpu-target.h"
 #include "exec/translation-block.h"
 #include "exec/target_page.h"
 #include "accel/tcg/cpu-ops.h"
@@ -180,6 +179,7 @@ const TCGCPUOps x86_tcg_ops = {
     .record_sigsegv = x86_cpu_record_sigsegv,
     .record_sigbus = x86_cpu_record_sigbus,
 #else
+    .cpu_realize = tcg_cpu_realizefn,
     .tlb_fill = x86_cpu_tlb_fill,
     .pointer_wrap = x86_pointer_wrap,
     .do_interrupt = x86_cpu_do_interrupt,
@@ -232,24 +232,3 @@ static void x86_tcg_cpu_instance_init(CPUState *cs)
 
     x86_tcg_cpu_xsave_init();
 }
-
-static void x86_tcg_cpu_accel_class_init(ObjectClass *oc, const void *data)
-{
-    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
-
-#ifndef CONFIG_USER_ONLY
-    acc->cpu_target_realize = tcg_cpu_realizefn;
-#endif /* CONFIG_USER_ONLY */
-}
-static const TypeInfo x86_tcg_cpu_accel_type_info = {
-    .name = ACCEL_CPU_NAME("tcg"),
-
-    .parent = TYPE_ACCEL_CPU,
-    .class_init = x86_tcg_cpu_accel_class_init,
-    .abstract = true,
-};
-static void x86_tcg_cpu_accel_register_types(void)
-{
-    type_register_static(&x86_tcg_cpu_accel_type_info);
-}
-type_init(x86_tcg_cpu_accel_register_types);
-- 
2.53.0

