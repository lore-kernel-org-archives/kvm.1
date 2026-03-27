Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEA83451C6;
	Fri, 27 Mar 2026 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630525; cv=none; b=qRSon0X4CAl4Cu0fyPkTwKt3WZo4OeqhIOizOgXQkcGxNQBMw/mNjL2V2wpS2KUiQiz6XhVFxPOJDvFI2xZMyo+GKZpK8gxOUbmtf9o7adA0a92eo6gpszgMiR+H6MIj/WfGsYIWVsUZF7Wc0XQeG0+AJ+QuZTt5C9g0wyQ89o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630525; c=relaxed/simple;
	bh=TVMo1XFVXuxmUw2tvJOzz0y0grawZJzuaipTlPoW+rU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kMuIaDvc77gG5lM3nF22vXAOydWehE5ola0arl4uzeUzmmmUzJerP5qB3SWSdFE3WXaSCISLb6HR+HR5o5FSvMoJnfpR3gor7PNT5FbT9ZcGqckCAWmSd1rHJ1/v4/RX7ZEGj3fSFiyhxW46AjRsVhdFEO6QuFIVI2pTIonEqJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLE57vbE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLE57vbE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD08C19424;
	Fri, 27 Mar 2026 16:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774630525;
	bh=TVMo1XFVXuxmUw2tvJOzz0y0grawZJzuaipTlPoW+rU=;
	h=From:To:Cc:Subject:Date:From;
	b=hLE57vbEtjRYgTp1wk78TmrhMjM6JVFjeNGB5qMM4WcbsFrlBodTeDplBIagOca5O
	 mrR/toMDIDWbskHacAZ0IEoh1HT4km4ECIXeAXbNrIVDuIIGTH7HNUyiwig9PjE6NR
	 XWc1knNM2ytlQ81UVHLNhNnZSEyIFmx8wIPT96hXCX0tmrg1Kt4csy8ICgHDskBYgZ
	 9JOdvsbp3fM9bh+KtJGUwbrtoe4kQEkUweuSbNCEFCOBJCnrfm6Lyzh+MExvXKR5KD
	 qkuGCops1OzYb4v1m8FpIYJdoFhCdodI9zoBW05KUDUM0Vs9qFzkZIorZz8gqWfoMd
	 5edlhMw5xiKBw==
From: Arnd Bergmann <arnd@kernel.org>
To: Alex Williamson <alex@shazbot.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vfio: unhide vdev->debug_root
Date: Fri, 27 Mar 2026 17:55:08 +0100
Message-Id: <20260327165521.3779707-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When debugfs is disabled, the hisilicon driver now fails to build:

drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c: In function 'hisi_acc_vfio_debug_init':
drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c:1671:62: error: 'struct vfio_device' has no member named 'debug_root'
 1671 |         vfio_dev_migration = debugfs_lookup("migration", vdev->debug_root);
      |                                                              ^~

The driver otherwise relies on dead-code elimination, but this reference
fails. The single struct member is not going to make much of a difference
for memory consumption, so just keep this visible unconditionally.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
----
This seems to be a new build failure, but I could not pinpoint which
commit caused it, as both the #ifdef and the the use were introduced
a while ago.
---
 include/linux/vfio.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 50b474334a19..31b826efba00 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -74,13 +74,11 @@ struct vfio_device {
 	u8 iommufd_attached:1;
 #endif
 	u8 cdev_opened:1;
-#ifdef CONFIG_DEBUG_FS
 	/*
 	 * debug_root is a static property of the vfio_device
 	 * which must be set prior to registering the vfio_device.
 	 */
 	struct dentry *debug_root;
-#endif
 };
 
 /**
-- 
2.39.5

