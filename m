Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793681555;
	b=TTxQiDkNWNqKHsTRrDncO+prLnX+CeRPMNPlhIfdYe2wzrhdDO1mIGiC7fdVkyqWtPEJ
	 /h/6vW1rBJjWuAFG2eFb5SN5p2BK/hO2v4qTJQIauSRHJVM7TYiClXYVsR8Tf9gREJY6t
	 sa4fia1N/UxoGolF1Fz/xDAgBfdz6rdLgPzE98YaNZwYn9ThYC5kWfRk+nbPcwWj8UpCw
	 fRGQ+0oGIoR0m2PMC/sbJox6dL1IPnECpp17aIJPqmp5FHcVfHyqt800p1pMzXOerEJJ5
	 Jxfe92KrIUKnu/8H20lh8Ziqiiidv6pB6/RHgKl2OpE926Lcw+efV+IbP8duMuhlrSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793681555;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=34p6/q4mUiohDUq3YP/o+RtLUNRMezD/7unT8fjXWqs=;
	b=aZNcYfHenfXxmWB3fHTLpTTdLWnYv2dPYHBrAmXsC1pVLWEtpbFFnD+T7hyyEI5R0VHb
	 55QJ4ygsOXDBm/l0+qumPOEW9ecv60DZ3bKv1tfeQjE4PJfCQWrJL04OKpdmbJL7deD28
	 lsfc5QSkSazjqT+OjLXOvFHNIDotHOZfH58AzOhIMxfnj3U+lr+5ymz+U57gMTkH3MlQr
	 IpYyPLTqXAMg2qPTxrPQfCpVPl+iWlzuNGHTTuzLM6CaUP5R1zgje1ozb+200gYwgfc69
	 qXLkuQIFa1MgcP+uhFFZujgp1uQLWtN/XeBQ9LusWjjU5JefhI7y2HF8JYucwuaSLyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mh0L3Skv;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FBD606A326;
	Tue,  3 Nov 2026 04:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3FBD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mh0L3Skv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793681554; x=1825217554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=r+WZUoyk2WCPAmB29GrTF3vpV/Ii9qAichtjByshkXk=;
  b=Mh0L3SkvF+rk4XrXm7l0FahMCKcxURLLbRk5RlkoQX81txrRo0Q7sPKv
   loIJR9LRyOf7wDxTnIVq+nBDpnKFIA8WrjkSOdnTShHQpH81iZY6vHkcv
   09fKza2gyEyb/hlkXj1V6LyQFww+tWDu3c04zrwajQ0ZEjdAUhkaQIpei
   iqFtUPq+kGNGJaTEZcueXKqv/jm2h8mf2mFV3LSvsyUtv/DWAIYJQzfTT
   qQgA+S0CYY5A8K4OqDd0CfMMzQRfUnre4dzrJCYuXYg3QOv/snRv0Blsd
   MZqyYWWCWzLw2yL/FheDxauVuK51+wSCbGxqaF7Ri4hTeOFCPD6JliImm
   g==;
X-CSE-ConnectionGUID: JsukaCJvTYm0HtOhWAeXYg==
X-CSE-MsgGUID: im2z6ax1SlGiRvu6izoaTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2269712"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2269712"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 20:52:33 -0800
X-CSE-ConnectionGUID: b/1gL201RsWw53qtt2NzoA==
X-CSE-MsgGUID: ua1yMAqYQf6kZ1IShzMipg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6852594"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 02 Nov 2026 20:52:25 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xO6VS-00000000iJU-0Zcp;
	Tue, 03 Nov 2026 04:52:22 +0000
Date: Tue, 3 Nov 2026 12:51:34 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Michael Roth <michael.roth@amd.com>,
	Liam Merwick <liam.merwick@oracle.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Ninad Naik <ninadnaik07@gmail.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	coconut-svsm@lists.linux.dev, joro@8bytes.org
Subject: Re: [PATCH v3 4/8] KVM: SEV: Add direct VMSA capability
Message-ID: <202611031239.b4rFO1dx-lkp@intel.com>
References: <20261102114137.1198982-5-joro@8bytes.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261102114137.1198982-5-joro@8bytes.org>

Hi Jörg,

kernel test robot noticed the following build errors:

[auto build test ERROR on kvm/queue]
[also build test ERROR on kvm/next linus/master next-20261030]
[cannot apply to tip/x86/core mst-vhost/linux-next kvm/linux-next v7.3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/J-rg-R-del/KVM-SEV-Document-SNP-direct-VMSA-userspace-ABI/20261102-124130
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/20261102114137.1198982-5-joro%408bytes.org
patch subject: [PATCH v3 4/8] KVM: SEV: Add direct VMSA capability
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20261103/202611031239.b4rFO1dx-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261103/202611031239.b4rFO1dx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611031239.b4rFO1dx-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/kvm/svm/svm.c:5473:2: error: cannot jump from switch statement to this case label
    5473 |         default:
         |         ^
   arch/x86/kvm/svm/svm.c:5466:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
    5466 |                 guard(mutex)(&kvm->lock);
         |                 ^
   include/linux/cleanup.h:423:2: note: expanded from macro 'guard'
     423 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:303:3: note: expanded from macro 'CLASS'
     303 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:80:1: note: expanded from here
      80 | class_mutex_constructor
         | ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:86:1: note: expanded from here
      86 | __UNIQUE_ID_unlock_1239
         | ^
   arch/x86/kvm/svm/svm.c:5466:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
   include/linux/cleanup.h:423:15: note: expanded from macro 'guard'
     423 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:165:2: note: expanded from macro '__UNIQUE_ID'
     165 |         __PASTE(__UNIQUE_ID_,                                   \
         |         ^
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:74:1: note: expanded from here
      74 | __UNIQUE_ID_guard_1238
         | ^
   1 error generated.


vim +5473 arch/x86/kvm/svm/svm.c

  5456	
  5457	static int svm_enable_vm_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
  5458	{
  5459		switch (cap->cap) {
  5460	#ifdef CONFIG_KVM_AMD_SEV
  5461		case KVM_CAP_SNP_DIRECT_VMSA:
  5462			if (memchr_inv(cap->args, 0, sizeof(cap->args)) ||
  5463			    kvm->arch.vm_type != KVM_X86_SNP_VM)
  5464				return -EINVAL;
  5465	
  5466			guard(mutex)(&kvm->lock);
  5467			if (kvm->created_vcpus)
  5468				return -EINVAL;
  5469	
  5470			to_kvm_sev_info(kvm)->snp_direct_vmsa = true;
  5471			return 0;
  5472	#endif
> 5473		default:
  5474			return -EINVAL;
  5475		}
  5476	}
  5477	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
