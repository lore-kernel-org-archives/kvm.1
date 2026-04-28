Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329F431A061;
	Tue, 28 Apr 2026 05:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777354444; cv=none; b=rbUyGzbkBX+ns+uw5sDwIkSEKi9ZdREgQFSN7gAO6CZj+N2Ozq/rgKqbWrClCmVcWADZ5qa+gomqQMD5AP3XUOEil2aBqXDAt1IjcAziWXD6I9bVlA7F5xk/2O1xs2X/XkZ8/MONHJBcdmxnPKEFcPa0fDdmsok9QORlIET89WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777354444; c=relaxed/simple;
	bh=fD03mv94P9IXgR0y6MiL9xNHEmmNM8uUhtDrkPeiuy4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FB+vqabT2Cg5B4/U0HqgyorO/FCr/U79yUZAKjZJudKhWVsIj2PkU7Z/f+VyvnKZIbBTbszweWcGKgBJ0E3g7ScdQt3fqP9ZjFN2P2unueE5lgWxcHEXon5C1Lhs1TMKmXNAVRwrsKak8dRvqqoo9J/c1u+dPmehAC3PCCgLKr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowACXKAy6RvBp2YXKDg--.35140S2;
	Tue, 28 Apr 2026 13:33:46 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: pbonzini@redhat.com,
	shuah@kernel.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenhuacai@kernel.org,
	seanjc@google.com,
	dmatlack@google.com,
	gaosong@loongson.cn,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] KVM: selftests: Convert comma to semicolon
Date: Tue, 28 Apr 2026 13:32:04 +0800
Message-Id: <20260428053204.1018608-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXKAy6RvBp2YXKDg--.35140S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr4rCw4kuw4kuw1xGrW3ZFb_yoWkZwcEva
	9xKwnrCr4kAa4jvF4293WFqF4rCa17WF4xZF90qF13GF1UAFZ8Wr4kZ34kAryYgr45KrZI
	kFs7Gr4akr429jkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GrWl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOHUqUUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Replace comma between expressions with semicolons.

Using a ',' in place of a ';' can have unintended side effects.
Although that is not the case here, it is seems best to use ';'
unless ',' is intended.

Found by inspection.
No functional change intended.
Compile tested only.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 tools/testing/selftests/kvm/loongarch/pmu_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/loongarch/pmu_test.c b/tools/testing/selftests/kvm/loongarch/pmu_test.c
index ec3fefb9ea97..bf3ca5e66bf3 100644
--- a/tools/testing/selftests/kvm/loongarch/pmu_test.c
+++ b/tools/testing/selftests/kvm/loongarch/pmu_test.c
@@ -167,8 +167,8 @@ int main(int argc, char *argv[])
 	vm_install_exception_handler(vm, EXCCODE_INT, guest_irq_handler);
 	sync_global_to_guest(vm, pmu_irq_count);
 
-	attr.group = KVM_LOONGARCH_VM_FEAT_CTRL,
-	attr.attr = KVM_LOONGARCH_VM_FEAT_PMU,
+	attr.group = KVM_LOONGARCH_VM_FEAT_CTRL;
+	attr.attr = KVM_LOONGARCH_VM_FEAT_PMU;
 
 	ret = ioctl(vm->fd, KVM_HAS_DEVICE_ATTR, &attr);
 
-- 
2.43.0

