Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345BF516155;
	Tue, 29 Sep 2026 11:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681888; cv=none; b=tTlEnNFSyT+xZbFMoLPBH85oMHnifCbYBJTKk3vpgm48hMJqtSSxAQMLxramKdu/a1M//JY1HnrPXu1rNuhbGMQkVGtalpw4z9C6gZXJPlncspxaEitQyZ/xClXHMrHQWyYELsjJQBCYzf2ax6HQaWYq+bMrJVKs4qgxhYlCWmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681888; c=relaxed/simple;
	bh=l7iHp/nYTAmXpSl28UxGd/C9iQ1tfsrCicD9vEJJIkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdeUScjL/DQ2ZpasUSH28pZx0kmdoGy/O6VzEmBXUobIhVjoO0tfnf+Wpe+w2vIS2LTJqW4js4U8X/BPeHac5o/oK8YEzr05Ko/GtynMAJTNKXUCc/zp3zka7X8FNe6u0wyu8o4Pwof75GNKqYzgX6ODvqj+1DmdqmoxAyAPkYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LgGCX326; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LgGCX326"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE4161595;
	Tue, 29 Sep 2026 04:38:01 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 278173F85F;
	Tue, 29 Sep 2026 04:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790681885; bh=l7iHp/nYTAmXpSl28UxGd/C9iQ1tfsrCicD9vEJJIkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LgGCX326wY91p0IyDdSEZuuhls6p6+LhM7XO439l/hUcWuOCK2TSh91cgSA+4kQxG
	 LkaFcUKBZqMDWQbeIVThKjBOKIb+VrIH6mkQhuLu43fUOu0OlqApCeA//Nltc85JSX
	 yC6yvHLpgvBWoQQy+0wWpAOk+k/KDAKBg8v2fkTY=
From: Leonardo Bras <leo.bras@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Leonardo Bras <leo.bras@arm.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Josh Hilke <jrhilke@google.com>,
	Oliver Upton <oupton@kernel.org>,
	Wu Fei <wu.fei9@sanechips.com.cn>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] KVM: selftests: Check dirty-ring size before enabling
Date: Tue, 29 Sep 2026 12:37:07 +0100
Message-ID: <20260929113711.2064390-3-leo.bras@arm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929113711.2064390-1-leo.bras@arm.com>
References: <20260929113711.2064390-1-leo.bras@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2137; i=leo.bras@arm.com; h=from:subject; bh=l7iHp/nYTAmXpSl28UxGd/C9iQ1tfsrCicD9vEJJIkw=; b=owGbwMvMwCX2pizjszvTwvWMp9WSGLJ2L5rBFBH7+2qN5a67krcWXuQU9F10LGvDlhWV507s4 PnYlP/6RkcpC4MYF4OsmCKL7KP5q3i+T8k4cuXHApg5rEwgQxi4OAVgIlv4GBluO3U3zZnZqh7+ SkMwOsbj8uOVqStupyf9O7fhl9DPvde5GP5p/Jh6uFfz63SV3ovRmZ8vX0w+w9jFfpRrgqTWOU8 5XgYWAA==
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
index 9ddc047d5c27..15a671b71553 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -168,24 +168,37 @@ unsigned int kvm_check_cap(long cap)
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

