Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6D647A886
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 23:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785281102; cv=none; b=qAGjsNx6opZYHmLfSeNpZqgVd7vsmareBP4YShmwbV9IaCrzK9wI/qMmJybXelasnoVD2ZRiBuDePQoLnqnIT5YR0HSEIJLocmO/Z33gtWpt5mnwYhd+J4apjgqs4fwO1kqevNBWEFpF7RoKLSwgK/V5bnLI7suZc4fbdwDjRRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785281102; c=relaxed/simple;
	bh=eXdqC4UCAcp172BqsAXVonRWedqtBZ0i7TdgjShYz68=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bL1F1OM1nOM9Rngyf9WNSpj8hAp8LZV3mOO4AC1FVX0z3OpYMn+DMV/wHIyZ6uGrI/q/b5y+iv7u+iSs1RJREkoNsNjoLbwIGomwOURuwBY8RkODC1ee/FWFeyy513Apwwvv1/JBjB4jQdlXdkDX9G3fyFIG7ThacBfAlVJD80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iMCmJp77; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iMCmJp77"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dd87656d3so385261a91.2
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 16:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785281091; x=1785885891; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mDYZc+Oi/gY1u/9sWyLoIj/nHe7gnjnLgU9uzrqrkb4=;
        b=iMCmJp77qnth50n9r7brRM+P2CjJzMpEWLnlkE0W5zseRsJkZst2BMI7fV9fDuE35B
         chQsZbIh7izoYaDW31KMmFfpfocMC3VZWKbFnTeKPfiHdrQD6NpYyXsgpGOjwenLzYTc
         3r1JYH18H+ZTZqqPBjNZMty8gQIzBLEZOnEeF2vejdHdM4WhCWaXskOzHy3EE6VrA6Eb
         EWg1iWsvKj73EtzEWtP8JioGva4sNXc3Z6d+OvPDHxdHHm9+ZuhBOW3MTBQH8uHFy/vW
         LI/zQkwonjpyGjSMImCMp4J3X/wNlrb8a0mSaQJ0Dtlxa0pEzFznm+8ycvulIXh5UP/U
         dShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785281091; x=1785885891;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mDYZc+Oi/gY1u/9sWyLoIj/nHe7gnjnLgU9uzrqrkb4=;
        b=hYIoJf7IctNnfxOBFr7SxUv/wM5E6Y5S6dUbHoapd7ny7XLV0FYPdBrbI0+st4giSc
         EoABgP/VA5XRE0WqoE9CY2HQiERb+PnWeeF0TGHTQLN8eldTYTKSPEZSGVo3YdlkrHqc
         THQotSOs53/QXzqUZZ/xDJwl9FXAU9hBllk9NdTzWE/Na1voT8WLMZGuCIckvkdXuvWU
         GrI9B5FVuyUpLhADu2AknM/qhtSK0F16229ZwZ8azsmvRGeQNYd0Tqbnfbjbfl8lsy+L
         o98ja1Hvt7jqKtaeVn2NdjOFKJ2QPbpmVvBzpPKzNcG6alP3ZhlXoWsW00F3b/rFcgK+
         D8KQ==
X-Forwarded-Encrypted: i=1; AHgh+RrIzHv8hRn01mjs5yWMgQjIreO93Ek8xiWpJWnRZVWwnZxUw3PatarW+Ur5uiM0LSOk36E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW+085q4ByGpBSWS0jo63R2LF5F5bCRU5idcZMiGsE0lwfVUoA
	A45qgnUk5bydcqMujf3qK30yAOxIABBxUbP9MMRzGj7ZhA87v4c2Neml28gmYYKNXveKaJY8uoz
	ae5sXXSMW
X-Received: from pjbgk10.prod.google.com ([2002:a17:90b:118a:b0:383:c59b:fc00])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b83:b0:380:f34a:6ff1
 with SMTP id 98e67ed59e1d1-38f6a459881mr4635127a91.17.1785281090516; Tue, 28
 Jul 2026 16:24:50 -0700 (PDT)
Date: Tue, 28 Jul 2026 23:24:30 +0000
In-Reply-To: <20260728-igb_v3_b4-v7-0-4616c3745796@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728-igb_v3_b4-v7-0-4616c3745796@google.com>
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785281084; l=2362;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=eXdqC4UCAcp172BqsAXVonRWedqtBZ0i7TdgjShYz68=; b=crQncZCErV+wOb7+Ey+zTiLuILOfOVS4PiGD2lF/QGhJBTluqdgrvJDZGjZ9/6UQMLj20O0rD
 gEYJo8ZngfHBRTm9StheAS4G86EMB+QgdJkm5QoiJRGfo38QW+UK2SU
X-Mailer: b4 0.14.3
Message-ID: <20260728-igb_v3_b4-v7-5-4616c3745796@google.com>
Subject: [PATCH v7 5/6] vfio: selftests: Retry on EAGAIN during device reset
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="utf-8"

Add retry logic to vfio_pci_device_reset() to handle the case where PCI
resets fail due to lock contention, in which case
pci_try_reset_function() returns -EAGAIN.

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
2.55.0.487.gaf234c4eb3-goog

