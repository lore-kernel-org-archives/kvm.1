Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DC1391835;
	Wed, 22 Apr 2026 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776880211; cv=none; b=ErRb3GFVR8ffgzdzcBAsWRpF8LLhEByPpFOfqv3kEyIGnkRJk3xm2X7h6v+jIWMk72AQ5f/hgUljGnk8wKhCwqNyofkxNlMYGRZYWAz3DvvNcDW3j94EebXPzEurJuSOgDmedKwP9ukysl9XWFjk080iID98+PTkx+C+HIqkxbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776880211; c=relaxed/simple;
	bh=RcfdQiLFf9M3i/IP00/idYyj9IgwJ1oxZGyHNU1I+50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lFISvbHsYep5TZW5+sfGKPsQ4VbDkKX7on17pTqFWdL3TQSAcKerXguQp1LMH+/W2VxIqdEPOKWDipu9NIo9EYuo00dKK0uuuug+ez++nQQxZOuV/I1V7ZHs6of6dNutLDlMovTBE8IOG/N2dPTpZuXOQyDoGLp9Z7rwpHqvBBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=IhWbqnnB; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IhWbqnnB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=KJx43tBTqhlaiRDdxuTnqGFSnvf9IAGPT6zRmvq6y+A=; b=IhWbqnnB1jm4
	x0Z6N+RFvw574zG82nd/whe1vh1o5pOcdMhsdJ5ol+8dwUJNbXYjU8lq6cw7+/xn7FK/xC+rJIQTC
	6ApeLFqitvd5i3zkfEdPlNR/AslCzbXbiLT4cMFD0sL81qaQaRtCzKNfhrctLZyflzeJmgl+WxhBm
	oJRmwoY+4LujM3zZndlpXFBn7GV+bOZDgKxe9r5me3fYTh0ahTjWHDnAWkQdLks6+lGv1OyfDyAwi
	V74tFG9YNgXGkl67FgpPecR8YgxFJvVJnvT3d9kzwDe0n0daDzQZhfr/XkNo19RSaKdT4xFWVSfw7
	tWFgvySGI593iJ47cOOqtA==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.vzint.dev)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1wFbfQ-004KQw-0N;
	Wed, 22 Apr 2026 19:49:59 +0200
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
Subject: [RFC PATCH 0/1] KVM: VMX: restore host CR2 after VM exit
Date: Wed, 22 Apr 2026 19:49:59 +0200
Message-ID: <20260422175000.1544258-1-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this is an RFC for a small change to arch/x86/kvm/vmx/vmx.c that
restores the host CR2 register after every VM exit, overwriting the
guest's CR2 value that Intel VMX intentionally leaves in the hardware
register.


Where we first saw the problem:

The panic that triggered this investigation was not observed on a
mainline kernel.  It came from a RHEL9-based downstream Virtuozzo
kernel running a nested KVM workload: the host where the panic
happened is itself an L1 KVM guest of an outer hypervisor, and it runs
its own L2 KVM guests on top.

In the crash dump, four cascading kernel #PF oopses all reported the
same CR2 value, while the instructions at the reported faulting RIPs
could not have produced that fault:

  add $0x8,%rsp          (no memory access at all)
  lea ...,%r12           (no memory access at all)
  mov %rax,0x10(%rsp)    (write to local stack, not to the reported CR2)
  mov %rax,(%rbp)        (write to local stack, not to the reported CR2)

All four oopses happened inside the L1 host itself: the original fault
plus three further faults taken inside the oops-reporting code
(dump_pagetable() -> copy_from_kernel_nofault(), vt_console_print() ->
lf(), vsnprintf() in the "Modules linked in" path).
They are not extra levels of guest nesting; the nesting stack in this
setup is just two deep (outer hypervisor, then this L1 host running its
own L2 guests).

The reported CR2 did not correspond to any register or operand in the
surrounding code, but it had the form of a kernel virtual address
belonging to an inner KVM guest that had run on that CPU.

That matched the well-known property of VMX: after a VM exit, the
hardware CR2 register still holds the guest's CR2 - KVM only copies it
into vcpu->arch.cr2, it does not restore the host value.  In a real #PF
the CPU would overwrite CR2 with the new faulting address; the fact that
CR2 stays the same across all four oopses indicates that at least three
of them reached the #PF reporting path without the CPU having actually
updated CR2.


Why this mattered in practice:

What actually panicked this L1 host kernel was not the original fault
on its own - in isolation it would most likely have been a single,
locally contained oops.  The fatal part was that the oops reporter
itself tripped over a CR2 pointing into L2-guest memory:
show_fault_info() / dump_pagetable() treated the stale guest CR2 as a
host faulting address and walked the L1 host's page tables for it,
which raised further #PFs inside the reporting code and escalated a
would-be local oops into a full panic of this L1 host.  On top of
that, every oops header in the log carried that same guest-derived
CR2, which makes this class of crashes effectively undiagnosable from
the dump alone - the "faulting address" printed next to the RIP has
nothing to do with what the RIP was actually doing.  Restoring the
host CR2 after VM exit removes both effects at the source.


Why this is an RFC rather than a straight PATCH:

The mechanical fact (VMX leaves the guest CR2 in the hardware register
after VM exit, and the rest of the kernel treats CR2 as "address of
the last host #PF") is easy to verify from the source.  What I cannot
pin down from that one dump is which exact delivery path brought a #PF
handler into play with the CPU not having updated CR2 on that run.
The plausible candidates include:

  - corner cases of outer-hypervisor event injection into this host;
  - NMI/MCE entries racing with oops reporting;
  - crash/__show_regs() invoked from contexts other than a freshly
    taken #PF, where die()/oops code reads CR2 as if it were fresh.

All of these stop mattering the moment the host CR2 stops being a
guest-controlled value after a VM exit.  The patch targets the
weakest link directly: the "CR2 on the host == address of the last
host #PF" invariant should hold across VM entry/exit on VMX, and
today it does not.

AMD SVM does not need this patch because CR2 lives in the VMCB save area
and the CPU handles host/guest CR2 automatically; KVM's SVM code only
ever touches svm->vmcb->save.cr2.  I am happy to add a brief comment to
that effect in svm.c if it would help prevent a similar "optimization"
from being introduced there.


Verification against mainline:

To make sure the issue is not already fixed somewhere in mainline, I
checked the current:

  v7.0-12635-g6596a02b20788  (base-commit of this patch)

In arch/x86/kvm/vmx/vmx.c::vmx_vcpu_enter_exit(), the code still
reads:

        if (vcpu->arch.cr2 != native_read_cr2())
                native_write_cr2(vcpu->arch.cr2);

        vmx->fail = __vmx_vcpu_run(vmx, ...);

        vcpu->arch.cr2 = native_read_cr2();
        /* host CR2 is not restored */

A full-tree search confirms that vmx_vcpu_enter_exit() is the only
place in arch/x86/kvm/vmx that touches the hardware CR2 register:
vmenter.S does not touch it, and arch/x86/kvm/svm never accesses it.
So the same latent behaviour is present in mainline, regardless of
whether this exact crash has been reported against a mainline kernel.


Patch properties:

  - Hot path impact: one extra register compare in the common case,
    one extra MOV to CR2 under unlikely() when the guest modified CR2.

  - Stays within the existing noinstr region.  native_read_cr2() and
    native_write_cr2() are plain inline asm with no instrumentation,
    so noinstr constraints are preserved.

  - Not a security fix for a user-triggerable issue per se, but it
    removes a class of confusing "kernel CR2 points into guest memory"
    oops reports and hardens the CR2 invariant for the whole kernel.

Thanks,
Konstantin

Konstantin Khorenko (1):
  KVM: VMX: restore host CR2 after VM exit

 arch/x86/kvm/vmx/vmx.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)


base-commit: 6596a02b207886e9e00bb0161c7fd59fea53c081
-- 
2.43.0

