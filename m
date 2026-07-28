Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F7943A7F4
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785240718; cv=none; b=FAczFWW3un/M7w/hABepJxZnajLvWl59L9OP2jbXAaFqIyEx5fHyEsk7hIZpm4DsY7H2J0w1UsHQZXd1pq965AF78jHAcs+S/5yqVyao0xaDokKeJlZpK1oBjTyt7NjlN/uz4E91ZDverNndYyzcI9fIm6xah9MeVVMngrMXXsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785240718; c=relaxed/simple;
	bh=//dOX4zO0X4ZoL8mOmAWmQQZNeudbM5AbI8VS+aFh2I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fINxndFvtjnzmq/7cxKBEoLOWMMQNoIfVmGftAfSyZRSMZxOI42uRpKqO2F4NFVIJsUszpEqRPII7B3uXhxJgj3m1TiX37mjhM6w3+KlDG6xKOy4EN1M0Hufna1rYsIqT5ynyWqGZBjmnlewWha43gyh5QCqR5lC7RTOb8wv1g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PwT0kHZg; arc=none smtp.client-ip=209.85.218.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PwT0kHZg"
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c15fc5a1b7eso276160266b.1
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 05:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785240713; x=1785845513; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jLf4NZ8GM7enE5DcNnXkHjbguMY0Wvl4QcagAqNt0Jg=;
        b=PwT0kHZgdGHMQk9bDTH7Ko/9eWgZRlWIlbQoAUqCWaIQryHfstL8Pgq/GOpThUgYsk
         lsHipXHcmKoOu3pRdq6kZDXZW6ewtYW0X2cL2Dg6u+BqBsC/y+VrWVpZgC/i/5QKjg43
         HyV/6xbdFrE9miA4FEtfvFTakf14NjHnIDiDoqr20vWx5swniYbLUD12XnRSYlIL8U6D
         WYw41KOuN2d8edkX2KiEDvyzSYdrEfSYzlStLhi/m2iI1yqSlTImch1qHGUv+rXr1bcx
         vVq0zIHG4/dheEptgjUv85x7Ecg7raCF3OL9ScCHqACZuQgvShJEEy82S0WNSLyB2vBb
         BO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785240713; x=1785845513;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jLf4NZ8GM7enE5DcNnXkHjbguMY0Wvl4QcagAqNt0Jg=;
        b=seFoKTnNq4gEfVLXuoxMpPNTZGFd0N9j8WbVZL6BGfD/3CVjsQZw41BMbO53nK0E3R
         hzgystO4IPsz0KQDalCCveaeQDiV5EVNNCRdjVxhgYwWM7ASwTjXDpZyS14fKCr6uzSS
         pll389Xd3JW7VlzlIM7XiIvm9yru/DPpDSOrWnuG2F5WX7/A8dDARBPapm7ImbbJXB0i
         PUQQtERsjBmJrC94grK+J6QAaUrsa2TN6NeTb9daBt36XYHusbo1sXK7nSXjQSn9H+6r
         aQhiW9Pv06K+RRp0zEPYDIJZrO5PsmNL/gc9ehuXhTCtIE2mkXRB3iRoTGiLOulG80bP
         J38g==
X-Forwarded-Encrypted: i=1; AHgh+RpqBGuG+xw82cY3JSXcPFxuvVWzll/vtFuX0mQzCIJ/CbHm8pQ9PjqiwplQDqftorRuR0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxul3HUbZCrDXcHM51x91s8XYQCbFZpUX92jb40C77SjvL7JAg6
	ZKBoFdRrjhrZty8yECz5w6Xe8Fc3iR70vBpkkkKGybl6DrrkWwrCQQL2A9pk7EcTfdNN985tdXu
	3PAr0WLJVP6hk3ID9yQ==
X-Received: from ejet14.prod.google.com ([2002:a17:906:178e:b0:c09:e2fc:4344])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:6a02:b0:c1f:586a:8514 with SMTP id a640c23a62f3a-c1f725124camr96102666b.65.1785240713183;
 Tue, 28 Jul 2026 05:11:53 -0700 (PDT)
Date: Tue, 28 Jul 2026 12:11:37 +0000
In-Reply-To: <20260728121138.1103610-1-tarunsahu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260728121138.1103610-11-tarunsahu@google.com>
Subject: [PATCH v4 10/11] KVM: selftests: Split ____vm_create() and add vm_create_from_fd()
From: Tarun Sahu <tarunsahu@google.com>
To: ackerleytng@google.com, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, seanjc@google.com, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Tarun Sahu <tarunsahu@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: linux-kselftest@vger.kernel.org, andre.przywara@arm.com, 
	michael.roth@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	will@kernel.org, vannapurve@google.com, maz@kernel.org, fvdl@google.com, 
	kvm@vger.kernel.org, oliver.upton@linux.dev, kvmarm@lists.linux.dev, 
	alexandru.elisei@arm.com, skhawaja@google.com, aneesh.kumar@kernel.org, 
	linux-doc@vger.kernel.org, David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, 
	kexec@lists.infradead.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"

Refactor ____vm_create() in the KVM selftest library to extract its
initialization steps into separate helpers vm_init_fields() and
vm_init_memory_properties(). Also introduce vm_create_from_fd() to
instantiate a struct kvm_vm from an existing VM file descriptor.

This allows test setups (such as guest_memfd preservation tests) to
reconstruct and initialize a struct kvm_vm when restoring preserved
VMs across live updates. No functional change is introduced for
existing tests.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  3 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 49 ++++++++++++++++---
 2 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 04a910164a29..0626efa5a73b 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -471,6 +471,9 @@ const char *vm_guest_mode_string(u32 i);
 
 void kvm_vm_free(struct kvm_vm *vmp);
 void kvm_vm_restart(struct kvm_vm *vmp);
+void vm_init_fields(struct kvm_vm *vm, struct vm_shape shape);
+void vm_init_memory_properties(struct kvm_vm *vm);
+struct kvm_vm *vm_create_from_fd(int vm_fd, struct vm_shape shape);
 void kvm_vm_release(struct kvm_vm *vmp);
 void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename);
 int kvm_memfd_alloc(size_t size, bool hugepages);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 195f3fdae1e3..d3f98d9eb709 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -276,13 +276,8 @@ __weak void vm_populate_gva_bitmap(struct kvm_vm *vm)
 		(1ULL << (vm->va_bits - 1)) >> vm->page_shift);
 }
 
-struct kvm_vm *____vm_create(struct vm_shape shape)
+void vm_init_fields(struct kvm_vm *vm, struct vm_shape shape)
 {
-	struct kvm_vm *vm;
-
-	vm = calloc(1, sizeof(*vm));
-	TEST_ASSERT(vm != NULL, "Insufficient Memory");
-
 	INIT_LIST_HEAD(&vm->vcpus);
 	vm->regions.gpa_tree = RB_ROOT;
 	vm->regions.hva_tree = RB_ROOT;
@@ -380,9 +375,10 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
 	if (vm->pa_bits != 40)
 		vm->type = KVM_VM_TYPE_ARM_IPA_SIZE(vm->pa_bits);
 #endif
+}
 
-	vm_open(vm);
-
+void vm_init_memory_properties(struct kvm_vm *vm)
+{
 	/* Limit to VA-bit canonical virtual addresses. */
 	vm->vpages_valid = sparsebit_alloc();
 	vm_populate_gva_bitmap(vm);
@@ -392,10 +388,47 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
 
 	/* Allocate and setup memory for guest. */
 	vm->vpages_mapped = sparsebit_alloc();
+}
+
+struct kvm_vm *____vm_create(struct vm_shape shape)
+{
+	struct kvm_vm *vm;
+
+	vm = calloc(1, sizeof(*vm));
+	TEST_ASSERT(vm != NULL, "Insufficient Memory");
+
+	vm_init_fields(vm, shape);
+
+	vm_open(vm);
+
+	vm_init_memory_properties(vm);
+
+	return vm;
+}
+
+struct kvm_vm *vm_create_from_fd(int vm_fd, struct vm_shape shape)
+{
+	struct kvm_vm *vm;
+
+	vm = calloc(1, sizeof(*vm));
+	TEST_ASSERT(vm != NULL, "Insufficient Memory");
+
+	vm_init_fields(vm, shape);
+
+	vm->kvm_fd = _open_kvm_dev_path_or_exit(O_RDWR);
+	vm->fd = vm_fd;
+
+	if (kvm_has_cap(KVM_CAP_BINARY_STATS_FD))
+		vm->stats.fd = vm_get_stats_fd(vm);
+	else
+		vm->stats.fd = -1;
+
+	vm_init_memory_properties(vm);
 
 	return vm;
 }
 
+
 static u64 vm_nr_pages_required(enum vm_guest_mode mode,
 				u32 nr_runnable_vcpus,
 				u64 extra_mem_pages)
-- 
2.55.0.229.g6434b31f56-goog

