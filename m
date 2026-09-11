Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802844CE698;
	Fri, 11 Sep 2026 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789163001; cv=none; b=dt4R17zMURJK6+MT+fc9VFPTTipcTDkmykVvi3RfsarbQwtlkQDavgUsx1gxgGTjPM54OHfiChQFogWYM8FKePl8uDo+VPVG7bmL2oh8XhxxwfMN1I2gQ/Aly8EDWCGBwsRIngipsqFsNuKYoaqURDtGCjZs6pEuOVwiKM83Vn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789163001; c=relaxed/simple;
	bh=0aEzJ9qwYXcpOA7/qPgBgBQcHtUuHRHVJ72QgY84zwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RiZxrgF8u9vSCG2rPYCjuYvrATsGnfJf61Q1ZciLMPnUxydiLKqbtGQdJHf7TmCWM2IHR00Gc4t/PF8O7JafPq+yBe5PUeF1eoOWNYKMA85Q5Wnu4MiyghZZPXVWHJVruvNsVApAfXmL0OrCcsePjXmWUoaDPba4SstFabr9+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1/9DqHs; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1/9DqHs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789162999; x=1820698999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0aEzJ9qwYXcpOA7/qPgBgBQcHtUuHRHVJ72QgY84zwE=;
  b=J1/9DqHs+lTkPrJb+K0+AIzd+2kvKJcOy4Z4oNYNF/n1kJjM/VGL1emf
   r2kCp+Xl+Y1CSYd37WVJSd9lJdlM1cE0jtNNJUR35U56YhyudSVSDN6km
   l50tL6S3NVSDfvZEyTebyNdp0kNDUEIq41lEr7YoZ+5n6HOsMwc7i1xSa
   XyeVeEcFe+0KUfkbCimiMWom1R+yp9l52P6rDvHBSZvoL0bEMHhjmKfAR
   MWI4a2RDxyeiUVv7gCvL7V5fjJPAPid3DP0zeXdoaHE2GNkMJ9aoQvB90
   ekDaldI7dpIS3VyzRmqtTmxpw722oAwegO0ldHE8GpDf5HhGdwY5qxkyj
   A==;
X-CSE-ConnectionGUID: qKTGQkaQSZODc0ETiHjxZg==
X-CSE-MsgGUID: 3JGofwiXRrWctlR+7DGd/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572863"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572863"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:43:17 -0700
X-CSE-ConnectionGUID: fez44+cgTimXe6COkdDh3w==
X-CSE-MsgGUID: wAoWrDJYQcymWLvmGGesAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272004276"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:43:16 -0700
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
Subject: [PATCH v10 22/28] KVM: nVMX: Restrict event data VMCS fields to FRED-supported hosts
Date: Fri, 11 Sep 2026 14:36:52 -0700
Message-ID: <20260911213659.2025974-23-sohil.mehta@intel.com>
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

Prevent L1 from accessing the ORIGINAL_EVENT_DATA and INJECTED_EVENT_DATA
VMCS fields via VMREAD or VMWRITE when FRED support is disabled or not
present in KVM.

Signed-off-by: Xin Li <xin@zytor.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - Split out of "KVM: nVMX: Guard SHADOW_FIELD_R[OW] macros with VMX
   feature checks" and renamed (Sean).
---
 arch/x86/kvm/vmx/vmcs12.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmcs12.c b/arch/x86/kvm/vmx/vmcs12.c
index 837cb3d568c3..67c730e31465 100644
--- a/arch/x86/kvm/vmx/vmcs12.c
+++ b/arch/x86/kvm/vmx/vmcs12.c
@@ -222,6 +222,9 @@ static __init bool cpu_has_vmcs12_field(unsigned int idx)
 	case HOST_SSP:
 	case HOST_INTR_SSP_TABLE:
 		return cpu_has_load_cet_ctrl();
+	VMCS12_CASE64(ORIGINAL_EVENT_DATA):
+	VMCS12_CASE64(INJECTED_EVENT_DATA):
+		return cpu_has_vmx_fred();
 
 	/* KVM always emulates PML and the VMX preemption timer in software. */
 	case GUEST_PML_INDEX:
-- 
2.43.0

