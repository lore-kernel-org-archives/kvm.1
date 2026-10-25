Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792914708;
	b=r99/6MM3o7b03teeD7Hb0cEBv8/6pbOcIgFfOHKCAFbzytY39N8pwkxntu8+nqZQyC5j
	 3NlMYPMdbgRt/Uy3KAsu0X3L8mO32s6xjdxx3mTFj3W3QSP4IWaX9Q5eqHJ/R3Gf0aaHV
	 AYxTkSeYkKjP+aVcvN9Mk8SsR4Z4vqCfIlSuSVqGIeU8UwnyLlrypEryQlTpab+m7uXov
	 Wxh75qvlh/TfQxuAuDnGZmHTM1rTRlEp6zjZ+a1scLA2QhV+ZYI4WFiv/ychyy02pTYf6
	 Bb5oRnzQOszUEa8Z1B4+X62R9ZLzR1ZZeHptTa6lFHhWu+JmMN0cK9J5UFCRqBlCtdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792914708;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=z5DPNgnct5lFOm6/GJKN1n5GxtnVi3Rdus7r1K5LOpU=;
	b=FKiJzO2iFbws7xgRRuWsU0kh2f7fS8eJVYzbRGg7BVSb7fcw6z/1CiDlBz9DazTGwCG0
	 2abn6ol4adPiFxzgw9B+24k8/ZqiKXRh7i3lQ5keiWgt4iV4XFTifZJ4sdKyzeoPzPUNv
	 3h45kuShWzRiSpSEV252T9Ff4hNGvUDEsm68HLuWJaArzKhcKxS6wmoSlNpZF0Zma5WoO
	 46cTjGs6RVochh4CzEdpya4IPuwNXOTQ9wC/gau7KbldSrlkMM2g3v1wYbNpt1gP91kwJ
	 jtG202jZpZevEGEGH+pqSSbxJoGMREjiayP6ivR79VYNQxJzXqVGmIy16p8HYe8/qGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TJzimjCe;
	arc=none smtp.remote-ip=91.218.175.229
Received: from mta0.migadu.com (out-229.mta0.migadu.com [91.218.175.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF7C606A322
	for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 07:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BF7C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=TJzimjCe
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+igOoHTp4OV4TccBEgdDYfC02hrHe22jCQcAB41Vkjg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792914703; v=1; x=1793519503;
 b=TJzimjCeGdQEUvey4qs+W7p0N+ceRemf1VF9TTaXxN3mbmHBOhvVeZcQWRc+RwMhSeZ2fnGH
 XM6w9YFsgPaiBi53N/cVIfNcYNo7bSyCPqfMKt2Lt8GZNACVKbCte18mJ8EG5HXX5Txl6nl3VPs
 vSWv3uQkTnD+rponDLQSjW0k=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 21872143caefef64;
	Sun, 25 Oct 2026 07:51:43 +0000
X-Mizu-Trace-ID: 21872143caefef64
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Fuad Tabba <tabba@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] KVM: arm64: Support FEAT_LS64_ACCDATA in guests
Date: Sun, 25 Oct 2026 07:51:33 +0000
Message-ID: <20261025075138.2919734-1-fuad.tabba@linux.dev>
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

Changes since v1 [1]:
  - Support FEAT_LS64_ACCDATA in guests instead of capping
    ID_AA64ISAR1_EL1.LS64 at LS64_V. A saved VM keeps its level, so
    restore no longer has to accept older kernels' levels, and v1's
    set_id_regs patch goes. (Marc)
  - Add an arm64.nols64 option. (Marc)
  - Retitled the series to match.

On a host with FEAT_LS64_ACCDATA, KVM advertises ST64BV0 and ACCDATA_EL1
to guests but doesn't support either. A guest's ST64BV0 hits the WARN in
handle_other(), and every guest on a CPU shares ACCDATA_EL1.

Patches 2 and 3 are Marc's from 2024 [2], rebased. I changed patch 3
to switch ACCDATA_EL1 for guests only, and only when the new
ARM64_HAS_LS64_ACCDATA capability is set, for the reasons in its note.
Patch 4 sets HCRX_EL2.EnAS0. Patch 1 adds arm64.nols64 to disable LS64
on a host whose firmware leaves SCR_EL3.ADEn clear. It comes
first so that the option exists in every commit that switches
ACCDATA_EL1. All five carry Cc: stable. The get-reg-list patch carries
it because the test fails on a host with the feature once patch 2 is
in.

Tested on the FVP with arm_v8_7_accelerator_support_level at 3
(LS64_ACCDATA) in VHE, nVHE and protected mode, and at 4 (LS64WB) in
VHE, with cpuidle.off=1 so that idle doesn't reset ACCDATA_EL1 between
VMs. In my reproducer, one VM writes ACCDATA_EL1 and the next VM on the
same CPU reads it. Unpatched, it reads the first VM's value and ST64BV0
hits the WARN. Patched, the second VM reads 0 and ST64BV0 doesn't trap.

Based on Linux 7.3-rc3 (fd73f4a665989).

Cheers,
/fuad

[1] https://lore.kernel.org/all/20261023070110.1833446-1-fuad.tabba@linux.dev/
[2] https://lore.kernel.org/all/20240815125959.2097734-1-maz@kernel.org/

Fuad Tabba (3):
  arm64: Add override for ID_AA64ISAR1_EL1.LS64
  KVM: arm64: Enable ST64BV0 for guests with FEAT_LS64_ACCDATA
  KVM: arm64: selftests: Add ACCDATA_EL1 to get-reg-list

Marc Zyngier (2):
  KVM: arm64: Add ACCDATA_EL1 to the sysreg array
  KVM: arm64: Add context-switch of ACCDATA_EL1

 .../admin-guide/kernel-parameters.txt         |  3 +++
 arch/arm64/include/asm/kvm_emulate.h          |  3 +++
 arch/arm64/include/asm/kvm_host.h             |  3 +++
 arch/arm64/kernel/cpufeature.c                |  7 ++++++
 arch/arm64/kernel/pi/idreg-override.c         |  2 ++
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h    | 23 +++++++++++++++++++
 arch/arm64/kvm/sys_regs.c                     | 12 +++++++++-
 arch/arm64/tools/cpucaps                      |  1 +
 .../selftests/kvm/arm64/get-reg-list.c        |  2 ++
 9 files changed, 55 insertions(+), 1 deletion(-)


base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.47.3

