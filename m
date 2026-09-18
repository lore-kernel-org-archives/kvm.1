Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B026C369217;
	Fri, 18 Sep 2026 05:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789709916; cv=none; b=ZR94eHSGmDvQfX5VPx9grfwjWXPTwAVP4qpMStGA7W+DUuV6RYVB6G/1K6nEOW9+qIZvMdDwNavxRbok6Vcw5+5ZiUV9BZQ0agTvxqIRvX4Icm2KaaOFOLukgjOcUFJST48QvbNiLU4BpZmuy6RnRfcwoTgbla2o5OOGDNc6uIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789709916; c=relaxed/simple;
	bh=t2ClplML9zkcPCXZKC8gHHRapTDjWXKKbzD2Gn6eQVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmGV5xCxs9oM6c+P9PlXiLstrTMZ5Np/jyy5qHua9wCE8012iQ6BsoKx14XpaqaM39GD3+AUxkSBxF1MipPj0ndLBsHPoIjVTTI84Z4x5+EPq6jqyrCj4E47A5+8QZEfRnMDuFIHAPHzonqZR/stFXUS4PvTXZJ/nxko0XCdlSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JYzdrC0o; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JYzdrC0o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789709914; x=1821245914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=t2ClplML9zkcPCXZKC8gHHRapTDjWXKKbzD2Gn6eQVc=;
  b=JYzdrC0o3ZvIgTWXGUlCbsk9OgiDl2pXs+mVU5Ucu0A7MFne2xJtKy/Y
   GIcrwizOUdLqBsG7ohcdfwPMxBzvkWgC+i/+Og5Zq8jWWJ8490kN3lI/P
   himhQGzkU64IiGa1uh7cuIK09s9rfECXM6kDQGkIvczsa9kuZFKzbvO0w
   iKMeRCtiL6Mea3n/DLs4sLaBHzqxh9BuwVblRBxLnBTkb//114OkGdkus
   4anELqby0PGJJA4WWbV8Abj6tIQhzMLcHMbapOGRoWjgdHr5UAzQ1q+G6
   9TwgWC77AzjtCG4y9HsllrCKPRHnEF1/KlcHxsvPJr+XacPWjWBjktSTr
   A==;
X-CSE-ConnectionGUID: p6FI4CZ+TfuUylvgn2plaw==
X-CSE-MsgGUID: /KLxcZ5eQlOxnsaY5AMAgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="94024578"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="94024578"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 22:38:33 -0700
X-CSE-ConnectionGUID: hOPFj521SaCpoVOQSvCFZA==
X-CSE-MsgGUID: PAqmF9ZgRZKu1G5YeZANdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="271550870"
Received: from wgawrons-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.112])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 22:38:28 -0700
Date: Fri, 18 Sep 2026 08:38:25 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Michael Roth <michael.roth@amd.com>,
	Liam Merwick <liam.merwick@oracle.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Ninad Naik <ninadnaik07@gmail.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	kvm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	coconut-svsm@lists.linux.dev
Subject: Re: [PATCH v2 6/8] KVM: SEV: Add SNP vCPU state get and set commands
Message-ID: <aqzOUb1m-v-kG5v-@tlindgre-MOBL1>
References: <20260908103338.427254-1-joro@8bytes.org>
 <20260908103338.427254-7-joro@8bytes.org>
 <aqksXLLcmFDkM9Xj@tlindgre-MOBL1>
 <aqrDUgB7nfdgzXpQ@8bytes.org>
 <aquIYzwDOx6jzy3T@tlindgre-MOBL1>
 <aqv-FtT1v1FjDZJD@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqv-FtT1v1FjDZJD@8bytes.org>

On Thu, Sep 17, 2026 at 04:59:37PM +0200, Jörg Rödel wrote:
> Hi Tony,
> 
> On Thu, Sep 17, 2026 at 09:27:47AM +0300, Tony Lindgren wrote:
> > Oh OK, so calling for both hypervisor and confidential VCPU state would be
> > needed. The difference could be specified in the struct kvm_vcpu_transfer
> > flags?
> 
> Or hypervisor state is migrated outside of the CVM live migration interface? From QEMUs
> perspective it is not different to other state like for emulated devices and
> such. Does TDX also have per-cpu hypervisor state that needs to be migrated?
>
> In any case, for SNP this state must be settable from QEMU to correctly support
> IGVM loading, so an interface outside of live migration is needed :)

Oh OK so the per-cpu hypervisor state is part of the IGVM loading.

Yes the per-vcpu migration is a bit different for TDX. No two separate
steps like you're describing for vCPU migration (per-cpu for vCPU
registers and per-cpu for hypervisor state).

After stopping the TDX source, the VM state is migrated. And then the
per-cpu state. The per-vcpu state is just a QEMU VMState for TDX too,
and it needs the help of KVM to export the state into an encrypted blob.
