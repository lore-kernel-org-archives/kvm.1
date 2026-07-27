Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE59C3DC850
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138817; cv=none; b=jvM2ucxF5Zbhb5poISVQHXCc+WXAphKXVs3g3F+6TKNKwpkZBuF1d1EbEKBRXn6bMSs3ejqe3DtG8FTQxoUpMNWk0O27ULI+/IzOcJ8vgB00oOW/TO0sW1ryZn7LeJnVpjYoJpxPqXZd6sseHpeJeIstYDZt12mqfGUaRGVvEuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138817; c=relaxed/simple;
	bh=E7Pm4pOgT9/FGSvVt/z3K7v9iZOQRnB7iAxp178p5EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNxxYBytE+BNiybtUMzkKSz7N2bOR8gXqVMFDArvTwEH2bla8UvUgJZwde98SPy5izunJ/5/VW9MqiQAcDywBq5Bw4PEFczensQhfMgLbwdQ3KGej8lLZx0Ab8YtE7A9NpNckHDu3JWuTVZggmPvhatICm2JgcR3rsJ6li5Eq3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Mf41hobB; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Mf41hobB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=YgMBvZrDjU7PPG+5S596XWGrQIaUG/ui/X8Jrpd+FHA=;
	b=Mf41hobBKgyyn5Y5+hOUz9z9G25cJQpEjZIUxhjMdSyXZA3tLqCqqvqIU3p19U
	Qb5eNylp/RpxmlMLu7Hs2lYalTvduX1d+nKUul1meVRMQ2hfnXjOr1K9g3PQ9K2l
	tYNVOqTjnlaPs0WQc39WWA0uSxWchN49lBMFWJNA97SjU=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCXXZNpDmdqpWdoLw--.45440S2;
	Mon, 27 Jul 2026 15:53:14 +0800 (CST)
Date: Mon, 27 Jul 2026 15:53:12 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Hao Zhang <hao_zhang_kdev@163.com>, Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Subject: Re: [PATCH v3] KVM: x86: Mark nested RSM-created VM-Enter as
 untrusted
Message-ID: <amcOaHsgnHjdhcsm@192.168.1.215>
References: <al8wZQwqC9IhlBZc@192.168.1.215>
 <al-SKXoha-dqz047@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <al-SKXoha-dqz047@google.com>
X-CM-TRANSID:_____wCXXZNpDmdqpWdoLw--.45440S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Cr48Ar1xuw47KFy5Xr1kXwb_yoWDWFyUpF
	Z7Aw1j9rW5JFy7X3s7Gr4vvFWSgrn3tr1jyr9xW34rAr4j9as3tF1xKrW5ZFW5CrWxWFyS
	va1jqFy5Cws0qrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pReMKtUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC+QoSBWpnDmpXWAAA3C

On Tue, Jul 21, 2026, Sean Christopherson wrote:
> On Tue, Jul 21, 2026, Hao Zhang wrote:
> > From: Hao Zhang <zhanghao1@kylinos.cn>
> > 
> > RSM can restore state that indicates the vCPU was running L2 when SMI
> > arrived.  KVM then re-enters nested guest mode and marks nested_run_pending
> > so that the next KVM_RUN completes the pending nested transition.
> > 
> > Unlike a normal nested VMLAUNCH/VMRESUME, the state restored by RSM comes
> > from SMRAM.  Userspace can modify SMRAM before RSM.  The resulting L2 state
> > may require invalid-guest-state emulation.  If KVM trusts that pending run,
> > VMX can synthesize EXIT_REASON_INVALID_STATE before hardware VM-Entry
> > completes the pending run and trip the nested_run_pending invariant.
> > 
> > Do not treat an RSM-created pending nested run as KVM-trusted state.  Mark
> > the run as KVM_NESTED_RUN_PENDING_UNTRUSTED for both VMX and SVM, matching
> > the existing userspace-modified-state handling in kvm_x86_vcpu_pre_run().
> > 
> > Keep the VMX BUG check for trusted pending nested VM-Enters, but allow
> > untrusted pending state to reach the existing invalid-L2-state handling.
> > If that handling synthesizes a nested VM-Exit back to L1, retain the
> > pending state while synchronizing VMCS02 to VMCS12, and consume it before
> > restoring L1 state so that the flag does not leak into L1 and block event
> > injection.
> > 
> > Fixes: 2bb8cafea80b ("KVM: vVMX: signal failure for nested VMEntry if emulation_required")
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
> > ---
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index cc75feec05da..cf5c3f78ebfc 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -6715,12 +6715,14 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
> >  		return 0;
> >  
> >  	/*
> > -	 * KVM should never reach this point with a pending nested VM-Enter.
> > -	 * More specifically, short-circuiting VM-Entry to emulate L2 due to
> > -	 * invalid guest state should never happen as that means KVM knowingly
> > -	 * allowed a nested VM-Enter with an invalid vmcs12.  More below.
> > -	 */
> > -	if (KVM_BUG_ON(vcpu->arch.nested_run_pending, vcpu->kvm))
> > +	 * KVM should never reach this point with a trusted pending nested
> > +	 * VM-Enter.  Short-circuiting VM-Entry to emulate L2 due to invalid
> > +	 * guest state after a normal nested VM-Enter would mean KVM knowingly
> > +	 * allowed an invalid vmcs12.  Pending VM-Enters restored from untrusted
> > +	 * state are handled below.
> > +	 */
> > +	if (KVM_BUG_ON(vcpu->arch.nested_run_pending == KVM_NESTED_RUN_PENDING,
> > +		       vcpu->kvm))
> 
> Ugh, I missed that my suggestion would require adjusting this KVM_BUG_ON().
> That's not the end of the world, but it's not great either because it further
> degrades the sanity checks provided by nested_run_pending.
> 
> And while Sashiko was hallucinating wildly with respect to a "mailicious L2
> modifying SMRAM", Sashiko did have a point about leaving nested_run_pending set
> beyond the emulated RSM.  KVM really should check for the impossible state after
> loading vCPU state from SMRAM in emulator_leave_smm(), so that forcibly leaving
> nested mode to synthesize TRIPLE_FAULT into L1 naturally Just Works.
> 
> The only reason I didn't suggest that is because I didn't want to add another
> SMM-specific kvm_x86_ops hook, but I think we can avoid that and (arguably)
> improve other paths at the same time.
> 
> Rather than provide a generic .vcpu_pre_run() hook, which is somewhat confusing
> because SVM has it's own pre_svm_run(), what if we provide separate hooks for
> unhandleable_emulation_required() and vcpu_needs_initialization()?  That bleeds
> some vendor specific details into common x86, but in many ways, that's a _good_
> thing in this case because I think it's helpful to highlight the need for
> additional initialization for CoCo vCPUs.
> 
> Do you happen to have a reproducer I can test?  Either way, I'll try to add a
> testcase to tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c to
> cover the SMRAM => RSM path.
>

I tried to capture your suggestion in a KVM selftest that covers the RSM
path directly.

The test extends vmx_invalid_nested_guest_state.c by entering SMM after L2
has run, corrupting the 64-bit SMRAM image for TR, and then executing RSM.
This makes KVM attempt to resume L2 with invalid guest state restored from
SMRAM.

On an unfixed kernel, the test fails in the new RSM path with KVM_RUN
returning -EIO.

Please let me know if this matches what you had in mind, or if you would
prefer the coverage to be structured differently.

---
diff --git a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
index a2eaceed9ad5..c48cab25a534 100644
--- a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
+++ b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
@@ -2,6 +2,7 @@
 #include "test_util.h"
 #include "kvm_util.h"
 #include "processor.h"
+#include "smm.h"
 #include "vmx.h"

 #include <string.h>
@@ -10,9 +11,37 @@
 #include "kselftest.h"

 #define ARBITRARY_IO_PORT 0x2000
+#define SMRAM_GPA	0x1000000
+#define SMRAM_STAGE	0xfe
+#define SYNC_PORT	0xe
+
+/*
+ * The 64-bit SMRAM state-save area starts at SMBASE + 0xfe00.  TR starts at
+ * offset 0xfe90, and attributes is the second 16-bit field in the descriptor.
+ */
+#define SMRAM64_TR_ATTRIBUTES_OFFSET	0xfe92
+
+#define STR(x) #x
+#define XSTR(s) STR(s)

 static struct kvm_vm *vm;

+/*
+ * SMI handler: runs in real-address mode, reports SMRAM_STAGE via port I/O,
+ * then executes RSM.
+ */
+static u8 smi_handler[] = {
+	0xb0, SMRAM_STAGE,	/* mov $SMRAM_STAGE, %al */
+	0xe4, SYNC_PORT,	/* in $SYNC_PORT, %al */
+	0x0f, 0xaa,		/* rsm */
+};
+
+static inline void sync_with_host(u64 phase)
+{
+	asm volatile("in $" XSTR(SYNC_PORT) ", %%al\n"
+		     : "+a" (phase));
+}
+
 static void l2_guest_code(void)
 {
 	/*
@@ -21,6 +50,8 @@ static void l2_guest_code(void)
 	 */
 	asm volatile("inb %%dx, %%al"
 		     : : [port] "d" (ARBITRARY_IO_PORT) : "rax");
+
+	sync_with_host(1);
 }

 static void l1_guest_code(struct vmx_pages *vmx_pages)
@@ -50,25 +81,20 @@ static void l1_guest_code(struct vmx_pages *vmx_pages)
 	GUEST_DONE();
 }

-int main(int argc, char *argv[])
+static void setup_vmx_guest(struct kvm_vcpu **vcpu)
 {
 	gva_t vmx_pages_gva;
-	struct kvm_sregs sregs;
-	struct kvm_vcpu *vcpu;
-	struct kvm_run *run;
-	struct ucall uc;

-	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
-
-	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+	vm = vm_create_with_one_vcpu(vcpu, l1_guest_code);

 	/* Allocate VMX pages and shared descriptors (vmx_pages). */
 	vcpu_alloc_vmx(vm, &vmx_pages_gva);
-	vcpu_args_set(vcpu, 1, vmx_pages_gva);
-
-	vcpu_run(vcpu);
+	vcpu_args_set(*vcpu, 1, vmx_pages_gva);
+}

-	run = vcpu->run;
+static void assert_l2_io_exit(struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *run = vcpu->run;

 	/*
 	 * The first exit to L0 userspace should be an I/O access from L2.
@@ -79,9 +105,34 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(run->io.port == ARBITRARY_IO_PORT,
 		    "Expected IN from port %d from L2, got port %d",
 		    ARBITRARY_IO_PORT, run->io.port);
+}
+
+static void assert_ucall_done(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_DONE:
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+	default:
+		TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
+	}
+}
+
+static void run_set_sregs_invalid_guest_state(void)
+{
+	struct kvm_sregs sregs;
+	struct kvm_vcpu *vcpu;
+
+	setup_vmx_guest(&vcpu);
+
+	vcpu_run(vcpu);
+	assert_l2_io_exit(vcpu);

 	/*
-	 * Stuff invalid guest state for L2 by making TR unusuable.  The next
+	 * Stuff invalid guest state for L2 by making TR unusable.  The next
 	 * KVM_RUN should induce a TRIPLE_FAULT in L2 as KVM doesn't support
 	 * emulating invalid guest state for L2.
 	 */
@@ -91,13 +142,71 @@ int main(int argc, char *argv[])
 	vcpu_sregs_set(vcpu, &sregs);

 	vcpu_run(vcpu);
+	assert_ucall_done(vcpu);

-	switch (get_ucall(vcpu, &uc)) {
-	case UCALL_DONE:
-		break;
-	case UCALL_ABORT:
-		REPORT_GUEST_ASSERT(uc);
-	default:
-		TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
-	}
+	kvm_vm_free(vm);
+}
+
+static void make_rsm_tr_unusable(struct kvm_vm *vm)
+{
+	u16 *tr_attrs = addr_gpa2hva(vm, SMRAM_GPA + SMRAM64_TR_ATTRIBUTES_OFFSET);
+
+	/*
+	 * In 64-bit SMRAM, segment attributes are enter_smm segment flags >> 8.
+	 * Clear P so that RSM restores TR as unusable, thereby making L2 guest
+	 * state invalid only after vmx_leave_smm() re-enters guest mode.
+	 */
+	*tr_attrs &= ~(1u << 7);
+}
+
+static void assert_io_stage(struct kvm_vcpu *vcpu, u8 expected)
+{
+	struct kvm_regs regs;
+	u8 stage;
+
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	vcpu_regs_get(vcpu, &regs);
+
+	stage = regs.rax & 0xff;
+	TEST_ASSERT(stage == expected, "Expected stage %#x, got %#x",
+		    expected, stage);
+}
+
+static void run_rsm_invalid_guest_state(void)
+{
+	struct kvm_vcpu *vcpu;
+
+	setup_vmx_guest(&vcpu);
+	setup_smram(vm, vcpu, SMRAM_GPA, smi_handler, sizeof(smi_handler));
+
+	vcpu_run(vcpu);
+	assert_l2_io_exit(vcpu);
+
+	/*
+	 * Inject SMI while L2 is running, then corrupt the SMRAM state-save
+	 * area so that RSM restores invalid L2 state.
+	 */
+	inject_smi(vcpu);
+
+	vcpu_run(vcpu);
+	assert_io_stage(vcpu, SMRAM_STAGE);
+
+	make_rsm_tr_unusable(vm);
+
+	vcpu_run(vcpu);
+	assert_ucall_done(vcpu);
+
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
+
+	run_set_sregs_invalid_guest_state();
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_SMM));
+
+	run_rsm_invalid_guest_state();
 }

base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
--

Thanks,
Hao

