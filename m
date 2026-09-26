Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AE032AABC;
	Sat, 26 Sep 2026 00:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790383852; cv=none; b=RQaT/eZBH80gia68JQe5aych7mFAdMhbZMdwoLNN/N5el1EvbsBf+PQjtB6G2COZpxwk4I/D2xhLA8hTOThKntIzRtii4CoxJUaXy78BnczMhv6o6zGVJB+A1cfEkvYpM1J7frM5iN2O+Tt1C2OyGj2sA+9c9g11CIoFGhUjlSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790383852; c=relaxed/simple;
	bh=n+q1qgFLiSwvjUPpDAXg+gMGkb9JtV4aKYDtoDohKlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tLaT+7x6//W36194JaQyf8iHtavuBh1IP0MwblwcQcjWQ0bjj5H8sK+ITAlqf0ftLhe2H/FdMLxo9kgpGB7eBy0HGlItcbgGuJJj3YM4YauZ4OI3TGjvAOI+WFUtp64jl0xHGaAoA66cPfpJVK7a4c2A+TGosYQUPRAyy4aypPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4ZJIXko; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4ZJIXko"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A991C2BCF4;
	Sat, 26 Sep 2026 00:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790383852;
	bh=n+q1qgFLiSwvjUPpDAXg+gMGkb9JtV4aKYDtoDohKlo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T4ZJIXkomUX+C339mTXSfpVBbkd+iDAy47mofvTXwI7dxotGESB6mJNaacxyB4JgV
	 R/0t6pjDCA2FY+ghcii20tO4VkIMmU3A6uGbUZ+AzTl2l1p2ns8f9iooHD72Fa8qsX
	 sdpRlb/xWk0Ps/CW36hYg8Rd4fS+V64iQ9ZmZYqsFvMX5X+3oyQLxMQv+vxWaaGVsq
	 otZ0pq92bdjhqVxf0jUiJU4DHl/Ws97djuhOohXuyW1I0cP7Vb3f+lBkdtAjYlcQVC
	 HUvIIAjExqjrmDzuy4cTZ+qtB0cxmKmEp7DZ8tbQDYZhnpK5vWjYAw5qVHouuHSJpj
	 9g9Ph5fEeKQPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A9BC9830E;
	Sat, 26 Sep 2026 00:50:52 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 25 Sep 2026 17:51:01 -0700
Subject: [PATCH RFC 14/17] KVM: selftests: Test memory allocation against
 shared tmpfs resource pool
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-gmem-tmpfs-backend-v1-14-d36159822d18@google.com>
References: <20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com>
In-Reply-To: <20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com>
To: Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan <shuah@kernel.org>, 
 vannapurve@google.com, erdemaktas@google.com, jxgao@google.com, 
 rientjes@google.com, fvdl@google.com, jthoughton@google.com, 
 tarunsahu@google.com, pratyush@kernel.org, fuad.tabba@linux.dev, 
 Gregory Price <gourry@gourry.net>, David Woodhouse <dwmw2@infradead.org>, 
 yan.y.zhao@intel.com, michael.roth@amd.com, suzuki.poulose@arm.com, 
 Christian Brauner <brauner@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Nicolin Chen <nicolinc@nvidia.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
 aik@amd.com, aneesh.kumar@kernel.org, Vlastimil Babka <vbabka@kernel.org>
Cc: kernel-team@android.com, kernel-team@meta.com, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790383850; l=1937;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=e5T0d60S1RJIK+yOTmGq9i0vT2WW1I1oApGjOS3UiOo=;
 b=9FIMY/6EtN+BUMK9CipyVOXFBib9h5+8+GiXMOwHojyWfqXUItP+KcJF14AQK4ZJmIOmh91rJ
 ZO/6zjGODO0B0t6LgIt14X3vvd4keOV4Nh9d0fwsEHcMg4dK1F0E3fr
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Verify that allocating folios in multiple guest_memfd instances sharing
the same tmpfs resource pool consumes blocks from the underlying pool as
reported by filesystem statistics.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 81311be059923..4610eeab39be6 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -19,6 +19,7 @@
 #include <sys/mount.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/statvfs.h>
 
 #include "kvm_syscalls.h"
 #include "kvm_util.h"
@@ -545,7 +546,8 @@ static void test_resource_fd_tmpfs_huge(struct kvm_vm *vm)
 
 static void test_resource_fd_tmpfs_shared_pool(struct kvm_vm *vm)
 {
-	int pool_fd, fd1, fd2;
+	int pool_fd, fd1, fd2, ret;
+	struct statvfs svfs;
 	struct stat st1, st2;
 
 	pool_fd = create_tmpfs_pool_fd("never", true, page_size * 2);
@@ -573,6 +575,18 @@ static void test_resource_fd_tmpfs_shared_pool(struct kvm_vm *vm)
 	TEST_ASSERT(st1.st_ino != st2.st_ino,
 		    "different guest_memfd instances should have distinct inodes");
 
+	ret = fallocate(fd1, FALLOC_FL_KEEP_SIZE, 0, page_size);
+	TEST_ASSERT(!ret, "fallocate on fd1 should succeed");
+
+	TEST_ASSERT(!fstatvfs(pool_fd, &svfs), "fstatvfs on pool_fd should succeed");
+	TEST_ASSERT_EQ(svfs.f_blocks - svfs.f_bfree, 1);
+
+	ret = fallocate(fd2, FALLOC_FL_KEEP_SIZE, 0, page_size);
+	TEST_ASSERT(!ret, "fallocate on fd2 should succeed");
+
+	TEST_ASSERT(!fstatvfs(pool_fd, &svfs), "fstatvfs on pool_fd should succeed");
+	TEST_ASSERT_EQ(svfs.f_blocks - svfs.f_bfree, 2);
+
 	close(fd2);
 	close(fd1);
 	close(pool_fd);

-- 
2.56.0.rc1.315.gc6ed9934b7-goog


