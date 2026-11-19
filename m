Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795059637;
	b=w9SBl5iXNCq0/POCh5/8068218Q6TpFdIXt+qWBqQqAhp43fbCZbGeK2JhtCqIbjCMhH
	 7NCrdsveubmN+uUmPvIMVuAZMB7DkOXhWv48GjktS4oofUkYA3a0o4aZfhYX/Z0kKlOs8
	 lfsDIeVP21S2s/i4B1j0NPVq7I5+9R96/v+g1CpMYqIqHryQhfwXNw4ICIimuBGHSUx4S
	 nLlEqRRo5WmLieRAmi1T9LoTuufg1fnW3nT9/3CkV6bNVSVg6/UJEhOsTvjcnx8R+anye
	 HDt8Wah336f/Jw0lJ0Jw0/jsQx+e7BPH01847rma6BV17Y3/R8XbSmwT5jJBsbZvtHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795059637;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=NI0va50cDCKMHdfqKJQeS8LALWOya2PyFi/22nDA7R4=;
	b=f7Qi6+Dh/Hh0odsHlTX3r8qx/K8MXfeCT0Ijc2kpxaHBlr1GigIwnb7E5EZIu8KCvnAd
	 RgUUeArqC2no8iFicPG26Yv8ZHi1QmsNS1oqPhGsXqThSv2SbCpp4ykKiVQtLsvQnawO6
	 uLTjLsqMVVuClmPR11Rs2Zx86iDXakxemFOqssZs43Mj4sxQAFkyITsH0I5FFhh3U7a8Y
	 eppzCI23cvXRxTGTkCo0lAY9iceAnIXFikExYsKJ83jbb1olSHOvjhEsckHsfL7nfDZlW
	 sdCQdlhvvNRjtP1pJlG7qRYX/L3zv5t0qyWktpsHNX72V69yh0uR4T4IxH+ZS5s/xSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HrcvmuaE;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B1860A5BCD;
	Thu, 19 Nov 2026 03:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20B1860A5BCD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HrcvmuaE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795059636; x=1826595636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bIsDMXZZ/vjl+EXRlXLqewlTe/KOQScQ5HwofszCNrY=;
  b=HrcvmuaEOrAixQX3vBQqCgWbPM706eq2XTNt8ryRPe1ODxzPE0hH2U+Q
   xy7zuLXOhiNlmVKQ2k1rGJPELxoX5aXpjDTjJ8XvYAQbu1R4LY01KcOJN
   zlVIqdD6qXmpk07xc/tJ3+2K0nQ43xc9Poy83u5ezCZPw6W2aaebl6xGH
   5P4Mt5pPVrVcPCzjBNOYQMiMKhiUlnHLlvh/JMdm4m5A77oCEE+EdTlKi
   F2nh9QTkx3N0pcAb5CiaB3/5hbnIQfGJhEx3koDM+xfSzVLqiUVbHtmti
   1rL4byhpDVXuHWGvLTsmcV9Odj8M10gyQNOiPQPCJI9Fr8eS8sX0g60a+
   A==;
X-CSE-ConnectionGUID: USkRnsPASKa6lFYKRGyLxQ==
X-CSE-MsgGUID: AELUFf2lQDOxlwh29dQ/dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3815642"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3815642"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 19:40:36 -0800
X-CSE-ConnectionGUID: ec5JIMXARAOxobLn3/RyVQ==
X-CSE-MsgGUID: E+fGsanTSTaf0YBIbE1NhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10225183"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by orviesa003.jf.intel.com with ESMTP; 18 Nov 2026 19:40:32 -0800
Date: Thu, 19 Nov 2026 11:31:28 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>,
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"Gao, Chao" <chao.gao@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>,
	"Maloor, Kishen" <kishen.maloor@intel.com>
Subject: Re: [PATCH v5 1/6] x86/virt/tdx: Move TDH.SYS.CONFIG operations into
 a wrapper
Message-ID: <av5tkGyaCEuWdzyF@yilunxu-OptiPlex-7050>
References: <20261111-tdx-module-ext-v5-0-c74f764abc3d@linux.intel.com>
 <20261111-tdx-module-ext-v5-1-c74f764abc3d@linux.intel.com>
 <cbc0c92dba00c04fc538f40795c00f94c53d5bcf.camel@intel.com>
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
In-Reply-To: <cbc0c92dba00c04fc538f40795c00f94c53d5bcf.camel@intel.com>

On Wed, Nov 18, 2026 at 06:51:30PM +0000, Edgecombe, Rick P wrote:
> On Wed, 2026-11-11 at 11:48 +0800, Xu Yilun wrote:
> > TDH.SYS.CONFIG is currently not wrapped in a SEAMCALL wrapper because it
> > is not exposed to external callers (such as KVM), also because the
> > level of TDX ABI details needed to perform the call is low enough to
> > flow well with the calling code.
> > 
> > But as more configurations are being added to this SEAMCALL leaf, more
> > ABI details are leaked into the surrounding caller code, which decreases
> > the readability of the caller logic. The first case is that the Dynamic
> > PAMT (DPAMT) change [1] tweaks the R8 argument based on whether DPAMT is
> > supported by the loaded TDX module.
> > 
> > A follow-up case comes as the TDX architecture has evolved the ABI to
> > introduce new leaf versions. The host must select the version to call
> > based on what new features are supported by the loaded TDX module.
> 
> It is not totally clear to me what a leaf version is here. Like is it a new leaf
> or (as it actually is) a new variant of a single leaf.

How about:

 A follow-up case comes as the TDX architecture has introduced a new
 variant of TDH.SYS.CONFIG by adding a new leaf version for it. The
 host must ...

> 
> > 
> > Before the version selection makes the caller logic even messier, move
> > the register ABI operations into a wrapper.
> > 
> > The original changelog was written by hand. AI was used to help correct
> > grammatical errors and polish individual sentences for better
> > readability.
> 
> Looks good overall, but weren't we going to drop the AI blurb? Oh oops that was
> a comment on a different series:
> https://lore.kernel.org/lkml/03cdc774-7fef-4d0b-82f7-126288636f3d@intel.com/

Yeah I saw this thread. My reading was that this sentence "AI was used
under supervision to review code and workshop logs" is too broad to be
meaningful. I have cut this sentence for this version, but keep details
about how I use AI to refactor logs.

So can we conclude that if the AI usage is expected, then we don't write
it? In that case, yes I should drop it.
