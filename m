Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7866427EFE9
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782297054; cv=none; b=jsBrpXV6NJvb9Jh7UxhjMU2CJDIDlL7uq4pgIjseO6NMT0UzIKTDIwHUpjRo95TtajvRUagafUzCZLmopivoXJy6Q+yl+6WnvuclxtbBSQGSNAy+IkYH3FyPP0LbywNkDijsZH8eJlxyW+jfdC/ZhCcHc9uHFKEUfA0pS+oIHgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782297054; c=relaxed/simple;
	bh=y27zdymnpKwNIiikg6uf4vhQzGhkgwC1tEk+BstP7Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=scSdcX27hOzoGgcvmyvERljsk84ryvRQXgiQMXkjvwJfFJzK4iTmKrH50d432mo+Ax9Jyff1TUfiDVFjdexvA+NVJetzA2yVUaLt39ILQq3mAbKJjpnj6n48Nm4rITBNkWRQlEnsXqiiAbs7hAibIdWLjb28HhJq288ix4wccZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wpxaGtcX; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wpxaGtcX"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-46cbf263113so201580f8f.1
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 03:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782297052; x=1782901852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ps+nLp3Q4CfPMJGduuipgUZanX4xJ5a30/iMTqcTrBM=;
        b=wpxaGtcXbVCq+it8FxZQIavuDU4wqOz3xNghgSFp8TbbqXW2N8/mAd1+R1mNQ/IaUv
         2C7AYJnGsetHygn/A44tKjfviGO3voHwhTaU6BStSdNrAMwta9XrDyYSh8vcSHM6pdZk
         kErAW+i85zgrWsx708icyqzTass2L6gIeQlr8b5Lu57kyQXMhI9okE6u1RDq0pPq3yIW
         P9tKNlVe/7vL+qELfXxoE/cBsc4Gu60+rCvjc7REqR/M88da20IfbjFbvVS3I7tkf2rm
         NuRjuDsz7A3ZOrIzrXLZWydbT8q9tB8vf/L+OrvOI4XP/4O5ruQPO7woNeLnx0Qu1iee
         K3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782297052; x=1782901852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ps+nLp3Q4CfPMJGduuipgUZanX4xJ5a30/iMTqcTrBM=;
        b=Zqe0vUKejnQ3mhcTDoI5DBaBiRPh6FshhllR2Ry+lanzdYTa74/g8oZZkS/wZcbuYk
         y6WqUjs6FaDLASMtbKhwaOVeburD6pQ0bIbV/Eea1AwkAdIB27/gsRxu/qDJQJ60Plan
         kFfbuNo4pyU95hczryiE4RctITtdzk8aIzBq1UJPJCoVE53oTE5sGUlWcmw/FvWi4vYf
         rfEc4AUy5x4kmltavV4QIclKfA8yA24QHfL6Rp1tSXNOjR2hIcAkaeopEfax5i4HTOzL
         Y8VCCQ88GfyELhBS6Cs6SpegQyfQNOlYMt8hsUW5M18wjh3jFNV60Z8mX0U8GJTgA5eu
         eE6A==
X-Gm-Message-State: AOJu0Yyw/IPr06GFM5DmDme3Eiz/byUzrNUZrBaqPh4xVm1fI0VWRAha
	Y8JziQBzro3RsMzMaLkOD2vbly1MzejYtVl9zSBmYAReHC6j1jrfKqOFwydxQY/aMNg=
X-Gm-Gg: AfdE7cl7NSMA1MeRlyLMW1pqqEdjFTqLyKAb7Vl2/bBn87rzeGYAAhTiQtPVRm//6Md
	WjsYVUlnKcYJ5+9lksiDHBovnZeAuTpgHCudM0G/fYxrNREQBWaasOrV9RwFwBvKsenh5J/aToc
	/3mAjdssVwjnEToTKQoGpO1HFWUdJGN4ZzdBXdL1SFXyjbs7yLLpBHRrhuAsnDGWBKEiNNPipyz
	8HXnM2HbBzZfSpR/uGT6xCoXvyqD92qHfcyJ+mzqh+MsmajyuB/Z68/ZMlbW2pXkqxKvtM9GErc
	pXSlznxDExlv3YSzATYhkHtJzEHchQMQdhtdud6rykbuxjwS4/kEsF9ceeyvsccECrQfyuzuksB
	LvSvDuFeqIBZ3nsUfzKQqpS3PWKBTd05b0fRhiTHrbT6eym3vw1ftcuD0juN4cmXDKLlAyHfyru
	izE3j2nVC5umvBp4anaMTz01E=
X-Received: by 2002:a5d:490e:0:b0:461:a169:f965 with SMTP id ffacd0b85a97d-46c0b8b182bmr2896485f8f.34.1782297051850;
        Wed, 24 Jun 2026 03:30:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d9405sm6263592f8f.22.2026.06.24.03.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 03:30:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 021645F9CD;
	Wed, 24 Jun 2026 11:30:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Troy Lee <leetroy@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Hao Wu <wuhaotsh@google.com>,
	Kane Chen <kane_chen@aspeedtech.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Steven Lee <steven_lee@aspeedtech.com>,
	Joel Stanley <joel@jms.id.au>,
	Jamin Lin <jamin_lin@aspeedtech.com>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tyrone Ting <kfting@nuvoton.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	qemu-arm@nongnu.org,
	Alexander Graf <agraf@csgraf.de>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v9 3/7] target/arm: do not clear halting reason in has_work helper
Date: Wed, 24 Jun 2026 11:30:45 +0100
Message-ID: <20260624103049.884930-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624103049.884930-1-alex.bennee@linaro.org>
References: <20260624103049.884930-1-alex.bennee@linaro.org>
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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

