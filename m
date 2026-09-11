Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9174A4983;
	Fri, 11 Sep 2026 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162933; cv=none; b=r78s3uSQeg0jzvLzSm3ytJtw5wH7JCxPF+w5+fuuDOKYnVrtp7QGoba5k0JKIB8r42NgQLgvpPyBF5SgTIgqRh1fDts+F1IT4iYNa8rDEgBUNchFJ3wxPRuphfh8lyL1zlHEfIInNP7KXlJMstkLTdh0RgQ5Ozf8v7IOlOOCrxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162933; c=relaxed/simple;
	bh=uME2D72vWU1Qt9DlOEkO5iOKA32h3uQ2jXteCliDKSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3SyjZtPMkJgHHFRi1s33UZDl88EnsFh7QZrEa1aguHSR2X0cq25F2k52a2oBtarBdpBI15zFcSfOHfvwGWSVaNjsvWAZH2a4QVh7OYEnDTksHHB326a1Et3p3GYXNt/3SUmsdD9Ka3kGAJL3ppt7gbx0bmuYTiuD1I9HbJ7DJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pc+jKPkD; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pc+jKPkD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789162931; x=1820698931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uME2D72vWU1Qt9DlOEkO5iOKA32h3uQ2jXteCliDKSY=;
  b=Pc+jKPkDJ9XbCWT9JAUhBnBrF5osOMsqYV7ZjE8qq/N3YtdmZIoDzVTt
   zUnrVWHjVuvDiZB6GVGJNwUx6VPrwvwJbzaMXC/heDNZg457gUnuM530h
   0gQzG3WN+fEV8wg6Ao3F9Z/3Uy1G95rXoavH0pieT3N3I1bk0uBXf2YTj
   MIBzHyNyaDN5/m8t1LF1G+NSC0se0GlpPjHBoHJ5hYW8LzjYtM2EZng3N
   3Q3+egP69Rk++cyf3/LJAf1tG2qtVBfpm7CRH1uo04+HjO29s+nL4kgRX
   rzdvVD9iS/AUxOz9Iozvwatabx0Xq7NhUoPpjl7ZcffJ4DFkc8xdX3M1n
   Q==;
X-CSE-ConnectionGUID: DlAlWB/MTbOw0Q2Fz6XVZw==
X-CSE-MsgGUID: a27rVBCCRSKd9utpekRBEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572720"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572720"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:42:10 -0700
X-CSE-ConnectionGUID: PJcsdByjTx+GtKnOVUe8TQ==
X-CSE-MsgGUID: TuzcDgpYTIK4bm2tzHG+1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272004162"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:42:09 -0700
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
Subject: [PATCH v10 15/28] KVM: x86: Include CR4.FRED in the emulator CR4 write mask
Date: Fri, 11 Sep 2026 14:36:45 -0700
Message-ID: <20260911213659.2025974-16-sohil.mehta@intel.com>
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

From: Xin Li <xin@zytor.com>

Add CR4.FRED to the emulator's CR4 write mask.  Historically, CR4 was
restricted to its lower 32 bits in the x86 architecture.  With the
introduction of FRED, CR4 is expanded to use its higher 32 bits to
accommodate the FRED enablement bit at position 32.  Update the mask
to ensure the emulator correctly handles FRED initialization and
prevents the inadvertent truncation of high-order bits.

Signed-off-by: Xin Li <xin@zytor.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - New patch
---
 arch/x86/kvm/regs.h |  2 +-
 arch/x86/kvm/x86.c  | 12 +++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 4e641a6c20f9..ef46918daf43 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -8,7 +8,7 @@
 #define KVM_POSSIBLE_CR4_GUEST_BITS				  \
 	(X86_CR4_PVI | X86_CR4_DE | X86_CR4_PCE | X86_CR4_OSFXSR  \
 	 | X86_CR4_OSXMMEXCPT | X86_CR4_PGE | X86_CR4_TSD | X86_CR4_FSGSBASE \
-	 | X86_CR4_CET)
+	 | X86_CR4_CET | X86_CR4_FRED)
 
 #define X86_CR0_PDPTR_BITS    (X86_CR0_CD | X86_CR0_NW | X86_CR0_PG)
 #define X86_CR4_TLBFLUSH_BITS (X86_CR4_PGE | X86_CR4_PCIDE | X86_CR4_PAE | X86_CR4_SMEP)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e10ac6b280f6..f264bc9c35f9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5552,11 +5552,17 @@ static int emulator_set_dr(struct x86_emulate_ctxt *ctxt, int dr,
 	return kvm_set_dr(emul_to_vcpu(ctxt), dr, value);
 }
 
-static u64 mk_cr_64(u64 curr_cr, u32 new_val)
+static u64 mk_cr0_64(u64 curr_cr, u32 new_val)
 {
 	return (curr_cr & ~((1ULL << 32) - 1)) | new_val;
 }
 
+static u64 mk_cr4_64(struct kvm_vcpu *vcpu, u64 curr_cr, u64 new_val)
+{
+	u32 shift = guest_cpu_cap_has(vcpu, X86_FEATURE_FRED) ? 33 : 32;
+	return (curr_cr & ~((1ULL << shift) - 1)) | new_val;
+}
+
 static unsigned long emulator_get_cr(struct x86_emulate_ctxt *ctxt, int cr)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
@@ -5593,7 +5599,7 @@ static int emulator_set_cr(struct x86_emulate_ctxt *ctxt, int cr, ulong val)
 
 	switch (cr) {
 	case 0:
-		res = kvm_set_cr0(vcpu, mk_cr_64(kvm_read_cr0(vcpu), val));
+		res = kvm_set_cr0(vcpu, mk_cr0_64(kvm_read_cr0(vcpu), val));
 		break;
 	case 2:
 		vcpu->arch.cr2 = val;
@@ -5602,7 +5608,7 @@ static int emulator_set_cr(struct x86_emulate_ctxt *ctxt, int cr, ulong val)
 		res = kvm_set_cr3(vcpu, val);
 		break;
 	case 4:
-		res = kvm_set_cr4(vcpu, mk_cr_64(kvm_read_cr4(vcpu), val));
+		res = kvm_set_cr4(vcpu, mk_cr4_64(vcpu, kvm_read_cr4(vcpu), val));
 		break;
 	case 8:
 		res = kvm_set_cr8(vcpu, val);
-- 
2.43.0

