Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0533B399036;
	Thu, 25 Jun 2026 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385033; cv=none; b=BMg0bULtAOAoqrOuRpgBX7Ii2f/2r6z95Hz/gWbi4c5iCAstZBgj0YZpTKkMW23lmEZt6aC5CQUA9CphcGG2u1+AWzodsHkruA01WIsYDH9RdD8tIWf0TYAMEcmDZ6IdVTka1nOQe/+QlHhRmZfefzN+pSg9crzBIHKIxAo66m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385033; c=relaxed/simple;
	bh=SEBex/xnttZw+U8hZRhjP+heIRFnKI6FHkax/qYUkBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m++7Y8ktVmSiHYvimCzCO9qReV319qqz1bHUUM1x+gWrcrZPcWUp1bjYXjNxdV5fXrsqT/jn/XtywqNklOYFp+SvXVDt6C3RPB5VwZ08qkY1PDS/CPjOfWFW24HjK0r1WfvnyUVX+oQcLN+pI+mdyuTTFndflyp3AriWPGrOoiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HTZ05XE/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HTZ05XE/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782385031; x=1813921031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SEBex/xnttZw+U8hZRhjP+heIRFnKI6FHkax/qYUkBo=;
  b=HTZ05XE/15Un8Ig2a7l84RQT9e/OKjF7d1Yv+5N+a82oeHn/00Ti53YB
   edzGd3z5HG7ysOaIUWOqmkhuaiOnZBUzSkhx26j/cCVIkZsSanOnruFVt
   TehJkVNs4IGIrhrz0haBCslVtIOtnqTN+cq9+BvZTEKI+tSO8DTlp76lH
   ls8VC6VpS8oD8zVVDKUzAJKNn/cWoJk0u7Xe+z/6Ek09M2Hs7pXXmeAPy
   6C2XqmuRPRIAco/WH8VUVlZZ8Atlg5RlmT++sUGeCpk5bjpTyjAs0GQys
   HKZXT2tkaD4uKU5CIrWvKjAAWmaUge6byG9XJRLi5VbL9NVOL3mgkYsDy
   Q==;
X-CSE-ConnectionGUID: Z9NYKskTQKeATqGffvPjjA==
X-CSE-MsgGUID: 7LiQZ4VzSOmbS2daL9CPiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="94277722"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="94277722"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 03:57:11 -0700
X-CSE-ConnectionGUID: N6qU95aSRUe/DQRnkFZrfQ==
X-CSE-MsgGUID: pgtiru1SR0OUPlk/xcYyuA==
X-ExtLoop1: 1
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 25 Jun 2026 03:57:06 -0700
Date: Thu, 25 Jun 2026 18:57:05 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, djbw@kernel.org, kas@kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	peter.fang@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, dave.hansen@intel.com,
	dave.hansen@linux.intel.com, seanjc@google.com
Subject: Re: [PATCH v2 03/17] x86/virt/tdx: Detect if the extensions
 initialization is required
Message-ID: <aj0JgX2DxcDdZ2Jy@yilunxu-OptiPlex-7050>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-4-yilun.xu@linux.intel.com>
 <ajy6VMlPK08K7kIT@tlindgre-MOBL1>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajy6VMlPK08K7kIT@tlindgre-MOBL1>

On Thu, Jun 25, 2026 at 08:19:16AM +0300, Tony Lindgren wrote:
> On Thu, Jun 18, 2026 at 04:13:41PM +0800, Xu Yilun wrote:
> > TDX module extensions support extension SEAMCALLs that are preemptible
> > and resumable, unlike normal SEAMCALLs that run to completion while
> > monopolizing the CPU. This allows for higher-level API constructions,
> > so better supports some add-on features that implement higher order
> > security protocols.
> 
> How about "TDX module extension SEAMCALLs are preemptible and resumable..."
> above to make it easier to read?

Included, thanks.

> 
> Other than that:
> 
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
