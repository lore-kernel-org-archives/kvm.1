Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=134.76.10.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708717;
	b=2blArAR6CEXsbDTpHw3eaY2yefl6rVwSABG4cujsxfzQFxaqkzI0cYAM9qQe/CoGT/EJ
	 KqYl/3QNHMjKT/DLWbj/tzQF+ejnn1fC+lqiAkT0z9h+t8A9TaYfkjS6XHCCwIFdRDXBh
	 ONfoZO50v8UHbtBcdrEvnUnGxiHtoHk3Gg0swHuvcfKHx6NY8yoyo0fE4kcZRHf3hNYvR
	 ourMwTDBFencVcFHmL6IVWIw87JYiAMuPia3lPaosLJIyy8IkkvkKA2M8dI956bJM/38s
	 4UZ7YruY9acvMBVWqYWou1DqbrEW1ZfhCcaezjih4HEHSAPoKZZDJzV3Sl8l1yT9tqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708717;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Virus-Scanned:X-Spam-Level;
	bh=G7VsWhr2M8RMRhhdUxV4+ISLGkrYm6GOFfsNhoHkbFw=;
	b=DpVhoj2SqtjgrJvps5yXvWi7PDxl5JITYeVACqqkXB2o2/ILPX/RD6YR1JLwJonGBT5+
	 LkxwdJU/0Xkb9c1KuE9iQK8e03qeIqwX4MWSEdy/gMS3HV2rxAUMO8Vp335TFq2YljiJc
	 wjadAXngYg1DygTSjLtxDfOQOJSxKZGCuOqoYgHUpSt9BH4Lt2OmvQzC1Zzx7f3/60qOE
	 S0kbt4a5D7FtI31ZkvvmjkOMQI8yeIHnJfc78JkZPay4hq6Utq8Yk/mGfGMh4Y5WuiIfP
	 XAC6ZVRfLBkJAYRv3q9btR6elcwyzmIs8r3OiBKGTAoh8NoDKQVMEfs3M4Kns3j6j5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cispa.de;
	spf=pass smtp.mailfrom=cispa.de;
	dkim=pass header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=mCOPszip;
	arc=none smtp.remote-ip=134.76.10.21
Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61974606A319;
	Thu, 22 Oct 2026 22:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61974606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=mCOPszip
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=G7VsWhr2M8RMRhhdUxV4+ISLGkrYm6GOFfsNhoHkbFw=; b=mCOPszipBEd6qJ15mzHUuH8MYk
	99vV2TQm+CD3YK7Jz/7MAqRRjtDqOXtX3sWmIDrJdf83LDGcZP1wqPAEYFHRyDOMVhlV03AHT1z+O
	IfLGODgfUbuFjr7aZhm99WPBfDpf0IF4uXuJ3EPe7Pjp+kFpLL1qSi5czbTC2a+B7bW9L/pZ8yoGk
	N0I+iOGy9lRzzGfw+JwgLqkpd8icmDJQmNKOJiX5p6rhgblfOOcIlzPaBfkphERarbBdTnGGbOtdY
	poz3c19s0471uazADTv3hOkPjUYo0d46f0Hy+m4oWKTkG7Lu+BeRlNkJxj2Z36uU5m0FRsnFohXWK
	j9AueYxQ==;
Received: from mailer.gwdg.de ([134.76.10.26]:43348)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xK1Qg-00ECOo-2X;
	Fri, 23 Oct 2026 00:38:34 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xK1Qg-000Ar4-1D;
	Fri, 23 Oct 2026 00:38:34 +0200
Received: from localhost.localdomain (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 23 Oct
 2026 00:38:27 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<amirmohammad.eftekhar@cispa.de>
Subject: [PATCH] KVM: nVMX: Restore L2's DEBUGCTL/BNDCFGS/CET from vmcs12 on RSM and nested state restore
Date: Fri, 23 Oct 2026 00:38:20 +0200
Message-ID: <20261022223820.8279-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.54.0
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
Content-Type: text/plain
X-ClientProxiedBy: mbx19-gwd-01.um.gwdg.de (10.108.142.50) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

nested_vmx_enter_non_root_mode() snapshots the guest's DEBUGCTL, BNDCFGS
and CET state (S_CET/SSP/SSP_TBL) into vmx->nested.pre_vmenter_* so that
prepare_vmcs02() can preserve into vmcs02 any of those fields that VM
entry leaves unchanged, i.e. whose VM_ENTRY_LOAD_* control is clear.  The
snapshot reads the currently loaded VMCS.

That is correct for VMLAUNCH/VMRESUME: the active VMCS is vmcs01, and
when VM entry does not load a field L2 does inherit L1's value for it.
It is wrong for the two from_vmentry == false callers -- RSM back into L2
(vmx_leave_smm()) and KVM_SET_NESTED_STATE -- because there the active
VMCS is still vmcs01, holding L1's live state, while the state L2 must
resume with lives in vmcs12.  On RSM the pre-SMI values were put in
vmcs12 when the SMI forced the L2 -> L1 exit (CET via
sync_vmcs02_to_vmcs12(), DEBUGCTL/BNDCFGS tracked in vmcs12 as L2 updates
them); on nested state restore vmcs12 is the state userspace supplied.

So after an SMI taken while L2 is running, followed by RSM -- a sequence
entirely under the guest's control -- or after a restore, L2 resumes with
L1's DEBUGCTL, BNDCFGS and CET instead of its own whenever L1 left the
corresponding VM_ENTRY_LOAD_* control clear.  Nothing rejects it: the
physical VM entry sees a legal vmcs02 (the stale values are valid, just
not L2's), so the state is silently wrong rather than faulted.

Source the snapshot from vmcs12 on the !from_vmentry paths.

Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
---
Notes (not for the commit message):

 - Fidelity/correctness bug: the victim is L2 and the entity that both
   owns L1 and drove the SMI is L1, so this is L1 corrupting its own L2,
   not a privilege-boundary crossing -- not memory-safety and not
   guest -> host.  It is a concrete instance of the existing in-tree
   "L2's values may be corrupted on SMI+RSM" TODO near vmx_enter_smm().
 - The same snapshot bug applies to the KVM_SET_NESTED_STATE restore
   path, which this fixes too.
 - DEBUGCTL/BNDCFGS have read the active VMCS here for a long time; the
   CET arm is newer.  Happy to add whatever Fixes:/Cc: stable scope you
   prefer rather than guess the split.
 - Verified against mainline (v7.3-rc6) and kvm-x86/next; please confirm
   it still applies on your tree, I will rebase if needed.

 arch/x86/kvm/vmx/nested.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 151873407ab..c51dcb1cb8d 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3650,19 +3650,38 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,

 	kvm_service_local_tlb_flush_requests(vcpu);

+	/*
+	 * Snapshot the state that VM-Enter leaves unchanged when the matching
+	 * VM_ENTRY_LOAD_* control is clear, so it can be restored into vmcs02.
+	 * On VM-Enter the active VMCS is vmcs01 and its guest state is what L2
+	 * inherits.  On the !from_vmentry paths (RSM back into L2, and
+	 * KVM_SET_NESTED_STATE) the active VMCS is still vmcs01, i.e. holds
+	 * L1's state, whereas L2's state lives in vmcs12 -- read it from there
+	 * so that resuming L2 doesn't clobber its DEBUGCTL/BNDCFGS/CET with
+	 * L1's values.
+	 */
 	if (!vcpu->arch.nested_run_pending ||
 	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS))
-		vmx->nested.pre_vmenter_debugctl = vmx_guest_debugctl_read();
+		vmx->nested.pre_vmenter_debugctl = from_vmentry ?
+			vmx_guest_debugctl_read() : vmcs12->guest_ia32_debugctl;
 	if (kvm_mpx_supported() &&
 	    (!vcpu->arch.nested_run_pending ||
 	     !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS)))
-		vmx->nested.pre_vmenter_bndcfgs = vmcs_read64(GUEST_BNDCFGS);
+		vmx->nested.pre_vmenter_bndcfgs = from_vmentry ?
+			vmcs_read64(GUEST_BNDCFGS) : vmcs12->guest_bndcfgs;

 	if (!vcpu->arch.nested_run_pending ||
-	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_CET_STATE))
-		vmcs_read_cet_state(vcpu, &vmx->nested.pre_vmenter_s_cet,
-				    &vmx->nested.pre_vmenter_ssp,
-				    &vmx->nested.pre_vmenter_ssp_tbl);
+	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_CET_STATE)) {
+		if (from_vmentry) {
+			vmcs_read_cet_state(vcpu, &vmx->nested.pre_vmenter_s_cet,
+					    &vmx->nested.pre_vmenter_ssp,
+					    &vmx->nested.pre_vmenter_ssp_tbl);
+		} else {
+			vmx->nested.pre_vmenter_s_cet = vmcs12->guest_s_cet;
+			vmx->nested.pre_vmenter_ssp = vmcs12->guest_ssp;
+			vmx->nested.pre_vmenter_ssp_tbl = vmcs12->guest_ssp_tbl;
+		}
+	}

 	/*
 	 * Stash L1's CR3, so that in the event of a "late" VM-Fail, i.e. a
--
2.54.0

