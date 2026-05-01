Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40991EEA31;
	Fri,  1 May 2026 02:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777601817; cv=none; b=PDoUA7dmhy8V5qlpOYE6KRvx2kafS+oJoNphnTXxOCx6fZ+grbLoPr5+cGhFGCQJ1Y0IzhgqFuX8RNlCJAepMQB/sGSU1lk7UQbsb0kobmzd21LRvOw/Ib+yWhRGj1Nxmz/so6L8iBjD35KfC4vvV7emlHylp6s+5oDZMIGTqdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777601817; c=relaxed/simple;
	bh=f6gSBn9P/CgOI/34hVibjzE9zYcFXx2vZl9HyYKG72Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BlvozWfPS/DEh+N97LLRg11PGQpsups1qS6OuX6eO60RDS37CjEePhkeEESU3zWSUTKVwbPPVFv3UMv9T8xV8m2igO8t6eePvagMthhjBwVV00y9OhoadWYSKFC0TTRlNWRdCeKTNDR7sGNr6VVRqhtQ5tviS3JGseibm/Yf2W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAD3iw8LDfRpCp0UDw--.14623S2;
	Fri, 01 May 2026 10:16:43 +0800 (CST)
From: Jiakai Xu <xujiakai2025@iscas.ac.cn>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Anup Patel <anup@brainfault.org>,
	Jiakai Xu <xujiakai2025@iscas.ac.cn>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Jiakai Xu <jiakaiPeanut@gmail.com>
Subject: [PATCH] KVM: arm64: Add memslot for ST_GPA_BASE in check_steal_time_uapi()
Date: Fri,  1 May 2026 02:16:39 +0000
Message-Id: <20260501021639.2563219-1-xujiakai2025@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3iw8LDfRpCp0UDw--.14623S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy3Gr1DGFWrAr4fuw17Wrg_yoW8XrW5pF
	W8CFnxKryrtrnrt3WUCr4DXF45Gw4v9r1kJwnxXw13ur4rtrs2vrWIkr93Z3yUXa9Yqr1r
	ZayxtF17urWDWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUAxhLUUUUU=
X-CM-SenderInfo: 50xmxthndljiysv6x2xfdvhtffof0/1tbiBwwOCWnz4uBbkwAAsc

The refactored check_steal_time_uapi() creates a temporary VM via
vm_create_with_one_vcpu(), whose default memslot0 only covers GPA
0..~2MB.  Setting st_ipa to ST_GPA_BASE (1 << 30) causes
kvm_arm_pvtime_set_attr() to fail with EINVAL because gfn_to_hva()
cannot find a valid memslot at the target GFN.

Add a memslot at ST_GPA_BASE in the temporary VM, mirroring what
the main test already does.

Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/lkml/afM8WEe4gG5tL4fH@sirena.co.uk
Signed-off-by: Jiakai Xu <xujiakai2025@iscas.ac.cn>
Signed-off-by: Jiakai Xu <jiakaiPeanut@gmail.com>
Fixes: 40351ed924dd30 ("KVM: selftests: Refactor UAPI tests into dedicated function")
---
 tools/testing/selftests/kvm/steal_time.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index 7df2bc8eec02..2b01b466ddc1 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -213,6 +213,10 @@ static void check_steal_time_uapi(void)
 
 	vm = vm_create_with_one_vcpu(&vcpu, NULL);
 
+	/* ST_GPA_BASE needs a valid memslot for gfn_to_hva() to succeed */
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, ST_GPA_BASE,
+				    1, 1, 0);
+
 	struct kvm_device_attr dev = {
 		.group = KVM_ARM_VCPU_PVTIME_CTRL,
 		.attr = KVM_ARM_VCPU_PVTIME_IPA,
-- 
2.34.1

