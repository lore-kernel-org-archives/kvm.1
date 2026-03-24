Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0542389DF0
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368001; cv=pass; b=A6AnsBvqturGw7xBr73qUVJTQPfYnKrazxuHg8mP+XlvCzuCIOTGehJnijlsIQPat3u2j3xKOceyu7erASA3btyeKCQbaTr806nJg1E730XMfF1bq65xjM50PEhlpG0tC9vJsDovRgwzeqijOBNPhM+F6mpXE+gJA0mG7+EiMbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368001; c=relaxed/simple;
	bh=rpMp3hiozZmCIXMf9wbrKA0CspmZNmRPkIjUDgHwedg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ew+MuxB5krUVCCgJlwaYft/iH0g9V/hHjmYLYPrQz5jsw4oeTxnb7egV8wYboZB646ts/qM60yUD9urjLbBc6YOGlNu89rCHHgH2cBgHFYNP0ibXpak3rZC8py5Omtm0pIkKQN2C+9HR56T+0oW1gLWk44FB3p7kzeBu2/Syk6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ek/38mM+; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ek/38mM+"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50b6c45781aso832631cf.0
        for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 08:59:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774367999; cv=none;
        d=google.com; s=arc-20240605;
        b=Fkk72eFPSTY0uQT7cZu5n1d0kgrhH0YySB6Le63ziGqw+7fJkxanwVvon6wl20WxpE
         4prXcQFkbNk8Afo3JSR3MkGzB/3FL+NJ2K+DojheggN7DdBHRL40O3ENgmpYOsSQScWX
         pqEf1OQY/1MxEHndJHmO8jQs/eb/EaE2HxwY1DGBfuozopbihZIR13SA8foJs/OLWDDn
         wKNLuqDYwPsilW2VQdx9SiMpvWNalXvIyH0/t3fscTORHMykuzRz2DsyK1KcqzWRqQlX
         T89ahcUgZSteGEFy9xqgMZ8w9GP3gRvWwHSStR3awCkTZJrg7/Rem2A4r2KOaS6Tqn75
         5ohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XLrSVgO5Jwz0u6hqz5pvyqn1EORmtlk3PJkOIiSuuek=;
        fh=bxsefr91ei6tKWAKQAtq9+KoDuwlXZAoB2gTCumnYjg=;
        b=TJ6bMCSGAy7Ra5L1zv/WtfsWzowKTsDOKJrFxxiUEhQNo9KNf4oMI83FqgtBeYTad+
         8a5zbP44k5IcHpkamTbC+tiW8v+SX6APJfwCSopaku6g8LEPnImD9onuFeJTgDBfxewP
         asM1K9UHySU/Zjz+ZY4bHpXvaIwfug/JehKMGDUwhbkNkPMvJhdrtSdXkYUITtaxZe3U
         30pUKvk4lQMyyefDxDDEYufkVQe4btNC+Hd12pTkV1ENnpTOyATXYDUZjyllA1kxEzzQ
         FGkqYLvfzXCbB3f+DNB6mscEBmbeOtV45JcCZ5m0Na3kgggAc/ogrdyxsPC0ScJRCTlJ
         u89w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774367999; x=1774972799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLrSVgO5Jwz0u6hqz5pvyqn1EORmtlk3PJkOIiSuuek=;
        b=Ek/38mM+cJ0KdU/nk2xFYU80ACjSZSamxiefjc/vE+0kySoYd3/CuA1lY+3hR4dXMc
         kTCMLSo4CwMDc9UchmC/vB+Ii08w68Vcu16LIsle3qfMArrLE+N1LBrFSkiZjRBjSSZ9
         IzJXc46UMc+Vu/rtknxxQHzbFgxbZ6PCgEoypXf+u/yYGMJJs48Ux/UcENlopKI6D84v
         bm7qmRKbwUCM3drLlifA967WhfU/uHGfu91kuoEubTjVS8Vk5eXBuVwvNrwGu1tSxR9l
         veXNHcsBRJhA5Z43mfuUU2CTQj1asP1nERjNR/gY1igzoyqv4VRKmKKFSTDw+DANsK6k
         ACKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774367999; x=1774972799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XLrSVgO5Jwz0u6hqz5pvyqn1EORmtlk3PJkOIiSuuek=;
        b=o0y4PbgUHyTme61YtCV1VHvgb/W88k+Us2HM8KRam3Co8xfEONTFJ4k5EsC3ErQ4nI
         gRbLFbLRFS6D33DQ+hEwX3jAIusNrP7/7y59PS+4iPmQxsGqqM7tzhaq+OIlOqWgQoQW
         nqK+KFsiwz1uU+T0HTK9w87gQtg8GVAXCN2+vrhvr/kByap7zMugBXkO6un/fe5SF3VU
         6p/njgEtRdfH/MBUHR4QXlEjXmVqByUbI2Z7BJa3XFn2YitgpB2oMG7e+gpscOaqgDaS
         rvoyIt/95SNRq26M4qlDlGdioVASft/0+0pE34hruGqsBnWNqGy0bgLTZEDybve39kjk
         uplA==
X-Forwarded-Encrypted: i=1; AJvYcCV/J6Spn1u/lxT0uTPYdd1NdiJg6WMZJ+qMhsFKbaECNqu176txack1Gh/nRvudD0w3A5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYHGU36M2dfTYmCKX4zKvHNF6hIgnTIPoUQ5tjWuIlje8OPkSe
	DhcTvdSVciI6gpT5/gFzAOH/9h3EvG4Jc2hwxdiRmLEvvlbbFUax0kjFrWeR2kOB3obrj8Na96z
	DL5gHQr35TBymHHjWVDnbNoKKWwoi6Ff0ux69TFxu
X-Gm-Gg: ATEYQzymH1A/3/f5HmDHi9OqCvRAvvq6dSDs1uiothazeDwoB2HKutL6D74EdkmdEVj
	0bDJ8R8gh4rPuc87NDjIN5nc93aIbusWNb3IO2FbtAPn+3JgR2cWpdG2lbrOexhGkkGcnQNpHzv
	BtQLKIFz+R6YW6ZGEgYU+uaIZTez+pRgl0pIt5EohUqLjSnjB9G0ikZ2zOiNe8K4VRQmCM2cbwY
	2dBKGnbeM/76L1jaQ78V/ZoocENvUYMumTWPOvRmBibtToZ85pkp3ubpqFwQiHd7DTfffgOnYiG
	T8uHTcapoAsExEOA/4+6OpMEGaF0CmV77Zy7Og==
X-Received: by 2002:a05:622a:8d15:b0:509:1eca:6d24 with SMTP id
 d75a77b69052e-50b6fab570emr14738871cf.2.1774367998125; Tue, 24 Mar 2026
 08:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322054309.898214-1-surenb@google.com> <20260322091723.dbc1a8e45f4412fca43ba510@linux-foundation.org>
 <CAJuCfpGEA17hB4BMdr5a7=NxfeF1RUt0q=_w2WieVv0XoN24Gg@mail.gmail.com>
In-Reply-To: <CAJuCfpGEA17hB4BMdr5a7=NxfeF1RUt0q=_w2WieVv0XoN24Gg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 24 Mar 2026 08:59:47 -0700
X-Gm-Features: AQROBzAMqgNkN_nl_EndICe5F5XJG6Br11eHuUlOIjfDgcmYOvJ6ZgT0J1pHfxM
Message-ID: <CAJuCfpHQ6ru79hjnRnz6vpb2-Rjff8QsM9d_4g9jd+_jb9-qvw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Use killable vma write locking in most places
To: Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	Roman Gushchin <kfree@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 9:29=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Sun, Mar 22, 2026 at 9:17=E2=80=AFAM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Sat, 21 Mar 2026 22:43:04 -0700 Suren Baghdasaryan <surenb@google.co=
m> wrote:
> >
> > > Now that we have vma_start_write_killable() we can replace most of th=
e
> > > vma_start_write() calls with it, improving reaction time to the kill
> > > signal.
> >
> > Thanks.  Sashiko review raised a few possible issues:
> >         https://sashiko.dev/#/patchset/20260322054309.898214-1-surenb@g=
oogle.com
>
> Thanks! This Sashiko dude is good :)

Interestingly Sashiko had one false flag: "Does this code leave
mm->locked_vm permanently corrupted if vma_start_write_killable()
fails?"

In mlock_fixup() the path that we call vma_start_write_killable()
happens only if both new_vma_flags and old_vma_flags have their
VMA_LOCKED_BIT set. In such case nr_pages is 0, so "mm->locked_vm +=3D
nr_pages;" does not change the value of mm->locked_vm and we are fine.
Perhaps this can be used to improve the model?

CC'ing Roman.
