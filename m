Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A60737B402;
	Wed, 24 Jun 2026 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782321453; cv=none; b=U60XPQvDNVP6RWfZn1funaMR/RGLsOuAyDJw66aLPU3DB7u8IxfSwqxZJNHBwxm/rRSYnNB371S3JE8IfuZfNV8DRvCCVd/otp4kSCn4cXL2fpSMOuoyRL7Ee8dZSEEiaVyMbd/IJ/3Vm1j+nelw1Vlcjd4IkT1xiXyV84Bjkf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782321453; c=relaxed/simple;
	bh=3GsDJUnWTbOcgOraoN4QbQcgFD/QUYNaAEIFZb36O+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmH/OaZeukiLqgmmkjqq04e5oh54eeoImXzhxYLJohL5Q+rM/e4bZHCWSHUBQal3CkjfA9mpHEJigLjZ7bE7ZYBEMiDHm7DMQMspy6H0Bkf7fWVl9CqSml8VAecDy+ntnN+Mvzv/1VlpYSg2253KXB5CARP5VZOB+99PNABsuK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GRA+sGV9; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GRA+sGV9"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 200A728AC;
	Wed, 24 Jun 2026 10:17:26 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAA703F905;
	Wed, 24 Jun 2026 10:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782321450; bh=3GsDJUnWTbOcgOraoN4QbQcgFD/QUYNaAEIFZb36O+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GRA+sGV9OG8cNOF8c7Cb0Ea8DGFhQuPtFzV1YtCuXX6Er4qAMiXvZSEDl2oshc3Pd
	 qM1PwlD+Sq1IHsqURKI2j3GZx5/ARgbPuRBEJOJNmL7NYN0R8fWo4lxMcnSuq9dV+3
	 naDK3ybDUliWk5EiU4K/8gzh/mH82hazbyuvJ8Rk=
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
Subject: [RFC PATCH 2/3] KVM: selftests: Check dirty-ring size before enabling
Date: Wed, 24 Jun 2026 18:16:48 +0100
Message-ID: <20260624171656.1737580-3-leo.bras@arm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624171656.1737580-1-leo.bras@arm.com>
References: <20260624171656.1737580-1-leo.bras@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1963; i=leo.bras@arm.com; h=from:subject; bh=3GsDJUnWTbOcgOraoN4QbQcgFD/QUYNaAEIFZb36O+A=; b=owGbwMvMwCX2pizjszvTwvWMp9WSGLJsBG7av5ie85CnqURDkI1V6etpmfQLIsJHVy/pu39+y o2aX4zzOkpZGMS4GGTFFFlkH81fxfN9SsaRKz8WwMxhZQIZwsDFKQATiRNhZFjwu1a1/2afxB3z iAvWvY1ie2JmRNUu9Heazhkbuq74igzD/2i+6/fqpPUn7nQ98Pxrfb5p1ToP4cTPhx0XnjxVKit ylgMA
X-Developer-Key: i=leo.bras@arm.com; a=openpgp; fpr=36E6C95AE0F111CC5B6F4D2E688C33F8A0C5B0C5
Content-Transfer-Encoding: 8bit

As of today, trying to enable dirty-ring with a size bigger than the
maximum will return an "argument list too long" error.

Change vm_enable_dirty_ring() to get the maximum size, then compare it to
the desired size before enabling. If the value is invalid, print a more
precise error message.

Signed-off-by: Leonardo Bras <leo.bras@arm.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 195f3fdae1e3..237f0ce0ae60 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -160,24 +160,34 @@ unsigned int kvm_check_cap(long cap)
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
+	TEST_ASSERT(ring_size <= max_size && is_power_of_2(ring_size),
+		    "Invalid dirty-ring size: Should be a power of two "
+		    "smaller than %d entries\n",
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
2.54.0

