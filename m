Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628811;
	b=e/0XFSUgbxhOyCV6I/qpjXjmKt76m6XTCnZMnJJmudp9OxymczeBM0oI3U1nLLSxm8tD
	 05iwJlCs1SIcrONZU85eHgW+YuS7wkODr17/IXsGBaXa5s3SjP1XM80KrBTe5n8o1EKsO
	 Ga6zCMfjNYkawHBMNjlVzxCsxoXLQXsCJaIYBjfxsoluHaAUb+SRnpBLCol6ewudxIU1W
	 9ZTkOUIy6qdRouclkYIEPGjn9zuHONwpSAbPFVPisiiw+R+JBJa09tsgYrTSre8PDCZDX
	 Hyik9OKG5lnhEqv7ly3IYIs1bPIBVYOGs+rKXv/dTV2NM/odp4105p53hKR0dOeOLTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628811;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Ua1DOoDM2ycibNdB6MjyfXMQfwPGZxy1wTaNHdPExSE=;
	b=YlOLQFkSp+7IuVfK7mSV6DtCbqp7uabg2pKYMg3zX0iCOfS/T7IEzaXvU2KMk+ffLRVK
	 +5+DqMDShs4OoLHnKM7XRPCP8K17AHgMnajJrGZwS7VuExkKuhf7HJa7HxJEzfUG0yfX9
	 0THm89l0fKMaab6tmnaS2EZWvGKNJiEjXzK0Zq6Tv5qTetJPQtHcXm2D0tAzv/y9cpm3t
	 yMpPwWLC81HmkV+VVHg9e7iZyAvkwZ72qFJIcFNfMt3pVc4UnfDl77Me9gys7z/hCcuqj
	 gYfUJLvrJum/7QFUHdAbtx4nD2S4/skBpsnx8DK22HVweEQopPcigUGDDz7rct6Yufg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=N3l60SDP;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2A1606A327;
	Mon,  2 Nov 2026 14:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C2A1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=N3l60SDP
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43EB31691;
	Mon,  2 Nov 2026 06:13:26 -0800 (PST)
Received: from e122027.arm.com (unknown [10.57.58.9])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A554D3F59E;
	Mon,  2 Nov 2026 06:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793628809; bh=c0J8oAMjRRRr84vzXcxPgHvZvqambP7No/QhePqrRBE=;
	h=From:To:Cc:Subject:Date:From;
	b=N3l60SDPbFfZ/rOuZxoYhJ8tcOkCD9sP+8uYKl4eoZq/cgrmQrEnoisz5nMtdJLuD
	 qWSdXM9gtzbElbowMGwonb6XxZqM4kWzYJXehgEmhhYeY30TR0+NZkpilaJfrOo8Bi
	 7jmItYOE9907P8VlBdZFksu/Z3QQYoEXRV8ARkH8=
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
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH 00/11] KVM: arm64: CCA: Prepare Realm memory management
Date: Mon,  2 Nov 2026 14:12:51 +0000
Message-ID: <20261102141304.126883-1-steven.price@arm.com>
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

This series adds the memory plumbing for CCA building on the basic
plumbing[1] that has just been merged.

These patches add the internal realm VM state and RMM feature checks,
prepare realm stage-2 setup and teardown, and provide RTT mapping and
invalidation helpers. Realm memslots are now contrained to the lower
half of the IPA space, because faults treat the protected and shared
halves as aliasing. The final patch then connects these helpers to the
KVM stage-2 MMU operations.

There's also an integration branch[2] that builds on this series and
includes the realm descriptor creation, REC entry/exit, activation and
the new uAPI. This series by itself is also available as a git
branch[3]. However the new code isn't generally active without the full
integration branch.

[1] https://lore.kernel.org/all/20261007073537.2454351-1-suzuki.poulose@arm.com/
[2] https://gitlab.arm.com/linux-arm/linux-cca
    branch: cca-host-mm/v1/integration
[3] https://gitlab.arm.com/linux-arm/linux-cca
    branch: cca-host-mm/v1/mm

Steven Price (7):
  KVM: arm64: CCA: Reserve the RMM mode
  KVM: arm64: CCA: Check for RMI support at KVM init
  KVM: arm64: CCA: Check for LPA2 support and SHA-256
  KVM: arm64: CCA: Add basic infrastructure for creating a realm
  KVM: arm64: CCA: Tear down RTTs
  KVM: arm64: CCA: Add Realm RTT mapping and invalidation helpers
  KVM: arm64: CCA: Support runtime faulting of memory

Suzuki K Poulose (4):
  KVM: arm64: CCA: Introduce Realms
  KVM: arm64: Handle attributes in stage2_unmap_range
  KVM: arm64: CCA: Prevent memslot modifications after Realm creation
  KVM: arm64: CCA: Add Realm stage-2 MMU operations

 arch/arm64/include/asm/kvm_emulate.h   |  29 +
 arch/arm64/include/asm/kvm_host.h      |  62 +-
 arch/arm64/include/asm/kvm_rmi.h       | 109 ++++
 arch/arm64/include/asm/virt.h          |   1 +
 arch/arm64/kvm/Kconfig                 |   1 +
 arch/arm64/kvm/Makefile                |   2 +-
 arch/arm64/kvm/arm.c                   |  33 +-
 arch/arm64/kvm/hyp/include/nvhe/pkvm.h |   2 +-
 arch/arm64/kvm/hyp/nvhe/switch.c       |   4 +-
 arch/arm64/kvm/hyp/nvhe/timer-sr.c     |   2 +-
 arch/arm64/kvm/mmu.c                   | 242 +++++--
 arch/arm64/kvm/rmi.c                   | 852 +++++++++++++++++++++++++
 12 files changed, 1275 insertions(+), 64 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_rmi.h
 create mode 100644 arch/arm64/kvm/rmi.c

-- 
2.43.0

