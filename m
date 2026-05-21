Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBEA22D4C3
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 08:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350947; cv=none; b=nYGTMUVjZPRgv9ohZRJX1GgN4vga6sVy6bhyy0+O2TMD8fsbA7LN2JXSfKMX8WVq2aEvwDDLSKPUXsY5ydjVb9DcUOCkVi9nr+PPuWDX7uaLBHPtqy8UFPbETz3PuunahR6HjIYN2EZSy7vFQpIRZt3ReSWOH+7bItOjy+DOvhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350947; c=relaxed/simple;
	bh=EbLtyeffX9/xKE/c+eEA9iGJB41FbrtuZFFiPty40fA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=K/Z6CgKDynW/oKhnbzTBvVcegC6iFGOejv/o9Zpctm4Zfdqb+32YyYvCjvtk2PEwV0LqSoxTOIMwLr+XlVyPbfis+yeHvI0AAslBLpgC6NCkz4I8JF07f/jvLaY5j0bJRzex9NTdMD6s3utgb1rBQtRBuj0/ijB8OGGQHBYDnbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L2KH5zzq; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2KH5zzq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779350946; x=1810886946;
  h=date:from:to:cc:subject:message-id;
  bh=EbLtyeffX9/xKE/c+eEA9iGJB41FbrtuZFFiPty40fA=;
  b=L2KH5zzq4dVuiawMOMXxkBJtqo7R1ze3OAd2mogkrJnmy/3IPzrNxJjp
   pgHRplnrNWoLvANT5XQwKU3zrK0Ao8FqoaT5pN5gmcfvHu/k5/ExLoCXx
   TsTPkwZZ0l/7T96DMHwS1FLnmCDaiDwqgwLbjwKoyW3JxTSJGzUEdbnJ9
   NoXC7JUqx8V+rc0gF5RJujv5GcNypOsivlcr/7gL0tnJr26IziUwI/H3a
   lsIsWk35urALMY0pFvoovEmOLf2wmehhSSAepaQA1sCW0Q+hJBu6HdEpl
   URYzBQ9mBlBygqsSOF9LBtmWGLhjSoosZElkvI8G+M8698CksEteNNh/M
   A==;
X-CSE-ConnectionGUID: 8bCVYzdGRWy+psv8kN/5YA==
X-CSE-MsgGUID: GCqJMXtiS02itXK2/lsP2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="102939948"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="102939948"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 01:09:05 -0700
X-CSE-ConnectionGUID: gS9ViL1gR1mx24KcLITjQw==
X-CSE-MsgGUID: NfOO3STJS5Kx2y3y9YaD6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="245495352"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 21 May 2026 01:09:04 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPySE-000000004dl-2DZJ;
	Thu, 21 May 2026 08:08:42 +0000
Date: Thu, 21 May 2026 16:07:08 +0800
From: kernel test robot <lkp@intel.com>
To: Matt Evans <mattev@meta.com>
Cc: oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
 Alex Williamson <alex@shazbot.org>
Subject: [awilliam-vfio:next 11/13]
 include/linux/vfio_pci_core.h:247:31: sparse: sparse: incorrect type in
 return expression (different address spaces)
Message-ID: <202605211601.U1OvmuqY-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

tree:   https://github.com/awilliam/linux-vfio.git next
head:   b9285405c5f6144f4444f97bf3048d865e11cc1d
commit: 859dc0f6253b0d65fd4d79e29aa29b3d939c51a9 [11/13] vfio/pci: Replace vfio_pci_core_setup_barmap() with vfio_pci_core_get_iomap()
config: alpha-randconfig-r132-20260521 (https://download.01.org/0day-ci/archive/20260521/202605211601.U1OvmuqY-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 8.5.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260521/202605211601.U1OvmuqY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605211601.U1OvmuqY-lkp@intel.com/

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
   drivers/vfio/pci/vfio_pci_core.c:1736:9: sparse: sparse: cast from restricted vm_fault_t
   drivers/vfio/pci/vfio_pci_core.c: note: in included file (through drivers/vfio/pci/vfio_pci_priv.h):
>> include/linux/vfio_pci_core.h:247:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   include/linux/vfio_pci_core.h:247:31: sparse:     expected void [noderef] __iomem *
   include/linux/vfio_pci_core.h:247:31: sparse:     got void *
   include/linux/vfio_pci_core.h:250:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   include/linux/vfio_pci_core.h:250:31: sparse:     expected void [noderef] __iomem *
   include/linux/vfio_pci_core.h:250:31: sparse:     got void *

vim +247 include/linux/vfio_pci_core.h

   235	
   236	/*
   237	 * Returns a BAR's iomap base or an ERR_PTR() if, for example, the
   238	 * BAR isn't valid, its resource wasn't acquired, or its iomap
   239	 * failed.  This shall only be used after vfio_pci_core_enable()
   240	 * has set up the BAR maps and before vfio_pci_core_disable()
   241	 * tears them down.
   242	 */
   243	static inline void __iomem __must_check *
   244	vfio_pci_core_get_iomap(struct vfio_pci_core_device *vdev, unsigned int bar)
   245	{
   246		if (WARN_ON_ONCE(bar >= PCI_STD_NUM_BARS))
 > 247			return ERR_PTR(-EINVAL);
   248	
   249		if (WARN_ON_ONCE(!vdev->barmap[bar]))
   250			return ERR_PTR(-ENODEV);
   251	
   252		return vdev->barmap[bar];
   253	}
   254	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
