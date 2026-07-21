Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6D33264FF
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 06:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784614135; cv=none; b=eqfXJ5lz2hG6iS1eMCqGTyZJqOgF+ID/rlc+fFhL/jW8zEbqhlx2O7CfwF5Pz/lNlPt0wZyIE4XS2QYKgXDivN6kW9YiNLIQnWpr2v9wkc4ivv+JPzH1OhkAsq+UIUmBc0Sje9p1CfibJeQPC3G6cJdtaVs5XumU5eJgBAmtcRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784614135; c=relaxed/simple;
	bh=a7PS1GxgP/GrEBIs6udJRmkS3LClp6HsIRiIIc+ry4k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q2Q+GjCPw6QNCpDncgOFejysUATxsDaCDslFET/AMhAAWs77yUK79xhxbpXu5DSs2Eaf0XyYB0yoKKnlzCY5dUuBseUn1TwAp0V39dtSdkbL5zv24+WeBR2MH1ZzrDy8YJD4/Havf7/5Qsnl01kd0p6pSSGSx8MGgCnfaAnNYdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fPRSKG8y; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fPRSKG8y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=DzoANxAX8v7sRUVrSRZWhwiKsYcmnDVGZrhVRijhM08=;
	b=fPRSKG8yfVu6NMV+EXbYkSA068xY+FRY1BoN77etlXVh0THakkoMvt441YBA1k
	VpfvKa3xREpyrYk5oe6MoATCcsZcw47Dw2gHq4N1M0wKJdLu1JL2cf3KmNyz6X3Z
	ncr0lAlc3pbQY+81TkSz2PMY8gnihCcbKs3pDne+fnm7k=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCHHCHiDF9qchtMIQ--.40550S2;
	Tue, 21 Jul 2026 14:08:35 +0800 (CST)
Date: Tue, 21 Jul 2026 14:08:34 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v2] KVM: x86: Mark nested RSM-created VM-Enter as untrusted
Message-ID: <al8M4gCwsWXS_jMs@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-CM-TRANSID:PygvCgCHHCHiDF9qchtMIQ--.40550S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1DJr17ur18WFW7GrW3Wrg_yoW5Cr1xpF
	Z3ZrsF9r45Gr97JrykGr48ur9FvF95JryUZrWDG3s3JF1jg3s7tr1xt3yqvas8J3yfuw1S
	va18Zr4jkw1rJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrqXQUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC3QOtoGpfDOM68wAA3A

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

Fixes: 2bb8cafea80b ("KVM: vVMX: signal failure for nested VMEntry if emulation_required")
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
Changes in v2:
- Mark nested state restored by RSM from SMRAM as KVM_NESTED_RUN_PENDING_UNTRUSTED.
- Keep the BUG check in __vmx_handle_exit(), but make it apply only to KVM_NESTED_RUN_PENDING.

Link to v1: https://lore.kernel.org/all/al3Qbq-jUYE-_72N@192.168.1.215/ 

 arch/x86/kvm/svm/svm.c | 2 +-
 arch/x86/kvm/vmx/vmx.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

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
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cc75feec05da..333072cc9bce 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6720,7 +6720,8 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	 * invalid guest state should never happen as that means KVM knowingly
 	 * allowed a nested VM-Enter with an invalid vmcs12.  More below.
 	 */
-	if (KVM_BUG_ON(vcpu->arch.nested_run_pending, vcpu->kvm))
+	if (KVM_BUG_ON(vcpu->arch.nested_run_pending == KVM_NESTED_RUN_PENDING,
+		       vcpu->kvm))
 		return -EIO;
 
 	if (is_guest_mode(vcpu)) {
@@ -8436,7 +8437,7 @@ int vmx_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
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

