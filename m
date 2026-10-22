Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792711680;
	b=eX8fuerYESEMHGTA28qas9TT6TK0SIbUi6GaFmVX4JtZ5Bo+coLAheeWg7ws7S36ryAd
	 xBRIUWgsk4r2P7J0gfS5h2EDS4mz5zobmEIsG62JOKQR4ihB4LrqnW6YJm568nKPHGGCf
	 7ZkZJ2ouYnHqtg1Q3/vEQQrySysrfjDkJp0z1yVHkWelDzcJVhn5YuXoJ9Ebwru0gvZyH
	 7hvMKr8qXKW6PShVKXwlX8W+lnYGmoavwytxXdNYhMuGWkv2puAMGEvjMLkBioYlGVPvY
	 n/kZEUh2hVXxKS3RzAq2JyG3SLjTet/VQif/waKtZefHNaOQtORVRfLJw1VTUi7SVgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711680;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=oTeaqFa1HXg+JOfpK9hboIAMw/2sySo+E4rGYwzL0fo=;
	b=mbED4FbXWauOia3lGLGk3aOV4rEGsAOnEyxenLSx5uqW16ZjY91LQwyox9ZxhE4hiU9w
	 N+FUDSPHnl4hFnzMWSE81BzmTwCoZ+tuk0oNPPMWuzKBFJqDgTUgsZZch9H4wdlAhG8M0
	 WHh2tRRRlWlNvbqkYafECJXQkjrQfbQArHcbRXgeoB7pYgFmtKVfCiEYID83Liy43KbKk
	 Fjr7Lx7XXyQh0+edES01seOn53xrHhiUx+MQui1Nk87nlHmF0b0kWTyaMIEw8ms4XRkrd
	 ajWQfmBH/+EXB4/NyIBmacpEg8gNWEzTFkv6Lls3YkiE9zmQU7s2FG01p7IC0riD/NA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QtDIDBLQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C081260A2615;
	Thu, 22 Oct 2026 23:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QtDIDBLQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792711679;
	b=gZxVX7yxlVT/SQnHBxnr/0owW9BOQwqUlR9YHnsCPKotHQH3LBLz7MyEr7VCo6Smgcsf
	 Vj6QSAuN164RdzE9VVov2qlAaJ7b71fJkUQnKA1zXRyj8A7rdFOQMDBkKD0jb2tF3qgfq
	 SDvkHBkUVpwXJK59T2Rc3M+yC/K7osYKXw8FfbW2EjxFUnH0CfYYx3L6Hf4bHmSxWXne2
	 oRwOL9kO4jTuDy83JlBvTiGETuPU4BTdKDxzxCIdlVYZWgFltKm9bXLudc4bTdLo7YewM
	 nmfYrUvZlFdXROGaqce3Lt8V2yA2oEdC/EcODCQnWy6dNuongJHUAGAoa6F7rjWD5sA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792711679;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=oTeaqFa1HXg+JOfpK9hboIAMw/2sySo+E4rGYwzL0fo=;
	b=zyLi+fjhZmb7XWUI5V5uGj2d2i/ozzteS6rEC+rRtDlqBKjthWkDuL26YQ/GPfXA6rJ9
	 k7FGGWd6QUhtovNaOKNgc03BeIfkt+CwmWamw/Ff0tXwzdUSlPZogkUqifmJQ1/VD1o2y
	 qSCzcZC4Stp3E2Qs1ZuOi5LKIQKbazkMNOSFVBFtl++VN7Kq022lyXY3maXV/JTwtS+z+
	 KkWPRgWn11mg1xwNs4EHYOE/hX7aA9GQKd4NiEHMkVfLtO/CVojj2Gnt5hYeFCaYKOFJb
	 /T+OoyrIhPmhCu7PDzKF5j0ug8qBu1NEmxTlFrNUHUsYnzk5b3HwLjfo3sOeSr/1a1Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 948411F01197;
	Thu, 22 Oct 2026 23:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792711679;
	bh=oTeaqFa1HXg+JOfpK9hboIAMw/2sySo+E4rGYwzL0fo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=QtDIDBLQ7sLdDRf8rJcCkxflN0zkuMMWTtksNGNCRlWJS7z7mJ6fJpjnyY+LN0kpP
	 2FGOxZkFgpOkm3w0IRHsLIg2QdvEK/eYUHlqAi9bOQHvfrKvU4PGCwpn4nZL0ODgIb
	 tyQKpbkSlO7BTh1QbFbDBauugiPpjrRI36CPQH4HttmqgTpnK0P1pd7AbRRYx9oi2W
	 W/U7jPTv48nw4NbKJtTBBt5DDLYN6KcI4AlLMMAXHXOiAO5HQ9vcYMS/n8cOrSlFil
	 ieczMLiZLFIaKUgNXF8RhpFThIvopBc6WtHiGxxT72RCFHQuqiLxcvTeyiMQ8xNn6E
	 vRVcj9RkrWRdg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F02124207F;
	Thu, 22 Oct 2026 23:27:48 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 22 Oct 2026 16:27:47 -0700
Subject: [PATCH RFC v2 15/50] KVM: selftests: Test memory allocation
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
Message-Id: <20261022-gmem-alternative-providers-v2-15-5dd1dc6c660a@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792711665; l=1933;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=6KatK9dzFsYDMnh/WM/jXUR/ewN8CiU3pBTeSrOUg04=;
 b=/P+rFa6MKAfQ2FTprf3qC1Fg/EKnBnijzsSsQS2H5G5qu40sLn36wx0KQjpfUJhsF9CA7l2TL
 bew/od/tWxCBRVJTmLYmpanhJYxYOMXUjYVGl6TYFsFTaGw8xcGDA0j
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
2.56.0.257.gf7497c7d27-goog


