Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364653B3884;
	Mon, 21 Sep 2026 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020383; cv=none; b=OvhiR1jKOVjZ+tUN4KBMHmtXWpPsU17XOFgrfImBOQPP4ViOfhEN7GlzLXy5Q3bKdH+5SDFGJvjBb1oxr72TMmfkiqnXkFgKGWRQ24ICDVt3ULr7J7qlmpJ05Ld7U6qKNqufQA1VFlaoNA/xr5OkYN+DH7Yn2zScH38hbEmiZKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020383; c=relaxed/simple;
	bh=bkhJSl1Cq62EQXSMdVznURMEBI25uS+zoGaB+7oBFpM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E1a4Vf8fLuAAwsoXFjlBHiKEs30uibTvBLFZXVpdc93Bj6JoPmdahGEVq7xC78gW/0AItlVrlE4Kxn8IKFgdHqQWiKNjD+j+JO350z++oz0lRx7jVyyiot5PuI8cd4nuxmbMHmDeqFoDr+vRQZG3N2QASEroOOyklyVKJoBAbvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VOThC040; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VOThC040"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790020381; x=1821556381;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=bkhJSl1Cq62EQXSMdVznURMEBI25uS+zoGaB+7oBFpM=;
  b=VOThC040Up1iY2rbHbJyph03PgW0KV/Yjmdli/hW9NycC3EvtqLa9OHw
   kJfdSjnHVRHO5rPlgvOJc1Cpn3dREWRxpNuXzXBLDWHSTpcO4fez4MW8U
   kAwVpzAsdJWsjRTIWnvd4c70nnrfpi2PEEJqUjfDugvhiZxg62eavhod/
   cYX7ra2APOFlF9EcRDK0H1fvNB5nN0f7L1jTVWIwPbBFKlJ+INQQp8ZKX
   JW4VWtUiVTxsdEcVGVMI5dULbrU3PU99rWAJR6472xH/Shc1bg/qNrP1Z
   g0eQRSLCl+UTdhtibFnXEv1ExoM4a8YeWy+RkDkU41F2VQB3R6or2hlrJ
   Q==;
X-CSE-ConnectionGUID: 98g0tni8S22UYnZ1W4fuuQ==
X-CSE-MsgGUID: TKFzQiGqS0G9zWkxMQgU6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90435100"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="90435100"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 12:53:00 -0700
X-CSE-ConnectionGUID: kVAB7FAIRx6Pa2Mi4sNwAw==
X-CSE-MsgGUID: wVj6mPwoR+CLcaeEZXTcMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="299041222"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.125.109.250])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 12:52:59 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 0/2] x86/tdx: Use TDVMCALLs directly for earlyprintk
Date: Mon, 21 Sep 2026 13:52:36 -0600
Message-Id: <20260921-b4-tdx_earlyprintk_tdcalls-v2-0-ad1fde3f25fd@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NwQ6CMBAFf4X0bM22EiOe/A9CSLddpFqBtJVAC
 P9uQc8eJ+9lZmGBvKXArtnCPI022L5LIA8Z063q7sStScwkyDMUcOKY82immpR38+BtF591NFo
 5F3gORqAU6oJKsiQYPDV22uVl9eXwxgfpuBm3R2tD7P2810ex/X4hAf9Co+DAc5QosCkABN7ST
 O6o+xer1nX9AFd0CWjWAAAA
X-Change-ID: 20260903-b4-tdx_earlyprintk_tdcalls-40d1b21a8ba2
To: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
 Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.16-dev-62088
X-Developer-Signature: v=1; a=openpgp-sha256; l=2437;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=bkhJSl1Cq62EQXSMdVznURMEBI25uS+zoGaB+7oBFpM=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDFkbu6VZjsVWifA3mFZtWLTV93T2D5uC1aFPTf4sun1eV
 SJhRYhvRykLgxgXg6yYIsvfPR8Zj8ltz+cJTHCEmcPKBDKEgYtTACbCJ8rI8Ntc9rjooUzXA3dO
 tGtrHzspHmayP52LOf4rM1/yW9u0Rob/GYuPp/F6pYamNNvOXB3xQlE3vr6s2ya+VsjFUtzU4DU
 PAA==
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

Patch 1 is a prep patch that moves the port I/O direction constants to
arch/x86/include/asm/shared/tdx.h.

Patch 2: Add a new earlyprintk=tdx option (with sub-options to select
the serial port - same as earlyprintk=serial - tdx[,ttySN[,baud]]).
This calls new tdx_inb() / tdx_outb() helpers, which perform the port
I/O directly using TDVMCALLs.

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

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
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

 Documentation/admin-guide/kernel-parameters.txt |  9 +++++
 arch/x86/include/asm/shared/tdx.h               |  6 ++++
 arch/x86/include/asm/tdx.h                      |  3 ++
 arch/x86/boot/compressed/tdx.c                  |  4 +--
 arch/x86/coco/tdx/tdx.c                         | 47 +++++++++++++++++++++----
 arch/x86/kernel/early_printk.c                  | 37 +++++++++++++++++++
 6 files changed, 98 insertions(+), 8 deletions(-)
---
base-commit: 93f51579e7df248780214094418f205253383cc5
change-id: 20260903-b4-tdx_earlyprintk_tdcalls-40d1b21a8ba2

Best regards,
--  
Vishal Verma <vishal.l.verma@intel.com>

