Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A2746C825;
	Thu, 17 Sep 2026 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629690; cv=none; b=eezmO9p8lMJ32im3DBlHwZavQsGiFDNlSzE0J7z8SAv+Ggo4tlIitkaAMBJ9+HbR7QyEivprElV2nLl1WA3TkbTh6C/W3qMmn1LYBFtxva1t3Ch9QipbLcROEgYQpRTYjbzett6s1l0NS6iw2+pRc4NePIbFUWPBw2MaNDtEIpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629690; c=relaxed/simple;
	bh=EBpHgTZyZP6uIboBLsfhcSvw7FkmQS729DOzD4ZKb9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QUk25kzbWkc0QraxwluV0KT0paQORuOVJYIZWl+/G4Rj8DuvWOkqy7V8xxqsIYUGWQmJAJ6DL9cxVIAxJ5PNetzDlF4ET+/lbWQ3gqqfQI1bk5BUicbcqpPWodD07hqImQg2Y2Bkx1SMzr/K48q5s4HJ6nE9lPydopdTmJY/5V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2on6VBz; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2on6VBz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789629687; x=1821165687;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EBpHgTZyZP6uIboBLsfhcSvw7FkmQS729DOzD4ZKb9g=;
  b=R2on6VBzsg548F7nk47xoLSk7AwzmPqb+VjkTwQ3COr55jxYgjytYWrd
   676yW1G8bBqDpoksLjE6i9F+JC8aI6j1M9nbBVDgHuuicRMwh6eTY5PFM
   0swrFRAl6BJPU1bqnA5MPQ/G8SdYmg68Krv+9O2WJqXzGyJspJ+/3hKUQ
   NQNoV9p9aKwZc3B1M7AnzbfmProTgxYQWKQXH3rVRLSGb3oe9ufv8t9XZ
   V3b5tzEKqcyiwRLWkF/eiLWoisfOZ8Kil78CGF5EeOe6s26m0BtRsH1xA
   F6W4oD3a5EIaaf3kRJlktlr8oTCTtGg3dWuA9Gu4ZyHtAF+KMgvA7+sE7
   Q==;
X-CSE-ConnectionGUID: 11Kh/qtHTfWunBN5T/9xtw==
X-CSE-MsgGUID: wTzQD9U0SSO5Hg2auoYRHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="531827"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="531827"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 00:21:26 -0700
X-CSE-ConnectionGUID: GRfP/lGuSomBJbaBeRm+jw==
X-CSE-MsgGUID: CqwOz6pASxakYL1DPqZGbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1849193"
Received: from litbin-desktop.sh.intel.com ([10.239.57.15])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 00:21:24 -0700
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
Subject: [PATCH v4 0/4] KVM: TDX: Validate directly configurable CPUID bits
Date: Thu, 17 Sep 2026 15:25:44 +0800
Message-ID: <20260917072548.2314491-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TDX module reports a set of CPUID bits that the VMM can directly
configure for a TD, but KVM cannot blindly expose all module-supported
bits to userspace.  Certain features imply additional architectural state
(such as one or more MSRs) that KVM must explicitly manage across
host/guest transitions to prevent host state corruption.

Today, KVM hardcodes a denylist to filter out host state clobbering
features that KVM doesn't support.  However, a denylist doesn't scale as
the TDX module evolves, i.e. host state clobbering features added by a
future TDX module are not covered by the denylist, and userspace could
enable a feature that KVM doesn't support.

This series builds an allowlist for directly configurable CPUID bits, and
filters and validates userspace input against it, so that newly introduced
TDX directly configurable CPUID feature bits can only be enabled by
userspace after KVM explicitly opts in.  Except for a few fixed-1 bits
required for basic TDX support, host state clobbering features are either
directly configurable or gated by TD ATTRIBUTES/XFAM.  KVM already
validates ATTRIBUTES/XFAM, so the allowlist only needs to cover directly
configurable bits.

For this version, I'm hoping to collect some RBs and Acks.  The key
discussions from v3 [1] are summarized below.  Note, FRED KVM support is
in progress upstream [2], and no TDX module with FRED support exists yet,
so there is no immediate issue.  But it would be nice to get this series
merged sooner rather than later.

Discussions from v3:
- Whether to restrict the TDX feature bits to kvm_cpu_caps[].
  Xiaoyao and Sean preferred not to restrict the TDX feature bits to
  kvm_cpu_caps[], to avoid an unnecessary dependency on feature enabling
  for non-TDX VMs [3][4].  However, Rick pointed out that ideally the TDX
  arch would not be finalized before the normal VM KVM design reaches some
  level of maturity [5].  Also, it's safer for TDX to respect KVM's logic
  around disabling certain features, since the reasons for disabling them
  could apply to TDX as well [6].

  This version still restricts the TDX feature bits to kvm_cpu_caps[], with
  a few exceptions.  If TDX feature enabling turns out to be consistently
  blocked by non-TDX VM enabling, a solution can be worked out then.

  Note that the final allowlist is the same either way, i.e. whether or
  not the TDX feature bits are restricted to kvm_cpu_caps[].

- New opt-in interface vs. backporting.
  There are two options for old KVM versions that don't do the filtering
  and validation:
  1) Add a new opt-in interface to expose features newly introduced by the
     TDX module.
  2) Backport this series to LTS/stable branches.

  The opt-in design vs. backport decision is deferred, since this series is
  correct and an improvement either way [7].

- Potential backward compatibility issue when an effective fixed-1 bit
  becomes directly configurable due to x86 feature deprecation.
  This is left for the future, i.e. it can be addressed if and when such a
  deprecation actually happens, e.g. by adding an opt-in interface to let
  users/admins choose between migration flexibility and backwards
  compatibility on old platforms [8].

Changes since v3:
- Audited the directly configurable CPUID bits outside of kvm_cpu_caps[],
  added XTPR and HT to the allowlist, in addition to MWAIT and
  CORE_CAPABILITIES.  The remaining bits are left out of the allowlist
  because they are either not supported or can't be properly virtualized.
- Improved comments/changelogs. (Xiaoyao, Kishen)
- Updated documentation/comment about the ABI change. (Xiaoyao, Rick)
- Renamed functions for better readability. (Tony)
- Collected two RBs from Tony.

The series follows the CSV version of the CPUID virtualization document
from "Intel TDX Module ABI Definitions" [9], updated in June 2026.

AI tools were used to:
- Polish the cover letter and commit messages.
- Do code review.

[1] v3: https://lore.kernel.org/all/20260827031837.2863609-1-binbin.wu@linux.intel.com
    v2: https://lore.kernel.org/all/20260604023314.3907511-1-binbin.wu@linux.intel.com
    v1: https://lore.kernel.org/all/20260417073610.3246316-1-binbin.wu@linux.intel.com
[2] https://lore.kernel.org/all/20260911213659.2025974-1-sohil.mehta@intel.com
[3] https://lore.kernel.org/all/9abeed40-bcdc-48d9-8cbb-cb87154bb9f6@intel.com
[4] https://lore.kernel.org/all/aqHdwkOFVR4XoS2M@google.com
[5] https://lore.kernel.org/all/c967dc3eb6b128055e415bae45d1c14a52dc4acd.camel@intel.com
[6] https://lore.kernel.org/all/4c379b90da893c5d1ffea46dc7e40303e7923872.camel@intel.com
[7] https://lore.kernel.org/all/c6b240bd-3c45-4abe-b17c-72a1a7da582f@linux.intel.com
[8] https://lore.kernel.org/all/1deddc78d14326b378ddd62ad99c21d66da401e6.camel@intel.com
[9] https://cdrdv2.intel.com/v1/dl/getContent/795381

Binbin Wu (4):
  KVM: TDX: Track configurable CPUID bits allowed by KVM
  KVM: TDX: Report CORE_CAPABILITIES as configurable
  KVM: TDX: Filter configurable CPUID bits
  KVM: TDX: Validate userspace CPUID input for KVM_TDX_INIT_VM

 Documentation/virt/kvm/x86/intel-tdx.rst |  10 +
 arch/x86/include/uapi/asm/kvm.h          |   2 +
 arch/x86/kvm/vmx/tdx.c                   | 279 ++++++++++++++++++++---
 3 files changed, 262 insertions(+), 29 deletions(-)


base-commit: 70c944caf570fda2d79baa71435589a8db39f048
-- 
2.46.0

