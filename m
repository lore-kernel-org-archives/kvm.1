Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EFF22538F;
	Thu,  4 Jun 2026 02:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540186; cv=none; b=C2QSmZAa1Xned2M7qmDq8iCUhXVAhsdVOtPNNugAyEbS/VD9zVd6omw+KMkvfRAGvdh61ZQE9PFk25nZzie8GCi433r0uwiMfjwA9l6RRmo8mr3jOeAiUe4JwA7ExHE1E0v0wIvo/1tUjGYgPzEcw5zVlmngNJOf8mk4Uv7AT60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540186; c=relaxed/simple;
	bh=arkpqNknWxmNZK86E6H+1JwdIlW/O8xgEkmqrL4fmCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YM8OmlPXE+QxwqPhpiaprOszeBTGOfObsM9iCv0Q5nMYdlGEiOVk1jJvD3enmCwCkU/hhaGk7+8O22W7UhPI78XtiHi8CGdknQRRMjHkz7sOeKy1oxZjorXGnw9QHZpvsqajAB+83GwPJ35szytALoooKTV0jax/3GogQitd9w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DtiscIem; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DtiscIem"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780540184; x=1812076184;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=arkpqNknWxmNZK86E6H+1JwdIlW/O8xgEkmqrL4fmCM=;
  b=DtiscIemLXUWCdR8QPSAlD1ogxdoJ1KIeVvkF01dFAAsumrmcrpHaK6r
   onzk52ZtjFKbNTAsPo6sEEP+AUiI9IXP/4JHQVDdS22Ix6QxROTo/512F
   umC+w9H5D2Xgi7VAUBlUcBkgIvbiYyy7e73lU4TtPb8hdfjMNBls6EFaJ
   rkfqa2jgFuaBOCDKmamr+0dzfs/jy686CeXIq9LxIWm8i/k5unriugyCs
   HVhpdg5QRxgDRen+H3AF4IZ0TQkL4P9huT1pLXQMMdr+Rbe9OOnk56o5K
   b5ZN6GSNgg4tNBAgtH8xMcnxdLyc8YhgUdEGu2v8q44FntFllJeKA5784
   w==;
X-CSE-ConnectionGUID: e3un+7JxR8KgzY234jtUiA==
X-CSE-MsgGUID: FajQbSE6RoiNs1tdEQc3jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="92045232"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="92045232"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 19:29:43 -0700
X-CSE-ConnectionGUID: cR0MZkg2TjWk1pVvVBRfzw==
X-CSE-MsgGUID: diehkjfXR4ec8XB00iD6BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="239940476"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 19:29:41 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH v2 0/4] KVM: x86: TDX: Validate directly configurable CPUID bits
Date: Thu,  4 Jun 2026 10:33:10 +0800
Message-ID: <20260604023314.3907511-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

A host state clobbering feature on new TDX modules/platforms can lead
to host state corruption if KVM does not explicitly save and restore
the related MSR(s) during host/guest transitions. If such a feature is
blindly exposed to and used by TDs, it will result in unexpected behavior
on the host.

The v1 RFC [1] attempted to solve this by introducing a comprehensive
CPUID paranoid verification framework across VMX, SVM, and TDX. However,
as Sean pointed out in [2] and the discussion in the PUCK meeting, this
approach was overly complex and bled too many TDX-specific details into
common KVM code, creating an unnecessary maintenance burden.

This v2 takes a significantly simpler, TDX-contained approach. It strictly
validates only the TDX directly configurable CPUID bits—those reported by
the TDX module in CPUID_CONFIG fields that the VMM can configure for a TD.
This is sufficient to address the host clobbering issue, as no new host
state clobbering features will be fixed-1. All filtering and validation
logic is entirely isolated within TDX code.

Feedback is highly appreciated, particularly on whether this contained
approach strikes an acceptable balance regarding complexity.

Specifically, this series builds a KVM-side allowlist of supported TDX
directly configurable CPUID bits to:
 - Filter KVM_TDX_CAPABILITIES:
   Replace the hardcoded denylist to only report configurable bits that
   KVM explicitly supports.
 - Validate KVM_TDX_INIT_VM:
   Reject any configurable bit that the TDX module allows but KVM does
   not yet support.

With this allowlist, newly added TDX configurable CPUID bits will not be
exposed to userspace until KVM explicitly opts-in after fulfilling the
necessary virtualization requirements.

Open:
- This series doesn't implement validation for KVM_SET_CPUID2.
  TDX has two interfaces for userspace to set CPUID bits: KVM_TDX_INIT_VM
  and KVM_SET_CPUID2. A malicious userspace VMM could lie to KVM through
  KVM_SET_CPUID2 by setting a TDX directly configurable CPUID bit to a
  different value than what it set via KVM_TDX_INIT_VM. KVM does not
  currently use its own view of vCPU capabilities to manage host clobbering
  features for TDs. The consistency check is not a must have action so
  far. It could be added later if KVM really relies on its own view
  to make decisions to manage host clobbering features for TDX.

Changes from v1:
 - Dropped the overarching CPUID paranoid verification framework across
   VMX/SVM/TDX and the opt-in interface. (Sean)
 - Shifted focus entirely to isolating and validating TDX directly
   configurable CPUID bits.

[1] https://lore.kernel.org/kvm/20260417073610.3246316-1-binbin.wu@linux.intel.com/
[2] https://lore.kernel.org/kvm/agsiQGikhZA0CGTY@google.com/

Binbin Wu (4):
  KVM: x86: TDX: Track supported configurable CPUID bits
  KVM: x86: TDX: Hide unsupported configurable CPUID bits
  KVM: x86: TDX: Validate userspace CPUID input for KVM_TDX_INIT_VM
  KVM: x86: TDX: Report CORE_CAPABILITIES as supported

 arch/x86/kvm/vmx/tdx.c | 251 +++++++++++++++++++++++++++++++++++------
 1 file changed, 214 insertions(+), 37 deletions(-)


base-commit: d4bfaa66fa171089b9b9fb2dc17af9245f2b9b34
-- 
2.46.0

