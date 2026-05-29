Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5AA367B7F
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064729; cv=none; b=QvGeuVmCPRv6D92mRI8kxLjli4JBEKoK4mtwzUgjXGLyMQS1ZlImXtFpDYzm0KdWFAtH+P/4Id3+Xt/U5Ntz3Sg17xqkxNQOFBMeHiUkAO3qWgUZzSDjhEDx1bGYsjjNTZORuh8dmDTEoSIGJ0SafPeIFeVMbDMmZAUjQQ29k7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064729; c=relaxed/simple;
	bh=1S0MHTUuKXIAMnlqlVBlnAA8aF6TMqNjSEXzJAK/Rr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOqJ03nBF1qjIru6zyT3thag+aBWmUtTk11fXBJsz7XgjNIumioIJZlZL31rK41jCkq7lpAC8NsYte6FMBWJghVoBKs6ruen+p8l9YkagCixYICmk6V6G15zSo9NKAHYsMP4s3vVOwTaXkzgZN2q1QNFMYCK7Tij/GWRGrW5+7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vN/WMpaS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vN/WMpaS"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso121174505e9.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780064726; x=1780669526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bh2neLmp2yCN+no5zdf9s1S1CTB1NaAAPjqIYQpJDXU=;
        b=vN/WMpaSo0Cd4hkLTACiuyqX5791lJYmFV7GXWyelzYyNQ9y7S+hXfeNEQMFYG1MRt
         0Iqy+zB+eDkiQO1VCiuH/JBUjIK3koM7ANuJsBX6A7wxx+CBiT7Mq6a8dC0rumEG1MuO
         jXXsUlHzCo5HOipI/uxD8d1xoMk8F7lCr327eADrpd1x580ryMdfOpp6lZwBqaxiqYD7
         K2mi4xdRWP+WAzffi/dRFMIe8NV0gQchtR40pHoob+ydrX96bKDUw04XYgieSa6CGjDT
         /JaqOHER3UC8Pobnp7B6nG2EPAkPDbCYtWL0mhUc6T/n1pKSx8dD9wQ/WyAmD+Wu/SDj
         VbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780064726; x=1780669526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bh2neLmp2yCN+no5zdf9s1S1CTB1NaAAPjqIYQpJDXU=;
        b=U2FQS1zASODU4fHV7AO3567aUN542NtawDn9p/U2rJYDQPeyMTGbDHUtPfq2h96Dbn
         6oQmU+JH0vl1kqobei7jaQKmQiPZMYszcDJs8RCLD+bSnYNgKXBnnNyU1KoGinXq3TQv
         icPGbG9tjLCgOf50xkCg9sb77NEj3gZvR/sxXOIV3PijtATn0/Wwblt+gAvZsyOYkaN/
         SBmHyNdOGizBe24l+rbyXcn+BXOBJLBcftkZgq9wtqbGq2LNEGlom0LN1ZEMl725y+ox
         caB9XJga0J83LMdDZA/vAx0ROX7tZhkupWcf3SYLFBQVPS+8ux9geUksV9yCQ9M5qEd6
         okIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Kro1AXgIWRTgg2jQ0RQXAGtZSS2f+nHzK7+M5uBoYRxiSVyKnf7Dist3A11gaXrujJfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybt+DP53/89WE3TB44BQWfcDgLEN1SAVWUybbyqUGfOSMWxqg4
	x9oP1y+xxIFom0M7h9/Zg7RoSRwrf48VzkQfCfp2QYWThNayBAK0dUxKks5f4h1bik0=
X-Gm-Gg: Acq92OGmWpqby4qlBZlh+nc2R5qn7VcKHOv8kv2f4sAzgyXylju6PqXre/RnUYXAkKs
	ZIbomn9LQtrYglI4gY1/rMihEXpKQS5mqTbMS3tTslN9XLF/zRnFBiC1Uw2YdwYlZ5N2ZDJZBcC
	0pIRNhEYw+Q/S8eF+roD6YL8KYOyTe6XW+6EO4ST1hmZRe/luJGsXrg+DoJSnkljCGnCsZT7u16
	NqvCeCsGI58Y1cokQhFVSh72eiMFN2nkGyIROuSM72FtZtUcOYBQTpPjETILgT1tAgQTosQ/snP
	6pQyKl4HkaSAjL7CVm64d+imqM26L2dLmH9I2td1XfQjFcaO/vPqi1j5YH1qjTDTOSL4iwEELzF
	cgQhKwuSY2AbPO5TjH46t6majwbweIeEBjGnnfwRERV/qasbD9SIEC5AqkDTPaCF3TfmrSAZwfo
	KKmnP5OdVTKz9IKJS5iRvXfaofgxFooTKKmIN2jIy4Zsn788NVLTn7h/H3vxAsqceZo0ewa7BIN
	5W2
X-Received: by 2002:a05:600c:c04b:20b0:490:3cb4:f1b3 with SMTP id 5b1f17b1804b1-4909c0ba682mr43032785e9.16.1780064726422;
        Fri, 29 May 2026 07:25:26 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d7002e8sm55832855e9.15.2026.05.29.07.25.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 07:25:25 -0700 (PDT)
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
Subject: [PATCH 06/17] accel: Introduce AccelOpsClass::cpu_instance_init handler
Date: Fri, 29 May 2026 16:24:22 +0200
Message-ID: <20260529142434.87880-7-philmd@linaro.org>
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

accel_cpu_instance_init() currently dispatch via target specific
AccelCPUClass which we want to remove. Introduce a similar hook
in the generic AccelOpsClass structure.
We will convert implementations from one struct to the other, so
add an assertion to be sure only one implementation at a time.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/accel-cpu-ops.h |  1 +
 accel/accel-common.c          | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/accel/accel-cpu-ops.h b/include/accel/accel-cpu-ops.h
index fd1307dad6d..9810cc27cd2 100644
--- a/include/accel/accel-cpu-ops.h
+++ b/include/accel/accel-cpu-ops.h
@@ -34,6 +34,7 @@ struct AccelOpsClass {
     /* initialization function called when accel is chosen */
     void (*ops_init)(AccelClass *ac);
 
+    void (*cpu_instance_init)(CPUState *cpu);
     bool (*cpu_realize)(CPUState *cpu, Error **errp);
     bool (*cpus_are_resettable)(void);
     void (*cpu_reset_hold)(CPUState *cpu);
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 176b03e0e90..b3bcd53a4c6 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -39,7 +39,15 @@ void accel_init_interfaces(AccelClass *ac)
 
 void accel_cpu_instance_init(CPUState *cpu)
 {
-    if (cpu->cc->accel_cpu && cpu->cc->accel_cpu->cpu_instance_init) {
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+
+    if (acc->ops && acc->ops->cpu_instance_init) {
+        if (cpu->cc->accel_cpu) {
+            assert(!cpu->cc->accel_cpu->cpu_instance_init);
+        }
+        acc->ops->cpu_instance_init(cpu);
+    } else if (cpu->cc->accel_cpu && cpu->cc->accel_cpu->cpu_instance_init) {
         cpu->cc->accel_cpu->cpu_instance_init(cpu);
     }
 }
-- 
2.53.0

