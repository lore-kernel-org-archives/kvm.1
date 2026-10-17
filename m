Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5DB45D5E2;
	Sat, 17 Oct 2026 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792229435; cv=none; b=r13eNcQeb/+KYmeZthw3GOloI6GiP+ajOfncNlOLB9jPJjTMI6zypImH1FyNwIgO3ar5LGk/SYIgkSGo8gSWhiDYoyDZ537SVSTIdEveaUfGVzHTgRiafjLBmsb9JLF0Ke82ujzCztpagJPF1dnz8YTBo/Ku7TWGdZZV3MyIp0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792229435; c=relaxed/simple;
	bh=qz+ndUBj65T9pNRP0eH0pSrmMTujG8Qw1LhPKU7jRDA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EN5qfEBJ924aftPRnaapV5jNEGAyaxKJF+6/nGny303HgBk6w5MW3CluM3BSkEYq+uY4ScAQb2AEE5t2oqNGtqEU1nNKrsMLkuXBOHdK0MzV3hbam9tF5SeYQJXxahfcIbg4SHV8+8AB12H3friUyZ/YkL8uHdrg5OVQbX1eRus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b=NVZ2t0G2; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b="NVZ2t0G2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=IyLwFuwt9xvTMRmGR0g8uY48KLl2wMeZYw2+YnAXfJc=; b=NVZ2t0G2B2UKctZovkm+j64dTu
	lvQbpWShhJhki0gjp4uq9BS99nc8aEUESenRXvAsk0nsaXbHYcjPrzBImYN+6DszAxEiFP3SM4bZz
	9DMJ3MT2YRqFaEv6kk8+JAtbt4FFReNaYnxSuhvRoF7HBHUDiAR/+3UoLFFYasuwdwzsdf73ezjhn
	cVSEyA0doE8FgDFXboL5rRzDjUkB5trQPWM0zRsywQUpnrUhF7RQXaH+mU1uKc6RwV70fOCfea9oe
	qrbvqbqqHcCN2LHynsQKDIZeMX1zagf/jnkpdrEoyXFeoBGdI9lXKwCv0SJfZV20BBAGLi8r6ER8a
	qnjBs+mg==;
Received: from mailer.gwdg.de ([134.76.10.26]:36901)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xI0kK-00BAXa-1T;
	Sat, 17 Oct 2026 11:30:32 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xI0kK-000VY2-08;
	Sat, 17 Oct 2026 11:30:32 +0200
Received: from localhost.localdomain (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sat, 17 Oct
 2026 11:30:31 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [BUG] KVM: nVMX: RSM re-entry reloads L2's DEBUGCTL/S_CET/SSP/SSP_TBL/BNDCFGS from vmcs01, not L2's pre-SMI values
Date: Sat, 17 Oct 2026 11:30:14 +0200
Message-ID: <20261017093016.32348-5-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MBX19-FMZ-07.um.gwdg.de (10.108.142.66) To
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
