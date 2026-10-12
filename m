Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4636F47D44B;
	Mon, 12 Oct 2026 23:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848219; cv=none; b=LJhS5xvXuStFD96ZJ4sm9V89BLZ+/Q9hBEURHZuIQclM/348Xzpzf8x4+3a3bNjff2Fza5SiyD/iSaXB+CpAQdoH+I1kLFSnq88NYYubRVJdZCg1t3GjSr1g9Mvj/gv3/Oj+nduD1QVY+VTWbvAoK+lXyxfI2f/srv4IzVw4hqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848219; c=relaxed/simple;
	bh=VlCUKtQrwilUiGVi4+KYqIBgEdcw5ADTn6ijtb9H9lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enlB2SoWCqlwingYybYSCuY7mk8jNN139WRx9PgEmCyDsUZzHB86dmsoDhWafFIyRRRqI0zzCaMbxxMAtas5slXzAOwoDz1NowaDbTC1ebyp97XjJKTBMvA0rgWYlO9nqMJ3kLBnUpoUh+La+lyoNkugogXctyAeCWZI2NbCDpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdU9hPRi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdU9hPRi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8571F008A3;
	Mon, 12 Oct 2026 23:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848218;
	bh=QWiUdzbUzhqde9+5a+CQl4bbW9lyaKXw2EHkNRQcgko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cdU9hPRikSx4GBf8cOIGkG37DIAcxoYF/LwQvBqPFthWSVR4fSi/DUdJp27llAN/J
	 ijUXUBF3WV3ZBa7qCZ0Z9i9FSpdb3KNX9we+K0GXPcIItCbqiZ+Y5ac59gdo+z6zEP
	 2s6oLVeacapHA+6lS5MyP740UIfr3j1sQDSZg4D9VSskSeAHD0NMAPiGOUvumStDH/
	 HzTVdtdfI5cGqGRC9JMwymxVMijyUfv1ImO8sUhd64+la3oz/QsfqV4yekDZ2WeNLv
	 wGHLW3AbbKnOUdMyNEWYWFk4CG8QTOYZkdPg5w8E6j+1Dm81Xghp1WJzB5VcxrayNL
	 OYOolU8T0rqsg==
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
Subject: [PATCH v3 24/27] KVM: nSVM: Flush L2's ASID when emulating INVLPGA
Date: Mon, 12 Oct 2026 23:36:35 +0000
Message-ID: <20261012233638.2546339-25-yosry@kernel.org>
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

KVM currently handles INVLPGA in the same way as INVLPG, flushing L1's
own ASID. This is currently correct because L1 and L2 share an ASID, but
it doesn't work once they have separate ASIDs.

If L1 is flushing a different L2 ASID than the one KVM is tracking, do
nothing, as KVM will flush L2's ASID in hardware (and sync the MMU if
needed) when L1 switches to the target ASID.

If L1 is flushing the tracked L2 ASID, flush the L2 ASID in hardware
using INVLPGA if running on the same CPU as L2. If not, fallback to a
VMCB-based ASID flush. Note that if L2 then runs on a different CPU KVM
will flush the ASID anyway.

If NPT is disabled, also free L2's roots, as they may have stale
translations for the flushed address. Do not try to sync the mappings
for the flushed address as it involves walking L2's shadow page tables
with L1's MMU context. This is similar to INVVPID handling in with nVMX.

Note: If L1 is flushing its own ASID, it remains handled the same way as
INVLPG. Additionally, if INVLPGA is executed by L2 (and not intercepted
by L1), also handle it like INVLPG. Technically, L2 could be flushing an
untracked ASID, in which case KVM doesn't need to do anything. However,
kvm_mmu_free_guest_mode_roots() does not handle being invoked in guest
mode, so using kvm_mmu_invlpg() in guest mode side-steps this, and
should not happen with a well-behaved L1 anyway.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/svm.c | 48 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 8f2542357e78d..436d13f106369 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2468,17 +2468,61 @@ static int clgi_interception(struct kvm_vcpu *vcpu)
 
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
+	 * If L1 is flushing its own ASID, handle it like INVLPG. Do the same if
+	 * this is an unintercepted INVLPGA from L2, as
+	 * kvm_mmu_free_guest_mode_roots() does not handle being in guest mode.
+	 */
+	if (!asid || is_guest_mode(vcpu)) {
+		kvm_mmu_invlpg(vcpu, gva);
+		return kvm_skip_emulated_instruction(vcpu);
+	}
+
+	/*
+	 * Do nothing if L1 is flushing a different L2 ASID than the one KVM is
+	 * currently tracking.  KVM tracks a single L2 ASID, and performs a TLB
+	 * flush (and MMU resync if needed) when L1 switches ASIDs anyway.
+	 */
+	if (asid != svm->nested.last_asid)
+		return kvm_skip_emulated_instruction(vcpu);
+
+	/*
+	 * Use INVLPGA to flush L2's ASID in hardware if running on the same
+	 * CPU, otherwise fallback to a full ASID flush.
+	 */
+	cpu = get_cpu();
+	if (cpu == svm->nested.vmcb02.cpu)
+		invlpga(gva, svm->nested.asid02);
+	else
+		vmcb_set_flush_asid(svm->nested.vmcb02.ptr);
+	put_cpu();
+
+	/*
+	 * If NPT is disabled, free L2's shadow roots as they may have stale
+	 * translations for the flushed address. Do not sync the mappings for
+	 * the flushed address, as it involves walking L2 shadow page tables
+	 * with L1's MMU context.
+	 */
+	if (!npt_enabled)
+		kvm_mmu_free_guest_mode_roots(vcpu->kvm, &vcpu->arch.root_mmu);
 
 	return kvm_skip_emulated_instruction(vcpu);
 }
-- 
2.56.0.385.gd3acb90ef8-goog

