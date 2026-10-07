Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FA542DA3D
	for <kvm@vger.kernel.org>; Wed,  7 Oct 2026 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791403216; cv=none; b=H0JVE7CJA0BNBUe+bjWnSXvVpfBVb+L90psaXxAkab6MH/3jgWboWP52A+TmakBc3LzjPQGcRKeGRX8OD0DdNzrHH1vkoBRdzPN//IX/Hufsdb78LNye0jP8u89XahTZ2l1ZPpgdlPCILo2GoQhFBNfMonZJ8dTJe7H7Gklesb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791403216; c=relaxed/simple;
	bh=YcSOKcacwBj4EMKRyE5hRbXzeo/h9a40jv0Tg1OUgjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+mxVYXS/1zgOVQqzUFYyZNrkwdl+t8KuyGW1n91tKAyUgzPxri598jaLrH4uTbEiFiW3tEssqZGWni+uz4Mo9ShhuTMyrnE8TSqZiiQP9q0w+r81S0BG/8zLI/XdE5fQtSlQpQ5t7tK7OGjytFf41cWMZpL4PkSAsYa0xr63L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MF7Jl77A; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cl0HEKX4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MF7Jl77A";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cl0HEKX4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791403213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ewc9H7FWlns+uwpkCHiWlx0H/3jVFSNz6XK7sSj7XLo=;
	b=MF7Jl77AefVxNxz94ln31X+naMCl5jMvQUdnvkFsmDE8UmKrKJWRhEkueZZHE59um2IR5Z
	cTCPCPlB35MghtaEqiZ9ic2N1DZKmm1LwAxrcMUF5pM81Y01CJBGaTIAXNdOlohocKuUvd
	VgG9EULlLYbkePpcMGFWOOFr9tYkUxU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-uiQIxs2IMWSiNvYn61aUfw-1; Wed, 07 Oct 2026 16:00:12 -0400
X-MC-Unique: uiQIxs2IMWSiNvYn61aUfw-1
X-Mimecast-MFC-AGG-ID: uiQIxs2IMWSiNvYn61aUfw_1791403212
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93ce7a85f04so841275785a.0
        for <kvm@vger.kernel.org>; Wed, 07 Oct 2026 13:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791403212; x=1792008012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ewc9H7FWlns+uwpkCHiWlx0H/3jVFSNz6XK7sSj7XLo=;
        b=Cl0HEKX42qz0rFr1M/IUZjBiItxEmyuswZ2N5qJSjgYw1Ho/jmm/PeIwztXdZsDC29
         f834uEVvkuWkKFBgrBEdIOSBjIVhCrKvB6HNltSkJq8GrnAyozdfRsr1r/pw+uAH6wvg
         CefNzDo8hxM35zD/KLq/8d+MN75WRcxNDu+B/UAbEyO+bERAJh1WWPM3WS5R2C3Oowt9
         4jh8GwzQULv596rPAFUTYcC353qz7OLxsTE8BMaMsA/SJB5U6RHTL9A50/IPVzRqPf90
         a7R/osvLZxpdskIUiWgdA5nP8E0l1RtucJjTuySCNEo+eYL6wNmoVGvpIqdej3YGfU/J
         mrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791403212; x=1792008012;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ewc9H7FWlns+uwpkCHiWlx0H/3jVFSNz6XK7sSj7XLo=;
        b=Xpu6+ok93KpO4saOx8b5M4B7Ai0jGGI6mQiGaUVMw/Z3YW9iuuLNa6AqpWRcTx9SbY
         7S7db0aNf8dh/Xjf1zkzJiRh60CTy1FMWEqnNFn4U5cOB0S+OlFCsi0XW5XrRF4IlHmv
         Tv7p7qAfTWZwUwDxBcmPVlhRL/jSAo5xSIwAqDbTRtDwFP5K+1JxhcqBbFbgUkape0Pz
         LDbggCWaKsYXwiXdRNIvaAZKUf/loTRHS5RMAc8/WaCPXqF/uRD8tTCUf+KzDJhzld3T
         Wfhl6txHu61gsV17bLOpI7dXFC0Zl4KVrmm17Ey+LGyts5RiBA/yP7HtoyqSX2Msruyr
         6Qmw==
X-Forwarded-Encrypted: i=1; AKwUvBwpFkUAJOtuKSSTEZ6M/267kOgKJ9y13E5NWdbueHK5lsxeaSmJngNMFaFWKroGVVwDmQY=@vger.kernel.org
X-Gm-Message-State: AFuF++mF9XE/5qRq4TXQya6pzlqAIu3jmy2RDDH89D5vI5P2arzA6U0a
	mOtI7zZznF7RB17xmhNfOOKRwqSATU63SAVNuJ5BBIxAYqtlwMvH43TJDzk4kGCCe0I4qjtw1aw
	N/uHxzE4w8p0J65QVg38pww3hbt9CxTWjNQL4b60acnzJhpsY/M+g6g==
X-Gm-Gg: AYBFou0ttg9iyns6t0PpPs6Hb5ff1y3ZwODTZLkXpTqoLfNQGN/DVXaigK0zNVkL6IW
	D38l5KriDz+0whyI+okpAvJWTTpLQ9mTQnswlyW11Vb5NeJA/X26Pyf3/CdBj3UjoZabnHt6sxY
	E0oFHPLLnftVsWPpotf611q6kz9G0iVSr3PAvyRPxzy4gFI8fyDCmH7wWTQP+P0dc54LcjFl2ik
	SJVDYnLTjTt1hKchLs5IRvpXzzK32e3FVpPpC6d5uRNtPb8q3ZzyL0tC9psUiKpyQrSxhd6/dKv
	ve5TrryzeLhRY/6rR4xaz3SKx40dqq8re+OqEtPR7RYpafOBI0R5FJbjBQ0TjGTYXS5d5Zo=
X-Received: by 2002:a05:620a:2981:b0:93e:70cd:e428 with SMTP id af79cd13be357-93e9b836095mr604920885a.66.1791403211396;
        Wed, 07 Oct 2026 13:00:11 -0700 (PDT)
X-Received: by 2002:a05:620a:2981:b0:93e:70cd:e428 with SMTP id af79cd13be357-93e9b836095mr604911385a.66.1791403210586;
        Wed, 07 Oct 2026 13:00:10 -0700 (PDT)
Received: from localhost ([142.188.212.246])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e991580d2sm294004185a.21.2026.10.07.13.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 13:00:09 -0700 (PDT)
Date: Wed, 7 Oct 2026 16:00:08 -0400
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
Message-ID: <asakyIs1beS_I-o_@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
 <aq1ehHk7OUYaGCe5@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <f2889dd6e44333b2a5bbd4bd32a4557c3b50a3cc.camel@gmail.com>
 <arLwnNyM4Tkr-Oh3@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <97c6ab9a9d5527776a580a242b6c8033cf1e9a36.camel@gmail.com>
 <arWT9fwpCkFneDKn@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <59384511c6070abfd048b37f5ec2831e5f8bb715.camel@gmail.com>
 <arwoEgUjYR82OrLO@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <c7d5adf38d6338857f73bb4b3f014a500b4c2fe1.camel@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c7d5adf38d6338857f73bb4b3f014a500b4c2fe1.camel@gmail.com>

On Fri, Oct 02, 2026 at 10:57:46PM +0300, Artem Bityutskiy wrote:
> On Tue, 2026-09-29 at 17:05 -0400, Peter Xu wrote:
> > > Here is how I saw this, but I may be missing something (my excuse is that I
> > > am still new to the team and still learning).
> > > 
> > > 1. QEMU has a bitmap of shared pages in RAMBlockAttributes, so it can
> > >    distinguish shared pages.
> > > 2. In general, QEMU does not distinguish private vs unaccepted pages, so
> > >    unaccepted pages are treated as private pages.
> > 
> > Yes, the latter seems uncontroversial.
> > 
> > The 1st one is true, and it just reminded me if the conversion is
> > synchronous and one step requires the hypercall to QEMU, then indeed
> > background conversion can be avoided by some form of userspace locking.
> > 
> > Perhaps, a rwlock suites, each vCPU takes it for write whenever page
> > conversion requested from the guest (private <-> shared; nothing about
> > "accepted" that matters).  Then the migration threads, one or multiple,
> > take the read lock, lookup the bit, do MEM.EXPORT, unlock.
> > 
> > Then it seems fine in general, except that I donno if things can still go
> > wrong when there are multiple versions of "if this page is private or
> > shared".  Say, minimum of three?
> > 
> >   (a) QEMU maintains the bitmap in RAMBlockAttributes, each bit represents
> >       if the page is shared or private
> > 
> >   (b) KVM should maintain one, looks to me, kvm->mem_attr_array
> > 
> >   (c) Hardware / Firmware may maintain its own, in case of TDX, is that one
> >       bit on the SEPT pgtable?
> > 
> > They don't change together, AFAIU, they change in order, I believe
> > (c)->(a)->(b) if my above understanding is correct.
> 
> It looks like in terms of which layer saves the page type change first:
> 
> - Private->Shared: TDX -> KVM  -> QEMU
> - Shared->Private: KVM -> QEMU -> TDX
> 
> In both cases the TD initiates the change. This ends up with a TD exit,
> followed by KVM exiting to QEMU. QEMU calls kvm_convert_memory(), which
> calls back into KVM (KVM_SET_MEMORY_ATTRIBUTES). At this point SEPT did not
> change yet.
> 
> Private->Shared:
> - KVM first removes the page from SEPT, so TDX sees the change first.
> - KVM updates own data (kvm->mem_attr_array). So KVM "gets" the change
>   second.
> - QEMU updates RAMBlockAttributes, so QEMU "gets" the change last.
> 
> Shared->Private:
> - KVM removes the page from the shared EPT, updates own data
>   (kvm->mem_attr_array).
> - QEMU updates RAMBlockAttributes, discards backing storage.
> - Back to TD, which accepts the page. This causes an EPT violation, and
>   KVM adds the page to SEPT (TDH.MEM.PAGE.AUG).

Oh, this reminded me that ram_block_attributes_state_change() is done after
the ioctl(KVM_SET_MEMORY_ATTRIBUTES); I believe I didn't notice this detail
and assumed the other way round.  In that case, yes, KVM's page status will
always change before QEMU's.

> 
> > Then, what if they report different things?
> > 
> > Say, during migration the guest wants to convert a page from shared to
> > private.  (c) can be already done saying one page "private" now for TDX,
> > (a) tries to mark it "private" too, but now assuming page being accessed
> > (read lock held), it may be trying to take a write lock and sleep, which
> > means (b) will be "shared" so far.
> > 
> > So what happens is, QEMU thinks this page "shared" because the conversion
> > hasn't take place waiting for the write lock, however at least TDX may
> > think it already "private" instead.
> > 
> > Then QEMU logically can access HVA of that page, with (a)=shared,
> > (b)=shared, (c)=private.
> > 
> > Would it cause trouble?
> 
> (c) should see it as private only after KVM and QEMU do.
> 
> But I am not sure about the entire idea. Holding the read lock around the
> export ioctl means that a vCPU requesting a conversion waits until the
> export finishes. One export call may cover many MiB of crypto work, so the
> vCPU stalling may be significant, right?
> 
> Let's check the 2 cases.
> 
> Private -> Shared
> 
> QEMU calls the export ioctl for a page that it thinks is private, but
> meanwhile it became shared. In this case, if the semantics of the export
> ioctl is that such pages are skipped, we should be fine, right? QEMU will
> just handle this page during the next round.

Yes, this should be benign as long as conversion of page status set the
dirty bit; QEMU guarantees to clear the D-bit before reading the page, then
it must read it again later.

> 
> Shared -> Private
> 
> QEMU tries to migrate a shared page, which meanwhile became private. Reading
> it would result in zeros or some stale data, right? Would it help if QEMU
> used a lock-check_if_still_shared-copy-release, and the same lock around
> kvm_convert_memory()?

AFAIU, this should SIGBUS QEMU, which is the major issue, that should be
what happens in current linux tree, where now only INIT_SHARED is available
for fault() processing.

I also think that's the plan for afterwards, but still worth check kernel
tree with TDX migration integrated: kvm_gmem_fault_user_mapping() should
decide what happens..

-- 
Peter Xu

