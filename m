Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5D33B0ADC
	for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787514082; cv=none; b=JehfrEmG12dv8tGjQxqCMHmW8RaJfe16CM9zKL393SW8znEd7WUFuYrLEXUomlAZcOaJNkiZcfMSOAkWZvQ1Fm4MdeGkoJfVKHnkj6ZsptHkr7eCXJrRwDd2zGIIAizKEtpmkmuT9PHiuZ9Hblp4Pa9N4UbW2L3oeu5WFd6byq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787514082; c=relaxed/simple;
	bh=6H/urXyqo0R+eZVEoqxfnPvxrvulOJIGV7ZBXfbSyS8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JvJlnVyLaHttAeADBZ12yeYKhnzMHJj1BlIwG1Tj/NNPSpIiiiwp/GY0m7qh/auMT9hf/A+K6yq99gYbIvnbZTnYbPq9KN9YibBrP1Efeay11EaAMuS+qyIX46bJAIyUrkFOflzfkDgs0xaKsUIlyOsP8sL6CMQbuFqDU5St8bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vob8eWkT; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vob8eWkT"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc73f47bdcso33896835ad.3
        for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 12:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787514079; x=1788118879; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KyxwXzW/e6yZkOmQq00SGFMBQuYBpdvqua93AJie1gM=;
        b=vob8eWkT74uhbwnbqDbh52jxxsrNQplHLbXUlwCMCEWsYqPd4uFhJxpRAQlPzWF52d
         gDgIhxUJMlKXkvQW76sizXjLF2r/t3FCjDphREX/k9Ua8qMajo+9juRlZEV36i0xu1sd
         IaIYIQus5n2aA9wui2LncdszA3ANE5VLONohG6BZRCBWxLbR6Az5kpR2XtXhZvI1DISQ
         EU2yO6xdZRWpikHiThnlDNBKdQ+XEUBmcLpCn3UFre0xNV8w9oVpVeR/fcETdmyjomjx
         3E+2J+iNlNYTuPGonikygzlvhqeWoyO5X7IrVes0mIEMdCVKXam2QD2TepQfM8fxpFGF
         QMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787514079; x=1788118879;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KyxwXzW/e6yZkOmQq00SGFMBQuYBpdvqua93AJie1gM=;
        b=IxSPVasjDAf9UDXaQ2mRM1AxXeVTf1QICNVkUBqsVdC6+sY9nj6CIhagJ2Db8m005Z
         3qNpv177WLjHCtkGqW8rXCtjpgpJ0aB/gjP8JxORqPUSNg/XOqsslce6dfiuM5zBAWC9
         NAmjz/3lDfJ+tjA2SGtU0sGSLGM/2DliNnDv0ngb5PaEjaCMYeGwVAUDA4J0rNGGdnbZ
         XYkLcpZfDoEi5btXAMG6zRpd3iyMAdZTXdm+3lX9NqdmitUsisEtdJkfCrO7JmOvptQx
         Cyh8y3JbI+N+Xr28Fl6DAgvZKpvbzxvQX48Tr2N8XGFIt64qd7lrW7zrwRAjXgUrh5cT
         Qu8A==
X-Forwarded-Encrypted: i=1; AHgh+RqAIR7S7cvgyLPBZvfBfpt7m0WyTR3N3rqWs/xBGuh7eInasWKhkS04tqMO9Hvl+WKDKrI=@vger.kernel.org
X-Gm-Message-State: AFuF++kLZNlvt9HqexnP6EnqGMvfv///UyQSC4Iv+mgYPnBzmAI6+EsK
	GKUd62Suum1Q87H3QOUyKKXq8uTJUXop3Lw9TBinKRD+5Q07YT8woTcXoYlw3v1VpvA5mHIY4DX
	Xqbwbjg==
X-Received: from plho9.prod.google.com ([2002:a17:903:23c9:b0:2c9:a5a0:a677])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f693:b0:2d3:7c58:b0e1
 with SMTP id d9443c01a7336-2d64a9a6dadmr341194815ad.0.1787514079265; Sun, 23
 Aug 2026 12:41:19 -0700 (PDT)
Date: Sun, 23 Aug 2026 19:40:58 +0000
In-Reply-To: <20260823-memory-failure-mf-delayed-fix-v5-0-d97a5703e45a@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260823-memory-failure-mf-delayed-fix-v5-0-d97a5703e45a@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787514072; l=5373;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=6H/urXyqo0R+eZVEoqxfnPvxrvulOJIGV7ZBXfbSyS8=; b=cfUM1tjzhEk88mj+/xQKY18Tt+IgfKj4f4BWzGxytwJR3RDp3E/1P4wLOfG3mtNtrmLJ7RP7q
 DWeg3JebmrBC9/hzRqFcen3nbsG48on5ZN3oWRga2CjGRq3Ol71dSNW
X-Mailer: b4 0.14.3
Message-ID: <20260823-memory-failure-mf-delayed-fix-v5-5-d97a5703e45a@google.com>
Subject: [PATCH v5 5/5] mm: selftests: Add shmem into memory failure test
From: Lisa Wang <wyihan@google.com>
To: Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, 
	Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Rik van Riel <riel@redhat.com>, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>
Cc: rientjes@google.com, seanjc@google.com, ackerleytng@google.com, 
	vannapurve@google.com, michael.roth@amd.com, jiaqiyan@google.com, 
	tabba@google.com, dave.hansen@linux.intel.com, Lisa Wang <wyihan@google.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
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

Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 tools/testing/selftests/mm/memory-failure.c | 118 +++++++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/memory-failure.c b/tools/testing/selftests/mm/memory-failure.c
index 1a5a32e22cce..5b26f0c44664 100644
--- a/tools/testing/selftests/mm/memory-failure.c
+++ b/tools/testing/selftests/mm/memory-failure.c
@@ -20,6 +20,10 @@
 
 #include "vm_util.h"
 
+#ifndef fallthrough
+# define fallthrough __attribute__((__fallthrough__))
+#endif
+
 enum inject_type {
 	MADV_HARD,
 	MADV_SOFT,
@@ -29,9 +33,14 @@ enum result_type {
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
@@ -157,17 +166,22 @@ static void check(struct __test_metadata *_metadata, FIXTURE_DATA(memory_failure
 	case MADV_HARD_CLEAN_PAGECACHE:
 	case MADV_SOFT_CLEAN_PAGECACHE:
 	case MADV_SOFT_DIRTY_PAGECACHE:
-		/* It is not expected to receive a SIGBUS signal. */
-		ASSERT_EQ(setjmp, 0);
-
+	case MADV_SOFT_DIRTY_SHMEM:
 		/* The page content should remain unchanged. */
 		ASSERT_TRUE(check_memory(vaddr, self->page_size));
+		fallthrough;
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
 
@@ -263,6 +277,20 @@ static int prepare_file(const char *fname, unsigned long size)
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
@@ -355,4 +383,88 @@ TEST_F(memory_failure, dirty_pagecache)
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
+	if (!ret && !self->injection_attempted) {
+		self->injection_attempted = true;
+		ASSERT_EQ(variant->inject(self, addr), 0);
+	}
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
+	if (!ret && !self->injection_attempted) {
+		self->injection_attempted = true;
+		ASSERT_EQ(variant->inject(self, addr), 0);
+	}
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
+}
+
 TEST_HARNESS_MAIN

-- 
2.55.0.766.g2966f0265a-goog

