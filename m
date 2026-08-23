Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC18367291
	for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787475307; cv=none; b=ouwIjkZ9UdqoUkupGHPFFCU9cpfJr2R+EPAobMkmvzDXtnoQ2cOyENI4qyNDMV1J7bMN3V1NdEUy5xV3DN3ap4C75/BOPFIPNmhSnobRQ8io6cS57Vymvcgs/TpR9eRhzSdmC6jisrwmMMRkibJ343yCKvBLIPTl+u8cDVNFD6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787475307; c=relaxed/simple;
	bh=n6VFAnBXcNjuJGOFr6OMzXoYlpDVurWKsqexkPLYQRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOVYaIK7cICGz1M079mB0wsfM03vR0XTG+3QCBsR/YcGzAbIX6yIJ8wdljrQsI5MJ2RftVMqLyn4TFgLhvmLTxGKARgv0S1HJAsOhBoew/kgCXl9Mzt+2gTUKP5xvtfHBFbYRZyWsBkcFmok1TqyOw7Pnfha+619Syy/EgIaNE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=clZVYXIv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="clZVYXIv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787475306; x=1819011306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n6VFAnBXcNjuJGOFr6OMzXoYlpDVurWKsqexkPLYQRk=;
  b=clZVYXIvgLZGagORSYW1JshX2pm18Ll0l/yl9xGCSAMYjL4FAbcI2rWD
   lh6aMBBIq+Xz3JD2StRn3ZH+qfRbPRTDLoafYf6UN60+17cbnbu3rMq7Q
   IdOcl9LIWxYRY8/khency8/0+/IMkUjon7B6diZeNYZ+VZ8vdf8BhWlb+
   pT3Nhys2WhGonnCYablthf7J7+ClPodoeFhiaaD8GSqYWaaWgy7QU7FZn
   bN7mYnbRB3BPKTM/ne8qdLvuM/JUYCnlxSvt+fX3jrzHiaGoV4Q1jp2R0
   KIKrrAf8mh3aFctDFyxUUVDKw064C4U9DYcrfv4CQy8KKS3mqGr3Gf8sf
   Q==;
X-CSE-ConnectionGUID: Re2oQG+IR0ytrh/+Tcu7SA==
X-CSE-MsgGUID: 3XmiDrTsT46plmCONmX0SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11883"; a="105333093"
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="105333093"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 01:55:04 -0700
X-CSE-ConnectionGUID: iMgrhqd9R864fBDPngSsuQ==
X-CSE-MsgGUID: sSqU5W35TuuxMPLjPDgbSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,238,1779174000"; 
   d="scan'208";a="263022686"
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by fmviesa010.fm.intel.com with ESMTP; 23 Aug 2026 01:55:02 -0700
Date: Sun, 23 Aug 2026 16:55:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>
Subject: Re: [PATCH v2 6/9] target/i386: Do not broadcast injected MCEs for
 Hygon
Message-ID: <aoq1ZT66amRjhuNa@intel.com>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
 <20260810082956.1768042-7-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810082956.1768042-7-zhang_wei@open-hieco.net>

On Mon, Aug 10, 2026 at 04:29:53PM +0800, Tina Zhang wrote:
> Date: Mon, 10 Aug 2026 16:29:53 +0800
> From: Tina Zhang <zhang_wei@open-hieco.net>
> Subject: [PATCH v2 6/9] target/i386: Do not broadcast injected MCEs for
>  Hygon
> X-Mailer: git-send-email 2.43.7
> 
> cpu_x86_support_mca_broadcast() excludes AMD CPUs because QEMU handles
> AMD injected MCEs as local machine checks, not as Intel-style broadcast
> MCEs.  Hygon Dhyana missed that exclusion: it is not an AMD vendor CPU
> and its family is greater than 6, so QEMU reported MCA broadcast
> support.
> 
> This affects QEMU's synthetic MCE injection paths.  KVM memory-failure
> injection uses this helper to decide whether to set MCE_INJECT_BROADCAST.
> HMP 'mce -b' uses it to decide whether a broadcast request is valid.
> With a multi-vCPU Dhyana guest, QEMU could fan out an injected MCE to
> secondary vCPUs and populate extra bank records.
> 
> Linux routes Hygon through the AMD MCE feature initialization path and
> does not use Intel/Zhaoxin LMCE broadcast handling for Hygon.  Do not
> advertise Intel-style MCA broadcast support for Hygon in QEMU's injected
> MCE paths.
> 
> This is limited to the MCE broadcast-support decision.  It does not claim
> that all Hygon MCE/MCA behavior is identical to AMD.
> 
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  target/i386/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

