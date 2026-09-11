Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643FC368299
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137769; cv=none; b=SZPrpmcWnVf1vO+H5Oqw3fVusgGRk5K41MSMKlv8xdq8XwDKFdrpWdMuIIb/GAJ49hxn6MeNbXGnc4Hk3LYHWNGY+JmOOX4yc+PwO7B1Mey9FPWtjzOIJEJQ7z1yYsEXUYqBJZcEc+Vi63jxrA0LBOSU1Co8xhF4vHO5QvBl4Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137769; c=relaxed/simple;
	bh=gz51FBCWhizVrU+7SLeOKliZNk1p8rWeS98CiQ+wXUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kNWLGF0YlWwimAYB4Uor7+yNnb02ZWvMaVPvDWNkONjg/lhKZaI9WgBJcJ10WhhS+VPJRuNtMB34RBrA6IvOEaquk9/uabx7wE5dqwCw1veeyFl7AgcyWJyRiKIEKMBu41+mcmwXRtH4H8x31mg40/iG+O7l5l9Zh+4YZQEgsOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ajOgQGpD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ajOgQGpD"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49cd77e0f95so8246945e9.3
        for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 07:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789137766; x=1789742566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hNkJ+Y4UNh/VmhAHfWRxswemkYstE9GZTmx6wz4UC8Q=;
        b=ajOgQGpDs3yYfUXtrlSTNyiOgWtIHxcoXZxQMb+dz2y4w/vXa1LSmatbWXyLQFbWXT
         ny9Fcgw2/nJd1gCpwYz/Cb03im3LOJpgLR1Ddg4yOvYsiO8qPiQlMCFiHZu5U/ljbH7N
         h8+TGWLR4EKofu6Tybtzg49ATYWDsIobQqZCSS6h+tfUOgYL3KMmE0ddZ12E2H1zt4CE
         A2zjyrHVfc1TqDPj3vbb+M2x3jRWHsByokhWJa99F+hma60wTz1hhaxNwKKOEfRDWafy
         ZGE3reZdHpvQFoO0GSHeUDe5CPZDGkruDkRGIJZdzvgP7Lzjj4oFbClqFLpyCveOvZru
         mu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789137766; x=1789742566;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hNkJ+Y4UNh/VmhAHfWRxswemkYstE9GZTmx6wz4UC8Q=;
        b=TDDhOcKbexR8PpXLQs51rY7Gu/KtMAsAp/VoiTDuDSp53phwa1BnEnBg5/Gri7tymr
         fLSxO56qG62D4chitJlGJgmfVpBNoTQZ1EXdHahpdc8NETF7fZH0jCty1+kfkG5OFfjQ
         VpWm07gvJCTl3K2GYTBYKJGYYrdf75ysDVC77VHw+M6dOD+xVjVD+WHP+reo3JCbHwwJ
         RrK3YmUJHX2hDGIq+AffUR7lgnVj5fjnJWTJ2+YNrlInTgsIT7zgW2b1mxi4kIjgGQaC
         GZVEwI772xWET5ujonUFkoukxrZO403fkh+zOhr0nDOaXXvfrs7uGGaln2hBBnKBI7wF
         H60A==
X-Forwarded-Encrypted: i=1; AKwUvBzJ8fU0qhGTLq7ICsve9LrouqxzPyGmm31aqmAo1Xnhkw8Ra6K1/0Um/KL7o01GzBVszXg=@vger.kernel.org
X-Gm-Message-State: AFuF++lqikB+k65jgRiR5mX/MCdUOh1O3kYUcH+VshHbj3JiCF40qvg2
	NSoIon9NSJxMbRAgp+p5bl2bNSVHLFhbQi6SGQ7himB84z0HHBGgYGdnkMoezLDHyQU=
X-Gm-Gg: AYBFou0/vy9JYyeUg5pje3b//GszEd66YuHdrt62a8PpKpHnMiZArFNeOVTGdZYa08Q
	28o0NKUTFX28cbeWeLA0gpNuD6CcBVDINj2NeoueDhM9IZGwkMHJ/CNg5m8ZXbDwgWACBAo3WNM
	T6G539nsA5FVPDYHu5lA+lE99g4SlQNDxc3xN/CvBMDBC44YjpfpDogPJD+J3RFPWS2Sxv6Yq+V
	HZAuftUBCK1gQzHla7To8zQupKQCHlzk6tEVSchZ5zLqDLZghSN0DWCpsw9zbuFaTs2Wp9Fq0S8
	r3JF9LSfK4tkI1f1GL1DjRc6AYw+l8eMNgmLT0WaBDWtW5WVx0TTqrQ+5DQ2r5YR/+MYeILRJOm
	FgF6ogXg+bqfymS01LuSSk2jAs7rIMQq9UulC8yAykzLHoqNtYRfA+0CCr08rqKrmOw4wvCmE+V
	naMGL1cxlgx6AWLMBMKdREIl1chAoEDZG95jlGrBAko/WlaX0VpkLWC0sIIqdx9ddkYFRv8eNRK
	xBsGuyT574PukEo
X-Received: by 2002:a05:600c:e557:20b0:49d:1d6a:4cfb with SMTP id 5b1f17b1804b1-49e619836d6mr35798025e9.1.1789137765611;
        Fri, 11 Sep 2026 07:42:45 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60ababd5sm107038405e9.4.2026.09.11.07.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:42:45 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Xin Li <xin@zytor.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] s390: Avoid indirect includes through linux/module.h -> linux/elf.h
Date: Fri, 11 Sep 2026 16:40:32 +0200
Message-ID: <20260911-module-include-elf-v2-2-954c732975fb@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911-module-include-elf-v2-0-954c732975fb@suse.com>
References: <20260911-module-include-elf-v2-0-954c732975fb@suse.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Several s390 files use declarations that are provided indirectly through
linux/module.h -> linux/elf.h:

* arch/s390/kernel/nospec-branch.c: s390_kernel_write() -> linux/uaccess.h,
* drivers/s390/char/uvdevice.c: copy_to_user(), copy_from_user(),
  put_user(), get_user() -> linux/uaccess.h; file_operations -> linux/fs.h.

Add the missing includes to these files in preparation for removing the
linux/elf.h include from linux/module.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/s390/kernel/nospec-branch.c | 1 +
 drivers/s390/char/uvdevice.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/s390/kernel/nospec-branch.c b/arch/s390/kernel/nospec-branch.c
index e11ec15960a1..b62da9e81e79 100644
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/cpu.h>
+#include <linux/uaccess.h>
 #include <asm/nospec-branch.h>
 
 int nobp = IS_ENABLED(CONFIG_KERNEL_NOBP);
diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
index 4d274a2ee84d..402b8a225d6b 100644
--- a/drivers/s390/char/uvdevice.c
+++ b/drivers/s390/char/uvdevice.c
@@ -28,6 +28,8 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/cpufeature.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
 
 #include <asm/uvdevice.h>
 #include <asm/uv.h>

-- 
2.55.0
