Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDE93FA5D5
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 08:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783326996; cv=none; b=H2KmiQMbAF+PBe+wd1YhrIbaTg1C3y1nIe9sh2k6G2dNqkomKDVEbVrFuc/vp+mxxRoOq7s+y73agVO0VEcodTc+RyFgeb3e6VoS/Y8Egyaa6j0LVXXxmr5mZmgYdwAB31osM1a+lxVOIHuld0aGn4updH6X4xPVWsgAATvL35w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783326996; c=relaxed/simple;
	bh=OtxwYDiXIs45/R5qOgWfhIJ1pNdeZ/iTCiGIauTmmN0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ikRJxnNaRpR2RmPk5T1RT6ukjyU0QJrVo5oDLSJ4dyyygAeaef7dbbmmu5fnW5sFLnDt6Se6Ygzrkxxdqple1cS3SN3E+SinvxH0gmq1M7DBQTMu2SEPhAsR3LxxttZYkL80eyGgO2xbrj0qqZkmlq98Lx4survjhIi37pArABE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wMqcMQbf; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wMqcMQbf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783326966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jZXscVUG63ZFrhHpOJR3V/mNooz4GyCGGWNSo7+GJVc=;
	b=wMqcMQbfnogp23GG0ATQUVXIgs5wVw4+d91tG26/5vcv162UntnbsGt13VNtBk36k/hkee
	eGQkVB83uLCaDhKzK1PHCaziStN5B+xuIKPyeZflrTMV7C41czTrJJKOXdhRcUT9L03RYv
	ouIVxQ4TvO89+/pVJKBB1irJOGRwfO8=
From: Fuad Tabba <fuad.tabba@linux.dev>
To: kvm@vger.kernel.org
Cc: kvmarm@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	Fuad Tabba <tabba@google.com>
Subject: [PATCH kvmtool v1 0/5] Add guest_memfd support for arm64
Date: Mon,  6 Jul 2026 09:35:50 +0100
Message-Id: <20260706083555.302972-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi folks,

Due to popular demand, i.e., Alexandru asking me about it, I repolished my
guest_memfd support series. The one I sent years ago was stale and
over-engineered, so this is a fresh start instead.

This series adds support for backing guest RAM with guest_memfd on
arm64, for non-protected VMs under both regular KVM and pKVM.

The first two patches are standalone fixes in the code this series
builds on: an uninitialized return value in kvm__for_each_mem_bank(),
and doubled newlines in die() messages. The next two switch memory
registration to kvm_userspace_memory_region2 unconditionally and add
guest_memfd plumbing to kvm__register_mem().

A new --guest-memfd option creates guest RAM from a guest_memfd with
mmap support (GUEST_MEMFD_FLAG_MMAP and GUEST_MEMFD_FLAG_INIT_SHARED,
Linux 6.18+), maps it to provide the userspace mapping, and registers
it with KVM_SET_USER_MEMORY_REGION2.

Protected VMs need in-place shared/private conversion of guest_memfd,
which is still in progress in the kernel [1], so --protected rejects
the option.

Based on kvmtool master (ca0ddafa941d).

Cheers,
/fuad

[1] https://lore.kernel.org/all/20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com/

Fuad Tabba (5):
  Initialize the return value in kvm__for_each_mem_bank()
  Remove newline from end of die() aborts
  Use kvm_userspace_memory_region2 for all memory registration
  Add guest_memfd support to kvm__register_mem()
  arm64: Add --guest-memfd option to back guest RAM with guest_memfd

 arm64/include/kvm/kvm-config-arch.h |  5 +++-
 arm64/kvm.c                         | 38 +++++++++++++++++++------
 hw/cfi_flash.c                      |  2 +-
 include/kvm/kvm.h                   | 16 +++++++++--
 include/kvm/util.h                  |  1 +
 kvm.c                               | 26 +++++++++++------
 util/util.c                         | 44 +++++++++++++++++++++++++----
 7 files changed, 106 insertions(+), 26 deletions(-)

-- 
2.39.5

