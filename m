Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44E13AB269
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790244991; cv=none; b=WM/JIkrwIG+GsO1joCspjv8SS9cGzaLJ1SZb/3vTVIwdBfF2bV/fCk1QTxjUWtjrhYWC0KY4VZKsS1aF47nYUbA2BfVry4DzxS6p5JQ1psb4ncDQ+HBLc4J+MB9yA/MSghHrnvRP1sfB/lfu4klUjSptpjgQ9nbz24E5H9h4N2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790244991; c=relaxed/simple;
	bh=MiE+4ItnXmHUBKhLrUz3zntIZyWtLRntpAxtOY0u6BY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Hx0YxiH3dCoNhtXJLfjp+6dzxbjF3h9wa7xaC41zGnKs+GPqik8AFg6LMlzeaCHqypjfq8ckUTwGOOUeC+/ssnJ43KzIJuWyWfBY2X+EidUrEqypMbJrnNntBDGcrhkzGfwHt6ncz1TrBvurVb5tm1vJ1P0XjfhnI1rpdjwl0ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=g9DSzDqs; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="g9DSzDqs"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd025d06so1642262c88.1
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 03:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1790244979; x=1790849779; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u7LK00oqDOE3QAV0dIPEwP0ZWU0x/VHk80FlxiovFNw=;
        b=g9DSzDqs8LuN4AeYdsx4K6TuX9oqHEq/5mGCol5OmHfpvvB/Z+YqSHP1/5ZWdeRQu6
         LBGKRLG1aqpGKVEbw8mzJ88IkmLVih4LqVGyffPKdO0Yc9oW4aBQilS051gTuWwki36D
         /7Gbq+fpXNW0PXiIR9pw1ZzTAdpGdmetqMO++m9CXuXIjcldqc6JFrcAZ12gZ+gYU/vv
         UZSWcvUlSuhROTmptcAf6g51snHEhuSmOTj3AmGbdlt1aC+SMwg4/Ibw+DIVxzVcr3zz
         o7+IxAf0D9ldllmkktLMbfncuhkTghJ5QT5aw49Le7pk6EYPtKI35yLj8WQWj7NJORar
         txvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790244979; x=1790849779;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u7LK00oqDOE3QAV0dIPEwP0ZWU0x/VHk80FlxiovFNw=;
        b=gkmBORrHg/KQt7dwL1m2ckwgsK8lAWv6Fi+r8yqYFLB8KR3i1CyrcZPioawkJ4e9Ux
         c78wzfstGWQLG8M7DVGPYNBV8B0kA/T8FW3P1zhhLWGz+FcsYNfVZcP4w9Pe5hFDGiUa
         JnlBrGWs9EUvshoO0v1/CDuMy547HReOukri965Ex23rMCg4PU/f4FuvpUikJy4/wdnJ
         e06FmTZTMkhgMijN0DThsRE+DoO+G9sJZFZZk7RHg1dXQqy2Qf2PG4YtNd9AP9nvpOFE
         SIhx/AfDxlkmGDsnBAHRpZYFLfmlbZ8UZ107IAu4STzPs0FvopUePCsaCZ20YirsNafP
         zI0w==
X-Forwarded-Encrypted: i=1; AKwUvBz+GrIipsxf6OXRpSbb+mXQ92y8tKTIKqQkhoWmd/1sydC1cFzVJFsMBT3Aly5hoYLNwXg=@vger.kernel.org
X-Gm-Message-State: AFuF++n+I8P86/dKjw3DwOiLo/OLQ2iJnT1fIeMHtgwxQVsVWxFqPArE
	MP0F3crH4EpAMoRpxQ4KkVB23Rh4/HLq8JKexYQWGbdqVq9/alYbqfvZaBJT6TAIfXs9mH84zK3
	Pku28VxFK3w==
X-Gm-Gg: AYBFou1o0xs9IkN83ryqAkTWH9MCuUl+45dzsNk1FObCrerZgys3hAtmsSvRCQalUDV
	bd+M8w9dh9RhC620X6qaOgOLDtVcIQGRPos6p4J+JajaEow36jx53+MzKhZgKjBMeQth1h0nOOr
	wERXPYnkya2lkThmTEGBEgHkaupcp3o7B2KyaglPrvjgeDS5ZmvA8tQsNekc/+zwb1mMdztd1SG
	szOZee6MFFpZQOntJhUN4ZqsR/LHGr+Wemb9/PfVKkbMDJ5J9+cFQipbj3QmNm5n2V+2rKNFbHX
	omos8Uh78UWin3U/Da1wqKgPAngyk6OLP5xZae24E+famO7xCYcIu/ospAKk0FUO4K2T2SiaA5F
	fjwXEkNp2cqnO0Xyl6S2vWOISXZhZwwrl/4sEk/lJET/MP9Tz6kh9+k2dHY0PRCX6m83nBUkQzA
	3qctjRin7btZDiE8RRjIJbh4fvqkimSza/yasV+ohArJszGjwIjHoFB2aOzUF3vz6wAFQBzOoQO
	m3rXTXCjZyBdA2GmWs=
X-Received: by 2002:a05:7300:c019:10b0:33b:c24c:47cd with SMTP id 5a478bee46e88-340035bf9d9mr1782888eec.16.1790244978791;
        Thu, 24 Sep 2026 03:16:18 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e975223fcsm12254595eec.31.2026.09.24.03.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:16:18 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Thu, 24 Sep 2026 03:16:13 -0700
Subject: [PATCH v2] RISC-V: Clear HSTATUS.HU on CPU initialization
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-hstatus_hu-v2-1-7e970f5f1d8d@sifive.com>
X-B4-Tracking: v=1; b=H4sIAGz4tGoC/22NywrCMBBFf6XM2kgTHw2u/A8pkqZTM4JNySRBK
 f13m7p1eeDcc2dgDIQMl2qGgJmY/LiC2lVgnRkfKKhfGVStzrWWjXAcTUx8d0kYabQ2qrFNJ2E
 dTAEHem+xW/tjTt0TbSyFYjji6MNne8uyeH/DWQoplLang+2H7ljrK9NAGffWv6BdluULdtg/e
 rcAAAA=
X-Change-ID: 20260817-hstatus_hu-a1a88a27c7b1
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, zong.li@sifive.com, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Yong-Xuan Wang <yongxuan.wang@sifive.com>, 
 Samuel Holland <samuel.holland@sifive.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790244977; l=3822;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=MiE+4ItnXmHUBKhLrUz3zntIZyWtLRntpAxtOY0u6BY=;
 b=lJsDgeDAFpzkUZgwbf6xofjnxNK0j5K+KDvcLG59+7QXUPCuV2SrHNbl6effhqne9YSnrJDPl
 DbbQVpzEO2jBsZbYKau8bP8WWRoX/urfT4BpbtZmYrJ8aUni4lV7kqg
X-Developer-Key: i=yongxuan.wang@sifive.com; a=ed25519;
 pk=+8NCHB1ZJvZthQAmZspOAaqjo+/snaW8mFSiDx45HxY=

The RISC-V privileged specification does not mandate HSTATUS reset
values, leaving the HU bit potentially set after hardware reset.
When HU=1, hypervisor instructions (HLV/HLVX/HSV) can execute in
U-mode to access guest memory, which may cause unintended behavior
if not explicitly controlled.

Clear HSTATUS.HU during CPU initialization to ensure hypervisor
instructions are only available in HS-mode, preventing unexpected
guest memory access from U-mode code.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
---
Changes in v2:
- Clear the hstatus.hu in the arch core setup instead of kvm core setup
(sashiko)
- Link to v1: https://patch.msgid.link/20260817-hstatus_hu-v1-1-28c53cdfb408@sifive.com
---
 arch/riscv/include/asm/cpufeature.h |  2 ++
 arch/riscv/kernel/cpufeature.c      | 12 ++++++++++++
 arch/riscv/kernel/setup.c           |  2 ++
 arch/riscv/kernel/smpboot.c         |  2 ++
 arch/riscv/kernel/suspend.c         |  2 ++
 5 files changed, 20 insertions(+)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 739fcc84bf7b..5efa72823475 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -40,6 +40,8 @@ extern u32 thead_vlenb_of;
 
 void __init riscv_user_isa_enable(void);
 
+void riscv_clear_hypervisor_csr(void);
+
 #define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size, _validate) {	\
 	.name = #_name,									\
 	.property = #_name,								\
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index f46aa5602d74..80767a016602 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -1183,6 +1183,18 @@ void __init riscv_user_isa_enable(void)
 		pr_warn("Zicbop disabled as it is unavailable on some harts\n");
 }
 
+void riscv_clear_hypervisor_csr(void)
+{
+	if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_h))
+		return;
+
+	/*
+	 * Clear HSTATUS.HU to restrict hypervisor instructions to HS-mode.
+	 * This prevents user-mode from executing HLV/HSV instructions.
+	 */
+	csr_clear(CSR_HSTATUS, HSTATUS_HU);
+}
+
 #ifdef CONFIG_RISCV_ALTERNATIVE
 /*
  * Alternative patch sites consider 48 bits when determining when to patch
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 52d1d2b8f338..bf42efd848f6 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -364,6 +364,8 @@ void __init setup_arch(char **cmdline_p)
 
 	if (!IS_ENABLED(CONFIG_RISCV_ISA_ZBB) || !riscv_isa_extension_available(NULL, ZBB))
 		static_branch_disable(&efficient_ffs_key);
+
+	riscv_clear_hypervisor_csr();
 }
 
 bool arch_cpu_is_hotpluggable(int cpu)
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index f6ef57930b50..a9de2dae804c 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -244,6 +244,8 @@ asmlinkage __visible void smp_callin(void)
 
 	numa_add_cpu(curr_cpuid);
 
+	riscv_clear_hypervisor_csr();
+
 	pr_debug("CPU%u: Booted secondary hartid %lu\n", curr_cpuid,
 		cpuid_to_hartid_map(curr_cpuid));
 
diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
index 3efbf7874f3b..db220966f782 100644
--- a/arch/riscv/kernel/suspend.c
+++ b/arch/riscv/kernel/suspend.c
@@ -43,6 +43,8 @@ void suspend_save_csrs(struct suspend_context *context)
 
 void suspend_restore_csrs(struct suspend_context *context)
 {
+	riscv_clear_hypervisor_csr();
+
 	csr_write(CSR_SCRATCH, 0);
 	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_XLINUXENVCFG))
 		csr_write(CSR_ENVCFG, context->envcfg);

---
base-commit: b5060a4aa33d7d78a8c1837ab08ef0c81ea96650
change-id: 20260817-hstatus_hu-a1a88a27c7b1

