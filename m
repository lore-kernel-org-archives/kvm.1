Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F123314BF;
	Tue, 16 Jun 2026 00:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570553; cv=none; b=CW9LcRGn5UwZt27fmPZw304SxLoI+7akAYa0fQtienK+Bgr6jvNrj8nBH3YdeD38WVeac6BUegF+FEaXqFdzPTrcx1tq/NK+7x/Cp2Km05ozQVj+v094n1YmJ+A75behlxwyxos/wWki0sAUxRl9wBLX7V6lFRNoryTJWvHxL4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570553; c=relaxed/simple;
	bh=tXRjipMD11C6lBd759IrOSVZFgsQ7ecidlg37COnq1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ce/K1lKtZrNcZ1vs6z9AXFny1RZ3JDzpxqu6ozMcrSP5So2AztzziSM6/JLhCf5L0NEXkNZz/yxyTLI5tI/Y9HOrYqkE45Y3V2KBtQ6l3a04U4pqiv4zGcZab8ujmYOZ0I2yhMViHvQUWU4ABKJwuPwV2wPg/jAi9dKEihSVEGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohVQM6g+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohVQM6g+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4331F00A3D;
	Tue, 16 Jun 2026 00:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570552;
	bh=GG7VZaT8SASv/ia+LEE656V3I3yteoCYcd4u8m1m56U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ohVQM6g+gPuftNT0K4lT5yjjB1WR0rsXPiIEsR4vFuXKQMnq1NaNuBBxjkRlbJcpj
	 rqevPrL+8H0/QU6TcyuqvudP1rdmwdFDjI74zlq3xuSCNAXSZuMyFRvtUtIG+V+MT6
	 TPmV8dZDwuKrFToj/2TFU6iynmQxr8Un9lNLes2LH7PgkCaCVuxaYufeIPatzJoGyY
	 sPcqsc9ezG4Xgw+UnhMt4Ov7e+ZH65tPISkgVYwI4krmqjIcJCgxzcSBjzFsSGT7z2
	 uXOqbZO64GwfS229+JceiXEdTZaKnMzw39eaBfAT8iQQXNHZls6ezFHFg61aMOFULR
	 sIdxJOH2b34yQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [RFC PATCH v2 21/25] KVM: x86/mmu: rename __kvm_mmu_invalidate_addr()
Date: Tue, 16 Jun 2026 00:41:50 +0000
Message-ID: <20260616004155.1435766-22-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616004155.1435766-1-yosry@kernel.org>
References: <20260616004155.1435766-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for creating another helper for
kvm_mmu_invalidate_addr(), rename __kvm_mmu_invalidate_addr() to
kvm_mmu_invalidate_addr_in_root().

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index bf2e0c2205631..65c35ed8f4a01 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6577,8 +6577,9 @@ void kvm_mmu_print_sptes(struct kvm_vcpu *vcpu, gpa_t gpa, const char *msg)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_print_sptes);
 
-static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
-				      u64 addr, hpa_t root_hpa)
+static void kvm_mmu_invalidate_addr_in_root(struct kvm_vcpu *vcpu,
+					    struct kvm_mmu *mmu,
+					    u64 addr, hpa_t root_hpa)
 {
 	struct kvm_shadow_walk_iterator iterator;
 
@@ -6634,11 +6635,11 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 		return;
 
 	if (roots & KVM_MMU_ROOT_CURRENT)
-		__kvm_mmu_invalidate_addr(vcpu, mmu, addr, mmu->root.hpa);
+		kvm_mmu_invalidate_addr_in_root(vcpu, mmu, addr, mmu->root.hpa);
 
 	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++) {
 		if (roots & KVM_MMU_ROOT_PREVIOUS(i))
-			__kvm_mmu_invalidate_addr(vcpu, mmu, addr, mmu->prev_roots[i].hpa);
+			kvm_mmu_invalidate_addr_in_root(vcpu, mmu, addr, mmu->prev_roots[i].hpa);
 	}
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_invalidate_addr);
-- 
2.54.0.1136.gdb2ca164c4-goog

