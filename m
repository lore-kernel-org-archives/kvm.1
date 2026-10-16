Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE603E3DB1;
	Fri, 16 Oct 2026 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141829; cv=none; b=uiMRCAQgqlyw1phzSVphrXrj328bcI0M+pIMp89d2XzgACPWbVbAVtiOCFFN8hAvFCozNUarJlPmWshpzMfU4KP7mm1IiRlwhm1g/ydqWGbgbja8da/l757DQLHsnO+ZsaqjKaZa44JzqwsnA9YZio1owfT+eEWP4xxFc9pW9YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141829; c=relaxed/simple;
	bh=IcqZ76rfSDpcQwiD9DxB/mRMqJ9LDWG0ojtAogXJl9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UFgqmxlzibjYxSwRSZuZuyZIDo/FD6PilgkAHaFakwKVi1GRJnp6Tnw3cb2fTddH0ctWNjv+oFi5TYxR13SRKGNYpJKVd7aI29QTj9mwqgSlxdfjt/Hzpk2ReAp9EpIG1pIzQ+eUhrTlk2uhqReFydWj9Q39iYQ5ZdRcKPys/pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DV9zFSaz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DV9zFSaz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792141828; x=1823677828;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IcqZ76rfSDpcQwiD9DxB/mRMqJ9LDWG0ojtAogXJl9E=;
  b=DV9zFSazw7xpG6Wz+/GyyiPjfK9wR+0grvew4JE9An3oma2vUugh/1c5
   daDBgMfREd+MTBaJlMK4cBQTFRqL8GG/EVHhiEuTB99RkGAIr+ZFSsI3f
   cT5lL3Am+Azyd9OPEHpJnt1oI1dY07OYfYNer1kZrRu1Q+faNWo2agUr2
   rz6e73NSFhiRKXoFf5+Ba5JTeIxKwbSgGcd/p0oClyDrjstygCAP+c7lY
   +85tkERCH2PV4GTygHuXLMFtoq3YowBcl6dlxEz1QNFpHa8V+TgvZmCvz
   m6rVy8JPG87idR865Fry5HRwSEKuEd5/ezfkzBNoVlyXlfNspQW4hjhPP
   g==;
X-CSE-ConnectionGUID: 6OAXGE5yQDScylHyBRUUcQ==
X-CSE-MsgGUID: AF5aVkmOQG6hO3DgUfzxeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="927110"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="927110"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 02:10:27 -0700
X-CSE-ConnectionGUID: f0ZxwHqcQzezsx9jeKD9wQ==
X-CSE-MsgGUID: Dmx66YQHQDeMGJg02dnCpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1812539"
Received: from litbin-desktop.sh.intel.com ([10.239.57.15])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 02:10:24 -0700
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
	adrian.hunter@intel.com,
	binbin.wu@linux.intel.com
Subject: [PATCH v5 0/5] KVM: TDX: Validate directly configurable CPUID bits
Date: Fri, 16 Oct 2026 17:14:17 +0800
Message-ID: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
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

Patch 1 is a standalone fix for the existing denylist check, which uses
the index of the matched userspace entry instead of the subleaf reported
by the TDX module, i.e. userspace can bypass the HLE/RTM/WAITPKG check.
It is tagged for stable so that it can be backported independently of
the rest of the series.

Patches 2-5 build the allowlist, add CORE_CAPABILITIES to it, filter
KVM_TDX_CAPABILITIES, and validate the CPUID input of KVM_TDX_INIT_VM.
The last two patches are user-visible changes, which are now called out
in their changelogs, along with why existing userspace and guests are not
expected to be affected.

For this version, I'm hoping to continue to collect some RBs and Acks.
The key discussions from v3/v4 [1] are summarized below.  Note, FRED KVM
support is in progress upstream [2], and no TDX module with FRED support
exists yet, so there is no immediate issue.  But it would be nice to get
this series merged sooner rather than later.

Discussions from v3/v4:
- Rick asked whether the assumption that the reserved bits in
  CPUID.0x1.EAX, CPUID.{0x4,0x18,0x1F} and CPUID.0x80000008.EAX won't be
  used to enumerate features can be confirmed by the x86 architects [3].
  Confirmation is still pending.  Per the SDM/APM, these leaves/registers
  are defined for specific information (version, cache/TLB parameters,
  topology, and address sizes), so the reserved bits are expected to be
  used to extend the existing information rather than to enumerate
  features.  Allowing these registers in full is a best guess, but it's
  still far better than the existing denylist-based check.

- Whether to restrict the TDX feature bits to kvm_cpu_caps[].
  The conclusion from the discussions is to construct the allowlist based
  on kvm_cpu_caps[], plus a few bits that KVM can support for TDs
  independently of kvm_cpu_caps[].  If TDX feature enabling turns out to
  be consistently blocked by non-TDX VM enabling, a solution can be worked
  out then.

- New opt-in interface vs. backporting.
  There are two options for old KVM versions that don't do the filtering
  and validation:
  1) Add a new opt-in interface to expose features newly introduced by the
     TDX module.
  2) Backport this series to LTS/stable branches.

  The opt-in design vs. backport decision is deferred, since this series
  is correct and an improvement either way.

- Potential backward compatibility issue when an effective fixed-1 bit
  becomes directly configurable due to x86 feature deprecation.
  This is left for the future, i.e. it can be addressed if and when such a
  deprecation actually happens, e.g. by adding an opt-in interface to let
  users/admins choose between migration flexibility and backwards
  compatibility on old platforms.

Changes since v4 [1]:
- Split the CPUID entry index check out into a standalone fix, which
  allows it to be backported to stable independently of the rest of the
  series.
- Exclude XTPR from the allowlist, as neither TDX nor KVM actually
  virtualizes the feature and guests don't need it. (Xiaoyao, Rick)
- Rename TDX_CFG_EXTRA_F() to TDX_CFG_INDEPENDENT_F(). (Xiaoyao)
- Fix AMX_COMPLEX to be added for CPUID_7_1_EDX instead of CPUID_1E_1_EAX.
- Drop the descriptions in the TDX documentation and the uapi header, as
  the ioctl interfaces for KVM_TDX_CAPABILITIES and KVM_TDX_INIT_VM are
  unchanged by this patch series.
- Improve changelogs and comments. (Xiaoyao, Rick)

The series follows the CSV version of the CPUID virtualization document
from "Intel TDX Module ABI Definitions" [4], updated in June 2026.

AI tools were used to:
- Polish the cover letter and commit messages.
- Do code review.

[1] v4: https://lore.kernel.org/all/20260917072548.2314491-1-binbin.wu@linux.intel.com
    v3: https://lore.kernel.org/all/20260827031837.2863609-1-binbin.wu@linux.intel.com
    v2: https://lore.kernel.org/all/20260604023314.3907511-1-binbin.wu@linux.intel.com
    v1: https://lore.kernel.org/all/20260417073610.3246316-1-binbin.wu@linux.intel.com
[2] https://lore.kernel.org/all/20260911213659.2025974-1-sohil.mehta@intel.com
[3] https://lore.kernel.org/all/e7182b3c03a0e39cb60392b4d75111255418d6cf.camel@intel.com
[4] https://cdrdv2.intel.com/v1/dl/getContent/795381

Binbin Wu (5):
  KVM: TDX: Check unsupported CPUID bits against the TDX module's
    subleaf
  KVM: TDX: Track configurable CPUID bits allowed by KVM
  KVM: TDX: Add CORE_CAPABILITIES to the allowlist
  KVM: TDX: Report only KVM-allowed CPUIDs in KVM_TDX_CAPABILITIES
  KVM: TDX: Validate userspace CPUID input for KVM_TDX_INIT_VM

 arch/x86/kvm/vmx/tdx.c | 258 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 231 insertions(+), 27 deletions(-)


base-commit: dea4f6380f4ec96e8f3b0aaf2343764bd0d25ef4
-- 
2.46.0

