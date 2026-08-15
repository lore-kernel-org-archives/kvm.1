Received: from mta1.migadu.com (out-82.mta1.migadu.com [95.215.58.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36741395AE5
	for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786787780; cv=none; b=MU70RwGj4BGTtTg1aeWmYTXzaDLCjMP2nq6B0nnJK9b4IAmA1zWvmIUeNC3o5vYk515XXDrS6ngtJ7ZxZvpdC+3f3coz1CunOw1GxDTWtPgmgtz+2FAvpoOExQkTRiQULTmqJgQyeKrn6EYSUTh+Ds/Uz9l385Te6KJlSPPfmRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786787780; c=relaxed/simple;
	bh=7pNmrvIx4K6yCZeAF8BM/+9i5LH5byhcra2hCpPYFLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HDqWiJRKoTquWxWR3m8+cuBBZO4jvWQeRoO8j0ZZYlelSX6WzZ/VLVdi2LSLrow3JK7HiMONldx7T8QW6K96RPOsuKFXPVihnoX4a7v6+CSSx9OhtAWmHIl31R6imHpHex9HpytvxGOmJZFE/1Z3YfgGMsqtEizSThI7NBGZWa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kCJ/0cKD; arc=none smtp.client-ip=95.215.58.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kCJ/0cKD"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7pNmrvIx4K6yCZeAF8BM/+9i5LH5byhcra2hCpPYFLk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786787776; v=1; x=1787392576;
 b=kCJ/0cKDCnBBYmOC4pPwrRJxlcHF2XuCwQTuvYZJRg7xWgKDLT5D/l5k/C/LRlLL595D4+P7
 F9725u9+kcFOipgJHeCtsnue+B1XdavkMctrkOTuPFkns0k5zVo2ce/nvRectnQqAigtRpSeCEo
 M+9yJ3z64W3y8AYhQJY134ew=
X-Envelope-To: kvm@vger.kernel.org
Received: from localhost.localdomain (2408:823d:2011:2c0:e810:54f9:f0a3:99d)
	by smtp.migadu.com with ESMTPS id 7ecf30df64708a6c;
	Sat, 15 Aug 2026 09:56:15 +0000
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
	Yifei Jiang <jiangyifei@huawei.com>,
	Jinyu Tang <tjytimi@163.com>,
	Jinyu Tang <jinyu.tang@linux.dev>
Subject: [PATCH v4 0/5] KVM: riscv: Add KVM_PRE_FAULT_MEMORY support
Date: Sat, 15 Aug 2026 05:55:43 -0400
Message-ID: <20260815095548.860018-1-jinyu.tang@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add RISC-V support for the generic KVM_PRE_FAULT_MEMORY ioctl.

Patch 1 and patch 2 fix existing G-stage huge-page corner cases. They
are included first because the prefault hook relies on the map path
reporting the mapping that actually covers the requested GPA.

Patch 3 adds the RISC-V arch hook for KVM_PRE_FAULT_MEMORY. Patch 4 adds
Sv57 indexing support to the RISC-V KVM selftest helpers, and patch 5
enables the generic pre_fault_memory_test for RISC-V.

Patch 1 folds the previously posted standalone G-stage table overwrite
fix into this series:

  https://lore.kernel.org/kvm-riscv/20260814105752.565325-1-jinyu.tang@linux.dev/T/#u

Changes in v4:
- Fold the standalone G-stage non-leaf overwrite fix into this series.
- Avoid THP adjustment when the original faulting GPA already has an
  existing 4K G-stage leaf.
- Return an error for HWPOISON instead of reporting success without a
  visible G-stage mapping. (Sashiko)

Changes in v3:
- Retry internally when the map path returns success without a visible
  G-stage mapping, instead of exposing -EAGAIN. (Sashiko)

Changes in v2:
- Drop the per-test guest_modes_append_default() call from
  pre_fault_memory_test.c. (Sean)

Jinyu Tang (5):
  KVM: riscv: Avoid overwriting G-stage tables with huge leaves
  KVM: riscv: Avoid THP adjustment for existing 4K G-stage leaves
  KVM: riscv: Implement KVM_PRE_FAULT_MEMORY
  KVM: selftests: Add RISC-V Sv57 page table indexing
  KVM: selftests: Enable pre_fault_memory_test for RISC-V

 arch/riscv/kvm/Kconfig                        |  1 +
 arch/riscv/kvm/gstage.c                       |  9 ++
 arch/riscv/kvm/mmu.c                          | 83 ++++++++++++++++++-
 arch/riscv/kvm/vm.c                           |  1 +
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../selftests/kvm/include/riscv/processor.h   |  6 ++
 .../selftests/kvm/lib/riscv/processor.c       |  2 +
 7 files changed, 100 insertions(+), 3 deletions(-)

-- 
2.43.0
