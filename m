Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2062DFF3F;
	Thu, 25 Jun 2026 06:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782367778; cv=none; b=m4Tc28xlekfOnY3pyvPFT3DNKqiN6/4SC8B2Ew2m8/lQKQDK/5LCEpXZX2K9VX/NLIsx3KEHf4FO8S8oqr7Cu4U2Z+GmYPhz1boyRzw5RtmhyG8vGDRdT8G3zigjPjbGmnx+GaFUS6bVKKKgbBlduEfFwKSbW9OxOWhyyxYGldQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782367778; c=relaxed/simple;
	bh=DWu/+9yYI52gCGGp5HiZgLDZ3b6rVRqzAx3X6C3ckdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=de7BUn/sQaxLtfy2lhqueapA4HeDLlJj4aqjvB8Ae8/Np3BklbOdBsSzxtaWsxHgxXmdwtfk+ELvEVEhKi7laHQ90L9hjG1fS11pftlc+ifc3fi/ZVtaQNmVtTifxKOhx3P7+vFSgs12OzHL/ISrSShg2nqlYGCoN+VjhoaB148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CV2STnd0; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CV2STnd0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782367777; x=1813903777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DWu/+9yYI52gCGGp5HiZgLDZ3b6rVRqzAx3X6C3ckdo=;
  b=CV2STnd0m/Gu5YMUUw/oHeNs5jkzMTJSmcT7y002iY+Ssiuc+Q+vbRAR
   86+swTBfNF5xPt7mRhog6wpLx9LpEzs6krgqRA45QuAJ4C12jsgF4hXCY
   Fk+X2rUHE+YPbZ+aW3nOE6dAOjb8FKIh5yVf8LegF5sbtB6XggiWy9nKR
   iUPvX7i9Yt3dcD+clOxuyv68VrUS5RpeUPLT9mw9FhkTn5XN6S5bahZQx
   NvLZye+QfsL6w0Z4T1zpYpe0G8P1c4KLUooDcFfp3GlVGWHvu/uoYaqva
   onpajlm76tH5au4ZFYRc4LIEHeMRnYZcZZ5Trrvfsvtw7NlJ4OTB0+0j1
   g==;
X-CSE-ConnectionGUID: LMmijISQQi2R6N4/MUaWGw==
X-CSE-MsgGUID: FCbLU0dtSn2mtxjDIVUyEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="94258614"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="94258614"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:09:36 -0700
X-CSE-ConnectionGUID: vLu00DftRrexV9FEcTOk/Q==
X-CSE-MsgGUID: 8yGO/pP+TqOG8Fr5lIe7lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="250496067"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.64])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:09:32 -0700
Date: Thu, 25 Jun 2026 09:09:28 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, djbw@kernel.org, kas@kernel.org,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	xiaoyao.li@intel.com, sohil.mehta@intel.com,
	adrian.hunter@intel.com, kishen.maloor@intel.com,
	peter.fang@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, dave.hansen@intel.com,
	dave.hansen@linux.intel.com, seanjc@google.com
Subject: Re: [PATCH v2 09/17] x86/virt/tdx: Add interface to check Quoting
 availability
Message-ID: <ajzGGCTHBaWl_WpL@tlindgre-MOBL1>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-10-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618081355.3253581-10-yilun.xu@linux.intel.com>

On Thu, Jun 18, 2026 at 04:13:47PM +0800, Xu Yilun wrote:
> From: Peter Fang <peter.fang@intel.com>
> 
> KVM needs to know if the Quoting extension is available to determine
> whether userspace must be involved in Quote generation.
> 
> Since the Quote buffer is always created during Quoting extension
> bringup, checking whether the buffer exists is sufficient.

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
