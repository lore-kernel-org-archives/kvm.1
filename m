Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124543CA493
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920054; cv=none; b=ekl+qHGqJqpESPuHv7OrbSbWiMvet/ac/0lEkmf+1bHk8Nu2eOhx1w1jrYrJcpRu5kK3IR7pUJ/VPKGkzWoDdjgn9G7CizckLoAu9IKAUSvthSR/lzuzQ2ghfj3BgTDg0kq9kJ9ZuulFNsFSHLvD+SyTtOSU0OIG6L6r9CK73GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920054; c=relaxed/simple;
	bh=Ll4UsZuRNoQNy362Gt9SkZVf4O4AWcOWQWFPjNXElKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=evrDUwsq6hWuFHDyfZ1eaGxCRLE4jRmhdhDG2RBViItIWhuVudWUwFBbG19UHxs4H7AMCW6+EjhcPbrf02C5abzHhhL8uileIG71AMNKOEH4Czq3DqI+aGm8prXSWKPnLJjQt+R508Wyk1v7xyUKWZtL6DSzQexbDIxRGfzaYe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDy2BTyz; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDy2BTyz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779920053; x=1811456053;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ll4UsZuRNoQNy362Gt9SkZVf4O4AWcOWQWFPjNXElKc=;
  b=EDy2BTyzqhjeopLmH8cniHMhKBTWKUQzCP3+hP+fnmWbL2Li10j3+btt
   2i9B6NGwl+Nvn0Hmpz1PxH9EUpDS6+1sHZ5k165uO6oCjil+eUUUwd0sp
   bAzdRFFhAHEnb86NUtybEmr07IcQsyDlp9lEEDmhu5B00BNQWl6m1acgc
   vF7G+GZdOVKr1yR0MtXlyIZc/3u3r/j7JzDNS2ALTXoQLb5bs1YtZOPN4
   lZRyD8XUkaZ3RlwIK3/63vnpAdAvljt+wU+J97+wDVkNaig3r03WpjkcN
   0e7v+fCDML4lQUptiNT93ktKrn4xlCC2WGi96sAbdRSxsUV+K7htuME+Y
   Q==;
X-CSE-ConnectionGUID: qK9xeZPoTOaf3IFArizLGQ==
X-CSE-MsgGUID: ThrTiaWJTO2MEpOpHlevtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80615407"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80615407"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 15:14:12 -0700
X-CSE-ConnectionGUID: gWDSD+4RTPq+tzCKzK1nPg==
X-CSE-MsgGUID: UmlhxepqSbCuFl7Er87mYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="239362556"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.139])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 15:14:12 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: kas@kernel.org,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH] MAINTAINERS: Move Rick Edgecombe to TDX maintainer
Date: Wed, 27 May 2026 15:13:42 -0700
Message-ID: <20260527221342.415814-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per some offline discussion with Kiryl, he could use some help on the TDX
host side. I have worked on the TDX host side for the past few years
including wrangling the initial KVM support, and can help with this.

I am already listed as TDX reviewer. Move it to maintainer.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 882214b0e7db5..a838ff047d891 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28943,8 +28943,8 @@ F:	arch/x86/kernel/unwind_*.c
 
 X86 TRUST DOMAIN EXTENSIONS (TDX)
 M:	Kiryl Shutsemau <kas@kernel.org>
+M:	Rick Edgecombe <rick.p.edgecombe@intel.com>
 R:	Dave Hansen <dave.hansen@linux.intel.com>
-R:	Rick Edgecombe <rick.p.edgecombe@intel.com>
 L:	x86@kernel.org
 L:	linux-coco@lists.linux.dev
 L:	kvm@vger.kernel.org
-- 
2.54.0

