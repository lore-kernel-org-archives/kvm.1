Received: from mail-ed2-f34.google.com (mail-ed2-f34.google.com [74.125.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB17495ACB
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 12:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993425; cv=none; b=nlODq5741Pi4PjS1AVsTHXRVcr/lCGRT1g94rffCUr9NJ+/P2AG0pJgxC5+K5bE6m/WuFZ63tK5K+3jf0OTLxpLrLDjC5Lkxs1+yA8tGK8gVG2RZmyf0OzsyShoNjFLrJJ1UhS7sc+RDDmYPtKJs9DIsLgR8+JxT6x5OedDGH4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993425; c=relaxed/simple;
	bh=F9zJRMikI9WeEBIIzxSya6IfDY6kvRKp1F8o4LGQzf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAq30kd9Rvqwq8gptdc4K9g19Da/ZSFah8umqOljx5HVNZDfCl9wGvhsIGU81LKiuLs1hVgaa0gOwsZPf5DsiCaz87Hr2Is2RzzDkO8QUSDX+e5+o/HO2fnc01BERBDfzfVf0n45AfmNd0NR8+xJkQ36e6kPykGBQ8za5Aj+AGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCX7K/sI; arc=none smtp.client-ip=74.125.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCX7K/sI"
Received: by mail-ed2-f34.google.com with SMTP id 4fb4d7f45d1cf-6a9dfe4dfc0so4200742a12.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 05:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789993421; x=1790598221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9PtmaD+dFfANavdWfY8E3JvcpIeWj4J1LbV7u+lXUeA=;
        b=UCX7K/sIVjf2qokVrACZS3RRa5rPfwk5NegBTGzsGcPSmOdbmardwYogktPkmPob1q
         12BFPP7CxXcas2tQCPq1UsfkjleM9e9ecbEojvScL5zov3KFEoR1AWVFozb9WKO3iASg
         VjBWNY0pAUERaHr9ZraU+fbeJSTAGajKFcfoRKdl//e4GqxJmI/epZpJrVS1MIE3ekQ5
         jZ4Df6VLPrQjk3CdT+gmXOdZOn6UnemwGRT/jUB9+rJrRYSh3U+vOlSM5GDl09F0YRpl
         NT01Y0EoRAzw3p+fmBby5uWp5dtAY5K1NSZgibJzNJql5JTYOKpVOUdyAdeUkxmS+Bow
         EVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789993421; x=1790598221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9PtmaD+dFfANavdWfY8E3JvcpIeWj4J1LbV7u+lXUeA=;
        b=0tgq2trXk9mmm84Et6dx0ObuAiOkAuiVq1Fdi3+ILMcUf+rV267iSQXc9KtWVXnX90
         /o8mFU0kxCWXAdbh0+N2b/rCEUNcWGK3P3vrxngTinFwclhtER2uBNZ3cb3lii669Yfh
         rsnHkE9sU90xhsNzEP9jBVp5IscTwXnIMw72uNKhPet1CuJsqX4MSyJrY55aemyG4SVF
         FRXhjiSOP+MZ/fzeCRI7cdPedboOc46gRwfmBZ22VAZtZP3d1gW5Scj0dexAvKNlNFV6
         v9wyWqK2w7ohmgGEn13o4JZIQJhhihTbrqrqhm6U26oeSLBXkTHD86urpQ7ZKMxD1gsG
         kcYg==
X-Gm-Message-State: AFuF++kZa2Rz1jnuxYlRvs3y45UXmgOg/b/NaSDp9josAWUHV9g7G9Tr
	SgJ0MiKiQ0gvOi9IPmLn1LjlsBtJhKrmA9d0fdHUC+7JZev69SNkoT143T727w==
X-Gm-Gg: AYBFou0Sjn48zWcvW777tO25klR9ePYESmZQ1DTFAGYJl+HbUqPjZ4KVxZDNWpYeP9T
	g/IS7Oz+YXjA8HjNFohVmyKEI7Hyg820EECgnMLbhAJaPd4N09CBIgbkruF2U7UFb04IAsE7uJ5
	IttLnU7JnvtMHe/HXaCzzMIKiqlIVY8qBSDUa0NBikobPgUrJxBooALF3hWiRKSOEtVJGGGG21z
	PjV4Thsw9Dt12xx0iuiEooJA0kFGqEJ72tV4cp3ZbBZwQ2iHKnb4MxPSGrZz8XryvJ99YcUcYm0
	DmRH037leX+oOboUzo5OOGWYPeL456z10/Lao4FrlAwF9bTQ37Rx8gcmQdVV8IjEm3+36es1gC6
	SkxVvcHCJ/qw4NHGj6m22MqFzDlKwa98kFW/sfinQH81pgLQPRqWpW3NBuDemLr/+IPkQv2ChMn
	T/nTxtxirE1873G7VRBxvQV+sOG0QZTa+kgtfKINvY0lq/pboIGH+d5nVrTw7iSZRa5A0KiQfaX
	Qiwj2G7++vK4koZ
X-Received: by 2002:a05:6402:3205:b0:6a9:ba2d:4752 with SMTP id 4fb4d7f45d1cf-6aa53cb300amr8619349a12.25.1789993421279;
        Mon, 21 Sep 2026 05:23:41 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.112.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67b5eddcsm4228761a12.0.2026.09.21.05.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:23:40 -0700 (PDT)
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
Subject: [PATCH 1/7] vfio/platform: prevent read-only region mappings from becoming writable
Date: Mon, 21 Sep 2026 15:23:28 +0300
Message-ID: <20260921122334.2099-2-suruurism@gmail.com>
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

