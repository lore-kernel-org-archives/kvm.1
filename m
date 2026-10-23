Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=134.76.10.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792775671;
	b=rBv/Yc1jFBtj/9ZzkNUVrJUZkY2Hq7ncwY2EK/r5l7VMDA/GtqIScKTQSUDlz6GH/gFo
	 56Ow5fYSO1OZ4+8H8PvrymYcL4oi9lf4ISrDvCSRY+axQ2W225j24APNrs5TfwVghKLbC
	 ehqFtP9wZZOA+lKRLvX/Zu7h5TAn6aS77frRhy4Oi1WAikSr0npCbMtf7cYYm2ARzxzW0
	 bWWaIUcHC1pYN6dmxr6fmtm2NdW7ikiLu3GMB/fn11h4VgckVsaoYLokyQ+KwoUoQzQwJ
	 RqxgzgFqIUcEMTSDgqNa97bOxDslqaJUHd0ervq/yysrMGFCkwrj5Xtd9Y8SMqq46yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792775671;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Virus-Scanned:X-Spam-Level;
	bh=IyLwFuwt9xvTMRmGR0g8uY48KLl2wMeZYw2+YnAXfJc=;
	b=1ijwYV08dGyo7q3NDpjVvrMsbyMjriA6BdZHF1SJ6I+DtBLb+obxs25OlGAiLg7EGQNG
	 /WVT1RErvoRLTwhqLCuE4oS61pov0/gX/ZqI8FHoVkzkpUV9LAggj3S/YFfArHCgN+Yak
	 oVCS1dzk9xm3tGqOegJpBi1mHTFdtzElLhlOB65AQ5jyVX1oUMhQdy7lHMox3Xrxp47TZ
	 aLXZBYK8bUYm8vnnVgMFj8ch0hUT0xXmoB+xGu+GeqYugzK9TGbeAwQaLEmXgFViD40Ug
	 ltqZUjRjiMcjUTHQaSjYXNc1DC9eb/zZ88ZK6pHLITa0Yfi/1m7jmKaqbrf7dGQQQ8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cispa.de;
	spf=pass smtp.mailfrom=cispa.de;
	dkim=pass header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=TD8eRhrQ;
	arc=none smtp.remote-ip=134.76.10.21
Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229FB606A31B;
	Fri, 23 Oct 2026 17:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 229FB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=TD8eRhrQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=IyLwFuwt9xvTMRmGR0g8uY48KLl2wMeZYw2+YnAXfJc=; b=TD8eRhrQhGFPygragoQuiRxsMX
	1DO5ktWB6kcyC+iR3cR87w6p+Aiz6hbfKd9EDMXfP47YYX7pYRrW1/FFOxSZLXC2DI8/xpFKivbXt
	UmddSk3vDwtcm49f+LIwFThHGXHecBXdXMqDegP19iSG1p0vgrpEm+gK3lKi+N5B7nYYKkhwqTjTb
	BPt3t3JYGEvLyQt12G52Zbe5AhvPJ6z3SnoI8R/lJA/wga3bFRc5Ay61O8qwGwhz97ZiTy+TOiv2i
	OqYpVpyV/YX/PEYjeE9moOySEZgL1HZlvIprMWjlJPODLufTj83tc4TN2+ER/AGXNflzTOicooj5S
	EX4c6M7w==;
Received: from mailer.gwdg.de ([134.76.10.26]:34981)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xKIqb-00EmxH-2K;
	Fri, 23 Oct 2026 19:14:29 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xKIqb-000MFz-0z;
	Fri, 23 Oct 2026 19:14:29 +0200
Received: from localhost (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 23 Oct
 2026 19:14:28 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<amirmohammad.eftekhar@cispa.de>
Subject: [BUG] KVM: nVMX: RSM re-entry reloads L2's DEBUGCTL/S_CET/SSP/SSP_TBL/BNDCFGS from vmcs01, not L2's pre-SMI values
Date: Fri, 23 Oct 2026 19:14:09 +0200
Message-ID: <20261023171409.637483-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.34.1
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
X-ClientProxiedBy: MBX19-FMZ-04.um.gwdg.de (10.108.142.63) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

Hi,

Reporting a nested-SMM fidelity bug (correctness, L1-self / L2-state; not
memory-safety and not guest->host). On RSM from SMM back into L2, KVM
re-stamps a set of guest MSR/state fields into vmcs02 from values it read out
of the *active* VMCS at the moment of re-entry -- which is still vmcs01 (L1's
live values) after the SMI forced the L2->L1 switch -- instead of L2's
pre-SMI values that were already saved into vmcs12.

The path
--------
vmx_leave_smm() -> nested_vmx_enter_non_root_mode(vcpu, from_vmentry=false)
runs with nested_run_pending == 0 (vmx_leave_smm() sets
KVM_NESTED_RUN_PENDING only *after* the re-entry call returns).

On that !from_vmentry re-entry, the "stash pre-VM-enter state" block reads the
current VMCS:

  vmx->nested.pre_vmenter_debugctl = vmx_guest_debugctl_read();     /* nested.c ~3677 */
  vmx->nested.pre_vmenter_bndcfgs  = vmcs_read64(GUEST_BNDCFGS);    /* ~3681 */
  vmcs_read_cet_state(vcpu, &vmx->nested.pre_vmenter_s_cet,         /* ~3685 */
                      &...ssp, &...ssp_tbl);

At this point the loaded VMCS is still vmcs01 (the SMI switched L2->L1 and RSM
has not switched back yet), so these reads capture L1's live DEBUGCTL / S_CET
/ SSP / SSP_TBL / BNDCFGS.

prepare_vmcs02()'s "no VM_ENTRY_LOAD_*" branch then stamps those stashed
values into vmcs02:

  vmx_guest_debugctl_write(vcpu, vmx->nested.pre_vmenter_debugctl);  /* nested.c ~2796 */
  vmcs_write_cet_state(vcpu, vmx->nested.pre_vmenter_s_cet,          /* ~2801 */
                       ssp, ssp_tbl);
  vmcs_write64(GUEST_BNDCFGS, vmx->nested.pre_vmenter_bndcfgs);      /* ~2807 */

But sync_vmcs02_to_vmcs12() already saved L2's correct values into vmcs12 when
the SMI was taken; RSM discards them and L2 resumes with L1's values for these
fields.

Impact / class
--------------
E2 fidelity. The victim is L2 and the entity that both owns L1 and drove the
SMI is L1, so this is L1-self-inflicted state corruption of its own L2, not a
privilege-boundary crossing, not guest->host, and not kvmCTF-scoring. It is a
concrete instance of the existing in-tree "L2's values may be corrupted on
SMI+RSM" TODO near vmx_enter_smm().

Suggested fix
-------------
On the !nested_run_pending (RSM) re-entry branch, source these fields from
vmcs12 (where sync_vmcs02_to_vmcs12 already put L2's values) rather than from
the active VMCS. Happy to send a patch once you confirm the preferred shape
(source-from-vmcs12 vs. reorder the vmcs switch so the stash reads vmcs02).

Read-confirmed against kvm-x86/next (tip of 2026-10-13) at the three anchors
above; the same pattern is present in mainline v7.3-rc6.

Thanks,
Amirmohammad
