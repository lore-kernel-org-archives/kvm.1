Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571133ED112;
	Tue,  3 Feb 2026 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142674; cv=none; b=B3ZjHTVX9AlaFaoG/vvcrtcpRV1/OWdPFO1aryizbIYHfFRR00+sABu+SflfieHliNwIYZ8fbYB/hg1aa1atnM1iI1qFKWJN9MoTXkQ+SWAlMS/nA+OtAuULASm/1g+wq01065KhwGgh/TQKTiJJrh7dNeBk+XyIsm6zyBoJ9Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142674; c=relaxed/simple;
	bh=Xp9vVVC9VmSIjmyuA7qa6qei/ZbOzg/Sj/hvegc3Ao8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rykYQVQoiMsooAjuDwPmuw3scsb+aELCEsrjnzPPbOwJlmoKGVaX2U+z+NrWrCBzK06weSJEnf5E9W9PU6uxksSWwp+f81hRv+u7xU2XyECGVRtvbtk907yGptn7LMSHqSWO4Cdl5KvLqZZNWTYJOG5ChZDiHX1805itgEMwFVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KInTC9tL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KInTC9tL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770142673; x=1801678673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xp9vVVC9VmSIjmyuA7qa6qei/ZbOzg/Sj/hvegc3Ao8=;
  b=KInTC9tLxmVvYOWTDECmRGwEAHHqO+xArMduOeED7oMG8Uhc3ZG1QZXS
   pkeAk9jeyu/ZEXYEPioXVP3BXngayRRez+aL6e/5nfn/Uf9qex7da7KIF
   kRdE0qRhc/zBK9WXDh099WH/8avEQlM7GAICRxN82uUtq3D+YNi0hAjZL
   yJRPN2Xd5tywfUctD1ELqj5aLdWZVjBXQdSIlk7Ev7XVyajiSOM6izEhK
   NXu4w5QFRxPQsCfAXpwT+rsXdIe8iEu7cq+MWny5Ny9v0a5omPCHTMvA8
   zaGLB0sQQo7EPzDvPh6TnOiKe/WOyytB/rYpv8v0Q10P49dLerY9crsAz
   g==;
X-CSE-ConnectionGUID: opTjxPAWQLazoquhQM81vg==
X-CSE-MsgGUID: ZnmHevydTYeuNd8cAeuarg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="88745862"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="88745862"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 10:17:47 -0800
X-CSE-ConnectionGUID: JpN5z5EzR5G1EXujeqLJwQ==
X-CSE-MsgGUID: Xa68/UmEQlSxZfzIe+d7HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="209605533"
Received: from khuang2-desk.gar.corp.intel.com (HELO localhost) ([10.124.221.188])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 10:17:46 -0800
From: isaku.yamahata@intel.com
To: kvm@vger.kernel.org
Cc: isaku.yamahata@intel.com,
	isaku.yamahata@gmail.com,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 26/32] KVM: selftests: Add test for nVMX MSR_IA32_VMX_PROCBASED_CTLS3
Date: Tue,  3 Feb 2026 10:17:09 -0800
Message-ID: <94e3f8de4021620758a213721d05e65437cdf4da.1770116051.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1770116050.git.isaku.yamahata@intel.com>
References: <cover.1770116050.git.isaku.yamahata@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Isaku Yamahata <isaku.yamahata@intel.com>

Add test case for nVMX MSR_IA32_VMX_PROCBASED_CTLS3 emulation.  Test if the
access to MSR_IA32_VMX_PROCBASED_CTLS3 to succeed or fail, depending on
whether the vCPU supports it or not.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 .../testing/selftests/kvm/x86/vmx_msrs_test.c | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/vmx_msrs_test.c b/tools/testing/selftests/kvm/x86/vmx_msrs_test.c
index 90720b6205f4..3ec5b73b4f2f 100644
--- a/tools/testing/selftests/kvm/x86/vmx_msrs_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_msrs_test.c
@@ -48,6 +48,11 @@ static void vmx_fixed0and1_msr_test(struct kvm_vcpu *vcpu, uint32_t msr_index)
 
 static void vmx_save_restore_msrs_test(struct kvm_vcpu *vcpu)
 {
+	union vmx_ctrl_msr ctls;
+	const struct kvm_msr_list *feature_list;
+	bool ctl3_found = false;
+	int i;
+
 	vcpu_set_msr(vcpu, MSR_IA32_VMX_VMCS_ENUM, 0);
 	vcpu_set_msr(vcpu, MSR_IA32_VMX_VMCS_ENUM, -1ull);
 
@@ -65,6 +70,54 @@ static void vmx_save_restore_msrs_test(struct kvm_vcpu *vcpu)
 	vmx_fixed0and1_msr_test(vcpu, MSR_IA32_VMX_TRUE_EXIT_CTLS);
 	vmx_fixed0and1_msr_test(vcpu, MSR_IA32_VMX_TRUE_ENTRY_CTLS);
 	vmx_fixed1_msr_test(vcpu, MSR_IA32_VMX_VMFUNC, -1ull);
+
+	ctls.val = kvm_get_feature_msr(MSR_IA32_VMX_PROCBASED_CTLS);
+	TEST_ASSERT(!(ctls.set & CPU_BASED_ACTIVATE_TERTIARY_CONTROLS),
+		    "CPU_BASED_ACTIVATE_TERTIARY_CONTROLS should be cleared.");
+
+	feature_list = kvm_get_feature_msr_index_list();
+	for (i = 0; i < feature_list->nmsrs; i++) {
+		if (feature_list->indices[i] == MSR_IA32_VMX_PROCBASED_CTLS3) {
+			ctl3_found = true;
+			break;
+		}
+	}
+
+	if (ctls.clr & CPU_BASED_ACTIVATE_TERTIARY_CONTROLS) {
+		uint64_t kvm_ctls3, ctls3;
+
+		TEST_ASSERT(ctl3_found,
+			    "MSR_IA32_VMX_PROCBASED_CTLS3 was not in feature msr index list.");
+
+		kvm_ctls3 = kvm_get_feature_msr(MSR_IA32_VMX_PROCBASED_CTLS3);
+		ctls3 = vcpu_get_msr(vcpu, MSR_IA32_VMX_PROCBASED_CTLS3);
+		TEST_ASSERT(kvm_ctls3 == ctls3,
+			    "msr values for kvm and vcpu must match.");
+
+		vcpu_set_msr(vcpu, MSR_IA32_VMX_PROCBASED_CTLS3, 0);
+		vcpu_set_msr(vcpu, MSR_IA32_VMX_PROCBASED_CTLS3, ctls3);
+		vmx_fixed1_msr_test(vcpu, MSR_IA32_VMX_PROCBASED_CTLS3, ctls3);
+
+		/*
+		 * The kvm host should be able to get/set
+		 * MSR_IA32_VMX_PROCBASED_CTLS3 irrespective to the bit
+		 * CPU_BASED_ACTIVATE_TERTIARY_CONTROLS of
+		 * MSR_IA32_VMX_TRUE_PROCBASED_CTLS.
+		 */
+		ctls.val = vcpu_get_msr(vcpu, MSR_IA32_VMX_TRUE_PROCBASED_CTLS);
+		vcpu_set_msr(vcpu, MSR_IA32_VMX_TRUE_PROCBASED_CTLS,
+			     ctls.set & ~CPU_BASED_ACTIVATE_TERTIARY_CONTROLS);
+		vcpu_set_msr(vcpu, MSR_IA32_VMX_PROCBASED_CTLS3, 0);
+		vcpu_set_msr(vcpu, MSR_IA32_VMX_PROCBASED_CTLS3, ctls3);
+		vmx_fixed1_msr_test(vcpu, MSR_IA32_VMX_PROCBASED_CTLS3, ctls3);
+		vcpu_set_msr(vcpu, MSR_IA32_VMX_TRUE_PROCBASED_CTLS, ctls.val);
+	} else {
+		TEST_ASSERT(!ctl3_found,
+			    "MSR_IA32_VMX_PROCBASED_CTLS3 was in feature msr index list.");
+
+		TEST_ASSERT(!_vcpu_set_msr(vcpu, MSR_IA32_VMX_PROCBASED_CTLS3, 0),
+			    "setting MSR_IA32_VMX_PROCBASED_CTLS3 didn't fail.");
+	}
 }
 
 static void __ia32_feature_control_msr_test(struct kvm_vcpu *vcpu,
-- 
2.45.2

