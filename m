Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957D438B157;
	Thu,  6 Aug 2026 01:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785979126; cv=none; b=OpFTM+3ngJsdwkPmb29b6eqmIcA38dmCJshMYveLdfRpnQYRGXT9urwgyUPJTHxZhrIdNYJHudb+6m+tVqOz2SH4mKdMhqPxV7bp3xpt/mpAQc8mZrN6vI9rm0clgzezXK7CnVOfKyYWmWQug/beofnw5qrqelXi6VRyA6/6vww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785979126; c=relaxed/simple;
	bh=Knn5l140lFqaaJ/Gr+gnBzcJZqTLYOqtJFCFTuDq9ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1SZuhd7TzRBlyH3nO4mUNzitXlX17iu5gPHA6zqyJaOhOrzPOGVaR+5QX567DvtdwqWudNUefPvYJg8D3Mn6LVfOR8u5nk9gAMutfqPeSk2QAwzL9CiWL6fYrLDYavO1Yi4f224wgbRE59oWHeSKf1c4Ij2GSdkftmZN3HG5WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mmHf4mZR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mmHf4mZR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785979124; x=1817515124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Knn5l140lFqaaJ/Gr+gnBzcJZqTLYOqtJFCFTuDq9ao=;
  b=mmHf4mZRleuw6OYxCzg9NwF5InecaJnIxjsWAFINZ1pmW3dP7ZKSroC7
   IsNn8cWsb1KPJgXTg65W5q17+JZalW1B6jb9p0XPrf1ZpzzGT2xEX4ki1
   vVlG7O2IRUeR+Tl8xzxZqkozD87xWQXQ4cYgHW+1mM7VqTXmsTDk/pm+v
   5PTxCPmjNSUkgBbQQC+VLti/h3b2eXuNt6hGpfqEVVFWDqNuYfZtK3un4
   rqjmmnzr536Gt6qZlrTgaY1pIuSI+16TIei6yyQlN8wNVate7tYKvh19X
   +NkgG6VpMuuFIrMzhcgIjFjWio5YLIPxxU87JWMgMBHX+CQcvM31kReMW
   A==;
X-CSE-ConnectionGUID: Ki4RSQkVQ8a7oDBU/6kY0Q==
X-CSE-MsgGUID: BHijKYlBTSSpWKd3kmHsSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86593970"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="86593970"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 18:18:43 -0700
X-CSE-ConnectionGUID: ZJdDaGpwRdKP80VJGSfoyg==
X-CSE-MsgGUID: L5tTlltwQWeRSQEl3SX43Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="265804607"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa004.jf.intel.com with ESMTP; 05 Aug 2026 18:18:43 -0700
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
	Sohil Mehta <sohil.mehta@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 1/7] KVM: x86: Add an emulator flag to differentiate branch targets from fetches
Date: Wed,  5 Aug 2026 18:15:30 -0700
Message-ID: <20260806011536.4172258-2-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806011536.4172258-1-sohil.mehta@intel.com>
References: <20260806011536.4172258-1-sohil.mehta@intel.com>
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
---
v4:
 - Added LAM untagging exemption
 - Reworded the commit message
---
 arch/x86/kvm/emulate.c     | 5 +++--
 arch/x86/kvm/kvm_emulate.h | 1 +
 arch/x86/kvm/vmx/vmx.c     | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 8071b372d233..8ff28643b2e3 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -672,7 +672,8 @@ static __always_inline int __linearize(struct x86_emulate_ctxt *ctxt,
 		    (flags & X86EMUL_F_WRITE))
 			goto bad;
 		/* unreadable code segment */
-		if (!(flags & X86EMUL_F_FETCH) && (desc.type & 8) && !(desc.type & 2))
+		if (!(flags & (X86EMUL_F_FETCH | X86EMUL_F_BRANCH)) &&
+		    (desc.type & 8) && !(desc.type & 2))
 			goto bad;
 		lim = desc_limit_scaled(&desc);
 		if (!(desc.type & 8) && (desc.type & 4)) {
@@ -723,7 +724,7 @@ static inline int assign_eip(struct x86_emulate_ctxt *ctxt, ulong dst)
 	if (ctxt->op_bytes != sizeof(unsigned long))
 		addr.ea = dst & ((1UL << (ctxt->op_bytes << 3)) - 1);
 	rc = __linearize(ctxt, addr, &max_size, 1, ctxt->mode, &linear,
-			 X86EMUL_F_FETCH);
+			 X86EMUL_F_BRANCH);
 	if (rc == X86EMUL_CONTINUE)
 		ctxt->_eip = addr.ea;
 	return rc;
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 3e375af15c03..97421b8dde13 100644
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
index e3bfe6aca1a0..973f7e95be65 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8571,7 +8571,8 @@ gva_t vmx_get_untagged_addr(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags
 	int lam_bit;
 	unsigned long cr3_bits;
 
-	if (flags & (X86EMUL_F_FETCH | X86EMUL_F_IMPLICIT | X86EMUL_F_INVLPG))
+	if (flags & (X86EMUL_F_FETCH | X86EMUL_F_BRANCH | X86EMUL_F_IMPLICIT |
+		     X86EMUL_F_INVLPG))
 		return gva;
 
 	if (!is_64_bit_mode(vcpu))
-- 
2.43.0

