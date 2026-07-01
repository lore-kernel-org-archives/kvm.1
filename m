Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD2B48A2D3
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782910482; cv=none; b=iLzzTqe8NPqdJVJJ0n7zUoAoE0YJdXqCH0HWMSrhK4auux8N3+8UBbV7GtPgC1r15xM3YLhEB3Yq4R6Jsn2RYNytFcBw/ik4m56qeke3qERCrZ0P0awPcpeVpHSOogXkaYmZc40Bz1uPCao0RHqssOdxjnkAvNGYD8Rs+L3t1mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782910482; c=relaxed/simple;
	bh=VLWilKP6ucRhVP1O1gGpGwyupoc41SLj/hvGXaJ29RQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fu+FGhA8ySbpAECLhAAlWqDzVrSsJIvbhJAkTQAY7rm/YSuJP3SHB5NnhdANMA3y6yDxf6hBXoUwFhP/+OPDOOuaCYLhNqIXAZoXfsMOR4D5j/pL2gq6FE5blvCqBnP3ILC79CHhoPQoLwbCtqwThMzevlP8UFq5RG2SIBFSq5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6BqdlXP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6BqdlXP"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-845f2909cd4so281363b3a.1
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 05:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782910478; x=1783515278; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZxsAhQO08nchBu0N72CIaBjipJTc4e3B80SKfWk0ZI=;
        b=F6BqdlXPLOBGxozs/rOsz92sJY6c7lqzwUh1HhvKnj0wIrBfQMt4E1p4SFyynUzW7i
         aNrExEwm02xsZL23l4SUzLVwL+piWGqwoY4NbFwm5XRJRlTgT6OJDqeRFlKsbA5kCnIV
         IqGQ70OqA/j3agYiHV08JHC6uxw6hzk3s5AmFnKG3crkVRh4rhVjnNmMiHvgKFHp6Ups
         bXFJYVDbOAVoWifl1qoGKidTstZm9Hqaij8jANE/3ejeNme0gwjD0wahsCJdmlbla5ZK
         SKAHT7053gN60wmO+yr8EKXrPogHa+GyXT3NqBKKXf8Fvc8JnzvzdUdnSThm38SbOBjQ
         GqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782910478; x=1783515278;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bZxsAhQO08nchBu0N72CIaBjipJTc4e3B80SKfWk0ZI=;
        b=CtC5vIJ+VWHTZd4VHXJFEks2QCODpiIu/dDPKxi4Pg2ZJEuTKYiLqKQlHQEoPcp8ZE
         l5xNnQotVaprGaoF089kvdomGU6GhyZh0dgxDq8rOEX87Aj3ghm9SKFYLFFuQLuKZrk9
         ulTM+Lo8F6pBcoselpffKoPixI6QaBUQhNP0jHkD0jBtygJyVXSCuAJz3OLytPRcsj+P
         r0EH3CUSkHmWoaLXrIFseu+0Urtp4z2wGb8mOzEoC3JWxd0T+UIlbHVsKAr1NhPgBzCN
         gMFRZjQ2S5WsL/nzvztK5EnEY5pA6k0RZ1ixq0JjMz199FFr4iQ/nptR4a+zr0Hdrr82
         +x6w==
X-Forwarded-Encrypted: i=1; AHgh+Rpvw9D/VDU0NomRyFhCI0VyWwqis/0KEDTSj8ceZYNGoTnirP4DkzeEtzPLolznGOYQFcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJsxAYFI56wEIwPg/HnLc6KBnlj+guc4k6sJVEeRD0vlfS5pfJ
	wZTT/NQENmMpiYhae4XnfpMK8iQoIt8LqORGH6R5h9ZCZRM7CE/Q7Px0
X-Gm-Gg: AfdE7ckNzHbZqChwhpxhq4Nv8NpNDy3a5NL0nn4/HZY8py202/CWwpHaHDgS9mFw1CW
	s9bhs8LKUYijacGTqiHEM/+5v9NUe3HfZQpwt97Uxe5rHW06/kyY6afnGsHXqtW9ENV0xDeSqVB
	//mXDJGCzDw6csG/FcLy8Z2LuzLiH30VceVMtw44GhN+9F7NN4IFRVT+Vb/j1BfoY11YP2o7GHi
	nMp75G2DuQ5WyNq5LzA5DdkuZA4h8pqEa45uqhAp3O8nnal118vQM7DkvVdNgq3IujbxWUr8gn9
	JMfNzEMzOWJRY7QoPMpE612n6woBleYDJUjUKXH5ZIptYmCdnMF7IW1FYMKmsyvIK9uLsvLHH5X
	108z74GeGVxOSWHtzMf3Tds7wIHXv6wnyG57gWRL0kkXVYIfNDoRDliv6/POwVf7b/YR3ojNAzD
	n+ktVpdOeaWr+IO/KS/YFW
X-Received: by 2002:a05:6a00:1bc3:b0:835:6388:655d with SMTP id d2e1a72fcca58-847c0723d59mr1533915b3a.14.1782910477909;
        Wed, 01 Jul 2026 05:54:37 -0700 (PDT)
Received: from [127.0.1.1] ([120.244.9.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a03778basm3999403b3a.49.2026.07.01.05.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 05:54:37 -0700 (PDT)
From: Guodong Xu <docular.xu@gmail.com>
Date: Wed, 01 Jul 2026 08:52:25 -0400
Subject: [PATCH v5 12/17] riscv: dts: spacemit: k1: Add Zic64b ISA
 extension
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-rva23u64-hwprobe-v2-v5-12-2c61f94a695a@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10106; i=docular.xu@gmail.com;
 h=from:subject:message-id; bh=VLWilKP6ucRhVP1O1gGpGwyupoc41SLj/hvGXaJ29RQ=;
 b=owGbwMvMwCXWtEl1Z3CGpCDjabUkhixX3rZ5vSEdyRlfXUS7kt2118a5MCdNEXG8bf/11b64g
 g+7bGQ7SlkYxLgYZMUUWQ4fbcne+son2vc55w+YOaxMIEMYuDgFYCLvNRh+MZ+8vv7d5ee58Rpe
 gkY5M3ZHbxJeNpW/JSSQ9YKzbKP8O0aGk4/FVrCcTHBm7NsuGPXeMZjp8N17d5h9Pa9UNnmxWic
 zAQA=
X-Developer-Key: i=docular.xu@gmail.com; a=openpgp;
 fpr=90B1DC3DF0BD10FD1227BD6344F254AF42F143EE

The K1 X60 cores have 64-byte cache blocks, described by their
cbom/cbop/cboz-block-size of 64, so they implement Zic64b.  Declare it in
each core's riscv,isa-extensions and in the deprecated riscv,isa string.

Signed-off-by: Guodong Xu <docular.xu@gmail.com>
---
v5: No change.
v4: No change.
v3: New patch.
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 80 ++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index 08a0f28d011fe..f179c619f5807 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -54,12 +54,12 @@ cpu_0: cpu@0 {
 			compatible = "spacemit,x60", "riscv";
 			device_type = "cpu";
 			reg = <0>;
-			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
+			riscv,isa = "rv64imafdcbv_zic64b_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
 			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
-					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
-					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
-					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zic64b",
+					       "zicbom", "zicbop", "zicboz", "zicntr", "zicond",
+					       "zicsr", "zifencei", "zihintpause", "zihpm", "zfh",
+					       "zba", "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
 					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
 			riscv,cbom-block-size = <64>;
 			riscv,cbop-block-size = <64>;
@@ -84,12 +84,12 @@ cpu_1: cpu@1 {
 			compatible = "spacemit,x60", "riscv";
 			device_type = "cpu";
 			reg = <1>;
-			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
+			riscv,isa = "rv64imafdcbv_zic64b_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
 			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
-					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
-					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
-					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zic64b",
+					       "zicbom", "zicbop", "zicboz", "zicntr", "zicond",
+					       "zicsr", "zifencei", "zihintpause", "zihpm", "zfh",
+					       "zba", "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
 					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
 			riscv,cbom-block-size = <64>;
 			riscv,cbop-block-size = <64>;
@@ -114,12 +114,12 @@ cpu_2: cpu@2 {
 			compatible = "spacemit,x60", "riscv";
 			device_type = "cpu";
 			reg = <2>;
-			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
+			riscv,isa = "rv64imafdcbv_zic64b_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
 			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
-					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
-					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
-					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zic64b",
+					       "zicbom", "zicbop", "zicboz", "zicntr", "zicond",
+					       "zicsr", "zifencei", "zihintpause", "zihpm", "zfh",
+					       "zba", "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
 					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
 			riscv,cbom-block-size = <64>;
 			riscv,cbop-block-size = <64>;
@@ -144,12 +144,12 @@ cpu_3: cpu@3 {
 			compatible = "spacemit,x60", "riscv";
 			device_type = "cpu";
 			reg = <3>;
-			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
+			riscv,isa = "rv64imafdcbv_zic64b_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
 			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
-					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
-					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
-					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zic64b",
+					       "zicbom", "zicbop", "zicboz", "zicntr", "zicond",
+					       "zicsr", "zifencei", "zihintpause", "zihpm", "zfh",
+					       "zba", "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
 					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
 			riscv,cbom-block-size = <64>;
 			riscv,cbop-block-size = <64>;
@@ -174,12 +174,12 @@ cpu_4: cpu@4 {
 			compatible = "spacemit,x60", "riscv";
 			device_type = "cpu";
 			reg = <4>;
-			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
+			riscv,isa = "rv64imafdcbv_zic64b_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
 			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
-					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
-					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
-					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zic64b",
+					       "zicbom", "zicbop", "zicboz", "zicntr", "zicond",
+					       "zicsr", "zifencei", "zihintpause", "zihpm", "zfh",
+					       "zba", "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
 					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
 			riscv,cbom-block-size = <64>;
 			riscv,cbop-block-size = <64>;
@@ -204,12 +204,12 @@ cpu_5: cpu@5 {
 			compatible = "spacemit,x60", "riscv";
 			device_type = "cpu";
 			reg = <5>;
-			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
+			riscv,isa = "rv64imafdcbv_zic64b_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
 			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
-					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
-					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
-					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zic64b",
+					       "zicbom", "zicbop", "zicboz", "zicntr", "zicond",
+					       "zicsr", "zifencei", "zihintpause", "zihpm", "zfh",
+					       "zba", "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
 					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
 			riscv,cbom-block-size = <64>;
 			riscv,cbop-block-size = <64>;
@@ -234,12 +234,12 @@ cpu_6: cpu@6 {
 			compatible = "spacemit,x60", "riscv";
 			device_type = "cpu";
 			reg = <6>;
-			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
+			riscv,isa = "rv64imafdcbv_zic64b_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
 			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
-					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
-					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
-					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zic64b",
+					       "zicbom", "zicbop", "zicboz", "zicntr", "zicond",
+					       "zicsr", "zifencei", "zihintpause", "zihpm", "zfh",
+					       "zba", "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
 					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
 			riscv,cbom-block-size = <64>;
 			riscv,cbop-block-size = <64>;
@@ -264,12 +264,12 @@ cpu_7: cpu@7 {
 			compatible = "spacemit,x60", "riscv";
 			device_type = "cpu";
 			reg = <7>;
-			riscv,isa = "rv64imafdcbv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
+			riscv,isa = "rv64imafdcbv_zic64b_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
 			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zicbom",
-					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
-					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
-					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "b", "v", "zic64b",
+					       "zicbom", "zicbop", "zicboz", "zicntr", "zicond",
+					       "zicsr", "zifencei", "zihintpause", "zihpm", "zfh",
+					       "zba", "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
 					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
 			riscv,cbom-block-size = <64>;
 			riscv,cbop-block-size = <64>;

-- 
2.43.0

