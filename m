Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225B040B11C;
	Thu, 15 Oct 2026 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095725; cv=none; b=ZDKAb/Bm7iSLoaGzERwIx0qTB947ExP+pucYGOubUwHV/9w9jJ6+uvBaXnksDHXUuriZvTkTCqcbVQ7ikslm40GFXyWbbvOvs7tpBjDEP+MHRYOjwW0ybpP22FcPRVtYytks3YWFmpAQJbyg3y5rblQScSKSeqYhpmmhVLvIGuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095725; c=relaxed/simple;
	bh=bEu91svauhluwg9S2y0KXADLiIBC/AB0LG6RjLqH6c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trFOT9fIWxI+wh7051iBauBgw3RfX/39qx45s6kt+ZQHfcx2NrnfMbcRS8zwpxiyR4GUCo7IDofbi1SadqlMGLGUm35iOwksnSN9Q1XS2emp8YOyMKtREc3/vyHWUeg7TyRYFgFtc4HZz2kNgU7fIP0lZlS9LxQ+Hd4bnUkahQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hFgICQmR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hFgICQmR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792095721; x=1823631721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bEu91svauhluwg9S2y0KXADLiIBC/AB0LG6RjLqH6c0=;
  b=hFgICQmRIDkdFPmluNkmDwQwtS2gFR96Mof35lv/yGxwLp4/0AJlPzCt
   8fKmg0QzvwsFTe8CuEIsb4dkU/0KA4Y/QzxbZmMJtbL+qvd5LHXCCskcV
   9tdmqolIInWPyytqBfhGUsp8NA7K7rIcXS9ojZ/qRVaF2rvWBedpgvPtK
   /zk3Nu3whL4CpjcJDZh37vXzDNxWM4NxrI4D8qDXD9Z+cePkwoZ7SRvG3
   SoBzukRrsYxAmHs+HSh1OdSmKMvk2d9Z5DH7NvbDVKkXC2DeYKgdihENK
   zZzrZdrFSdxpbtg+D3VS28SeTlS8xmT2TST7/bkNQky38BCw53jU7YXRA
   A==;
X-CSE-ConnectionGUID: XELu0nDGR4+ZVEfAywY6Og==
X-CSE-MsgGUID: QudB3Z4LSjePSFFlpdngig==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="911082"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="911082"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 13:21:59 -0700
X-CSE-ConnectionGUID: A78hp7+pSwWlr4McVrY9qQ==
X-CSE-MsgGUID: DqlGilf+RgmM7Vb4ceElPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1844431"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa003.fm.intel.com with ESMTP; 15 Oct 2026 13:21:57 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: kvm@vger.kernel.org,
	x86@kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Chao Gao <chao.gao@intel.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Matlack <dmatlack@google.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Kishen Maloor <kishen.maloor@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Farrah Chen <farrah.chen@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 1/6] KVM: x86: Add an emulator flag to differentiate branch targets from fetches
Date: Thu, 15 Oct 2026 13:19:35 -0700
Message-ID: <20261015201940.1655956-2-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015201940.1655956-1-sohil.mehta@intel.com>
References: <20261015201940.1655956-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Binbin Wu <binbin.wu@linux.intel.com>

Add a new emulator flag, X86EMUL_F_BRANCH, and use it instead of
X86EMUL_F_FETCH in assign_eip() to distinguish between instruction fetch
and branch target computation for features that handle them differently.

For example, Linear Address Space Separation (LASS) applies to code
fetches but not branch target calculations. A LASS violation occurs only
when the branch target is used to fetch an instruction.

X86EMUL_F_BRANCH is still a code access, so add it to the code segment
readability check in __linearize() along with the Linear Address Masking
(LAM) untagging exemption in vmx_get_untagged_addr().

For now, X86EMUL_F_BRANCH and X86EMUL_F_FETCH are identical as far as
KVM is concerned. No functional change intended.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Kishen Maloor <kishen.maloor@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
---
v5:
 - Picked up Tested-by tags

v4:
 - Added LAM untagging exemption
 - Reworded the commit message
---
 arch/x86/kvm/emulate.c     | 5 +++--
 arch/x86/kvm/kvm_emulate.h | 1 +
 arch/x86/kvm/vmx/vmx.c     | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c1b21282187f..15872e722af8 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -654,7 +654,8 @@ static __always_inline int __linearize(struct x86_emulate_ctxt *ctxt,
 		    (flags & X86EMUL_F_WRITE))
 			goto bad;
 		/* unreadable code segment */
-		if (!(flags & X86EMUL_F_FETCH) && (desc.type & 8) && !(desc.type & 2))
+		if (!(flags & (X86EMUL_F_FETCH | X86EMUL_F_BRANCH)) &&
+		    (desc.type & 8) && !(desc.type & 2))
 			goto bad;
 		lim = desc_limit_scaled(&desc);
 		if (!(desc.type & 8) && (desc.type & 4)) {
@@ -705,7 +706,7 @@ static inline int assign_eip(struct x86_emulate_ctxt *ctxt, ulong dst)
 	if (ctxt->op_bytes != sizeof(unsigned long))
 		addr.ea = dst & ((1UL << (ctxt->op_bytes << 3)) - 1);
 	rc = __linearize(ctxt, addr, &max_size, 1, ctxt->mode, &linear,
-			 X86EMUL_F_FETCH);
+			 X86EMUL_F_BRANCH);
 	if (rc == X86EMUL_CONTINUE)
 		ctxt->_eip = addr.ea;
 	return rc;
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 10886bea82c9..0623637f923b 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -105,6 +105,7 @@ struct x86_instruction_info {
 #define X86EMUL_F_INVLPG		BIT(3)
 #define X86EMUL_F_MSR			BIT(4)
 #define X86EMUL_F_DT_LOAD		BIT(5)
+#define X86EMUL_F_BRANCH		BIT(6)
 
 struct x86_emulate_ops {
 	void (*vm_bugged)(struct x86_emulate_ctxt *ctxt);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b341af4c6057..04a9acf4a39a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8436,7 +8436,8 @@ gva_t vmx_get_untagged_addr(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags
 	int lam_bit;
 	unsigned long cr3_bits;
 
-	if (flags & (X86EMUL_F_FETCH | X86EMUL_F_IMPLICIT | X86EMUL_F_INVLPG))
+	if (flags & (X86EMUL_F_FETCH | X86EMUL_F_BRANCH | X86EMUL_F_IMPLICIT |
+		     X86EMUL_F_INVLPG))
 		return gva;
 
 	if (!is_64_bit_mode(vcpu))
-- 
2.43.0

