Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0198D30E0EC;
	Thu,  4 Jun 2026 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780614309; cv=none; b=k8VpOoqTJTJ7mpEO0EiZ6o+RPXrj2RfdM7z2sQnhxrjZ40zbhmDgNLhvSy94ibikappfw+4zm2YeHMFu0Q8guHi9514xB2IdYscKeGnSz1yHITbojbhtmtDUQ4sYUrG0eyNbbm87sz/XiyX8G41B4TfQy77cKEgq55DmUHM/oKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780614309; c=relaxed/simple;
	bh=Arv+H/n5R1ohnW7OLIdudoSlPQzy24UdDRbJhW8R8ew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RHFn/SXm9f2lKJFZTJrGzrwgQrLsvlmQPqFIXtRvgo9oy3PhkgaG/3dqlj0Vtk0uZQoporUB7G+hKSYcm5cDNy/hMYVoGrGBTtb20uJaqNEZG/sPsr8x6n7wL0FcmSdwWarFsDWUEIQJlZArWuOQfsJpNEo0ZaueoDOtYwzcKwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PHwg3m0f; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PHwg3m0f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=31
	aVyHUumnhXwzCExpLEJUIkTMuPZna46h2rihqSFBc=; b=PHwg3m0fzy5cEX1++E
	LczfKuSQNhaelLXuY8+tJtZY4N16853GJZAhl4Yxs/x1BrOaFN1ByNUIJeToOosh
	yhSpxfCXVa7zvPGSQDungnI3sIj79g5Psh21b83a0ad0uGiQu7hAbVF4xXD5z2hj
	rbQrqiuvlgPnWcp05dfYR1Ow4=
Received: from wufei (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wA3H9tJBCJqsfP6BQ--.26783S2;
	Fri, 05 Jun 2026 07:03:44 +0800 (CST)
From: atwufei@163.com
To: seanjc@google.com,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Wu Fei <wu.fei9@sanechips.com.cn>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] RISC-V: KVM: Fix skip of valid pages in gstage ops
Date: Fri,  5 Jun 2026 07:03:13 +0800
Message-ID: <20260604230317.30501-1-atwufei@163.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3H9tJBCJqsfP6BQ--.26783S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFyUtrW8Cw4fKFWUKF47XFb_yoWkKrg_uF
	WrJFykCwsrXa4xJF90k3s8A3s7WrWj9r4jvFnFvan3t34ftF1UJa18uFZ7XrWxX3yUC3W7
	u34Y9r18Ar1SkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU86wZ7UUUUU==
X-CM-SenderInfo: pdwz3wlhl6il2tof0z/xtbCzhA42WoiBFDygwAA3S

From: Wu Fei <wu.fei9@sanechips.com.cn>

The current gstage range walker unconditionally advances by 'page_size'
when a leaf PTE is not found, e.g. when the range to wp is
[0xfffff01fc000, 0xfffff023c000) , if found_leaf of 0xfffff01fc000
returns false and page_size is 2MB, it skips the whole range, but it's
possible to have valid entries in [0xfffff0200000, 0xfffff023c000), so
only [0xfffff01fc000, 0xfffff0200000) can be skipped safely. Both
wp/unamp have the same pattern.

dirty_log_test intentionally sets up the unaligned guest physical
address, after riscv kvm enabling KVM_DIRTY_LOG_INITIALLY_SET, it's easy
to trigger this bug if there is a larger window for guest to write more
pages before first collect_dirty_pages.

v2:
* reformat
* drop the patch to dirty_log_test, which is replaced by the one from
  Sean: https://github.com/kvm-x86/linux/commit/4e0fdd9b0d7d

Wu Fei (2):
  RISC-V: KVM: Fix skip of valid pages in kvm_riscv_gstage_wp_range
  RISC-V: KVM: Fix skip of valid pages in kvm_riscv_gstage_unmap_range

 arch/riscv/kvm/gstage.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

-- 
2.51.0

