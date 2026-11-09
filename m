Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.162
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794213130;
	b=4w21W9hFtWx1NKshEIihRa8xh13SnMTBFm80yDrVZtA0dp0+2a7fQK4nEEBDtIOwmdRN
	 S26uOzsC97ECGvVBFv1HiCqQW0QoxD+Gj8AxedyOqYM/3gtRn4APsdGUwg6lgc4gidBlS
	 9IyzV8xk7JjA4AJu6LzRSi9KOeNIRODxwCecHWF8SWxVnf9Q5UapwyKja90nUj5G6P9/L
	 1gy7/t59QS0JCYIG9mvHnExy6wyQo9aSEXBSZ/kM+udvUqvsVhHh8AOJJDHNBjGXBhkP7
	 fXIYdZ7CmCtSNEl64Oha9bovnpGiaLUoS226jmQpsA0hG8fVuaPdSNy0DbsrdC8KwOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213130;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=XjEaU5iZiIoWZWXI3lEp1cSCckG214xKlxFgGMZy1WQ=;
	b=VPSE+8Kk2+6bsrtAhG672m5oz8bg2V/tmqTcJnpVT3ph8pTDr+uTitPeYw7PItmM9a4A
	 T2QUK+NB+S7jk/j48QKKvFUikOCN9YIqMI/WYtThJaXbGKv0DBbDyjq5HcGPIb+WEB5XT
	 vRMNGfoXytHidcPvCU268p1Ju8BDcXiwMH+CrJduD/+bXDYU49nv76MWmxQ1SLEwfSpKs
	 u/VK60edaKIyJW4miERKG4CzXh6FxFp/uwGoc85eQAiwdAgaGWU7AeuHNCS0r+sT1CZVe
	 3GbpWYv4lCClcG+nU6sqvBk7MmKPvnfmbqJa1ELncMffOoI+JybZ5oKNAfgatIH674A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xWIBD2E5;
	arc=none smtp.remote-ip=91.218.175.162
Received: from mta0.migadu.com (out-162.mta0.migadu.com [91.218.175.162])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30655606A31C
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 08:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30655606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xWIBD2E5
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jOYOI4w8TbsJs0zAnXNNJjeqeD+Qjc1ew2XDbtbhPHw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794213126; v=1; x=1794817926;
 b=xWIBD2E5ZBBxrWG2maINOHIlhOiCExOHoCbbM2GDJVzs2YXRXLJJTQ3wkNuKzkwR0PpP6fn+
 ko4oWadVomYI4XLsmODJSbw9bDMYM7yOx+l8W38cGxUIwJEDvxSYZvn6x1joWARSDO02NcAaxIF
 e7Kxk+B7tIHIA2BnpfKjon1o=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b213c8f6249ab49b;
	Mon, 09 Nov 2026 08:32:05 +0000
X-Mizu-Trace-ID: b213c8f6249ab49b
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Fuad Tabba <tabba@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/16] KVM: arm64: Support debug, SVE, MOPS, PIE/POE, FPMR and more in protected VMs
Date: Mon,  9 Nov 2026 08:31:49 +0000
Message-ID: <20261109083205.806619-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

With most of the groundwork now merged, bringing protected VMs up to
the features we support for them in Android turns out not to be a big
series. So this folds self-hosted debug [1] and SVE [2], which I posted
separately last week, into one series with the rest. Both are small,
and keeping them apart would only leave a few conflicts where they add
neighbouring lines to the pVM ID-register code. The debug and SVE
patches are unchanged from those postings.

  01:     Self-hosted debug.
  02-05:  SVE, with EL2 owning a protected vCPU's SVE state.
  06-07:  Compute a protected vCPU's fine-grained traps at EL2.
  08-16:  Advertise TCR2, SCTLR2, S1PIE, S1POE, MOPS, FPMR and the
          features EL2 already handles for non-protected guests.

Tested on QEMU, in hVHE and nVHE, and on FVP for S1POE and the fields
QEMU doesn't model (CLRBHB, RPRFM, ECBHB, LSFE, LSUI, HAFT, ETS3 and
F16MM). v2 of the pKVM selftests series [3] will cover debug, SVE,
MOPS, PIE, POE and FPMR.

Based on Linux 7.4-rc1 (6628e7d4c6b25); it also applies to 7.4-rc2
(7475ea8b58616).

Cheers,
/fuad

[1] https://lore.kernel.org/all/20261102093950.2922035-1-fuad.tabba@linux.dev/
[2] https://lore.kernel.org/all/20261105130456.1617185-1-fuad.tabba@linux.dev/
[3] https://lore.kernel.org/all/20261104084842.132944-1-fuad.tabba@linux.dev/

Fuad Tabba (16):
  KVM: arm64: Add support for self-hosted debug in protected guests
  KVM: arm64: Remove redundant kern_hyp_va() calls from the pKVM FP sync
  KVM: arm64: Allocate a protected vCPU's SVE state at EL2
  KVM: arm64: Advertise ID_AA64ZFR0_EL1 to protected VMs
  KVM: arm64: Allow protected VMs to use SVE
  KVM: arm64: Move the VM's FGU initialisation into config.c
  KVM: arm64: Compute a protected vCPU's fine-grained traps at EL2
  KVM: arm64: Advertise TCR2, SCTLR2, S1PIE and S1POE to protected VMs
  KVM: arm64: Advertise MOPS to protected VMs
  KVM: arm64: Advertise FPMR to protected VMs
  KVM: arm64: Advertise HBC, CLRBHB, RPRFM, CSSC and LUT to protected
    VMs
  KVM: arm64: Advertise FAMINMAX, LSFE, LSUI and FPRCVT to protected VMs
  KVM: arm64: Advertise AFP and RPRES to protected VMs
  KVM: arm64: Advertise ECBHB, TIDCP1, TTST and LVA to protected VMs
  KVM: arm64: Advertise FP8 and F16MM to protected VMs
  KVM: arm64: Advertise ECV, HAFT and ETS3 to protected VMs

 Documentation/virt/kvm/arm/pkvm.rst    |  13 +-
 arch/arm64/include/asm/kvm_host.h      |   2 +-
 arch/arm64/include/asm/kvm_hyp.h       |   6 +
 arch/arm64/include/asm/kvm_pkvm.h      |   1 +
 arch/arm64/kvm/arm.c                   |   5 +
 arch/arm64/kvm/config.c                |  32 ++-
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h |   1 +
 arch/arm64/kvm/hyp/nvhe/Makefile       |   1 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c     |   6 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c         |  51 ++--
 arch/arm64/kvm/hyp/nvhe/switch.c       |   1 +
 arch/arm64/kvm/hyp/nvhe/sys_regs.c     | 349 +++++++++++++++++++++++--
 arch/arm64/kvm/reset.c                 |   2 +
 arch/arm64/kvm/sys_regs.c              |  17 +-
 14 files changed, 413 insertions(+), 74 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.47.3

