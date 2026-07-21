Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB40D2D0C97
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623232; cv=none; b=p+O+zWiyKvDF6kSqpzo4uZU0KF3HHtEijt6aj02PrahAMBQzo5BcqvYxLIVDGMEjl7ZQBx+kjdCuXd4vLMpT8g/kXP4MxPZyLsLOpP+sePNvwvcfdTBTVM0xkSxYohlixCZXrUf7pynq9KwcyhcVjVl/X7atmc3D0enCMfK+iF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623232; c=relaxed/simple;
	bh=6Tj834dZmAxzKUo0CdkNNi8Rz6FFYxLSEcBJzDRv/0o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mD88DoY6jU0Y63+kypJ6sG/R2zUInM9lzRUzjwmiU7hd0Qtnmme3RN9v+jBEfX+9HdMyU8/IfRc7+3iLvinVcIlVXdxiY8CMmorP2gWV4Itu96JCPVkZSajswXOummMY9vpbuYVXnmNj7HrerDhsO/b+9cQVsN/CHGq9uqKdZKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oRQtvNwB; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oRQtvNwB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=26GRvKE5WuLLUiNuEuWJiqzX+/qZrRuWelBWUSW0UJQ=;
	b=oRQtvNwB11ogeOoqPXVNV5oFugERn5HjktwOyvF/DnJAUE0rGThCJ3v7ofyOYk
	0IiRpwI7lwLfFvpNw1V4EtWgyrqOP+4MxY1vutL6jhfBAyApv1iA31+VQ6FwzVJq
	TG9pxq1mykgzPeY9VeDkuunoCvDq/m/euEnsTmROETwhU=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD31YZmMF9qRz8YJg--.0S2;
	Tue, 21 Jul 2026 16:40:10 +0800 (CST)
Date: Tue, 21 Jul 2026 16:40:05 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v3] KVM: x86: Mark nested RSM-created VM-Enter as untrusted
Message-ID: <al8wZQwqC9IhlBZc@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-CM-TRANSID:_____wD31YZmMF9qRz8YJg--.0S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XryfKw4rCw4DGFy8GrW8Crg_yoW7GFy3pa
	9ayr4q9w4UGr9rJr97GF48Xry29rn5XF1jyrWkCa4rX3Wjgas7tr1xK3yqvay5CrWfu34S
	vF1Uur4j9w1rJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrqXQUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC3QqYi2pfMGo5lgAA3E

From: Hao Zhang <zhanghao1@kylinos.cn>

RSM can restore state that indicates the vCPU was running L2 when SMI
arrived.  KVM then re-enters nested guest mode and marks nested_run_pending
so that the next KVM_RUN completes the pending nested transition.

Unlike a normal nested VMLAUNCH/VMRESUME, the state restored by RSM comes
from SMRAM.  Userspace can modify SMRAM before RSM.  The resulting L2 state
may require invalid-guest-state emulation.  If KVM trusts that pending run,
VMX can synthesize EXIT_REASON_INVALID_STATE before hardware VM-Entry
completes the pending run and trip the nested_run_pending invariant.

Do not treat an RSM-created pending nested run as KVM-trusted state.  Mark
the run as KVM_NESTED_RUN_PENDING_UNTRUSTED for both VMX and SVM, matching
the existing userspace-modified-state handling in kvm_x86_vcpu_pre_run().

Keep the VMX BUG check for trusted pending nested VM-Enters, but allow
untrusted pending state to reach the existing invalid-L2-state handling.
If that handling synthesizes a nested VM-Exit back to L1, retain the
pending state while synchronizing VMCS02 to VMCS12, and consume it before
restoring L1 state so that the flag does not leak into L1 and block event
injection.

Fixes: 2bb8cafea80b ("KVM: vVMX: signal failure for nested VMEntry if emulation_required")
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
Changes in v3:
 - Retain KVM_NESTED_RUN_PENDING_UNTRUSTED until after
   sync_vmcs02_to_vmcs12(), to avoid saving VMCS12 fields that are valid
   only after L2 has actually run.
 - Clear the untrusted pending state before restoring L1 state to avoid
   leaking nested_run_pending into L1 and blocking event injection.
 - Clarify the VMX pending-run BUG comment and update the changelog.
 - Tested with the syzkaller repro on the fixed kernel, no WARNING/KVM_BUG
   in the repro log

Link to v2: https://lore.kernel.org/all/al8M4gCwsWXS_jMs@192.168.1.215/ 

 arch/x86/kvm/svm/svm.c    |  2 +-
 arch/x86/kvm/vmx/nested.c |  8 ++++++++
 arch/x86/kvm/vmx/vmx.c    | 16 +++++++++-------
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 4d2bacd00ec4..f54757bd8382 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5096,7 +5096,7 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 		goto unmap_save;
 
 	ret = 0;
-	vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING;
+	vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING_UNTRUSTED;
 
 unmap_save:
 	kvm_vcpu_unmap(vcpu, &map_save);
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 6957bb6f5cf7..e345b085a316 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5142,6 +5142,14 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 		WARN_ON_ONCE(warn_on_missed_cc);
 	}
 
+	/*
+	 * Untrusted pending VM-Enters may be canceled by untrusted state.  Keep
+	 * the flag set through sync_vmcs02_to_vmcs12() so that fields which are
+	 * updated only after L2 runs, e.g. the preemption timer, aren't saved.
+	 */
+	if (vcpu->arch.nested_run_pending == KVM_NESTED_RUN_PENDING_UNTRUSTED)
+		vcpu->arch.nested_run_pending = 0;
+
 	/*
 	 * Drop events/exceptions that were queued for re-injection to L2
 	 * (picked up via vmx_complete_interrupts()), as well as exceptions
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cc75feec05da..cf5c3f78ebfc 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6715,12 +6715,14 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 		return 0;
 
 	/*
-	 * KVM should never reach this point with a pending nested VM-Enter.
-	 * More specifically, short-circuiting VM-Entry to emulate L2 due to
-	 * invalid guest state should never happen as that means KVM knowingly
-	 * allowed a nested VM-Enter with an invalid vmcs12.  More below.
-	 */
-	if (KVM_BUG_ON(vcpu->arch.nested_run_pending, vcpu->kvm))
+	 * KVM should never reach this point with a trusted pending nested
+	 * VM-Enter.  Short-circuiting VM-Entry to emulate L2 due to invalid
+	 * guest state after a normal nested VM-Enter would mean KVM knowingly
+	 * allowed an invalid vmcs12.  Pending VM-Enters restored from untrusted
+	 * state are handled below.
+	 */
+	if (KVM_BUG_ON(vcpu->arch.nested_run_pending == KVM_NESTED_RUN_PENDING,
+		       vcpu->kvm))
 		return -EIO;
 
 	if (is_guest_mode(vcpu)) {
@@ -8436,7 +8438,7 @@ int vmx_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 		if (ret != NVMX_VMENTRY_SUCCESS)
 			return 1;
 
-		vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING;
+		vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING_UNTRUSTED;
 		vmx->nested.smm.guest_mode = false;
 	}
 	return 0;

base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
-- 
2.15.0

