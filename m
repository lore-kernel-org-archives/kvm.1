Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DB036C5B4;
	Mon, 29 Jun 2026 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782730814; cv=none; b=dHbF2XnmvdVOT1e02DK2CoN/KJY1S9xVf6JZMWwJvBUF2u9X8JT5w2G011iV4TLhmc38eJJClba2OnZ2WvcNRf2W5UVSNeZP7RTNGGXyKLnexLUbvr60RMAVPypt7T7RreiHp0NrlN++LZnU4ndBKiwkoZp/l/+n3jbhg/vm3e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782730814; c=relaxed/simple;
	bh=rXl6YfMXYvYDSdPsMQ629hiSvMKFL5QOqwUVLE4GpL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2MQk+iwoPKqx4mburpQwSbgD3dNrR6sbBjcen0XnH/L86YrbOoegVpY56n8gZdnXMwjp4TI6os+iV9TmGR90mQ4L/5U+oKhsw0+NLlZDV0cHHWeMMvJ8gN2Ob3Mcs6zC9UiAm3boLEg7GBni0ZLGhz6KCAM/beP+c6Gsf/SZXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AxnlOi2m; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AxnlOi2m"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9710B25DE;
	Mon, 29 Jun 2026 04:00:06 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 629393F836;
	Mon, 29 Jun 2026 04:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782730811; bh=rXl6YfMXYvYDSdPsMQ629hiSvMKFL5QOqwUVLE4GpL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxnlOi2mucr3nV254zg9UhnNOMD8s2k3/9LQ+vuGdDjMqd9DKECKyZP5OGQFwH6zd
	 epkHJkiKNcm6E+HujFne0NzqqNnHWnTk6AHjFQuUBv8J7+4jhd6gS5t6cFKtdK9DFr
	 7tNknbcynqkNTMTZzVGZnVrmS0rbciH4vTDx/uZY=
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
	Steffen Eiden <seiden@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/3] KVM: selftests: Check dirty-ring size before enabling
Date: Mon, 29 Jun 2026 11:59:41 +0100
Message-ID: <20260629105950.1790259-3-leo.bras@arm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629105950.1790259-1-leo.bras@arm.com>
References: <20260629105950.1790259-1-leo.bras@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2030; i=leo.bras@arm.com; h=from:subject; bh=rXl6YfMXYvYDSdPsMQ629hiSvMKFL5QOqwUVLE4GpL0=; b=owGbwMvMwCX2pizjszvTwvWMp9WSGLKc/Cs6dhxSS6pJkv3Oc8FsC4tdX+T8QmfVlS4ZK+zst 5s7nZvdUcrCIMbFICumyCL7aP4qnu9TMo5c+bEAZg4rE8gQBi5OAZjIZAOG/3Gl89f5beROEe74 OHHbgtnvPfgvlT5d1973I/nfMRNffkWGv/KiIoKux8JNeZZM7O45sOPV/fJp4a1G3KFrowSP3+n axQIA
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
2.54.0

