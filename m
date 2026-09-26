Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3483731AA92;
	Sat, 26 Sep 2026 00:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790383852; cv=none; b=h1yBo2JWgGEu7zSNQn/2TobfLuUVp678xR+JXKXJsUUo1ic9oX4u9DkcP6hjQ33Et4S2GYEESqIMWH+Aej5vJw8DewY9eWgWt1qKEKdznZ3cBt+PWMyfN2zPHkykm6UIokKAjzmNrezzK7xvArtkue49Z17psIiqbSdkSataGxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790383852; c=relaxed/simple;
	bh=clzJl7tat7edqHdDSmDO0zl3L0rUROd5Ujs5P0wIAzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HxYiJLa59Wyp6UEIl8EnCK2V68x0hCQ94xeym68Hy5KEWruBdj1PLso3KYTM6wXnvF1AS9NJwmOZnp4LS9og8uOjNgbbKC+orVf7xIMkN7XDRL84NVgKSfdT4af7xK8IcYY15EHs+a42OAyaaJSzR5+swISUJFx8zUVdgrlP6RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIQ2+pr1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIQ2+pr1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BB5FC4AF13;
	Sat, 26 Sep 2026 00:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790383852;
	bh=clzJl7tat7edqHdDSmDO0zl3L0rUROd5Ujs5P0wIAzk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CIQ2+pr1/IFy1J/Cqj4xAxFux/GIa20NPau6WtfoEaI34fPTFtJyPnFqcyYL8ObnE
	 TnWxKE2Hxw4sMDJYa/Ckq8gdthUDuYAw4r/VWKJxWi3CukaUmmdTgcCZpMSbjXVqY1
	 78h3b85NmurNGGPwHvKk+MycCnRDgDghOBaopcuAa0L88dcwRrMyBUXW4o/WicUnZw
	 uFI29kJeWFuq9nEtT/e3CLso0y1kXapkhMeM3H9qMfcamQ2J3l/ZfP8NkNEPd5Cu7F
	 FfPUS3t3uwyGhHGoFlWbJ9ON7yN/XIyViunsF+WGWlGYCWBeelYKtx/7sNeHfKq8HV
	 Y4rwL8EOMdA0Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB871C98331;
	Sat, 26 Sep 2026 00:50:51 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 25 Sep 2026 17:50:58 -0700
Subject: [PATCH RFC 11/17] KVM: selftests: Test guest_memfd with anonymous
 fsmount() tmpfs pool
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-gmem-tmpfs-backend-v1-11-d36159822d18@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790383850; l=2594;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=Si9JGry309vjF8hKL0mCR4ckxqZZ+FxcLQB0xL3xoag=;
 b=PyIIYTVR6N2jUy7YaNCs+XJW/WTb8muHJXoGFl1QAit/5T4X7y8M5Oq8R5MHlWF7Xs+QkWAos
 p6iAVxid4mbCy3dVT3rzd/VcyoiQCU2KkivZkLfKJ9j/KwsTlzd0Lpd
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Add test coverage verifying that creating a guest_memfd backed by an
anonymous tmpfs mount descriptor returned by fsmount() succeeds and
reports the requested file size.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 35 ++++++++++++++++++++------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index e8199ed17b0f8..73212d5307049 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -541,12 +541,23 @@ static void test_resource_fd_tmpfs_huge(struct kvm_vm *vm)
 	close(pool_fd);
 }
 
-#define ____gmem_test(__test, __vm, __flags, __gmem_size, args...)	\
-do {									\
-	int fd = vm_create_guest_memfd(__vm, __gmem_size, __flags);	\
-									\
-	test_##__test(args);						\
-	close(fd);							\
+#define ____gmem_test(__test, __vm, __flags, __gmem_size, args...)		\
+do {										\
+	int pool_fd = -1;							\
+	int fd;									\
+										\
+	if ((__flags) & GUEST_MEMFD_FLAG_USE_RESOURCE) {			\
+		pool_fd = create_tmpfs_pool_fd("never", true, __gmem_size);	\
+		fd = vm_create_guest_memfd_resource(__vm, __gmem_size,		\
+						    __flags, pool_fd);		\
+	} else {								\
+		fd = vm_create_guest_memfd(__vm, __gmem_size, __flags);	\
+	}									\
+										\
+	test_##__test(args);							\
+	close(fd);								\
+	if (pool_fd >= 0)							\
+		close(pool_fd);							\
 } while (0)
 
 #define __gmem_test(__test, __vm, __flags, __gmem_size)			\
@@ -606,15 +617,23 @@ static void test_guest_memfd(unsigned long vm_type)
 	test_resource_fd_tmpfs_huge(vm);
 
 	__test_guest_memfd(vm, 0);
+	__test_guest_memfd(vm, GUEST_MEMFD_FLAG_USE_RESOURCE);
 
 	flags = vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS);
-	if (flags & GUEST_MEMFD_FLAG_MMAP)
+	if (flags & GUEST_MEMFD_FLAG_MMAP) {
 		__test_guest_memfd(vm, GUEST_MEMFD_FLAG_MMAP);
+		__test_guest_memfd(vm, GUEST_MEMFD_FLAG_MMAP |
+				       GUEST_MEMFD_FLAG_USE_RESOURCE);
+	}
 
 	/* MMAP should always be supported if INIT_SHARED is supported. */
-	if (flags & GUEST_MEMFD_FLAG_INIT_SHARED)
+	if (flags & GUEST_MEMFD_FLAG_INIT_SHARED) {
 		__test_guest_memfd(vm, GUEST_MEMFD_FLAG_MMAP |
 				       GUEST_MEMFD_FLAG_INIT_SHARED);
+		__test_guest_memfd(vm, GUEST_MEMFD_FLAG_MMAP |
+				       GUEST_MEMFD_FLAG_INIT_SHARED |
+				       GUEST_MEMFD_FLAG_USE_RESOURCE);
+	}
 
 	kvm_vm_free(vm);
 }

-- 
2.56.0.rc1.315.gc6ed9934b7-goog


