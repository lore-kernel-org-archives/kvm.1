Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F15305698;
	Wed, 12 Aug 2026 08:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522056; cv=none; b=lw/zDxmHZz1vSKVkNTefhiJLpg1aT0hxNs8V03Mnlh4A5trXlwov29Rj1fApQ9KTwjzO8jjqSdLlp9rCMCX+pBp2rTolcdISorGYNuoV65QkLTOmvMw0iZkcICFM29TLoPQLO28IjfUKRq1c5H8R9NdMszenuHqXrC0RiDvPvIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522056; c=relaxed/simple;
	bh=AMz77dxfIwA56MZwT8xeckdbhQKxSTrQA8X3ZSJWp/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VUuPtFcGphfLAUzJ05VMUTwXHt8FcZxunnYTEZ6IjSjydN36V/ANXGEzXtYq8vCV8piJ2j6e7USi3zjGYjOIxkfb94fIv+/A1LkEQfH27RC6cUan4cD7/pTwOF5+oPQPgstFgQ9robVi80imf6nqnZ2seDly5kYc+AQIfQ4qPmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IUrlsChq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IUrlsChq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786522056; x=1818058056;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AMz77dxfIwA56MZwT8xeckdbhQKxSTrQA8X3ZSJWp/M=;
  b=IUrlsChq9QqK43NpN8zrwoGxk1iYlzFpCkudr+SHV8NeZk16GGcp2MAA
   ZNUv04XskIbwQFSi0WjFmmNAEpBn4WeqVe598JklrrJ4Xw3hTcxZIcSEH
   iCNsx6GQOc7vqaldRf1qLAPOCC6JVnMs2XgaH2TugxUh2XXzF50lmfqSH
   tsj5yytN3OYcMfIJaoU6RqF+X/7JbrHypZJ6QVe0ZYlBO7FRNXjc/I3+a
   gnAtbyjKLf9FtFQqK/FeLodMBn8+1vMlza8tDB+re2akEBZ3fnYhhc4Oo
   qc+MfbB+mzfrYZlqOyvYQK0tBcpSiSk1JNcPyQAFRblLRopwKFMvftjEi
   A==;
X-CSE-ConnectionGUID: 5MLqzrgQSGCDBVArvCCDsQ==
X-CSE-MsgGUID: HyW2eJ42S/aeqyJjF/AZOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97413257"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="97413257"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 01:07:35 -0700
X-CSE-ConnectionGUID: mKh3p91DSrGFWk8QD9JBeA==
X-CSE-MsgGUID: Ew3n19EYT/K1kHkQBW9zpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="287000358"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.33])
  by fmviesa002.fm.intel.com with ESMTP; 12 Aug 2026 01:07:32 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	nik.borisov@suse.com,
	xiaoyao.li@intel.com
Subject: [PATCH v3 0/4] KVM: TDX: Enable VM-DoS Prevention Features for TDX
Date: Wed, 12 Aug 2026 16:02:25 +0800
Message-ID: <20260812080229.2481439-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is v3 of the series to enable the Notify VM Exit and Bus Lock VM
exit for TDX, which fixes the KVM CAP issue related with them and allow
userspace to actually enable the features.

It still tries to keep the series as small as possible because it's
targeted for being backported to stable kenrels.  This v3 splits the
patch2 of v2 into two patches (patch2 and patch3 in this v3) to make them
easier for review.  There are other issues of existing code found during
previous review but not mandatory for this series. The plan is to address
them in followup series separately.

Please refer to v1 for a full background.

v2: https://lore.kernel.org/all/20260810112200.2326727-1-xiaoyao.li@intel.com/
v1: https://lore.kernel.org/all/20260805031257.1844914-1-xiaoyao.li@intel.com/


Xiaoyao Li (4):
  KVM: TDX: Enable Notify VM exit
  KVM: TDX: Set bits 31:16 to 0 for the synthesized Exit Reason
  KVM: TDX: Don't assume exit_reason[31:16] as all-0 in
    tdx_to_vmx_exit_reason()
  KVM: TDX: Enable Bus Lock VM exit

 arch/x86/kvm/vmx/common.h | 19 ++++++++++
 arch/x86/kvm/vmx/tdx.c    | 75 +++++++++++++++++++++++++++++++--------
 arch/x86/kvm/vmx/vmx.c    | 15 ++------
 arch/x86/kvm/vmx/vmx.h    |  1 +
 4 files changed, 82 insertions(+), 28 deletions(-)


base-commit: 1b731e5ded480bd1e5546aed35584238661ce72e
-- 
2.43.0

