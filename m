Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D5F38737A
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790143460; cv=none; b=hECKFAwRj+jO16tYQ7Z2jT6LZfV7NYM5I9aB7SfIAw3ZXwGlrDxtT6Uv8zPdnNGspAj0puzh/ZlnKxeNx8yqCvzJDU0CpASsPEqalgNjCxXayJSrBnipjCVHD3jFUhVO6/TncQy02lMm1+Xp0gxx6m/d6Z1pRDhxpeMFL5urLIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790143460; c=relaxed/simple;
	bh=ZypDEqmBTokIXhlQdHP0yrXRfoiVpZ7CPvDHJcAI3dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRQNhaDil1sIpR3wRtRJqPs4aRHKBkJb/b5z3s5xrfAWNTi/kEc8YbGLfnnPGV9POKYiTKrU1b+/tKL09mVUYVKTH1weHZgUjEDKWre8dFCndCI/R/kx9AJlLtVcSuRUnyBP5/nZfycPXWbCeSxKHkGCcVz5xGkOTs+D5BSbasU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C55gCJDh; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C55gCJDh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790143458; x=1821679458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZypDEqmBTokIXhlQdHP0yrXRfoiVpZ7CPvDHJcAI3dk=;
  b=C55gCJDhO/ISHoXwj2xDrZG0anL7TOueuS4Qz824GRNuEJnDRU/NbC4g
   Rjc6y0w0FViuosujLQnaPrNIwqhN5Hc8wVKwZ9mo0z+Pg0jfuy5k/LIGm
   3UguuTkYFFoaxegT0Qek6VtjQSDVcO+ja7M/tJKRpUo+VKYl6GiNLUshg
   vuLJXvmA82BB2+ASB/hogWYdjvifzKyAUMx9qhPGIX6fID8YXyMM3mqRN
   Y+d2Ea1w+Wmsewb+1Sb8QmH904o1yJvD4/481VxLGNPf3deSzdGp+865/
   gI5bBWsBA7f4AIW5JkAAhBPO55Fd7bPnze5OsYwpWahQpARhmoqEpjzwU
   Q==;
X-CSE-ConnectionGUID: UxnnTU0lSHmybnW9txZCuA==
X-CSE-MsgGUID: NfVdQ9BnTI6WHkfJkeJRmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="101394379"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="101394379"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 23:04:17 -0700
X-CSE-ConnectionGUID: T2KRBMpkR1qyJrJE2SW8rA==
X-CSE-MsgGUID: ViBB8HsMS3y9ttel/sYwtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4532972"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO localhost) ([10.245.246.235])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 23:04:10 -0700
Date: Wed, 23 Sep 2026 09:04:07 +0300
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
Message-ID: <arNr18dSS5P6Kf4e@tlindgre-MOBL1>
References: <aqoknAli8A0Mc4HR@tlindgre-MOBL1>
 <3ee06a84-2c4b-4b2f-9899-68fc92b6daf7@intel.com>
 <aquL7kNJsjnY0mJ4@tlindgre-MOBL1>
 <b5906521-858b-487b-a262-7a86891a0731@intel.com>
 <aqzS_mCOT6YuHKxN@tlindgre-MOBL1>
 <e2f8b93a-fd42-4ee6-8b74-759d3052258a@intel.com>
 <arDUOl2WPKRxwrZW@tlindgre-MOBL1>
 <da65fe89-e7cf-461b-88bc-4f40f81a6ec1@intel.com>
 <arIRTIm4Q9ElodIX@tlindgre-MOBL1>
 <1f481f4a-716d-47fd-97b1-8fa872d39797@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f481f4a-716d-47fd-97b1-8fa872d39797@intel.com>

On Tue, Sep 22, 2026 at 05:38:43PM -0700, Kishen Maloor wrote:
> On 9/21/26 10:25 PM, Tony Lindgren wrote:
> > On Mon, Sep 21, 2026 at 08:57:45PM -0700, Kishen Maloor wrote:
> >> On 9/20/26 11:52 PM, Tony Lindgren wrote:
> >>> Then for KVM tracking the role, I don't think we need it with the two
> >>> above. The role tracking can always be added if really needed. Any other
> >>> opinions on this one?
> >>
> >> I do think it's useful for generic KVM to track this role (1 byte).
> >> - It lets _TRANSFER_ style calls dispatch directly to import or export 
> >>   callbacks based on the role.
> >> - Even if we don't adopt the _TRANSFER_ style, it enables generic KVM to
> >>   reject mismatched calls, e.g., KVM_EXPORT_MEMORY on a destination.
> > 
> > Having KVM do generic checks on the calls is a good idea. There might be
> > a simpler way of handling it though. Rather than having KVM track the
> > migration state, how about we add a function to check for the migration
> > session state from the vendor code?
> > 
> > So something like this for the states you suggested earlier:
> > 
> > enum kvm_lmstate {
> > 	KVM_LM_NONE,
> > 	KVM_LM_SOURCE,
> > 	KVM_LM_DESTINATION,
> > };
> > 
> > With something like this to get the state from the vendor code:
> > 
> > enum kmv_lmstate kvm_arch_get_lmstate(struct kvm *);
> > 
> > For x86 it would end up calling kvm_x86_call(get_lmstate)(kvm) and for
> > the TDX specific case tdx_get_lmstate().
> 
> How is this simpler? It trades one byte in a KVM struct for a new generic
> enum, a new kvm_arch_get_lmstate(), a new kvm_x86_ops entry, and a vendor
> implementation per vendor, plus a cross-layer call on every command just
> to learn the role.
> Directly checking a stored byte (0=unset/1=src/2=dst) seems simplest, no?

It would avoid dragging KVM into the "track the migration state" business
at least for now.

I guess the question in general is: What does KVM need to do with the
migration role beyond generic checks on the migration related calls?
 
> > It would allow KVM to do the generic checks for the migration related
> > calls you're describing. And having KVM start tracking the state can be
> > still added later on too if it is needed.
> 
> I think we'd need to pick one way or the other before the UAPI settles
> if we want generic KVM to reject mismatched calls. OTOH if we want to
> defer this generic KVM validation, then yeah, it could be settled later.
> 
> > 
> >>> The transfer direction is there with the EXPORT/IMPORT naming. Maybe
> >>> just let's keep that naming for easier readability rather than try to 
> >>> switch to TRANSFER style naming. No transfer direction flag needed.
> >>
> >> I can't say I have a clear preference between EXPORT/IMPORT vs _TRANSFER_.
> >> If we keep the EXPORT/IMPORT naming, then consistency would arguably call for
> >> splitting MIGRATE_CMD too, which makes it 6 vs 3 (or 5 vs 3 against the RFC
> >> as posted):
> >>
> >> EXPORT/IMPORT style              _TRANSFER_ style
> >> KVM_EXPORT_CMD                   KVM_MIGRATE_CMD
> >> KVM_IMPORT_CMD
> >> KVM_EXPORT_MEMORY                KVM_TRANSFER_MEMORY
> >> KVM_IMPORT_MEMORY
> >> KVM_EXPORT_VCPU                  KVM_TRANSFER_VCPU
> >> KVM_IMPORT_VCPU            
> > 
> > Agreed we should split the MIGRATE_CMD too. Probably the number of ioctls
> > is not and issue compared to following the KVM style and better
> > readability. So my vote is now on EXPORT/IMPORT style naming.
> >  
> >> I guess the main benefit of the _TRANSFER_ style is reduced duplication. 
> >> Each EXPORT/IMPORT pair takes the same struct and differs only by the role
> >> that the session already knows. Merging them gives one entry point per call
> >> type and lets userspace drive both ends from the same call site which could
> >> be considered a win. It doesn't reduce kernel code though as the top-level
> >> handler still branches internally on the role.
> > 
> > Yup not much of a win for the TRANSFER style naming.
> 
> Yeah, my goal was just to enumerate alternatives for consideration.
> 
> One other benefit of KVM_EXPORT_CMD/KVM_IMPORT_CMD is that the per-session
> role is implicitly conveyed - in other words, a successful KVM_EXPORT_CMD/SETUP
> (for e.g.) would indicate that this is a 'source'. So, we wouldn't require a 'role'
> field in struct kvm_migrate_cmd to explicitly assert one during SETUP.

Yes good point with the KVM_EXPORT/IMPORT_CMD, that sounds good to me. 
 
> > Trying to summarize again after we sorted out the direction flag issue in
> > the transfer:
> > 
> > role            per migration session (cannot change during the migration)
> > direction       per command, EXPORT/IMPORT
> > hardware state  set and tracked by vendor specific code
> 
> The 'role' and 'direction' as you define it above are essentially saying the
> same thing - a source only invokes the vendor's EXPORT call, a destination only
> invokes the vendor's IMPORT call, and the role doesn't change over the session.
> If a destination needs to send data to be consumed by the source, then that
> still invokes the vendor's EXPORT call.

Yup.
 
> > And checking again against the dmaengine analogy:
> > 
> > Compared to dmaengine, the migration role is modeled similar to the dma
> > channel configuration.
> > 
> > The migration direction with EXPORT/IMPORT is modeled similar to
> > dmaengine_prep_slave_sg().
> I'll leave the dmaengine comparison to you, I don't know that API well enough
> to map it properly :)

Heh just a sanity check for trying to relate this to something existing.
