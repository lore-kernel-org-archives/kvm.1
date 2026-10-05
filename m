Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171C24302FC;
	Mon,  5 Oct 2026 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791240626; cv=none; b=pwk++69/dAtVIZyKssswOWJlLuOY7iRxdfqVsrDUTBzg9o+Fj2Lj5IhHf2krJHghcJuRbMzB6z5k5xs5X98jbNN9PBxwVt4kMqd8jXA4GeiA41nX79xSlX44oQ6v5usKxidXofOGHDTLQkWi0z2n4seD0gv/pFA9CmG1t7R34iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791240626; c=relaxed/simple;
	bh=SdsGJ8xqSDaaQyoYBqei7X+VtMmyV2viAQXFMQwEmPY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Hq25hfQdWr3J1r1xjjXPQ96j4f9HGvzj1PUwA2o1n/DKyqQhWPoNU4gI/YsnJSE2jlAGy7E2qUL9327+YGgTxOqz3h/eUY5wet+0kuc+a5KymzzEyML0i0frmWzwEK9APOaHLeAwzm1BmZsbn5IgdeLCuTgkJ5jEfzR0BIsU8iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZu9fVvw; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZu9fVvw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791240623; x=1822776623;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=SdsGJ8xqSDaaQyoYBqei7X+VtMmyV2viAQXFMQwEmPY=;
  b=lZu9fVvwUdMYwSbm3pmxZjD6UqTfz6BCPmrw9efvbfL7dSZ4UJLyOzrd
   Kfvcf4aGQwCr+qYvP+kk1kiRze4w6TOzrb/VAH9pUWQYK2rVXoY9q9S3u
   w7S0hS9FJVqYS8wF6bnJuyJTkLS5Ixx2v+cD6NRRj5OZMNF5sXtCklI5M
   awAr7+DAggAlFQuo7jsLdgPoqz/m0vvmzHKfr10uN+ZFGlIDUBdA+4XRB
   pOUafqcFA0yvA/JhVxIXLMu2DSdaK9SVtyKXCZJQZVAdORPkycWO+WZ2w
   0kX5GY7zkMI3DdPg2GbGZ6TEftukoDBpFSqSuW6NdiC/ssFyIR7Leq1Qf
   A==;
X-CSE-ConnectionGUID: 75fFCzB0ShKZDnqwoAf0Xw==
X-CSE-MsgGUID: 5nJgwFGlSMynbwIJa/xBpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="94798732"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="94798732"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 15:50:23 -0700
X-CSE-ConnectionGUID: vXZD3QIuSGaLTwpBrwmq/g==
X-CSE-MsgGUID: Pb/xQbQORemo/oiZ8qSHvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="277063563"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.125.108.147])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 15:50:22 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v4 0/2] x86/tdx: Use TDVMCALLs directly for earlyprintk
Date: Mon, 05 Oct 2026 16:50:05 -0600
Message-Id: <20261005-b4-tdx_earlyprintk_tdcalls-v4-0-3f7c56dd568a@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQY7CMAyF4augrAmy3YKmrLgHQihunCEzpUVJq
 ECodycFFhWLLp9sff9DRQleotouHipI76Pv2jzK5ULVJ9P+ivY2b0VAG6ig0FzqZG9HMaG5X4J
 v0/8x2do0TdQlWGRC88OGVAYuQZy/vfD94b3jlf+kTqM4fpx8TF24v+o9jn+fEMJcqEcNumRiZ
 FcBIO/yWZpV3Z3VGOppQhHOUpQpY9FZKRytnf2miilFs1SRqY2wMeuqsg5hSg3D8AQZmpTnbAE
 AAA==
X-Change-ID: 20260903-b4-tdx_earlyprintk_tdcalls-40d1b21a8ba2
To: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
 Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=2861;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=SdsGJ8xqSDaaQyoYBqei7X+VtMmyV2viAQXFMQwEmPY=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDFlHNFcYiYbcmei5/bBFcqxZ7MG8pU+nTY1O7Lp/devUF
 o/5x26+6ihlYRDjYpAVU2T5u+cj4zG57fk8gQmOMHNYmUCGMHBxCsBEtHMYGXbYWZpePMUfmaRr
 s2LN21OvlJZsef99krLEwUlvdocHvOpkZNgWcuiYFFeyzuHivFOcFW8nxFwLMnlzw17rz14uzzW
 5mdwA
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

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
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
base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
change-id: 20260903-b4-tdx_earlyprintk_tdcalls-40d1b21a8ba2

Best regards,
--  
Vishal Verma <vishal.l.verma@intel.com>

