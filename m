Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED68C30C631;
	Sat, 26 Sep 2026 00:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790383852; cv=none; b=KJVTOc+4rQYspI2nC75slVd3OYM0htZmHgIoP90WrlPOb1Oxrsv8tvXi5OxY1Chw6k1h4VQ0VI7foTOsnLx78jpgFYFyMScK+gqUCkRtYAsnCEEOyCjFYCGgYj2Xkqlsdy7CtxV8oDLA4FUwnXNOMRlgKXt8NNY7jamr4RUPqyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790383852; c=relaxed/simple;
	bh=WcDRsHkmlxq31EOsgijIocsiUREamnuasZXvE6eFUyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MlnDzCF0mFf3lr/lwU7jUJwdml7ebL2dZXtQ51zlUqSKzJSXhQh8Hfbd8iLdMTdzuJMRUt8Vq96SgE8sgbLT3GXOHlmhjHVN3N7TgOLbNeSyJnNTcw9tjyvjhD/H32Sjn5hDO0jSLst+8DqvsuAWE9Iu/6IWDzNtvT7ag0HWLzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4HQpCbZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4HQpCbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC027C4AF09;
	Sat, 26 Sep 2026 00:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790383851;
	bh=WcDRsHkmlxq31EOsgijIocsiUREamnuasZXvE6eFUyI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=U4HQpCbZK5DG8EZSGPYthln3S1ikiBLlPTp/6Imauraia0pHu6XggYsoik1z4O5Vm
	 G+bDso8dO019O5l7S2Ifzih21I+R5P+HgyJxOcMzfbK8xJQkyRO8j075vQeKAIoa6X
	 5rPiWS70iViKpVTPTZeHbhZDJuSnHcWrd6+9qX0Q2833c+Sgp/+3VUfNC0UK1URzPf
	 JlSvx0d+KYL7+e1XJD3No3C48qJjx6i0TVgunRaD52eCeSSlblhghvltTX9bawMoGa
	 Nxdlv2Y4bpCRW2PgYEIAWTUcITy0umn4q/5NdqtoJnzZG4nDatp/O4na8zFng2S5tx
	 rgYZN3potO+sg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9175AC9832F;
	Sat, 26 Sep 2026 00:50:51 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 25 Sep 2026 17:50:53 -0700
Subject: [PATCH RFC 06/17] KVM: selftests: Test negative validation of
 resource_fd argument
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-gmem-tmpfs-backend-v1-6-d36159822d18@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790383850; l=2106;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=iBvHnSmUj0NiYI2gh2HdRSLcUfZMIscuYT1+68ta7ps=;
 b=FmJHODI39gS8wDYTgZFvNQSKXaYtDDeUYWD/fb9mP0pf/vGXvL776WINNrhuTxNGtGgGFIwu3
 kp54PCvz2vyAlH9LzU8o1bP2LMsgZu7zqGDgKG8+EizfmBgpVE+lM+U
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Add negative test coverage verifying that creating a guest_memfd
instance with a non-zero resource_fd when GUEST_MEMFD_FLAG_USE_RESOURCE
is clear fails with -EINVAL, and creating with an invalid resource_fd
fails with -EBADF.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 2233d871a38f4..84b958b9ef715 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -404,6 +404,8 @@ static void test_guest_memfd_flags(struct kvm_vm *vm)
 	int fd;
 
 	for (flag = BIT(0); flag; flag <<= 1) {
+		if (flag == GUEST_MEMFD_FLAG_USE_RESOURCE)
+			continue;
 		fd = __vm_create_guest_memfd(vm, page_size, flag);
 		if (flag & valid_flags) {
 			TEST_ASSERT(fd >= 0,
@@ -418,6 +420,22 @@ static void test_guest_memfd_flags(struct kvm_vm *vm)
 	}
 }
 
+static void test_resource_fd_invalid(struct kvm_vm *vm)
+{
+	int fd;
+
+	/* Non-zero resource_fd without GUEST_MEMFD_FLAG_USE_RESOURCE fails */
+	fd = __vm_create_guest_memfd_resource(vm, page_size, 0, 1);
+	TEST_ASSERT(fd < 0, "guest_memfd with resource_fd but without flag should fail");
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	/* Bad file descriptor with GUEST_MEMFD_FLAG_USE_RESOURCE fails */
+	fd = __vm_create_guest_memfd_resource(vm, page_size,
+					      GUEST_MEMFD_FLAG_USE_RESOURCE, -1);
+	TEST_ASSERT(fd < 0, "guest_memfd with -1 resource_fd should fail");
+	TEST_ASSERT_EQ(errno, EBADF);
+}
+
 #define ____gmem_test(__test, __vm, __flags, __gmem_size, args...)	\
 do {									\
 	int fd = vm_create_guest_memfd(__vm, __gmem_size, __flags);	\
@@ -476,6 +494,8 @@ static void test_guest_memfd(unsigned long vm_type)
 
 	test_guest_memfd_flags(vm);
 
+	test_resource_fd_invalid(vm);
+
 	__test_guest_memfd(vm, 0);
 
 	flags = vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS);

-- 
2.56.0.rc1.315.gc6ed9934b7-goog


