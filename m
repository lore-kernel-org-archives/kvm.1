Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199A7494A0C
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137171; cv=pass; b=nUfqYOXlgxD+fGR5ma+b5Ru0jiNyPmrVEskUrjxmXUNk4sUnKMG0oqdU2i9Ql1ilWNHqhzn9KDJjqQVDYwXfnGIH1BLN+MfDN1BNzKIhnK8w/+OGhuQoDgF1rC5n91qUmRDm1Decz9tloFn6bfyxzjMZuM1XDNM8NSj4juI+rz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137171; c=relaxed/simple;
	bh=UR90RzwH1sTaFwHI2fccHwy64vQk/jsB/OnXGze9wC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=samfTI+Mv10KUKeSJRzRDD9eyxu7rXnxxJjRYIvQvwvBe/HPcSf4vzhyoLd87yN1akim8wtqGk2kOzlg5AocUlOvDezo53E3Cww+Wk3AnCUezEdTVKGEOg6evOCD9sBBAjACEXyVVkDC+4/+xnh6iwY4RpUtpYhBC0xu3Oyg4l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h3JLQCxi; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h3JLQCxi"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca913a601fbso4008181a12.3
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 10:39:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784137169; cv=none;
        d=google.com; s=arc-20260327;
        b=UGX9pwRfwbKER2/s7FIBNJLHE29stFx3/OhPUAUXVledfFjMK11gjR49dBcS/4fUnR
         vB/uNLRXVAZn2hGTNaHIONNtlSMR7DTyaUTpG4ZefBWmtv9pCSUnoLx5YOzts/IucPIx
         p2xNbTVwExrrmY7zB6PoxXUe+yk3FLkoQs8j4GG3eZ69/QXRCTYtIzD5IrTdRNbputEa
         J+tq/N9mdWvdsD4OyMH/ZQQgt7baftwqqoJPDZmrg053gAJK9olFp9vvNY3AeDIs7beY
         9xP259c2i+0W8KQkig8ccZOqrlmlYKCWWbZe3twzbw/PEcFSD07n6161fdc3WP7R1KzC
         s0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1/uRn4D1jgvTwu8lCVDS64ggTAzCxy5MUCusZYPj+s8=;
        fh=QGOSbqHXNfEsRJMiKxygMPdMi/b4ceHqXBD9WVzu7fQ=;
        b=WMnOUj3c7u439aVFZW+oM8d00ZTgbb07VtWvyGDcQmkHlWurMae+NcpsLEXZbcRO+I
         fvtBs78Mt7XOkyNBLBmEZNioYG/HU0+isFXU5eJbspTZ8fWhmzndlUhxJe6hLy9dkngY
         PvGDdVAgePrGgLtTCoBc4w66O9uGwZKtMx+9b9DklgsaMxZ5StQfPU+qLrTxds26PXgx
         LgD6lhIXumR4uNmdV3MqXfZxS0sE4DovGgsEGxQCOjEQBTXWB/3zdS6kDTkFea5+PzwD
         awwG0EZsabpwYtcVXo9K5tkj/Ay6KauHCEKiGW7yRFpvL8BcnTn68V+PgYYOy0apX8u+
         Aubw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784137169; x=1784741969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1/uRn4D1jgvTwu8lCVDS64ggTAzCxy5MUCusZYPj+s8=;
        b=h3JLQCxi/TgwPu8OFTVmPvZo0sFHq29DI8tdgUgFQw92GT/6gz7+N3D+CnFFhPmnyy
         Rw8XyK1MxWZVi1mIooesqV5tijZFc/opGcMrStN7lNqMweel01I+5hKMnWPIUklkcYhE
         iM79b8Qc7BU3Ebe+lsJbm5pQ9ak7bdeolyNr7iBFeMXNS9vzvIsALPy8Wk+tGDGrZWE1
         nN1JrM1NRqG531Z5TmntPOcNgcRMUDPSm9X3AC83yZ7HefXMfUaTB5jHLTFY3pPUQOB7
         B6RHg49z2vzFYOEfz99rxwyDUp9UwcdKR1D/93KLxL+UKaGQqWuj0h7KRFOg8fbajHTV
         rB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784137169; x=1784741969;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1/uRn4D1jgvTwu8lCVDS64ggTAzCxy5MUCusZYPj+s8=;
        b=qI3PHROQ0WRcdC8RGAQa8zEcwcJOsdkfqaXlKQcha9C7D+HvhXcReDk2SBX0g1wBcH
         0xGhr4JJ2RW3s1ZmkvWxq35z5zASjJOkvtGEJl1WC5HC+4JCXEHXrNVZ4y4OFVHFvpg6
         mBQZHPF7fQvF/r/yZatltoD+ulKVtmFXzRKz6rjW00dCMVnKkPmIcWl3wBJ6/EgeRkGl
         IzxnUHJk4KcFPG4Uzc59aeacoL+7mmUbHrgMZtzHr+z3QLBfr+FZL8wUvN/zqocBMbiA
         jTJ6nSP+62/uk9sGz3Kkbn/H6wsNgD9ufr9o+N8XH2VZmD38Omaj109VSDFJ/VVJI2gA
         IAbw==
X-Gm-Message-State: AOJu0YzvEqeFGauANwugUGp9F5/ky3P3+V+wJwXREl/MJidRF18DL0l6
	4k2T3efZFG3NonDTzl4Pc5eJ07dS7haHI1XhW4BNEMzKDDMzZL3V15AMQe7D+XVC0vB/mwYNEBh
	5x3L1QJ1hTCfmDMUPGK+H2PjDmNnHyj7l8KeCdxEn
X-Gm-Gg: AfdE7cmxLv+PQ1QK7OCxX7+r6ScHh55MUBlKjE4dzFxElYX8PY6b4z3SUeNHzwwXsWw
	zgFVimRBqGzYLsbphxhvIa2Y3SBKBX9sbPm2ub4N4YN45H5lbztjeg3d/kw+jAspg0R29xIFMXA
	njwL9tJxouYgr57OTd05hSXsHWGq9RHUk2vN2eCfhxT0sj8J6ebbex/nxAHiMpAmjACy8hD5O78
	DrzvZpuRMHkZ3333N3G8YqZn+lq/vCYYBMKCgXL8dpvg+sx+okAeRcMBwiE0AREFqgzZCG7OPql
	IFgB3J8=
X-Received: by 2002:a05:6a21:610f:b0:3bf:6c08:fb9c with SMTP id
 adf61e73a8af0-3c35754eddbmr8789709637.48.1784137168803; Wed, 15 Jul 2026
 10:39:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714210303.3967981-1-aaronlewis@google.com> <20260714210303.3967981-2-aaronlewis@google.com>
In-Reply-To: <20260714210303.3967981-2-aaronlewis@google.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 15 Jul 2026 10:39:01 -0700
X-Gm-Features: AUfX_mwNwzgGdeS4cy63Qu4yT_h2teWRo98UoEkQX9TqSeqvZ2tmJUzmlkS29vQ
Message-ID: <CALzav=ckyqekeXkhzyBc9tOEU-_Ukmgh30dcye-BWbaMnNa6vw@mail.gmail.com>
Subject: Re: [PATCH 1/2] vfio/type1: Periodically try rescheduling when unmapping
To: Aaron Lewis <aaronlewis@google.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org, jgg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 2:03=E2=80=AFPM Aaron Lewis <aaronlewis@google.com>=
 wrote:

> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_ty=
pe1.c
> index c8151ba54de3..e78bc07d9b6e 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1153,6 +1153,7 @@ static long vfio_unmap_unpin(struct vfio_iommu *iom=
mu, struct vfio_dma *dma,
>         int unmapped_region_cnt =3D 0;
>         long unlocked =3D 0;
>         size_t pos =3D 0;
> +       int i =3D 0;
>
>         if (!dma->size)
>                 return 0;
> @@ -1196,6 +1197,8 @@ static long vfio_unmap_unpin(struct vfio_iommu *iom=
mu, struct vfio_dma *dma,
>                         next =3D iommu_iova_to_phys(domain->domain, iova =
+ len);
>                         if (next !=3D phys + len)
>                                 break;
> +                       if ((++i % BIT(PUD_ORDER)) =3D=3D 0)
> +                               cond_resched();
>                 }

What is the performance impact on unmap if cond_resched() is called on
every iteration of the loop? It would be nice to not have a magic
heuristic (which is brittle as Sashiko points out).
