Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD73823EA87;
	Sat, 28 Feb 2026 00:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772240068; cv=none; b=aj/Ci2ScKRUSx4QGZ2T1qKyQzHAmtU6rfirUw+a6CCGg1G0jtot7D7gATd6BdGE6QUWc6L0Ov6xpf+HgogJEo//azod3gltlOWqCzfsTb9NvaHLBLTWgx+kghnhBSRhZBZf3YcXgnBjkZcQAx0NY22SImTU3rfDYxKU2LwlBp9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772240068; c=relaxed/simple;
	bh=I1akHnJlWwfH8S5HpA7qOgVYcSiZVNu876gNzuaaP6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cQi5kzV44IjbtSTGkOJWqdIqVG9w7ZfC8XzbD8Cab0dAGt8rd1vQPqbo9c5NjOAXvEnxPXO3TvVB0j8XxDeQUM87Au0MCcB9++2G/3T7E0ZI4YTXeTnB64beoUvHCJgM545FwdrXLDfCv3YhlAKH2OIJKmPKhSDmKlPWZros1h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fric.. (unknown [210.73.43.101])
	by APP-03 (Coremail) with SMTP id rQCowABXO+KkPKJpPMJ2CQ--.12049S5;
	Sat, 28 Feb 2026 08:54:00 +0800 (CST)
From: Jiakai Xu <xujiakai2025@iscas.ac.cn>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jiakai Xu <xujiakai2025@iscas.ac.cn>,
	Jiakai Xu <jiakaiPeanut@gmail.com>
Subject: [PATCH v9 3/3] RISC-V: KVM: selftests: Add RISC-V SBI STA shmem alignment tests
Date: Sat, 28 Feb 2026 00:53:55 +0000
Message-Id: <20260228005355.823048-4-xujiakai2025@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260228005355.823048-1-xujiakai2025@iscas.ac.cn>
References: <20260228005355.823048-1-xujiakai2025@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXO+KkPKJpPMJ2CQ--.12049S5
X-Coremail-Antispam: 1UD129KBjvJXoWxCr1fKw17CryftrW8KrW3Jrb_yoW5urWkpF
	WkCrnagr18Kws3A3yxKr4kZFyrWw4vyr4kZry3Zw4Fka1xAFs7Ary7KF4DZas8ursYqF1S
	vFySgF1UuF1DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQa14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxd
	M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
	C7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUmiifUUUUU=
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiDAcMCWmhss27agAAso

Add RISC-V KVM selftests to verify the SBI Steal-Time Accounting (STA)
shared memory alignment requirements.

The SBI specification requires the STA shared memory GPA to be 64-byte
aligned, or set to all-ones to explicitly disable steal-time accounting.
This test verifies that KVM enforces the expected behavior when
configuring the SBI STA shared memory via KVM_SET_ONE_REG.

Specifically, the test checks that:
- misaligned GPAs are rejected with -EINVAL
- 64-byte aligned GPAs are accepted
- all-ones GPA is accepted

Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
---
V8 -> V9: Dropped __riscv guard around INVALID_GPA, which is common to
           all architectures.
V7 -> V8: Moved INVALID_GPA definition to kvm_util_types.h.
          Removed comments in RISC-V check_steal_time_uapi().
          Corrected reg.id assignment for SBI STA.
V6 -> V7: Removed RISCV_SBI_STA_REG() macro addition and used existing
           KVM_REG_RISCV_SBI_STA_REG(shmem_lo) instead.
          Refined assertion messages per review feedback.
          Split into two patches per Andrew Jones' suggestion:
           Refactored UAPI tests from steal_time_init() into dedicated
            check_steal_time_uapi() function and added empty stub for
            RISC-V.
           Filled in RISC-V stub with STA alignment tests. (this patch)
---
 .../selftests/kvm/include/kvm_util_types.h    |  2 ++
 tools/testing/selftests/kvm/steal_time.c      | 31 +++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_types.h b/tools/testing/selftests/kvm/include/kvm_util_types.h
index ec787b97cf184..0366e9bce7f93 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_types.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_types.h
@@ -17,4 +17,6 @@
 typedef uint64_t vm_paddr_t; /* Virtual Machine (Guest) physical address */
 typedef uint64_t vm_vaddr_t; /* Virtual Machine (Guest) virtual address */
 
+#define INVALID_GPA (~(uint64_t)0)
+
 #endif /* SELFTEST_KVM_UTIL_TYPES_H */
diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index 75ad067f27260..0708b94ead895 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -332,6 +332,37 @@ static void steal_time_dump(struct kvm_vm *vm, uint32_t vcpu_idx)
 
 static void check_steal_time_uapi()
 {
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	struct kvm_one_reg reg;
+	uint64_t shmem;
+	int ret;
+
+	vm = vm_create_with_one_vcpu(&vcpu, NULL);
+
+	reg.id = KVM_REG_RISCV |
+			 KVM_REG_SIZE_ULONG |
+			 KVM_REG_RISCV_SBI_STATE |
+			 KVM_REG_RISCV_SBI_STA |
+			 KVM_REG_RISCV_SBI_STA_REG(shmem_lo);
+	reg.addr = (uint64_t)&shmem;
+
+	shmem = ST_GPA_BASE + 1;
+	ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
+	TEST_ASSERT(ret == -1 && errno == EINVAL,
+		    "misaligned STA shmem returns -EINVAL");
+
+	shmem = ST_GPA_BASE;
+	ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
+	TEST_ASSERT(ret == 0,
+		    "aligned STA shmem succeeds");
+
+	shmem = INVALID_GPA;
+	ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
+	TEST_ASSERT(ret == 0,
+		    "all-ones for STA shmem succeeds");
+
+	kvm_vm_free(vm);
 }
 
 #endif
-- 
2.34.1

