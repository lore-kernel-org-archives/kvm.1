Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1625A33D505
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064809; cv=none; b=dYQUdG8JRM6Y8GCRh5FnvnEv6GhegZOTyXyOcimedRPgNLNkSboG0p3TqR5+L7Kp5RH8wY2UZNKVnlphyO3voDGDjH9nX1vzO8wxIT79EF2bpCZpLh/JYr+3MqM9Y23R6A9ZJDuBbqfF3fBbIcotE/LNog6FDTRaYWRY3jbkVpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064809; c=relaxed/simple;
	bh=Ocs19irIjfDOR1vovaKMr0waJ5dwqy2kicJAQ3uxDgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XafuyTry4C6Qx/mZSQRcoSvRukvQDJN6rcRMA04XDArrq8QHl712aN6UDQjvyQ/8WT+zg7JvALMTOZ5CxqdQdw4Y3IzgecjIvjL+TWTxRkb0r6tUs0tWO2Rd41TfrvEk35PEF9vy4v+mDzO1ZJ3wO9si3qZ/470hC9rAmtqribg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w0+eVpbD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w0+eVpbD"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso83301705e9.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780064806; x=1780669606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5ag1C+2SG1c3WsflC/6w87NYFOhc1Xx+nqXj9RTveg=;
        b=w0+eVpbDiUh68Q2ZepZaGl7fvupuRq6Bq7mg5IkiqInyTYCDx9o2d3jEf7+DwpHeGL
         e4ms48jSdVGfiuGglFsUsFn1aB8sPYDcFc4auoipH+Z1QLk8RryBA5eWuLouFjydMw81
         vjhY2AtUMtIl71aJsJQ8YsFpmf0DD1ue8McJhKyc3CQ7BNV4C+gt+RVH1hl0eDLmIlDu
         ERQA5i7VsWkPQgaOtXzLI6KuKm1YSd3gSZliqkS4iz5rl0CBqNQMxESgu3ZrJFaKe+Lr
         nCNW1ualtfk8QKlskoLjg7gGd/Ttj2wPPcEQiMpvL3j0oUht8fOIXrgyCG/FRlg9Jd43
         9LEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780064806; x=1780669606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z5ag1C+2SG1c3WsflC/6w87NYFOhc1Xx+nqXj9RTveg=;
        b=Epzx61Vn010Y/46/EwvvCG7feO9Pxkk+QvNQDEyImVFTFKwzwzx7R305Dte3V28uKm
         pdU8C20WCXxd+2KSdVHB5dQt8bENvCfY6u3N+yzP8z/s904JhFyQcWjdzcppf8TQfx93
         I0JdlDphv/EZdlcmqQX4jhDA/n8UtNGqj3WvpfG7ApR/hE3RiJtTV9L03uNfP/L2BO9T
         GJAp5YrxIVpkZQd7nk90s7805dKGcZjVSuMcwA00I3rOmT1uP6gm76dq7oAiJfgaPBiT
         zFQcm94miANTk1GmDYkzg7MYjpghP/6omhXFbHPRHjBqji/Qfc/eR+yuyKUhdxC1u0Rw
         c9jA==
X-Forwarded-Encrypted: i=1; AFNElJ82gemHtIKei7BGr1jqwS3sjBbiF21dXGTym5s+2pkaJw3T/YJmMZtkrH44obkuFYfbkG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8vRXuxs4lyXranugKAARdsMW7FS2ZWXEhZv3QIuoMSz7k50+A
	aJA2b2jvLiTI6zoNyVAgNE8G17MM/hJYMvVoCdgL9oA9IAmjqvdgTaaGpyrlnE6Zs1I=
X-Gm-Gg: Acq92OEX47OzgUdIuXhd8ePTuPOsusBdXqqduClvwlCq3AZHxL3OPNhzHm3D7q5+WeB
	lF22Nji/7CcztpqjB5f/QnssDiyNBwmGvrbIF4HxDszqqMe3h8S1zy45LLXnNpdrFXUe74gNiki
	1jBp91va9uaThkNM9LfOldlmC83QyMsmMTRHTu4Ft//pKCUNEmTLjJzht6GLKYsByGuGpThLzI0
	4x2wsou74UDGbM+oIsyEZiF9B5FHMztAeCpmuktd+nGSQlaHCirMNr/WQRwxxgBk+xkXWoHwk5H
	CEh9H1IuHvuf14IITj0liLF2KdQuDWFd5IfgQutMwNWQQfC9ThUklVqXafDD+wj9aBiz5/IA5ds
	sOkNb2kZoHquPYQFFjLEeknAM5eXW04SL4R1288+xlJkHDlK/YQFPkPhp/zLiH6WbqRfO4zOfcM
	59I5uBkbLPlnJ80h2O1jqZe4sDgGRVNc2U0MbDbeLL/ELjfWM3eTYdQvoCyz1L/fV7fw==
X-Received: by 2002:a05:600c:a105:b0:490:6e12:542c with SMTP id 5b1f17b1804b1-4909c0e4476mr45336475e9.23.1780064806113;
        Fri, 29 May 2026 07:26:46 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c103b98sm14989405e9.19.2026.05.29.07.26.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 07:26:45 -0700 (PDT)
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
Subject: [PATCH 16/17] accel: Remove AccelCPUClass::cpu_target_realize()
Date: Fri, 29 May 2026 16:24:32 +0200
Message-ID: <20260529142434.87880-17-philmd@linaro.org>
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

We removed all implementations of AccelCPUClass::cpu_target_realize,
remove the calls in accel_cpu_common_realize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/accel-cpu.h | 2 --
 accel/accel-common.c      | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/include/accel/accel-cpu.h b/include/accel/accel-cpu.h
index c42221f96cf..d7ea45ada2e 100644
--- a/include/accel/accel-cpu.h
+++ b/include/accel/accel-cpu.h
@@ -14,8 +14,6 @@
 
 typedef struct AccelCPUClass {
     ObjectClass parent_class;
-
-    bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
 } AccelCPUClass;
 
 #endif /* ACCEL_CPU_H */
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 04482b6b57e..d8ee6d62667 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -52,13 +52,6 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
     AccelState *accel = current_accel();
     AccelClass *acc = ACCEL_GET_CLASS(accel);
 
-    /* target specific realization */
-    if (cpu->cc->accel_cpu
-        && cpu->cc->accel_cpu->cpu_target_realize
-        && !cpu->cc->accel_cpu->cpu_target_realize(cpu, errp)) {
-        return false;
-    }
-
     /* generic realization */
     if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
         return false;
-- 
2.53.0

