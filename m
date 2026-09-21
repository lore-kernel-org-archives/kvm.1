Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8701E48F82F
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993427; cv=none; b=jvLTxQxPTzSt5v3h3LdlkdF5VaoHRtFICQIeewKkafJhi3MaUTbm4WBvqi4vefDN6eze8eWZoo9Sepj20jkXJaErZ4tS586x+pMK1AqQEvKVWMizRzxYQ7wtcvQgxT/FSJIsVoEEV1yybjYKm7pon2/O3/7FnMWFPLDiDuG8Cuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993427; c=relaxed/simple;
	bh=AIdwN2utZ+S9OIGhkxgi5YqFtL0V+PJG7pH77YVnr4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOmvoTf77X5IGPU6+UoQAJs6yuy/QyNIO3y5J5AISnJR3grhgiZnc7Z3DKcIzLE10kaLlbOxEPu5Nn0GyJEfZhLGMOFQzXnB3iyk/XViaP7brUHEcV68Adz9l6FTyMx/vwpikVoJmrT0eAsJSoxt/zLBrd0GQrOnYDGUCXZ3z24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVvYqyXV; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVvYqyXV"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6056c2064so3422793a12.2
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 05:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789993423; x=1790598223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KsqvDPr7iq6cd8ngK8PdM5xwS0CUZIiH+1Dv2KM9pss=;
        b=GVvYqyXVdKnyNG3psox8nXHi1oxOaoKiGyELuPLRUZ5k+fP0hfEgQ0JaC3vv15vXw5
         OAeML8YahcZ15ioj4UqJCbVbBf09fGeGhE+ovyN+Y1dFFlxFrXUecG0u6MHU5/dQ8lJB
         FA2SwSivNt0oyR4JIcGp5RpJzGme8BAVq3J0OTGkeDWL2o/BisUJmHsuxqK8aP6OESxQ
         3xDOOQ+UXp+zB+8nLHk7gVA5Ig8rOLAiyV1BDtT3eh6/cNvqeBx42DI98NuK4C4K20Tn
         N0PLxH2y+Gul8iiIhhDQwltgu67WMyEvNAXJcRwXjJfobeJHtH+8u5rqEKrFzuAmm3eL
         qs0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789993423; x=1790598223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KsqvDPr7iq6cd8ngK8PdM5xwS0CUZIiH+1Dv2KM9pss=;
        b=0uo1RbkukDqkLkiz3OCdnW/UigYvjNBIx5wwX0DpdHNsRVsCzX0Z//1Fw0Wrr9RqWy
         cRTPcEPUSMH/JjFH/R9UXJpJZRw1CtODHW8yK7LRXkJ3xBstFJ1y0UktxY3O/XpR4Ql9
         Tk4N+HB2/TqLAXO/aiGNHdPAB+f3pSQ1zBPtdqz2xGs31Xwop1kPD9SrjUWFLmll1aD8
         W2COhBJd2azXzmkCHnaVElJC10G1sbNXbZ2b51UuiBKGFumTAkaOw6d+JdnU4qkCwCod
         d/GRXqdnjNXOe4lYUL61zD3MYyd/P+TX0fDk/g0E2LQP/TslvKcHw54yOCH/BNuWwMPG
         PmWA==
X-Gm-Message-State: AFuF++npQjkotdxy3PGzxjznwlQjXNFXwogj+0DOQo6u2QJtQmN2INjJ
	CD3k8L/xMc53xy2Azrkq1MsNJVzLRnOb5vNjUI9czWHjD0m1YughVOzmYiDuQA==
X-Gm-Gg: AYBFou3W9UBlzOEHnWWG5vQfU90YdTU4ATgtmpLxhsUzy3jnAwWYkVLq8wlxGyzes6/
	jojPECm8usA7F0XjDr8GQQc3w02IyaTDQwiOFOiFnpW7tpaJt88U2AGMdrldRBn9kKUGI1cNZ7n
	ywJJv7WuqOb5anO5sSqsoOdSGu4mRzkLXc5KMoHxpTIP7nbuX08/vA211JGLDnw9kf7UdymsXI/
	AHBFAl6fCpy5fJMgLJ42VA2HTkv39B8qzKF7xRGkWX5Crp9NDuMz4u1CmdQbnreZlg6kI+pVwEP
	8EHwnADh+/mc/7OCjfvjZbgMnKXnBdd4orE9HkvYp3sGfa75dbtD/w1JMwYSvc7x8VJEFKZCq+n
	PY74UWLOrfCgfXTX9+BGGjLc/zh9ziO4BaCvrQSGDgk9MTvnx9Z0G7GJBKmWHKF6vKrrsLC3wk9
	4x6nNZlDwFiSEj5wsqAyFBDEHjY5qZbJswLe4DyiAVZF0nMUlSRGm71cx7c1rgrXxwlakdY28rL
	EzK/Q==
X-Received: by 2002:a05:6402:434c:b0:6a6:32f5:556f with SMTP id 4fb4d7f45d1cf-6aa562e21d2mr8202167a12.17.1789993423220;
        Mon, 21 Sep 2026 05:23:43 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.112.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67b5eddcsm4228761a12.0.2026.09.21.05.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:23:42 -0700 (PDT)
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
Subject: [PATCH 2/7] vfio/fsl-mc: prevent read-only region mappings from becoming writable
Date: Mon, 21 Sep 2026 15:23:29 +0300
Message-ID: <20260921122334.2099-3-suruurism@gmail.com>
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

vfio_fsl_mc_mmap() rejects writable mappings of regions without the
WRITE flag, but leaves VM_MAYWRITE set.  Userspace can map such a region
read-only and then upgrade the mapping to writable with mprotect().

Clear VM_MAYWRITE for regions without the WRITE flag, as i915 does for
its read-only objects and as fixed in drm/vc4 (CVE-2026-68445),
drm/panthor (CVE-2024-53071) and commit a5edadbae57e ("ptp: vmclock:
prevent read-only mappings from becoming writable").

Note this is defensive hardening: the fsl-mc bus publishes all device
regions with the WRITE flag set, so no device can currently reach the
read-only path.  The guard costs nothing and keeps the mmap() interface
honest if a read-only region ever appears.

Fixes: 67247289688d4 ("vfio/fsl-mc: Allow userspace to MMAP fsl-mc device MMIO regions")
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
@@ -406,7 +406,11 @@
 	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE)
 			&& (vma->vm_flags & VM_WRITE))
 		return -EINVAL;

+	/* Prevent read-only region mappings from being upgraded with mprotect() */
+	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE))
+		vm_flags_clear(vma, VM_MAYWRITE);
+
 	vma->vm_private_data = mc_dev;

 	return vfio_fsl_mc_mmap_mmio(vdev->regions[index], vma);
 }
