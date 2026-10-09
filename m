Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3690B4DE735;
	Fri,  9 Oct 2026 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550905; cv=none; b=iILyOD2uU/wGN49lfOZcUpRgDdYeYy+uEUSuEaT7gi2imMXN+YlsAJLeIV9RzP3+U0EReUUJIGjHwiA/ocaqqPYO6ayyl5T3jX4aqoaHFBzvKKpVh08EGM4UnULxP38cnjkt32BjuuJZColOJ4GJWtQFq9ksfXNdmjWYiC8wBfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550905; c=relaxed/simple;
	bh=hpA3yq1dtgYCQ1gEHC6AyIkyBLcI/2NeWdwfPF4ppdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4eLMvMxk7fNKDhkpygkGv9fEVGVeAivOnUVPVdlfKFMsqrVGGo5TCF3dMQ34rIpTo1N6DGoflq4yPFInXRvfbx8Vm/82+CfadTXLx1zhTMnLsg1AEsP+KP9l8AsS+cucOjHIuK5KfN2wz6Wid8JbB94Ws17G+WSwWHLrZBKl8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fGFeIfJX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fGFeIfJX"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33F781E32;
	Fri,  9 Oct 2026 06:01:40 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DA023F66F;
	Fri,  9 Oct 2026 06:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791550903; bh=hpA3yq1dtgYCQ1gEHC6AyIkyBLcI/2NeWdwfPF4ppdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fGFeIfJXQRmU/jcH8SgkDdZQYvRARaj7OLc3K91O3RjMSHlwZ0B1Ci7n9mK5gZtla
	 hW/U9Q5H+1nyEpXNQH2ktXYQqDxcffT0HW29RvrwGeh890X1PLNHki/E6+qjzMhHkv
	 HP31XSNCSj959is0fhTLAZsIDUtf+7KZuCqEzE5g=
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
Subject: [PATCH v2 3/5] KVM: selftests: Introduce kvm_get_dirty_ring_cap()
Date: Fri,  9 Oct 2026 14:00:48 +0100
Message-ID: <20261009130054.3312154-5-leo.bras@arm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009130054.3312154-2-leo.bras@arm.com>
References: <20261009130054.3312154-2-leo.bras@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2758; i=leo.bras@arm.com; h=from:subject; bh=hpA3yq1dtgYCQ1gEHC6AyIkyBLcI/2NeWdwfPF4ppdg=; b=owGbwMvMwCX2pizjszvTwvWMp9WSGLJOPG2o0fTf0+KtsNrgoEvUv/40mdeXt9n1hzBvtm27k 2U7K5qpo5SFQYyLQVZMkUX20fxVPN+nZBy58mMBzBxWJpAhDFycAjAR070M/71q17HOcU0IMe2Z vz1Qbcu0iU0t+zreye3j6EyeUcNb5sDI0G+0y2DqkeWXVszzfl/kMtNn1cY1JxvWTp2yMWSNnte daB4A
X-Developer-Key: i=leo.bras@arm.com; a=openpgp; fpr=36E6C95AE0F111CC5B6F4D2E688C33F8A0C5B0C5
Content-Transfer-Encoding: 8bit

In a preparation to introduce dirty-ring support in dirty_log_perf_test,
add a helper to detect the Dirty-ring capability and replace the checking
of individual capabilities in the dirty_log_test.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Leonardo Bras <leo.bras@arm.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 11 +++++++++++
 tools/testing/selftests/kvm/dirty_log_test.c   |  3 +--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 5a7a455b5387..a89758e66a68 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -300,20 +300,31 @@ static inline int get_kvm_param_integer(const char *param)
 	return kvm_get_module_param_integer("kvm", param);
 }
 
 unsigned int kvm_check_cap(long cap);
 
 static inline bool kvm_has_cap(long cap)
 {
 	return kvm_check_cap(cap);
 }
 
+static inline long kvm_get_dirty_ring_cap(void)
+{
+	if (kvm_has_cap(KVM_CAP_DIRTY_LOG_RING_ACQ_REL))
+		return KVM_CAP_DIRTY_LOG_RING_ACQ_REL;
+
+	if (kvm_has_cap(KVM_CAP_DIRTY_LOG_RING))
+		return KVM_CAP_DIRTY_LOG_RING;
+
+	return 0;
+}
+
 /*
  * Use the "inner", double-underscore macro when reporting errors from within
  * other macros so that the name of ioctl() and not its literal numeric value
  * is printed on error.  The "outer" macro is strongly preferred when reporting
  * errors "directly", i.e. without an additional layer of macros, as it reduces
  * the probability of passing in the wrong string.
  */
 #define __KVM_IOCTL_ERROR(_name, _ret)	__KVM_SYSCALL_ERROR(_name, _ret)
 #define KVM_IOCTL_ERROR(_ioctl, _ret) __KVM_IOCTL_ERROR(#_ioctl, _ret)
 
diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index af5eb0334a74..558a71d631da 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -284,22 +284,21 @@ static void default_after_vcpu_run(struct kvm_vcpu *vcpu)
 
 	TEST_ASSERT(get_ucall(vcpu, NULL) == UCALL_SYNC,
 		    "Invalid guest sync status: exit_reason=%s",
 		    exit_reason_str(run->exit_reason));
 
 	vcpu_handle_sync_stop();
 }
 
 static bool dirty_ring_supported(void)
 {
-	return (kvm_has_cap(KVM_CAP_DIRTY_LOG_RING) ||
-		kvm_has_cap(KVM_CAP_DIRTY_LOG_RING_ACQ_REL));
+	return kvm_get_dirty_ring_cap();
 }
 
 static void dirty_ring_create_vm_done(struct kvm_vm *vm)
 {
 	u64 pages;
 	u32 limit;
 
 	/*
 	 * We rely on vcpu exit due to full dirty ring state. Adjust
 	 * the ring buffer size to ensure we're able to reach the
-- 
2.55.0

