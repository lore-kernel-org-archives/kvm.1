Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6DD3DB32A
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735940; cv=none; b=NWbFEIXFiI1UTUAxgrQM0RfC5fZMgEeZSyr7kzhnrnSB6R37iH2YR4ivC2DwqiLYDNf/7jUnCOUqFRAzFYTjVERNUFimlQ9wtAIZYRD2k/GSI6lUxRsax/w5fGdkP9zhiZLPoE9fWqDTdEzz0b5XMxxZIqzExn0wQnWKVDEoX3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735940; c=relaxed/simple;
	bh=YLgunGHL+AL+LncG9sWVRtMDvArYtWgzJi2/TAMkgIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DxOzHDgu6/2i8XFjhxNREsIAk4BjGtu11GRdCJJ7iiZl1wE+yHDZ2clVlnWbXRSYxS9RXEgV4A9N842tLAu4YPbUjCp2HFV850jtZ90HeKBiTFHCe7sFRjgN2TQOdQ6flPGN6GeprGAvoz1cub3EA+PJHhOJuL52oFFyJfTu8pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u/XSN1Fc; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u/XSN1Fc"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfa55c9430so9740095ad.0
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 02:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735932; x=1788340732; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+cjy+nMsHw5PBRs0QTAeMD0IiOId+CkLeVE5YuR6Qzo=;
        b=u/XSN1Fcxxgy8VZ3iw5SCAJ/vZVtgEVYK33du3Alolfj7F/EFGn/xxmEQWCTo7LWXy
         pt8oks8yz4QWfrVTBiVbuEHWlibddtlxUyvZZjZyGXR2bzSq7gmCswIW2lDjnPSOpHg2
         c03LGIu0A5uffzAwEvZr5pmcfxrmSs6zdTuhhUq9N2BjoU0/VEuFFIN4GpfIKRlq2Y8x
         8DrdsHiGo110yrVW/g8UtrKKaSysTHp+tMA2m6w/5r5u5Ls7E1ZFpU5yRPSYqjp6CG+A
         4Ob/dOwgfc6dK5PSmR43cCEMMRrkPDi2Y3CRaN0haSGkJU0oeVjM9iI3S3EoNiH2/JVI
         4V8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735932; x=1788340732;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+cjy+nMsHw5PBRs0QTAeMD0IiOId+CkLeVE5YuR6Qzo=;
        b=JbuVNNDS89y0S9rCdVubS+OT2bH9fSzdPo7NP6pXzftmhLGOHtuu206J4Nwz24wpzR
         PgjY/BiHwtpC4Sm1dsdzDRWXlSRZVUUE6YNqV59jNjseNFh4CyyKxY+eMRz9CSgCwAIb
         hkRPQPMMrn7rnpV3mEIdK9xSv+/KaTRpHkdjeh6DmooOj9eWCW3Q7dk7IyRNHpEXLVFm
         rtqDeJVOX1NmXF8wb2GgHreXxHZc4wWxdkLM4bsb5zTXqZ4tbDRPS5lnvD9gsOiCJhoW
         8rR4VS7ammbxIfEJDXLLHiVppQXEUSabKpOKroZNBqmcRZJculN54yRnu/j/r+FhJmY0
         kksQ==
X-Gm-Message-State: AFuF++mGVosx2m5BZzMA4+L89AZm2E97ZvqJRSz5T5/ppI/aNgXcpZVS
	6MBZS/N2aGydaFkgghRdsOcN0bCo8k1/b566hGP93iLbhf387PxxIpjqiSb8aPRqBHMzWO5qQmA
	Cr7VvYRms50ZN592mbpSHmykJpg==
X-Received: from plhq8.prod.google.com ([2002:a17:903:11c8:b0:2d2:f257:ff6b])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:b48:b0:2cf:b68a:340 with SMTP id d9443c01a7336-2d707b7f737mr84539505ad.10.1787735931763;
 Wed, 26 Aug 2026 02:18:51 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:24 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=5047;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=mb3uaLD2f73gjBg5EOuTiW5jIrrwXcBsUyiQfGfT2N8=; b=JETiA2QHKaiExWNZCyGlrQT84yI/YT1kdJUQpYKxpqoY5RadHrf8I2YGHK3b4T5c72XHbZUpU
 2Jn4PILDbMQB9KRhsSDSu6kzn90BQELMLsi1gc6Ru6P3p1cgHLRu0um
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-26-0a15d8a799aa@google.com>
Subject: [PATCH v11 26/46] KVM: selftests: Rename guest_memfd{,_offset} to gmem_{fd,offset}
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Fuad Tabba <fuad.tabba@linux.dev>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

Rename local variables and function parameters for the guest memory file
descriptor and its offset to use a "gmem_" prefix instead of
"guest_memfd_".

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h |  6 +++---
 tools/testing/selftests/kvm/lib/kvm_util.c     | 26 +++++++++++++-------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 5a7a455b53875..cf49a84de02e8 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -690,17 +690,17 @@ int __vm_set_user_memory_region(struct kvm_vm *vm, u32 slot, u32 flags,
 				gpa_t gpa, u64 size, void *hva);
 void vm_set_user_memory_region2(struct kvm_vm *vm, u32 slot, u32 flags,
 				gpa_t gpa, u64 size, void *hva,
-				u32 guest_memfd, u64 guest_memfd_offset);
+				u32 gmem_fd, u64 gmem_offset);
 int __vm_set_user_memory_region2(struct kvm_vm *vm, u32 slot, u32 flags,
 				 gpa_t gpa, u64 size, void *hva,
-				 u32 guest_memfd, u64 guest_memfd_offset);
+				 u32 gmem_fd, u64 gmem_offset);
 
 void vm_userspace_mem_region_add(struct kvm_vm *vm,
 				 enum vm_mem_backing_src_type src_type,
 				 gpa_t gpa, u32 slot, u64 npages, u32 flags);
 void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		gpa_t gpa, u32 slot, u64 npages, u32 flags,
-		int guest_memfd_fd, u64 guest_memfd_offset);
+		int gmem_fd, u64 gmem_offset);
 
 #ifndef vm_arch_has_protected_memory
 static inline bool vm_arch_has_protected_memory(struct kvm_vm *vm)
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 3413d45e34faf..af501a27211a2 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -970,7 +970,7 @@ void vm_set_user_memory_region(struct kvm_vm *vm, u32 slot, u32 flags,
 
 int __vm_set_user_memory_region2(struct kvm_vm *vm, u32 slot, u32 flags,
 				 gpa_t gpa, u64 size, void *hva,
-				 u32 guest_memfd, u64 guest_memfd_offset)
+				 u32 gmem_fd, u64 gmem_offset)
 {
 	struct kvm_userspace_memory_region2 region = {
 		.slot = slot,
@@ -978,8 +978,8 @@ int __vm_set_user_memory_region2(struct kvm_vm *vm, u32 slot, u32 flags,
 		.guest_phys_addr = gpa,
 		.memory_size = size,
 		.userspace_addr = (uintptr_t)hva,
-		.guest_memfd = guest_memfd,
-		.guest_memfd_offset = guest_memfd_offset,
+		.guest_memfd = gmem_fd,
+		.guest_memfd_offset = gmem_offset,
 	};
 
 	TEST_REQUIRE_SET_USER_MEMORY_REGION2();
@@ -989,10 +989,10 @@ int __vm_set_user_memory_region2(struct kvm_vm *vm, u32 slot, u32 flags,
 
 void vm_set_user_memory_region2(struct kvm_vm *vm, u32 slot, u32 flags,
 				gpa_t gpa, u64 size, void *hva,
-				u32 guest_memfd, u64 guest_memfd_offset)
+				u32 gmem_fd, u64 gmem_offset)
 {
 	int ret = __vm_set_user_memory_region2(vm, slot, flags, gpa, size, hva,
-					       guest_memfd, guest_memfd_offset);
+					       gmem_fd, gmem_offset);
 
 	TEST_ASSERT(!ret, "KVM_SET_USER_MEMORY_REGION2 failed, errno = %d (%s)",
 		    errno, strerror(errno));
@@ -1002,7 +1002,7 @@ void vm_set_user_memory_region2(struct kvm_vm *vm, u32 slot, u32 flags,
 /* FIXME: This thing needs to be ripped apart and rewritten. */
 void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		gpa_t gpa, u32 slot, u64 npages, u32 flags,
-		int guest_memfd, u64 guest_memfd_offset)
+		int gmem_fd, u64 gmem_offset)
 {
 	int ret;
 	struct userspace_mem_region *region;
@@ -1078,12 +1078,12 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		region->mmap_size += alignment;
 
 	if (flags & KVM_MEM_GUEST_MEMFD) {
-		if (guest_memfd < 0) {
-			u32 guest_memfd_flags = 0;
+		if (gmem_fd < 0) {
+			u32 gmem_flags = 0;
 
-			TEST_ASSERT(!guest_memfd_offset,
+			TEST_ASSERT(!gmem_offset,
 				    "Offset must be zero when creating new guest_memfd");
-			guest_memfd = vm_create_guest_memfd(vm, mem_size, guest_memfd_flags);
+			gmem_fd = vm_create_guest_memfd(vm, mem_size, gmem_flags);
 		} else {
 			/*
 			 * Install a unique fd for each memslot so that the fd
@@ -1091,11 +1091,11 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 			 * needing to track if the fd is owned by the framework
 			 * or by the caller.
 			 */
-			guest_memfd = kvm_dup(guest_memfd);
+			gmem_fd = kvm_dup(gmem_fd);
 		}
 
-		region->region.guest_memfd = guest_memfd;
-		region->region.guest_memfd_offset = guest_memfd_offset;
+		region->region.guest_memfd = gmem_fd;
+		region->region.guest_memfd_offset = gmem_offset;
 	} else {
 		region->region.guest_memfd = -1;
 	}

-- 
2.55.0.887.g758fc8c411-goog

