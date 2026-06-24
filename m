Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EC61A6816
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782337677; cv=pass; b=ssK9uzWxIsXAzFEjd9VJYYpDh3dHby9thqpIF5OOS+OPISZW0Bo1Uhfs094BpZIeyIUYBvK1Lm8pE4Zdq7cXpp1/D4WrjI+a9fjDcX8wIJ6PkB3y8M2tNqJ0nqc7yIZnDMhyX8+njkLE47jI7Vs56NGq/7RyANbsfwfo7ShsMos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782337677; c=relaxed/simple;
	bh=hkFwlfmlGq5uiQhhguJIpFE+BzPicxluPWYKlmAeNw8=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOb3aVcD2jcWLEn1FSnrzKRy6qpXyf5O4J+9BmS8KJeboH+Z2pvyhcok8Tjr7GFXA/0zBMSSNHEy7QjLQTfA89YhUoKzsZThPdoMUM8qw5b062UrHrcu0Dh17vxSGf6AmDveZFV2OY5kA6z/ducJO0ieOHjXoDvCPylDiWOqmBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnCd1Qa5; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnCd1Qa5"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-807bf286000so15111247b3.0
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 14:47:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782337675; cv=none;
        d=google.com; s=arc-20240605;
        b=cTFnZZzmkcvEXTjsZiqAflX+UH8+SF/nQVxmgj7HjYCUoGimC4T448ZlNdOCFDFTcD
         CzdDkda9BYJNDDOZHhukSGQyD6IuSf2vNdALp/uYhclLEJwY6Wr9r/ofZjOr9u0prnb9
         LlybSMYFldM8jpKi5Wt56UqHAAx6Ko+uY7IP/WM0J6QuLcYAC54WZTULfUFYlPDOX3Ih
         JcClyngCEAGHnAJRfVP7GLMUmKM0BMjtXSv8KSFXQN2tDnliDM6cRNMTLVWsQOiuYOWY
         stWoP9i2UmEGxUckr/ay2JOMYBH2Q5U0S90OqWBFxRaiSecVuf31zH2pE0zv06UH1ZFn
         smog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=hkFwlfmlGq5uiQhhguJIpFE+BzPicxluPWYKlmAeNw8=;
        fh=NeD/spySzqDrhpYQV2U7bSTD2RFiRs4mxypZADhnZ7U=;
        b=AULgh1eXr9CWcCL08VoL30o7+IHojUA4fr1fzljVJtHxO3P3IUPQNk7IQ3ZYNQxE00
         m0pM+V8IFNzWWh3HVnodEEy2UgY9LzOw0268vCXerifiuNc3vg6W1/0hI6yVTH1dBfW/
         TM+dCXcg1Wo81uDOEUZAnwQtboESu4FHZMfXf1vumWOz4nroIM0niqpFVCUQ35YeQiBz
         TIUokQeVs5xBA3r8+XXDlRNrklfxZDRRz8XOwZmuzEl8T6uwDSaa3WfrLbz/AO884nJu
         /OsounvHJ7PLkl7sl4EIiNWtf2KmgQnJ8o81DKejboHKsME2kBoYDQxPWRDhiFBsBZQ1
         5Adw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782337675; x=1782942475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hkFwlfmlGq5uiQhhguJIpFE+BzPicxluPWYKlmAeNw8=;
        b=jnCd1Qa5U9pX1f6wh3ZWwbCacyNztSy7GGxq7n1htGWYI1K4CYLXRRU+jMJsYW9tZO
         BPRmkkgDieGH4dwLT/VLA0qS0v2utQ1pAp6RPn7cNQgSpOLFzIzVkB7mxicq3X7sr09n
         15hMBxQHuq4oKe5ZvjYi4NVM7Q2e1DKLc6zDOcdEfqsOSAXqLv1PT0eaVNpBJPKeENgf
         NLUkNGxObglxjF1aES0vCjDuX8FRFqlXQahrDtxcW2GpXmTH27xj5ecJx4LWv5h12sEJ
         FBtxc+tE1VjpeIRm26KE1fwUzaPFhKG/RAgrCVwLACDIco7mz0FV3RAKpr3ioFH9nMf6
         MXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782337675; x=1782942475;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkFwlfmlGq5uiQhhguJIpFE+BzPicxluPWYKlmAeNw8=;
        b=bq8hZ5mS7wqYyJ+SrKTT003ofelUFKbsp2vmdAandhwihdVeBO17SNxyi+kPBQaK7u
         JpZtZy2sD4OO5LoyhGhmsghpodm2HFHm10HGXYgkyjNmsu26B8wkPf2NJ0KtE6iFnIap
         os8GxmdIIUSInSQRFzmALTkKek4w2QdtPnBJsdOKWEDALLWKouO2+Nosf418x4bZWLhw
         FrzC/Vz8PUXYIPVFHkx9fU9BQNTEI6OiqkPm+LdkyiT1ivBmfXi5gG1J056ogOxBrJMm
         xagQ6JXNa7RTpXn4xXzWaawE9rzJQ8ppwTKfM8dxFWO6k/5qWzxEu1dPKrFx9lurUX2M
         DhqA==
X-Forwarded-Encrypted: i=1; AHgh+Rq4acBQwul+kuosoffXZWgx/5Xibsm1qYkmO1ddkWmY0i7YmFbz2ooAk1RaFqA8/AmJMdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx03yZEQQs1Zj40ag0HkH2pwjhdudNsIeguwikLE70El1UH+dYH
	QiVe9TT+jF5jVGIEGm5lQODGtLklMum+ab3W7J11TRRAxA1d3cSQuqZojUD0nZAFLpgNGU7sIVh
	MEyumrEhOAn2C0i2WttUkXo75LJsMQIU=
X-Gm-Gg: AfdE7cl2RtAPBwnI6o3FF5wcVvHnz8A79h6R7PociDpW9QC6qWd6mCzy4lwSSjjxmgv
	2w+HwUKHQqA4v9TDqew+GjBtngWal0GuchWBDKeRfZAw0Ln+mrV9rP9q8FkYsgVBW7nYoNCg3vH
	nzGjU7C6bNhZQ0o91MS5LuA0scPGn4pSnVy+FB+cMRWexbNFTJan1XNVzFzIX+869PVzsjP8xO8
	xu6fwEhQvqY3D2QaTj3W2ss/QhEGG0kuqJUACUYtXcYcLI4rNkn0E+iqJVLpguqquqNblDq
X-Received: by 2002:a05:690c:628a:b0:7cf:d242:d966 with SMTP id
 00721157ae682-80a63f4560bmr669177b3.15.1782337674985; Wed, 24 Jun 2026
 14:47:54 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 24 Jun 2026 14:47:53 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 24 Jun 2026 14:47:53 -0700
In-Reply-To: <20260624153850-mutt-send-email-mst@kernel.org>
References: <20260624190653.2893-1-alhouseenyousef@gmail.com> <20260624153850-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Wed, 24 Jun 2026 14:47:53 -0700
X-Gm-Features: AVVi8CeynxX2_AcSDWHorX_h258yRsucuQ_SkLNN6wE5TmhSJnB8IHSA5IRr3Og
Message-ID: <CAMuQ4bWKsMA_88Qt-0azvUckrKkcY87i0PZFmJ9Lozo-OsXtrw@mail.gmail.com>
Subject: Re: [PATCH] vhost/vdpa: reject overflowing PA map page counts
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 24, 2026 at 01:53:38PM -0400, Michael S. Tsirkin wrote:
> You should add "on 32 bit systems" - I do not see how it can
> overflow on 64 bit.

Right, the overflow I was trying to cover is the unsigned long
page-count calculation on 32-bit systems, where size can be wider than
unsigned long and the page offset is added before PFN_UP(). I should
have made that scope explicit in the changelog.

> I don't see how this can happen at all - pinned_vm is in units of pages.

Agreed, that part is not needed for this fix. I'll drop the memlock
check change and send a v2 with the changelog clarified to say this is
for 32-bit systems.

Thanks,
Yousef


On Wed, 24 Jun 2026 15:53:38 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Wed, Jun 24, 2026 at 09:06:53PM +0200, Yousef Alhouseen wrote:
> > vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
> > size before computing the number of pages to pin. If that addition wraps,
> > the code can pin and map fewer pages than the requested IOTLB range.
> >
> > Reject sizes that overflow the page-count calculation.
>
> You should add "on 32 bit systems" - I do not see how it can
> overflow on 64 bit.
>
> > Also make the
> > memlock check subtraction-based so a large page count cannot wrap the
> > pinned page total.
>
> I don't see how this can happen at all - pinned_vm is in units of pages.
>
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> > ---
> > drivers/vhost/vdpa.c | 12 ++++++++++--
> > 1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index ac55275fa..090cb8693 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -1102,6 +1102,8 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
> > unsigned int gup_flags = FOLL_LONGTERM;
> > unsigned long npages, cur_base, map_pfn, last_pfn = 0;
> > unsigned long lock_limit, sz2pin, nchunks, i;
> > + unsigned long page_offset;
> > + u64 pinned_vm;
> > u64 start = iova;
> > long pinned;
> > int ret = 0;
> > @@ -1114,7 +1116,12 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
> > if (perm & VHOST_ACCESS_WO)
> > gup_flags |= FOLL_WRITE;
> >
> > - npages = PFN_UP(size + (iova & ~PAGE_MASK));
> > + page_offset = iova & ~PAGE_MASK;
> > + if (size > ULONG_MAX - page_offset) {
> > + ret = -EINVAL;
> > + goto free;
> > + }
> > + npages = PFN_UP(size + page_offset);
> > if (!npages) {
> > ret = -EINVAL;
> > goto free;
> > @@ -1123,7 +1130,8 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
> > mmap_read_lock(dev->mm);
> >
> > lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
> > - if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
> > + pinned_vm = atomic64_read(&dev->mm->pinned_vm);
> > + if (npages > lock_limit || pinned_vm > lock_limit - npages) {
> > ret = -ENOMEM;
> > goto unlock;
> > }
> > --
> > 2.54.0
