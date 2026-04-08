Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF883DA7EB
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669183; cv=none; b=nXQDOwT0WDHYK+41isJQuWVU7LfNNeux0iU/hqKkmHYDZTejP2JOm24fQgisTT/8PkZI9rZMYTJF/hxDtZzmubY2YWCn1J5tN7LCufhCgt9ELwIkvDRi+i2aNfXDehdTx9+IZSy6H5tg9zJXiKs5orzD13oKZlYeGQEUcqIUs9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669183; c=relaxed/simple;
	bh=ijzz7721/Uxn/cIYDu6fObmDcCDSsHBAV/IttC7RW3U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mrxa19L5LngTNqLb4tw07Vwpxa7p2EacUq6HvagnOlVL3WSU84RFVi4Muq4qW6xvaGeNK2xI9i104OwBMHZBjOf/HbxP/GhBl4HM5tR1DwFcIp6s/fOaTTtXYLh8gjmEyhzEAmSxfs5aWQMtlcX+6PtU5w9Ndq8rGem+sGwQqsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PaOXtJCh; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PaOXtJCh"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso87398a91.2
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 10:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775669181; x=1776273981; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qDOZkIKxiPaQK0xKrpR+eqPsSd9MFpMG2SR/o/KXRoA=;
        b=PaOXtJChxYFKDzExJRS+IfE4YVW3dWf5ljM0Ll46OTY6ZWk918PcxF253ENUgj2mKO
         YYv9gwbrcLqFqU26LmtNNdP3Q0CXX8uad/l8bMdaDEjTDn8g2Plre2aMObSjE77KBa7y
         nP7QlkACgmKF7yVf4Fvv95IzC0MzznEDGs1skBaSRHBOD2MBf6E0BilN1y61He2tVzxx
         pz8Muo4JW8o2nc+zuH4qbJyzFDUzVHmUbmpcdnj1XBYv7CU7symhKPgIaARK8C98PTIC
         Dc40zaYvDk8ZBpHUwmr9CgnFP63NfTe46SRvqqye6zv5Pc1yq0BTxBQ7Ow3zrR1S7iNh
         A2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775669181; x=1776273981;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDOZkIKxiPaQK0xKrpR+eqPsSd9MFpMG2SR/o/KXRoA=;
        b=hOf7do2g8k2FP0w0SeDBNldyisxH7Zb7hljjjiBTSkH+jY0wNw3OMQBdHNge488VAE
         k8k+kAcaoG6An9I4TX6gCZcQsHlmfWBiD3En/iW4gpXvUZ7tBTA70ZxZ1d6MzN6z7NMm
         7NB02QCxu6bQIQz5FSTl7BrHbhtr4CRF3A5Sr8NCYGKjxH57oEOwmDW1+gT0I4Ix3elB
         rt/R1xloOO1gMUWBt27jdBGY261LTwSWi0mR2lA2nj8r+gp/q4blXXN+HUn5IcwuTry/
         OykgHDx0cgUm4PefFZs4PXuH+ooAno/1INnnJt46aStlwnfh4WVRdl3gsLrwXvxjaZLA
         Skag==
X-Forwarded-Encrypted: i=1; AJvYcCUXW9fvw2QGk3gNAXh8ndR0gfTJDOhiXZ3Ahdg2YHKE/m3jVAx1SICklposeBLudEHotdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVxiUmgRQN78LJeyNLzVCgjRG0rKkpbd94DTheM0rBYURC3+4i
	+qgtdeBGlIUboUsnVUTsGakrZz9r7itp16hs7+od4sxOvjzvG1q+RglbgcS6DJEKBMRE0DCCoIo
	zYQ9yfA==
X-Received: from pjbhl3.prod.google.com ([2002:a17:90b:1343:b0:35d:a369:bbea])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c48:b0:35a:18b1:c245
 with SMTP id 98e67ed59e1d1-35e3574c101mr173541a91.3.1775669181262; Wed, 08
 Apr 2026 10:26:21 -0700 (PDT)
Date: Wed, 08 Apr 2026 17:24:48 +0000
In-Reply-To: <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-0-718f45eb7c75@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-0-718f45eb7c75@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775669168; l=3409;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=ijzz7721/Uxn/cIYDu6fObmDcCDSsHBAV/IttC7RW3U=; b=sRyqvXXGMNI5dZjLhIg1mr5q1swOpgzarSwWrk1NumIrtzSiI54MbVYzXC+7k09lxHjEFl4fv
 +zVMRi1MIeSBNGsLfAME4QP5EX4LbgDrrGBr1tO69JgO1LqU2DVF5ct
X-Mailer: b4 0.14.3
Message-ID: <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-7-718f45eb7c75@google.com>
Subject: [PATCH RFC v3 7/7] KVM: selftests: Test guest_memfd behavior with
 respect to stage 2 page tables
From: Lisa Wang <wyihan@google.com>
To: Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: rientjes@google.com, seanjc@google.com, ackerleytng@google.com, 
	vannapurve@google.com, michael.roth@amd.com, jiaqiyan@google.com, 
	tabba@google.com, dave.hansen@linux.intel.com, Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="utf-8"

Test that
+ memory failure handling results in unmapping of bad memory from stage
  2 page tables, hence requiring faulting on next guest access
+ when the guest tries to fault a poisoned page from guest_memfd, the
  userspace VMM informed with EHWPOISON

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 70 +++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 0ea4e7d7e6d5..6615ee8bfcd8 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -26,6 +26,7 @@
 #include "ucall_common.h"
 
 static size_t page_size;
+static uint64_t test_memory_failure_guest_gpa;
 
 static void test_file_read_write(int fd, size_t total_size)
 {
@@ -637,6 +638,73 @@ static void test_guest_memfd_guest(void)
 	kvm_vm_free(vm);
 }
 
+static void __guest_code_read(void)
+{
+	uint8_t *mem = (uint8_t *)test_memory_failure_guest_gpa;
+
+	READ_ONCE(*mem);
+	GUEST_SYNC(0);
+	READ_ONCE(*mem);
+	GUEST_DONE();
+}
+
+static void guest_read(struct kvm_vcpu *vcpu, int expected_errno)
+{
+	if (expected_errno) {
+		TEST_ASSERT_EQ(_vcpu_run(vcpu), -1);
+		TEST_ASSERT_EQ(errno, expected_errno);
+	} else {
+		vcpu_run(vcpu);
+		TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_SYNC);
+	}
+}
+
+static void test_memory_failure_guest(void)
+{
+	const uint64_t gpa = SZ_4G;
+	const int slot = 1;
+
+	unsigned long memory_failure_pfn;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	uint8_t *mem;
+	size_t size;
+	int fd;
+
+	if (!kvm_has_cap(KVM_CAP_GUEST_MEMFD_FLAGS))
+		return;
+
+	vm = __vm_create_shape_with_one_vcpu(VM_SHAPE_DEFAULT, &vcpu, 1, __guest_code_read);
+
+	size = vm->page_size;
+	fd = vm_create_guest_memfd(vm, size, GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED);
+	vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, size, NULL, fd, 0);
+
+	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	TEST_ASSERT(mem != MAP_FAILED, "mmap() for guest_memfd should succeed.");
+	virt_pg_map(vm, gpa, gpa);
+
+	test_memory_failure_guest_gpa = gpa;
+	sync_global_to_guest(vm, test_memory_failure_guest_gpa);
+
+	/* Fault in page to read pfn, then unmap page for testing. */
+	READ_ONCE(*mem);
+	memory_failure_pfn = addr_to_pfn(mem);
+	munmap(mem, size);
+
+	/* Fault page into stage2 page tables. */
+	guest_read(vcpu, 0);
+
+	mark_memory_failure(memory_failure_pfn, 0);
+
+	guest_read(vcpu, EHWPOISON);
+
+	close(fd);
+	kvm_vm_free(vm);
+
+	unmark_memory_failure(memory_failure_pfn, 0);
+}
+
 int main(int argc, char *argv[])
 {
 	unsigned long vm_types, vm_type;
@@ -644,7 +712,6 @@ int main(int argc, char *argv[])
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_GUEST_MEMFD));
 
 	page_size = getpagesize();
-
 	/*
 	 * Not all architectures support KVM_CAP_VM_TYPES. However, those that
 	 * support guest_memfd have that support for the default VM type.
@@ -657,4 +724,5 @@ int main(int argc, char *argv[])
 		test_guest_memfd(vm_type);
 
 	test_guest_memfd_guest();
+	test_memory_failure_guest();
 }

-- 
2.53.0.1213.gd9a14994de-goog

