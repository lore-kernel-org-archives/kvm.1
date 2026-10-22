Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792711686;
	b=fHxgeVb9Bzl5+N+yoVMz5XYJOd2zPl1GgIg1Ai0mWnIykhIhuvgarqK4vbRpQABlKop9
	 zj/qoJDSddxOh8fSGCFmOwLMgrv06EvTRkGfU9nKhSuhKbNyV5y/jFzsUZ5LwbzRqE5lM
	 6b4hUAA+9QMyABfK+VzwH76KWHln8HEJE9rGYeai/dJWyPH6rIIC1sQnMfVddYE8nG587
	 7w3FOFGsATBxd0Ha+DHdQ30YraLNliKO/V3mrbuEhUFDZHpQFjSt5DQjaUTnV7nmBLWFj
	 +8dyVBNBT7O0a/+xLUm8fxBqIVMmWp3zmYliFhjSzCg8+kh6wQ2s2jRcLpBsJHYjz5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711686;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=X78HZyiy+58c3BPVTrK0KZrqYrh6HOK3w406pYK3FkE=;
	b=Uo7jJJ4qouGyqG+H+jBrkeMv7x+azA9ZseEa33bBXpHsAAt1/6n0P6nKVdAEWcrz4SM5
	 0X6vhhmqV6kg+g3LFPxubBxfPoY7IJYya7UAiHvakPPCCaUaDfbD2TIv1IhYPgCeLuBkT
	 +hNBwWNbUbztzQTrqKLLBocC8mbroxY7tB3xT2TcOkn0tGaSi9gXQ+3EZfbonQPX5DRC4
	 qREdmOmIoWApdJ7FfIlZMy2gp2rkEcAftof73OaXxMtJKkVqmMW0nrMwmE5QlkN8hRadM
	 x/xChgTpiDSzCd6/wlAv9N0XCWGDlb2gREIwNfJtcdxRIEstVOIqC6xlHOtqxbTKvhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OYfEKZNl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D73E606A74A;
	Thu, 22 Oct 2026 23:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OYfEKZNl
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792711686;
	b=EB07UqtfXvZH5Ii46YRIDKWJhFHFQBPU0cMd4LgoPobykZklQdOL1vYwdJJILWKY227O
	 eEtoshzV6fs0VqTCiwvmgYdh+TcZpzSfDkIBoIfA3qe3ja/Qx+fZaJCAfXjRO3sz/1Sxu
	 OJ1Eg4WpLRn0XYK0unXu5nkPfcSzhg9Pw5E1ZaNxgei+FPl1gkQKFFJKrIgVGQ3Kl2IoH
	 hWw7ku9h+kjjsrwSFepixfiXF0l4M0ZhX9zj3fQiPl9PnBioo4DF6esh2lb5J5Yfy89vS
	 CwiuZ3kCXtHTXFzUZOVExzMzBcTf27sTEjFaI8YqPwhiEfbY/husPY6HXt0+KeEBlbw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792711686;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=X78HZyiy+58c3BPVTrK0KZrqYrh6HOK3w406pYK3FkE=;
	b=oU+hm5R1OfvXg6USis0TJncSFYGEUaG3PysdoWW+3UBJNsk41upxACl4S6WWzyDs7pJM
	 YYW6Nto07ILWDRSKUFpHonc3uxzdyvtG1mqfZGzRgGwkKCcH0obJwlcUOmxbf1n2nWyOx
	 tUrt4lPqQICv8ta8EfYnS3toLejRmfHZTlOJgKc53jZ0DZ+1ONV3sPqBDS4ACtUmQJPlN
	 ijpvCFvWmA16Omv+9vH75Y5rx2PzrqP+b2lHvqycnL7dznajNQTkDRBsy49l+7usUQEpz
	 es3AOAJIQ97hQ6fTootdeDqIyQlrVWHKg6pe2/h4cxral1po5VH5txT/Sdrs2dHxn4Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A358F1F0119A;
	Thu, 22 Oct 2026 23:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792711686;
	bh=X78HZyiy+58c3BPVTrK0KZrqYrh6HOK3w406pYK3FkE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OYfEKZNlRerju5ZLailmMHqnTafkjJ3JvD7biWegxapcy6w7D6a8DeMrBj3mABKIg
	 rYFuMU5F25iCdg0ngFrrFqRot1htDr9TY8JiAq+gu3nDGjVfrZLOu/NUJUOriS7TLZ
	 mr1ZCmHw/9ZwGnZx9xEOdg3zhWhvUMZ73GAa/Fnz4gknlO07j5LgK/NetSmkavTIzi
	 43xjCY5fV5P784e+BVzkEXRcF9EecFg5w/v6tz2OqA3/LgIBNs+q0yXv/uV1p6jced
	 KMOyFMKMRxv2pBXz9XC7d3/NTZZ1amvZ63q+HNCyZB1D2Se6S0pOeYsyKYByrKTuAq
	 ayfeUU9oSFzuQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E44894207B;
	Thu, 22 Oct 2026 23:27:48 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 22 Oct 2026 16:27:46 -0700
Subject: [PATCH RFC v2 14/50] KVM: selftests: Test guest_memfd resource
 pool sharing across instances
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
Message-Id: <20261022-gmem-alternative-providers-v2-14-5dd1dc6c660a@google.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
In-Reply-To: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
To: Alex Williamson <alex@shazbot.org>, Alexander Graf <graf@amazon.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Alexey Kardashevskiy <aik@amd.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Ashish Kalra <ashish.kalra@amd.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Baolu Lu <baolu.lu@linux.intel.com>, Bill Wendling <morbo@google.com>, 
 Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
 Christian Brauner <brauner@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Connor Williamson <connordw@amazon.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, David Hildenbrand <david@kernel.org>, 
 David Rientjes <rientjes@google.com>, David Woodhouse <dwmw2@infradead.org>, 
 Erdem Aktas <erdemaktas@google.com>, Frank van der Linden <fvdl@google.com>, 
 Fred Griffoul <fgriffo@amazon.co.uk>, Fred Griffoul <griffoul@gmail.com>, 
 Gregory Price <gourry@gourry.net>, "H. Peter Anvin" <hpa@zytor.com>, 
 Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, 
 James Houghton <jthoughton@google.com>, Jan Kara <jack@suse.cz>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Jianxiong Gao <jxgao@google.com>, 
 Joerg Roedel <joro@8bytes.org>, Joey Gouly <joey.gouly@arm.com>, 
 John Starks <John.Starks@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
 Justin Stitt <justinstitt@google.com>, Kevin Tian <kevin.tian@intel.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Michael Roth <michael.roth@amd.com>, Mike Rapoport <rppt@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, Oliver Upton <oupton@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Pratyush Yadav <pratyush@kernel.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Robin Murphy <robin.murphy@arm.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
 Steffen Eiden <seiden@linux.ibm.com>, Steven Price <steven.price@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Tarun Sahu <tarunsahu@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Tom Lendacky <thomas.lendacky@amd.com>, Tycho Andersen <tycho@kernel.org>, 
 Vishal Annapurve <vannapurve@google.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, 
 Xu Yilun <yilun.xu@linux.intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, x86@kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792711665; l=2262;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=ERP4iDESBKgfDl/D301xPUqUKAaFSqS72fvQfnKX/h0=;
 b=gvjCvZAEyO66fTp0In1v7/io1RmdqagQp3azd1KuvLFx2EEQWQ+zwcIrXBb1QeYYIN79KZH/b
 +xAxv/FNmj2CuJ4wHpNdy2Gn/eP0swfzaVfF0JsmQKnxtme4/XQ6llm
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Test that multiple guest_memfd instances can be created backed by the
same tmpfs resource pool descriptor, that each file descriptor reflects
its requested size, and that they have distinct inodes.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 34 ++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 2250c3e9a583f..310a45b6656aa 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -562,6 +562,39 @@ static void test_resource_fd_tmpfs_huge(struct kvm_vm *vm)
 	close(pool_fd);
 }
 
+static void test_resource_fd_tmpfs_shared_pool(struct kvm_vm *vm)
+{
+	int pool_fd, fd1, fd2;
+	struct stat st1, st2;
+
+	pool_fd = create_tmpfs_pool_fd("never", true, page_size * 2);
+
+	fd1 = vm_create_guest_memfd_resource(vm, page_size,
+					     GUEST_MEMFD_FLAG_USE_RESOURCE,
+					     pool_fd);
+
+	fd2 = vm_create_guest_memfd_resource(vm, page_size * 2,
+					     GUEST_MEMFD_FLAG_USE_RESOURCE,
+					     pool_fd);
+
+	TEST_ASSERT(!fstat(fd1, &st1), "fstat on fd1 should succeed");
+	TEST_ASSERT(st1.st_size == page_size,
+		    "fd1 st_size (%lu) should match requested size (%lu)",
+		    st1.st_size, page_size);
+
+	TEST_ASSERT(!fstat(fd2, &st2), "fstat on fd2 should succeed");
+	TEST_ASSERT(st2.st_size == page_size * 2,
+		    "fd2 st_size (%lu) should match requested size (%lu)",
+		    st2.st_size, page_size * 2);
+
+	TEST_ASSERT(st1.st_ino != st2.st_ino,
+		    "different guest_memfd instances should have distinct inodes");
+
+	close(fd2);
+	close(fd1);
+	close(pool_fd);
+}
+
 #define ____gmem_test(__test, __vm, __flags, __gmem_size, args...)		\
 do {										\
 	int pool_fd = -1;							\
@@ -656,6 +689,7 @@ static void test_guest_memfd(unsigned long vm_type)
 	test_resource_fd_tmpfs_swap(vm);
 	test_resource_fd_tmpfs_huge(vm);
 	test_resource_fd_tmpfs_regular_file(vm);
+	test_resource_fd_tmpfs_shared_pool(vm);
 
 	__test_guest_memfd(vm, 0);
 	__test_guest_memfd(vm, GUEST_MEMFD_FLAG_USE_RESOURCE);

-- 
2.56.0.257.gf7497c7d27-goog


