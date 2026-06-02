Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C833B2D0B
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780437376; cv=none; b=nwLoXuUeZc79mtM64GQxRyzFkewoDXFCERX9gqU8RkKt71BLliRUlACoXexIjRG+Tf2tkWqLi8jHgEyc7zQTM6BtLPMbIWNtYtd/UI9QVhjxxiUxR+0cLoskCvz2ij9daPa298oe5jTA5HhRfOtIdnpRVi6maiooQIaEa/kRb2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780437376; c=relaxed/simple;
	bh=uanUhuG5chBI7iGRiYb/NQJAUXfg811Uv7P0B8yjofM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mo6aAproH/R9mHeOpvyb/Ry5Veh9GGg98+b/nr4AQElVRQC/1ZYJCyQLzLbMDudCTWAw/ddYPof+qPwsdxHnSzAcsaFxNS64tzKO9m1aVfRkBEu4tdDlj98A+E2as/OVvvOEvpI9Oq7rgZiPi9GWcPgT/2HI7LthGU6MJgauKQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ozXt2lBy; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ozXt2lBy"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d98b76d12so2252331a91.2
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 14:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780437375; x=1781042175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQ6ZTIKmnZDIm2PqykNUkTYiLD4CQXsPT3VeVYf4kfY=;
        b=ozXt2lByeR+meHbow4e7bzL96EQ/QocmGuwXo1LtKlHnxmUmw1PUz/jAaadzVrPXmx
         AUjmudO2gfzLBTVdEM1w4M0BT4s8grRLlT+nLcsv0Wy1xHTCmNZbeY8CkMPxjUiMuXzE
         1VT0kp/eiycwcWkbDFMI3EGZp7t77CNPRaNFMXuOwyRv2+6lJq+ILzHamQ0XaLIo5XxX
         JvACUHKThZoeXKTOtN25JyQSyMW35VY/1h/g8sIr06BoFqAi5T0VLb7NUL6QYabRqXDX
         Y9VunWtH0lhK3gDleHKxxLjIF4vHiMBReyb+6BatQLHi0fesct6GzaNRo/v/xLhPupDD
         MUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780437375; x=1781042175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQ6ZTIKmnZDIm2PqykNUkTYiLD4CQXsPT3VeVYf4kfY=;
        b=GbgGGAvcF+HKHAQFgWmoni4kY6lucjdEj8kaMg2FBx4Q1jEfYZ6ZpNiJwheflHjSZ5
         2aFASEJcH5nyGoLAo2cmA4IKpVLR8ZgdidQjcnp5TTF58B/gqUsQy5P89A9jocYjmtCm
         xGbMuf/XQKO5qluZD/0R0lSrMJL7x9XD4/aGuvu5B4AY/+LXD96tetHhWF+lPsef7ShO
         uALgNM+UBIuY/cCLMFJ344i21Tq+Leo5gC9pphypmaTstkzS4usJlcm96Ha8VvM6x4P1
         k7LF3+PBa9Qf9yChYP2JA8Q+QiiQteKDjo2ngxfXRvNQSLx4pveuOzC9JaoutjFHVYxJ
         i5JA==
X-Forwarded-Encrypted: i=1; AFNElJ9k0kAfRIcGIDyKOJLQDFXQHq5CLXiYsJ3T5OixtNyRbkEBzOMty6owWfbUki0b2LoR4ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyynT96M1y/MasoYRAAhsDMJZdC4KaCI7AFKL6olSiQDjjN1Rtz
	39wOwv7mJNOI6RV+bUDZz9BGz4T7hmY6zV4JK069DHUutgM5OV+eUDY1AP4CKOjUuDXB/tlMbXl
	pKzaXzQ==
X-Received: from pju15.prod.google.com ([2002:a17:90a:d4f:b0:36b:89e6:3ee5])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e4e:b0:35f:b647:d98a
 with SMTP id 98e67ed59e1d1-36e30552788mr686479a91.5.1780437372149; Tue, 02
 Jun 2026 14:56:12 -0700 (PDT)
Date: Tue, 02 Jun 2026 21:55:47 +0000
In-Reply-To: <20260602-memory-failure-mf-delayed-fix-v4-0-a5bc7db5a9b2@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602-memory-failure-mf-delayed-fix-v4-0-a5bc7db5a9b2@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780437363; l=3092;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=uanUhuG5chBI7iGRiYb/NQJAUXfg811Uv7P0B8yjofM=; b=onjoJh2jwfvgE5J9KsFufxaaM/BBUoZUbER0Iv4yiEZbnHtSt3LZi3VagZRC8gVSTIjS36l5y
 WirOgE+fH18CGioPV6fp/j5ijMuy/gRGi7+ecGc+dvu8oYZZXqd01R3
X-Mailer: b4 0.14.3
Message-ID: <20260602-memory-failure-mf-delayed-fix-v4-7-a5bc7db5a9b2@google.com>
Subject: [PATCH v4 7/7] KVM: selftests: Test guest_memfd behavior with respect
 to stage 2 page tables
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
 .../kvm/guest_memfd_memory_failure_test.c          | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_memory_failure_test.c b/tools/testing/selftests/kvm/guest_memfd_memory_failure_test.c
index 6c8032d390ae..e6f4c327bd5a 100644
--- a/tools/testing/selftests/kvm/guest_memfd_memory_failure_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_memory_failure_test.c
@@ -24,6 +24,7 @@
 #include "kvm_util.h"
 #include "test_util.h"
 #include "kselftest_harness.h"
+#include "ucall_common.h"
 
 static size_t page_size, total_size;
 
@@ -313,6 +314,71 @@ TEST_F(guest_memfd_failure, test_memory_failure)
 	}
 }
 
+static void __guest_code_read(uint64_t gpa)
+{
+	uint8_t *mem = (uint8_t *)gpa;
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
+TEST_F(guest_memfd_failure, test_memory_failure_guest)
+{
+	const uint64_t gpa = SZ_4G;
+	const int slot = 1;
+
+	unsigned long memory_failure_pfn;
+	struct kvm_vcpu *vcpu;
+	uint8_t *mem;
+
+	/* Limit guest test execution to a single variant to avoid redundant runs. */
+	if (variant->method != MF_INJECT_DEBUGFS ||
+	    variant->kill_config != PR_MCE_KILL_EARLY ||
+	    !variant->map_page || !variant->dirty_page)
+		return;
+
+	self->vm = __vm_create_shape_with_one_vcpu(VM_SHAPE_DEFAULT, &vcpu, 1, __guest_code_read);
+	vcpu_args_set(vcpu, 1, gpa);
+
+	self->fd = vm_create_guest_memfd(self->vm, self->vm->page_size,
+					 GUEST_MEMFD_FLAG_MMAP |
+					 GUEST_MEMFD_FLAG_INIT_SHARED);
+	vm_set_user_memory_region2(self->vm, slot, KVM_MEM_GUEST_MEMFD, gpa,
+				   self->vm->page_size, NULL, self->fd, 0);
+
+	mem = mmap(NULL, self->vm->page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, self->fd, 0);
+	TEST_ASSERT(mem != MAP_FAILED, "mmap() for guest_memfd should succeed.");
+	virt_pg_map(self->vm, gpa, gpa);
+
+	/* Fault in page to read pfn, then unmap page for testing. */
+	READ_ONCE(*mem);
+
+	memory_failure_pfn = addr_to_pfn(mem);
+	munmap(mem, self->vm->page_size);
+
+	/* Fault page into stage2 page tables. */
+	guest_read(vcpu, 0);
+
+	self->poisoned_pfn = memory_failure_pfn;
+	mark_memory_failure(memory_failure_pfn, 0);
+
+	guest_read(vcpu, EHWPOISON);
+}
+
 static bool can_inject_memory_failure(void)
 {
 	int fd;

-- 
2.54.0.1013.g208068f2d8-goog

