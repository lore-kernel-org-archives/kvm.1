Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD69B383C66
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070152; cv=none; b=tQuaxRBmJiFBnBDTrLBRtfi/i5sj7NSO5ZwLD0uosb/8J66DS3h1z6kBC/nITQaLmtN9jGpzWPo++MzheQQQ/g8qeNZCJgYsl9Xnwdtscdm26Ohi88hfVhDcPkLXbZdA2EEj47Bdb8tw9HpiXyeDSzaPZj+qsao04fjHeFs2swQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070152; c=relaxed/simple;
	bh=WijWvt34lV07O0Rx0uCWba3yNRm7gWl8HBsmGFjNH3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdTef7LkzhTCxAzNq/zN2FwAMr3qruYWRjIBRjIQbxq9aD/EaOqgPTt7HnaxVG+n0JXHSIsrbrrEfMSeB1JoV/LQl4JJJ/QBnJNlDlWOvHnGLt6jzj/MsZyAs5OkyhbQEwAiLBrq1Wf4poGahHLbhboeKviDu7iz+CPqREKywlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PaM6NeeG; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PaM6NeeG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790070149; x=1821606149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WijWvt34lV07O0Rx0uCWba3yNRm7gWl8HBsmGFjNH3I=;
  b=PaM6NeeG2C7aWcKd8cBKfYi4voytfrByqG5rWx3MfVBe9w2fUfG7n+nt
   lcOov+QYX6R72pqva1e94G1JedtZAm7pfUbe3TLVvt6QPEn8/+/JXrZxc
   02mtiirRppQjsZdU8r4BFZH2oeeuUwKRsLa7rjInH6vOTp0EaRdBbWndg
   yzp30n2fc8NmjJjIxD8L338RVeJv9SSiq8Y2Vto4ytlu8wMMgKXTS1sqx
   SA6iocXdQO3wWF1WFwtl2kyNJ43AF9XikIGKpp7MOZyqQp1XCGMrZWcCc
   SCo8mTu6C2gzKZTQzyo3ERCtd/nlQnFgtZP5PDQsZ8Z52pa3lS09uuo5r
   w==;
X-CSE-ConnectionGUID: HqiFIzinRQ2kS1Q4IHnJ9g==
X-CSE-MsgGUID: cWh1PMPDRe2bqJyJCVmGkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90674324"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="90674324"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 02:42:29 -0700
X-CSE-ConnectionGUID: foLc/dGpRwCZnR54pO1d4A==
X-CSE-MsgGUID: /rZdOzQDQT2odsRFhtGZ0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="300991292"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.202])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 02:42:21 -0700
Date: Tue, 22 Sep 2026 12:42:18 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Fabiano Rosas <farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Steven Price <steven.price@arm.com>,
	Anup Patel <anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	Jakub =?utf-8?B?UsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Kishen Maloor <kishen.maloor@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
Message-ID: <arJNemNy_SK3mt_c@tlindgre-MOBL1>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
 <aq1ehHk7OUYaGCe5@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <f2889dd6e44333b2a5bbd4bd32a4557c3b50a3cc.camel@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2889dd6e44333b2a5bbd4bd32a4557c3b50a3cc.camel@gmail.com>

On Tue, Sep 22, 2026 at 11:09:42AM +0300, Artem Bityutskiy wrote:
> On Fri, 2026-09-18 at 11:53 -0400, Peter Xu wrote:
> > Unexpected, that's a lot just for tracking.
> 
> I assume because it brings various seamcall wrappers and some shared infra
> code. But also Tony might have over-estimated - I'll let him comment on
> this.

Yes dirty log support is currently about 20% of the number of patches for
the POC. About 100 LOC changes, about 75% it is TDX specific code with
SEAMCALLs and and the scanning functions.
 
> > > I already raised this with the Intel TDX module architects, and they asked
> > > for use-cases. The only one we came up with is QEMU estimating the TD dirty
> > > rate before starting migration (the calc_dirty_rate command). I understand
> > > their position: without a use-case there is little reason to implement it,
> > > and they would also need to study the security implications - can it help
> > > an attacker in some way?
> > > 
> > > So if you or anyone else can educate me about use-cases for independent
> > > dirty page scanning, I would really appreciate it - I could take them back
> > > to the TDX module architects.
> > 
> > Yes, calc_dirty_rate will use it, I also can't think of another use case
> > that needs it.  RHEL supports it, so it would be nice this will be
> > supported for CoCo too.
> 
> Do you or someone else know how important it is to have it working?
> Do actual customers use it in real setups and rely on it?
> How bad or painful is it if this feature is not available?
> 
> The reason I am asking is that my assumption was that it is not important.
> But if it is, I will come back to the TDX module architects with a
> request to revise the design to support independent dirty page tracking. Of
> course they may have some reasons for not doing it, but I would try at
> least.
> 
> > QEMU also has another way to do it without KVM tracking, which is kind of
> > simle page hash daemon fully done in userspace. But in case of CoCo it'll
> > stop working too when most memory unreadable.  So GET_DIRTY_LOG seems the
> > only way to go.
> > 
> > We can still "emulate" it by initiating a remote migration just to collect
> > this info, I believe all attestations will simply pass and we do a fallback
> > when the admin turns it off.. but it's awkward and all the rest (including
> > trying to find another host suitable for migration, allocate resources..)
> > are pure wastes.
> 
> Understood, thanks - sounds like this workaround is doable, but wasteful,
> something to avoid if possible. That in itself is useful evidence I can
> bring back to the TDX module architects.
> 
> Just to understand the real-world deployments better: do you know if anyone
> actually falls back to this workaround today, or is it more of a theoretical
> idea that nobody actually uses?

Interesting workaround :) I too agree that proper dirty log support is the
way to go. To me it seems non-migration dirty log support can be added to
the TDX module as an additional feature. And adding it probably would not
even need KVM changes except a new flag for the scan SEAMCALL.
 
> > Btw, do you know if the private pages will be write-trappable by the host
> > kernel, with things like userfaultfd-wp or soft-dirty?  That'll be another
> > way to do this without TD involvement, but I don't know well enough to say.
> 
> The short answer is - no, private pages are not write-trappable outside of
> a migration session, so trapping cannot be used as a workaround for
> independent dirty tracking today.
> 
> But a bit longer answer is that the TDX module provides 2 alternative dirty
> page tracking mechanisms, and one of them is in fact a write-trapping
> mechanism. In the TDX specs, these mechanisms are called Write-Blocking
> Export and Non-Blocking Export.
> 
> - Write-blocking: the VMM write-blocks pages using `TDH.EXPORT.BLOCKW`, and
>   gets a VM exit (an EPT violation) when the TD attempts to write a
>   blocked page.
> - Non-blocking: based on Secure EPT scanning, using `TDH.MEM.SCAN.RANGE`,
>   which was mentioned earlier in this cover letter. I refer to it as dirty
>   scanning.
> 
> Today, both mechanisms are only available during migration and require the
> migration setup to be done first - neither can be used as a standalone. In
> our PoC we use the dirty scanning mechanism, as we expect it to be more
> performant.
> 
> But our PoC actually started with the write-blocking method. According to
> Kishen and Tony, it required a lot of ugly code and was very intrusive into
> the MMU code. But I'll let Kishen and Tony provide more details.

Yes write-blocking has issues with being intrusive. Exported pages are
locked by the TDX module and only cleared on import or after a cancel
operation. KVM MMU error handling gets tricky. The non-blocking migration
makes the tricky parts go away at the cost of adding TDX specific code
to handle the GET_DIRTY_LOG scanning.
 
> Anyway, if I can get the TDX module to allow dirty tracking independent of
> migration, we could pick either mechanism, or even implement both and add a
> TDX-specific ioctl to select which one to use. We could plug either method
> into the KVM_DIRTY_LOG ioctl - both would work, just differently.

Note that for TDX write-blocking is an older approach. The non-blocking
SEAMCALLs were added because of the issues noticed. Both features are not
usable the same time.

If non-blocking is enabled for a TDX module write-blocking cannot be used.
Also note that the dirty log scan features depend on non-blocking features
being enabled.

IMO no reason for Linux to try to support the write-blocking migration at
all.
 
> = Dirty Scanning Optimization in TDX Module =
> 
> Now, I am diverging, but just in case: in the PUCK call where we presented
> TDX migration, Sean made an immediate observation that WP-based dirty
> tracking is not categorically worse than PML-based dirty ring tracking, it
> depends on the workload. Then he learned that TDX module's dirty scanning
> does not use PML, and was understandably surprised. Sean was concerned about
> dirty scanning performance.
> 
> So what I learned then about dirty scanning is that it is optimized for
> minimizing the downtime. Before the source TD is paused, there are a couple
> of seamcalls to invoke, let me refer to them as prescan seamcalls.
> 
> They scan the Secure EPT while the source is running, and mark the
> sub-trees that do not have migration candidates as "clean". Then during
> the actual final dirty scan in the downtime window, the scan can skip
> those entire sub-trees and be more efficient.
> 
> Sean correctly pointed out that this would be problematic because on Intel
> CPUs the EPT dirty flag is set only at leaf level, and does not propagate
> all the way to the root level. However, what I learned is that the TDX
> module uses the "accessed" bit instead of the dirty bit in this prescan
> optimization - the accessed bit does propagate all the way to the root
> level. I thought this was a nifty trick, but obviously it would also mark
> sub-trees as "not-clean" on read access.
> 
> Now, I personally did not benchmark this optimization, but I heard that
> some people did and the results showed acceptable performance.
> 
> > It just sounds like if it's doable in KVM, it's still the best place, also
> > since GET_DIRTY_LOG is available as long as memslot marked tracking, it
> > sounds good to keep CoCo be compatible with that API if it is to be reused,
> > hence GET_DIRTY_LOG API is consistent across coco / non-coco.
> 
> 
> Yes, that's exactly the goal and the proposal: QEMU would use GET_DIRTY_LOG
> API regardless of the VM type. In TDX guest case, KVM would use TDX-specific
> dirty page scanning seamcalls to implement the GET_DIRTY_LOG API.

Yes.
