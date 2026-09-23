Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2A941A501;
	Wed, 23 Sep 2026 05:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142253; cv=none; b=JgE8Nuj03W0Si8nCGX1f6XUBu2Z6TJ9PGtLEnopF7nRsnovFZhHeQ3CR0Iu7yFgwVkdjnQKoDQqs8r8pVTozhLr2b2XkhUlFL3RKlq2bC8uVBqPn3G1Q8gNZktMWZNeao1NjYYE3vWlvrhKcgEfLWVXSILcR2ejeFHIGs+rjc24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142253; c=relaxed/simple;
	bh=y74lpcnmUllGAWRFEDCby3KhL59rqalI6nEkRfcayRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsis4wRAVBlKQ0gmvuaGoQlM44XohYYK5TnqalDmH45ydJa5Hl4EpogOpKfis5NWgsAu2Bxo2CRfrjjaWmiZcFe1rcvxTwlgaE3o2m5h2yPk6Wqd3YA1tu4tirhe9V3kbnl/sqyjGNUBKH/DeMI/3nkVUfWyqQZhEQTPNfNSeXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFSA0SoU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFSA0SoU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790142252; x=1821678252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y74lpcnmUllGAWRFEDCby3KhL59rqalI6nEkRfcayRM=;
  b=mFSA0SoUALeFHzXZRTJkiCMztyAixUNU5l8N5b6O5bKPIvp5KzVH++x2
   h9YXJ/1cwZykrRa9BS2gT6hB6F0VGAGOrFXS6FDcuRhmRVN5xWiFq21Pf
   CHvbqcGwc+ntHIJblT0i2ecUX4soH5e/mScYvZrdTIlODEIoT1uNXH5yA
   AbCMhDydX9Oa8E1M/xqsSvLxmsHGhbjxoK3RbvRkShl/ARVkeCNjfaSM9
   Mk9DmqZFp9+YaCfWDP+5N1nrNVXTMkjquSLg8Qm1psTsK9EV8EYN1AkY2
   wfOscZRzk1RSp/px3xytwbJ58nXyJYfX5P1jOK1CkSQRz/AP9+JqV3xOh
   Q==;
X-CSE-ConnectionGUID: 02GWZyyzRzmFTZpwD71v1w==
X-CSE-MsgGUID: RqoqyhT6RFC70uDtwoFSBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90918915"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="90918915"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 22:44:11 -0700
X-CSE-ConnectionGUID: 8jKRAshlRr2M+xtn/ajagQ==
X-CSE-MsgGUID: 8LWbQSsYTPKDp9GV32CKbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="278201839"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.235])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 22:44:07 -0700
Date: Wed, 23 Sep 2026 08:44:04 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, yilun.xu@linux.intel.com,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 00/10] TDX: Stop auto-generating the global
 metadata code
Message-ID: <arNnJO3aKDlCD2Uz@tlindgre-MOBL1>
References: <20260918132946.76533-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918132946.76533-1-chao.gao@intel.com>

On Fri, Sep 18, 2026 at 06:29:19AM -0700, Chao Gao wrote:
> This series cleans up the TDX global metadata code. It has two goals:
> 
> 1. Replace the generated code with a table-driven metadata reader.
> 
> 2. Make the existing code easier to read and maintain, and simplify
>    adding new metadata fields.
> 
> During the v1 review, Dave raised concerns about signing off on
> AI-generated code. I have since rewritten the affected patches based on
> my own understanding of the code.
> 
> The main goal of this RFC is to agree on whether the table-driven reader is
> the right replacement for the generated code. Please raise any concerns or
> alternative design ideas.

For alternatives, I wonder if grouping the metadata would help in the long
run. Some of TDX metadata needs to be cached. Some of the metadata is init
time data for how much memory to allocate etc. Some of the metadata needs
to be re-read after TDX module update.

Should we have the table-driven metadata reader use the TDX module
metadata directly by default instead of always copying the data? That
could be used for the init time data. And data could still be cached for
CPUIDs etc.
