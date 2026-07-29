Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3688411A0A;
	Wed, 29 Jul 2026 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341741; cv=none; b=l/HWQujHpHf7gjZFTCMRWNnLxFe21KJpgzxHaiLz1jnJvxXKA4F45Es1t2eFV+ya4M6DsU9fK92LFFa7CM94vj34IIvfjQAhBRp8h5GXCNrYmlMXjOsWsF/JSGRy8lXib06REXSQbcK2DloRI5+ezohdI8g43jCI0nedVeBFcu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341741; c=relaxed/simple;
	bh=FRhXrtjA+aJsVgnpMuj0TY7Sbv/PelctM5tktbJXPwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bECoG1JnFzREQxCTkCgwINmWXdBORtwCjIrAM8iWyrZairAUli0xl8WmJK/yCzabdkCCoDd5N+w3ByTVT6iv8PnvfmdiIk5K+bKiauUgUOcs6xxMjgPCCA0WKSVesEz82pifcznjlC6CuyGgJIeVQmamT2yLQwLiVO2fSfQelgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=uqpT8p4Z; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="uqpT8p4Z"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8803169C;
	Wed, 29 Jul 2026 09:15:34 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BE863F66F;
	Wed, 29 Jul 2026 09:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785341738; bh=FRhXrtjA+aJsVgnpMuj0TY7Sbv/PelctM5tktbJXPwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uqpT8p4ZzIe6u8XG8ilaMAGXamg9hNdi/hAoBOdYjQ5IzQGON9A6RZ2pqd4Ubh9wb
	 MlqA7krNybVjZ/YYCVb9bbgmy4/hqzNyz0O/TYZtFjyf4K1JEURLsv4XZ7x2RDsbAR
	 /qTRGbCf9fX26+/eI3Umw/mtwRsuLl+YxZFGDLdQ=
From: Leonardo Bras <leo.bras@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	David Matlack <dmatlack@google.com>,
	Leonardo Bras <leo.bras@arm.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Oliver Upton <oupton@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Wu Fei <wu.fei9@sanechips.com.cn>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 2/3] KVM: selftests: Check dirty-ring size before enabling
Date: Wed, 29 Jul 2026 17:15:17 +0100
Message-ID: <20260729161519.3778839-4-leo.bras@arm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729161519.3778839-2-leo.bras@arm.com>
References: <20260729161519.3778839-2-leo.bras@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2137; i=leo.bras@arm.com; h=from:subject; bh=FRhXrtjA+aJsVgnpMuj0TY7Sbv/PelctM5tktbJXPwg=; b=owGbwMvMwCX2pizjszvTwvWMp9WSGLKy1PnOmPQsari12S1z2x3bhwrHo7o/mh4s3M/8hE108 U62pLLKjlIWBjEuBlkxRRbZR/NX8XyfknHkyo8FMHNYmUCGMHBxCsBEzuxhZLh+srNSy05LsOXm 65fab92S9lvOdS0QMM3pvMk0W+dZ6VxGhtNznc8W9P5at2tFpe3KrY2tJwvuKhvqz7/VtECFcbl UEQ8A
X-Developer-Key: i=leo.bras@arm.com; a=openpgp; fpr=36E6C95AE0F111CC5B6F4D2E688C33F8A0C5B0C5
Content-Transfer-Encoding: 8bit

As of today, trying to enable dirty-ring with a size bigger than the
maximum will return an "argument list too long" error.

Change vm_enable_dirty_ring() to get the maximum size, then compare it to
the desired size before enabling. If the value is invalid, print a more
precise error message.

Signed-off-by: Leonardo Bras <leo.bras@arm.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 195f3fdae1e3..f1ebd7122763 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -160,24 +160,37 @@ unsigned int kvm_check_cap(long cap)
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
+	TEST_ASSERT(ring_size <= max_size && is_power_of_2(ring_size) &&
+		    ring_size >= getpagesize(),
+		    "Invalid dirty-ring size: Should be a power of two "
+		    "between %lu and %lu entries\n",
+		    getpagesize() / sizeof(struct kvm_dirty_gfn),
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

