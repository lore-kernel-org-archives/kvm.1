Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B9E34EF0C
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420001; cv=none; b=O3jY6TtTfKbOdFfqo2a8YkSLjzYmDqSWbBcHQ+skPb2XkxzUGs0+deJtI/gYpfCNh+qCbjahe73RYkWz9zLfQ1acE70IwkYzUYBYU3nO+xwOgtoPD9v8dntdzSAv47XgHqpBy5DTsRwj3qim+2RZGK3s6akxdKQYxFkC16B4qUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420001; c=relaxed/simple;
	bh=WIGyhjmFX3PvAEfEIc2uUOuaJw83FvB0A1Cda3WLsus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OVeVDriQRh6279XiyG7RrLzSRYM6orN+z+jCcVdEV1fnefPMgflY7a/ial8fFfJgK46vraYsS+nr+6KPkXuJbxzopGUisjDnrdisAybfWEAy8CPDqNGOqqnrgaMzMUElK8r1mTaSeYvqE8oB2O5wjX3vXQ7u2n/RcrvQNjLYQKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHrR4e0k; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHrR4e0k"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so20163925e9.3
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 00:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788419998; x=1789024798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nBAHZuXWY5KyAIRDBkxHYvUNH8902LbkXp1LoQGZxso=;
        b=OHrR4e0k0JZguWIEQ+obAP3QTGBIsty6crxdZQoYwylJw5k0bgpGEBGCUDBRE63p/o
         XSbNCxovqI+4ZF7TKHyHSCI1aSYVW+8JtvIkjwChAmj4Qf2CRuwRr6AZdj5NCMiSMyc0
         hjMcWkeNsvENmoK5arRrQxoLGS87EI8mPMxCSDnbFHN4a6Tpj+hQgEO806Uf1IP8xUmi
         8xvnG2c42l2tT2zJXad4u8nvXXsf07l5CG+MvdK9eRXi4iioZ1Snkr4hmveUENSYXvD1
         F7Hl6SPvFhvaIVEF8jgDkycbNAg/mpf1fr0gJq7jgTQDeYeBpwIWJNJcevnOcAeumZ8D
         5XnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788419998; x=1789024798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nBAHZuXWY5KyAIRDBkxHYvUNH8902LbkXp1LoQGZxso=;
        b=KWePbp0RY3DrDYolr2hTWSJM+ShIw61vQH1UIlyhNFGN896YTNizDCLSdqgi2DZavr
         9ed0aE13IoeQ9hSl6RjIAaxx9L0cC2UOvCEwVEdqD+xG7Umm7wstYwci5Jl/wndTwWNI
         vW6cu/Ns+Xy3NfOnuWVs96IxWHRN5iU6SJKFcQIUcv35jQMbrcELWgX+tKOcnbIrmmH8
         ASnSKw9jFM4vle7xdpFN2DFgWZIh4CJoLYp/bE8qSe5f3CsZmtKA1w16/ls96Wg8AFbH
         yGaYIg+c+4v52kzshOjiGEMAdiBPO9csiQhEMntPb56uTZqNFwa2Yos8jy6Li0urY4yJ
         LrRw==
X-Gm-Message-State: AFuF++mXKaYZSp19OlRSC17bCwHTQg34/pRcXrIG2dHMb36RDblhY2WX
	JFcOtQU3QyXkDmUBaNO8wZj2CXA+9pbOsHKfbfT58iX22BdYuXGIjxe0f77YFw==
X-Gm-Gg: AYBFou1/1hzGNPmGxmpn66FPg6nXg93U+nhDJG5FfcnBaUD5k6v5bP34DDoVrd26Mrd
	yTNKYCS+BgXa82uaYxkgc5s+K8eD0p4nhB+aPJ+m9AbUEMJpyBL179hgwieZylXP4KKxDpg2Fs5
	xAkiz/+9LFB8HkJo2TGYvWjR3fVEH73dmDQYysCqmPXL39yNHQ36iTFMwAjim0pHNXM0XTFeSXU
	nozk/zkIpDqSe2pEVZ9MNsSXe+WG9vPsSvcZZpvdXrRRE7ak4pT8opRTcfOey/MQjoPfHuOn7Jp
	KQKzbiu75yfpo4POfE5ICZqMiBBSCCNQywGvC35xl0kephbC5vH5adhjuiYzNn+Kc/Gg0VXd/ws
	U1OYLv5vOQsl+FmpNaFJsWs69+PYJCDklIuylbCUf3EGKsGTEhygOhbZFeLZoQaRGrHRCVoA/Z6
	VjbMrp5b0gFjNbnkkbRBXy3j5Yb1A5ntwNi8dYgrfCobeBYZBZ5ECryAUG0+P5Du7nOtw=
X-Received: by 2002:a05:600c:3f08:b0:49c:e1ed:26b1 with SMTP id 5b1f17b1804b1-49ce5850cefmr189595405e9.16.1788419997972;
        Thu, 03 Sep 2026 00:19:57 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.114.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5e589bsm45644615e9.13.2026.09.03.00.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 00:19:57 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Eric Auger <eric.auger@redhat.com>,
	Mostafa Saleh <smostafa@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Alex Williamson <alex@shazbot.org>
Subject: [PATCH v2] vfio/platform: prevent read-only region mappings from becoming writable
Date: Thu,  3 Sep 2026 10:19:55 +0300
Message-ID: <20260903071955.13144-1-suruurism@gmail.com>
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
drm/panthor (CVE-2024-53071) and ptp: vmclock (commit
a5edadbae57e2298a56cf7a4e774a027905a331f).

Note this is defensive hardening: no in-tree platform driver currently
publishes a region without the WRITE flag.  The guard costs nothing and
keeps the mmap() interface honest if a read-only region ever appears.

Fixes: de49fc0d99e6a ("vfio/platform: initial skeleton of VFIO support for platform devices")
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
---
v2: commit log now states plainly that the read-only path is
unreachable in practice, per Alex's review; dropped Cc: stable as
there is no reachable issue to backport.

--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -594,7 +594,11 @@
 	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE)
 			&& (vma->vm_flags & VM_WRITE))
 		return -EINVAL;

+	/* Prevent read-only region mappings from being upgraded with mprotect() */
+	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE))
+		vm_flags_clear(vma, VM_MAYWRITE);
+
 	vma->vm_private_data = vdev;

 	if (vdev->regions[index].type & VFIO_PLATFORM_REGION_TYPE_MMIO)
 		return vfio_platform_mmap_mmio(vdev->regions[index], vma);
