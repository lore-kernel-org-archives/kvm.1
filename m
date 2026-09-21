Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AF34973BB
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993428; cv=none; b=abhyJx6WbmEg16AnGWufZTbV1VyTzhgHNSF4VfM8zul2/Fl4MLijZRF8gASoohV3M0QAMYzP7FWLnspI/q+ckZLdj9LjB/65VROICqSX6Uj7RKSa0Jnu0VPJIsqqvgrK0bew8MI3Gs2PyEhKj4sJixMwA9pFG8/RCf8VuCthoiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993428; c=relaxed/simple;
	bh=KelE4SWm1+HYl0DpOC+bCl0jk0qcaELIIMi1khMiueE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUIo4s9BBR4Gyw+bXSOZRa7tdeNXIFCDS3ktp3i61FD9+XwX40mmBd8xOuBxsA2IYWAt44z7e5lUj4z07kVz3YyklXwxzTrAl4F7FqS8iyoLx+GOcqXZIFTGP6Za15Y+LzF1On6hfsvDIwWzM5X3859eOsL+viqHBQoG9Yb1sfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCgPbx6w; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCgPbx6w"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a605844571so3465734a12.3
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 05:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789993425; x=1790598225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EF+sKWuB3CWbGRd7nfbQrjAa992ig3a8RDVONCAqUWU=;
        b=mCgPbx6we7NYaWk5pZs/ewxGcndbQRWXDBQ4GRUZlYPBT1otTltQEbwWSrQh7Fo+9F
         AEu/twEsbZajkN7d4fuLkKYKoAbz83+UiYym4G+Dv6EU2svA4R8V93BKIL86WDaI7fck
         cCyTsGzDCwotzF/AqhMNnL5MNpKjmU+g0rvJfeyVWWKnkKvBzzeDzKCYTXyOeVotIjTR
         1VGKu9Gf16veb00EoUQ40bOsjrktGwG1xa2SO04U54RIyp6UZ2eNHEWlfjwoaYoS3LmK
         XbD99Eddl8mxhOGJrw/F9QK7Ye2xT5lLTDBCQN7nxLbl6KW9TNJTGOFLa88wfhzyc+4F
         haBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789993425; x=1790598225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EF+sKWuB3CWbGRd7nfbQrjAa992ig3a8RDVONCAqUWU=;
        b=aJBSYdmD3wzhwjxWSLqz5k2ca8fOZtS1f0xGiUbFsGDmc6mwMWQz5StjVm2UCgijhY
         Kc3bL1clEx2osG1E/JrjzAKvZALF6EOCYjJX9lB1q17FAb0sgtRWKVkbpMfRbg9w3ioQ
         FYwA4LKV7I5iyw38AF1N4JOw2eeoJ143H29KJnMBYmz4tgpTIhh/QPqNPTfZWUKrSEo1
         yd9JrXadmKmGDP6KwfEWPdXJTAgH971fKK+0kCL9nOV57GbSRiUU9oobzBHXXKwWlXlr
         Ali1RPzd3NEO9/42Q50x533yXBEpQCRL7MynDcim8gYrbGbMksCpTPYrqrWwUvzafCX9
         oOHQ==
X-Gm-Message-State: AFuF++klXJhZ19wU4saf0RErYzLov4RlqNGzkJGo2k2c/ZWMyq9wdFiU
	h0c0TwWipRHt3HCDZSA+grF3Yyv68iks0V4/5fImh5+HfY5A/aVzYJC2RAg75Q==
X-Gm-Gg: AYBFou3Dtyhg5ZCy65RipzsjLyTFprBpNKuPesQareVxdLSZ0nYZBDFMtMXJACyPQZ4
	Jk+jMuQKewhHxDC0mN2nSWnjKMhbYT2glbr4Is/KVYCcyiZYsSVmPxujY4Fuo5yzl/atPmIINr6
	wOdSIWxYP0Dsz7aWj2z0LQuiQVpQKp7yW5yOhba2jkYL2IxyjHSsDIDCouTRoGALP9lqPJgLWyB
	u60p5fgSKpWppy/zYexlDTnUl8Bh6jpr7yGWuVn4AYOujfnVDCVj+kRZXxt82q91Qly6yi0EvyR
	+9kt9VF3CYC0/ImoxbnRoLDR8FXXRM6f+IDrqeAyDtgtFjn84luRbgATt0S1/WaDi6QUFTxwQ6D
	A1qsem6Z/EP3Guhz5+taSgU+pymvKbYVnzvt4BMV4smYmTwXmuD76MUwNoFOndZv9zdeI/XTN2P
	Lf8SkBd8C0+sAmqAR6TWPYnhizrqjHLKqYTlkO9YxBGIOo0f4NkXAqy9AFB2DivfKM5DaNIh2Ks
	QThew==
X-Received: by 2002:a05:6402:4018:b0:6aa:7fb:7696 with SMTP id 4fb4d7f45d1cf-6aa545f8024mr8446773a12.2.1789993425204;
        Mon, 21 Sep 2026 05:23:45 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.112.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67b5eddcsm4228761a12.0.2026.09.21.05.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:23:44 -0700 (PDT)
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
Subject: [PATCH 3/7] vfio/cdx: prevent read-only region mappings from becoming writable
Date: Mon, 21 Sep 2026 15:23:30 +0300
Message-ID: <20260921122334.2099-4-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921122334.2099-1-suruurism@gmail.com>
References: <20260921122334.2099-1-suruurism@gmail.com>
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
