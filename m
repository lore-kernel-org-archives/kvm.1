Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB82D35AC2F;
	Thu,  8 Oct 2026 00:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418490; cv=none; b=bAiePGaiBJsTNSV8vTxN54r8QbrbK1w7hacN2HfJBLaDqceqe+2QRTFGvLVDKRhR1arnusMfSZ0aAlsijkLXP1wEjZRc09uSw44yCKao+v/GQobYIMK4D8v3KKuzx3b8bj3xwkEVH2U4T1e7qWpM19agfroqe8kE03ayHeUQwIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418490; c=relaxed/simple;
	bh=hg052sX/kJUUKhTI0kRFAqDGZSNFRsqhIXqjSQRCG3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amvwLYdoVFYF4aXbBkmv7YLyAON4D3bi2qPC51gY9K8BszV9rrBjWZEUtim+jOfCfJVjxlSjjcAIORMdmVzX0SoBNt8yIswMVFYDZQ+8ZBVEVTBkt+Ajs7Hq+fuNShLTeG80oeiQqwxZf6/Q+VKF55q5+onctadYVKonTh1TD1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0f3IHe+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0f3IHe+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DD31F0089B;
	Thu,  8 Oct 2026 00:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418488;
	bh=v6T5aoEwDNoWTcv/NzhlTgIAU2AY7WZGLOfuOsRu1EU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L0f3IHe+ULxqTf0wEjgAWwDajD1uufD6WYfbT95WpH9K/ZFj824lp1gwQitXSnFI5
	 UjBOsEStlppKC4CYaFB4Ad1T64tTsbmDp6urM1rscT07udI0xgYVl0FDr55ktwlRaA
	 o0CXj1fh31IJLPsA4LJ1Bsf/hA0JdTRVAwwAtUQd1GQQtF3+2VcMNns72uTq/YAH+B
	 9bnUdxG/z0KJqffgRaI31AU9hrL17PjSnzkipxgGS4BQKgy9D1VMHWvYV9WIJyouMv
	 euplcVGX0pExwEeZ4+YHSy6NaV1XscyvT349VHqalwZw4Mi7a171YGqlbATpW7VabS
	 yvx6hYlJAKnNw==
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
Subject: [PATCH v2 20/29] KVM: x86: Add KVM_REQ_MMU_SYNC_ALL_ROOTS
Date: Thu,  8 Oct 2026 00:14:16 +0000
Message-ID: <20261008001425.2458927-21-yosry@kernel.org>
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

Add a new x86 request to sync all roots, current and previous. This will
be used when syncing the shadow NPTs on nested VMRUN when an ASID flush
(or new ASID) is requested by L1, as all physical translations in all
roots should be sync'd (since shadow mappings are not tagged with an
ASID).

Refactor syncing all roots (currently only done by
kvm_vcpu_flush_tlb_guest()) to a helper, and use it to handle the
request.

Clear KVM_REQ_MMU_SYNC when handling KVM_REQ_MMU_SYNC_ALL_ROOTS as the
latter is a superset. Do not do so inside kvm_mmu_sync_all_roots(), to
avoid any subtle behavioral changes from kvm_vcpu_flush_tlb_guest()
clearing KVM_REQ_MMU_SYNC. It makes sense to always clear it when
syncing the MMU, but there might be weird dependencies on the sync only
happening before the actual vCPU run, and kvm_vcpu_flush_tlb_guest() is
called in other code paths than handling KVM_REQ_TLB_FLUSH_GUEST before
vCPU run.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/mmu.h              |  7 +++++++
 arch/x86/kvm/x86.c              | 11 ++++++++---
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e2eef7057bd35..1d28bb7e92c7f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -127,6 +127,7 @@
 	KVM_ARCH_REQ_FLAGS(33, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_UPDATE_PROTECTED_GUEST_STATE \
 	KVM_ARCH_REQ_FLAGS(34, KVM_REQUEST_WAIT)
+#define KVM_REQ_MMU_SYNC_ALL_ROOTS	KVM_ARCH_REQ(35)
 
 #define INVALID_PAGE (~(hpa_t)0)
 #define VALID_PAGE(x) ((x) != INVALID_PAGE)
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index b443a5083bfb0..b6ad0ff72393e 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -170,6 +170,13 @@ void kvm_mmu_unload(struct kvm_vcpu *vcpu);
 void kvm_mmu_free_obsolete_roots(struct kvm_vcpu *vcpu);
 void kvm_mmu_sync_roots(struct kvm_vcpu *vcpu);
 void kvm_mmu_sync_prev_roots(struct kvm_vcpu *vcpu);
+
+static inline void kvm_mmu_sync_all_roots(struct kvm_vcpu *vcpu)
+{
+	kvm_mmu_sync_roots(vcpu);
+	kvm_mmu_sync_prev_roots(vcpu);
+}
+
 void kvm_mmu_track_write(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
 			 int bytes);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 12eaeaea51633..a54e9da2ed09e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2020,8 +2020,7 @@ static void kvm_vcpu_flush_tlb_guest(struct kvm_vcpu *vcpu)
 		 * a forced sync of the shadow page tables.  Ensure all the
 		 * roots are synced and the guest TLB in hardware is clean.
 		 */
-		kvm_mmu_sync_roots(vcpu);
-		kvm_mmu_sync_prev_roots(vcpu);
+		kvm_mmu_sync_all_roots(vcpu);
 	}
 
 	kvm_x86_call(flush_tlb_guest)(vcpu);
@@ -8167,8 +8166,14 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			if (unlikely(r))
 				goto out;
 		}
-		if (kvm_check_request(KVM_REQ_MMU_SYNC, vcpu))
+
+		if (kvm_check_request(KVM_REQ_MMU_SYNC_ALL_ROOTS, vcpu)) {
+			kvm_mmu_sync_all_roots(vcpu);
+			kvm_clear_request(KVM_REQ_MMU_SYNC, vcpu);
+		} else if (kvm_check_request(KVM_REQ_MMU_SYNC, vcpu)) {
 			kvm_mmu_sync_roots(vcpu);
+		}
+
 		if (kvm_check_request(KVM_REQ_LOAD_MMU_PGD, vcpu))
 			kvm_mmu_load_pgd(vcpu);
 
-- 
2.56.0.360.g66cac248cb-goog

