Received: from va-2-113.ptr.blmpb.com (va-2-113.ptr.blmpb.com [209.127.231.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A182D0622
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 03:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779681197; cv=none; b=mX6KtYepRwqhn+q2yOOhlR2JXnqY017EHRNtRzEBbOp0TBtbifbIHTA6IxAwHsgjOAkfaVOecA9WzxqOZoFVYx+TgYk2h3m6esMM95YzRd5EA+U2BecD/JoGdmDodEs3v60UpanKBatMVfmJvHo5+AaTFGHcu7lTLtB9mwa/1w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779681197; c=relaxed/simple;
	bh=L6ukFEBQXC/kIX4TNaD30CgrrmcjFvQgJZeQ9/827Zo=;
	h=Subject:Date:Content-Type:From:Message-Id:Mime-Version:To:Cc; b=QFwCud2IXamvWDz+2SD1OBwRGmpOxH0la6ELDY0g6j8hihjYBn+Rkyy/gcw53FD2M0HhX1pxt1LzvzVymGm20GI+JcztboHyVyxwwjOfz8otWQcLHRBOrOuU0Tq3dOIYwN8Hw6t/COZ/MhM0j8IpRjOAyynQF+eAErQE8rEsc58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=pkA+RHfA; arc=none smtp.client-ip=209.127.231.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="pkA+RHfA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779681184; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=fuzHHuhemOiKvdNY2llJuX8JkAEHKsIeyQhAf1pDTE4=;
 b=pkA+RHfAi80VG00ZbXKT4w3Wkh1uIew+c2r3rutO481QjOPF3rXNlSFWTrsQm1zwVjcLI6
 ioRZqm4qkKhKdRJdxOEFomVN1TunWlx2ttTN7zDI10HufOopDKhXSZILdVXMMR1C6vPIAw
 dtNfeS2TkdQUVq59+s8K1hcyraAM0iKB6B4ly+U5ADngfeemjEtD1BE/Ki8VJokKVTmTY2
 SdWQ/k4OL8Nh6TZxoCu/OG1/q7detxKomH6u1u0XylLJsJjj3wrJOI2xG4S0yUAG/H0Ybb
 5S4Phk5jJ04MXNhw/5NCc1uD/Z4X6+ee46Tq9zCD9a/UnEeBUrkqNjlNPoDPFA==
Subject: [v3 0/2] KVM: irqchip: Reduce KVM_SET_GSI_ROUTING allocation overhead
Date: Mon, 25 May 2026 11:52:40 +0800
X-Lms-Return-Path: <lba+26a13c79e+2834b8+vger.kernel.org+yanfei.xu@bytedance.com>
X-Mailer: git-send-email 2.20.1
Content-Type: text/plain; charset=UTF-8
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
Message-Id: <20260525035242.107264-1-yanfei.xu@bytedance.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: <seanjc@google.com>, <pbonzini@redhat.com>
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: <kvm@vger.kernel.org>, <caixiangfeng@bytedance.com>, 
	<fangying.tommy@bytedance.com>, <yanfei.xu@bytedance.com>, 
	<isyanfei.xu@gmail.com>

KVM_SET_GSI_ROUTING can become expensive for guests with many VFIO
devices and MSI-X vectors, Each update rebuilds the routing table, and
the repeated allocation/free of routing entries can dominate the cost of
kvm_set_irq_routing().

This series reduces that overhead in two steps.

Patch 1 allocates all routing entries in one contiguous allocation, so
the entries can be freed together instead of allocating and freeing each
entry independently.

Patch 2 adds a per-VM cache for one freed entries[] allocation and reuses
it when the next routing update needs the same allocation size.  This
avoids repeated allocation/free churn for frequent routing updates while
preserving the existing SRCU lifetime rules.

I wrote a test that continuously calls KVM_SET_GSI_ROUTING 50000 times and
count the elapsed time:
Test machine:
  Architecture: x86_64
  CPU: Intel Xeon Platinum 8336C @ 2.30GHz

With 512 routes:
Before:
    irq_routing_perf_test --routes=512 --iterations=50000
      total: 1557023.484 us
      average: 31.140 us/update
After:
    irq_routing_perf_test --routes=512 --iterations=50000
      total: 873104.338 us
      average: 17.462 us/update

With 4096 routes:                                                         
Before:
    irq_routing_perf_test --routes=4096 --iterations=50000
      total: 15192698.026 us
      average: 303.854 us/update 
After:
    irq_routing_perf_test --routes=4096 --iterations=50000
      total: 3295068.326 us
      average: 65.901 us/update
 
The result shows that the time spent per call is reduced by approximately
78.3% when the number of routing increase to 4096. It can significantly
improves routing update efficiency.

v2->v3:
1.switch kcalloc to kv flavor of allocation. (Sean's suggestion)
2.introduce patch2 to cache freed entries allocation and reuse it at the
  next routing update. (Sean's suggestion)

v1->v2:
1. fix variable 'r' is used uninitialized when a 'if' condition is true 
2. simplified free_irq_routing_table() by removing the iteration over the
   entries and the hlist cleanup.

[v2]: https://lore.kernel.org/kvm/20251226062741.4014391-1-yanfei.xu@bytedance.com/

Yanfei Xu (2):
  KVM: irqchip: KVM: Reduce allocation overhead in kvm_set_irq_routing()
  KVM: irqchip: Cache IRQ routing entries allocation

 arch/loongarch/kvm/irqfd.c |  2 +
 arch/powerpc/kvm/mpic.c    |  2 +
 arch/x86/kvm/irq.c         |  2 +
 include/linux/kvm_host.h   |  7 +++
 virt/kvm/irqchip.c         | 88 +++++++++++++++++++++++++++-----------
 5 files changed, 76 insertions(+), 25 deletions(-)

-- 
2.20.1
