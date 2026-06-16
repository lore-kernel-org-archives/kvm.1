Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B7233BBD0;
	Tue, 16 Jun 2026 00:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570554; cv=none; b=RpeUJLZasuBu5v4Spx6Zy63kpWl4+NF1EX96aKmVuM2H0IhopUWG+4Lr5oSucCylv9khxJXeYHQ2rmkO8wLFRM/c3TeNoQPLeTAxOBBu7n9cFZDSjqJEUc5FPz1gkXo1gEhOzwmCpmrfdhGOEeAavZWRmhyDt9gyuRjiT93/FWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570554; c=relaxed/simple;
	bh=08N2zW+YGr8DxCzNzA2tF2mk+fGdSr/rAXVDCFUCmwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwbY7ts617KKZVbm2s0C5KQ58UVTreCzO9LxAN5PqqbMasNnr61bRqXU+KBOgU+LH7qJtLK6zLqvyAAksrajllM/sADXuI38fo7u8cdau6x6q+ChYP4PRWIv6nRKqcuR2r7gGWpk66joUMS0C6KciOXMYCvyj+AwLfPPKDPxGUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXF5vo4d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXF5vo4d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8391F00AC4;
	Tue, 16 Jun 2026 00:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570553;
	bh=feX3t7Dt1NDncJGPUVVFgzIqi8vXiXAY5vFNLkLDLlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CXF5vo4dgcf1tAGIImOXQuoVhA8VC9jtDfp6mSrYq/6vP56RHg73jLkpodEK2BOFK
	 H1iIOPSnVGyDC5ddPdxMZizN3ejuQwM7HUI1ZTOmH/ZwFH9TrPB/49RaLc4lcIu/mf
	 k6NVT70CNWLRte8ADvYUQJkNZTaimJkU/DB+C2gxNCOc+RxeUhwOSxYuD18OL10yax
	 zCgbTKKanQIhzle2uF+CPjJvHWykhtMPeeBUS6R5RO+ssIB8iASzXwHqQtT1+wHCKw
	 sb0XQ+LK8T1zn6X/CKUpiWd9iywaejMhDSq9MbRmY9uL/DrjADPmEzOpnbqfnfppQf
	 cr+uivvYzOmfg==
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
Subject: [RFC PATCH v2 23/25] KVM: nSVM: Flush L2's ASID when emulating INVLPGA
Date: Tue, 16 Jun 2026 00:41:52 +0000
Message-ID: <20260616004155.1435766-24-yosry@kernel.org>
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
 arch/x86/include/asm/kvm_host.h |  3 +++
 arch/x86/kvm/mmu/mmu.c          |  8 ++++---
 arch/x86/kvm/svm/svm.c          | 38 +++++++++++++++++++++++++++++++--
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3886b536c8a57..ee83dd4a56712 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2385,7 +2385,10 @@ static inline void kvm_dec_apicv_irq_window_req(struct kvm *kvm)
 int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 error_code,
 		       void *insn, int insn_len);
 void kvm_mmu_print_sptes(struct kvm_vcpu *vcpu, gpa_t gpa, const char *msg);
+void __kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva, bool flush_gva);
 void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva);
+void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
+			       u64 addr, unsigned long roots, bool flush_gva);
 void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 			     u64 addr, unsigned long roots);
 void kvm_mmu_invpcid_gva(struct kvm_vcpu *vcpu, gva_t gva, unsigned long pcid);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 3feb75732f7b4..b55c2fa2b388b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6615,8 +6615,8 @@ static void kvm_mmu_invalidate_addr_in_root(struct kvm_vcpu *vcpu,
 	write_unlock(&vcpu->kvm->mmu_lock);
 }
 
-static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
-				      u64 addr, unsigned long roots, bool flush_gva)
+void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
+			       u64 addr, unsigned long roots, bool flush_gva)
 {
 	int i;
 
@@ -6642,6 +6642,7 @@ static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu
 			kvm_mmu_invalidate_addr_in_root(vcpu, mmu, addr, mmu->prev_roots[i].hpa);
 	}
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_mmu_invalidate_addr);
 
 void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 			       u64 addr, unsigned long roots)
@@ -6650,7 +6651,7 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_invalidate_addr);
 
-static void __kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva, bool flush_gva)
+void __kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva, bool flush_gva)
 {
 	/*
 	 * INVLPG is required to invalidate any global mappings for the VA,
@@ -6666,6 +6667,7 @@ static void __kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva, bool flush_gva)
 				  KVM_MMU_ROOTS_ALL, flush_gva);
 	++vcpu->stat.invlpg;
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_mmu_invlpg);
 
 void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva)
 {
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 87f82ae51e8b1..bc5a1cff04647 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2404,17 +2404,51 @@ static int clgi_interception(struct kvm_vcpu *vcpu)
 
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
+	 * assumethe same behavior from INVLPGA since the APM doesn't specify.
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
+	 * ASID is non-zero (i.e. L1 is not flushing it's own ASID), skip
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
2.54.0.1136.gdb2ca164c4-goog

