Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011825;
	b=NKdwj0UbcK1FbhyoS6hRAENuxQa6YQBEsUJVvXpNf9x5JqkakryQzJ+1asmdG/gs+lHu
	 NKrtcs619VI5ODm5NdT4TDcMZPgOz2OT/tDi5LQhTouJUZ4H8Faw2dyHb9wlN0/Aay8iC
	 5+I3tRQUtyjFO5hPS6e+oeANRzVrNFBWlJGwfGlESyFyMlAS2UOYDTIeCwR1rAbexyhnD
	 wC/8k06ZruE7ZyLrhXnym3mgWISSjYP/U3/nkK2UHWzTngIKBI8I/VRNJvNgshpG3TzyR
	 XsIH/gqFVyNqWcX14SmP9KbDxAcSN28BS0RRe+BQJ3ZG9RD7KSDV9yatWoBkAao8E0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011825;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=WEsvWJrtZKFuRaNPE0dZ9EmVrGX9PP233mRUy4dzRbk=;
	b=q29t/nh/bcApSc2vmZMuEOuR3Edf5plqhiZMf+66j3jl7csm9meXUPD3Ui+79ozH/qbd
	 v6CCqAZtbikK3oRIAuVt3Ls4C/MLr2FFTVS97ANeGny/UQbdSM7hFDrZz0wIUVCCAeodh
	 zumw2davyUkwR7SWldBb0FtcuGpHzS93ta/x7v2So97OINBrH3V8zHs0TfF537stKJLze
	 G9YTDrEhM3tEpAGqZ7FoKtQNqPApg5MGXgBJaulv2XwrzRi3t3fFb8Tvpz5ISyWT7Y7Yy
	 H0Q/0xtwhKZ4cRi2HcamAMndDRsq1Fi+iBcHbivc3UkYqlT3OFN4Ayn7MTTOZYFHd9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JhbzNiix;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B116083611;
	Sat,  7 Nov 2026 00:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JhbzNiix
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011818;
	b=LQq13lZx+sdZvJz5hV0vhqPaWhKazQtEJtF/YdBvmS+jXpfC38I3fuX8LbgI0cfBSa8O
	 i2O3Eo2v8vnZ0O+mKpWd4VRDEkj1UWVeGDTQGxxnOaWUKL9t82HbxduC1NDTZ4LMI7j5Q
	 QzeQO0idOvt+ruCOicr+VL/q7Az9OWpoz9/AfQrI33JgEbXDKaLBGIWe6luWlsy1xwIum
	 BCW/KCUWE7g1iing5sMEQ3FmCFeMyPXLsKzYnt09tcYeLS2nzuVa2pzq91W68Dc0289iC
	 Ow8QwVM+VGjNDX0IM8GNer7BkZwE83XUwOWRNEIrcb+XYT1OkH+jmNhjuffdi0QkIRQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011818;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=WEsvWJrtZKFuRaNPE0dZ9EmVrGX9PP233mRUy4dzRbk=;
	b=tTRHieWCp9iQTGVHmjJVrmhwJ1DQHhCwWnR5vtFJ4AYKdxeifkft0a3IkcNJOj94yKKL
	 yvN4bJi3lB61m53NcEh/LOVjC8NXr82mPoDhZcgTLnhEhPRzLhwjG7cjvCBKDT3eUObx7
	 mO5FEZrNMO56O1J7L2/sBMESnIaH7zIDBDEgglPBCGZWPt+mJfu50+Qy4E6wqqJISwCVu
	 v0Ks2vk2hGuQmWlOd972egztZuk0ZnWLsHkvF7Az4cQWWI93lS/fjsrk81mjo6y9tSslJ
	 vZP9AMYQcz1ROW2OKGSJgaKxqojzvN148UPp46Ui5zk70fqLAPwM52XLCGVdbh1Oj9Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8E1F51F00923;
	Sat,  7 Nov 2026 00:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011818;
	bh=WEsvWJrtZKFuRaNPE0dZ9EmVrGX9PP233mRUy4dzRbk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=JhbzNiixOQpWLus21oLO1FWIRUOevDOFjpyEjgPXYjOFKaY2ZAJxqPxOdwvmMH1wU
	 +cpIgzxWwgtrCL7j+pE0Mq1LzoK8ajN4SCA7wWcHMANq+gfs+4J9ERmIga3yfxoBej
	 KGisCr09zVNewGg5/4CTmRJpt7nf1be806cO+g0zRUR+PuHRMB/qb/idCaRczpf2f6
	 YbLl7vnknkt+1OP0Ehl9PWYiebzNo59u4jTqiTG1g6omcgIMNnCsOqA7xZk+OFgTRg
	 06hcBdmoWtJpESakP+xgdJ5dbgtaRJ0g/hLuxr67hujc4MDp3u6CKyNEFmBVE01+cF
	 nUFJj4Dgs8Mig==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 00CDC47950;
	Sat,  7 Nov 2026 00:36:54 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:36:49 -0800
Subject: [PATCH RFC v3 15/88] KVM: selftests: Test memory allocation
 against shared tmpfs resource pool
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261106-gmem-alternative-providers-v3-15-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
In-Reply-To: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
To: Alexey Kardashevskiy <aik@amd.com>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 David Hildenbrand <david@kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
 Fred Griffoul <fgriffo@amazon.co.uk>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jianxiong Gao <jxgao@google.com>, 
 John Starks <John.Starks@microsoft.com>, 
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Sean Christopherson <seanjc@google.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Tarun Sahu <tarunsahu@google.com>, Vishal Annapurve <vannapurve@google.com>, 
 Xu Yilun <yilun.xu@linux.intel.com>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=1933;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=0jopPByLNEPBSe0/be0Wm6QK3iE1kkpZwMF93kEQ4eo=;
 b=ScmyeLGXcUc8o/vmZGhEcaEmxpTM+jdVNW4rYAIxNVAiMpGRVTplAEa7BJbxPZT141BmrEWN9
 wgmFQ71KphQBC4nTm17TPFSsfUH0DlS3aqYVRFiQJyH2q7Jt9E6TtfG
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Verify that allocating folios in multiple guest_memfd instances sharing
the same tmpfs resource pool consumes blocks from the underlying pool as
reported by filesystem statistics.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 310a45b6656aa..639b1b0c204ed 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -18,6 +18,7 @@
 #include <sys/mount.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/statvfs.h>
 
 #include "kvm_syscalls.h"
 #include "kvm_util.h"
@@ -564,7 +565,8 @@ static void test_resource_fd_tmpfs_huge(struct kvm_vm *vm)
 
 static void test_resource_fd_tmpfs_shared_pool(struct kvm_vm *vm)
 {
-	int pool_fd, fd1, fd2;
+	int pool_fd, fd1, fd2, ret;
+	struct statvfs svfs;
 	struct stat st1, st2;
 
 	pool_fd = create_tmpfs_pool_fd("never", true, page_size * 2);
@@ -590,6 +592,18 @@ static void test_resource_fd_tmpfs_shared_pool(struct kvm_vm *vm)
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
2.56.0.455.g6c5a503b38-goog


