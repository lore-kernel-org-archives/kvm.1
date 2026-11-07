Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011827;
	b=iymzuVsxBGIEKBr/8GpH6FPCi2vkD2La+OSWN1qEUU4c4rOoiCv7lcpAVKwtL4xN88OW
	 /XUKtp5uFfGI18PGR769O0onsBIeCOwM/UIWql0uKLwFM+IzW9r/K/4kpFxlXmkrSSLNq
	 suWPHJwVHF0NrJl9DD+7B8HMik5/zTUbEw952c8aQb1tHH+5dYauuGi/+oBpyedZD9iMd
	 ZSkNay3YXaO6RWidNF60OvOnwx8W8yh4GYJ9IB9g679fl68Lqh5rtetzHoKXEUKL0KVf2
	 pueLwREZmk9sFdTQFHo4leiScB/ZLCOKo9QHyUY+qfU9MIjKp7V38SwClTX3812AFAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011827;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zb9+5k0IUwH2cT00AAZTFtNkxkhXFYPW9HN27CYbDL4=;
	b=yWmAcfWxznQljecnS9zVlkZMc1Xm7rCm3HdyN4pad05+ImAjZlxx5a9ecJgLItQgPF63
	 ZbGceIC8XAiXeeEEjgtZpBPlBRZ+L0y+jJg3dXw3TjTS6jWrpobMK0WUhHEe6Vw7KZsKz
	 rUBA7SRGR2eChmqfEhYQuUy6A9BXhPiNviaF/na0nwmlSB/1JapYxD60524DjTkCHd1cv
	 F8O/zQgByn5je0MtCJFVWFl55/sW1MDwNzAnV4BlKtVlENYX9IMyaYHNSsKnBGywHDmA+
	 1p17WU+d9fyCt15EflwX2o3+slTGf9zvCScoMmb1DsGiqkFRScmyNX29xtrUViR/GLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KxeMzZvU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1584F6083634;
	Sat,  7 Nov 2026 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KxeMzZvU
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011827;
	b=aWX3Q35/7a5A5/Ijl+tyTdHXI8v7ZaR+4J8Y0eDa579riyBESTCisS+t9EZp7g1RGzID
	 tUcK2LUow8K6EW7htPYp9dn9byPZaXwrYdehQXh+VAqMgmJ8DDtFHboct/ZXxXrlLRjTH
	 kht3qA2T+4Rj9aiqLjdB/kpoEBP8Q0bsNeFlslWv3HpYUbDAJ+bkj4YSFcT6vOoKxfwt2
	 TwSxUz97OVjQJqO95zszOnDkthUXH5KbkbrkACmqfG97j+/F+jtoHF6lMYR39L65QbdTQ
	 XxjmQZZH4xF6HE+VugFT/ilp3P2ZYSEguIdW/ccLxnEXOqw2EmIkbLBpvflYfOuVxBQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011827;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zb9+5k0IUwH2cT00AAZTFtNkxkhXFYPW9HN27CYbDL4=;
	b=faplxL3OCtnY5hXU2kAHzLIGBSThAs6mfgK3j2ZrUFEN86Bp7rfyRvX6afbX+kD0CmCb
	 It28Re7UgJ+168COA45sDtsUzCh0xKNj+wmDPdbH0AXDZCaEdXxZ0u6z0ux8xDBgUITGH
	 vmed8NYBsJjEKsj0ydmPrWjsSrzjNTkaftaJGyLMp9qYIvzEhGGL1++qfZv1d23XBE3Nd
	 9GoR5PzEUcuEOjM+mTZKBBb6s/Z92qxN/1il09Fm70dPoQdGSbU7M1dFZ3OvEiXdnz8qG
	 CyMwPBWFDI8TuRJVLvg8au1kgpNF5F3W1qmvSLw/Fx8ZGdkjoutJr2SrrbPtwNQ9vhQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 496541F008A7;
	Sat,  7 Nov 2026 00:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011826;
	bh=zb9+5k0IUwH2cT00AAZTFtNkxkhXFYPW9HN27CYbDL4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KxeMzZvUVygv9Ea8tcUt1Dq8CspODexD7Q2DFav1TBSwV/SOiXkbtyLHw2ktGsY9y
	 pWbvDhLJqxKLdThAqlXC32fb6UAY6tjFyvaMAnyui8j1qywEAG3S4l2sh53zk0waFM
	 9lDo09uxdIAiEBOV3Xj524G6XSJebVT0Fc8HwK4P16scXw47T0hBekTacp3bgi6Lur
	 xnXD6ast3SbkD/i4ukK+ujeascbGmlQwNXa+qHReCd8X9p2qt8ZoqCOOaPR2bry+UF
	 nMEDwnODG2l4TSvH5DlA734x+OazCzfmAauQ90A9oe+wb+2YPQY+I51w7xUlKvWlYx
	 kpjn8WwoihGmA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6BC8B47934;
	Sat,  7 Nov 2026 00:36:53 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:36:42 -0800
Subject: [PATCH RFC v3 08/88] KVM: selftests: Test rejection of unsupported
 filesystem for resource_fd
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
Message-Id: <20261106-gmem-alternative-providers-v3-8-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=1756;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=0ahPMSc6GtBF8lWLRrGCjyFX000iueLLA9MpljWJTxQ=;
 b=PvnkTfeMSI+t3ucJfNd1mZ7x+KS1+9FHkGY+aR9D7rUyf4LZsXEbHZeztXx+YOAdA17lUmiQF
 NZKrEo072OSCPtKiqKZNY7dq5N9ZkuAR+ZEAyjf8uJM6EpZh/pKJboe
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Add test coverage verifying that passing a directory file descriptor
from an unsupported filesystem without provider operations as a resource
file fails with EOPNOTSUPP.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 3313d306c0bdc..445396860d819 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -436,6 +436,27 @@ static void test_resource_fd_invalid(struct kvm_vm *vm)
 	TEST_ASSERT_EQ(errno, EBADF);
 }
 
+static void test_resource_fd_unsupported_fs(struct kvm_vm *vm)
+{
+	int fd, file_fd;
+
+	/*
+	 * Passing an FD from an unsupported filesystem without provider ops
+	 * (e.g. the /proc mount root directory) is rejected by KVM with
+	 * EOPNOTSUPP.
+	 */
+	file_fd = open("/proc", O_DIRECTORY | O_RDONLY);
+	TEST_ASSERT(file_fd >= 0, "open /proc failed");
+
+	fd = __vm_create_guest_memfd_resource(vm, page_size,
+					      GUEST_MEMFD_FLAG_USE_RESOURCE,
+					      file_fd);
+	TEST_ASSERT(fd < 0, "guest_memfd with /proc fd should fail");
+	TEST_ASSERT_EQ(errno, EOPNOTSUPP);
+
+	close(file_fd);
+}
+
 #define ____gmem_test(__test, __vm, __flags, __gmem_size, args...)	\
 do {									\
 	int fd = vm_create_guest_memfd(__vm, __gmem_size, __flags);	\
@@ -495,6 +516,7 @@ static void test_guest_memfd(unsigned long vm_type)
 	test_guest_memfd_flags(vm);
 
 	test_resource_fd_invalid(vm);
+	test_resource_fd_unsupported_fs(vm);
 
 	__test_guest_memfd(vm, 0);
 

-- 
2.56.0.455.g6c5a503b38-goog


