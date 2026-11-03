Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793747284;
	b=GSmwKxiyKbnBLUdMHWnFTx9EGVhOhQZJcNhSuWmMsCZZokq7grImADeXU/4KhQ3r4g+Q
	 +5XT79ytbNZ3W52OZFrn3PnezIygBoG8r1i7ND1GYJWst+8DAlYu9bq7dz9nt9bDM50H0
	 tB8w75CO1kz1q7TDLgflt4QpmiXrantaprELJJfRa8vC0GwmtS7T7mGTgZOXREP2xECsW
	 YAavDiazHGro2hAr8/bCuJHRxVhkj43hi51WmqVtuxQ7gAMYV5BFkBzMhCbQqlrniqGOi
	 bRw1Ia+cnGEUxmwKV+xXOC4c5anxfG+jF3EdDD84HTR/jK1GVZNGbyhr4jlVj/ODIIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747284;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=uVsRo4Fk5ocBc1p4CB7m4Slnz2MVxoj3RypzyMZCOqo=;
	b=zXcCrlnl92+Ty7B6B0ZM3Ru97lhQRqANeEVvKGWEW4GDNC8KJpPahfOqu4uy8j8V992H
	 z2Fp2q63YqBoZUv2wIuTqyXC8GIkxIzs2w/CmQ/LGDW80nsV2lwKU+CIY+StveZRyj7Fz
	 6oA6Rp4sPidOcpzJrY0XEwoZHwKw1xEc/WDbMb2FQEv3B5taTZlhX0/0tIb4HAzLIKn39
	 EDQjmNj4f/ZOsudwfPokJCytuAggBNEwma3LSCCdozHH/vxxw80n3L1D277HieM/HElYa
	 R3DzNoWggBnzG+Joq9cTvs1+w+XjrACofx1uwr/PSrP1UgJaXeOFzfJlyBozNJEypVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=ma.08@web.de header.a=rsa-sha256 header.s=s29768273 header.b=Q82WOaeL;
	arc=none smtp.remote-ip=212.227.15.4
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1768606A31B;
	Tue,  3 Nov 2026 23:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1768606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=ma.08@web.de header.a=rsa-sha256 header.s=s29768273 header.b=Q82WOaeL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1793747276; x=1794352076; i=ma.08@web.de;
	bh=uVsRo4Fk5ocBc1p4CB7m4Slnz2MVxoj3RypzyMZCOqo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Q82WOaeLrpk94qQ+Hx9yKWJP63EaLBShAjXWltrFdVgr/sMTfaPCRKJcUS3Ej6eP
	 D77Lz3ZK3vNNft5u8N/jMq02Y6IX9lEJ9JPLfZ7JC8lR+RdHw0akD2Vs4Xw9I7SRk
	 vjCPY2oqFsrg66cO+Sx6lRkrGOFFfkJYOvb3CjG8Zv2OkWImQC6WFi/UJqwUwUby1
	 wGuYqtVO9ORVLgXnyrEPaxet7S+6SAIhADb2bN9qAt0mgEXjxm1kRJ4lV0EtH5a0r
	 ll+woDz3a3A5jzgbX02EcsVmR+gS4QWdH7HgAMp1iIu4stTQ+hs6P0RqFoiWm3qCP
	 wT28hib0tmGHgdIeFQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHEXc-1xJxls050S-0039Wn; Wed, 04
 Nov 2026 00:07:56 +0100
From: Abdelali Maddane <ma.08@web.de>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abdelali Maddane <ma.08@web.de>
Subject: [PATCH] KVM: nSVM: Validate L1 host save state restored on RSM from SMM
Date: Wed,  4 Nov 2026 00:07:50 +0100
Message-ID: <20261103230750.1843-1-ma.08@web.de>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lKwmJCblnroJ2bPnm57YryGuMH8hU33AWf/i7UccmIXoULrySfG
 CZQAWngK1gUML3Q0aW/UI9228IZ+dsGQpAQ+54O8fp+Z0KxK0NjzNokgNVpfOzzSLS484wN
 oHqwhERfaAGS5A49TQZm6E9/hxHYJ/EAUd19xJVZXHbs2z//Ppd66Nii7Xj6/t++bb2lpkS
 jO5X5aUn9RVdtZt21ScWg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p+DnCoy9U5A=;xczdmqlXrV59q3o7RbW8lVAOMBO
 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

When an SMI is taken while L2 is running, svm_enter_smm() saves L1's host
state into the HSAVE area (ordinary guest memory pointed to by
MSR_VM_HSAVE_PA).  On RSM, svm_leave_smm() copies that state back into
vmcb01 and builds the nested MMU from it, but unlike KVM_SET_NESTED_STATE
it does not validate the restored state.

Because the HSAVE area is guest memory, L1 can modify it while the vCPU is
in SMM so that RSM loads an impossible EFER.LMA=3D1 && EFER.LME=3D0 combin=
ation
(e.g. together with CR4.PAE=3D0).  kvm_calc_cpu_role() then computes a 4- =
or
5-level role while shadow_mmu_init_context() wires up the 2-level paging32
template, and FNAME(walk_addr_generic) indexes out of bounds of the
fixed-size guest_walker arrays.  On kernels carrying the KVM_BUG_ON()
backstop in kvm_calc_cpu_role() this is a guest-triggerable KVM_BUG_ON()
(dead VM, or a host panic with panic_on_warn); on older kernels it is an
out-of-bounds access in the page-table walker.

Validate the restored L1 host state in svm_leave_smm() with the same check=
s
KVM_SET_NESTED_STATE already applies to L1 host state, factored out into
nested_svm_check_l1_save().  A failed check fails RSM, which is the correc=
t
response to an impossible saved state.

The patch, reproducer, and this changelog were developed with substantial
help from an AI assistant (Anthropic's Claude Code), directed and reviewed
by the submitter.  Tested by the submitter on an AMD EPYC host: without th=
e
patch a reproducer triggers the guest-reachable KVM_BUG_ON() in
kvm_calc_cpu_role(); with the patch the reproducer is rejected, and the
smm_test and svm_nested_shutdown_test selftests still pass.

Fixes: 37be407b2ce8 ("KVM: nSVM: Fix L1 state corruption upon return from =
SMM")
Signed-off-by: Abdelali Maddane <ma.08@web.de>
=2D--
Reproducer (a KVM selftest) available on request.

 arch/x86/kvm/svm/nested.c | 36 ++++++++++++++++++++++--------------
 arch/x86/kvm/svm/svm.c    |  7 +++++++
 arch/x86/kvm/svm/svm.h    |  1 +
 3 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index af0ef6784..2295bd90a 100644
=2D-- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -616,6 +616,26 @@ void nested_copy_vmcb_save_to_cache(struct vcpu_svm *=
svm,
 	__nested_copy_vmcb_save_to_cache(&svm->nested.save, save);
 }
=20
+/*
+ * Validate L1 host save state loaded on return to L1 (RSM from SMM, or v=
ia
+ * KVM_SET_NESTED_STATE).  g_pat is not checked: it may be clobbered by S=
MM and
+ * isn't loaded at emulated #VMEXIT.
+ */
+int nested_svm_check_l1_save(struct kvm_vcpu *vcpu, struct vmcb_save_area=
 *save)
+{
+	struct vmcb_save_area_cached save_cached;
+
+	__nested_copy_vmcb_save_to_cache(&save_cached, save);
+	if (!(save->cr0 & X86_CR0_PG) ||
+	    !(save->cr0 & X86_CR0_PE) ||
+	    (save->rflags & X86_EFLAGS_VM) ||
+	    ((save->efer & EFER_LMA) && !(save->efer & EFER_LME)) ||
+	    !nested_vmcb_check_save(vcpu, &save_cached, false))
+		return -EINVAL;
+
+	return 0;
+}
+
 /*
  * Synchronize fields that are written by the processor, so that
  * they can be copied back into the vmcb12.
@@ -1968,7 +1988,6 @@ static int svm_set_nested_state(struct kvm_vcpu *vcp=
u,
 		&user_kvm_nested_state->data.svm[0];
 	struct vmcb_control_area *ctl;
 	struct vmcb_save_area *save;
-	struct vmcb_save_area_cached save_cached;
 	struct vmcb_ctrl_area_cached ctl_cached;
 	bool use_separate_l2_pat;
 	unsigned long cr0;
@@ -2033,19 +2052,8 @@ static int svm_set_nested_state(struct kvm_vcpu *vc=
pu,
         if (((cr0 & X86_CR0_CD) =3D=3D 0) && (cr0 & X86_CR0_NW))
 		goto out_free;
=20
-	/*
-	 * Validate host state saved from before VMRUN (see
-	 * nested_svm_check_permissions). Note that the g_pat field is not
-	 * validated, because (a) it may have been clobbered by SMM before
-	 * KVM_GET_NESTED_STATE, and (b) it is not loaded at emulated
-	 * #VMEXIT.
-	 */
-	__nested_copy_vmcb_save_to_cache(&save_cached, save);
-	if (!(save->cr0 & X86_CR0_PG) ||
-	    !(save->cr0 & X86_CR0_PE) ||
-	    (save->rflags & X86_EFLAGS_VM) ||
-	    ((save->efer & EFER_LMA) && !(save->efer & EFER_LME)) ||
-	    !nested_vmcb_check_save(vcpu, &save_cached, false))
+	/* Validate host state saved from before VMRUN. */
+	if (nested_svm_check_l1_save(vcpu, save))
 		goto out_free;
=20
 	/*
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 136069dfc..9de22fa92 100644
=2D-- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5224,6 +5224,13 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, con=
st union kvm_smram *smram)
=20
 	svm_copy_vmrun_state(vcpu, &svm->vmcb01.ptr->save, m_save.map.hva + 0x40=
0);
=20
+	/*
+	 * The HSAVE area is guest memory; validate the restored L1 state before
+	 * it is used to build the nested MMU, same as KVM_SET_NESTED_STATE.
+	 */
+	if (nested_svm_check_l1_save(vcpu, &svm->vmcb01.ptr->save))
+		return 1;
+
 	/*
 	 * Enter the nested guest now
 	 */
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 6d0242966..f7f0f3071 100644
=2D-- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -901,6 +901,7 @@ static inline void nested_svm_simple_vmexit(struct vcp=
u_svm *svm, u32 exit_code)
 int nested_svm_exit_handled(struct vcpu_svm *svm);
 int nested_svm_check_permissions(struct kvm_vcpu *vcpu);
 int nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu);
+int nested_svm_check_l1_save(struct kvm_vcpu *vcpu, struct vmcb_save_area=
 *save);
 int nested_svm_check_exception(struct vcpu_svm *svm, unsigned nr,
 			       bool has_error_code, u32 error_code);
 int nested_svm_exit_special(struct vcpu_svm *svm);

base-commit: dea4f6380f4ec96e8f3b0aaf2343764bd0d25ef4
=2D-=20
2.56.0

