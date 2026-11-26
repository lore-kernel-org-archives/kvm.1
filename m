Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795680999;
	b=z03clvx3BaQtZrbvjQob7ZOcveEICi8o6Q3rCdNgK/+ly6qbjoVbtuztNXwGjnnaP+g8
	 QGjay1efTUnjZisCIaAhatuJx53lKpmdzsB3ZO9twcSdYDtL7IJwPMf1uKou7ziQHtG8S
	 C2xuqkrJYaJKob+1w3PI1mNeGayW02tbTrdhzjssS7RC/vh9PAU9ZHV5/wQoavy6BpVdC
	 w6Q4uk0m4Azi9U7lu8qnBVUHws+ifnIoaIqUQ7W+hTZPXWDFZrYZYNKmV+s7llFTLROmU
	 lSqf72PVu5yPhjATE2x3H+17cDCMolPKMK9Vm/h5f7HCLrHGegWh6+WY9ew6F3M38bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CBSIDCKro4GDs12iDpbveHASbLjhtJ1zWAB1w2J4Ssg=;
	b=v6RBXp6K+VwSVjGSarZz8Gj0ql9rO0KQ0xXQ123j+SlNsnHQgau492STqhTIxcMzRsPY
	 NPyTv2UzyThJhc/3gk3KCNLIQuKhw5GgRLm3fk6bvUbchyzkziQDSBed+qWYCpI0txvaN
	 tuo3JGHwNpq/O6EDo5RFvd70utFiRQY9YGmrjpsRzteVfC+nPjBgDK4/VFTKDdcL+rt/D
	 jzBW3wKUtdrqE/MBQfMKDUa0/OHaKyOhLpyO7dvCKnW7Ky6aRcogo93TXo55W9ANkSejQ
	 Ccxr+GzrT0quoBJFURRDW/b83aW5d8SfsGxstj0plxEPfOhG4jzAVSG40shDbF+pXbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PQa1AFXI;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75196606A326
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 08:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75196606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PQa1AFXI
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so86044835e9.1
        for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 00:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795680998; x=1796285798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CBSIDCKro4GDs12iDpbveHASbLjhtJ1zWAB1w2J4Ssg=;
        b=PQa1AFXIZS40/OkHRWSeK9C0cJH4iXrwvZSbqalNLtcMObluAt2ryBFq+7UwnlrGtk
         Rpbe2zlplBYfObUSV+nJJDjWG678OAAU2fzBxTF8TZlvuYYdU/GZtHr7hSj8Q1IpBCmc
         8yQFV7mvXIKXGc+W+jn0ycgK+gI1vzpJ3l2H4s629XIWdwtdjEcRdVSHbORecbNpHt3i
         5mR5Xd+Jz+7wusXeD3RH9hRRtV0w7xy8BY04bYAHjHPdkXq43OacZwmVYeQZETI6dHcE
         +SCTpHV7CYu1AjQYSuSBFHoaFIFiSg29kxlBkHG1eOXjWNMT72xh4kU38MjsOXLOYTpd
         S2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795680998; x=1796285798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CBSIDCKro4GDs12iDpbveHASbLjhtJ1zWAB1w2J4Ssg=;
        b=QlhEW2OQS1vmEOGs/L82JnEF0uIkNVro08/pf8pSiGR0D7XCdoVM+PhNAWKCNgrzbJ
         xZxFmaRIWCcClL5eHk5M/q4DOoZn2vX9drYMrS7+4UPdrsqbS/Ac1chMEmxqGihjvQLL
         tjyjcv/v1HgbQAhU89TKWot5pBJASBWmXgHxMlXbOA7PiHkCBacCwnC2tZSuik4MR6Np
         ID7RH6olNN/q+GXZDFXs5LTiUjZGmbedy551e7yIVq6C0fSvdGbgwjUsvsxDpV+pEO0B
         lwOFWchJZwrUrg+ytBxkREWivFzKW5woOpq1aFKqG5jMPSqZm5BudzTwSk7N4lu+Q2MK
         BOgg==
X-Forwarded-Encrypted: i=1; AL+hErGSdjc18MwNBdbn6B+rbAgU9JBL5z/L30yfm5dIL2rs4HOW4bt+D/LnKYpWQr6bncJtFks=@vger.kernel.org
X-Gm-Message-State: APuU4Z/aMFEiOt8LP9G4YxrE4eIDEehnymApNBqKYooa0aBZHqAm844+
	1UtTYzmuFkFrkLxqyCliBQgDh8FfQVH/j3+5i9wfve8XjbFDtMeSvNxq
X-Gm-Gg: AZFdTZemwo6S22Tq+nL2ENUOfi4Weayg8SQ7RdWrvhJbHjtADXyBUNgtdX5Gj8yqdte
	As5Byk/X7k8Cc6w8HR2qg104yxozN1NPnQ3CsdIjSGOG5p8+WBCZ2jy/RSYgTxqf8UX+lOy9A9L
	LQ/pNQFNgY8C0SM901ASiW5Gt6oT1YOFKnbJ89AEvNXAL9u+UzwFCApUkimifakDeP72jfW7Cv+
	TWUvf7X7OlILY3EDxSnG+ZMCnqClnG6KkAbnrmiNcGTbYBV6GWvjsdJ5U0IW2xGsJxbkyaCB5CK
	9VNgotUWoXHn9YVxxas1jAKRIWwln+DN6mpPah4wC5YMlwqSR5W9rxOUyVFvv+mCMMYrJBcxEuu
	yvo/u9OI4pd/BK/A0/TrQ1oinHmDCoghl6Dp5GnTJCy6yzgbyF1EVdrcTdKsr7wjUSrAQFOnlJm
	A06lWZFag4zMeOnEtT/snlUIt1ApHgteWoEYONvZydsopqkLm5LpKAisd50+0fOYXdFzGH+3Eb2
	LnS8Xcaiqiq5DzMvrWvrf/VMCbvE/hpKhiFyP++fHW2qYuE+qT9bUxy7/ZWbBMfUyJA53KwfuUO
	7XOnNFspPGKNNwAofCk8ujc2rEFkZs21T9wq+RCSiWPvVX7N5h0dQs0qUnGs2pHGA+lEGpubwA=
	=
X-Received: by 2002:a05:600c:154c:b0:4bb:6a78:7c42 with SMTP id 5b1f17b1804b1-4bb887c3428mr407967675e9.1.1795680997558;
        Thu, 26 Nov 2026 00:16:37 -0800 (PST)
Received: from grower.termidesk.ru (ppp91-78-19-165.pppoe.mtu-net.ru. [91.78.19.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf61e8sm40320996f8f.11.2026.11.26.00.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 00:16:37 -0800 (PST)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	Eric Auger <eric.auger@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Baptiste Reynal <b.reynal@virtualopensystems.com>,
	Antonios Motakis <a.motakis@virtualopensystems.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Mostafa Saleh <smostafa@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Abdifatah Suruur <suruurism@gmail.com>,
	Alex Williamson <alex@shazbot.org>
Subject: [PATCH 5.10/5.15] vfio/platform: prevent read-only region mappings from becoming writable
Date: Thu, 26 Nov 2026 11:16:30 +0300
Message-ID: <20261126081631.45468-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abdifatah Suruur <suruurism@gmail.com>

commit 420bed9131dbbe37abe9d6b32af51219875811e0 upstream.

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
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
Link: https://lore.kernel.org/r/20260929094848.7439-2-suruurism@gmail.com
Signed-off-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-99809, adapted for 5.10.y/5.15.y: vm_flags_clear() appeared only in 6.3,
use the classic vm_flags assignment so the file builds on these stable branches.
 drivers/vfio/platform/vfio_platform_common.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
index ce67ed9510cc..64c4291592f1 100644
--- a/drivers/vfio/platform/vfio_platform_common.c
+++ b/drivers/vfio/platform/vfio_platform_common.c
@@ -617,9 +617,13 @@ static int vfio_platform_mmap(void *device_data, struct vm_area_struct *vma)
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
+		vma->vm_flags &= ~VM_MAYWRITE;
+	}
 
 	vma->vm_private_data = vdev;
 
-- 
2.43.0
