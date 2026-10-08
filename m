Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC3A37F8DB;
	Thu,  8 Oct 2026 00:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418493; cv=none; b=OcXQZAexhgRs8A8hNUKg3AGSvKhWoUl1C4r5Gc+wzTxnMnoMR72MBH6XVizuCq8s7IzaIuLkeUGgplqW+tBNZSDoJc1lXjDuYDnL7mb9KcmkujYVdY/iiXpTQF+zsuakLnpKQfYnnI/k4zBR4zLWtB3Z5BAwJEOuDX9tFL9g/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418493; c=relaxed/simple;
	bh=n+VwIJlfaXVA1VJdLjDmfLYB/2jjRMWX9K/dlQAr1dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7eEx+Zx+KANFIKIQs0cNsbFihwvIKWjzhuZgwDLfPqD0Ur9OHwpnJeEnxsWEJ2KfXQ86kjcPYa2BJuIVJGTJwFV2hvshjUc/gJ4kUXbIuXPopH873rgCXYaKoUptfd0YjLiefL1Zmfz5iwjs74MBz/xIMOW2BLQSVjrGURZlfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kC3t8kAq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kC3t8kAq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668021F00899;
	Thu,  8 Oct 2026 00:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791418491;
	bh=vLSL0M3y/CCYJEV7fAuJoY5xJYYnpOcXZZye/tvJJZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kC3t8kAqoJrEmej2SR4TR2Xhl1KkQsBXHm0q3fG+wZk/L0tSKYTc4NVqMYejm3oO6
	 BetFe8zYJHTDvkjpecWui9sMxOIU4NG2bYxZqGVHlI3+D5dISDLAaN4i1HsiC7YHxg
	 CPcm7Fwk8MV9w4o8EfYQnpVpw1rzYMg+Ho2Pf4r9aausr0p/bdJ6NTGdh6s0bSTj0s
	 w94FuoNoK3cckeGrmezHgc3l1YDD094/loxTR9rVvodiskUp6lUtL4rCk/piaNXHf8
	 hb6H5RUoazOMPfWxPIOzRobKnz6kFINXpwGLIVLR3brROf0tFdwu8Ivt8NG82fJV+f
	 dXANa1XKew+Zg==
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
Subject: [PATCH v2 26/29] KVM: nSVM: Flush L2's ASID when emulating INVLPGA
Date: Thu,  8 Oct 2026 00:14:22 +0000
Message-ID: <20261008001425.2458927-27-yosry@kernel.org>
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

KVM currently handles INVLPGA in the same way as INVLPG, flushing L1's
own ASID. This is currently correct because L1 and L2 share an ASID, but
it doesn't work once they have separate ASIDs.

If L1 is flushing a different L2 ASID than the one KVM is tracking, do
nothing, as KVM will flush L2's ASID in hardware (and sync the MMU if
needed) when L1 switches to the target ASID.

If L1 is flushing its own ASID, handle the flush the same as INVLPG.
Otherwise, skip the GVA flush for the current context (L1's ASID), and
flush the L2 ASID in hardware using INVLPGA if running on the same CPU
as L2. If not, fallback to a VMCB-based ASID flush. Note that if L2 then
runs on a different CPU KVM will flush the ASID anyway.

Either way, sync the MMU if NPT is disabled, which is handled by
__kvm_mmu_invlpg(). Note that all MMU roots are sync'd when NPT is
disabled, which can be optimized by keying off guest_mode to only sync
the appropriate context (L1 vs. L2).

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/mmu.h     |  3 +++
 arch/x86/kvm/mmu/mmu.c |  8 +++++---
 arch/x86/kvm/svm/svm.c | 38 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index b6ad0ff72393e..b5100f31f6a35 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -150,7 +150,10 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 error_code,
 		       void *insn, int insn_len);
 void kvm_mmu_print_sptes(struct kvm_vcpu *vcpu, gpa_t gpa, const char *msg);
+void __kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva, bool flush_gva);
 void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva);
+void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
+			       u64 addr, unsigned long roots, bool flush_gva);
 void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 			     u64 addr, unsigned long roots);
 void kvm_mmu_invpcid_gva(struct kvm_vcpu *vcpu, gva_t gva, unsigned long pcid);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 433ed69b1e1e4..bfc3dd08bedb0 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6769,8 +6769,8 @@ static void kvm_mmu_sync_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 	write_unlock(&vcpu->kvm->mmu_lock);
 }
 
-static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
-				      u64 addr, unsigned long roots, bool flush_gva)
+void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
+			       u64 addr, unsigned long roots, bool flush_gva)
 {
 	struct kvm_mmu *mmu;
 	int i;
@@ -6806,6 +6806,7 @@ static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk
 			kvm_mmu_sync_addr(vcpu, mmu, addr, mmu->prev_roots[i].hpa);
 	}
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_mmu_invalidate_addr);
 
 void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 			     u64 addr, unsigned long roots)
@@ -6814,7 +6815,7 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_invalidate_addr);
 
-static void __kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva, bool flush_gva)
+void __kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva, bool flush_gva)
 {
 	/*
 	 * INVLPG is required to invalidate any global mappings for the VA,
@@ -6830,6 +6831,7 @@ static void __kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva, bool flush_gva)
 				  KVM_MMU_ROOTS_ALL, flush_gva);
 	++vcpu->stat.invlpg;
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_mmu_invlpg);
 
 void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva)
 {
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index f37cba4f34c2b..4b95a05c37f60 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2468,17 +2468,51 @@ static int clgi_interception(struct kvm_vcpu *vcpu)
 
 static int invlpga_interception(struct kvm_vcpu *vcpu)
 {
+	struct vcpu_svm *svm = to_svm(vcpu);
 	/* FIXME: Handle an address size prefix. */
 	gva_t gva = kvm_rax_read(vcpu);
 	u32 asid = kvm_ecx_read(vcpu);
+	int cpu;
 
 	if (nested_svm_check_permissions(vcpu))
 		return 1;
 
 	trace_kvm_invlpga(to_svm(vcpu)->vmcb->save.rip, asid, gva);
 
-	/* Let's treat INVLPGA the same as INVLPG (can be optimized!) */
-	kvm_mmu_invlpg(vcpu, gva);
+	/*
+	 * INVLPG on a non-canonical address is a NOP according to the SDM,
+	 * assume the same behavior from INVLPGA since the APM doesn't specify.
+	 */
+	if (is_noncanonical_invlpg_address(gva, vcpu))
+		return kvm_skip_emulated_instruction(vcpu);
+
+	/*
+	 * Do nothing if L1 is flushing a different L2 ASID than the one KVM is
+	 * currently tracking.  KVM tracks a single L2 ASID, and performs a TLB
+	 * flush (and MMU resync if needed) when L1 switches ASIDs anyway.
+	 */
+	if (asid && asid != svm->nested.last_asid)
+		return kvm_skip_emulated_instruction(vcpu);
+
+	/*
+	 * Handle INVLPGA similar to INVLPG, with one caveat. If the specified
+	 * ASID is non-zero (i.e. L1 is not flushing its own ASID), skip
+	 * flushing the TLB for the current context (L1's), and use INVLPGA to
+	 * flush L2's ASID in hardware if running on the same CPU (otherwise
+	 * fallback to a full ASID flush).
+	 *
+	 * Note, if NPT is disabled, this will sync all the shadow page tables.
+	 * This can be optimized by keying off guest_mode.
+	 */
+	__kvm_mmu_invlpg(vcpu, gva, !asid);
+	if (asid) {
+		cpu = get_cpu();
+		if (cpu == svm->nested.vmcb02.cpu)
+			invlpga(gva, svm->nested.asid02);
+		else
+			vmcb_set_flush_asid(svm->nested.vmcb02.ptr);
+		put_cpu();
+	}
 
 	return kvm_skip_emulated_instruction(vcpu);
 }
-- 
2.56.0.360.g66cac248cb-goog

