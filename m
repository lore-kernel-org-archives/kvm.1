Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795218760;
	b=qh5cjTov4GJquHGQigogfaPXOa5w2NsZLzG1vi9Csv1q8ryQOLpz/QVcFYGTA60qi9FM
	 tHg9+/+53DOuktYO/rFVSaGpjB2iHb8loCgHg16RBYzvajh7qHrW1X3OJcDPnhk7myNXY
	 3XYteN047QI9btCmuPw0xC7ctbWMjDO3oyYomu9kNJPTJueQFf26j98AvkXKq/ZJnmcMM
	 qsy6cCdQjqYFtJSq3bmMercYvqESKMUZu1ZWUF3KeL7PaqhTy8t53GVv+AvZ4BvYblKbA
	 mPcX9SlO3P87LdmZM8uMfXC0rp1X/16l0KVlP6CNeeYadZOsIq/nSR0ZlEZlz1wlMhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795218760;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=oVXU+dyVt/mUcu0r5Q0BTrwlNIYhXqEzQdQl2AiU4ZE=;
	b=lNAfRFfBGGBYWRTdaGdzt7m8TdHJYzvg6vdg2SQeZAVYR/HieUHmgBUxootVsbK0Vw+Z
	 E0QKdlcfEx0oUZMLgtUeOY0a4J53/kmrC+TtRbktAQzaGaP2qSJu4zqlauBUmEx7PJZnd
	 CewPvfJ35z2Z5l60ndWvWsKOCRom4afezGAuXRMCaj6mtH/ejP0o7Xft0rMbmHjPHPn42
	 pt6vwZP4Jm27QTa7xVq+lYVhqR5Hghhp6EkO/tIhzWGkqobcZQT4RLiRDYqCWVgQ4wKve
	 zellCFOBSyzw5YOgpieuFmCXX9b6qvxWd0tCDgbmo/AsqiHCq7NPCWksCB+aYd8EnoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dxhStFEg;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FB9606A33B;
	Fri, 20 Nov 2026 23:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09FB9606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dxhStFEg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795218756; x=1826754756;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xvLmoK0AjxNXRcn7yctFWlTccdraprJkwv6n91O9PwI=;
  b=dxhStFEgash5wMovc2lMv6qpPPHVThNlQLDXihSOTmxm+a/iWMCgfohZ
   90f+ypq39KL1h39/t2wMUKEOgbHd6BnwcwI5kdLbfEc9K21NKUuLdNm2h
   HCzBlmQb7xjsu0rZOBWRs5fs92C3k8/izE6RLsmU+mnW+cxmHMhEISJ3U
   m6zM4LfV9TwDHI63tr+OZmXvFpwYdsdBRtqE5sDJY7Yvx3Njd6pmISjWy
   yg+DFMibUoCdHB5sRtNdAbTcWDHxO4eL4a/F4iOOsGbD1SBE0VN7m5dJG
   VfxRN33vO4aCueoxqmTO8OlyoG6Ec0WmQ+bd7v49f5Hxubd/Y+KNDIPLL
   w==;
X-CSE-ConnectionGUID: hpnp5x6LQbWW364jrQ9G7g==
X-CSE-MsgGUID: 6VHij4jNTrmZbYxBW0dwWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4021655"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4021655"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 15:52:36 -0800
X-CSE-ConnectionGUID: U09dVRhHSomon1rF265DGA==
X-CSE-MsgGUID: rzhHANfHT8ibPgL45//v0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10722789"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa004.jf.intel.com with ESMTP; 20 Nov 2026 15:52:34 -0800
From: Sohil Mehta <sohil.mehta@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Chao Gao <chao.gao@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] x86/cea: Clean up the exception stack names and declarations
Date: Fri, 20 Nov 2026 15:50:23 -0800
Message-ID: <20261120235025.2809042-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Background
----------
This is a simple cleanup of how the x86-64 exception stacks are named and
reached. These patches started out as part [1][2] of the FRED KVM series. They
were prerequisites for the KVM enabling because the original proposal [3] was
to call __this_cpu_ist_top_va() directly from KVM. So the macro had to be
converted to a function and then be exported.

However, KVM is now planning to use a FRED-specific helper [4] which is
compiled into vmlinux so the macro directly works inside it. Therefore, FRED
KVM no longer needs any of this. Though the cleanup itself is still valuable
and makes the code clearer and the comments more accurate.

Motivation
----------
The exception stacks (DF, NMI, DB, MCE, VC) carry names too short for a header
that almost the whole x86 build pulls in, and the stacks themselves are both
declared and looked up by pasting those names into structure member names.

The first patch adds the ESTACK_ prefix to the names and the second patch
indexes the stacks by the enum that callers already pass. This removes most of
the pasting, and leaves the layout, the addresses and the guard pages exactly
as they were.

There is no change in behavior expected.

Changes from the FRED KVM v10
-----------------------------
Patch 1:
 - Minor commit message improvements
 - Pick up Binbin's review tag

Patch 2:
 - Drop the conversion of __this_cpu_ist_{bottom,top}_va() from macros
   to functions.
 - Expand struct exception_stacks explicitly and drop ESTACKS_MEMBERS()  
 - Rewrite most of the commit message and drop the prior tags.

Links
-----
[1]: https://lore.kernel.org/lkml/20260911213659.2025974-5-sohil.mehta@intel.com/
[2]: https://lore.kernel.org/lkml/20260911213659.2025974-6-sohil.mehta@intel.com/
[3]: https://lore.kernel.org/all/20251026201911.505204-7-xin@zytor.com/
[4]: https://lore.kernel.org/lkml/20260911213659.2025974-7-sohil.mehta@intel.com/


Sohil Mehta (1):
  x86/cea: Index exception stacks by the ordering enum

Xin Li (Intel) (1):
  x86/cea: Prefix exception stack names with ESTACK_

 arch/x86/coco/sev/noinstr.c           |  5 +--
 arch/x86/coco/sev/vc-handle.c         |  3 +-
 arch/x86/include/asm/cpu_entry_area.h | 52 +++++++++++----------------
 arch/x86/kernel/cpu/common.c          | 10 +++---
 arch/x86/kernel/dumpstack_64.c        | 18 +++++-----
 arch/x86/kernel/fred.c                |  6 ++--
 arch/x86/kernel/traps.c               |  2 +-
 arch/x86/mm/cpu_entry_area.c          | 14 ++++----
 arch/x86/mm/fault.c                   |  2 +-
 9 files changed, 52 insertions(+), 60 deletions(-)


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.43.0

