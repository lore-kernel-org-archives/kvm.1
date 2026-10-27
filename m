Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128757;
	b=NJpaXF6RnC/KkGrV/F4Jg8peCOyw3Jt5rIV+nWUYJeNH0l8icMPqkgZ6Htn0bmnQEQh9
	 XZadfRBiaqX4xxLWlilC6xfcKtHYBHdRpjN3UJa1Nqb7ZS1NnMHLwd9Xt/xB25b5iM1nT
	 bPo2kPr8WnoOG1x35PQjJhgpC92fZuAi21hcrW9ZtFZpEw8VnqrH890naTLltOr0Nhd1j
	 /AoLOLF8F6itUUPxsBkOSmLDDULW6OEAaabaHR5jglIVhEKF9fxmKoF+94fGq0LmtXe6S
	 AecGe9+sERlQz1Lrx63BYgxLPLhZ6jufKsMzEZ8s7RuG9ixDQhcgv+/zaL/kLT3lPnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128757;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JW0YZqG1Np+CsPVJLjbAl6Vth3lXZA3H3X0YDZVM2iE=;
	b=tzujmzRq4K6xTP3RviyDLSXGfSxVyfS8It3Ry7tw/x+SiloCjoEJlQdTJFPKeBf7Ej1z
	 +r/NEDnB+tsdAOYJpxnWZX4EGiTnfofuo5vmPIz1lD1TWY+khhNeQswMQcvVLs4M5K+am
	 ja1d3EZFeMrztecV2dDRws1V0+2GHkpaGEDBCwAAbgJ07KbTpOSCUN/HIHV3wRkxxIDDg
	 D0Iub4UZSWu3glMvqkszcPn1ZOmTK95ZfxVXq7CwvHjO4kHoXDdEO1BPgQ4H2+bQVr2Yf
	 x8pLmbJshUySuWF65Km/UjrqpSwVn2r5o6VymTkvRfJYgnHZ0AZyUj78DLIqGFPk8sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nQZt5Ezh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E96606A31A;
	Tue, 27 Oct 2026 19:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nQZt5Ezh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33841F01825;
	Tue, 27 Oct 2026 19:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793128756;
	bh=JW0YZqG1Np+CsPVJLjbAl6Vth3lXZA3H3X0YDZVM2iE=;
	h=From:To:Cc:Subject:Date;
	b=nQZt5EzhB0eNy72pdF1v4r65NNuBvKhi4YYQyfs4BLOyiggvy8yJhV0uAG/ZJeMkz
	 jG+OpO5Yl6AOkLXuGjMefe7jt8dJ7WujarDqtpHw9BFB4B1OMipRtjObEfQf7F5g9w
	 ZBvjFaAnMpe+vHvqAn9L62wBc4bC98fhuGUV7s+pC4o0SfgKhX9SFT6tWooVh3R+aZ
	 nm7xfCiglfLCb+g0rUpnze2E2s6OPJQ6AFMJH3ovyvF1BkBA5rM5zipl4IZLR4HEY2
	 /f5GWDUXDPkuiMdUHr4J31jyNjWD5i7pquXSgTB57a+v44TTFuKlypJ26SOCWNsx5R
	 VMFDW4fZQGYNg==
From: Sasha Levin <sashal@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Kyle Zeng <kylebot@openai.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86: Don't reuse the GPA of a fault on the guest's page tables
Date: Tue, 27 Oct 2026 15:19:14 -0400
Message-ID: <20261027191914.2341911-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
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

When a #NPF or EPT violation leads to emulation, x86_emulate_instruction()
saves the faulting GPA for direct MMUs, and emulator_read_write_onepage()
uses it instead of walking the guest's page tables for an access whose
page offset matches.  If the fault occurred while the CPU was walking the
guest's page tables (PFERR_GUEST_PAGE_MASK), the GPA is that of a guest
paging structure, not of the access being emulated, and the access goes
to the wrong address.

KVM selftest set_memory_region_test runs into this on AMD.
test_delete_memory_region() deletes the memslot holding the guest's page
tables while the guest spins on a read of 0xc0000000 that userspace
handles as MMIO.  If the vCPU is at the read when the memslot goes away,
the CPU takes a #NPF on the guest's root page table at 0x180000.
DecodeAssist provides the instruction bytes, the read of 0xc0000000 has
the same page offset as 0x180000, and the emulator turns it into an MMIO
read of 0x180000:

  ==== Test Assertion Failure ====
    set_memory_region_test.c:83: run->mmio.phys_addr == MEM_REGION_GPA
    ...
    Unexpected exit mmio address = 0x180000

If the vCPU is at the next instruction instead, the #NPF happens on the
code fetch, DecodeAssist provides no bytes, KVM fails to fetch the
instruction itself and injects a #PF, and the guest shuts down as the
test expects.  KernelCI sees the failure in about half of the runs on a
DL345 Gen11 (EPYC).

The CPU walks the guest's page tables with write accesses, so such faults
also set EMULTYPE_PF_WRITE, and a write would be redirected the same way.

Tell the emulator when the fault occurred on the guest's page tables and
don't use the GPA for the access then, so that the access is translated
through the guest's page tables.  KVM can't walk the encrypted page tables
of SEV guests, so resume an SEV guest instead of emulating, as is done
when the #NPF occurred on the instruction fetch.

Fixes: 0f89b207b04a ("kvm: svm: Use the hardware provided GPA instead of page walk")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Reproduced on an HPE DL345 Gen11 (EPYC 9655P) with KernelCI's x86 build of
mainline d135ab453a74: set_memory_region_test failed in 15 of 30 runs, and
in 6 of 12 runs with tracing, always with the MMIO exit at 0x180000. The
traces show the #NPF at 0x180000 with error code 0x200000006 on the cmpq
that reads 0xc0000000, followed by an MMIO read of 0x180000.

With this patch on the same config, the test passed 50 of 50 runs. When
the #NPF hits the cmpq, KVM now injects a #PF for the read of 0xc0000000
and the guest shuts down. The rest of the KVM selftests give the same
results as without the patch, with and without
kvm.force_emulation_prefix=1. Not tested on SEV or Intel.

 arch/x86/kvm/mmu/mmu.c |  2 ++
 arch/x86/kvm/svm/svm.c |  9 +++++++++
 arch/x86/kvm/x86.c     | 10 ++++++++--
 arch/x86/kvm/x86.h     |  6 ++++++
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index dc2aef72ffddc..66e5365f63f20 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6719,6 +6719,8 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 emulate:
 	if (error_code & PFERR_WRITE_MASK)
 		emulation_type |= EMULTYPE_PF_WRITE;
+	if (error_code & PFERR_GUEST_PAGE_MASK)
+		emulation_type |= EMULTYPE_PF_GUEST_PAGE;
 
 	return x86_emulate_instruction(vcpu, cr2_or_gpa, emulation_type, insn,
 				       insn_len);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 136069dfcd44f..2240d122ceabc 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5324,6 +5324,15 @@ static int svm_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
 		return X86EMUL_PROPAGATE_FAULT;
 	}
 
+	/*
+	 * Don't emulate if the #NPF occurred while walking the guest's page
+	 * tables.  The GPA is that of a guest paging structure, not of the
+	 * access, and KVM can't walk the guest's encrypted page tables to
+	 * translate the access itself.  Resume the guest, see below.
+	 */
+	if (emul_type & EMULTYPE_PF_GUEST_PAGE)
+		goto resume_guest;
+
 	/*
 	 * Emulate for SEV guests if the insn buffer is not empty.  The buffer
 	 * will be empty if the DecodeAssist microcode cannot fetch bytes for
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32563a91fba99..c947c3096838a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6495,8 +6495,14 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		/* Save the faulting GPA (cr2) in the address field */
 		ctxt->exception.address = cr2_or_gpa;
 
-		/* With shadow page tables, cr2 contains a GVA or nGPA. */
-		if (vcpu->arch.mmu->root_role.direct) {
+		/*
+		 * With shadow page tables, cr2 contains a GVA or nGPA.  If the
+		 * fault occurred while walking the guest's page tables, the
+		 * GPA is that of a guest paging structure, not of the access
+		 * that needs to be emulated, and can't be used for the access.
+		 */
+		if (vcpu->arch.mmu->root_role.direct &&
+		    !(emulation_type & EMULTYPE_PF_GUEST_PAGE)) {
 			ctxt->gpa_access = ACC_READ_MASK;
 			/*
 			 * Always allow writes for guests with protected page
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 436e2fb1396c4..4d54e31133668 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -410,6 +410,11 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
  *
  * EMULTYPE_PF_WRITE - Set with EMULTYPE_PF when hardware reports a write access.
  *
+ * EMULTYPE_PF_GUEST_PAGE - Set with EMULTYPE_PF when hardware reports that the
+ *			    fault occurred while walking the guest's page
+ *			    tables, i.e. the GPA is that of a guest paging
+ *			    structure, not of the access being emulated.
+ *
  * EMULTYPE_COMPLETE_USER_EXIT - Set when the emulator should update interruptibility
  *				 state and inject single-step #DBs after skipping
  *				 an instruction (after completing userspace I/O).
@@ -449,6 +454,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 #define EMULTYPE_WRITE_PF_TO_SP	    (1 << 8)
 #define EMULTYPE_SKIP_SOFT_INT	    (1 << 9)
 #define EMULTYPE_PF_WRITE	    (1 << 10)
+#define EMULTYPE_PF_GUEST_PAGE	    (1 << 11)
 
 #define EMULTYPE_SET_SOFT_INT_VECTOR(v)	((u32)((v) & 0xff) << 16)
 #define EMULTYPE_GET_SOFT_INT_VECTOR(e)	(((e) >> 16) & 0xff)
-- 
2.53.0

