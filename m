Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680140;
	b=SRvDlcJaa/4J9QK/8gCXo9Y3xIjLg4OnSlYmOyoEniWwshfC7Woe+tpAkglMI8kGCphC
	 DxskkuFo42kMsFrgROzQBxNOrwAe5zpRM5nWNZsL6AgqI3Vo6hpaLofwB5lIxJn7IzfXW
	 x/ao2IgiPvuRFqHLvGUQMWrxlyLsyw3eY06qHoJDSMw8tHKW86PYVqY3QjLjEW2qm8U7C
	 9suCqC9zbgUTPBw9uiSTbg3xU4yUuBuJQbvvCd3ahglnws1mH5HVtWNKenZ0FTLAZoLhE
	 VH2V7V5MUpsptuPjUW5yX6nUA2QMfV3v8qHizjumFtDhIr7VU7cXTnZsJ3d44YvIdYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680140;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Y/LUBFBKFZ6pOnoBKgntXD5HdgzoU+tx/ippvDPRFz8=;
	b=XosuQmf5vH2HQOxXXqXsWLXWITqnbrxofaWrytTSdtfhq/DGBZCtccsFhIEzWOp0+R12
	 dJJayXPXk0xA9btaPH2Li43hxXM1s23Pt1wHxYPSOpykA+JCE1g7OKuiAFbQkqwxix/9x
	 MPTH1Ds9nvwQf/+izF5cUIenIxDIR9EdB2wqoCX1fMA7yDMCOhwNn0ay105sCxMA0x6KG
	 crYFzX4NBAlrvhbLKtwRXKXvOkg7ukmIqgGOkxjp10UvamIiRPevU764lH3P55Mg5kFoR
	 xY+GyYi7scNJ3C/Co9qAsf/eIwjvBLu24Hl3wPxPT8WJLzAWtH/yck7xNzT8yiSDpvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QwWnv18G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BAA606A319;
	Thu, 22 Oct 2026 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QwWnv18G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D1F1F000C1;
	Thu, 22 Oct 2026 14:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792680139;
	bh=Y/LUBFBKFZ6pOnoBKgntXD5HdgzoU+tx/ippvDPRFz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QwWnv18GDdspYldAzA7jwq1orZiwP7kwD51CJLmUI/hA7JOIigj13YSsCGdmecAvc
	 46Af8XgaSPB0/af488hSXMzWXBZVYhz8feqjz6tYcWXLwhnafFM9RDkg39VH8qCo88
	 5tE9J8PdRTbOpIYqlb8uDjAZ2Qj03gqPOknl6+GfjnlxGEq5DXEWXRPg4qsEq/kJ1A
	 ud1/u0zwCXeBpft9qDuksliQChVPjBmBY9KSWVHGjLckqW6imzLu9eXF3Kd3bwkWip
	 9qq4z16OLDLz4mvuBRQYs+8RF3hME3KlSwqBioPcsuHFFkBOcWurQkDU9bXbu0ZLSs
	 7REL9rmOdlKLQ==
From: Sasha Levin <sashal@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Anup Patel <anup@brainfault.org>
Cc: Mark Brown <broonie@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Jinyu Tang <jinyu.tang@linux.dev>,
	Atish Patra <atish.patra@linux.dev>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: riscv: Implement kvm_arch_pre_fault_allowed()
Date: Thu, 22 Oct 2026 10:42:16 -0400
Message-ID: <36adc119db9b30984c0df4d1846c0f29e4e46c07.1792679974.git.sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CABgObfaH4-Ud4VR=GC8giDmWGJWS-tvYSmPOs4TtWg2hm4ocqw@mail.gmail.com>
References: <CABgObfaH4-Ud4VR=GC8giDmWGJWS-tvYSmPOs4TtWg2hm4ocqw@mail.gmail.com>
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

Commit caa63620f9e3 ("KVM: Allow architectures to disallow pre-fault")
requires every architecture that selects KVM_GENERIC_PRE_FAULT_MEMORY to
implement kvm_arch_pre_fault_allowed(), and there is no generic default.

Commit e8b32e377951 ("KVM: riscv: Implement KVM_PRE_FAULT_MEMORY") was
written before that hook existed, so it selects the option without
implementing the hook. With both commits in the same tree, riscv builds
with KVM enabled fail to link:

  ld.lld: error: undefined symbol: kvm_arch_pre_fault_allowed
  >>> referenced by kvm_main.c
  >>>               virt/kvm/kvm_main.o:(kvm_vcpu_pre_fault_memory) in archive vmlinux.a

The riscv implementation does not refuse pre-faulting in any state, so
return 0 to keep its current behaviour.

Fixes: e8b32e377951 ("KVM: riscv: Implement KVM_PRE_FAULT_MEMORY")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Paolo, this is needed when kvm-riscv-7.4-1 is merged into kvm/next.
Feel free to squash it into the merge instead.

Mark, next-20261022 already fails to link, so linux-next needs this on
top of the kvm-riscv merge.

Build-tested with a riscv tinyconfig plus KVM=y on next-20261022 and on
kvm/next with kvm-riscv-7.4-1 merged. Not runtime tested.

 arch/riscv/kvm/mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index e8673cfa69668..738d9ee1eac9d 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -754,6 +754,11 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	return ret;
 }
 
+int kvm_arch_pre_fault_allowed(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
 long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 				    struct kvm_pre_fault_memory *range)
 {
-- 
2.53.0

