Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E5D3ED120;
	Tue,  3 Feb 2026 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142674; cv=none; b=tg9O+b7RyXS52CI6T29LStOizM2s2HFyIn3cQCsgKTvFxpNKZyVzlGu7zjMdfs20JbdFxt4qwozMdivxYW9Mj4LMxiHdNZOkPC/wPdZAtwVr91RK/5OkK8k6Fu1qH/6QXgBDObTNeFB3gpL5AJ4i9pJ2mTaOH2+p/rZnGm72jiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142674; c=relaxed/simple;
	bh=MTUlsvIH1AkRzwWJPF1ATD3Q1XzZXcMIgmLGy8/GHBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oS1bkC7aMt2Q9sVW8E+kFTRWxk/vZ00aAeUXgE0UGOUFCQPAWLKGOaBaJmsT1L0ePzBCIc1RQePBXe65+HLszvoyv+DCKegCuAzcIPQyInLTWNI3UFS8T0krth/DJwdBHMbwEvgLQ41gFeqJWxFLaiTvI8rZqJ9CF/s+S0pKZEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hxX8nFLR; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hxX8nFLR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770142673; x=1801678673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MTUlsvIH1AkRzwWJPF1ATD3Q1XzZXcMIgmLGy8/GHBA=;
  b=hxX8nFLR//vXwEsUtnXx9l7jP4tlB1RaE3gSgxF6//A2Ig8vE/8mdZfp
   ivKTQikX8Zpc3ozYn4OpRG1Ad7hXUP/K7IPOk7+y0VWtf4up1JCcz8PO/
   JDR5A+c8swsejJO+BSoy7kNdNpm/yn0dMnF81zKMnCoo0mRG2UxmY7ZtN
   t8ekvSwCoZWkYOtdN7H3FDAY/ZN2aQRK65808oa9D+kbe9aARlua0gKmZ
   LKFW8+vvKQTc9CYBm0+lD7IYKLsngPZdVD847UKQ0jhwT3+JLPcfllpnL
   4QfM+lmqZ6IxdoqEnJwHbzpVQD8QBSyNHsQS417ARZm9peNWnWXopwanm
   w==;
X-CSE-ConnectionGUID: xJ1nz92OTH6u7isXBCqrfA==
X-CSE-MsgGUID: VXDfuw4HSheLehZQw7znpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="88745867"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="88745867"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 10:17:48 -0800
X-CSE-ConnectionGUID: Rm0jqLTXTgq1ii+5qBwmHA==
X-CSE-MsgGUID: mIfTUGxNT/SWtA3Sj0DQ2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="209605538"
Received: from khuang2-desk.gar.corp.intel.com (HELO localhost) ([10.124.221.188])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 10:17:47 -0800
From: isaku.yamahata@intel.com
To: kvm@vger.kernel.org
Cc: isaku.yamahata@intel.com,
	isaku.yamahata@gmail.com,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 27/32] KVM: selftests: Add test vmx_set_nested_state_test with EVMCS disabled
Date: Tue,  3 Feb 2026 10:17:10 -0800
Message-ID: <8935e63039b4cfc9a343a2ed7dc7bc25b392fa33.1770116051.git.isaku.yamahata@intel.com>
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

Hyper-V EVMCS capability, KVM_CAP_HYPERV_ENLIGHTENED_VMCS, is optional.
To increase test coverage, when Hyper-V EVMCS is supported, additionally
run tests with EVMCS disabled.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 .../selftests/kvm/x86/vmx_set_nested_state_test.c    | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/vmx_set_nested_state_test.c b/tools/testing/selftests/kvm/x86/vmx_set_nested_state_test.c
index 67a62a5a8895..cbf6a8ff626e 100644
--- a/tools/testing/selftests/kvm/x86/vmx_set_nested_state_test.c
+++ b/tools/testing/selftests/kvm/x86/vmx_set_nested_state_test.c
@@ -298,6 +298,18 @@ int main(int argc, char *argv[])
 	test_nested_state_expect_einval(vcpu, &state);
 
 	test_vmx_nested_state(vcpu);
+	if (have_evmcs) {
+		/*
+		 * KVM_CAP_HYPERV_ENLIGHTENED_VMCS can be only enabled.
+		 * Because There is no way to disable it, re-create vm and vcpu.
+		 */
+		have_evmcs = false;
+		kvm_vm_free(vm);
+		vm = vm_create_with_one_vcpu(&vcpu, NULL);
+		vcpu_clear_cpuid_feature(vcpu, X86_FEATURE_VMX);
+
+		test_vmx_nested_state(vcpu);
+	}
 
 	kvm_vm_free(vm);
 	return 0;
-- 
2.45.2

