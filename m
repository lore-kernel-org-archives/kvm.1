Received: from va-2-37.ptr.blmpb.com (va-2-37.ptr.blmpb.com [209.127.231.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B713596B
	for <kvm@vger.kernel.org>; Wed, 19 Feb 2025 01:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739930117; cv=none; b=GoPqNNHHPrZUTHQaqw9csZV+hnD2MaH14YUa1LLSfCszdrDZ8xjDYYlW791luwZ7JBHB8712B001dK+XWdC8jz1Zy0vEUWRwsbkGsPwRetZyteUrVF4dBbbhPmDee0QG0Sn4FR/OeSoTKtXHO/09JOBt+aCxSpsHNBqmFFD+KBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739930117; c=relaxed/simple;
	bh=U58Jx+9rEOcLurBCCRbc+xOiBgYN7pseBJjEBbRxXZU=;
	h=Message-Id:Content-Type:To:Cc:Subject:Date:Mime-Version:From; b=tj0uovFEex+UxEJc+OfvpJZVNo/G89HQop4wh5138UpD3V4yDTq5hCDri6ACVWvw/3bc35arVPafvQKty5mhg9qjbM1am3VxEtvcAzvGHD3UmD7BNv3iwGgQfO/JikB1mt2I/B/iDfOWKKgMH3s+juLNFYg2LWawRUdw1RlmiRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=k26LlSm5; arc=none smtp.client-ip=209.127.231.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="k26LlSm5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1739930102;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=cQPgSHvwewybXbQoyDuJoBkKJD1qHn20v1BZRnO8+8A=;
 b=k26LlSm53NadsMNE5zfLry2epZI+oanW9H3a21Xekfv6Spri6d4DXVSDqGl6sev9d4K7/j
 Wc+2zkusSy7LnQH7u8Dn2A7N8FKdHx6cbUv4eJpy/f9emjVuKVJ4cRnY6jE5i+OS91A1rr
 f8xrm1eJQUgI6WNgXT+YwCEYeM9Yz61b9FOWf5MvxrsUCN0UZqJseaOxNm8csb4HTvhzz+
 A+RoH3xxHEPuhVUahpK9RQIuuH51WR9u12NiOLrHKqZRL/cUoZYAY3H78ldB7ZXdRNO03W
 LYmRErJHmKZCn02bEZGYS4BchKR9+ZF7So/EVbsdTTzlx+j+8cLfh9ROIytMMw==
Message-Id: <20250219015426.1939-1-xiangwencheng@lanxincomputing.com>
X-Mailer: git-send-email 2.46.2.windows.1
X-Lms-Return-Path: <lba+267b539f4+e64b55+vger.kernel.org+xiangwencheng@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
To: <anup@brainfault.org>
Content-Transfer-Encoding: 7bit
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
Received: from localhost.localdomain ([222.128.9.250]) by smtp.feishu.cn with ESMTP; Wed, 19 Feb 2025 09:54:59 +0800
Cc: <ajones@ventanamicro.com>, <xiangwencheng@lanxincomputing.com>, 
	<kvm-riscv@lists.infradead.org>, <kvm@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<atishp@atishpatra.org>, <paul.walmsley@sifive.com>, 
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>
Subject: [PATCH] riscv: KVM: Remove unnecessary vcpu kick
Date: Wed, 19 Feb 2025 09:54:26 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: "BillXiang" <xiangwencheng@lanxincomputing.com>

Thank you Andrew Jones, forgive my errors in the last email.
I'm wondering whether it's necessary to kick the virtual hart
after writing to the vsfile of IMSIC.
From my understanding, writing to the vsfile should directly
forward the interrupt as MSI to the virtual hart. This means that
an additional kick should not be necessary, as it would cause the
vCPU to exit unnecessarily and potentially degrade performance.
I've tested this behavior in QEMU, and it seems to work perfectly
fine without the extra kick.
Would appreciate any insights or confirmation on this!
Best regards.

Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
---
 arch/riscv/kvm/aia_imsic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index a8085cd8215e..29ef9c2133a9 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -974,7 +974,6 @@ int kvm_riscv_vcpu_aia_imsic_inject(struct kvm_vcpu *vcpu,
 
 	if (imsic->vsfile_cpu >= 0) {
 		writel(iid, imsic->vsfile_va + IMSIC_MMIO_SETIPNUM_LE);
-		kvm_vcpu_kick(vcpu);
 	} else {
 		eix = &imsic->swfile->eix[iid / BITS_PER_TYPE(u64)];
 		set_bit(iid & (BITS_PER_TYPE(u64) - 1), eix->eip);
-- 
2.46.2
