Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6569D43B4AD
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784808726; cv=none; b=JjP3RcUSEUg/018/RrpwbKLKNy95oKCprnlP8OO/STz693/HTG6mQyq18eFNFOn/1zrnXs3I1JKTDvoeCSg50LJeW6JN6BmilxOWljh/LAbGgqmNF4iDtRVlxA7MXovd6UHMpx+2jWKDWcAQVBo5NcMTkUH/Sh01KmXO2H9E5zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784808726; c=relaxed/simple;
	bh=eII1PBzEE8SnfKcy8G5nVpzEv4kxcnItr8poopo4trY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZvXxmf4n2WwcXrGPmu/W7aIuDIHaI0vPPyltNTbecD71lLQQG5y1DHiuXcxTFoKhSVhTaCSPGgmxVZ0/E+y0JJbt4M6r5JkUAooWEcTIkTd+D24KyRmt6uUCxuGgyPO7ETL2VGNyTeKZ89su9jHnkEXx2EM/kwlHsFV1fsAYGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O1Fa3wF5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O1Fa3wF5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784808721; x=1816344721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=eII1PBzEE8SnfKcy8G5nVpzEv4kxcnItr8poopo4trY=;
  b=O1Fa3wF56iOiyv0EaHVAww2LyZiDEdA/6JuFoyvqGmexUiyTeh6+gpju
   B2r2hrenDM5+G+jSc4+SJBtJWz2kFA7EWaV4vFEgTg3G4cm44aI9SIHOK
   2uOjiSXjUKFvnJcPik+93ePMRux/BoTOsUYSR4DLUo+khcnoi/ocWKmIA
   1WhNPwyKXtIj9sdlGDJnk0e/dnQFSSKdY/V1kEJepW+2b8aJLq6D7voat
   XXL4/A0ccS4hz/fYv0FEE4R/U2aiuXxAaSfTsF+fSRfrRKeS7YF25Zqoe
   v6LgJdNYZtusEnSfQbeJyJLQF8hLdWEsBddSnzdC5uEA1RDIdcbEJmKaL
   Q==;
X-CSE-ConnectionGUID: RYEKinR0RFqergN4tx2hsw==
X-CSE-MsgGUID: BTHFNhTKQcmXN1v8UVFgdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85313382"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="85313382"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 05:11:59 -0700
X-CSE-ConnectionGUID: YLyN8t9OR2KOojv6uusv6w==
X-CSE-MsgGUID: T9HsjTKRRja0zGk4/DYerg==
X-ExtLoop1: 1
Received: from zhaoliu1-desk.sh.intel.com (HELO localhost) ([10.238.208.118])
  by fmviesa003.fm.intel.com with ESMTP; 23 Jul 2026 05:11:56 -0700
Date: Thu, 23 Jul 2026 20:11:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
	marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	"open list:X86 KVM CPUs" <kvm@vger.kernel.org>
Subject: Re: [PATCH] target/i386/sev: fix MemoryRegion reference leaks in
 gpa2hva callers
Message-ID: <amIFC5OwQ5eCPdI0@intel.com>
References: <20260521145451.1831984-1-marcandre.lureau@redhat.com>
 <e7d3e9dc-be97-40f3-b426-3e93a242410a@oss.qualcomm.com>
 <87mrvightj.fsf@pond.sub.org>
 <CAFEAcA-Upx9uacBZ8nq3Co5csNqi-nHaTOVX7t9kUzDW-CL5Bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-Upx9uacBZ8nq3Co5csNqi-nHaTOVX7t9kUzDW-CL5Bg@mail.gmail.com>

On Thu, Jul 23, 2026 at 11:45:47AM +0100, Peter Maydell wrote:
> Date: Thu, 23 Jul 2026 11:45:47 +0100
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: Re: [PATCH] target/i386/sev: fix MemoryRegion reference leaks in
>  gpa2hva callers
> 
> On Thu, 23 Jul 2026 at 10:46, Markus Armbruster <armbru@redhat.com> wrote:
> >
> > Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> writes:
> >
> > > Hi,
> > >
> > > On 21/5/26 16:54, marcandre.lureau@redhat.com wrote:
> > >> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > >> gpa2hva() returns a referenced MemoryRegion via its p_mr out-parameter
> > >> (inherited from memory_region_find()), but both SEV callers were failing
> > >> to release it.
> > >
> > > Comment orthogonal to your fix; odd to have a non-monitor code
> > > call an undocumented monitor method.
> >
> > Which one?
> 
> The gpa2hva() function, presumably. It does seem a bit odd to
> have the target/i386 code directly calling this. The function
> in monitor.c works on the system memory AddressSpace and
> assumes that there is only one kind of "guest physical address",
> because that's the implicit "everything is an old i386 PC"
> kind of assumption that got backed into the human monitor
> command. But it's not really something we should be doing
> more widely.
>
> The i386/sev code looks rather odd to me. It seems to be
> using gpa2hva as a way to get at the host memory that is
> backing the guest memory. Why can't it use the usual
> address_space_map() etc APIs for this?

Yes, I agree.

For sev_inject_launch_secret, it's straightforward to use
address_space_map().

> Worse, it looks like
> it keeps that host pointer around in a SevLaunchUpdateData
> struct, and it's not immediately obvious to me that it won't
> go wrong if the memory map later gets moved around and that
> pointer becomes invalid. And it looks like it writes into
> guest memory in a way that will bypass the dirty-tracking.

For snp_populate_metadata_pages() and SevLaunchUpdateData,
I think maybe we can use address_space_map() to get pointer,
and add a flag to SevLaunchUpdateData marking that data entry
owns a mapping. Then sev_snp_launch_finish() can unmap if that
flag is set, in its loop.

Thanks,
Zhao

