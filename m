Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048123F65E1
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506642; cv=none; b=WUPcVAP6bKyd3oXrTTaAxhLuOcMSOunkPUvBhQqMCU7x32DzFmKVJO+I5KWI69LqRt1aR9x16ADeTrFE3iGaDqTZJoKqAWGc2wBfd2vjFMI3FErihGgciYa74qlaBu5oUZQ9ZcnO/ZhyHFz5WSvnlHGaRNsJWk0lfk8AHO7/ByA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506642; c=relaxed/simple;
	bh=gMp19lC3Unjg9mMl4fTtDb8YmdM5Obv0B1W9PFDDwIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EUNARcDKUJDYt6z2PSDPV8e7JqaZfM2b6p1M7Y9qwvsyy4T1VEbONtWNrWizmK65blmSnrtMGzI8TS59CRqlIF1NeZtP8yRZUFd4IN8pWS/R/H+CKjDxG7kur31iNVlANsJtmlmT0f4Af9Otx3Fjj9c3fy3enFldw8ZQKivBPp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=zkvNb/Zy; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="zkvNb/Zy"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3665a90bcd3so2653059a91.1
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 06:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778506640; x=1779111440; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1X1rQwa6+aIkH1NloR/E1SkocmjVrWbvU49Eu1vnOIg=;
        b=zkvNb/ZyKZJpyUzi5vxySolsJOAuMk4pqN0hC1Yv2FUuiSvPtCCihHykDcq8AQRZiT
         CZL5F8fxYqgJhbnAqbH7A6u6fo0l+jPINvbn+ht/4wzuDTQPvtFmITPx9jrssOmr2jTg
         znDMIxgcjqdmnkPwOQTT4UFfFc0rmIV+vRflrSkez0buhee2Y+uMHt4DyT0PtFCjeAUG
         RKwCkYAwNoAp66LgmMqxNPs8QwwPUpMv4/F2dwCEnMvdBiwRitlzFpc9c7Q4e/YXmA91
         4RjqPIEXm1mZ0s7RH0j30+yz4fiyHD/pd3vARfg4sH7IHHIQydNsRDsT5JKCsKAghRtq
         JJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778506640; x=1779111440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1X1rQwa6+aIkH1NloR/E1SkocmjVrWbvU49Eu1vnOIg=;
        b=BpaH/cAd+FvRJ3a3tSF6ol4cMR+JMeDkslzo/fTbW5fLyHJNHJ4KGbgc8meUnqXzyy
         yj9eEndDCnms3mwEeI3JghoEC+T4PnPTo4u34XQH7ojORuC4uraLwdhm8rCV58rUoQ4n
         IV0Sq40KnTKTDMGW5bJVFW4ecVQhNKaeW7GZaCc1LFuUWNLyFyzRYSlihQp8vGYQMcM8
         iPb+FkX1WYWp4GpM7fBxwF5hkrKnUt3765T9hFVy+u3E+JO3oqHzIj16gBaVxHnm0AX1
         lnJIx9Qo9teJwBCcvRBpkL+v0jtXwORNKCaNEwhTppGaL0K4Jvlu7tFutJ7OCwlA521X
         GB4Q==
X-Forwarded-Encrypted: i=1; AFNElJ/4w+g97XVC29cqE6UcZUsDJtHQaupqVCO8/mx72GadiRQdbFYbIUhG7KcsENXWpXNhpHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsv9sNCHvQE/LVQO8G4DHs0zh45wPFIe4hn++5CE9R8AWxCbsq
	ZU2iTYnRQBWpJPS5LJqPzJUhduw5Kxk55NjoLlO+T+wUmHOoMZDoWJ2ZsO5VkNCGpN8=
X-Gm-Gg: Acq92OEPLRpuxLGrfrIl9ngFYvsRk/T2AGkgts+cTIvApwk+eWdmlUHr6Q4eb/XGbSh
	YiV0o8JUA0Sid/abDAyOfTetwJoiPKNfK5NpDUjPRF374iJpNB/S4dp3GwewPhqphZP4P5Y3L0C
	0kdcSAloiFUXgZoVXzsxgyi9qY385ucYjYjCyXgWQSCyx2XVt42fVO5hYPhgEEc1ou099aw3GlV
	xm/1J9Ld9pizFqmtiPXa6BUrp95OzONd0u/QGNlUzT9TVkXsxkxpu6qA7ei1AkHzoqKkzhD9d6q
	VXtX5YgGfhJs5NFFXxy3zqBpBHRcxvdwAzYH5rtnLN04TZJ7YzRvf9DykiO1OiILft7o38govkM
	SFhvzeI7VY9XYb8h6wwPLSzz91cvBSu9PnD8cAnOacoTiuek56asl5zmhqfYNM25D+5g/Pgf0J5
	B37vX9Nq4esO5APfBs83UrvcvNjqFwLusAtodNqDM/5dA=
X-Received: by 2002:a17:90b:38cb:b0:367:bf59:6f9f with SMTP id 98e67ed59e1d1-367d48a22damr10503248a91.25.1778506640486;
        Mon, 11 May 2026 06:37:20 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::30f3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367be3daafesm3034326a91.8.2026.05.11.06.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:37:20 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 11 May 2026 21:34:53 -0400
Subject: [PATCH v2 08/10] riscv: cpufeature: Introduce ISA bases bitmap and
 rva23u64 detection
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-rva23u64-hwprobe-v2-v2-8-21c5a544f1dc@riscstar.com>
References: <20260511-rva23u64-hwprobe-v2-v2-0-21c5a544f1dc@riscstar.com>
In-Reply-To: <20260511-rva23u64-hwprobe-v2-v2-0-21c5a544f1dc@riscstar.com>
To: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atish.patra@linux.dev>, Shuah Khan <skhan@linuxfoundation.org>, 
 Deepak Gupta <debug@rivosinc.com>, Zong Li <zong.li@sifive.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Samuel Holland <samuel.holland@sifive.com>, linux-doc@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, Guodong Xu <guodong@riscstar.com>
X-Mailer: b4 0.15.1

Introduce a per-hart and host-wide bitmap of conformant ISA "bases" --
named profile-class sets such as IMA and RVA23U64 -- and compute
both at init time.

This is the cache that subsequent consumers (hwprobe's
RVA23U64 base behavior bit, /proc/cpuinfo's "isa bases" lines, etc.)
read without recomputing.

riscv_init_isa_bases() iterates over all possible cpus to populate
each hart_isa[cpu].isa_bases, then computes the host-wide
riscv_isa_bases against the AND-across-harts riscv_isa bitmap.  It is
registered as a subsys_initcall so it executes after
core_initcall(tagged_addr_init), which probes senvcfg.PMM and
populates have_user_pmlen_*.  Without that ordering,
riscv_have_user_pmlen(7) would still return its default false and the
RVA23U64 detection path would always bail.

The detection itself is encapsulated in riscv_set_isa_bases(), which
takes an output bases bitmap and an input ISA bitmap.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v2:
- Implement riscv_init_isa_bases() that runs at system init time,
  after tagged_addr_init() populates have_user_pmlen_*.
- Split RVA23S64 placeholder into a future patch.
---
 arch/riscv/include/asm/cpufeature.h | 14 ++++++
 arch/riscv/kernel/cpufeature.c      | 92 +++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 739fcc84bf7b2..facc31b2960c6 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -25,10 +25,24 @@ struct riscv_cpuinfo {
 	unsigned long mimpid;
 };
 
+enum {
+	RISCV_ISA_BASE_IMA,
+	RISCV_ISA_BASE_RVA23U64,
+	RISCV_NR_ISA_BASES,
+};
+
+/**
+ * struct riscv_isainfo - per-hart ISA state
+ * @isa: bitmap of ISA extensions this hart implements
+ * @isa_bases: bitmap of profile bases this hart conforms to
+ */
 struct riscv_isainfo {
 	DECLARE_BITMAP(isa, RISCV_ISA_EXT_MAX);
+	DECLARE_BITMAP(isa_bases, RISCV_NR_ISA_BASES);
 };
 
+extern unsigned long riscv_isa_bases[BITS_TO_LONGS(RISCV_NR_ISA_BASES)];
+
 DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 
 extern const struct seq_operations cpuinfo_op;
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 81145621dc378..6e8dd33aa3888 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -41,6 +41,9 @@ unsigned long elf_hwcap __read_mostly;
 /* Host ISA bitmap */
 static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 
+/* Host ISA bases bitmap */
+DECLARE_BITMAP(riscv_isa_bases, RISCV_NR_ISA_BASES) __read_mostly;
+
 /* Per-cpu ISA extensions. */
 struct riscv_isainfo hart_isa[NR_CPUS];
 
@@ -1305,3 +1308,92 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
 	}
 }
 #endif
+
+/*
+ * Compute the set of profile bases (IMA, RVA23U64, ...) a hart
+ * conforms to, given its resolved ISA bitmap.
+ *
+ * If @isa_bitmap is NULL, the host ISA bitmap (the AND across all harts) is
+ * used.
+ */
+static void riscv_set_isa_bases(unsigned long *bases, const unsigned long *isa_bitmap)
+{
+	const unsigned long *isa = isa_bitmap ? isa_bitmap : riscv_isa;
+	DECLARE_BITMAP(ext_mask, RISCV_ISA_EXT_MAX) = { 0 };
+	DECLARE_BITMAP(tmp, RISCV_ISA_EXT_MAX);
+
+	/* IMA */
+	set_bit(RISCV_ISA_EXT_I, ext_mask);
+	set_bit(RISCV_ISA_EXT_M, ext_mask);
+	set_bit(RISCV_ISA_EXT_A, ext_mask);
+
+	if (bitmap_andnot(tmp, ext_mask, isa, RISCV_ISA_EXT_MAX))
+		return;
+
+	set_bit(RISCV_ISA_BASE_IMA, bases);
+
+	/* RVA23U64 */
+
+	/* Zic64b and Supm with PMLEN=7 */
+	if (riscv_cbom_block_size != 64 ||
+	    riscv_cbop_block_size != 64 ||
+	    riscv_cboz_block_size != 64 ||
+	    !riscv_have_user_pmlen(7))
+		return;
+
+	set_bit(RISCV_ISA_EXT_F, ext_mask);
+	set_bit(RISCV_ISA_EXT_D, ext_mask);
+	set_bit(RISCV_ISA_EXT_C, ext_mask);
+	set_bit(RISCV_ISA_EXT_B, ext_mask);
+	set_bit(RISCV_ISA_EXT_ZICSR, ext_mask);
+	set_bit(RISCV_ISA_EXT_ZICNTR, ext_mask);
+	set_bit(RISCV_ISA_EXT_ZIHPM, ext_mask);
+	set_bit(RISCV_ISA_EXT_ZICCIF, ext_mask);
+	set_bit(RISCV_ISA_EXT_ZICCRSE, ext_mask);
+	set_bit(RISCV_ISA_EXT_ZICCAMOA, ext_mask);
+	set_bit(RISCV_ISA_EXT_ZICCLSM, ext_mask);
+	set_bit(RISCV_ISA_EXT_ZA64RS, ext_mask);
+	set_bit(RISCV_ISA_EXT_ZIHINTPAUSE, ext_mask);
+	set_bit(RISCV_ISA_EXT_ZICBOM, ext_mask);
+	set_bit(RISCV_ISA_EXT_ZICBOP, ext_mask);
+	set_bit(RISCV_ISA_EXT_ZICBOZ, ext_mask);
+	set_bit(RISCV_ISA_EXT_ZFHMIN, ext_mask);
+	set_bit(RISCV_ISA_EXT_ZKT, ext_mask);
+	set_bit(RISCV_ISA_EXT_V, ext_mask);
+	set_bit(RISCV_ISA_EXT_ZVFHMIN, ext_mask);
+	set_bit(RISCV_ISA_EXT_ZVBB, ext_mask);
+	set_bit(RISCV_ISA_EXT_ZVKT, ext_mask);
+	set_bit(RISCV_ISA_EXT_ZIHINTNTL, ext_mask);
+	set_bit(RISCV_ISA_EXT_ZICOND, ext_mask);
+	set_bit(RISCV_ISA_EXT_ZIMOP, ext_mask);
+	set_bit(RISCV_ISA_EXT_ZCMOP, ext_mask);
+	set_bit(RISCV_ISA_EXT_ZCB, ext_mask);
+	set_bit(RISCV_ISA_EXT_ZFA, ext_mask);
+	set_bit(RISCV_ISA_EXT_ZAWRS, ext_mask);
+	set_bit(RISCV_ISA_EXT_SUPM, ext_mask);
+
+	if (bitmap_andnot(tmp, ext_mask, isa, RISCV_ISA_EXT_MAX))
+		return;
+
+	set_bit(RISCV_ISA_BASE_RVA23U64, bases);
+}
+
+/*
+ * Populate the host ISA bases bitmap (riscv_isa_bases) and each
+ * hart's per-cpu isa_bases.
+ */
+static int __init riscv_init_isa_bases(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		riscv_set_isa_bases(hart_isa[cpu].isa_bases, hart_isa[cpu].isa);
+
+	riscv_set_isa_bases(riscv_isa_bases, NULL);
+	return 0;
+}
+/*
+ * Registered as subsys_initcall so it runs after
+ * core_initcall(tagged_addr_init) populates have_user_pmlen_*.
+ */
+subsys_initcall(riscv_init_isa_bases);

-- 
2.43.0

