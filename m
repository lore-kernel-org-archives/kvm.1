Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E521332EC1
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064712; cv=none; b=uMNRMdEvUQi7hoCOd3E4wIveRxzN6RGHsrXINzSpSgVrHhbKUiNzP6DoeP33v9MyFr4OrrNjgY7XOaHG3b/0OzbGXRXx1jLw/OouAD5dSCybwC6CEJqTR6Oqzcml+M354wyI88DkCK9ru1mpHBJDm26glbkSmSJWVyjDAHhTGZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064712; c=relaxed/simple;
	bh=k31f89fwGdKz7CcBDcjqdEB+pNj+wXNBOoccjy5z7fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bLSCvyhr2vTnhQMB7WP9aNBFnV5YeB29yNosG2FoSQDGXsfuQbYtWXUTgTnZHGzD9FRc99r3a45G+CzhJLe/fLfN1gJhPKbXmkl4qFWBWzU3zph5tONYH7szBq3VgGPbYEP521Z2UeEdWS91SS+sDcKdKoKcHv0k1oJSUlgp0cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AabfjQQL; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AabfjQQL"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso121170855e9.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780064710; x=1780669510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6oyorGlH+SpcUBdmmr9vp9bR/hdFD5W9NOUghfpRrA=;
        b=AabfjQQLUAUvTR8rKuN86jsgtAd+z97qexEO2xhPiafT4B7+knZIglGCL8hZjreg5b
         ltoFHt6TGmXV3FH24xGwDSXMH55bKXPD5SJ1eqp16qyFy/rYqYZ1c5Y38QuAV+ZRMyHj
         0YnAgKY9XGyneTm2CZTsG2VKotPWrL38Amn5EwMwQhgWk9mMX5DIsTkj2KvSZk2agu1B
         48DHBN+aCpjLs4MVtTJjWyil0IWqGrEpdIM8DOnU9RLrQuc/g/1jg0czu5l5r9kGHwr0
         XuW7Gij7HB/Rib9/R9XJlDlu5FM9dQsjlVfS2aPuo5G3Vzr2HlCGGv9RvjuxQbJUpjl7
         Es/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780064710; x=1780669510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P6oyorGlH+SpcUBdmmr9vp9bR/hdFD5W9NOUghfpRrA=;
        b=rX7fRmV06nQkvpdww7uNEk+rOVIJ+fDtQ2BilyZWf/umXh5zk2NY1YiJAXbGDzaZWg
         4lVLfIBpIBTTAT615f4OTT4tFEOhPb9AAKPVIyUjIX9McbAZoSkEgcgPgsrrJMmwRjvW
         AFTYz1nycqo5pKfu2VZB+hAz9eQBqjTQJgs+dLDOR2pe7QMfqunPgJcY6veXtwEE/4H+
         6kNQ/W+tiDuEnWG1+xWUoOHjjcVyZqRYhnhef+3f7sCqBQqZIC4y3s/Mway5XvvGtva0
         2B4I6dJQ+MJbxK2rzDnkDaM0mMethmQHho7sPPslTWm3Kxt57v78juIai7Uc1Xr4hqny
         Tarw==
X-Forwarded-Encrypted: i=1; AFNElJ+ySJTBhlGfNi6loqCu2VnIsDdEsAkznssSyEUnqM9PwG+DmKwkBkh7ytkmFH1rG2AXDXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjVR5Is59yQdVPsV8XBOZezhMgJdR/rawYBYerW9BaY1QkIHgc
	WyavCdc/J+xuJMT2iasnOKqozsmKpvxSKeZ1BOK3cmTls3mbBDLwvGoITiElYQcsmsE=
X-Gm-Gg: Acq92OEorK39BTngI9V+PRc8H9zjF221MixMRcKYY5RWAcC2hBWN4TQUwxVbeqmIoNZ
	1Kw6ugEGJ72ZMjSQqO4qI3MDksJzUE1vuKtLjiSnptC7GQt4Q5S9c8MP7Yg5N7+qJPKTfjJc4MM
	uNhCtaTgZwqIZPrtEl/RW8svGVWb+1EQ+no/CByQrKbe+yeaSBSwClELbhGMYviOO0yZVD1autC
	kCEJWWOSygYHMHW2Yonx4Ijrj+WBNcIyMvptrvkSeAnof2NJHlsfzJneruLxVw5lMNrXicgi9r2
	GLjuZ/rubMpEUmYjczSzEOIwfkUQenmD2usgzfz4Zs1qwQd6B1uga9lyU683UxG1HFyHiGsgkFd
	pkkEOaTqlNFhEXSzLDuDfhCN/jbKdgyQwZUoeP79UAGIYkcwQC8TlLZV2aSWzLviHXGVGv+Lq/h
	H+mSxkmYsDoQDuu/e/g1f8MX8uX7XuowH2EeriNUIbiFnBbKWBhVijw7fhhPAZilpJ5A==
X-Received: by 2002:a05:600c:e489:20b0:48a:76a3:2b9b with SMTP id 5b1f17b1804b1-4909c0ba7camr44898955e9.17.1780064709341;
        Fri, 29 May 2026 07:25:09 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909ca72cfbsm49313385e9.8.2026.05.29.07.25.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 07:25:08 -0700 (PDT)
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
Subject: [PATCH 04/17] accel/hvf: Remove need for AccelCPUClass::cpu_target_realize
Date: Fri, 29 May 2026 16:24:20 +0200
Message-ID: <20260529142434.87880-5-philmd@linaro.org>
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

accel_cpu_common_realize() first calls accel_cpu->cpu_target_realize
then ops->cpu_realize, which is set to hvf_arch_cpu_realize() on HVF.

We want to remove accel_cpu->cpu_target_realize, so have
hvf_arch_cpu_realize directly call HVF AccelCPUClass target_realize
handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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

