Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089243603E0;
	Mon, 18 May 2026 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112962; cv=none; b=ISBZ+ZVH1aHBH2U0bDAOwZ5zxu+m713SVZvVIuDWFfGK6wdz/eTJX2wx71RMvydMxA+/ZpcpP2itnvV75/rBDuss6N16UcQHNdvrLB1WyQh1KdFX2Y1Rt75FmQ486md9ER+azr2EqiTvg70py5Qtq0yfT9MFACdJ9+EMyysN0V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112962; c=relaxed/simple;
	bh=MBOe3M8vC36FSXeMstxja8WsC6C5ofZEdm1O6XyYQHg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=byMhh5GuyiTlZMJRF9nKRQ5b96U5tvQOm4yAd2eQQkRjWR/34K/UN2ZJmWdIS2D1DiqXYpA5dGuSbLTjjDQDwe0vpnzNkehXLfll1YkwSSWjMPo1Nbo9yEzIXBIz5quDfkwLzoalxo4CTg/FDTy4tBM/7HPm3quIweyzDEs55Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=DVz8fyVc; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="DVz8fyVc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1779112961; x=1810648961;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2Wgj2cmiHagcd8CnnxIkijliXY8iTZAznD+B4zMkJaA=;
  b=DVz8fyVc3RtjtEOx5Mbb1v3sOAocM209rNsmMABn6Kz0WcBj7OCyDNWr
   JSucjPTw/FemJ2OsIOiHqbxcQ8DFCQ/QjROgzCFV664VJGSJng5n9TPER
   E2Ujd8Uw30W0TevdSH2bDYkrkDsvzAAosRgqICBvWzee90/xEcfGxlDPU
   f2G+P4cM36mcB3PA0QE7AAMPt16NnwgQvSbeCvN6SKC9iGTTDMP2Kygai
   5W4NIdk4uTRIKGcTEWVtnaKFiKwUX45JgtxsiIaUJRAikU5KQIqsiDZN/
   Sw6zijEDWJswblBHx0Xb8QjEznv8qlpuNqakTskj2nlHBKzOTlcKj/PBn
   Q==;
X-CSE-ConnectionGUID: XVKELTxtT/aSGO/lwRoU9A==
X-CSE-MsgGUID: lvZ6S6D7QHmReVaYPiTPug==
X-IronPort-AV: E=Sophos;i="6.23,242,1770595200"; 
   d="scan'208";a="19697606"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 14:02:38 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:27410]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.141:2525] with esmtp (Farcaster)
 id a87cb414-3d81-4d43-9577-c149ac370216; Mon, 18 May 2026 14:02:37 +0000 (UTC)
X-Farcaster-Flow-ID: a87cb414-3d81-4d43-9577-c149ac370216
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 18 May 2026 14:02:37 +0000
Received: from dev-dsk-ehemily-1c-401a2257.eu-west-1.amazon.com
 (10.253.103.254) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 18 May 2026
 14:02:34 +0000
From: Emily Ehlert <ehemily@amazon.de>
To: <seanjc@google.com>, <pbonzini@redhat.com>
CC: <amit.shah@amd.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<x86@kernel.org>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>, <graf@amazon.de>, <nsaenz@kernel.org>, "Emily
 Ehlert" <ehemily@amazon.de>
Subject: [PATCH] KVM: x86: Fix ERAPS RAP clear on INVPCID single-context invalidation
Date: Mon, 18 May 2026 13:59:56 +0000
Message-ID: <20260518135956.82569-1-ehemily@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use kvm_register_mark_dirty() instead of kvm_register_is_dirty() to
actually mark VCPU_EXREG_ERAPS as dirty when emulating
INVPCID_TYPE_SINGLE_CTXT.  kvm_register_is_dirty() is a read-only
predicate whose return value is discarded, making the call a no-op.
Without this fix, a single-context INVPCID will not trigger a RAP clear
on the next VMRUN, breaking the ERAPS security guarantee.

Fixes: db5e82496492 ("KVM: SVM: Virtualize and advertise support for ERAPS")
Signed-off-by: Emily Ehlert <ehemily@amazon.de>
---
Hi,
we recently discovered a SVM bug where ERAPS are not properly cleared,
this may have security implications. I attached an AI assisted security
analysis.

The bug is reachable when INVPCID is intercepted while ERAPS is exposed
to the guest. When NPT is disabled then INVPCID is always intercepted
when shadow paging is acive. ERAPS can I think be active while NPT is
disabled (commit does not guard against it). So when triggered the
consequence is that the guest retains stale RAP entries after the
INVPCID call. A malicious guest could exploit this to speculatively
influence return predictions of another process within the same guest
underminding the ERAP security gurantee that the RAP is cleared in the
PCID invalidation.

Severity: Low-Medium.  Exploitation requires either an unusual host
configuration (npt=0, which is primarily a debugging mode) or a nested
virtualization setup with a cooperative L1 hypervisor.  The attack is
intra-guest (guest process vs. guest kernel), not guest-to-host, since
ERAPS hardware tagging still separates host and guest RAP entries.

 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fd1c4a36b5936..181a78c30260d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -14207,7 +14207,7 @@ int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsigned long type, gva_t gva)
 		 * the RAP (Return Address Predicator).
 		 */
 		if (guest_cpu_cap_has(vcpu, X86_FEATURE_ERAPS))
-			kvm_register_is_dirty(vcpu, VCPU_EXREG_ERAPS);
+			kvm_register_mark_dirty(vcpu, VCPU_EXREG_ERAPS);
 
 		kvm_invalidate_pcid(vcpu, operand.pcid);
 		return kvm_skip_emulated_instruction(vcpu);
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

