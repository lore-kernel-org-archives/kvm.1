Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E3D407113
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773963068; cv=none; b=tSIKfIHBz6r9+tN95qZ9ZqjBkOWKCR9IS1/LstiKY5cVpyaj9xIgFoMy3hu5U+Zh4xcan4O3nGLpejkDdvH9LnSEAzRBgZUAF/fHoTUiH2iPD7zZmle22QbpvJtO2umfgxSeptMQXA2LjJEWY1FrHbE91OF4BZsUyZjCoAyVnww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773963068; c=relaxed/simple;
	bh=wltySrG4vozgVjDjb43L2B3dD6dgSygZ1tpNGMuiOvU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XV7h2DVHr3w1jZ4nrQ3mT1vleuxxRRePNIS0KKPY4RbZ+4j4kwtELCmaP4kx2CIkuWuOTZN22UdLcEhs8J0AwGz7cnuXNQkHlkAk4z9tndB988VU9vdYVQCQbRDw0CRBL6mzZdQcIdh/oOihFyqQRlYG3bS4MkoxR6KhyeWL+yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iYucmjAS; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iYucmjAS"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b069bfa817so20637395ad.3
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 16:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773963066; x=1774567866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zfyz6j+K0eCUgYIAireZB6wFZ/MNqUoA9mP0eBvWMq8=;
        b=iYucmjASYPBw8+929cUl1yJm3d6Esry5KMVnxg252ptKGZWlr3zsjeVrOlIP3qeziV
         9iPe5EeWHQmpLHcF5lz8HAMUGD+8mo4v0QhMnCaAu1ld5+VW6T9sjgLEKS+NL5JEq3y+
         VlpKcruLFos2R+STo+3uFGn6KTTbZDjcxhr8jAM3Hwrim/CoKvA6vXrfMx/hoLp2Qbhn
         toqKhyoHj3HJgNVgRtzOJQ83tGWUXQzX0cV/pi+WPxgRP+qwij5WrTPBcsvKNr/Wf8DW
         craCZdUNcJJ1JvW2Cwgevx65buGiwdJCzcT7i97d+AuFlVfrp2ADuOiUbIh/9rkIcs3Q
         fFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773963066; x=1774567866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zfyz6j+K0eCUgYIAireZB6wFZ/MNqUoA9mP0eBvWMq8=;
        b=NnmTR7xw3Lz8hJaryow5xHG7eU1Fj/P2LcO9BqYfC7DIuvvQVrFbRL4ZGElOb3LoS/
         SX7Fkz0sA4c4vwDJG0hlBnCsJbXJp60bNPJEp8u12hZmXzyUoHtF3nTM2AFqzRXy2DqR
         sG3qwc6jDjzuEIG7uuQgcPC/uxSpOpxjfdvvqUZ+h6A2YjFJ0oGKAeFQz8r3vmXrPuVF
         tsMQzP/HUKbQPYh9FIvbDT55g9P670I0J8wVkKdNlyieahKRoglesqvwMMFRpkC9IJRa
         kmmdSQJKzWZnsp5+eZZ+B9o0wVsrWivTsu5A+CSW1AKt+sshDd2tVMTtTK+JOLXUDHiJ
         y5ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWu/dNR4vkT6Nx3WpNQUws6QV9uASlaoEwnVWn0c/VZHvqq4eMYCmCyah9BXmElXf7GWRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXalZ2LDc911Is06J6+/0aTfsMeXCinoTn02kInMpGrMRycUqi
	QyfLi4Wn/rHpj2rD3N0ied8gZrQSpQFgs18ySANVRN+xQK+ilbgKjRBb/Xy5AVjDFm+7dT2kecn
	0r1hnjg==
X-Received: from plbks8.prod.google.com ([2002:a17:903:848:b0:2b0:52e8:584])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f84:b0:2b0:4b3a:9b4b
 with SMTP id d9443c01a7336-2b0826e3368mr7472585ad.16.1773963066002; Thu, 19
 Mar 2026 16:31:06 -0700 (PDT)
Date: Thu, 19 Mar 2026 23:30:34 +0000
In-Reply-To: <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-0-92c596402a7a@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-0-92c596402a7a@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773963053; l=2809;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=wltySrG4vozgVjDjb43L2B3dD6dgSygZ1tpNGMuiOvU=; b=MzayBc1lrUG8AtictP2UDRMFjSP2+93iY+nziVK024vQNTr5SivQhuoSDPM9eVFFuI+tPuw4N
 h7fKV+BGoAJDypYm6vtelBw4anbbG1sxuJC+lRnOm/wX8wAEripkYXw
X-Mailer: b4 0.14.3
Message-ID: <20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-7-92c596402a7a@google.com>
Subject: [PATCH RFC v2 7/7] KVM: selftests: Test guest_memfd behavior with
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
 tools/testing/selftests/kvm/guest_memfd_test.c | 65 ++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 445e8155ee1e..50907875dc43 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -637,6 +637,70 @@ static void test_guest_memfd_guest(void)
 	kvm_vm_free(vm);
 }
 
+static void __guest_code_read(uint8_t *mem)
+{
+	READ_ONCE(*mem);
+	GUEST_SYNC(0);
+	READ_ONCE(*mem);
+	GUEST_DONE();
+}
+
+static void guest_read(struct kvm_vcpu *vcpu, uint64_t gpa, int expected_errno)
+{
+	vcpu_args_set(vcpu, 1, gpa);
+
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
+	/* Fault in page to read pfn, then unmap page for testing. */
+	READ_ONCE(*mem);
+	memory_failure_pfn = addr_to_pfn(mem);
+	munmap(mem, size);
+
+	/* Fault page into stage2 page tables. */
+	guest_read(vcpu, gpa, 0);
+
+	mark_memory_failure(memory_failure_pfn, 0);
+
+	guest_read(vcpu, gpa, EHWPOISON);
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
@@ -657,4 +721,5 @@ int main(int argc, char *argv[])
 		test_guest_memfd(vm_type);
 
 	test_guest_memfd_guest();
+	test_memory_failure_guest();
 }

-- 
2.53.0.959.g497ff81fa9-goog

