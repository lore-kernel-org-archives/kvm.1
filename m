Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB19D39891F
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 20:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208913; cv=none; b=Jv9jHwHA1UAzcKM2Kwx7mQCjgEHM7hbtTQYagG8mLe5ixTHLthqLrYcghmMmQN6jxpZkDi4717nY9t+FpLH/aFMNYy88B0Aw3IzdEvtqN2hJX7ER/ZUcOzrqyMIVF6+xeWGkf5qH53BEfG3q+j2n9AfpUT2LghZvvuHRcBCiAik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208913; c=relaxed/simple;
	bh=6uRwmcArNmpcYHUxfVzJ1KUTNe7nDEt3Iouczp4pFJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gYOIjaTs0qoF/PaLJYviSL9BcrT/XnVEXRThlGcB8MEqQ7jZDAfqSeEBXp2DX61GOm9Q1jte0ZWQ3S2nE/FO8z5D84EFWH0Z8+B0vqC+dHF0BAa35MZb7Yzb1MN23W4uj5HAORT5rlh9mtqKUE4vd4uXJ+xg0P0+lRgzIvpRKaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAEMLVPV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAEMLVPV"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0bb4a94b8so2260335ad.2
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 13:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781208911; x=1781813711; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m265EV302HRo7Gs5HUB3XDJdYi9da1UqwB9AyAJDJRw=;
        b=ZAEMLVPV0UlbRsLIzNXCpfzYOHCBmWjUbVCtnKbKfqxxDwn8qqBrMmrXJVK7BoPQBk
         0Tt5vB20QtCmRMKcUNrhM6rjwlD+4hSSNQBQXnG6cxNmZ78g6fH8Z1nbLTFlSBdFjdtv
         cfiC5srGizBLOJ4FMgJvls1gubOw/ZUzRbwDL1XJrQtbjsaNjqvv2YQ2gtvihVrdWfax
         smVgQKX9TOn1EBd0HUpUD9sOCxGlHBf76hwfeleg+izX3pFrjyCEczXCdRPlJbh55hcN
         mu5ITCrANYOZ1eWgkO/RoLqDl+9QjKGxZgbpqrbqhL6Tj6bCi9O0gSZ46OOJGNavm/V5
         /jvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781208911; x=1781813711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m265EV302HRo7Gs5HUB3XDJdYi9da1UqwB9AyAJDJRw=;
        b=PDWesfuD4ZSCCedfyASEVzBQtzJH1CUAnFEFk0MzG1c56O+3ijsHBRMR4XJBKNjWL1
         NEXHRzO8oEs54rnMT3pbxSkFyfw+OYnhXkaMUFtiKIw02GJbTr4A+yMyVApgtzfL8tBo
         5PYsqPVRwOdDlI6gqF22wrgbd4L0mpSkjmxsf7VjvQmmARv4GqDojDvQRSMJfQis3HD7
         C+4WanwkDMAAp9CmEWIO/4X6p7obHzAO//DHpcGQLWEAzey8bLtfLtxZFnLMVrUswHYP
         xEWAPHpyoX+I2qOpp9O8MkwH1HHliGdIKpEcr7yUv0qh2xwEIGxg41CofuIE13VCzygj
         m8dA==
X-Forwarded-Encrypted: i=1; AFNElJ/YwqOTx0uoG4UxY8Io29+yG+tvNqN51deLUZYXhYZaDgQbh5yMqDy4Wek26eKexQ2Z1AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiIomooNPLMOKD7Jn5qDVaaijz/8EqcnrASP+WPv4Cr3R0Dbci
	5oKnrOcXyF9Ny6cEaACY2MGHXKuDKgkkMA+FO7Wlgiiuaout9gHPJKC2
X-Gm-Gg: Acq92OFfzrKpbqJjf83VlfWe3AA3JaIoRYQjLclaTtlRiafsYz7fsYDbs4LxUrLfanr
	fDmw1CUrzgK0mBJMLc63gBJbkuZTc2H/4I5k/P25wsxRMy/6S7yoeIFgjFv6zCiqkqxQY1qRvji
	whvKF1h2D9BC6RPycUAw/CjOa5CDxtcP8XOR91Gt3k9uPWzKbQxarSk45A2XWV7rugZ4iLY0Qv8
	3ZrBjgyh2I0Q4pp+H5hE5PNmUFSckeEy248w9t6hFI7vh4usP+KcLRkMVpBWlsCbvVyQG6gHcCn
	YmUWnNOOzW1UVm+lK0pfwsGXCPJqj3D8s3WoaycIG0q2dpyfwJxmYlxmdmxiGmudJCb/70OJGma
	I1m1bjFH1kyQ6pzBTefWXNHBO74rmiRkDKECARXXJWmKklQA4MwnNb56j3bAHano436EInocfwA
	==
X-Received: by 2002:a17:902:ebc6:b0:2c0:c940:dc1e with SMTP id d9443c01a7336-2c2f2c64838mr48032165ad.20.1781208911134;
        Thu, 11 Jun 2026 13:15:11 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::302d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f875casm288730475ad.22.2026.06.11.13.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:15:10 -0700 (PDT)
From: Guodong Xu <docular.xu@gmail.com>
Date: Thu, 11 Jun 2026 16:12:52 -0400
Subject: [PATCH v4 15/16] riscv: cpu: Output isa bases lines in cpuinfo
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-rva23u64-hwprobe-v2-v4-15-3f01a2449488@gmail.com>
References: <20260611-rva23u64-hwprobe-v2-v4-0-3f01a2449488@gmail.com>
In-Reply-To: <20260611-rva23u64-hwprobe-v2-v4-0-3f01a2449488@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Zong Li <zong.li@sifive.com>, 
 Deepak Gupta <debug@rivosinc.com>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atish.patra@linux.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, 
 spacemit@lists.linux.dev, sophgo@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>, 
 Guodong Xu <docular.xu@gmail.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2817; i=docular.xu@gmail.com;
 h=from:subject:message-id; bh=6uRwmcArNmpcYHUxfVzJ1KUTNe7nDEt3Iouczp4pFJc=;
 b=owGbwMvMwCXWtEl1Z3CGpCDjabUkhixtscP8W/I7a44KTu7eNGUm/x/V9O7U55x9jvfX8IaI1
 ssc8jHtKGVhEONikBVTZDl8tCV76yufaN/nnD9g5rAygQxh4OIUgIloMTD8T3wWVc9/4Hm9Y7yr
 eVbGq8q1TtuvXvyga7K41THqj6TMdYb/nt9nPzbeIJA1uXnNe+Wgo6cy8mddueVw6fH5C27BBTP
 2cwAA
X-Developer-Key: i=docular.xu@gmail.com; a=openpgp;
 fpr=90B1DC3DF0BD10FD1227BD6344F254AF42F143EE

Output two new lines per processor in /proc/cpuinfo:

  isa bases       : <bases that all harts conform to>
  hart isa bases  : <bases that this specific hart conforms to>

These read directly from the cached riscv_isa_bases and
hart_isa[cpu].isa_bases bitmaps populated at boot by
riscv_init_isa_bases().

Example output on qemu booted with -cpu rva23s64,sv39=on,pmp=on
(showing only the new lines plus their neighbors for context):

  processor       : 0
  hart            : 4
  isa bases       : rv64ima rva23u64
  isa             : rv64imafdcbvh_zicbom_zicbop_...
  mmu             : sv39
  ...
  mimpid          : 0x0
  hart isa bases  : rv64ima rva23u64
  hart isa        : rv64imafdcbvh_zicbom_zicbop_...

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Signed-off-by: Guodong Xu <docular.xu@gmail.com>
---
v4: No change.
v3: No change.
v2:
- Read from the cached riscv_isa_bases and hart_isa[cpu_id].isa_bases
  bitmaps populated by riscv_init_isa_bases() at init time.
---
 arch/riscv/kernel/cpu.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 3dbc8cc557dd1..31e2857dcdcf1 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -305,6 +305,26 @@ static void print_mmu(struct seq_file *f)
 	seq_printf(f, "mmu\t\t: %s\n", sv_type);
 }
 
+static const char * const riscv_isa_base_names[] = {
+#ifdef CONFIG_32BIT
+	[RISCV_ISA_BASE_IMA] = "rv32ima",
+#else
+	[RISCV_ISA_BASE_IMA] = "rv64ima",
+#endif
+	[RISCV_ISA_BASE_RVA23U64] = "rva23u64",
+};
+
+static void print_isa_bases(struct seq_file *m, const unsigned long *isa_bases)
+{
+	unsigned int i;
+
+	for (i = 0; i < RISCV_NR_ISA_BASES; i++) {
+		if (test_bit(i, isa_bases))
+			seq_printf(m, " %s", riscv_isa_base_names[i]);
+	}
+	seq_puts(m, "\n");
+}
+
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
 	if (*pos == nr_cpu_ids)
@@ -336,6 +356,9 @@ static int c_show(struct seq_file *m, void *v)
 	seq_printf(m, "processor\t: %lu\n", cpu_id);
 	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
 
+	seq_puts(m, "isa bases\t:");
+	print_isa_bases(m, riscv_isa_bases);
+
 	/*
 	 * For historical raisins, the isa: line is limited to the lowest common
 	 * denominator of extensions supported across all harts. A true list of
@@ -360,6 +383,9 @@ static int c_show(struct seq_file *m, void *v)
 	seq_printf(m, "marchid\t\t: 0x%lx\n", ci->marchid);
 	seq_printf(m, "mimpid\t\t: 0x%lx\n", ci->mimpid);
 
+	seq_puts(m, "hart isa bases\t:");
+	print_isa_bases(m, hart_isa[cpu_id].isa_bases);
+
 	/*
 	 * Print the ISA extensions specific to this hart, which may show
 	 * additional extensions not present across all harts.

-- 
2.43.0

