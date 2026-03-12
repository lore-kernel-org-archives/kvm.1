Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E40426F288
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 20:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346612; cv=none; b=O/HBkG0R5ZZcbx72c/l7vBFYl2bpKWSdToCIFDHpv4ZiYdZiJvxkwNU6bqwlb/NVRzbQNcnJ/xOH+kjsCFu2r5H1vmPhO/jeq9Bcqe3tsHvhuhuyz/ooNo0AUVRnzzpV2Y2CV2oL7f9nmZTRJsp4+jQAGHu2/O/PoCQt3ACvvdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346612; c=relaxed/simple;
	bh=QHE6iyyvDr40yfVCax+FdyjHYEVd7EKg6pvQbTGrt2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vfu7dN0A/CzSimSxKzBzuaRTfBhaBERXh0Q/DQZTgxDcwq9e+MuLAmTfduh0BEpj3B/4tXNtqJ9j+mXm0PcrjXIHgUuSgG6452DynoEHde9ChAtnip8S9OnLvZC3cvCsc6kb0s2KmOjSOqGVv45HbaG76BpTb0u+SrR8wPM1KSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IDvwYLuz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nQXlz7NY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDvwYLuz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nQXlz7NY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773346610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h1HBFzhSFxQEwXgSYQ9wkWANIOtO1PybFXCRQaEKDww=;
	b=IDvwYLuzUTLnCxjguZr29+ZnVh0+vtQYFr+6B656TdTl5r8db/P9B4r1CcDlN+3lFhAGSP
	zoOBK5G/L9Vp6WjfM7yuq+OuNk30E8fkkUYBrqB+8nSB4zxHMGpmxGu8XOeG0Idpjq9w53
	yHEe2cl4LbcDwb8y5vrIOBECZTrolEg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-58g47-VhOgyp1RgZ4hYCGg-1; Thu, 12 Mar 2026 16:16:48 -0400
X-MC-Unique: 58g47-VhOgyp1RgZ4hYCGg-1
X-Mimecast-MFC-AGG-ID: 58g47-VhOgyp1RgZ4hYCGg_1773346608
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-899fead92c6so119263106d6.0
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 13:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773346608; x=1773951408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h1HBFzhSFxQEwXgSYQ9wkWANIOtO1PybFXCRQaEKDww=;
        b=nQXlz7NYxI0AWx597BZwbglKI8NSSXMYeUQzeW/pxSnmwajc04JUlNJkBKu8/P5dQW
         Oa2X1EOScD1ughw9aQmqt0IoZbzj9e7wHh2y06ngv99CBB8WqHFHNy3G1tYDs1YVesYw
         iBtUr1Zl2rx7SU25g8V62Mk0WkIsxTdTM+gULQnX8eNqbJ8uz3kTQnlCccBohhSFAYL/
         oOai1I56+xnG/9KhK2izt30VgDEo5Mu54ToaoYpr8m0G6ry12IJtaKTgI3Gmf4tvy4Eb
         kn7cVYarLT1WIm44Zpz5HdD9wfrDVqc7WRNkoSjMP72ICAuYDhxX5iKczILHJ8APRNWx
         kyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773346608; x=1773951408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1HBFzhSFxQEwXgSYQ9wkWANIOtO1PybFXCRQaEKDww=;
        b=vwM70LpcCEWY5nizlFnFuND2jvr+2NAZc4ApMxGJeNMSY0qlxNNPm1c3jRVdNXUsgB
         pV6vPDwcJ0xq+lTHEg0xsj8LH/g3Q9b54hV7FL0/IV+hAgFalG7aVK0LTHBMjTYOBXWR
         v9qkG/da4iknUcyRSf2et/jeGyfwSY7D8L4mnhifgL2NlhE7URfjTVZjBVlhkr6Kyt9Q
         O47ncQe1i182y9FNYF5t5S5tWzcCinCVLZwMam8u18DNjtYBw+hL0YJni+o0dBHkEh1z
         0WL4bgkZVoDnzJdruLp8URGkKEG6k9a5mNP0yG+MLyun+v7NnfZUfaVbnUivOUUb8VZY
         K5fw==
X-Forwarded-Encrypted: i=1; AJvYcCX3q4D6GVidCWIrn3o8QM7DRttpYICtIqyD2PvDWQSKUdEu9dMXAmSYUF+d/5/xkmnD+D8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp0zk397KOglQeFHzQ318yi7cFpUiw/AkKqupM6YJY8DMyNhYv
	YW/Cf11udO/LtaK0JzRIBVXk/xP08JbvZJYrOzTcjizzxqmqQHN8hoZjGZz9qE7GM6/uDbjzd9Y
	0fy+mYtObi4GEq6Oiyw2nZm0Dc0pdsupB5qDJx+9Qq1Mf8y6rrEr2Ww==
X-Gm-Gg: ATEYQzwGcWsDgaR0C2VbLOI1AM/Tq/gYNfIwig1ggAGko20mWGEzSN2NfFnSDOx2eNT
	gdRDKpmcOnDPyTGb2iN8ZVmQFbvN4UjcJuNKeYs6wL05LtWtgXu4K0GLyd4uUA7lqM+Ggk70Er7
	7b5eMKtNa1L6mnZ/FGFsJKk6p2l1cN+EgKYCaILwdJOSAIPWqZpKxnpXkLNG8Hw5h3nZdssGlLC
	s4hU4scj3lfkVclqpksY3CY/UmAqsEuyluHPZVefPMUZU+PdIdghWqEr2QC+E+ER7q4IdsYrx+x
	9re3LFW/F5knomjSNeajuJ1hXn3OyleYiTzWcBt69NKHeIodY4rO6cUoH42kB5L5npPHbs6lLl5
	Pf3lHHYX7RfhU3g==
X-Received: by 2002:ad4:5743:0:b0:89a:629:2203 with SMTP id 6a1803df08f44-89a81d44b05mr16969176d6.11.1773346608123;
        Thu, 12 Mar 2026 13:16:48 -0700 (PDT)
X-Received: by 2002:ad4:5743:0:b0:89a:629:2203 with SMTP id 6a1803df08f44-89a81d44b05mr16968616d6.11.1773346607545;
        Thu, 12 Mar 2026 13:16:47 -0700 (PDT)
Received: from x1.local ([142.189.10.167])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65beb4besm41315866d6.15.2026.03.12.13.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 13:16:47 -0700 (PDT)
Date: Thu, 12 Mar 2026 16:16:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Yishai Hadas <yishaih@nvidia.com>, jgg@nvidia.com, kvm@vger.kernel.org,
	kevin.tian@intel.com, joao.m.martins@oracle.com, leonro@nvidia.com,
	maorg@nvidia.com, avihaih@nvidia.com, clg@redhat.com,
	liulongfang@huawei.com, giovanni.cabiddu@intel.com,
	kwankhede@nvidia.com
Subject: Re: [PATCH V1 vfio 6/6] vfio/mlx5: Add REINIT support to
 VFIO_MIG_GET_PRECOPY_INFO
Message-ID: <abMfLQPzVFK388q_@x1.local>
References: <20260310164006.4020-1-yishaih@nvidia.com>
 <20260310164006.4020-7-yishaih@nvidia.com>
 <abL5wKfPGzi88iBy@x1.local>
 <20260312130817.69ff3e60@shazbot.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260312130817.69ff3e60@shazbot.org>

On Thu, Mar 12, 2026 at 01:08:17PM -0600, Alex Williamson wrote:
> Hey Peter,

Hey, Alex,

> 
> On Thu, 12 Mar 2026 13:37:04 -0400
> Peter Xu <peterx@redhat.com> wrote:
> 
> > Hi, Yishai,
> > 
> > Please feel free to treat my comments as pure questions only.
> > 
> > On Tue, Mar 10, 2026 at 06:40:06PM +0200, Yishai Hadas wrote:
> > > When userspace opts into VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2, the
> > > driver may report the VFIO_PRECOPY_INFO_REINIT output flag in response
> > > to the VFIO_MIG_GET_PRECOPY_INFO ioctl, along with a new initial_bytes
> > > value.  
> > 
> > Does it also mean that VFIO_PRECOPY_INFO_REINIT is almost only a hint that
> > can be deduced by the userspace too, if it remembers the last time fetch of
> > initial_bytes?
> 
> I'll try to answer some of these.  PRECOPY_INFO is already just a hint.
> We essentially define initial_bytes as the "please copy this before
> migration to avoid high latency setup" and dirty_bytes is "I also have
> this much dirty state I could give to you now".  We've defined
> initial_bytes as monotonically decreasing, so a user could deduce that
> they've passed the intended high latency setup threshold, while
> dirty_bytes is purely volatile.

I see..  That might be another problem though to switchover decisions.

Currently, QEMU relies on dirty reporting to decide when to switchover.

What it does is asking all the modules for how many dirty data left, then
src QEMU do a sum, divide that sum with the estimated bandwidth to guess
the downtime.

When the estimated downtime is small enough so as to satisfy the user
specified downtime, QEMU src will switchover.  This didn't take
switchover_ack for VFIO into account, but it's a separate concept.

Above was based on the fact that the reported values are "total data", not
"what you can collect"..

Is there possible way to provide a total amount?  It can even be a maximum
total amount just to cap the downtime.  If with the current reporting
definition, VM is destined to have unpredictable live migration downtime
when relevant VFIO devices are involved.

The larger the diff between the current reported dirty value v.s. "total
data", the larger the downtime mistake can happen.

> 
> The trouble comes, for example, if the device has undergone a
> reconfiguration during migration, which may effectively negate the
> initial_bytes and switchover-ack.

Ah so it's about that, thanks.  IMHO it might be great if Yishai could
mention the source of growing initial_bytes somewhere in the commit log, or
even when documenting the new feature bit.

> 
> A user deducing they've sent enough device data to cover initial_bytes
> is essentially what we have now because our protocol doesn't allow the
> driver to reset initial_bytes.  The driver may choose to send that
> reconfiguration information in dirty_bytes bytes, but we don't
> currently have any way to indicate to the user that data remaining
> there is of higher importance for startup on the target than any other
> dirtying of device state.
> 
> Hopefully the user/VMM is already polling the interface for dirty
> bytes, where with the opt-in for the protocol change here, allows the
> driver to split out the priority bytes versus the background dirtying. 
>  
> > It definitely sounds a bit weird when some initial_* data can actually
> > change, because it's not "initial_" anymore.
> 
> It's just a priority scheme.  In the case I've outlined above it might
> be more aptly named setup_bytes or critical_bytes as you've used, but
> another driver might just use it for detecting migration compatibility.
> Naming is hard.

Yep. :) initial_bytes is still fine at least to me.  I wonder if we could
still update the document of this field, then it'll be good enough.

>  
> > Another question is, if initial_bytes reached zero, could it be boosted
> > again to be non-zero?
> 
> Under the new protocol, yes, and the REINIT flag would be set indicate
> it had been reset.  Under the old protocol, no.
>  
> > I don't see what stops it from happening, if the "we get some fresh new
> > critical data" seem to be able to happen anytime..  but if so, I wonder if
> > it's a problem to QEMU: when initial_bytes reported to 0 at least _once_ it
> > means it's possible src QEMU decides to switchover.  Then looks like it
> > beats the purpose of "don't switchover until we flush the critical data"
> > whole idea.
> 
> The definition of the protocol in the header stop it from happening.
> We can't know that there isn't some userspace that follows the
> deduction protocol rather than polling.  We don't know there isn't some
> userspace that segfaults if initial_bytes doesn't follow the published
> protocol.  Therefore opt-in where we have a mechanism to expose a new
> initial_bytes session without it becoming a purely volatile value.

Here, IMHO the problem is QEMU still needs to know when a switchover can
happen.

After a new QEMU probing this new driver feature bit and enable it, now
initial_bytes can be incremented when REINIT flag set.  This is fine on its
own.  But then, src QEMU still needs to decide when it can switch over.

It seems to me the only way to do it (with/without the new feature bit
enabled), is to relying on initial_bytes being zero.  When it's zero, it
means all possible "critical data" has been moved, then src QEMU can
kickoff that "switchover" message.

After that, IIUC we need to be prepared to trigger switchover anytime.

With the new REINIT, it means we can still observe REINIT event after src
QEMU making that decision.  Would that be a problem?

Nowadays, when looking at vfio code, what happens is src QEMU after seeing
initial_bytes==0 send one VFIO_MIG_FLAG_DEV_INIT_DATA_SENT to dest QEMU,
later dst QEMU will ack that by sending back MIG_RP_MSG_SWITCHOVER_ACK.
Then switchover can happen anytime by the downtime calculation above.

Maybe there should be solution in the userspace to fix it, but we'll need
to figure it out.  Likely, we need one way or another to revoke the
switchover message, so ultimately we need to stop VM, query the last time,
seeing initial_bytes==0, then it can proceed with switchover.  If it sees
initial_bytes nonzero again, it will need to restart the VM and revoke the
previous message somehow.

>  
> > Is there a way the HW can report and confidentally say no further critical
> > data will be generated?
> 
> So long as there's a guest userspace running that can reconfigure the
> device, no.  But if you stop the vCPUs and test PRECOPY_INFO, it should
> be reliable.

This is definitely an important piece of info.  I recall Zhiyi used to tell
me there's no way to really stop a VFIO device from generating dirty data.
Happy to know it seems there seems to still be a way.  And now I suspect
what Zhiyi observed was exactly seeing dirty_bytes growing even after VM
stopped.  If that counter means "how much you can read" it all makes more
sense (even though it may suffer from the issue I mentioned above).

> 
> > > The presence of the VFIO_PRECOPY_INFO_REINIT flag indicates to the
> > > caller that new initial data is available in the migration stream.
> > > 
> > > If the firmware reports a new initial-data chunk, any previously dirty
> > > bytes in memory are treated as initial bytes, since the caller must read
> > > both sets before reaching the end of the initial-data region.  
> > 
> > This is unfortunate.  I believe it's a limtation because of the current
> > single fd streaming protocol, so HW can only append things because it's
> > kind of a pipeline.
> > 
> > One thing to mention is, I recall VFIO migration suffers from a major
> > bottleneck on read() of the VFIO FD, it means this streaming whole design
> > is also causing other perf issues.
> > 
> > Have you or anyone thought about making it not a stream anymore?  Take
> > example of RAM blocks: it is pagesize accessible, with that we can do a lot
> > more, e.g. we don't need to streamline pages, we can send pages in whatever
> > order.  Meanwhile, we can send pages concurrently because they're not
> > streamlined too.
> > 
> > I wonder if VFIO FDs can provide something like that too, as a start it
> > doesn't need to be as fine granule, maybe at least instead of using one
> > stream it can provide two streams, one for initial_bytes (or, I really
> > think this should be called "critical data" or something similar, if it
> > represents that rather than "some initial states", not anymore), another
> > one for dirty.  Then at least when you attach new critical data you don't
> > need to flush dirty queue too.
> > 
> > If to extend it a bit more, then we can also make e.g. dirty queue to be
> > multiple FDs, so that userspace can read() in multiple threads, speeding up
> > the switchover phase.
> > 
> > I had a vague memory that there's sometimes kernel big locks to block it,
> > but from interfacing POV it sounds always better to avoid using one fd to
> > stream everything.
> 
> I'll leave it to others to brainstorm improvements, but I'll note that
> flushing dirty_bytes is a driver policy, another driver could consider
> unread dirty bytes as invalidated by new initial_bytes and reset
> counters.
> 
> It's not clear to me that there's generic algorithm to use for handling
> device state as addressable blocks rather than serialized into a data
> stream.  Multiple streams of different priorities seems feasible, but
> now we're talking about a v3 migration protocol.  Thanks,

Yep, definitely not a request to invent v3 yet, but just to brainstorm it.
It doesn't need to be all-things addressable, index-able (e.g. via >1
objects) would be also nice even through one fd, then it can also be
threadified somehow.

It seems the HW designer needs to understand how hypervisor works on
collecting these HW data, so it does look like a hard problem when it's all
across the stack from silicon layer..

I just had a feeling that v3 (or more) will come at some point when we want
to finally resolve the VFIO downtime problems..

Thanks,

-- 
Peter Xu

