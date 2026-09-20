Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDBC3D646B;
	Sun, 20 Sep 2026 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789928610; cv=none; b=CXoxfAIdK4nmgy9dCsAvTIN7GQZ909vMF9opeGSTJmRk54P5iLgs0i51RW+JjokQ31ZSiQ+9RT4Vy6gvQ4VY78AZJRm8SYAdTCWNb+VumAfQD0fooVEYwLlbfyJtZJB1HDBKmkkCn4vEY2LfOrzwb1aVtajG7UeHcfLGAXELAHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789928610; c=relaxed/simple;
	bh=0mXQ+TZ5l+g9AWKeeUjd10QVgLNrE3l6VCtckKnCyIM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awjUHgNhIjqZi/1mAbMJRUtDc7WowOTEgvlE/XwRC9midgP7aVbHuG9cuRpfN9H8VYo3pAYnRnpowh8yNAgToU+xh7kPe1hHyFC/8kbBoXqJhBjE3kG5Fxs0eOvVE9KFXP7iuX79FNwnjEb5PH+E3Rp3wYfIsysPIu6HpVNills=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=QpqkAgeQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LMrGvxjL; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="QpqkAgeQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LMrGvxjL"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 109A97A0075;
	Sun, 20 Sep 2026 14:23:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sun, 20 Sep 2026 14:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789928605;
	 x=1790015005; bh=uVP3B4eZAr0us09kFMKVJy1GOQ6xqt+/9a3b9urSYuM=; b=
	QpqkAgeQUBXSyf5WZVit1tqGctoGW2MGKCM0FLUA31vp9NaTfWGuiiaczMq8mqKA
	KCjKkLJxcLzfb1pCT54Zxif9Xaw8xhLr3Mqp/PN8ADJqJenbIgAJ/ce0niaRZST2
	+1l4q+YIJ/2Rwy/So/DmyZQIN+elPfCcAKRWsXrKsYSzovN1J7tGW+Qjt5ovHGkp
	9o2NnyLfNKIzy+BFXBNHaZVlexZhTU6keP/sXchLPe2971wNiUScgOUSZMjk0TfC
	ozuadTS3XWlGKuFNOGqVEEyZ1vMKnWBHUpBTuB/VhwjXMSuBKS+i06WzD3W1r+tO
	C3IraFLMOIYO8JR5MOOfuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789928605; x=
	1790015005; bh=uVP3B4eZAr0us09kFMKVJy1GOQ6xqt+/9a3b9urSYuM=; b=L
	MrGvxjLU6gBNSF2TOGqXM5aqkzsnhpRq8uZ8eYJHUoD2B92/I9YqAj8F1sASEPEs
	uWdMB6I1tqLnLVfOIwcTrZi6h9FemZbm+hlehU7essbVTUcZNppJi3/YsGbNZOzw
	mZUWYjnkVnR8zHr/xCZfvbyWfMt18Klvk8/ruKURedwTSAI13MD8g448HdgGlidm
	AoPhX7iBc7OfSj8CXTvXVQVkMSfrA8/ykhKw7fonIx61ZsoiZT7oih7M960ZxzuB
	8/fL1qnEu1R7WEu0AC6kDPFW07ZZIGoTZdrbcFJss/6vve+BXqnJT25vXfIItg1Y
	1bY1RFZrR7WNWhnQaGRAg==
X-ME-Sender: <xms:nSSwajtGW-PGgETRsqX-5UniMYnB6wkS99AYkrFFn5K-LxsPRR5jJQ>
    <xme:nSSwal8T-zzAtbBAgb-2S8JlxYvmwylg7T-5gPrzVdgHp36MzXbvc9g_Ib51-Ngi2
    _NP3HjL_Wl-V-JALSA7Fv-70fTbEB8sONknvTEt1bxIMtaaESz2ISY>
X-ME-Received: <xmr:nSSwam1W-PxOMOXfuP2dsjY2kkLFm4oQ4pGRnG9EjEs3IZRFOSjo206FtB61cg>
X-ME-Proxy-Cause: dmFkZTGNjVRgdGQTs2MLb/8kbQ4oIZ4XTCcTclWhy4q5DjHEy1U2KO3uRJu8ZWS8HmxfFq
    VHvc1ljmEeypkOWytLnZavHgCH9VjIjjtjWrNz/yj5f9osSLctLV9I8d9hob6PEvxpAkga
    6zg/sOLBFyoP4DKthjnmJhpEwTX3BSGwlJJde416CA8jwhjoXR5Zh6mjEysfrNfzfTJsi2
    4IICYu8WSGyWMdL8ATq7CaI8pm2fgDUaCQAkFqdostPfObfRTC5BUt15f9ZIu9cKYs+3Nc
    7B2qIGSIgTohSANRUsM0Hw0rczdPdXU5OmcYud/QgJqIgKsGyciHLG7kDDGr2cEEHRiAPQ
    9uVWidxl4SbWfuHp0/4ItRLCCHpjjl1NGWi0Okbm0SmkGD6zZzAhHZqImeclHDulngczeV
    o25/KGDoGtmvalTAuRivnJVmEt5aUsjyhJutuuzcjYRu8VrWne5s39myj3NYEr7FM8rtA5
    SZ9AfW6+B3wNXEYGiDIDkV4d7nSuf3cULwAKdGHHpZr8NPNFZG5l44pwXnSj9d2B/w15m3
    EDkb53LiSCCY0mGR4HFdIYmdGOBhhJIML+H8WWj7aPvWsNXKsfHA/NCnBPUgcP5c5ni3fZ
    wz2XAuYdPsDfVqhGb3x7l67Y2KsH800zT/pf5hG58EKuvdh3qPEwJf4JjLXQ
X-ME-Proxy: <xmx:nSSwaiAU2wkqt52sUCyPauUCXcOOiboZszLdJhIqbSG7CrBnFcCV-w>
    <xmx:nSSwaqeZFaqRwPIJALphjuIQbnoo5v9Pe-QM0YcgdlMD9TgkO2fV_g>
    <xmx:nSSwan63o0IiuTU8yfFakaigUYCfY8kdYv5X8A3N8O2G2NoKCbcvjg>
    <xmx:nSSwalWveyu2uYbCjLdrIfa4x1mWPS2pji3gIVNrqzFFR1H5DM0Igg>
    <xmx:nSSwagndsLfi4Q9AI0iAuE1BS4au0fo1gHFwyiG2poay43RQ3hgokuzB>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Sep 2026 14:23:24 -0400 (EDT)
Date: Sun, 20 Sep 2026 12:23:22 -0600
From: Alex Williamson <alex@shazbot.org>
To: Pavol Sakac <sakacpav@amazon.de>
Cc: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nh-open-source@amazon.com>, alex@shazbot.org
Subject: Re: [PATCH] vfio: Create the group chardev outside vfio.group_lock
Message-ID: <20260920122322.6ad9a01e@shazbot.org>
In-Reply-To: <20260911-vfopt-s4-v1-0-98ba1d2ef7ab@amazon.de>
References: <20260911-vfopt-s4-v1-0-98ba1d2ef7ab@amazon.de>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 18:25:13 +0200
Pavol Sakac <sakacpav@amazon.de> wrote:

> VFIO holds the global group_lock while allocating, naming, and
> registering each group chardev. cdev_device_add() includes device_add()
> and the KOBJ_ADD uevent, so unrelated group creation is serialized.
> 
> Allocate and name a candidate without the lock, reserve its IOMMU-group
> identity on group_list, then build the chardev unlocked. A contender
> waits for an unpublished reservation and then retries the lookup.
> Keep removal locked through cdev_device_del() so a lookup miss also
> guarantees that the chardev name is free.
> 
> Suppress the ADD event until publication so a failed construction emits
> no uevents.
> 
> The ADD uevent also carries per-event cost (env allocation,
> kobject_get_path()) and a netlink broadcast that serializes globally under
> uevent_sock_mutex; sending it off the lock keeps that global section from
> extending vfio.group_lock hold times.
> 
> Under parallel device probing this lock is a top contention source; with
> the chardev built outside it, it disappears from the enable window's
> contention profile entirely.
> 
> Assisted-by: LLM
> Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
> ---
> vfio.group_lock is held across cdev_device_add() -- device_add() plus
> the KOBJ_ADD uevent -- so one group's chardev creation serializes every
> unrelated one under the concurrent bring-up of "PCI/IOV: Initialize
> virtual functions in parallel" [1]. The patch reserves the group
> identity on group_list first, then builds the chardev outside the lock:
> three short uncontended holds replace one long contended one.
> 
> Lock statistics and SR-IOV init time for 4x PF (NVMe, 255 VFs each), on
> the reproducer from the parallel VF initialization cover letter [1]:
> 
>   lock_stat:
>   Lock                     wait: Before     After   contentions: Before   After
>   iommu_probe_device_lock       9154 ms  12367 ms                   783     990
>   &vfio.group_lock              3823 ms      0 ms                   730       0
>   &root->kernfs_rwsem           1285 ms   2189 ms                 55459   62799
>   gdp_mutex                        6 ms    314 ms                    23     191
> 
>   vfio.group_lock acquisitions / avg hold  1020 / 378 us -> 3060 / 11 us
> 
>   Removing vfio.group_lock contention lets the released concurrency
>   re-queue on iommu, kernfs and gdp_mutex, none of which this patch
>   touches; the staged sysfs series [2] absorbs most of the kernfs rise.
> 
>   Stage                 SR-IOV init time:
>   S0 (baseline)         3027 ms
>   S1                     999 ms
>   S2                     995 ms
>   S3                     991 ms
>   S4 (this patch)        943 ms
> 
> Reproducer disclaimer:
> I lean primarily on lock_stat numbers to defend the improvements. In
> the reproducer, the residual iommu_probe_device_lock dominates the
> window and masks the later series' wall-time gains; reducing that lock
> further is out of scope for this set. On real hardware the five series
> together cut SR-IOV initialization by 65% [1].
> 
> The lock_stat and timing figures come from the public reproducer. The
> full series has also been tested on current datacenter server hardware
> with thousands of VFs.

I'm having a hard time justifying what this actually does.  We're
optimizing for lock contentions, but we're just redistributing the time
elsewhere and disregarding the actual lock bouncing.  For example the
error path acquires and releases the global group_lock for list removal,
the discard path acquires and releases the group->group_lock even when a
group hasn't been published, and there's another global acquire and
release to set published.  It's not necessarily incorrect, but it
doesn't appear as the right balance of incremental or logical
improvement to base this so heavily on lock_stat alone.

It also seems like there's a bit of code refactoring without locking
changes that could precede this.  Thanks,

Alex

 
> [1] https://lore.kernel.org/r/20260911-vfopt-s1-v1-0-693271dc0226@amazon.de
> [2] https://lore.kernel.org/r/20260911-vfopt-s5-v1-0-fa4cacdb6ca8@amazon.de
> 
>  drivers/vfio/group.c | 192 ++++++++++++++++++++++++++++++-------------
>  drivers/vfio/vfio.h  |   9 ++
>  2 files changed, 146 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index b2299e5bc6df..692381151303 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -537,52 +537,157 @@ static struct vfio_group *vfio_group_alloc(struct iommu_group *iommu_group,
>  	group->cdev.owner = THIS_MODULE;
>  
>  	refcount_set(&group->drivers, 1);
> +	init_completion(&group->publish_done);
>  	mutex_init(&group->group_lock);
>  	spin_lock_init(&group->kvm_ref_lock);
>  	INIT_LIST_HEAD(&group->device_list);
>  	mutex_init(&group->device_lock);
>  	group->iommu_group = iommu_group;
> -	/* put in vfio_group_release() */
> +	/* put in vfio_device_remove_group() or vfio_group_discard() */
>  	iommu_group_ref_get(iommu_group);
>  	group->type = type;
>  
>  	return group;
>  }
>  
> -static struct vfio_group *vfio_create_group(struct iommu_group *iommu_group,
> -		enum vfio_group_type type)
> +/*
> + * Undo vfio_group_alloc() for a never-published group: the teardown tail
> + * of vfio_device_remove_group(), except that unlinking the group from
> + * vfio.group_list is the caller's job, under vfio.group_lock.
> + */
> +static void vfio_group_discard(struct vfio_group *group)
> +{
> +	struct iommu_group *iommu_group;
> +
> +	/*
> +	 * An unpublished group holds only vfio_group_alloc()'s reference.
> +	 * On a count mismatch, leak rather than free under the other holder.
> +	 */
> +	if (WARN_ON(refcount_read(&group->drivers) != 1))
> +		return;
> +	/* No discard site leaves the group findable, so nothing can inc it. */
> +	refcount_set(&group->drivers, 0);
> +
> +	mutex_lock(&group->group_lock);
> +	WARN_ON(!list_empty(&group->device_list));
> +	if (group->container)
> +		vfio_group_detach_container(group);
> +	iommu_group = group->iommu_group;
> +	group->iommu_group = NULL;
> +	mutex_unlock(&group->group_lock);
> +
> +	iommu_group_put(iommu_group);
> +	put_device(&group->dev);
> +}
> +
> +static bool vfio_group_has_device(struct vfio_group *group, struct device *dev)
> +{
> +	struct vfio_device *device;
> +
> +	mutex_lock(&group->device_lock);
> +	list_for_each_entry(device, &group->device_list, group_next) {
> +		if (device->dev == dev) {
> +			mutex_unlock(&group->device_lock);
> +			return true;
> +		}
> +	}
> +	mutex_unlock(&group->device_lock);
> +	return false;
> +}
> +
> +/*
> + * vfio.group_lock is held only to claim the identity: a reserved group is
> + * linked on vfio.group_list before the lock drops, so a lookup miss proves
> + * the chardev name is free and a hit on an unpublished group waits for its
> + * builder.  Allocation, naming, and cdev_device_add() all run unlocked.
> + */
> +static struct vfio_group *
> +vfio_group_find_or_create(struct device *dev, struct iommu_group *iommu_group,
> +			  enum vfio_group_type type)
>  {
>  	struct vfio_group *group;
> -	struct vfio_group *ret;
> +	struct vfio_group *new;
>  	int err;
>  
> -	lockdep_assert_held(&vfio.group_lock);
> -
> -	group = vfio_group_alloc(iommu_group, type);
> -	if (IS_ERR(group))
> +retry:
> +	mutex_lock(&vfio.group_lock);
> +	group = vfio_group_find_from_iommu(iommu_group);
> +	if (group) {
> +		if (!group->published) {
> +			/*
> +			 * Wait unlocked and look up again -- the builder
> +			 * can still fail and unlink the group.  The device
> +			 * reference keeps the completion alive.
> +			 */
> +			get_device(&group->dev);
> +			mutex_unlock(&vfio.group_lock);
> +			while (!wait_for_completion_timeout(&group->publish_done,
> +							    10 * HZ))
> +				dev_warn(dev, "waiting for vfio group %s registration\n",
> +					 dev_name(&group->dev));
> +			put_device(&group->dev);
> +			goto retry;
> +		}
> +		if (WARN_ON(vfio_group_has_device(group, dev)))
> +			group = ERR_PTR(-EINVAL);
> +		else
> +			refcount_inc(&group->drivers);
> +		mutex_unlock(&vfio.group_lock);
>  		return group;
> +	}
> +
> +	mutex_unlock(&vfio.group_lock);
>  
> -	err = dev_set_name(&group->dev, "%s%d",
> -			   group->type == VFIO_NO_IOMMU ? "noiommu-" : "",
> +	new = vfio_group_alloc(iommu_group, type);
> +	if (IS_ERR(new))
> +		return new;
> +	err = dev_set_name(&new->dev, "%s%d",
> +			   new->type == VFIO_NO_IOMMU ? "noiommu-" : "",
>  			   iommu_group_id(iommu_group));
>  	if (err) {
> -		ret = ERR_PTR(err);
> -		goto err_put;
> +		vfio_group_discard(new);
> +		return ERR_PTR(err);
>  	}
>  
> -	err = cdev_device_add(&group->cdev, &group->dev);
> -	if (err) {
> -		ret = ERR_PTR(err);
> -		goto err_put;
> +	mutex_lock(&vfio.group_lock);
> +	if (vfio_group_find_from_iommu(iommu_group)) {
> +		/* Lost the race; drop ours and take theirs. */
> +		mutex_unlock(&vfio.group_lock);
> +		vfio_group_discard(new);
> +		goto retry;
>  	}
> +	list_add(&new->vfio_next, &vfio.group_list);
> +	mutex_unlock(&vfio.group_lock);
>  
> -	list_add(&group->vfio_next, &vfio.group_list);
> +	/*
> +	 * Hold back device_add()'s KOBJ_ADD until publication; on failure,
> +	 * suppression also keeps the device_add() unwind from emitting an
> +	 * unmatched KOBJ_REMOVE.
> +	 */
> +	dev_set_uevent_suppress(&new->dev, true);
> +	err = cdev_device_add(&new->cdev, &new->dev);
> +	if (err) {
> +		mutex_lock(&vfio.group_lock);
> +		list_del(&new->vfio_next);
> +		mutex_unlock(&vfio.group_lock);
> +		complete_all(&new->publish_done);
> +		vfio_group_discard(new);
> +		return ERR_PTR(err);
> +	}
>  
> -	return group;
> +	mutex_lock(&vfio.group_lock);
> +	new->published = true;
> +	mutex_unlock(&vfio.group_lock);
> +	complete_all(&new->publish_done);
>  
> -err_put:
> -	put_device(&group->dev);
> -	return ret;
> +	/*
> +	 * Send the deferred ADD unlocked.  The caller still owns the
> +	 * drivers reference, so vfio_device_remove_group() cannot reach
> +	 * cdev_device_del() before the ADD is sent.
> +	 */
> +	dev_set_uevent_suppress(&new->dev, false);
> +	kobject_uevent(&new->dev.kobj, KOBJ_ADD);
> +	return new;
>  }
>  
>  static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
> @@ -603,9 +708,11 @@ static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
>  	if (ret)
>  		goto out_put_group;
>  
> -	mutex_lock(&vfio.group_lock);
> -	group = vfio_create_group(iommu_group, type);
> -	mutex_unlock(&vfio.group_lock);
> +	/*
> +	 * The iommu_group is fresh and private, so the lookup and builder
> +	 * wait are unreachable; the shared helper is used for uniformity.
> +	 */
> +	group = vfio_group_find_or_create(dev, iommu_group, type);
>  	if (IS_ERR(group)) {
>  		ret = PTR_ERR(group);
>  		goto out_remove_device;
> @@ -620,21 +727,6 @@ static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
>  	return ERR_PTR(ret);
>  }
>  
> -static bool vfio_group_has_device(struct vfio_group *group, struct device *dev)
> -{
> -	struct vfio_device *device;
> -
> -	mutex_lock(&group->device_lock);
> -	list_for_each_entry(device, &group->device_list, group_next) {
> -		if (device->dev == dev) {
> -			mutex_unlock(&group->device_lock);
> -			return true;
> -		}
> -	}
> -	mutex_unlock(&group->device_lock);
> -	return false;
> -}
> -
>  static struct vfio_group *vfio_group_find_or_alloc(struct device *dev)
>  {
>  	struct iommu_group *iommu_group;
> @@ -659,17 +751,7 @@ static struct vfio_group *vfio_group_find_or_alloc(struct device *dev)
>  	if (!iommu_group)
>  		return ERR_PTR(-EINVAL);
>  
> -	mutex_lock(&vfio.group_lock);
> -	group = vfio_group_find_from_iommu(iommu_group);
> -	if (group) {
> -		if (WARN_ON(vfio_group_has_device(group, dev)))
> -			group = ERR_PTR(-EINVAL);
> -		else
> -			refcount_inc(&group->drivers);
> -	} else {
> -		group = vfio_create_group(iommu_group, VFIO_IOMMU);
> -	}
> -	mutex_unlock(&vfio.group_lock);
> +	group = vfio_group_find_or_create(dev, iommu_group, VFIO_IOMMU);
>  
>  	/* The vfio_group holds a reference to the iommu_group */
>  	iommu_group_put(iommu_group);
> @@ -702,16 +784,16 @@ void vfio_device_remove_group(struct vfio_device *device)
>  	if (group->type == VFIO_NO_IOMMU || group->type == VFIO_EMULATED_IOMMU)
>  		iommu_group_remove_device(device->dev);
>  
> -	/* Pairs with vfio_create_group() / vfio_group_get_from_iommu() */
> +	/* Pairs with vfio_group_alloc() / vfio_group_find_or_create() */
>  	if (!refcount_dec_and_mutex_lock(&group->drivers, &vfio.group_lock))
>  		return;
>  	list_del(&group->vfio_next);
>  
>  	/*
> -	 * We could concurrently probe another driver in the group that might
> -	 * race vfio_device_remove_group() with vfio_get_group(), so we have to
> -	 * ensure that the sysfs is all cleaned up under lock otherwise the
> -	 * cdev_device_add() will fail due to the name aready existing.
> +	 * We could concurrently probe another driver in the group racing this
> +	 * removal with vfio_group_find_or_create().  The sysfs name is all
> +	 * cleaned up under the lock, so once a creator's lookup misses, the
> +	 * name is guaranteed free.
>  	 */
>  	cdev_device_del(&group->cdev, &group->dev);
>  
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 7728bc99b63d..cfc76e5752dd 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -9,6 +9,7 @@
>  #include <linux/file.h>
>  #include <linux/device.h>
>  #include <linux/cdev.h>
> +#include <linux/completion.h>
>  #include <linux/module.h>
>  #include <linux/vfio.h>
>  
> @@ -83,6 +84,14 @@ struct vfio_group {
>  	struct list_head		device_list;
>  	struct mutex			device_lock;
>  	struct list_head		vfio_next;
> +	/*
> +	 * Reserved on vfio.group_list while the chardev is built; published
> +	 * is set when the build succeeds (failure unlinks the group) and is
> +	 * accessed only under vfio.group_lock.  publish_done releases
> +	 * callers that found the group mid-build.
> +	 */
> +	bool				published;
> +	struct completion		publish_done;
>  #if IS_ENABLED(CONFIG_VFIO_CONTAINER)
>  	struct list_head		container_next;
>  #endif
> 
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935

