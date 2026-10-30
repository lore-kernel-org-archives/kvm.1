Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350414;
	b=Y9rG24Gsh/1Exe4Av70ZzHzYQNqkO8PJ0T2IADu4AkfgFVFzYmKdvVUo7XUUrk/cR0w4
	 sYUtTojqwRmfpuRdYR630mjXgWgSWByZDhAfEry65Q4V/1JkjyMi1L/hhFb88LWReCB+H
	 cTkA8LfzjrGnX83+699KslCcvb+GFR2F7UcLtKjJzWR9uEKvnb/qMEMY7F/zfnf/YXPUu
	 JeYd3j5Vq6AbBmb6zHLLE4Nphb9X4UeziwT5PU/f0Ot/1ZLsOakf6KM2Aujuk4mrtjyRj
	 fm0urO+zcuZTDS/qo1/4KzaqA9QQGiPWo9uaTjs8jzZx4qYZF1PB/hflfWcTv5TfXFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350414;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=S/4+TRsoLshkvAwJpP+2abwX1YTP9lA99c9S8UzEXko=;
	b=Uha8EYXfmPw0ZsapS2E6y6eZA+ZVOI6KxXBrXcEmCM8yKYiKsIQrRfW4P44Y9X5ysyYb
	 YIQviWJnBN77PDamTSMtzdQZSA4ffR1uSp+5BMvscUW+WTp0FX0XwgneTlPJytkbugHzz
	 kWZm0M7MiKNRSfarxqYbC9SreBhQVpEcTG/pu1fmRoYaq6G29y+yjw4zwK5vABZzliQLB
	 Y5wFO5PS5X/YtEBgm/XEFA2gyhu19XuAvbql/oB7+VV9xgDL3fMTRV6UE6EHX3i+A1dSh
	 Pbt0Juon4DuEOfuXgZu/QJHSASrOsy0hRyPVzXReLv/eL9xkf4+rgKWSm2/F52lv8Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="P/g6obrH";
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AE3606A31C;
	Fri, 30 Oct 2026 08:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02AE3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P/g6obrH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793350414; x=1824886414;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vn0ScrPaHzQTbUF3NhrfMrhAbRmenQcfaJaeeipfx8g=;
  b=P/g6obrHaCq8Z7tX4qveKvQ29ONW0HimikMWKbIE8P90BPT/XY+y0vhT
   R/Gtyx8WfVfKK/yLyRzgQgcF7y8Xqzm6ty7Hj8aLRt4DF17n3STeM2PV1
   Kz0R0yIqhxDbXJkjkeLsVsvfhmNBEP71ibn0TmKVO5Ioik1dOV9CFqPFb
   AMsZ7xU0DWT5HmCGnmR9fLk99Jm7/GGxMaNv8x1JV6ScP4A4yvuUBjmz0
   +C+F5SAdI2LN5+KUv9tfnGv1co9/aDqmRkhmsh+UdFlsbRx4Y2kw5VOND
   aGPxNYrZon2DD4q3L6zYgU5MiudwIjzUrplI1oGFf8wwmHSpUZspX3/d7
   Q==;
X-CSE-ConnectionGUID: Oae9db6PS3aockLXmd5XBg==
X-CSE-MsgGUID: RqB5CScjRqKgLNKiMQgDOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2122553"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2122553"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 01:53:33 -0700
X-CSE-ConnectionGUID: THJi/VY9QqmldCAK8fTjkg==
X-CSE-MsgGUID: hwV2OnitRo24IUn9CYVnIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="7199498"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 01:53:34 -0700
From: Chao Gao <chao.gao@intel.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yilun.xu@intel.com,
	arjan.van.de.ven@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [RFC PATCH v1 0/3] TDX: P-SEAMLDR: Support large TDX modules and sigstructs 
Date: Fri, 30 Oct 2026 01:52:57 -0700
Message-ID: <20261030085304.3886520-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
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

This series lets TDX module updates handle large TDX modules and
sigstructs. It is an RFC for early review.

Dave, feel free to ignore this RFC for now. TDX developers, please take
a look.

I would especially like feedback on one question. Does the kernel need
to tell userspace that it supports large modules and sigstructs? I would
rather not add such an interface.

Userspace can simply try such an image, because a kernel without this
series rejects it with -EINVAL before calling P-SEAMLDR, so a failed try
has no side effects. If userspace should not have to try an update to
find out, the alternative is to backport this series to all kernels that
support TDX module updates. Userspace could then assume that any kernel
with TDX module updates handles such images.

====

This series is a follow-up to the TDX module update series. As thanks
for merging that series, we agreed to take on the TDX metadata cleanup [1].
With the cleanup converging, we are starting on this work and expect it
to be merged after the cleanup.

Today a TDX module binary can be at most 496 pages and its sigstruct at
most one page. Both limits come from the P-SEAMLDR ABI.

TDX modules are outgrowing them. A post-quantum signature algorithm
pushes the sigstruct past 4KB, and new module features push the binary
past 496 pages. The P-SEAMLDR ABI was extended for both.

The kernel rejects any image over these limits. TDX modules for Diamond
Rapids exceed them, so without this series, TDX module updates fail on
Diamond Rapids. This series is all that is needed to make them work.

The image format that userspace uploads ('struct tdx_image') is generic
enough and needs no change.

== AI Usage ==
AI was used under supervision to review code and workshop logs. It
spotted a u32 overflow and an oversized allocation that removing the 496
page cap would cause in patch 2. The module size limit in that patch
prevents both. It also suggested renaming init_seamldr_params() in
patch 1 and updating the comments around it.

== Testing ==
Tested on a Diamond Rapids system. Updates with a module larger than 2MB
and an 8KB sigstruct work, which exercises both the chained page list
and version 1 of 'struct seamldr_params'. TDs keep running across
updates.

[1]: https://lore.kernel.org/kvm/20261012094754.27702-1-chao.gao@intel.com/

Chao Gao (3):
  x86/virt/seamldr: Allocate 'struct seamldr_params' after image
    validation
  x86/virt/seamldr: Support large TDX module binaries
  x86/virt/seamldr: Support multiple sigstruct pages

 arch/x86/virt/vmx/tdx/seamldr.c | 154 ++++++++++++++++++++++++++------
 1 file changed, 127 insertions(+), 27 deletions(-)


base-commit: a49e2d257594931772ab8f0024708c3076f3aa1d
-- 
2.52.0

