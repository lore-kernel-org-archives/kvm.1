Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BEC23BD17
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 06:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786428168; cv=none; b=tNxdL5eCJQZgIiDA5VeN8TRYq+bt1ySUK9kBcfZbwvvRolxMEKY//YuxLp5J8oCA8DtHGSq4ZLKnWvvr/+0U5mTp+nLgwQvceo+gYVTNpqlieOIX9zKnl1aPreElZciiwORH2xGeFkSffGvHEe1T9sHV3rl0R/cx84NVA74ZmQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786428168; c=relaxed/simple;
	bh=XJLIXb/52ELsJA0VK2h9PSZ4579QC1qL/TSdr9CqOxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YI3d6Yj0vWJ31WQ0OHfjzDobpKZgAQGKbBz4baU9140QfLFgcrEflREwDowGc4w04vbOAF/WwtccTyLewYw6L+bD/TUZZC/Au0LpSyt8N8a+WQMBndkaQ3wh0lfg9ydWC/2o6NoRfeLFbqTMg7b2Ushe9J3pGqscIOjw44lD0mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QhqBe4xV; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QhqBe4xV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786428154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WYtY1rGPyp4UaCJfpmk8LbHxzINII5BxDNNg7wmiL1Y=;
	b=QhqBe4xVk3oISf6Sjp5+lCqhNofmL6YOa9bSVfi9LK3ixb3Hd4jhoAnAcqz6oz53U6TaWA
	I3wn59xB3anIbk2XphgJ4UUoFjkh17r1x+3FHBI3hHH7D+HX54IsBc7I5TcgWo7bw5OXS6
	RejMI+CaxQ7ZtYAo++Y61x5O1M/xbz0=
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
	Shuah Khan <shuah@kernel.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Nutty Liu <nutty.liu@hotmail.com>,
	Jinyu Tang <tjytimi@163.com>,
	Jinyu Tang <jinyu.tang@linux.dev>
Subject: [PATCH 0/3] KVM: riscv: Add KVM_PRE_FAULT_MEMORY support
Date: Tue, 11 Aug 2026 14:01:31 +0800
Message-ID: <20260811060134.106973-1-jinyu.tang@linux.dev>
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
 .../selftests/kvm/pre_fault_memory_test.c     |  3 ++
 8 files changed, 50 insertions(+)

-- 
2.43.0
