Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBC235DA41
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 05:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535405; cv=none; b=dIZ11r39eUGTGGRIg4Ac6uND+A/de8jLQzfnlwIu7xxMD0qNx39Sy/7px5reijCw0yRw+jPGJUWjlKw56V0homwmCujtQVfnik+sbg/rqiAI4rOeEL+dAFewhg0n/pGQgTSeww6azqRfD+K4KSTZ635sviY1y3wjXE6IEO91BrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535405; c=relaxed/simple;
	bh=qKdxfXkMfSh4FamBWlqynr5J72eabbL9tAi+VLmj058=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6+yioLe5QAOA7hM+56w40oCKevToRrwBpzQg9fT7R7HMnizH8D3LSawZ/vG0kzo0SL3b+Vx31wh+DnXu7nVvN5wX6tpbKvc+nYuAgBEUz8BXKpLe9mYO9ZwKCk7xzjD5yX4WO4KojvWxHzlHTKnpNbTY1lCscXHT9NNCpJSkNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YTTOK8OU; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YTTOK8OU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789535401; x=1821071401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qKdxfXkMfSh4FamBWlqynr5J72eabbL9tAi+VLmj058=;
  b=YTTOK8OUqsMZXzE4F2cg8SjeMNBRjZWLQHbSPfxkuoMhJe6/yqAop87o
   QqxUgbhvTEHnjAFQL37L64eF5ypTHhSFjfNpQiWCOuQqtMz1+FP6VtWBo
   4d+U2XpswtYKidX+38NlmXDkdZ8fAxCmVLu8oEqib17FTysOIdbmmrdz8
   /F0DRn9RiteRhoUK1vF7LiqevNeZQ4nxfVk2EiHS/jxDOnWP9hM6b36kc
   oRl26MZrmXpgThiuM4mdL1ja6XG6x/tOgrCMYEdPRQkHGESjhY/iZ+bFd
   3KJGJEy5fdRgV/bKgEd8J49O39dZMnsaOOVIZkYUo82eX/t3ZC6E1DE5b
   g==;
X-CSE-ConnectionGUID: zfgqTmItQF+UNVR/Cudb5g==
X-CSE-MsgGUID: nAzNKeMNTwavRuevtz2Tmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77468762"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77468762"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 22:09:59 -0700
X-CSE-ConnectionGUID: iUZ9uUeoRUWZTyRE1yEZsg==
X-CSE-MsgGUID: g6yXnWmITjae8NzFWD2Z/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="311495886"
Received: from szadworn-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.45])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 22:09:52 -0700
Date: Wed, 16 Sep 2026 08:09:48 +0300
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
Message-ID: <aqoknAli8A0Mc4HR@tlindgre-MOBL1>
References: <ap-SihGd0fk02QV8@tlindgre-MOBL1>
 <4c07e70e-7639-4141-b602-1c09c9c7510c@intel.com>
 <aqEDQ5Qrv724gGzN@tlindgre-MOBL1>
 <0cf5b79e-521d-4c7c-97f2-673c51d42bbd@intel.com>
 <aqJPLEX51DSCF1zC@tlindgre-MOBL1>
 <be09b02d-c993-40ad-a690-753a7a50677c@intel.com>
 <aqOCPVoFAFMv8ZYo@tlindgre-MOBL1>
 <085c28db-31e3-4249-a9be-a2f9d7156719@intel.com>
 <aqjNFLv5VrmB_fdx@tlindgre-MOBL1>
 <e090caa0-be97-46cd-bde8-374f2522c986@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e090caa0-be97-46cd-bde8-374f2522c986@intel.com>

On Tue, Sep 15, 2026 at 08:53:18AM -0700, Kishen Maloor wrote:
> On 9/14/26 9:44 PM, Tony Lindgren wrote:
> > On Mon, Sep 14, 2026 at 05:14:32PM -0700, Kishen Maloor wrote:
> >> On 9/10/26 9:23 PM, Tony Lindgren wrote:
> >>> On Thu, Sep 10, 2026 at 06:40:04PM -0700, Kishen Maloor wrote:
> >>>> On 9/9/26 11:33 PM, Tony Lindgren wrote:
> >>>>> On Wed, Sep 09, 2026 at 06:11:11PM -0700, Kishen Maloor wrote:
> >>>>> ...
> >>>>>>
> >>>>>> As mentioned above, that is a destination launch time directive that we needn't
> >>>>>> conflate with a migration/transfer session role.
> >>>>>
> >>>>> It's still the same role though. Yes we can set it on init, but would
> >>>>> be nice to have some generic way to do it for qemu -incoming.
> >>>>
> >>>> I'd separate these.
> >>>>
> >>>> On the role: it seems we agree on recording roles per-session. My only point
> >>>> then is that a VM created through the delayed_init flow doesn't additionally
> >>>> need a destination role recorded for it if SETUP will assert one when the
> >>>> migration is kicked off.
> >>>>
> >>>> On generic plumbing for -incoming: is this about KVM_TDX_INIT_VM_F_DELAY_INIT?
> >>>> A generic mechanism would make sense to me if the flag were consumed by generic
> >>>> KVM code, but that isn't the case here. Userspace has to make a
> >>>> vendor-specific VM-init call like KVM_TDX_INIT_VM anyway, with the flag passed
> >>>> on that call. So I'm not sure what a generic version would add, unless you have
> >>>> something else in mind.
> >>>
> >>> So we could add a SETUP subcommand SET_ROLE or SET_INCOMING.
> >> It might be better to pass the role as a parameter of the SETUP call
> >> rather than a separate SET_ROLE call.
> >> A separate SET_ROLE would bring its own ordering rules relative to the
> >> other SETUP sub-commands. 
> > 
> > OK a flag for SETUP sounds good to me. SETUP is needed anyways for each
> > migration session.
> 
> To be clear, I was suggesting a field in kvm_migrate_cmd and not a flag to pass
> the role as an argument to SETUP. As I mentioned in my last comments (right 
> below), 'flags' in the current proposal carry the vendor-defined sub-command values,
> so a generic role argument wouldn't belong there.

I was thinking 8 bits for common flags and 8 bits for vendor flags but
yeah that can be a bit tight. Sorry if the SETUP above caused extra
confusion.

So trying to summarize the common flags for the role and separate vendor
flags:

struct kvm_migrate_cmd {
	__u16 command;
	__u16 flags;
	__u16 vflags;
	__u16 reserved;
	__u32 reserved;
	struct kvm_transfer_buffer buf;
};

Is the above along the lines what you were thinking?
  
> >> The specific role (src or dst) still needs someplace to go, and flags is
> >> already the sub-command selector. An option is to carve out room in
> >> the __u32 reserved field to carry a role argument, something
> >> like 0=unset, 1=src, 2=dest so KVM can verify that a role was indeed set.
> > 
> > To me it seems that 0=src can be the natural default starting point, I
> > don't think we need 0=unset.
> 
> With 0=src, the field would only carry information when it's a destination,
> thereby making it an is_dest boolean rather than a role. It would also mean any 
> VM that never established a session still reads as a source, so a 
> KVM_TRANSFER_MEMORY aimed at the wrong VM by buggy or rogue userspace would get 
> dispatched to the export path instead of rejected outright. The generic 
> dispatcher shouldn't have to rely on the vendor layer to catch that. Reserving 0 
> for 'unset' costs nothing and lets KVM reject a session that never stated a 
> role.

Ah OK, yes that would also tell "the hardware has been initialized to a
certain migration role". That seems like a usable common feature.
 
> >> It could further be written into a generic KVM struct (kvm_arch or kvm) which
> >> could be queried on KVM_TRANSFER_MEMORY, etc. to identify the relevant
> >> callback.
> > 
> > Yeah eventually some generic place for it would be nice. But that's easy
> > to add later on too.
> 
> Sure, we don't have to decide now as we're still discussing the UAPI.
> But we'd want this detail also settled sometime before we call the UAPI
> complete as it determines whether the dispatch is generic.

Yes a shared place for the role would make some generic sanity checks
easier.
