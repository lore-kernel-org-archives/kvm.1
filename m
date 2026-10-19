Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A868D4A68BC;
	Mon, 19 Oct 2026 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401883; cv=none; b=C+aeFeW5y6BLt4SstbpCOesH+7YAzvCv62n1nJURA9bDH5Tfz4bhNzLnYj9wtQCmsm+Bg7zDmz5NVwR92oIu666/1Cl6HSeyMMvl/hKp4kh4GZMiktDIwds6DHDuT8m13KKpJEnncSCj4prTRZ5Ul88LGa9GNd9Z/ytEAck1hIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401883; c=relaxed/simple;
	bh=Qw6EgPhet4HBE+Fp3N9OvLKAKBsDCuHsZePPSoodzro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NL8vgk/ghyKxX5875+ea4RfJrxwJ26V2A2mBZeB79L7GQiwWOhVOFPyU2wMxkLHrQCJDtdJ7eEaIf7seQClBVnBUqzaEYISyz5hhvSCR/xl4tfgerXGMUjAikJvRhR34k96oCEWGIX44fG2AmMyGNCqn3lmzt5G6lqvFte88Flo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TcEKiSYR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TcEKiSYR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792401882; x=1823937882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qw6EgPhet4HBE+Fp3N9OvLKAKBsDCuHsZePPSoodzro=;
  b=TcEKiSYReqWLKxCK8boaplpIyOefb5W1/N+TpBGKWvLvGCjPeAok60vq
   /yfZRY909OZEOjD41wYYX/E/UA0hZlcdRE0mVM9p9J7SpaguOFIxdBvZx
   IB8cRv8pe5Dp5wbfiruqrxbk0AKS8bH7Aub7Hahdg8fVleIeioljkR0Vd
   B+tknOY6dJzQq0dYUEqNoeE/p6RPjZZrcwTGjut6Tpebd81IMPxWG1khL
   fBzohHDrPFoQYOQUEy1odJti23rfEx1F+K1TgP+T7ueZC/ZfT7yM8/Kbx
   DCt/yHwIEgBIYk+InH60SBq3V8fyLIBbICwp9xqC6FSXDD7MEMGVbaRnO
   A==;
X-CSE-ConnectionGUID: NKqr373kSJumdSgWflynoA==
X-CSE-MsgGUID: ujCitKT6Trm0+6tnSrUACQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="949559"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="949559"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 02:24:42 -0700
X-CSE-ConnectionGUID: a3wHqUL3QSWY+nZ/e9Q6bA==
X-CSE-MsgGUID: t5CxkMO3SvKKlakpb2p8rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2485005"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.31])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 02:24:35 -0700
Date: Mon, 19 Oct 2026 12:24:31 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, dave.hansen@intel.com,
	kvm@vger.kernel.org, yilun.xu@intel.com, xiaoyao.li@intel.com,
	sohil.mehta@intel.com, adrian.hunter@intel.com,
	kishen.maloor@intel.com, peter.fang@intel.com,
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
	chao.gao@intel.com, artem.bityutskiy@linux.intel.com,
	nik.borisov@suse.com
Subject: Re: [PATCH v4 4/6] x86/virt/tdx: Support DPAMT when adding memory
 for the extensions
Message-ID: <atXhz1APsHqBCQfW@tlindgre-MOBL1>
References: <20261013-tdx-module-ext-v4-0-de5ffac65470@linux.intel.com>
 <20261013-tdx-module-ext-v4-4-de5ffac65470@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-tdx-module-ext-v4-4-de5ffac65470@linux.intel.com>

On Tue, Oct 13, 2026 at 11:28:54PM +0800, Xu Yilun wrote:
> The TDX module uses Physical Address Metadata Table (PAMT) to track some
> state for each page of physical memory that it might use. 3 levels of
> PAMTs are used to track pages of different sizes - 1GB, 2MB and 4KB.
> The Dynamic PAMT (DPAMT) feature allows saving memory by allocating
> 4KB-level PAMT dynamically, while the 1GB and 2MB levels remain
> allocated on TDX module initialization.
> 
> A previous kernel change [1] enabled the DPAMT feature by default so
> that the kernel must install DPAMT before adding any 4KB pages to the
> TDX module.
> 
> Although the memory for the extensions is tens of megabytes and the
> kernel allocates it in a large chunk, the TDX module accepts it at 4K
> granularity. Thus the kernel has to install DPAMT for each page of it,
> otherwise TDH.EXT.MEM.ADD would fail to execute.
> 
> The kernel has helpers to install DPAMT for a 4K page. Call
> tdx_pamt_get() for each extension page before adding it to the TDX
> module. Normally, these operations should not fail, and if they do,
> intentionally keep the error handling as simple as before - leak all
> pages, including the installed DPAMT.
> 
> AI was used under supervision to review code and workshop logs.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Link: https://lore.kernel.org/all/20260904215841.303070-1-rick.p.edgecombe@intel.com/ # [1]

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
