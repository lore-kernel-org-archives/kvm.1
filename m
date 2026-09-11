Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA54497B62;
	Fri, 11 Sep 2026 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162954; cv=none; b=tNcvM7Rl44XXWKHCaQlgrZTs/I5B4Lyb7/ptBCyRproZoZKdOFfbi2dHPcolScoWzZf+/tEnzGafJkLjf+FmB+SyI+h94sKm3oABq5YyRP7RoCXjDZdGbG+B+9sSezDHeSYd1MDls7+BqPiCOrpxjNK4UTTnCNn7rgmq10u8BdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162954; c=relaxed/simple;
	bh=g9xfFIN1eybrlbdeBNPLXC5TVFM8Kvup/yimqq6mDiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpjByyOnh0XRfa0SxTphKnOAJafMpGC6Mzlokusd7vsTt5Q1ZWqpE/AYPVgwxKvfHAONUm2j9kzWHGzv9zs0v7LFijM5zMhqK98pA1loieJYpfHqOn8BjRrh+r7Pd/lweHWWmdgd0nboapuSaeLkMldQyDg15DoY+4YG0StnPFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZfqffOTl; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZfqffOTl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789162951; x=1820698951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g9xfFIN1eybrlbdeBNPLXC5TVFM8Kvup/yimqq6mDiY=;
  b=ZfqffOTlUxhn0j2kCulcfMstar/88d4h+yHPpX9vKTgAfDl+YrCgKtQR
   jyLJ1AEJahySKsJkgApija3ogvAmDBxYHEPOqJlCSGTCx2abnbvaFln5X
   uI/c/asrkwEWZ8y+Yj65teC04kHtRAS0RewDUiEP24MbfwjvdvKSvADxO
   Fiawzv1peI1AsP5j/JlKfpP+EXczf+mnUosnOV7mfPRCmhgtKapxKDB/X
   0Uz7vFL2Nc/Zft+BB8tGc8lsstXeIjUFyFHkydIRu5605lIu74twN4Y7Y
   E72gXZuqdN1T8+bGQQepXdhpNdieXJoSBZ9nxdTtM0UL63mfOpx3NUN8i
   A==;
X-CSE-ConnectionGUID: 8W4BmMHFQwKWgHPfItMKfw==
X-CSE-MsgGUID: TsOAfeA5Tiym3g6Dcx+aHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572765"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572765"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:42:30 -0700
X-CSE-ConnectionGUID: 5H0pNPuTQ0m24jT5LNwtgw==
X-CSE-MsgGUID: TycCSzVRQPWm6hxDCswdhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272004180"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:42:29 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: kvm@vger.kernel.org,
	x86@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Yosry Ahmed <yosry@kernel.org>,
	David Matlack <dmatlack@google.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v10 17/28] KVM: x86: Handle CR4.FRED when emulating RSM
Date: Fri, 11 Sep 2026 14:36:47 -0700
Message-ID: <20260911213659.2025974-18-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911213659.2025974-1-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clear CR4.FRED before CR0.PG when leaving long mode on RSM, and restore
it only after CR0.PG has been set, the same way CR4.PCIDE is already
handled in both directions.

SMI delivery saves all 64 bits of CR4 and RSM restores them so CR4.FRED
survives SMM. But KVM emulates RSM as a series of individual register
writes, and so drives the vCPU through an intermediate state with
CR4.FRED set and EFER.LMA clear. kvm_set_cr4() rejects that combination,
so RSM of a 64-bit FRED guest fails with X86EMUL_UNHANDLEABLE.

Note, SMI delivery needs no such handling, as enter_smm() clears CR4 in
full via the vendor callback rather than kvm_set_cr4().

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - New patch
---
 arch/x86/kvm/smm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index 656a38dad7e7..a504e93fc5f5 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -435,10 +435,10 @@ static int rsm_enter_protected_mode(struct kvm_vcpu *vcpu,
 
 	/*
 	 * First enable PAE, long mode needs it before CR0.PG = 1 is set.
-	 * Then enable protected mode.	However, PCID cannot be enabled
-	 * if EFER.LMA=0, so set it separately.
+	 * Then enable protected mode. However, PCID and FRED cannot be
+	 * enabled if EFER.LMA=0, so set them separately.
 	 */
-	bad = kvm_set_cr4(vcpu, cr4 & ~X86_CR4_PCIDE);
+	bad = kvm_set_cr4(vcpu, cr4 & ~(X86_CR4_PCIDE | X86_CR4_FRED));
 	if (bad)
 		return X86EMUL_UNHANDLEABLE;
 
@@ -446,7 +446,7 @@ static int rsm_enter_protected_mode(struct kvm_vcpu *vcpu,
 	if (bad)
 		return X86EMUL_UNHANDLEABLE;
 
-	if (cr4 & X86_CR4_PCIDE) {
+	if (cr4 & (X86_CR4_PCIDE | X86_CR4_FRED)) {
 		bad = kvm_set_cr4(vcpu, cr4);
 		if (bad)
 			return X86EMUL_UNHANDLEABLE;
@@ -599,10 +599,14 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
 		struct kvm_segment cs_desc;
 		unsigned long cr4;
 
-		/* Zero CR4.PCIDE before CR0.PG.  */
+		/*
+		 * Zero CR4.PCIDE and CR4.FRED before CR0.PG, as neither can
+		 * be set while EFER.LMA is 0, and clearing CR0.PG clears
+		 * EFER.LMA.
+		 */
 		cr4 = kvm_read_cr4(vcpu);
-		if (cr4 & X86_CR4_PCIDE)
-			kvm_set_cr4(vcpu, cr4 & ~X86_CR4_PCIDE);
+		if (cr4 & (X86_CR4_PCIDE | X86_CR4_FRED))
+			kvm_set_cr4(vcpu, cr4 & ~(X86_CR4_PCIDE | X86_CR4_FRED));
 
 		/* A 32-bit code segment is required to clear EFER.LMA.  */
 		memset(&cs_desc, 0, sizeof(cs_desc));
-- 
2.43.0

