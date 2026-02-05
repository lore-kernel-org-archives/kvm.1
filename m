Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825001A0BF3;
	Thu,  5 Feb 2026 01:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770253524; cv=none; b=SquIQ0NipU9vHxaXu17+yZu/ryLp+Y2GoEv0lt2fDnURde9zlUX08s77lZD8kSU24YLBmLGe9G0mCvqQvGYBf6BRQcyXSZsxVGORCIf4htXVWMV0JBpis0iDUpezuT1720hjoFs/IOJ8gcif3BIGbTio9qdQCc3msJfja+Nt7RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770253524; c=relaxed/simple;
	bh=QHsjVMGkgiV8AH3RnGbijs0L2IzNi5CzSF7b9hE5cPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hlm9F4n3z+RI0QDiDEQBtXctxLt84lIKwlSU7phYp1ROAzFFjuMVVMeN4c98DN9SBBUih4YSFBKsy8JNRmi4uPQKiz0JoAC7+1iO+uxSDUn2NTe//goFwFvknC6EqDu3BmocudoIUSG1TinQtsR244QFQyR0k2vY2T+CJU7QqUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fric.. (unknown [210.73.43.101])
	by APP-03 (Coremail) with SMTP id rQCowACXt97A7INpzKW1Bw--.43975S4;
	Thu, 05 Feb 2026 09:05:05 +0800 (CST)
From: Jiakai Xu <xujiakai2025@iscas.ac.cn>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Jiakai Xu <xujiakai2025@iscas.ac.cn>,
	Jiakai Xu <jiakaiPeanut@gmail.com>
Subject: [PATCH v6 2/2] RISC-V: KVM: selftests: Add RISC-V SBI STA shmem alignment tests
Date: Thu,  5 Feb 2026 01:05:02 +0000
Message-Id: <20260205010502.2554381-3-xujiakai2025@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205010502.2554381-1-xujiakai2025@iscas.ac.cn>
References: <20260205010502.2554381-1-xujiakai2025@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXt97A7INpzKW1Bw--.43975S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCr1fKw17CF15CrWfXrW3Awb_yoW5trW5pF
	WkCwn0vFW8KFWxt34xKr1vqF4Fg3ykKr4vvrWxu3yrAF4xtrWxJrsrKFyDZ34DWrZ5X3WS
	vFyIgF4Uua1UXa7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxd
	M2kKe7AKxVWUXVWUAwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv04
	87Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280
	aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67
	IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWr
	XwCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjTRu89NDUUUU
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiDAcJCWmD6tsHtgAAsh

Add RISC-V KVM selftests to verify the SBI Steal-Time Accounting (STA)
shared memory alignment requirements.

The SBI specification requires the STA shared memory GPA to be 64-byte
aligned, or set to all-ones to explicitly disable steal-time accounting.
This test verifies that KVM enforces the expected behavior when
configuring the SBI STA shared memory via KVM_SET_ONE_REG.

Specifically, the test checks that:
- misaligned GPAs are rejected with -EINVAL
- 64-byte aligned GPAs are accepted
- INVALID_GPA correctly disables steal-time accounting

Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
---
 .../selftests/kvm/include/riscv/processor.h   |  4 +++
 tools/testing/selftests/kvm/steal_time.c      | 33 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index e58282488beb3..c3551d129d2f6 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -62,6 +62,10 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t subtype,
 						     KVM_REG_RISCV_SBI_SINGLE,		\
 						     idx, KVM_REG_SIZE_ULONG)
 
+#define RISCV_SBI_STA_REG(idx)	__kvm_reg_id(KVM_REG_RISCV_SBI_STATE,	\
+						     KVM_REG_RISCV_SBI_STA,			\
+						     idx, KVM_REG_SIZE_ULONG)
+
 bool __vcpu_has_ext(struct kvm_vcpu *vcpu, uint64_t ext);
 
 static inline bool __vcpu_has_isa_ext(struct kvm_vcpu *vcpu, uint64_t isa_ext)
diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index 8edc1fca345ba..30b98d1b601c3 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -209,6 +209,7 @@ static void steal_time_dump(struct kvm_vm *vm, uint32_t vcpu_idx)
 
 /* SBI STA shmem must have 64-byte alignment */
 #define STEAL_TIME_SIZE		((sizeof(struct sta_struct) + 63) & ~63)
+#define INVALID_GPA (~(u64)0)
 
 static vm_paddr_t st_gpa[NR_VCPUS];
 
@@ -301,6 +302,34 @@ static void steal_time_dump(struct kvm_vm *vm, uint32_t vcpu_idx)
 	pr_info("\n");
 }
 
+static void test_riscv_sta_shmem_alignment(struct kvm_vcpu *vcpu)
+{
+	struct kvm_one_reg reg;
+	uint64_t shmem;
+	int ret;
+
+	reg.id = RISCV_SBI_STA_REG(0);
+	reg.addr = (uint64_t)&shmem;
+
+	/* Case 1: misaligned GPA */
+	shmem = ST_GPA_BASE + 1;
+	ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
+	TEST_ASSERT(ret == -1 && errno == EINVAL,
+		    "misaligned STA shmem should return -EINVAL");
+
+	/* Case 2: 64-byte aligned GPA */
+	shmem = ST_GPA_BASE;
+	ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
+	TEST_ASSERT(ret == 0,
+		    "aligned STA shmem should succeed");
+
+	/* Case 3: INVALID_GPA disables STA */
+	shmem = INVALID_GPA;
+	ret = __vcpu_ioctl(vcpu, KVM_SET_ONE_REG, &reg);
+	TEST_ASSERT(ret == 0,
+		    "INVALID_GPA should disable STA successfully");
+}
+
 #endif
 
 static void *do_steal_time(void *arg)
@@ -369,6 +398,10 @@ int main(int ac, char **av)
 	TEST_REQUIRE(is_steal_time_supported(vcpus[0]));
 	ksft_set_plan(NR_VCPUS);
 
+#ifdef __riscv
+	test_riscv_sta_shmem_alignment(vcpus[0]);
+#endif
+
 	/* Run test on each VCPU */
 	for (i = 0; i < NR_VCPUS; ++i) {
 		steal_time_init(vcpus[i], i);
-- 
2.34.1

