Received: from mta1.migadu.com (out-203.mta1.migadu.com [95.215.58.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0527738F646
	for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786790094; cv=none; b=pV/uf+Lc+5pNr97yyyetLrxZ40JatLvrM0y0Q7aZVTCVUurXZ7dipm+OBymBYQRZBIbVPg3L41G+WivBtz4YgNbvxktQzxXKk9BjSxzfMw+VrHoJABuaRluttH03BmuI6eRYrX8QRJtzL6keVUTJuJ8LPrbG2CW6ZPXnzKsSHBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786790094; c=relaxed/simple;
	bh=pBGNsphtwvKUMT19aojQRvWbbD9gZSFI8gT/RJcmfQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uEV9bASOc1RRcNpq01thN5VmmZ/65PfngjcsGJ5BmYsGVma/xf686EyeaphZ1X6GX+s9Z7g5zFNK4IfHcdEOBnoZVmLgcPfh4u42tFZ+EKe6zVNVkgN76MXcV6IjMtAbDjdSJ4JdVhLRdR3LTnEETYh9cCEj1ibevW8J4t7kQlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wzKMFc+z; arc=none smtp.client-ip=95.215.58.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wzKMFc+z"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pBGNsphtwvKUMT19aojQRvWbbD9gZSFI8gT/RJcmfQM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786790091; v=1; x=1787394891;
 b=wzKMFc+zIYpGkZFMV7uprkN6uskeVSt0lbNpSpP8LC+HMdX7FXqu1wbcLnoqg+4wdzNHK6ma
 SCYG0hAQZXJmo7CfyFwLDrF0BxgjZpFLwhCGtF5X6QyDuG9aA1fbQe8VdrVvO0WQKLvIHckPjFG
 UzVHcw809gbzHrvtzCXkEya0=
X-Envelope-To: kvm@vger.kernel.org
Received: from localhost.localdomain (2408:823d:2011:2c0:e810:54f9:f0a3:99d)
	by smtp.migadu.com with ESMTPS id ee0bac32ec84a1c6;
	Sat, 15 Aug 2026 10:34:51 +0000
X-Migadu-Flow: FLOW_OUT
From: Jinyu Tang <jinyu.tang@linux.dev>
To: Anup Patel <anup@brainfault.org>,
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atish.patra@linux.dev>
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Nutty Liu <nutty.liu@hotmail.com>,
	Jinyu Tang <tjytimi@163.com>
Subject: [PATCH v4 RESEND 5/5] KVM: selftests: Enable pre_fault_memory_test for RISC-V
Date: Sat, 15 Aug 2026 06:34:41 -0400
Message-ID: <20260815103441.865076-1-jinyu.tang@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815102833.864330-1-jinyu.tang@linux.dev>
References: <20260815102833.864330-1-jinyu.tang@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V now supports KVM_PRE_FAULT_MEMORY, so include the generic
pre_fault_memory_test in the RISC-V KVM selftest build.

The test uses PAGE_SIZE from the architecture processor header. Define
the normal 4K RISC-V selftest page size so the generic test can build
for RISC-V.

Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Signed-off-by: Jinyu Tang <jinyu.tang@linux.dev>
---
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

