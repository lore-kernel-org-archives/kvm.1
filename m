Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A11B3644BD;
	Thu,  5 Mar 2026 23:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753745; cv=none; b=rlhgnowrNl8Uf7c+id63TiQofanKIxLwJnpVTSZSSbDBsZ+/01Yp1lLDVdtaCBF+pUNRBPaSyeAkTIrWz2T79UG2W0EMJQjyG11PHS7jfEzlC9Ro/46LdXlFKc57qsD8gUWx/bOHxjhAwwdYwYEO1SrHQGnv7LP3Exr//tBYtoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753745; c=relaxed/simple;
	bh=t0TZmCG4eAXE2szr4WjVr28rsk/ho3gKxkgeBrqNmNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gPFhXhmMZdyYILOaYJVC0Abp5WhaKESV1fe6NQ15ajf0UY1goLSXjn1E5HKKK5AKpKiRg+SCUqDTV1G18fYfyyejTUCzT0nh4fDtFvVj2WL0m0tC5SOUv34jmsR2p16uoxv66PeK0ur9CA6DUPaBPnntGAlBuurERZiUh/sJqJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RIwFP0xY; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RIwFP0xY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772753740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=m4mNsXRdwDDdjn3tPZCDa4XCAx1aTHCTpEKqRD6WqUQ=;
	b=RIwFP0xYGz0AAHFlEq12y/hIDJSkuk+DntyDWLVvrseNqPYYsVExAUD5JXMJk6NrK8eITG
	d8NWeCF2iOpYB+zmhcSbsyx72f2fLK224fpi3A5/15eBHw7xwZdAPC9RdH3cLAXvYZe5qV
	fYlejfnNPAOS0UwaISfOVSRTZLQdoKg=
From: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
To: jp.kobryn@linux.dev,
	kwankhede@nvidia.com,
	alex@shazbot.org
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	malmond@meta.com,
	kernel-team@meta.com
Subject: [PATCH] vfio/mdev: make VFIO_MDEV user-visible in Kconfig
Date: Thu,  5 Mar 2026 15:35:26 -0800
Message-ID: <20260305233526.32607-1-jp.kobryn@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: JP Kobryn <jp.kobryn@linux.dev>

VFIO_MDEV is currently hidden and only enabled via select by in-tree
consumers. Out-of-tree drivers such as the NVIDIA vGPU rely on the mdev
framework but have no way to trigger its selection.

Add a description and help text to make VFIO_MDEV visible and directly
selectable.

Suggested-by: Matthew Almond <malmond@meta.com>
Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
---
 drivers/vfio/mdev/Kconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/mdev/Kconfig b/drivers/vfio/mdev/Kconfig
index e5fb84e07965..642d46b7aa4b 100644
--- a/drivers/vfio/mdev/Kconfig
+++ b/drivers/vfio/mdev/Kconfig
@@ -1,4 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 config VFIO_MDEV
-	tristate
+	tristate "Mediated device driver framework"
+	help
+	  Provides the mediated device (mdev) framework, which allows
+	  physical devices to create virtual instances for use with
+	  VFIO-based passthrough.
-- 
2.47.3

