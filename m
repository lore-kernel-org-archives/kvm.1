Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D67B363090
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074703; cv=none; b=MEiyq/DYaF6yzyyM1RBplkXd/p5n+tAWZ2Wq/iZ0AqlOhzZsfMCtjGAB5FbyJ37mV02SMaEViDkk5liNIz/EWaJlG/047zA5xckJUAcAhg61DesOo60h9mGN8O/UoF4PIilsAAgikINr+1BTSuzYPReVUA4FsmhrP67KubGKq8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074703; c=relaxed/simple;
	bh=8depo0jZCcoeyxNNWASx4mnkcCj/HamrrELwL42w1fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7vQSB+4/MyzPyVs8szO4QgiyqS3b46nSFr4Qqxirdc8fUdCG4qnZMrP6gcpfFGzFTOO4IWDgB+n6gYXxxtC2fxpQSldYhs2jtBGu+tPIDTi9I6Ez+G9InNww+uPZr4V2akZu6a9UXu6gx9nGRxW1UqeXEnoCNWn/1meIXOGTCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GwGztUoa; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GwGztUoa"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso816495e9.3
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 13:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775074700; x=1775679500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVG35mCjYbI6WSVBV9wk5F4umnWgTK95HJKmzFc6eOA=;
        b=GwGztUoaN9D5CjGbcN7C6xlKiZPLSEX/11h7cgiPLVsR+RtP5xsS4Ruz6Akemi7i9v
         nMMv5uBxSxfClU0BL99dfDX1UK2DkIIDH9UXpocmWCfQHWLuntCX0cUoDeMOTY2kve/+
         SWuYSFvJTvp97Isq19bOBmwW3CKLpPD0To0uCPu9on3uPwS1N56JDhQfMh2Njd937mta
         O8YOHnWYyvlcbPHsOJR7pZ0W8rNwrmLzh685TgjVLHkvN1858zZJxXIECue8pPQkuVI7
         Skh/UStGR6wYSwwSG8CdxAUR9eed41tokd/ybVUUv/Sf71WXPxKKS95Hil7oVUPfsAfN
         oXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775074700; x=1775679500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YVG35mCjYbI6WSVBV9wk5F4umnWgTK95HJKmzFc6eOA=;
        b=fnLdEiJK18NjYY9OFtLMAuJuLMlwcSoOU31TYVwV5BbUddiDDRkW4NmcIUkkZ7+Xx+
         KConA4CpiMHXkKLmA6oOlOrE74KPjKZ4+b1DfWXTbkmxTlRAR3mn51Qnhjb4s3GT+KtZ
         w6nrtdzyvLcLH2yPmZhiw7a6tHs2zY0MTT2/X5q61PcYSNMZ6V8o4yWTfd4y1izgopJ5
         /O6slxZ9whTjJzuCh6Vf8+yFuENjajnCIx8zuqkCtZibhm0xHpQsYwpyNuYSHLinJMP5
         tFImpowJWaw1uX29mez0/mVKVmeqmoEZBGtgBVeMye8KUO4mg4n70Aml2hWbDK+JqUOV
         C+XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbN01JBnHNS761LuivHYbr4TyJ5r9HW4dgSyN5vuJF3EHSdbBePGhO2nxfyga7uAJ34Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDtpwQcRzFixzKZaeKO8OFL1KyOxrCqoYDFbwlaSypMfVt+pms
	v284sxnyh54jwX5gZN6Yucx1zGv9HE5RytJ8Vn2hG446W9EERylNxwPp+xsHlMihFVs=
X-Gm-Gg: ATEYQzx6EzRbiJ/NJ7lCxxvIxJX/EaKRznCdK2WCo6j2Y9hsOWfIsU+I7KuEgPTGj5i
	oV8VN7LQMwsC3NwM3vqoukRrVv11vdrsA0/1gimM5ws3Dog7pSTkcIs3g9e6RPcuM3EXVtjHaTw
	pRzDbkS41O+RGG0P35komx69UKSRbweLYDoclIbQmxmFS8MEvxG8pBRBao+CY9WhanaZKgMxJxw
	k9goGFYPy/pgJA4dTQ1hifflrKpJ8etw7h2nIjdqmBQFQH4k/vRsSFxbx7lRTfEqkKhiOxZIMDC
	fgeqk93aX1ZUzXzx3ogDP4GlaZm74U2MBTUhs+RO/KGv8nk6MCCX8rE1uDBJoftajBmqOhxoFwm
	jue5PkzWAkJgVZ7AIuhIStNx4ull6oDrf+WjmfxMUuG4Ya+PVSVdwBBTPk5dBq1gCVS6orLJeGd
	MvMyBhbC74htcOFXwRBXe+2XZwjmhTBzCp/PGR6uFP7C7k4v+y7Fd0qETG/ZY7bqc10Q1rjVJOX
	JHClMtZtCo=
X-Received: by 2002:a05:600c:3e1a:b0:488:7784:d06 with SMTP id 5b1f17b1804b1-488835abf84mr81848365e9.31.1775074699871;
        Wed, 01 Apr 2026 13:18:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e93cf2dsm128270145e9.11.2026.04.01.13.18.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Apr 2026 13:18:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	kvm@vger.kernel.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	qemu-riscv@nongnu.org,
	Alexander Graf <agraf@csgraf.de>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Anton Johansson <anjo@rev.ng>,
	Song Gao <gaosong@loongson.cn>,
	Weiwei Li <liwei1518@gmail.com>,
	Aleksandar Rikalo <arikalo@gmail.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>,
	qemu-s390x@nongnu.org,
	Chao Liu <chao.liu.zevorn@gmail.com>,
	Bibo Mao <maobibo@loongson.cn>,
	qemu-arm@nongnu.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Zhao Liu <zhao1.liu@intel.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 3/8] accel/kvm: Expose all non-target specific declarations
Date: Wed,  1 Apr 2026 22:17:47 +0200
Message-ID: <20260401201753.92290-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401201753.92290-1-philmd@linaro.org>
References: <20260401201753.92290-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

None of the declarations guarded within the COMPILING_PER_TARGET
checks use target-specific declaration. "cpu.h" is not required
since some time (maybe commit 4fb54de823e "meson: build target
libraries with common dependencies"). Remove the restrictions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/kvm.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index a2463a3ac3f..8bf7a10deac 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -224,9 +224,6 @@ void kvm_irqchip_add_change_notifier(Notifier *n);
 void kvm_irqchip_remove_change_notifier(Notifier *n);
 void kvm_irqchip_change_notify(void);
 
-#ifdef COMPILING_PER_TARGET
-#include "cpu.h"
-
 /**
  * kvm_update_guest_debug(): ensure KVM debug structures updated
  * @cs: the CPUState for this cpu
@@ -449,8 +446,6 @@ void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
 int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
                                        hwaddr *phys_addr);
 
-#endif /* COMPILING_PER_TARGET */
-
 bool kvm_arch_supports_vmfd_change(void);
 int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s);
 
-- 
2.53.0

