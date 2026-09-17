Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A61849D590
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668643; cv=none; b=fdYXRvc7zk/BN8FW6HlsQQw+zxe/2QmejwIizDWXCYQfZ1iNGJiWhuQn6UL5TomI9nAYYF8vNrwblnnTFGg7S4IxANBaGd+o4eKYuSO0kTjkQS9FCwiaeoDTgkCpcaJxOz35w4znpxkvqD3Bipd9uEYVWbNSxHV6eMaeBpMdIlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668643; c=relaxed/simple;
	bh=kr+z+SDuUt1hcjAlDkjURs5lDqW6XfYcaxmQkcluc18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bcU1UEehz6tawN4hh+lOUhuzuel9+uN3QFN7UvdpHDiNXT6htxg4Nf5g8W9B3z/fV4pXbeMPfDW7mACtFIlIa2TF3H6HJjC/ZVUPMzccGUvhT8EDefHeAHqR2E+nxarRu+ICtUCwspjZE/GfLhoRYLg9yCsg7IMqyxnoklpWPIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jG/kxUiu; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jG/kxUiu"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b350c6920so1084047a91.1
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 11:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789668640; x=1790273440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3uVaG3wnObeyDihPCO3OxQZpu9/0jLGD4D30QeEXjgQ=;
        b=jG/kxUiu+kHH6JE7fKoVZ3z5nMU25LtYr2UT8z/0MqyoUxe3ysrvJHB9A4kcSsZoVA
         t0PereHMYkHlsMz6ZYQzZ9RoJJBgJboVH28zixyfl8PlxBKm2v6t8nqMemxUtx1q8LpQ
         bxSPc4N2AHGUOHlFU9kr/jcGRQWn5FcGU0jTrAOOMyyjQpOnDXiOCfno0vqyPUkXMSjz
         NpuWxoZEpZiinS384SG1nhhuQduDttRRjcCEW/TSNVSI6aOCRqcVxsjfTMJx/0eTnpbP
         jxeoQrxAGy/FUpUrPy8BtkM4WG2UTu5nxC4k5HNuoqhTPSkrK2XmGZnOBN92V7+IU0lJ
         Felg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789668640; x=1790273440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3uVaG3wnObeyDihPCO3OxQZpu9/0jLGD4D30QeEXjgQ=;
        b=joEfbHd51HfoEKb3f7Gz/+Fv463NbbZ5rJqZYLaQBN7l0TsTXy3Zgy9PKNC8nqtZDu
         ioSqPmk53bURxywWug6GS1M0u+KokAizZJcZd0VEbw1pSR91dufUzrFDJfL5OK/Y3Rch
         2p+VI37n//VEqJVioU6i0cTjrTjsqpk/QtLJ4qRGBDh1UdfDLQrXlsHg33/RHaDnb9Z4
         5fbUReu1w3L6tkRaHysOD6vN73MK+DtnObtvhYFtOsMXwB+4SOJcLILwOe37ZQVud8Vd
         K/SSUYCVE2o3HarMdJ8qiJnnEiVDqxgsEfW0fWdCepIlFfNWA6ZY/ja26vgEeiH8qbdQ
         QS7A==
X-Forwarded-Encrypted: i=1; AKwUvBzNL3IxPZNBX6TcuwwoUMjh2N/mOxeS++VhCzbwnRyYnjzJaVGhANogKyxetmjAcGgXnP8=@vger.kernel.org
X-Gm-Message-State: AFuF++myQfmKGPnLmAQ+7/3pTMmsbaE11/xuWh9KYEeaQhdlHW7sSsyu
	jJHB+r8dP9VNJbixXbW6W652igCG9GIhmoaGcDNrm9o0dvqtbodiZh2N
X-Gm-Gg: AYBFou31wNR5SlqXxyDsw48WEA2Dxi8tX3hizeLD1nKV3VCX/R3LjYCW7nFdiPIrmDJ
	+jZsIi1Y9mZ0GBOZrIF+FhPEaWnx2YGIcyfQnDZvyZx2LGXNwSFuiWP9FJ0IBxk41450AXmsDXL
	XuOhW7qveSl+0Tal65pW3/vfPu4pa7oej/I8Lme4ztByRmlFQfLHhEtIigInNdGpT/GioB2J+T1
	pD0f6CYBmdF0KXOAmGXpUvZWun5cC3DpqHVCh/+2gTAWORQKzaaEA63A9LNq1LU9SneK6d/uFZz
	D6b7I29mMMffvzJijM7ESeCE05L3xlpkWO2RxrPOoznYL74k6NGWnl4JKFxoCPmcmj5zAKZei1B
	YQ2Elw5wWxyzM+mzC5ZgvSbfFlzNgozR/fCpjpg3RW6OEbaxIADajiJMa8i1hDLtzUW9JmL34Yi
	kr1zoVFzANQ/fzyNBcbSfEZdnIXOuvhyih2oevyGkli7s0jA0T4JJtADwblh20VsFZFmn8psxqe
	FMqnB783J+B
X-Received: by 2002:a17:90b:2ecb:b0:39e:4154:130a with SMTP id 98e67ed59e1d1-39e54d8d5e3mr10862a91.10.1789668639710;
        Thu, 17 Sep 2026 11:10:39 -0700 (PDT)
Received: from 10-86-27-207.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395cacce6sm15059432c88.1.2026.09.17.11.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 11:10:39 -0700 (PDT)
From: Gokul K <gokul02k@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: Drop the unsigned >= 0 assertions in test_write/test_read
Date: Thu, 17 Sep 2026 23:40:28 +0530
Message-ID: <20260917181028.288194-1-gokul02k@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_write() and test_read() both open with

	TEST_ASSERT(count >= 0, "Unexpected count, count: %li", count);

but @count is a size_t, so the condition is always true and the assertion
can never fire. Building the selftests with -Wextra says so:

  lib/io.c:51:27: warning: comparison of unsigned expression in '>= 0'
                  is always true [-Wtype-limits]
  lib/io.c:128:27: warning: comparison of unsigned expression in '>= 0'
                  is always true [-Wtype-limits]

@count has been a size_t since these helpers were added in commit
6089ae0bd5e1 ("kvm: selftests: add sync_regs_test"), so this has never
guarded anything; nothing regressed and there is no behavioural change.

Note also that the message the assertion would have printed is wrong: %li
takes a long, not a size_t. That has gone unnoticed precisely because the
assertion is unreachable, which is a fair summary of the value it adds.

Delete both. The comment above each one is about a count of zero being
legitimate, which remains true and is worth keeping.

Signed-off-by: Gokul K <gokul02k@gmail.com>
---
 tools/testing/selftests/kvm/lib/io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/io.c b/tools/testing/selftests/kvm/lib/io.c
index fedb2a741f0b..356586250595 100644
--- a/tools/testing/selftests/kvm/lib/io.c
+++ b/tools/testing/selftests/kvm/lib/io.c
@@ -48,7 +48,6 @@ ssize_t test_write(int fd, const void *buf, size_t count)
 	/* Note: Count of zero is allowed (see "RETURN VALUE" portion of
 	 * write(2) manpage for details.
 	 */
-	TEST_ASSERT(count >= 0, "Unexpected count, count: %li", count);
 
 	do {
 		rc = write(fd, ptr, num_left);
@@ -125,7 +124,6 @@ ssize_t test_read(int fd, void *buf, size_t count)
 	/* Note: Count of zero is allowed (see "If count is zero" portion of
 	 * read(2) manpage for details.
 	 */
-	TEST_ASSERT(count >= 0, "Unexpected count, count: %li", count);
 
 	do {
 		rc = read(fd, ptr, num_left);
-- 
2.54.0


