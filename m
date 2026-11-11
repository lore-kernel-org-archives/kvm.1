Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409092;
	b=m62cEZ8xc1cBjBI6jVyTVYUUqf79duhyxeMGsyYqShbpO+/3Wda5nR8t0Hm/v3OZeRmn
	 GkCmVVM4lKTm6V46/zQjBalHb139YvolhGY6mwLWbh359rOMekDSD5+26QgIVP79SEdvW
	 /sFM6DSAubs+40gB6DTXkd1K9DSc7qazizhM/AnTezjFihvCfSjJGB7UkxjeSC1j0OyAE
	 S9kK/jhcQYktbZOnPAk9eOHRM5s4adpzw7YAZeO7gB66gqrIBv1Ywco1REJtRp8qAOTre
	 9HDvc6sTd7crqHWoFbrOsGor6OJIChZee/9Sm+v+dIN7bqHsMc+SEonsGay4um+U8nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409092;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=4oexicqlKkgDocERMEx4v8VNyMOo/fmHzBt5H4YEt40=;
	b=FKRsORFHt8VW5jmw2/nNE4tNvmUHWeRFJsji5yCbgWWGD1dfhzQxI2eiWCvu2sl8Btpr
	 p230SFix6crK3UMP5Ui9lMtdy4AF/993r962C4d1WEVpjBVRvEyFKOS21p/q5532TaZta
	 v67k5NHruhF+7C0nkLtJ8ja8jrokd5i2azZbqxVO1l65+WBnCRYFlvcAuJ9UfXGE4//8d
	 6dwOvnY0jegSLjt/TJ4ZJdlQkjooL2xqVw3vSutIGErIgRKrScCEMAn6DEAByLOMhLbnS
	 XdPAYoM1W3l/KG1iIZ34KAK1BI/xqgHhmQSHj/OQ68iqUCY+Y3sg+SgurI1ufJRn5Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=p+rBH1Wp;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AADA606A89F;
	Wed, 11 Nov 2026 14:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AADA606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=p+rBH1Wp
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 307691576;
	Wed, 11 Nov 2026 06:58:07 -0800 (PST)
Received: from e122027.arm.com (unknown [10.57.58.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7E773F632;
	Wed, 11 Nov 2026 06:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794409090; bh=T0N8qo5+1VMrs2ox5XW1dEpZFcq610OBfeD56CkYpKA=;
	h=From:To:Cc:Subject:Date:From;
	b=p+rBH1WpylC0VUzXRB1q0lrvXOFutUTQdZgZuphMmKau1O6BIyepVDzTSqJDP9dve
	 y6a0NoaxnVXtOq/Wyd4ray1op4b4Z+I5fhLVAhTndDu7/LLQD0yppjfXETP7NXRsqJ
	 OQb/um1WL7FGAp3VM0xtWq441gJg2hAZw4HH1STs=
From: Steven Price <steven.price@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.linux.dev
Cc: Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	James Morse <james.morse@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Joey Gouly <joey.gouly@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Christoffer Dall <christoffer.dall@arm.com>,
	Fuad Tabba <tabba@google.com>,
	linux-coco@lists.linux.dev,
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
	Gavin Shan <gshan@redhat.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Alper Gun <alpergun@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Emi Kisanuki <fj0570is@fujitsu.com>,
	Vishal Annapurve <vannapurve@google.com>,
	WeiLin.Chang@arm.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kohei Enju <enju.kohei@fujitsu.com>
Subject: [PATCH v2 00/12] KVM: arm64: CCA: Prepare Realm memory management
Date: Wed, 11 Nov 2026 14:57:44 +0000
Message-ID: <20261111145758.217946-1-steven.price@arm.com>
X-Mailer: git-send-email 2.43.0
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

This series adds the memory management plumbing for CCA, building on the
basic RMM support [1]. Thank you to those who reviewed v1 - I'm
attempted to address all the comments.

The patches introduce internal Realm VM state and RMI feature checks,
prepare Realm stage-2 setup and teardown, and provide RTT mapping and
invalidation helpers. Realm memslots are restricted to the lower half
of the IPA space because the protected and shared halves alias each
other. The final patch connects the helpers to KVM's stage-2 MMU
operations.

This is the memory management portion of the larger Realm host series.
Realm descriptor creation, REC entry and exit, activation, and the new
uAPI follow in the integration stack. This series alone does not enable
Realm creation.

As before there's an integration branch[2] that includes the realm
creation, REC entry/exit etc building on top of this series. I've also
pushed a git branch[3] of just this series.

Changes since v1:
- Add a guest_memfd prerequisite patch that checks whether the backing
  file supports mmap when preparing an arm64 memslot.
- Combine the RMI availability and feature checks into one patch, and
  move Realm vCPU feature restrictions to the integration stack.
- Correct Realm IPA sizing and RTT teardown, including teardown before
  activation, RTT accounting, and handling of missing or folded RTTs.
- Rework RTT mapping to respect IPA and physical alignment, handle
  partial RMI progress, and retry interrupted operations.
- Preserve private mappings when a Realm guest_memfd memslot deletion is
  rejected, and tighten Realm fault handling and stage-2 destruction.

[1] https://lore.kernel.org/all/20261007073537.2454351-1-suzuki.poulose@arm.com/
[2] https://gitlab.arm.com/linux-arm/linux-cca
    branch: cca-host-mm/v2/integration
[3] https://gitlab.arm.com/linux-arm/linux-cca
    branch: cca-host-mm/v2/mm

Steven Price (7):
  KVM: arm64: CCA: Reserve the RMM mode
  KVM: arm64: guest_memfd: Check mmap support when preparing memslot
  KVM: arm64: CCA: Check RMI support and features at init
  KVM: arm64: CCA: Add basic infrastructure for creating a realm
  KVM: arm64: CCA: Tear down RTTs
  KVM: arm64: CCA: Add Realm RTT mapping and invalidation helpers
  KVM: arm64: CCA: Support runtime faulting of memory

Suzuki K Poulose (5):
  KVM: arm64: CCA: Introduce Realms
  KVM: arm64: Handle attributes in stage2_unmap_range
  KVM: Allow architectures to reject memslot changes before invalidation
  KVM: arm64: CCA: Prevent memslot modifications after Realm creation
  KVM: arm64: CCA: Add Realm stage-2 MMU operations

 arch/arm64/include/asm/kvm_emulate.h   |  29 +
 arch/arm64/include/asm/kvm_host.h      |  53 +-
 arch/arm64/include/asm/kvm_mmu.h       |   4 +-
 arch/arm64/include/asm/kvm_rmi.h       | 104 +++
 arch/arm64/include/asm/virt.h          |   1 +
 arch/arm64/kvm/Kconfig                 |   1 +
 arch/arm64/kvm/Makefile                |   2 +-
 arch/arm64/kvm/arm.c                   |  21 +-
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h |   2 +-
 arch/arm64/kvm/hyp/nvhe/switch.c       |   4 +-
 arch/arm64/kvm/hyp/nvhe/timer-sr.c     |   2 +-
 arch/arm64/kvm/mmu.c                   | 311 +++++++--
 arch/arm64/kvm/pkvm.c                  |   4 +-
 arch/arm64/kvm/psci.c                  |   2 +-
 arch/arm64/kvm/rmi.c                   | 883 +++++++++++++++++++++++++
 drivers/firmware/arm_rmm/rmi.c         |  10 -
 include/linux/arm-rmi-cmds.h           |  13 +
 include/linux/kvm_host.h               |   5 +
 virt/kvm/guest_memfd.c                 |   6 +
 virt/kvm/kvm_main.c                    |  33 +-
 20 files changed, 1391 insertions(+), 99 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_rmi.h
 create mode 100644 arch/arm64/kvm/rmi.c

-- 
2.43.0

