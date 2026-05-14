Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A683002CF
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776810; cv=none; b=s73z+fQPoPeT6RUz2S21focFQQlVf8fjKUPeW1rCTY0zHAEA9IcEKvYMsQF+7HP2firgAqFXMsqTmRWhlIynD4j0YVSxHea7Lf5t7A1jox7zcCoW+KEpiXGiEPw+hxVpxJoqsC2XneFT6T3hC9vJslE+juez1JjZXqY3sJGhXJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776810; c=relaxed/simple;
	bh=fsj9ai4SXoVbScciJfWf1Zf+epwvOLBrPhyOPcApwGY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Xf93kRXdUGr4rlBu1jXiAUWHKYZhO+H1GIA0N+QkZpdoKyvrlGh1IRmeibVyua0iO8AkCTRRa7YQ2pmWapRF1jUFNUi+MWKDvg8kr0yjUKzV6yiVW/d+cAurE5q6TbgIahcqZiz2okA9iFnv3CMh5k3PgLuNAr2DqcmGRt9MV9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J8C+GoEq; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J8C+GoEq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778776808; x=1810312808;
  h=date:from:to:cc:subject:message-id;
  bh=fsj9ai4SXoVbScciJfWf1Zf+epwvOLBrPhyOPcApwGY=;
  b=J8C+GoEq6FpglrtZIUM9kVpqAs7+xcAPPLSCSzs2lJ+bygOUdG0mxUyN
   nYrzrhUQi60nf1PpFB8AVXmyrkrvKgFggYq6mJzl/7J99vclQOtZvg0Yt
   lsrbfftFIHoBkN2hrtkVMnOFgSprxHOB1RCE4I4CkzUyAlO/h0RaOV7Hq
   mizugJ8MyLCi8WdKy0IqGjsxHtUHnxNvm9WqaO/thC3TSe18m2tWzdt61
   guw4zF4IYyW3/LAjbiGx9CpXN2xJ7QjEvFzfByLV5sFwuMiK9VB+TwpQ1
   t2uAsQsKmn3Cpz23dZN10aQS+aO/5nyCqrxi9jHQ/l5zmTstdc3MCuioU
   A==;
X-CSE-ConnectionGUID: nrgJpSIXRQONUoQamlJozg==
X-CSE-MsgGUID: T84W1e1gTSaoMiR2SqUtnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="90417418"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="90417418"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 09:40:07 -0700
X-CSE-ConnectionGUID: R6fOTJOpTpaAmwdTtf0Yaw==
X-CSE-MsgGUID: frazWV52SXGbOWH7i9rv+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="238534958"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 14 May 2026 09:40:05 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNZ6Q-000000006mr-3tfT;
	Thu, 14 May 2026 16:40:02 +0000
Date: Fri, 15 May 2026 00:39:50 +0800
From: kernel test robot <lkp@intel.com>
To: Matt Evans <mattev@meta.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
 Alex Williamson <alex@shazbot.org>
Subject: [awilliam-vfio:for-linus 3/4]
 drivers/vfio/pci/vfio_pci_core.c:499:35: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202605150023.lXFibOM0-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

tree:   https://github.com/awilliam/linux-vfio.git for-linus
head:   a8a3ce989a94db08f77968a4e75b34eaa6d40c9a
commit: a975fd177726e110f30b561dd0707b78f21ffe66 [3/4] vfio/pci: Set up BAR resources and maps in vfio_pci_core_enable()
config: parisc-randconfig-r134-20260514 (https://download.01.org/0day-ci/archive/20260515/202605150023.lXFibOM0-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260515/202605150023.lXFibOM0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605150023.lXFibOM0-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/vfio/pci/vfio_pci_core.c:274:33: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/vfio/pci/vfio_pci_core.c:274:41: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/vfio/pci/vfio_pci_core.c:278:25: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/vfio/pci/vfio_pci_core.c:278:43: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/vfio/pci/vfio_pci_core.c:278:56: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/vfio/pci/vfio_pci_core.c:278:65: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/vfio/pci/vfio_pci_core.c:283:25: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/vfio/pci/vfio_pci_core.c:283:44: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/vfio/pci/vfio_pci_core.c:283:57: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/vfio/pci/vfio_pci_core.c:283:66: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/vfio/pci/vfio_pci_core.c:291:39: sparse: sparse: restricted pci_power_t degrades to integer
   drivers/vfio/pci/vfio_pci_core.c:291:58: sparse: sparse: restricted pci_power_t degrades to integer
>> drivers/vfio/pci/vfio_pci_core.c:499:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/vfio/pci/vfio_pci_core.c:499:35: sparse:     expected void [noderef] __iomem *
   drivers/vfio/pci/vfio_pci_core.c:499:35: sparse:     got void *
   drivers/vfio/pci/vfio_pci_core.c:506:43: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/vfio/pci/vfio_pci_core.c:506:43: sparse:     expected void [noderef] __iomem *
   drivers/vfio/pci/vfio_pci_core.c:506:43: sparse:     got void *
   drivers/vfio/pci/vfio_pci_core.c:514:43: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/vfio/pci/vfio_pci_core.c:514:43: sparse:     expected void [noderef] __iomem *
   drivers/vfio/pci/vfio_pci_core.c:514:43: sparse:     got void *
   drivers/vfio/pci/vfio_pci_core.c:1736:9: sparse: sparse: cast from restricted vm_fault_t

vim +499 drivers/vfio/pci/vfio_pci_core.c

   484	
   485	/*
   486	 * Eager-request BAR resources, and iomap them.  Soft failures are
   487	 * allowed, and consumers must check the barmap before use in order to
   488	 * give compatible user-visible behaviour with the previous on-demand
   489	 * allocation method.
   490	 */
   491	static void vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
   492	{
   493		struct pci_dev *pdev = vdev->pdev;
   494		int i;
   495	
   496		for (i = 0; i < PCI_STD_NUM_BARS; i++) {
   497			int bar = i + PCI_STD_RESOURCES;
   498	
 > 499			vdev->barmap[bar] = ERR_PTR(-ENODEV);
   500	
   501			if (!pci_resource_len(pdev, i))
   502				continue;
   503	
   504			if (pci_request_selected_regions(pdev, 1 << bar, "vfio")) {
   505				pci_dbg(pdev, "Failed to reserve region %d\n", bar);
   506				vdev->barmap[bar] = ERR_PTR(-EBUSY);
   507				continue;
   508			}
   509	
   510			vdev->barmap[bar] = pci_iomap(pdev, bar, 0);
   511			if (!vdev->barmap[bar]) {
   512				pci_dbg(pdev, "Failed to iomap region %d\n", bar);
   513				pci_release_selected_regions(pdev, 1 << bar);
   514				vdev->barmap[bar] = ERR_PTR(-ENOMEM);
   515			}
   516		}
   517	}
   518	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
