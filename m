Received: from mta0.migadu.com (out-228.mta0.migadu.com [91.218.175.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA2828686
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609116; cv=none; b=A4haO76y6aCTo/tZqcLEi7xWIhW+XFDaS7P1wIiLN8CLTOB5WYYocpjXNoSDOOCI88J4VA7yrtc+S2YILCRXHBprBikT10Czi9+spVG3YbS9hpf2Naw1jaxONYgrWKMG472WY11thGa0LRa9NKzqMCivdZFxp+dGdZWJFdeDojs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609116; c=relaxed/simple;
	bh=s41ieSguAC04yFXFLtnQHHE7zfUrtIP1s8AWwaR+J+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hYWYmu2VHODrZq2St0D4YNXl/4/7j2MTVAU3/zT5eOrDRCc1tpEJfc7AamaoxD/3ufqFpdWlo/lM1mMK0MGqAX2OIzIphQ4k8+U1ltku3jth7QbA3rDeVIeTb4xlPs0q340J1IxCgMVm3GcxOTf7k/bL1s7XmB+NwUyOL8sPNQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mPkGYQvm; arc=none smtp.client-ip=91.218.175.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mPkGYQvm"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=s41ieSguAC04yFXFLtnQHHE7zfUrtIP1s8AWwaR+J+o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790609112; v=1; x=1791213912;
 b=mPkGYQvmppfa+fOw3hQpUUbhAMtQHgRfMHtdDUXqU+WDP0rmwjdcbdOK+zR5FIijNkVO9Avq
 ETe5r6zDijFAnhBMWtLiGyI7T2Jnd2A7z91Gek0+tJqBp2WiXYY3Qg1rJuav/uSg0d3j2Qdwj8f
 fOymlSnlSXiqYPfKHUhfxSR4=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8f5f8dc529bfd712;
	Mon, 28 Sep 2026 15:25:09 +0000
X-Mizu-Trace-ID: 8f5f8dc529bfd712
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
	Jing Zhang <jingzhangos@google.com>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <tabba@google.com>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 00/10] KVM: arm64: Nested stage-2 walk error handling and other small fixes
Date: Mon, 28 Sep 2026 16:24:57 +0100
Message-Id: <20260928152507.2116110-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

Small KVM/arm64 fixes that came out of reviewing Karl's SMCCC filter
series [1], and it just kept growing.

The first two are WARNs that userspace or a guest can trigger: the
SMCCC filter one on an allocation failure userspace can force with a
memory cgroup limit, which Sashiko raised [2], the nested one when an
L1 guest programs an invalid VTCR_EL2. Patches 3 and 4 are the same
walk's return values. With an invalid VTCR_EL2 or a stage-2 descriptor
KVM can't read, AT S12E{0,1}{R,W} was retried forever instead of
retiring with the fault in PAR_EL1. Reporting the unreadable descriptor
as a Data Abort instead, for the stage-1 walks too, is a separate
change I'll send later. Patch 5 extends the AT selftest to cover the
SL0 case.

The three documentation patches fix identifiers in api.rst that don't
exist anywhere in the tree, and the last two fix selftest leaks.

Based on Linux 7.3-rc3 (fd73f4a665989; also applies to torvalds/master
fd179f8a05be3).

Cheers,
/fuad

[1] https://lore.kernel.org/all/20260829054856.70549-1-kmehltretter@gmail.com/
[2] https://lore.kernel.org/all/20260829055809.29AD31F000E9@smtp.kernel.org/

Fuad Tabba (10):
  KVM: arm64: Don't WARN on SMCCC filter reserved range allocation
    failure
  KVM: arm64: nv: Don't WARN on an invalid VTCR_EL2
  KVM: arm64: nv: Don't loop on AT S12E{0,1}{R,W} with an invalid
    VTCR_EL2
  KVM: arm64: nv: Return a failed stage-2 descriptor read as a fault
  KVM: arm64: selftests: Test AT S12E1R with an invalid VTCR_EL2.SL0
  Documentation: KVM: Fix the name of the SMCCC filter attribute
  Documentation: KVM: Fix the name of KVM_ARM_SET_COUNTER_OFFSET
  Documentation: KVM: Fix the name of KVM_ARM_FEATURE_ID_RANGE_IDX
  KVM: arm64: selftests: Free the VMs in smccc_filter and psci_test
  KVM: arm64: selftests: Free the thread arrays in vgic_lpi_stress

 Documentation/virt/kvm/api.rst                |  6 ++--
 arch/arm64/kvm/hypercalls.c                   |  2 +-
 arch/arm64/kvm/nested.c                       | 11 +++-----
 tools/testing/selftests/kvm/arm64/at.c        | 28 +++++++++++++++++++
 tools/testing/selftests/kvm/arm64/psci_test.c |  5 +++-
 .../selftests/kvm/arm64/smccc_filter.c        |  2 ++
 .../selftests/kvm/arm64/vgic_lpi_stress.c     |  3 ++
 7 files changed, 45 insertions(+), 12 deletions(-)


base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.39.5

