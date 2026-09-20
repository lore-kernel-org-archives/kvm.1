Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E191436BC8;
	Sun, 20 Sep 2026 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789909824; cv=none; b=qYr7pST4Bv00K8aytdj5SOKKUEhxUzsY9AzZ/YTritgidqteuTDg8z0dThXgvM5PBixqd7pE4guotTU0KHwJF/9qH3ZAMBsQ4lfASVW/zvAQ878r1UPPidVvdEq5hMTYAToplQGkPjiV4nOAsIZS/zYyNIkwzbNJRAUssi5xNFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789909824; c=relaxed/simple;
	bh=AqnRodBIwABofBtRlUF4paLYDS04JTFYgO4ptt3bU14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uthX1kyZxrWr0mkwK4XbatfSDzzzXSEzJ4+JUC4NXKVEqNDHeB76sUKMxVK0rfK6/OU0gjZBoOxkkwDD/2DWxaZLhsaQ7CbtREm6VCMiRsclCglW2+nHnZ6TdosVvxpyePumBQ3/Nush4WHVzBxOQQuZEu3vVh8UQ4gtO+X4glU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Hyq93UyW; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Hyq93UyW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=xT
	nC9jWGLW12aTgRRmdOguEbZvWOQuln9KGAxNvNGak=; b=Hyq93UyWq9S3yt/FL9
	pTitFm1JdF05vAVEXeyyL88yDO6WYoQLAVSv1VhVuVMO9FJZiGbIyiIt14ocxkrC
	HViKNVw6UpOTR4371oIKww1SGAl8Y+tmgl8hIfCMX5EpnnZHS10uTVzb8/fkjE2L
	478dEpIEnyRShcezOmrfyUuY8=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnr9_C2q9qDpfBAQ--.40005S2;
	Sun, 20 Sep 2026 21:08:19 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: anup@brainfault.org
Cc: Pengpeng Hou <hppiscas@163.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Atish Patra <atish.patra@linux.dev>,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>,
	Guo Ren <guoren@kernel.org>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Nutty Liu <nutty.liu@hotmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>
Subject: [PATCH v2 0/2] RISC-V: KVM: Validate AIA MMIO ranges against GPA width
Date: Sun, 20 Sep 2026 21:08:16 +0800
Message-ID: <cover.1789872556.git.hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnr9_C2q9qDpfBAQ--.40005S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr13ZrW3Ar4rGFy8XFy7ZFb_yoWkurg_ua
	18Kryaqw48Wa1UCa4qyr4rXr95C3yrGFW5AFyYyr1fJr9xXFnxWF4kGr1rXF1UG3yYyF1D
	Zr9a9w4fGryIyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRNMan7UUUUU==
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbCxgRuN2qv2sQC6QAA3r

This revision keeps the existing mandatory-address checks and narrows
the initialization revalidation to APLIC. An IMSIC address is only set
after a vCPU exists, which already freezes the selected GPA width.
APLIC can be configured earlier, so its range is rechecked at init.

Patch 2 keeps the previously reviewed GPA-width freeze unchanged.

Changes since v1:
https://lore.kernel.org/r/cover.1786512671.git.pengpeng@iscas.ac.cn/
- Preserve the required-address checks and existing cleanup path.
- Remove the all-vCPU range-validation pass.
- Explain why only APLIC needs a range recheck before initialization.
- Retain Anup's Reviewed-by for unchanged patch 2.

The issues were found by our static-analysis tool. AI assistance was
used to revise the patches and descriptions following the review.


Pengpeng Hou (2):
  RISC-V: KVM: Validate AIA MMIO address ranges
  RISC-V: KVM: Disallow GPA-width changes after AIA init

 arch/riscv/kvm/aia_device.c | 42 +++++++++++++++++++++++++++++++++----
 arch/riscv/kvm/vm.c         |  3 ++-
 2 files changed, 40 insertions(+), 5 deletions(-)


base-commit: 518e5b794c06c0f0eb40df3e202274a66202c137

