Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FFB361657;
	Thu, 27 Aug 2026 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787829767; cv=none; b=SgLPPRwnCxkNEFxJULpL+z7BmdD/sOOYRgiHeFCu0V2vqRroP/FHPbvllRb6u1m+yUfa4TvCed80TJk4krK2Q4rVtMdoXd1i0WvmTdJhlz3MzEw1dyiGjd1aFUyaO6WAQyQ2R95xPxoM4+SpoHWbArp3FTbV+15cYu8qHvacAv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787829767; c=relaxed/simple;
	bh=cqAWRSgYTHV3fOWdtmBR3Tr7DvLbDBa9N+ao5ZkOjRU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dCZajpupF/+9BxC2flL9cCDyMUGsgHgssdfLIKzDQ3TrZHOz45SJ5ogUQ4OVCCfQcbGsm2qnyIGThnJi3tt2lGnP6jeC+kHBxO7/J2rl+hiIct1wihfeD1c0JChU2OnOP+wTnf08O80JTcx9tsZ6ZjRROX0CNQ6+djmobMQCySc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=p5wWHTF4; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="p5wWHTF4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=R/
	kgS3Aa81E+reF8g/MlREJZholSotIPm3yvYCgTSo8=; b=p5wWHTF46H3ACQEp2a
	XxdoehfP1gycNXg+MLuPgaEJ4+tYOQXjU89fATY9QEapspodSqMWo9LQAOLKsGYG
	3mzyaQlPliI8E0i2Y+MwLoiOP5MbB69LQ7m2WCT2N8iN/dJPCp8ffTGpGnEF+fL3
	1zN71LgSWuPGYYESFiTDRpTtM=
Received: from zengchi (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wC3zrDaHZBqxfaaPw--.4791S2;
	Thu, 27 Aug 2026 19:22:04 +0800 (CST)
From: Zeng Chi <zeng_chi911@163.com>
To: pbonzini@redhat.com,
	seanjc@google.com,
	imbrenda@linux.ibm.com,
	xiaoyao.li@intel.com,
	schlameuss@linux.ibm.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zengchi@kylinos.cn
Subject: [PATCH] KVM: Mask off the address space ID in kvm_set_internal_memslot() check
Date: Thu, 27 Aug 2026 19:22:00 +0800
Message-Id: <20260827112200.866476-1-zeng_chi911@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3zrDaHZBqxfaaPw--.4791S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr1xKF1xJF1UKr4ruFyDKFg_yoW8ArW8pF
	W3Cw1DKr48JF1IvF4vgw4kWr97C392qFsrCr47Ww4Y9r1fKF43AF4kK3ZrJFn8trZYqa40
	vFy5Xay7u34kXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5a93UUUUU=
X-CM-SenderInfo: 52hqws5fklmiqr6rljoofrz/xtbCwBw9+GqQHdxdqAAA3X

From: Zeng Chi <zengchi@kylinos.cn>

kvm_set_internal_memslot() is supposed to reject memslot IDs that belong
to userspace, i.e. IDs below KVM_USER_MEM_SLOTS, but it compares the raw
"slot" field, which packs both the address space ID and the memslot ID
(as_id << 16 | id).  For any address space other than 0, the packed value
is always >= 65536, which is larger than KVM_USER_MEM_SLOTS, and so the
sanity check is a nop regardless of the actual memslot ID.

E.g. x86 sets internal memslots for every address space, including SMM,
so the check would silently accept a userspace memslot ID for the SMM
address space while rejecting the same ID for the normal address space.

Extract the memslot ID the same way kvm_vm_ioctl_set_memory_region() and
kvm_set_memory_region() do, so that the check covers all address spaces.
No in-tree caller trips the check; this only makes the sanity check
effective for all address spaces.

Fixes: 156bffdb2b49 ("KVM: Add a dedicated API for setting KVM-internal memslots")
Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d..e8d0e360ea26 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2128,7 +2128,7 @@ static int kvm_set_memory_region(struct kvm *kvm,
 int kvm_set_internal_memslot(struct kvm *kvm,
 			     const struct kvm_userspace_memory_region2 *mem)
 {
-	if (WARN_ON_ONCE(mem->slot < KVM_USER_MEM_SLOTS))
+	if (WARN_ON_ONCE((u16)mem->slot < KVM_USER_MEM_SLOTS))
 		return -EINVAL;
 
 	if (WARN_ON_ONCE(mem->flags))
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

