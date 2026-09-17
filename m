Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F2F4F3EA3
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677916; cv=none; b=ZgamEQWknSA2Fz2gipd8u8Pn+BLFxx1b9nWPXjcLVlz0V+U+tnlejFKQcXtAUJzhvWCqVPOvZF3vWlLmpeb3PxteMXrXz9e7xQNqH/MbZxqavqCJxU1bQqHa/zlVgKMv9wLCChJ1MNjdOxBIE6A8ruQDzqa5yyV9yJp8PY1kOHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677916; c=relaxed/simple;
	bh=oCZbQTSw2Yyl7B5BQDviNb8o0kDmMbfd/szlr3bi9Xc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MUE8I0HYPGHM9ythf3CdHebd/Z8D8AC4Ocv9C5LwK5/xm1hYIs6KuLdR+aI5+7+P7K90cVBXJSO1h/ssjCMVoVzJInSZl09/xA2CEwB+sinzLBPlUGThhCI5lle9/+kE6vnBC7PEhSHsNStL8w33AHAC4E5Nf8lXbClD3Ia8Kbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bab+nJ/0; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bab+nJ/0"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2db3d832827so705125ad.2
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 13:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789677912; x=1790282712; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GhFaT1pWqaSYrZ5igcNnVG6b2J5qZxAlydhAJEnR0ZM=;
        b=Bab+nJ/0V6jpXMC97e+ZPo3Xllxynjs3pqo0pZPG2wu4/HhmLCvJVTaePNSNCmEb5Y
         J7bVslQaF3VyYZ0opid7LGYexvYs32CCdHPZ6zfI2RFvK3KnUdqJxUYyrzlLZX+KzMHY
         7wES20uOL7attywKQWSMC3WmfGv8qFHFGU0lw8i1FbLYu9u2eokdQ3gRy4WIfvUFVhZf
         hzdKTUKb0sGV7km2WczuDF2RXxo7qZ7eYPKOFv+B8RE1q+KoZbghpTpn1lt/Zo/1bEOd
         jmDTBV5wTsmXTy94ULHVjw89nKnT3khP4cb2+ED/7n1wHI1H0bEcXb+mR6VmNWSOqNPW
         dEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789677912; x=1790282712;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GhFaT1pWqaSYrZ5igcNnVG6b2J5qZxAlydhAJEnR0ZM=;
        b=jSkFX+wEfPzMhPS3WwjH9yzTnlpV+VlNf6PHNCm/LXmtjvHPkvWZi/ELGsQrzZzWSH
         K019xYDR1wGaJI0uUTpfN148yVN7g2cPlw19ezvxjuwqpXYt9BKG2dhuSiodf410oJC/
         z1UUM9WHWeRjNwmn4ib8oY0IrJNStVf7VyQQ3FRMEM8wFUbZsE/pVoJBEEzxPIwG1cgE
         3Qgxi9bm1eLK3CK1RYkwgKz9O1AAmesZTZL/DbjldlTKyOotc7On/rOKoZ1Kc/Bw/1iC
         Q8x0caCZB2sJvrySkdcqnEdT1EbMPaH2UnVZXwAJyQr6DwXzp4lT196Nlw+1vRWLp1go
         upvA==
X-Forwarded-Encrypted: i=1; AKwUvBzxFkXApjHirN/Ex4dhn1zFGbIIsGwY10uaSuBKQpmLvBDXuSEl3Nqm/F9wjgk2kpCfMzA=@vger.kernel.org
X-Gm-Message-State: AFuF++kceVz+mY71mNC1tLr0e7WmGQo5faYr634/gbnEOfyjcJsbraoL
	OYE8g39hS5MZaJ2NfthyxsqpP81NDqdUpzwN5Twug+yK1REKLNeW/IBupowo2V5z6KfdV1Cdl6X
	cUlz5sg==
X-Received: from pjzm16.prod.google.com ([2002:a17:90b:690:b0:39d:9b47:4551])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:224c:b0:39b:61f1:8032
 with SMTP id 98e67ed59e1d1-39e54e7c18emr677747a91.16.1789677912150; Thu, 17
 Sep 2026 13:45:12 -0700 (PDT)
Date: Thu, 17 Sep 2026 20:43:51 +0000
In-Reply-To: <20260917-memory-failure-mf-delayed-fix-v6-0-4b00856b5364@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260917-memory-failure-mf-delayed-fix-v6-0-4b00856b5364@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789677906; l=5191;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=oCZbQTSw2Yyl7B5BQDviNb8o0kDmMbfd/szlr3bi9Xc=; b=2sjWrqtdOcssMiZtTNK//2RmRxIpXb5yhivrXeyIB1v0t2FyBFn36kmbEWN2P8Ax0XR7UqVYg
 PdjG1ilLGPiDeSDyMaCfp7cPG5UuHvIdRtwg6rJOtaSMWsW7wX2rc6R
X-Mailer: b4 0.14.3
Message-ID: <20260917-memory-failure-mf-delayed-fix-v6-5-4b00856b5364@google.com>
Subject: [PATCH v6 5/5] mm: selftests: Add shmem into memory failure test
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
 tools/testing/selftests/mm/memory-failure.c | 114 +++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/memory-failure.c b/tools/testing/selftests/mm/memory-failure.c
index 1a5a32e22cce..d5d17a262c00 100644
--- a/tools/testing/selftests/mm/memory-failure.c
+++ b/tools/testing/selftests/mm/memory-failure.c
@@ -29,9 +29,14 @@ enum result_type {
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
@@ -157,17 +162,22 @@ static void check(struct __test_metadata *_metadata, FIXTURE_DATA(memory_failure
 	case MADV_HARD_CLEAN_PAGECACHE:
 	case MADV_SOFT_CLEAN_PAGECACHE:
 	case MADV_SOFT_DIRTY_PAGECACHE:
-		/* It is not expected to receive a SIGBUS signal. */
-		ASSERT_EQ(setjmp, 0);
-
+	case MADV_SOFT_DIRTY_SHMEM:
 		/* The page content should remain unchanged. */
 		ASSERT_TRUE(check_memory(vaddr, self->page_size));
+		/* FALLTHORUGH */
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
 
@@ -263,6 +273,20 @@ static int prepare_file(const char *fname, unsigned long size)
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
@@ -355,4 +379,88 @@ TEST_F(memory_failure, dirty_pagecache)
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
2.55.0.1082.g2b9226bbc0-goog

