Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D597D3DE427;
	Mon, 18 May 2026 07:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088212; cv=none; b=XoN4LgaaHJKQvAzgcuPqrXLNu9aW5Hy5/o1/XZOn6TkkiB/BF4TI+/DG+yp3TdbJVXbVQiVixJOyMlp59WtEGyiKql4wMygyXbGnKxxCzjNNZ5CPxbaAIW6gNgEuMe/S2Ev0iaR6FfoOvQqy+A9R1MC2zB9KnF31t/0ftyuFQo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088212; c=relaxed/simple;
	bh=YViOcVEwFb+NEqT11dAFAGaXos+RyhvLp/NZnEOWgMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDWeIgLgEDK9vCCKY/VZub+cqWD03fy3JUXnH9njjDy1sSZ/bCfQrPzd7XKOChdCZtY6ZFQ/DFLCVun2z6NOzdqA3qnaCxLrObAJRQpZu0MRqwO12AVsQVRPtntKtq1MdKupuObUC6HB0yerEW81saX45V7IWWdJGEW91cq+LJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QQx25NMn; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QQx25NMn"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779088203; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9UUz9cxNvFJXw97pxpxZYwOxVNQRD3Z1R4MivFHtRY0=;
	b=QQx25NMnaO1dV/GWH4zPU+5mKw9vZOoGQFihtDq2rCQNZTIVBiFCr8tNysKGyWBW22jhuITRh4pzIBIkw/Ks2vH6krZ823p1RX+lFAiWuBe/wM7lRGlh6diM70HaWYoCypqaBgV6/6WGzMEXXoPvk3clu0kPZfzqspnhukxABF8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=zongyao.chen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X34Snsb_1779088201;
Received: from localhost(mailfrom:ZongYao.Chen@linux.alibaba.com fp:SMTPD_---0X34Snsb_1779088201 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 18 May 2026 15:10:01 +0800
From: ZongYao.Chen@linux.alibaba.com
To: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Chao Peng <chao.p.peng@linux.intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
	Zongyao Chen <ZongYao.Chen@linux.alibaba.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] KVM: selftests: Test guest_memfd binding overlap without GPA overlap
Date: Mon, 18 May 2026 15:09:43 +0800
Message-ID: <20260518070943.2091287-3-ZongYao.Chen@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518070943.2091287-1-ZongYao.Chen@linux.alibaba.com>
References: <20260518070943.2091287-1-ZongYao.Chen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>

The guest_memfd binding overlap test recreates the deleted slot with GPA
ranges that overlap the still-live slot.  KVM rejects those attempts from
the generic memslot overlap check before reaching kvm_gmem_bind(), so the
test can pass even if guest_memfd binding overlap detection is broken.

Recreate the slot at its original, non-overlapping GPA and use guest_memfd
offsets that overlap the front and back halves of the other slot's binding.
Expand the guest_memfd so the back-half case remains within the file size.

Fixes: 2feabb855df8 ("KVM: selftests: Expand set_memory_region_test to validate guest_memfd()")
Signed-off-by: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>
---
 .../testing/selftests/kvm/set_memory_region_test.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index 9b919a231c93..15607e0bec90 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -510,7 +510,7 @@ static void test_add_overlapping_private_memory_regions(void)
 
 	vm = vm_create_barebones_type(KVM_X86_SW_PROTECTED_VM);
 
-	memfd = vm_create_guest_memfd(vm, MEM_REGION_SIZE * 4, 0);
+	memfd = vm_create_guest_memfd(vm, MEM_REGION_SIZE * 6, 0);
 
 	vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_GUEST_MEMFD,
 				   MEM_REGION_GPA, MEM_REGION_SIZE * 2, 0, memfd, 0);
@@ -526,19 +526,19 @@ static void test_add_overlapping_private_memory_regions(void)
 	vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_GUEST_MEMFD,
 				   MEM_REGION_GPA, 0, NULL, -1, 0);
 
-	/* Overlap the front half of the other slot. */
+	/* Overlap the front half of the other slot's guest_memfd binding. */
 	r = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_GUEST_MEMFD,
-					 MEM_REGION_GPA * 2 - MEM_REGION_SIZE,
+					 MEM_REGION_GPA,
 					 MEM_REGION_SIZE * 2,
-					 0, memfd, 0);
+					 0, memfd, MEM_REGION_SIZE);
 	TEST_ASSERT(r == -1 && errno == EEXIST, "%s",
 		    "Overlapping guest_memfd() bindings should fail with EEXIST");
 
-	/* And now the back half of the other slot. */
+	/* And now the back half of the other slot's guest_memfd binding. */
 	r = __vm_set_user_memory_region2(vm, MEM_REGION_SLOT, KVM_MEM_GUEST_MEMFD,
-					 MEM_REGION_GPA * 2 + MEM_REGION_SIZE,
+					 MEM_REGION_GPA,
 					 MEM_REGION_SIZE * 2,
-					 0, memfd, 0);
+					 0, memfd, MEM_REGION_SIZE * 3);
 	TEST_ASSERT(r == -1 && errno == EEXIST, "%s",
 		    "Overlapping guest_memfd() bindings should fail with EEXIST");
 
-- 
2.47.3

