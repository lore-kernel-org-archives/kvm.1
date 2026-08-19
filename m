Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1107942902E
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 08:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128936; cv=none; b=uERMQdJhnxvk2aEvA7qscJ9AmnCDk9n0S8P5DtW++vd2wPCMXw8yjMno2YPWstVYfitwXajr/fQQpMAEUtMBtCTIqJbmCX0MDbxPIF4MkDRfNFTA3oj0Q6tUGTBP1Oez8oM8JIm2DPUCBsTFMUEUrer5ULjke0wCFDdGxj1O08A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128936; c=relaxed/simple;
	bh=lV3H2tb2qiMnCClXMs0+wmrc43ydlEATktuhAe9EyR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jRer2WwkFT5M9KBZsA1ONQDMq9/Xlk+WxcD0ACG9YttbUDLjMMHzCsP16Em3870s3867UMPFJN+RhfyG1rVc00fle058IOSeug6vJtqdnFGlA8shA0y0ciD8Ujmn13A1x2JL7X0runuShxlyTEiYRK3OCFZZMdV2T9M80KD2r04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnN8CUti; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnN8CUti"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493b966dd74so4898995e9.3
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 01:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787128930; x=1787733730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UORZ+icp2lmX+P7JbOJDudH0GncJTos6NcrZjknca28=;
        b=OnN8CUti5xFsqFWYn1ypGubO1BdeqMu8FQpQvw0bW5dzzOvjc1r7ic4KPA+nn8OuY4
         BMz7rDFKynJnvd6H4CBVy3dYcAnSaqHneZyHfbIl4rgzE91nZ//KiZfIS/Eqjjaf8vZo
         +kkBiIgosOp+It+pl8yINOD+vVOWfGosGgeyFOLUQoJ8J9IrDSQCy+o3oM62AKZWO+Ne
         g68I031fAgrQaJqu+w+8kgFSnclfNMSXEMzd7DOE4A97IgSv634E8pyDs3nQt2I+HvQv
         YwdBL1EZvykRhz/p/xVhve07ithq3KrhXvrWNII8N+MA5wpVDKDz1wCjJs7FFCo5x+B+
         RAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787128930; x=1787733730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UORZ+icp2lmX+P7JbOJDudH0GncJTos6NcrZjknca28=;
        b=lyywMX9+Zo97WeHDByB4lucralJZ3k3Q+JowFpgt6vnCz/XyvC10k1j4oD3lUOylp4
         WE0Z/jV5WC289NAvS0GcGfNLUhitk6mDjhQShC9Z7664G7Wh0trAAi8CUhdaF/IyD3k7
         BF9KSc9Gwawuku7k2mWtFqUjMDkt3SXpLnUMchVvSQvnCz/9Qqr5UHOkBZYtwBjbRjYt
         1KiMCRwVUTfc2RJ5etwZM832agneWN502CKoGFQqgxgcUiWBM0sES07L8Lbp4SoveY6l
         uA7HvdNqGEjtMRPjtgzwWBiMlnwHQqukpLsQ6q/e2OhGCalxzwBJO0nI8S4hatwd0i9D
         1Suw==
X-Gm-Message-State: AOJu0YzmsGZ/lPRnX4kG/k5qft1s/Vhyo/XpQq8zpwmo2plgbkiMgjts
	FHESfA37OILpXc+cmy36leGDwQzve0qedZq3nrGjVhMLLfI5PSR9ryApslyhWEat
X-Gm-Gg: AR+sD10UqZY5jFJs+j/v1PiLvl9l8YFyVNWxHHsWOXejJDMLdZZqe71h6TS0CcSwxtu
	R+H2qwdDJRVtBQDYEq5sMcBxm7KYB657TDuMIx2uTiJDNxYhyIojPWhCIvFxsrDv2WmfREUPakM
	gvFqALY8lsWwjx2etzC3tfL8Vq93S6pF7YmPCBjBWwq3eob/u31rl/OU6cBTRlP/P7jIrOi3hsG
	Vt2F0n23JTiiDBTCL5Jfsn3S5bwQuzonySlhFAzKj46dxGszgZzpGXdvRKEqfBl0iwDNF/eP/OH
	6q5CMV6TYtGuHoT4W9Ap+rgqCEQdOi0zZXJ5JwBDHh7EeLwjLEE6k0faIwB4Fgh4ITo5QSalIWt
	ZrvWcit7YRSH+hAF+oAX2rTieiKqd8lNQwSoMy/P2PD1Rl1/x6nW4EbExkvvRsgaX5w6d2IxrUZ
	FVQ2ajWjMJpfp4B/8iIvAsUFxiirjxpx5wb+XArQZtNuoSKcA2tS8S+BvJk/NZcoWTmK4DSTpkO
	Xlief1g
X-Received: by 2002:a05:600c:a05:b0:499:93b3:91ea with SMTP id 5b1f17b1804b1-499aa1f85demr42894755e9.15.1787128929433;
        Wed, 19 Aug 2026 01:42:09 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.112.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0d6a84sm41397845e9.10.2026.08.19.01.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:42:07 -0700 (PDT)
From: Abdifatah Suruur <suruurism@gmail.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	nipun.gupta@amd.com,
	nikhil.agarwal@amd.com
Subject: [PATCH] vfio/cdx: prevent read-only region mappings from becoming writable
Date: Wed, 19 Aug 2026 11:42:03 +0300
Message-ID: <20260819084203.1526-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
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
its read-only objects and as fixed in drm/vc4 (CVE-2026-68445) and
drm/panthor (CVE-2024-53071) and ptp: vmclock (commit
a5edadbae57e2298a56cf7a4e774a027905a331f).

Fixes: 234489ac56130 ("vfio/cdx: add support for CDX bus")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

---
--- a/drivers/vfio/cdx/main.c
+++ b/drivers/vfio/cdx/main.c
@@ -284,5 +284,9 @@
 	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE) &&
 	    (vma->vm_flags & VM_WRITE))
 		return -EPERM;

+	/* Prevent read-only region mappings from being upgraded with mprotect() */
+	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE))
+		vm_flags_clear(vma, VM_MAYWRITE);
+
 	return vfio_cdx_mmap_mmio(vdev->regions[index], vma);
 }
