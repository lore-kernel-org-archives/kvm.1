Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627DF3ED12D;
	Wed, 27 May 2026 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896005; cv=none; b=sjn7V2i927jUk9K+lRcwLEx+7iHkKgc86pcgGGX97LFSAmkhv8XtijYODMbmqz+gRXNm1SkPoiIwvZBiGYgPyuP+M0WKFv0h+12ZPps6/o5ZGT5gmCt/jZarlI/xM3wAZVfKriF8bopEwtu76/9A3JcfeUe9x4RnUoEJpV6wMvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896005; c=relaxed/simple;
	bh=ZO5W64CtWNP+5gC9BrgLSE8kNQUV1QQDwxqRTcg7pnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DACHGu6I9lWbVkswjsLPal1LGViydPWatJ6mH9EEzlfYz/2niUQTc64SUYKCD3cRqMJlkdTxg0cy8TcB1FCoPyo6T/SNuebA608ZOcIawUtyQElSHWxrw8kmHmbbPvkfvZIf1aJIfzWkjBTa6N/i5QcKIeQlKFYAkKP9XREYQMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIUu3fEi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIUu3fEi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EA7DC2BCB3;
	Wed, 27 May 2026 15:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779896003;
	bh=ZO5W64CtWNP+5gC9BrgLSE8kNQUV1QQDwxqRTcg7pnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QIUu3fEiAgxP9/bkAL0f5vClmUKDbY9O4nToSGoBgad7SmS656K4Tc8UiVM3tletV
	 7XJDLb4H2Q49LXECOgUHe3hrzAU4MmOOVZvKGYT34FtMP+P7F5sc+6tyOhruAkBRMv
	 axmGyOV89V26ujTC20XVoRhiuPVgQxqdEYOmgrP8fapgHLqDQffjT8c0vQ4l8zWEUv
	 dNTXYEieRlshzzz4tjqxAYAP7AVCGZPzo8Zn1aGTwJRX6+fcRcszCuzlfZnbS+LkV7
	 0mZROqmVLAHG0DBIMvyV64GR8NqO0Ux/VZ6PxyH85XSoKjuez0f9qyQvdIvusIRlkS
	 3Zj5jRRJbhzPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D4DCD6E45;
	Wed, 27 May 2026 15:33:23 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Wed, 27 May 2026 08:33:23 -0700
Subject: [PATCH RFC 11/12] KVM: mmu: Point users of
 host_pfn_mapping_level() to docs
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-kvm-locking-docs-v1-11-4fe8b602ff47@google.com>
References: <20260527-kvm-locking-docs-v1-0-4fe8b602ff47@google.com>
In-Reply-To: <20260527-kvm-locking-docs-v1-0-4fe8b602ff47@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
 vannapurve@google.com, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779896001; l=4206;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=1Iv7rmsthjHBhqlZuqMTaGdIcDmY7dzZBn2M3n/QhfA=;
 b=DbFncF6doMBB+aSot4N9pP3MjdxICCeHux2pefhL0l/IYTSzt+vFHwnY3udE0SyelBPn1PfAQ
 H4IwkJf86J8D18K8SCuU30i5QSn926OUxaY1cKuJTR+oj3QTWScfu5d
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

After consolidating documentation for host_pfn_mapping_level() in
Documentation/virt/kvm/locking.rst, point users of function to docs.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/loongarch/kvm/mmu.c | 24 ++++--------------------
 arch/x86/kvm/mmu/mmu.c   | 24 ++++--------------------
 2 files changed, 8 insertions(+), 40 deletions(-)

diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
index a7fa458e33605..0313901171a2e 100644
--- a/arch/loongarch/kvm/mmu.c
+++ b/arch/loongarch/kvm/mmu.c
@@ -641,27 +641,11 @@ static bool fault_supports_huge_mapping(struct kvm_memory_slot *memslot,
 /*
  * Lookup the mapping level for @gfn in the current mm.
  *
- * WARNING!  Use of host_pfn_mapping_level() requires the caller and the end
- * consumer to be tied into KVM's handlers for MMU notifier events!
+ * WARNING!  This derives information from the current state of memslots and
+ * page mappings and may race with invalidations.
  *
- * There are several ways to safely use this helper:
- *
- * - Check mmu_invalidate_retry_gfn() after grabbing the mapping level, before
- *   consuming it.  In this case, mmu_lock doesn't need to be held during the
- *   lookup, but it does need to be held while checking the MMU notifier.
- *
- * - Hold mmu_lock AND ensure there is no in-progress MMU notifier invalidation
- *   event for the hva.  This can be done by explicit checking the MMU notifier
- *   or by ensuring that KVM already has a valid mapping that covers the hva.
- *
- * - Do not use the result to install new mappings, e.g. use the host mapping
- *   level only to decide whether or not to zap an entry.  In this case, it's
- *   not required to hold mmu_lock (though it's highly likely the caller will
- *   want to hold mmu_lock anyways, e.g. to modify SPTEs).
- *
- * Note!  The lookup can still race with modifications to host page tables, but
- * the above "rules" ensure KVM will not _consume_ the result of the walk if a
- * race with the primary MMU occurs.
+ * See Documentation/virt/kvm/locking.rst to understand how to consuming the
+ * result of this lookup safely.
  */
 static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
 				const struct kvm_memory_slot *slot)
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f8aa7eda661ee..20cdcdd20e78d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3214,27 +3214,11 @@ static void direct_pte_prefetch(struct kvm_vcpu *vcpu, u64 *sptep)
 /*
  * Lookup the mapping level for @gfn in the current mm.
  *
- * WARNING!  Use of host_pfn_mapping_level() requires the caller and the end
- * consumer to be tied into KVM's handlers for MMU notifier events!
+ * WARNING!  This derives information from the current state of memslots and
+ * page mappings and may race with invalidations.
  *
- * There are several ways to safely use this helper:
- *
- * - Check mmu_invalidate_retry_gfn() after grabbing the mapping level, before
- *   consuming it.  In this case, mmu_lock doesn't need to be held during the
- *   lookup, but it does need to be held while checking the MMU notifier.
- *
- * - Hold mmu_lock AND ensure there is no in-progress MMU notifier invalidation
- *   event for the hva.  This can be done by explicit checking the MMU notifier
- *   or by ensuring that KVM already has a valid mapping that covers the hva.
- *
- * - Do not use the result to install new mappings, e.g. use the host mapping
- *   level only to decide whether or not to zap an entry.  In this case, it's
- *   not required to hold mmu_lock (though it's highly likely the caller will
- *   want to hold mmu_lock anyways, e.g. to modify SPTEs).
- *
- * Note!  The lookup can still race with modifications to host page tables, but
- * the above "rules" ensure KVM will not _consume_ the result of the walk if a
- * race with the primary MMU occurs.
+ * See Documentation/virt/kvm/locking.rst to understand how to consuming the
+ * result of this lookup safely.
  */
 static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
 				  const struct kvm_memory_slot *slot)

-- 
2.54.0.823.g6e5bcc1fc9-goog


