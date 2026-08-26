Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B114F322B8F
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 03:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787715333; cv=none; b=kzR4c7Ah1NNjf0sbyKDh5IIeyTJ2VkrLgsUdb3wv3chtsuI4gej45rhiYPJzQ7u2/sXIJnj7v7fwenMckMMMXj+HymDkLJxEobF3UWmO0s60tZ3k/MEAiQ+R+alAwGqKe9MJZrX/m1aqEHAb92vw0h3RkpPtWpQRis7XGxmLPbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787715333; c=relaxed/simple;
	bh=ULqvLgcf5aolbxdLszytXH1oq+3IAUaBe+G/qeS8EdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eCLVHOjXOjMiBPW4uOpdFtzngKf1vwY7A3Fl/0mDmc5kMB7f+BIXGPo162FPnrYhqndHypos5n8hsrGEeFWwcdEpM13Dx5nkWLO0uB4r2KmdqIsmclqghZ+cIm0J3WyAGWdhAMran1rNob8GN69Q7DMZtJPIYQWDttqI53ZADCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cY3/3KRO; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cY3/3KRO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787715332; x=1819251332;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ULqvLgcf5aolbxdLszytXH1oq+3IAUaBe+G/qeS8EdM=;
  b=cY3/3KRO62WPUAjzfjQoQeIE7bA/wYs3NP3DwRDCNv5qDopAkyDrAiav
   E8dblV4LRXyuQrYQ4peDhVrV9S/mQYGb6ejd+uaPDznHXvaMbx6DDlvtY
   rxfrozJ3e9zVVI30MLLTVqeHvDLl3jipxRXax11vFEpOCeamszk6ya/hm
   m6Vn59O+2CRPSrC4QBb20qbQt3Wq+nn/19PFsQMGagDrzc7WA/ucEimQv
   N1d6U5x3VdenMeXRCvoESpg2zL5b00S7+6qHd3/Kvdfk5iEBn/MAoGQLf
   /yRAXlrMLlUbgZhZNiCdnSWwB2tPOKJO9xKPPvfRNsBhEAMf8AzdSDi4T
   A==;
X-CSE-ConnectionGUID: lQ0cdkmOTi+YMnvEczEAyQ==
X-CSE-MsgGUID: cC1uY43xTQGfNlhwEEIxNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="75728370"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="75728370"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 20:35:31 -0700
X-CSE-ConnectionGUID: nB/r3phlSgKxFBIsXLmKcw==
X-CSE-MsgGUID: /1JyepAAS26vrUjWpwqhxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="297364009"
Received: from d404e69c8b80.jf.intel.com ([10.54.34.91])
  by orviesa002.jf.intel.com with ESMTP; 25 Aug 2026 20:35:31 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	zhao1.liu@intel.com,
	kvm@vger.kernel.org,
	sohil.mehta@intel.com,
	xiaoyao.li@intel.com,
	binbin.wu@linux.intel.com,
	farrah.chen@intel.com,
	kishen.maloor@intel.com
Subject: [PATCH 0/5] target/i386: Add support for LASS
Date: Tue, 25 Aug 2026 20:57:29 -0700
Message-ID: <20260826035734.114685-1-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds QEMU support for Linear Address Space Separation (LASS) [1],
an Intel security feature that prevents a class of side-channel attacks
relying on speculative accesses across the user/kernel boundary. Paging,
along with SMEP and SMAP, already provides mode-based access protection,
but enforcing it requires a page walk whose timing can leak the layout of
kernel memory. LASS applies the equivalent protections during
linear-address pre-processing: given the usual partitioning of the linear
address space into a user half (bit 63 clear) and a supervisor half
(bit 63 set), an access targeting the opposite half is rejected on the
basis of bit 63 alone, before any page walk.

This series enumerates the LASS CPUID bit, recognizes CR4.LASS,
and exposes LASS on the relevant Intel CPU models via new versioned models.
LASS is not emulated by TCG.

Exposing LASS to a guest also requires KVM support: KVM must validate
the CPUID bit and CR4.LASS, and enforce LASS violations in its
instruction emulator. That enabling is currently under review [2].

Tested with a Linux guest on LASS-capable hardware: LASS is enumerated and
CR4.LASS is set under KVM, and not enumerated under TCG.

[1] Intel 64 and IA-32 Architectures Software Developer's Manual, Volume 3A,
    Section 4.3, "Linear-Address-Space Separation (LASS)".
[2] https://lore.kernel.org/kvm/20260806011536.4172258-1-sohil.mehta@intel.com/

Isaku Yamahata (2):
  target/i386: Add support for LASS in CPUID enumeration
  target/i386: Add LASS support in CR4

Kishen Maloor (3):
  target/i386: Introduce DiamondRapids-v3 to enable LASS
  target/i386: Introduce SierraForest-v7 to enable LASS
  target/i386: Introduce ClearwaterForest-v5 to enable LASS

 target/i386/cpu.c    | 26 +++++++++++++++++++++++++-
 target/i386/cpu.h    |  7 ++++++-
 target/i386/helper.c |  4 ++++
 3 files changed, 35 insertions(+), 2 deletions(-)

-- 
2.47.1

