Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458A347F78B;
	Mon, 12 Oct 2026 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848221; cv=none; b=TVW1zUQ0T0wwqxqWsahFv5qdE5plSbiSS+FGhAFtz4kssd+adInysnTjFsQ8DmBgQXO/jzfTMjtD2GA1g+XrlCwuJp9TLssURhUxV8aSmvbdY8Fd/HjKiuVzPE6J2pg7hnyqxoy1SJt8kPQwijr5X44eMUOM+jsHCouldLxpUlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848221; c=relaxed/simple;
	bh=4hrzKXPe80d2nfn97glwlOEWXQa9BLr9VhzH+fFBygI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lr7AKFTkFDE+GupPwDZIEgQW4Ot74uWEVcpfnw3Fl6aYY38uOZKKe1R3HCUUq/Qq27OCEFuUSQ+u7hRR8kSlS5x0AzqepJYVtASGlsBg5lCxmoyPCiXSZA46IdrtFmQsns7ZpSmRc3YrJdmLlDOQCrppZwv97PqTJnTjGY4liyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAgX81fI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAgX81fI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00A01F008A4;
	Mon, 12 Oct 2026 23:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848219;
	bh=wRCSLwTCVWj/ShYx3A8Y3sfmyfzBkjXX6FdzlwyQilU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CAgX81fI4+v7b0ZNDIIXm7Z8oqnRxQBVXKGGbdUqGHbkHdeUl4soqU58CQ9CubdMG
	 ZbyUW0UBN82JGN7+y9CROsznuFK1Bx5hejdHrKtYqJQNwsA8qwKZaTX0s8j6Vw3h9P
	 mvVp9zPjZ59jGj9m6YjplcPXSZolW3kxy8zWdat/57N8u5tDENZnUaRFHWsuhZBCzv
	 F63qe7vH/F9GmksUiua+ZqraNCUCQ9flr+tUKuLiFEPE3mkId/U0YbXQZ5jMJdZL7/
	 LCLtoZej91k4m+xsniQskO1k2ygZ5X4TpqEhamYpBCCunVO8yfvk+htG7wW4UcEjed
	 32oTtVSqemI0A==
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
Subject: [PATCH v3 26/27] KVM: nSVM: Use different ASIDs for L1 and L2
Date: Mon, 12 Oct 2026 23:36:37 +0000
Message-ID: <20261012233638.2546339-27-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261012233638.2546339-1-yosry@kernel.org>
References: <20261012233638.2546339-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that TLB flushes are properly handled and tracked for L1 vs L2
ASIDs, allocate a separate new ASID for L2 for each vCPU, similar to how
VMX handles VPIDs. Drop the unconditional flushes and syncs on nested
transitions.

L1 and L2 can now only share an ASID in two cases:
- KVM runs out of ASIDs and uses the fallback ASID for both L1 and L2.
- SEV VMs always use the same ASID for SEV-specific requirements.

WARN if the ASID is shared otherwise.

Initialize last_asid to 0, such that the L2 ASID is always flushed on
first nested VM-Enter after it's allocated.

On SEV VM migration, free the L2 ASID on the destination vCPU (if nested
was already initialized) before overwriting it with the SEV ASID.

On a Turin CPU, this results in 8-15% performance boost in CPUID rate
microbenchmark [1] and netperf TCP_RR latency/throughput.

[1] https://lore.kernel.org/kvm/20231109180646.2963718-1-khorenko@virtuozzo.com/

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 32 +++++++++++++++++++++++---------
 arch/x86/kvm/svm/sev.c    |  6 ++++--
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 4ffc10bf9232e..6fe68f2ae282d 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -711,6 +711,10 @@ static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
 	 * context is not tagged by the ASID, so the shadow NPTs cannot be
 	 * reused across different L2 ASIDs.
 	 *
+	 * Note, last_asid is initialized as 0, so the first nested VM-Enter
+	 * after setting EFER.SVME will always flush the TLB to avoid using
+	 * stale entries.
+	 *
 	 * If L1 requested a full TLB flush for all ASIDs (including its own),
 	 * L1's own ASID is also flushed on nested VM-Exit, before running L1.
 	 *
@@ -727,12 +731,10 @@ static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
 	 * If L1 and L2 share the same ASID in hardware (when using the fallback
 	 * ASID for both, or for SEV guests), flush it on nested transitions.
 	 */
-	if (svm->asid == svm->nested.asid02)
+	if (svm->asid == svm->nested.asid02) {
+		WARN_ON_ONCE(svm->asid != fallback_asid && !is_sev_guest(vcpu));
 		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
-
-	/* TODO: optimize unconditional TLB flush/MMU sync */
-	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
-	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
+	}
 }
 
 static void nested_svm_exit_tlb_flush(struct kvm_vcpu *vcpu)
@@ -747,9 +749,6 @@ static void nested_svm_exit_tlb_flush(struct kvm_vcpu *vcpu)
 
 	if (svm->asid == svm->nested.asid02)
 		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
-
-	kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
-	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 }
 
 /*
@@ -1566,7 +1565,20 @@ int svm_allocate_nested(struct vcpu_svm *svm)
 	svm->nested.vmcb02.ptr = page_address(vmcb02_page);
 	svm->nested.vmcb02.pa = __sme_set(page_to_pfn(vmcb02_page) << PAGE_SHIFT);
 
-	svm->nested.asid02 = svm->asid;
+	svm->nested.asid02 = allocate_asid(&svm->vcpu);
+
+	/*
+	 * KVM uses a fallback ASID when out of ASIDs, and fails vCPU creation
+	 * if there's no fallback ASID. ASID allocation must succeed here.
+	 */
+	KVM_BUG_ON(!svm->nested.asid02, svm->vcpu.kvm);
+
+	/*
+	 * Clear last_asid to ensure that the ASID is flushed on the first
+	 * nested VM-Enter. Otherwise, stale TLB entries from a previous life of
+	 * the ASID (e.g. different vCPU or even different VM) could be used.
+	 */
+	svm->nested.last_asid = 0;
 
 	return 0;
 
@@ -1583,6 +1595,8 @@ void svm_free_nested(struct vcpu_svm *svm)
 	if (WARN_ON_ONCE(svm->vmcb != svm->vmcb01.ptr))
 		svm_switch_vmcb(svm, &svm->vmcb01);
 
+	free_asid(svm->nested.asid02);
+
 	svm_vcpu_free_msrpm(svm->nested.msrpm);
 	svm->nested.msrpm = NULL;
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index b2e6acfbb081f..646108e70e21a 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2043,10 +2043,12 @@ static void sev_vcpu_migrate_asid(struct vcpu_svm *dst_svm,
 	dst_svm->asid = asid;
 
 	/*
-	 * If nested is already initialized on the destination vCPU, also update
-	 * the nested ASID to match the new SEV ASID.
+	 * If nested is already initialized on the destination vCPU, also free
+	 * the previous ASID (in case it was non-SEV) and update the nested ASID
+	 * to match the new SEV ASID.
 	 */
 	if (dst_svm->nested.vmcb02.ptr) {
+		free_asid(dst_svm->nested.asid02);
 		dst_svm->nested.asid02 = asid;
 		dst_svm->nested.vmcb02.ptr->control.asid = asid;
 	}
-- 
2.56.0.385.gd3acb90ef8-goog

