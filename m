Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793865376;
	b=rLPE+w+wbIwXGfLx275qfJgha700pyLnNgUAV/SUz6QLpM1MZhgrJURvLuIESO8T1n8R
	 W/KHKofuPHUUPHzFfVF45vthu8fyjM3rr1l4SLoRT9C8q7Z07/vBcfbVFrlQGIlKCIx7h
	 5WR/98bgXl90QJx40ZwMy4okZosIiy08taC2laJaFffCzsUvKdlf1+H7befL3NRXRmQx9
	 VKSWKFw/bwfUjmmVhy14IQzP6NCXR1w8etR0Ln0jRMnQsYjnGjzkTTUMKp4qqInooaQzk
	 56ypsN2OwdNQCRypU0lQLuSb7oxMb4adHwyAQOYqNb/WtsPG0pEJ3ERvGgh3IBNMw4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793865376;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=WYKLhjZojkV/Tmsr5BGvWu2TVcuinj9/B2ZB1xR8yqQ=;
	b=OKpIvlyemlUZsEgJmeFMVMnXT5uWZBDzmuj/yKS2gGPOqQJ8w4571EQHSJ0Yo0qX7jkg
	 /XWiv2M83eIPcyd3tXTLXYUEhuvoec9jgEgD8SnNVyf5n1mwEbldbmSyI9o3Zvyorw0CN
	 auxCaL79mDbw60MaamlzB5u38+Lado1wiz3nXIn3pqiZ03hcTN1SR8oNyG++MNf+XPcxC
	 F0wcYlao5VAYhyBO9cDyYSinzZLkAs9vozG6FqwchLy9OF1e5jOzuqu3zYa/gvTW0zAFD
	 YM3yBUMP+XEkaD+Hwrd7ciYGWJhXeaYON8LobSLl4/0z61EeuYj2jwlejwkxnM9Tb+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fYBfivp2;
	arc=none smtp.remote-ip=95.215.58.121
Received: from mta1.migadu.com (out-121.mta1.migadu.com [95.215.58.121])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF78606A330
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 07:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AF78606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fYBfivp2
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=k9y24bW4jo8B40iHLCIlVJwO4M8UIaQgR1LB6bPJ2yc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793865371; v=1; x=1794470171;
 b=fYBfivp2nsHXnzHfCaZu2p4VvmARdAKyhzKpFcorw9fQJ3KMvFxuByEbdejQ7hQ/Qpo0G8sv
 PYz7ZtNuMQCFJ7li90DL/bjY1uO0fZDw+DJ4Ei2bgEdGR/bedx5bGdnwqqqaX/3Kt0bRMWwt+1o
 rA+7J/Y7hWrnG8kFnuThfOLY=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 36aa00a02140456e;
	Thu, 05 Nov 2026 07:56:11 +0000
X-Mizu-Trace-ID: 36aa00a02140456e
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Quentin Perret <qperret@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Martijn Bogaard <martijnbogaard@google.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Fuad Tabba <tabba@google.com>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] KVM: arm64: Honour KVM_VM_TYPE_ARM_IPA_SIZE under pKVM
Date: Thu,  5 Nov 2026 07:56:03 +0000
Message-ID: <20261105075606.367005-1-fuad.tabba@linux.dev>
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
  - Dropped v1's kvm_get_ipa_max() patch. EL2 checks the requested IPA
    size against a copy of the host's limit taken at init.
  - Added patch 2, which aligns the PGD of EL2's selftest VM.
  - Rebased on 7.4-rc1.

pKVM ignores KVM_VM_TYPE_ARM_IPA_SIZE: every VM gets the host's IPA
limit, and an out-of-range request is accepted. So the vgic_init
selftest fails on any pKVM host whose limit exceeds 40 bits.

With patch 3, a VM gets the IPA size its VMM requested, and EL2 rejects
one the host itself would reject.

Patch 1 rejects a PGD donation that isn't aligned to its size, which
crashes EL2 today. It's first because patch 3 lets the host choose
that size. Patch 2 aligns the PGD of EL2's own selftest VM under
CONFIG_NVHE_EL2_DEBUG.

A VMM that requests less than the host limit now gets that size. One
passing the default type gets 40 bits. On a host whose limit is below
40 bits the default type is rejected, as it is without pKVM. kvmtool
and QEMU request the size their memory map spans, and crosvm the host
limit, so none of them places anything beyond its request.

On QEMU, with 7.4-rc1 as a 64K/PA_BITS_48 pKVM host on a 52-bit part,
KVM_RUN fails on a 52-bit VM's first access to a memslot above 2^48.
With patch 3 the guest writes through it. The same kernel, with
CONFIG_NVHE_EL2_DEBUG, panics at pKVM init on cortex-a57, which patch 2
fixes.

On an M4, whose limit is 40 bits, pKVM now rejects a 44-bit request, as
the M4 does without pKVM. A protected kvmtool guest there boots with the
32 bits it requests.

Based on Linux 7.4-rc1 (6628e7d4c6b25).

Cheers,
/fuad

[1] https://lore.kernel.org/all/20260917091826.2639205-1-fuad.tabba@linux.dev/

Fuad Tabba (2):
  KVM: arm64: Align the pKVM selftest VM's stage-2 PGD
  KVM: arm64: Honour the requested IPA size under pKVM

Quentin Perret (1):
  KVM: arm64: Check PGD alignment when creating a pVM

 arch/arm64/include/asm/kvm_hyp.h      |  1 +
 arch/arm64/kvm/arm.c                  |  1 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c |  2 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c        | 34 +++++++++++++++++++++------
 arch/arm64/kvm/mmu.c                  |  4 +---
 5 files changed, 31 insertions(+), 11 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.47.3

