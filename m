Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8EA26F288;
	Tue, 10 Mar 2026 00:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773103987; cv=none; b=uW39mm7nqB6oe54JkLFIiX6kKkT9/EbDGQQbiHKEUtuJuXkk0nL7EJfy0hrUYpy38wr23mUQg6XinkJpcJhKx+wNddzkXRc8bmTH66Qyk0VZCu629HoBWRiwW+GSV/vK08qEAdOYWczShiECP+yVcrZl6fGOWhIgYua6c+W/vEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773103987; c=relaxed/simple;
	bh=dOY3I///IsofiCq91EtquP1UGc+hdwgFEw9KZ+bbsn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6pnlxXavmgcmfhv7hCHHjmKUsJYXCDsoST595GPOZ3fO3W/t/K+B1jg2WYW9cs7gL87/CpPI3VSLUrzkjJVYDoGgXzfF2xLi1nNyFexF9ZbXlrInyipHIoCPvYa6FePXrUVunZNyAWPakASIHv+OV42slBtcayECOqKOAE/vuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dA+XMCQg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dA+XMCQg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773103985; x=1804639985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dOY3I///IsofiCq91EtquP1UGc+hdwgFEw9KZ+bbsn0=;
  b=dA+XMCQgz0kI+eKRxqGfWnO/OtSVPWUCddwuJDnc0r45JSFfDGf5AHTU
   Srp8fTOfjOtFu0lzD/M8AthNeZ2KPErbe66FubkdAEDXw4aqnXggmzFTL
   0LA/hB9m1rMQ0ygwNbikP8mtGN3kVQ+Mq95l1jVWQv90EIfaui2Pu+QNT
   Fncpn4/Wjx0pfWUMR/b39iQfY/NnMeDfIaGL30S3zEmus0e5q/g2OMB5U
   JihRako+0UYYvllcbW+xkLPdYfpb9ShAVLO1taxJVO4OY0LxG0Rfdyuh2
   A4kY2sUtGA5dW9FRVZv44d8xY27HYfw2wrZxupw8tjau9TvDda/n1YY0h
   w==;
X-CSE-ConnectionGUID: 6gQEAA2CQnWWvlqLjDOL+A==
X-CSE-MsgGUID: N9ykD8v2TLmIJMRhurRizA==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="85616366"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="85616366"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 17:53:04 -0700
X-CSE-ConnectionGUID: o/ca9FhaRryL0yUpF/MhrA==
X-CSE-MsgGUID: 8S0Fxg/MQ0C6Fpz4FOgi5g==
X-ExtLoop1: 1
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 17:53:03 -0700
Date: Mon, 9 Mar 2026 17:52:55 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Jim Mattson <jmattson@google.com>
Cc: x86@kernel.org, David Kaplan <david.kaplan@amd.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Asit Mallick <asit.k.mallick@intel.com>,
	Tao Zhang <tao1.zhang@intel.com>, David Dunn <daviddunn@google.com>,
	chao.gao@intel.com
Subject: Re: [PATCH v4 04/11] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260310005255.3smfztoqb2p4ej6h@desk>
References: <20260306232920.dja5n7cngrsyj6tk@desk>
 <CALMp9eSoNaifKyppbjJjNx1YEw9KFv0LGAJ6xD-ko0zJnNXEbw@mail.gmail.com>
 <20260307010051.u4ugg3nyvsu6hwbg@desk>
 <CALMp9eQGZcekQ3QtL=J7TqHJ9YfZ+SbrgY5P8fp14p4KNThYmw@mail.gmail.com>
 <20260307024132.wleqtpovzd6wtvm7@desk>
 <CALMp9eTO0irFX9sZaVU84r1aW5E7Q2B3bE8uWfgViSug6Hx+og@mail.gmail.com>
 <20260309222935.2wu6xhydsgikkjpn@desk>
 <CALMp9eRu1YYFiqzMbNKOOhwwy-FqrSOvw-ddTuNtiSZbNs7JLg@mail.gmail.com>
 <20260310000020.pxig2fy7tjfex7jh@desk>
 <CALMp9eRC4Sq8Kj=uiP=qaG0RtnUB8GhmLSTeu2Jh7pSMcw7hAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALMp9eRC4Sq8Kj=uiP=qaG0RtnUB8GhmLSTeu2Jh7pSMcw7hAw@mail.gmail.com>

On Mon, Mar 09, 2026 at 05:08:09PM -0700, Jim Mattson wrote:
> On Mon, Mar 9, 2026 at 5:00 PM Pawan Gupta
> <pawan.kumar.gupta@linux.intel.com> wrote:
> >
> > On Mon, Mar 09, 2026 at 04:05:55PM -0700, Jim Mattson wrote:
> > > On Mon, Mar 9, 2026 at 3:29 PM Pawan Gupta
> > > <pawan.kumar.gupta@linux.intel.com> wrote:
> > > > > Is it reasonable to assume that without the presence of BHI_CTRL, the
> > > > > non-Linux OS we've been discussing will (ironically) only use the long
> > > > > sequence if the hypervisor advertises BHB_CLEAR_SEQ_S_SUPPORT? That
> > > > > is, without BHB_CLEAR_SEQ_S_SUPPORT, does it assume the short sequence
> > > > > is adequate?
> > > >
> > > > I don't know. But, it doesn't seem logical to assume short sequence is
> > > > adequate when the guest can't ensure that VMM would do BHI_DIS_S for it. It
> > > > should be the other way around.
> > >
> > > Assuming BHI_NO is clear...
> > >
> > > If the hypervisor offers to enable BHI_DIS_S for you, then the
> > > migration pool may contain SPR+, so you need the long sequence if
> > > you're going to clear the BHB in software rather than accept the
> > > hypervisor's offer.
> > > You are saying that if the hypervisor does not offer to enable
> > > BHI_DIS_S for you, then you know nothing, so you need the long
> > > sequence.
> >
> > This is all when MSR_VIRTUAL_MITIGATION_* is enumerated by the VMM.
> >
> > > How would a guest that refuses BHI_DIS_S ever be able to use the short sequence?
> >
> > Without those MSRs a guest could ignore the migration case, and use the
> > short sequence.
> 
> Ah. So, a hypervisor only advertises MSR_VIRTUAL_MITIGATION_* when the
> migration pool spans the change in BHB size?

Not really, virtual MSRs can be exposed to guests with and without the
migration pools.

> Why not just declare that explicitly? This whole mechanism seems to be
> an exercise in obfuscation.

What I meant was without the virtual MSRs, a guest has no way to know
whether it could be in a migration pool that spans the change in BHB size.
It has to assume one way or the other.

When the virtual MSRs are enumerated we can better handle the migration
cases. A guest would set/clear BHB_CLEAR_SEQ_S_USED based on whether it
deploys long or short sequence. And When the guest migrates, a VMM would
update the guest's mitigation under-the-hood based on:

	if guest BHB_CLEAR_SEQ_S_USED == 1:
		if host.CPUID.BHI_CTRL supported:
			Set guest.virtual.SPEC_CTRL[BHI_DIS_S]
		else:
			Do nothing, short sequence is sufficient
	else:
		Do nothing, guest indicated that it is not using short sequence
