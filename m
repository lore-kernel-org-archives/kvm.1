Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C1E4B2CC5
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531444; cv=none; b=WHyhNqqV/gFqj80DbBGwzvtE5eoGf0svjlV60iThRJU6rs9dJvDL3D4wQBLZjlXQOyR5OhAynEs+gbP63CJdvYtHkwYnxtekvwU1vha7daZfOSDXokqvs0ghQJDVgZoq2dXMSKqd9dcYeR4SI7vS/6hjQKPp003XzVD4aKmuGn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531444; c=relaxed/simple;
	bh=D2t6B1YS33bYDK84WqJqNPxeuOe8w02R1XfEYryLAhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSAFX+rZz/fSuuCnav4pTOdcxah5AGVq+e53kLeHVCOFq/ylixwzfUGntpUa7CLaboNuUsQw0GY/N4zLmS+8LLeyHxqueT3snp/TOw6L8m3dObKMuoQCMliYnSKsqI8ufYKkLmk42lL+EvNIkXj9Iocd3zhweb1zsJ5VpEaMR2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nCp4SGOd; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nCp4SGOd"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff3aca06so92595ad.0
        for <kvm@vger.kernel.org>; Fri, 04 Sep 2026 07:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788531442; x=1789136242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=60ByTjtXefcxnqfTN2YbLnHfehKM3hxAEVNuYOtMxjU=;
        b=nCp4SGOdAF06D8bgFngQo4t9xp/tHR6rqhAMBRBLD6FHjeGVOzpxO3+W+ClZn3WDiw
         VLTuHeSNay9kIU8gzvgSl5EUhP7yfelgSFQzr9gfUKcuXh3oP5NndoSkMc6oDGE3X0ID
         XmdMMXvO8UwqMxxsv/7Kmb8QvBNhbIt7qb0PuieLhshJFoUZPnNHI9SIZ9a9OnffRWVq
         1bgla9vCkLBNDz8e1GhHOJs0UckaDp8WWlf/x2/DsCBxor+7U+H6+MtGhvBDcMENcYls
         guca1xRJaH65h1ZdlfunC7cjaZBqBttWWbI1i9RR/J1Z86G+BbcGZZPjOZape7IfNpjT
         QwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788531442; x=1789136242;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=60ByTjtXefcxnqfTN2YbLnHfehKM3hxAEVNuYOtMxjU=;
        b=GjKgMNKKIUoO8dPEzY8O+hWGv5yo1VJfGPoh5FfQq3yxHK4H+aGAuVbLyDUocx3Www
         MpJqGf2gf/etYy7Rn73Q4JhXH/Souh+5/U29isdOMrgDgCWaSARTodHAUFfOu9B8FkE3
         aNsT7mX1rqYtaVclP+bCK4mHqahMAoW6alHBjFyY4kCzgM+IpCWCqZU/2d2gx0JDKD3K
         DE8JhYkY6Pwg9Z1YTIJB3QczGt3IanE8oo4Z4TPvH3j3rgJ84IdDpdL8sZB12Z5suyJE
         pCRa5m5D832boNPqiD2BscXDxfSXusCbcsT6qxm/jCfkKGE4HOOQCHLskgjjhx9NfILX
         Ey8Q==
X-Gm-Message-State: AFuF++nVLlodY+wXqRIT38YhU1+4Bk27uGYIkUenwdGfQB7dDQLPEdMC
	ggqn9qijRp4aC0vbD2o56J8YfVnerQ1Ey+nijQ/FTTrpkEmyDjlWtLfKmIXKQOu4lQ==
X-Gm-Gg: AYBFou0DNMUsBcO8Q6OfTI5lqkweLR2nIYB5/ijXh3J3bB47MDBNUWsWFlJaXNNocMZ
	B377XHXP3lLMxe30G7aB45lf/wC7Q+sWKgud6V/fU3TBmH+yOvHhUTxIHggvtjUMHnyCyvOwXDL
	aM/pjDI6zavqJsHop/LzLw/YUF/YWGMg2Pr6iESo1rcR8kPP0NDHinMNHZZrJgf0wfP9LqZBSaF
	A2JKzvESKV+getxoXAMR4r90MjkdqZpg2NbPbfHFYpc6+JQC781yfS6IqDThQZnbLdesbnRtsGZ
	mYC94PWIzfKvUfDrDSO8sZWfIqnU0rm5pPGcP2a+kcoqNvmdFCAXEMQhgQ9B1X/IbpmVE5uIlpJ
	RD6ail0H1+mp52FtkOq2/Lnek1nJUHWUvtasVbnqbtA78jqyLVixoKwuLAje7nrA1x5Z27pqOb1
	8m5TEuIgAXp+Xvf6ZDDO7Ww4icHhpbWIqTuoKUtroleg8SGYkWicELkf8B/MfQjgN/+pgs4HlBx
	IrkJ9abpUJ/j8QFr0pTlRbld7I+n+G2XzT+
X-Received: by 2002:a17:903:3c2b:b0:2db:2225:d2fd with SMTP id d9443c01a7336-2db2225d395mr1063405ad.16.1788531441093;
        Fri, 04 Sep 2026 07:17:21 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b25f8d2c5sm5029514a91.2.2026.09.04.07.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 07:17:20 -0700 (PDT)
Date: Fri, 4 Sep 2026 14:17:15 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Eric Auger <eric.auger@redhat.com>,
	Mostafa Saleh <smostafa@google.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH v3] vfio/platform: prevent read-only region mappings from
 becoming writable
Message-ID: <aprS65nZ3vi6TPxY@google.com>
References: <20260903092907.419-1-suruurism@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903092907.419-1-suruurism@gmail.com>

On Thu, Sep 03, 2026 at 12:29:07PM +0300, Abdifatah Suruur wrote:
> vfio_platform_mmap() rejects writable mappings of regions without the
> WRITE flag, but leaves VM_MAYWRITE set.  Userspace can map such a region
> read-only and then upgrade the mapping to writable with mprotect().
> 
> Clear VM_MAYWRITE for regions without the WRITE flag, as i915 does for
> its read-only objects and as fixed in drm/vc4 (CVE-2026-68445),
> drm/panthor (CVE-2024-53071) and commit a5edadbae57e ("ptp: vmclock:
> prevent read-only mappings from becoming writable").
> 
> Note this is defensive hardening: no in-tree platform driver currently
> publishes a region without the WRITE flag.  The guard costs nothing and
> keeps the mmap() interface honest if a read-only region ever appears.
> 
> Fixes: fad4d5b1f042 ("vfio/platform: support MMAP of MMIO regions")
> Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> ---
> v2: commit log now states plainly that the read-only path is
> unreachable in practice, per Alex's review; dropped Cc: stable as
> there is no reachable issue to backport.
> v3: use 'commit <sha> ("<title>")' style for the vmclock reference
> and point Fixes at the MMAP support commit, per Mostafa's review.
> 
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -594,7 +594,11 @@
>  	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE)
>  			&& (vma->vm_flags & VM_WRITE))
>  		return -EINVAL;
> 
> +	/* Prevent read-only region mappings from being upgraded with mprotect() */
> +	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE))
> +		vm_flags_clear(vma, VM_MAYWRITE);
> +

Minor Nit: We seem to be evaluating this condition twice, back-to-back:

if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE))

We could consolidate this into a single block to make the intent and
flow cleaner:

        /* Prevent read-only region mappings from [...] */
        if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE)) {
            if (vma->vm_flags & VM_WRITE)
                return -EINVAL;
            vm_flags_clear(vma, VM_MAYWRITE);
        }

Apart from that,

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
