Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E817364AA4
	for <kvm@vger.kernel.org>; Sun,  5 Jul 2026 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783215615; cv=none; b=QWDSpBH8VAM003SXy0ne2E9TdrguGhoZAUUd1XKKFbwcYLpcCqVfZXPIH8p3nuzM7IwRrAvGpEadsgovqIsb2Ox4Wrto3mi92VUvMM7Lsg/tfEvxc/RfWgB0NTci/76odjAaDnqFCRRvq0x0+w1/9dfSBvwvg062XMrkWEud+dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783215615; c=relaxed/simple;
	bh=EYJEPXytt4pmKnn/MD3hvuVjx/RNH42xxRrH4dUNC8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eLrmxNRApCVf3K/ga8pF2AHi6a/25QD9Tu46h/UdBIIvqM1MXVjL2rNHg7G2qMNNRqFZgfiuSJnUfO7fXz8DSXTxVorGO9roR1UeNjQhn2fk4s+bF3Bf19jzVYTk+BNLiFPxUgfmInxkTMKS6qGudnFrpLI1pytad6HfTigK47Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=McYgCY+3; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="McYgCY+3"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so486636a91.3
        for <kvm@vger.kernel.org>; Sat, 04 Jul 2026 18:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783215613; x=1783820413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oPsFGUTTT7n/qqSsl80pkjMnwpBJfWNqBULhouzxndg=;
        b=McYgCY+3/k+U6wbt+lxn04r7dXDKDw503iWORZxNYBlBU6maqbtvjiX1CtnDJUTg+Z
         S5uwcx7xrJXy/pszhxXrHhgtZOBRe9OJm1lIEv3v8DwU0VT8ISccTM2T2AV1JJv70kym
         GP5/ywejVCAY5yxKl0fTKbGXVsO5SNs82s4BJqesY0vHu50505xLPt0Ods+4ZJK2SX8P
         71/9KDLtIJQKsYc8aLoFQMx+nLc3mfvFqP58z0FMFqirciXLFmLDN3taVIULRH8PJAGt
         8Upo9mF1PT/AVtmVudwlZg9v0+1KOUmNxEkL9xThSKOxQyEUjQn/9hOYk0+TIcR+P9sa
         CnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783215613; x=1783820413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPsFGUTTT7n/qqSsl80pkjMnwpBJfWNqBULhouzxndg=;
        b=WQFzXLVlmyamevuD3A/MyuMRBSg/K8h9EFXpqb7VvNuxSlJhCO7cISsdKQhIuW8zYc
         SFrdOY1JY/ZqjpsQ5RL3CmDeR8A0hezF7Dw1AZxRhgm3s6Yp1FJaoorpHkbjJP4qs+QK
         gtELv2iPJbkhqWwnHm+ZZ9gfoXwyqq8DLbbPSc0R2QJ7J6IQ6AO9ZupJ4NmRfEG9G8nL
         7NyNZOFuhFMgWx2HcMp1/aA7XVbK+DJplX6yEVhpLzTJQ1OkDw2G6Ut9qjdPCFPVhmg7
         P3ubGdWDoSXJGlDWjPP4znjFtDhwGrcPJvyzwnj83IO9PkekX7vQd7E1MeebpQnSbODy
         Vp3g==
X-Gm-Message-State: AOJu0YwyAXFB7xA9JxXfOYPD7X2cLKTin3r4MeEAsCanNVgENZ6iAbQq
	mGKTQF6RmBuh0ybU50r06RS4iry+AnP3OdQ0sC3spe93sA0LMrgG3LcIig7ejUhh7w==
X-Gm-Gg: AfdE7cmv19ZpbgQHcQCSJbKIgTXTWnfb7FcChzTGJQwCM9BEJWVh65GXkxaqCvAhSAF
	VzNZE3cfHNFLzB4Zc1YDyWkC3UjzcnAYrzAVc0uec/wnBKQHLTJp4ftZbMp5G3eFLja2a5iEOvD
	nzyRLeZWhyGPh5FoYCUPl7QdqG59MVDzQfrz8G9wCsRb3Lrbdi+H3YQc04hNy5//YMmg1/SHL0K
	s0ww4kIi05teW4bnXHT3YPrCDQro7uqMAcWdM5/qLRdcg1zZJKXuy/DJuEY1AvTQFciT+1OXt0d
	rNVkY0CWCpbsTC/D5sNyF8h6dq/4QSqNX6Hz1S8iW1iZgv0cJOhNKXE0a/D81pX5mQodGzQmnta
	5vB0vxcoB5PsrggRw6wvidk0e4rrPs5YQRNxlx9hqz+2EJi7jF1xgu4qjQCep0Q4oe2KmFuDkiL
	rvr4kCZjWL
X-Received: by 2002:a17:90a:e704:b0:367:bc89:546e with SMTP id 98e67ed59e1d1-38280e9457emr4626911a91.12.1783215613226;
        Sat, 04 Jul 2026 18:40:13 -0700 (PDT)
Received: from p1.. ([2607:fb90:ec0d:5e36:b9f2:b9e9:da03:a2c0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38127ae6e2bsm2945320a91.2.2026.07.04.18.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 18:40:12 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Auger <eric.auger@redhat.com>,
	Li Qiang <liq3ea@gmail.com>,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH] vfio/pci: clear vdev->msi_perm after freeing it on init failure
Date: Sat,  4 Jul 2026 18:40:10 -0700
Message-ID: <20260705014010.1297885-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vfio_msi_cap_len() lazily allocates the per-device MSI permission table:

	vdev->msi_perm = kmalloc_obj(struct perm_bits, GFP_KERNEL_ACCOUNT);
	if (!vdev->msi_perm)
		return -ENOMEM;

	ret = init_pci_cap_msi_perm(vdev->msi_perm, len, flags);
	if (ret) {
		kfree(vdev->msi_perm);
		return ret;		/* vdev->msi_perm left dangling */
	}

When init_pci_cap_msi_perm() -> alloc_perm_bits() fails with -ENOMEM, the
error path frees vdev->msi_perm but leaves the freed pointer stored in
it. vdev->msi_perm is not re-zeroed later because struct
vfio_pci_core_device is per-device and persists across open/close cycles,
and the vfio_config_init() error path returns without calling
vfio_config_free(). So the dangling pointer outlives the failed open.

That leads to two use-after-frees on the same device:

1. Reuse. The next vfio_config_init() sees the stale pointer at
   "if (vdev->msi_perm) return len;" and reuses the freed object. MSI
   config accesses in vfio_pci_config_rw_single() then dereference and
   call the freed perm->readfn / perm->writefn function pointers.

2. Double free. A later vfio_config_free() runs free_perm_bits() and
   kfree() on the already-freed object.

Fix it by NULLing vdev->msi_perm after the kfree(), matching the
NULL-after-free discipline already used in free_perm_bits() and
vfio_config_free().

  BUG: KASAN: slab-use-after-free in vfio_pci_config_rw_single (drivers/vfio/pci/vfio_pci_config.c:1961)
  Read of size 8 at addr ffff88800fcc88d0 by task exploit/143
  Call Trace:
   ...
   kasan_report (mm/kasan/report.c:595)
   vfio_pci_config_rw_single (drivers/vfio/pci/vfio_pci_config.c:1961)
   vfio_pci_config_rw (drivers/vfio/pci/vfio_pci_config.c:1986)
   vfio_pci_rw (drivers/vfio/pci/vfio_pci_core.c:1599)
   vfs_read (fs/read_write.c:572)
   __x64_sys_pread64 (fs/read_write.c:764)
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
   ...

Followed on device close by a double free of the same object:

  Oops: general protection fault, probably for non-canonical address
    0x1f63e0e8000008: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:kfree (mm/slub.c:6711)
  Call Trace:
   vfio_config_free (drivers/vfio/pci/vfio_pci_config.c:1861)
   vfio_pci_core_disable (drivers/vfio/pci/vfio_pci_core.c:685)
   vfio_pci_core_close_device (drivers/vfio/pci/vfio_pci_core.c:777)
   vfio_df_close (drivers/vfio/vfio_main.c:602)
   vfio_device_fops_release (drivers/vfio/vfio_main.c:648)
   __fput (fs/file_table.c:512)
   __x64_sys_close (fs/open.c:1496)
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
   ...
  Kernel panic - not syncing: Fatal exception

Fixes: 30ea32ab1951 ("vfio/pci: Fix potential memory leak in vfio_msi_cap_len")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/vfio/pci/vfio_pci_config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index a10ed733f0e3..9914f3ac69ae 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1272,6 +1272,7 @@ static int vfio_msi_cap_len(struct vfio_pci_core_device *vdev, u8 pos)
 	ret = init_pci_cap_msi_perm(vdev->msi_perm, len, flags);
 	if (ret) {
 		kfree(vdev->msi_perm);
+		vdev->msi_perm = NULL;
 		return ret;
 	}
 
-- 
2.43.0

