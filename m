Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED687535FBC
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 19:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883537; cv=none; b=Q6RgrulLgB6G9XEx/ZJ9VDQ7jDUuwYBPcoO7h140s2IHepX+AiP5U0AOLMThtwKDWy6mtn2zx7KD7JL8a4c/TtJgnNksk8+u5KyYN4TDJ440g/4qLO/JpNb8PZjYmOrtrsWu6ayEqgRaWyrIUKNRxD12gV9RSyWN9czJxP8OCQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883537; c=relaxed/simple;
	bh=sZyyJs/KlSsWRD9sQg89mVg98goUj8UDv1HtfnjzwME=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CvZcOqT/2fXo2QCmIeaSN17lbq5aSZ80DUPZGcHLoEkHwRcnM0J52ItDDBONdY1TYCmPxEEEx0hmpqGj3R9h4een9LeLQh4h8nBb5E7BP9Yw9EjRKy/4C2jGgxOhXUaIKEBDzb8BkntC5Yq7bEWg8HL3VZmAO4/Ge56YBfz8w00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MCHzQag/; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MCHzQag/"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d02df2bf09so48053355ad.0
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 12:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790883534; x=1791488334; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q+jGeioH3xBzsz+B9rJvX4YPTjLXl5pfC6kAHkC+4bE=;
        b=MCHzQag/DZVbzWEby/qDBxcuBcoAc+tVE5Qm+pYfupJlwaatAMkrEgEprKe2dKaNPZ
         6lV3hbXwKwqCwSytgMkNb28AoxPVbPvGUv/LsHDLn5wUWW3mTJHhJ0eVpf1d0mabm4gt
         FsdlZk96RdB4LgQ98m1QCgE8dKKlIOUxbtBTZwNBDnNvxdZj5dshU3xgi0R5yYxoy3Sr
         74/d5KI84XIE6Z/yr2MtXQRmR+EjulpdOjK3IcdpQvjKoSGELeMKX5yPZMqwdHv8l7rS
         fooy4Rm26MuVD1FEspq2a6aOB9r1ByKq4eSUsU72DC/ooPN7Zwx3n8A23pC3J7iBvXq9
         7Psg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790883534; x=1791488334;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+jGeioH3xBzsz+B9rJvX4YPTjLXl5pfC6kAHkC+4bE=;
        b=QSpXGvR8q1Uu0o7LonG6mAF8SQqUm2Ci+jWg6hY+wGHJ/5AiclabujEKKOBqGA9TUI
         0I+Y3PoP3mA155hzv5RA9vY4e0cCTK56A4PjAVSEtg1jhtZX6gk4wt8OP+isH20NZnuK
         m48Jp3UtCoVcBBwf3dqg6IbrGLawYGkeUemZ3AQhQ0Z2OhG2qWOI0mTcfU/zS1uXoKx/
         pi3BLKLFCq9jDKevnvn4BgZPLTWR0I4lW6hl6fqcAR6851rLVki+UrlOqLfUW+dCq608
         N7mzE0/vLhaxwPDjN+NkfSmX49eMsHYsU3xhqP9YFKeH9snnwLutjpKb10IQelnIi9CA
         asog==
X-Forwarded-Encrypted: i=1; AKwUvBxSGAhKw4BWlUuVYO6N1ivhrEWBGKEZC325madmQbRZ6h7otcXk68K8fJ11Ymngt9dqre4=@vger.kernel.org
X-Gm-Message-State: AFq9FYISBcpVGnbUwJCclfqbW579ChMyN6XPxubqDv1ebxZHeFio1fy1
	OiH1nRQ+JlYSAoOZblA9agdA+fzM7nghKtZZvjq8srZhN5idN5EpQWm4FXNf79NXjZZQ3OQ4oxC
	f/SjouQ==
X-Received: from plap1.prod.google.com ([2002:a17:902:f081:b0:2df:9edc:303f])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:186:b0:2df:ab36:f145
 with SMTP id d9443c01a7336-2e49b685f37mr4147425ad.68.1790883533313; Thu, 01
 Oct 2026 12:38:53 -0700 (PDT)
Date: Thu, 01 Oct 2026 19:37:40 +0000
In-Reply-To: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790883521; l=3515;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=sZyyJs/KlSsWRD9sQg89mVg98goUj8UDv1HtfnjzwME=; b=O95g8bknqdRknghTtLqM3Z47uJTLV1rIB0wGM6T628Yfa65tkZlZ+mNz7Y+7PyuYycoq14Rsb
 L/WWSkzNI3iDFwRxhnitj/S/Jwpuy/HU1djFdGF3Vfc53bobmxENV8/
X-Mailer: b4 0.14.3
Message-ID: <20261001-tdx-selftests-v15-13-7c62a5d8a992@google.com>
Subject: [PATCH v15 13/23] KVM: selftests: Support guest_memfd in-place conversion
From: Lisa Wang <wyihan@google.com>
To: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng <ackerleytng@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="utf-8"

With guest_memfd in-place conversion, the memory region can be set as
shared, eliminating the need for dual-backed memory.

By setting the region to shared initially, the KVM selftest framework
can populate the mmap()-ed guest_memfd memory just like any standard
memory provider.

For CoCo VMs, pages that need to be private are explicitly set to
private before executing the VM.

Signed-off-by: Lisa Wang <wyihan@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c         | 20 ++++++++++++++------
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c |  6 +++++-
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 7625908caf21..f474664b5d92 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -494,8 +494,10 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
 	u64 nr_pages = vm_nr_pages_required(shape.mode, nr_runnable_vcpus,
 						 nr_extra_pages);
 	struct userspace_mem_region *slot0;
+	u64 gmem_flags = 0;
 	struct kvm_vm *vm;
-	int i, flags;
+	int flags = 0;
+	int i;
 
 	kvm_set_files_rlimit(nr_runnable_vcpus);
 
@@ -505,14 +507,20 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
 	vm = ____vm_create(shape);
 
 	/*
-	 * Force GUEST_MEMFD for the primary memory region if necessary, e.g.
-	 * for CoCo VMs that require GUEST_MEMFD backed private memory.
+	 * Force GUEST_MEMFD for the primary memory region if necessary, and
+	 * initialize it as shared if in-place conversion is supported, so the
+	 * selftest framework can populate it exactly like other memory
+	 * providers.
 	 */
-	flags = 0;
-	if (is_guest_memfd_required(shape))
+	if (is_guest_memfd_required(shape)) {
 		flags |= KVM_MEM_GUEST_MEMFD;
+		if (kvm_has_gmem_attributes)
+			gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED |
+				      GUEST_MEMFD_FLAG_MMAP;
+	}
 
-	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags);
+	vm_mem_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags,
+		   -1, 0, gmem_flags);
 	for (i = 0; i < NR_MEM_REGIONS; i++)
 		vm->memslots[i] = 0;
 
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index e348507a6be8..40ee9b1951c2 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -23,6 +23,8 @@ void tdx_vm_setup_boot_code_region(struct kvm_vm *vm)
 	gpa_t gpa;
 	u8 *hva;
 
+	if (kvm_has_gmem_attributes)
+		gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED | GUEST_MEMFD_FLAG_MMAP;
 	vm_mem_add(vm, VM_MEM_SRC_SHMEM, alloc_gpa, TD_BOOT_CODE_SLOT,
 		   nr_pages, KVM_MEM_GUEST_MEMFD, -1, 0, gmem_flags);
 
@@ -44,9 +46,11 @@ void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpu
 	size_t boot_params_size = sizeof(struct td_boot_parameters) +
 		nr_runnable_vcpus * sizeof(struct td_per_vcpu_parameters);
 	int npages = DIV_ROUND_UP(boot_params_size, PAGE_SIZE);
-	const u64 gmem_flags = 0;
+	u64 gmem_flags = 0;
 	gpa_t gpa;
 
+	if (kvm_has_gmem_attributes)
+		gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED | GUEST_MEMFD_FLAG_MMAP;
 	vm_mem_add(vm, VM_MEM_SRC_SHMEM, TD_BOOT_PARAMETERS_GPA,
 		   TD_BOOT_PARAMETERS_SLOT, npages,
 		   KVM_MEM_GUEST_MEMFD, -1, 0, gmem_flags);

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

