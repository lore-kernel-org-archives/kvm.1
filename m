Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE401326D65
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084203; cv=none; b=P3HHcANOrR/elLcOr1o/SCHhvVWsF/LMkoxxioqE2gY5MSzUEJSjLVwM2alWlrLuoUokFNylYS6CtAHMIJyGTQOJ6jxoqSWOqQ24Tk6gzoGRAQmqIxGi6r+c2Hs+55480I8huc5O1pS/H2e1C794uFuC5xIZoaO5IhUnksuWT5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084203; c=relaxed/simple;
	bh=c8xvBP6LSndzbzTTY6AZkFHdTIFuXKYYQcrV4vJGDGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VC51KFx9BXTIa6bgQXvjnTN/icj2U7QzfMlqmGp/LbxA3OBV2aBtdqGfhMj+/9GO2AFN10jUTd/7SHGJxJk4kseUhHmyFiCfrByMphHtUBPx9Bw4sRuePrUo2popus5IxulHlXzMfEAMtvlX4LCwU+l6RXpYaVnFFUTVfnUgFP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PiRSiZP8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PiRSiZP8"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so91381835e9.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 12:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780084200; x=1780689000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vn1TfSGGJHYXoT5p86UQzNNg6yKLfh8iH6VFrIwRfTU=;
        b=PiRSiZP8GYumqFIyg7K4HgtGuL9EaoicnPmObgwgE+w7U4d4151PgpyZVeN5LtnwKQ
         w8ZL8MzqOz02P39IFimjDoVvM4dLlVHVduFY1htk++KlFbmlFBZjWxzjPYkCsVer6FqK
         bsJW0Jk2Keo1ZrumWGAa4UjHfqJGxOS7l7+2+L9hv7x8dDVejPM6jFj1AkyGJlTy5Dhb
         QWG9fxl2SjsiAZUcD0j6X4+z52evVIWJqP8npCXQn4GXSYSMw4AYWOnhzxEGmtZOvPM0
         vfBGhgtb1WqPVmBeviHXnCymiB2yo2dNdH3zsg22W4pPaXy1sHYMH9tAPQQR3Tcn6/4/
         xOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084200; x=1780689000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vn1TfSGGJHYXoT5p86UQzNNg6yKLfh8iH6VFrIwRfTU=;
        b=rsRre2o4n2P2n8poEkNV6qY5aK4K8DR9W1i28rsMi+sagP+5NwUmxbbsGrjEadmosB
         lZd49D2A7lPIZAKuflT2B53p5vQpbuHt+GfTuTiBnuoXSM2lFKt7NBj84aOkF1xHvYLF
         Jbt1OzG1fXOtctIb915BTYavLOGMa/v/vRJa5oDywg+dSh9zKoPvoRPz2VSTl+SA/Gjm
         Q7Zed5ZwF3ImsLJHwCh3mmS0f3BIAahAORm4ZYu7fen6jgTI/d4/rJszW0WjoEBNiPNE
         J3jQxKubUZEhS0EvCiik2aIDJ2AIpzrunfFT5xeLWTKzjADvSTeFZH6fWTZ8CeAH0hTF
         eqrg==
X-Forwarded-Encrypted: i=1; AFNElJ9xilWjSSWFXlHYKUsnegJjdKseWHlgmAEnbKPxlb0TMIsPvCsBrlubhAB+w9J5o/+4Yyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw69SEQwz0t/f0PMu3fymOEB5BVkxOYUnOeHf9GxKGFxfa2otbY
	oZqQ6hyBi5OVsMHVLQSTO/Q1z45imb94j0OpitNKhrmhamIZzY+QpvLNvfCrGfi3Bbo=
X-Gm-Gg: Acq92OFtFl2Fi/jurQ1utc5CAe3OVKT5VBw2U0b2E+yYf1jZH2r1d2gYTWbE/6lojsK
	yevsSjQ08H1gD89Coy2rIjXwn3+sa+d3OW/HSm/foGzR+lgifWyK/34p8i9wHxjCTQP7r2eZ/Hd
	sScZLiZ/lGYuSVNoRBSzmOmWPTRTqQqgEG+c/naSKL5trB/hzgjeX6wMAaaohmB7i3W5ExESdOI
	eey+cItOXYdlwqyaVJ92PA96J0R7W83otKCWLNSWMOydhqDqAJ+L99PDiUn+b2HLhYysETO9PJO
	qoK0QON34fDdNcBm8ob56FFBEojeL14keFsJiaE8dXYwEtQUHRy65arSF8SsQtnWTAEPyXgBWha
	nE5sCo+SNl2L+3UMWG0uCApzJHCQFdPpMkzSAsmM2D5ZYYjLYuOw2u4JeI2NvJMSHW8koukdsbz
	2OCuhzfpAWGgNiOH6xdgmix6mptAx18T0qEyAWk1I+VZxmPgPcGawbt34P4xP3WVQe8A==
X-Received: by 2002:a05:600c:314e:b0:490:31e:d6fd with SMTP id 5b1f17b1804b1-490a2968488mr16252265e9.25.1780084200053;
        Fri, 29 May 2026 12:50:00 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef357635fsm5573661f8f.33.2026.05.29.12.49.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 12:49:59 -0700 (PDT)
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
Subject: [PATCH v2 02/17] accel: Remove AccelCPUClass::cpu_class_init()
Date: Fri, 29 May 2026 21:49:24 +0200
Message-ID: <20260529194940.97143-3-philmd@linaro.org>
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

Last implementation were removed in commits f50d0f335a6 and
a522b04bb9c ("Remove AccelCPUClass::cpu_class_init need").
Remove as dead code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/accel/accel-cpu.h |  1 -
 accel/accel-common.c      | 33 ---------------------------------
 2 files changed, 34 deletions(-)

diff --git a/include/accel/accel-cpu.h b/include/accel/accel-cpu.h
index 9e7eede7c3c..88c0815e2d8 100644
--- a/include/accel/accel-cpu.h
+++ b/include/accel/accel-cpu.h
@@ -15,7 +15,6 @@
 typedef struct AccelCPUClass {
     ObjectClass parent_class;
 
-    void (*cpu_class_init)(CPUClass *cc);
     void (*cpu_instance_init)(CPUState *cpu);
     bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
 } AccelCPUClass;
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 62590a7d9a6..ebc103053dc 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -32,42 +32,9 @@ const char *current_accel_name(void)
     return ac->name;
 }
 
-static void accel_init_cpu_int_aux(ObjectClass *klass, void *opaque)
-{
-    CPUClass *cc = CPU_CLASS(klass);
-    AccelCPUClass *accel_cpu = opaque;
-
-    cc->accel_cpu = accel_cpu;
-    if (accel_cpu->cpu_class_init) {
-        accel_cpu->cpu_class_init(cc);
-    }
-}
-
-/* initialize the arch-specific accel CpuClass interfaces */
-static void accel_init_cpu_interfaces(AccelClass *ac)
-{
-    const char *ac_name; /* AccelClass name */
-    char *acc_name;      /* AccelCPUClass name */
-    ObjectClass *acc;    /* AccelCPUClass */
-    const char *cpu_resolving_type = target_cpu_type();
-
-    ac_name = object_class_get_name(OBJECT_CLASS(ac));
-    g_assert(ac_name != NULL);
-
-    acc_name = g_strdup_printf("%s-%s", ac_name, cpu_resolving_type);
-    acc = object_class_by_name(acc_name);
-    g_free(acc_name);
-
-    if (acc) {
-        object_class_foreach(accel_init_cpu_int_aux,
-                             cpu_resolving_type, false, acc);
-    }
-}
-
 void accel_init_interfaces(AccelClass *ac)
 {
     accel_init_ops_interfaces(ac);
-    accel_init_cpu_interfaces(ac);
 }
 
 void accel_cpu_instance_init(CPUState *cpu)
-- 
2.53.0

