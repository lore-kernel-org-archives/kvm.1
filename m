Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439E43BB11C
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780437372; cv=none; b=KRrn9T0pteu8NNL8VtSMiW/4OvMJ543pkiE+chyWFWkn91UQNyJ7nIttzRwLLGCVWV2+WjOXYSv/K9BokR4/fWqsUkAzMoehlbqz8r5QaxhOBSIFoL5p3hW36kDesAD/KCBu9yko8Rc7m1SgsJ3IHbq+jy343RgtrN1pnI3W3SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780437372; c=relaxed/simple;
	bh=ERS9n/C66Pu/CFQvxwGbdMovjGhnOPXiuO/oE3uJErA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LtT4xyAnnA0wByuwXeQwDgeJiMUguByoSbKvRc67rLIV9b4+poMgrjsOoTbES6+VDiFf1T3FclNM0u95J3UyA4+yMF9Rbq6nXOXF3taqCYHblXr8u3AiJmWgjXRaiIZh0n3iQ9FRvSXG66xSndcUOtdHudDJt+CVFLL+ORrTir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nShnSK9o; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nShnSK9o"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8422ca754d8so2787896b3a.1
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 14:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780437371; x=1781042171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PVk9IZSmeQ2ojFO9YakU9Uvjo4C4aXJx9fyWGDEUtbc=;
        b=nShnSK9oIb9Ut4FZZyGYi6Yjc5kBZyxSAQCdJ7pUvW/K/s181MOZZchyVg08bZvVF3
         SDw9KLiPm26ENxV6pyZpAdSvFf6CUx7nMPcERLo3risyGpE5saU/6Wm7Q9gwenqZKRfQ
         tmdPObCZkEwzZBQ83aUL67OVKJ1tL5xtaQa65yb5U0R+XGPs1+OQ2IO3t1YPpN2roPjw
         f4WgKID5jxHMZCE9H2djohvREGNmSr2cHDT0lokgltf25RT6G9bybmtIkyrczHvlRIEj
         uoPXTt7OfBEZkTy8c9Yioa1cNyRsn3coVNnul3gYYM8szLd2JORdCRgC8GN0VXTrTQHB
         vynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780437371; x=1781042171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PVk9IZSmeQ2ojFO9YakU9Uvjo4C4aXJx9fyWGDEUtbc=;
        b=QkYuTni6lyv4w8725PKeqMuamk3PqdLjsxskZyT5RGF9yjA3SXCm2aKXKe0f1Q8Jvt
         knh3kjfG29wJrDkEBHYHel6vFssELjm3YlQGqv5PKPg4pXNOmcFdjXgcsRHpsN+mnUx+
         E66xPvQq+bjKfMV4v5yem1fzR76MFgoKOOcSw4hgZ5NDGnN126Dh3y4cKqeNrnY3pgS4
         p7JOC065vpH3SSfTvwri5xc3qZPpGIrk1ZDIYv/gKYqMwv8htcP1Sjvt4lKOT9Rsdebp
         6QVeSDUPUxoadhHD8tdK9frEhsXpNgLNbfVyebv/3HmbyVLiQypA3l/AuDdBtfDYVe9t
         nhuA==
X-Forwarded-Encrypted: i=1; AFNElJ/lqoMzMwDVkuTvq5Q6mD/ZQpoW6fg9QBzaE7gbk0MEMGxmAlQ7i8mcNJ5bJdOT0R52iAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL/Bvxvi+Gs+5I8Gd87URsnWwwZpoVZsWr/8Of7lkZisizS4Op
	6JryhEsQfQJOybFbsSl6WOPdASZ0z01V6NSlqoNlRiOX772xpGXRle164jhFs97QRlMlwejzCgZ
	O+m+w4g==
X-Received: from pfih3.prod.google.com ([2002:a05:6a00:2183:b0:842:2674:ba4e])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4aca:b0:842:6e9f:9d3
 with SMTP id d2e1a72fcca58-84284f61a4cmr515894b3a.43.1780437370305; Tue, 02
 Jun 2026 14:56:10 -0700 (PDT)
Date: Tue, 02 Jun 2026 21:55:45 +0000
In-Reply-To: <20260602-memory-failure-mf-delayed-fix-v4-0-a5bc7db5a9b2@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602-memory-failure-mf-delayed-fix-v4-0-a5bc7db5a9b2@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780437363; l=5052;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=ERS9n/C66Pu/CFQvxwGbdMovjGhnOPXiuO/oE3uJErA=; b=gl04QDueWfY5Mz/UMSTqZqEfqFAcCz8GPZv3rivd+R/DZnODOzzs+ShfEwjBLFL8XbbcCoOEl
 EknEUQ6a+G2AsmhRcocPCnKsgzKYa/SK4ZFwcl1YJ+i0YPAHx/u9JBc
X-Mailer: b4 0.14.3
Message-ID: <20260602-memory-failure-mf-delayed-fix-v4-5-a5bc7db5a9b2@google.com>
Subject: [PATCH v4 5/7] mm: selftests: Add shmem into memory failure test
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

Specifically, test the expected behavior under various scenarios
combining page dirtiness (dirty vs clean) and failure types (hard vs
soft):
+ Dirty + Hard: Trigger a SIGBUS on injection, and trigger another
  SIGBUS when reading the page again.
+ Dirty + Soft: No SIGBUS is triggered, and the original value can be
  read successfully.
+ Clean + Hard: No SIGBUS is triggered on injection, but trigger a
  SIGBUS when trying to read the page again.
+ Clean + Soft: No SIGBUS is triggered, and the page can be read
  successfully.

Signed-off-by: Lisa Wang <wyihan@google.com>
---
 tools/testing/selftests/mm/memory-failure.c | 111 +++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/memory-failure.c b/tools/testing/selftests/mm/memory-failure.c
index 3d9e0b9ffb41..43949b3b3565 100644
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
@@ -356,4 +379,86 @@ TEST_F(memory_failure, dirty_pagecache)
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
+		/* Test the address accessability without check_memory(). */
+		FORCE_READ(*addr);
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
2.54.0.1013.g208068f2d8-goog

