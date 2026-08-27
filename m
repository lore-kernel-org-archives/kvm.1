Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A187E382F1C;
	Thu, 27 Aug 2026 03:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787800439; cv=none; b=ZbhcH7z6dsthQQxHvS6x41KoL6yrN2/5mVbRetAB3+Wf6PvHUUaZx4UeikSjyspNWvuR8v2Yu2A21zU8uxAOKVqwJnLowxBCbgNPgTWOmeGd2/S43s31abXhaJXtaF7YhaklnSdWSGtwmD2t3NEJrI90WZKwg2ZPbFYH+5JPEiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787800439; c=relaxed/simple;
	bh=nGCSYyo/h9DheITHez6bmG5SD7boChoHdtT6PkMgBZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MrzFcw1BoZlATg2aq99Ia+qe1AghkNHS+qyZJLf7POLQy3fVfzAmK3E/5bIUTwPhqirQTwuTtVFjN7siPXZYSYGmqaO02X2RP2q5oyNJtzrQ66wna6t3XQJ1WDz2LwdQS3A73YXqXGFYPRGWntgd7ghHEAFjQS0IuTYuPWN7q/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J7YtpG5F; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J7YtpG5F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787800437; x=1819336437;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nGCSYyo/h9DheITHez6bmG5SD7boChoHdtT6PkMgBZs=;
  b=J7YtpG5F5UhP1Wpt7V4zucfW4crJs6UcD9m42cNTAZzI8ldQrFgviHQR
   ku4CVRvmLq9WdkUbrwYYImwvRAU9I1lmuqOVMyZkV4QLeUOhbtL4DsTnH
   CnZtQJR85g5B8kh8DeKW3WYwSqnlmrtE3ZIHanXn3bqbHgeha2g8sS46B
   j5M+IWSrT0dyliH7TPSeeikLJZtcoD52plglQAfj6BPskO+wdOsgfX+Du
   u8EDjBOq+lDDXyEH1TcjldOF+JNhUmO4aOqV+bha/sPd+yu+jdaiNsgrY
   nQSZJiZJRZPWTWinFpJHxxHUVuwBX/539aGGF80zWxT50Tx163mCodb5K
   g==;
X-CSE-ConnectionGUID: UZ90nKu5TLSxl1XdSOQfGQ==
X-CSE-MsgGUID: NaU94hiIQ/+HS+PYpYFjSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="98964526"
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="98964526"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 20:13:56 -0700
X-CSE-ConnectionGUID: MKWGK7m5R+GP2CPJkiA74g==
X-CSE-MsgGUID: BziuH5qpTr+i69Bxsh3PyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="271264005"
Received: from litbin-desktop.sh.intel.com ([10.239.57.15])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 20:13:53 -0700
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
	binbin.wu@linux.intel.com
Subject: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID bits
Date: Thu, 27 Aug 2026 11:18:33 +0800
Message-ID: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The purpose of this patch series is to prevent userspace from enabling
host state clobbering features that KVM does not support for TDX.  A host
state clobbering feature exposed on a new TDX module/platform can corrupt
host state if KVM does not explicitly save and restore the related MSR(s)
across host/guest transitions.  If such a feature is blindly exposed to
and used by a TD, the host will behave unexpectedly.

Except for a few fixed-1 bits required for basic TDX support, host state
clobbering features are either directly configurable or gated by TD
ATTRIBUTES/XFAM.  So an allowlist covering only the directly configurable
CPUID bits, plus the corresponding filtering and validation, is sufficient
to serve the purpose while keeping the code footprint small.

Open question for Sean/Paolo
============================
This revision comes long after Sean confirmed the overall direction on
RFC v2 [1], due to internal discussions about a potential backward
compatibility issue: a CPUID field can change virtualization type to
directly configurable.  The TDX module can maintain backward
compatibility in most cases; the problematic case is a single bit that
was effectively "1" and non-configurable becoming directly configurable.
The only scenario we can envision for that is an x86 feature deprecation.

In that case the TDX module has to decide how to handle deprecation,
especially with respect to TD migration compatibility.  That
pre-existing VMs with the deprecated feature enabled cannot migrate from
an old platform to a new one is a problem shared by TDX and VMX, but the
TDX module additionally has to decide:
- Whether to allow TDs newly created on old platforms to migrate to new
  platforms.
- Whether to allow TDs created on new platforms to migrate to old
  platforms.

There are two options:
1. Do not offer the VMM the ability to configure the bit, i.e. simply
   report it as zero on platforms that no longer support the feature.
   This disallows both migration cases above.
2. Make the bit directly configurable so the VMM can clear it even on
   platforms that still support the feature, allowing both migration
   cases above.  However, since the bit is not in KVM's allowlist,
   userspace would no longer be able to enable it on old platforms after
   a TDX module update.

Adding all supported CPUID bits to the allowlist, regardless of their
virtualization type in the TDX module, would avoid the compatibility
issue for option 2, at the cost of a significantly larger series.

Given that x86 feature deprecation is expected to be very rare, and that
Intel will discuss such cases with the community beforehand, does the
approach taken by this series look acceptable?  If so, the goal for this
revision is to collect detailed feedback and, where appropriate,
Reviewed-by tags.

Expected host state clobbering behavior for TDX
===============================================
We also want to call for discussions about the expected host state
clobbering behavior for TDX here for future features.

For a normal VMX guest, VM entry/exit behavior for a given piece of CPU
state is architecturally defined: state is either switched by hardware via
VMCS host/guest fields, or left as the guest value on VM exit and managed
by KVM in software.

For TDs, the host/guest transition goes through TDH.VP.ENTER, and what the
TDX module does with a given piece of host state is defined by the TDX
module ABI rather than by the x86 architecture.

What we would like to align on is the expected baseline behavior of
TDH.VP.ENTER for future features.  The proposal is to have TDX simply
match VMX behavior, i.e. on return from TDH.VP.ENTER, state that VMX would
restore from the VMCS host fields is restored, and state that VMX would
leave as the guest value is clobbered.  That keeps a single model for VMM,
and means enabling a new feature for TDs requires the same work flow as
enabling it for VMX.

FRED is a useful concrete example.  Under VMX, the FRED host state in
IA32_FRED_CONFIG, IA32_FRED_STKLVLS, IA32_FRED_RSP1-3 and
IA32_FRED_SSP1-3 is covered by the VMCS host-state area, so the TDX module
is expected to restore these MSRs on TDH.VP.ENTER return.  IA32_FRED_RSP0
and IA32_PL0_SSP (a.k.a. IA32_FRED_SSP0) are handled by software, so the
TDX module is expected to clobber them on TDH.VP.ENTER return.

The series
==========

Starting with v2 [2], the series takes a simpler, TDX-contained approach
instead of the comprehensive CPUID paranoid verification framework across
VMX, SVM, and TDX proposed in v1 [3].  It validates only the TDX directly
configurable CPUID bits, which are reported by the TDX module in
CPUID_CONFIG fields that the VMM can configure for a TD.  All filtering
and validation logic is isolated within TDX code.  This is sufficient to
address the host clobbering issue because:
- The TDX module will not introduce new host state clobbering features
  that are fixed-1.
- Non-directly configurable feature bits (i.e. features controlled by XFAM
  or ATTRIBUTES) cannot be enabled by userspace without KVM's support.

Specifically, this series builds a KVM-side allowlist of supported TDX
directly configurable CPUID bits to:
 - Filter KVM_TDX_CAPABILITIES
   Replace the hardcoded denylist to only report configurable bits that
   KVM explicitly supports.
 - Validate KVM_TDX_INIT_VM
   Reject any configurable bit that the TDX module allows but KVM does
   not support, as well as CPUID entries with an unexpected subleaf.

With this allowlist, newly added TDX configurable CPUID bits will not be
exposed to userspace until KVM explicitly opts in after fulfilling the
necessary virtualization requirements.

The allowlist consists of two parts:
- Feature CPUID bits, which are tracked in tdx_cpu_cfg_caps[] following
  the organization of kvm_cpu_caps[].  It holds KVM's supported masks for
  the TDX configurable CPUID feature bits.
- Non-feature multi-bit fields, which are handled at runtime for the CPUID
  registers holding such fields.

For compatibility with older TDX modules that report CORE_CAPABILITIES as
fixed-1, report CORE_CAPABILITIES as configurable even though KVM does not
support guest access to MSR_IA32_CORE_CAPS.  This allows userspace to keep
enabling CORE_CAPABILITIES when the bit changes from fixed-1 to directly
configurable, and allows userspace to infer that the bit is no longer
fixed-1 so it can adjust its expectations.

Known limitation:
- The series does not check KVM_SET_CPUID2 input for consistency with the
  CPUID configuration supplied through KVM_TDX_INIT_VM.  This is not
  required for host safety today because KVM does not use its vCPU CPUID
  model to decide whether to manage host-clobbering state for TDs.  A
  consistency check should be added if KVM ever starts relying on the vCPU
  CPUID model for such decisions.

Changes from v2 [2]:
- Drop the dedicated data structure introduced in v2; track only feature
  bits following the organization of kvm_cpu_caps[], and handle
  non-feature bits at runtime. (Sean)
- Add AMX_COMPLEX since it has been defined in the CPUID virtualization
  doc.
- Add CPUID.0x24.0.EBX[7:0] into allow list. There is a mismatch of the
  description about CPUID.0x24.0.EBX[7:0], which is listed as
  "XFAM & CPUID_Enabled & Native" but should be "XFAM & CPUID_Enabled &
  Configured & Native".
- Move the patch for CORE_CAPABILITIES earlier in the series to avoid
  breaking userspace during bisection. (Xiaoyao)
- Report CORE_CAPABILITIES as a configurable bit to userspace for
  backward compatibility, but drop the MSR_IA32_CORE_CAPS access code.
- Use two versions of macros to distinguish whether a supported TDX
  configurable CPUID bit should be checked against KVM's common CPU
  capabilities.
- Validate KVM_TDX_INIT_VM input against the allowlist instead of masking
  it, and additionally reject entries whose index does not match the
  TDX sysinfo configuration. (Sashiko)

Changes from v1 [3]:
 - Drop the overarching CPUID paranoid verification framework across
   VMX/SVM/TDX and the opt-in interface. (Sean)
 - Shift focus entirely to isolating and validating TDX directly
   configurable CPUID bits.

The series follows the CSV version of the CPUID virtualization document
from "Intel TDX Module ABI Definitions" [4], updated in June 2026.

AI tools were used to:
- Check the coverage of the directly configurable CPUID bits in the
  document against the allowlist in this series.
- Polish the cover letter and commit messages.
- Do code review.

[1] https://lore.kernel.org/kvm/aj1fqZEcApyd4sxi@google.com
[2] https://lore.kernel.org/kvm/20260604023314.3907511-1-binbin.wu@linux.intel.com
[3] https://lore.kernel.org/kvm/20260417073610.3246316-1-binbin.wu@linux.intel.com
[4] https://cdrdv2.intel.com/v1/dl/getContent/795381

Binbin Wu (4):
  KVM: TDX: Track configurable CPUID bits allowed by KVM
  KVM: TDX: Report CORE_CAPABILITIES as configurable
  KVM: TDX: Filter configurable CPUID bits
  KVM: TDX: Validate userspace CPUID input for KVM_TDX_INIT_VM

 arch/x86/kvm/vmx/tdx.c | 258 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 229 insertions(+), 29 deletions(-)


base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97
-- 
2.46.0

