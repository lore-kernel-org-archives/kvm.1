Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5990231832;
	Thu,  8 Oct 2026 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418492; cv=none; b=p449WfgzTZvCGCZ9KOca7ApHwYhok/gtJ2ABA8uxTJYSH78znZdIaSSqFb55Bx+tIn/KzWqkyrL0TGHFtGguSKUSrm8CMtvnfEBMxzxHd34kCkPJXJutvIrxVWnszr9VC8c9UrSw0CgOMwwAc+Qd6xJz/E9rWUGLpNbV4bTYhN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418492; c=relaxed/simple;
	bh=G4/qeSFmad1NOZxGGMtGisfhn7eXEm+RFCy3a4Xh3hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2TGvVW6lXNBoHNrNZqTtq8zgIPDz4CEelvee7mmM1Az6/Lx00eTtXmKMVY6GCT47S789gADGRp+XErxM+0mvqaA4Beh5lbyDz+gN2PlXJdUEvhJbyU8uNnxJ1Jvzq4ehRFEcDrz7B50KEMU1tH5vpjJA5WB52TJMtgDkOJY43s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLLmbI8J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLLmbI8J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF321F00898;
	Thu,  8 Oct 2026 00:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418490;
	bh=Mzuz8AUfWTQ+ImeXyDiQyA7b/EmEZ7+U1xaqUtdkYkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MLLmbI8Jj5vIKecypKhZfrxiSAhSp01rS0kH0MZv8avYJMFkkwkBSC1AMRm/0jIzd
	 xGa8Bno1JKZXuW6T+yz6ycP/3hm58V4JFu3mcPVPLRK7t9XFrRzPplyXA19krgeKDJ
	 qVQNFy5izXx88c2nny6je1xclQh10taHGcqNZYC2aZ4NmTME/9E+4YSVMUKyUpex30
	 OAroG4cme3OCWOTj4rKEzb4plY4NEMNGGml7zXfb+V4XsjX9OEsP5bCXWbmwXZ6EX2
	 w6kDcFC+jwCJaEjekddziXfBO+jHBOorwvRBGeRj4DJ8qlzsMijQE09yBbVC/ritAY
	 oTl3HnKZLuwqA==
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
Subject: [PATCH v2 24/29] KVM: x86/mmu: Rename __kvm_mmu_invalidate_addr() to kvm_mmu_sync_addr()
Date: Thu,  8 Oct 2026 00:14:20 +0000
Message-ID: <20261008001425.2458927-25-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
In-Reply-To: <20261008001425.2458927-1-yosry@kernel.org>
References: <20261008001425.2458927-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for creating another helper for
kvm_mmu_invalidate_addr(), rename __kvm_mmu_invalidate_addr() to
kvm_mmu_sync_addr(), which is arguably a more descriptive name.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/mmu/mmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c096c1a2b4684..b3085f409d0de 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6732,8 +6732,8 @@ void kvm_mmu_print_sptes(struct kvm_vcpu *vcpu, gpa_t gpa, const char *msg)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_print_sptes);
 
-static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
-				      u64 addr, hpa_t root_hpa)
+static void kvm_mmu_sync_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
+			      u64 addr, hpa_t root_hpa)
 {
 	struct kvm_shadow_walk_iterator iterator;
 
@@ -6798,11 +6798,11 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 		return;
 
 	if (roots & KVM_MMU_ROOT_CURRENT)
-		__kvm_mmu_invalidate_addr(vcpu, mmu, addr, mmu->root.hpa);
+		kvm_mmu_sync_addr(vcpu, mmu, addr, mmu->root.hpa);
 
 	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++) {
 		if (roots & KVM_MMU_ROOT_PREVIOUS(i))
-			__kvm_mmu_invalidate_addr(vcpu, mmu, addr, mmu->prev_roots[i].hpa);
+			kvm_mmu_sync_addr(vcpu, mmu, addr, mmu->prev_roots[i].hpa);
 	}
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_invalidate_addr);
-- 
2.56.0.360.g66cac248cb-goog

