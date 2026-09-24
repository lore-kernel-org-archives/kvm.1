Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699A141D23C
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 07:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233210; cv=none; b=ZtGEKijT8NSli+phwqnSYG6fhDmW+ttlgeN01Fui26RG08g3j0/RBgTnIUYk5uYFoV6r+TOHDkjH8auHe7sDFfonLn45PiHvZYt+yY59bC4snyfHD6n5U84U092UN3rOCJWB8TRl72LUwmzdMIgSbsPnDQW8OdDPZ9HAtO8v+Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233210; c=relaxed/simple;
	bh=triJqsH08gfx1bk/klGXRUvQJFhFQM9DOGeTaj8BpYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1rLXkoZhWwZ0gkAxom6hSBcq2hHwY0KZ1Z0e/QK2ck9J92kfpbWVuQN6+xm76vgQUPSJwGuiVKyInMqZt45wSemENYhHqqukcYxHcM041B8YQgEreygMYOnyUBdBqQp1xZ0UCdA187+EU+tRbaXi8fJr/OdRQoKJ8zJIeUhnb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AK9GesSy; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AK9GesSy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790233203; x=1821769203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=triJqsH08gfx1bk/klGXRUvQJFhFQM9DOGeTaj8BpYw=;
  b=AK9GesSy8srzrEI9Wi5bFpcLswEe0gJ5ntbU7Q0X5sNssPFiC8gmW/gF
   f3dLhMShYOje72bepq2NgjDgYVj8HH7TB/dwdoe+dPKflYXvr894ASxki
   Cnt/Gjy9MYBLUfopN9PXVPvSZu9o2dXoTeDbbbzFUxMkIPS2OJcHN+xlD
   15x4CLwRxdWZHf6BumBS1C9eoz9RmdyNoWWnXPzhSXlhvdJZZ9ww9oqMR
   RK8KyqDzCV7rSlGm2VSw9437b5u/8PpUVfOwzQp9MZiPuCS64DSilA2ME
   LcW0FfXYM4jhhedi/MKLM5cjB8O7xMF47Ft+eZaKVdeT6OjoMd2AaomV8
   w==;
X-CSE-ConnectionGUID: GVNbRpE+QbCg7gkt5poQww==
X-CSE-MsgGUID: DT/+lsD1S9uUNBK1dWRIbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="89951251"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="89951251"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:59:56 -0700
X-CSE-ConnectionGUID: 81kSphXITD+xFmeWYilcgA==
X-CSE-MsgGUID: aShLXz6pSlCjjb5xNflwJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="282037061"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.13])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:59:47 -0700
Date: Thu, 24 Sep 2026 09:59:44 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>,
	=?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
	Jon Grimm <Jon.Grimm@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Steven Price <steven.price@arm.com>,
	Anup Patel <anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	Jakub =?utf-8?B?UsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	Vishal Annapurve <vannapurve@google.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: Add optional KVM_CAP_LIVE_MIGRATION
 and KVM_MIGRATE_CMD
Message-ID: <arTKYMyP8JeQ5wly@tlindgre-MOBL1>
References: <aquL7kNJsjnY0mJ4@tlindgre-MOBL1>
 <b5906521-858b-487b-a262-7a86891a0731@intel.com>
 <aqzS_mCOT6YuHKxN@tlindgre-MOBL1>
 <e2f8b93a-fd42-4ee6-8b74-759d3052258a@intel.com>
 <arDUOl2WPKRxwrZW@tlindgre-MOBL1>
 <da65fe89-e7cf-461b-88bc-4f40f81a6ec1@intel.com>
 <arIRTIm4Q9ElodIX@tlindgre-MOBL1>
 <1f481f4a-716d-47fd-97b1-8fa872d39797@intel.com>
 <arNr18dSS5P6Kf4e@tlindgre-MOBL1>
 <21aa5868-b8c3-46a8-a6cb-61c164fd55de@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21aa5868-b8c3-46a8-a6cb-61c164fd55de@intel.com>

On Wed, Sep 23, 2026 at 10:53:28PM -0700, Kishen Maloor wrote:
> On 9/22/26 11:04 PM, Tony Lindgren wrote:
> > On Tue, Sep 22, 2026 at 05:38:43PM -0700, Kishen Maloor wrote:
> >> On 9/21/26 10:25 PM, Tony Lindgren wrote:
> >>> On Mon, Sep 21, 2026 at 08:57:45PM -0700, Kishen Maloor wrote:
> >>>> On 9/20/26 11:52 PM, Tony Lindgren wrote:
> >>>>> Then for KVM tracking the role, I don't think we need it with the two
> >>>>> above. The role tracking can always be added if really needed. Any other
> >>>>> opinions on this one?
> >>>>
> >>>> I do think it's useful for generic KVM to track this role (1 byte).
> >>>> - It lets _TRANSFER_ style calls dispatch directly to import or export 
> >>>>   callbacks based on the role.
> >>>> - Even if we don't adopt the _TRANSFER_ style, it enables generic KVM to
> >>>>   reject mismatched calls, e.g., KVM_EXPORT_MEMORY on a destination.
> >>>
> >>> Having KVM do generic checks on the calls is a good idea. There might be
> >>> a simpler way of handling it though. Rather than having KVM track the
> >>> migration state, how about we add a function to check for the migration
> >>> session state from the vendor code?
> >>>
> >>> So something like this for the states you suggested earlier:
> >>>
> >>> enum kvm_lmstate {
> >>> 	KVM_LM_NONE,
> >>> 	KVM_LM_SOURCE,
> >>> 	KVM_LM_DESTINATION,
> >>> };
> >>>
> >>> With something like this to get the state from the vendor code:
> >>>
> >>> enum kmv_lmstate kvm_arch_get_lmstate(struct kvm *);
> >>>
> >>> For x86 it would end up calling kvm_x86_call(get_lmstate)(kvm) and for
> >>> the TDX specific case tdx_get_lmstate().
> >>
> >> How is this simpler? It trades one byte in a KVM struct for a new generic
> >> enum, a new kvm_arch_get_lmstate(), a new kvm_x86_ops entry, and a vendor
> >> implementation per vendor, plus a cross-layer call on every command just
> >> to learn the role.
> >> Directly checking a stored byte (0=unset/1=src/2=dst) seems simplest, no?
> > 
> > It would avoid dragging KVM into the "track the migration state" business
> > at least for now.
> > 
> > I guess the question in general is: What does KVM need to do with the
> > migration role beyond generic checks on the migration related calls?
> 
> I haven't thought of any other uses for it. But if we do want those generic
> checks, I'd still lean toward the stored byte.

We can easily add the KVM role later on if real KVM generic need for
carrying the migration role comes up. We can just have the vendor code
do the checks for now.
