Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339B539184C;
	Wed, 22 Apr 2026 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776880212; cv=none; b=oH83rWXkD44/vhyd40CWQjigENseJD7PJbfhofPu4uIu9wzqZU9dVy4uLSDFPnhGRHk+Vc0HG2faDqYhy10m6TjsLhythhhqOJd8x4L+U2k/6hBmK1hrBcfqQiX9UBGx3f7kIzSbbzwFEmwHiGwf5Dgp0n4MJ4SM+4KyiB8WvhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776880212; c=relaxed/simple;
	bh=b9XRXh5k9/zsttfo5zzzCoU+uzUIP41798k0kJAQECo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHLUkWIaN0C608UhXng6U3/mupuYtY01RmR7i73uIzvdom6oSSR4kDjjuTE1q/RLMzx8vPl2NJ4fWBePsL8DAcyPvaxdSusowmZrZui9LsHu5clSRyFMgx4j0X5QneKIIHqdsL/OQurfKPYmEGYCykguNWxGFAUyE1qGuOfa+/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=OAwei166; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OAwei166"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=t1I9cTfl5nUY0ImgwPNBuZFoTfUYggsb+7YdOc9cqtU=; b=OAwei166U6SF
	HKsuCOpLVDEYnDuJ4+yssEac7TW0fDbAD3aK5SxwUSryyE/agChyjVMvp8Bsmq0Au0OHZD9AFKsW8
	bSsKpiYwTeMUSQVSmrCvkua14qP4Fv9EwxCXw6b8yIK4LnSwGmINoCjIYtXiJ6e2mYIQFD+8oVyAd
	5ghLnCwIdj3iBtw7ibwavQNu3DlgW88NxGQBXHgkYIEKwAKWE5baSwCYcR/sDZ+lysF8loyA8BynR
	02i6t9nt5/UxuekrcALyTVBBMfpLxUsbN12Ch4NvJgktPJoKd8FAqW265H1Aq4/HAbXA+K6X/ZbXw
	WnVrDbOokUMXbJsfv3YpkA==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.vzint.dev)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1wFbfQ-004KQw-1s;
	Wed, 22 Apr 2026 19:50:00 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: [RFC PATCH 1/1] KVM: VMX: restore host CR2 after VM exit
Date: Wed, 22 Apr 2026 19:50:00 +0200
Message-ID: <20260422175000.1544258-2-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422175000.1544258-1-khorenko@virtuozzo.com>
References: <20260422175000.1544258-1-khorenko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Intel VMX, CR2 is not part of the VMCS guest/host state area.  The
CPU does not save or restore it automatically across VM transitions,
so KVM manages it in software: before VM entry it writes vcpu->arch.cr2
into the hardware register if it differs from the current value, and
after VM exit it reads the hardware register back into vcpu->arch.cr2.

The host CR2 is intentionally left clobbered by the guest after VM
exit, as an optimization: the expectation is that the next host page
fault will overwrite it before anything else looks at it.

That expectation is fragile.  The rest of the kernel treats CR2 as an
invariant.
 -  exc_page_fault() reads it at the very start of #PF handling, before
    any instruction could have updated it.
 -  __show_regs() reads and prints it from die()/oops/crash paths.

Any flow that reaches a #PF handler, or that reads CR2 in an oops or
crash context, without the CPU having just taken a real host #PF, will
observe the guest's CR2 instead of the host's.

On nested setups the stale guest CR2 left in the hardware register
has the form of a kernel virtual address in the inner guest's address
space, which overlaps 1:1 with the outer-guest kernel layout.  That
makes the stale value visually indistinguishable from a plausible
outer-guest fault address, which can lead to confusing oops reports
whose CR2 has no relation to the reported faulting RIP.

Fix: save the host CR2 before VM entry into a local variable.  After
VM exit, compare the already-read vcpu->arch.cr2 against the saved
host value, and write the host CR2 back if the guest modified it.
In the common case where the guest did not touch CR2 this is a single
register compare with no write; the restore is placed under unlikely()
because most VM-entry/exit cycles do not involve a guest CR2 write.
The change stays within the existing noinstr region;
native_read_cr2()/native_write_cr2() are plain inline asm with no
instrumentation.

This brings VMX in line with the CR2 invariant the rest of the kernel
already relies on.

AMD SVM is not affected.  On SVM, CR2 is part of the VMCB save area
and the CPU saves and restores host and guest CR2 automatically on
VMRUN and #VMEXIT.  KVM's SVM code only accesses svm->vmcb->save.cr2
and never touches the hardware CR2 register.

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 arch/x86/kvm/vmx/vmx.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a29896a9ef145..dd441b90dfd4a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7458,6 +7458,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 					unsigned int flags)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	unsigned long host_cr2;
 
 	guest_state_enter_irqoff();
 
@@ -7465,13 +7466,25 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 
 	vmx_disable_fb_clear(vmx);
 
-	if (vcpu->arch.cr2 != native_read_cr2())
+	host_cr2 = native_read_cr2();
+	if (vcpu->arch.cr2 != host_cr2)
 		native_write_cr2(vcpu->arch.cr2);
 
 	vmx->fail = __vmx_vcpu_run(vmx, (unsigned long *)&vcpu->arch.regs,
 				   flags);
 
 	vcpu->arch.cr2 = native_read_cr2();
+
+	/*
+	 * Restore host CR2 if the guest modified it.  The rest of the
+	 * kernel relies on CR2 holding the address of the last host
+	 * #PF; leaving the guest value there can mislead any code path
+	 * that reads CR2 without the CPU having just taken a real host
+	 * #PF (exc_page_fault(), __show_regs() from oops/crash paths,
+	 * NMI/MCE report, nested-virt corner cases, etc.).
+	 */
+	if (unlikely(vcpu->arch.cr2 != host_cr2))
+		native_write_cr2(host_cr2);
 	vcpu->arch.regs_avail &= ~VMX_REGS_LAZY_LOAD_SET;
 
 	vmx->idt_vectoring_info = 0;
-- 
2.43.0

