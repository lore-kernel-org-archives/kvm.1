Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1F230AAD8;
	Mon,  5 Oct 2026 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228024; cv=none; b=HjY0fK5ik9+U5FMnOwY04bv19GtqaqUVlB+zXDMir70oWnq8nv4AJXoIW8Z7Itku5h+MVOi3iSya+VPsXueduv8SCd1Rsn8z77KedG41OiVUjiGaKvleHGuGCLVcjqG3oMChTgzQwJ9Ckt2dUWigBfN1ykGmVbofYioXFhMF96o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228024; c=relaxed/simple;
	bh=SrLUQHaTErXY75ovh1E+cHDPNatBH3CZnT4ipuUVkH0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jN1aGIdnNA4NGi8JOLTvvCT16wYjFBmTOz0qjjPUZD6laupyx2OpV8c0hXTrD+0/gLwSnAtdCUKHoiZwIlhY6YQA7PNoi7d4LzEH0hijiDxSYxdM43rUlx4Z5Wlh4vVOBE3HHNVRYE5qkWpNbRyQM9X4Wlg9SNBziDLW2IA9mV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=efvtBDTE; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="efvtBDTE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1791228022; x=1822764022;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D8mW2fWN8EvSGyuK4guDuczx+whRKJ16nzLe2cDa1pA=;
  b=efvtBDTEbdzZFUv7l/n0hWXNVnXemAadq3EggfzKqV3Fy9+o3dwsG0kN
   Snj8I24rgpRT0+moai+rOZIOSi8ij9rsgojXskug/altlqbekF1ZA8eXk
   wyDxS4532p+5AtT+gIs1DasJBRBDjW/ji2iiwD2tbQ4V02lVIAFjEsZtg
   HkTykjsQO5KXGEwkI/46CwYl4b1Xi+T6/YOh4SX3SLelRwb4EVtpVMggu
   +S9Nebsqnnt8JrhKcYMjHlC6foaFtNf2cm7UXGYaxcFjEDTTaYhjTQoRj
   D60tDfKdPGLL9A/AXTY1wbibifWykHtZnL0P3NH9nysIu/tXSDdcXlP9B
   g==;
X-CSE-ConnectionGUID: 1bjJ9ktQRRCDHQXwR29h4A==
X-CSE-MsgGUID: RsqX0UpATYiF6p36OQis7g==
X-IronPort-AV: E=Sophos;i="6.27,142,1787011200"; 
   d="scan'208";a="30507217"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 19:20:19 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:17183]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.164:2525] with esmtp (Farcaster)
 id f12a0637-e7a1-4e4d-a1b9-2d0dafe6d759; Mon, 5 Oct 2026 19:20:19 +0000 (UTC)
X-Farcaster-Flow-ID: f12a0637-e7a1-4e4d-a1b9-2d0dafe6d759
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Mon, 5 Oct 2026 19:20:19 +0000
Received: from dev-dsk-hmushi-1a-0c348132.eu-west-1.amazon.com
 (172.19.124.218) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49; Mon, 5 Oct 2026
 19:20:17 +0000
From: Mushahid Hussain <hmushi@amazon.co.uk>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>, <mushi.shar@gmail.com>
Subject: [PATCH] KVM: x86/mmu: Fail nested EPT walks for GPAs beyond the EPT width
Date: Mon, 5 Oct 2026 19:20:10 +0000
Message-ID: <20261005192010.66037-1-hmushi@amazon.co.uk>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Fail the nested EPT walk when the L2 guest-physical address has bits
above the width of L1's EPT. The width is 48 bits for a 4-level EPT
and 57 bits for a 5-level EPT. Report no RWX bits in the exit
qualification, as for a translation that no table entry provides. L1
then handles the EPT violation itself.

Hardware signals an EPT violation for such an address without a table
walk. KVM's shadow walker instead indexes the tables with PT_INDEX(),
which drops the high bits. The walk resolves the aliased address and
KVM installs a shadow mapping for the alias. The CPU faults on the
original address again, and KVM repeats the walk without end. L1 does
not see an EPT violation for the access, and the L2 vCPU is stuck.

Any L2 that references an address at or above 2^48 under a 4-level
EPT triggers the hang. The easy way to get there is a MAXPHYADDR that
differs between L1 and the host. Take L1 MAXPHYADDR 48 on a 52-bit
host with KVM's default allow_smaller_maxphyaddr=0. A PTE bit that L1
treats as reserved is then valid for the CPU. kvm-unit-tests "access"
and "vmx_pf_exception_test", run as L2 under an L1 KVM with MAXPHYADDR
48, hang at the first present PTE with bit 51 set.

Fixes: 37406aaaeebc ("nEPT: Add EPT tables support to paging_tmpl.h")
Assisted-by: Claude:claude-fable-5.1
Signed-off-by: Mushahid Hussain <hmushi@amazon.co.uk>
---
Reproducer:
  L1: KVM, CPUID MAXPHYADDR 48, 4-level EPT.
  Host: 52-bit MAXPHYADDR, allow_smaller_maxphyaddr=0.
  L2: kvm-unit-tests "access" and "vmx_pf_exception_test" under QEMU.
      Both set a PTE with bit 51, which L1 treats as reserved and the
      CPU treats as an address bit.

Without the patch both tests hang at the first such PTE. L1 sees no
EPT violation.

With the patch L1 receives the EPT violation. Both tests pass with the
bit-51 cases excluded, as access.c does for MAXPHYADDR >= 52. This holds
with ept=1 and ept=0.

 arch/x86/kvm/mmu/paging_tmpl.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 8e350095508c5..6ba4439e56b10 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -378,6 +378,21 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	    KVM_BUG_ON(walker->max_level > PT_MAX_FULL_LEVELS, vcpu->kvm))
 		goto error;
 
+#if PTTYPE == PTTYPE_EPT
+	/*
+	 * EPT translates 48-bit guest-physical addresses with 4-level tables
+	 * and 57-bit ones with 5-level tables; hardware raises an EPT
+	 * violation for an address with bits above that width without
+	 * consulting the tables.  PT_INDEX() drops those bits, so walking
+	 * would resolve the aliased address and the shadow mapping built for
+	 * it can never satisfy the CPU.  Fail the walk the way hardware does.
+	 */
+	if (unlikely(addr >> (PAGE_SHIFT + walker->level * PT_LEVEL_BITS))) {
+		pte_access = 0;
+		goto error;
+	}
+#endif
+
 	++walker->level;
 
 	do {

base-commit: 6bd2905303c58679e303941b7d8ae8c074cd95ce
-- 
2.47.3

