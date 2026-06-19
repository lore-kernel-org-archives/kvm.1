Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61455390CB0
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781874344; cv=none; b=R1n67MqCv1109XJxTXgbzfmlTRWMZi7OLM+JQJKBU8T4D+oXnKZILyCxQ50B+yaryj5ysOadp4VSvy9Mx7b+IbXSLlbabrA00SC9z/CzGPoZj0djTUJbNSYomrZZ5ISKM3UJ1uuPcE06V3+lk5PVXdBvPt/7ceYijD0JEIJ6MP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781874344; c=relaxed/simple;
	bh=PmxnzJnKscG7dGPKPDxus4v3HqBJvLxzD2HnVasr49M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gk9u7GUprCTNPk7BQOlYi8T45tc8/H8XSCrTh7GHZDVUL5XuLZfJMWCfbVVJkOvzFfH7XvHpERDyOV1GTkLnXAmRwi2btX1GWYe3VOv/kZh9gvM3L/lRasoHXHfpH7AuvYr53rwVzlysrM3RqvTOSwLIcwKatbTaTpO2H5KtJSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xMK9FE96; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xMK9FE96"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso14159345e9.3
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 06:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781874341; x=1782479141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Il5WY7QfACzZ93YAvZWGe3XWn3xPIGhu97enE1XxJnA=;
        b=xMK9FE96pci5LRixoYdd5bzeBOinvLQCO1mAeY8QAsgRrJ0KIOyz1AisONk/6dYj2/
         onG/FqMzOsfsVN5jvZ+9eGMxnptx0FBr//sKPlRqKIUd6h20T4BXXDBeY+taFvYUBei4
         PkME0qbe11yAO8OwgDcRuhWPW4CnjZ6BnD06d9+YkD1h9ND5iCtuTt9Mg7kQrE8e2yPN
         GD8k3EM0I23i6O9Ebn+dnEKuMWgjAn3iph41tWfIHEsEDWNZ2QUE2007R6Sn2izCKaMN
         kDY5GbhVqTKzcaT3qUFPrwkCNtMh5vSN/diB5ybYZ59nMVIh/l3vAQDNt0tSwlkvSu7w
         +/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781874341; x=1782479141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Il5WY7QfACzZ93YAvZWGe3XWn3xPIGhu97enE1XxJnA=;
        b=EXW08LdMnRAYxI4l6ZwRxW3HvQuC/rTUmquPudoZgJM4D4FxKFv7hMgxVCw53+fyiR
         RAnYuKli0RWhNtNDyachOERTl7FGQXbbjJMFLJKv+Gn12MHLezZuaNMnNYORDEtSG9d4
         +0Do7yqPwDlCKcqPdXAR9kVbblLnFL7LY3cgl7k21p3jr1nqCIgs3rMDB5Nlly02K6VK
         IpSaCabzqWV1hEOqwIA/OjeJDYGXyra4dnoL614sbmOqUcWmsujQfY4Z5yVb+kOf8hSZ
         eCdiEx3ieZ5RmCSNw1tG1Nzih4os2PxPS0eS87Xp+ipY6YKdFIDZl+svAWjXkOZamFFC
         MhHA==
X-Forwarded-Encrypted: i=1; AFNElJ+lqbgULfO7ElANvrPRZHcRDSjHrEgMVXLZnwVDcOb9oK4nmorMW1KC3B3oI8RiI12mw84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqxbSRSS0XlxQ6J3Smw6RCwBfoforJNKIwg0lfZ82MaQdL/uO1
	b0fw6UOTl5yO5Ab1jm5DdMkPDgCb8ry/jMA3Vnok6y04QMA/DSbP1EMu8m1GP2iCmFI=
X-Gm-Gg: AfdE7cm5iB1eMMKtQUNKV4Z9H/CgsvsMWtFHpDPez0XKh3gRAh2f9iS7fAdEVUW5Al0
	ifH890n+t2rPOa/mqmuxN5vhUhLfGEl2TqtyTZ52PjqOeHUDgBORk5RodAFlfmOZnIA4hRweyWm
	zXin0Lev/sw5DPb/N6ifgJLIPVtJ4inYWkL5B1cE05K/tcPw7dzCSUAkZB9qjcarXSU2Ict7pkP
	REoEpVLcUBJ3tmUAnB8vsfmxdkqC8t7M4MydETMmYF61L03YPcapsgliVTGPcYlz6e+0D/7gwli
	pdL2KRk0zgcydkSPn1cOWViwp4EhbFZI5A7LWjjrKp1NzkonmNDCvMUkZSezVGGOQmVhFILPT9Z
	7E065yw+z4J5/rWf9PgBsNunxzSeRsg4z0AwWzTSNkqiJNNdkE+tfl2lmEZnGyZgbuTJrilyWGe
	jIcMjrd/e1U4NX
X-Received: by 2002:a05:600d:4448:20b0:490:da12:f1fa with SMTP id 5b1f17b1804b1-49240ea7f99mr46236105e9.31.1781874340737;
        Fri, 19 Jun 2026 06:05:40 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240efc160sm54997235e9.2.2026.06.19.06.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 06:05:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 8B58F5F946;
	Fri, 19 Jun 2026 14:05:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Jamin Lin <jamin_lin@aspeedtech.com>,
	Steven Lee <steven_lee@aspeedtech.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	qemu-arm@nongnu.org,
	Troy Lee <leetroy@gmail.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Kane Chen <kane_chen@aspeedtech.com>,
	Tyrone Ting <kfting@nuvoton.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	kvm@vger.kernel.org,
	Hao Wu <wuhaotsh@google.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v8 3/7] target/arm: do not clear halting reason in has_work helper
Date: Fri, 19 Jun 2026 14:05:32 +0100
Message-ID: <20260619130537.820184-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619130537.820184-1-alex.bennee@linaro.org>
References: <20260619130537.820184-1-alex.bennee@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The helper will be called multiple times as we exit a loop and until
we actually restart (via arm_cpu_exec_halt) we should leave the
condition the same.

Fixes: 6fd2fcdc61b (target/arm: teach arm_cpu_has_work about halting reasons)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/core/sysemu-cpu-ops.h | 3 +++
 target/arm/cpu.c                 | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 8be6a84bd54..9a45596169a 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -18,6 +18,9 @@
 typedef struct SysemuCPUOps {
     /**
      * @has_work: Callback for checking if there is work to do.
+     *
+     * This function should be idempotent (i.e. not change state) as
+     * it will likely be queried multiple times before a CPU resumes.
      */
     bool (*has_work)(CPUState *cpu); /* MANDATORY NON-NULL */
     /**
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 86aae36ae55..597e0626e7f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -158,7 +158,6 @@ static bool arm_cpu_has_work(CPUState *cs)
      * A wake-up event should only wake us if we are halted on a WFE
      */
     if (cpu->env.halt_reason == HALT_WFE && cpu->env.event_register) {
-        cpu->env.halt_reason = NOT_HALTED;
         return true;
     }
 
@@ -170,7 +169,6 @@ static bool arm_cpu_has_work(CPUState *cs)
                            | CPU_INTERRUPT_NMI | CPU_INTERRUPT_VINMI | CPU_INTERRUPT_VFNMI
                            | CPU_INTERRUPT_VFIQ | CPU_INTERRUPT_VIRQ | CPU_INTERRUPT_VSERR
                            | CPU_INTERRUPT_EXITTB)) {
-        cpu->env.halt_reason = NOT_HALTED;
         return true;
     }
 
@@ -878,6 +876,8 @@ bool arm_cpu_exec_halt(CPUState *cs)
         if (cpu->wfxt_timer) {
             timer_del(cpu->wfxt_timer);
         }
+        /* clear the halt reason */
+        cpu->env.halt_reason = NOT_HALTED;
     }
     return leave_halt;
 }
-- 
2.47.3

