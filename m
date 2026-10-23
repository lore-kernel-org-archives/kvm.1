Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=134.76.10.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792775632;
	b=IrfktWNLtV1eFcD3UrIKVbYh0Xyb4vZiOokmgyvAhJz+Mm6AAOWDKHJeaS1f34DUPjvY
	 4Cq2tcgzXlouPLvraP/T87t2+ZdXHhaqba8n2fv9WfSGTFxNCKZEHn+KISjadjWhQtG6t
	 4LtLIrFsnBmWV0SGLEp/iSNdKCB9Qq4eq9tAv1NVD1rLwrtF3qhWKDV1xVOGpz89+T2qU
	 Z957uFrQ+SixLQsaimrl7vxACNKecSZHDIYyTFUd0Weh/6UyAGoUrrcKZC6q6gAG5O3zs
	 NEm3OyHJ0o3SBVWRRELW1qjUdmT+gCn3DomHj/GjTrec7icyR/6rVa5ukL/q2MWOppg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792775632;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Virus-Scanned:X-Spam-Level;
	bh=HgMYbhAoeaeOOZxtD9k9QZow02hV/8D2BFRu4aNQ2EE=;
	b=izxYaQQ/Rydjt7GVXSfw8ZfG8yUnSku7694eq1df0wYv7k4Ij7QT2+M1RZn/RtmKnlMb
	 y6WciT6D2Rk+pzReOwYDI2I/x3hz8nDUIsGlnperuM3BxMDokbiIJkOTfCUbDiWIDY9kk
	 hUlezbd9vhwxwSqvn1XNYCA+VeGVCgYXQS2t1NLBnuYyHD6gXwV/LcoHC77F3Su2U2CZ8
	 TucorQcEuO9JEIWfbgDka/grOKhKoie6Dxbw4O31SU5ZuuETz6dzpU07LEwg8sAyToDKw
	 i8s568MkjAuzOJ7Datc6CAdmf7SgOuOuiJnypTYLzwUqZ1CxAnuB5GQdYJwYIHQ53QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cispa.de;
	spf=pass smtp.mailfrom=cispa.de;
	dkim=pass header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=Lvr6nhY4;
	arc=none smtp.remote-ip=134.76.10.21
Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F5660A2631;
	Fri, 23 Oct 2026 17:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17F5660A2631
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cispa.de header.i=@cispa.de header.a=rsa-sha256 header.s=2023-rsa header.b=Lvr6nhY4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HgMYbhAoeaeOOZxtD9k9QZow02hV/8D2BFRu4aNQ2EE=; b=Lvr6nhY4RY7QWlQsJiyfS/SU/r
	wr71tROMOoZX0Ve5Pj27DypsLxlUyaH5yl0pSRxKuIYu+DHh4FNrfrJUk5CZ3JQan41/7R6YqVb+y
	zVYlsWBoJtusMNTtrGGhChaC588IprqZpMuVfWq6QeSFkIHqTw2SO13GuuBPk2f28f38do9INXjxa
	OMjn2T6tMN9rUPA86Y7DDAmJFWzcxjXt7ivoHHi3da9Hph0wGYisObpZCp2z3i/wcQaG6wvgNOyOr
	y10jvUdfAuX+NJ4v3JJ8ADs9mOeYUHt5J3NQL8j4OdaQVfSwHJcAKyVGQQ7khK/i8CqB6lZKPPjHs
	u0U7MRqQ==;
Received: from mailer.gwdg.de ([134.76.10.26]:47115)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xKIpx-00Emw8-2p;
	Fri, 23 Oct 2026 19:13:49 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xKIpx-000M9b-1U;
	Fri, 23 Oct 2026 19:13:49 +0200
Received: from localhost (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 23 Oct
 2026 19:13:42 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>
CC: Maxim Levitsky <mlevitsk@redhat.com>, Santosh Shukla
	<santosh.shukla@amd.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <amirmohammad.eftekhar@cispa.de>
Subject: [BUG] KVM: nSVM: vNMI vmcb02->vmcb01 egress runs for a non-nested-vNMI L1 (gated on global vnmi, not nested_vnmi_enabled)
Date: Fri, 23 Oct 2026 19:13:26 +0200
Message-ID: <20261023171326.636988-1-amirmohammad.eftekhar@cispa.de>
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
