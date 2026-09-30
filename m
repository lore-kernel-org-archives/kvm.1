Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DB63D45D5
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 20:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800957; cv=none; b=TKSW15nGf+xRqe1ZcRyBeC1dYt6Vh2BncS8qLX7jC8eEoJzBi/Dutt6okKD34Dlu/scLcJeFr9JlPbrplTDBvS2zVxxJN/ynNGv58wTf4HxikHH7D5PGuhgfn85r6/3NKow+sZAWoA0mNONWhtGLPLy2fqnaYoHQvusY/Kt9npI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800957; c=relaxed/simple;
	bh=yYniw+nMomrkaXx/2eY/JFaRy1+bu3nlJBcsTPMW/B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4A/EsySPJ6cWJ2ZLkjJujAJcz5j6hDmNu02NVBKB47a2KG2c1TBe1j7bptCtPqlDS3SvpK8tHN9bDsfCg6tuUHpY2LCeUHrj2XqcV9MtK4NoSL6ZUCheEdMC9aMjX2xLgxbxS7rdDGsus6AeX9ab0Y6aBr0Qre6/LDu/223y20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ccIlWhWl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMjOu1ta; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccIlWhWl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMjOu1ta"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790800954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GpJPw9HZuRWY2Huj01tPka8V1MVPItV+oRCso4TpIz0=;
	b=ccIlWhWlJVHHoD3TZ8bapeKlgR3TS5Kl+EcsrRHLqXmYUibjlyiWZG/WIdi8jqVO7cUI5i
	C4rrLWwFYXxY62YKZ5G+2ur01tcMufEIRN2lhMR/QLnHisUbwnVngYcnonptdlaTbSrYrX
	SqYXE+5f2NKzIzzv4+XG0T9iPMKJBb8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-D4AT-gWnPhCquQPpeN8lqQ-1; Wed, 30 Sep 2026 16:42:33 -0400
X-MC-Unique: D4AT-gWnPhCquQPpeN8lqQ-1
X-Mimecast-MFC-AGG-ID: D4AT-gWnPhCquQPpeN8lqQ_1790800952
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53124d6a362so162342831cf.0
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 13:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790800952; x=1791405752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GpJPw9HZuRWY2Huj01tPka8V1MVPItV+oRCso4TpIz0=;
        b=IMjOu1taGqJeIVxc8ZYbeW2PhZJTEnM8GlDa2rX+FteXgtdDv34zXha/38Rlo9ICow
         qRWWBilTLTspWmGyqLeiPMZPMwVB46oSN6hnj0Tq3jfLdFHmf5OLoZoU/t+SWsrHxE5/
         15viMYYrFV3FJrjVA+wdzA/iVXHYGofOsFh2Y5drcxZ4sihB/5SaCc0/99JIC8KgjW3g
         rizqArkqAuvFUajwC9nikZRYpwAm7iPw64OB+6Sgg2/skajOGZJuJq5EPHCMf5q6TUCq
         Pmi4Fv30cEw2mI8SividlK2l76sE+exQPxxMXU+30+w/nYEHPRCO0cu2gptTmJs6pLuC
         UF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790800952; x=1791405752;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GpJPw9HZuRWY2Huj01tPka8V1MVPItV+oRCso4TpIz0=;
        b=LoZ4hOxb1j5AgGDaeOZbBtxsAmpMZDa0AGlIMDPdcJlVj5qq03MmFPGjXVIMZNA6+9
         ANncVdRlBaahb1KAoT1KIiodjnAy7DQ3hvv1lWeSIj+4JxqVwiED65X35nQv9dVhsTz+
         +Y8n0zN6vIsLBQTkaDse2uQKzepW0CZB3usjEkB1ry4cKqiLKmdb9zJnWnnM8GiCR+OC
         amzoMSBkTnPq/9R5tNup/vjkFaZLHUILATwvwq+wz2PMy9myusplTmVDHMKyFHQL44LP
         z45uxVph6AgaAYbp4rm/9cbBesDfoTDyROt0P9WYjo1PpuPD4R/lK2sClvN5cISAv9b+
         niIA==
X-Forwarded-Encrypted: i=1; AKwUvBxUEITf9/ahe21czbCqJKqtoIIFxsohvdPb8ISVE1MfIwNlhjQGa9m2ljkhbSFmoWMiyyM=@vger.kernel.org
X-Gm-Message-State: AFuF++kJeXeqh8InuK+QJz5X1mfeZ+J/IT/cS3uwkUyX3fNTlzu9RAwR
	0Xv7q5Izr8DVTGNmkeb60dHdgjcS+/b7M/ipM3lXnFALx8XCJEc9DjyysLPGc1MSIqy1k893eL2
	o7y8Eo6ta9UjGbbs5WDQLq117AnH+TojqWHs6zanBUXn5fVyRAd323Q==
X-Gm-Gg: AYBFou0lRBYm1gFmsQU73M3/9m6tjzytQt/zgIwDr4SifVZUgJHQmqTAZ10oqmT53Qj
	0ziUk0Je2040THyglnVTfcZwUNhmnrrdFKAPBeU/LBT8MOFWrTDNRc7cssldb88CxM5B5U3z60M
	uhqDmAnuOq408PFku/MMmEmST4bFGTS95/F/bIo/wXfLaGzKUBIi1YTWK7jGmzXGfvEgLkfmBZC
	q4+l0ICLVE42dlR93X+aCfdxkSwREfC40+/DYzAV/wE3Ugu4WdjzIztTvNeJDSzagXyA4C/ds5v
	5inSAU3Crr5onHdwlP9bp+9UFSMXmt48cE6FJE/V+jgUTofudKza8ksXQ7n0NCY0proHpar3KsX
	r45KNdQ==
X-Received: by 2002:ac8:5ccb:0:b0:530:b2e2:d7da with SMTP id d75a77b69052e-53374dd4c8cmr47911471cf.53.1790800952266;
        Wed, 30 Sep 2026 13:42:32 -0700 (PDT)
X-Received: by 2002:ac8:5ccb:0:b0:530:b2e2:d7da with SMTP id d75a77b69052e-53374dd4c8cmr47910721cf.53.1790800951570;
        Wed, 30 Sep 2026 13:42:31 -0700 (PDT)
Received: from localhost ([142.188.212.246])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917a8a21755sm8290926d6.25.2026.09.30.13.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 13:42:30 -0700 (PDT)
Date: Wed, 30 Sep 2026 16:42:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: Artem Bityutskiy <dedekind1@gmail.com>,
	Tony Lindgren <tony.lindgren@linux.intel.com>,
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
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] Add KVM API for confidential guest live
 migration
Message-ID: <ar10Ncg2-GhzgBR9@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <a4ec3af5-5494-4fb4-bf66-e3a8b67325e3@intel.com>
 <arRGYbvXgq8LLYQH@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <9fa229ea-818c-4ba9-81c6-be7ead5cb60a@intel.com>
 <araC0YkwLVPhGfy0@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <784c4ecc-da9d-44b8-9adc-1d1e92d20ae3@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <784c4ecc-da9d-44b8-9adc-1d1e92d20ae3@intel.com>

On Mon, Sep 28, 2026 at 06:28:39PM -0700, Kishen Maloor wrote:
> Hi Peter,

Hi, Kishen,

[...]

> > So it seems TDX will "lock" the memory footprint in place when enabled,
> > allow accept/unaccept (or say, plug / unplug) memories, but anything like
> > "flipping this to that" will not work.
> 
> Yes, I think so. The TDX module holds the GPA->page binding, so any change has
> to pass through it. Adding and removing pages plumb through the module.
> But a sort of content preserving remap of GPAs in the way QEMU does for PAM
> is not possible AFAIU.

This still looks fine for TDX then, but I think we may want to make sure it
works properly for all the rest consumers of this API that we're aware of,
say, AMD, ARM CCA, etc.

Especially, MEM.IMPORT seems trickier to me: MEM.EXPORT even if described
in in GPA address space, can be converted to other address spaces at will,
as long as QEMU has full knowledge of the mappings.  MEM.IMPORT, OTOH, may
not trivially work in GPA terms, if memory mappings can overlap.

> 
> > Then there's a very corner case question I want to double check, and I
> > apologize if this is stupid only due to my ignorance on TDX knowledge: can
> > someone migrate a VM too early so TDX is just hasn't been enabled at all?
> 
> Not a stupid question at all. I've actually tried this. TDX VMs appear to
> migrate fine beyond a certain point mid-boot of the source. Kicking off 
> migration any earlier causes the destination not to resume, even though the 
> migration itself reports success. I haven't yet confirmed what that point is
> to explain it.
> 
> For now we're trying to settle on sound fundamentals for the UAPI and flow,
> but this is definitely an area to dig further into.

Ok.  Before any fixing lands, perhaps one can add a temprorary migration
blocker in QEMU and remove it after that mid-boot phase.

> 
> >>> I'm a bit surprised that TDX will also monitor how many times the same GPA
> >>> is updated per iteration.  What if below happens:
> >>
> >> Yes, and maybe that is because it won't know the ordering if the same
> >> GPA were caught at different times in the same epoch and fed to different
> >> migration streams (which one is newer?)
> >> On regular VMs, I believe QEMU doesn't migrate the same GPA twice in one round.
> >> As I understand it, a migrated GPA is revisited only in the next round.
> >> I suppose TDX just makes that behavior architectural.
> >>
> >>>   ...
> >>>   ITERATION sync n
> >>>   GET_DIRTY_LOG, see page P dirty
> >>>   migrate page P
> >>>   GET_DIRTY_LOG, see page P dirty again
> >>>   migrate page P again   <--------------------- [a]
> >>
> >> QEMU shouldn't transfer P again in the same round, right?
> > 
> > I believe yes with current QEMU, I can't think of anything otherwise.  But
> > still, this is very specific impl detail.  There's definitely no issue
> > migrating one page twice or more in non-CoCo.
> 
> Thanks for confirming this. But do you think it would be a problem during
> pre-copy with multifd on regular VM migration if we didn't have this
> "transfer once per round" logic?  If the same page got fed to different
> multifd queues, couldn't the older copy land after the newer one at the
> destination? [1]

Multifd has a flush logic per-iteration, so no chance an old version page
lands after a new version.  Can refer to multifd_ram_round_notify().

QEMU sometimes calls it "round" in the code or comment but it is the
ITERATION term we're talking about here.

NOTE, that function was merged very recently; you may need to pull latest
QEMU, but the logic existed for a long time, so even old multifd behaves
that way.

> 
> With a single channel it shouldn't matter, but it could with multiple
> channels. I think since the bitmap sweep is shared with multifd, QEMU ends up 
> transferring a page only once per round either way.

Normally, yes, the scanner submits pages to multifd threads, the scanner,
if scan one round of bitmap, can only submit one page once until the next
round / ITERATION.

But it may also be a matter of how that ioctl(ITERATION) will be done
inside QEMU; I'll need to reference to the QEMU PoC branch when ready to be
sure I have the correct understanding.  E.g., IIUC that ioctl(ITERATION)
needs to be done similarly "per-round" here to make sure one page appears
once, and we should also always keep in mind QEMU can still have
GET_DIRTY_LOG run in the background concurrently of the scanner, as I
mentioned that too somewhere else (which means one page can be dirtied
right after sending it, but as long as the scanner moves on with the next
page it looks still OK).

Thanks,

-- 
Peter Xu

