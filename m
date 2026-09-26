Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B42315D32;
	Sat, 26 Sep 2026 00:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790383852; cv=none; b=LWAjWqkiKSmn4wQeH8pxzSM96Cd9+vqL4qKQSCNmWRKXBLY96ITlfe1AAppiRWOcoc69fpLtg9MLwyJv1OCslPQrZ6F04hjxe66dxhbRlPkiku93z/Vb+PJTOQok4kdQACFhzy3IL8TbmtHUjxc2dzsSSze1l0voq6hk09Ls7ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790383852; c=relaxed/simple;
	bh=bPm6ZaQk+kt/I6sAAcBSCrNyHmK+Z/anevzTBBSqifg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DQsSzFmoTrH2khSiFsL2zOvBSo4I4AmNoo/oJPc4SeoZt9S3QxZx4w+XJM6CcxMbeiPex18T911CxHmWBMHNRiXEmMktOQSE6wDIYfgk1Uo5+wd7Z5eHC5vfXo/KW5vSAcXKyDfTPfgHqHawpPMw4mgl81h7jpQpQyfBlmB+RzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozaTqiC4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozaTqiC4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC293C2BCF6;
	Sat, 26 Sep 2026 00:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790383852;
	bh=bPm6ZaQk+kt/I6sAAcBSCrNyHmK+Z/anevzTBBSqifg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ozaTqiC4V04B2iYpKwpfal2K3UJdgWQA4ZqQ1uG4CfkeORwBYm5Q8pVkBoFeEjCYa
	 31bhdvH9XymD1cJ3q2E9bjEL8HPa5miX+cBv7814Klm6idQrgjfv2h213ZL0BTCjOX
	 4WkisO1VmqA8dnmCGJR8oMYvp/IC/77hzAt4FtCxXinokR/ngltV1sofyEUNDOWHjq
	 OdnkE72IJZ4+QPUDe01xTDvaZNqURoBQ1GOldHbEMCsaCcqsUVQjgUJGYDn20M2VtH
	 TaQJ+pBt9WP0Ifx2KG7c7PP/VcOQ8ije+Pr/YWp9siTGQNXjT8ybqAxEfR3pp7T+xU
	 ghTpLKWMkQ5Rw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B35C9832F;
	Sat, 26 Sep 2026 00:50:51 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 25 Sep 2026 17:50:57 -0700
Subject: [PATCH RFC 10/17] KVM: selftests: Test rejection of hugepage tmpfs
 mounts
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-gmem-tmpfs-backend-v1-10-d36159822d18@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790383850; l=1598;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=uHRD08KWJ33IfEmWlgc0kkQt05Gpcc9eJdkNLri4xT0=;
 b=KVKUJLxxCYvtA5PDFe3Kp6RxITzYbR1FXKIlwN3Ce6FqDa1idF+AAVjWn1CGwjlIZcUQZUsTe
 xcWXqn7k6exC4aW6OmpLcFJPBcw5uw8u3PZ1DNLU6V+yKSf5vxzxbsK
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Ensure that guest_memfd creation fails with -EINVAL when passed a tmpfs
resource pool mount descriptor that has huge pages enabled, as required
by the tmpfs guest_memfd provider implementation.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 5d017164d7b45..e8199ed17b0f8 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -526,6 +526,21 @@ static void test_resource_fd_tmpfs_swap(struct kvm_vm *vm)
 	close(pool_fd);
 }
 
+static void test_resource_fd_tmpfs_huge(struct kvm_vm *vm)
+{
+	int pool_fd, fd;
+
+	pool_fd = create_tmpfs_pool_fd("always", true, page_size);
+
+	fd = __vm_create_guest_memfd_resource(vm, page_size,
+					      GUEST_MEMFD_FLAG_USE_RESOURCE,
+					      pool_fd);
+	TEST_ASSERT(fd < 0, "guest_memfd with huge-enabled tmpfs should fail");
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	close(pool_fd);
+}
+
 #define ____gmem_test(__test, __vm, __flags, __gmem_size, args...)	\
 do {									\
 	int fd = vm_create_guest_memfd(__vm, __gmem_size, __flags);	\
@@ -588,6 +603,7 @@ static void test_guest_memfd(unsigned long vm_type)
 	test_resource_fd_unsupported_fs(vm);
 	test_resource_fd_tmpfs_file(vm);
 	test_resource_fd_tmpfs_swap(vm);
+	test_resource_fd_tmpfs_huge(vm);
 
 	__test_guest_memfd(vm, 0);
 

-- 
2.56.0.rc1.315.gc6ed9934b7-goog


