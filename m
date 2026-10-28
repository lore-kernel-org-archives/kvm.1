Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175202;
	b=xuMXmv+/WkDciX8leuYQCp/vlGbBU0x6Yb77lJPlZgeri6STYcM07aX5z0aKoGOuMjI/
	 IeqCoh0e5P1oAThoZu5bWWLHXhfty6z7rPsvvNCFCQKyzIZB1GYiFsgBAqH13tg8Xc3yx
	 P0IAH1FgRIavt5Fj3ru48N9uQ3vM+rqwjOAiK3xMc70DuV0mWRv1+gL8rMRJUH2m1Bb/h
	 QAE2zG6mPBVMApU2hUzIKRgmRap0ikaccqyb0QQefbRRhgPXQNNqHVB8DwjmHwzyhxeWI
	 vLVmsBRg7lOLz/Hf6NUCUIxbSjPNCj62gnPhNU1EOhTRyuft5GraBSGZ0kmHOpYzDww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175202;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=AQ69QgwWrBTLbLy8ZCOmzzYIZQFOgR3K0SSo1y7xus0=;
	b=n9g06leBfnA+iCkSWFKBsQwYTio2C6BbaUZY5cGH7hRBH7/uO0OogHqCMJaO90aATo6I
	 UKTP9TFny7ULZrirEueJbmUG7bodhOk8KNjvkekz77Xv1+zKV6o7xvLXXmGMmsEr+Icnx
	 TUQTqaj+P5C6oc6MuqKAxP6cKXDalFk7yNeqOTOHNcRUWIAicXF0+wAlDcbwjhqE5N67b
	 3AG8p2e4U6Vb3wx23fGDvrNr9H4MInKBXvOYE2Fy08YwX7pEenU/kyRhu3C/Nf8AJAx/G
	 3ZAUyasgK3aptFRB2BQL1PIsVx8zbX1NEvfBHzDpp3m8Odb+UPX/DPIjLkXmu6Iz+jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YbM4UYMV;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4B8606A31A;
	Wed, 28 Oct 2026 08:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE4B8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YbM4UYMV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793175201; x=1824711201;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YdoBbntMRkrdPEwFCxfL27AAbVHzuUnLR/LwX9+Decw=;
  b=YbM4UYMVjM7dlGjHWizIs2dyhhtJ+hg7ytnxDdj7hvIuAloCKUV/8pmE
   WUahkU8ObEKIEo75Ef+uQF5LHvGgvz8NfMJxfAJ7ODSNKudbB8JgUrhdw
   GzNg8O7igUuUkbU5kcfkNdrtMd5E5hotzAVVpNbQd49mI/HzsiCg05JJm
   bPIsxXPbdqHmqrJJJeAbQb93Oeq5FgFhH6yOCEv0A16D0DV6pfNlmC9TO
   VLfdIycpfo46zeoZEkNMMmf8pGVbHH6q2UD3thmoakYvTKR1+2a1Y+Bev
   NYWns77R3hDaUo59Njz9jmleN8Pd9CVwaPDxNUU3AdZnTUajIHa8vgJYD
   g==;
X-CSE-ConnectionGUID: c5le7f29SfygcixKshIPQw==
X-CSE-MsgGUID: K2nNZGPrQBGyskRafqbrtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1902885"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1902885"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 01:13:15 -0700
X-CSE-ConnectionGUID: Wf6ZPOlUQhGh9RE7nrD4Kg==
X-CSE-MsgGUID: VwaN//XQQ12DTxB+Ez6USg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="5118463"
Received: from litbin-desktop.sh.intel.com ([10.239.57.15])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 01:13:10 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	dave.hansen@linux.intel.com,
	andrew.cooper3@citrix.com,
	nik.borisov@suse.com,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	tony.lindgren@linux.intel.com,
	kishen.maloor@intel.com,
	dedekind1@gmail.com,
	binbin.wu@linux.intel.com
Subject: [PATCH v6 0/4] KVM: TDX: Validate directly configurable CPUID bits
Date: Wed, 28 Oct 2026 16:16:53 +0800
Message-ID: <20261028081658.1228484-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
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

Hi,

This is a quick respin of the TDX CPUID validation series (v5 [1]) to
address Rick's changelog comments [2] and to rebase on top of Sean's TDX
CPUID fixes series [3], which this series depends on.  Also, patch 4 now
ignores the index for non-indexed CPUID functions when looking up the
allowlist, as userspace isn't required to zero it.

I think this version is in good shape.  If there are no further concerns,
I'd appreciate it if this could be considered for queueing.

The TDX module reports a set of CPUID bits that the VMM can directly
configure for a TD, but KVM cannot blindly expose all module-supported
bits to userspace.  Certain features imply additional architectural state
(such as one or more MSRs) that KVM must explicitly manage across
host/guest transitions to prevent host state corruption.

Today, KVM hardcodes a denylist to filter out host state clobbering
features that KVM doesn't support.  However, a denylist doesn't scale as
the TDX module evolves, i.e. host state clobbering features added by a
future TDX module are not covered by the denylist, and userspace could
enable a feature that KVM doesn't support.

This series builds an allowlist for directly configurable CPUID bits, and
filters and validates userspace input against it, so that newly introduced
TDX directly configurable CPUID feature bits can only be enabled by
userspace after KVM explicitly opts in.  Except for a few fixed-1 bits
required for basic TDX support, host state clobbering features are either
directly configurable or gated by TD ATTRIBUTES/XFAM.  KVM already
validates ATTRIBUTES/XFAM, so the allowlist only needs to cover directly
configurable bits.

Discussions from v3/v4:
- Rick asked whether the assumption that the reserved bits in
  CPUID.0x1.EAX, CPUID.{0x4,0x18,0x1F} and CPUID.0x80000008.EAX won't be
  used to enumerate features can be confirmed by the x86 architects.
  Confirmation is still pending.  Per the SDM/APM, these leaves/registers
  are defined for specific information (version, cache/TLB parameters,
  topology, and address sizes), so the reserved bits are expected to be
  used to extend the existing information rather than to enumerate
  features.  Allowing these registers in full is a best guess, but it's
  still far better than the existing denylist-based check.

- Whether to restrict the TDX feature bits to kvm_cpu_caps[].
  The conclusion from the discussions is to construct the allowlist based
  on kvm_cpu_caps[], plus a few bits that KVM can support for TDs
  independently of kvm_cpu_caps[].  If TDX feature enabling turns out to
  be consistently blocked by non-TDX VM enabling, a solution can be worked
  out then.

- New opt-in interface vs. backporting.
  There are two options for old KVM versions that don't do the filtering
  and validation:
  1) Add a new opt-in interface to expose features newly introduced by the
     TDX module.
  2) Backport this series to LTS/stable branches.

  The opt-in design vs. backport decision is deferred, since this series
  is correct and an improvement either way.

- Potential backward compatibility issue when an effective fixed-1 bit
  becomes directly configurable due to x86 feature deprecation.
  This is left for the future, i.e. it can be addressed if and when such a
  deprecation actually happens, e.g. by adding an opt-in interface to let
  users/admins choose between migration flexibility and backwards
  compatibility on old platforms.

Changes since v5 [1]:
- Dropped the bug fix patch in v5 and rebased on top of Sean's TDX CPUID
  fixes series [3].
- Changelog updates per Rick's comments [2].
- Collected RBs from Rick, Chao, Nikolay, Xiaoyao.
- Ignore the index for non-indexed functions when walking reverse_cpuid[].

The series follows the CSV version of the CPUID virtualization document
from "Intel TDX Module ABI Definitions" [4], updated in June 2026.

AI tools were used to:
- Polish the cover letter and commit messages.
- Do code review.

[1] v5: https://lore.kernel.org/all/20261016091422.3182216-1-binbin.wu@linux.intel.com
    v4: https://lore.kernel.org/all/20260917072548.2314491-1-binbin.wu@linux.intel.com
    v3: https://lore.kernel.org/all/20260827031837.2863609-1-binbin.wu@linux.intel.com
    v2: https://lore.kernel.org/all/20260604023314.3907511-1-binbin.wu@linux.intel.com
    v1: https://lore.kernel.org/all/20260417073610.3246316-1-binbin.wu@linux.intel.com
[2] https://lore.kernel.org/all/b196cf9f65fe1e52aba7b867b7c2687c40caa337.camel@intel.com
[3] https://lore.kernel.org/all/20261022210134.612848-1-seanjc@google.com
[4] https://cdrdv2.intel.com/v1/dl/getContent/795381

Binbin Wu (4):
  KVM: TDX: Track configurable CPUID bits allowed by KVM
  KVM: TDX: Add CORE_CAPABILITIES to the allowlist
  KVM: TDX: Report only KVM-allowed CPUID bits in KVM_TDX_CAPABILITIES
  KVM: TDX: Validate userspace CPUID input for KVM_TDX_INIT_VM

 arch/x86/kvm/vmx/tdx.c | 260 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 231 insertions(+), 29 deletions(-)


base-commit: dea4f6380f4ec96e8f3b0aaf2343764bd0d25ef4
prerequisite-message-id: <20261022210134.612848-1-seanjc@google.com>
-- 
2.46.0

