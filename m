Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDC03C3F70;
	Wed,  5 Aug 2026 03:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785899882; cv=none; b=lsQsFXCZaQMjLs5Aj6uuSP8f11ZZj1Psnwrp2BRW/Oa0TBka3t2scNaKsD5Sbkne/5yseNnwcIQe+KkYaz83jes9zIlZARDANV+oGYOMzk6RlKiaekdJ1jJDZ92mfbwIz8Ap9HmvRL8KpyWQxDJGJpOUmIkgd+acGbahqcE530I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785899882; c=relaxed/simple;
	bh=csc8YNLPNLODMjV7kbgLAWrRacayW2aNDWDAx5skxOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a1k7nhkDQXqalwn7V3CgPdxHucaevcR3J9+awaGbxGswAKfcM7QXtHvb6O8q8aF+7g6mYfZigHZFc8237VaGeV5oQ+ypYVaNUmQl/BaeLyAD7v3l8DaC96/DO+zdwTLXQWVQ9vzgzlbUXYxUDYwI2vM4PMrmiY8AKlg5O5ncYwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=anAfNR+p; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="anAfNR+p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785899879; x=1817435879;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=csc8YNLPNLODMjV7kbgLAWrRacayW2aNDWDAx5skxOE=;
  b=anAfNR+pyIaATH/RnQn//DiKnm/H6y5dBneC21dQyMe5KnikcBb8I0ir
   iDz/S5PLVtsQG0S2M6Lkea76egUrqBZl49lQSVVIGx2vb7lQoCfrMgY2S
   iUdUyqSx2r+euIPO5ZGttZmjoa72Gdhd0JXYPajkEx+tduN9Ax+HDbd+G
   3Q8nxnOeWVqkVLZLqOrjUPfwPHaST/G9zR9MG3LEaHp+0RlJ8jsOH2QqA
   ek8QBpkW9yDnhYTKL+hELuJuz3xFIBwGyy1EnAzky56puQ8OdHhItFlAI
   zM4ajEpU2dy8j6Odec/tL1a6CCE0bj8YLe3J+MB18vwhjRunXnPZmeegF
   w==;
X-CSE-ConnectionGUID: zOn5++20QvWqQz1n4DPhNQ==
X-CSE-MsgGUID: l1E7hA1zSsG+5f1ioly/MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86493958"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="86493958"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 20:17:58 -0700
X-CSE-ConnectionGUID: UdrxiKjDQky7iZf5TRzIEA==
X-CSE-MsgGUID: p+VywjDiSc+XBz/ErpqdlQ==
X-ExtLoop1: 1
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.33])
  by fmviesa003.fm.intel.com with ESMTP; 04 Aug 2026 20:17:54 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaoyao.li@intel.com
Subject: [PATCH 0/2] KVM: TDX: Enable VM-DoS Prevention Features for TDX
Date: Wed,  5 Aug 2026 11:12:55 +0800
Message-ID: <20260805031257.1844914-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are 3 existing DoS prevention features that can be used by
KVM/Linux to prevent DoS attacks from guests.

1. Bus Lock VM Exit

This feature is controlled by KVM. KVM exposes KVM_CAP_X86_BUS_LOCK_EXIT
as the interface for userspace to query support for and enable the
feature. When enabled, a VM exit occurs after the execution of an
instruction that asserts a bus lock. This VM exit is trap-like, meaning
it does not prevent the bus lock from occurring but can detect that one
has occurred. Similarly, there is another bus lock detection feature for
OS usage, where a #DB is raised when a bus lock occurs at CPL > 0. KVM
does not use this feature to detect bus locks from guests, but
virtualizes it for the guest so that the guest can use it to detect bus
locks from its own userspace.

2. Notify VM Exit

This feature is also controlled by KVM. KVM exposes
KVM_CAP_X86_NOTIFY_VMEXIT as the interface for userspace. When enabled,
a VM exit occurs if certain operations prevent the processor from
reaching an instruction boundary within the configured time window.

3. Split Lock Detection

This feature is controlled by the host kernel rather than KVM. When
enabled, a #AC is raised before a split lock can be acquired. Since the
MSR controlling this feature is per-core in scope, KVM does not
virtualize it for guests. As a result, when a guest split lock triggers
a #AC, the exception is unexpected from the guest's perspective. KVM
addresses this by intercepting the #AC and allowing the host to handle it.

For features 1 and 2, support was missed (inadvertently omitted) for TDX
during the initial TDX base support upstreaming. However, KVM still
reports KVM_CAP_X86_BUS_LOCK_EXIT and KVM_CAP_X86_NOTIFY_VMEXIT as
supported even for TDX guests. This means userspace does not receive an
error when attempting to enable these features for TDs, even though they
are not actually being enabled.

For feature 3, KVM cannot intercept #AC from TDs. There was a prior
effort[1] to enlighten the Linux TD guest kernel to handle such #AC.
however, it was not accepted. We are looking at TDX architecture
enhancement to allow intercepting #AC from TDs.

This series therefore focuses on fixing the CAPs reporting issue and
enabling features 1 and 2 for TDX. Specifically, this series adds the
codes to call SEAMCALLs to set the controlling bits for the features in
TD VMCS and implement the corresponding exit handlers.

[1] https://lore.kernel.org/all/20260107134955.3293885-1-xiaoyao.li@intel.com/ 

Xiaoyao Li (2):
  KVM: TDX: Enable Notify VM exit
  KVM: TDX: Enable Bus Lock VM exit

 arch/x86/kvm/vmx/tdx.c | 33 ++++++++++++++++++++++++++++++++-
 arch/x86/kvm/vmx/vmx.c | 25 ++++++++++++++++---------
 arch/x86/kvm/vmx/vmx.h |  2 ++
 3 files changed, 50 insertions(+), 10 deletions(-)


base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
-- 
2.43.0

