Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC5139B4A3
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784533121; cv=none; b=XIoGQXsjBPjqTk1MOIZWPIWPFp+vtcPfQBnacQK8zXiYdwlfggRAjsRHezjrDFZCgBAfplocvvxToAdeUe4zfDB0AiEXKejBK+K4u4GrDGU9ZDvX4wV+t9XS4CmBSxYTWUsyU9JI1MsfLVUBchuvAXVQ6N87tk85TuxtHQvhTnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784533121; c=relaxed/simple;
	bh=qb1XqJIybEaoq6n+C2qyhvs3uuSXm0nwzO8WBCYO+uI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oqlICYTgqVFvx54h7lIpMQ1Jgi+crj0AJbAMT6AnwLoEs49nSI/VjTsgI1h7pU2YcAcHMN8yBXFGiD2c2f51lnsw0ADZo/oL1OvivRdqGz6m4uMV04nhwow1WS3sbP+cU4NDudEwhmL+zEmfsdB+dxujzSd9IXuF27mOnV22gdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JIsEVf0f; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JIsEVf0f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=De05zIwDh+XYbWBduYitlYYxaE5X1RUhjhRC0aHpxn0=;
	b=JIsEVf0fchq+4ZCeYZxFF8Txm9Gcka5mj62STtU/FLzNJBzAj4QVUNqwOGy1rJ
	miSIMs4fLdvW6z+kUoAnVnym3hs8v1pwRQD6Syi4g9sflqzrvXk0i6m1msAWILOI
	mr7T8Ibay39LNncIhVfHZo2ool5hjtkbQf/ewN477z9/s=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wAn0+dv0F1q99TUKQ--.9654S2;
	Mon, 20 Jul 2026 15:38:24 +0800 (CST)
Date: Mon, 20 Jul 2026 15:38:22 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH] KVM: VMX: Complete pending nested VM-Enter on invalid-state
 failure
Message-ID: <al3Qbq-jUYE-_72N@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-CM-TRANSID:_____wAn0+dv0F1q99TUKQ--.9654S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr1DGw4fKr4rZw1UAr45GFg_yoWrXr4kpr
	Z3trZayrWqqa47tr93JF4rXrZ29w4IgFy29rZxC34Syw1jgFn5Jr48Kw1jqFW5ur4Sgw17
	XF1jgr4Uuay5J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrqXQUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC3hBCNWpd0HBrqgAA3v

From: Hao Zhang <zhanghao1@kylinos.cn>
Date: Fri, 17 Jul 2026 09:18:31 +0800

Commit 2bb8cafea80b ("KVM: vVMX: signal failure for nested VMEntry if
emulation_required") made KVM synthesize a failed VM-Entry with
EXIT_REASON_INVALID_STATE when L2 guest state requires invalid-state
emulation during nested VM-Enter.

That synthetic failure is generated in vmx_vcpu_run() before attempting
hardware VM-Enter.  As a result, it returns before the normal post-run
path that accounts and clears nested_run_pending after a real
VM-Enter/VM-Exit round trip.

If the synthetic invalid-state failure happens while a nested VM-Enter is
pending, __vmx_handle_exit() observes a trusted pending nested VM-Enter
and fires KVM_BUG_ON(), causing KVM_RUN to fail with -EIO instead of
reflecting the failed VM-Entry to L1.

Treat EXIT_REASON_INVALID_STATE with the failed VM-Entry bit set as
completion of the pending nested VM-Enter.  Clear nested_run_pending, keep
the existing BUG check for other trusted pending exits, and do not convert
this synthetic failed VM-Entry into a triple fault for L2.

Fixes: 2bb8cafea80b ("KVM: vVMX: signal failure for nested VMEntry if emulation_required")
Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 arch/x86/kvm/vmx/vmx.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cc75feec05da..0ebd2e746ddd 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6699,6 +6699,7 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	union vmx_exit_reason exit_reason = vmx_get_exit_reason(vcpu);
 	u32 vectoring_info = vmx->idt_vectoring_info;
 	u16 exit_handler_index;
+	bool failed_nested_vmentry = false;
 
 	/*
 	 * Flush logged GPAs PML buffer, this will make dirty_bitmap more
@@ -6715,13 +6716,29 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 		return 0;
 
 	/*
-	 * KVM should never reach this point with a pending nested VM-Enter.
-	 * More specifically, short-circuiting VM-Entry to emulate L2 due to
-	 * invalid guest state should never happen as that means KVM knowingly
-	 * allowed a nested VM-Enter with an invalid vmcs12.  More below.
-	 */
-	if (KVM_BUG_ON(vcpu->arch.nested_run_pending, vcpu->kvm))
-		return -EIO;
+	 * vmx_vcpu_run() may synthesize EXIT_REASON_INVALID_STATE with the
+	 * failed VM-Entry bit set before attempting hardware VM-Enter, and thus
+	 * return before the normal post-run path clears nested_run_pending. Treat
+	 * that case as completion of the pending nested VM-Enter and reflect the
+	 * failed VM-Entry to L1.
+	 *
+	 * For all other exits, KVM should never reach this point with a trusted
+	 * pending nested VM-Enter. If userspace gained control while VM-Enter was
+	 * pending, the pending state is marked untrusted because userspace may
+	 * have modified vCPU state and induced an architecturally impossible
+	 * VM-Exit.
+	 */
+	if (unlikely(vcpu->arch.nested_run_pending)) {
+		if (exit_reason.basic == EXIT_REASON_INVALID_STATE &&
+		    exit_reason.failed_vmentry) {
+			failed_nested_vmentry = true;
+		} else if (KVM_BUG_ON(vcpu->arch.nested_run_pending ==
+				      KVM_NESTED_RUN_PENDING, vcpu->kvm)) {
+			return -EIO;
+		}
+
+		vcpu->arch.nested_run_pending = 0;
+	}
 
 	if (is_guest_mode(vcpu)) {
 		/*
@@ -6755,7 +6772,7 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 		 * the least awful solution for the userspace case without
 		 * risking false positives.
 		 */
-		if (vmx->vt.emulation_required) {
+		if (vmx->vt.emulation_required && !failed_nested_vmentry) {
 			nested_vmx_vmexit(vcpu, EXIT_REASON_TRIPLE_FAULT, 0, 0);
 			return 1;
 		}

base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
-- 
2.15.0

