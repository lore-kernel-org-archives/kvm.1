Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124B4279329;
	Tue, 28 Jul 2026 00:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198976; cv=none; b=MmQvQUlsVAaIuM7XOIi/RVuvQ+MrRCxr/6PKtaE3ZpjH+AJof10kRw50QAsx0s/vzIEG5/DNZjc7G8QitAsJ6oZ6jgRIxgAORU+cYwUwmuvZMyX8ULraG41X1sG1BJ6jNh6StySQg6sZ3sauL4JhRljwk5iAKO+8q3j2l7iFU3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198976; c=relaxed/simple;
	bh=tk4fYKOskRHffRCHqzK3qV3/k28Li3w5YM3ZckvpTMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+jfCnbmtWnDs7XVP3LVB1pZvwBF0ivhVQgYPtrR05eyJwlhvH5y/o3p0tHViZx7fQ6Oco07YopRDU47necWvNOFPAvaLQEj+FyEbQP5w4YGhDu5Xw9iL73sHlc/s6k5ZedYXeri8Cjj+fLcVKRh6njFEryEzDJiEuP0y9azQRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcDB8FoF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcDB8FoF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA871F00A3E;
	Tue, 28 Jul 2026 00:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198975;
	bh=xqvjAuuPanNDR7cz0ubP1viPuiw1ope9/2hDIhzVcR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WcDB8FoFBY2EYdPiy9UdNETd0aAVSpGH82P0SgwupKVXoAkuuFyaKkuVkEgeJXhqg
	 Wbe+SXjxurKLlGEGMH7dquM9Zng258dBoyGggaWphS9ba7wUmG7bE63HJ67hEr+eZN
	 tS2uRy26ndoklYnj46B6X95/CEWUMaZp4C9R7wQhyPs0enBGf2M1ib+OK99RJlcri1
	 kpBZFXRIod5mcM/p9x4G4S68zGLLqvuwlmu6fqoZJiNzCfP5LvW31ll0VhrW4FAkHC
	 fpfOLZzoNYZvz4i6XK4XjoLKIJ+DruL4/3cAskAQUqz1OnsXPUii3s6+EXYv1++sQH
	 eAVvpyO0Z7ALg==
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
Subject: [PATCH v1 23/28] KVM: x86/mmu: Rename __kvm_mmu_invalidate_addr() to kvm_mmu_sync_addr()
Date: Tue, 28 Jul 2026 00:35:52 +0000
Message-ID: <20260728003557.1136583-24-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260728003557.1136583-1-yosry@kernel.org>
References: <20260728003557.1136583-1-yosry@kernel.org>
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
index 05d2ba2598e1b..1889413759d2e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6627,8 +6627,8 @@ void kvm_mmu_print_sptes(struct kvm_vcpu *vcpu, gpa_t gpa, const char *msg)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_print_sptes);
 
-static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
-				      u64 addr, hpa_t root_hpa)
+static void kvm_mmu_sync_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
+			      u64 addr, hpa_t root_hpa)
 {
 	struct kvm_shadow_walk_iterator iterator;
 
@@ -6693,11 +6693,11 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
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
2.55.0.229.g6434b31f56-goog

