Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00F8330B2A;
	Mon, 26 Jan 2026 10:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423339; cv=none; b=LMqUIbsMri0WZDSeSaA3cutPi2gE8BuH5qHTKdEz53x9ql0PUgrrNkwvRwrjqAymh7ht94hMpAl9wDV+3qe42sSmiFzdOTAXbtGShyMDovHo9OGzPiHf6nT8E4dA0EpjBy9w+xOc4D3ScLjjybF0qs+P6fZHMFXdfJ13ZCbXE5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423339; c=relaxed/simple;
	bh=bhG3gelob0jmBkWsdn8PSBSfhQbeTB63h3+j1LDrLzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jxij91fcQk0QpdW7XPqjMNJMZPe21/LB0YRhMpNtI8ccNzJMSX9LYXAlVKV+kS33ZZvEQipfWwF530D9E6llRW3c9gdS15fYs/8+G6DVMn+JV4L1wvXSgc89msNs7VovqKTW2slN4opRMXHIjnTTFkN97oMPnOS0U/2lgUgggVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dvQ0cUrn; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dvQ0cUrn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769423338; x=1800959338;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bhG3gelob0jmBkWsdn8PSBSfhQbeTB63h3+j1LDrLzg=;
  b=dvQ0cUrnAr53Nk6vSJXU2+OqYVRS76fAUeuQmoR8Dx6OkBwjMQqzHqJh
   rX1MLCzBZANEICdmjA2RshPYAbXYgw1MoWZjvK7iOOYVg7sBAWyKCbSCy
   lULSPiRVHKwPcDY3zVeJSV9J9KfZq2D65I9VNo+OTOzjusLVbgi1aHXH7
   1veaT9XaVvm5BjuR6ui7XBrMDte4ICwK0+Aqeb6bKS9kjdKWh6o/JwiWj
   BNUc4uuHIYfcPgomMPZ0uokik8Nz6PLdK7+Gv+1B69Vnsc+QWyh18P2Ii
   CYt7eFxEBle6FLJP/7Zf8SvUYEJ4Aa/1lDaLpdNUzOJnfCq66QzFGLgwV
   w==;
X-CSE-ConnectionGUID: n0dFhlJlQUCEbxobjSZxyQ==
X-CSE-MsgGUID: RihuuXK7TZmxNSZST/ev4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="96061534"
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="96061534"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 02:28:55 -0800
X-CSE-ConnectionGUID: R+VAUD2tRu6HjQMScxaVrg==
X-CSE-MsgGUID: 2slZUXjlQii4kQlJeWwFeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="207248608"
Received: from krybak-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 02:28:47 -0800
Date: Mon, 26 Jan 2026 12:28:44 +0200
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, x86@kernel.org, reinette.chatre@intel.com,
	ira.weiny@intel.com, kai.huang@intel.com, dan.j.williams@intel.com,
	yilun.xu@linux.intel.com, sagis@google.com, vannapurve@google.com,
	paulmck@kernel.org, nik.borisov@suse.com, zhenzhong.duan@intel.com,
	seanjc@google.com, rick.p.edgecombe@intel.com, kas@kernel.org,
	dave.hansen@linux.intel.com, vishal.l.verma@intel.com,
	Farrah Chen <farrah.chen@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 14/26] x86/virt/seamldr: Introduce skeleton for TDX
 Module updates
Message-ID: <aXdB3F6xaDxjpE5N@tlindgre-MOBL1>
References: <20260123145645.90444-1-chao.gao@intel.com>
 <20260123145645.90444-15-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123145645.90444-15-chao.gao@intel.com>

On Fri, Jan 23, 2026 at 06:55:22AM -0800, Chao Gao wrote:
> The P-SEAMLDR requires that no TDX Module SEAMCALLs are invoked during a
> runtime TDX Module update.
> 
> But currently, TDX Module SEAMCALLs are invoked in various contexts and in
> parallel across CPUs. Additionally, considering the need to force all vCPUs
> out of guest mode, no single lock primitive, except for stop_machine(), can
> meet this requirement.
> 
> Perform TDX Module updates within stop_machine() as it achieves the
> P-SEAMLDR requirements and is an existing well understood mechanism.

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
