Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792711684;
	b=jJGVAQnFP91AdzvH8f9CiUVgP9gLra2mJC0/izdUOeEqTnDkntHadyYdx3XUWU7HCIK8
	 sNfxvvBeiPHKRxPodRIXZ1BkqQ+YDOSddEhcKOGDaOJDp/WvqUo+oqOuHlY549lBw3w4L
	 pSZaOUalFu/l92vUhpOR8YONSMYzHhjOrCUb82hNtPQ7u0iYpt9rxRMNBtFa5EpolcqqE
	 D0BISdAKI/9xptLfJDqkzstarE/e2jPgXYvZc3wq+OC7b22YCgMtB2TJBtLGWYWjfLC8t
	 hghVfL6EGutxYWl4O2HZsJIhrK/oa50MnodIzaizK043upxcszzv9wz9KLLceE2EqZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711684;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=o1gbyJWrq7gNMYi3d97cDgWKmm9v1VUHIwBQSaU0vFg=;
	b=OJPy8JqyFvyWq3/Kujwvv6B139U4Xaqciohq3x9U7Eatc9eaxvFBOJJh4aEyNaRqYvOG
	 OvwJVmzh5Y6LZ7VXJyfvjowrHru1NoIGursiQ3A2YkulB8epoeM5WBkd91hjERKYr6nl+
	 0q2HQT2758b9CLoaFa/HZ2cSgbUI3jlDNRJqhYpdTcSmd1fdxIFvGBi3x/X7IptZJe850
	 KnryXXtXMleStnjkR5P7Gj1l9UJBTLrC2QcOpbf5N7M5wXt6hL3V0H4AS9rshnMM//1pR
	 KAjUQIkkvb0Dxhb9ZLOF3DOiXTOIicwszq+DMMAH0z++uNG/93ygDyuym+OGPGdaL6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OUMYWHe8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DEF606B451;
	Thu, 22 Oct 2026 23:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OUMYWHe8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792711683;
	b=VsXUrsvAdrYvgXrUid1BFa1AUY9lFMOooANRmU47N6rhhiTPnzyVu0zVPIhGZrhgt3QL
	 hjIQfg/W5MX7yo37gTpw8TQEDSUxr63ituQBpSY29dTRPaRmt8S/rQWJSXpo7n/drZail
	 v4JZ1Bf1ZAB5xHGJ53C4bBVOtmOlYozgqo398o3lB0XLJkRV1PHUPR/Nr9fdasb0kENW1
	 z0qzdXEFGwRTpqwChVg5X8fam4x/kieg7MtznC2/l9Q/t5IqIeRlr3hRr01t9Cf31kHqq
	 z0AoXLqVIcSGccr/v9CERlgN4hpp4rZAdSzhTtbiu2joE61/8XT3mN9DM3iinqIwghQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792711683;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=o1gbyJWrq7gNMYi3d97cDgWKmm9v1VUHIwBQSaU0vFg=;
	b=ojJV6Ym/u2e4WqgeLdYHHH3HymmE9Y6ysCeGWndwTUjTs+kuiIuyyM9zvTYjNUzGLt7h
	 CnlsNjdibSc23zGwrF50dtqHvI/S9bVHqDVXIKtSUtRzzVdaj78mrX7lDXsOnB01C8KW4
	 Lh2dzn8zJYvtQlZv4vS6W2BXfNjdBX2PUbsvI3Dry+HX8+lQDcCii9lzOK4E1ooHYXayZ
	 dvVAj3yYvLWDta9hboFabCoOX/YrDfLoRXPRsX2gWe5WsX8o04fT5uzzsK/PUJBk+B5Aw
	 QIY0X5zve014kevmy9JmXFjNsm4jSxa9Zn2G5WUnZeE1tSqYT4KvrO7xL05q/byZ/cA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2D0791F0118D;
	Thu, 22 Oct 2026 23:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792711683;
	bh=o1gbyJWrq7gNMYi3d97cDgWKmm9v1VUHIwBQSaU0vFg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OUMYWHe8UnjROSfgKl348zSMR/d9YabpRnkRf6sJ0plRyyLN1wL069ESKgJO7An0h
	 nygWWHdTUG+pV+WAgPjnEEZvGTZht5udWIbOMFoA6TQBJqoTVbx0CwMvvgXrft9SG2
	 G3BYFVsyEWlXgjR+Qr0KzDMjk5mZzGA1RrOo6B3E1ezQAkze+701Qm08TDnLoN7pPM
	 LMWIjYAoZ0UjawSW9HUXYL1RHTyypvDfwuZK1lN9lWVrFCNfM/vTnJQtx235ADOmJK
	 K9p1vgdKdyras8RwjJD6fr1pYxc76UecYp8crXIpvsao192lVC+96k0pBiXo4IWNEd
	 9rOgS4TrdcB4Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D926F42077;
	Thu, 22 Oct 2026 23:27:48 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 22 Oct 2026 16:27:45 -0700
Subject: [PATCH RFC v2 13/50] KVM: selftests: Test guest_memfd with tmpfs
 resource pool
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
Message-Id: <20261022-gmem-alternative-providers-v2-13-5dd1dc6c660a@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792711665; l=2627;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=YbcH78A2PggvmgIHyLc+FvDnM+c8ZNEhltr6vRYx48I=;
 b=3tHe0p96whxRdNNyX/r+KpHPSvLRTqYyqnIWCP8R+a0C5FAForRtXgxX3rTpW+B9mcxCieVzj
 d7PIu77lFIPDjzb3OfhoEdtqC1oPeBW3BEXI9o3cm6P/lHqLHMwabS9
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Add test coverage verifying that creating a guest_memfd backed by a
tmpfs resource pool directory succeeds across all guest_memfd subtests
and flag combinations, and reports the requested file size.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 35 ++++++++++++++++++++------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index bef1acead4a6d..2250c3e9a583f 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -562,12 +562,23 @@ static void test_resource_fd_tmpfs_huge(struct kvm_vm *vm)
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
@@ -647,15 +658,23 @@ static void test_guest_memfd(unsigned long vm_type)
 	test_resource_fd_tmpfs_regular_file(vm);
 
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
2.56.0.257.gf7497c7d27-goog


