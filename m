Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D420038F921;
	Thu, 26 Feb 2026 07:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772091329; cv=none; b=hsfyvzXsnhQ4mW4/OiyhEFnqpryhqatM/i0BMyzPGCGVSFH9f9FcNETt3cwlditFQJaZzs16ujIjqLjFzAWgvNeuSb7yaMQCnPgoUNta5pWHs+II/SmGvVOEUDq9YeQalrBxzRBbNzfzLAxwhrvZVkB1ukkcnpIhGNANpXlYgNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772091329; c=relaxed/simple;
	bh=P8+TGDnvkg7gufbIf6sOV2gE+oWXesLj+BT+qqAjWd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxR2AFQyMuRrBLtIOpT/44wZfXkX+yBQ+an49vxHABjkBaXA5fm6hbryBLy3AECSnAvwRT400reFxduWPZTnJC/+PhUj+kmjaMN4qGJZf7VUt0aEhEknH/u6RgxpcHsAkRfl2OWyKUprQHgPuvFF8OQbFCtZkVd7/5xoRvRflIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=KcYHtes9; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="KcYHtes9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1772091326; x=1803627326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=okgIaffSuE7iTDSP0gw48/bn86X3WVAG8sCQHMc54fQ=;
  b=KcYHtes9avrkA27FxmBskqP1CAajtqUObEK+T86A2EN7bhIZiqcDj+Iv
   /FQ+Zl7eFu0aL/NCf4FPv9IJsMG/pSHvEcNpnaPZUBHkhG7ye7CGQpFmT
   HNEU740zbTws79IFkZdYNkfS4goNN80PAmmkFwaepmIDjJOMZuWvPesog
   o933GmG+9/iWpx2+MTc8djPU7/7QWNHYbsF51RUxSqLv5fWPSegXoQKui
   4E41Q//nTrbKknDif1nRH34HZxFSEfYd7+2j9nY7tWYeU4pUEbGIJmD5U
   0rL8ORX/PPetVQ/9CQsptgB62s+JjFccF0mtQ32c/u3SQwfYF12KmyFxN
   Q==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 16:35:24 +0900
X-IronPort-AV: E=Sophos;i="6.21,311,1763391600"; 
   d="scan'208";a="616141560"
Received: from unknown (HELO asagi..) ([43.11.56.84])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 26 Feb 2026 16:35:23 +0900
From: Yohei Kojima <yohei.kojima@sony.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Yohei Kojima <yohei.kojima@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>,
	Tim Bird <tim.bird@sony.com>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] KVM: selftests: Extract memslot setup code from spawn_vm()
Date: Thu, 26 Feb 2026 16:37:14 +0900
Message-ID: <57c05d4d7db845be9250b7a4f6537e98636d70ca.1772090306.git.yohei.kojima@sony.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772090306.git.yohei.kojima@sony.com>
References: <cover.1772090306.git.yohei.kojima@sony.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vm_userspace_mem_region_add_map() function to set up memslot, and
update spawn_vm() to use it. This helps the test cases to create
additional memslots easily.

Signed-off-by: Yohei Kojima <yohei.kojima@sony.com>
---
 .../selftests/kvm/set_memory_region_test.c    | 47 ++++++++++++-------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index 7fe427ff9b38..8d4fd713347c 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -107,31 +107,42 @@ static void wait_for_vcpu(void)
 	usleep(100000);
 }
 
+static void vm_userspace_mem_region_add_map(struct kvm_vm *vm,
+		uint64_t addr, uint32_t slot, size_t size, uint32_t flags)
+{
+	uint64_t *hva;
+	uint64_t gpa;
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS_THP,
+				    addr, slot,
+				    size / getpagesize(), flags);
+
+	/*
+	 * Allocate and map two pages so that the GPA accessed by guest_code()
+	 * stays valid across the memslot move.
+	 */
+	gpa = vm_phy_pages_alloc(vm, 2, addr, slot);
+	TEST_ASSERT(gpa == addr, "Failed vm_phy_pages_alloc\n");
+
+	virt_map(vm, addr, addr, 2);
+
+	/* Ditto for the host mapping so that both pages can be zeroed. */
+	hva = addr_gpa2hva(vm, MEM_REGION_GPA);
+	memset(hva, 0, 2 * 4096);
+}
+
 static struct kvm_vm *spawn_vm(struct kvm_vcpu **vcpu, pthread_t *vcpu_thread,
 			       void *guest_code)
 {
 	struct kvm_vm *vm;
-	uint64_t *hva;
-	uint64_t gpa;
 
 	vm = vm_create_with_one_vcpu(vcpu, guest_code);
 
-	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS_THP,
-				    MEM_REGION_GPA, MEM_REGION_SLOT,
-				    MEM_REGION_SIZE / getpagesize(), 0);
-
-	/*
-	 * Allocate and map two pages so that the GPA accessed by guest_code()
-	 * stays valid across the memslot move.
-	 */
-	gpa = vm_phy_pages_alloc(vm, 2, MEM_REGION_GPA, MEM_REGION_SLOT);
-	TEST_ASSERT(gpa == MEM_REGION_GPA, "Failed vm_phy_pages_alloc\n");
-
-	virt_map(vm, MEM_REGION_GPA, MEM_REGION_GPA, 2);
-
-	/* Ditto for the host mapping so that both pages can be zeroed. */
-	hva = addr_gpa2hva(vm, MEM_REGION_GPA);
-	memset(hva, 0, 2 * 4096);
+	vm_userspace_mem_region_add_map(vm,
+					MEM_REGION_GPA,
+					MEM_REGION_SLOT,
+					MEM_REGION_SIZE,
+					0);
 
 	pthread_create(vcpu_thread, NULL, vcpu_worker, *vcpu);
 
-- 
2.43.0

