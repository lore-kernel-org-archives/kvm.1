Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CAD383991
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426472; cv=none; b=Smx4um1bl8Kh/3q9zXBB6aOn9IzXcbDkiJJZydGdUlOr0Krl/SnO+smDj7vMYRzRomh2BmIhQyOPWnfde9ZYanXMTvFExzOCA0a1ak9zuSbJG1MtlEZcgsdtlFouQXK65ZKmulgmD2TCKHMobdN2P+BJ96u1vdb8+J3Aaiui0as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426472; c=relaxed/simple;
	bh=FJHEpPAs0Mp3w0fAF9kOYo+s54kGqv5ubvECN7wuy1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgsfum/VjdpJ0zSgJKiWxyz37WkNbE00eB3m55GlF/Vlsd9EZMIXlgGjkzJ8XX4gIwCz4g3gO1c1P3185vSvVgoFzL7i79HPm6wfRRzvWCuUbzNV+uSXHuP1hUBJ8RX9rZlp8hDGJiNOfjrUK5Kb+SMdMjwx44Nf/wikANVoqZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qJONRJJf; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJONRJJf"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3bc34cso30405e9.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 02:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788426468; x=1789031268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gzPjC7D68idIVmlMUaOMP6Qao8mYdB0Lqfy2NnmqJjM=;
        b=qJONRJJfPalV7Oyd5UXNSkaxy3NU8ynG5KelLMANHU3xb4Wxyz6q6y+8DzZT7Xf3Rr
         F+A77pZAolpzcP8Hc8lRg3IasSv0rGn21XHx89p9GQQTOjiO4zSi5VjWXEHpZdQD+hej
         vW7WEBwduRsJ3iCccH+jcc4rZ3xQ6dd2oOcTWFFdg8rxfngSXgWxl4OVJrxd3DxEdLu2
         gCehW6s3UaeX+RnOc+NTt2rLfaieh6vOGYNTuyaxfL39xNcQSMQWZx+iIV8UfOEeBcEi
         sbX80e7/B3D+crBQFVDZ++ZptGjEF67dbDnHekN6Oci6d851/fFEL1bDZ7TAlCJlJsXn
         iy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788426468; x=1789031268;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gzPjC7D68idIVmlMUaOMP6Qao8mYdB0Lqfy2NnmqJjM=;
        b=kspV3iOWbv21fH2Y6QrGg1TrYbpxIHd+4VF8IGt7LSy/oW52VJueAdkIK9krBv3YpJ
         1whiIehlmyWbQhHjrehYqITfcZ/+CxAeelrvVHGKEEVFb3/trjEUtYOzQ+potZgr3X6n
         +dmO4arCnP9NCoa1H/cDtqWm4RHi0hVO4rd2hvPgIZUW1134X77O77Qvcv43ztkw9oWI
         hLF/TRYuPaoUMaLnD/b4eoqPFz5yAGYzaCpzwAarqz3sJjol81Fl7MINSSjaMaJZsyBs
         RJkoXfiZPmeQObpzB8AWuai9RZ9aHhEmPeXmXDQpZ5xhKPz3ZUW38GFhmGExO1p/8BjA
         bcJA==
X-Gm-Message-State: AFuF++nlcFmLF76SP6SAbFsiPlaXbrIvNcTWObBv827zWG2d8K/AKVR9
	XKxCQ8OZxvwL5ZKsbjH6MkSHB1+ApBaiXkg3lBdI9fzW2C6DYg1uFt8Tixkpb1mi9g==
X-Gm-Gg: AYBFou176IWZBRpJcY477ncuu86EL5EYxCjXemFz3otdfstSHlde24h5lvj8ovZbYCX
	NQdI7jYH6HOdJVkRl/wLRd1zXHTG4qTiYGC8BogCr8m+9rRI0Nq0fz5pJ12SkNw2GKnIEjbMnEq
	ER+NVbxpQNZ0NNKH7c0gmT4Zxc+2F5nZop52o0jJxpShRkkVY33Tztth0V8qexg/FMaNl8VByMb
	Ji1SLL3SZ9xXXWTejWksiycQIrwRBIpNPzPgmYBb/QLbEecLWM0VjoMQL/JwC+xp45JkMO+6UHV
	zSlsswVYWtnq40qwO9UWooFMWip5G/IlCaCs1GiymZ9FlAQbapIphtmKu3xtKPwdbLqWfT3bL4Z
	FVl47qOrOZ6ZenW4xj7eq7XqEhpL93PEYefPIapGjTKTEbU8+KqnKNE0hWkMP/baZ5gPZCGcvMp
	9ZPDkIuKZqeNk8lkl704PSbl862ltRYvjV+kPekCNCVN79JZNef/3TP0dhRF1S30AgA3gB29xOf
	4iXV++LmoebcaXBbKCUs/DgcPIx+w==
X-Received: by 2002:a05:600c:26c5:b0:49c:cee4:dbc7 with SMTP id 5b1f17b1804b1-49cf0806508mr335085e9.15.1788426468158;
        Thu, 03 Sep 2026 02:07:48 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60d9c6sm56979455e9.11.2026.09.03.02.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 02:07:47 -0700 (PDT)
Date: Thu, 3 Sep 2026 09:07:43 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Eric Auger <eric.auger@redhat.com>,
	Pranjal Shrivastava <praan@google.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH v2] vfio/platform: prevent read-only region mappings from
 becoming writable
Message-ID: <apk43xFwqAAwdd3s@google.com>
References: <20260903071955.13144-1-suruurism@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903071955.13144-1-suruurism@gmail.com>

On Thu, Sep 03, 2026 at 10:19:55AM +0300, Abdifatah Suruur wrote:
> vfio_platform_mmap() rejects writable mappings of regions without the
> WRITE flag, but leaves VM_MAYWRITE set.  Userspace can map such a region
> read-only and then upgrade the mapping to writable with mprotect().
> 
> Clear VM_MAYWRITE for regions without the WRITE flag, as i915 does for
> its read-only objects and as fixed in drm/vc4 (CVE-2026-68445),
> drm/panthor (CVE-2024-53071) and ptp: vmclock (commit
> a5edadbae57e2298a56cf7a4e774a027905a331f).

nit: checkpatch(--strict) fails with:
Please use git commit description style 'commit <12+ chars of sha1>
("<title line>")' - ie:
'commit a5edadbae57e ("ptp: vmclock: prevent read-only mappings from becoming writable")'

> 
> Note this is defensive hardening: no in-tree platform driver currently
> publishes a region without the WRITE flag.  The guard costs nothing and
> keeps the mmap() interface honest if a read-only region ever appears.
> 
> Fixes: de49fc0d99e6a ("vfio/platform: initial skeleton of VFIO support for platform devices")

This only adds a stub for vfio_platform_mmap(), The right one is
Fixes: fad4d5b1f042 ("vfio/platform: support MMAP of MMIO regions")

> Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
> v2: commit log now states plainly that the read-only path is
> unreachable in practice, per Alex's review; dropped Cc: stable as
> there is no reachable issue to backport.
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
>  	vma->vm_private_data = vdev;
> 
>  	if (vdev->regions[index].type & VFIO_PLATFORM_REGION_TYPE_MMIO)
>  		return vfio_platform_mmap_mmio(vdev->regions[index], vma);
