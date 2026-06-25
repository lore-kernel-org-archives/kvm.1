Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1325D221F1F
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378430; cv=pass; b=ClzrNDSjxtcjyXdX8/gflOwVFiGEK/swtlnZUzNvvdiGW/t75vCeVg+DZHDmNHCdBayMdPD8WuUN4z5Uy8UYSVMhPzjyTksfXM9UuJeKPO4Q2b2B21GLOQs78AeMeOfmsazwgLy/n+hiHNOpvVI9qtLssznI/Gfaf1W/5QteURQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378430; c=relaxed/simple;
	bh=UEYSjQQa9ki6wfrDTl8bUciJydH67+AsH0v6+q+s0WM=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOHoyE5bZ7qPOmmUmFI3v3txy8M5Ntn4K9jw3YLaQFeDWvgibNtWPFtGHrIunmPdrTPcz5Xdra1mMCLIrpTTCLZeQVvoa+Hg+zcypKet2S4y/1/yhHoKZEZzIihrbbyxPVvA7miDsEoya1pHAthWeT4nTQ+xvGy5frUuDP+JjAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bs9l5f/3; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bs9l5f/3"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7dfceeaf168so22746767b3.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 02:07:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782378428; cv=none;
        d=google.com; s=arc-20260327;
        b=dYLD/hg+gp0EutXTFuB3oPbC9WZQoISAXtt0PKhGhz979UM9QkQZhIjmifGDZkjohD
         XEqCfUytwzzzgVWCSdWzI7zfm/HAcOL9OY98mI2nAPFu12UP80eLDKOAK3YV522U3pZ8
         OOMqShIFkcl+EQTZ4Rgv6IaMC6/9bEmNFKiFBvXma+zU9VzhhjDYbcwNaL4CTDl+Wvn+
         OCVhN5hBX3vWUZzsBry1hbTkmREz3U/k3k09CIHY4pZeWN+aUq22xiqALT+rWCCWJ5VD
         IuDH4ZDYYuKckRL6PGF4ALYckFum1kutXk14pPE8kChwo2BDHHF60mtz1BnV2AfNvdL1
         MLiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=UEYSjQQa9ki6wfrDTl8bUciJydH67+AsH0v6+q+s0WM=;
        fh=7zvvFFXHdKmji8sLPsftZ9ignPKtGN3mj3H4Q2q2vxo=;
        b=r1SHwT7CH0FjY4xDOJA+PdxOSZHlx6pXENg2USQQvOgU/tcbea7zQ/+jKjWzrmC3j1
         uAQ86GXy/F1bAN570O0pYIGeF7147bxD0srPMIAH+Kqqe2Iuq13qed23D3wDXYS1tgXH
         czil1rCvtIhVvuGTQPK8pqZzFBevtEaUNRSWG26PS0/2VaAvbF/9fwUMsanIL9E05EUy
         efDDhOeKHE4UQ3HlfOyOaMFI6X4JvWOSjbL+1LMZfuK6peIancPDub5pmTMCvHlkmNvm
         Hmw7M8syXd8lVya7hvqXW7ZGgI2lzfvl1mIGVPC0JmTOeRmOWokdydI91ep0yrR41Vek
         KW0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782378428; x=1782983228; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UEYSjQQa9ki6wfrDTl8bUciJydH67+AsH0v6+q+s0WM=;
        b=Bs9l5f/3aZPCc+dMTvVEyPYlWMKiEhbkGoiYj6M7xKtuEQM+1JO6tAUv2xBItyS4lN
         0mHoegcNYsWSj5HGK9O+23fOxis9WHayLIBggjWyxO+EbeR/+xG7KoJaVvWmHx0Lj6xR
         6w0SRJhnh8amr66jq19qwTR3qKp3j5XpgHW/hAkonZqocWIa65rWlmwD+yN1XW1IdM2c
         T1iXKgKW8s0CdnNiIeYKDEUIpKDn9SlsQjS7Ekid+Cdfs0glhBS9sd66wrTA9OqGI+ct
         mrD4oiox0U3DMzQHB0aJqd+uttmPBdezjqMsVJ3G+rVQIvggCO0qwi/YBioshGfiUv1k
         DtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782378428; x=1782983228;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEYSjQQa9ki6wfrDTl8bUciJydH67+AsH0v6+q+s0WM=;
        b=Y8ePiOsB8br2qhx/g/qkQUBhHhWJxz/iii9mMIueJEolsKzZZNbH8iXkxFLfU/+u2C
         cKju6AhuorvJA4rR3GFMbaYazQfOnW+sJ9xrESs6v8HOVRCTPk+gakTzon7mWlYgKYBY
         JjRpS9d90XwUAPQXUG3wPSJNdzkvIEf0tLzYY5YubdNDJVy8cx1XrDEx5OHGDxJ/jbo+
         zmheE1oCLf7DKBEBJQtMRP34MLQ6W28a7kJxW7H60uyxnhC1y6mgxxgaQi/iwDyno9aW
         79yLUqkLj4ocZSG78r20Qn08YHOyXpYobr9tbalz/lPor9Db5AUXS8Gnf/qt8wdXp2bA
         2Wtg==
X-Gm-Message-State: AOJu0Yw2aHhN6tull13sP3K/XfOu7M4/PPEOas3YR+ZFx0B+ToxC9ERW
	pu9Ef3T23tAlNs8E9DrizsNhvTSdP9MjI59HmTkHTElV3m1PwBZ/2oKPPzi2sxkFqXENKrp2lvA
	lfWdvrd6nubVvknW5jqEBKDg0vYFeb0w=
X-Gm-Gg: AfdE7ckn+6XtTsxXCoUtfCKFqnr5VyBaZFpdNfucMwf8/T+wBqpcm9+JUi8j3pI/PxB
	sJB28nSzsVIi1+cDqA62SIeFg6Yl819vQrDMq3VZJ0StlN43llZXqJ7mkOz19MLx7F3QG9/UJyk
	mg1NerBQGVO6cqi5nVVO9nZlLhCOYECb1ilcfOoJUjX+s4yw+R4LHQkD28iyAHzf1wWoeSFNMbU
	3Euxs5Q4Wj4rwEIgqryJXIEHV94L7KB98Y9m6pzaZuwPxcY6xlk9m8Og67ZSzKYaIfXbEpBgw==
X-Received: by 2002:a05:690c:c453:b0:7d4:3090:f39 with SMTP id
 00721157ae682-80a6b0a264cmr16436707b3.42.1782378428135; Thu, 25 Jun 2026
 02:07:08 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 25 Jun 2026 02:07:07 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 25 Jun 2026 02:07:07 -0700
In-Reply-To: <20260624132217.7fd42c77@shazbot.org>
References: <20260624191204.3774-1-alhouseenyousef@gmail.com> <20260624132217.7fd42c77@shazbot.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Thu, 25 Jun 2026 02:07:07 -0700
X-Gm-Features: AVVi8Cd3-MLnkT3QQoy3d0WjFoeLW5hfvJeraMpvbqdjUWcA2rnRFw8pk_bCrJc
Message-ID: <CAMuQ4bWvYZTaDOPzOYSL8GpTNupGjkFS86evM7A4GV=DwTsgLg@mail.gmail.com>
Subject: Re: [PATCH] vfio/type1: validate dirty bitmap page size before use
To: Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Li RongQing <lirongqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

Thanks for the pointer. I'll defer to the existing series; please drop my patch.

Thanks,
Yousef

On Wed, 24 Jun 2026 13:22:17 -0600, Alex Williamson <alex@shazbot.org> wrote:
> On Wed, 24 Jun 2026 21:12:04 +0200
> Yousef Alhouseen <alhouseenyousef@gmail.com> wrote:
>
> > The dirty bitmap ioctl paths derive a shift with __ffs() from the
> > userspace supplied bitmap page size before comparing it with the IOMMU
> > page size. A zero page size has undefined behavior, and a non-power-of-2
> > value makes the bitmap size check use a different granularity than the
> > page size later accepted by the ioctl.
> >
> > Reject invalid bitmap page sizes before using them in shift arithmetic.
>
> Thanks for the patch, this is already being worked:
>
> [v1]https://lore.kernel.org/all/20260616111733.1810-1-lirongqing@baidu.com/
> [v2]https://lore.kernel.org/all/20260617113251.2535-1-lirongqing@baidu.com/
>
> Thanks,
> Alex
>
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> > ---
> > drivers/vfio/vfio_iommu_type1.c | 7 +++++++
> > 1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index c8151ba54..9499381d0 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -26,6 +26,7 @@
> > #include <linux/fs.h>
> > #include <linux/highmem.h>
> > #include <linux/iommu.h>
> > +#include <linux/log2.h>
> > #include <linux/module.h>
> > #include <linux/mm.h>
> > #include <linux/kthread.h>
> > @@ -2949,6 +2950,9 @@ static int vfio_iommu_type1_unmap_dma(struct vfio_iommu *iommu,
> > if (!access_ok((void __user *)bitmap.data, bitmap.size))
> > return -EINVAL;
> >
> > + if (!is_power_of_2(bitmap.pgsize))
> > + return -EINVAL;
> > +
> > pgshift = __ffs(bitmap.pgsize);
> > ret = verify_bitmap_size(unmap.size >> pgshift,
> > bitmap.size);
> > @@ -3039,6 +3043,9 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
> > range.bitmap.size))
> > return -EINVAL;
> >
> > + if (!is_power_of_2(range.bitmap.pgsize))
> > + return -EINVAL;
> > +
> > pgshift = __ffs(range.bitmap.pgsize);
> > ret = verify_bitmap_size(size >> pgshift,
> > range.bitmap.size);
