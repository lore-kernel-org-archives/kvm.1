Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A39F367B7F
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064785; cv=none; b=QE8Vzqy4q3kXh8DHv8JV8iC0ZGZkQ7FnKmyOCfIoupvVaRzIUUYLfO1gZcSJPFCV84Q1gK5ydDWk4H4uxowZQ7WVZ7PmOWKody1y52xqcaaS0infQZbeNeIL0QcmNpOOl7wseEfHAg+b36JIe2m/bXIP6tYjcTzsxRE4gRePp3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064785; c=relaxed/simple;
	bh=72OgsdwmQGAd0m0U/SgQ5X+xgjTu+d7UajPn9ajS0ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLSl0dJNGQ8uhFPMJXLgz3Me71blZKDkp3R7vzdaTuxhWWPawrjm3ebc5juCVbrG0Xhlvp3r2erlmvI1pQxOaIlccQ1lpYYAMD5SNLSoE4IXNFGlorrNFnsakKyqxqFPj7W0+B10VN6g9NXRk8la/usnk8dASJPS97S1jJA2CCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iOWmI4wG; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iOWmI4wG"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43fe62837baso8138938f8f.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780064782; x=1780669582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pY5dZL3lqDIGFvqQzCCG1CGy5J/P2MEPS9AZJ7MvyM=;
        b=iOWmI4wG7KOXBpQ55GfEEeNv2J2Z2OkNo0o9bywl91GzY1qFcY2qP83HVkfDc3X/6n
         5grCzymMHM1wb2IGm3kex9w74KFgH2/OGqL49d8Ur/kamP9hCCWp9scl9wNVabsOOZkG
         p48D2wx0s3Aym9Y1AUeATQmL3sBzapZcnHnz+b9KlCZ5z5jNbn/fxXDk0iHNN1xk7xdX
         veH7ogi2pAMiVCeNcf0upgqFQOARRrpF6agOBAOXcU3RKVTH1EWkT5XpXxsMSLVdBqAw
         hi9ZIR4PfUj+COqZ/HiHYAWOg1CiJDzpleSP4Zl2y6QFBdIPfP4QdLZJHlG61s79DnW+
         S6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780064782; x=1780669582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5pY5dZL3lqDIGFvqQzCCG1CGy5J/P2MEPS9AZJ7MvyM=;
        b=oZfDSmWV8PlnW63AmlWpz9wnsmj4kmbSIBLVSAH31aOFL1M6ACuKN931TyTCDdzYay
         NzeWZaohhgqzWharyqYR3AHyv98HMmXuBj4O4INqTwRtuirUOesHl6hEuZLfqXPuu7cK
         7pHGu/g49A/TNj+9Iy1bux47Sh8CH2xTISzE6VxmgFhi6JATIiEHX8T+yC4pqIXQxbtX
         rDn4dJ3k3sFswHbcGIixEKS+yuS9bS0GPasZBjfcV1QdWn7zOKCLrKULz79wu0yduohe
         vuJNNANDZOun1q4cJrfAAZ4CrWNB2kzctmjJOTv/OZduNUUIuuJl6G8VK7b/OM0NQlDO
         iQrQ==
X-Forwarded-Encrypted: i=1; AFNElJ9HmdhZbMiF/PfCgSkq2a4cZWRmnmQVfU4KNQebwAZon6umomSkN9d9xF2/MX3J6XbYCmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzffpW0mHyUuUHfmrKUB3jwoC83Vsjhz1XjsvC8FZKeQaZbWX7H
	nfI/1HWntsEZEIgUDpHh4DaQXpIeG6q0aF7+3SMeCnksH8Ph8nECfInPy9sReRO8GmA=
X-Gm-Gg: Acq92OFefDQ7utmC4My2QnSOgYWCouv56pOb6ChyONriobkSFLrwAs8vYxX3KbUk9Ma
	qCQ5j2LvsOJRpgneOjPmBOBfImb+gg28on9tfng4iZqYdztwq/ju1S41fr+2IckORS4/Fw/Z5Kt
	HAy60570UCelGf6n1W3rGk2ljt6HBKR/8pn8/11vK7FEKpIJfanFn4CZQDGbcBXnddmE7MsdFvL
	wQTje/J0Qw7U5MoPLD2DKD1L8m7Aq6TRK5ZeJaGEHwtPTP8HhO4xOWP3cN0PhdT4ipAkxVOqks2
	YbkPBoX1AIbRFMprVUauSuIwBmFJmiErK7qZMcMVLJDwBqwCk8405369hlV0qP1ageIwUEhWvU0
	o0sSsoDz9+7m/EC8mS7exE0UVwIYVTLoF57fsE+B+luQXpQMcmSGn8hObqLSimaAfHV3y6SxTph
	OqTZ6VHZ5lpYKEy5iOTi5mx26Rr2bOr6wrNbasvR8Ekh64gTwCq4BJDvq7cZ0WErWSYA==
X-Received: by 2002:a05:600c:2112:b0:490:6889:1ff with SMTP id 5b1f17b1804b1-4909c0c0b42mr42497545e9.28.1780064782308;
        Fri, 29 May 2026 07:26:22 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef35598e5sm3754032f8f.27.2026.05.29.07.26.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 29 May 2026 07:26:21 -0700 (PDT)
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
Subject: [PATCH 13/17] accel/tcg: Convert AccelCPUClass -> new TCGCPUOps::cpu_realize
Date: Fri, 29 May 2026 16:24:29 +0200
Message-ID: <20260529142434.87880-14-philmd@linaro.org>
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

Introduce a TCGCPUOps::cpu_realize hook and call it at
the end of tcg_exec_realizefn().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/tcg/cpu-ops.h | 1 +
 accel/tcg/cpu-exec.c        | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index d7d329e419d..5eba6949ba1 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -49,6 +49,7 @@ struct TCGCPUOps {
      */
     void (*initialize)(void);
     void (*cpu_instance_init)(CPUState *cpu);
+    bool (*cpu_realize)(CPUState *cpu, Error **errp);
     /**
      * @translate_code: Translate guest instructions to TCGOps
      * @cpu: cpu context
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ef44c12b601..1efa3bbe53d 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1056,11 +1056,11 @@ void tcg_cpu_instance_init(CPUState *cpu)
 
 bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
 {
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
     static bool tcg_target_initialized;
 
     if (!tcg_target_initialized) {
         /* Check mandatory TCGCPUOps handlers */
-        const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 #ifndef CONFIG_USER_ONLY
         assert(tcg_ops->cpu_exec_halt);
         assert(tcg_ops->cpu_exec_interrupt);
@@ -1081,6 +1081,10 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
 #endif /* !CONFIG_USER_ONLY */
     /* qemu_plugin_vcpu_init_hook delayed until cpu_index assigned. */
 
+    if (tcg_ops->cpu_realize && !tcg_ops->cpu_realize(cpu, errp)) {
+        return false;
+    }
+
     return true;
 }
 
-- 
2.53.0

