Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C50037D10B
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850896; cv=none; b=Mx0aA5ExYsnyUrRMOEIMyMVtM9tEe3Ow65V+wMyteeVPaTXmFKl1R7pT8puanN/QNBuUWTlFqaehUTk5kiloaQ5wwBwxbE6F2rz5NNUTrsl3VluftdDBrnsa+ad1g0wRJqP7C6Kg5wm6MEeo39eRCTyUWfxmPxHTHxinMXD0DEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850896; c=relaxed/simple;
	bh=ieIcChIgPJa8E/kGBhK+yBWyyvoC+wr7+QdoyOSGSR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ReBCK25rde5kvRYqNNo0tcZcRtWiXmzZOlflRGmsFP2gYUR01fuKbb2e5Lv3YoS/8owi3sLL7yxBZSa0alxUcczg1rJxv8LfjAWSq3sBz7z6LFaSNH6sk/aL+Ksh8rcEhSugd1NRFxbeK5HTPaGw+PFYYDsmXQ6dVSacoU+nONI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XDQXURIS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XDQXURIS"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso28744765e9.2
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850893; x=1776455693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fh21TaJ8ypSq1QYVzVlTyt3qC9Wy73HL07UKYAF+YwI=;
        b=XDQXURIS5DUCeCfmaIjOG14mlcbEFjc/7HGmuVGHCRsGWcwpi8pFWwXaE6SP+lFwls
         J2JKPuLELwNeWAFA1dtdBJwHZerG4fUr4ZP5iN4O/dtu2nUduW1J5owUFslTnf9hWl6A
         lQG1oSxh89GC/W9N5jz/681gwE+hrjGiSUXwq9suTHzdRCsfGiQ7k4ZuyHc875ZKwr7/
         k09hY+xPDLnYlB7Vg2sZW62mQKCAVeFJj99r9V5n7xjaKunU8mkOgGmYB32b1uCUwPYL
         8IgsYT3ZZUbqe5t0iKCbrKZ2f6I0xbkeJzMvftqgoNH1OIOULLiUQQJShflIA/dXGe82
         4nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850893; x=1776455693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fh21TaJ8ypSq1QYVzVlTyt3qC9Wy73HL07UKYAF+YwI=;
        b=fYbHJ1B0lSgcnLqBK9mM0QEJYTrKoCwBYNX580TlDeQzg0X31EYKt9EVChqRx54ogX
         jxV7Pbj6yDgPH0Mr+ykoLxBa5MYu3debQ/dtUuiCkRy7wC9ngV0modc44JYIGKPRbeoV
         RWy+vwVNRDcNF/LyU0q4yp1kcxDbOFyb6aybIKk/5K43s7lXdOiBKLTfI79hSvFuviTo
         /RQok486w3DhX7txzRSfNXQPiPqnRGk7VXIP6DP9eXG5wN/vcspcOLkIgkJeTvmT5zgn
         /GWAdIilTfyekA4c+fk6zlTveFXUwL1hjkpoigL1S0TXrvygAU98Ud5a0jVsVNIWqO3R
         Qh6w==
X-Forwarded-Encrypted: i=1; AJvYcCX6dl55DKEvCcDtOKRHvEWA3UH7G4zs1dyC6slrJ4uQJ5ZY7bfoCBafwgfVPAfWYvCXbDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+9YaPuLRDj6Q26PlZYstgVfNFdddk/OEX3Q9/kvFQOu9Mqc4u
	nVT9wEGerdsnLCGf12jSJhWAVr7SRqfso1KKmoQaiTAf0nLBa1w6Mi4v8moDq10XFGI=
X-Gm-Gg: AeBDietXoe+qpWJC3QGiixtILv2HuFjUDjeeuCyBBpL8+hC6RIfINat/yLpobNAR6SX
	a0m8Dxqc3dZCRZRR0D82Wit3ad+yAWpCOzWq2Pvbkjw2MYymgowJ+kblRMU27/xQ1f/unLVK52M
	M4RqxLpRfUjJgqmWBjqMCnaBleBdFhhgmNddcnkWAAx/ANcHpuY2EN7yLGsCLbRDx9HmvRTAnRq
	BzFmar53+TZHz8J9K+LGMZoPIUg+U4+bULpxGLhWSVNFv8G21tE7NM0yCno13jtbCgjQRfjnzfE
	Y4+Z3C0/6hjF+vG1FoKKDLh0gBqoRoX2IhjWvF1yyxt0aHniQMYPEjwByqf9x4OyUxml11up0rc
	v6oy2XE1jUeUWva8RZMVu++Cs73BddZVKo/6aL78OagS7saHOID7OK/eNm2CzpjQW576kd8EP8a
	D43GUyArSa4Yqg6eD4TwAjlnBJn1t/IMzDLyBRuBYNohwjvmVfgiAHTYgIQGIcfT+7WbrGp5WG
X-Received: by 2002:a05:600c:3b24:b0:488:c078:bfda with SMTP id 5b1f17b1804b1-488d688d2a1mr56635425e9.26.1775850892918;
        Fri, 10 Apr 2026 12:54:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5396293sm84794825e9.15.2026.04.10.12.54.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:54:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	"Dr. David Alan Gilbert" <dave@treblig.org>,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-riscv@nongnu.org,
	Markus Armbruster <armbru@redhat.com>,
	qemu-s390x@nongnu.org,
	kvm@vger.kernel.org,
	qemu-ppc@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH v2 12/27] target/riscv: Register target_get_monitor_def in SysemuCPUOps
Date: Fri, 10 Apr 2026 21:53:06 +0200
Message-ID: <20260410195323.17937-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rename target_get_monitor_def() as riscv_monitor_get_register_legacy()
and register it as SysemuCPUOps::monitor_get_register() handler.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/internals.h | 3 +++
 target/riscv/cpu.c       | 1 +
 target/riscv/monitor.c   | 4 +++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 35b923c4bf5..7c91f1872b6 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -233,4 +233,7 @@ static inline int insn_len(uint16_t first_word)
     return (first_word & 3) == 3 ? 4 : 2;
 }
 
+int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
+                                      uint64_t *pval);
+
 #endif
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8ac935ac06e..dbd88fa6655 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2720,6 +2720,7 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
     .get_phys_page_debug = riscv_cpu_get_phys_page_debug,
     .write_elf64_note = riscv_cpu_write_elf64_note,
     .write_elf32_note = riscv_cpu_write_elf32_note,
+    .monitor_get_register = riscv_monitor_get_register_legacy,
     .legacy_vmsd = &vmstate_riscv_cpu,
 };
 #endif
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 3f206b9fca5..1c90c779534 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -26,6 +26,7 @@
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
 #include "system/memory.h"
+#include "internals.h"
 
 #ifdef TARGET_RISCV64
 #define PTE_HEADER_FIELDS       "vaddr            paddr            "\
@@ -310,7 +311,8 @@ static bool reg_is_vreg(const char *name)
     return false;
 }
 
-int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
+int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
+                                      uint64_t *pval)
 {
     CPURISCVState *env = &RISCV_CPU(cs)->env;
     target_ulong val = 0;
-- 
2.53.0

