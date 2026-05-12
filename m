Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BFC3F2116
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506613; cv=none; b=SfK8ClUD0FtafdSWA7waveslvwUWQhpHdanGwDwnDbCVyuOREGU3lH/IOBhLT6JswsCNcGoGc2PhV370lyu1fPZfToBBFE7nTJg68jdszXOtjCy6OwUyaT5eZvBjMU8IIqbx6o+kNaDdXCrZzJRCFWcLgmYSvNII6UDos0dlwZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506613; c=relaxed/simple;
	bh=btPka3uhwXWcLn3XzAxmZQCEH/IOtTSVNWSQTEzJ5Vo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N+u1XcwTJoSelMsAI5BWyw34JdvFuQColqnxCXwRxUdhSGDTv70t0vfWnmWZzbzc0B+dOTZPx7+orJz8g/t0jCFTk7e/S2fB+fLSTMRzEVrK8s5PaQIRWTMu//M1rykK6WjUQAbYSEYEEs1NxjdqgSuyWg7yd2Knx/1KxoocINs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=Iz4Kh+HM; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Iz4Kh+HM"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-366be8040a9so1254448a91.3
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 06:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1778506611; x=1779111411; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U7GyZnvSj+meNOJSgPSxs0cFVvDT8MNweX/dQpEyHMI=;
        b=Iz4Kh+HMSCsIIrWlrfwK9ZmUaJSEV58UwGSsqoVdCatV+B8vWwshMH63n7VlEzuEim
         RZkNN1l7eBG2mLkSYczX4i7hi6hm8/7xJKRCFg5L3Qk+qXZ2Ad/EGA4Fwsak3bDOlEE2
         8fl/Q+YQGgnknYf9b0hLzLRBuCnanaA600gir4fx3QlK8K9WBlSyZQfs1YdBvfKSenck
         sy2GWcUF2bOhPrFVQv75Y2X0MgfcvFyuGf77Z0NpnbOQvnw1s1k6a7U3rWJjdGcvi3ZS
         VA47WtEaaxJgrGbBok04wSFhK9HNmz/zqy3PGMkJ20gmcNW/oVBssfUmzYs30PN1/IgH
         JPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778506611; x=1779111411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U7GyZnvSj+meNOJSgPSxs0cFVvDT8MNweX/dQpEyHMI=;
        b=Sq00NGo2qFUJGDHZ9fJIw9ZURGySRpFHhRB6Os8P7Mn6+ZPXIAAAblTocEL5f2VwtY
         5y4VFlGlBr7pvQ813DjmQIQjS8RbPY3WL1qsGKe6BBsLuogTHn6X4TY7xdN62tw4y+YP
         mgJIP3JkGljlF/CaQGLA8RsspSdNgEi47i9agjgodiElySL+2nQAbocTzBczAJLt5Rdx
         QgJM+7xP4Miwcp/mxD/330PHHv4JdO2dJQRs2LP2e2RzqCaRnuACIuamG8M+i709K4ib
         kPeS8+ezENCaiJV8ebm3K/WVKae117aRPAlcG0at5nHSf+cKLbmEGSgHvqKLKq6bje1G
         3XPQ==
X-Forwarded-Encrypted: i=1; AFNElJ8fJDCURGQEKtzUDs86j44b+n0SXgQQOwjrailjIed7JdnxazkTYZUCkwRCXYIjQH8KnDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMbD6PdXvYrsN5v4Mi+/YHecmEjhCPm0vDSkgOlELQGSyZQ2Dn
	wuBCx41u1sFSZHlMqY/LRTFIjru9kcTlm0g0e9G0T6KPArmUV443o1Rqeo+JlGL2+rs=
X-Gm-Gg: Acq92OFCICjQSEKlE5K9Y7iS0KY5K28YDnnZZRQgC4DqZUm8o3vE84jgxWFowJzB/7e
	jcTzojP0C9HPoJzp536PQb7uhHFWM2q7WpbsBQPIYab7zz/gZhCPCzvt+3/6CiqHFLO00T2Vb/d
	RYiZ15Wz1VEKRqnwpLvnCpeIP2JONEmpAHlqWm3a/ZzcrMf6pewHmesZq8qEsBjsq1K/1l6X2qA
	yRuG94lXbNsVPw7eEZicRchKZrLRMdwLoCiX9s1TNaNd8Zvrc3bUT15IMckVy4vz/XvC5aurjMZ
	fKY+HqDlpy+7wtTzHUtStnt1uEhQBr8ls+NIu5Rcfo+9WQK6tZV8Que7LZIuixiqG4eESfvzgGa
	1lYBY2CUdg7pKiPtZ9GzCuM5awjIQXv0DSv6L2llvu+DOq6vtsDIGW2s/Rv562XlUPAK/ZY6eAg
	psyWif5bKDGTCITI76r4qoZnccAmWHxzxIArV461MR9/8=
X-Received: by 2002:a17:90b:4f85:b0:368:5367:d67e with SMTP id 98e67ed59e1d1-368536812b4mr4487165a91.10.1778506611016;
        Mon, 11 May 2026 06:36:51 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::30f3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367be3daafesm3034326a91.8.2026.05.11.06.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:36:50 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 11 May 2026 21:34:49 -0400
Subject: [PATCH v2 04/10] riscv: Add Zicclsm to cpufeature and hwprobe
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-rva23u64-hwprobe-v2-v2-4-21c5a544f1dc@riscstar.com>
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
 kvm-riscv@lists.infradead.org, Guodong Xu <guodong@riscstar.com>, 
 Jesse Taube <jesse@rivosinc.com>, Andy Chiu <andybnac@gmail.com>
X-Mailer: b4 0.15.1

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
Signed-off-by: Guodong Xu <guodong@riscstar.com>

---
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
index c3bb26d70c748..05f746061f679 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -289,6 +289,10 @@ The following keys are defined:
        defined in the RISC-V ISA manual starting from commit f88abf1 ("Integrating
        load/store pair for RV32 with the main manual") of the riscv-isa-manual.
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZICCLSM`: The Zicclsm extension is supported,
+       as defined in the RISC-V Profiles specification starting from commit
+       b1d80660 ("Updated to ratified state.")
+
 * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: Deprecated.  Returns similar values to
      :c:macro:`RISCV_HWPROBE_KEY_MISALIGNED_SCALAR_PERF`, but the key was
      mistakenly classified as a bitmask rather than a value.
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
index 5cf463570229d..4b4a8157277a3 100644
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

