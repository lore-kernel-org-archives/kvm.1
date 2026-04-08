Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336C920B22
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 22:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775685663; cv=pass; b=ZfdCNDzTQ+mFIV4kmzQMHBVS397nx1BeKtoNNAby0sPs66ROm3jQr71V1xP2ADRJiT7PgN24Awkr0cvyiNEo/aVC9m4jviedH6PZqW5GDAmZa+/iA7VdQFSIml36kLpbcHnh8GRdVPLoVcQ2tdDSPeBouR5/TtwPslwjhnLfK3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775685663; c=relaxed/simple;
	bh=j8imaKId0dRx7JPyCv4vSVVbP0IIoQNE2Omu9BO+pR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfTVnPCmzx0VJqJWHP6s0LNUnEaQheuqlLz1MyB9FxbcT7Ov4l4ygMVcbewekjb7HRal+e+GkY7Bjtn+FwT029sJbgg5XkqfQB36rBIo5sqcyoO4GMeMA8Kve0tj0DEnNOOevDhCJO0EgK07bdDZIf0mikkyD/Nqcm/lLIYhrsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PvH5kk/o; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iza2MgKt; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PvH5kk/o";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iza2MgKt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775685661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=37chEWD8E7J2il6Ld/rOd9Xr2zHalfFTJF1CJk2mB1E=;
	b=PvH5kk/owSLfixZhzrdUZo89oFP4G7RLnoGY6mPNtxAteRNka/NP/rrdO6SwJ2B2WMvUf6
	LjiEtE6t6cXE6iIejfKcaqFbhbsC2QBUE9MSvw1NjF0m0PjoQUKbwZQtXh8vtaYeWk+a8v
	mq0lUJ/+hSqt1vAWhDyWQftBz7xsgB0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-yfqc7h6YP1WS8qe0jDDIIA-1; Wed, 08 Apr 2026 18:01:00 -0400
X-MC-Unique: yfqc7h6YP1WS8qe0jDDIIA-1
X-Mimecast-MFC-AGG-ID: yfqc7h6YP1WS8qe0jDDIIA_1775685659
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d07f0aca0so136816f8f.3
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 15:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775685659; cv=none;
        d=google.com; s=arc-20240605;
        b=AaWH7W5kyUkAVnwYbMtBDvGU1fuxxX++aszUDftHSHO8yWIsfdJJeBGa+zZVCAAx51
         GokqAfS8E/RuJnmogrUlqedlbq/ojjrSpZ8qLjHqRe/2AsUeSZTWkUfPV5RgByLoQvzD
         ZZycZkLWlh/vokKcW4vOTQGuZlDsyydLl8PoQ3o8EXnx0EyoirRobJ6TTc9qi1oCj8bL
         CvoZWK1O0zc9kzzDNH0JENtkZ/VQYEokqlvIJVGx11/evJnTeBBd33Cz1/DLnJum1ICB
         gB9Api480RSkmNqviaOIGqgvlm+Wj/u58e7XK2FaDatHSwGwROMYunig5EjrHh8YL1aP
         dreQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=37chEWD8E7J2il6Ld/rOd9Xr2zHalfFTJF1CJk2mB1E=;
        fh=49pbv4SHsk6SY/UjZYRkzIP3rcejrFaOtV0++VjH9DQ=;
        b=dwYVJS3UNDYK2r2cBp/J+nwZYq265oJmKTWS1YUpqFcM2Hx5xf1NzGtBj3Uv9VDTz5
         TrLA/eox4BdTO/oOHGBYfEbWsxRIMgSGWpeKpoVA7t0LnC8bDRJv47r3LPEtWMnbxDXB
         9vNzXIF5fbwdqCQm4F1FM0KlOnOtG+XUazNS2MaVQXVflVLXR0LNU924ppZ+LkbI1yxB
         a0cQiYPNcqoaJIJ3aBf+tnoSrcQ+9cLl3NNXqDt5s1EJz5+6OnlWEtWFsSXj5To2QXly
         EqCiygI5U5LMBegVy4zGSFCnmWJrI3eJTYMVhTFrmcVCvBXCLgVpbTJNnKBQw6xKmLrp
         Rb9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775685659; x=1776290459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37chEWD8E7J2il6Ld/rOd9Xr2zHalfFTJF1CJk2mB1E=;
        b=iza2MgKtNUcvDrYwwpIODMqG5KAFq6BrZ+MLWVUADISbKxbU7zx7b2mKjHFHosiyi2
         H3bpwgjLZ/zacD2w76one17fKVocbO7pzcU9ZIIGM0trRVC6JPimZcN/UrZo6q55wFJm
         0sG2FYD2BsyAWXwi8jm/OOFH7glwiI+rmhirgpHr4CYLzy2mRHvbZ7nW/O2gfZjiG5rI
         uD/DGxFwkOqvC4Wfnk/xTs97gQtHQ933F0YiHeoqoXqYI8nyqEuvY113uAoFLQVvkZfY
         Xk3OnI1uKhyoooMTpSxm18wjFTA/wN9tggyoJ/35obZNqhxqoyporqVeqYV1Cv0iIKdc
         9ODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775685659; x=1776290459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=37chEWD8E7J2il6Ld/rOd9Xr2zHalfFTJF1CJk2mB1E=;
        b=WiJhfwmuKXAjUtjHyukFsh5qxRyUcLYd+kb3esipxeshAzcWBfWhxaqCIcLmOzkN+5
         NIyxRSTpOAM6BAto42IT7rA+z28uAWlb9gc9ZVob5CbLySOcwrrrC6NhAE/WKQPpCBji
         P///q0MkIKa5YrGkWp/JxykDJYYtKvJDdO+DEwYOB6snUP95Z1NUOXRyuIUzfHonpazY
         HhuX9QOdHKVRJ1XBJqOw3W7Sc8ZPYw682V2D984kIQj3VShFE9HQkpV0WluhpYiAMbtx
         5NBCDANj1MOTCbVYb33QarMj0n0JqIEiUkKwkjnUon/zCroivy7rwNR2tgqJAQlWqLES
         3qRw==
X-Forwarded-Encrypted: i=1; AJvYcCUceN85Zq9FGQ77kpOmeryTVPpPGQapPTXD0gLME5MmEAShvAi4HWuXPWR90M+qqDmIEak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdNhdhbz+LzXxs6i4fgZbdnStdQ5NOAqLmcVhoo9XlAUgl2wl7
	bOk2qL6zTckzhUrKZ7ZpjGj8dp/yxA05pZOHslCxGqZYhkcYnAZn1aFwupn2i0JOmPUJ4GrtgNA
	J9ryeMfhQ8mpWzymYEQs7qH6AUhyakkjLKJJEDVWcETpuupE9U4e4JZSKyHZLdJCzP0gvBg88Vj
	i8iiAb+R0Uk7PqPxjqh1DrY4I9+ADf
X-Gm-Gg: AeBDiet5u/E2fjuYiB6oslsmkeJ8HgjqG2TIb4pXXLgepwXm0fz2KSTNDclzhXIMs2L
	mbSZPDBv9ZUb/qRK5qWF8M49bGQ2qfY3acqvE+Rt5prwgmni5u45D5AQLYs7FsCosEirMsgFJqg
	ZdxNgTtONMUjMi5a+xIb307qvlLMN8utGDqs43y8KiWS9JQ//nCQHSAihQ7YoHHd65tdLOam42K
	+g6gbm4DmgvkVrD82IYMiXVjsxrHHYtyk6gxZEk8sBbPW/HGR+qjtK6t0dCAnOnjqcygHldr8pV
	ySIl
X-Received: by 2002:a05:6000:4201:b0:43b:3d80:b0b9 with SMTP id ffacd0b85a97d-43d29295ed7mr34842337f8f.12.1775685658572;
        Wed, 08 Apr 2026 15:00:58 -0700 (PDT)
X-Received: by 2002:a05:6000:4201:b0:43b:3d80:b0b9 with SMTP id
 ffacd0b85a97d-43d29295ed7mr34842301f8f.12.1775685658178; Wed, 08 Apr 2026
 15:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407175934.1602711-1-pbonzini@redhat.com> <6569b8b8-7654-4dbe-a4a6-f1e565451672@linux.ibm.com>
 <CABgObfbiNRfNGvhDFO=h-E27KONh80fkB1y1rOGpazTB2Eigzw@mail.gmail.com>
In-Reply-To: <CABgObfbiNRfNGvhDFO=h-E27KONh80fkB1y1rOGpazTB2Eigzw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 9 Apr 2026 00:00:46 +0200
X-Gm-Features: AQROBzDtkULtXuOIc6UktDacGB00r8lXLxRwmWhCPnmkbmrka56IuwUdIx-sODc
Message-ID: <CABgObfZg7HTX=N3cjHCeiZ2KuKSxnbr9Q7-5ciy8WgMPwBhU5g@mail.gmail.com>
Subject: Re: [PATCH] VFIO: remove dead notifier code
To: Anthony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, alex@shazbot.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 4:36=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> On Wed, Apr 8, 2026 at 4:35=E2=80=AFPM Anthony Krowiak <akrowiak@linux.ib=
m.com> wrote:
> >
> >
> > >     open_device:
> > > -    The vfio_ap driver uses this callback to register a
> > > -    VFIO_GROUP_NOTIFY_SET_KVM notifier callback function for the mat=
rix mdev
> > > -    devices. The open_device callback is invoked by userspace to con=
nect the
> > > -    VFIO iommu group for the matrix mdev device to the MDEV bus. Acc=
ess to the
> > > -    KVM structure used to configure the KVM guest is provided via th=
is callback.
> > > -    The KVM structure, is used to configure the guest's access to th=
e AP matrix
> > > -    defined via the vfio_ap mediated device's sysfs attribute files.
> > > +    the open_device callback is invoked by userspace to connect the
> >
> > Capitalization:
> > s/the open_device callback/The open device callback/
> >
> > Capitalization:
> > s/this callback/This callback/
>
> Heh, I had to pick one or the other (close_device previously used
> lowercase) and chose the wrong one. :)

I was going to make the change, but then noticed that lowercase is
more common in the file:

  create:
    allocates the ap_matrix_mdev structure used by the vfio_ap driver to:

  remove:
    deallocates the vfio_ap mediated device's ap_matrix_mdev structure.
    This will be allowed only if a running guest is not using the mdev.

  ioctl:
    this callback handles the VFIO_DEVICE_GET_INFO and VFIO_DEVICE_RESET
    ioctls defined by the vfio framework.

What do you think?

Paolo

