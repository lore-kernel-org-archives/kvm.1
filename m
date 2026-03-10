Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A792D2B9A4;
	Tue, 10 Mar 2026 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773100830; cv=none; b=iXLImTtfxAOc1OMuw47ZbPsnYkJgaYw6F/p6BoTKgNkOaG149s/cBxKW4ilqTmZU5ec+9Z2F7Ye+/dvccplY6+XNtKulfrvMZw1ptNEb1sbwm4b3Ph/AZhrkgPAXUw/6KBkYQ0T2AHeZzU+7k+S41JBI+VbR4uqlHPQnilFhbDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773100830; c=relaxed/simple;
	bh=phHbyebq8z5Qx+1T6aJ34Y7ejk3gl5L9LxBybwOz3mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZtRi0NSbb0O67OsC0FiI304luS4jaP3MjYOxVzbo4aEQExWWoePaaHvQedQ/PD0Cr8pLVsNwkQD2ryb3qLj5RtpI4vAdTAJFE9BGHQPAjbtZ8wOIgrz31gCY1gKvbjjqoCpgyfqPpW1KUzp2d7llwgT71zKzVuFNLdXZPXFXr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UG7dlUpd; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UG7dlUpd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773100829; x=1804636829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=phHbyebq8z5Qx+1T6aJ34Y7ejk3gl5L9LxBybwOz3mM=;
  b=UG7dlUpd4+6NdKZ9Jd8VE5dobZwo2nU8hgjypXzlU8W5attZ5KHvenNN
   7SluszIaoSiedy2zZZegKCqK0aylZL4FD0xJJcDkNfdtuvyBW6WkRdE/r
   bWgo5HW+UwQ1PXyC6G90qi55qFyE12lahAdhaKMRJeTo++F5rnY+a42Wj
   8XxfVD2VhkpXaAwcXxOZMibDN+dLux4gzDI30yGM7gIl14TWZ0WEaOraF
   gXPNMLD4m4jFbExBZiPR6bpWvQC5uweispZCO3gKhDJkG4t8knRfj5utq
   jAfpwJyfxP0gNeelAqWyRN4P3nLfVVI4upzaylRXlDB9B5mk+moD/zxUi
   g==;
X-CSE-ConnectionGUID: o7oK7/4KQ4GfL0vTAONiPQ==
X-CSE-MsgGUID: LfIl8y3yS6WhBcuJZBxWjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="96757672"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="96757672"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 17:00:28 -0700
X-CSE-ConnectionGUID: e5slDVkCQa6lgrDrM1ulLA==
X-CSE-MsgGUID: X0Po7KXpScG0D/hySUD7mQ==
X-ExtLoop1: 1
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 17:00:27 -0700
Date: Mon, 9 Mar 2026 17:00:20 -0700
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
Message-ID: <20260310000020.pxig2fy7tjfex7jh@desk>
References: <20260306223225.l2beapz3nvmqefou@desk>
 <CALMp9eQoE13d1cqD3PNJtvdKUGZeVm1g-9TWh+M+MJj_sm9CzA@mail.gmail.com>
 <20260306232920.dja5n7cngrsyj6tk@desk>
 <CALMp9eSoNaifKyppbjJjNx1YEw9KFv0LGAJ6xD-ko0zJnNXEbw@mail.gmail.com>
 <20260307010051.u4ugg3nyvsu6hwbg@desk>
 <CALMp9eQGZcekQ3QtL=J7TqHJ9YfZ+SbrgY5P8fp14p4KNThYmw@mail.gmail.com>
 <20260307024132.wleqtpovzd6wtvm7@desk>
 <CALMp9eTO0irFX9sZaVU84r1aW5E7Q2B3bE8uWfgViSug6Hx+og@mail.gmail.com>
 <20260309222935.2wu6xhydsgikkjpn@desk>
 <CALMp9eRu1YYFiqzMbNKOOhwwy-FqrSOvw-ddTuNtiSZbNs7JLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALMp9eRu1YYFiqzMbNKOOhwwy-FqrSOvw-ddTuNtiSZbNs7JLg@mail.gmail.com>

On Mon, Mar 09, 2026 at 04:05:55PM -0700, Jim Mattson wrote:
> On Mon, Mar 9, 2026 at 3:29 PM Pawan Gupta
> <pawan.kumar.gupta@linux.intel.com> wrote:
> > > Is it reasonable to assume that without the presence of BHI_CTRL, the
> > > non-Linux OS we've been discussing will (ironically) only use the long
> > > sequence if the hypervisor advertises BHB_CLEAR_SEQ_S_SUPPORT? That
> > > is, without BHB_CLEAR_SEQ_S_SUPPORT, does it assume the short sequence
> > > is adequate?
> >
> > I don't know. But, it doesn't seem logical to assume short sequence is
> > adequate when the guest can't ensure that VMM would do BHI_DIS_S for it. It
> > should be the other way around.
> 
> Assuming BHI_NO is clear...
> 
> If the hypervisor offers to enable BHI_DIS_S for you, then the
> migration pool may contain SPR+, so you need the long sequence if
> you're going to clear the BHB in software rather than accept the
> hypervisor's offer.
> You are saying that if the hypervisor does not offer to enable
> BHI_DIS_S for you, then you know nothing, so you need the long
> sequence.

This is all when MSR_VIRTUAL_MITIGATION_* is enumerated by the VMM.

> How would a guest that refuses BHI_DIS_S ever be able to use the short sequence?

Without those MSRs a guest could ignore the migration case, and use the
short sequence.
