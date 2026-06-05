Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC275451062;
	Fri,  5 Jun 2026 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643713; cv=none; b=iz/Fah1CZyocR1TiAve/di3gFn4gzNJ83lZXPCmb1rdAqKWA4X/sb9mnATGqL2SsMuezzDcm5DZ1Wd9d+NgbxTF7tIp9rmNKHJnYxIV7bAc/UxRoQmN/DTWKcrSx4akYWgACygnwrWS20SE9QcFFH224PKBp/9Sz2y7XvcdG0Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643713; c=relaxed/simple;
	bh=qwyPU7ax3kVXIchgtoYzveweTq4OWKz4g0yAXFqtEr4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qFNZgk1aJDGjVRFpBEqxbraEfrd59kT099MGGTxsGXgx9dmR6PqJIyhXxl7nPfom6VEoxIL20lGN9zjIefh5I4QQLNWHYBx4TfdzhjDKQCcIFWX2L3eCxslz801Fz01yArhd92yoSvdbyZOG8egRNa8n4J9fAVtijvMLJOOysgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ASRz/R4g; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ASRz/R4g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780643712; x=1812179712;
  h=date:from:to:cc:subject:message-id;
  bh=qwyPU7ax3kVXIchgtoYzveweTq4OWKz4g0yAXFqtEr4=;
  b=ASRz/R4g+uZXuVT8F11rozeiGoIQZgPF7F1LStNF/OLxozqmqtPyeitP
   N8b1uAnqNShH0vZw42uZKKue0VpOgKB0ESaP7AxLU4I+NHPpoQ8R2Dvwz
   jJzg6AtAmHiH5jP/i3hIcTi7AtZPdVRwYqxIERt/OjqYEeC5jAMZoEQe7
   OBwGxYfyZTLBQKPlVgOulDqht4HldbS8p/lsrPUDNM4ir8KdTWTdpyGap
   xla1UCwZWfR8YDyyp1/5mdbuC9VmO1yFR8POj5uT8iQHC7P2JhY1HVgBv
   ENUZoZNBdy7oMaYHd3fCuxIfJMeaNaeRIaTfGb9Q3fAUePKwMPHFC8Exm
   g==;
X-CSE-ConnectionGUID: WTfhmh8uSdK+NEqHaAJdhA==
X-CSE-MsgGUID: ei9isWCUTWqt2GKdxq1wlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="85328557"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="85328557"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 00:15:12 -0700
X-CSE-ConnectionGUID: NORpfU9wT4OGYOVtU5E0Zg==
X-CSE-MsgGUID: qI/sYgenQku/vn1+JNgt5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="249880727"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa005.fm.intel.com with ESMTP; 05 Jun 2026 00:15:10 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wVOlo-000000002VH-2SH1;
	Fri, 05 Jun 2026 07:15:08 +0000
Date: Fri, 05 Jun 2026 09:15:06 +0200
From: kernel test robot <lkp@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org
Subject: [mst-vhost:balloon 8/39] Warning: mm/page_alloc.c:7270
 expecting prototype for alloc_contig_frozen_pages_user_noprof(). Prototype
 was for alloc_contig_frozen_pages_user() instead
Message-ID: <202606050959.Rsoiib9n-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Hi Michael,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git balloon
head:   b145636d693114d343a0a47a4400f5b31e211fec
commit: 2edc4a8a3ed54fe5fd742e60ff3cba3b7dbd8316 [8/39] mm: add alloc_contig_frozen_pages_user for cache-friendly zeroing
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260605/202606050959.Rsoiib9n-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project f43d6834093b19baf79beda8c0337ab020ac5f17)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260605/202606050959.Rsoiib9n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606050959.Rsoiib9n-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: mm/page_alloc.c:7270 expecting prototype for alloc_contig_frozen_pages_user_noprof(). Prototype was for alloc_contig_frozen_pages_user() instead

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
