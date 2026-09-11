Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AB0497B96;
	Fri, 11 Sep 2026 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789163024; cv=none; b=CKurdllmC9MNI4aaJKdoIT0gE/kV1cOiotqEK+WugnKW3ZSx8K5m29lG+KxDPWhbGpMH5TZgNJL39YuOMRAX5IiGkEv5MUKiDZfj/aJeAy7E//b+VCP+S94vqbi+jfMph86a77O2azC6L36DE77E5iDCHRUDaxk1jKL5D8d6Gnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789163024; c=relaxed/simple;
	bh=u/9qQB+51ZA54dIgotA961NlEY+IOivKPseuq1clEso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=De+3/5J1Uy+T5BLTICj8p2HAb9/l6oP1q0kBqAwUJI0VG+7GOaMyacpsbc6PsZHXJGPhmEOU6wLPURRnNrR/D5NznXIsIofqlRTax7AXrPgjVpWsKX3LQsXmtE2HUPz9SPNUIkhOr2UH5RPQMYO+2BXyZTrbYGQznQl7C9Nz/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HajxN4B2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HajxN4B2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789163022; x=1820699022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u/9qQB+51ZA54dIgotA961NlEY+IOivKPseuq1clEso=;
  b=HajxN4B2UqebvQxhsydi1k/6lR0QsUt4wcM67H/JX1955XIhEnlbqZ6P
   Ff5mKo+dZ6VVX7ywjtuoWCVhDogzkZpBW+ptxOcWs6H26p6LoBfixF1nj
   rxM5iGyO0l85JX7pEaGbc0x0f/xiYSwPHcGQ9TSx+D+DhaHdY4r3ZapOR
   cmgsHiNot5KVVRcVb7+pionJ0NA5APB80fk8bqrNVIH6JXxUEQ9bhtzbo
   B3nHhStA3PaYUs0HfJaqoIuIf8BcZGbO4JqHhE+7taVtACXgsbvTWwNS+
   PW0Ytb+7t7fmhETWK78yPUeb12Z8OmqAZS+64fU3e51nbjDA96P/0cdD3
   w==;
X-CSE-ConnectionGUID: dC7GaMFESViUi8k0ryGxCg==
X-CSE-MsgGUID: S2v95pE/SDC3Oh0C178IyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572919"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572919"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:43:42 -0700
X-CSE-ConnectionGUID: 755rMGAsRjuRGYyz/NwHjg==
X-CSE-MsgGUID: X5BupmnMQd61URu1z532xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272004338"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:43:41 -0700
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
Subject: [PATCH v10 25/28] KVM: nVMX: Enable VMX FRED controls
Date: Fri, 11 Sep 2026 14:36:55 -0700
Message-ID: <20260911213659.2025974-26-sohil.mehta@intel.com>
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

From: "Xin Li (Intel)" <xin@zytor.com>

Permit use of VMX FRED controls in nested VMX now that support for nested
FRED is implemented.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
---
v10:
 - Remove an obsolete comment (Chao).
---
 arch/x86/kvm/vmx/nested.c | 10 +++-------
 arch/x86/kvm/vmx/vmx.c    |  1 +
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 3e0a1ed6440d..4fad9728a2ea 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -7371,12 +7371,8 @@ static void nested_vmx_setup_exit_ctls(struct vmcs_config *vmcs_conf,
 
 	if (msrs->exit_ctls_high & VM_EXIT_ACTIVATE_SECONDARY_CONTROLS) {
 		msrs->secondary_exit_ctls = vmcs_conf->vmexit_2nd_ctrl;
-		/*
-		 * As the secondary VM exit control is always loaded, do not
-		 * advertise any feature in it to nVMX until its nVMX support
-		 * is ready.
-		 */
-		msrs->secondary_exit_ctls &= 0;
+		msrs->secondary_exit_ctls &= SECONDARY_VM_EXIT_SAVE_IA32_FRED |
+					     SECONDARY_VM_EXIT_LOAD_IA32_FRED;
 	}
 }
 
@@ -7392,7 +7388,7 @@ static void nested_vmx_setup_entry_ctls(struct vmcs_config *vmcs_conf,
 		VM_ENTRY_IA32E_MODE |
 #endif
 		VM_ENTRY_LOAD_IA32_PAT | VM_ENTRY_LOAD_BNDCFGS |
-		VM_ENTRY_LOAD_CET_STATE;
+		VM_ENTRY_LOAD_CET_STATE | VM_ENTRY_LOAD_IA32_FRED;
 	msrs->entry_ctls_high |=
 		(VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR | VM_ENTRY_LOAD_IA32_EFER |
 		 VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 3a3315a7fc11..f673cd4e8956 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8150,6 +8150,7 @@ static void nested_vmx_cr_fixed1_bits_update(struct kvm_vcpu *vcpu)
 
 	entry = kvm_find_cpuid_entry_index(vcpu, 0x7, 1);
 	cr4_fixed1_update(X86_CR4_LAM_SUP,    eax, feature_bit(LAM));
+	cr4_fixed1_update(X86_CR4_FRED,       eax, feature_bit(FRED));
 
 #undef cr4_fixed1_update
 }
-- 
2.43.0

