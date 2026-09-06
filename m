Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B99199920
	for <kvm@vger.kernel.org>; Sun,  6 Sep 2026 12:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788697968; cv=none; b=HiCqHlVgGlPaYKLDwA99f7QZ57KWPZetP7JE+t+ALGzxw35qcmOYH4YER64C4x4fGGwKVp2HGXqJPNbxdfGrfmqvlnr3+gKAXC6QihDOnSxV+9TFWiqEz44fFe2XANqOGoP2uDK1pBMJ4Ek5t1AwWQIbNvhEEgcKi7+Ys4ntEJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788697968; c=relaxed/simple;
	bh=sguKYoMM16u01ZuI3nbB6NDrvXLR50b8W9WG1GStR5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sIqN/4kSMsTNd+YpYLdtq9JIpKm31Mmg8s7+RF2eZoOinNC2JA8OrxkyWtrgxe7Pm+hzyj2hN7bIuRuuek4NVuXc35S6EEuw7J50DlxwXKh1CBLUxPs9I02ipXN1DthfPocVwrA/D1ZhmFRhPkGq3rCQMAgPzNjCHN7j4Vv77XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hi+6mdFG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hi+6mdFG"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-495590dde14so36060955e9.0
        for <kvm@vger.kernel.org>; Sun, 06 Sep 2026 05:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788697965; x=1789302765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zpji3VV9wlpDiX/8ryiSpf8k4yghCZmWbJA5NViszTA=;
        b=Hi+6mdFGl+VILKpKwQ6OjDdkNs3CbjJgLJaB//xaOTCp8nnPP87Jxn3jxNoJ38SExG
         IcU3xl3eZ1NJ0o1J1V9UPmQ2lYaSfrfkGlV0O2eHxASoT3B3IB43Skcg4CUZPFO1sCLt
         pibMZeNSPZeiWcpAIKxoP1hInZjy71AOtnLlRF2gyJqvK41UmJzRacJWDWJtieX3jCEM
         uB8sjXCX9y/RUSP4qQoqtjRNyy/UkKXZhC9omA55kiASkIQN2yEr0QL4lLBcLO9i4VF7
         mLdfRRNsg0YSBmRiq0jPE07PSQvjb9ZR3Fdr7Z2Gceb4sE107k7wswpdKk0a7YDiA5Mc
         8f5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788697965; x=1789302765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zpji3VV9wlpDiX/8ryiSpf8k4yghCZmWbJA5NViszTA=;
        b=m1i7JbJW1gk0RpBxHPJY8eR1O7JWHbKWPmX4VS+r2Tvc44Gw2qBSoutkIAbVDbDmV8
         svROxLANQmGB4eelfJgfVNv5wpA/QNSIp25zsuY0lsUu3MxeKQmslXzsrnRO8bpjh/ak
         5K1LsFWoGW677h8uqhRIIqnO+c3iq6SKM3z8OBlprjK3WvGj0IdRZ7ie9Mzb+F06YeVt
         T9epteSHRrEi2A1rmx2eMfqyOu4usVls5fdA27AIVDPt4vogcByJO920joEEiU1r4SwT
         OPL3top0EckFgu8xWuSTOYXirysyjfVzuBMM02JYZLLqp4EPYpIuasZxUAZOkylSk29I
         PNAg==
X-Gm-Message-State: AFuF++mmeD0yhHrHm+KUK4JzRpY1ouz+M/1HdYY7NpAmGdPRzTlc2aSG
	eiuwDg/FWVObwfcMNeVSxqRaw/j7YNpxrUxquTo6FF7z2ISQ9xjwwYVqJEU71Q==
X-Gm-Gg: AYBFou1xw4rRby9wCFOOuhi1EjiMdiEQi5NoVX8eDdUAs0av2zgGj00vU740QKcau5Z
	2ZkTpO6Yz3o27Z6f9uaKijb2hmXY4Po2FMgxc+OZwiW7g9n2ZqJppzRlU8L+jqrB3DbgpcOMiJC
	kQYHahg2D8U6YoypxtvaL8PAZF6OiTRQ+G+01SvtAsIz0ZImund9znebYG2lVuQXQ8Nn9rZaduu
	Vfjl8wTknKnHpWxRKKbmPbbMklqfX/AxVYOLbWLdNI4sEKM/sMZniusv3/YWISqG39CoNh/XSdm
	3dIq1ESd7cLQXXtuADSXyxLHuWdEDPmLvfCxFx5MxIEZk9FnaFojezv44X9w+EMRRs1cAqaDmT7
	5UYJ+cgB5MErWEyXCXY/APEC1c3Mzt0/7bCb+sJv5QyS8S2V/jtTutvpmAAQWEIySea+H3KLI1R
	ZTyjX5tGrEXoUgIqlFqkAKUHk1HdBKu/098AGI6QwXC+RsarMRzZB6YufM1udRkFg34431
X-Received: by 2002:a05:600c:860b:b0:49c:ee20:e787 with SMTP id 5b1f17b1804b1-49cf7fe62e9mr350719575e9.1.1788697965389;
        Sun, 06 Sep 2026 05:32:45 -0700 (PDT)
Received: from SurHub.localdomain ([102.218.51.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6158e9sm313653625e9.12.2026.09.06.05.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 05:32:45 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: eric.auger@redhat.com,
	smostafa@google.com,
	praan@google.com,
	alex.williamson@redhat.com,
	Abdifatah Suruur <suruurism@gmail.com>
Subject: [PATCH v4] vfio/platform: prevent read-only region mappings from becoming writable
Date: Sun,  6 Sep 2026 15:32:39 +0300
Message-ID: <20260906123239.10858-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vfio_platform_mmap() rejects writable mappings of regions without the
WRITE flag, but leaves VM_MAYWRITE set.  Userspace can map such a region
read-only and then upgrade the mapping to writable with mprotect().

Clear VM_MAYWRITE for regions without the WRITE flag, as i915 does for
its read-only objects and as fixed in drm/vc4 (CVE-2026-68445),
drm/panthor (CVE-2024-53071) and commit a5edadbae57e ("ptp: vmclock:
prevent read-only mappings from becoming writable").

Note this is defensive hardening: no in-tree platform driver currently
publishes a region without the WRITE flag.  The guard costs nothing and
keeps the mmap() interface honest if a read-only region ever appears.

Fixes: fad4d5b1f042 ("vfio/platform: support MMAP of MMIO regions")
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
---
v4:
- consolidate the duplicated !WRITE condition into one block, per
  Pranjal's review; no semantic change
v3:
- use 'commit <sha> ("<title>")' style for the vmclock reference and
  point Fixes at the MMAP support commit, per Mostafa's review
v2:
- commit log now states plainly that the read-only path is unreachable
  in practice, per Alex's review; dropped Cc: stable as there is no
  reachable issue to backport
---
 drivers/vfio/platform/vfio_platform_common.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index c72db5a99ebda..ab531318f170a 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -591,9 +591,13 @@ int vfio_platform_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 			&& (vma->vm_flags & VM_READ))
 		return -EINVAL;
 
-	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE)
-			&& (vma->vm_flags & VM_WRITE))
-		return -EINVAL;
+	/* Prevent read-only region mappings from being upgraded with mprotect() */
+	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE)) {
+		if (vma->vm_flags & VM_WRITE)
+			return -EINVAL;
+
+		vm_flags_clear(vma, VM_MAYWRITE);
+	}
 
 	vma->vm_private_data = vdev;
 
-- 
2.53.0

