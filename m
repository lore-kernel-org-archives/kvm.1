Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217233D3D14
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775659018; cv=pass; b=HR+pGIBBdCoHDjtjfi/k6+fSS0zv2PzycjDDY57KcGKq6Ynj1/7b8NGp0VH0yU+EhAOgAJCqZtK5vihwaNVvR2WbrtrHaEMxr3+JMqlkaKej63/SvN92hUcO2HsVDAv0xtqbhCjC5OlXbaTu67Tj5odkJQVHbxHWAdug7kPCsc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775659018; c=relaxed/simple;
	bh=qT1zHZCSFMPJrwZKDQHbbpFFBhz3FsCccEZdVXIfmuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxJ7UKKj/E5zqbRi8VM/Er0CvxAifbUtVZvomXeyxqhpyC4/C9nuIceeKR5B7gvIRZgqLgTdOC2Yi94k0mH7AMD9RYDip2DErRNZIBOlgJCSVAF1A4EgqmjMM6WprPkYOh1bPyHTvhcBg2AMOaiY+27HPbEH6WwJHjg0oUyr7OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GqgwwfuS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rYVXSAWS; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqgwwfuS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rYVXSAWS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775659016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a7nrQttg0XaH4EfgeMJpijdBLoyZ1TdLNy6iZIsWY9k=;
	b=GqgwwfuS+zaBtvu0ePOvKT9twRSPq0OWkxmxr4nxhve/CEDmXSN4Mgd68SILkLqRqlc4QG
	CPnBhlQq3rs9BkklPaWij7Ht4Yfpx2GJiFDG72eAGZUCdUsloOUKfjnuoxISurAAeVdOi5
	2lrPq6OHktYoSwDshDvRJMPXn1Hj974=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-BJYrIsB7P4O-tIhgulbAcg-1; Wed, 08 Apr 2026 10:36:54 -0400
X-MC-Unique: BJYrIsB7P4O-tIhgulbAcg-1
X-Mimecast-MFC-AGG-ID: BJYrIsB7P4O-tIhgulbAcg_1775659014
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43cfb72377bso4280738f8f.2
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 07:36:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775659013; cv=none;
        d=google.com; s=arc-20240605;
        b=N1790/Bp0lgbsmvkYpQy25rORzZk+8MNlKp9IFyF8Ema43tS+FAFzARSrLKuDbjFNt
         m8tsrxx2jQefv9x+Y7OtiB1FJTw/D22phejWg7uApO64s0W+x62hGovtZ2BeFei65m+h
         G88AEjACzEd620NzMqXuJtMZrehwnMndJ/o+r1G/tYOreaGY3CqVFej78DF/chiW0ZyZ
         wbxmcegjXZT02RHmVkNs+2rgawcVYUXdDvI8rR991zHwUF8K4Ax6lbLKyCwxBFGfwpUw
         EQYTZLqIeDJyJo6Vd8awZBfP+hZJM7lIr60xDv98zbKkQ60pTBB5dtgzs4lXdsQJ8MCu
         GPHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a7nrQttg0XaH4EfgeMJpijdBLoyZ1TdLNy6iZIsWY9k=;
        fh=HMwOLwv6Al04GY8bVAzkZzxEmJulCUOjHFRTW6s/O/w=;
        b=KymdrTxPGL8eYecdhxNPX5KALTBp+CYJgFxd3h/DQq4m89iYoztAMDpGq4kDhpyCPf
         5m7c0q+Lutibvqx+1Sx2bYe1sJnoT/7cYQZAkJ1L74QOoCG41+z/m1/nE5oMgXmaSl9S
         GmSIbQDll0skdAcU5Vt/7HKxE6HyY5jeQ6uOUyhCfXY4TZ2sgZaZyZJgRj4SkPMva4Q3
         MnQYFt488dXev8JHDoeXanoGx0Lk2OFBKN6kTtiAfwToPdb2/TkIikHK/t10UtT6D2mS
         v851XeBsvyGHnPOLrgsu2mPkyme/8gnjU3SmZQPH9c3IiPWfOJXkWKFgpdQQ7VeWegv7
         UI4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775659013; x=1776263813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7nrQttg0XaH4EfgeMJpijdBLoyZ1TdLNy6iZIsWY9k=;
        b=rYVXSAWSh4L0928kkHyBwsKIfWxI3ErIlb1y1Xx9rwtlnbhFLOSC4HnEJuJTODNORZ
         caCp4R+IEuteQpTK+E5oosQGLzsPq9qRna8r876j1dlT5bT/ZlCJJTGDOD2xAef03fVo
         GzBJMK1qv9+lZ5N3A2gKBXzlenMUR5Um6hEwQCl7BSMJ+hfg4Nm2UG+uEkwWt06K6wdT
         Zb5LU1F2QsYom2U1Vo+mdiX6YonI30tunXbuezTx9Ih55BJhelPMGoxE77ePbaSHPVxQ
         ZgDd6JY2LoNuWDayFM+TF++klQr0uM4hPLsOYdM2b+gSXMWHjWB9OqUey3wowLCzlSCp
         u1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775659013; x=1776263813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a7nrQttg0XaH4EfgeMJpijdBLoyZ1TdLNy6iZIsWY9k=;
        b=Nsrz3vF7iy7GiYQMaGBRYa7XUpEY7tlu2NcuF/FCK7N1fadNNrL/OmZ0GfDTDnmA87
         M5yDQeh7EBYpOaIq8JsLHdjBenHtVyAOlcCfFAp0wgokPtbXbNm7G2x7DQ/ZiVJqGHeF
         kMw2d2INzBTXRyR2Zyz7ZDkBjjEEQo4lcnnx5cfns2Iaa2GOy4Nz6+lDjnLWiZmVQ0Wj
         GvuLahHGGHzc6aZj6FRSCnui7609bpFiSDyAImnYAMC1egHoC1DJxi5bqf1ccCw+uKH7
         vdBbgo2TW4NJ3pPUrZLv7JL3JH4z4Ay076oGe3nUkrSlZsOzocxjAAC6wqzDMfQrKmF2
         kU9A==
X-Forwarded-Encrypted: i=1; AJvYcCXzY5Ey7B4LYjyuGjxZq93pByY7PbCVp1LxbJwsQl+MvSGWxSkzmBhgogukVaMbNSJBCGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwidR/rEOijXEuR8ANZ2qWcgyOidApuaIWUpb1wMy+Vtc9AfZEv
	h/giy5gCDpqRWXNEv0NrQd+db1ccaNz3/6sZO1CsOcQyEZ+0AROUKqzMDIkCRGKeL/x0vtCxqwy
	1yqkHOcty/cHgKklJKNC7+5l/yUJqYGNtaZrykgwPUA0PUSPxngUITm+HGsjNxN2PQkn2ai3NnL
	UO5+kCxC2yns/ZqXih7wjsYmYfd1L1
X-Gm-Gg: AeBDieulEQv+CVJayqNPrDO12GLkLwdQASf7+3v3svTcgbnNg/2Ddt1wWYmSKAZO4AC
	ZtWzoWPr9Pf/cFVOnhlh6tXkv6ISZ8kl1p+e8Gt1P74dPgorG/F6QjFWuHSA9rjLNZa6I5B2WzT
	ob/JvpTcwfKsqppvvBS6pdEWAmd40tPK4khioVkITjZMtbqgvQnOd/Ri1sFku/aXgQOGT/B79iH
	JZ2qQyJbLMJy5/AQkv3gw3XRBUmeMySTIR0HcI8sJC6WFIf+klv3frssCwNmd5icuY7EV3Ab4Ss
	YT3J
X-Received: by 2002:a05:6000:230c:b0:43b:48d3:2a46 with SMTP id ffacd0b85a97d-43d292fc2bbmr31500618f8f.33.1775659013513;
        Wed, 08 Apr 2026 07:36:53 -0700 (PDT)
X-Received: by 2002:a05:6000:230c:b0:43b:48d3:2a46 with SMTP id
 ffacd0b85a97d-43d292fc2bbmr31500576f8f.33.1775659013061; Wed, 08 Apr 2026
 07:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407175934.1602711-1-pbonzini@redhat.com> <6569b8b8-7654-4dbe-a4a6-f1e565451672@linux.ibm.com>
In-Reply-To: <6569b8b8-7654-4dbe-a4a6-f1e565451672@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 8 Apr 2026 16:36:35 +0200
X-Gm-Features: AQROBzB5omoJWYrrMqaSBonwZlBQM8vJiaSjlVlseeyW58fQ54aszgrPriv5Sfk
Message-ID: <CABgObfbiNRfNGvhDFO=h-E27KONh80fkB1y1rOGpazTB2Eigzw@mail.gmail.com>
Subject: Re: [PATCH] VFIO: remove dead notifier code
To: Anthony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, alex@shazbot.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 4:35=E2=80=AFPM Anthony Krowiak <akrowiak@linux.ibm.=
com> wrote:
>
>
> >     open_device:
> > -    The vfio_ap driver uses this callback to register a
> > -    VFIO_GROUP_NOTIFY_SET_KVM notifier callback function for the matri=
x mdev
> > -    devices. The open_device callback is invoked by userspace to conne=
ct the
> > -    VFIO iommu group for the matrix mdev device to the MDEV bus. Acces=
s to the
> > -    KVM structure used to configure the KVM guest is provided via this=
 callback.
> > -    The KVM structure, is used to configure the guest's access to the =
AP matrix
> > -    defined via the vfio_ap mediated device's sysfs attribute files.
> > +    the open_device callback is invoked by userspace to connect the
>
> Capitalization:
> s/the open_device callback/The open device callback/
>
> > +    VFIO iommu group for the matrix mdev device to the MDEV bus.  The
> > +    callback retrieves the KVM structure used to configure the KVM gue=
st
> > +    and configures the guest's access to the AP matrix defined via the
> > +    vfio_ap mediated device's sysfs attribute files.
> >
> >     close_device:
> > -    unregisters the VFIO_GROUP_NOTIFY_SET_KVM notifier callback functi=
on for the
> > -    matrix mdev device and deconfigures the guest's AP matrix.
> > +    this callback deconfigures the guest's AP matrix.
>
> Capitalization:
> s/this callback/This callback/

Heh, I had to pick one or the other (close_device previously used
lowercase) and chose the wrong one. :)

Thanks for reviewing the s390 docs, I wasn't sure about the new text was en=
ough.

Paolo

