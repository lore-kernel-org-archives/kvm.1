Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794288102;
	b=ijCR3hZo8ZYpuvQl2ti7iMq6KMTH+X+bwV176QrnJzWkeWgY3qHu5acJwe2Mu0Mor8cy
	 Y343BBjqelIo9Rtkf52Sz2S/7B9yDp5vKTs76+W+4LaRSHmWGr6aL727Hi3GfciJ5bHGN
	 DY1qBdkGFAdKMvQE5LxnSp4s9Z9DkQ1hhiWjYwRfyreneJq51+7hHPhWLAhgJbHlyJGqt
	 A3oVDFCodC55J8UEXFfjwIZEhC8rr42XLaQfhfaQ7q6oL3nThGVOxOe6n2ALQZVdn9Wp3
	 9kU5YTwUy2RpTDbMl7ktdai8fYe0RvQJlMzuZAQOn5zvPO0/qMJjsfVwvdoHs9RvZZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794288102;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Pecfb5pvLyq9H2GzGT0xx4/rfb25RsEuISA7EJYskG4=;
	b=piE4rEWQDwZHoGCk5ugs6JJ3eQTFeVY3ZmYQmgJLt4qxrYH/D/p6h5lxDAF+gmUzQbxb
	 y4KmMdcf7gQu5GvA/RGBYjdQJSWKhNq4x2JNposydUvLQS9sp/5qyvDieENn0eChIlzLv
	 0pmKxV5klKA1DgTlbNLQtJWbeEW4fj4R/544LqHrcCpovYxPOSWkCXYY65np7EQJNNJNt
	 zOG9qyIFmskx4nAKIggM14uJkzAwe9XFQbZdDk2goHHwg5Rf3b/uaAmuw8f0ssDe7Dpoo
	 zIEb/sfixL4MW0bttrKfBAf+7Ap/HyuFCbBv509oiIkh4QyQvw28yucRdvcW7Z8TzLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bWB0j+MK;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C1A606A31C;
	Tue, 10 Nov 2026 05:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45C1A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bWB0j+MK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794288102; x=1825824102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oFY/jbHuyFVs9fcim3O79B+sKqlAAqnVh+aV2N/0ovY=;
  b=bWB0j+MKIBWCSDbnAB1Ok5OJ8fBOIsCJRzpg8d3ShztfzT6hlfJJZ4hy
   97+/td/vHspcKPduRnMGwStMxHQ+AZz77Klmy9M10xvTzLEMmM2ns6uEr
   a/x3vSRLGPH6LE1u9NSPJQtbiz2h5nQ2M0TtrAdph71Qen4Tjebfz2gjz
   BEyyR27fHaKM0EBGweJRabDcqet58PoxazrGrearUVJ7lwnqGPScy5TkU
   chN8fws9Hpe6YIMd6h1dBbMoEk+KpSwmYPqntXiY6/LXzXrMXkSe5pJ72
   GBMVpgvu4jyYvJhyHK8IvKoGLjO8k7vyBGANXHGzejwDwGmMQMy0zrs0C
   Q==;
X-CSE-ConnectionGUID: uMY+Ddy3S2K8gjbt268AyQ==
X-CSE-MsgGUID: rK2FYPk3RjuE3MVFEVB+AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3062304"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3062304"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 21:21:41 -0800
X-CSE-ConnectionGUID: RKv6GKLrRXekh8Hyw1NSow==
X-CSE-MsgGUID: B2DoDwPBT2ynDzLgYC0JmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8233683"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 Nov 2026 21:21:34 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xQeIV-00000000w43-0oq1;
	Tue, 10 Nov 2026 05:21:31 +0000
Date: Tue, 10 Nov 2026 13:21:04 +0800
From: kernel test robot <lkp@intel.com>
To: David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	xen-devel@lists.xenproject.org, x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paul Durrant <paul@xen.org>, Vitaly Kuznetsov <vkuznets@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Sascha Bischoff <Sascha.Bischoff@arm.com>,
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Jack Allister <jalliste@amazon.com>,
	Dongli Zhang <dongli.zhang@oracle.com>, joe.jin@oracle.com,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH v12 08/24] KVM: x86: Re-synchronize TSC after
 KVM_SET_TSC_KHZ
Message-ID: <202611101323.6WZgh2FM-lkp@intel.com>
References: <20261109012112.3415328-9-dwmw2@infradead.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109012112.3415328-9-dwmw2@infradead.org>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on dea4f6380f4ec96e8f3b0aaf2343764bd0d25ef4]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Woodhouse/KVM-x86-Improve-synchronization-in-kvm_synchronize_tsc/20261108-172047
base:   dea4f6380f4ec96e8f3b0aaf2343764bd0d25ef4
patch link:    https://lore.kernel.org/r/20261109012112.3415328-9-dwmw2%40infradead.org
patch subject: [PATCH v12 08/24] KVM: x86: Re-synchronize TSC after KVM_SET_TSC_KHZ
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20261110/202611101323.6WZgh2FM-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261110/202611101323.6WZgh2FM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611101323.6WZgh2FM-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: arch/x86/kvm/kvm.ko: symbol '__udivdi3' undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
