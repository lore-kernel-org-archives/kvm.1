Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECED42F702
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 23:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786489434; cv=none; b=NO1rJGWO0oHeDswLN2q7C0mJoBjCGHEZ+VkIlgIKhOonh3HEFGgxN/M04yfe253u0CscnMvoAIL4ejugCxQmBb/i/cW+jA72dCehWKLffxx0Fnvm2d8Lsf2bZTL3rlScEjvvDatoYwgi4tkjLPW7FXWxF++MNDFpKaulj71zem8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786489434; c=relaxed/simple;
	bh=XyIn08WiCac5PIjwY3CazzPrW6vIHJnSZ9DAu0w7m+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olufUEBCtBTFalXY1JqF8cfzjnllA4YAqe/gQrS7Xf1CritvmFgMkoc9uRDevhBA/XGewv/qEpFP65VdSaWgDPz8hP5ZKg6fistjMrJfVgQq+VpFxpQjddh6jcNeq95yFJw8eiIYZeQqWoOYg4Q1hWhC19eUsm/+WvCCQ/eMAHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vDgshGKE; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vDgshGKE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786489431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0gsK+RPMVbPdBplt1NaL9W65DIA5uhK1UuwwNS0HXY=;
	b=vDgshGKEX7vyYjP47jciW6pM4KsjZCFm51w72WbPmdjHLIiUKn89xuTA16ycJkruA63PVN
	4gnHxVCXbPHRVql09oH4kJJHXfWEvrejfOF2Yd/pC+Ki6SDPq1soSy/g5Hlj5pO8mVUQ0l
	b0Wluk3xk6jhpIuxsmKwF3wgTHDQTTM=
From: Jinyu Tang <jinyu.tang@linux.dev>
To: Anup Patel <anup@brainfault.org>,
	Anup Patel <apatel@ventanamicro.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Nutty Liu <nutty.liu@hotmail.com>,
	Jinyu Tang <tjytimi@163.com>,
	Jinyu Tang <jinyu.tang@linux.dev>
Subject: [PATCH v2 3/3] KVM: selftests: Enable pre_fault_memory_test for RISC-V
Date: Wed, 12 Aug 2026 07:03:16 +0800
Message-ID: <20260811230316.218770-4-jinyu.tang@linux.dev>
In-Reply-To: <20260811230316.218770-1-jinyu.tang@linux.dev>
References: <20260811230316.218770-1-jinyu.tang@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

RISC-V now supports KVM_PRE_FAULT_MEMORY, so include the generic
pre_fault_memory_test in the RISC-V KVM selftest build.

The test uses PAGE_SIZE from the architecture processor header. Define
the normal 4K RISC-V selftest page size so the generic test can build
for RISC-V.

Signed-off-by: Jinyu Tang <jinyu.tang@linux.dev>
---
v1 -> v2:
- Drop the per-test guest_modes_append_default() call from
  pre_fault_memory_test.c.  RISC-V already initializes supported and
  default guest modes from kvm_selftest_arch_init(), which is called by
  the common kvm_selftest_init() constructor, as suggested by Sean.

 tools/testing/selftests/kvm/Makefile.kvm              | 1 +
 tools/testing/selftests/kvm/include/riscv/processor.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 6fc34e9bf8e1..ac64ac92fd4b 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -225,6 +225,7 @@ TEST_GEN_PROGS_riscv += coalesced_io_test
 TEST_GEN_PROGS_riscv += dirty_log_perf_test
 TEST_GEN_PROGS_riscv += get-reg-list
 TEST_GEN_PROGS_riscv += mmu_stress_test
+TEST_GEN_PROGS_riscv += pre_fault_memory_test
 TEST_GEN_PROGS_riscv += rseq_test
 TEST_GEN_PROGS_riscv += steal_time
 
diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index abde3c71c891..70487c8ed155 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -12,6 +12,9 @@
 #include <asm/vdso/processor.h>
 #include "kvm_util.h"
 
+#define PAGE_SHIFT		12
+#define PAGE_SIZE		BIT_ULL(PAGE_SHIFT)
+
 #define INSN_OPCODE_MASK	0x007c
 #define INSN_OPCODE_SHIFT	2
 #define INSN_OPCODE_SYSTEM	28
-- 
2.43.0
