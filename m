Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5163847CC96;
	Sat, 17 Oct 2026 09:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792229435; cv=none; b=m/V9++fItXJBgCL3apycNhaMRR13scxaUssCa+Qa1fd8y5/PRklDyqKFXKDSsCOXRKAZD3sCBsjFAVrTCPpJg9rks5buxb9GTq6vuVg413xa/yV2enr+NBL1k9TRoEna0X9EO1S/WkufixNWaUVcYcjcmqSb4NJxe2rAVbyFsMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792229435; c=relaxed/simple;
	bh=6n/DP+J3QmugsD4VZVw0nVpPRH9MpEeUb+U8oLZy37I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=km1f64+kBrid/zXimLh5yuNlgn5uvT4iYwkXEsKCLIOiA2wX7fxbuvippTh13wTUFfi19609EH1Ds4RW2L2wrWsYHFfWPJjS5Z3ZTulI2KeTN8eAero3fT/oVkMeeSuOjSgER19xBmCGhXv9e0v29cHPzryFYwoIuPR22S+RO1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b=dt/U9xKf; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b="dt/U9xKf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HgMYbhAoeaeOOZxtD9k9QZow02hV/8D2BFRu4aNQ2EE=; b=dt/U9xKf/R1IbwIzG1qexRxGT+
	3BKH6MlOG9oZT9BFUFzBTKtwIsdktEtYFFwdU19zZd0WkCOdmMhlALo3XfGapu1KcgOBTPhwfGN3V
	RfzyuA7FeztGcPrMhXELKGOYGDBAIpAvfVn82dUFx3ivCBX2kPRC/sM44QMZHilhHf8QwIsfg5t7N
	AxjKrIPe5VuUjotA9ktCJPAgWj/mS4+v8qNvFPiOWwXeYSQMVTWQ0mT08WOx7KhxOHaJ30m8Rm11n
	82eJCEmd+/LrK2VVatsoUvTZ1Z0mnw+wiJ6AQMa3YDD0K8k/AndLRW8KEEIT925aMCl6vlKWUEs0f
	gv9iRLmA==;
Received: from mailer.gwdg.de ([134.76.10.26]:43444)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xI0kL-00BAXf-0F;
	Sat, 17 Oct 2026 11:30:32 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xI0kK-000VYE-26;
	Sat, 17 Oct 2026 11:30:32 +0200
Received: from localhost.localdomain (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Sat, 17 Oct
 2026 11:30:32 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [BUG] KVM: nSVM: vNMI vmcb02->vmcb01 egress runs for a non-nested-vNMI L1 (gated on global vnmi, not nested_vnmi_enabled)
Date: Sat, 17 Oct 2026 11:30:15 +0200
Message-ID: <20261017093016.32348-6-amirmohammad.eftekhar@cispa.de>
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

Reporting an nSVM vNMI fidelity bug (correctness, L1-scoped; not
memory-safety, not guest->host).

On nested VM-exit, nested_svm_vmexit() copies the virtual-NMI state from
vmcb02 back into vmcb01:

  if (vnmi) {                                             /* svm/nested.c ~1407 */
          if (vmcb02->control.int_ctl & V_NMI_BLOCKING_MASK)
                  vmcb01->control.int_ctl |= V_NMI_BLOCKING_MASK;
          else
                  vmcb01->control.int_ctl &= ~V_NMI_BLOCKING_MASK;

          if (vcpu->arch.nmi_pending) { ... V_NMI_PENDING_MASK ... }
  }

The guard is the global `vnmi` module capability, not
nested_vnmi_enabled(svm). The *ingress* side is gated correctly -- in
nested_vmcb02_prepare_control() the V_NMI_* bits are only pulled from vmcb12
when nested_vnmi_enabled(svm) is true (svm/nested.c ~888-896). The egress is
not symmetric: for an L1 that was NOT granted nested vNMI, KVM still overwrites
vmcb01's V_NMI_BLOCKING/V_NMI_PENDING from vmcb02 on every L2 round-trip, so
L1's own NMI-blocking/pending state (which KVM maintains in vmcb01's V_NMI for
such an L1) is clobbered by L2-derived bits.

Impact / class
--------------
L1-scoped fidelity (a VMEXIT-egress state-mismerge class). Victim is L1; not a
privilege boundary, not guest->host, AMD-only, and CONFIG_KVM_AMD is off on the
kvmCTF target, so this is upstream-hardening value rather than a bounty issue.

Suggested fix
-------------
Gate the egress copy on nested_vnmi_enabled(svm) to match the ingress, so a
non-nested-vNMI L1's V_NMI state in vmcb01 is left untouched across L2 entry/
exit. Happy to send the patch.

Read-confirmed against kvm-x86/next (tip of 2026-10-13); present in mainline
v7.3-rc6.

Thanks,
Amirmohammad
