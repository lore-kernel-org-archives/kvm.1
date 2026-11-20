Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168706;
	b=HIiOzY3sk4TGKrrqa8dNJtIaSXXw5vty7L9XUlHPICcVbe2LKqsgg8Q2RKlVnmyg4HWr
	 VntEAqdqvapOpqXUgfnrhTQ0hVyW7fXVMxMkx6tFPvOeAekgQoNzAaXOiFbfP1lOZ7+ix
	 5TFfmjNGjeDC+vCye8hT3rWlG785nfxYthG8fSMtf2BxKpBzgyHJLnhE8AiRjRbsmPUUD
	 PCbAqheS9uh2kk/9vKzQkleckTMf1eDGN7Wvfv+HrtcR64ZdSCiykrRe0sjhU7YsZRq03
	 Z8f+a78lurDMM0fz82ASkJCGQx4Kxg1ysgymuVcC1kXoSpEZP0j3QKKGepcj217fiVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168706;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=TN8NkqYXPqqaP4HiWogaPI2uV4tpxwPQMmBsUcR390A=;
	b=mYF+4djU59spNtRPt/EwlK/xuwpl3seVnWhpAG0kasujhtXC+pl3u6sY/rJkzPNsgI5Z
	 Qcd/hKlYhZ3m3qs83ixf/JoE5sPIvZIRjA7ZZm2AIFXsUF6ZAWWHSO8FdsEAx05toYuiw
	 nXkMrgAgEIDtoXjmxwj3RA1Sm2AJkem1G2PBIHLAOinueIwbpFwfPRVB2QMrlpuueh+ZO
	 /vH+BS0b8n0dTsZsMnmBe/o075eigw7HsLEe+Gz9q921Jobn7DwyaCkMooACw6oh0+5+b
	 gao6nlp6/+xkkh2ivqFiSEU+CRrP/ja9ggHkzLMpR2ZzAT37UfHsJ0ag03L/E+Hm/Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="liYEAsq/";
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3140606A33E
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 09:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3140606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=liYEAsq/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795168706; x=1826704706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VqfWWyNKP41xggbE8G4O+U9tuF1EbfzC3ALH58eUH8E=;
  b=liYEAsq/W0sDy4yJVa/l5lo5zDAppkErx9e0VuFTvwNmfLeYKiGq1wlX
   lYlkv2aU609IBVtpJGep2BbzokfAF0kIN/WR5jAIyAYPe0CpWYf+bJTmJ
   pI3f0+qCpL4RYXVKWWZTVsUoS3cpdtAZI/wN4SAFAotRoFRL3EFgoFiGG
   Q3U9OOQKeHyqKGaWEnrG3SWsiFe6aK1ohThIO94XKAc5XLD/iyjPKtKxU
   mlj7/7cvwLx9l0J8nsWR63dELUM7f+aNXnhSntfrJrwMOmnJDn8ToKiBQ
   kgg+W7XV+VOwjfANexF/1Bk5Dvz20C+A3FRSf+BFejUlaOJWPAZtke5MF
   A==;
X-CSE-ConnectionGUID: tjf0AGeATFynlFjgKyKyWg==
X-CSE-MsgGUID: nqif8w4cSISXVYfgTB3gzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4052250"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4052250"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:58:26 -0800
X-CSE-ConnectionGUID: vh4oHUzHSYqdJIcu7sa0SQ==
X-CSE-MsgGUID: BBkncL18Qvi715stShz4RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10605541"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.112.226.173])
  by orviesa007.jf.intel.com with ESMTP; 20 Nov 2026 01:58:24 -0800
Date: Fri, 20 Nov 2026 17:58:23 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] i386/cpu: mark CPU properties as const
Message-ID: <awAZv3AsmNdJ7oUW@intel.com>
References: <20261119180859.1044425-1-jsnow@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261119180859.1044425-1-jsnow@redhat.com>

Hi John,

On Thu, Nov 19, 2026 at 01:08:59PM -0500, John Snow wrote:
> Date: Thu, 19 Nov 2026 13:08:59 -0500
> From: John Snow <jsnow@redhat.com>
> Subject: [PATCH] i386/cpu: mark CPU properties as const
> 
> Currently, these large property tables are loaded in the read-write
> `.data` segment; by marking them as const they can be loaded as part
> of `.rodata` instead, where these tables can be shared between multiple
> instances of QEMU as RssFile memory instead of RssAnon memory.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  target/i386/cpu-internal.h |  2 +-
>  target/i386/cpu-system.c   |  2 +-
>  target/i386/cpu.c          | 30 +++++++++++++++---------------
>  target/i386/kvm/tdx.c      |  2 +-
>  4 files changed, 18 insertions(+), 18 deletions(-)

I'm fine with the "const" change, but it seems only
cpuid2_cache_descriptors can move to .rodata:

$ objdump -t build/libqemu-x86_64-softmmu.a.p/target_i386_cpu.c.o | grep -wE 'feature_word_info|cpuid2_cache_descriptors|epyc_v5_cache_info|epyc_v4_cache_info'
0000000000005fa0 l     O .data.rel.ro.local     0000000000000020 epyc_v4_cache_info
0000000000005f80 l     O .data.rel.ro.local     0000000000000020 epyc_v5_cache_info
0000000000000d20 g     O .rodata        0000000000001284 cpuid2_cache_descriptors
00000000000060a0 g     O .data.rel.ro.local     0000000000006a80 feature_word_info

I think it's because FeatureWordInfo and CPUCaches have pointer fields.

So with the commit message fixed:

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

...

Futhermore, for CPUCaches, it could embed the cache info by value:

typedef struct CPUCaches {
    CPUCacheInfo l1d_cache;
    CPUCacheInfo l1i_cache;
    CPUCacheInfo l2_cache;
    CPUCacheInfo l3_cache;
} CPUCaches;

although the cache info will be stored in .rodata, this would also give
each vCPU its own copy, so smp-cache would no longer modify the global
tables. The cost is that CPUX86State grows per vCPU (from 4 pointers to
4 full CPUCacheInfo). So, maybe there¡¯s room for further optimization,
but that¡¯s a separate issue, not a blocker for this patch.

For FeatureWordInfo, what I can think of right now is to make the
feature name array a fixed length like:

#define FEAT_NAME_SIZE 36   /* strlen("vmx-invept-single-context-noglobals") + 1 */

typedef struct FeatureWordInfo {
    FeatureWordType type;
    char feat_names[64][FEAT_NAME_SIZE];
    ...
} FeatureWordInfo;

Thanks,
Zhao

