Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064272F12AC
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782424589; cv=none; b=EXhyZ4EkxelXNaSXCgeeBbiUkCvwGCusUwDql1nZvvvXI3nAu+V8GdIeVhbpUUMz0zeA7uwnpGADDQb7WJUv4A2DrfGyO/m9z2+Tov/ccvtKF6YVsDNcez3Z+QIA/tEkDCdh4IdyME1iA4yZX04pk6NZ5TBomizVhOlXXxwSNMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782424589; c=relaxed/simple;
	bh=YbzQ6M30Y8kpdu0iYSN4yCN2bhJh/8dQMdnjgheZJqo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nHFaj350pobyNaWNDWJvnjOGH0g+2LrqsoOfyWnY4pNkpsX807aYGlkeJNIHIrmz9r4d4xumobF94mUU4+/8u0mMSNM+1zclcCEyZG5s+TZfqyWxNpqsxcyj5CEFDYH3s8LXnhjq+fAPfC5QC3l/d9RAcjPtWcyYcMjRpgFnP2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lr8ACllB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lr8ACllB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CB81F000E9;
	Thu, 25 Jun 2026 21:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782424587;
	bh=27hyDyh4axNPkyvBsnLLFhz/8OoZARwL5+HULaiFe08=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lr8ACllBGn2/kJ4PFHNT3Xpj4TAKKX6kZ0dUlHdc/0WUp/g9A67pFDkQK3bVfleSj
	 Kv2FwMZEQFu62NyUUyoI2Z2l1UOBylJXbWbLfDDWGVMTjhIa+fzmYK/lyp7CYZ2owk
	 L0u1Ywlxiuof1hsd/dTYUOviEleOQoINUIpqrk/Fl6NRs/WXzZXkjRm4MGwe9Ra/gT
	 zSqtFjYfsYIypOGnfgfzM0Pr+r4hzoAcKM7c6esQG/gKiZLEugghCR6DZjXeKW8zzb
	 +x4hesgLk56g7OLs23xF9TSuE2osQf9yC5l+wyud6gcg/9WofkdJyzRY3aSmdviYpq
	 JB4llvKD4wCOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] vhost/vdpa: reject overflowing PA map page counts on
 32-bit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <CAMuQ4bV8OeSTOVnAPRh6ygKdogFjqEiDNj1Vbh623KBBkZgxiw@mail.gmail.com>
References: <CAMuQ4bV8OeSTOVnAPRh6ygKdogFjqEiDNj1Vbh623KBBkZgxiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 21:56:27 +0000
Message-Id: <20260625215627.81CB81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pinned user pages are permanently leaked in the error path of `vho=
st_vdpa_pa_map()` when `pin_user_pages()` or `vhost_vdpa_map()` fails after=
 a successful chunk mapping due to flawed `nchunks` logic.
- [High] Integer truncation of `uaddr` in `vhost_vdpa_va_map()` allows mapp=
ing arbitrary massive ranges on 32-bit systems, bypassing VMA boundaries.
- [High] On 32-bit systems, `iova &=3D PAGE_MASK` silently truncates IOVAs =
greater than 4GB, leading to incorrect IOMMU mappings and memory leaks.
- [High] `vhost_vdpa_pa_map` incorrectly uses `0` to represent an uninitial=
ized `last_pfn`, which can cause the function to erroneously map arbitrary,=
 unpinned physical memory if a valid page happens to reside at PFN 0.
--

commit 1f4f03872bda69e8780226c7f6b39b4e2b451c4f
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

vhost/vdpa: reject overflowing PA map page counts on 32-bit
   =20
vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
size before computing the number of pages to pin. On 32-bit systems,
where unsigned long is narrower than u64, that addition can overflow and
the code can pin and map fewer pages than the requested IOTLB range. This
commit rejects sizes that overflow the unsigned long page-count calculation.

> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ac55275fa0d0a..ed47b1140703e 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1102,6 +1102,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	unsigned int gup_flags =3D FOLL_LONGTERM;
>  	unsigned long npages, cur_base, map_pfn, last_pfn =3D 0;

[Severity: High]
This isn't a bug introduced by this patch, but could the initialization of
last_pfn to 0 cause regressions if a valid page happens to reside at PFN 0?

If PFN 0 is pinned, the continuity check if (last_pfn && (this_pfn !=3D las=
t_pfn + 1))
fails, causing the code to map arbitrary, unpinned physical memory.

>  	unsigned long lock_limit, sz2pin, nchunks, i;
> +	unsigned long page_offset;
>  	u64 start =3D iova;

[ ... ]

Further down in the same function:

drivers/vhost/vdpa.c:vhost_vdpa_pa_map() {
    ...
				map_pfn =3D this_pfn;
				iova +=3D csize;
				nchunks =3D 0;
			}

			last_pfn =3D this_pfn;
		}
    ...
out:
	if (ret) {
		if (nchunks) {
			unsigned long pfn;
    ...
			WARN_ON(!last_pfn);
			for (pfn =3D map_pfn; pfn <=3D last_pfn; pfn++)
				unpin_user_page(pfn_to_page(pfn));
		}
		vhost_vdpa_unmap(v, iotlb, start, size);
	}
    ...
}

[Severity: High]
This is a pre-existing issue, but are pinned user pages permanently leaked
in this error path when pin_user_pages() or vhost_vdpa_map() fails?

When a chunk is successfully mapped, nchunks is zeroed but map_pfn and
last_pfn track the new outstanding unmapped page. If a subsequent operation
fails, the error path skips unpinning these outstanding pages because
nchunks is 0.

Also in vhost_vdpa_pa_map():

drivers/vhost/vdpa.c:vhost_vdpa_pa_map() {
    ...
	cur_base =3D uaddr & PAGE_MASK;
	iova &=3D PAGE_MASK;
	nchunks =3D 0;
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but might iova &=3D PAGE_MASK
silently truncate IOVAs greater than 4GB on 32-bit systems?

Since PAGE_MASK is an unsigned 32-bit constant, bitwise ANDing it with a
64-bit iova zero-extends the mask and clears the upper 32 bits, causing
unmap operations to fail to find the original mapping.

Finally, in vhost_vdpa_va_map():

drivers/vhost/vdpa.c:vhost_vdpa_va_map() {
    ...
		vma =3D find_vma(dev->mm, uaddr);
    ...
		map_size =3D min(size, vma->vm_end - uaddr);
    ...
}

[Severity: High]
This is a pre-existing issue, but will the truncation of the 64-bit uaddr
to 32 bits on 32-bit systems allow out-of-bounds mapping?

When uaddr is passed to find_vma() and then used in the bounds check, the
subtraction uses the untruncated 64-bit uaddr against a promoted 32-bit
vma->vm_end. This can result in a massive underflow that bypasses bounds
checks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CAMuQ4bV8OeSTOVnAPR=
h6ygKdogFjqEiDNj1Vbh623KBBkZgxiw@mail.gmail.com?part=3D1
