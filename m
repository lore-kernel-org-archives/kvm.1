Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECAB363089;
	Fri, 21 Aug 2026 03:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787282967; cv=none; b=g1vLDQ2OyLJBXeIchq0pZsUYwHd5OqKmmVCxyBBzUofd55h9vhKfzpOH7gXtm2vwPdiDr/+iXaar3NnzbH08l7XvBAUrUNXyTWw2zp/8xufJjXSIXdytuHScAMYOxAz0b3zcMU9OQknY2ei9HQULIo4IOHFPICEJOUPl52WbH0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787282967; c=relaxed/simple;
	bh=Tg47wxnZT/EuRtUTQhOxoMkogWxsRxN/pw3SnJqF/w8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WZ2CYg7GtxupfukYsxF9xoG6t/MT40+mtxWUtD4d5sBKTp96TkunYBObFWX2kZrDPOrgZSxiyzOocaPZzX8XWTROXefjI+QitDmfCTpHgkZMdrPAgCS3mdQfzwpzKkjN1Pa5/6o7SeZ4NVNVzYAPaAFGFhMUPm3a9aTs0rgEQTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJJxEgvg; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJJxEgvg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787282965; x=1818818965;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Tg47wxnZT/EuRtUTQhOxoMkogWxsRxN/pw3SnJqF/w8=;
  b=MJJxEgvgmylujUaYTmTXMZH13zIsQIpNi2FP4w1Jujz4rF9Np1yIs0XD
   Zzt7HRdNbbGxr2jLU3tW1yGzY5CIpF94VS9foTm+lohKsNJwSp/IzXKlE
   8ERMNhonvlZFGQ44vVxUq5aN/OXB/OSomChLYlL9W6/FYn+Rnv1ty6s5Z
   aXe1tWsaEG3gbfqH71xYLFkuo6lT/sHVlnbrRuZMMgi28RHrONQbBYNip
   sK6FT4sEUy+Zu4ZDVzmQyXY7lKkPl6JNXadwBSgeGkCLPuDrEeju7FY2a
   LUnNiyT4yNjh1gCxeuo/1kgQYv2Mz3/zKGOa+NR00nG19WIIwauM+jJuP
   A==;
X-CSE-ConnectionGUID: NQrNlLbTQyO3M9LZQ0v5vw==
X-CSE-MsgGUID: ZBmtV7M7SGSvd4Gl4kNSkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="91640223"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="91640223"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 20:29:25 -0700
X-CSE-ConnectionGUID: jzL0HLMXRDSq4xG3a478bA==
X-CSE-MsgGUID: 1WRSveMpQpCiMeKYLGT2KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="264451585"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.47.46])
  by orviesa006.jf.intel.com with ESMTP; 20 Aug 2026 20:29:21 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: kas@kernel.org,
	rick.p.edgecombe@intel.com,
	yilun.xu@linux.intel.com,
	yilun.xu@intel.com,
	xiaoyao.li@intel.com,
	sohil.mehta@intel.com,
	adrian.hunter@intel.com,
	kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com,
	peter.fang@intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	chao.gao@intel.com,
	artem.bityutskiy@linux.intel.com,
	kvm@vger.kernel.org
Subject: [PATCH 0/6] Enable TDX module extensions
Date: Fri, 21 Aug 2026 11:29:14 +0800
Message-Id: <20260821032920.256225-1-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are trying to get detailed review and some acks for this series.

Dave please feel free to ignore. Kiryl, Rick and TDX developers, please
help take a look.

== Why it's split out ==

The extension patches are pre-requisite for several TDX features (DICE,
TDISP, TD migration). We would appreciate community review and ack so
that all of the extension-based work can build on it.

Previously this series had been posted along with DICE [1]. But now it
is split. It was confusing review to have them together and DICE needs
more time to implement feedback.

The DICE part is in the full branch [2] as an example for extensions.
But it does not include the other DICE feedbacks.

[1] https://lore.kernel.org/lkml/20260618081355.3253581-1-yilun.xu@linux.intel.com/
[2] https://github.com/intel-staging/tdx/tree/tdx-module-ext

This series retained Reviewed-by tags collected in DICE series. Please
let me know if you object.

== Branch stack ==

This is based on v7.2-rc1, the full branch contains:

  Patch 1:   SEAMCALL version patch [3] which is WIP on community review.
  Patch 2~8: This series, including this cover-letter.
  Patch 9~N: The old DICE part as an example.

[3] https://lore.kernel.org/all/20260722084634.131020-1-yilun.xu@linux.intel.com/

== Overview ==

To date, SEAMCALL execution must complete quickly to avoid stalling the
host, or yield quickly at pre-defined interrupt checkpoints. This is
acceptable for the existing SEAMCALL leaves, which perform simple,
bounded operations.

However, some new features such as attestation and TD migration require
higher level security protocols inside the TDX module, which cannot fit
within that constraint. TDX solves this by making those operations
inherently preemptible and resumable like OS tasks. TDX provides a
separate SEAMCALL execution environment - the TDX module extensions -
for those operations.

This capability allows for higher-level SEAMCALL ABI design - like
"create a DICE-based quote". Several new features, such as DICE-based
quoting, TDISP and TD migration, use SEAMCALL leaves backed by the TDX
module extensions.

The TDX module extensions need memory for their own internal state and
data to serve these SEAMCALL leaves, so they need extra setup during TDX
module initialization. At runtime, the host invokes these SEAMCALL
leaves just as normal ones - if interrupted, simply re-invoke the leaf
to resume.

For more information on TDX module extensions, please refer to [4].

[4] https://lore.kernel.org/lkml/20260618081355.3253581-1-yilun.xu@linux.intel.com/

== Changes ==

Dave pointed out the SEAMCALL version change could be a separate
discussion. Split the patch out from this series.

Chao asked if the extensions re-initialization flow could be simplified
by unconditionally executing TDH.EXT.INIT and leaving the validity check
to the module. Yilun pointed out that if we don't honor the updated
metadata, the SEAMCALL leaf may fail then the entire update fails. Rick
pointed out if an update results in different metadata for the
extensions, it is an incompatible update so the update failure is
expected. We agreed on this, so now the simplified re-initialization
flow is: execute TDH.EXT.INIT unless the extensions were originally not
required at boot time. This also moves the extensions' metadata back to
tdx_sys_info, as they now read at boot time and never updated afterward.

Another comment is that Xiaoyao and Rick pointed out the interruptible
resumable capability provided by the extensions is not new. From the
host perspective, some existing SEAMCALL leaves can save states, return
from interrupt and resume. So I no longer emphasize that the new
SEAMCALL leaves are new type of resumable calls. Instead I explained the
yielding details in TDX module to justify why TDX module extensions are
needed.

Rick pointed out the selection of SEAMCALL leaf version for
TDH.SYS.CONFIG is the TDX ABI detail, mixing the operation with other
kernel operations makes the version selection logic tenuous. Make a new
patch which adds SEAMCALL helpers for TDH.SYS.CONFIG/UPDATE.

Quoting v2: https://lore.kernel.org/lkml/20260618081355.3253581-1-yilun.xu@linux.intel.com/

Quoting v1: https://lore.kernel.org/all/20260522034128.3144354-1-yilun.xu@linux.intel.com/


Xu Yilun (6):
  x86/virt/tdx: Wrap TDH.SYS.CONFIG/UPDATE operations in helpers
  x86/virt/tdx: Configure add-on features on TDX module init and update
  x86/virt/tdx: Detect if the extensions initialization is required
  x86/virt/tdx: Add extra memory to TDX module for the extensions
  x86/virt/tdx: Make TDX module initialize the extensions
  x86/virt/tdx: Re-initialize the extensions on runtime TDX module
    update

 arch/x86/include/asm/tdx.h                  |   1 +
 arch/x86/include/asm/tdx_global_metadata.h  |   6 +
 arch/x86/virt/vmx/tdx/tdx.h                 |   2 +
 arch/x86/virt/vmx/tdx/tdx.c                 | 245 +++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c |  20 ++
 5 files changed, 265 insertions(+), 9 deletions(-)


base-commit: d8610a4dbc62cf5ddf24ad10ba7a7324c0abb278
-- 
2.25.1

