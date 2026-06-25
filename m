Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3D513D891
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782414432; cv=none; b=NyGEJGNg9xDqh7No97nrv66ept8zgEu/lkNsosB8+yeE8pbDOekAJYewsPqwEtgC3gysdQCWeV1NzxYI+7WUJW5ugXGBuzDqXXMyyH8XSNBTk17VDjTQ1xEuGOf7xZEOeoIYP6sMqJQzqK1oaQeu2V3kLPs99DezT+Gm8xXn7wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782414432; c=relaxed/simple;
	bh=nsqb1tz2bDc+ssS0lvVIeKHj0pXROC4yOCAqzf85+yc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a/oqCAQJaORqfCBQidM6l4eEwJCnZPwoB9x5VwuGpJ1uoKW0j1acYaBIZ0SMRFZILc3i6KQ6aZ6HA/rHMFD59NftsHpZLyC/D0NZ1rhF00GKCnHF8IkmfSqtdvuQ8pfebLGwh5wNIChjP5+wWA/9ak/yQGPdJJ6UJ7OnWsih/iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcNi6n+r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcNi6n+r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557121F000E9;
	Thu, 25 Jun 2026 19:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782414431;
	bh=muFfKGL3lwflKCrSkngHr7FjsuVWPTux0LF4bM1ejxI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EcNi6n+ryKyoAp0QoaCWscHuCyYPZNSpCpatBnxLPVhTlHmfKjgWecddL7qaO8WOT
	 nlkSCPTdjxPQiBr+4CzLlHZpo/6pxEE8PDIKUbyGWUJ/Efj96BXwgfxpr5N8uj9xnc
	 AGAdDqJIVSIUFnzK7M79/ofD6IOE57sKSIccmV/RZdbGBhbZB2NuviIYFVFMK1XiYv
	 WiSr+jltcXT7nh+JB/3geBc8kI7RVffgiBMJJuQVx5Uv/ttwOnW+gAMSvUpUbC70Vn
	 HdOemhJslfqbTV6n/5jbjFtkI//H7ywl81G8IS5DekMAyscbCdy5ZJH1VrPGRkeBsd
	 pII+28VSBl1UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost/vdpa: reject overflowing PA map page counts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260624190653.2893-1-alhouseenyousef@gmail.com>
References: <20260624190653.2893-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 19:07:10 +0000
Message-Id: <20260625190711.557121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The variable `last_pfn` uses `0` as a sentinel value, which br=
eaks the physical discontinuity check if PFN 0 is pinned, allowing an attac=
ker to map arbitrary physical memory into the device IOMMU.
- [High] Permanent leak of pinned memory pages in the error handling path d=
ue to flawed state tracking with the `nchunks` variable.
- [High] TOCTOU race in RLIMIT_MEMLOCK check allows users to bypass the loc=
ked memory limit by concurrently mapping pages across multiple vhost-vdpa d=
evices.
--

commit b62fefdce516922a639203f628dde15b26a4b097
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

vhost/vdpa: reject overflowing PA map page counts

This commit adds a check in vhost_vdpa_pa_map to prevent integer overflows
when adding the size and page offset. It also converts the pinned memory
limit check to use subtraction to prevent wrapping.

> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ac55275fa0d0a..090cb8693b7ce 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1102,6 +1102,8 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	unsigned int gup_flags =3D FOLL_LONGTERM;
>  	unsigned long npages, cur_base, map_pfn, last_pfn =3D 0;

[Severity: Critical]
This is a pre-existing issue, but does using 0 as a sentinel for last_pfn
break the discontinuity check if PFN 0 is pinned?

If PFN 0 is pinned, last_pfn becomes 0, and this check is silently bypassed
for all subsequent pages:

vhost_vdpa_pa_map() {
    ...
    if (last_pfn && (this_pfn !=3D last_pfn + 1)) {
    ...
}

Could this allow discontiguous physical pages to be incorrectly grouped
together and map arbitrary physical memory into the device IOMMU?

[ ... ]

> @@ -1123,7 +1130,8 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	mmap_read_lock(dev->mm);
> =20
>  	lock_limit =3D PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
> -	if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
> +	pinned_vm =3D atomic64_read(&dev->mm->pinned_vm);
> +	if (npages > lock_limit || pinned_vm > lock_limit - npages) {

[Severity: High]
This isn't a bug introduced by this patch, but does this limit check contain
a race condition?

Because pinned_vm is read without global serialization across the shared
mm_struct, multiple threads could concurrently issue ioctls to update the
IOTLB. Each thread takes its own device mutex and a shared mmap_read_lock.

If all threads concurrently read pinned_vm here, couldn't they all pass the
limit check, pin memory, and increment pinned_vm later, effectively bypassi=
ng
the limit?

>  		ret =3D -ENOMEM;
>  		goto unlock;
>  	}

[Severity: High]
This is a pre-existing issue, but is there a leak of pinned memory pages in
the error handling path of this function?

When a discontiguous page is encountered, the previous chunk is mapped and
nchunks is cleared to 0:

vhost_vdpa_pa_map() {
    ...
    if (last_pfn && (this_pfn !=3D last_pfn + 1)) {
        ...
        ret =3D vhost_vdpa_map(...)
        ...
        nchunks =3D 0;
    }
    ...
}

However, the inner loop immediately continues processing the new page, maki=
ng
it the start of a new outstanding chunk. If a subsequent pin_user_pages()
fails in the next iteration of the outer loop, the code jumps to the out
label:

vhost_vdpa_pa_map() {
    ...
out:
    if (ret) {
        if (nchunks) {
            ...
            for (pfn =3D map_pfn; pfn <=3D last_pfn; pfn++)
                unpin_user_page(pfn_to_page(pfn));
        }
        ...
}

Because nchunks was left at 0, doesn't it skip unpinning the outstanding
pages?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624190653.2893=
-1-alhouseenyousef@gmail.com?part=3D1
