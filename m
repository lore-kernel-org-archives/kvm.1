Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B97352C3C;
	Mon,  8 Jun 2026 05:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780897520; cv=none; b=LR8AVEZZN8AYytsvI2V6x7Dro6s+xPQcvv7DNIU9NMbL+G8HzzzeOwBnJIRBUnk1fs3xI27gTN/PYb+KWAxi9c34HQ2oANOz/Tj4mv/4zCsL2tk+Fbsg4Fqy/UhteYYK699qP6d/u5L89LwXcsSHakDGSVYECvMGXz0vuezo7k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780897520; c=relaxed/simple;
	bh=/RGGAgxhY6od1kGgxTlv0melPSju+MK4bbQR13r3qWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sk434A3EcaYDkAt++MhgC/+lH2vMggMndRI74UV0P34GzmIl674wEa2Yx7wuEeMHEtTsQz5Ag1pis/0ZCS+geOj+NedpQnlI4ZSAS8fU6X9AD7u6anx5cElAfOnaLb7aeRf3L7+yR7fXjNgkJdBDr1TZnxKvTFSm7EkZjZQlvlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/HG7y0I; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/HG7y0I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780897519; x=1812433519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/RGGAgxhY6od1kGgxTlv0melPSju+MK4bbQR13r3qWw=;
  b=T/HG7y0I2CtcFblYrDZsjs/LcEmg0lYRO/Kr/r2/Cg1TtzfoSKqdGy7C
   vAkvgIjL/pV8HQv+ZRAF4zrhKX0ll4RZKKNYddSxiykDqA/sXK52c7H/1
   Yc14kOLGd1GJR81U1k3kLHtaAnXZG/JdvCJ7yrN1DG34+Eeqh9qZ1DYz6
   zdTIvsCmPWeKtD9wBUcG0yRZ55C3GhmwAIm0O9nqxNNvdYL4Ke1AgTAWg
   iHJRMLVmwCY/O0ZJ9P4TwQbczETv59TxLV6QIqBX0CsFONxwr3FsKm1BR
   3kn2ZMgN55GfKGCM0XwIvVXWuoxIEwBHuo3hjp5Y5kwjoiUiOILZZsYQc
   g==;
X-CSE-ConnectionGUID: gTSztelsTkq3wtdNBrvnXw==
X-CSE-MsgGUID: UhmW7l7JSv6kx5nlYttNew==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="84199709"
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="84199709"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 22:45:19 -0700
X-CSE-ConnectionGUID: qH9sb52xRkSt8Gzwh/PMTA==
X-CSE-MsgGUID: qegt3SeTQE+/bqLd8HfVSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="250362963"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.107])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 22:45:13 -0700
Date: Mon, 8 Jun 2026 08:45:10 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: bp@alien8.de, dave.hansen@intel.com, hpa@zytor.com, kas@kernel.org,
	kvm@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mingo@redhat.com, nik.borisov@suse.com, pbonzini@redhat.com,
	seanjc@google.com, tglx@kernel.org, vannapurve@google.com,
	x86@kernel.org, chao.gao@intel.com, yan.y.zhao@intel.com,
	kai.huang@intel.com
Subject: Re: [PATCH v6 00/11] Dynamic PAMT
Message-ID: <aiZW5oSFJMnr-p7J@tlindgre-MOBL1>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526023515.288829-1-rick.p.edgecombe@intel.com>

On Mon, May 25, 2026 at 07:35:04PM -0700, Rick Edgecombe wrote:
> For a simple small server with mostly physical contiguous RAM and no CXL
> complications, the basic implementation should be close to optimal anyway.
> And for big servers, an 8GB allocation is going to have less impact. In
> the end Dynamic PAMT *is* an optimization that we will force on as a
> good default option. Even with all the optimizations we could throw at it,
> if the system is 100% TDs, Dynamic PAMT could come out slightly behind. So
> judgment on good defaults is needed regardless.

From usage point of view it's not just a memory optimization though.
These patches make it easier to see what gets allocated for TDX IMO.

This based on rebasing other patches on the dynamic PAMT series a few
times over the past year. So for the series:

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
