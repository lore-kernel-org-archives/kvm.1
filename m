Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07F7386C1F;
	Tue,  7 Apr 2026 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579403; cv=none; b=obfXT6clq4x4ob1wi0ah+OBuRXeuLslWyWLQsgzMUlh+gaIuGyspETtK48JABE3cytwVirX8jmBlquTGBbWv0TX6pTI+x1cGGOQgMEzEBajy8ws2WNpv1f9/tzf4PcObBdUlaX2OMEyP5UukooQ6bbG61naZ8dfrs7fDLDQoyFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579403; c=relaxed/simple;
	bh=SaytBHWLYbTwhsvKj0cQjKCx0k4cs+2ND2byJlWhrvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N23016rGaeZ4rMkrFeSVwV591HJn/JOIxtnjmfwQkoOMh8hzziwyW2NrxhwBzbPOwl1TGojXodWzetSIw7m0OfsiOIHLWV5c9u7Jc1JiZQaNgoxCE4Aa1l+Kvv8wnCFCHE1uoKsFm2bsPJaV35DN56t7kp4LqG1k54M1rVObJ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VXEKTNNb; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VXEKTNNb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775579402; x=1807115402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SaytBHWLYbTwhsvKj0cQjKCx0k4cs+2ND2byJlWhrvM=;
  b=VXEKTNNbQp1s5cCszLMjAkpmJW2nvxjTrvJzLJlNLX1ftl1E7LBs0otM
   64lxaC7vsEzxyQVi1Kl0tWWn3gDaEnksPbVuyBwvHS9TAnoQStrFr6Ek+
   5OfT8zP7bacHXKbmwJhovZUWSY1DJIj3kSSiA3sBkGtWeDWfz4P+ojeGk
   dFaoWGpzMV81qlcv3OB+uNEhanalTy4lln9ZbQXSDzRc+ZW7MQFlIfRpV
   HUT7UuCXwGkritX7trVX3UiHkIeiZIn+BLoKJWN2e1zHjlbii2lfT8g+u
   /vhwbgZe0npcId2M+x/LUJ40jfN+jUrm0zbwDfAPfPwCrht+36Io3XId0
   A==;
X-CSE-ConnectionGUID: PmWN+t3WRpeWbl374yTrUw==
X-CSE-MsgGUID: 5R1pMJ2IQCGmBZQImuztwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="64094751"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="64094751"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 09:30:01 -0700
X-CSE-ConnectionGUID: G/chWIi3TrqWGdX8XHJOZQ==
X-CSE-MsgGUID: 7s+bb/sFSSyK4tL4fH+Ybw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="232246173"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 07 Apr 2026 09:29:58 -0700
Date: Wed, 8 Apr 2026 00:08:27 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <djbw@kernel.org>
Cc: chao.gao@intel.com, dave.jiang@intel.com, baolu.lu@linux.intel.com,
	yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org,
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com,
	kas@kernel.org, xiaoyao.li@intel.com, vishal.l.verma@intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/31] PCI/TSM: Report active IDE streams per host
 bridge
Message-ID: <adUr+/9PIAL+i1qm@yilunxu-OptiPlex-7050>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-15-yilun.xu@linux.intel.com>
 <69cef244d7c91_55682100ed@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69cef244d7c91_55682100ed@djbw-dev.notmuch>

On Thu, Apr 02, 2026 at 03:48:36PM -0700, Dan Williams wrote:
> Xu Yilun wrote:
> > From: Dan Williams <dan.j.williams@intel.com>
> > 
> > The first attempt at an ABI for this failed to account for naming
> > collisions across host bridges:
> > 
> > Commit a4438f06b1db ("PCI/TSM: Report active IDE streams")
> > 
> > Revive this ABI with a per host bridge link that appears at first stream
> > creation for a given host bridge and disappears after the last stream is
> > removed.
> > 
> > For systems with many host bridge objects it allows:
> > 
> >     ls /sys/class/tsm/tsmN/pci*/stream*
> > 
> > ...to find all the host bridges with active streams without first iterating
> > over all host bridges. Yilun notes that is handy to have this short cut [1]
> > and from an administrator perspective it helps with inventory for
> > constrained stream resources.
> > 
> > Link: http://lore.kernel.org/aXLtILY85oMU5qlb@yilunxu-OptiPlex-7050 [1]
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Oh, looks like I had yet to get this reviewed on the list. Can I add
> your review and / or test tags and take this for v7.1?

Yeah, I've added my RB in that series. Hope we could have this one in
v7.1.
