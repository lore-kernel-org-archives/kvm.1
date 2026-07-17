Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42F13A8741;
	Fri, 17 Jul 2026 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281361; cv=none; b=BdRuC5gjJIYk+5iWE2AUwBEJCxCUi7C36l+c2XID6oZOInk1wn5nBvMclpI3PPHT8OfAqj1N+OMlGgZhzXgCzbBhW1cWboAD7HWwntpzwIJdWOLyn41XdSVjSgwm6c9gc7iWs6NUdRPl35e3Ir376C9X/7/ZePNjrVWyKAFXAco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281361; c=relaxed/simple;
	bh=u8cz8tQzTQAqE3cFWRYhon7SCX8cvMIDEZjF5NN21n8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oFhjE8NrHGIYHLSJao/yw+7Bbnk4VqluWvgxjwq9HA20oMuQ9B1V9H+d14aiNKxpgkN5c2FBnJ2g0LaiRARFWS3CtM/OmXHzDQBPo+tCBRoOrY2FMbG8yh765jt8kTzfKtSg5Nja0toXAOIbRkNEF+KFq6JT1YBkM4XZ0VNcsxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0f/xGipS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XOxt5VNn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0f/xGipS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XOxt5VNn"
Date: Fri, 17 Jul 2026 09:42:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784281358;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dpRxGmOIHKOclha4lQHLwzsQk9BHHT9mm7sVd4UHbsw=;
	b=0f/xGipS87aT1DjGQzJNRuN58RJYp54yMDjkXiT9DrXvIn7Xg0wMmF16EZHnOKtNvkEhKI
	7jIFSYT3AADbZKWdWUf94bAO/myVKm74wJ2BIFV0N9zlFvc/kS2JcVEer+vWS5DHY5uRoG
	kCpvIncHuFH8LIcTAF/jktImOoYwgHRKfmwFNAsQifF7yfDvn6V7IN5GUVS/nkLceuxABu
	g+mTx4FuJYNLgGfie10u+rRKqPcV4UVG8qXOv4kHB5wUYm2PRBsheQDO/VefTjzFZz1VXm
	pJ4RuoAQJDpNKjMesXccZM58miSWLYxx3i+yAPBqmYoa65I5gu6j/3+D0CrO1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784281358;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dpRxGmOIHKOclha4lQHLwzsQk9BHHT9mm7sVd4UHbsw=;
	b=XOxt5VNniICTeCPF+kz9wERJazQXHCbKC/hN2gjREOwIWL5D5/QUb1RNxOxWmD+Umw3Xcu
	0wZkByTakUHaUmCA==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/msr] KVM/x86: Stop using 32-bit MSR interfaces
Cc: Juergen Gross <jgross@suse.com>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260629060526.3638272-10-jgross@suse.com>
References: <20260629060526.3638272-10-jgross@suse.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178428135675.1844600.9212680001777795869.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     1620ddc0dcefc6ffb85f4718086e880335d1a7f5
Gitweb:        https://git.kernel.org/tip/1620ddc0dcefc6ffb85f4718086e880335d=
1a7f5
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 29 Jun 2026 08:05:00 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 17 Jul 2026 11:30:00 +02:00

KVM/x86: Stop using 32-bit MSR interfaces

The 32-bit MSR interfaces rdmsr(), wrmsr() and  rdmsr_safe() are
planned to be removed. Use the related 64-bit variants instead.

No change in functionality intended.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org
Link: https://patch.msgid.link/20260629060526.3638272-10-jgross@suse.com
---
 arch/x86/kvm/vmx/vmx.c      | 24 +++++++++++++-----------
 arch/x86/kvm/x86.c          |  4 ++--
 arch/x86/virt/vmx/tdx/tdx.c |  6 ++++--
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2325be5..49948bb 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2676,13 +2676,13 @@ static bool cpu_has_sgx(void)
=20
 static int adjust_vmx_controls(u32 ctl_min, u32 ctl_opt, u32 msr, u32 *resul=
t)
 {
-	u32 vmx_msr_low, vmx_msr_high;
+	struct msr vmx_msr;
 	u32 ctl =3D ctl_min | ctl_opt;
=20
-	rdmsr(msr, vmx_msr_low, vmx_msr_high);
+	rdmsrq(msr, vmx_msr.q);
=20
-	ctl &=3D vmx_msr_high; /* bit =3D=3D 0 in high word =3D=3D> must be zero */
-	ctl |=3D vmx_msr_low;  /* bit =3D=3D 1 in low word  =3D=3D> must be one  */
+	ctl &=3D vmx_msr.h;  /* bit =3D=3D 0 in high word =3D=3D> must be zero */
+	ctl |=3D vmx_msr.l;  /* bit =3D=3D 1 in low word  =3D=3D> must be one  */
=20
 	/* Ensure minimum (required) set of control bits are supported. */
 	if (ctl_min & ~ctl)
@@ -2738,6 +2738,7 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_c=
onf,
 	u64 _cpu_based_3rd_exec_control =3D 0;
 	u32 _vmexit_control =3D 0;
 	u32 _vmentry_control =3D 0;
+	struct msr val;
 	u64 basic_msr;
 	u64 misc_msr;
=20
@@ -2787,8 +2788,9 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_c=
onf,
 				SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
 				SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY);
=20
-	rdmsr_safe(MSR_IA32_VMX_EPT_VPID_CAP,
-		&vmx_cap->ept, &vmx_cap->vpid);
+	rdmsrq_safe(MSR_IA32_VMX_EPT_VPID_CAP, &val.q);
+	vmx_cap->ept =3D val.l;
+	vmx_cap->vpid =3D val.h;
=20
 	if (!(_cpu_based_2nd_exec_control & SECONDARY_EXEC_ENABLE_EPT) &&
 	    vmx_cap->ept) {
@@ -4435,7 +4437,7 @@ void vmx_deliver_interrupt(struct kvm_lapic *apic, int =
delivery_mode,
  */
 void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
 {
-	u32 low32, high32;
+	struct msr val;
 	unsigned long tmpl;
 	unsigned long cr0, cr3, cr4;
=20
@@ -4476,8 +4478,8 @@ void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
=20
 	vmcs_writel(HOST_RIP, (unsigned long)vmx_vmexit); /* 22.2.5 */
=20
-	rdmsr(MSR_IA32_SYSENTER_CS, low32, high32);
-	vmcs_write32(HOST_IA32_SYSENTER_CS, low32);
+	rdmsrq(MSR_IA32_SYSENTER_CS, val.q);
+	vmcs_write32(HOST_IA32_SYSENTER_CS, val.l);
=20
 	/*
 	 * SYSENTER is used for 32-bit system calls on either 32-bit or
@@ -4492,8 +4494,8 @@ void vmx_set_constant_host_state(struct vcpu_vmx *vmx)
 	vmcs_writel(HOST_IA32_SYSENTER_EIP, tmpl);   /* 22.2.3 */
=20
 	if (vmcs_config.vmexit_ctrl & VM_EXIT_LOAD_IA32_PAT) {
-		rdmsr(MSR_IA32_CR_PAT, low32, high32);
-		vmcs_write64(HOST_IA32_PAT, low32 | ((u64) high32 << 32));
+		rdmsrq(MSR_IA32_CR_PAT, val.q);
+		vmcs_write64(HOST_IA32_PAT, val.q);
 	}
=20
 	if (cpu_has_load_ia32_efer())
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index afcac10..9b64556 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7633,9 +7633,9 @@ static void kvm_probe_feature_msr(u32 msr_index)
=20
 static void kvm_probe_msr_to_save(u32 msr_index)
 {
-	u32 dummy[2];
+	u64 dummy;
=20
-	if (rdmsr_safe(msr_index, &dummy[0], &dummy[1]))
+	if (rdmsrq_safe(msr_index, &dummy))
 		return;
=20
 	/*
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 42df8ea..1b9ff74 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1430,6 +1430,7 @@ static __init int record_keyid_partitioning(u32 *tdx_ke=
yid_start,
 					    u32 *nr_tdx_keyids)
 {
 	u32 _nr_mktme_keyids, _tdx_keyid_start, _nr_tdx_keyids;
+	struct msr val;
 	int ret;
=20
 	/*
@@ -1437,8 +1438,9 @@ static __init int record_keyid_partitioning(u32 *tdx_ke=
yid_start,
 	 *   Bit [31:0]:	Number of MKTME KeyIDs.
 	 *   Bit [63:32]:	Number of TDX private KeyIDs.
 	 */
-	ret =3D rdmsr_safe(MSR_IA32_MKTME_KEYID_PARTITIONING, &_nr_mktme_keyids,
-			&_nr_tdx_keyids);
+	ret =3D rdmsrq_safe(MSR_IA32_MKTME_KEYID_PARTITIONING, &val.q);
+	_nr_mktme_keyids =3D val.l;
+	_nr_tdx_keyids =3D val.h;
 	if (ret || !_nr_tdx_keyids)
 		return -EINVAL;
=20
