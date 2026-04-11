Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82423446C0;
	Sat, 11 Apr 2026 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775910442; cv=none; b=TIKam6gtVs6rdb7Af1gui4BL9Y7TTJJhtoCktXO3nDnarruCsu/6/WCZEz7FiWOV3v2+FowSX2ypmpFG9VW4PXQz5KJfnEiZwfUeUk7FrEsc/frG04ghqup+oVIPRbaTY7w+UrRfh9Ql+arNTpU6qyjKBOZ4vfJWII19BL62Bv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775910442; c=relaxed/simple;
	bh=qmTG0sPt0gGADnHCwpgCA4OgO6l5QwLO2uOUdGQmqhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqfqM1au0aoEoYlL2Eu+FXuMkjg/+1VZwATXdXLhGvxDSb20M+8cscFrE72/gVhh9WfzdPnmLlnmNpkj/iDCj0c/tITawyiQmdRiB20U3/0ROZY7PJ8sVng6EDF+oVnqY3MU1S3CQk0kFoaVg9o0t8+zm/CGSEcj9LStLZlvnRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iD+ydLmx; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iD+ydLmx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775910441; x=1807446441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qmTG0sPt0gGADnHCwpgCA4OgO6l5QwLO2uOUdGQmqhQ=;
  b=iD+ydLmxUeEnuI3sz6PPaVm0+CmOcSci9XpHcPE/zUCm+ww3tFZ9VBJM
   iKvs/1jQn5euT/Flk8OsSStb/NjCQufI3rupPybPtd52hzS0fZ1oKI5Q3
   hvF+y3ScsTp6kTuURucDmX69F9HjDk35BPnI+ibwqKScUL/U2B4y7LOsa
   aIRk7/asGfV2Jh/HNEB0RkiAg2eMMLPy2KzuWNLndpTgD5X9Vujb1qojM
   Qp9HZrpwIKbMq8u3E6ScXmScdb3r4Nk0zCXHVtwLnPD3p3nqooM0mW/uC
   rYDGcfrrGqjwU3sizNx9ROKR3uEm3vnw+EuYC3CfdVOZCnOZYbOXAGbu1
   w==;
X-CSE-ConnectionGUID: gyyuNbzmTumUd0VqhYRh+Q==
X-CSE-MsgGUID: lf9PmdxbSmuTiR8KoEYHkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="77027404"
X-IronPort-AV: E=Sophos;i="6.23,173,1770624000"; 
   d="scan'208";a="77027404"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2026 05:27:20 -0700
X-CSE-ConnectionGUID: ntWZk1AxR0OVmCiWxzGylw==
X-CSE-MsgGUID: TKt1l8TtQgyU/6IITjirJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,173,1770624000"; 
   d="scan'208";a="224610713"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by fmviesa006.fm.intel.com with ESMTP; 11 Apr 2026 05:27:19 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wBXQj-00000000B4b-0IMg;
	Sat, 11 Apr 2026 12:27:17 +0000
Date: Sat, 11 Apr 2026 14:26:28 +0200
From: kernel test robot <lkp@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Steffen Eiden <seiden@linux.ibm.com>,
	Alex Williamson <alex.williamson@nvidia.com>
Subject: Re: [PATCH 3/3] KVM, vfio: remove symbol_get(kvm_put_kvm) from vfio
Message-ID: <202604111413.JR4rqpIv-lkp@intel.com>
References: <20260407180107.1603697-4-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407180107.1603697-4-pbonzini@redhat.com>

Hi Paolo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on awilliam-vfio/for-linus]
[also build test WARNING on kvm/queue kvm/next linus/master v7.0-rc7 next-20260410]
[cannot apply to awilliam-vfio/next kvm/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Bonzini/VFIO-take-reference-to-the-KVM-module/20260411-044838
base:   https://github.com/awilliam/linux-vfio.git for-linus
patch link:    https://lore.kernel.org/r/20260407180107.1603697-4-pbonzini%40redhat.com
patch subject: [PATCH 3/3] KVM, vfio: remove symbol_get(kvm_put_kvm) from vfio
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260411/202604111413.JR4rqpIv-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260411/202604111413.JR4rqpIv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604111413.JR4rqpIv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/vfio/vfio_main.c:1517 function parameter 'kvm_module' not described in 'vfio_file_set_kvm'
>> Warning: drivers/vfio/vfio_main.c:1517 function parameter 'kvm_module' not described in 'vfio_file_set_kvm'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
