Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFB92E0B71
	for <kvm@vger.kernel.org>; Thu, 19 Feb 2026 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771530016; cv=none; b=HDf5cW+1Bqt43rGQLcIWO3GmJ70tR4Fk7iQ9ZfasZJIr5dALqHEXvfHwPjQHg//OddJTSd/MMZI7JtQlDz2cIR5KM0AfMrwrb4XQcEjyBX+P7WjpwpVHDo1JYhq0msb3YHTxnqq/XdM3B5iQyqD3ihURzuVPdUJPRuRu8l5dQRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771530016; c=relaxed/simple;
	bh=Yb/h3SWlZlbircOAun2JXTxFjNafy+0hCDeswET08Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKI0xFxvInCu/NgNqWmQiakI8ybJNLagfVWNmAS32cMFF969a8XQT9asxDf9Sc9on1QdTnJ8Wg8qRYdyJbpU2Hk/gnOXrvXvgDzf5IKs7CFr+jmC9ovPxBFSBGpphf3acisYQdqjXZL8/59+0uX522NmXjviI8FAf3WxnQzVxXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xim5Lbeq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FBhNfrko; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xim5Lbeq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBhNfrko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771530013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+I0GTYyR9NzqLZxw+F+YDaR+3n5QpSYWV3wkDlQpSA8=;
	b=Xim5LbeqTKbNYYbyb1L7VBsPS0uS8CqJeIs+Jb/cedulIhgjDwYI17q0WQjXL8wstxzkTR
	ET7ogTu7xoX1FqudH0Zo5PKqXdXbGuGLrT4/ognji23DrYXWIjt9zpSu1EVTsPFm5614DW
	qIAllh1pRSZSvrYcQ9Lfao8nM2ZtKSU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-GFVOg9aiP0iaqkgRNtaV1Q-1; Thu, 19 Feb 2026 14:40:11 -0500
X-MC-Unique: GFVOg9aiP0iaqkgRNtaV1Q-1
X-Mimecast-MFC-AGG-ID: GFVOg9aiP0iaqkgRNtaV1Q_1771530011
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb390a0c4eso1472773685a.1
        for <kvm@vger.kernel.org>; Thu, 19 Feb 2026 11:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771530011; x=1772134811; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+I0GTYyR9NzqLZxw+F+YDaR+3n5QpSYWV3wkDlQpSA8=;
        b=FBhNfrkodVcBkE+uMacln4RyyPYP01FeC/74RD5bn53vqxHYNUGKdMIR/RLkaXNOcK
         +p7fqsTSIlEXB70b9bC+EqrPk+b+ioYyr4cHq4FGSbKwcl6sf7uJ0CR836H7qbPPKqGN
         q4hxt+4W+vdHCZz3VqCF9FA7SajXlTowd8BOJGu9kwENo90toomiCEKqwq86F3NUK+/c
         wYa+uzmwXa48kq6IlJlHH2ltUUE8JIAIdIT+a5WuGRFkZc+//CFb9u6/rrTMkE/ALE9n
         unGT+yi39oO83+T0fQTMrxy7UMd0sTouxD/EJUpAux1+V5PeWgGjMNuIex1XoSyiCg9/
         Mq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771530011; x=1772134811;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+I0GTYyR9NzqLZxw+F+YDaR+3n5QpSYWV3wkDlQpSA8=;
        b=UrZziRxbu55lX1zbalhcyQEFH2y2nvwLhQx/uMd4tADwmdnn9Ujx4h/7sfKOCOjuzu
         RQ20wVpyBUZxRtynw721hszk3IGth7YxD+LOLhN57wDkfPEiCnF+xxCljS/RaYGCGkfg
         epz2nMpiQ0EXR+FwbdS1NQIepSp0fWgmHqODfXa4tAeMEoAnuKUP0Lk4uokvuOIgNihb
         H/ftnbih2xxeSnALfMxgedJAFLYa1H7CLQHQ3XjNt6tdMvyPuD+9WW1WHmB7BI+k1idy
         2JTFH737low2TMC/cHXE6uEQ/V5aC1KRFlkqKAWl7fJQotYQNk097sNSnBakxS+J7DmI
         +otw==
X-Forwarded-Encrypted: i=1; AJvYcCWg9vB5bMADpfodJAnExarn2ZnIG6OVyZp7N3f6GmfLtK8aoqclxJin8GGCVDajOb9zmlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAyScqlzuHeouKshqW5bXkw1UV0Ue68uB9A/n9tDI9G+Fn8s2e
	43h5IgT5if19u5fJYCsXZRijvJG1D17z5XbM+6llevoWp6cuHcNdKR09WDWX4iQoBneRURCIfQu
	d0c/O3LNMGuGWSR4zuap3in8nukcXQc3VbkrNF4Dd1u1tSKH2USiCpg==
X-Gm-Gg: AZuq6aKxP66TMfebpDQd34pFdMHCwzgMxAGDrhsT6c0aIViC3aOtkhKCUsALeWGfHCq
	zE+bRJTBibNp71WSHtSntq6eRFh3qxoar8ecEaMq+rdNgi+9LfaOdzAAdJYhYLxg7Y76sJnDVdT
	PRjD01ynB/ypaRVsemfcnPphkBYr84FPt12or/3F7p3Y0i6E9P9CSMVMyfjKU/y7CYrrvJV0DJD
	PIS1C6h67srpw+ZthNeXOoQpRoVb3lAHFAB+8jpoWEyNfXlr8ItxVj0Iq/ZFo2YWzBL1+tgmfyi
	pRpfMYymFrcvH5WDSGvS2HS0mTv+JJHr2b+FcWfSlucSEVnCbljCSTA3qdbiv9C0dvrK15DWOIN
	MOaPvtFPsnQC8Vw==
X-Received: by 2002:a05:620a:4d94:b0:8cb:50d6:18c3 with SMTP id af79cd13be357-8cb50d61b3dmr1532721785a.1.1771530010534;
        Thu, 19 Feb 2026 11:40:10 -0800 (PST)
X-Received: by 2002:a05:620a:4d94:b0:8cb:50d6:18c3 with SMTP id af79cd13be357-8cb50d61b3dmr1532718185a.1.1771530009994;
        Thu, 19 Feb 2026 11:40:09 -0800 (PST)
Received: from x1.local ([174.91.117.149])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0e12eesm2157317685a.15.2026.02.19.11.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 11:40:09 -0800 (PST)
Date: Thu, 19 Feb 2026 14:39:58 -0500
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,
	=?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
	kvm@vger.kernel.org, Alex Williamson <alex@shazbot.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ben Chaney <bchaney@akamai.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Fabiano Rosas <farosas@suse.de>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Mark Kanda <mark.kanda@oracle.com>
Subject: Re: [PATCH 06/10] system/memory: split RamDiscardManager into source
 and manager
Message-ID: <aZdnDrs9ivLctEIj@x1.local>
References: <20260204100708.724800-1-marcandre.lureau@redhat.com>
 <20260204100708.724800-7-marcandre.lureau@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260204100708.724800-7-marcandre.lureau@redhat.com>

On Wed, Feb 04, 2026 at 02:07:02PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Refactor the RamDiscardManager interface into two distinct components:
> - RamDiscardSource: An interface that state providers (virtio-mem,
>   RamBlockAttributes) implement to provide discard state information
>   (granularity, populated/discarded ranges, replay callbacks).
> - RamDiscardManager: A concrete QOM object that wraps a source, owns
>   the listener list, and handles listener registration/unregistration
>   and notifications.
> 
> This separation moves the listener management logic from individual
> source implementations into the central RamDiscardManager, reducing
> code duplication between virtio-mem and RamBlockAttributes.
> 
> The change prepares for future work where a RamDiscardManager could
> aggregate multiple sources.

The split of sources v.s. manager makes sense to me.

I didn't follow the whole history of how the discard manager evolved, but
IIUC it was called "discard manager" only because initially we were pretty
much focused on the DONTNEED side of things so that when things got dropped
we need to notify.

However IIUC the current status quo of the discard manager covers both
sides (population and discards).  It maintains what ranges of memory is
available in general for consumption by listeners.

For that, I wonder if during this major refactoring we should think about
renaming this slightly misleading name.  Considering that the major
difference of such special MR (either managed by virtio-mem or ramattr) is
about its "sparseness": say, not all of the memory is used but only a
portion of it to be used in a somehow sparsed fashion, maybe
SparseRamSources / SparseRamManager?  Another option I thought about is
DynamicRam*.

No strong feelings on the namings.  But raising this up in case you also
think it might be a good idea.

[...]

> @@ -699,50 +682,60 @@ struct RamDiscardManagerClass {
>       * @replay_discarded:
>       *
>       * Call the #ReplayRamDiscardState callback for all discarded parts within
> -     * the #MemoryRegionSection via the #RamDiscardManager.
> +     * the #MemoryRegionSection via the #RamDiscardSource.
>       *
> -     * @rdm: the #RamDiscardManager
> +     * @rds: the #RamDiscardSource
>       * @section: the #MemoryRegionSection
>       * @replay_fn: the #ReplayRamDiscardState callback
>       * @opaque: pointer to forward to the callback
>       *
>       * Returns 0 on success, or a negative error if any notification failed.
>       */
> -    int (*replay_discarded)(const RamDiscardManager *rdm,
> +    int (*replay_discarded)(const RamDiscardSource *rds,
>                              MemoryRegionSection *section,
>                              ReplayRamDiscardState replay_fn, void *opaque);

A major question I have here is how we should process replay_populated()
and replay_discarded() when split the class.

I had a gut feeling that this should not belong to the *Source object,
instead it might be more suitable for the manager?

I read into some later patches and I fully agree with your definition of
aggregations when there're multiple sources, which mentioned in the commit
messsages later of this part:

    The aggregation uses:
    - Populated: ALL sources populated
    - Discarded: ANY source discarded

IOW, a piece of mem that is "private" in terms of ram attr manager, but
"populated" in terms of virtio-mem, should be treated as discarded indeed.

However I also saw that in some follow up patches the series did a trick to
fetch the first Source then invoke the replay hook on the first source:

int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
                                         const MemoryRegionSection *section,
                                         ReplayRamDiscardState replay_fn,
                                         void *opaque)
{
    RamDiscardSourceEntry *first;
    ReplayCtx ctx;

    first = QLIST_FIRST(&rdm->source_list);
    if (!first) {
        return replay_fn(section, opaque);
    }

    ctx.rdm = rdm;
    ctx.replay_fn = replay_fn;
    ctx.user_opaque = opaque;

    return ram_discard_source_replay_populated(first->rds, section,
                                               aggregated_replay_populated_cb,
                                               &ctx);
}

It seems to me that aggregated_replay_populated_cb() will indeed still do
the proper aggregations, however if we could move the replay functions into
the manager (or do we need it to be a hook at all?  Perhaps it will just be
an API of the manager?), then we don't need this trick of fetching the 1st
source, instead the manager should do the math of "AND all the sources on
reported populated info" then invoke the listener handlers.  Maybe that'll
be cleaner from the high level.

What do you think?

Thanks,

-- 
Peter Xu

