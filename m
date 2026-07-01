Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C1A49253D
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910499; cv=none; b=ZY3+r8847Hp53Q45V4nDy4mMkcg+6LkBs0PuQ1KvBRrxJDtLvqFXg8E+8Xx7p5N+KzqCVq8s1tfvT+duMVhWyH1LIk6RLSTsXT9JiKWxH8Jdmj0ttjHmFm2bhKU6T0bW1xxBCsD+v+DARTfa1U65qDZnp7ANPk2Wy/Nhg/n04gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910499; c=relaxed/simple;
	bh=RM5/Jm80n8hic83slp8easkNCPyba3jQD85igQwb558=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X2DplH56PMvUY4f+Z0yeo5UvCYfjiI12zU3RNgxdnkKsHaVbV6P3gEY578D51M+CR5+VMpM+VFGoD65fQq/svppIVbUnk97I/NMrzBS886Bei61kM1MP8B/0VSY7iPZz5qA/BDkhxmSSaD8TS2cvghQIY5tunbPtkBZbhf/g1Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hL+kHZv9; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hL+kHZv9"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8479f1a86ecso344869b3a.1
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 05:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782910498; x=1783515298; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4itvwgmIkfoT47xsL7nDKqH8kqk6Z6HU3EjYTAF58M=;
        b=hL+kHZv9QtNmqmq4shB0EI5/eyhYkO8XTFPmsbD/isNbQaIXt+7joQB2hAvIUmmrMV
         P9gNKItTxhVvdgtb2DnDSl4wkA8gSyMlyrXO4aFoaF5xCjh1hAdrz/dB4vPlSlt5IwiR
         AY9LHlqAxBVFfnpMn6Z1z3jI0sCSzg6WzIKxNDdirxFG9ldTAjtCIm+QlwLpadEc0vg1
         wM0SZ/0aJD8qt+rqzvRuXWCUACNx4IY5zyQLPiphYkNwLBNKFUMZUNyszoxF/m/rxp0D
         6M+eOdQAFn8NoBdq4ILMl8EUFrBvx5tupTPND7k7ITFdd0a2bjTJv6Aqyxs0mRH50Qi6
         dIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782910498; x=1783515298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F4itvwgmIkfoT47xsL7nDKqH8kqk6Z6HU3EjYTAF58M=;
        b=ZOR/PW7YofXZgmNy0dG/2Fh05H4Ubp4czUM9MXFZklvq4cAiMWX/Pw7k3TcDdUkCHc
         ptZgfIf2E/Fat53Ypd74KnMQWkw6lnwSaEBpyVYOV+HiYpGMKU/4Nh7asxSaRg9WjE0N
         2c6XOdoIC8wPRy9LLQ4hnDTzAHOtl6c9U3SNWsxAGtwpDJUde8Fz5kxnQkhe/Kh03TMX
         PL49JbRu+dzzv1UAAhm6obzlTZrYupZW4iAJOay6Pf58ZUaDtNsoJgoCxfyeIjWvayQQ
         YiWwcRLu5BfZp0i1yNGhghDYDhQuVe3atqKARfOag0LIwoQNgBAWxyP+sL5zS1LNPV/M
         8SMw==
X-Forwarded-Encrypted: i=1; AFNElJ8XOgHmkjD3Jp1Aum7SxcCeINtLdOq7VT6RRwTRSDO8ehNYKe157b+eCPNl8f20UF6Zl1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0eKTh6bPEBno99fdx7RaeBlchBwI1DjITESjFQc9+F/wjeett
	4SBKWJ+/RXvqSmI/6Bjn973nCqObZE2SjvUNmAehG8htT/CpLjyKO9sN
X-Gm-Gg: AfdE7ckCRA3BmAcPYIicMNpj05sCFE+3zGI/sZlSNvvczoOJbLOsc1gxbdUDT9dygjO
	0uXyYz0JjqtsQ/ETqLsJ0c5fvfFai7ei5gB425xpUmIY3WmoWQHLkNFpCCvOBItXfJ6vozKYLjU
	D3tx5d5teXJ9ErhI6plD9EtCNslMhfNTrx3TV5kf86qk1KEWmmtTKqy3fKh/9TnKv63Qm4+4q0l
	pHIvy5jwe8B1APqY0/B7uwI8kLKNZQe+8d0DzGmmvEg9FvCa+mRIZk8BN4hZKdH6B0wB9EnSeTA
	GZNzvJVRs138QNbK5WDBqEDJ1M2YgkyRYAPFdTqJJfXwmJ0fP7T1mLXYBiQIAZgllW7E+sDSL22
	nUSQMIFQF+XA6UXqy2uI10B8A1VX7W2DaYV8PP2/olXUZowsdIlEUZKWi81eoX+q+FwvbNNwYdt
	3s4e1lKRrjoe23PJnEDp7F
X-Received: by 2002:a05:6a00:44c6:b0:845:e105:1e6c with SMTP id d2e1a72fcca58-847c5235e15mr557323b3a.62.1782910497562;
        Wed, 01 Jul 2026 05:54:57 -0700 (PDT)
Received: from [127.0.1.1] ([120.244.9.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a03778basm3999403b3a.49.2026.07.01.05.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 05:54:57 -0700 (PDT)
From: Guodong Xu <docular.xu@gmail.com>
Date: Wed, 01 Jul 2026 08:52:27 -0400
Subject: [PATCH v5 14/17] riscv: Add a getter for user PMLEN support
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-rva23u64-hwprobe-v2-v5-14-2c61f94a695a@gmail.com>
References: <20260701-rva23u64-hwprobe-v2-v5-0-2c61f94a695a@gmail.com>
In-Reply-To: <20260701-rva23u64-hwprobe-v2-v5-0-2c61f94a695a@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Zong Li <zong.li@sifive.com>, 
 Deepak Gupta <debug@rivosinc.com>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atish.patra@linux.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Chen Wang <chen.wang@linux.dev>
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 Conor Dooley <conor@kernel.org>, Jesse Taube <jtaubepe@redhat.com>, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, devicetree@vger.kernel.org, 
 spacemit@lists.linux.dev, sophgo@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Guodong Xu <docular.xu@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1943; i=docular.xu@gmail.com;
 h=from:subject:message-id; bh=LaS0cxSQXBgyR01xQr5M6KNsO7HDlsJSbaq9hq8ofFM=;
 b=owGbwMvMwCXWtEl1Z3CGpCDjabUkhixX3jaJs1we53hUJftu3dk5Y52sfn0Xg+vbEK7Om/tuL
 zAvnjqpo5SFQYyLQVZMkeXw0Zbsra98on2fc/6AmcPKBDKEgYtTACZizMjIcGpvd2B4wjVF7TIX
 h1/fvitwee95mTC3Iqiy4+QF5p0ycxj+aTkoSGYs+z1b+51NUvTHg/+rd8dNWbVvxirV3Wy6Yma
 ZDAA=
X-Developer-Key: i=docular.xu@gmail.com; a=openpgp;
 fpr=90B1DC3DF0BD10FD1227BD6344F254AF42F143EE

From: Andrew Jones <andrew.jones@oss.qualcomm.com>

Querying whether a given user PMLEN is supported is needed for
RVA23U64 base detection from outside arch/riscv/kernel/process.c.
Add riscv_have_user_pmlen() to expose this.

Link: https://lore.kernel.org/linux-riscv/rfuwa7a3ebe76udmnwyrssjy7shkkgxntvhwzn6oquysj4tuyp@xzvpylcfhz53/
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
[Guodong: replace exported booleans with getter per Andrew's suggestion]
Signed-off-by: Guodong Xu <docular.xu@gmail.com>
---
v5: No change.
v4: No change.
v3: No change.
v2: Add a getter for user PMLEN.
---
 arch/riscv/include/asm/processor.h |  4 ++++
 arch/riscv/kernel/process.c        | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 812517b2cec13..febf51e127f70 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -214,6 +214,10 @@ long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg);
 long get_tagged_addr_ctrl(struct task_struct *task);
 #define SET_TAGGED_ADDR_CTRL(arg)	set_tagged_addr_ctrl(current, arg)
 #define GET_TAGGED_ADDR_CTRL()		get_tagged_addr_ctrl(current)
+
+bool riscv_have_user_pmlen(u8 len);
+#else
+static inline bool riscv_have_user_pmlen(u8 len) { return false; }
 #endif
 
 #endif /* __ASSEMBLER__ */
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index b2df7f72241a5..5d9cb108a6232 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -302,6 +302,18 @@ enum {
 static bool have_user_pmlen_7;
 static bool have_user_pmlen_16;
 
+bool riscv_have_user_pmlen(u8 len)
+{
+	switch (len) {
+	case PMLEN_7:
+		return have_user_pmlen_7;
+	case PMLEN_16:
+		return have_user_pmlen_16;
+	default:
+		return false;
+	}
+}
+
 /*
  * Control the relaxed ABI allowing tagged user addresses into the kernel.
  */

-- 
2.43.0

