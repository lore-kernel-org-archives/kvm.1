Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E37F35B642;
	Tue,  7 Apr 2026 03:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775533764; cv=none; b=gOq4xgA4l+Hxw6nfAmAPV1mAQcBonjApxdr5DQp/CWC1uflQoM9Qbkv9SUFLUqB1blv8PAJYHLuKWlpVaiYcMvesvKMLOMl6EHYIG8MokFPqiKGOvfcP7gWEDEhAjBrKBJtOMJ1QZ/ikKsUfvh8TfGRkBn2hEtV1y7PFczzzRo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775533764; c=relaxed/simple;
	bh=nuYqkxlnIzX9aecF4Nwi/Xqd7VHkUCjCmgk3tZ5Wp6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+1FRU7rn0xoV1/0IHAd0Q6WpxqY5W+ggV/emrmx7QgsSxOerIA4VlmpaH+UycLwrI/FKzo755GT8eMndfngADOx4/ODbU+a/RHH2Ru1rvFUGZ5SEtrjyEf6qbBOVpRCvlIckvjzFopRoZiuvyy/8vfr1z9KIJFusJSLJc8NlZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oje8Oip+; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oje8Oip+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775533762; x=1807069762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=nuYqkxlnIzX9aecF4Nwi/Xqd7VHkUCjCmgk3tZ5Wp6U=;
  b=Oje8Oip+QJ2rYpQG92RIukvRSUS3vfYNGZM5iAgTm5HLES1kWBJTvEpc
   /2mSz4C8XAlVRZZiKoAYBQWJQT1Mfd6Yn2iwUfSCUF54IHixVVVHfJOoW
   i6/VBNuJUw3XPMaGd7PYyKHu/5B6YUFzMFtYlTPwhFdqyOd1x6c2al/jK
   yPw/GYfzzPZ37l9lfSZPJKfHdkvxW7lMHoinkPHl82N3688ofhaU1R9CY
   S+BophYXqWXVFYxhIjycreIlUpbMstEwQvo+odbYdl2uOVlOmMUa3jXoF
   z28L3Mw+uhCZJthN4vVa4l8wLiqv5tDKxlj+5gqC/ULAF5vZq/u7QgUuM
   Q==;
X-CSE-ConnectionGUID: rblRmZyYQNyQHgul9+WC/A==
X-CSE-MsgGUID: Yw7nWSvSS0Kct+7FBaqLKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="87191975"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="87191975"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 20:49:22 -0700
X-CSE-ConnectionGUID: 12OorsaTQhOS9a0fFtwFvQ==
X-CSE-MsgGUID: i3jBYrMCSpWREdHpjd2fPw==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 06 Apr 2026 20:49:20 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w9xRF-0000000001B-41m0;
	Tue, 07 Apr 2026 03:49:17 +0000
Date: Tue, 7 Apr 2026 11:48:53 +0800
From: kernel test robot <lkp@intel.com>
To: Carlos =?iso-8859-1?Q?L=F3pez?= <clopez@suse.de>, kvm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, alex.williamson@redhat.com,
	pbonzini@redhat.com,
	Carlos =?iso-8859-1?Q?L=F3pez?= <clopez@suse.de>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] KVM: VFIO: use mutex guard in
 kvm_vfio_file_set_spapr_tce()
Message-ID: <202604031640.vckbuS2S-lkp@intel.com>
References: <20260313122040.1413091-5-clopez@suse.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260313122040.1413091-5-clopez@suse.de>

Hi Carlos,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d2ea4ff1ce50787a98a3900b3fb1636f3620b7cf]

url:    https://github.com/intel-lab-lkp/linux/commits/Carlos-L-pez/KVM-VFIO-clean-up-control-flow-in-kvm_vfio_file_add/20260314-053050
base:   d2ea4ff1ce50787a98a3900b3fb1636f3620b7cf
patch link:    https://lore.kernel.org/r/20260313122040.1413091-5-clopez%40suse.de
patch subject: [PATCH 2/4] KVM: VFIO: use mutex guard in kvm_vfio_file_set_spapr_tce()
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260403/202604031640.vckbuS2S-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260403/202604031640.vckbuS2S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604031640.vckbuS2S-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/powerpc/kvm/../../../virt/kvm/vfio.c: In function 'kvm_vfio_file_set_spapr_tce':
>> arch/powerpc/kvm/../../../virt/kvm/vfio.c:219:13: warning: unused variable 'ret' [-Wunused-variable]
     219 |         int ret;
         |             ^~~


vim +/ret +219 arch/powerpc/kvm/../../../virt/kvm/vfio.c

121f80ba68f1a57 Alexey Kardashevskiy 2017-03-22  211  
121f80ba68f1a57 Alexey Kardashevskiy 2017-03-22  212  #ifdef CONFIG_SPAPR_TCE_IOMMU
2f99073a722beef Yi Liu               2023-07-18  213  static int kvm_vfio_file_set_spapr_tce(struct kvm_device *dev,
73b0565f19a8fbc Jason Gunthorpe      2022-05-04  214  				       void __user *arg)
73b0565f19a8fbc Jason Gunthorpe      2022-05-04  215  {
121f80ba68f1a57 Alexey Kardashevskiy 2017-03-22  216  	struct kvm_vfio_spapr_tce param;
121f80ba68f1a57 Alexey Kardashevskiy 2017-03-22  217  	struct kvm_vfio *kv = dev->private;
2f99073a722beef Yi Liu               2023-07-18  218  	struct kvm_vfio_file *kvf;
73b0565f19a8fbc Jason Gunthorpe      2022-05-04 @219  	int ret;
121f80ba68f1a57 Alexey Kardashevskiy 2017-03-22  220  
73b0565f19a8fbc Jason Gunthorpe      2022-05-04  221  	if (copy_from_user(&param, arg, sizeof(struct kvm_vfio_spapr_tce)))
121f80ba68f1a57 Alexey Kardashevskiy 2017-03-22  222  		return -EFAULT;
121f80ba68f1a57 Alexey Kardashevskiy 2017-03-22  223  
8152f8201088350 Al Viro              2024-07-19  224  	CLASS(fd, f)(param.groupfd);
8152f8201088350 Al Viro              2024-07-19  225  	if (fd_empty(f))
121f80ba68f1a57 Alexey Kardashevskiy 2017-03-22  226  		return -EBADF;
121f80ba68f1a57 Alexey Kardashevskiy 2017-03-22  227  
db3d8c11676213b Carlos López         2026-03-13  228  	guard(mutex)(&kv->lock);
121f80ba68f1a57 Alexey Kardashevskiy 2017-03-22  229  
2f99073a722beef Yi Liu               2023-07-18  230  	list_for_each_entry(kvf, &kv->file_list, node) {
1da91ea87aefe2c Al Viro              2024-05-31  231  		if (kvf->file != fd_file(f))
121f80ba68f1a57 Alexey Kardashevskiy 2017-03-22  232  			continue;
121f80ba68f1a57 Alexey Kardashevskiy 2017-03-22  233  
2f99073a722beef Yi Liu               2023-07-18  234  		if (!kvf->iommu_group) {
2f99073a722beef Yi Liu               2023-07-18  235  			kvf->iommu_group = kvm_vfio_file_iommu_group(kvf->file);
db3d8c11676213b Carlos López         2026-03-13  236  			if (WARN_ON_ONCE(!kvf->iommu_group))
db3d8c11676213b Carlos López         2026-03-13  237  				return -EIO;
819da99a7360f7e Jason Gunthorpe      2022-10-07  238  		}
d55d9e7a4572182 Jason Gunthorpe      2022-05-04  239  
db3d8c11676213b Carlos López         2026-03-13  240  		return kvm_spapr_tce_attach_iommu_group(dev->kvm, param.tablefd,
2f99073a722beef Yi Liu               2023-07-18  241  							kvf->iommu_group);
121f80ba68f1a57 Alexey Kardashevskiy 2017-03-22  242  	}
121f80ba68f1a57 Alexey Kardashevskiy 2017-03-22  243  
db3d8c11676213b Carlos López         2026-03-13  244  	return -ENOENT;
121f80ba68f1a57 Alexey Kardashevskiy 2017-03-22  245  }
73b0565f19a8fbc Jason Gunthorpe      2022-05-04  246  #endif
73b0565f19a8fbc Jason Gunthorpe      2022-05-04  247  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
