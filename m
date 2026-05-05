Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583C2481FC7
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997032; cv=pass; b=FcXmjUjVfHo29Ttidmzeo+ZmMHjkn3+EOwTXh/a9csz3clWy8rXKtZ2AhA0cGD63rFuvccHVM6sLZamqpnWF0N9iCWl9oXSy3zXkdwTnoWfCMBjbDNVaPEiYZjYbDsXNVug8w50vi+CnocABRp+OT5iCrj2MolhyBNm+V3E5674=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997032; c=relaxed/simple;
	bh=DOxw+2aGh05xah5kcfBJMyzXIPlOW0sfsA2Z1OFqjOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAzRGbzHgBy6HDcaFcHNGH0dWdNq1OjmgYk+bypeyCd9YNX0GwbNBAo1LGErYedCVq6kE73jINPVUib5zd9dHh+yKv+gTyztnVprc+MsSVFh3v+2PL5xowlmCTzprI+gdpN9IB9SSWAHExERAJr2IUlO/vUINs8Evwg3ZxPU1qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tdamdiJZ; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tdamdiJZ"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c1a170a50so7115363c88.0
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 09:03:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777997028; cv=none;
        d=google.com; s=arc-20240605;
        b=EA5fhMowxU9h0JEB65mfWr/CYsU3i8mMb/gHcGhHXZKZXg3l3ZdAr62uuPnKDz6S0p
         7G8r0YGD7SLpdq2LZGNAwOblMb5M5BlxuTuEgpMp/V0PdjvYctuPbsX/Ugs6Yob3NfCD
         teHlixw3HlBGydDUK5sITFOjcArgKOcJ+9SDnwe5ufzN7ixaU4RaJVGp4snqO6pdpcK7
         JyLTANn54hlzLxQmIaaBCE1fhQ3dN3+8JUySwAhDaEiutgg6xEvKbWRbNfec35NsWlKd
         aE8XxnXvBTMzPdJ0iy1BUqMPDjcXBKdj+PNAcobTbJNQDSAnq4/McwZCuHl8Akx42ur4
         SR3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DOxw+2aGh05xah5kcfBJMyzXIPlOW0sfsA2Z1OFqjOk=;
        fh=N8UDXelftHoqOroHm8YrFUny+U9iF7tnwD8eAfd3x4w=;
        b=lEd0LEy3aEJrjDcwzJcRuoj6ovyyLdc6uhpGQYycH6jPUDVm7HbY+MvRnFxOJAJBLn
         +ZHnTi0UA7QRtxGIZnnktVREvlBV0XjbrhfQu4WhK55Y3Ioe8EtV7lRImlP2cQULcSI2
         znBilyFxADTtqqTsKDjj9u18NasLyyPxbH8lft80hWo6fdM2XvTDIcjprAxlFZsny4XD
         HKejUPp87Cl1RWxZkZ5oBFMR8tZ+Wyne49uOxDoYG57ugyP/fE38/MudfobF1asIpeNR
         MgIXwoezFbKL3fqA9jhY2HqqJ3ntmx79ElR5PhhlgGkPeuTBqyQ2H98rtTHRyzB4fxFt
         HVGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777997028; x=1778601828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOxw+2aGh05xah5kcfBJMyzXIPlOW0sfsA2Z1OFqjOk=;
        b=tdamdiJZ8AIZ26E9sOTTyk5jU1BM7rY1atHf7juQtp4GtWQo2X7xFMAFFaXqis+usC
         3rOop43vEFOgGCM2lvtCWwGpCZd6r8vAhaPGXwFp3uQUG6mMe/g9x6YqrMXZg5OlxsHA
         tDFr5xlKD89TC/QqpPzhkoloRoC5il7rqtZqjrl2y1cI77mU2u/DViFwzy7cuCXvJHoM
         xeHOlDIGsgSvEdI7UJiVxJvEYA2LvyWAhv9xoRmwBi7Kqq2Jl5FVOzD/TDXFPOsAHrTU
         ZIz2AMStuM2F+GMwYJdzBqwmibTYK1T5ShB1lfsvPz8HFg4B9nOYk3PB+gvyJZED4p/U
         AsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777997028; x=1778601828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DOxw+2aGh05xah5kcfBJMyzXIPlOW0sfsA2Z1OFqjOk=;
        b=pwl7f2hu1/Z0Ygx8VzFO0CL5tUIN9AT+3/R8cw9LhdR5LSpxo5LBCId24emusQii+O
         r5//0ULXvXyrMdsDUJxpPPvOC48JuKoElRYx8Cjf6uCWrjIL1Rtg4t/bbaywO67iislu
         P2P7Gp/ShprRtt8k0LkXah9CCEz7YkEHV7ULe8HRT5/psy3R9b3ZIgRdR5L/40y3bDY1
         H4bBzj2MKfxl+ScHF5voyHy3fJeSKF6QYGg+chdxJlvwxrRSeN7ll6bQg5OKcDB+wmop
         OcmWElMeH21TJ7ddDamsyq0sb94rNWarfdZjm2U35Xyk3bt4ZERcdeA5sE1W3OqXb7qt
         mm8A==
X-Forwarded-Encrypted: i=1; AFNElJ8hrw5NUgBJJwOF5Lzc5FuIvQJNAsnR8Ca3ucwcWIJ8IQrLGqLEJMr/hJR7K7nhqLA/W/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy2XX0rUMGWNynIwAPwv6hEu1BR6Lh0gAQ7z340g9e6E+JBIRu
	d9vq79L4MR+zpS1EUzmvwd6KAim3aY5IB3HYnzw8jSWYelZJYkMHkkFqlXkm4dI99ZppOEX/MnW
	NPzFq1YK9+Cq+/MENj7csgsbSLBxTc621mXPPzQnp
X-Gm-Gg: AeBDietgNYA1GRFe4Vt9m6siADELwDdV9wr8N/+y4i4qMkG2wUwju0hIKMntCQX5JbR
	zr6BOrZByL4lXfZ31iZbqB1su2cKuHcNWkE7yf1ukX085pilH3FrnircsjW2hGZhBjaXpap2e+Z
	X7OmQF+5FVbM+8V+o5dc1prS5DTk9IbF4yrgBvmoFfAkzcugihAOY1XoN0ZFM42IMTUYBsLhHt4
	tIVZeRpLEQ7OmnQOn/FY1zMnwMiZKwh8pWJR9vlhyJNKStT+3ouqKAlMZlq5bI=
X-Received: by 2002:a05:7022:78f:b0:12d:ca32:59f with SMTP id
 a92af1059eb24-12dfd7e5bdbmr7028039c88.11.1777997026608; Tue, 05 May 2026
 09:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com> <9-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <afkfP-8UHaoyLd5Y@google.com> <afoQtL6gEN2wUba7@nvidia.com>
In-Reply-To: <afoQtL6gEN2wUba7@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 5 May 2026 09:03:19 -0700
X-Gm-Features: AVHnY4LsNmTptv6RYHm1ivIrJui-vL8wanpj85inMj7g24wxtEjU8rbJcAF7qfg
Message-ID: <CALzav=eQcRUNR8FtqDwXsjm+MbMSN-u7GyCj96-NmbDhB17GRQ@mail.gmail.com>
Subject: Re: [PATCH 09/11] vfio: selftests: Add mlx5 driver - HW init and
 command interface
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 8:46=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Mon, May 04, 2026 at 10:35:43PM +0000, David Matlack wrote:
> > On 2026-04-30 09:08 PM, Jason Gunthorpe wrote:
> >
> > > +/*
> > > + * Driver state =E2=80=94 overlaid on device->driver.region.vaddr.
> > > + *
> > > + * Contains both software-only state and HW-visible DMA buffers. HW =
buffers need
> > > + * strict IOVA alignment.
> > > + */
> > > +struct mlx5st_device {
> >
> > Can we do s/mlx5st/mlx5/ on the series?
>
> No, I don't want to do this. Since it is in tree I want to reserve the
> mlx5_ prefix only for the main driver. The driver is huge, I do not
> want to harm or confuse grep - that team will get mad.

git-grep can be scoped to directories, but ok let's keep mlx5st to
avoid disrupting anyone's workflow.
