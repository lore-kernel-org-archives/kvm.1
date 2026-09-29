Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D813D301F
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790715936; cv=none; b=I2qoMTGyIvOJ8MOT/HgWTCGQo+We3U7gHr8fcfmQ29purY1PSR53PiHEAT/N4clVSgLhF5OSAHV5Pcj9RirHCZhrS6wskt2p0yVEXUaRi4jvlwiAgdzZTa0SHAfcpTtdbqV9Cyho03TCxxJbFgusGrLvC+EkIvJ3/6PqUK2vFHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790715936; c=relaxed/simple;
	bh=8ugMHP5Fgb/lG/oANAxb8la7wlIfPM4ZyOsrW7PDIis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/P7h0ObgWfxg6BTaigzL1TFcB+LKCoz18H/EZ332xhL3o+5oxzsxp2CMbXbBizRKN5LLDft2S7wuV+Uimrcoe0GQA8zTS2+yrSkClr8Rspu58ZtfjvmbxpjF5h7+4CQtOZoyby4ctDv7wjLuN3lgY3dup8PBE0nMMSonGEEWtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=atzUP+5I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=keDESHO1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atzUP+5I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="keDESHO1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790715928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=37++lit9+2DXn11dEqLaxcUobtIJd5aWh9YbcnkRsq8=;
	b=atzUP+5IfPP04jWAitpv81liGTGteLLBjGSBA132XdoP1DCxqvM7FTaqwxEf5yzDmdiSDO
	wg/bIamN5aun1BCD+tNkhUyx+x0YJqptf8SjCodlC89Bv9ZhKa2Zfd21N8AEYC/HAbBKBd
	uoXjFAGiYVF+kTwooIgz6MCu2TguYqI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-eggelPw-OX2zZ69qbzj3jQ-1; Tue, 29 Sep 2026 17:05:27 -0400
X-MC-Unique: eggelPw-OX2zZ69qbzj3jQ-1
X-Mimecast-MFC-AGG-ID: eggelPw-OX2zZ69qbzj3jQ_1790715926
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e82060977so238722585a.1
        for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 14:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790715926; x=1791320726; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=37++lit9+2DXn11dEqLaxcUobtIJd5aWh9YbcnkRsq8=;
        b=keDESHO1cr1PN8Nsd9pmbskPPRLbNewFciXDC3wDmM+zyEZoBYqJKtwLk4hak7o9Hm
         rk5yny59an/H4eSlGLyy21+KUY62UkV4uItpTxVmmgwyoh9bY9gCKScIzTIQ442Ox8Di
         ywnwAtpE4Fr2g5Qlp2tSG6EHkzJTBQiyhQ3ap773kzCN22d4bXJc0uy1K8Yd4zLXJFJm
         8r+uOrZ+5WUlTnfU/QrM+yTHBr5aYH65MGdgfWciaUiEiC4fpd58RVIN68Jgbq+x47Y4
         9P5QpYpz9qf9XeR9gWy1/9tHpUtgVkiZ51QkGDbTVtmRqFCkNmjwMu4Bgv6wwuuFVuIf
         Hb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790715926; x=1791320726;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=37++lit9+2DXn11dEqLaxcUobtIJd5aWh9YbcnkRsq8=;
        b=AGus3dazUrDcWAMmvgAv7ykJ/5Rirwcer/53fug3nUVF5CoBdr5iD+QlYBJoOGjX7+
         XI1QaSJGsjP3/gE+k8MjC0gdpi2UrKPHipplW6xRwLG3O5LWCqHillQCd5HSNE340ldN
         e86h9rWqeBKKFILcpIKCkCbu88oSown6VZA5dqRBH794BtcalnzfsZuAFklvI6zyTH+i
         waAwTsac8SJT9UPtzJ4vp1xmkbWsjXl7s0yGBN/xMmKCSXL2Jt/QMZZk+E5S5TBK9d2f
         dS1v2fI6QBx38y5agGRIJF5Vhav3bz9VT7oq+6wfIFipuGKP2hrxWYbUbOs5Mw4gVvwG
         MFng==
X-Forwarded-Encrypted: i=1; AKwUvByJbw6ih4WkOWtdilqI77TMHjAm0PQTeIQtJlAuGuuXbGrtbYeqVk/b2lo8SBozZKy9Tkk=@vger.kernel.org
X-Gm-Message-State: AFuF++mk01vSm7ajJcn/EPhZXMiXDETN6NfJG+8ypL1xfTugzmDqSN9T
	FJbseFjPvbApqagDNLdm5MNxStRrTjFlgY5LSnTn89X1yMNiP71qLlQPz+tYzkNun8RGBMIaM8u
	B1ijahZOqt5U5esdbSLEBdwjhkN8i3uGXjs61R6V6/ADg89jh3LRgAg==
X-Gm-Gg: AYBFou0inci+lZWAPjiMIACQhNj/fGQjAzTbg87MBJtDmHu60+hBYu9SbECsEyeQ/5Q
	5j/aJbtVQH0Ga6amUWmAJxdYP9xT7QKzPee/vq7tzKDRXHiZhBfMSREHDaaQXTJQBlslsNEEljN
	5nG2K87dfbV8frWCCHnohYl7uCGhQcWNhQAUjdHfQdFFmIXdcrtHQmcTmZLDnvX8xXCUd/nIMC0
	3PO+dJINF5iIvDA07mxOQLXNmHSgqUdYvYpLR/tAath4Iyhx1XaXtyMUX8PFLA+SW6oe7QIEnTT
	UVLVfikLBHBexHkMU9hbucoIW3b5d7sggvKzffLqbOR06hz+fOzF60D02oQERMPjQPc2QVY=
X-Received: by 2002:a05:620a:2985:b0:93c:65e3:df81 with SMTP id af79cd13be357-93c8becf5a5mr689861085a.13.1790715926151;
        Tue, 29 Sep 2026 14:05:26 -0700 (PDT)
X-Received: by 2002:a05:620a:2985:b0:93c:65e3:df81 with SMTP id af79cd13be357-93c8becf5a5mr689851685a.13.1790715925318;
        Tue, 29 Sep 2026 14:05:25 -0700 (PDT)
Received: from localhost ([142.188.212.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c9f2e00d1sm62020585a.6.2026.09.29.14.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 14:05:24 -0700 (PDT)
Date: Tue, 29 Sep 2026 17:05:22 -0400
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
Message-ID: <arwoEgUjYR82OrLO@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
 <aq1ehHk7OUYaGCe5@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <f2889dd6e44333b2a5bbd4bd32a4557c3b50a3cc.camel@gmail.com>
 <arLwnNyM4Tkr-Oh3@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <97c6ab9a9d5527776a580a242b6c8033cf1e9a36.camel@gmail.com>
 <arWT9fwpCkFneDKn@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <59384511c6070abfd048b37f5ec2831e5f8bb715.camel@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59384511c6070abfd048b37f5ec2831e5f8bb715.camel@gmail.com>

On Mon, Sep 28, 2026 at 05:15:00PM +0300, Artem Bityutskiy wrote:
> Hi Peter, thanks for reply again.
> 
> On Thu, 2026-09-24 at 17:19 -0400, Peter Xu wrote:
> > > > > The reason I am asking is that my assumption was that it is not important.
> > > > > But if it is, I will come back to the TDX module architects with a
> > > > > request to revise the design to support independent dirty page tracking. Of
> > > > > course they may have some reasons for not doing it, but I would try at
> > > > > least.
> > > > 
> > > > Thanks, I'll talk to our team and revisit this after I collect answers.
> > > 
> > > Many thanks!
> > 
> > I got some feedback on this, I'll try to provide a summary.
> > 
> > So, first of all, calc_dirty_rate isn't seem to be widely used across our
> > customers.
> > 
> > However, we do have customer case using calc_dirty_rate to evaluate
> > migrations of a VM fleet for cases like from one data centre to another.
> > 
> > I think it makes sense because the normal "try to migrate and fallback
> > otherwise" idea applies well to one VM, but perhaps not that good on a
> > fleet.
> 
> Yes, that makes sense.
> 
> > When a fleet is involved, we don't want to migrate 400 VMs then found
> > there're 30 critical VMs too busy and can't migrate, then due to whatever
> > reason (inter-VM communication / service locality ?) one is forced to
> > migrate that 400 VMs backwards.
> > 
> > IOW, it seems helpful to provide high-level evalutions of migration
> > decisions over a full cluster, concurrently and efficiently.
> 
> Thank you. I'll work on this internally. It will take time.

Yes, thanks.  Nothing urgent, good to know it's on the map.

> 
> Just to give wider context: Sean and Paolo gave us feedback regarding the
> entire SEPT scan approach - they believe it is too costly and won't scale,
> and suggested using PML instead. For now, dirty scanning is the best we
> have, but I continue to explore other options internally, and standalone
> dirty tracking is one of them.

Ok.

> 
> > > AFAIU, the TDX guest migration implementation benchmarking results are
> > > satisfactory with the scanning approach, but I do not have hard numbers to
> > > share. I also feel that PML could offer better performance, at least for
> > > memory-intensive workloads. But this is intuition only.	
> > 
> > My gut feeling is DMA shouldn't be a blocker for PML: AFAIU we don't track
> > DMA from KVM side. Assigned device should have its own dirty tracking for
> > DMAs, either via device's own tracking facilities, or the IOMMU on the
> > host.  Feel free to refer to vfio_listener_log_sync() in QEMU.  In all
> > cases, it'll be great you could share the reason if you have more solid
> > clues.
> 
> Yeah, this is also part of the internal exploration I mentioned above too.
> 
> > > 
> > Are we talking about the memory export/import API or GET_DIRTY_LOG?  IIUC,
> > GET_DIRTY_LOG always applies to a whole memslot,
> > 
> > struct kvm_dirty_log {
> > 	__u32 slot;
> > 	__u32 padding1;
> > 	union {
> > 		void *dirty_bitmap; /* one bit per page */
> > 		__u64 padding2;
> > 	};
> > };
> 
> I apologize, I worte something unrelated to the context. 512 GPAs at a time
> is the limit for exporting the memory, not for dirty scanning.
> 
> For the dirty scanning seamcall (TDH.MEM.SCAN.RANGE), the limit is 512 * 512
> GPAs at a time, which is 262,144 GPAs, or 1GiB. So if a memslot is larger
> than 1GiB, multiple calls to the dirty scanning seamcall are needed.
> 
> > > Keep in mind that dirty pages are the majority of migration candidates, but
> > > not all of them. Sometimes a migration candidate can be a page that was
> > > already exported, but then was, for example, converted from private to
> > > shared, or unaccepted by the TD (gone, in other words). In this case the TDX
> > > module flags it as a migration candidate too. The memory export seamcall
> > > treats it differently too - instead of exporting encrypted page data, it
> > > exports a small record indicating that the page has changed its status
> > > (gone).
> > 
> > Yes, it makes sense.
> > 
> > So can I inteprete this as GET_DIRTY_LOG works seamlessly for both private
> > and shared pages (or even, unaccepted pages)?
> > 
> > Then I assume it means MEMORY.EXPORT should also be able to read shared or
> > unaccepted pages too, am I right?  Same to when apply with IMPORT.  Another
> > counter example is MEMORY.EXPORT returns a flag saying "this page is
> > shared, go read it directly from HVA", but then QEMU reading it may race
> > with a concurrent shared->private conversion crashing VMM.
> > 
> > Looks to me MEMORY.EXPORT must support shared too, then.
> 
> Hmm... First of all, it does sound like a possible approach. But it is not
> the approach we took in our PoC today. I hope Kishen will chime in to
> correct me.
> 
> Here is how I saw this, but I may be missing something (my excuse is that I
> am still new to the team and still learning).
> 
> 1. QEMU has a bitmap of shared pages in RAMBlockAttributes, so it can
>    distinguish shared pages.
> 2. In general, QEMU does not distinguish private vs unaccepted pages, so
>    unaccepted pages are treated as private pages.

Yes, the latter seems uncontroversial.

The 1st one is true, and it just reminded me if the conversion is
synchronous and one step requires the hypercall to QEMU, then indeed
background conversion can be avoided by some form of userspace locking.

Perhaps, a rwlock suites, each vCPU takes it for write whenever page
conversion requested from the guest (private <-> shared; nothing about
"accepted" that matters).  Then the migration threads, one or multiple,
take the read lock, lookup the bit, do MEM.EXPORT, unlock.

Then it seems fine in general, except that I donno if things can still go
wrong when there are multiple versions of "if this page is private or
shared".  Say, minimum of three?

  (a) QEMU maintains the bitmap in RAMBlockAttributes, each bit represents
      if the page is shared or private

  (b) KVM should maintain one, looks to me, kvm->mem_attr_array

  (c) Hardware / Firmware may maintain its own, in case of TDX, is that one
      bit on the SEPT pgtable?

They don't change together, AFAIU, they change in order, I believe
(c)->(a)->(b) if my above understanding is correct.

Then, what if they report different things?

Say, during migration the guest wants to convert a page from shared to
private.  (c) can be already done saying one page "private" now for TDX,
(a) tries to mark it "private" too, but now assuming page being accessed
(read lock held), it may be trying to take a write lock and sleep, which
means (b) will be "shared" so far.

So what happens is, QEMU thinks this page "shared" because the conversion
hasn't take place waiting for the write lock, however at least TDX may
think it already "private" instead.

Then QEMU logically can access HVA of that page, with (a)=shared,
(b)=shared, (c)=private.

Would it cause trouble?

> 
> Dirty tracking:
> 
> - QEMU uses the same KVM_DIRTY_LOG mechanism for tracking shared, private,
>   and unaccepted pages.
> - For shared GFNs, KVM uses the normal VM dirty tracking mechanism. For
>   private and unaccepted GFNs, KVM goes to the TDX-specific code.
> - But the final bitmap that QEMU sees covers all page types.
> - KVM calls TDH.MEM.SCAN.RANGE on both private and unaccepted GFNs.
> - For private GFNs, the TDX module reports it as a migration candidate if
>   its data changed or its status changed (e.g., converted to shared or
>   unaccepted).
> - For unaccepted GFNs, the TDX module reports it as a migration candidate in
>   the first round (so it appears as dirty in KVM_DIRTY_LOG reply). Then it
>   reports it as clean, unless its status changes - it becomes accepted.
> 
> Page export:
> 
> - QEMU migrates shared pages the old way - it does not try to use the
>   proposed CoCo migration uAPI for that.
> - For private and unaccepted pages, QEMU uses the CoCo migration uAPI.
> - Our export uAPI PoC implementation does not try to check GFN type - it
>   just   feeds them all to the TDX module TDH.EXPORT.MEM seamcall. Here
>   is what TDX module does depending on the page type:
>   - Shared pages: just skip, no errors.
>   - Private pages: export the data in encrypted form.
>   - Unaccepted pages: export a small record telling that the page is
>     unaccepted. This record should be delivered to the destination and
>     imported there, just like private pages.
> 
> But clearly this is part of the uAPI contract that must be discussed and
> made explicit. What I describe above is obviously our PoC implementation,
> plus TDX module behavior details.
> 
> > > The same logic applies to a TDX guest using dirty scanning. Suppose the
> > > final dirty scan is slower than a theoretical TDX PML-based approach would
> > > have been. The prescan optimization I described in the previous e-mail
> > > should help with this in an average case, but let's assume it does not
> > > help for some special case - when the TD touches most of its memory, so
> > > all EPT sub-trees end up touched. This should be rare, but let's assume it
> > > happens.
> > > 
> > > In this case, whether that scan slowdown will actually matter for the
> > > overall downtime also depends on the network. If the network is very fast,
> > > the scan itself can become the dominant part of the downtime. If the
> > > network is the slower part, the scan slowdown may barely matter.
> > > 
> > > So my understanding is that downtime is never fully predictable, for
> > > either type of VM.
> > 
> > Right, but IMHO background scan of EPT pgtable dirty bits adds a completely
> > new reason to introduce downtime, and when I said "unpredictable", it is
> > about that part.  Also, I worry in some worst case this can be pretty large.
> 
> Just to clarify on the "background" part. Yes, it is "background" relative
> to the TD - some CPU is running it, in parallel with vCPUs running on other
> CPUs.
> 
> But there is no background activity in the TDX module itself. All the
> seamcalls run synchronously on the CPU that invokes them.
> 
> This means, for example, that to speed up memory export, one can run the
> TDH.EXPORT.MEM seamcall for different GPAs in parallel on different CPUs.
> 
> Same for dirty scanning - if one could run the TDH.MEM.SCAN.RANGE seamcall
> for different GPAs in parallel on different CPUs, that would make scanning
> much faster.
> 
> Also a bit separately, one point to keep in mind is that in CoCo the page
> export and import are heavy, compute-intensive crypto operations. So when we
> talk about slower scanning, we need to keep in mind that it is not that slow
> in relation to the export crypto. But I understand that this is not an
> apples-to-apples comparison:
> 
> - Scanning is potentially about a large SEPT in a VM with terabytes of
>   memory.
> - Exporting is only about the pages found to be dirty.
> 
> So this is only to remind that in the CoCo case, memory export also has a
> high price tag, compared to a traditional VM.

Ok, I'll keep that in mind.

> 
> > So we have two overheads here at this stage, unpredictable:
> > 
> >   (a) Scanning EPT pgtable, when very unlucky, can take a lot of time to
> >       finally reports to a GET_DIRTY_LOG request,
> > 
> >   (b) Migrating of dirty pages during blackout phase, which should be
> >       roughly linear to how many dirty pages we just collected.  (NOTE!  I
> >       think we may have way to fix this (b) or optimize it.. but this is
> >       off-topic; let's focus on the difference of (a) and (b) first)
> > 
> > When with PML, IIUC (a) is predictable: we have the bitmap on hand, plus a
> > maximum of some (my memory is, 512?) PML entries to flush per vCPU.
> > That'll be flushed automatically when we do vm_stop(), likely also
> > concurrently, atomically updating the bitmaps.  I never measured it, but it
> > is bounded, and sounds pretty fast.
> 
> Yes, I agree.
> 
> Now my secret desire is that TDX module can eventually plug PML under the
> hood, consider it a "hardware accelerator" without changing the ABI. But I
> do not know whether keeping the ABI unchanged is possible, or how soon it
> could happen. This is something I am working on internally with Intel TDX
> module team.
> 
> > When with scanning, (a) seems more unpredictable.  That's the part I was
> > slightly concerned.  But now after thinking a bit more, it seems fine.
> > Please read below.
> 
> Sure, thanks.
> 
> > > Intuitively, the TDX case does feel "less predictable". The open
> > > question for me is whether the degree of unpredictability is large enough
> > > to bother users. My attitude is to focus on getting something simple done
> > > first, learn from real-world behavior, and improve it later if needed,
> > > including exploring PML. The best is the enemy of the good sort of
> > > attitude.
> > 
> > Yes, I think it's always fine we start with whatever is most feasible.
> > 
> > I think it actually may not be that bad. The last sync is special at least
> > on how QEMU treats it, it should look like:
> > 
> >   - GET_DIRTY_LOG, to do last math, decide to switchover, <------   [1]
> >   - vm_stop()
> >   - GET_DIRTY_LOG, this collects all rest dirty bits      <------   [2]
> >   - migrates the dirty pages, device states, etc.
> > 
> > So I expect there should be normally very small window between two
> > continuous GET_DIRTY_LOG across system.  Only [2] will be part of downtime.
> > 
> > Since you explained to me on how the background rescan roughly works, by
> > relying on A bit in pgtable directory entries, I do feel like in this case
> > most of the memory regions shouldn't be accessed during small window of
> > [1]->[2], then the range to scan should be very much under control too.  In
> > reality, it will likely be even smaller, [1]->vm_stop(), because after that
> > vCPUs are halted.
> 
> Yes, I agree. Just to flag the word "background" again, and to make sure we
> are aligned - this "rescan" happens between [1] and [2]. The idea is that
> [2] will be very fast after the "rescan". But it does increase the time
> between [1] and [2], and the TD has time to dirty more pages.

In general, looks like either way we can still stick with GET_DIRTY_LOG.
PML would be better, otherwise from a review on the API level, that's still
ok.

Thanks,

-- 
Peter Xu

