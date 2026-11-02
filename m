Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659958;
	b=DMSpQ4dBlbvZX3tszcYcRsuKlTFg7T+OqY8lxi4N97iOqveNvkTuo1jWSYYIA+8h5b1p
	 lTUKHPG4nuyGMGv2iS8WTE2O9et5SA6yqSGMlU5HYYZb5JVYi/0MDJQy5U1DQ67j6BUWo
	 g2ISSdGAjspiRLyyQ2m+M44Ux85Tj6jQqFQucJh8Uvig7qPnPFsQsqwdTG6uLBdd05OQu
	 3dzuNHUT/PK8ZlYSIspXyJIz5n2GUnxYy+xgBwJM+w9AWmi9q7c0xhHUCq6D+igotGuGm
	 2Y5ps5YPP1x9VpXY5D33fS/eB8Ul7+OYXkjfjAi9FcCTzk59CXHTDS5Htuf65qs5BkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659958;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=jGfVNVMEbI4knnr0HYK3aNhbSGglWPrTVSKSO44YhOE=;
	b=b1RjshGfMN80hYtDVhFBKdVBTBtBXSliQIWc7lgFVrnDBsxeOl8J+IBayN+4JbkQxVBA
	 ugGdTf0C7EM87cfgrA7hmJRH0QgYuUEeUCHL3ZR8XbYdgf5eizWfnOx2XVwnekhzbu4b1
	 +8pFujLQesAXSRSqBhdkXysaqyn4q9TiT4IF4Jb+ITHjZHLRgk8arnlTxbC9Hzyf970Sn
	 EVovBFLz3uVYlvkTqw+K+5vqN5f3OehlofUnJenXX+xKHZvzNC05qNF2UN6qNsZ8F7km9
	 IoN1D81tgrHUnKFvyuWUiEGpIRoXFqcJUC9e+Rcjd13QjulujPtaEAEZPq1S8tqytuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aMUPK0PK;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCF3606A324;
	Mon,  2 Nov 2026 22:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DCF3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aMUPK0PK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793659958; x=1825195958;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=MA3ldHTa9klyYEdiCEzwDK8GfST9flXGwd0snH5szYc=;
  b=aMUPK0PKHCUtjToFG0vX5n3W9wd7jF0CAUmvgpajYMpEWPoEvd/As4/3
   QtRJZ+L66Z4uw0tXJ+UE8eUKH8XtMO9oBn0ias2fWUY/fhwYqlvBEDulT
   m4uS2M83TyDIoXoWMPL4DCtjAEf6XU6leUwdlFdP1UzOzF+IRZ95NpcTl
   wgg8yg0Wd35DJ2LbV+dM7BL/PYN8MYUOm+s6rvsY/2SKW4CYdHnHNWMA2
   tq5bMcYmmogTEIYPeaR+D1B8ZkMfyJjUmVvhgT7O+XJ7TRTARcQmw3kta
   +cmK01/oP7dF2yCvWWQFRYl0I5dSUlkhnwmIIXAlkRoNXunec6EPsAMxq
   Q==;
X-CSE-ConnectionGUID: mtXKPp+5TAOa0PzmT/0Q5A==
X-CSE-MsgGUID: DOR0EvFaSM+35ySlKusw3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2258115"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2258115"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 14:52:37 -0800
X-CSE-ConnectionGUID: w9C0ZrkwRmaks44ZdBvL9w==
X-CSE-MsgGUID: TDXrEbIuS6WVdA5WzCCBeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6360423"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.125.109.177])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 14:52:37 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v5 0/2] x86/tdx: Use TDVMCALLs directly for earlyprintk
Date: Mon, 02 Nov 2026 15:51:57 -0700
Message-Id: <20261102-b4-tdx_earlyprintk_tdcalls-v5-0-b01bc95d44ff@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQU7DMBCF4atUXmM0M7ZDw4p7IFTZ8ZgaQlLZJ
 mpV5e44BaGoiyyfZvT9V5E5Rc7ieXcViaeY4zjUYR52ojva4Z1l9HULAmqgBSWdlsWfD2xTfzm
 lOJTPQ/Gd7fssNXh0hHbvLIkKnBKHeL7hr2+/O3+7D+7KIi4fx5jLmC63+oTL318IYSs0oQSpH
 Tl0oQVA91LP3D9245dYQhOtKMJNiiplPQbPKpAJ/p5Sa4o2KVWphp21pm19QLin9D+FAGaT0pV
 S4akzjfem2ds1Nc/zD6j3BE+3AQAA
X-Change-ID: 20260903-b4-tdx_earlyprintk_tdcalls-40d1b21a8ba2
To: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
 Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 Nikolay Borisov <nik.borisov@suse.com>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=3402;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=MA3ldHTa9klyYEdiCEzwDK8GfST9flXGwd0snH5szYc=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDFkvRXQZPzupzqteoLTF4mTnocxkv1SL7EsxfDVuKetKE
 uY5Rgd1lLIwiHExyIopsvzd85HxmNz2fJ7ABEeYOaxMIEMYuDgFYCLLtjMyvLo0x3j96tD7wWWO
 HAypXhu1j5rs/eRwxytvf8amIxLxoQz/C0N9gkSumAfL7ja/umH1vfWsXYtZ9a10xc/PPb3s3BI
 7XgA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

Background
==========

TDX guests have early_printk support, but it is through a roundabout way
using a #VE exception as a functional mechanism. The exception handler
has to use TDG.VP.VEINFO.GET to find out what faulted, and then issue
the TDVMCALL. Simplify this by using a TDVMCALL from the guest which can
directly perform the port I/O.

Patch details
=============

Patch 1 is a cleanup that moves the port I/O direction constants to
arch/x86/include/asm/shared/tdx.h.

Patch 2: Add a new earlyprintk=tdx option, which calls the new
tdx_serial_in() / tdx_serial_out() helpers to perform the port I/O
directly using TDVMCALLs.

The serial earlyprintk path is left as is - TD guests using this will
still take a #VE exception, and the exception handler will perform the
I/O.

Testing
=======

Added a counter for the number of COM1 port I/O #VEs handled:

  no earlyprintk     -  ~63000
  earlyprintk=ttyS0  -  ~61000
  earlyprintk=tdx    -  ~35000

The new tdx option nearly halves the number of #VEs handled.

Additionally, ran the usual suite of CI testing, which covers KVM self
tests, KVM unit tests, and Avocado KVM tests without any regressions.

LLM Use
=======

LLMs were used under supervision to generate some of the changes, to
help understand the scope and mechanisms, create testing instrumentation
(throwaway) to count #VEs in the serial vs tdx earlyprintk setups, and
to drive lab machines to do this testing.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
Changes in v5:
- Collect review tags (Rick, Kiryl, Nikolay)
- Move LLM attestation notes from the commit message to cover letter
- Rebase to v7.4-rc1
- Link to v4: https://patch.msgid.link/20261005-b4-tdx_earlyprintk_tdcalls-v4-0-3f7c56dd568a@intel.com

Changes in v4:
- Rename the tdx_inb()/tdx_outb() helpers directly to the serial
  accessors with __noendbr annotations, and remove the config ifdefs
  from early_printk.c. (Kiryl)
- Rebase to v7.3-rc6
- Link to v3: https://patch.msgid.link/20260922-b4-tdx_earlyprintk_tdcalls-v3-0-6ebaa599df10@intel.com

Changes in v3:
- Drop the ttySN and baudrate option parsing for earlyprintk=tdx (Dave Hansen)
- Link to v2: https://patch.msgid.link/20260921-b4-tdx_earlyprintk_tdcalls-v2-0-ad1fde3f25fd@intel.com

Changes in v2:
- Rebase to v7.3-rc4
- Move the TDX hypercall helpers into coco/tdx/tdx.c (Kiryl)
- Add a new earlyprintk=tdx option that implements the direct TDVMCALL
  path (Dave Hansen)
- Link to v1: https://patch.msgid.link/20260910-b4-tdx_earlyprintk_tdcalls-v1-0-4b2b1bf9001b@intel.com

---
Vishal Verma (2):
      x86/tdx: Move port I/O definitions to a shared header
      x86/early_printk: Add earlyprintk=tdx to drive the UART with TDVMCALLs

 Documentation/admin-guide/kernel-parameters.txt |  8 ++++++
 arch/x86/include/asm/shared/tdx.h               |  6 ++++
 arch/x86/include/asm/tdx.h                      |  4 +++
 arch/x86/boot/compressed/tdx.c                  |  4 +--
 arch/x86/coco/tdx/tdx.c                         | 37 +++++++++++++++++++++----
 arch/x86/kernel/early_printk.c                  | 20 +++++++++++++
 6 files changed, 71 insertions(+), 8 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260903-b4-tdx_earlyprintk_tdcalls-40d1b21a8ba2

Best regards,
--  
Vishal Verma <vishal.l.verma@intel.com>

