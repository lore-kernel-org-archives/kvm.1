Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3DB3F12EE;
	Wed,  8 Jul 2026 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524166; cv=none; b=eXgX3pk4TADtSdBinaGBsCSdB+i8OEAtTm0AXJfWiP0cOWmAySMjHAJd7HVcY73nDpxuWvGT/sZwhUQzUvHwmOaX9vJXYDhSw2XpAvuP6BWjyXg2OHeriLc92jHHhJC3Kv3ZFvNVE3MoGihefVoI9sfji2ovSj0E231RWR9rxCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524166; c=relaxed/simple;
	bh=apzV4oh9O1P2YQMbrmGXEcX+PtvV3tL6P8GVOtdu8z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgWj9UX2+2tFR0sIwVF4lFCqMvqTWtA9bvliKKhWVm2XYGbYwKSfT3UzBjDs28Q+I42qLw2rJQ7xqBgLnAhFXuZPQxmV0VoDf2+x1yDUXIHf/ITYduAyXsRTLv765K0cwXT4G11l7swkDOkozTVpoKEnlCdg985cMIk8gNBvPoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IyvYvGxN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IyvYvGxN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60F781E2F;
	Wed,  8 Jul 2026 08:22:40 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D54F3F66F;
	Wed,  8 Jul 2026 08:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783524164; bh=apzV4oh9O1P2YQMbrmGXEcX+PtvV3tL6P8GVOtdu8z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IyvYvGxNwcS151RrtXbzKfeaWjMCXoY0gD2nfEQcsrmOlrSFdl3L2UAvz0M6SuZl8
	 58cBb9rMEyxvcXgkGXD9Jb2UUJtkiv59F4v2eILqk0xmUky3zd0Nzjq35lSy2hvQPK
	 3TJmSQMjfPYxq26YeVlZ+IVGmt1nwL+HBMmquHak=
From: Leonardo Bras <leo.bras@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	David Matlack <dmatlack@google.com>,
	Leonardo Bras <leo.bras@arm.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Wu Fei <wu.fei9@sanechips.com.cn>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 2/3] KVM: selftests: Check dirty-ring size before enabling
Date: Wed,  8 Jul 2026 16:22:27 +0100
Message-ID: <20260708152232.2568907-3-leo.bras@arm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708152232.2568907-1-leo.bras@arm.com>
References: <20260708152232.2568907-1-leo.bras@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2030; i=leo.bras@arm.com; h=from:subject; bh=apzV4oh9O1P2YQMbrmGXEcX+PtvV3tL6P8GVOtdu8z8=; b=owGbwMvMwCX2pizjszvTwvWMp9WSGLL8spUunj7kcfogr9fZqwuOCB/yszf20uAUdCjaelV4w u4YifiYjlIWBjEuBlkxRRbZR/NX8XyfknHkyo8FMHNYmUCGMHBxCsBEnk5k+Ct499RVxb7iLfvr nV//eGcv1VZ6dM+qJ3pOIn8Dmd8pOtxmZOjrk9zwbY46T9wPF85El1cp295XRh/acqaW533cJin 9RFYA
X-Developer-Key: i=leo.bras@arm.com; a=openpgp; fpr=36E6C95AE0F111CC5B6F4D2E688C33F8A0C5B0C5
Content-Transfer-Encoding: 8bit

As of today, trying to enable dirty-ring with a size bigger than the
maximum will return an "argument list too long" error.

Change vm_enable_dirty_ring() to get the maximum size, then compare it to
the desired size before enabling. If the value is invalid, print a more
precise error message.

Signed-off-by: Leonardo Bras <leo.bras@arm.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 195f3fdae1e3..4ae27ad9f947 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -160,24 +160,35 @@ unsigned int kvm_check_cap(long cap)
 	ret = __kvm_ioctl(kvm_fd, KVM_CHECK_EXTENSION, (void *)cap);
 	TEST_ASSERT(ret >= 0, KVM_IOCTL_ERROR(KVM_CHECK_EXTENSION, ret));
 
 	kvm_free_fd(kvm_fd);
 
 	return (unsigned int)ret;
 }
 
 void vm_enable_dirty_ring(struct kvm_vm *vm, u32 ring_size)
 {
-	if (vm_check_cap(vm, KVM_CAP_DIRTY_LOG_RING_ACQ_REL))
-		vm_enable_cap(vm, KVM_CAP_DIRTY_LOG_RING_ACQ_REL, ring_size);
-	else
-		vm_enable_cap(vm, KVM_CAP_DIRTY_LOG_RING, ring_size);
+	long cap = KVM_CAP_DIRTY_LOG_RING_ACQ_REL;
+	int max_size = vm_check_cap(vm, cap);
+
+	if (!max_size) {
+		cap = KVM_CAP_DIRTY_LOG_RING;
+		max_size = vm_check_cap(vm, cap);
+	}
+
+	TEST_ASSERT(max_size > 0, "Dirty-ring not supported in this kernel\n");
+	TEST_ASSERT(ring_size <= max_size && is_power_of_2(ring_size),
+		    "Invalid dirty-ring size: Should be a power of two "
+		    "<= %lu entries\n",
+		    max_size / sizeof(struct kvm_dirty_gfn));
+
+	vm_enable_cap(vm, cap, ring_size);
 	vm->dirty_ring_size = ring_size;
 }
 
 static void vm_open(struct kvm_vm *vm)
 {
 	vm->kvm_fd = _open_kvm_dev_path_or_exit(O_RDWR);
 
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_IMMEDIATE_EXIT));
 
 	vm->fd = __kvm_ioctl(vm->kvm_fd, KVM_CREATE_VM, (void *)vm->type);
-- 
2.55.0

