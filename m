Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6E24E06FF;
	Fri,  9 Oct 2026 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550908; cv=none; b=aM7Phk8kLTuOivOmnIjQNnE7KhsHwwbeQlEMw9IXWIfEB4d44Eu4tGWKvDghsLSgolnMygyH9SBTB/DNQXikx+tMB/FJmvQGqo8jjAtsySSqufOM09JohujSWKgpUQq9AQIga3VQz5+BA3aSxwxP1sPnb0iPGP2jdxp3nqlg4EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550908; c=relaxed/simple;
	bh=DApXm/g1Dtg73I8PDC2dA4PYJOzC97JRvsUungOi/5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDNR2yX4bU9TWaMKTq82N6WPY1Ps9vC3IDCaGdvak7rqiFjXbZJeyguty3iMfedWYNmzC1UEcJgP/oihjfZSmoFuGjhAhkb6X3s4H/oLlJExq4D2RMdcJiKygJ0Vy3co/pTua8D15Y9svM2mxvsRIXeH849KqQuciggvOmX6sRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dUn7MKhT; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dUn7MKhT"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96BBD1E4D;
	Fri,  9 Oct 2026 06:01:42 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D18363F66F;
	Fri,  9 Oct 2026 06:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791550905; bh=DApXm/g1Dtg73I8PDC2dA4PYJOzC97JRvsUungOi/5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dUn7MKhTj/26AbVPn34UeYbM9/qhAMj+DyNYw+m8YpSkP7RIbglu1Mlfo/D7r6w/q
	 KlKB9O5S8W0oiGGkXCOXjRSoI74luTqUgt4YEJdXyz5tXI2KDOrgOyFwXhjSwiegTi
	 QKbx7lWAyWMQVRghZyZk2EDOQ7OJolVn9chFFy6Q=
From: Leonardo Bras <leo.bras@arm.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Oliver Upton <oupton@kernel.org>,
	Leonardo Bras <leo.bras@arm.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Josh Hilke <jrhilke@google.com>,
	Wu Fei <wu.fei9@sanechips.com.cn>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] KVM: selftests: Check dirty-ring size before enabling
Date: Fri,  9 Oct 2026 14:00:49 +0100
Message-ID: <20261009130054.3312154-6-leo.bras@arm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009130054.3312154-2-leo.bras@arm.com>
References: <20261009130054.3312154-2-leo.bras@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2116; i=leo.bras@arm.com; h=from:subject; bh=DApXm/g1Dtg73I8PDC2dA4PYJOzC97JRvsUungOi/5A=; b=owGbwMvMwCX2pizjszvTwvWMp9WSGLJOPG3okLpdEOW3wfjj/qkqP09267ScmD1xetKfmb2qj imphyZqdZSyMIhxMciKKbLIPpq/iuf7lIwjV34sgJnDygQyhIGLUwAmMmsmwz/tZhGtF1O1inb4 +4RWBl7STF9+oPJZw7WWb482nT/xvC2a4X/N69+l+8RZH9zfO0/yueqf82zZXNFKrJqOM5zt63Z lp7MDAA==
X-Developer-Key: i=leo.bras@arm.com; a=openpgp; fpr=36E6C95AE0F111CC5B6F4D2E688C33F8A0C5B0C5
Content-Transfer-Encoding: 8bit

As of today, trying to enable dirty-ring with a size bigger than the
maximum will return an "argument list too long" error.

Change vm_enable_dirty_ring() to get the maximum size, then compare it to
the desired size before enabling. If the value is invalid, print a more
precise error message.

Signed-off-by: Leonardo Bras <leo.bras@arm.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 9ddc047d5c27..fbd0aaa679d6 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -168,24 +168,36 @@ unsigned int kvm_check_cap(long cap)
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
+	long cap = kvm_get_dirty_ring_cap();
+	int max_size;
+
+	TEST_ASSERT(cap, "Dirty-ring not supported, check CONFIG_HAVE_KVM_DIRTY_RING");
+
+	TEST_ASSERT(is_power_of_2(ring_size),
+		    "Dirty-ring size '0x%x' must be a power-of-2", ring_size);
+	TEST_ASSERT(ring_size >= getpagesize(),
+		    "Dirty-ring size '0x%x' must be at least one (host) page", ring_size);
+
+	max_size = vm_check_cap(vm, cap);
+	TEST_ASSERT(ring_size <= max_size,
+		    "Dirty-ring size '0x%x' is larger than KVM's limit of '0x%x'",
+		    ring_size, max_size);
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

