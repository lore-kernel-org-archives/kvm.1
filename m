Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07087343884
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064696; cv=none; b=p3wp0Mj2CtSl9JAfjfqJvO3eL2mqQOWqaiovo7bcKe3MfF4N6moEAX/NqIpMpkquvpNkPLb7MzLhfhwzGc8CeVv6DvPlQfg5juUpV7dxERcwKCQKUxBOQS63t73CXz94Z2Nk5nyWvBltFM0ZOUz2cSgK7vvca+/YUCb5GCL4pTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064696; c=relaxed/simple;
	bh=613u2vIShqA3do4v5yyzpbFuJq4htomvUTVVwOX34dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QypsLEqtXgAeloLX72AcpEnf2J3SaSR/9YRJvxnse/ZjFgXjKzSdb3MHlNGFjHQqnDemC6Kbms30CsRjVhqpKgLDF6Jrt8NhRltNNrPkYCpSc/rLdPCsmITI2xV96rs6Pj0STpBgr/u7IdBlJQebWNnknfhKgM6SHCGeYWDNwqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VOWVx+0j; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VOWVx+0j"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49050bfe053so45743225e9.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780064693; x=1780669493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFEMIJ2KJOaWjwhyxDKINz2zmIup5qa01FGrlMeKBW4=;
        b=VOWVx+0j1fB+6/ff288Fwi35TrcYMNPdp4awgKmVZyc2lqcBA2P5UIwj7F9nmHSG8P
         PwAMmLzoAJchYJuDXU2t9pCXqRDN5ts2w/VQuSGoD6dkUSk9pKUZlAOarATZL1XJjrkQ
         Tb1cpLmtdpIfnzZlh5rRdLJhu06mlpcQ4venchwz+5ala/APuh9/Uwe6PwV1o4jenKW8
         XMLaT67jnCttd/jJ8VBNHMjgLQcQWgvzw/a7P7ji7xLUlO87eTs20RIg9KqRGzTsiTXi
         8Pb7f4tPOUmwUntqP5ssFw1ane1SJHtYZxyWoQzlsmTfTx24kyXL611/u8iow7289r2y
         P/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780064693; x=1780669493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nFEMIJ2KJOaWjwhyxDKINz2zmIup5qa01FGrlMeKBW4=;
        b=dq7l2h+zyTJnj1as9IXHMbZ5a4AnFDI7vSjCMiXz+tiubpXqc+2sxC7XSTR/sJEIcu
         UlCjXnDpC75eSdNKZk+TIP0Z34gJohRAgPwW5eO14Ye3WkFmm3gY5CGPaaUaqrx1oLbg
         gUEud09Yn3WQiqoi7mV/+x7IrCNxAumK1DAHtilRkOQrjEU5sKedqbg4W/9OSQUmmWrD
         +JmmjcsUD7Evb5ZAI4I5DogDhR8iyYAOcZLprlVo4eZqtfY7YG8FEFyJPTfDcA13pT4N
         +TVSKKM+qPyOvFJhg4WUUJfy0DIW2DL2U3oRPBfW+3AsQKk3DI1QPkAvS2YJPX5U1YOK
         1JQg==
X-Forwarded-Encrypted: i=1; AFNElJ9HMsizzmPYvCvrnFOS0/CabeKLuFNJBitTwut4p3QXbFJJhHJ+toD4/yjoBNm5+OSRD5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC4KWUAX6kCnEupeKy7HJYuOcxtY2KCDCYZdx1nbVYyr2dvHwX
	4aObFjM8lBfDeicA6JQ6xrWu+EhDM6htQLEHGqOnbkGojH9nwP6E+1abvnUlq+Q7Haw=
X-Gm-Gg: Acq92OHnVdTvLG5ePJiBfIgRAFvkqzHtjCZN4ltVClHKZ9zs8XC99YM4eKkIo2BJS17
	FqBC33xJ2YyAA3D31xuEQy6oB6InTt6nGBcizRlZeoHooikeFFpPCHckUKam9HxmWf3zoYpD3Ld
	8dQ3zjcglC6EoIMTdLbgS8GFPv+KfYv6vplbzHRRGtI/IeHCZvjLTy3SYsGzuFrQP5tYuMQ1O7s
	9Pzmg+ygNZjn69kXlcyUytbtHqwzHV51xrBPr3pTA0L3HJbHW3vc49ix8Rw5QJtZRdOw9yCbUx8
	IKtosr+td/7p5Du46EZDT1kmcrYCrmKD2qrcoSrZ0HMxinWuaIJw7kH2F9aTYkk0Vcjtk7/ma+V
	dYWYaCEZn/OQkDffdkv368jr55DYnl5rkRY9yYty4nsHpX9kMlVhvLPTYyslMOUk72HR5kAss8N
	NBd5OgdKsecrz7iySdy/XD+/4yln1Qzk1yz1YYs4Ww1ZBytcp6kjDTv1ZdccKyC1xhDA==
X-Received: by 2002:a05:600c:1d18:b0:489:c57:7836 with SMTP id 5b1f17b1804b1-4909c0c7ad7mr56817125e9.27.1780064693487;
        Fri, 29 May 2026 07:24:53 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909ca6e124sm47683785e9.7.2026.05.29.07.24.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 07:24:52 -0700 (PDT)
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
Subject: [PATCH 02/17] accel: Remove AccelCPUClass::cpu_class_init()
Date: Fri, 29 May 2026 16:24:18 +0200
Message-ID: <20260529142434.87880-3-philmd@linaro.org>
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

Last implementation were removed in commits f50d0f335a6 and
a522b04bb9c ("Remove AccelCPUClass::cpu_class_init need").
Remove as dead code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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

