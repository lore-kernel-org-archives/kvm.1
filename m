Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B8134F247
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 23:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786489415; cv=none; b=W+WeGQT/V9pPKmYpW9jrK/x68UiZJ7pc3drz3Ybj5ahMGOM7oCUYj38AM2t3iyKnJFpXvlH8I+Or2CGbdOInz2o13oWE+A7DkCib4UmuUXR3a5GQvmCQLNu/fLf7+nEUh84IZ/MeX5csanHZDXqxlsibAahl/c8bcV2gNmli6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786489415; c=relaxed/simple;
	bh=+LKFcMApSCsnOhk6ssXJV4RsC8/mPP/K8TE2ue8ghXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cfd7wh6G5qzk6Mg0T0AFJNgLd75/2kP7Vmv3ryLHH1sGB4z4KAFrTsz4RZk9+HfstA+rS+VBBLYlXdXQAlDZ/LaSA58oMj9uiGRugdoPjhDlyMuiYR2Ld5WJBtVVO9PsqZ6O2i9rbekXBNK18skoUBps3FEoDlglDGAAvJ5ZAcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uhqDK676; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uhqDK676"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786489409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8UvpAj+F5vT5g4mqj62S8++wLHXXvTKlCPt/B/F/wRA=;
	b=uhqDK676wfkne/SJg/zrMRXEuKOCSYL5QtpyKgvrDo0pT2IcJKOScNB6Dmfx/xf3WPo8SH
	6f18T8GkU74//HaIFjg30nYvgx2HUPxgBLLYF9sln+zlLRBujxWy4Toy7aYHmFxjMqCaQC
	z0RcgOXAHRHzBL7Qxh87wLjLX496R2I=
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
Subject: [PATCH v2 0/3] KVM: riscv: Add KVM_PRE_FAULT_MEMORY support
Date: Wed, 12 Aug 2026 07:03:13 +0800
Message-ID: <20260811230316.218770-1-jinyu.tang@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series adds RISC-V support for the generic KVM_PRE_FAULT_MEMORY
vcpu ioctl and enables the existing generic KVM selftest for RISC-V.

KVM_PRE_FAULT_MEMORY lets userspace ask KVM to populate stage-2 mappings
for a GPA range before running a vCPU that is expected to access that
range.  x86 already supports the ioctl; RISC-V currently falls back to
normal first-touch G-stage faults.

Patch 1 implements the RISC-V arch hook using the existing G-stage map
path.  Patch 2 fixes the RISC-V selftest page-table walker for Sv57,
which can be selected as the default guest mode.  Patch 3 enables
pre_fault_memory_test for RISC-V.

Tested with pre_fault_memory_test on a RISC-V KVM host.

Changes in v2:
- Drop the per-test guest_modes_append_default() call from
  pre_fault_memory_test.c.  RISC-V already initializes supported and
  default guest modes from kvm_selftest_arch_init(), which is called by
  the common kvm_selftest_init() constructor, as suggested by Sean.

Jinyu Tang (3):
  KVM: riscv: Implement KVM_PRE_FAULT_MEMORY
  KVM: selftests: Add RISC-V Sv57 page table indexing
  KVM: selftests: Enable pre_fault_memory_test for RISC-V

 arch/riscv/kvm/Kconfig                        |  1 +
 arch/riscv/kvm/gstage.c                       |  3 ++
 arch/riscv/kvm/mmu.c                          | 33 +++++++++++++++++++
 arch/riscv/kvm/vm.c                           |  1 +
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../selftests/kvm/include/riscv/processor.h   |  6 ++++
 .../selftests/kvm/lib/riscv/processor.c       |  2 ++
 7 files changed, 47 insertions(+)

-- 
2.43.0
