Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3042B3EC82E;
	Wed, 29 Jul 2026 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344911; cv=none; b=fVIA5DaK4nXu0mTsj2ekbSJXYD0RsAIzHos2LmVkto1moIpMDvMmx6Si5FeXsKXyq81aUb0whllrUaidIhOCem/CchfPGht03oJf4rGuZ+3D5zQHkc2lq9/VvkdBFAJARNd3RE1ERse04wH2cr/UxpFPksjqEhD4/vVD9/zAhTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344911; c=relaxed/simple;
	bh=LnSPWfgKVTC9pQVgQ9cD/+XqciARJ0SfGX6CMjIESx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWIy4R7JMwl+brp8YOxQuWfN5GwgxKXc/zEdU6MC42R0gdPGKJw9mwrfKoMsI28VlBxMy/3Rs9iiVaJq6u3mQlNOfxGTrSJRL6H/scSwhSEpkHmF2oCj2OntDF3Ev+4qVMU5Tseraic8CpdUhk+jwUuHLAqSeBoxlHD9YOizXwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VIwfIfT7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VIwfIfT7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785344910; x=1816880910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LnSPWfgKVTC9pQVgQ9cD/+XqciARJ0SfGX6CMjIESx8=;
  b=VIwfIfT7ZJEDxbhj4xZD5+wZR9yTJKysdiQN2Li3BIvB3DN/EKK+YmwE
   yLQEdCCsvif2VXQ9havd+96IPD00YtKs/WTJBIeBLl89InZvc0mNVg5Te
   etRKVR2gEPhdp3ugUD7t4ri0Drvzk7JXm2kc8Z4qp65QiTb2pkccqDdUX
   mbDADMfg15MO2gj9eoMw5S51v0wN6Ye3s1KId8En6a8FtJ8umkM8Y8orz
   OGpk+V5lPCRUHps4EMoEbApKeOvqiLBnIDjb0aIQE8fZs9r93fcIMs0AV
   jbcjJwxgrTALxehAPF+/vku3E4iGiMWtjLMrdRG/JbORK9izcLhwCI/nO
   g==;
X-CSE-ConnectionGUID: d/T+BPSMQgGGGjs8YzBhuA==
X-CSE-MsgGUID: s4vIMGmjQjeUIBgVrHHOxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85995048"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="85995048"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 10:08:30 -0700
X-CSE-ConnectionGUID: //iNZg0MSgqG6gtkCAFQQg==
X-CSE-MsgGUID: Ky6UAgGkSkytuB99qgYbsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="264339287"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 29 Jul 2026 10:08:25 -0700
Date: Thu, 30 Jul 2026 01:08:24 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"tony.lindgren@linux.intel.com" <tony.lindgren@linux.intel.com>,
	"Xu, Yilun" <yilun.xu@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"Fang, Peter" <peter.fang@intel.com>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"djbw@kernel.org" <djbw@kernel.org>,
	"Maloor, Kishen" <kishen.maloor@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 03/17] x86/virt/tdx: Detect if the extensions
 initialization is required
Message-ID: <amoziNqNW3lfLJUA@yilunxu-OptiPlex-7050>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-4-yilun.xu@linux.intel.com>
 <cfeee0fe-c61d-447c-86bc-8d8244090879@intel.com>
 <amdRWaoKa0k324JM@yilunxu-OptiPlex-7050>
 <7611fe250925614d64f05cac8d398f54ee386583.camel@intel.com>
 <aml4cVnFkKvmJimj@yilunxu-OptiPlex-7050>
 <ce4c800ccce210e65aaf8432c0413a342f1765c9.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce4c800ccce210e65aaf8432c0413a342f1765c9.camel@intel.com>

> > But yes, a brief explaination of why we need special initialization is
> > good to me: A global service environment should be built to provide
> > some general context switching mechanism inside TDX module.
> 
> Wait are all extension seamcalls resumable? Couldn't there be one associated
> with an extension that is not?

All extension SEAMCALLs must be preemptible and resumable. If a SEAMCALL
doesn't need the ability, it is not backed by an extension. Note an
extension may only serve part of the functionalities of a feature, for
example, for TDX Connect, only SPDM related SEAMCALLs are extension
SEAMCALLs, others are not cause they have short or simple routines.

> We have so far explained extensions in terms of
> the TDX module needing more memory for the optional features. So "extension"
> probably be interpreted as "optional", not as enabling "preemptible" seamcalls.

This is a long story and is explained in cover-letter. The need for extra
memory is only a requirement to host, not the purpose for "extension".

Normal SEAMCALLs monopolize CPUs when execution. To prevent starving the
host, SEAMCALL developers must count instructions at compile time,
pre-define interrupt check-points and yield to host. This programming
mode for TDX module is so complex that is hardly possible to handle
complex tasks. As a result, TDX module had to push complexity into the
host, such as by fragmenting a protocol setup service into several
phases, let the host manage the overall flow and the SEAMCALLs only
handle the secure parts which are short routines...  This makes the
SEAMCALL ABIs trivial, losing their semantic meanings. While AMD only
calls a TIO_DEV_CONNECT and let its co-processor manage the whole thing.

A preemptible SEAMCALL behaves like an OS task, so a specific SEAMCALL
developer could easily handle a complex routine, without caring about
starving the host. A general underlying service environment is taking
care of the hardware interrupt response, the context switch...

So IMHO a normal SEAMCALL may be called 'resumable' to some extent, but
it is definitely not 'preemptible', it voluntarily yields. That's also
why I think "preemptible SEAMCALLs" natually explain things than
"extension SEAMCALLs"

[...]

> > ----8<----
> > 
> >   TDX adds a new class of SEAMCALLs which are preemptible and can cooperate
> >   with the host scheduling. 
> 
> But these are not new is the point. Look for TDX_INTERRUPTED_RESUMABLE in Linux
> and TDX source.

From host perspective, extension SEAMCALLs are just like normal
'resumable' SEAMCALLs. But the mechanism is new, and we have to explain
the differences, otherwise there is no justification why we introduce
the extensions.

> 
> > Some features like TDISP, DICE-based quoting
> >   rely on these preemptible SEAMCALLs to implement higher order security
> >   protocols with simple ABIs. To enable preemptible SEAMCALLs, a global
> >   service environment, called TDX module extensions, must first be
> >   initialized.
> 
> Why are we even talking about this in a patch that reads the metadata. Is it
> necessary?

OK, I can drop the introduction of the context here, it is not
necessary. The cover-letter has the detailed explanation.

But should we still add the introduction in patch 5 ("x86/virt/tdx: Make
TDX module initialize the extensions")?
