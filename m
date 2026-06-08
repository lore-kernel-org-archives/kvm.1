Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4218B3ECBD5
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931606; cv=none; b=s+qvD9ZjstdSa5BnrMID7NNaS42gUzJrmRKIj9vKJwIeWjC5+pMb0QZnGq133/qcp0LU1g8q0T2Sl0ioDv6iYbZzCeMZDXeWDIoB8S1J7Vhn9/NGZq7iqeItus/FYacJN3e7sZvKkdLHv6B69pGciQVuaBvsSYY9mo7gsK842Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931606; c=relaxed/simple;
	bh=Q/v7olDWMtsFQIKkgWRXwqFOm5ijx/Hn2bRWiEWzZzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bA2ebDCT9lcPGK5QCoOPTFJrVs7rTUUD6CaIMamgqe25GpptfKPCS8MHd0hVKeE6LhSsHYwf6rcLjeFezGeujZ5me5m3xFYsiVscvvDr6M8I4MiXFYWxg3Tvd4qX2jBbq7+tKYLxiN6rxFaAJgw468IRR0rCiAIN+cd40O4lN3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ncClj36U; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ncClj36U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780931605; x=1812467605;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q/v7olDWMtsFQIKkgWRXwqFOm5ijx/Hn2bRWiEWzZzU=;
  b=ncClj36UdQrDowsKD0fS4VGbivWmIQ8H0IEtqDj5qYj57KO3UA86CLf9
   zUEWAEHNIDt9UjRyyKpkSNMum6+c09G5KQmsQyblVzSXqWEpC73zPp8My
   mhWxyZiP0dG4BBeP9zwebf5qjZ1UXoNNN56chgFIhReDVBYkKbfvcpmS6
   2nInAJuRNlxlvJVDL8QwGVikQT3S5n5JvwcLhNQGwj2rEONXlTVFLOnY8
   UTVz22ysX/t7vCIGSjxXbhZGf+ZVbgln8CGsv6Vp4Evf53Fd5PTUD817Q
   7syUQRmYcaNPuwQ0rAhUabUEjbUoDNKPYfrg5pFW9V+gNqcIHGu10Xp1B
   w==;
X-CSE-ConnectionGUID: qpvR819qQke89/Jl03McRw==
X-CSE-MsgGUID: uOo+95pTQs+qTXuE8co2bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="91994663"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="91994663"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 08:13:24 -0700
X-CSE-ConnectionGUID: aewhEanfTIKGlNYp/r+T5w==
X-CSE-MsgGUID: kmKqUlSxQBCWtTMM3fVxjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="283660558"
Received: from silpixa00401971.ir.intel.com ([10.20.226.106])
  by orviesa001.jf.intel.com with ESMTP; 08 Jun 2026 08:13:23 -0700
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: alex@shazbot.org,
	jgg@ziepe.ca,
	yishaih@nvidia.com,
	skolothumtho@nvidia.com,
	kevin.tian@intel.com
Cc: kvm@vger.kernel.org,
	qat-linux@intel.com,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Ahsan Atta <ahsan.atta@intel.com>
Subject: [PATCH] vfio/qat: fix f_pos race in qat_vf_resume_write()
Date: Mon,  8 Jun 2026 16:12:57 +0100
Message-ID: <20260608151317.136613-1-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit

qat_vf_resume_write() checks filp->f_pos before taking migf->lock, but
copies into the migration-state buffer after taking the lock and
re-reading the shared file position.

Two concurrent writers could therefore pass the bounds check with the
old offset, then have the second writer copy after the first advanced
f_pos, writing past the end of the migration-state buffer.

Take migf->lock before doing the boundary checks.

Fixes: bb208810b1ab ("vfio/qat: Add vfio_pci driver for Intel QAT SR-IOV VF devices")
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
---
 drivers/vfio/pci/qat/main.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/pci/qat/main.c b/drivers/vfio/pci/qat/main.c
index ac9652539d66..60ff907b6a67 100644
--- a/drivers/vfio/pci/qat/main.c
+++ b/drivers/vfio/pci/qat/main.c
@@ -298,14 +298,18 @@ static ssize_t qat_vf_resume_write(struct file *filp, const char __user *buf,
 		return -ESPIPE;
 	offs = &filp->f_pos;
 
-	if (*offs < 0 ||
-	    check_add_overflow(len, *offs, &end))
-		return -EOVERFLOW;
-
-	if (end > mig_dev->state_size)
-		return -ENOMEM;
-
 	mutex_lock(&migf->lock);
+
+	if (*offs < 0 || check_add_overflow(len, *offs, &end)) {
+		done = -EOVERFLOW;
+		goto out_unlock;
+	}
+
+	if (end > mig_dev->state_size) {
+		done = -ENOMEM;
+		goto out_unlock;
+	}
+
 	if (migf->disabled) {
 		done = -ENODEV;
 		goto out_unlock;
-- 
2.54.0

