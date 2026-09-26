Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6133115AE;
	Sat, 26 Sep 2026 00:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790383852; cv=none; b=DwkKS+IpOKomZoI6ia1v2QASbYAg0OoFI/wfzi9UVPGVBkP36aioemNSd5Cr7edtpSIZGosG17QmqxwMBXxbC6a5y4hCb3RDa83SyqzFCvFMzskuNjaKNH4a2QG9eJjWxsvXwAFz7Onnx9b22se8JHs6oO2KnjZKkzwbKyQ07QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790383852; c=relaxed/simple;
	bh=ZQkHIEo90myH/etAY2BZvV0PdV/I+2f0qu5W0si1/Vg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n7LAbc4VvmUpOyU+mho8QrxoeO0+HkHZIWuMqZhZTbQV4ZSqgX+liFbp7dm46h0j0E5zjLNv1R+o0N4+VJP7Q/hdn18O/yvgDReaDRSeqaqv6Xaz3ICTLjTHuiwbkDF9C9EB2LYCIHdIFG9kSpiSIXwJJKTuQfg2311okvi0wI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnu/hdLL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnu/hdLL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C714DC2BD01;
	Sat, 26 Sep 2026 00:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790383851;
	bh=ZQkHIEo90myH/etAY2BZvV0PdV/I+2f0qu5W0si1/Vg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gnu/hdLL/8rQ1eCpICBDMgQ5bdAfMXUZB6QclisY2veSfL3KWIII4fqBZJYUbNLXp
	 gQeewK6auA3yOn1u0DybDlBl1Ma8sRYeKLTxqDUEH0E9tQKvnfdlPLP1VBfE1GIjZh
	 OIp5kyd8evCiqHhDMCft3eUwZrsrYf6hOBXhO/DHPmm664vH5pQ4Y8xto2O7yG7Lw/
	 Gyk79kiUiMgS4apZ8IdUqc+/Cp8VQNlKPRNIrQUzir4XO3B78NowK3TpB0eaqESPmR
	 UL1NrQQMWmCfQgNokiG42aDhn2vItl+BXAterA85xlL75uU2yAvZZ+J5uO+Gy5hR7L
	 IDfa0vpXFdngA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F4BC98331;
	Sat, 26 Sep 2026 00:50:51 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 25 Sep 2026 17:50:55 -0700
Subject: [PATCH RFC 08/17] KVM: selftests: Test rejection of tmpfs file for
 resource_fd
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-gmem-tmpfs-backend-v1-8-d36159822d18@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790383850; l=1833;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=pY+7zel/xk6auUHj9TI6BcpE5A6Lb+XZc+WYc5WnDfM=;
 b=6ICqdR//hE/RTxLIzxROFfy94V96cNAwZqPG5viJrO4RVBZA3wcH6/zTFcVp2BIl7ddnTJ1D3
 XWEO8D7UwtkBxgYBX0V2bQmanCnt1ukpEayqoKxStzdpPNHwXUpIqF5
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Add test coverage verifying that passing a regular file from tmpfs
as a resource file fails with ENOTDIR. Only directory file descriptors
representing the mount root are supported as resource pools.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 31bc74c4c26bd..a7a1b5470cb2c 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -457,6 +457,26 @@ static void test_resource_fd_unsupported_fs(struct kvm_vm *vm)
 	close(file_fd);
 }
 
+static void test_resource_fd_tmpfs_file(struct kvm_vm *vm)
+{
+	int fd, file_fd;
+
+	/*
+	 * Passing a regular file from tmpfs (e.g. via memfd) is rejected by
+	 * the provider attach callback with ENOTDIR because only directory
+	 * FDs representing the mount root are supported resource pools.
+	 */
+	file_fd = memfd_create("test_tmpfs_file", 0);
+	TEST_ASSERT(file_fd >= 0, "memfd_create failed");
+
+	fd = __vm_create_guest_memfd_resource(vm, page_size,
+					      GUEST_MEMFD_FLAG_USE_RESOURCE,
+					      file_fd);
+	TEST_ASSERT(fd < 0, "guest_memfd with tmpfs file fd should fail");
+	TEST_ASSERT_EQ(errno, ENOTDIR);
+	close(file_fd);
+}
+
 #define ____gmem_test(__test, __vm, __flags, __gmem_size, args...)	\
 do {									\
 	int fd = vm_create_guest_memfd(__vm, __gmem_size, __flags);	\
@@ -517,6 +537,7 @@ static void test_guest_memfd(unsigned long vm_type)
 
 	test_resource_fd_invalid(vm);
 	test_resource_fd_unsupported_fs(vm);
+	test_resource_fd_tmpfs_file(vm);
 
 	__test_guest_memfd(vm, 0);
 

-- 
2.56.0.rc1.315.gc6ed9934b7-goog


