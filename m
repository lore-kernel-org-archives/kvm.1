Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC64344D8D
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775584782; cv=none; b=Si48oH+RdM7+U4CezQ7uhaKghnw8B9n+QPEZYbxwrWn2ubcwDtnFQZ8HgvSMspiims2XaPS8px8uQvubpfPGgZGgh5WQanfmPQIg0Zh0ioTOGbxOP0Z3nqCl9P9gBQs7bRQISqPI4V1hVEehL00q5v353slI9btZgkicaYnEznQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775584782; c=relaxed/simple;
	bh=JkxrRGeUt903Tkb6jtekbiPgeO+F1zGmN6rhH/iL+qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mNFcx3U8FA5s5DjzPaXI9bR+aF3T6Gf/9Xij9j5c45cwICqEZC3CVHJAUKd5jr4rqZdz8sFKiFBBmyA5TjwbovCT4Y1Vt3HLIBxOJts9b2Sik1UHg2APa/UdsRlQ0QENwLUhegMeftLm7xPxB99ybcBXTf3SFO1ijCmq9bG/MzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iuHn2wDy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FFU2IdMU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iuHn2wDy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFU2IdMU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775584779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JbbrgplfY4mkXfVp2HYVkKbYe0elLI6fbPJUksDPRBQ=;
	b=iuHn2wDyr3V5REPWCY7zNqCK596SkZy3dk0kOw1cBfIgnDiYhyuFsHIPVuNlse4oKYmHrc
	5uNCJ09zHRTOgXOuny/iYstsPyCNvyt4HY+rLHxbtTSfu7A8O+IDcty6hAsQ2bcrOfGTma
	9pU5Xc9bVNFGaAM9kgG7kfuwZlF2ecQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-cTyKvSLbODSygo6XAy6fNw-1; Tue, 07 Apr 2026 13:59:38 -0400
X-MC-Unique: cTyKvSLbODSygo6XAy6fNw-1
X-Mimecast-MFC-AGG-ID: cTyKvSLbODSygo6XAy6fNw_1775584777
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4836abfc742so45749825e9.0
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 10:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775584777; x=1776189577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JbbrgplfY4mkXfVp2HYVkKbYe0elLI6fbPJUksDPRBQ=;
        b=FFU2IdMU1jqyF4YdCBluIqJ4kOtSBjCeDiNsUQnx3BDlHH0kMAIUuMG8k9BoznJ5t2
         W8MKmNPeAZfL8MLWZs9IcNjIpudcH8wUXwoOyawaLx+4btX9JORLoNVj6a5G3tFpvQJ4
         hxI7+QSIxVrdQBvbcLd4cvifTYTnW+Li22qKV3q33A5dnpVmLdgmcYJW8lvzlYaqsuNp
         24BqKDj6qXXjaQnjFDJoeu4CiWdyQX5oq12n7rzAsQkGU7OO4Qw6zSh6cpl3aTI4b0hi
         615x1cEMLDA5S8B64WzhPAMAXtZkrjUOZelrCnS9qYaV2gdwo8Ns3HfYCOdcZJujx8WG
         BvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775584777; x=1776189577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbbrgplfY4mkXfVp2HYVkKbYe0elLI6fbPJUksDPRBQ=;
        b=LgXbMaKLfmctktLrta+tsM94zQMknx5Anwgjl6clxGKJ13GT5xLtUIMa1arHvN9zy/
         8jcDLZUCF1JAweUCLDDXjyAVxbkD7Hi79P9AI7u3R92aKogJL7Itebs9PAQWPUVnCZG8
         v9uoiac/fPG+SLd24vpWj9K6Ln1eNFjQ0mE6iKpRHT2X+3CBsWnul1jCjgTUeSJBOyl5
         TohTQkxPlmpThe8iTaRANc99N5MizJ8TlKPXlf38SQCy7paDGZydw5OALqefMEs9x7qq
         O9UDE8GLpIZQXW33plHMqyG+5gXH13EDibMrzJ5jWlGid9mU/dpk3NkejVD4DxUhO41h
         JHJg==
X-Forwarded-Encrypted: i=1; AJvYcCX9rFm0PUIRxOzi5Pys78jxJ1T7L0V4eeVZINL2h/826SG15GGHwa7xLS8EcachstO3SOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAUPjva2DL9HOCcv3KkGH3BOOuaAeofrjuFksNRz9qr6U5AlU3
	m049RG60adWoGrKRWPVjJLKwxtDW+D/RkQew18q2Gd7pow4OVV6zxUFX41xUYPz2QoI3ixyZojd
	Oj0Fc/k8GPyEMndluCFSscw11cFyuLfrTdZp2XEt1iKaj4Md2Qmt+zZphmxN1hg==
X-Gm-Gg: AeBDieviGNNPm3LfHn4xTn3tFVreFEfdsuQwNeJLC+dIBX085yT9r/jdlsefxkTrWlP
	uCIJq4XADgyoQ8xsSqEDVDXCmMUdI9kgBTmV0Op+XPV8klPPyy1B/Czk9dUBIX8nU5z0L2Hg1z3
	GVXRcOochZG7kQQx/8cHFLpKuMvti+rHFdu+aAGQ9lnQwGlvTBC81/GjosGtGY5ZXytlkM7UrNr
	PIQoRnIXswasFtuswkn5nkamAeMW4sPHiGXapVlsAWchCD4iuNQ1a90ywB1F7KpuKukiIGCMB+E
	b/GjuXPfQAt5LmiY8XLJ6KBaCxaI+7FxuKhMW5ZaoS1Mm/B9DPJoN2Pqkpkb1JfqVZQYMvkxAjI
	EMJvG5n9iaIUn1eJo/Bt7qCJ3dxKfGCcCBelxNW6A7YRXmfKZD29WgVWt2enArpk+Pn9OJyoUjD
	miVxklPLM0RMBn4v6CST1X8H6j
X-Received: by 2002:a05:600c:3b18:b0:487:12c:e7e1 with SMTP id 5b1f17b1804b1-4889970dccdmr237538665e9.11.1775584777045;
        Tue, 07 Apr 2026 10:59:37 -0700 (PDT)
X-Received: by 2002:a05:600c:3b18:b0:487:12c:e7e1 with SMTP id 5b1f17b1804b1-4889970dccdmr237538275e9.11.1775584776562;
        Tue, 07 Apr 2026 10:59:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a616sm1053930265e9.2.2026.04.07.10.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 10:59:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: akrowiak@linux.ibm.com,
	alex@shazbot.org,
	linux-s390@vger.kernel.org
Subject: [PATCH] VFIO: remove dead notifier code
Date: Tue,  7 Apr 2026 19:59:34 +0200
Message-ID: <20260407175934.1602711-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

group->notifier is dead code. VFIO initializes it and checks it for emptiness on
teardown, but nobody ever registers on it or triggers it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/arch/s390/vfio-ap.rst | 18 ++++++------------
 drivers/vfio/group.c                |  3 ---
 drivers/vfio/vfio.h                 |  1 -
 drivers/vfio/vfio_iommu_type1.c     |  1 -
 4 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/Documentation/arch/s390/vfio-ap.rst b/Documentation/arch/s390/vfio-ap.rst
index eba1991fbdba..2de0560bd70c 100644
--- a/Documentation/arch/s390/vfio-ap.rst
+++ b/Documentation/arch/s390/vfio-ap.rst
@@ -431,17 +431,14 @@ matrix device.
 * callback interfaces
 
   open_device:
-    The vfio_ap driver uses this callback to register a
-    VFIO_GROUP_NOTIFY_SET_KVM notifier callback function for the matrix mdev
-    devices. The open_device callback is invoked by userspace to connect the
-    VFIO iommu group for the matrix mdev device to the MDEV bus. Access to the
-    KVM structure used to configure the KVM guest is provided via this callback.
-    The KVM structure, is used to configure the guest's access to the AP matrix
-    defined via the vfio_ap mediated device's sysfs attribute files.
+    the open_device callback is invoked by userspace to connect the
+    VFIO iommu group for the matrix mdev device to the MDEV bus.  The
+    callback retrieves the KVM structure used to configure the KVM guest
+    and configures the guest's access to the AP matrix defined via the
+    vfio_ap mediated device's sysfs attribute files.
 
   close_device:
-    unregisters the VFIO_GROUP_NOTIFY_SET_KVM notifier callback function for the
-    matrix mdev device and deconfigures the guest's AP matrix.
+    this callback deconfigures the guest's AP matrix.
 
   ioctl:
     this callback handles the VFIO_DEVICE_GET_INFO and VFIO_DEVICE_RESET ioctls
@@ -449,9 +444,8 @@ matrix device.
 
 Configure the guest's AP resources
 ----------------------------------
-Configuring the AP resources for a KVM guest will be performed when the
-VFIO_GROUP_NOTIFY_SET_KVM notifier callback is invoked. The notifier
-function is called when userspace connects to KVM. The guest's AP resources are
+Configuring the AP resources for a KVM guest will be performed at the
+time of ``open_device`` and ``close_device``. The guest's AP resources are
 configured via its APCB by:
 
 * Setting the bits in the APM corresponding to the APIDs assigned to the
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 4f15016d2a5f..731dd0dead0d 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -456,7 +456,6 @@ static int vfio_group_fops_release(struct inode *inode, struct file *filep)
 	 * Device FDs hold a group file reference, therefore the group release
 	 * is only called when there are no open devices.
 	 */
-	WARN_ON(group->notifier.head);
 	if (group->container)
 		vfio_group_detach_container(group);
 	if (group->iommufd) {
@@ -541,7 +540,6 @@ static struct vfio_group *vfio_group_alloc(struct iommu_group *iommu_group,
 	/* put in vfio_group_release() */
 	iommu_group_ref_get(iommu_group);
 	group->type = type;
-	BLOCKING_INIT_NOTIFIER_HEAD(&group->notifier);
 
 	return group;
 }
@@ -720,7 +718,6 @@ void vfio_device_remove_group(struct vfio_device *device)
 	 * properly hold the group reference.
 	 */
 	WARN_ON(!list_empty(&group->device_list));
-	WARN_ON(group->notifier.head);
 
 	/*
 	 * Revoke all users of group->iommu_group. At this point we know there
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 50128da18bca..0854f3fa1a22 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -90,7 +90,6 @@ struct vfio_group {
 	struct mutex			group_lock;
 	struct kvm			*kvm;
 	struct file			*opened_file;
-	struct blocking_notifier_head	notifier;
 	struct iommufd_ctx		*iommufd;
 	spinlock_t			kvm_ref_lock;
 	unsigned int			cdev_device_open_cnt;
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 03cefdf99a4a..c8151ba54de3 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -36,7 +36,6 @@
 #include <linux/uaccess.h>
 #include <linux/vfio.h>
 #include <linux/workqueue.h>
-#include <linux/notifier.h>
 #include <linux/mm_inline.h>
 #include <linux/overflow.h>
 #include "vfio.h"
-- 
2.53.0

