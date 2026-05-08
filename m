Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF65155C82;
	Fri,  8 May 2026 01:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778205029; cv=none; b=OxcAB7y6GV2rPscvc9Mr67+KX1BsVJ39A/jXaYjC5WYE8sZBTkdH9KyTvUzWICuojRmJS4czEz6RcBjzG+4QLm7w9h8dq5p6bHPEeWFg4YqLzsRk7hpM0EQ0JLtHWx4sEes0JBTQmTuskQAOFOMJ4VosOnr1wgoZouL9IwN4zow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778205029; c=relaxed/simple;
	bh=M6rElpswawLj43RhvN2IOLXOGItFyqfuhnEW9Ixw1Js=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m8g3fpx3kMbaihdc0LfBJC5eXFrAnucNv562BUXeeSLK51p7F15itrmHLvr16uhHBnmCFnGegY1UBJz1t0VPC88iRO+QH2BLISpfLlsOHXkvaSVh6cnzGJM+GjCeXaN902a1vqUz9PrA0lPr+rNSaVuoxpHSf+Ibkj21aAlOs5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxncBgQf1pmb4HAA--.1081S3;
	Fri, 08 May 2026 09:50:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJDxzsJXQf1pIKB8AA--.40778S2;
	Fri, 08 May 2026 09:50:15 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Oliver Upton <oupton@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftests: Check guest memfd validity with flags
Date: Fri,  8 May 2026 09:50:13 +0800
Message-Id: <20260508015013.4108345-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxzsJXQf1pIKB8AA--.40778S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

The type of guest_memfd in structure kvm_userspace_memory_region2
is __u32, it is not correct to assign it with -1 and check whether
it is smaller than 0. Here check flags with KVM_MEM_GUEST_MEMFD
set.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 2a76eca7029d..9d3553f7e6a5 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -817,7 +817,7 @@ static void __vm_mem_region_delete(struct kvm_vm *vm,
 		kvm_munmap(region->mmap_alias, region->mmap_size);
 		close(region->fd);
 	}
-	if (region->region.guest_memfd >= 0)
+	if (region->region.flags & KVM_MEM_GUEST_MEMFD)
 		close(region->region.guest_memfd);
 
 	free(region);
@@ -1101,8 +1101,6 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 
 		region->region.guest_memfd = guest_memfd;
 		region->region.guest_memfd_offset = guest_memfd_offset;
-	} else {
-		region->region.guest_memfd = -1;
 	}
 
 	region->unused_phy_pages = sparsebit_alloc();

base-commit: 74fe02ce122a6103f207d29fafc8b3a53de6abaf
-- 
2.39.3

