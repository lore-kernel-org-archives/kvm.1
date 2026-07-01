Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C148A2BD
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910528; cv=none; b=WUKPQOz7Oq6udQ5Iun1GiDDp9nwTLTc3qHtQeoiSQuj9Ew4m5+OT2DqLV9xl+EB0St7A0RmwEBwPlhmh9YE2TMN1FV7g7eAoL7wbeAv8lULTrzNTi035jXuyjTrc1fUexuo2lGjCMNYWKVrfpvZzmXuTBGna6z9ZwavChBLBZyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910528; c=relaxed/simple;
	bh=JS2yG9pDjGwh3KA79+kpc5rS+oVEF7mlXGQkOFvbxFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tBUGiTAjgsQm+yvRIr1THJeLofEEtk2SutumChFBHjVCqqAKeVi41NQHNxHnKnRfMvx3G/KnREDgZHlgXjBFoYUrWuE3716ZFK0kSYegVcVMQ/gMrs6AwkdK9CkfU/SoQl9u7ZGcND3oYD6/6SqB2UCO475f/CMUYe5uBAeE5aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR4aiH8B; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR4aiH8B"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8454160043aso419060b3a.3
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 05:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782910527; x=1783515327; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0UYpoyK5fl+7ujxdLva1zphzrbPXeYkLwxH26RQow7w=;
        b=BR4aiH8BOQQC2xNpBAVnQ9us6xtKwlsSiuxwOCRxI5J21LC7jQduRS/v10pTc3eVdf
         Javdycerofv65LDjN4/bpn1DXW5x5fuWGcIfghurFf2XyVf59Vfjq2D7sWZ19EygHGHr
         VTfLIOTWTgfKf6nNduq4U6Knkk7XhSYVK1z+Pv6Rx0DQ649+Y0M6HonulyAxKzsUcwo1
         BPjDW4/r3EgIOv71Q6DZUu7g6gePUA8rn7tLbzfvOjGUJbjKq+TYK2fsYiJPuFf3R5Pe
         CaBuD7H6xtilHhpMrnl1q9iSU1W34MjLDOGP3QBMoK8lhFu8JD/PNfuW9fBZbaen5ufq
         ezzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782910527; x=1783515327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0UYpoyK5fl+7ujxdLva1zphzrbPXeYkLwxH26RQow7w=;
        b=eCQerrFbdDYl/QxMepVnA2QXXmDyEO1ygvIkM5mKmjxozeIbtRM4ypX6z5vvlTw6Zm
         VU9JbDhD5QuXrQs2PolhtXBY3fdYaMrU5hNBZnPUwjp3yT/LLV+8VdK5ljXItbXIv8Wr
         Lv3psMjHhJarSwvz7HotM7EEIX22cZD/5FwpinFiwxYVACIXHtSbmBze9AeAR2XqGcMU
         cBcX/omi4odOWJV83MBEBfn31hw296QD/p0+DQoKqnu+OTCfJYdBuXCXeD8rMbL6WY89
         hzIFUuCsL1Ih5ccnTE/XhM+7SuxlC84j644wa+vXXH9lF8gAkjLOJlPsgb/fEWHwIOf3
         0OoA==
X-Forwarded-Encrypted: i=1; AHgh+RocObPruCFvr+X881v1qkzXmePUy8HfYyN3DyJapAqWXJ0TKhGjush0Smbbx3Gi3lU3Lu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLDd5d7p+0ut0hwbbTYrGhpmKmS47BGgYQoAVzDipphonRfkeE
	PCWR4/2ZloXHM2GAjFDc34lVzIA+N65eX/sDxj8qaaI4yeb++07JsTKR
X-Gm-Gg: AfdE7ckD1W5Nu2Pn8TKtzlCYs3P8/9OKDMzJwZDqywAtE/y51Q0EVLaQGmE98nYQ4Oz
	EeettR6H2SXhPBBQHLjT6Lwzize3gMZfdp7MKOnUedz7gpJMtfVEHvK/v51J0Rpg24uxs70vuzM
	mJwGxI41RDrx2OgzN9bnzSnLhu2zz347Eo5xxtlUb+yV/dh8N9wIORVUL+TI9L+1TJWSL0/VWNk
	zWik20J9esiOUlEwUPJJvX6Rl1vnKwLE9eW4e6F0GuNdiaQnPhWN0bsSvPQHIjp/CCH80PlG3/S
	QHorrybBOnjnduZsdTOaV89Vvj1vQSTPSxncxvsU0QeLJ7Xc8QSwXVeTsy5KDHchaSmjce4su4O
	xwyYMScQ3jxep+Srm7ECtTK/e0smbIH9MHc1P6qX5gYY+H1rMVnTpgPTeGCNQZWBLWfR0Hyxl4v
	d6h82c7Sp8O+qU4TKl7Q0q
X-Received: by 2002:a05:6a00:8d0:b0:847:83bd:6676 with SMTP id d2e1a72fcca58-847c0797314mr1543138b3a.17.1782910526573;
        Wed, 01 Jul 2026 05:55:26 -0700 (PDT)
Received: from [127.0.1.1] ([120.244.9.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a03778basm3999403b3a.49.2026.07.01.05.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 05:55:26 -0700 (PDT)
From: Guodong Xu <docular.xu@gmail.com>
Date: Wed, 01 Jul 2026 08:52:30 -0400
Subject: [PATCH v5 17/17] riscv: hwprobe: Introduce rva23u64 base behavior
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-rva23u64-hwprobe-v2-v5-17-2c61f94a695a@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4859; i=docular.xu@gmail.com;
 h=from:subject:message-id; bh=JS2yG9pDjGwh3KA79+kpc5rS+oVEF7mlXGQkOFvbxFc=;
 b=owGbwMvMwCXWtEl1Z3CGpCDjabUkhixX3vaDBvML16z7O4dpxQF11qYlJadmHrDpqhEv/rXBV
 9tr7sX4jlIWBjEuBlkxRZbDR1uyt77yifZ9zvkDZg4rE8gQBi5OAZiI4i6G//W2Nn4L07wviPnP
 LdUK7wr5wKn66Jh0oNmqaTU/WmetLGNkuBHhnqF5wDSfY9vegt8vfd7POrRq0kY2Y3mJhecqlh3
 h4gEA
X-Developer-Key: i=docular.xu@gmail.com; a=openpgp;
 fpr=90B1DC3DF0BD10FD1227BD6344F254AF42F143EE

Provide a hwprobe base-behavior bit so userspace can check RVA23U64
support in one call.  Without it, a consumer needs five hwprobe
calls and four prctl calls, which is error-prone to require of every
caller.  Most software treats RVA23U64 as a new base anyway, so
expose it directly.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Signed-off-by: Guodong Xu <docular.xu@gmail.com>
---
v5: No change.
v4: No change.
v3: No change.
v2:
- Detect RVA23U64 by reading from the cached hart_isa[].isa_bases
  bitmap populated by riscv_init_isa_bases() at init time, sharing
  one source of truth with /proc/cpuinfo.
---
 Documentation/arch/riscv/hwprobe.rst               |  8 ++++++++
 arch/riscv/include/uapi/asm/hwprobe.h              |  3 ++-
 arch/riscv/kernel/sys_hwprobe.c                    | 23 +++++++++++++++-------
 tools/testing/selftests/riscv/hwprobe/which-cpus.c |  2 +-
 4 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 32a14331eb9de..dc70470093b1b 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -67,6 +67,14 @@ The following keys are defined:
       programs (it may still be executed in userspace via a
       kernel-controlled mechanism such as the vDSO).
 
+  * :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_RVA23U64`: Support for all mandatory
+    extensions of RVA23U64, as defined in the RISC-V Profiles specification
+    starting from commit 0273f3c921b6 ("rva23/rvb23 ratified").
+
+    The RVA23U64 base is based upon the IMA base and therefore IMA extension
+    keys (e.g. :c:macro:`RISCV_HWPROBE_KEY_IMA_EXT_0`:) may be used to probe
+    optional extensions.
+
 * :c:macro:`RISCV_HWPROBE_KEY_IMA_EXT_0`: A bitmask containing extensions
   that are compatible with the :c:macro:`RISCV_HWPROBE_BASE_BEHAVIOR_IMA`:
   base system behavior.
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 36ec8ab470423..50733d3db7633 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -21,7 +21,8 @@ struct riscv_hwprobe {
 #define RISCV_HWPROBE_KEY_MARCHID	1
 #define RISCV_HWPROBE_KEY_MIMPID	2
 #define RISCV_HWPROBE_KEY_BASE_BEHAVIOR	3
-#define		RISCV_HWPROBE_BASE_BEHAVIOR_IMA	(1 << 0)
+#define		RISCV_HWPROBE_BASE_BEHAVIOR_IMA		(1 << 0)
+#define		RISCV_HWPROBE_BASE_BEHAVIOR_RVA23U64	(1 << 1)
 #define RISCV_HWPROBE_KEY_IMA_EXT_0	4
 #define		RISCV_HWPROBE_IMA_FD		(1 << 0)
 #define		RISCV_HWPROBE_IMA_C		(1 << 1)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 3e80e5551ae0d..3f66f2e99d41a 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -226,6 +226,17 @@ static bool hwprobe_ext0_has(const struct cpumask *cpus, u64 ext)
 	return (pair.value & ext);
 }
 
+static bool hwprobe_has_isa_base(const struct cpumask *cpus, unsigned int base)
+{
+	int cpu;
+
+	for_each_cpu(cpu, cpus) {
+		if (!test_bit(base, hart_isa[cpu].isa_bases))
+			return false;
+	}
+	return true;
+}
+
 #if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
 static u64 hwprobe_misaligned(const struct cpumask *cpus)
 {
@@ -308,14 +319,12 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 	case RISCV_HWPROBE_KEY_MIMPID:
 		hwprobe_arch_id(pair, cpus);
 		break;
-	/*
-	 * The kernel already assumes that the base single-letter ISA
-	 * extensions are supported on all harts, and only supports the
-	 * IMA base, so just cheat a bit here and tell that to
-	 * userspace.
-	 */
 	case RISCV_HWPROBE_KEY_BASE_BEHAVIOR:
-		pair->value = RISCV_HWPROBE_BASE_BEHAVIOR_IMA;
+		pair->value = 0;
+		if (hwprobe_has_isa_base(cpus, RISCV_ISA_BASE_IMA))
+			pair->value |= RISCV_HWPROBE_BASE_BEHAVIOR_IMA;
+		if (hwprobe_has_isa_base(cpus, RISCV_ISA_BASE_RVA23U64))
+			pair->value |= RISCV_HWPROBE_BASE_BEHAVIOR_RVA23U64;
 		break;
 
 	case RISCV_HWPROBE_KEY_IMA_EXT_0:
diff --git a/tools/testing/selftests/riscv/hwprobe/which-cpus.c b/tools/testing/selftests/riscv/hwprobe/which-cpus.c
index 587feb198c049..f8c797b1d0fd9 100644
--- a/tools/testing/selftests/riscv/hwprobe/which-cpus.c
+++ b/tools/testing/selftests/riscv/hwprobe/which-cpus.c
@@ -105,7 +105,7 @@ int main(int argc, char **argv)
 	pairs[0] = (struct riscv_hwprobe){ .key = RISCV_HWPROBE_KEY_BASE_BEHAVIOR, };
 	rc = riscv_hwprobe(pairs, 1, 0, NULL, 0);
 	assert(rc == 0 && pairs[0].key == RISCV_HWPROBE_KEY_BASE_BEHAVIOR &&
-	       pairs[0].value == RISCV_HWPROBE_BASE_BEHAVIOR_IMA);
+	       (pairs[0].value & RISCV_HWPROBE_BASE_BEHAVIOR_IMA));
 
 	pairs[0] = (struct riscv_hwprobe){ .key = RISCV_HWPROBE_KEY_IMA_EXT_0, };
 	rc = riscv_hwprobe(pairs, 1, 0, NULL, 0);

-- 
2.43.0

