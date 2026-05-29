Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EF73E8C70
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064704; cv=none; b=hAe5HZ2Tyh413dR6tLQcP/SPVbPMhEvyMMuRSjkkt6Y3NhoF8ktpUBFpX0fsJ6Ca2f/f+0SjhVLUyjZyr6Gc66N3MGYJNfLrBxzU7q1hbg8lsAvqiGiAdyxucCdWvYinffMftt2NNWiUPpTZ6ChFHXqbFEhNd6c9VjHa1LtJ9UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064704; c=relaxed/simple;
	bh=PG22ST33UI6mr9hIXgnWlrnUjkyybLC229sshMhThJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uq53kc1tpGkjv4f0Mm3SfBMRVDAqW3zO6mlVGFSdwOBvC72M4828e78CvCD4RyfXuPlgs0xVusKbpkvUnNASpionQYPKSu0FQPucDll5EcWksA7rZ7VJEaZCBjcpEQN42wjik+ld4Ujv0tH7y1hnK2LLt5ixYC9zPJXK+YDgoxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ydagTYen; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ydagTYen"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4905529b933so56446495e9.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780064701; x=1780669501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jW2zG1X8bHmlXnWN82TlCGxlIo9/KiyZAvhHEyZQIgo=;
        b=ydagTYenwEgOzsovQz86r326xJ43zXW0F9q+hHby74aL3sbLvClDpOamqWg/0rBAYB
         8EfpQHHWKGiqTdzVmU1YyLb1M9QsXkfn7vuR37h/seArM2crQG39+kryzB/3aM1CIA43
         64qt6GtaWwtSCn7Lgctn0aI2PtAWlnmqBSKB0RF0at1hDYPEnwvU5fXdVPeXVmSGrgLA
         M8K57PiAqC+ECmoaxJs4fodnQr+HY+ClajTBduMyW3ZbKOtsGJnbgSuNZYYznNIQyJan
         dTHhuUppnmIGRSqpUZg5KJvy2XqbWExs7XweRtMC0GJ4Jp0sbT81G+vidaNDCGrIqOgK
         AZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780064701; x=1780669501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jW2zG1X8bHmlXnWN82TlCGxlIo9/KiyZAvhHEyZQIgo=;
        b=pceuECkaybj7cp20Hu49esvNqHB15YbeDvsgIO29vTkZnFyz/6v3KjtBKypXHfM52Y
         8Cbk4bZSpn+L4LKshmVdsuKJ2uOQORFwP1nwzgM44HAAgWYDQRkD5ospuOWr39AAbZss
         XSjbroX610oyTlxA+l0HQj+tnVhTY28eiy72djhMuq8fwRqFNL5faB/TmmGpqJ8DBQIw
         BscugD1Vw2g8pqM2P3CpdHLjaAVxqfe7QlYr5017gmGIw+TXnYSf8gYIdfw5XF8b0oKm
         CPzRVSjqg7pnLU141Yg+oBA4pW25VenLY1LAemUGfrWp0XRZQDFJW4VBhMzDEog07biy
         fX5g==
X-Forwarded-Encrypted: i=1; AFNElJ8plqR8gSh5LuBIIYapPleAnnd5tj+p9f6OvaYGkqW+alB1hUgiwkI9yQzvKl4CKTKmZnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG0F7dTYPjMqLcnZkBF1Nbilyp6E9aXcgIDrujqY2mEzN38T65
	pSKaHziMdJ5ZZq78DDkfRLgFzHSyZg3Hm+9a/XeHvm8KoeJnJ4rzXQMYBhQHIWdweJnVGPZI0y3
	10bTD4Iy1Cw==
X-Gm-Gg: Acq92OHW0jgaSnyoTNdBNu9MxjkeqgUod5UK4lavnjjEUnzXIEACklfZ00akgH38XUJ
	/kvdlt9FL12VZQdb1XMIJc4pvGOtHZQWsFMlZckSUGDIFCAbkPPxN1bn2S/4If/WIbhl9TCP/oi
	XhEi6Ik5rCsNsiePRRqZHV4oOvVf2WSHFaDbusUElpb4hamktL0plstTMNEHq4RIlhv7GRLBAhh
	8dMRtraIFbprRIIymHOTjZQ9v7K/9zdXLYJ39VOi6iBB675+vPqnIOyNQt9pYxxPiJwCOfAe1Rm
	r2CSZmBMD0r4aTIm3vE+qvOLNBLGxBQ5Arr2I4zo63R9Y+sjLdfy9xIx2K1cMzCg847WA0oxKlm
	gh9Nud5YvfP3M7uAw9nUIRt5QgkTfvU2JBZ7HI/0DuQziIM1t2W3+FqX8YITqZsn6po65GTnv33
	OTQWvAyL1xbeFe/Ddx+c1imNoB/huyjquA8eXan+La9TRKa65c98Ya48YxAc9UthlNNQ==
X-Received: by 2002:a05:600c:1453:b0:490:9536:c513 with SMTP id 5b1f17b1804b1-4909c0b0012mr40361385e9.19.1780064701417;
        Fri, 29 May 2026 07:25:01 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d696f25sm60774685e9.5.2026.05.29.07.24.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 07:25:00 -0700 (PDT)
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
Subject: [PATCH 03/17] accel: Rename AccelOpsClass::cpu_target_realize() -> cpu_realize()
Date: Fri, 29 May 2026 16:24:19 +0200
Message-ID: <20260529142434.87880-4-philmd@linaro.org>
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

cpu_target_realize() is misleading, we simply want the host
accelerator to realize its things on a vCPU. Rename more
generically.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/accel-cpu-ops.h | 2 +-
 accel/accel-common.c          | 5 +++--
 accel/hvf/hvf-accel-ops.c     | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/accel/accel-cpu-ops.h b/include/accel/accel-cpu-ops.h
index 9c07a903ea0..fd1307dad6d 100644
--- a/include/accel/accel-cpu-ops.h
+++ b/include/accel/accel-cpu-ops.h
@@ -34,7 +34,7 @@ struct AccelOpsClass {
     /* initialization function called when accel is chosen */
     void (*ops_init)(AccelClass *ac);
 
-    bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
+    bool (*cpu_realize)(CPUState *cpu, Error **errp);
     bool (*cpus_are_resettable)(void);
     void (*cpu_reset_hold)(CPUState *cpu);
 
diff --git a/accel/accel-common.c b/accel/accel-common.c
index ebc103053dc..176b03e0e90 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -60,9 +60,10 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
     if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
         return false;
     }
+
+    /* specialize with target specific realization */
     if (acc->ops
-        && acc->ops->cpu_target_realize
-        && !acc->ops->cpu_target_realize(cpu, errp)) {
+        && acc->ops->cpu_realize && !acc->ops->cpu_realize(cpu, errp)) {
         return false;
     }
 
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index b74a5779c3d..6edc2242ed9 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -356,7 +356,7 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
-    ops->cpu_target_realize = hvf_arch_cpu_realize;
+    ops->cpu_realize = hvf_arch_cpu_realize;
 
     ops->create_vcpu_thread = hvf_start_vcpu_thread;
     ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
-- 
2.53.0

