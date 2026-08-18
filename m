Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFF33446A6;
	Tue, 18 Aug 2026 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081051; cv=none; b=WbEM/WqE/wXQxualfQzt1rNMnJ7KNYH4D6X9d105xVAeVBCN8flNNlSsizQPY6durWzmUWsY70hu3v+li8NAkSQ+9DgZrDU3FrJsE1sj8o9eMblTicpQ0WScr1lm+WdtsNQd4LzLr1KNn0dIGYbB0QBQHC5tetlrMTUg17L9+yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081051; c=relaxed/simple;
	bh=Wqe6bjZ4BCWh00tUqt4Dhiv2GMKQH+LXUvktvhpzB9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyEmg1U+sdGu2dtTo4WzEobmCtqFvJGAs0avnwbXEgMyAN7cFtwITRoZ24AkG1oz7YxeC1PFhH3F+JTdDImUO5K0aT7zuRDE+RYzAAlz7mHo1ep8qt+SaSwY/G6e5pIKmuyPv5X0fdBkFq3DafVLnvD2Pnj03fGYpJ24ZFHOWVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZSmmnKY3; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZSmmnKY3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787081048; x=1818617048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wqe6bjZ4BCWh00tUqt4Dhiv2GMKQH+LXUvktvhpzB9c=;
  b=ZSmmnKY3DG/7c+QKp6fPLjlDiVfkZRkcEfwDLSDAHBva6awoWIsMf7Z9
   5NtHVXAlH6D0cdps4yVsTzFZGqIqRoGTAHmjq522wlzHEnlUlsAljWTtO
   o2/WrxAF4KaakZCPMqszf4DfVe81l3bTp1I4gWmWDD/6gevpP06dYku57
   heDQixt6NRsa8wFdKEUkx5b+vFWB4zofKPKgOGeU1ndmWEQ1eXTSgzd0c
   oP3ZFh/j+Tb+4iY1F3vxMu0mt9z3I1vROJssXs3Q0ygv0g6Q8NXWO4ewp
   bwP37l3WzfALdg6dd9DKlbuu9d2jIR732VGty5Mj0RhyqtUJ4PeRmTXpT
   g==;
X-CSE-ConnectionGUID: h+8eaa1KQfWGdAw3HsHnMg==
X-CSE-MsgGUID: 7catcOPqSkWIsTVZka05iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87605381"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87605381"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 12:24:07 -0700
X-CSE-ConnectionGUID: XKrw6z8bQVav+RSspirBKA==
X-CSE-MsgGUID: Jbbj5kHKTuq3Bievd5UetQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="268827229"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 12:24:07 -0700
Date: Tue, 18 Aug 2026 12:24:05 -0700
From: Andi Kleen <ak@linux.intel.com>
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v8 7/8] KVM: x86/pmu: Emulate RDPMC on performance metrics
Message-ID: <aoSxVRJqjJzQssMJ@tassilo>
References: <20260817183143.226156-1-zide.chen@intel.com>
 <20260817183143.226156-8-zide.chen@intel.com>
 <aoSZRRDtNxNA0UtK@tassilo>
 <cdd88e7c-abc9-4e49-8947-bb7226f3a385@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdd88e7c-abc9-4e49-8947-bb7226f3a385@intel.com>

On Tue, Aug 18, 2026 at 01:30:32PM -0500, Chen, Zide wrote:
> 
> 
> On 8/18/2026 12:41 PM, Andi Kleen wrote:
> > On Mon, Aug 17, 2026 at 11:31:41AM -0700, Zide Chen wrote:
> >> If the host has the PERF_METRICS capability but it's not present on
> >> the guest, RDPMC interception must be enabled and KVM should inject
> >> an #GP when the guest attempts a PERF_METRICS RDPMC.
> >>
> >> If the guest has PERF_METRICS but RDPMC interception is enabled for
> >> other reasons, KVM needs to emulate RDPMC with type 0x2000.
> >>
> >> For simplicity, Metrics Clear Mode is not supported.
> > 
> > But is the bit cleared in PERF_CAPABILITIES? And would 
> > the enable bit fault?
> 
> Currently KVM doesn't advertise
> IA32_PERF_CAPABILITIES.RDPMC_METRICS_CLEAR[19].

Thanks.

How about the fault for the enable bit?

> > It would be better to just support it, metrics clear is actually useful.
> 
> Sure, I'll add it.

I guess it could be a follow-on patch, no need to hold up this one.

-Andi
