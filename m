Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152B147604B;
	Thu, 17 Sep 2026 07:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629702; cv=none; b=ai5QawahQD/Faa5OI7hJeob6F4rKWXQtBb3LsNltRrfaeNZFBQOQHSymDWuhufB6r/oblPxpn0QStbEug5diCz9DC1hBCZm9sahZWlPEd1/GUcsfEa8VsdihTOjs5cy3iMkOaoCwcC1FjYNidd85+dGuE/QNal2zGNaUDV/nees=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629702; c=relaxed/simple;
	bh=oMsXHD3gcjjkL+qdh1k2ncXZr3LSlbqkqd60iPb3Py0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XzcAVnt2jQmekhoXPsELO3k3hWp0YRkB8TD86RDuyXL6+opNZdXAblxN+YLPXehayq9rCyqkCDxyazVaTvQfp+xitAkuMZJHtq9p/FY4TkbGe95trh94yDbna7r4im31FW/boSQYyPbvARFbP3r/O26Ub5CiwmThZokw8tfC9Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PFwJkJiL; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PFwJkJiL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789629697; x=1821165697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oMsXHD3gcjjkL+qdh1k2ncXZr3LSlbqkqd60iPb3Py0=;
  b=PFwJkJiL05GqvPV9n4xRXB+JtsvcbFw+/2P9cteFFTsh6n4kfiNIMJH7
   irWPIex8id8Fxcurd6vXsulTosZbntbuyjgozZLetIxy45k9kscGzKN1n
   9Di6gxag6wU1ghQe0bo6bbIVPBa85N73p0ql6ntDmHdYbOCPU9p2JwxRw
   juakaIeaVtmAPzW2Qeo1/LTjJeonZoWUJaPNVewCnO8/K3Epdpdjs75Eg
   G5GVSNT5wSODK8Ah55LxI2yaLWg1xTaYi74JetzciKrm0R1H8mqGM03/X
   Vh4IJ+N4RDR7QYCsWGZ0f38kJ7cNMGmHRllcTeArhp9USo9iHEfxynbhN
   Q==;
X-CSE-ConnectionGUID: Z7GARTPaRHSUQcofObSoIA==
X-CSE-MsgGUID: vhGIV64pTxOLcMVc2OqbTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="531856"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="531856"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 00:21:33 -0700
X-CSE-ConnectionGUID: T5f5e0VtT6GNoCT2BC37zw==
X-CSE-MsgGUID: 04p8HGb4Soa918/thMAeJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1849327"
Received: from litbin-desktop.sh.intel.com ([10.239.57.15])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 00:21:31 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	dave.hansen@linux.intel.com,
	andrew.cooper3@citrix.com,
	nik.borisov@suse.com,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	tony.lindgren@linux.intel.com,
	kishen.maloor@intel.com,
	dedekind1@gmail.com,
	binbin.wu@linux.intel.com
Subject: [PATCH v4 2/4] KVM: TDX: Report CORE_CAPABILITIES as configurable
Date: Thu, 17 Sep 2026 15:25:46 +0800
Message-ID: <20260917072548.2314491-3-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
References: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CORE_CAPABILITIES (CPUID.0x7.0.EDX[30]) to KVM's allowlist of TDX
directly configurable CPUID feature bits, even though KVM doesn't support
MSR_IA32_CORE_CAPS for TDX guests, to accommodate the legacy TDX module
definition and userspace's stale knowledge of it.

Older TDX specifications define the CORE_CAPABILITIES CPUID bit as
fixed-1, so userspace may expect the bit to be enabled for TDs.  #VE
reduction turns it into a directly configurable bit, so leaving it out of
the allowlist would make the bit impossible to enable once KVM starts
validating userspace's CPUID input, i.e. would be a surprising behavior
change for such userspace.

Reporting CORE_CAPABILITIES as directly configurable also lets userspace
detect that the bit is no longer fixed-1, and thus correct its stale
knowledge.

Keep MSR_IA32_CORE_CAPS unsupported for TDs, as no existing TDX user needs
guest access to the MSR.

Note, CORE_CAPABILITIES is the only bit that is unsupported by KVM *and*
changed from fixed-1 to directly configurable by #VE reduction, and no
further #VE reductions are expected.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
---
v4:
- Add #VE reduction related background to the changelog. (Kishen)
- Add RB from Tony.

v3:
- Drop the code for MSR_IA32_CORE_CAPS access.
---
 arch/x86/kvm/vmx/tdx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 2b51a85c998e8..b34afc52b714e 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -165,6 +165,13 @@ static void __init tdx_initialize_cpu_cfg_caps(void)
 		TDX_CFG_F(AVX512_VP2INTERSECT),
 		TDX_CFG_F(SERIALIZE),
 		TDX_CFG_F(TSXLDTRK),
+		/*
+		 * KVM doesn't support MSR_IA32_CORE_CAPS, but older TDX specs
+		 * define this bit as fixed-1.  Report it as configurable to
+		 * accommodate the legacy TDX module definition, and to let
+		 * userspace detect that the bit is no longer fixed-1.
+		 */
+		TDX_CFG_EXTRA_F(CORE_CAPABILITIES),
 	);
 
 	tdx_cpu_cfg_cap_init(CPUID_7_1_EAX,
-- 
2.46.0

