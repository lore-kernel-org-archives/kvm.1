Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF42545D5DE;
	Thu, 23 Jul 2026 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804654; cv=none; b=cpnA+UfK8y3rH9kasLDL03GuFWtUlFohs/9mPtUyt8Vf1sK29xG480nwNlPtOQpVgqVuDtB2k2gQghWe5MEDOR6iTiXmvBImZY7c1x6nbVaiRIPHAxvxfXB6lLj7A7MsacAiGFExOucRdXRg1IxVU7Q1vvAQkSWqsNQEfSQaHvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804654; c=relaxed/simple;
	bh=+vpxsYVLYdFObePE4vfMlEfo589tTcvb0YZ5yJkWL8U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gd79u8Zg1dPfF6mUHIgJeYAcektZszoUVdFnLA/PYQSrIQXk5Ou65PuPJRqZSaX3Rj9z+SrcIK0YNvd/GLIW8E7fmfQg0Cgh+/OTw3SO1M4cPU8L310M2K2vG29kLZ5o3hFk4Alg1zBKhnz0AL9BIEaqTZ8tuXbXZS5RLUBIK5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OW0e5fJw; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OW0e5fJw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=sV
	4C4q5bM5X44A/3g20+8iQFUM3EV2YkFrasHp0Z/0A=; b=OW0e5fJwK0/74DktLS
	uAWC5XLwW5yK+JaVclfya8gg9vSrslyGjrSMeAqsoCs2jVRGRmpkW0We3UgWrORs
	al7sotbRYkg4WNw3OSba6j7OZ+oODuQsNcnJtdDmVP1CZZCkPdCUtdfVzeurihMD
	lsKJMVtA+0+fWsxZSSU2xSERE=
Received: from zengchi (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wC3GL0G9WFqTAoiLg--.17578S2;
	Thu, 23 Jul 2026 19:03:35 +0800 (CST)
From: Zeng Chi <zeng_chi911@163.com>
To: zhaotianrui@loongson.cn,
	maobibo@loongson.cn,
	chenhuacai@kernel.org,
	kernel@xen0n.name
Cc: kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zengchi@kylinos.cn
Subject: [PATCH 0/2] LoongArch: KVM: Fix PC double advance in MMIO read fast path
Date: Thu, 23 Jul 2026 19:03:29 +0800
Message-Id: <20260723110331.1326097-1-zeng_chi911@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3GL0G9WFqTAoiLg--.17578S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtryxZw17Wr45tF1ftw15XFb_yoWfCwcEyr
	ZayrZ7Cr4UGF47AFW29w13tFWjkFW7CFWrJF90qwnrWr97W3y5XF4kuF15tFyv9398JFZI
	yr4qvr9Yyr129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbQJ57UUUUU==
X-CM-SenderInfo: 52hqws5fklmiqr6rljoofrz/xtbC5wdxLWph9QdyZQAA3S

From: Zeng Chi <zengchi@kylinos.cn>

This series fixes a bug where the guest PC is advanced twice in the
in-kernel MMIO read fast path, causing the instruction immediately
following the MMIO read to be silently skipped.

Patch 1 removes the redundant update_pc() call in kvm_emu_mmio_read().
Patch 2 adds a KVM selftest that exercises this fast path and verifies
that the PC advances correctly.

Zeng Chi (2):
  LoongArch: KVM: Fix PC double advance in kernel MMIO read fast path
  KVM: LoongArch: selftests: Add in-kernel MMIO read fast path test

 arch/loongarch/kvm/exit.c                     |  1 -
 tools/testing/selftests/kvm/Makefile.kvm      |  3 +-
 .../selftests/kvm/loongarch/mmio_read_test.c  | 89 +++++++++++++++++++
 3 files changed, 91 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/loongarch/mmio_read_test.c

-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

