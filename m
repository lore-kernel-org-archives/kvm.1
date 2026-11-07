Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011820;
	b=VKxDzwsgqh4BHpOlo6PJuXntfluUlL/TCm57ELB9IcV52haX1baIUJ2RwR9U3ZKdRpQ1
	 b+9yyFh0rShDSb8ySFQZBvV2T8dpTknIxwVIHrN/XsR3guxFahPrvKbW1fgxhcAvmTKr0
	 QXcFvSIReKmzqIoXhUZweBJiTb6PL5KJyX81KCpjBVbryTltxr9W3+PIFK4BCiguhGfrI
	 di07Z85KfNRi/EbUo3dRAmm9b7yE49dQTsIzVoXERvSeI7ralil6zFF9EXmg9SWzWE8q5
	 hCPqFVCSruO6OgXA0ilbMOjtckEqMzXuWhXp9mskapyITKmsnhCbftB/TtWD6gZQg4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011820;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DHDksz66dHh+NtJTWgduIeFZwcvn0gYLuNtG7xctz0A=;
	b=nFd6LxtDt0F1l6eJEt0WCS7fDBoLbA/Mpg6ZWAnLnu9TkHIAYp6d4Hzw6RpLK0sc1twQ
	 wv9ld7Wggq+wp5LD+NN4p1u7mpMZMBOtsbY07iF17SzwEV5SFQQNMR4RoeG7AB8k1KESw
	 mfvj8sNkokE5aIhgUxWd1Nfva531V2Epc+NmH3itrEgfetEnDm2y0ayOz+0TjOpvoMYsw
	 eO6dWPXMHap4ZdMpKK8q/LSfIS3R0x7bWfqLd5tUbJqd9nk7xTni80PO0ymbysaRL4oBx
	 L85qNT4s+mZJSrqo4n4nFkwhoz0d7YSHOUyajpxPmB4Mlnaq0HglIl77bPzD65FaR+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CTIuOzC7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7B5606EE9C;
	Sat,  7 Nov 2026 00:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CTIuOzC7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011820;
	b=VrE8rnsLnneuO/bg7C7WN9xssSN6Z41a8MHK6QtDbtznahHTUp+xY/6s/piUoA6iDuFS
	 UMP1HYDsKaksuvkl0LVw4J6E5p9tSuw2XXSYWbNONd9NsLkf7RcgklDHpY6i39WyjzX+P
	 GWkeiZEvqhR3i7kgsbL2EzhIEL9Eb4PKinRP7XW55MqIuZlwT9Mxzg9bWRwduOCV3wcON
	 I7CGBbSuirzlMiBnh+x+W62bHujKK157IJkez0pYFCRMaOw/8KqwT03Bq2JZEAOAaYrqb
	 z7+dnAv34QFGWWb/SgWhrrxMPTc3Lv9G/GSxIkdxjhWqb/P7OkWGNazIKsm7dIUOfOw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011820;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DHDksz66dHh+NtJTWgduIeFZwcvn0gYLuNtG7xctz0A=;
	b=t+UKBIUBCUhyW+jCDAu64FNq+UL8IEbnTWgkBcHDmcA9EOaM0pyfVhdT2UBg6DCC/6PP
	 c4hWixr3Vs33Jkln8TWnQHrAvv//Q8aNXympyY9pTsJD1Iy/1NNrqBoN8kVlhUYCsN6ZY
	 7qA+ZMhDRZYPSh7powFM/2NkczLzizxZNB05AHEddoXVK0oliknm4NN374i0HdVruDcLB
	 rM2ULh0tLL4BBFJMVP1b5u+KzqCcJKUDD/kFMrTIlebQA+yM5eBVl6yTx0fe+3pgrPbIZ
	 vJOmNKuOV6eHaRN1wwFEmnxyFaC9ctP9z4Fhd5s46sCAHnf/z4/xpmB5KszwE/ZWVfw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6539D1F008A6;
	Sat,  7 Nov 2026 00:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011820;
	bh=DHDksz66dHh+NtJTWgduIeFZwcvn0gYLuNtG7xctz0A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CTIuOzC7SDVZweqYICC0sI8QCSlsYLBGCRg/OR391gwTSe0tNboBS9+LYmvpXPhpD
	 GPMPDUgscXyL89iR5dssXaGz3Jl+q4WR3oFK4vXeOFKkpXzO0zp7qgQAkjw3NcZr3E
	 HvejGNEfUYik9Il9ZhBGwRg+MXmBBF1rnwvVb3JNxXI6ZDbsgSJOiocqV5ibNln4MY
	 ozioR0AfrnVp3joK73/f9JoG9iSMhD0ghVgn06hzWZheEIUZgzicfmtfFLrwtlGYt/
	 WiSbJmq2fxXwbws1WzBx0KjzhA6PXVFh36evVeGO1y/Qy8bNxdaAptBmHhl1xFoSfs
	 fUrVb28INlxXw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CDFBA47948;
	Sat,  7 Nov 2026 00:36:53 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:36:47 -0800
Subject: [PATCH RFC v3 13/88] KVM: selftests: Test guest_memfd with tmpfs
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
Message-Id: <20261106-gmem-alternative-providers-v3-13-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=2627;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=Qu55YepzOrkvcU6P+bNeN6dK+ZH4EE+CD9gCo1tRMPs=;
 b=1kdK6627i19vf9EPHPpEoGXhZEaTstbkmiKYLeec0b0X0HFFgMZ2ZRNvkGyRYgfjXfR/lS1e9
 BdAqrsrNbD/DUKfc1K2BQZoC/2dn8bnceObkJn7U9z8WcYqSyRW8UTs
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
2.56.0.455.g6c5a503b38-goog


