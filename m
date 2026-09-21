Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A1C492516
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789993423; cv=none; b=HM+4eNn47lUuMftzRoOIDf3yKjS/Rst31TUoZZrU6HTvjrZb5luXMxAGvknGBDjZx+rZnxY+LNRh6DBr0tBIxz+Sek2TaEQ/e5M25c6r4JSeJ2abhI/I1EJ9nYSxkRqaEQY9N1/erbh5Iw9RyjhEZm+Pv6hUJp7ayYJh6oCYQUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789993423; c=relaxed/simple;
	bh=JV4W5TMXI76KcExHD2GTseLBA6zQn/BdT3kKQ2I+OrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sfPH4W2l96u8ew4qEqxCCAbghPKt1uh2ioIopM8Qs/WwShdTWqj68Vq3xIq1fKCpP8drptJlVnN4Fu/red+LU+dEbuN3oOVlsLzoVo1ayvHthUCUkphHd0uOdGc+pkRAZNjxfPTVxHmFnZc6FvCRJPOLXaCSQl60Ux5MGgdl0ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pt4lTQm5; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pt4lTQm5"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a99391ffb2so4733870a12.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 05:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789993420; x=1790598220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1NSOlcFsa3Q2haBKnE9Qyms84RhbiSQDazU8Yyf+/gY=;
        b=Pt4lTQm5IBjjZn3nUStQGAiYbM+x81E1AantfoYbrGI1CGoOGAjPQMOiB0t3aCh76m
         XAmvKVPifLkJWWpnUu1QRh6LAU/ogzvoQNq3s3vhQUKFUXietfGtYII8LRP1WIDUfJ+Z
         BTLTtL1KBQd6FHHKCt60fa97xo2fm0ycRbmn3Sfg99t6B27wkDvxmi/siMqs5SoJDL6j
         2ydF17PBn+x9s1QfeccXQRcBQb6KszSUWFynHwCGZ8wRhSEq2RC3gGZUmP4OhD0vNiZI
         rOuRNyVH6+XS58fYlI/3iBSp1+QnyNBV0VKqnxKAZW/dkoop/g4d9UYfVsmZngr9ke9w
         ZJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789993420; x=1790598220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1NSOlcFsa3Q2haBKnE9Qyms84RhbiSQDazU8Yyf+/gY=;
        b=y3+FzEhtnVveS3Brmf46GciVn/ev4n80N0vvKZkuFQCPgofrwn0h2ehZJIL+Y9LGrn
         rqfr7eaRXsVlrfxM/hgcsQkL61TIc5J19I3HpAVgqbjnXxVT7IYFIxvjfXUbImZnc9dE
         ui/iX7c/RTtlJnImzZCNMdNk41aPnSYrNw1mgUIJKzmLjYxXdEVyU+bPdvJ57oZtfdYA
         ovBe9RAUY7whWDraib59nQlSs6nHMkC19GxUs+iVs+o6sW/QNtkzrurgegCvMMEwqtZL
         48HRc01YGAfx4r9lyBbRS8AkpxZ9fQirB/rSRgkPtG8lEZBRH8rJTYR3bwX1rJH2xVTL
         1vOg==
X-Gm-Message-State: AFuF++kxctlhv+CEMv82BQNzZ7IVnhnoAEVMBCCylVzvJLnpLD5Mw7D6
	O8Epm5H7Swdx/ju9PNIiPw8B7UDv6jGbgboevCTuutctXxZSq3Flqjsp2BIjdg==
X-Gm-Gg: AYBFou0fFIizSDS2hUmlYFIZOyCkyPUh5p+j8tizlOcoq6odiZZCj5y3jrUsL+eA0u6
	oYgsfTBqNh/E+0sOsrmI65KBGZRanOiVBiuzDs+tbtS8/4zikMhJ0EBPCzugXftV0Crjocm7hCh
	oAXTegACaFhDqqG5FRKbPVXiiSszAvBJVgV+0ukTkw9r3PfPTyNmsYgzoE/1s7XoeGexhZzzc/G
	PBuDZLOFD5GGnG9zg4LWJgHSMtdRx7ustNSyHh0mo+xPKMmETGqBrH3s/YuuskSMMOUjHXyZ3s0
	lm9/9Gc+PU5rxf8XrO6UKmq0PdMgzb15nTX8hcsQyZhByBfHGqz1nvjsOReHmpf7mFUxijGUgKW
	9nh2Ued27SUpOyOszRJf24Grm7HEhJ7HdBKmg3/XG3k8/nB4Pp5z7RPqs3zbayk6qVBfbAthXn8
	8gZ3dwXHubydCqYhJmYt/cbMYSh4ENLaH7z+NMxu8GlTfrUxb1wRvlPxTCEodinC+06Z7t+2V1l
	Y2QgA==
X-Received: by 2002:a05:6402:20d6:10b0:6aa:915a:f51e with SMTP id 4fb4d7f45d1cf-6aa915af661mr984290a12.17.1789993419349;
        Mon, 21 Sep 2026 05:23:39 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.112.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67b5eddcsm4228761a12.0.2026.09.21.05.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:23:39 -0700 (PDT)
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
Subject: [PATCH 0/7] vfio: mmap()/mprotect() hygiene for MMIO region mappings
Date: Mon, 21 Sep 2026 15:23:27 +0300
Message-ID: <20260921122334.2099-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These seven patches are hygiene/hardening cleanups of the MMIO region
mmap() paths in vfio-platform, vfio/fsl-mc and vfio/cdx, all in the
same class as commit a5edadbae57e ("ptp: vmclock: prevent read-only
mappings from becoming writable").  They do two things:

 1. Clear VM_MAYWRITE on regions without VFIO_REGION_INFO_FLAG_WRITE
    so that mprotect() cannot upgrade a read-only MMIO mapping to
    writable (patches 1-3).

 2. Keep vma->vm_pgoff in the logical VFIO offset space instead of
    overwriting it with the physical frame number, and reject
    non-shared mmaps where the remap_pfn_range() COW special case
    would overwrite it anyway (patches 4-7).

Proper scoping: no in-tree platform, fsl-mc or cdx device currently
publishes a region without the WRITE flag, and none of the three
drivers calls unmap_mapping_range(), so none of these issues is
reachable today.  The vm_pgoff changes preserve the documented VFIO
core contract that every device mmap is linked to the device inode's
i_mapping so it can be revoked; that shared namespace came from
commit b7c5e64fecfa ("vfio: Create vfio_fs_type with inode per device"), so
Fixes: tags were dropped from patches 4-7 and kept on patches 1-3,
pointing at the commits that added each driver's MMIO mmap support.

Previously posted as standalone patches; grouping them into one series
per Alex's request.  Reviewed-by tags from those reviews are carried
on the affected patches.

Abdifatah Suruur (7):
  vfio/platform: prevent read-only region mappings from becoming
    writable
  vfio/fsl-mc: prevent read-only region mappings from becoming
    writable
  vfio/cdx: prevent read-only region mappings from becoming writable
  vfio/platform: keep logical vm_pgoff in MMIO region mmap
  vfio/fsl-mc: keep logical vm_pgoff in MMIO region mmap
  vfio/cdx: keep logical vm_pgoff in MMIO region mmap
  vfio/cdx: reject non-shared MMIO mmaps

 drivers/vfio/cdx/main.c                      | 11 +++++++++--
 drivers/vfio/fsl-mc/vfio_fsl_mc.c            |  9 ++++++---
 drivers/vfio/platform/vfio_platform_common.c | 15 +++++++++------
 3 files changed, 24 insertions(+), 11 deletions(-)
