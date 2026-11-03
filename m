Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793729247;
	b=P9LKuYXqjoqcHHqie8uOFKXYpJkqtvFMoHwogj8wwlW4fZV/GeQR8BxNCpifekV29V5c
	 P8dM4XOzZYhEZtMg44KwZripaRN9MgjLcJrX+OUETTmoI1pBgN1ACC8NvcfSP9xZQTb/t
	 6Ftzy2NgLy/by9eVite/MNts418yOr7bHJ/KzaKKF5zz1edjmcY+hFSyCEgz1LJzLmuD1
	 0EZf1jOxqTvIlsqL/Njq27D3UIlUIHO9iPBeAZzIHt5DdSZ5fOvcCfr8r8wp0HfIrLKdb
	 5KKGHoPJR1rTU8r1Swab/+GWCHOBjuVg/KhPkvKA9EwuHymTjl5Stz3p7CaduFEnedA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729247;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=zK/MHfvWSgBGdmyh4OG7p06HHkO8iMce8c9q7NLU0+E=;
	b=v3Bl87wOBr5iMKpz01Hsd65n5t0Th9wuigaXARK3vYCLX/EYpHBhJTMjRXTJl3dyohCc
	 Ept5GmvuLBMhiRQLGTj1ifTxrE2hkISQZdj3ml5izVgTHMBvldPD3qR5s9+afOoCUV3MD
	 /NR0Cb/Mo+NUGhQ2A4x8Djipx6LfGw2D7O6zIKIhZefSgn2e9wwDOit+9sdRhFyGK1fNi
	 b1oc7fRFLts9Hcn9er7DGLSpskV/lW+iKEwAeSVXU52Y1TbGJSpH3lKfd14qyD/is90LG
	 cEHw7hdjJPzr0D6fv+/PNEhM5eMUpCCypyHK58iqhQkiJD/xbOVslPS0La3gDapyVkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F5o7VD9W;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E04606A32F;
	Tue,  3 Nov 2026 18:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1E04606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F5o7VD9W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793729246; x=1825265246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b64n/ALy9ONkgf58cbPGHTwkxpkalkyb2b0ByEQyLoY=;
  b=F5o7VD9Wuq7AuNCiHZbvb9znmI3oqNgxzilz9qLCfjF4sVFXyhNwHdFJ
   T0DsoRVVr5vpMq4367xcrJUaFUWHRLvHJG9jL9E1tpNzQ2a1s34f0kYVa
   Q0RvTCSazRZrc3gBBFg+tjZzGWtwkj23CWF1GslSc+2CO48wrPn6jklNE
   x0pKd5P5g8GzKL3DETaAQHIrIWnkgK0Z1ub2805o5h0GjyenObpAMELFP
   1Mr6PsGd4tMIvraYAM2UlOZpcPh4jO01CO9+QpRzFqlX6SvkhsGpfnxO+
   fKO54miWyFzRyaAU1pUr5V1T8ASSyPSI2RLp6TT1ynG0T6vCNVLiKtJpM
   g==;
X-CSE-ConnectionGUID: aa1tNM9fQR+aybWBhV5OOg==
X-CSE-MsgGUID: iQwIrZ/aSK6guoNX8m5zrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2478666"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2478666"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 10:07:26 -0800
X-CSE-ConnectionGUID: smG6AWmqT/KMhf5xtzl5sQ==
X-CSE-MsgGUID: FFMi16GtTlixeZXBGVCi4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6643639"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 03 Nov 2026 10:07:24 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOIun-00000000j71-0RuF;
	Tue, 03 Nov 2026 18:07:21 +0000
Date: Wed, 4 Nov 2026 02:07:17 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: Re: [PATCH 23/45] KVM: Introduce
 kvm_check_gen()/kvm_memslots_check_gen()
Message-ID: <202611040108.LHPSqkKE-lkp@intel.com>
References: <20261102174512.8903-7-pbonzini@redhat.com>
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
In-Reply-To: <20261102174512.8903-7-pbonzini@redhat.com>

Hi Paolo,

kernel test robot noticed the following build errors:

[auto build test ERROR on kvm/queue]
[also build test ERROR on kvm/next linus/master next-20261030]
[cannot apply to mst-vhost/linux-next kvm/linux-next v7.3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Paolo-Bonzini/KVM-nVMX-nSVM-check-unconditionally-whether-CR3-is-valid/20261102-124045
base:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git queue
patch link:    https://lore.kernel.org/r/20261102174512.8903-7-pbonzini%40redhat.com
patch subject: [PATCH 23/45] KVM: Introduce kvm_check_gen()/kvm_memslots_check_gen()
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20261104/202611040108.LHPSqkKE-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 65303e81f481bbfe386b8596423f94c43198ba94)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261104/202611040108.LHPSqkKE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611040108.LHPSqkKE-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/loongarch/kvm/vcpu.c:167:53: error: expected ')'
     167 |                      kvm_is_error_hva(ghc->hva) || !ghc->memslot) {
         |                                                                   ^
   arch/loongarch/kvm/vcpu.c:166:5: note: to match this '('
     166 |         if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->generation) || gpa != ghc->gpa ||
         |            ^
   arch/loongarch/kvm/vcpu.c:1821:53: error: expected ')'
    1821 |                      kvm_is_error_hva(ghc->hva) || !ghc->memslot) {
         |                                                                   ^
   arch/loongarch/kvm/vcpu.c:1820:5: note: to match this '('
    1820 |         if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->generation) || gpa != ghc->gpa ||
         |            ^
   2 errors generated.


vim +167 arch/loongarch/kvm/vcpu.c

   151	
   152	static void kvm_update_stolen_time(struct kvm_vcpu *vcpu)
   153	{
   154		u32 version;
   155		u64 steal;
   156		gpa_t gpa;
   157		struct kvm_steal_time __user *st;
   158		struct gfn_to_hva_cache *ghc;
   159	
   160		ghc = &vcpu->arch.st.cache;
   161		gpa = vcpu->arch.st.guest_addr;
   162		if (!(gpa & KVM_STEAL_PHYS_VALID))
   163			return;
   164	
   165		gpa &= KVM_STEAL_PHYS_MASK;
   166		if (unlikely(!kvm_check_gen(vcpu->kvm, ghc->generation) || gpa != ghc->gpa ||
 > 167			     kvm_is_error_hva(ghc->hva) || !ghc->memslot) {
   168			if (kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, gpa, sizeof(*st))) {
   169				ghc->gpa = INVALID_GPA;
   170				return;
   171			}
   172		}
   173	
   174		st = (struct kvm_steal_time __user *)ghc->hva;
   175		if (kvm_guest_has_pv_feature(vcpu, KVM_FEATURE_PREEMPT)) {
   176			unsafe_put_user(0, &st->preempted, out);
   177			vcpu->arch.st.preempted = 0;
   178		}
   179	
   180		unsafe_get_user(version, &st->version, out);
   181		if (version & 1)
   182			version += 1; /* first time write, random junk */
   183	
   184		version += 1;
   185		unsafe_put_user(version, &st->version, out);
   186		smp_wmb();
   187	
   188		unsafe_get_user(steal, &st->steal, out);
   189		steal += current->sched_info.run_delay - vcpu->arch.st.last_steal;
   190		vcpu->arch.st.last_steal = current->sched_info.run_delay;
   191		unsafe_put_user(steal, &st->steal, out);
   192	
   193		smp_wmb();
   194		version += 1;
   195		unsafe_put_user(version, &st->version, out);
   196	out:
   197		mark_page_dirty_in_slot(vcpu->kvm, ghc->memslot, gpa_to_gfn(ghc->gpa));
   198	}
   199	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
