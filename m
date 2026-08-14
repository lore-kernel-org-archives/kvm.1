Received: from mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A6D3D75C6
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786707940; cv=none; b=QEQiK2I2uYstCF4o2ql1Fw5QR+Sr1SNkvqCBpv+dqENT7aY0pBK9Ke/6ouqXrFBp6ZZNxsIWC6+mUZBAXXTiNf7RHJiwoFQdFd0HjNwHo7NwH5Dlxtk6ahLzPgl3YBk+VgjausfhW5KWE9wAA9SKNqHvfJ250CLmDbWFnr5VDn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786707940; c=relaxed/simple;
	bh=GOT8taQt6/EQFiPSFOU6QPaJFvivwjZtCf7FY3zWtvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nrqOd3tFjU2F+sZRNQHVACvIAMrkBZxAy/FMxDAQ/TQ6L03aDewUZZn0Np6Uz1GdySKYlubwduqa62+fg8/oQ+m5p/2UxF4wq+V0rkkK0LrVGoMAyhkwW3Tsh3eMuPommmr0qymAnG8S1dWXioDr2NPPnH44XoXHrlQMVqQa5Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nPm8xAF+; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nPm8xAF+"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GOT8taQt6/EQFiPSFOU6QPaJFvivwjZtCf7FY3zWtvw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786707936; v=1; x=1787312736;
 b=nPm8xAF+WTQpYyA0k/lZYgqJfHnipWNibvmJrmicCrJtEf+9TD5D8V1mwEpFsLK4fCO/Ab91
 +W7lIrAd/LJ7SIz8fZF03PB2Aj5o1LE4nD6zWrR4uJDL67D790QrBtgbDp7ag66Oes1jPJtQppx
 xDisOHlIAwZ+XOSUagnh+m08=
X-Envelope-To: kvm@vger.kernel.org
Received: from localhost.localdomain (2408:823d:2011:2c0:e810:54f9:f0a3:99d)
	by smtp.migadu.com with ESMTPS id 7e7cb55356a33f08;
	Fri, 14 Aug 2026 11:45:26 +0000
X-Migadu-Flow: FLOW_OUT
From: Jinyu Tang <jinyu.tang@linux.dev>
To: Anup Patel <anup@brainfault.org>,
	Anup Patel <apatel@ventanamicro.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
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
Subject: [PATCH v3 0/3] KVM: riscv: Add KVM_PRE_FAULT_MEMORY support
Date: Fri, 14 Aug 2026 07:45:04 -0400
Message-ID: <20260814114507.583424-1-jinyu.tang@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Changes in v3:
- Retry internally when the map path returns success without a visible
  G-stage mapping, instead of exposing -EAGAIN.  (Sashiko)

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
 arch/riscv/kvm/mmu.c                          | 42 +++++++++++++++++++
 arch/riscv/kvm/vm.c                           |  1 +
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../selftests/kvm/include/riscv/processor.h   |  6 +++
 .../selftests/kvm/lib/riscv/processor.c       |  2 +
 7 files changed, 56 insertions(+)

-- 
2.43.0
