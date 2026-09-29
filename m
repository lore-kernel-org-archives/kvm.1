Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDAA4BF930
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675338; cv=none; b=l3B1is4zi4DJwkukNA6ug19wv6ru8rMnZAxLH9rwsBFNWljpYFgDtPaI7rUgr3dQCzP1Aj46zDYmHwC9gVDo9yM4nKKZ4orcJ6oJDhg4t8pgm7HBnMpo1EdXySl4gRwbcUT30YPcreuC9y3zUpkCYLSjWYfGepygfb8vtXgNvp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675338; c=relaxed/simple;
	bh=YMe3Zk2nXuE8XEhwN2Qg/UDmrwPc+8BaHH88zc+1zLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SLi2cGH8m7hxojlPznwG27dNdNM8vI64itdQchL8lcK+m8midFaFylBYRhRBmuzyiXUzjt+MV9wPwrLqOZILTMdBaXweqWU4FgMrIpdbL/b7Kl0zJU7xF9KMF0uiGAS6sDY8z9F9KlGkE2akqZNy4Nst9YFVMtrOgXJaJl2kmgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlV43skT; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlV43skT"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so22138075e9.0
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 02:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790675333; x=1791280133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iOzpqRSnyNj37ljU8ynQoOyLs4dzHeG6uqIOfEfXILY=;
        b=XlV43skTG8bYwiqHCZ8Xr0UZD/mrQ9TMsW5hzGtrxshxiKyYCmqE6TKXsqaf9D3gdv
         ifmLFRykpqeaerNuFr2vJKin3GlRGJ2zUI6h/dINEn+Bc3eAW7ze2unvMNes4CmGtA+k
         kARuHP6gkIKwOkVzZDgvSIjw7hBiXig3Ko4nOWpKgf4pkw2iDatkkyPLNX05OIPSf7Cv
         Y+XTATCpAVG4y1uptDxyRrJOvPgvcKu9r46BJnJHH0Zn/c1HvGAf5ZRe26Q2krIN+yBk
         VaRaHRS3nCJK5NeF9rXFA1WvZJKJ5E0B+aIABu67qdeEgDQfVuLRIUvULVKWJfkME3rK
         A2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790675333; x=1791280133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iOzpqRSnyNj37ljU8ynQoOyLs4dzHeG6uqIOfEfXILY=;
        b=e2WKY8TdIVaAvTKZVk2fDIn4QNpOLB1WIJYQ1RqSrOJgyuxzzhml1nTlFMYT0fNZvY
         2G010/jdYKIRCpyH7yuxGRrR0MpAKWTCJlCZXNqXlhpCQc845P1R9WvBzBuRnJhHciyF
         9Bfi9h4XblW1JkfUDJyYHs3Qm92UdIf9VeoFvLIPKT64s4OCtIwLIB4gTvN+1evBspZj
         GGR4FJfkVEuWmvM6/fM3EmEKzUkGQmGY2vv6I0V5SLClpF/kvrBnL1fLVIz3U1itqbSS
         D7C7fm2Qav6JHlrKDceDewktXQ95aJQBgXfTRB7wTvqU/oYKvzUbEprfwuFTNyIyMQMX
         bfFQ==
X-Gm-Message-State: AFuF++mmxqRcgRF476zjaME6Tqu4+njiUWvm6Uo87Ya/n6mt8GERJVlO
	KhCnOpRBjf28tYjClXPxJOUdomLi8wKLsOmIfu8cLnkfSF3zXCA+ODRog8f95Q==
X-Gm-Gg: AYBFou1rNvvav5Wbi8QncrgTj13eLnPYPzp8vm7iN/Q+icV0P55GCQOXxjq4ovzHnQL
	UfQOXCa0EYkehbQVBHyRTdPGK1VgcsJ520rhLPTMsQ41am9rGqX0Co6bcABqU/JTTv/YJaDq0o/
	ajWCBhFAdsXIwReW86TjmEIZqZ0jq3Yd2mRi5Ol0OKL0EjFzqHDmuXolSeF/qtEl+C466qyqyii
	VbowRH5S2N2NddN0sbp005M4cxM8nr7Y/R2PzNKvSoT6jj1AEAUX2TrmBgZpsB5afZoXji2L8iT
	+mvLy9hUXHxp2WU8DWbWwDKIFNgEeIwlqGFyzAR39K+h+h5BMrzGamWEVdZq6Y+Dd6OeaOuh2to
	R3DzVwss/yAO4ILPXvQyFZjmpYvxstYlp3OKCK3TMgWLEOEpmDPLVQf7yNqaC0Amn+IFSbFnB+B
	iqGpo5bWGdL0ynrWWWnfE55ZmNdR769xP/jV/FuRNkiUwy+bxELBysb/0RnC2OeqVOFifr7WXaD
	wmi
X-Received: by 2002:a05:600c:3b14:b0:4a0:12d6:33b6 with SMTP id 5b1f17b1804b1-4a012d633bamr9144675e9.8.1790675333021;
        Tue, 29 Sep 2026 02:48:53 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.113.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf9b72fsm89821455e9.9.2026.09.29.02.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 02:48:52 -0700 (PDT)
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
Subject: [PATCH v2 0/7] vfio: mmap()/mprotect() hygiene for MMIO region mappings
Date: Tue, 29 Sep 2026 12:48:41 +0300
Message-ID: <20260929094848.7439-1-suruurism@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2 changes (per Alex Williamson's review of v1):
- 2/7, 3/7: consolidated the duplicated !WRITE flag test into a single
  block, as Pranjal Shrivastava suggested and 1/7 already does.
- 4/7: carried Eric Auger's Reviewed-by.
- Rebuilt with git format-patch from commits, so every patch carries a
  proper diffstat.

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

Previously posted as standalone patches, then as a series per Alex's
request.  Reviewed-by tags from those reviews are carried on the
affected patches.


Abdifatah Suruur (7):
  vfio/platform: prevent read-only region mappings from becoming
    writable
  vfio/fsl-mc: prevent read-only region mappings from becoming writable
  vfio/cdx: prevent read-only region mappings from becoming writable
  vfio/platform: keep logical vm_pgoff in MMIO region mmap
  vfio/fsl-mc: keep logical vm_pgoff in MMIO region mmap
  vfio/cdx: keep logical vm_pgoff in MMIO region mmap
  vfio/cdx: reject non-shared MMIO mmaps

 drivers/vfio/cdx/main.c                      | 17 ++++++++++++-----
 drivers/vfio/fsl-mc/vfio_fsl_mc.c            | 15 +++++++++------
 drivers/vfio/platform/vfio_platform_common.c | 15 +++++++++------
 3 files changed, 30 insertions(+), 17 deletions(-)

-- 
2.53.0

