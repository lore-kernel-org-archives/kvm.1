Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949D6440640
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 21:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790111922; cv=none; b=ugQ7DAykxQekn/G+Vo5Weg7rE+ZrLm3aGJKUYRv5I8kmKBHWD6dtCpANGtvQD3Dv4+RL0RbwKq8bofHE+5KUkkpNQGmyJtk0j22VTz/MHwTZnGJBSIbBb8alfAqGgXvy3ZVJVmXcpLj4bnh+Lz84rT/wLreP6v58NtM7kVLDatg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790111922; c=relaxed/simple;
	bh=THz1j7Rt3mxKlUakP1v0P4sBb6MzmK7u8InBDLTflTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvSN26+1mgIWgmnz/3TrQsHZT2R5K4jrrDdI3moSGqSFeFL4XjZwceKPRyKvLVeVNnL+MCoLRfayChgfNZJOQZES845qUNgP0Ovb/R2kU6i6gjpclelvy9fwVzIZmjppB7Vq1dgIXxUhuQyosnhxTzKdny7+ken6OpZQDvlX11E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ck+J+UBw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1ruk9YO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ck+J+UBw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1ruk9YO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790111907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8g20MUomW2kALgnzGHxR0HRVXgDuegIX+X1slaZ3yb0=;
	b=Ck+J+UBwS+KVL8TN06VZMW0FOBlmDXtWELJEjtodMA4+zntbPzlpbDsgmt34BgNRix0pWH
	tJowSnaBhVZTPp7trbu/PaR1bH+e3WfEwv4VRmzPNRNPV/dp8DrbRkf6/71kj7SwjAq9mF
	iknlHIB4uCh8IfWkCVPnrFDPxjsGIr4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-7DzglqO3NfK-H1Thx6KYtg-1; Tue, 22 Sep 2026 17:18:24 -0400
X-MC-Unique: 7DzglqO3NfK-H1Thx6KYtg-1
X-Mimecast-MFC-AGG-ID: 7DzglqO3NfK-H1Thx6KYtg_1790111903
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5304f2b5946so6252161cf.3
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 14:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790111903; x=1790716703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8g20MUomW2kALgnzGHxR0HRVXgDuegIX+X1slaZ3yb0=;
        b=D1ruk9YOXTmwaEMTZPuXLy7liOKsc+Dhc92++aQJqE/nWMohJmZUxuLYzaBBgyhO19
         TZa3tLGn5G6p4xXe4oTMnxT05DJpHsGL6w/osPPNrpaPY9BTPnrLndFLdtkNEgn3bZ7r
         ltNfZS2miBgfhuH/itMZ6nDSdJOfX3XpoeQt5yImJ9QKjTJa7ipHrj2k6jQ4VgZku9y+
         yfrzNY941VQ71DPlmonEyRxV9gzofg1sRLxdEXgAkbsjcTPqeDr/bozE71T6ZjJor/4A
         astaEdWW2T8Ee1BxBGVLvpAp+SLVk0WIxKXoAvo3vpE05iM9LCcqhrAF665JocN1t3tv
         kVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790111903; x=1790716703;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8g20MUomW2kALgnzGHxR0HRVXgDuegIX+X1slaZ3yb0=;
        b=fTw6fAW3SMhdpMB3jrL47AHZ+nbb/nemjMPjvDQtWHuK5lODWNnl/afddFv73qzlCB
         yePdB9Xt70lswTGhL2dUn9/EeTGzey5Lf1ZSaebKYkv9WqCnoJKQOi9F/SN5sjk4CDAG
         kRbRNZ4yyyNzS3axrw86e68K9iyWzWb9cudWmC1Yu2tILGx2kZGVpM/SR+50/QkU4s1d
         0QL+LHZ5b/7BDFJd4WDxEEnnxaQ3ewptLqyHpdoFg/cxDwIMSeR1cNkl/l4nqkqPeYDL
         kRiuuXrdzTVuExBsxe46gWlqlKXniC3wj0euPQukxID9hUQp0z8JuRidB4SpUMZYQIYb
         jP2w==
X-Forwarded-Encrypted: i=1; AKwUvBwiQLOfwsBtszxnWqT9xlzDjHiHD4dr6tR8XhnQsCndVoq+vMV6DUhGOi0Bi/DP/xDFD08=@vger.kernel.org
X-Gm-Message-State: AFuF++nvukP9az4FIfWIw8uZOu77cd0T9esCwl7YNXKCLrXR5scBN7h9
	CtT8uAgGyj8Jgxs0GlpiWvSST+nzZbNLDKeraMV2nmXKk6ywz/euQajeXNmYvsLYJX8loFOeBDA
	XvvERczsalq99wUTLnq6P1UzAfV4r6tCEtmvbeT4Hz8dBkZJPy6VIsg==
X-Gm-Gg: AYBFou1Sfse4dj6+CR1fa8H05rcAnUtaVSVYlhGfK3UK5Uy4VQrFsDFEDRfxdBYGt6M
	bnEJmZbnFX8tso32F9Xne70oxTio8/uCtf0JJI7F69I2JyCCXEGLyAc9v6b6OQSkyI8rtm1ydyG
	FRozN/pWitPKGhZCStHx1kfQdU7JjG/RvuR3fEb+Y40wSLddH3og5BmAgoNDoTiC3xRfIAWsXbd
	4SDLzQL7quKieMwWjy+Im+KbSRz2HJnMIZ+QISvcCPID8YnNwYxiwzemAeoHIE1kAxbKpnFkosF
	Jf94wi6O+lvG2UgTbTB+cGIUqboDEWJDDgeH8TOoGUI60FvonN6zS0SurGBvXjbPWKuEiXg=
X-Received: by 2002:a05:622a:8c6:b0:532:d202:3285 with SMTP id d75a77b69052e-532eae0a792mr12395611cf.52.1790111903263;
        Tue, 22 Sep 2026 14:18:23 -0700 (PDT)
X-Received: by 2002:a05:622a:8c6:b0:532:d202:3285 with SMTP id d75a77b69052e-532eae0a792mr12395161cf.52.1790111902434;
        Tue, 22 Sep 2026 14:18:22 -0700 (PDT)
Received: from localhost ([142.188.212.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532eb4200c9sm5736111cf.23.2026.09.22.14.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 14:18:21 -0700 (PDT)
Date: Tue, 22 Sep 2026 17:18:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Tony Lindgren <tony.lindgren@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Fabiano Rosas <farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Steven Price <steven.price@arm.com>,
	Anup Patel <anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	Jakub =?utf-8?B?UsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
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
Message-ID: <arLwnNyM4Tkr-Oh3@zhexu-thinkpadt14gen5.rmtcaon.csb>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f2889dd6e44333b2a5bbd4bd32a4557c3b50a3cc.camel@gmail.com>

On Tue, Sep 22, 2026 at 11:09:42AM +0300, Artem Bityutskiy wrote:
> Hi Peter,

Hello, Artem,

> 
> thanks again for good comments and questions.

My pleasure if I helped anything at all.

[...]

> > Yes, thanks.  I'm willing to hear more, and I'm a bit surprised that
> > non-coco migration didn't fit already well into it, because IIUC non-coco
> > needs less in this case, not more.
> 
> Yeah, just thinking aloud now.
> 
> - Suppose QEMU and KVM support CoCo migration.
> - Does it make sense to treat traditional VM as a CoCo VM for migration
>   purposes?
>   - Not for performance reasons - mmapped memory I/O is going to be more
>     efficient than any sorts of export/import uAPIs.
>   - Yes for testing/experimental purposes.
> - Would it add a lot of code and complexity: would the benefits outweigh the
>   costs?
>   - QEMU: Should require minimum amount of code. Would need a flag like
>     "treat me as CoCo VM", may be some QEMU operator commands or cmdline
>     options.

In QEMU, we could likely stick with calling them non-CoCo VMs even if the
new migration API will work for them.

We can have a qemu flag (kvm_coco_migration_api), which will be required /
enforced by CoCo VMs to migrate.  Then if the new API will support
non-CoCo, we can export that kvm flag so non-CoCo can select it too.

>   - KVM: Not sure, but intuitively it may add noticeable amount of churn.

True.  Also because of this, personally I would not request for this to be
supported, only if you all see fit or value.

Said that, this PoC problem that Kishen described PAM in the other email
helped me to notice something very important that I overlooked, that at
least I want to understand.  I'll reply there later separately.

[...]

> > I am just thinking out loud here: if the hardware is good enough to do
> > encryption plus (some?) compression, that would be very nice.  For "some",
> > I meant minimum over zero pages.  Because in this case even if host wants
> > to play tricks with zero pages, it can't anymore when un-readable.  Maybe
> > the guest driver can play some trick, but I'm also not sure if in CoCo.
> > 
> > M > N may imply it's not the case for now, but it's still sane as a start
> > even if so.
> 
> Yeah. In case of TDX, the TDX module does not do compression today,
> and there is no zero-page optimization either.
> 
> But keep in mind that what pages in TD are zero pages is by itself a secret.
> Any sort of theoretical TDX module zero page compression optimization would
> need to be done in a way that VMM cannot figure out what pages were zero
> pages. So with a disclaimer that I am not really a security expert, I'd say
> it is far-fetched.

Agreed.  That's why I think TDX, if able to compress zero pages in that
buffer stream, will hide that information into the encrypted stream, so
it's still not visible to VMM, but should be visible to destination TDX.
But yeah, this is slightly off topic, we can skip this one for now
regardless.

[...]

> OK, so by upper bound here you mean the maximum amount of data that can be
> exported in a single memory export ioctl operation, right? And you mean that
> there should be some sort of command to query it, similar to KVM_CAP_XSAVE2
> capability returning the XSAVE buffer size? If so - yes, I think exposing
> such an upper bound would be useful.
> 
> Let's see. In case of TDX, the `TDH.EXPORT.MEM` seamcall today can export
> max. 512 pages at a time. Today only 4KiB pages are supported, so it is just
> a 2MiB buffer. So this is the upper bound for the seamcall.
> 
> So in TDX case, 512 pages would be the absolute upper bound for the uAPI
> input buffer size. The alternative is to accept larger input buffers and
> internally do multiple seamcalls. For TDX case, I do not think the latter
> makes much sense though. But, what I do think is that the uAPI itself
> shouldn't mandate one approach over the other - a different CoCo
> implementation may prefer to aggregate multiple hardware calls internally.
> 
> Also, today TDX can only migrate 4KiB pages - VMM must split larger pages
> into 4KiB pages before migration. But I expect that in the future TDX may
> implement larger pages migration too. So I think the cap should be expressed
> in page count rather than bytes.
> 
> That said, I don't think exposing this upper bound cap should replace the
> flexibility we discussed earlier: the API itself should still allow
> exporting as much as fits the output buffer, regardless of what the cap
> reports. A specific CoCo implementation could still choose to just fail if
> the buffer isn't large enough to hold all requested pages - but that would
> be an implementation limitation, not an API limitation.
> 
> And the other question is whether to allow exporting a mix of large and
> small pages, like N x 4KiB along with M x 2MiB and K x 1GiB pages. Or the
> uAPI would allow to only export one page size at a time?
> 
> If large pages are added to TDX, I'd speculate that TDX seamcall would allow
> the mixing and matching - I can see that already today the seamcall API
> is provisioned for this. uAPI could require that the input buffer (set of
> pages) can contain a mix which should match the GPAs of the corresponding
> memory regions. But then race conditions - the GPA layout of the VM may
> change by the time the request reaches the hardware: large pages can be
> split or the other way round, I guess? Then uAPI could return a "retry" sort
> of exit code, may be?
> 
> What do you think? I am just thinking aloud: looks like pages of different
> size add a degree of complexity - I did not take that into account until
> this conversation, thanks.

I apologize if my question was misleading.  My question was more about the
size of user buffer QEMU needs to prepare.  I think I got the answer from
the other email.

Still, thanks for sharing your thoughts on huge page handling.  Personally
I'm not sure if we need to identify huge pages: we can always still define
the GFNs to always represent PAGE_SIZE no matter the size of host pages,
especially in migration context, we'll need to split in the first place.
But that'll be a question to ask for later.

> 
> > 
> > Said that, we'll need to be careful then in case of migration fallbacks at
> > the final stage. Nowadays, I believe QEMU can still fallback to source side
> > at a very, very late stage after all things applied.  If I'm not mistaken,
> > the final handshake is done at migration_incoming_state_destroy() ->
> > migrate_send_rp_shut() telling source to be gone.
> 
> Right. In traditional pre-copy VM migration model, the fallback is possible
> at any point before the destination VM starts running and modifying its
> state.
> 
> The same is true for TDX, but with more complexity and limitations.
> 
> We have 2 points:
> 1. Before the source has exported the start token - fallback is similar to
>    traditional VM migration - just abort the migration on source and
>    continue running the source TD, and just destroy the destination TD.
> 2. After the source has exported the start token - fallback is still
>    possible, but more complex - it requires the destination to first
>    generate the abort token, which should be delivered to the source and
>    consumed there. There are seamcalls for both generating and consuming the
>    abort token. The token basically makes sure the destination cannot run,
>    and the source can run again - same "only one of the TDs can run at a
>    time" security rule that we discussed earlier.
> 
> Now, the limitation here is that if the abort is because the network
> connectivity is lost, the abort token cannot be delivered. Then I'd guess
> migration should stop, without destroying the source and the destination,
> and the token should be delivered later manually, QEMU could even provide an
> infrastructure / commands for that.

Heh, this reminded me of postcopy recover that QEMU supported for years:
not a trivial feature at all, people always want it to be there, but I'm
not sure who is using it at all in production..

Especially, normally who cares about migration will provide dedicated and
reliable networking for migration purpose, so the failure will be even more
unlikely.  Meanwhile who doesn't care enough, may simply crash the VM at a
postcopy failure and reboot.. not bother to recover.

I bet rarely people will hit a network failure happens exactly at
forwarding the TDX START token to destination host, similarly for case (2)
on ABORT token lost.  But yes, likely this is required to make the whole
thing complete.

> 
> Would be very helpful to learn the abort protocol the other CoCo vendors
> offer - is it similar to TDX or not?
> 
> In our PoC we did not implement the TDX abort token procedure. But the
> proposed uAPI is provisioned for the abort token export/import.

[...]

> > Hmm, interesting.  Sorry if this follow up question may be slightly
> > off-topic of the new API, or maybe it matters, depends on the answer: do
> > you know who is in charge of this unplug / plug operation?  VMM or TD
> > (hence, transparent to VMM)?
> > 
> > If it's VMM, is QEMU involved?
> 
> Specifically about TDX - the pause seamcall will return an error if TDIs
> are not unassigned.
> 
> While this is something that is not implemented in Linux yet, I believe the
> model will be that there is some uAPI to unassign TDIs, and it is not
> related to migration. QEMU would just need to exercise this uAPI at the
> right time.

OK, this sounds working, but then it means the migration will be visible to
the guest.  I wonder whether there's any attempt to make it more
transparent, but we can also leave this question for later.

[...]

> Do you or someone else know how important it is to have it working?
> Do actual customers use it in real setups and rely on it?
> How bad or painful is it if this feature is not available?
> 
> The reason I am asking is that my assumption was that it is not important.
> But if it is, I will come back to the TDX module architects with a
> request to revise the design to support independent dirty page tracking. Of
> course they may have some reasons for not doing it, but I would try at
> least.

Thanks, I'll talk to our team and revisit this after I collect answers.

[...]

> Understood, thanks - sounds like this workaround is doable, but wasteful,
> something to avoid if possible. That in itself is useful evidence I can
> bring back to the TDX module architects.
> 
> Just to understand the real-world deployments better: do you know if anyone
> actually falls back to this workaround today, or is it more of a theoretical
> idea that nobody actually uses?

Nop, I am not aware of any CoCo migration worked in any production
deployments.  So it's only a wild idea assuming GET_DIRTY_LOG will be gone
without migration process.

> 
> > 
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
> 
> Anyway, if I can get the TDX module to allow dirty tracking independent of
> migration, we could pick either mechanism, or even implement both and add a
> TDX-specific ioctl to select which one to use. We could plug either method
> into the KVM_DIRTY_LOG ioctl - both would work, just differently.
> 
> = Dirty Scanning Optimization in TDX Module =
> 
> Now, I am diverging, but just in case: in the PUCK call where we presented
> TDX migration, Sean made an immediate observation that WP-based dirty
> tracking is not categorically worse than PML-based dirty ring tracking, it
> depends on the workload.

Hmm, I was expecting PML is still superior in most cases.  For "depending
on workloads", is that perhaps when (1) huge pages are used, and (2) the
workload writes only a small portion of guest memory?

Then maybe RO huge page will be a good hint to skip whole huge-page-range.
But that's only my wild guess, could be wrong.

> Then he learned that TDX module's dirty scanning does not use PML, and
> was understandably surprised. Sean was concerned about dirty scanning
> performance.

I'm definitely surprised too that PML isn't used.  Could I ask if there's
any simple reason not to use it for TDX?  Per my understanding, PML works
with all kinds of loads, and I was expecting PML to be efficient and most
ideal.

Another approach is if TDX can take over the bitmap buffer from the
relevant kvm memslots, update directly there alongside setting D bits in
EPT PTEs; after all IIUC we assumed dirty info not part of confidential
materials.  But that sounds more complex than PML if it's already working
for years.

The current scan approach sounds like unpredictable in terms of downtime,
in that even if with a scanner I don't see how TDX can guaratee the
downtime for the last dirty sync from QEMU, which will completely be part
of the blackout downtime.

Whenever switchover decision made, QEMU stops the VM, do the last time
sync, move anything left.  So that last one will matter a lot if we care
about downtime.

Thanks,

-- 
Peter Xu

