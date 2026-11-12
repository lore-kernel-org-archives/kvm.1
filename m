Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516230;
	b=NYDFcZNv9s/XSmNOCRLDYj7eOmjeCGHD+11NigVYd91d4N9OCHEs2ZdGKEGfEM2ccmXp
	 qU0g2KDoTesmzO/rVhrhFPfXVnzfA3Rdm1noF0q7olsf6rlCZVK+Xjewwm4f00FFJ18Xy
	 1qfz0uGSrasd34hO3KFSDqmldVkYu47OC7Nns0ARWv9Zh+A6NctVFctBgOx7J3+yqEFRx
	 UMNeAmVIq1o5wDs6gkNQr+c549itJwF7zpG1cDjLFLdr/1uPixbq7ZvuTAcSmp5mG16rU
	 Jjsalk6TT7Y2r4DCRuVZOIkcQxcWTIO9/DVZq6Fl/xOpcxKFYDpxN6Q6pxyclvb8Efg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516230;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Izb7xswF5tDNO3/2ZFSJ7xBbUNYnWHh0GiHEwa/FiEA=;
	b=bNcvBsDeO2usLAnEsaQMGSfshIV4GkHOGBAgEeO0OWUfkk5ombK/c/cyom1yz/5V3jex
	 2sZOHthGmTZ2sStE4c2LoS+ncfEMAsG99zCpf/S8+pxRTh6S8fhbU+IPauXVgwe7qu3Cb
	 QKtbZ/Q3MtBBvWdPnHuGshY/OskgJFs+4NJlG9YR0yCF/XPtJCkjgdJk/WJlRgtz942Sc
	 XfJGjSdEWGV9/z4RvTfe/BbqbxPIYR7tslN9RDbgFoKYsO66xDfFSAXC/+MzwB2J+WqFB
	 jS/JyOE5UbFw1vtGZjbbK2ZW4M9Co1UOWCrSQ4uRYWOliT4xv/4mEje4Evd1qkxWrZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hJRAIhVf;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B2860A2616;
	Thu, 12 Nov 2026 20:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07B2860A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hJRAIhVf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794516230; x=1826052230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yeZQlEu9eMJvbfV20JjUB42sSRxGNtXUebZlHM4MrYw=;
  b=hJRAIhVfeApLrjpt2371CCGI8c3Ds2pLmI0THN57aok1J5mRekBoGriB
   8pS9VQgJPMjnDGAtMk33ba30yU3nDjlZMMJ2yVBQAcWFIgPO996REDljc
   Q5/7sqtybwPBrBbU4jeRBw3pUi1kDVI1E8FemQNGxSLwZSWlSiFU0No1x
   DFTlKRwz+Zj3LJ3dBju1EIHFuLiMIrIi0/fzAAgGW/PCA1fw+MkEp9pCL
   ImFowF0prin4//RhVirwpWrR+8ue+ESfaTP+9qpMAzL7L0jg4/IepJWXi
   OZ7n72DR5YO3MY8MD8GrtYF3LqGqRjWO6HUYV2BCgHy5814Ud8m6Cy/a/
   g==;
X-CSE-ConnectionGUID: idKUWEIRTUWGLJ1q1y+80w==
X-CSE-MsgGUID: SGA43xTEQxm6VRO+kOMQPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3192276"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3192276"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:49 -0800
X-CSE-ConnectionGUID: zKENZnvDS4aK6lkfA32X4g==
X-CSE-MsgGUID: ple9Tv2GSfaZTQ3LMgwIbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9087905"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:49 -0800
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Andi Kleen <ak@linux.intel.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v4 11/21] KVM: x86/pmu: Document GLOBAL_STATUS_RESET passthrough erratum
Date: Thu, 12 Nov 2026 13:32:17 -0700
Message-ID: <20261112203227.289379-12-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261112203227.289379-1-zide.chen@intel.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IA32_PERF_GLOBAL_STATUS_RESET, introduced in PerfMon version 4,
inherits the MSR address and architecturally defined bits from
IA32_PERF_GLOBAL_OVF_CTRL, while providing additional bits to clear
new indicators in IA32_PERF_GLOBAL_STATUS.

From an emulation perspective, KVM handles it identically to the legacy
OVF_CTRL MSR: reads return zero, and intercepted writes are guarded
against pmu->global_status_rsvd. No code changes are needed in KVM
to emulate this MSR.

However, to reduce VM-exits on performance-critical paths, KVM passes
through this MSR in mediated PMU mode when all hardware counters are
exposed to the guest. Consequently, writes to bits that are valid in
hardware but unvirtualized by KVM will not trigger #GP (unlike when
intercepted). This is safe because such unvirtualized bits are never set
while the guest runs, so clearing them has no effect, and because the
MSR is read-as-zero and write-to-clear, passing it through cannot leak
host state.

Document this divergence in errata.rst.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
v4:
- Clarify in errata.rst that passthrough occurs when all hardware
  counters are exposed to the guest, and that guest writes cannot
  clobber host state. (Yosry)

v3:
- New patch. (Jim)
---
 Documentation/virt/kvm/x86/errata.rst | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/x86/errata.rst b/Documentation/virt/kvm/x86/errata.rst
index a9cf0e004651..70fd8a638ef7 100644
--- a/Documentation/virt/kvm/x86/errata.rst
+++ b/Documentation/virt/kvm/x86/errata.rst
@@ -84,4 +84,12 @@ memory.
 
 Note, this erratum does not affect AMD CPUs, which fully virtualize CR0.CD in
 hardware, i.e. put the CPU caches into "no fill" mode when CR0.CD=1, even when
-running in the guest.
\ No newline at end of file
+running in the guest.
+
+IA32_PERF_GLOBAL_STATUS_RESET
+-----------------------------
+To reduce VM-exits on performance-critical paths, KVM passes through writes
+to IA32_PERF_GLOBAL_STATUS_RESET (0x390) in mediated PMU mode when all
+hardware counters are exposed to the guest, without injecting #GP on
+unvirtualized bits.  Because the MSR is read-as-zero and write-to-clear, this
+cannot leak host information or clobber host state.
-- 
2.56.1

