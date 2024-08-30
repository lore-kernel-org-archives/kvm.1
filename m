Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3413D1AF4D0
	for <kvm@vger.kernel.org>; Fri, 30 Aug 2024 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012750; cv=none; b=ubpUQXyMLpO14feezU4WXr8HrbEJaEIQ+BTX5ac85VPjhhyVUYrMMNqB8gkxWBsbWu85mmmf67m0LqLVGpkRBkK9StMcw/yHfGJcGdG+yD+eufs189Kq99qM+ynMqpV2YEbS+UCmSiapdHI8yaoZtQkBAIs+K9USSLJ9rtI/ONw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012750; c=relaxed/simple;
	bh=T4+L0Vc/OlsMJ9NNSey9Bte3k4b9pfybm06hoTCC910=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FEDiPhsuNDaKrc7/A1LIzkOqL9GThdr6ZHnOTF6PnfScuVuV9U0wokmHjXOxhEVKZA+ao8CiwvlgavzaDU/IVywxvzxb+dsW7DmGFKGOtxF6pQo7tcsI/AIshn8g+gAEoDwUDFgZA7g7K5iLigioSZmyKzaubGFl2gGG47EeLhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bHlKt4R7; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bHlKt4R7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725012745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5p9qqDdIg7zE75jwwQgUR7uF93QuHuI5mYPsWVBSWBM=;
	b=bHlKt4R7DxyqyLi5eSw4ZKWRY5Md5b3qT/VPhyMT69FTShFxwxM3WaURtkt8Rh72X6NQlF
	DPLAQAhDQz2L0qxwrIJ8Qj5X1kE5xagGiVTgTSFQdoEy1ktxbB9RhtC3FmW//G7OeA9iiy
	fIkC+AcMZaFlgA7/9D78yKW0GUyzyOo=
From: Andrew Jones <andrew.jones@linux.dev>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Cc: atishp@rivosinc.com,
	cade.richard@berkeley.edu,
	jamestiotio@gmail.com
Subject: [kvm-unit-tests PATCH 0/3] riscv: Improve on-cpu and IPI support
Date: Fri, 30 Aug 2024 12:12:22 +0200
Message-ID: <20240830101221.2202707-5-andrew.jones@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The first two patches improve general library support for cpumasks and
the on-cpus API. on-cpus can now take cpumasks for input. The last patch
improves support for sending IPIs on riscv using the SBI IPI extension
by supporting a nicer interface of cpuids and cpumasks.

Andrew Jones (3):
  lib/cpumask: Fix and simplify a few functions
  lib/on-cpus: Introduce on_cpumask and on_cpumask_async
  riscv: Introduce SBI IPI convenience functions

 lib/cpumask.h       | 47 +++++++++++++++++----------------------------
 lib/on-cpus.c       | 35 +++++++++++++++++++++++++--------
 lib/on-cpus.h       |  3 +++
 lib/riscv/asm/sbi.h |  3 +++
 lib/riscv/sbi.c     | 43 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 94 insertions(+), 37 deletions(-)

-- 
2.45.2

