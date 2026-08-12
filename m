Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6732E7179;
	Wed, 12 Aug 2026 04:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786507739; cv=none; b=XU4AMyk08pMUrk59e2vilzAC7d8OIOQ2bGg+pUfYDCQdZyh2mcq8jAP0/DOBFRKSkQZqjvZ+FQlV8/Hs7lCaQzo5iNqXjuFVu3ukfOh7jP0koKHPZYrumac0WX0mdR3Zgmy99Db5FqWnkTnI2tfuufM+JZtI1qbWk2aX1VhabaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786507739; c=relaxed/simple;
	bh=7lnXXUzQZDp2EExHa5V5YQJDqx2j/p196z7wJUwv86o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i7+CbkohL1hY0kFgZQSmLM8UMY9m2MFam26/Qz801E45yLRGzohI8j+MFH31awVk2FCT5PkNlAqtCc2ZiSCXk7OJqeqjyOJZqZmD/0ntSK2Xk85mz/wlgBfdTl9tekZnusLOahHHLzixFLWOXGjQkjX6Nztgp9o1NIdNN2HX/hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxfdLW8Xtq9m0AAA--.1386S3;
	Wed, 12 Aug 2026 12:08:54 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJDxzM7X8XtquY4BAA--.2948S2;
	Wed, 12 Aug 2026 12:08:55 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: KVM: Remove unused function kvm_arch_flush_remote_tlbs_memslot()
Date: Wed, 12 Aug 2026 12:01:32 +0800
Message-Id: <20260812040132.113812-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxzM7X8XtquY4BAA--.2948S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Function kvm_arch_flush_remote_tlbs_memslot() is not called any more,
and it is unused. Here remove this API.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/kvm_host.h | 1 -
 arch/loongarch/kvm/mmu.c              | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 23cfbecebbd7..5682b8c847d1 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -350,7 +350,6 @@ static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot) {}
 void kvm_check_vpid(struct kvm_vcpu *vcpu);
 enum hrtimer_restart kvm_swtimer_wakeup(struct hrtimer *timer);
-void kvm_arch_flush_remote_tlbs_memslot(struct kvm *kvm, const struct kvm_memory_slot *memslot);
 void kvm_init_vmcs(struct kvm *kvm);
 void kvm_exc_entry(void);
 int  kvm_enter_guest(struct kvm_run *run, struct kvm_vcpu *vcpu);
diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
index e104897aa532..2c08402bfd3e 100644
--- a/arch/loongarch/kvm/mmu.c
+++ b/arch/loongarch/kvm/mmu.c
@@ -939,9 +939,3 @@ int kvm_handle_mm_fault(struct kvm_vcpu *vcpu, unsigned long gpa, bool write, in
 void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot)
 {
 }
-
-void kvm_arch_flush_remote_tlbs_memslot(struct kvm *kvm,
-					const struct kvm_memory_slot *memslot)
-{
-	kvm_flush_remote_tlbs(kvm);
-}

base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
-- 
2.39.3

