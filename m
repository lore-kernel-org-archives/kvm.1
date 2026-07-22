Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DD5306D26
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 00:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784679352; cv=none; b=UorvyF5xqfuw98DvI68HHEI6gU6kNnTVk8lHN6bGYKouI17fy58DgYtZVNT0G9rVNGZ/X4xjNzrxJHhiBqgx28rASP7eCcTOHFsSVhUzK6bPynfGpZkxS0VdlLpmfDKjh6pGt48dCGpJBGTHGrZEOdz80H5qSzx1YeqRRbGdYNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784679352; c=relaxed/simple;
	bh=lfTItr5Vg+lZepk1YTtimNxtQxX2xxsuhXX8/E8FyOA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kR0I248jS4MezXQnLwEkN2aOS9XCHeZwEEew20GnIuHEI0MXo+RXwHWyvPLmClTZ9GFwpHJbfPgpATK6eEvrIqrnrG06s8+NKgpSS1bp7m55QcE/6pwsdl8W0+kVUN37lcpiBtz+B5kDj5hMTNXkorUmhRaD8/ZPkkewira5aQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hmBqsgrU; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hmBqsgrU"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb4cdf95b5aso9955811a12.1
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 17:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784679347; x=1785284147; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eZ+JYUl+bJF8E+CsVPDDHP5xTQJTCrW/WMk4UkvfNvM=;
        b=hmBqsgrUjnFUFOOyBjzxhfhOcRgrE6pvFKFhgW8D+E9YTV53QBstvn4DbBFWvU3vu3
         ItNu32xBTfX3eD1qShImmIfeeZ25yI5eZYW9Yyqu5jnolrNKUKRBbcXJ0CHRp6oQvBUM
         l+u8WYf9GFHaCCZ1rWrpzrDKaSLCkyYwly1XebBvFserPsUFCBlMb8MYYMNdTUFH0y6s
         nIXS6ma1hDMsmxP24B4g64KhQMzk4BEAYzOhipqYE6xArr4tYuoU1fI42lQ6uap3Y7lF
         n2FIthZjsLqfcCvIfMwDaJQgCy3s6iShBth83WwJBeWsFpiUdyM4vHyz7cHtypMwBFrq
         eGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784679347; x=1785284147;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eZ+JYUl+bJF8E+CsVPDDHP5xTQJTCrW/WMk4UkvfNvM=;
        b=V4pXO2GXsQKSf1jQyffCuQMbJoeNzTlFoUibJMETSKP/5mlYmQP7jeYklixuDH22Jd
         hP6vUeMgSnqujSYTo8Avrs4rdvQAspJNQd1cVZMZ/p52wgPHcDCTUPH5QzO2FHpjIWiI
         nYUGAxEQGQARRjGk8M/K/B3jTQ2vZlhAQ0aKfSGxZLi6QF+eJ5P/dSCTtkuaTQtPssgY
         1ZqyoH7Tola0Ht+dQxxbJP4D/X7q23Nshc3REwdLHG2KlhiJ1v/wC0aFc6C1CQy0t+Qa
         +cELfCvpOmOWJpDv9drvOPgwJAH71sp/W21yDZdS/4I+ZN9FtwYvRJ3uv9RxnZxBPnMh
         vbww==
X-Forwarded-Encrypted: i=1; AHgh+Rp3qL7kYfP87EvIpZL0RtofqzvAvgKZqqj06uGWSNVavtmCXUd/LoeCdOiKuZ8wqPBqyfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn7yFjGG1Yd5/fOBbZWj3myPX6dbwuV1mWmI5k8C4EiiDdSkqB
	YnDloJ/F4D8+KdEe+zJqUIbr+ZaD28t1nvdqUDNhkq0UmpucJdT5ntKXBIlJan3wqY+jF7Of3xN
	XQsVhe35o
X-Received: from pgww13-n1.prod.google.com ([2002:a05:6a02:2c8d:10b0:c8a:c79:47e7])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c70b:b0:3c3:7427:5ed8
 with SMTP id adf61e73a8af0-3c3ad5fc1cdmr23350917637.8.1784679346553; Tue, 21
 Jul 2026 17:15:46 -0700 (PDT)
Date: Wed, 22 Jul 2026 00:15:40 +0000
In-Reply-To: <20260722-igb_v3_b4-v6-0-0be1d29918d4@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-igb_v3_b4-v6-0-0be1d29918d4@google.com>
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784679337; l=2385;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=lfTItr5Vg+lZepk1YTtimNxtQxX2xxsuhXX8/E8FyOA=; b=FwaSkyLKFRNCDrxuhKdnvvYY8lP/k/mmM0g9bHg2OIqLQqw3ScD4PobkBcMqhKdOSAoROja30
 F/ZYfWzQN6UA1YEKPiTvjn4KNqM8wBlII40LcWweQbDp5vIgwzQYMmB
X-Mailer: b4 0.14.3
Message-ID: <20260722-igb_v3_b4-v6-5-0be1d29918d4@google.com>
Subject: [PATCH v6 5/6] vfio: selftests: Retry on EAGAIN during device reset
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="utf-8"

Add retry logic to vfio_pci_device_reset() to handle the case where PCI
resets fail due to lock contention, in which case
pci_try_reset_function() returns -EAGAIN.

Suggested-by: Sashiko
Suggested-by: David Matlack <dmatlack@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 .../vfio/lib/include/libvfio/vfio_pci_device.h          |  1 +
 tools/testing/selftests/vfio/lib/vfio_pci_device.c      | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 2e67afc0d580..27bdf561925f 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -41,6 +41,7 @@ struct vfio_pci_device {
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu);
 void vfio_pci_device_cleanup(struct vfio_pci_device *device);
 
+int __vfio_pci_device_reset(struct vfio_pci_device *device);
 void vfio_pci_device_reset(struct vfio_pci_device *device);
 
 void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 7b8394d0ac50..1b29cef96b04 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <dirent.h>
+#include <errno.h>
 #include <fcntl.h>
 #include <libgen.h>
 #include <stdint.h>
@@ -221,9 +222,23 @@ void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
 		       write ? "write to" : "read from", config);
 }
 
+int __vfio_pci_device_reset(struct vfio_pci_device *device)
+{
+	if (ioctl(device->fd, VFIO_DEVICE_RESET, NULL))
+		return -errno;
+
+	return 0;
+}
+
 void vfio_pci_device_reset(struct vfio_pci_device *device)
 {
-	ioctl_assert(device->fd, VFIO_DEVICE_RESET, NULL);
+	int r;
+
+	do {
+		r = __vfio_pci_device_reset(device);
+	} while (r == -EAGAIN);
+
+	VFIO_ASSERT_EQ(r, 0, "ioctl(device->fd, VFIO_DEVICE_RESET) failed\n");
 }
 
 static unsigned int vfio_pci_get_group_from_dev(const char *bdf)

-- 
2.55.0.229.g6434b31f56-goog

