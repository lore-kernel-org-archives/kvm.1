Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6614FD26F
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675345; cv=none; b=u3kEl3X74HFTTzDjDEp05193zxdWVWJ5Jo/ACdGBKgTALbn7DM66S2Yw6toFhsADWIuCee/b2x3ld4GxTil5LVFlKL7iRJQFU8z6/RTxBq25urwFPFiRdXUcCiTx/5PZx30Ra7tzZUtkSfnpF2Awe9B5AoiaL7NtwZ5bZ9IK5K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675345; c=relaxed/simple;
	bh=mafYc1POG2ipFeoB3S8vmnJTgqB25TUzAsuGpwKhPDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMahLsRNygYAhkv4ftwgwX2kCWdKogMNAWsSqiGOdUP5BnBSj0UEjLjm4rdwLrCfwrujk1IW+1/q6odDxrlhImTadr7igRkOdKLIKN3ivgJA5XvhtwbCRpwhC2Dy4FbiMOXDAHYj3Sp5XWXiVsH3mnrDsSxh31QxmnDZA4A8mWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8dZMMGZ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8dZMMGZ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e721b5503so37480115e9.0
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 02:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790675340; x=1791280140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S7+efrB331TRd1EJW5ILzc3Z8sEFlBx8lKuHfa5SQxE=;
        b=T8dZMMGZq3X9h5VmN5onL9L4bX5l4lxQnxTh2lRuTeaLME3JhyTZjD4J3Wugf4uQVj
         uJj0vGud7d0U/5+N0fwKT9e4x+dcDjsXgwe9kUKHYceA/BDL04yB35z94hp6IfXi8x+z
         ObTZebs35kbTLs07RdddRQDLmR07QfAp06FIFW5xhnxCoe3hXQVNa6DcJQf7uic/4h9W
         aFMg8A6qFIGIvHPoU97oUKq0Zl2WSmipH6zI2Dgt7V5VsUvygWc/UaRfdfWmLsTPtpmQ
         buLEM+PbHKNbsVaANL41uOMc+FkWxDOq+NlfY6BaqecFIbnVYdPhs/VxLRo8nGmJTvGz
         Iu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790675340; x=1791280140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S7+efrB331TRd1EJW5ILzc3Z8sEFlBx8lKuHfa5SQxE=;
        b=md/WCK50UhujRnV+7OctT40b6JqW6kMp8NfJeAbhsxis8o5X5dvrT8zSxCh8WGjC0B
         1daFE8CAcpMlM/OvLC90dWMbQYrRagSIO+C2qi2TS5F1k+7OvDRKSGm8QjXnQMOoq8e5
         yxK4RdUyPozzXTqF8h8G3H4L7iByNS2S0ioSub0hIfGm3wCsqp195PfTKpitMv5FR+LS
         qTl8siLTrLPde4qj4jSZHSvD6srKViHoz3EKD9LdBdi0DEM3CnUcCTjzgZisJvpt/r2C
         PTgs6UjhFg9SVcZJSJGmKp02IzzC3pQOREYJRbx4K9PTs0KXMUpfj6a2WPE8q8pK/fGI
         QFOg==
X-Gm-Message-State: AFuF++nQ2bLtOC9ZIocCccDRc6vTTEhkj/zQgm8lEHWGWIxh16sQiVTN
	mUAXr1g1EaRpqjq2gE3Szo56UzCrG7B0ohlvnHgesW8y2xp78gaW8cXcBYhhHw==
X-Gm-Gg: AYBFou1FwYpqYf/PK2S6BT6b5XBkxRcvxzQxHnXYguUiG79s6uBi/csL0PxoluCH4ml
	YQJ8WoZzsRSOSGCuuyjg2wLs6/FYciEJNmfejVfxf0b167bkVDxchqFQuTKAS93IuHy77IuDPFw
	HuC38+a6/9LCaxWb7V+SmEavTC3/rAo9O1mSCJPPpVPTJbQKhUoD+HJb4kQzhOVQ1dDxaeYfNJ6
	PQaELGySqtOW8hzvipdky2n2FH3CeGAcQa5MkvyvqmnIcoqxf7EA60xfhY7BZIF/+0BrX4AQFeH
	2OEV3JDXP8LBiMLF9WkuBU96i0rIU6kso0LqHR4+Nksuf9gkfmiA48GKoiTPigfeERuf+3jWW6u
	arirOpUS4fT/g4+Khxu+nEPWJPm43mSpfC6Q5xI1ViZclzt72swEIRKTMQfycLBhdGTU1+a+d88
	mauQ64u+9zuhHNuHbhZVw9GTtkooBEon3wMF23Dk1jkRDl0ihkHUMDUtLhmzNarT+6TNttDl+hz
	Rgb
X-Received: by 2002:a05:600c:c177:b0:49c:fc6c:be19 with SMTP id 5b1f17b1804b1-49fe67080b1mr287914985e9.31.1790675339783;
        Tue, 29 Sep 2026 02:48:59 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.113.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf9b72fsm89821455e9.9.2026.09.29.02.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 02:48:59 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alex@shazbot.org,
	eric.auger@redhat.com,
	smostafa@google.com,
	praan@google.com,
	ioana.ciornei@nxp.com,
	nipun.gupta@amd.com,
	nikhil.agarwal@amd.com
Subject: [PATCH v2 3/7] vfio/cdx: prevent read-only region mappings from becoming writable
Date: Tue, 29 Sep 2026 12:48:44 +0300
Message-ID: <20260929094848.7439-4-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929094848.7439-1-suruurism@gmail.com>
References: <20260929094848.7439-1-suruurism@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vfio_cdx_mmap() rejects writable mappings of regions without the WRITE
flag, but leaves VM_MAYWRITE set.  Userspace can map such a region
read-only and then upgrade the mapping to writable with mprotect(),
writing to MMIO regions the device marks read-only.

Clear VM_MAYWRITE for regions without the WRITE flag, as i915 does for
its read-only objects and as fixed in drm/vc4 (CVE-2026-68445),
drm/panthor (CVE-2024-53071) and commit a5edadbae57e ("ptp: vmclock:
prevent read-only mappings from becoming writable").

Note this is defensive hardening: no in-tree cdx device currently
publishes a region without the WRITE flag.  The guard costs nothing and
keeps the mmap() interface honest if a read-only region ever appears.

Fixes: 234489ac56130 ("vfio/cdx: add support for CDX bus")
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
---
 drivers/vfio/cdx/main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
index b31ed4be7bdc1..28386fdb01f2e 100644
--- a/drivers/vfio/cdx/main.c
+++ b/drivers/vfio/cdx/main.c
@@ -281,9 +281,13 @@ static int vfio_cdx_mmap(struct vfio_device *core_vdev,
 	    (vma->vm_flags & VM_READ))
 		return -EPERM;
 
-	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE) &&
-	    (vma->vm_flags & VM_WRITE))
-		return -EPERM;
+	/* Prevent read-only region mappings from being upgraded with mprotect() */
+	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE)) {
+		if (vma->vm_flags & VM_WRITE)
+			return -EPERM;
+
+		vm_flags_clear(vma, VM_MAYWRITE);
+	}
 
 	return vfio_cdx_mmap_mmio(vdev->regions[index], vma);
 }
-- 
2.53.0

