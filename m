Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7121B4C33E8
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687056; cv=none; b=oCFQxPztWHFTx/SNABI+GaKx9afr4UvCJYrH1Rkx0r0rEy4XIVBwwYJ8qIAqWjNHnaXFkrk05O/GvUxTVzEUnIn4Ed02tPMP+ZVmULbDdgVJIx0Rvfx/xO7xf6nOjv4h3VBy1DAAwP3oktNsjsPA/4dAAUQzQJsadHuvfNryr78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687056; c=relaxed/simple;
	bh=XKmN0R6HIOKGHHbCjVpqBS3Gas3qPOdlKs5igD/oOVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nm7wWnGaYyPEEUQDRtNZ7W1uAOqEusELw7ySSsw5+HcFvrQCnCgg6jOz/l/27ssluvhZc3fIW+Ow4vw2zbOwsMXvT+1eeCveEvbmvQztmHkHSYilKdyJjHBjEuTjGGxoxOeYrB5FMdIvZ25lN4vxr3jIgd7xtd2Q9kw8OR2kCkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=amMEzIeP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="amMEzIeP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790687054; x=1822223054;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XKmN0R6HIOKGHHbCjVpqBS3Gas3qPOdlKs5igD/oOVY=;
  b=amMEzIePneey6sNQ5NybkZ0u1YZMGtk0VILUnbM3+hybAWejYgqasGT5
   3EoUSdeTZHess/1QvAXrS1stCsu7ELAaDjE3ZzOAwdThgXNfvNaMokjA5
   7rjyiHirncjBIiuTIaY78+xIdoj8qlkiNpRodUJ63kl8uxBhbWZ7re/Up
   Hyxjr8m88uj069IKFNrPLxRxrnZp7bwe/sImcfMnI0b/ZZVHdkc4bksc1
   W2Pezz9OZLhwAGLgHrUJzp48wvAlNTJXIT3M8paMr0kJro3H0EaHc0i8k
   P5zEYqH9CqHdoQadnGFlZJagEPRj38mgpOeUq8j7/flsb3FO/5jOsF9Gm
   Q==;
X-CSE-ConnectionGUID: BqiEKYiTQdeaZs48OY37NQ==
X-CSE-MsgGUID: b0iMhq3WS5OESAw3b80q3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="108894082"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="108894082"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 06:04:13 -0700
X-CSE-ConnectionGUID: az7gROBmRNW5anPjRmZEYA==
X-CSE-MsgGUID: MpTNusbORGW7mRXZQnViTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="275397797"
Received: from lxy-dev.sh.intel.com ([10.239.48.89])
  by orviesa009.jf.intel.com with ESMTP; 29 Sep 2026 06:04:12 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	xiaoyao.li@intel.com
Subject: [kvm-unit-tests PATCH v2 0/2] x86: Make ACCEL_PROPS work
Date: Tue, 29 Sep 2026 20:24:32 +0000
Message-ID: <20260929202434.174501-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The goal of this series is to make ACCEL_PROPS work, which needs to use
separate "-accel" parameter to configure the accelerator instead of
"-machine accel=xxx".

Changes in v2:
- Add patch 1 to resolve the incompatibility between "-enable-kvm" and
 separate "-accel".

Xiaoyao Li (2):
  x86: Make cet and lam tests KVM-only
  x86/run: Use separate "-accel" option to configure the accelerator

 x86/run           | 2 +-
 x86/unittests.cfg | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.53.0

