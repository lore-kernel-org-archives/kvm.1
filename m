Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0651242D97;
	Thu, 10 Sep 2026 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789079666; cv=none; b=Ikik4xMNPTRPauaS/eZaE+Tet3+PGSQ7Z2hkKTZWvNNH+BiU4ykKm2+iLAYKDmLACswQa5lKyYBq6h0qn03pQ2B2kNQoan8EijKoOaqZr2Bybhq0hQyczwdLKGKd4eupZzeQNrmDktjvGul3Phf3bBMdfXJFxEi2MRmXDwW67Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789079666; c=relaxed/simple;
	bh=dmz7LLUsSJlaqKdSz8Pld+MgYerELlf+7jDfNV9UMEs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Yys2qHPD2V7mITmI8FeZb3T3ohHVQxCsfHhf/oGHxK5/IqAHWobytxppsiqxG+jdh6dQiy3ypwuLnWL66Khx3/or9MsL5sUSzsuSyWZDbNt9m7yc7FtOeIaDK3GkLdZarYcNEaD51VoVwf3loxSw8A/fSVqsUS3ahFsi8MKFtDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K6Sy7WWa; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6Sy7WWa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789079665; x=1820615665;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=dmz7LLUsSJlaqKdSz8Pld+MgYerELlf+7jDfNV9UMEs=;
  b=K6Sy7WWaMacoG2qmnljUbQVHAJ/T4lQyltJ4j4C7Zd70Gf+7crYOKlQ7
   Hnqn1RDaGNbXMXJBQckvX0KlCv5c7/iHyTxRKajmHGxYMHynyYv9OmhU+
   1ZaYCxzB4UeuY+nXDoC2nSOK4tq+MnNg7HTDPuwxg6A/ama8/FGwWBKwZ
   Jg67fQBrCNYIbtsh9rULXv79SQrGbTCz3r1Sfm3pZwDRcf0bDQyHsUSk5
   lbOfwQL6+Wm0xPprnh9vCtfy4PT+hlNePCwcOzn31oXTeZ5ciT5ZRoPkA
   xdbIXcDlxH8W34I2/e9KcSvipmbK5vGCCjOZe2AffppwRYt8ILFqPVILi
   Q==;
X-CSE-ConnectionGUID: jZ/5KGpKSyOjYpKcqaDCig==
X-CSE-MsgGUID: wD0h+j1xTTmIh8fWn2m73Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="93407821"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="93407821"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 15:34:24 -0700
X-CSE-ConnectionGUID: 2y5TS/eATQSu1QmMPOgOpA==
X-CSE-MsgGUID: vjey+sH0Q1e5RtIzAcgwcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="301647425"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.125.111.227])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 15:34:25 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 0/2] x86/tdx: Use TDVMCALLs directly for earlyprintk
Date: Thu, 10 Sep 2026 16:34:07 -0600
Message-Id: <20260910-b4-tdx_earlyprintk_tdcalls-v1-0-4b2b1bf9001b@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMUQrCMAwA0KuMfFto6xD1KiIjbaNGSx1JJ5Oxu
 1v18/28BZSESeHYLSD0YuVnaXCbDuINy5UMp2bw1u/swW5N6E1N80Ao+T0Kl/oYaoqYs5reJhe
 8w31ADy0YhS48//LT+W+dwp1i/Y6wrh/FhTPxfgAAAA==
X-Change-ID: 20260903-b4-tdx_earlyprintk_tdcalls-40d1b21a8ba2
To: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
 Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 kvm@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.16-dev-62088
X-Developer-Signature: v=1; a=openpgp-sha256; l=1728;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=dmz7LLUsSJlaqKdSz8Pld+MgYerELlf+7jDfNV9UMEs=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDFmLDfKtVQREZ08oL926glNZdcPqVb4lGrYF9WH9Ukec2
 rO5w/Z0lLIwiHExyIopsvzd85HxmNz2fJ7ABEeYOaxMIEMYuDgFYCJ+jgz/3W+y/b/5L6Xs7mWu
 wyqLFZY9EHob9ibq3febnD4N5xb/smFkWCnSPClF6zLXXXfheeVH1162fH/rU8OFC5OLPFeIeZ+
 8xwQA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

Background
==========

TDX guests have early_printk support, but it is through a roundabout way
using a #VE exception as a functional mechanism, which is fragile. The
exception handler has to use TDG.VP.VEINFO.GET to find out what faulted,
and then issue the TDVMCALL. This can be simplified into a TDVMCALL from
the guest that does the I/O directly.

Patch details
=============

Patch 1 is a prep patch that moves the port I/O direction constants to
arch/x86/include/asm/shared/tdx.h.

Patch 2: early_printk.c already reaches the UART through static calls,
so a TDX guest can simply substitute accessors that issue
TDG.VP.VMCALL<Instruction.IO> directly.

Testing
=======

Measured using a TD guest by counting handle_io() calls and snapshotting
the counter at the last earlyprintk write.

  COM1 #VE count: 63160 (before patch) -> 21 (with patch)

Additionally, ran the usual suite of CI testing, which covers KVM self
tests, KVM unit tests, and Avocado KVM tests without any regressions.

This is based on v7.3-rc2.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
Vishal Verma (2):
      x86/tdx: Move port I/O definitions to a shared header
      x86/early_printk: Avoid #VE emulation for TDX guest serial output

 arch/x86/include/asm/shared/tdx.h |  4 ++++
 arch/x86/boot/compressed/tdx.c    |  4 ++--
 arch/x86/coco/tdx/tdx.c           |  8 ++-----
 arch/x86/kernel/early_printk.c    | 48 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 8 deletions(-)
---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260903-b4-tdx_earlyprintk_tdcalls-40d1b21a8ba2

Best regards,
--  
Vishal Verma <vishal.l.verma@intel.com>

