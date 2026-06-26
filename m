Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A383E3C5845
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 05:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782452482; cv=none; b=Cda6Fl+ddEwGqPOpSKUy47iv8z1OdkMo6S1j1g01lazlMkJ71yGxMdcCee4A8NnnBhWlvnx0TjSFuzGbzYHYHymwuknLFw2UEsTieccm9UUBrRo80RdphOOh0xFZKpQmjL5fvEeQSn5wZAtM5lM+A+zUaBiUASR8Ec0iM23U0yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782452482; c=relaxed/simple;
	bh=yV7xN88iFNtOGP1KY4Kfe+Y6Hwo7RX37AqpJSf+0GQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G0Eju4G67+oiml4/6cDooapI0bakqhRbrq7+TLc6BtQOb6tTGO+c3AFySLT+aSvPodnbL3alS8eyKsYfdQdWwE1joFjINWOBa8SU+tuWljlu4nU12i1z1ENnh3fcsglq7FnvIQXafTc/G08MJf5Kr1khUp6MtFpPDsYjld62o9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4CDHeLL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4CDHeLL"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c7f123b1acso7796545ad.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782452480; x=1783057280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rCn8lKg7NgEt+UxeSdKd7uOIi/uWFv3vSqBPrzK4a4k=;
        b=H4CDHeLLOdiRWQ75d8Uf0gGsXr3vBG7rqrLCf4hPPtJaMR4Sjx2fCiOcvnlWLCxOLw
         5XVmH2PPLFLvd4M/Q7/GUweDwJ4JB7htVbFNQ1QcILHZ7jWJJ7HA9UHzrBZ33R4gUWJN
         OMjldrfzo017b6ezR1qNPJnw7XkBjP/qHIOvVlSHqTcIqDbPkbG1STlpfOA6KqHUswgs
         tyjZcI40SARhOEdOM/3JQuR1xwtp+/W5qExULTRQvCWP2ywHfmQkCuCie91fsTAgBxYP
         WOQ1WBSJlJB/RyGDbSOKBT5xx7SIiNn4EvhIf0HgCcvri8ublO6e3hxhfJZOStCHIMY9
         q6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782452480; x=1783057280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCn8lKg7NgEt+UxeSdKd7uOIi/uWFv3vSqBPrzK4a4k=;
        b=eeAyge3zlg+/qG9WCfHfcUm4p0pY8NtJiI49qHR17WmOQCAlsESluX89Rv1Q8kmIXp
         Qy3CVltiFzPegbqvRtoQmvAamKoQWV6HHPw9ik/ZRfd0rI9JSrYc/VcgbpMq9jfAr1dX
         s3tDtxHC+jyub2QfCLjleEPhclD5vW+LYobhjIR8eYn+DLH82gPtPqyelfrMl5hBK5YI
         egcBkknIlltvCNRLTGAkbHu4tAPk+teYfwY9BRk9LLdpZceVX8If0rgC7WVxgVm5WWKv
         MmGScTWD5Q10Uz0ye+EM5V+OwkK1JyHceFePkhrguzbUyaluE/wZQ9/O+WhYBDNekln5
         mcWQ==
X-Forwarded-Encrypted: i=1; AHgh+RrBYfFsbzGwISGkliuoD425dY7ri/mnPQgHjLyNoR1Lve3laa+cYDyF/qXAyMOUm9aQCf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8s6PcVDpKWiyIzuUi7zpUs8MkFn45MZGY8AiqwCAewVZyE0uk
	1TOYcRNzvGGsoPLUcLQuAx4JzpHMQmlcyvtF9zeekd0fhn0mi+M93fso
X-Gm-Gg: AfdE7cksHosq2uL9XlV8dRUELZ9tmvMqxxJ7hPHljeVES42uijL1jR3bl7K5l/3snms
	JYd3hl/UWOEGlgG/aOxyTQnCMPvYEIiVmwAp/fWHoBvLdV0LxhmfB6h22tJ6NseWjQTN+pMydGO
	NAVM4phTsbCwFUawlqeJ2Bny8RA1y9QLLmRftxzUb162Nk65ggnFCW8dSpdVHGegJw8O/PRQad4
	sChOxz74T15WAew7X2uXPkR/bBMZ4+yzdj5vS8PddyHk5ZFCItCFD3yWuwTmKew5BZEEvtT/DvO
	HWjOCtHistyTwIvINAoy4WKsrIfs91RCtm19JXXzz2SqB48ggtYgplOMfOXp89Yi6F2eW1Wb6V2
	6ZB0pamuj5jc/pC1AQseMBa5Z3JAM16RJkZpSFUHJn+vkOULacXtcCrD7QnB0Ov9zmJjdN2O4kI
	NvliDjoZxqNWdzPoIqe2h/jhM5W9WRv9AaYwzFgF8cYni7Da9rC/4NfIKngCXRt5A=
X-Received: by 2002:a17:902:f552:b0:2c7:ef3b:e18d with SMTP id d9443c01a7336-2c7fc7366fbmr52715135ad.28.1782452479842;
        Thu, 25 Jun 2026 22:41:19 -0700 (PDT)
Received: from pop-os.. (118-163-201-11.hinet-ip.hinet.net. [118.163.201.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f63b27f4sm32974865ad.53.2026.06.25.22.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:41:19 -0700 (PDT)
From: Shengwen Cheng <shengwen1997.tw@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>
Cc: Shengwen Cheng <shengwen1997.tw@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: riscv: PMU: Bound counter mask scan to BITS_PER_LONG
Date: Fri, 26 Jun 2026 13:40:51 +0800
Message-ID: <20260626054051.3360865-1-shengwen1997.tw@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PMU SBI handler passes the guest argument registers directly to the
PMU start/stop helpers:

kvm_riscv_vcpu_pmu_ctr_start(vcpu, cp->a0, cp->a1, cp->a2, ...)
kvm_riscv_vcpu_pmu_ctr_stop(vcpu, cp->a0, cp->a1, cp->a2, ...)

which map to:

unsigned long ctr_base
unsigned long ctr_mask
unsigned long flags

Thus cp->a1 is a single unsigned long ctr_mask, not a bitmap array sized
for RISCV_MAX_COUNTERS.

On RV32, RISCV_MAX_COUNTERS is 64 while BITS_PER_LONG is 32.  Using
for_each_set_bit() with RISCV_MAX_COUNTERS can therefore make
find_next_bit() access bits beyond the storage of ctr_mask on RV32.

Limit the scan to BITS_PER_LONG.  The requested counter range is already
validated by kvm_pmu_validate_counter_mask(), so this preserves RV64
behavior and avoids an out-of-bounds bitmap read on RV32.

Signed-off-by: Shengwen Cheng <shengwen1997.tw@gmail.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index bb46dcbfb..2025b6649 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -586,7 +586,7 @@ int kvm_riscv_vcpu_pmu_ctr_start(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 		}
 	}
 	/* Start the counters that have been configured and requested by the guest */
-	for_each_set_bit(i, &ctr_mask, RISCV_MAX_COUNTERS) {
+	for_each_set_bit(i, &ctr_mask, BITS_PER_LONG) {
 		pmc_index = array_index_nospec(i + ctr_base,
 					       RISCV_KVM_MAX_COUNTERS);
 		if (!test_bit(pmc_index, kvpmu->pmc_in_use))
@@ -658,7 +658,7 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 	}
 
 	/* Stop the counters that have been configured and requested by the guest */
-	for_each_set_bit(i, &ctr_mask, RISCV_MAX_COUNTERS) {
+	for_each_set_bit(i, &ctr_mask, BITS_PER_LONG) {
 		pmc_index = array_index_nospec(i + ctr_base,
 					       RISCV_KVM_MAX_COUNTERS);
 		if (!test_bit(pmc_index, kvpmu->pmc_in_use))
-- 
2.43.0

