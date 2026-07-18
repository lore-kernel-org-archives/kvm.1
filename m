Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51BA23EAB8
	for <kvm@vger.kernel.org>; Sat, 18 Jul 2026 02:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784340818; cv=none; b=S6n0gVvPYM2XrpSwFlpUiENExldwSTZxyOwiLTUE1iIdcpSknfWJkrUzwW/6pGHp/4LiYTcs5L1iKynKFMJlkf0Pv7aCbYrZMwHlm2Vm7dm6w6Mp1F7mf+oGzNjgaM90MCk5zbu6CSfB2q21ZFyWQ5UI6MLX+S4Dz/9Q3thL1lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784340818; c=relaxed/simple;
	bh=E5GVXUuNMcy17MKpcJWROMYF4ZsRRG4eOxiIZ7PoK1A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nRyAGHM/69dLiGwfiReZBkoapKYSwAfQtKL6Jm+AHNE0kad9WuJVI1N4Zcut6PsEROZC99IH0UuMUN6VwgnZjsFSxL/n7kAFGI4E2n0kqAfY0NRaPFZ/n84oAWRsKPNVKxtul8myMIbjyV99+i7Xea2Lk0GPxyTjOJeFGpb/LTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWjsgyYJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWjsgyYJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2156C1F000E9;
	Sat, 18 Jul 2026 02:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784340817;
	bh=11Tcukj0TVcPWERgzJpa62MaUTmWpd53rvs0hhClXew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lWjsgyYJOLZUWgoj0e0ubyWMILimQoLeEatZN720Q36TdSQSWmsbn2ihBC/2CyU0X
	 GcBsP2EQkyABTK0cHHqrIp5q3iAXtTDWJB1xI8dKOKsWVJWzg3wBloceg6FJIO/2o/
	 2UX0BRAZqScLVjr+KtM4lAWRfumd7wVLIwctokioG9duqN7CDzwUn5hoQJY52tqcUM
	 nbEuydHoUtViiDd4l3E96I05PQVTCy5twvccR52T6e6owJtd9YgWoIAnaWPxDaeZsf
	 5VgqnPEzNWD2XLVFaG74nK2xC9q984Ehvs6MPgZWHcK5VEfIIxEZYNBWY4ll0Imccp
	 wJY86CYRAIlmQ==
From: sashiko-bot@kernel.org
Subject: Re: (no subject)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Weimin Xiong" <xiongwm2026@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260717021305.327441-1-xiongwm2026@163.com>
References: <CAJaqyWeNJwVNUihL8MAEH+-a5OsoaDGsgaPnP0BqQd6YH4ZhYg@mail.gmail.com>
 <20260717021305.327441-1-xiongwm2026@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 02:13:36 +0000
Message-Id: <20260718021337.2156C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Pages are unpinned before the hardware IOMMU is updated, creat=
ing a Use-After-Free race condition where the device can DMA into reallocat=
ed physical memory.
- [High] Hardware unmap failures are silently ignored, leaving stale active=
 mappings in the hardware while the OS considers the memory freed.
- [High] Pinned physical pages are permanently leaked when `vhost_vdpa_map`=
 or `pin_user_pages` fails after a successfully mapped discontinuity in `vh=
ost_vdpa_pa_map`.
--

--- Patch [1]: (no subject) ---
commit 9d5471c1144ba5ee59ae8bddf13fc8fca006ee54
Author: xiongweimin <xiongweimin@kylinos.cn>

vhost-vdpa: propagate set_map error to caller

The return value of ops->set_map() is currently ignored when handling
VHOST_IOTLB_BATCH_END. If the backend fails to program the IOTLB,
the VMM incorrectly believes the operation succeeded and may continue
with stale or incorrect mappings. Propagate the error from ops->set_map()
to the caller.

> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ac55275fa0d0a..89af89af26ca9 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1293,7 +1293,7 @@ static int vhost_vdpa_process_iotlb_msg(struct vhos=
t_dev *dev, u32 asid,
>  		break;
>  	case VHOST_IOTLB_BATCH_END:
>  		if (v->in_batch && ops->set_map)
> -			ops->set_map(vdpa, asid, iotlb);
> +			r =3D ops->set_map(vdpa, asid, iotlb);

[Severity: Critical]
This isn't a bug introduced by this patch, but does the unmap sequence
create a race condition where the device can DMA into reallocated memory?

Looking at vhost_vdpa_pa_unmap(), pages are unpinned before the mapping is
removed from the hardware IOMMU:

drivers/vhost/vdpa.c:vhost_vdpa_pa_unmap() {
    ...
            unpin_user_page(page);
        }
        atomic64_sub(PFN_DOWN(map->size), &dev->mm->pinned_vm);
        vhost_vdpa_general_unmap(v, map, asid);
}

For devices using set_map, the hardware is updated much later in
vhost_vdpa_unmap():

drivers/vhost/vdpa.c:vhost_vdpa_unmap() {
    ...
    vhost_vdpa_iotlb_unmap(v, iotlb, iova, iova + size - 1, asid);

    if (ops->set_map) {
        if (!v->in_batch)
            ops->set_map(vdpa, asid, iotlb);
    }
}

Could an unprivileged device execute asynchronous DMA into these newly freed
pages during the window between unpin_user_page() and the hardware update?

[Severity: High]
This is a pre-existing issue, but are we silently masking hardware unmap
failures elsewhere?

In vhost_vdpa_unmap(), the return value of ops->set_map() is discarded:

drivers/vhost/vdpa.c:vhost_vdpa_unmap() {
    ...
    if (ops->set_map) {
        if (!v->in_batch)
            ops->set_map(vdpa, asid, iotlb);
    }
}

Similarly, vhost_vdpa_general_unmap() ignores the return values of
ops->dma_unmap() and iommu_unmap():

drivers/vhost/vdpa.c:vhost_vdpa_general_unmap() {
    ...
    if (ops->dma_map) {
        ops->dma_unmap(vdpa, asid, map->start, map->size);
    } else if (ops->set_map =3D=3D NULL) {
        iommu_unmap(v->domain, map->start, map->size);
    }
}

If the hardware backend encounters an error and fails to remove the mapping,
could this leave stale active mappings in the hardware while the OS
considers the memory freed?

[Severity: High]
This is also a pre-existing issue, but does the map function leak pinned
physical pages if an error occurs?

In vhost_vdpa_pa_map(), when a chunk is mapped, nchunks is reset to 0:

drivers/vhost/vdpa.c:vhost_vdpa_pa_map() {
    ...
            map_pfn =3D this_pfn;
            iova +=3D csize;
            nchunks =3D 0;
        }
}

If a subsequent discontinuity causes a failure, the error cleanup path
skips unpinning the currently pending chunk because nchunks evaluates
to false:

drivers/vhost/vdpa.c:vhost_vdpa_pa_map() {
    ...
out:
    if (ret) {
        if (nchunks) {
            unsigned long pfn;

            WARN_ON(!last_pfn);
            for (pfn =3D map_pfn; pfn <=3D last_pfn; pfn++)
                unpin_user_page(pfn_to_page(pfn));
        }
    }
}

Will this permanently leak the pinned memory if a failure happens after a
successfully mapped discontinuity?

>  		v->in_batch =3D false;
>  		break;
>  	default:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717021305.3274=
41-1-xiongwm2026@163.com?part=3D1
