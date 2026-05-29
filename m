Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351A635F5E6
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084220; cv=none; b=T2n9kioCJqomSavb/miMTCu5RikFAveQ7NUTj3XWXMGbkJUFywaLorZem26KR6m6ukx+30aGz/cr1wG2fBJrKe31APpo0zbd/nieJd1Q0AbHXEbRmVoBUghz+ZDRPm51Gmv1RWB8DwUHMH9XAfX6RnYD8EFhWZVS2JvhdQNT6oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084220; c=relaxed/simple;
	bh=Enh0D0hg2dAQ7tYn/oZMXeRIAFmsYdVpZMjUDgdTNm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1HaM9ol7cuPbjm8bRrqY8MoyJiFsiSdEEuD/Uc2iDM/h1l4M5Pbx0MMn1kEZ8kwzfUbHYZrYY9b2ZKBKEXgm5uUszcGsEfZopGAZc+iW6SvtTKXy9NFUIGGf74lN10L4She1/U7QCJmetzvKX8QZSd/B+3gYqJBm9Edtr3Im7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E9Nf/30w; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9Nf/30w"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso67519875e9.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 12:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780084218; x=1780689018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSy0FrB9/d+wf1C2wnq80axQw2/zb3tMBvJqGyVtn+c=;
        b=E9Nf/30wF6WYiPWA17QMkdjpVXWKr7aLzRtEDyXH2bDQSPUsYWezRn1kzy6HIyhWYu
         ktwttR6cuujD2pneEEmejK3QRHcMni/Na6RK8BTVCmGf3lVFIJiI4aERTQFXwLglPoSg
         QHgafLXI+DQDeZY4/XA8sPqnNtd0GVaHNP/lmnBqtAMIWBSyX59ztFM6IafdFQh3xRLY
         4i6IR/tiY8BgIkCP5AwAYqLeFgRRnvlVpqAxrTMbTeV58QlmnHelkojaf2x+oFbvzaeC
         GzWEOS1Nk1/vNtlxNonUDzhN3XX3A/5iVuHxJaQ6k2SZ6ZozZGbj+pFj1/Y/9O7uKLIB
         oJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084218; x=1780689018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cSy0FrB9/d+wf1C2wnq80axQw2/zb3tMBvJqGyVtn+c=;
        b=AGbocfTtXQy8ozc6gSMSALTQvfqytouu85FPq65JCm1O1rp5X2aZI+bcg7ow3ixao7
         M+B3bQWwFLcBD0pZiIyK2XvY3Ee+GCP3wDbqKN14JFUDxijM6crYUYiSGdmji+qa08a5
         6KFnA8ft93Tb19vhiKPhokFWgPJgwkUz9rjPbIIMzF4hk6o/L8vVruDQBndxZRDZYxXm
         HlNjHWC5suqiGo36qSfl4194qX/ezgsa9dE6f7GEJbZhpSZ4PNYhmM959VIdLtptleQw
         3MN89as+RyH9uN4Arr8KiXHY6M7Od2KDMJ+8mR2AZfdgERZt7zD0JF7vFhDL8sbmAl+d
         JhSg==
X-Forwarded-Encrypted: i=1; AFNElJ+YzGePAhYVyskO7xYKid+XM8lb8GgOgvvfaeJv26S7svbkYm1Td2sH5SuT/KWBb2yQ3QM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyliNZQoa1beCKaCaeTCAgGNqtD83gowzZVroc2GyR75WxYyfnI
	Y2PGqvUumU70IODCdOhQTpC0bcHW+rp1f8+E7jbHVAMtxUbfncNdU5/pw23lmQdNLLU=
X-Gm-Gg: Acq92OH1/QDQwXXZK37+NTv3WluPRPv0v7OQZsvjBy5i4xYhehsdnVoOIxh0W+caD2f
	sL6VWSgr0jBBKJ8JnBKd3R6IQigu3EbvXlimSrZNDKpnqK3+YPQTLJBxgKZDIhkZHwnDybpq5X5
	r6ye8sDLtKn9EtJIBusBbVc4iAVoq3dlZMqgvjNT8B8bLU1QSIbcFEKJIM8a3+uoMsH+xLYZgVz
	Z688ZqGIhM5b3AhqK2ffq/l3XgcmwRELNAUra2Pd21QrBNqAE3CsG6lt+s03rVTqoY2HNn2MDKg
	NnIQ8mk3Y9jzDVL3fgOP9wuWAqGfvdVHecXJJMKgGVsNbkVSx22z2DVvFInexmfOxEoOlMGWmXi
	Ma9dfq+NgH50i9OZuyAQ524oZEGgMstbxGoySZKPlQqWYQ9wgdi8Y3OC2A57R2ZYNAFtTz9xjrZ
	cUfy+aulEqIJVzrYUE8GNeeJ6uakzFPF8fU/CD1WDM3WY18Cvfjk1D333WBBAWsm2o+A==
X-Received: by 2002:a05:600d:8445:20b0:48a:5c23:cab with SMTP id 5b1f17b1804b1-490a293a126mr13005065e9.19.1780084217642;
        Fri, 29 May 2026 12:50:17 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909cab0e94sm64497825e9.12.2026.05.29.12.50.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 12:50:16 -0700 (PDT)
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
Subject: [PATCH v2 04/17] accel/hvf: Remove need for AccelCPUClass::cpu_realize
Date: Fri, 29 May 2026 21:49:26 +0200
Message-ID: <20260529194940.97143-5-philmd@linaro.org>
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

accel_cpu_common_realize() first calls accel_cpu->cpu_realize
then ops->cpu_realize, which is set to hvf_arch_cpu_realize() on HVF.

We want to remove accel_cpu->cpu_realize, so have hvf_arch_cpu_realize
directly call HVF AccelCPUClass target_realize handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/hvf/hvf-cpu.c | 6 +++++-
 target/i386/hvf/hvf.c     | 5 -----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
index 316c1b0ba07..35f6bddbc0e 100644
--- a/target/i386/hvf/hvf-cpu.c
+++ b/target/i386/hvf/hvf-cpu.c
@@ -73,11 +73,15 @@ static void hvf_cpu_instance_init(CPUState *cs)
     hvf_cpu_xsave_init();
 }
 
+bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
+{
+    return host_cpu_realizefn(cs, errp);
+}
+
 static void hvf_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
-    acc->cpu_target_realize = host_cpu_realizefn;
     acc->cpu_instance_init = hvf_cpu_instance_init;
 }
 
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 2d1a943b96c..c2cbacd3360 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -369,11 +369,6 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     return 0;
 }
 
-bool hvf_arch_cpu_realize(CPUState *cs, Error **errp)
-{
-    return true;
-}
-
 static void hvf_store_events(CPUState *cpu, uint32_t ins_len, uint64_t idtvec_info)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
-- 
2.53.0

