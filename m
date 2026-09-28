Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41052472071;
	Mon, 28 Sep 2026 09:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586745; cv=none; b=JELJLiVSTGcBEWOIM/Cckpd59k7LUnb7DEVzxXCSmEyQmDWKvgdLe08ZNQClMQ5Fy7Ki+DFq/KhCkyTbkvTzVhIck/aR9rm3a49hLssdANwOpr7Vme1xr7LhVEDDuUp2ADVKhEAWPiF59sFBh7dKfajv+HKlfK18odRRQrMAalI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586745; c=relaxed/simple;
	bh=sv/2qHth2EJgMN53Gl1oqzs6AWOR+CFmKepRiwZjMsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDB7fTJMQHFzMLO8BD7EiKuNY2gmxUIdNhwGYpHs4iECVxtnSZdnW0A6cMEAdBnL2rtPgvLMLSBVAjkpQb6SPFYtKFDASjECc2n9BazxOYTos3EcnTp0cu1V+VEoH90LSg48WNWJWSE7UOsJxxA5aCzC/TbBGBUMnouGExG4ots=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q6p2V/SP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6p2V/SP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790586745; x=1822122745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sv/2qHth2EJgMN53Gl1oqzs6AWOR+CFmKepRiwZjMsw=;
  b=Q6p2V/SPK8wUy8J98WX/hzpwcF5NQ8vFB84TQjBEGeylJWBdFfAEfqvl
   NgyvIbPWJQK4hy+PBLQARVYgL3bB2natYAfJKsbGDCP3O7N4l1M+Pb2sH
   ecCyFrXt6dE3+pvr477Zfu226FDtkFK8xHyCDAphwnGbyeMPvDyJ1KZEl
   LBj1n/kS3P7Gjt+v3FJtQOdTDJ0vGwLm19g15bAU0E30O5Pb5qViy+DMD
   QfHSyM9ITOAKv9tWfNfDY4k/dDw9XAZC0PxEDrghWT3uJyZ6SozxTr5gr
   VOhN7B/YXTcKL1Gm/Mx4zVE2q+KYPM6Pe3j/btQr9oyHp4oNfD7jzoWBd
   Q==;
X-CSE-ConnectionGUID: Yx8b5djMRDqh2054hayE+Q==
X-CSE-MsgGUID: yz+VHzTpT0S6P6WYhCjq3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90148310"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90148310"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:12:24 -0700
X-CSE-ConnectionGUID: Kg7NrNSUQJCU+j7X3VZSEQ==
X-CSE-MsgGUID: YT/zgsvgR6aQMYQ8xztiJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275120944"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.61])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:12:17 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	dave.hansen@intel.com
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	x86@kernel.org,
	rick.p.edgecombe@intel.com,
	kas@kernel.org,
	tabba@google.com,
	ackerleytng@google.com,
	michael.roth@amd.com,
	david@kernel.org,
	vannapurve@google.com,
	sagis@google.com,
	vbabka@suse.cz,
	thomas.lendacky@amd.com,
	nik.borisov@suse.com,
	pgonda@google.com,
	fan.du@intel.com,
	jun.miao@intel.com,
	francescolavra.fl@gmail.com,
	jgross@suse.com,
	xiaoyao.li@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com,
	chao.p.peng@intel.com,
	chao.gao@intel.com,
	farrah.chen@intel.com,
	yan.y.zhao@intel.com
Subject: [PATCH v4 13/17] [GMEM-DEPENDENT] KVM: guest_memfd: Add helpers to get start/end gfns give gmem+slot+pgoff
Date: Mon, 28 Sep 2026 17:11:44 +0800
Message-ID: <20260928091144.15679-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260928090729.15468-1-yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Add helpers for getting a gfn given a gmem slot+pgoff, and for getting a
gfn given a starting or ending pgoff, i.e. an offset that may be beyond
the range of the memslot binding.  Providing helpers will avoid duplicate
boilerplate code "if" future code also needs to iterate over gfn ranges.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 virt/kvm/guest_memfd.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 5bf7c8b4509f..fea460e5e503 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -80,6 +80,21 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
 	return gfn - slot->base_gfn + slot->gmem.pgoff;
 }
 
+static gfn_t kvm_gmem_get_gfn(struct kvm_memory_slot *slot, pgoff_t pgoff)
+{
+	return slot->base_gfn + pgoff - slot->gmem.pgoff;
+}
+
+static gfn_t kvm_gmem_get_start_gfn(struct kvm_memory_slot *slot, pgoff_t start)
+{
+	return kvm_gmem_get_gfn(slot, max(slot->gmem.pgoff, start));
+}
+
+static gfn_t kvm_gmem_get_end_gfn(struct kvm_memory_slot *slot, pgoff_t end)
+{
+	return kvm_gmem_get_gfn(slot, min(slot->gmem.pgoff + slot->npages, end));
+}
+
 static u64 kvm_gmem_get_default_attributes(struct inode *inode)
 {
 	bool init_shared = GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED;
@@ -212,11 +227,9 @@ static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
 	unsigned long index;
 
 	xa_for_each_range(&f->bindings, index, slot, start, end - 1) {
-		pgoff_t pgoff = slot->gmem.pgoff;
-
 		struct kvm_gfn_range gfn_range = {
-			.start = slot->base_gfn + max(pgoff, start) - pgoff,
-			.end = slot->base_gfn + min(pgoff + slot->npages, end) - pgoff,
+			.start = kvm_gmem_get_start_gfn(slot, start),
+			.end = kvm_gmem_get_end_gfn(slot, end),
 			.slot = slot,
 			.may_block = true,
 			.attr_filter = attr_filter,
-- 
2.43.2

