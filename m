Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393C2392C29
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 20:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208828; cv=none; b=Wg8+t2FZi72RtTLkv75sfH1kc+6RpsQNidU4as4Yve9yFG4xat85olbZY7vlAZABAWSDGVoYkPvpWILnWbuVLX3fPcyEiZ5BoeqCaEY4XQQYNji7iywEW+ccpoBINX9sNGMPcA9GOQbSEaQlGeYkPNa+PMBICL7gRxPI5hXB7wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208828; c=relaxed/simple;
	bh=NbZKfIhAESQSZGLKBeiejMf182pR47BEC4U9FBjuJWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sSB6sa44PsJYkMqSPO8lNyZBW0ChrjTAiUuIzsELK2GiubzjH7Okn4bYjnnx+SQfayiW/wXE73qOE7IgCN8TlNumsgpOodUOi8W6XzHxDPcNTZeonXkgwvcvTD4YB7TJzxnLiBMMizpYTbXlto5qnIVtQvShrJxAjePlg0XLoIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrX8ICu+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrX8ICu+"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0c2c7e0c5so1874135ad.1
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781208826; x=1781813626; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZxM0nq9Qo37aSql2ij+ibdvlWTuLmx0z98uOay5MXI=;
        b=lrX8ICu+A7SivIpxFyZ/wuaPZ46IcbvIVGySeKF7P1e1Tf9figTcsNL/Rv4utgFkMo
         sPsupzycVKcdKJZ8JhsLBdnH2XdaHYZpX2WBoj2iklXbxc29IdXxii4BkwIze03QIaJ7
         GGTwMnddWAPujUWyk9+Z6OMijG0Y59KS8DYXKE3+CQg6wR+UWM5Rd9jUNYCLyAsYfsHV
         25DjGYTDx/EzT9AwCN9QTG5oE7IcAhg/GUWaaT0VMG6uUJd7hFRSAMbzx2nLHjeN/V4m
         fLaKSnJXixABJfq1/BW0RLdPGhj/6+235aNmA6Npti68WOcX0K10tlH9Ksn5HjeIllNH
         qtew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781208826; x=1781813626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SZxM0nq9Qo37aSql2ij+ibdvlWTuLmx0z98uOay5MXI=;
        b=mpwmwvm4ttrz+CLf4dD+R4c7Wb3EyWZ0koXE2f2TWAtdPc1ZezIy61N+5FrulXMpgM
         KIz0Ua7ulW+ETJYSYj9PiCJrh9nmzN9ko1NE6niMX8w3EFszavTqnbWEFDs1dS5tJ2G/
         gs65DsbWFMREeZxrfU+BTh+BWPqKg4JrHqKfibLtiTwLv4sgospl0vB1sDB6tsowS2M1
         Um38wxacDQlcEODwQE9ir1TPKbC7XOmQfNoaKCJBnuzfw+pGVggw48TeALcS7ZJEQ6A/
         S8Qo9Osjto6pg6hYfJe7aX2ie5C5ETi3n7FoiiBIGEsS5H+9R6AyqO0Z5uhmaQ0ewgAh
         5BIg==
X-Forwarded-Encrypted: i=1; AFNElJ9laUljMmXrPPx2EXK3qpca6QVA+egPXCQtdjH0q0+zW+dLIhEHt5XOrfoRUBLUpqDA7x8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqu0xjzeGcth5Ovl8Ibyg2zBgnrBnQPT2oaJfcIg/FLg7j0fUk
	elv4GCQrgs0ez+GWwDYJW/wBVFq8PQMxLOcrVvR2tlv4GBstiKTWwnVl
X-Gm-Gg: Acq92OG9X5xMZwL/htmo55o/BY9CEKFz3K1iMoiBlIXqI74Wm/+9SkifRf5RZt9Cbdu
	tIIMAlZHzPD+IMLTNLReYNtIX4kViXfEl/0si81p48cYTGXqONz4LbX1fNx/B3+n0n1JVeQP9PC
	obxhzdWRMLKaoZd8Ouu7p/hPOiiqKIPKkxuKFT6a944R3CcBMapXZc40xEksQf8R9MuyUe/SK3q
	2fUDO5/w/fkDfiEvzn83M/uEuEQqDfZhfqs1Jv/sIx+SVEbcsdD9K/+FgdEekf6R8+O3qhO08zs
	NU4hsP1PFZ9XHvuBx1GWTZ0CuRXCDRidotuQUTvxmo5giLt9roSNJ6Qbwbyf5SLLcjBaIEtQbGH
	43NCdKZDIZVS7kBMAJgEwUyKPWHRRfM5ACqqf1PTszp99dmTqYWu80Eh4E8WE1wvIltqoeiWzKA
	==
X-Received: by 2002:a17:902:f60c:b0:2c2:7baf:139f with SMTP id d9443c01a7336-2c2f2693495mr50380055ad.30.1781208826458;
        Thu, 11 Jun 2026 13:13:46 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::302d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f875casm288730475ad.22.2026.06.11.13.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:13:46 -0700 (PDT)
From: Guodong Xu <docular.xu@gmail.com>
Date: Thu, 11 Jun 2026 16:12:42 -0400
Subject: [PATCH v4 05/16] riscv: Add Zicclsm to cpufeature and hwprobe
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-rva23u64-hwprobe-v2-v4-5-3f01a2449488@gmail.com>
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
 Guodong Xu <docular.xu@gmail.com>, Jesse Taube <jesse@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Andy Chiu <andybnac@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4415; i=docular.xu@gmail.com;
 h=from:subject:message-id; bh=5gK/AJ7I7Z0fBTNqkcRMKGgIqY4cXewYPVL687SON2g=;
 b=owGbwMvMwCXWtEl1Z3CGpCDjabUkhixtsQNLEkV1ZpjuVfdXemZh73iycw/Dg4u5M1YkfLdJW
 stekszdUcrCIMbFICumyHL4aEv21lc+0b7POX/AzGFlAhnCwMUpABM5+ZThn9Lc/lJlgV/G6qEu
 nGtbnFuuTzxYpV1zqGBWnqLL5KDMHwz/PR+Yh9lkftX7wVj0+dsrd/ENPUr/WiXcdKTYX/RVm5u
 wAgA=
X-Developer-Key: i=docular.xu@gmail.com; a=openpgp;
 fpr=90B1DC3DF0BD10FD1227BD6344F254AF42F143EE

From: Jesse Taube <jesse@rivosinc.com>

Zicclsm requires misaligned support for all regular load and store
instructions, both scalar and vector, but not AMOs or other
specialized forms of memory access, to main memory regions with both
the cacheability and coherence PMAs, as defined in the profiles spec.
Even though mandated, misaligned loads and stores might execute
extremely slowly. Standard software distributions should assume their
existence only for correctness, not for performance.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Jesse Taube <jesse@rivosinc.com>
[Rebased, rewrote doc text, minor commit message revisions]
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Signed-off-by: Guodong Xu <docular.xu@gmail.com>

---
v4: No change.
v3:
- Move the hwprobe.rst entry to the IMA_EXT_1 section so its
  documentation matches the IMA_EXT_1 bit it was allocated in v2
  (Sashiko, agreed by Andrew).
v2:
- Rebased onto v7.1-rc2; moved ZICCLSM to IMA_EXT_1 and
  allocated a new bit for it
---
 Documentation/arch/riscv/hwprobe.rst  | 4 ++++
 arch/riscv/include/asm/hwcap.h        | 1 +
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/cpufeature.c        | 1 +
 arch/riscv/kernel/sys_hwprobe.c       | 1 +
 5 files changed, 8 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index d9928641deb99..49d9fb68632d0 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -401,3 +401,7 @@ The following keys are defined:
     as defined in version 1.0 of the RISC-V Control-flow Integrity (CFI)
     extensions specification, ratified in commit 302a2d45c243
     ("Update build-pdf.yml") of riscv-cfi.
+
+  * :c:macro:`RISCV_HWPROBE_EXT_ZICCLSM`: The Zicclsm extension is supported,
+    as defined in the RISC-V Profiles specification starting from commit
+    b1d80660 ("Updated to ratified state.")
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 44bf8c7d8acc5..e8f4a7dd96a93 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -112,6 +112,7 @@
 #define RISCV_ISA_EXT_ZCLSD		103
 #define RISCV_ISA_EXT_ZICFILP		104
 #define RISCV_ISA_EXT_ZICFISS		105
+#define RISCV_ISA_EXT_ZICCLSM		106
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 9139edba0aecb..6819df159c51e 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -116,6 +116,7 @@ struct riscv_hwprobe {
 #define RISCV_HWPROBE_KEY_ZICBOP_BLOCK_SIZE	15
 #define RISCV_HWPROBE_KEY_IMA_EXT_1		16
 #define		RISCV_HWPROBE_EXT_ZICFISS	(1ULL << 0)
+#define		RISCV_HWPROBE_EXT_ZICCLSM	(1ULL << 1)
 
 /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 686dde3ce3b98..1fb595581adcf 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -502,6 +502,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts, riscv_ext_zicbom_validate),
 	__RISCV_ISA_EXT_DATA_VALIDATE(zicbop, RISCV_ISA_EXT_ZICBOP, riscv_ext_zicbop_validate),
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts, riscv_ext_zicboz_validate),
+	__RISCV_ISA_EXT_DATA(zicclsm, RISCV_ISA_EXT_ZICCLSM),
 	__RISCV_ISA_EXT_DATA(ziccrse, RISCV_ISA_EXT_ZICCRSE),
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicfilp, RISCV_ISA_EXT_ZICFILP, riscv_xlinuxenvcfg_exts,
 					  riscv_cfilp_validate),
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index f8f68ba781b45..9cf62266f1890 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -205,6 +205,7 @@ static void hwprobe_isa_ext1(struct riscv_hwprobe *pair,
 		 * in the hart_isa bitmap, are made.
 		 */
 		EXT_KEY(isainfo->isa, ZICFISS, pair->value, missing);
+		EXT_KEY(isainfo->isa, ZICCLSM, pair->value, missing);
 	}
 
 	/* Now turn off reporting features if any CPU is missing it. */

-- 
2.43.0

