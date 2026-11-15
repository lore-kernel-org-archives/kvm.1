Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794755914;
	b=EISbxGLaPVjDG881M3berAsx4nJrcYDZ5d0BD9Q02SmMcXd0yphWYEGSRDxIhtO2YMUs
	 v2AbRTMcp7cmyyOK7IwgQI8OViA7qjfKLmeqCJPW2hMAPWHPFkuacNBf+tn9aDyxIall0
	 uss2Q5CZtid5V556fS47Cf4gaEJFsLKpj4VWND8lhI3fzaEzqsORHStDJ2vs61kkF/gIH
	 J5IQVjl3zIoE7FDfM6m7MS21xQj6WEmqyxsk1rsuvGdEaBLaDVHSpmlz70X1+ET1Fy+dy
	 MHxQWHTBVx7ZMVrOjp75AXtpbbNJZ0f2II0BOik1mzznJnaXtSeT2jaZCnyuTAKQyqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794755914;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=k5Qp03CAQ8BatLGqMbyRg2JVFKmiz6vka1EtIHQp7Pc=;
	b=tmGF7nKTk+7PbxiNHZ2bLqS6WAlYRRZgygKLEnLAwPr63kqKoMIXTtuTfzTXRCDtaZKa
	 C2pWz6sSKU4CEhbTVcVV8WePOueHi2e3knTY+a67AKA5A6zWgejrFv2r7PMQa+YpcVhzh
	 2UOvlkgZ8t0Eqtrt/7trE7i6Y41i47JZsA+s7jx+JqBJlrcXaqsDxPnt7Ijfx9ZfFOLh7
	 W94s1/n0vAW39Z7nAj40K+RkQA2ScwcgFQmioUuE3xiRPDQvUfFE2Rgqv2fnfN5ACS+qT
	 qHrEO/QCS4lCS9DHmeRh1pX53RbiR34Av5Zc/ZWl8fgM5cqxTMNurSf+0JHKfHaO+pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=axmlKbHD;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA37606A31D
	for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 15:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFA37606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=axmlKbHD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794755913; x=1826291913;
  h=date:from:to:cc:subject:message-id;
  bh=3PUFe8lGfmRoHU6PGkmQY4a6erVkVN1VaPEhG8iDapw=;
  b=axmlKbHDOf0dcOY3r8i6Kv030nNQuUmv/V72u8XvN/L8owk2DK5NKmhA
   mwP4zFtY1sMC8NuwZhXZ07HfTeT7SqUJTagCUI2FgJMCRxvGhIs+H/xUG
   igd9ycZ7qQGrvCQjVYx+eiYzPeasUWfgX0dGOxGxAjlCqfD4IqOGV8wsn
   6ou1ZSyMLCdCLd8YcC7rCFITqb/20pbDC588vZWJmzoG3f3qtNG29wFmE
   tcDvgVB+bszfZVfGwIpp5xuxb7c4mveRl9ub+JpNf9Qeq1oK19xLbVffT
   /8S9mucW8DhalUjL+PTQMWqwPITcnuOXpgZy4kVe26Pwf+7TzNEP6hW1t
   A==;
X-CSE-ConnectionGUID: 94lalwvwQD2fhFyG1Vd/sw==
X-CSE-MsgGUID: 6ThLRiTRQBq/B0GLamJgFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3493283"
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="3493283"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 07:18:33 -0800
X-CSE-ConnectionGUID: hgYGchmpSnufnt+cFIY40w==
X-CSE-MsgGUID: jj27NBEsSLeFx0dPrFBjNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="9500856"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 15 Nov 2026 07:18:21 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xSbzm-000000016yq-2Hw2;
	Sun, 15 Nov 2026 15:18:18 +0000
Date: Sun, 15 Nov 2026 23:17:25 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 kvm@vger.kernel.org, Farrah Chen <farrah.chen@intel.com>
Subject: [kvm:kvm-memprot-v4 32/54] arch/loongarch/kvm/vcpu.c:167:53:
 error: expected ')'
Message-ID: <202611152311.FOhXX4Pi-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

tree:   https://git.kernel.org/pub/scm/virt/kvm/kvm.git kvm-memprot-v4
head:   e71c4e83c03926c300f6c43e79b783d47ba8b588
commit: 494d2885086430d3eb267af6aaf35093e2ba78db [32/54] KVM: Introduce kvm_check_gen()/kvm_memslots_check_gen()
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20261115/202611152311.FOhXX4Pi-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261115/202611152311.FOhXX4Pi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611152311.FOhXX4Pi-lkp@intel.com/

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
