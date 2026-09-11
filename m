Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DFC4570D1;
	Fri, 11 Sep 2026 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162818; cv=none; b=FxZAQXnzvBObwj4YrHa7IhggJ6jW2fYs7Q/uJSVjoYthrvjxt79eJY4aa2fcTxGC5ejISdxrP24YXZb2WIKrq52iYQ8PNnI2tf2pZdtjncp0llBUKTLUknjyPIQbZpLsL0SFfQw20r6LLiuOQyR7mtJLErbf3hvRYGLW9aCfLLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162818; c=relaxed/simple;
	bh=Rei04Ot5HKLPhTtYmF1FETakMjgMhAt/5SlhNx5l7Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJ/+1GHnqULj01UJV8FTMzE9Qeg5OHxuWw02uOMgDxVcvB5+E1JmEKE36pY7shFvSwpcjLKcyGwdbAuynkKJoi4e/t7vOG3pHhxXv16YifhPkMTpY9h6F24dUu23TbGPRxaADfCf0qP+M/+3lih8bjs3uN/fKxcm6ngEdWZoi5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PR/WsRUP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PR/WsRUP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789162817; x=1820698817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rei04Ot5HKLPhTtYmF1FETakMjgMhAt/5SlhNx5l7Iw=;
  b=PR/WsRUPeDKVUa3fY3Icn4gWQ1+I264F7E7sZIjy9bL/R6yxuqGvw3yY
   sx5XQ1onj0p46eM1VV85hL3VQsBBVlI4dV5RnQS4UVO9KGDieT37wgRQS
   yuVPjjwDPo9DcTQ0Jo2FzMpijDrnyLtV4J01yJf0HVDzSKZQrUJErRD88
   lDiUaoVj1QAvY3AbElKisZsdDNQSXhNL9X9U5kX8THpTgu2+WmgeiUGvQ
   qmjlygr+7ukEgPus/ci6LYBOXuP9tEnUd99UB4MzbeqtPTqILPi/GKDur
   6fT6qT/P10zVZeCzvtsDa0Y2F2fwQEn9+lLeZaXDYXcviwaxPgMk842W8
   g==;
X-CSE-ConnectionGUID: 8bT8SIvnSRm6T79FjyMe6Q==
X-CSE-MsgGUID: mYoo3BaQSm+mkTKF34PaVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572420"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572420"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:40:16 -0700
X-CSE-ConnectionGUID: lBeSR+TGSnC/g3LiNCLqag==
X-CSE-MsgGUID: QNTjwgZSQASxf7lp9wD0Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272003935"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:40:15 -0700
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
Subject: [PATCH v10 03/28] KVM: VMX: Disable FRED if FRED consistency checks fail
Date: Fri, 11 Sep 2026 14:36:33 -0700
Message-ID: <20260911213659.2025974-4-sohil.mehta@intel.com>
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

Do not virtualize FRED if FRED consistency checks fail.

Either on broken hardware, or when run KVM on top of another hypervisor
before the underlying hypervisor implements nested FRED correctly.

Suggested-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
---
v10:
 - Remove the comment about why not check FRED VM-exit controls in
   cpu_has_vmx_fred() (Sean).
 - Remove redundant parentheses (Sean).
---
 arch/x86/kvm/vmx/capabilities.h | 5 +++++
 arch/x86/kvm/vmx/vmx.c          | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index 6be818ce27bf..95d22a54f856 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -409,6 +409,11 @@ static inline bool vmx_pebs_supported(void)
 	       !enable_mediated_pmu;
 }
 
+static inline bool cpu_has_vmx_fred(void)
+{
+	return vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_FRED;
+}
+
 static inline bool cpu_has_notify_vmexit(void)
 {
 	return vmcs_config.cpu_based_2nd_exec_ctrl &
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 062631e2dd37..2a2218e0983b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8122,6 +8122,9 @@ static __init void vmx_set_cpu_caps(void)
 		kvm_cpu_cap_check_and_set(X86_FEATURE_DTES64);
 	}
 
+	if (!cpu_has_vmx_fred())
+		kvm_cpu_cap_clear(X86_FEATURE_FRED);
+
 	if (!enable_pmu)
 		kvm_cpu_cap_clear(X86_FEATURE_PDCM);
 	kvm_caps.supported_perf_cap = vmx_get_perf_capabilities();
-- 
2.43.0

