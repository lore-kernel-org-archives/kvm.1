Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298EB36AB44
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084304; cv=none; b=s1iPG2ENs5wr6vZ9QWgSCwBb76sorbYoBcfK1/VRrBsk3mQJVvcc0fkSzrqlQI3j5pQ2WQ9bD33iSrHFjkodNS3/JhVIZL4kcnBsc/qny9/925TKE7Dq1/NuwHywKTW7DVpCpS1tlNSv5/CZFxx8YQ85E98K/VwNRwsOVXFXZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084304; c=relaxed/simple;
	bh=Hg2oUmfL9X5arE+vliSGeQXoKg1Ny/ooAhG4bti20s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O72x8662ILlqynwxwxwsuJmp3uedvnc72fU09amt7V16dgdfT7XW5k70YiMx3hhO+x2fOv9DBNQZPdAsEOrT0PxIgkATADARptkC8LKBkS0iK1YM89Qy4aTfcrJ18jq8oJwCtL9vXK5rkQx+yPooGx0w+rqs5P1UQ3wcxwJZJ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KP4+jJY+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KP4+jJY+"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48d146705b4so150799945e9.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 12:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780084301; x=1780689101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnMiDonv1YO14rMlbhW2kVzk+7R9nLq/lyljZBG8qv0=;
        b=KP4+jJY+WTIa2oNirv1uvLB9asHB6hWTEbJbe+CdB15r91wzkXnSpfpSkdL+PATtTn
         HtGzyscuPUVfMZP4wx4x8bzsDhG236GF7A92eAaYfqqke7rEKZaifpRHhFF82y6xxmzl
         H8Yv5nVf47BiOboaZkwiNN6Edhx8MeoZ5126CAaUFLpYLLLyTdvT0g48l0k6Mmdi70+b
         5owOkTMUyhjCziCIzhAapIHi44t6dj9mMPbf4AmRdbekdUobAc/jzLGvAoaxzh3l/r3U
         jyXqZSlN0RZQ2C0/y2gaDW4kj7uBUYi+ac+wHlOSE22iKp43sRyKr6D9ZEZ+8LlHIC2r
         8WIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084301; x=1780689101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WnMiDonv1YO14rMlbhW2kVzk+7R9nLq/lyljZBG8qv0=;
        b=cSLViruhyWcVN4wgirFCGidhKFAUC3Wf1y8L6b7MMq3AQffgEMDOPVBCWd+NdQnPos
         iyAGillcZ8BSoZxYB7+j2DdyjaEMXYkr1I1GVCXZUhVwLtHFSFW/1mAIzDOCTV81Ltxh
         fwhDMOeTlNDN1r/3zJrJE65OH12SsyT0AXfsNSW+KT5J6ya+ZVl5GkA5dnfbFTqTZduF
         fUY1ar9mIuiEZQzuZEqyH+XiyTo6HCsXfOYy8hnE6q2uWFsZJiMW0TOB5u8TXrlpASek
         /UxiBiIVluLJn+F8P/wRChm02JgFT5VTvdcdEKEQ/1HVJe+R2qrb/H4chQ9ttasDve84
         kKJw==
X-Forwarded-Encrypted: i=1; AFNElJ9pSQQwV0T23enucBgr8+eTkzL4OSkIBIBvwhNP3jLJcSnfEJcyJEoG/vzol9VjR+KwUW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4PabTQwmUuJBUw9IAQfaCRAbAESy0NsllPlc0NQFgEY8dw8jZ
	nObkLi/JhfIKeOzDFeNiit2Df8bxSIxATbd0JaQlR1+htomaJIRJ7BL5ZljIXQ6Vt4Y=
X-Gm-Gg: Acq92OFGvDLQRBjGhWhuUCW6EUO0oK5pBHWewqqEGzQ0RD6ZOjuaDn7Jx5xZwXc8f1C
	BD/jC6xHYmIfJ3RLliU/dTb6EzhjNyxqpJWmSQjq/sV0VTnJObIzQYppa/qVoy0yXHpD3JBR6Ld
	uc+xaVDvJOCkq4d+iV3wL4Ud7H4/jbbdkV4YYsv/XhGjFsVBiUhZN1kI29HP5Z4H9OXfdXP0sgO
	mDBB1+hlFnKuZsvcK1xWMe74azT1TWGy8QOYltMg2NYQOmr6U2O18iYdD2IFnDBlbze5aoIRM5G
	J5s5gLxcq+86yKwpSI4W52zzPZMganK9V1dcyzt6rNMBP29AL01gCJgwPZ5G9BjSO4wXeHyLsFq
	Ykj1mBzeX2ASah561SdyXGMpIx5Xqcn2osj1QmyjZ9WQ/HB4VPzdtfzHi3Dsfrt0rICK2V9Bnyq
	bGttNi2xZ2KYnJQcyb50WmD5pAwslioUdDFSZEPhAqz3elW7cwwrLGBX6Eq/3tWx6h/w==
X-Received: by 2002:a05:600d:848a:b0:490:58ef:cea7 with SMTP id 5b1f17b1804b1-490a293dcefmr12453125e9.22.1780084301545;
        Fri, 29 May 2026 12:51:41 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c12359bsm25514985e9.4.2026.05.29.12.51.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 12:51:40 -0700 (PDT)
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
Subject: [PATCH v2 14/17] accel/tcg: Convert X86 AccelCPUClass -> TCGCPUOps::cpu_realize
Date: Fri, 29 May 2026 21:49:36 +0200
Message-ID: <20260529194940.97143-15-philmd@linaro.org>
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

Register AccelCPUClass::cpu_target_realize as x86_tcg_ops::cpu_realize.
X86's ACCEL_CPU_NAME("tcg") TypeInfo is now empty, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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

