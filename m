Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC0B38F954
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 23:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777419213; cv=none; b=I+bFclSl7yG9ufLluezjDvjiOLct0YPFKQO+r+SORCbkCPlNbh2+r4uF1hVDDd+AZIwhMl0QdEb9AvnGZFbj/2wg7VuPiZOmxsGj4UTFW6eLEWU89tm9fMSpIl+cnTtQtVRICCjwErFN7+u/x5dZpWxR3RsWfO+77zcoPWA1BbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777419213; c=relaxed/simple;
	bh=w9utNXxCCC62f2kYxm5u5Pd5S1Lxi8j2YN3oYBMKdM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E4aFdtJgzKCvgf4vLtNdUwdGG90SdfXJiDLVUL0MUAGtGwPVWpyoOFXeGfYjK2pr7mUZGc0Ffc/10G0Ha38u58vaCdusmG0NlYB3iCtJNKwIcrRR7/+a50QFYGKHGQ5Lmc8/cIEkEZqWWblWb7ipZWvoiE7bX+MRwxXJ8erGaHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LwkGlO3G; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LwkGlO3G"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b258636d16so120684445ad.2
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 16:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777419211; x=1778024011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=clSh7OBsCI0JhKUCKzkprD+sDtva2OSfrDX8pAze+SM=;
        b=LwkGlO3GGoU0U9Eq3kERzXqRqw777yR2A8NQRDVWb2ME+VDXMc3wFpq4OYsfzcEV+R
         a1/pJNEjqsuGAxFzhxX+SNIlgfvyOZR3bqRmKkwHQxvYcuSFWOnR3im+rxlCx8jYEyPF
         VfvpmKke+C4ih1/4wwv988fY1jmXELofGxoaN8dDLuuVl8J3iMgiRL914FkC9KS0dWl/
         tk1dS+i9IEIYTHu/uNiu0GlMksRXO4zwKm2q6HeTnpW/KTv2BUTIKu4Ejb624L8TTYzA
         v4Dc/tmlohyyDg82naAUSGZDZfc53V23DEPuhQrunL54/upsWCJETPXuVWilUd2pjBiv
         m4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777419211; x=1778024011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=clSh7OBsCI0JhKUCKzkprD+sDtva2OSfrDX8pAze+SM=;
        b=Y6jwC/VjgBl6YougDBJMN9mZzRRjpGHwF2FOOIVBTbfWAERKseTLNDYF2WNnyyuGEj
         BUZ7/zvZ7L280sjRyzx5qawdPPBYVKrs7UCNbtgrJx5Gjdz5Yv2bRkVYyUsurOypbwT+
         bRIc9zhPKNsqdODrqja89Qsy02N45MpE79ltKUKEMGRwi69kYXc1NgX99TXW4jEv1Xl3
         hj7VPnxyyK0fYviO8aaSH6rB24v9ckF/lpO0gvIRh7oXVlwMd1OisffHdSqqQXjUtwg1
         WNIeeMnY8Aa8zm2Bv0IJWe3KqfxYCT/lfezMCgK4fDLu57NUPTq5W25pFRTojHMwIEMd
         6rYA==
X-Forwarded-Encrypted: i=1; AFNElJ86SBoIZDEROMz2f5yXv13a8uW5zF0+OfN1cM/lv0DzcCpRfPNfMPOQaGdw72DG0xYuS78=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYSD2o1vuwgx7CQ8pg0lbhht68p+pPNLm5/RnGOIO8s0i5n5Ct
	3VqWKGCqVBFs89ONAnbkFGrGCkrzKhAQyhE2JKfLQorLIN6/0oz2J56Sy3BMlDsaT5sW/LZ3BUR
	YX2j4ooHRWdUKWncgrWH7WFG/IA==
X-Received: from plpn20.prod.google.com ([2002:a17:902:9694:b0:2b2:ec1e:c943])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3c2f:b0:2b9:6453:389a with SMTP id d9443c01a7336-2b97c3cc0b3mr49885595ad.8.1777419210821;
 Tue, 28 Apr 2026 16:33:30 -0700 (PDT)
Date: Tue, 28 Apr 2026 16:33:21 -0700
In-Reply-To: <cover.1777418884.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com> <cover.1777418884.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <94c9e342215e6c88988d7aa62f3ba627eda34e94.1777418884.git.ackerleytng@google.com>
Subject: [POC PATCH 1/6] KVM: selftests: Initialize guest_memfd with INIT_SHARED
From: Ackerley Tng <ackerleytng@google.com>
To: devnull+ackerleytng.google.com@kernel.org
Cc: ackerleytng@google.com, aik@amd.com, akpm@linux-foundation.org, 
	andrew.jones@linux.dev, aneesh.kumar@kernel.org, axelrasmussen@google.com, 
	baohua@kernel.org, bhe@redhat.com, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, chrisl@kernel.org, 
	corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, 
	forkloop@google.com, hpa@zytor.com, ira.weiny@intel.com, jgg@ziepe.ca, 
	jmattson@google.com, jthoughton@google.com, kas@kernel.org, 
	kasong@tencent.com, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	nphamcs@gmail.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, pratyush@kernel.org, qi.zheng@linux.dev, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, seanjc@google.com, shakeel.butt@linux.dev, 
	shikemeng@huaweicloud.com, shivankg@amd.com, shuah@kernel.org, 
	skhan@linuxfoundation.org, steven.price@arm.com, suzuki.poulose@arm.com, 
	tabba@google.com, tglx@kernel.org, vannapurve@google.com, vbabka@kernel.org, 
	weixugc@google.com, willy@infradead.org, wyihan@google.com, x86@kernel.org, 
	yan.y.zhao@intel.com, youngjun.park@lge.com, yuanchu@google.com, 
	Sagi Shahar <sagis@google.com>
Content-Type: text/plain; charset="UTF-8"

Initialize guest_memfd with INIT_SHARED for VM types that require
guest_memfd.

Memory in the first memslot is used by the selftest framework to load
code, page tables, interrupt descriptor tables, and basically everything
the selftest needs to run. The selftest framework sets all of these up
assuming that the memory in the memslot can be written to from the
host. Align with that behavior by initializing guest_memfd as shared so
that all the writes from the host are permitted.

guest_memfd memory can later be marked private if necessary by CoCo
platform-specific initialization functions.

Suggested-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 216d6e037153c..3811aef8c98cd 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -483,8 +483,10 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
 {
 	u64 nr_pages = vm_nr_pages_required(shape.mode, nr_runnable_vcpus,
 						 nr_extra_pages);
+	enum vm_mem_backing_src_type src_type;
 	struct userspace_mem_region *slot0;
 	struct kvm_vm *vm;
+	u64 gmem_flags;
 	int i, flags;
 
 	kvm_set_files_rlimit(nr_runnable_vcpus);
@@ -502,7 +504,15 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
 	if (is_guest_memfd_required(shape))
 		flags |= KVM_MEM_GUEST_MEMFD;
 
-	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags);
+	gmem_flags = 0;
+	src_type = VM_MEM_SRC_ANONYMOUS;
+	if (is_guest_memfd_required(shape) && kvm_has_gmem_attributes) {
+		src_type = VM_MEM_SRC_SHMEM;
+		gmem_flags = GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED;
+	}
+
+	vm_mem_add(vm, src_type, 0, 0, nr_pages, flags, -1, 0, gmem_flags);
+
 	for (i = 0; i < NR_MEM_REGIONS; i++)
 		vm->memslots[i] = 0;
 
-- 
2.54.0.545.g6539524ca2-goog

