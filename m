Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175203;
	b=C4RPMXKCJkNqca4hJOlNlsg3NHhbAUSkFnx6wyEahyiHPHJYSFwgJ5+C32ndHzu96yMR
	 j9DUzwAqB4xYf01q/JGnfdvfWatHI6TzHDREacJ9qyY8QSBFfH5ypKN9zoLwLXDsBYKQU
	 V6Y9atyZU+pEN/0cez66sQEXiIHmOglFctdVrbVIPGmVA65o1rpky7OL7GdeDQUxpqPkb
	 LtkXR6duXlpw+r4lmMTSkRUEeakd7+Up/5A1PMvhyp1ZWDv4SCJaWdTk2QaacjiNhXkTH
	 MELy9AyA8aeDFB8RxYRdmuIj4m58qkr+ZAwCbCZ15WvuOtCsGbnIbM2J5mQvQcSh9Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175203;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cyFTSceoq3zuHq/GmeM10C/NFw97mGwU91gFM26+PlQ=;
	b=M2cYHwCQBHd8K4QtynuZ4a7sTVomNyoKBfop4YFNvMNUAgLtNx4zjQoGreCXf2XqE9+D
	 VyuZi25gIRoDZyDP92Am5Tynp0EbOaCRtiiKVn7HrfYP0USJk77lzsp7RM6sh1suJhByx
	 SYc/TOMOoeC5Vjffttt5Koeney9UFDjDVqH4a5JfQMg9xGNlKhCAAz2Q+tLcBJEm/4zzo
	 mxXAdCLSoZD22/P+6XwLE+lJU75NoYGDOLxCX+WHAAqInAiCCNy2cbFrCFtHRuQ+mkHf+
	 B1j9e7vaXQzE/5etBK951h7jgOBwJlOWibWMpcSiQcGrnX7+1ROtlXCUQc7AaLxMtWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XgJION42;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B2B606A325;
	Wed, 28 Oct 2026 08:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57B2B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XgJION42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793175204; x=1824711204;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XG8I1ZlzrQJMmoZkxoBKg5VNeMfO70HWg+m1XgJxHG8=;
  b=XgJION424HMDOlhR2UZkiS1+ASOlU3unP0yiZv1gaOV80RpB+gElO16U
   WhVbHcPGnEZm1Ww8Lj/b+lZnFeHDRTfqr8n5arEyopzQVkfst0Vubl89W
   andIYb9xJL7CXtDGUFfEBr0rG7l1J3MrhROUHDOnDDnhfrKxE5K+mb0bz
   eZhbreVp9jaP6EHhgoA0ToxYLUEIA0zNkaqvzu6Xw+sEntSfCW/zR7NOZ
   68Rr1Ma+i24lrOqzgR+WzFXb1QIsifFNFiAyrzJ4bwKEPRq+w3/bCTQAz
   +bEYEb0jl6AG7QrLjVZyThc2vxmYQES514wnjXgJhqLPRV0nUswieF0fK
   Q==;
X-CSE-ConnectionGUID: IpNbj16GRfy4BEXQ4q89TA==
X-CSE-MsgGUID: JVt0S1V2RpORKYM1avB6Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1902924"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1902924"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 01:13:24 -0700
X-CSE-ConnectionGUID: sC29fIEiTnO07dXkd0Wlaw==
X-CSE-MsgGUID: At6m1/LXTASNneV1jWyQ0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="5118495"
Received: from litbin-desktop.sh.intel.com ([10.239.57.15])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 01:13:19 -0700
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
Subject: [PATCH v6 2/4] KVM: TDX: Add CORE_CAPABILITIES to the allowlist
Date: Wed, 28 Oct 2026 16:16:55 +0800
Message-ID: <20261028081658.1228484-3-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20261028081658.1228484-1-binbin.wu@linux.intel.com>
References: <20261028081658.1228484-1-binbin.wu@linux.intel.com>
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

Add CORE_CAPABILITIES (CPUID.0x7.0.EDX[30]) to KVM's allowlist of TDX
directly configurable CPUID feature bits to accommodate the legacy TDX
module definition of the bit, even though KVM doesn't support
MSR_IA32_CORE_CAPS for TDs.

Older TDX module specs define CORE_CAPABILITIES as fixed-1, so userspace
may expect the bit to be set for TDs.  The bit is redefined as directly
configurable due to #VE reduction.  Leaving it out of the allowlist would
prevent userspace from setting it once KVM starts validating the CPUID
input to KVM_TDX_INIT_VM, which would be an unexpected behavior change for
such userspace.

Reporting CORE_CAPABILITIES as directly configurable also lets userspace
detect that the bit is no longer fixed-1, and thus update its stale
knowledge.

Keep MSR_IA32_CORE_CAPS unsupported for TDs, as no existing TDX user needs
guest access to the MSR.

Note, CORE_CAPABILITIES is the only bit that is both unsupported by KVM
*and* redefined from fixed-1 to directly configurable due to #VE
reduction, and no further #VE reductions are expected.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
---
v6:
- Rebased on patch series "x86/cpuid: KVM: TDX CPUID fixes"
  https://lore.kernel.org/all/20261022210134.612848-1-seanjc@google.com
- Collected RBs. (Rick, Chao, Nikolay)

v5:
- Clarify in the changelog that #VE reduction redefines the bit from
  fixed-1 to directly configurable.
- Change the shortlog from "KVM: TDX: Report CORE_CAPABILITIES as
  configurable" to "KVM: TDX: Add CORE_CAPABILITIES to the allowlist"
  since the patch doesn't change the CPUID reporting behavior yet.
- Add RB from Xiaoyao.

v4:
- Add #VE reduction related background to the changelog. (Kishen)
- Add RB from Tony.

v3:
- Drop the code for MSR_IA32_CORE_CAPS access.
---
 arch/x86/kvm/vmx/tdx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b71460805c573..becdd5aa9e682 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -220,6 +220,13 @@ static void __init tdx_initialize_cpu_cfg_caps(void)
 		TDX_CFG_F(AVX512_VP2INTERSECT),
 		TDX_CFG_F(SERIALIZE),
 		TDX_CFG_F(TSXLDTRK),
+		/*
+		 * KVM doesn't support MSR_IA32_CORE_CAPS, but older TDX module
+		 * specs define this bit as fixed-1.  Report it as configurable
+		 * to accommodate the legacy TDX module definition, and to let
+		 * userspace detect that the bit is no longer fixed-1.
+		 */
+		TDX_CFG_INDEPENDENT_F(CORE_CAPABILITIES),
 	);
 
 	tdx_cpu_cfg_cap_init(CPUID_7_1_EAX,
-- 
2.46.0

