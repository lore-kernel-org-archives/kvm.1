Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE681DDC1B;
	Fri,  6 Feb 2026 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770342339; cv=none; b=CRhtbnDzQqvH19A0ZxrMMiU9vWFAKaR1ZUcvvrGNO4KDW6HwgiAJtH1bY78pO4zI7y+PvpD5krqwaio5D7oubiYol4i01f4kYNBrnw6AHj4IoWw0SsW8u6K86gptJRTFhFMyybQt6fvwOkEGCj/Y6g1YZ66u6wJ0yjMvY0mrG24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770342339; c=relaxed/simple;
	bh=ii6RKtFYyE+Ewcaswlc7T5jvksLlmxsqr496cRHnhqY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SMc5DC/sjOBls8Vrb3dGnI1+r9/owNIyYrfWx0yTIlN60E9UoIlaGy5buFGAmtAsF66trwWKc0m+a8S2AeqXgYTJvycSrk9CIFqUHpzB+NJn2hi0J5UxVMKSpl/89trCO3uk/BWvJ+/sBkrnzyyJZjd4jZQwc0QIq/lChQvRICI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.185])
	by gateway (Coremail) with SMTP id _____8CxLMO5R4Vp1FYQAA--.52757S3;
	Fri, 06 Feb 2026 09:45:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
	by front1 (Coremail) with SMTP id qMiowJCx98C3R4VpgLZAAA--.40823S2;
	Fri, 06 Feb 2026 09:45:28 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn,
	chenhuacai@kernel.org
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	kernel@xen0n.name,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] LongArch: KVM: Add DMSINTC support irqchip in kernel
Date: Fri,  6 Feb 2026 09:20:26 +0800
Message-Id: <20260206012028.3318291-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx98C3R4VpgLZAAA--.40823S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Hi,

This series  implements the DMSINTC in-kernel irqchip device,
enables irqfd to deliver MSI to DMSINTC, and supports injecting MSI interrupts
to the target vCPU.
applied this series.  use netperf test.
VM with one CPU and start netserver, host run netperf.
disable dmsintc
taskset 0x2f  netperf -H 192.168.122.204 -t UDP_RR  -l 36000
Local /Remote
Socket Size   Request  Resp.   Elapsed  Trans.
Send   Recv   Size     Size    Time     Rate
bytes  Bytes  bytes    bytes   secs.    per sec   

212992 212992 1        1       36000.00   27107.36   

enable dmsintc
Local /Remote
Socket Size   Request  Resp.   Elapsed  Trans.
Send   Recv   Size     Size    Time     Rate         
bytes  Bytes  bytes    bytes   secs.    per sec   

212992 212992 1        1       36000.00   28831.14  (+6.3%)

v6: 
  Fix kvm_device leak in kvm_dmsintc_destroy(). 

v5:
  Combine patch2 and patch3
  Add check msgint feature when register DMSINT device. 

V4: Rebase and R-b; 
   replace DINTC to DMSINTC.


V3: Fix kvm_arch_set_irq_inatomic() missing dmsintc set msi.(patch3)

V2:
https://patchew.org/linux/20251128091125.2720148-1-gaosong@loongson.cn/

Thanks.
Song Gao

Song Gao (2):
  LongArch: KVM: Add DMSINTC device support
  LongArch: KVM: Add dmsintc inject msi to the dest vcpu

 arch/loongarch/include/asm/kvm_dmsintc.h |  22 +++++
 arch/loongarch/include/asm/kvm_host.h    |   8 ++
 arch/loongarch/include/uapi/asm/kvm.h    |   4 +
 arch/loongarch/kvm/Makefile              |   1 +
 arch/loongarch/kvm/intc/dmsintc.c        | 117 +++++++++++++++++++++++
 arch/loongarch/kvm/interrupt.c           |   1 +
 arch/loongarch/kvm/irqfd.c               |  42 +++++++-
 arch/loongarch/kvm/main.c                |   6 ++
 arch/loongarch/kvm/vcpu.c                |  58 +++++++++++
 include/uapi/linux/kvm.h                 |   2 +
 10 files changed, 257 insertions(+), 4 deletions(-)
 create mode 100644 arch/loongarch/include/asm/kvm_dmsintc.h
 create mode 100644 arch/loongarch/kvm/intc/dmsintc.c

-- 
2.39.3

