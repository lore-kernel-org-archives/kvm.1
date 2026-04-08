Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C85A3DA5BB
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669179; cv=none; b=Qch6Q1Lo6rPzTebtXqcdADdnfQISvEYJVPXwjaq62KKd0wK3gvNav47kN1b0k2m7ZuqF/rGD74jM5kJ3l7zhI9C/M1lZsfcwbZCQt2afHd5ts8yFryLxhowGS7OxJ1HV02HrIfUn1YplhLVz19XSIdKz7tjmYEcnz0V5tXQsFvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669179; c=relaxed/simple;
	bh=9j+Yjxv5DCIhDgqhSAFcOR8cdCu2/7Gl8VDuHjhEuMY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uuJKkwYXYzl1eNPX+xjA+y0Zoca3Scxkgof/OEFA099LPHWxljwsriG8E1jgUkHiTnVcIq9pJA8rGW8aglgLgs04/U/OpjlGR7/73XCAyUOZi56iNahCO39sV8QOQWNIG1WF0B9td91vkliJcPsXwW+H8oBBQy7FjZYVsWyKB9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pZpMa2Hc; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZpMa2Hc"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35842aa350fso310517a91.0
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 10:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775669178; x=1776273978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=coXWpWCJYRhXsanWDc3UBlYfp3L/GbnMTag+lQMZ4EU=;
        b=pZpMa2HcT2bdNr83iQTkU3t7HSRVAhYDWaB/RJjns3e2uQsLm/nYsHxOb5rfwyFb4S
         gblv6mXZjCjiOjytU7ade2fWeYcyGLvMC92IVqy8YuNEp8E7ZgTz961JnUKocngMPajQ
         Mlok2zAD14pzsacUBKgVjzZf1M0wgTnOpz0KpGMZdXXC1dYRhgpJsJVlIFjpv0IMPY7m
         oyCrjloPvWTxmOYDOaPCu8lIAkgdXdPPIskKvMeDS8X0CT0ylTZZEkvmI6LgIKKOIfu+
         oz6nerElY53poRvf2/ss+TCnCNE1PDfnLE3UjpxIDso3tUw7OrqFH06zWbI+2WtdX3il
         GJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775669178; x=1776273978;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=coXWpWCJYRhXsanWDc3UBlYfp3L/GbnMTag+lQMZ4EU=;
        b=dVBy7IQ8f7mlAiz0SqLD5iZwtWkQxZjqJA+Woz96mRu0xzebqghq+DwH8anjB2N1w9
         Lrnz7kuUVOKI3WODajPzVB1Omm9/MH6zriWF3a2bWTGuAM2wVWWrH9lU6A7po5d/peFu
         b2VEe2dPYZ8IA8hfRoexX0tXwBCnE3Y5fMORyxagCUCHRKBbxRestcn3UZnUClX/df1D
         P3u8G/slooKt1T9p51HG4qOd/TZf0mUzPw5l0vTamgd2+qgC167zipfmWgj4/PYiFmsu
         O9hXAHznUMIvClWhjx8vxxIqe4HnuBDEKWepom0uYu650NjzvmtGCoB2Z6SZi4GngoJv
         YZJA==
X-Forwarded-Encrypted: i=1; AJvYcCUdxvFNCozondN+r7cIiyr48q3HE2M/86eKUQNjmCUF5wDYLxwzrqpGBR8kfDjnoduFT+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDR+xL87QnJmCxZ7qSrHXKvewmsqyXvXlKLyHVyZfy++269zZR
	V83G+2yEzdr5kBHT5v+QVICxBSCPJVuuHGvB9VF8eCiKboDvmrBN6I4cCFpd8cHumE36iemwIbK
	oNzorqg==
X-Received: from pjbcl15.prod.google.com ([2002:a17:90a:f68f:b0:35d:a03b:ab5e])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:52c3:b0:35d:a861:36de
 with SMTP id 98e67ed59e1d1-35de691b394mr22211390a91.24.1775669177699; Wed, 08
 Apr 2026 10:26:17 -0700 (PDT)
Date: Wed, 08 Apr 2026 17:24:46 +0000
In-Reply-To: <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-0-718f45eb7c75@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-0-718f45eb7c75@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775669168; l=4632;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=9j+Yjxv5DCIhDgqhSAFcOR8cdCu2/7Gl8VDuHjhEuMY=; b=ZLj3IPnlSz73RcVt/W7CdlvSDsYMGQCljZ+P1jxfdDIyI2haYYqfl7EVXP3SrZ7hpSAi0brzc
 aAD0ijgQuUJD3pVUZ4XpVhZmt5xnWRUQ+TjBbKyJ7ygMxyHCoLl8kxe
X-Mailer: b4 0.14.3
Message-ID: <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-5-718f45eb7c75@google.com>
Subject: [PATCH RFC v3 5/7] mm: selftests: Add shmem into memory failure test
From: Lisa Wang <wyihan@google.com>
To: Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: rientjes@google.com, seanjc@google.com, ackerleytng@google.com, 
	vannapurve@google.com, michael.roth@amd.com, jiaqiyan@google.com, 
	tabba@google.com, dave.hansen@linux.intel.com, Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="utf-8"

Add a shmem memory failure selftest to test the shmem memory failure is
correct after modifying shmem return value.

Test that
+ madvise() call returns 0 when the poisoned shmem page is clean
+ trigger a SIGBUS when the poisoned shmem page is dirty
+ trigger another SIGBUS when the poisoned shmem page is fault-in again.

Signed-off-by: Lisa Wang <wyihan@google.com>
---
 tools/testing/selftests/mm/memory-failure.c | 109 +++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/memory-failure.c b/tools/testing/selftests/mm/memory-failure.c
index 3d9e0b9ffb41..eb3f8d98f6c9 100644
--- a/tools/testing/selftests/mm/memory-failure.c
+++ b/tools/testing/selftests/mm/memory-failure.c
@@ -30,9 +30,14 @@ enum result_type {
 	MADV_HARD_ANON,
 	MADV_HARD_CLEAN_PAGECACHE,
 	MADV_HARD_DIRTY_PAGECACHE,
+	MADV_HARD_CLEAN_SHMEM,
+	MADV_HARD_DIRTY_SHMEM,
 	MADV_SOFT_ANON,
 	MADV_SOFT_CLEAN_PAGECACHE,
 	MADV_SOFT_DIRTY_PAGECACHE,
+	MADV_SOFT_CLEAN_SHMEM,
+	MADV_SOFT_DIRTY_SHMEM,
+	READ_ERROR,
 };
 
 static jmp_buf signal_jmp_buf;
@@ -165,17 +170,21 @@ static void check(struct __test_metadata *_metadata, FIXTURE_DATA(memory_failure
 	case MADV_HARD_CLEAN_PAGECACHE:
 	case MADV_SOFT_CLEAN_PAGECACHE:
 	case MADV_SOFT_DIRTY_PAGECACHE:
-		/* It is not expected to receive a SIGBUS signal. */
-		ASSERT_EQ(setjmp, 0);
-
+	case MADV_SOFT_DIRTY_SHMEM:
 		/* The page content should remain unchanged. */
 		ASSERT_TRUE(check_memory(vaddr, self->page_size));
+	case MADV_HARD_CLEAN_SHMEM:
+	case MADV_SOFT_CLEAN_SHMEM:
+		/* It is not expected to receive a SIGBUS signal. */
+		ASSERT_EQ(setjmp, 0);
 
 		/* The backing pfn of addr should have changed. */
 		ASSERT_NE(pagemap_get_pfn(self->pagemap_fd, vaddr), self->pfn);
 		break;
 	case MADV_HARD_ANON:
 	case MADV_HARD_DIRTY_PAGECACHE:
+	case MADV_HARD_DIRTY_SHMEM:
+	case READ_ERROR:
 		/* The SIGBUS signal should have been received. */
 		ASSERT_EQ(setjmp, 1);
 
@@ -260,6 +269,20 @@ static int prepare_file(const char *fname, unsigned long size)
 	return fd;
 }
 
+static int prepare_shmem(const char *fname, unsigned long size)
+{
+	int fd;
+
+	fd = memfd_create(fname, 0);
+	if (fd < 0)
+		return -1;
+	if (ftruncate(fd, size) < 0) {
+		close(fd);
+		return -1;
+	}
+	return fd;
+}
+
 /* Borrowed from mm/gup_longterm.c. */
 static int get_fs_type(int fd)
 {
@@ -356,4 +379,84 @@ TEST_F(memory_failure, dirty_pagecache)
 	ASSERT_EQ(close(fd), 0);
 }
 
+TEST_F(memory_failure, dirty_shmem)
+{
+	int fd;
+	char *addr;
+	int ret;
+
+	fd = prepare_shmem("shmem-file", self->page_size);
+	if (fd < 0)
+		SKIP(return, "failed to open test shmem-file.\n");
+
+	addr = mmap(0, self->page_size, PROT_READ | PROT_WRITE,
+		    MAP_SHARED, fd, 0);
+	if (addr == MAP_FAILED) {
+		close(fd);
+		SKIP(return, "mmap failed, not enough memory.\n");
+	}
+	memset(addr, 0xce, self->page_size);
+
+	prepare(_metadata, self, addr);
+
+	ret = sigsetjmp(signal_jmp_buf, 1);
+	if (ret == 0)
+		ASSERT_EQ(variant->inject(self, addr), 0);
+
+	if (variant->type == MADV_HARD) {
+		check(_metadata, self, addr, MADV_HARD_DIRTY_SHMEM, ret);
+		ret = sigsetjmp(signal_jmp_buf, 1);
+		if (ret == 0)
+			FORCE_READ(*addr);
+		check(_metadata, self, addr, READ_ERROR, ret);
+	} else {
+		check(_metadata, self, addr, MADV_SOFT_DIRTY_SHMEM, ret);
+	}
+
+	ASSERT_EQ(munmap(addr, self->page_size), 0);
+
+	ASSERT_EQ(close(fd), 0);
+	cleanup(_metadata, self, addr);
+}
+
+TEST_F(memory_failure, clean_shmem)
+{
+	int fd;
+	char *addr;
+	int ret;
+
+	fd = prepare_shmem("shmem-file", self->page_size);
+	if (fd < 0)
+		SKIP(return, "failed to open test shmem-file.\n");
+
+	addr = mmap(0, self->page_size, PROT_READ | PROT_WRITE,
+		    MAP_SHARED, fd, 0);
+	if (addr == MAP_FAILED) {
+		close(fd);
+		SKIP(return, "mmap failed, not enough memory.\n");
+	}
+	FORCE_READ(*addr);
+
+	prepare(_metadata, self, addr);
+
+	ret = sigsetjmp(signal_jmp_buf, 1);
+	if (ret == 0)
+		ASSERT_EQ(variant->inject(self, addr), 0);
+
+	if (variant->type == MADV_HARD) {
+		check(_metadata, self, addr, MADV_HARD_CLEAN_SHMEM, ret);
+		ret = sigsetjmp(signal_jmp_buf, 1);
+		if (ret == 0)
+			FORCE_READ(*addr);
+		check(_metadata, self, addr, READ_ERROR, ret);
+	} else {
+		check(_metadata, self, addr, MADV_SOFT_CLEAN_SHMEM, ret);
+	}
+
+	ASSERT_EQ(munmap(addr, self->page_size), 0);
+
+	ASSERT_EQ(close(fd), 0);
+	cleanup(_metadata, self, addr);
+}
+
 TEST_HARNESS_MAIN

-- 
2.53.0.1213.gd9a14994de-goog

