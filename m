Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9619F33F584
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 21:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782162488; cv=none; b=nhV7tAoRzyZcLAVbxrOVNDn8+0pKeLgYaWU83+UOGnyuXLzlsLmj7tQ3mc2910QNYoZiroYIgv490XUytrx8/vt2jynwKIgJusdKFyeZezt+AMK1dgHfDoyqlEYTcCH+hcEgI8PCK00prPXSqJ//TA4pLSeDC38q75TuXcjRsws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782162488; c=relaxed/simple;
	bh=eunKVDlsNamoHDNiOA4C+NT/pAI4L8qMackQj+NL+1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKWfOY8tbVHhit646YXsSOKPj58iimwOuYpb46AhgDuhkE24McKGv2X9GeEnmo0JSSKhfeasJsLMwlw5i6sr9iXQm/pSD6ehbmMrX8bQRKRWkpkBBWSlnffYU3uXwU/s2t+SZ9NT6UU/sSkQ9fP4EuVA7LsnmjopQbyNumY4+TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MwZZoFWP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HOShRJJT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwZZoFWP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOShRJJT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782162485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZylaYIaJyH64ZUN0GPn4U0LhKcnXEBaFTWhwpPLc03o=;
	b=MwZZoFWPdqpQcm1EuIK3tzEShYwQgoGwFzwo37QaJFEVydm3AsyTDpbJRy4Ml4UgxHLenT
	6jRcDytr/phO4BzOrKxqRSJBA7ZEpH+5ujcL83uBWFsTuOPDxIMNte6pNNLBiHweTAvMBu
	NVc+F/iuzPk+SNUb5EyvMwxt+ce8/BM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-9AwgG_L2NqGzbOf7jONaTg-1; Mon, 22 Jun 2026 17:08:04 -0400
X-MC-Unique: 9AwgG_L2NqGzbOf7jONaTg-1
X-Mimecast-MFC-AGG-ID: 9AwgG_L2NqGzbOf7jONaTg_1782162484
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9159bc52211so806605385a.2
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 14:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782162484; x=1782767284; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZylaYIaJyH64ZUN0GPn4U0LhKcnXEBaFTWhwpPLc03o=;
        b=HOShRJJTRNMsBc3Y/SyJmubc50y2AoDY5FZDb80J+pF+//SHvNAWRQcVSyZkluwj6y
         zAoSAOt+RFcnUINODZoKwa/8RCBjChT6m7A+c+nMLytOVagWFYsfTnulPT3sXGf5SnC3
         0DMCfWPT0woHnTd5ZXbts5i4XXQNBa3doFPc+7VrEJA0pDMKmHtwCOoWIrAsjs8v5klT
         6bMOYP4V1eNGx7ZNlbDKUeBoNTko6g7AiL2ZbLR8IQ3aFXLDbzqOIFqh1p2kNQk4kvh0
         B/w0pcawffqhh6TGok7pT8mw2DNL7y0FcQOKXUjuEEtqOS7xMBKhnbFpbL5BEKSQ55G7
         U7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782162484; x=1782767284;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZylaYIaJyH64ZUN0GPn4U0LhKcnXEBaFTWhwpPLc03o=;
        b=qYhdgZ0J4z/wpXuZvvmG+NBGoa6GxAUPakZyXjE7AB0q0HDk0/HRF039Dp5QaX5+Ls
         xDZZQ7y848XeMAj0Iwhvaxv8W9ekvEEcV8J3QMDePr/2J72r7fLWGB82mgXd8TlLUFFj
         fKfv81qauugwF5LW/BnR6ioAe9pETNBEkkISytUm+InqYEzql2jEipRhRyaZNobdHhj6
         I4J0n/qD+LJrU2mbmUmM+9KqTC5DYQ/J+cM1Iqtk5fdU3W1dsxYOnqNuOYWZgRYCOWMv
         Vlj6KtoMnPqLgD2ZWdcNpevfm4SBiq5aTfvOUkyoYBvjzC/yraMp5MVq6IJkcZoxUFvQ
         pt2A==
X-Forwarded-Encrypted: i=1; AFNElJ8ZRTVifHy2W/JhQk/MbpkmTF+ELK+wrF2ywjl9DnNd1loIxuPbT1SLVczQObaqXm478dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYPI+TyNYusPBDVuHlvcwEODFUfhtwe27RVcWKun27x07LCtCX
	4zg5Yu55ceF8ZICah+oBiPEhvrJI8FNx4p+LZFevf7yh60S8l/V2FJnQSF4vCP5iGf6gj9NEQVC
	gr7Z6NCUdgFw4JFhDlZzZvS+aZVOjMKqjZ56PkZTOlmKh9wur2/JKvA==
X-Gm-Gg: AfdE7cl2BuISZgOMnxwsnOG7UrHI4wJmR7HgzsWy7cCMtlm24Ksunrz5f8i+uhUWJJx
	Avr0lY9CALftearihbCWswS168NoVK179YQJf2t4PwBYkgXbes+aUhVUglEHkQlL61JPtj+0D6b
	fq3Tu8WhCNCoOJIOtkxwX/5p2ZGITsv3AYlzoCgboiE6BKRJQ4W90aNZiDxenueuOeOk4o+1iEe
	7RSpXEkvAZTinfz2ZSKef00fbFYgw1xW7y6/NJnGaaVfphcc62+DtKpdB0BJzrpCr7Tp6AivWYr
	ec2MIQZj1tXtFoNaUMNeEU1WcmJdmMKZoIqNlDgvkoaoVEUqaMRNbBWL9yPn+ar4pt6BjKfmrXL
	ILR2dUMpLtiTkoaSUSX0xNzuW7M1meY2btGN3vgVWolJH/R8+t+xwCao+5dGm50a76x7uHslZ
X-Received: by 2002:a05:620a:6492:b0:913:dcd2:f132 with SMTP id af79cd13be357-92090db22b3mr2623429685a.40.1782162483845;
        Mon, 22 Jun 2026 14:08:03 -0700 (PDT)
X-Received: by 2002:a05:620a:6492:b0:913:dcd2:f132 with SMTP id af79cd13be357-92090db22b3mr2623419985a.40.1782162483170;
        Mon, 22 Jun 2026 14:08:03 -0700 (PDT)
Received: from x1.local (bras-vprn-aurron9134w-lp130-03-174-91-117-157.dsl.bell.ca. [174.91.117.157])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fd39188csm82036985a.6.2026.06.22.14.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 14:08:01 -0700 (PDT)
Date: Mon, 22 Jun 2026 17:07:58 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	qemu-rust@nongnu.org, Alex Williamson <alex@shazbot.org>,
	=?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
	"Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
	Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>,
	Ben Chaney <bchaney@akamai.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>,
	Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH v5 00/12] Make RamDiscardManager work with multiple
 sources & virtio-mem
Message-ID: <ajmkLgAqc_bz-m3A@x1.local>
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
 <CAJ+F1CKRvSWDOvKC98e_7uyjgJMuXfhOHP83H0s7a=+ZrYxA1g@mail.gmail.com>
 <ajVco512NDPKDPTr@x1.local>
 <CAMxuvazRnZw4PEsdKCEBD8X1ua5LMj5K-k+-oh-J_uvXm5vT1w@mail.gmail.com>
 <ajmMzMAXay65Sl7U@x1.local>
 <CAMxuvawvb-oueGsgXQsPzAtB8_ArAM+SOtpacrvOGq=4d1F2Bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvawvb-oueGsgXQsPzAtB8_ArAM+SOtpacrvOGq=4d1F2Bg@mail.gmail.com>

On Tue, Jun 23, 2026 at 12:00:04AM +0400, Marc-André Lureau wrote:
> Hi Peter
> 
> On Mon, Jun 22, 2026 at 11:28 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Mon, Jun 22, 2026 at 03:53:33PM +0400, Marc-André Lureau wrote:
> > > Hi Peter
> > >
> > > On Fri, Jun 19, 2026 at 7:13 PM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Fri, Jun 19, 2026 at 12:11:48AM +0400, Marc-André Lureau wrote:
> > > > > Hi
> > > > >
> > > > > On Thu, Jun 4, 2026 at 5:46 PM Marc-André Lureau
> > > > > <marcandre.lureau@redhat.com> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > This is an attempt to fix the incompatibility of virtio-mem with confidential
> > > > > > VMs. The solution implements what was discussed earlier with D. Hildenbrand:
> > > > > > https://patchwork.ozlabs.org/project/qemu-devel/patch/20250407074939.18657-5-chenyi.qiang@intel.com/#3502238
> > > > > >
> > > > > > The first patches are misc cleanups. Then some code refactoring to have split a
> > > > > > manager/source. And finally, the manager learns to deal with multiple sources.
> > > > > >
> > > > > > This has been tested together with the Linux kernel series from
> > > > > > Zhenzhong Duan [1] for TDX guests.
> > > > > >
> > > > > > (help fix https://issues.redhat.com/browse/RHEL-131968)
> > > > >
> > > > > Can the patch 1-11 be queued or are we missing something?
> > > > > (RFC patch 12 can be dropped for now)
> > > >
> > > > Likely yes.. one thing to double check with you before I do: We don't need
> > > > the kernel series, do we?  Since when unplug, I expect with the truncation
> > > > approach that this series proposed, KVM will emit TDH.MEM.PAGE.REMOVE then
> > > > unaccept is done (?).
> > >
> > > > Say, what happens if we run QEMU with this series applied, but without the
> > > > kernel series?
> > >
> > > The kernel series is needed at least for PAGE.ACCEPT. Without it, QEMU
> > > will have KVM_RUN return EIO, and finish into assert (while tearing
> > > down ioeventfd).
> >
> > Could you elaborate a bit more on why ACCEPT would fail?
> >
> > I used to ask the event flow here:
> >
> > https://lore.kernel.org/qemu-devel/agTjb3M8ElUAlfp1@x1.local/
> >
> > If AUG existed, then why ACCEPT would fail?
> >
> > PS: I didn't read a lot of what a Linux guest would do; I know there're
> > some lazy accept approach, but IIUC it's only a matter of time to ACCEPT,
> > not correctness.  My understanding is if we properly notify these new slots
> > with AUG, then it should be able to ACCEPT?
> 
> Yes, it will, but it needs the kernel patches to do it (or virtio-mem
> will let the guest access un-accepted pages and qemu will crash). I
> submitted a few proposals before Zhenzhong Duan proposed the last
> iteration.

OK, I think I misunderstood both the crash and also what Zhenzhong's series
is trying to do.  After a closer look, it seems to be a proposal for any
plug/unplug to work.  I'm surprised (if I get it right this time..) that TD
didn't seem to support DIMM hotplugs besides virtio-mem.

> 
> > >
> > > > What confused me a bit is the dependency of this series v.s. the kernel
> > > > one.  It seems to use different approaches, but then I don't understand why
> > > > this series was tested with the kernel change.
> > >
> > > My understanding is that the kernel may perform TDG.MEM.PAGE.RELEASE.
> > > That depends on TDX config TDCS_CONFIG_PAGE_RELEASE which qemu/kvm
> > > doesnt currently control. I don't know whether this is then
> > > redundant/needless with qemu doing discard on the guest_memfd..
> >
> > The problem is if this series depends on the kernel series, should we then
> > wait for the kernel solution be accepted first in case it'll change?
> 
> I don't think qemu needs to wait for the kernel to be fixed.
> Furthermore, this series is not tdx/sev/etc specific

AFAIU it is coco specific, otherwise we only always have 1 source, hence no
need for this series to provide this function.

Said that, I agree with you.. Looks like there's no major plan to add
anything specific to QEMU.

Patch 1-10 are all reviewed patches and correctly resolve the known >1 ram
sources and it's a design problem, I don't see how we can bypass that.

Patch 11 is very reasonable on its own, then I assume the guest ACCEPT
problem will need to evolve on its own.  Looks like the direction is
correct, and only some corner cases to think about (acpi coverage, lazy
accept, etc.) that I saw in the discussion.

> 
> >
> > But obviously I still don't yet fully understand how this whole thing
> > works.. :(
> 
> I am also slow, because I don't focus on this most of the time.
> Someone with more experience and dedication would handle it better.

I queued patch 1-11, will send a pull this week.  Thanks for all the
explanations.

-- 
Peter Xu

