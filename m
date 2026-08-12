Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1326375AC6;
	Wed, 12 Aug 2026 05:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513195; cv=none; b=TJ0+PBAa2XCGmrE28eM2Dv1NuZK6M2ZgA8iUGJio3tM3+jSo4wPPBBaOoztIJXaH1hvWcJD+zRsoFH9pHPLX+wJB6WMJssTiRgtQ1UCxB2B8+JKTJSuJi9pqT1T0PYsYBB4rsqkg65YpWYAxqHT67jY8H/HstJDhr01MDhSruJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513195; c=relaxed/simple;
	bh=Oji9FjxRwWcmTl7lw+lP8Ij/7MiaOpuczML+giuFYkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KXueBBCaPLPa8tuwUrP2sjuIWiSoFsx9ESR+5d3gT8qO1KNTdMaxLFIof8TsvZsc27Pr9ViNFr4S7C3dWS3srAJQCtyHYFvN1X+vi4XHqBTLiU5huDSXFABwIYmm4qwHbDrVnB5k3nYL1Q/C6okszBFKw3GstVti3eeAVEbocCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-05 (Coremail) with SMTP id zQCowADnVD8UB3xqybQxBQ--.41533S2;
	Wed, 12 Aug 2026 13:39:34 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Nutty Liu <nutty.liu@hotmail.com>,
	Guo Ren <guoren@kernel.org>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] RISC-V: KVM: Validate AIA MMIO ranges against GPA width
Date: Wed, 12 Aug 2026 13:39:30 +0800
Message-ID: <cover.1786512671.git.pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnVD8UB3xqybQxBQ--.41533S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XrWfWryxCF1xJFyrJw4ruFg_yoWkGwc_ua
	sY9a45Xw18WF4vqa43Kr4UGrZ5W3y2gFy7AFyDAFWxGryDXr9Iga1kKry8uFyxu3y5Ar1D
	AryS93WSywnxKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The AIA device API currently checks only the alignment of userspace-
supplied APLIC and IMSIC base addresses.  This can publish a wrapping
fixed-size MMIO interval or one that lies beyond the selected stage-2
guest physical address (GPA) width.

There are two points to close because the GPA width is configurable:

1. Validate every complete range when it is stored and again immediately
   before AIA initialization publishes the first MMIO device.
2. Once AIA initialization has published those devices, prevent the GPA
   width from being reduced below their addresses.

Both initialization and GPA-width changes are serialized by kvm->lock.
The series was reviewed against the RISC-V KVM queue at
dfdf1374fdeccb5b7e3d35186228e01ec5ea5f01.  No build or runtime testing
was performed.

Pengpeng Hou (2):
  RISC-V: KVM: Validate AIA MMIO address ranges
  RISC-V: KVM: Disallow GPA-width changes after AIA init

 arch/riscv/kvm/aia_device.c | 79 +++++++++++++++++++++++++++++++------
 arch/riscv/kvm/vm.c         |  3 +-
 2 files changed, 68 insertions(+), 14 deletions(-)

-- 
2.50.1 (Apple Git-155)

