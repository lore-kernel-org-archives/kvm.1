Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A192D4D37B0;
	Thu,  1 Oct 2026 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790847122; cv=none; b=qVc9r4MzVB0mnl0iMcvRj/90z7c180aBDzRW++/dt1UYsH+RmcgUqXiLGKttdCpPZUnq9Nos7tqXJme0La2Ht3QmjsI7+p7gGmZRIDw4NoNgbumJ6wOKvWw6B+f5rLUm4SW4qnrUsLZB99P7kf1Gx6nTIH3PmRqqN9t3rncdrhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790847122; c=relaxed/simple;
	bh=2L3GHBgKnxNfEISMFOnCHgNLDM0Kl4d0dR1aAm/XekY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sY6DwQ5JklIeRQVGvg8rqM2bFMXK+zYGoGqJzApwXOaPMc9Aeg5k8gUhQLyq4w2nt5Wv3R+/wjL0+jHF0Eua7fv6d8WNYYT8hYyBElYI7Ge7oj0L0B5ssrE54clbk3iHjNZymqMpMrlJuDnnac1Ju2bISCzMYvdfPX1rJOHOBvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eu0Nc7VI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eu0Nc7VI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC3A1F000FF;
	Thu,  1 Oct 2026 09:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790847120;
	bh=Q8nH4a9zyuqymi5cvucxrHlyiGUE1EZm5MBlxkRW3Lc=;
	h=From:To:Cc:Subject:Date;
	b=Eu0Nc7VIX1Bk59LO+H+6uZvTd34u0rhQzJC/lxF0nGzQLXV55JlOPs5wz3Rl0wrNc
	 6fqH4KGTfGLgSr9vfjDOusR16vgpiHmKduaK+HEOXitkAG/LSieMV34eRz1b9jyyC2
	 6DJZR7ElCCozC8G8SlwprGsCd20GWf9tw7jE6ofAH+v1/cj7ZgdomLmBDMKIYr4cWn
	 OJBm00Ii7bqSQFEZrXyHoK1kQV27FBskKFy60OrKHoqNN425QeURN3nj3lqUXt/U7v
	 yDOYJmWaHrez9An5jeFPUbHTNiVxiAb8K/hXzXFQKJTT+SeW4yx11AAdeBVdzF9sIM
	 USyVSkm3dAUlg==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alex Williamson <alex@shazbot.org>
Subject: [PATCH] vfio: cdev: Reject duplicate bind before updating KVM file
Date: Thu,  1 Oct 2026 15:01:52 +0530
Message-ID: <20261001093152.1698474-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cdev path only supports one bound/open device fd, but
VFIO_DEVICE_BIND_IOMMUFD only checked the per-file access_granted flag
before capturing the KVM file reference. A second fd for the same device
could therefore replace device->kvm, fail later in vfio_df_open()
because open_count is already nonzero, and then clear the active KVM
association during error cleanup.

Reject the bind while holding dev_set->lock if the device is already
open, matching the existing cdev single-open rule before touching the
device-wide KVM state.

Cc: Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/vfio/device_cdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 1d9515c967b0..ab46563604ac 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -124,8 +124,8 @@ long vfio_df_ioctl_bind_iommufd(struct vfio_device_file *df,
 		return ret;
 
 	mutex_lock(&device->dev_set->lock);
-	/* one device cannot be bound twice */
-	if (df->access_granted) {
+	/* The cdev path only supports one bound/open device fd. */
+	if (df->access_granted || device->open_count) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
-- 
2.43.0

