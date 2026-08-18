Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2CB1F16B;
	Tue, 18 Aug 2026 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787074890; cv=none; b=F6HmWAyTtLnvcnW1Zggdqz8ugzO+/qkohA6HCQVVr3CTJ9qJ3AakXXa3J22eU1r0IkxH8Ktv03CWArI43eeeaE7ZNT2RYZ1ivhJ4EOGOYsjLQE3zYIG1xcAqk6AGh8oW2NUaNq4SBiCEZP/Kle5HPYyjvaREGzGvFhZAAobSGBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787074890; c=relaxed/simple;
	bh=Tg8UHYuXd31LqWrkSnt/pKJV1BiDMsc5sKEQ47+w8mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HImvarQb56drjVlelrjm0Xukgo0yW5EJx0+eWfcYb2sC8QXReRdkzJ2vS8nv0gDV7ApR2DZgQlpdjUFfRBSiCWkBhUBZ/2MutcPh2XIEAtmxwTY5g0E7jfdNgu5HCMYUGG07+nWoGcQMLBd+4XhX39kkIcX3BkmoUs10t2GnZUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUVNg+Yr; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUVNg+Yr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787074888; x=1818610888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tg8UHYuXd31LqWrkSnt/pKJV1BiDMsc5sKEQ47+w8mQ=;
  b=XUVNg+YrOXXrcD/t8NMOkCIbxS0BoTVCduJtzII+vW39xx5YjWRSFRSu
   siXyizGNAFKam9x4AEGU0d8AOY/ecIpU30vxxqaGxms0FlPFhUEA91Z2w
   WbYUqOJ6H0OxyE9DaA6vQRMdqg41+tI/gbBeYf/x22RUl6cTp2GUfwkMr
   g3VoBlDR3z9M7vXuRCWKS2K6TvKoBKWgyUS3W1QwjpeGewN3/TXtX/Q7q
   jNuNsvrKDHY5qlxk/0SDxrjiofZoMSwJrSYXqGHlrqESseSMCWD+5h8u8
   KpIUVixsRAF3+yt3jptraSoaSQxgjhyfzTre3AFfifKauCdUhmw/FrSsx
   g==;
X-CSE-ConnectionGUID: InrDCGq7Q+eJI92idvW4jg==
X-CSE-MsgGUID: JtpgXVAbT9ilj1+OpOJbYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="105110342"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="105110342"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 10:41:27 -0700
X-CSE-ConnectionGUID: IhCWEYcAQvWxx+TzgYeovA==
X-CSE-MsgGUID: zsFWAiZJRfCVFQ7WoWPO4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="262021727"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 10:41:26 -0700
Date: Tue, 18 Aug 2026 10:41:25 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v8 7/8] KVM: x86/pmu: Emulate RDPMC on performance metrics
Message-ID: <aoSZRRDtNxNA0UtK@tassilo>
References: <20260817183143.226156-1-zide.chen@intel.com>
 <20260817183143.226156-8-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817183143.226156-8-zide.chen@intel.com>

On Mon, Aug 17, 2026 at 11:31:41AM -0700, Zide Chen wrote:
> If the host has the PERF_METRICS capability but it's not present on
> the guest, RDPMC interception must be enabled and KVM should inject
> an #GP when the guest attempts a PERF_METRICS RDPMC.
> 
> If the guest has PERF_METRICS but RDPMC interception is enabled for
> other reasons, KVM needs to emulate RDPMC with type 0x2000.
> 
> For simplicity, Metrics Clear Mode is not supported.

But is the bit cleared in PERF_CAPABILITIES? And would 
the enable bit fault?

It would be better to just support it, metrics clear is actually useful.


-Andi
