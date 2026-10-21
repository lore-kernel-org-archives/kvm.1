Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792605391;
	b=R0WBE4NqKe0ut69JfhPjO5xak+JHI3jK53ImOmXl29No1T0LfN7MF9LPiRrLjmsLhRij
	 t3w7Ojbzr5O81BdwgJBz5xJbFYPYofFoUnxtpAw+BCGtMW+QGrF73jQuEl9j1gQ5OqWc2
	 AlqHEFKDPuZpFnLXzbygr6L20faw4Hs6kiiHS4WLe+vy5IjS06LgyOORWRZRXchadSjlV
	 pyVD9B4KlT9p4syWIuXWds7FLyn1IcytB/ZzL1qbz2rbGVn4brl4E+oZfjxorm+gG0ZPv
	 1V4azFF93zB3wLxs7cCja+XdCDCtm0kqADLq+moQKMtGte2BrM6viwRH3HtEvBvqErg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=l/9Q6vwSpHzLOuQcu+iZE9ek6ulZ0fAfcC9lHWm1vuA=;
	b=DSSw2MDECvmf4aXwoWhBIYkRINV4DSyOe7VPzu0ImPdDyKhUh9fLG2w0164IZM6UPriR
	 oSJWYdv4SYIqzfl9+uovOyZht9o3xUHEfpX//JXXc2R/I7HzhVQeCkoFVHI/aoVsCXsHq
	 3Kbn6yQwUs1nBlXXbb/fXm2sKybF6JuCry7yEy5Lz5acXN7AwUAzxsJufVb82JPchOHJN
	 58rB/CPkSxf8415BxklYJHkTzYR4/HWblPkFvc6F4KeuJYEq6WYo97nXtLpkoudX0iij7
	 jFyDPWY45tIcDCq5Sn3sN+CNPeb++mTf7/UljIc6m1VRcigljR7TMtYgtnhi7mGHKVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=CsnNkHId;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344FD606A328
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 17:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 344FD606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=CsnNkHId
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b2232d8ef5so1510150a12.3
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 10:56:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792605389; cv=none;
        d=google.com; s=arc-20260327;
        b=O7NmXJtK1z3vDZk/efl9sRyn2tTg9T/ZK7i29QUn5d1363z+YE0sHtGoiBTzQnKjEp
         GP4LDdskl7zA7jqHlD/r5yiTmkMC31ZKpXkhFaZ+pIgLlhODmHX7txzD7LjsN9GzFAVz
         ellLoBet+tCY999AqLsTSyqNs0BIPtWwu+AY6WKrMOJzTHLzatSQBnYKb7X7rTFx7M2i
         mws45rsUI9uJ/j3Mntywi2oNexCbZoVplQ//nnED4BuEJLkN+F3XXwCK6r+wU7EC1UE3
         j15/aAzCISiXNOP53nD2WbqfqVwlUU1Wbnw73eEerQ9vEY8lFGSKoKwLjaIrkAVifdJ1
         wFfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l/9Q6vwSpHzLOuQcu+iZE9ek6ulZ0fAfcC9lHWm1vuA=;
        fh=sC8Et6z2DWBaHrUObZPG1bZ4VdctnELaEUp7+GPf+tk=;
        b=oESLoGvhg0gJScmOGRf2A/7rvsrdriKoRUU32AviONka0iesElda3n3R3g0Rm5IU+b
         uzZn4oGbxXcREclgzy+E6SS//eu6XSBaLYU0wI0sdJQasPViOTveRz8tjx/QkPkwuXTb
         1TsexF00E8qfOgIKa7y1/q7+yXJVhR0V6QI+jEkdyslXNtW9ntdmoIdWds/jKS2vkEUJ
         M0IBLRXCrz/CPzfedur6vluE2Azha0X0HK4cyWpZi7spIYsZ+f7S1TjvGI1vNL0NLCFg
         xI+kgRmJXOsLZdypWZ2X6TMkLLaUMoo08G2qOHGyTSqXvtPqdLYZarQM2xZkEAhBSx7a
         kzTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792605389; x=1793210189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l/9Q6vwSpHzLOuQcu+iZE9ek6ulZ0fAfcC9lHWm1vuA=;
        b=CsnNkHId/2HmaPxBHjb/0jR2Ogy9CW+152Se+WQyag2dh21j8P/RHssb1Z44QC5yWC
         C4QlKQrH5IzSaG/OPVbhWVM3PA/cIm1fOy/fqHgVzQMXB+wzQ3KobKxzNHWIF4yHaCSD
         txHLa8F1uvqOKW0HUcSBT/UKnibnqOmjYCzuBGkNyTsfn4IHOirM/RQrbSf1aiLT2X7E
         TgvGTfdyJp6KjZJ9KdiumiVokiBpI9M4awk2Pc8IDRALgaKADIzg57iXw0Hqhfl8ts2G
         zkyDtGt7WXsJ0Qmo6uDo8E2S2BXyQ30jWJlFRuBusxShLi3wKYksnzRG7ma3ngGkK7xJ
         oUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605389; x=1793210189;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l/9Q6vwSpHzLOuQcu+iZE9ek6ulZ0fAfcC9lHWm1vuA=;
        b=SyRahaZkXzO+zHhX/kZaUfDQAJqBfWPiH3/24w4RpKl0CYuluF+pDqH78rjZfR70wy
         u2mGdvDkes1IYQMRCztb3yhaDq1AWqw5H85y8kJ5BtzcZ580FuCVMdzpf+18G7U7lQPC
         73oJF+uVitKofHCxJ6jSCuIPuZGTtBCezmVGVifUortG07zxQq4XZgBnOAcnelbdBL8W
         JjOAY6GUhxz9dvoIkznfCXUBRrRIKtPAd89kjM7zxPrB+uBFg195oWmekC0fRWBoN5Bk
         UgRrYGwVp6oKDl3SGPk9qq7tvjgnmq5am0sCr1oVVtGaKeQkBV+7Yv0Cg+3we4GccxN6
         4w/g==
X-Forwarded-Encrypted: i=1; AKwUvBwcg/lbyN+acOkRk5RvkrUylXgJni2sY9NQh0wNGQtMhOC+6MoA9CeYoaaGAFofeq3W52I=@vger.kernel.org
X-Gm-Message-State: AFq9FYLt6u7vA8K3BU0rHt1c5gePNyE9AouwSFogbbznQwziRLPP6rzP
	WgLPhASmkRiaiFpOyBZqQhF4R+RdbggY/N/FDk5eQBZnaJstYAYEnzpmy/4DJVTdVBwIqA/+i13
	UxFzxBBoXtY2cpR7p603G3nvjMKmIFaxaJCr0C+h4Iw==
X-Gm-Gg: AYBFou1gvAykAQboL7rtP92NryYGKcL0kzlC+2RVDJgWoOKJAf8b2ffAsTDHo2mkk0T
	R4a1YGQx3iYHoawOXfnNZIZmfPrQryfcTfJl7zPPvHUhtWVi0tDX+OsWiyvNu0MVt31WVppSlZz
	XikLl+oWieRr7+uVoOA6Mh96Ny797OQ+oi1PbhrDlboFrhqP+eMjOEJSyMYCfRT9Fu43Z3qTfhR
	3JGUdLIZB7moi4+NQGuQkj5v8hJoULAt5+rp18i+igY4fJ1AfAtozmDsl3vf85X8Uf4531ozhTU
	CqkbRRoPYv+dXgibBDacFnXcwnwzB18BLz6vkCS+xFngq9+WWVD8s9DGSqVOWjU0dZYrUalwEwn
	8U/fJh1SgGcsdrJT4W6XNF/0+/M0gC1AX6M8bEqmu4ICpYmeawnOB3DC18TKukbpPhbo=
X-Received: by 2002:a05:6402:458e:b0:6ac:686f:91db with SMTP id
 4fb4d7f45d1cf-6b408e9f045mr1964734a12.11.1792605389455; Wed, 21 Oct 2026
 10:56:29 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com> <20261021174006.GU3008132@nvidia.com>
In-Reply-To: <20261021174006.GU3008132@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 13:55:52 -0400
X-Gm-Features: AclHuK-Q6MQhxMIMUURzzci_OOwzGik9EFivN3YqqlGA_5OHu0xT6GsF67-BzDw
Message-ID: <CA+CK2bDJzo44K0X-+5F77E9g2dmqKdwZvrUf-1SkC7ewrgEgzA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Tarun Sahu <tarunsahu@google.com>, Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	David Matlack <dmatlack@google.com>, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 1:40=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Oct 21, 2026 at 01:27:22PM -0400, Pasha Tatashin wrote:
> > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@google.c=
om> wrote:
> > >
> > > LUO and its file handlers validate handed-over state with monolithic
> > > compatibility strings ("luo-v5", "memfd-v2"). Any change to a seriali=
zed
> > > structure, even an optional additive one, must bump the string, which
> > > breaks live update between adjacent kernels. Replace the string in
> > > struct luo_ser with a feature header, so that the target kernel can
> > > accept or reject the source kernel state per feature.
> > >
> > > struct luo_feature_hdr is a fixed 128-byte header: the serialized
> >
> > This patch is all wrong; 128 bytes is far too large. For every _ser
> > struct, we only need 8 bytes instead.
> >
> > The first 4 bytes are the size, and the next 4 bytes are flags (i.e.,
> > 30 feature flags + 2 reserved bits for flags extension). The last two
> > bits of the flags indicate whether an extended flags field is present.
> > Each extended flags field is 8 bytes, and its last two bits indicate
> > that yet another extended flags field follows.
>
> I thought we agreed not to loose the string too, it was a tree
>  string -> feature flags -> individual values
>
> The string is the emergency if we really badly mess it up.

Yes, we'll still have the file-handlers/flbs compatibility strings.

>
> Jason
