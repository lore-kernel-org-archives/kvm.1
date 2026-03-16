Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754FA3E5EDE
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 19:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773689100; cv=none; b=Xt66Fbp4hWUF+A99gpw1fdH3gVl3NKeOYQPgWmuCnGl1wb2zHwcuD9WPshErxGEn+Wm5fG+JnlLaSf4J8C64SQOCSFBaza3ydZq7P2qrUL/FeavWryLPIxtXlO7ik6sxCPmaJ5T3HoiAouu4jlfqf5B93+mU9DdW8e4HRoBf5hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773689100; c=relaxed/simple;
	bh=WwLT3F9cm7hgu+w4uiCEwprQU6EHgPbhEV2X2keq6Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0++4YItLGlzDhyz6Qd1gnNu3reJ2bmu7QmPHSV4TXveRK4CF4XiH0e3q1ds4IvV2nVMaPraqeNJskbDxUJVRDKLYsnLzwl5iNKIRbFiVhScFC5wlxFJ73H2KrlwQBaORXZsvJZVhsvqFx/o3TbuNM4jVkvPJX9C1Ce+s5spnTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a6jn+dua; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TKfE5FWs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6jn+dua";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKfE5FWs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773689097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NLGtp3LU6HGHNlnSOBma33L7xD5k2WlTsV6P1lC4WEc=;
	b=a6jn+duaoxBd4izxk4D9LAv2iXHYVq36wFoGlhwuLkvqs3hcak200LJs+HhecjZaL0T8f7
	ejir+mDnD2EbzC7TcjH7nJHxtd2rCrhE9hu7PYvtZ5P7z7K845hnD07O8wVrkWb6NYcbCC
	6mk8wtwEu6oI5dGg5iAc8J1zyFAUgBY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-bpvS4rTbPDKk2EcJyrwtHQ-1; Mon, 16 Mar 2026 15:24:56 -0400
X-MC-Unique: bpvS4rTbPDKk2EcJyrwtHQ-1
X-Mimecast-MFC-AGG-ID: bpvS4rTbPDKk2EcJyrwtHQ_1773689095
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50921f7da6dso53835731cf.0
        for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 12:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773689095; x=1774293895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NLGtp3LU6HGHNlnSOBma33L7xD5k2WlTsV6P1lC4WEc=;
        b=TKfE5FWsjTxwNIcOJU4OgAaaJIif0n4UnWiUKskHRjPjRu4ifxrW5nV/2iOfime9Bx
         imVh70iT1G50o+x/KEy3c5VYD8O07J/GcBgUhmgqZzAvwx2MJBkbN2VDYQJ6MOHNP2Cn
         rAc+6W4Ndnvk3EX83YpgGa9HjYoKkbRyDeqFRKNvGQJcdjvKK46674uiAveg+/qHqtTi
         SG0+zpXD2/UAqBN28utCjI5R/SNozh7XGxSQrekij42MEdZ49HhAel531MvKIoeapt99
         C1WKKbzgfQQwdELye2ZAz/ngnJO4cVXcfQKvouAot1IbAn5EzRXozdFob7mp94492jgi
         4S4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773689095; x=1774293895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLGtp3LU6HGHNlnSOBma33L7xD5k2WlTsV6P1lC4WEc=;
        b=EDk6QkeNzN+Vgwb+v5fnu8OSAcf9vYkjVYTb1WKWsQtsRRKEAQbm8wkd+20pPrYvra
         fE8kP9UOSqIYUp+qHgasGQBF6lv2FdfKOMROIkPESD8A6zW6ah3/r7674+xW2KSLiKMv
         F4aF/71NlM/ZNEFaNfFfVGaBqQaAu7iUEDBMfGRWIFlDwWSktTXMwKqI/D6G8ODDMGMH
         o9GWshoJoLCb0SaYJEF2Mc1XJgBCt1rhJQ4UgB8XQ4sio7v5SN95Wh7ReCsrlb4+YXxp
         9PdEKyhTqXe6dEzWdKPlCQDShBwEzwveiY8xzMR+/h3jik/wMj+uZN18MTE+j8Eg5Pz5
         zlgw==
X-Forwarded-Encrypted: i=1; AJvYcCUp0mpVt9xznyUH5rce+WiRhSnjVkXI1j0J6IzZB7B1TtXswC2FHOAC9/OLXexvzBQIvDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc1YjTE+KajPdHoZPEtRYEyFALYYHXYaOgQbE9P621E4KiS5Dk
	bxrqWzXbSVPqNTqvznfBE/+DNORt7DlpUSXEptqvNd8CE7ynqFIosiGSyDRz7+IzwyFAKSkH1vw
	OdGHWEt7kRKYfnxgcqRrvRV+fXgsCAkIjjlG2nXwIbLpZ7IQ4DMfshQ==
X-Gm-Gg: ATEYQzwVcqe0mdkU8exCtMm/JXQ96Y88wP0T07wWnckaA4uQXW+2STJXJT20WhOQvbL
	CXNoPuOxwZm6toYPRdgVxrYHPW1fawU4GJRtCI2HkrDSIt6wwR+4O1G4pSOwjWT3rZLCNnV/jVF
	Ov3vSYhYHDCfynmkonCFob54HCRzS1REWDZ329MVIhBC45ChJyAfSmFicfdHWoU4BhHAo2pufNO
	BXdrxRtl09iYZ0383YMFU5uP/HPFeAkswU1lG631WSyCyFlp/B8Wamd+r2BlVxp275I+k1KgyPb
	ZB5EPCa8I6jPad+M7hnzyN4qNisk3J9VMd+0pKtdWWPDCzPcvFYO5828FHtb8dRpFQy8T19jgSz
	vzkpgFutXVdwYug==
X-Received: by 2002:a05:622a:1996:b0:509:116c:8e05 with SMTP id d75a77b69052e-50957e0105cmr189112071cf.43.1773689095343;
        Mon, 16 Mar 2026 12:24:55 -0700 (PDT)
X-Received: by 2002:a05:622a:1996:b0:509:116c:8e05 with SMTP id d75a77b69052e-50957e0105cmr189111641cf.43.1773689094662;
        Mon, 16 Mar 2026 12:24:54 -0700 (PDT)
Received: from x1.local ([142.189.10.167])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c463af3e9sm56503366d6.46.2026.03.16.12.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 12:24:54 -0700 (PDT)
Date: Mon, 16 Mar 2026 15:24:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, jgg@nvidia.com, kvm@vger.kernel.org,
	kevin.tian@intel.com, joao.m.martins@oracle.com, leonro@nvidia.com,
	maorg@nvidia.com, avihaih@nvidia.com, clg@redhat.com,
	liulongfang@huawei.com, giovanni.cabiddu@intel.com,
	kwankhede@nvidia.com
Subject: Re: [PATCH V1 vfio 6/6] vfio/mlx5: Add REINIT support to
 VFIO_MIG_GET_PRECOPY_INFO
Message-ID: <abhZBIe-vR-GX3TT@x1.local>
References: <20260310164006.4020-1-yishaih@nvidia.com>
 <20260310164006.4020-7-yishaih@nvidia.com>
 <abL5wKfPGzi88iBy@x1.local>
 <20260312130817.69ff3e60@shazbot.org>
 <abMfLQPzVFK388q_@x1.local>
 <fb6cb519-25d0-4cba-b13f-513349fb49db@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb6cb519-25d0-4cba-b13f-513349fb49db@nvidia.com>

On Sun, Mar 15, 2026 at 04:19:18PM +0200, Yishai Hadas wrote:
> On 12/03/2026 22:16, Peter Xu wrote:
> > On Thu, Mar 12, 2026 at 01:08:17PM -0600, Alex Williamson wrote:
> > > Hey Peter,
> > 
> > Hey, Alex,
> > 
> > > 
> > > On Thu, 12 Mar 2026 13:37:04 -0400
> > > Peter Xu <peterx@redhat.com> wrote:
> > > 
> > > > Hi, Yishai,
> > > > 
> > > > Please feel free to treat my comments as pure questions only.
> > > > 
> > > > On Tue, Mar 10, 2026 at 06:40:06PM +0200, Yishai Hadas wrote:
> > > > > When userspace opts into VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2, the
> > > > > driver may report the VFIO_PRECOPY_INFO_REINIT output flag in response
> > > > > to the VFIO_MIG_GET_PRECOPY_INFO ioctl, along with a new initial_bytes
> > > > > value.
> > > > 
> > > > Does it also mean that VFIO_PRECOPY_INFO_REINIT is almost only a hint that
> > > > can be deduced by the userspace too, if it remembers the last time fetch of
> > > > initial_bytes?
> > > 
> > > I'll try to answer some of these.  PRECOPY_INFO is already just a hint.
> > > We essentially define initial_bytes as the "please copy this before
> > > migration to avoid high latency setup" and dirty_bytes is "I also have
> > > this much dirty state I could give to you now".  We've defined
> > > initial_bytes as monotonically decreasing, so a user could deduce that
> > > they've passed the intended high latency setup threshold, while
> > > dirty_bytes is purely volatile.
> > 
> > I see..  That might be another problem though to switchover decisions.
> > 
> > Currently, QEMU relies on dirty reporting to decide when to switchover.
> > 
> > What it does is asking all the modules for how many dirty data left, then
> > src QEMU do a sum, divide that sum with the estimated bandwidth to guess
> > the downtime.
> > 
> > When the estimated downtime is small enough so as to satisfy the user
> > specified downtime, QEMU src will switchover.  This didn't take
> > switchover_ack for VFIO into account, but it's a separate concept.
> > 
> > Above was based on the fact that the reported values are "total data", not
> > "what you can collect"..
> > 
> > Is there possible way to provide a total amount?  It can even be a maximum
> > total amount just to cap the downtime.
> 
> The total amount is already reported today via the
> VFIO_DEVICE_FEATURE_MIG_DATA_SIZE ioctl and QEMU accounts that in the
> switchover decision.

Ok, I somehow got the impression that initial+dirty should be the total
previously.  It's likely because I was referring to this piece of code in
QEMU:

static void vfio_state_pending_estimate(void *opaque, uint64_t *must_precopy,
                                        uint64_t *can_postcopy)
{
    VFIODevice *vbasedev = opaque;
    VFIOMigration *migration = vbasedev->migration;

    if (!vfio_device_state_is_precopy(vbasedev)) {
        return;
    }

    *must_precopy +=
        migration->precopy_init_size + migration->precopy_dirty_size;

    trace_vfio_state_pending_estimate(vbasedev->name, *must_precopy,
                                      *can_postcopy,
                                      migration->precopy_init_size,
                                      migration->precopy_dirty_size);
}

After you said so, I found indeed the exact() version is fetching the
stop-size:

static void vfio_state_pending_exact(void *opaque, uint64_t *must_precopy,
                                     uint64_t *can_postcopy)
{
    VFIODevice *vbasedev = opaque;
    VFIOMigration *migration = vbasedev->migration;
    uint64_t stop_copy_size = VFIO_MIG_STOP_COPY_SIZE;

    /*
     * If getting pending migration size fails, VFIO_MIG_STOP_COPY_SIZE is
     * reported so downtime limit won't be violated.
     */
    vfio_query_stop_copy_size(vbasedev, &stop_copy_size);
    *must_precopy += stop_copy_size;

    if (vfio_device_state_is_precopy(vbasedev)) {
        vfio_query_precopy_size(migration);
    }

    trace_vfio_state_pending_exact(vbasedev->name, *must_precopy, *can_postcopy,
                                   stop_copy_size, migration->precopy_init_size,
                                   migration->precopy_dirty_size);
}

Do you know why the estimate version doesn't report a cached stop_size
instead?

Reporting different things will also confuse QEMU in its estimate() and
exact() hooks.  They should report the same thing except that the
estimate() can use a fast path for cached value.

> 
>  If with the current reporting
> > definition, VM is destined to have unpredictable live migration downtime
> > when relevant VFIO devices are involved.
> > 
> > The larger the diff between the current reported dirty value v.s. "total
> > data", the larger the downtime mistake can happen.
> > 
> > > 
> > > The trouble comes, for example, if the device has undergone a
> > > reconfiguration during migration, which may effectively negate the
> > > initial_bytes and switchover-ack.
> > 
> > Ah so it's about that, thanks.  IMHO it might be great if Yishai could
> > mention the source of growing initial_bytes somewhere in the commit log, or
> > even when documenting the new feature bit.
> 
> Sure, we can add as part of V2 the below chunk when documenting the new
> feature.
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 90e51e84539d..bb4a2df0550d 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1268,6 +1268,8 @@ enum vfio_device_mig_state {
>   * value and decrease as migration data is read from the device.
>   * The presence of the VFIO_PRECOPY_INFO_REINIT output flag indicates
>   * that new initial data is present on the stream.
> + * The new initial data may result, for example, from device
> reconfiguration
> + * during migration that requires additional initialization data.

This is helpful at least to me, thanks.

> 
> 
> > 
> > > 
> > > A user deducing they've sent enough device data to cover initial_bytes
> > > is essentially what we have now because our protocol doesn't allow the
> > > driver to reset initial_bytes.  The driver may choose to send that
> > > reconfiguration information in dirty_bytes bytes, but we don't
> > > currently have any way to indicate to the user that data remaining
> > > there is of higher importance for startup on the target than any other
> > > dirtying of device state.
> > > 
> > > Hopefully the user/VMM is already polling the interface for dirty
> > > bytes, where with the opt-in for the protocol change here, allows the
> > > driver to split out the priority bytes versus the background dirtying.
> > > > It definitely sounds a bit weird when some initial_* data can actually
> > > > change, because it's not "initial_" anymore.
> > > 
> > > It's just a priority scheme.  In the case I've outlined above it might
> > > be more aptly named setup_bytes or critical_bytes as you've used, but
> > > another driver might just use it for detecting migration compatibility.
> > > Naming is hard.
> > 
> > Yep. :) initial_bytes is still fine at least to me.  I wonder if we could
> > still update the document of this field, then it'll be good enough.
> 
> As Alex mentioned, initial_bytes can be used for various purposes.
> 
> So, I would keep the existing description in the uAPI.
> 
> In the context of the new feature, the uAPI commit message refers to
> initial_bytes as 'critical data', to explain the motivation behind the
> feature. Together with the extra chunk in the uAPI suggested above, I
> believe this clarifies the intended usage.
> 
> Makes sense ?

As long as Alex is happy with it, I'm OK either way.

> 
> > 
> > > > Another question is, if initial_bytes reached zero, could it be boosted
> > > > again to be non-zero?
> > > 
> > > Under the new protocol, yes, and the REINIT flag would be set indicate
> > > it had been reset.  Under the old protocol, no.
> > > > I don't see what stops it from happening, if the "we get some fresh new
> > > > critical data" seem to be able to happen anytime..  but if so, I wonder if
> > > > it's a problem to QEMU: when initial_bytes reported to 0 at least _once_ it
> > > > means it's possible src QEMU decides to switchover.  Then looks like it
> > > > beats the purpose of "don't switchover until we flush the critical data"
> > > > whole idea.
> > > 
> > > The definition of the protocol in the header stop it from happening.
> > > We can't know that there isn't some userspace that follows the
> > > deduction protocol rather than polling.  We don't know there isn't some
> > > userspace that segfaults if initial_bytes doesn't follow the published
> > > protocol.  Therefore opt-in where we have a mechanism to expose a new
> > > initial_bytes session without it becoming a purely volatile value.
> > 
> > Here, IMHO the problem is QEMU still needs to know when a switchover can
> > happen.
> > 
> > After a new QEMU probing this new driver feature bit and enable it, now
> > initial_bytes can be incremented when REINIT flag set.  This is fine on its
> > own.  But then, src QEMU still needs to decide when it can switch over.
> > 
> > It seems to me the only way to do it (with/without the new feature bit
> > enabled), is to relying on initial_bytes being zero.  When it's zero, it
> > means all possible "critical data" has been moved, then src QEMU can
> > kickoff that "switchover" message.
> > 
> > After that, IIUC we need to be prepared to trigger switchover anytime.
> > 
> > With the new REINIT, it means we can still observe REINIT event after src
> > QEMU making that decision.  Would that be a problem?
> > 
> > Nowadays, when looking at vfio code, what happens is src QEMU after seeing
> > initial_bytes==0 send one VFIO_MIG_FLAG_DEV_INIT_DATA_SENT to dest QEMU,
> > later dst QEMU will ack that by sending back MIG_RP_MSG_SWITCHOVER_ACK.
> > Then switchover can happen anytime by the downtime calculation above.
> > 
> > Maybe there should be solution in the userspace to fix it, but we'll need
> > to figure it out.  Likely, we need one way or another to revoke the
> > switchover message, so ultimately we need to stop VM, query the last time,
> > seeing initial_bytes==0, then it can proceed with switchover.  If it sees
> > initial_bytes nonzero again, it will need to restart the VM and revoke the
> > previous message somehow.
> 
> The counterpart QEMU series that we pointed to, handles that in similar way
> to what you described.
> 
> The switchover-ack mechanism is modified to be revoke-able and a final query
> to check initial_bytes == 0 is added after vCPUs are stopped.

I only roughly skimmed the series and overlooked the QEMU branch link.  I
read it, indeed it should do most of above, except one possible issue I
found, that QEMU shouldn't fail the migration when REINIT happened after
exact() but before vm_stop(); instead IIUC it should fallback to iterations
and try to move over the initial_bytes and retry a switchover.

Thanks,

> 
> Thanks,
> Yishai
> 
> > 
> > > > Is there a way the HW can report and confidentally say no further critical
> > > > data will be generated?
> > > 
> > > So long as there's a guest userspace running that can reconfigure the
> > > device, no.  But if you stop the vCPUs and test PRECOPY_INFO, it should
> > > be reliable.
> > 
> > This is definitely an important piece of info.  I recall Zhiyi used to tell
> > me there's no way to really stop a VFIO device from generating dirty data.
> > Happy to know it seems there seems to still be a way.  And now I suspect
> > what Zhiyi observed was exactly seeing dirty_bytes growing even after VM
> > stopped.  If that counter means "how much you can read" it all makes more
> > sense (even though it may suffer from the issue I mentioned above).
> > 
> > > 
> > > > > The presence of the VFIO_PRECOPY_INFO_REINIT flag indicates to the
> > > > > caller that new initial data is available in the migration stream.
> > > > > 
> > > > > If the firmware reports a new initial-data chunk, any previously dirty
> > > > > bytes in memory are treated as initial bytes, since the caller must read
> > > > > both sets before reaching the end of the initial-data region.
> > > > 
> > > > This is unfortunate.  I believe it's a limtation because of the current
> > > > single fd streaming protocol, so HW can only append things because it's
> > > > kind of a pipeline.
> > > > 
> > > > One thing to mention is, I recall VFIO migration suffers from a major
> > > > bottleneck on read() of the VFIO FD, it means this streaming whole design
> > > > is also causing other perf issues.
> > > > 
> > > > Have you or anyone thought about making it not a stream anymore?  Take
> > > > example of RAM blocks: it is pagesize accessible, with that we can do a lot
> > > > more, e.g. we don't need to streamline pages, we can send pages in whatever
> > > > order.  Meanwhile, we can send pages concurrently because they're not
> > > > streamlined too.
> > > > 
> > > > I wonder if VFIO FDs can provide something like that too, as a start it
> > > > doesn't need to be as fine granule, maybe at least instead of using one
> > > > stream it can provide two streams, one for initial_bytes (or, I really
> > > > think this should be called "critical data" or something similar, if it
> > > > represents that rather than "some initial states", not anymore), another
> > > > one for dirty.  Then at least when you attach new critical data you don't
> > > > need to flush dirty queue too.
> > > > 
> > > > If to extend it a bit more, then we can also make e.g. dirty queue to be
> > > > multiple FDs, so that userspace can read() in multiple threads, speeding up
> > > > the switchover phase.
> > > > 
> > > > I had a vague memory that there's sometimes kernel big locks to block it,
> > > > but from interfacing POV it sounds always better to avoid using one fd to
> > > > stream everything.
> > > 
> > > I'll leave it to others to brainstorm improvements, but I'll note that
> > > flushing dirty_bytes is a driver policy, another driver could consider
> > > unread dirty bytes as invalidated by new initial_bytes and reset
> > > counters.
> > > 
> > > It's not clear to me that there's generic algorithm to use for handling
> > > device state as addressable blocks rather than serialized into a data
> > > stream.  Multiple streams of different priorities seems feasible, but
> > > now we're talking about a v3 migration protocol.  Thanks,
> > 
> > Yep, definitely not a request to invent v3 yet, but just to brainstorm it.
> > It doesn't need to be all-things addressable, index-able (e.g. via >1
> > objects) would be also nice even through one fd, then it can also be
> > threadified somehow.
> > 
> > It seems the HW designer needs to understand how hypervisor works on
> > collecting these HW data, so it does look like a hard problem when it's all
> > across the stack from silicon layer..
> > 
> > I just had a feeling that v3 (or more) will come at some point when we want
> > to finally resolve the VFIO downtime problems..
> > 
> > Thanks,
> > 
> 

-- 
Peter Xu

