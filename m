Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795660250;
	b=FmIpKwksTnMHFh7nEKrneAWVcYHSc0XGmZCHz/FmpwKY0R9KT7lRq4w4b54ffhMcm9Xo
	 1vzZHnkdR5sXfsDaZ2pCHKk5QHshCBytsXNDActahM1NobKb1brRWxuEhjCTtNbUGJFt/
	 jC2zYdbqYsH7JnBoSBeI01iaFnh+dgjOUIT1MnzX/oPK6xcUlG5eQ+NlEnoJWtjGcK00d
	 Hb4O7It1XCmDsSyozoKnVveF1vlrxiGhaABkJdy5a9CTL4toQQLh96cnTIO4HH+TOOIem
	 njka806+iieQXIMJWIFglFgBqZa+RQU23uOyKZpqV7LC+PFNzRpnePyrHSzvMHl7hxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795660250;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=uAaoVd3CsAbWwzbYkbWbHH7ZrM0rPs/XIrtXSfHrQb8=;
	b=XA7f0E2zj/VkwQqnHCidSkpkSDacexTT2SDMyN3eS82ieR+BGlFqRFBUfzZtu5DLu5UA
	 t5QLzLCJEqLfsO10Xka4VcdTVfXze23ZBpEH8k8WikYfACy2MLlTBZ4Zt+YQCGJGcUTI3
	 GedvEstoJZbsWxKyq3Xuzuv+CTyc+i5gK6nW5KIdZbHOfsMU7DKUeXB0NO/hXtZdSm6Nf
	 FpOuOdzM1vlqkdwuO8QNlaymspO0F2lUjbdYulMdt8uFhMWC9FBnyCn/f8zv4fxeRZJT0
	 vRoMxtk1cd9MltEb31R3P1HO3+W2LpDGHLwTJG1vk4lpxFcoo7TaloTNyM6rInGuJiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hHjTHtBz;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3010606A31E;
	Thu, 26 Nov 2026 02:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3010606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hHjTHtBz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795660249; x=1827196249;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YTi8dcXIfnZzyvXr3rFgLdVxSt2OaV7m2cXBOu17pF8=;
  b=hHjTHtBzRxy85gqDCjXuLJZSji00bEw7J82poAy16EkUiIwjtZFI4iAU
   Q8fkQr3q/uqImf1gk/7dEuSelGV4vdxRJK/PNFNJPbtSeu5dsDFRPBxuL
   wiS3Xf2OdLUU/GHkxfT6zl/aJ607AbK7dVXgCF8nlvhVuAgtMeVerWY8P
   ZLyTygqhTIGlN1Vd2y47Zt3dQKQ8j3qEf8qTvKYCNbA9qilrEd+KjpWkj
   XOcVnsZpsAnrWE2mdoM2C1uJZnxyRfl/j9P7xqZ9XvEd0G6tF5HAqIxxt
   78RxFp87Ztz5R2oMhwEZLS/QIPFJ0g0Y6Cs9WO9Vc5zkdXPv/gZYkyi3B
   Q==;
X-CSE-ConnectionGUID: c9mgU4qFQCu+Q+Cf6YUDVQ==
X-CSE-MsgGUID: kNzm2G2sSgGP0FRm9D9N/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4642507"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4642507"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 18:30:48 -0800
X-CSE-ConnectionGUID: fthmVx+rRo2pGgaDvqdS8w==
X-CSE-MsgGUID: M/VNAOIZS+y9wvSW/mZBYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="12044172"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 25 Nov 2026 18:30:48 -0800
From: Sohil Mehta <sohil.mehta@intel.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin@zytor.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Jon Kohler <jon@nutanix.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] KVM: VMX: Add support for the secondary VM-exit controls
Date: Wed, 25 Nov 2026 18:27:40 -0800
Message-ID: <20261126022743.4082392-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
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

Sean, Paolo,

These patches started out as part of the FRED KVM series [1]. However, the
series is getting bulky (30+ patches) and hard to manage as well as review. I
am working on splitting it into smaller parts [2] for easier review and merge.

The overall goal is to get the infrastructure pieces ready first and then the
FRED guest support followed by the nested FRED support. Some core x86 patches
that were part of the FRED KVM series are already in place [3] with more on
the way [4].

This series focusses on getting the secondary VM-exit controls support in
place independent of FRED. Please let me know if you prefer a different
approach or have any suggestions.

Background
----------
The secondary VM-exit controls are a 64-bit VMCS field, activated by bit 31 of
the primary VM-exit controls. The SDM defines four of them so far: "save
FRED", "load FRED", "load IA32_SPEC_CTRL" and "prematurely busy shadow stack".

With this series, KVM discovers the field and programs it in vmcs01 and
vmcs02, so that FRED or any other user of these controls only has to set its
own bits later on.

Patches
-------
Patch 1 adds the support for the secondary VM-exit controls.

Changes from FRED KVM v10:
 - Reword the commit message and add some minor changes to match the name
   and placement with neighboring code.
 - Copy the secondary controls into vmcs02 to fix the issue described below.
   In v10 this lived in the nested patches [5] which tied the FRED guest
   support to the nested support.

Binbin, I have kept your review tag since the changes are minor. Please let me
know if you have any concerns.

Patch 2 fixes an issue reported by sashiko related to the entry/exit pair
checking [6] and patch 3 adds the new field to the VMCS dump. The last two
patches are optional, but they help complete the support.

The patches are based on the kvm-x86/next branch (kvm-x86-next-2026.11.11).

vmcs02 issue
------------
KVM seeds vmcs02's VM-exit controls from vmcs01's, so vmcs02 inherits bit
31 but not the secondary controls themselves. vmcs02 then runs with the
secondary controls active but empty, which is harmless only while every
bit is clear.

Once FRED sets its controls in vmcs01, vmcs02 also inherits FRED's VM-entry
control. Entering any L2 loads FRED state, but the exit from L2 doesn't
restore the host's. Until the next VM entry the host runs with a zeroed FRED
configuration, and any event in that window hangs the CPU. 

This isn't specific to FRED, any future secondary VM-exit control would
likewise be silently off whenever an L2 runs.

Testing
-------
I tested it on a CWF system with FRED enabled as well as fred=off. The CPU
enumerates all four secondary VM-exit controls (IA32_VMX_EXIT_CTLS2 = 0xf), so
KVM activates the field in vmcs01 and copies it into vmcs02, with every bit
clear.

A debug dump_vmcs() on first VM exit from vmcs01 and from vmcs02 shows the
same controls in both:
    ExitControls=0x902befff SecondaryExitControls=0x0000000000000000

KVM selftests and kvm-unit-tests show no regressions.

Links
-----
[1]: https://lore.kernel.org/lkml/20260911213659.2025974-2-sohil.mehta@intel.com/
[2]: https://lore.kernel.org/lkml/12f686a4-a9f8-4347-a7f4-c0f893addfb9@intel.com/
[3]: https://lore.kernel.org/lkml/179545148741.92412.5844266518161867015.tip-bot2@tip-bot2/
[4]: https://lore.kernel.org/lkml/c662df85-4431-4303-9865-4189d186a94c@intel.com/
[5]: https://lore.kernel.org/lkml/20260911213659.2025974-21-sohil.mehta@intel.com/
[6]: https://lore.kernel.org/lkml/20260911220046.1A4A91F000FF@smtp.kernel.org/

Sohil Mehta (1):
  KVM: VMX: Treat partial support of an entry/exit pair as inconsistent

Xin Li (Intel) (2):
  KVM: VMX: Add support for the secondary VM-exit controls
  KVM: VMX: Dump the secondary VM-exit controls in dump_vmcs()

 arch/x86/include/asm/msr-index.h |  1 +
 arch/x86/include/asm/vmx.h       |  3 +++
 arch/x86/kvm/vmx/capabilities.h  |  6 +++++
 arch/x86/kvm/vmx/nested.c        |  3 +++
 arch/x86/kvm/vmx/vmcs.h          |  1 +
 arch/x86/kvm/vmx/vmx.c           | 46 +++++++++++++++++++++++++++++---
 arch/x86/kvm/vmx/vmx.h           |  7 ++++-
 7 files changed, 62 insertions(+), 5 deletions(-)


base-commit: cbe54fc3462b3949ab27b9ae81fb9ddb509040c7
-- 
2.43.0

