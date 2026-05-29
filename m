Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2084E23395E
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084288; cv=none; b=iwsYgcT2zpqx3H8cOoiGr+IqSNJ9u4R9P5mMEfciNK7GcT7MwuFw4LCfQPhFC7bjx6o3Vjt0fD6ZzWaa07EhzPyvSmujeA9pcj2U3ZxYGPxDg3CxH4A2xljtYIl/rR/lfQI7Ma0V58hihRj+XmUyka37G0EaMXPAcXc0pI2ba8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084288; c=relaxed/simple;
	bh=+2NFNsuULDNtqMYbMPyOfyZTT6KgBIyeKmTx+3qd4NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYuPvFtCDRJDNcPIVq9Zhd890QQQ9ChCOepN9dUnkWuaCTcXwyM9JIh0IXGB1fB1ISNO7cFq/f5jQ91vyqBq4D+0VWwmKXwSA9DXyuKugOsXlUwrUNG+20w/0OgH5NnF2iOIUpdCtTRz84uNPBHrJaN+iwbP/kA/hReuU6kTMOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SKFT8y5j; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKFT8y5j"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45eea3448f2so1224916f8f.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 12:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780084285; x=1780689085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayZcEqBv6LCuc8yFGoECVuWb6aDn4koW4Fzg+F8BkqA=;
        b=SKFT8y5jhtfD5+X1fSnAiBf2ZoE5QqOCakitgKFD2khCSp7c6i3s5ndmvnc+8+FsMd
         YlBvfnxMI2Pe2gKnNVxxcZtaX/RybL7zPJu6pjrVaYw+Pi2ivYmR1uWvBssoARHWOZWd
         3C9kQFrlOKbVvcI2XqZuy5nyExd+qOQoHx8/x7uVE3i0sancydmajvJHTZUVQgCbpzLh
         RrKSZIZlqTF8GyBNJcA5IPUNY5cN8uB0eU4zvYYi4iXlGs4GS/RIu0xdtm1AIFPmBAyS
         wbJ3EyggLsnMV85JkZb8hsxiHTUKP4ejX5LiYNFaex0+uy7JgyvTDastvqnuq76Yb8ur
         MMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084285; x=1780689085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ayZcEqBv6LCuc8yFGoECVuWb6aDn4koW4Fzg+F8BkqA=;
        b=GYuR6GPa5Okk9ZZi6YOtPC44jvQDNPg/V1MjktBgBaET4V/bSumv5XPOG7Hdi6Zt+s
         vrOECiaaYi1wgEPLbkkW9hhMXO3GkOKxdjka//MBJUInbeZU9GRIMGwW/Km146JJOolK
         j3EqvgHQt5J7uRFd6xwQENbvepFhwTMnHFy0SP9ELufEq919h3D29xnH6b9JYNBdXdfL
         Yl8+lh96bPUJmXG/Fab1fjEFuFTtjPAtJlW4pX1J70ZDAXOTZD6Wg+vURbyAAz+NyeVE
         Xagu6cBjxFnD5Lma69fr0V0A8uBm1exqgh9amoA/dtakpUGAcgT7hYqDxtkZ3Ez20qoX
         NyXA==
X-Forwarded-Encrypted: i=1; AFNElJ/stPhnMMcJr4rDVawOEm06sad7TC0DrHK2LGjgHgCDHY04yZYOkGiyevKO+c6qoPIZRTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgezmWztoFLAe8K5vL/nFYk95rVBBs6rXIwIclN4V+zAH7UKpg
	RUv7hdkAk1FQ2BXnPVmKD3QkflrUvnVBRKnkt7DmZRWRuyy/yhBPhXvtkjNY4VkcCYM=
X-Gm-Gg: Acq92OEzG9ELXgsQ/Od9Z8jOjEhVrxfGNBTUA3P87s4spHRAeDKKsmZf4qaozggTGdM
	nny65bUJhbl3rXOBSZpi5chOhDgVBNGibeCjGVrpLmIAMKK+qnnWUqtmPjK2tWF9gcH2hHr1n03
	PqAGIR4gNiNq5Gro3LSRJv+qXVgoDDpB/n/ndoWGDo01zBEthXzKoWU5XVcNPVKQbDnXMVUsDPm
	Ud8oB8ipQJoIQBd4iQiMDZV4dgN5KAYh1gCGkG4yfstg4T5ASu4mV8HSZpLJspUqDZnAQKZCM0w
	wVPuTgYX9mdAW4ULxSopebdKcGpbkMAhNlrgrCM6G1wD156OwzCvucVkfT+FEDMqAMaATGEGWSD
	ggmVy1IUG2BY1t8OeIoWMbpwNA3JxnNAtu+ky6f0zP1A9Le/tmMY6aREx664fVnHOV1u1jYduuz
	CeBq5ogQNMXmRWjMIb6FuBzW66mZpD5CYKPk2w2KqnRh9ndC1qgxeW1ars00WK5a0HIQ==
X-Received: by 2002:adf:ed43:0:b0:43d:7dcf:ae26 with SMTP id ffacd0b85a97d-45ef6b78552mr1841372f8f.34.1780084285470;
        Fri, 29 May 2026 12:51:25 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef356b129sm7392104f8f.32.2026.05.29.12.51.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 12:51:24 -0700 (PDT)
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
Subject: [PATCH v2 12/17] accel: Remove AccelCPUClass::cpu_instance_init()
Date: Fri, 29 May 2026 21:49:34 +0200
Message-ID: <20260529194940.97143-13-philmd@linaro.org>
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

We removed all implementations: remove as dead code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/accel/accel-cpu.h | 1 -
 accel/accel-common.c      | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/accel/accel-cpu.h b/include/accel/accel-cpu.h
index 88c0815e2d8..c42221f96cf 100644
--- a/include/accel/accel-cpu.h
+++ b/include/accel/accel-cpu.h
@@ -15,7 +15,6 @@
 typedef struct AccelCPUClass {
     ObjectClass parent_class;
 
-    void (*cpu_instance_init)(CPUState *cpu);
     bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
 } AccelCPUClass;
 
diff --git a/accel/accel-common.c b/accel/accel-common.c
index b3bcd53a4c6..04482b6b57e 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -43,12 +43,7 @@ void accel_cpu_instance_init(CPUState *cpu)
     AccelClass *acc = ACCEL_GET_CLASS(accel);
 
     if (acc->ops && acc->ops->cpu_instance_init) {
-        if (cpu->cc->accel_cpu) {
-            assert(!cpu->cc->accel_cpu->cpu_instance_init);
-        }
         acc->ops->cpu_instance_init(cpu);
-    } else if (cpu->cc->accel_cpu && cpu->cc->accel_cpu->cpu_instance_init) {
-        cpu->cc->accel_cpu->cpu_instance_init(cpu);
     }
 }
 
-- 
2.53.0

