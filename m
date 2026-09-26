Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D305337BA4;
	Sat, 26 Sep 2026 00:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790383852; cv=none; b=EwvMMeooTvlKXVPZ/H+CTX/Ne5mJNVyW1QSz9AZQsLAZyoQ7zh+rjBUPkB18Z5iXt6wlZdBOEF+xKPOXNTgrJ9kN3xrcEh+X1znXLcYIcRphs+Oon27UrFbVL5JqD6FH6cBsSHoXuCu+r5tURAasZpx1gPlTOegex/hGsl4cbY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790383852; c=relaxed/simple;
	bh=WL6SVj5nkt1VSLicwCms+MFdPTGQsPTJ4cFpwfrA8CY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kz2GoytpUoeKsjC0E7E4o9ilQJHQjiMp/amPTLS2oFhUVhGJ5PrUQw4xVbQUHEr4/uOf7IcQ8kWZxclctEtYVzzxrjsbKJvD1PO9EoDKCuf6DSBwDHV4kiP6HNSgnUsUeE+ICA0ta3Wk2qWlrSFVe1wFmN4bpUU/R6hPDzHyfOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3N1YqtV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3N1YqtV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A039C2BD04;
	Sat, 26 Sep 2026 00:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790383852;
	bh=WL6SVj5nkt1VSLicwCms+MFdPTGQsPTJ4cFpwfrA8CY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=p3N1YqtVRuIgAdzCdcKxpzfvc2kPcvmzPpbElcxGhXp0FJV4hAHtxSuXWUmNNgveF
	 J3AclXs7McCNXymGq7Dmscv58eNZQ4hNFzy3Hnc/73gXKQeu4XAJkvhvPC3iIrlqDH
	 1yrixPqZMbS9sC6RT/IeUGBS89GPJZEg5IJOY83AItfv0l1lgAglGxFQhG2MI+rH1+
	 hDY6ZGlINlN+7Xzb84vjexHtM5+Z5AVo7pcfHI9LtUrUnfQQyca2LaT87CnCMfxhd9
	 O5DH/MaCVQTfkI6yASvYueRy07tyyfZis1WbZsaKLdJJAiGOCa8OFGg1DBt/sbIjqx
	 Px4xJrqd1DyCg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5674CC9832F;
	Sat, 26 Sep 2026 00:50:52 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 25 Sep 2026 17:51:03 -0700
Subject: [PATCH RFC 16/17] KVM: selftests: Test guest execution with
 tmpfs-backed guest_memfd
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-gmem-tmpfs-backend-v1-16-d36159822d18@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790383850; l=2762;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=eEUCNuv+RKC7m7QsxpNwXumKz8ugTchjMOMGNl/2g/s=;
 b=A4r1WBbxOP9ZOlG7QCGCgeTR0iYmACXawNF2ydSLaVCH5b3ki+XdoPlrDcX39UZFv73bZqeB4
 75FNsbJvLzPAAoFskLa0UlxlDUdH77Y2b4eHQ71jrqFWXwLRW9STmEN
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Test that a guest vCPU can execute instructions and read/write memory
mapped into a guest_memfd instance that is backed by a tmpfs resource
pool descriptor.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 57 ++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 345b41c912a18..bf369874f2647 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -829,6 +829,62 @@ static void test_guest_memfd_guest(void)
 	kvm_vm_free(vm);
 }
 
+static void test_guest_memfd_guest_resource(void)
+{
+	const gpa_t gpa = SZ_4G;
+	const int slot = 1;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int pool_fd, fd, i;
+	size_t size;
+	u8 *mem;
+
+	if (!kvm_check_cap(KVM_CAP_GUEST_MEMFD_FLAGS))
+		return;
+
+	pool_fd = create_tmpfs_pool_fd("never", true, page_size);
+	if (pool_fd < 0)
+		TEST_REQUIRE(false);
+
+	vm = __vm_create_shape_with_one_vcpu(VM_SHAPE_DEFAULT, &vcpu, 1, guest_code);
+
+	TEST_ASSERT(vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS) & GUEST_MEMFD_FLAG_MMAP,
+		    "Default VM type should support MMAP, supported flags = 0x%x",
+		    vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS));
+	TEST_ASSERT(vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS) & GUEST_MEMFD_FLAG_INIT_SHARED,
+		    "Default VM type should support INIT_SHARED, supported flags = 0x%x",
+		    vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS));
+
+	size = max_t(size_t, vm->page_size, page_size);
+	fd = __vm_create_guest_memfd_resource(vm, size,
+					      GUEST_MEMFD_FLAG_MMAP |
+					      GUEST_MEMFD_FLAG_INIT_SHARED |
+					      GUEST_MEMFD_FLAG_USE_RESOURCE,
+					      pool_fd);
+	TEST_ASSERT(fd >= 0, "guest_memfd with tmpfs pool should succeed");
+
+	vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, size, NULL, fd, 0);
+
+	mem = kvm_mmap(size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
+	memset(mem, 0xaa, size);
+	kvm_munmap(mem, size);
+
+	virt_map(vm, gpa, gpa, size / vm->page_size);
+	vcpu_args_set(vcpu, 2, gpa, size);
+	vcpu_run(vcpu);
+
+	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
+
+	mem = kvm_mmap(size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
+	for (i = 0; i < size; i++)
+		TEST_ASSERT_EQ(mem[i], 0xff);
+
+	close(fd);
+	close(pool_fd);
+	kvm_vm_free(vm);
+}
+
+
 int main(int argc, char *argv[])
 {
 	unsigned long vm_types, vm_type;
@@ -849,4 +905,5 @@ int main(int argc, char *argv[])
 		test_guest_memfd(vm_type);
 
 	test_guest_memfd_guest();
+	test_guest_memfd_guest_resource();
 }

-- 
2.56.0.rc1.315.gc6ed9934b7-goog


