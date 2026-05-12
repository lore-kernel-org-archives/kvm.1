Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1283B1ED1
	for <kvm@vger.kernel.org>; Tue, 12 May 2026 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601397; cv=none; b=rDKbT5Z5sX1dUhLpfWoHStDRT30xy8bjz0b5wFQTcCuEZxBtRy1ji79cqvnq5kb2reY7qcuE0sbcXCAZtNxrR6/oKcopxAFRhMLIrJwMvEC3nZNVwCIOdG2cG/KEzgEpWA6hM1t7iMNqPm4QTCPP/+BuTpdOtWykqw/iqEhPRWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601397; c=relaxed/simple;
	bh=yljjG8l8B69MlqrY+w1gCcEq2SscDsa0PKnhEBZTGA0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Wj6yTpiU2Lpd/HFSDYH0cJ7//CdQfUag3MYGZlnmuhR0irim7fxn2lb4b1+zIG9wFs7d/3RdhUQ+jzb9bDdNKtRyMNyVNl6cVlo6oSjNJRYCgJDgN78rR4O/ae+hpYooDXbO41qZ6rY02auNohvzq9KQePbpygnVOoWIVzxscyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BSOhWgfA; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BSOhWgfA"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa2165c3eso3987059b3a.0
        for <kvm@vger.kernel.org>; Tue, 12 May 2026 08:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778601396; x=1779206196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4hiTjnHHAawTA+YjwYcN9iXdJb4DuQurxNnuEC+t9M=;
        b=BSOhWgfAKNRCMIWFgECaMHGu9oA6fhkORaBO8OVfSJfqarLqlhROd7wvb9LdGalqvT
         b1mUG4OW6648W7Wkm6WwXiQVEHshcHj3oUtqRsoAlXMPe6d1Noy8X0uc0c6SfJ+dRNBR
         kTwV4YCSQ/WKTUFTZdhrnihcbyUPHf3sN/y9hIWnLKMYbDVbi/LdQkmz33YVK/KfeZJp
         tY/QoMi+sHo/S0odTqFgQor4xS0YRLa9y8ZZdqtAzfABmZvCmMjLJm41Fr3oYRClBbXa
         I2v+QgvXxE0WfY9kRPMjysh7u2OAm/4Qx2+yW61T9hmWoAxCV+fS316eIV5VKj2D870A
         9x5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778601396; x=1779206196;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x4hiTjnHHAawTA+YjwYcN9iXdJb4DuQurxNnuEC+t9M=;
        b=JoL7NZAfwzAsYTu1GkUHp692LUyd+TQiE5kDN4CitmTTk00sMF9t1SMT1r8W5tHD2U
         H6FoHUdDXa/69Bf9xSnCJLNOvnY33JDYds4pL1wTTyK3neaoqgcHNhnln9mg4TXntsu3
         Pkr94ujevQGJgnifbQGsHMMl5DH6Vdc6/huu/vM0N6XeeOXedbjWO0wKDfLH70mtgxCy
         aiMLewcM8NzCB2KRHbEsBHcnhCOZxZFchP1Dp4/DXr7w8sSwgh6F7xALAJqXyOLnN2Q5
         corx9MhNPXLhc6Se9CvVG7NbkRUfxpv2eSJS1jEPIKDEeWhqT+XXrTpPN6pNwNbVeGX7
         NUrQ==
X-Gm-Message-State: AOJu0YyMEWL4V8CRdiXGamCN1D+9SzOU0DEURU3F97aC8s5Y88G+rv/g
	BzwVjfmxFRAUSFTQrBVrpmIn6wydJjjoAOe7lgPs54vGDlEJExJ/Xg07otcNohBsJLK7vIDqC/q
	KW6XlUw==
X-Received: from pfbkw5.prod.google.com ([2002:a05:6a00:94f5:b0:839:5556:c979])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a90f:b0:838:af72:fb44
 with SMTP id d2e1a72fcca58-83cf4f760e7mr22440518b3a.2.1778601395691; Tue, 12
 May 2026 08:56:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 12 May 2026 08:56:34 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512155634.772602-1-seanjc@google.com>
Subject: [PATCH] KVM: selftests: Ensure gmem file sizes are multiple of host
 page size
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zenghui Yu <zenghui.yu@linux.dev>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

When creating a guest_memfd file and associated memslot to validate shared
guest memory, size the file+memslot to the maximum of the host or guest
page size.  Attempting to allocate a single guest page will fail if the
host page size is greater than the guest page size, as KVM requires that
the size of memslots and guest_memfd files are a multiple of the host page
size.

For simplicity, verify the entire file can be shared between guest and host,
e.g. instead of trying to validate "partial" mappings.

Fixes: 42188667be38 ("KVM: selftests: Add guest_memfd testcase to fault-in on !mmap()'d memory")
Reported-by: Zenghui Yu <zenghui.yu@linux.dev>
Closes: https://lore.kernel.org/all/0064952b-048c-455d-ad89-e27e5cb82591@linux.dev
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index d6528c6f5e03..253e748c1d4a 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -510,7 +510,12 @@ static void test_guest_memfd_guest(void)
 		    "Default VM type should support INIT_SHARED, supported flags = 0x%x",
 		    vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS));
 
-	size = vm->page_size;
+	/*
+	 * Use the max of the host or guest page size for all operations, as
+	 * KVM requires guest_memfd files and memslots to be sized to multiples
+	 * of the host page size.
+	 */
+	size = max_t(size_t, vm->page_size, page_size);
 	fd = vm_create_guest_memfd(vm, size, GUEST_MEMFD_FLAG_MMAP |
 					     GUEST_MEMFD_FLAG_INIT_SHARED);
 	vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, size, NULL, fd, 0);
@@ -519,7 +524,7 @@ static void test_guest_memfd_guest(void)
 	memset(mem, 0xaa, size);
 	kvm_munmap(mem, size);
 
-	virt_pg_map(vm, gpa, gpa);
+	virt_map(vm, gpa, gpa, size / vm->page_size);
 	vcpu_args_set(vcpu, 2, gpa, size);
 	vcpu_run(vcpu);
 

base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
-- 
2.54.0.563.g4f69b47b94-goog

