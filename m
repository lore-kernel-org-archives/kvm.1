Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B1F20F08C
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 00:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362047; cv=pass; b=hSU+s47uxJPc/WJ7j01fBXaOQhZ07UHYA9c24DXs7CxpXfESbN93FPqQVp43JjVb+si5qKNWHuxyTpeIGPtNL+7n5g5NN+RWruT1pfHcAwD6+pFTwefS9r048hpNzRr/bo9/ca6G+meOwPHu7fJ7EXgeDaMNaVFvfb9Ln7uzfw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362047; c=relaxed/simple;
	bh=P9DYNvw0pXgKNQlqCuTgX5BsLWxpM/GHGwCmn4gqBFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTjqacm/ymuBgAO+BWQuszGLxjvTpW0IrzU2hpYLvzkFe0+oJfNdM48shnW64K4nhXWoEZDfRyLAxIm9SxE3xamfxwaMnx094c5WkoSps/hGtaQBNGsSLWw+RHkzU1sKXvo00SIs8L3UilKVRlF4uFGijWTP55ypxFzOrE6e/eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Vo4xbcbG; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Vo4xbcbG"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-661cfb9f3aaso2333947a12.2
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 17:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773362044; cv=none;
        d=google.com; s=arc-20240605;
        b=bVoHIf+p2UDDior3gtOlSUVW1YcjRB26L+5e3+cKla2Y9tFGdBsKtAauX9g4Pxfoj1
         M9m6f8vISwsIfA1LIZHKYCnBOh6CQoPSWuUPIAOxZOg7jNTDZC/UkK5aWBly+FmSy93P
         6XZ+rJELCh8jN5Co6jTALwKqYxHcgVR3o7iYfibhtQUqvIOriroSsIHSuJFqylgpSPmf
         85D1+uydCdpSDZkafrStb+AXn/3ucNwyYRkU1k/LyT+8TpAJFknQm2NDbmGdNucFu+S1
         qPqHA9qL4rEDKu5c7ZMDi9ky0hehVgRt+Dfpr+fkxefNsXVQKY1ZLYd4EBBQvSIThH7a
         4FPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pnJL3Iw0wwI9nfGsL4UNGadpWjx4M7Li4XWaHu9e8Ms=;
        fh=Hw7au8Ww+4ECf5lcr7xkU5393y/I0T5TOgs2BHwdbiA=;
        b=U/tPlmiaDHLUDnwcw37QaPcDcifKgChuirUchaDt8dE/pK0xmZtxRP64TOcJqL5Atw
         SJO12j1NtxgpB31TIfgpSPkckCFoSAb/TL0hyaSzfXEb6xJVFP0q3IPrHjO9mHMLFlOw
         rEJHKTpHjdxfFkLPMhInA9CKj12RqVKE1cVv1vNpHinC+YCM0A3aOw7b1wcboq9ri1DR
         iJVHlru3G2NlUUMuGAQhs5BIPzk+qzdkcWe37j5X5SEsClS4PutESQ8rAh1+VCpv4oso
         4Q/XEsKIxppnLWufdm0l8c5SjRWL4y4XvyNeuBhUJExA48fiWWcxRCZL/29F3D+LuTx1
         63+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1773362044; x=1773966844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnJL3Iw0wwI9nfGsL4UNGadpWjx4M7Li4XWaHu9e8Ms=;
        b=Vo4xbcbGVbDxB47s28JvwRyPuGtfhUdWydhmCZfZFIXwIoa4Nolcq1178Ix2aIR7FB
         r8v2I8q08uXsv6RRbkQyx/J8IkETMYbND4jJfuRMx+DOsB9K/PAnXSOpk/xGe4+FFVnY
         NPlR4d3w/YeSU9Y8BQRRUEGhqf6rDJX+b/7EAqF0bpeIputpz3HhnhP9env9yyvlcV8M
         6CF60BZb/c/ASGteI40pQ2Z/NPISEnB+B2jy+zyZAowFpJq3PvcpHATD/DnA6DihYKpc
         S1c3ryc+sbCygNaePFMbd3OB4TYVGxuhDi4cyqcpW1WLnQsu9ucW9sm5xTK7TLg7cS3e
         p8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773362044; x=1773966844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pnJL3Iw0wwI9nfGsL4UNGadpWjx4M7Li4XWaHu9e8Ms=;
        b=AitYGqiOQwz5pMwDAEmNQEoDOLpWClOeu567c8ZDHuNUqeH5A/m+ZdplZHx6F2vVtz
         UnQPaN76qQsz3VAWdJll+eS6tqwgMtx9bWaLwYxj0gsq57B4cwimdOOSaQj0QNVbC6bC
         xVBXwogw4btZkldMy/HFYX7J5WkIq4F8RsPSsqHAsQ613obY0+k5LviOCQwY21R5j28+
         tFCBTsMuVVF00/v8My6TBBHHl31RSPEDd5Oaw8JL7a//K5O1AlQeZVQCHoHPGniubXgd
         xj4iX1f1QEutG9CrJbB86Nyo/W3zO5I7ZkQFkBJXZDipcgTbqqQNOo+MnpycLDheqU6y
         M+3A==
X-Forwarded-Encrypted: i=1; AJvYcCVNftiBtfcCzO7GzUNeHG2S5gQqiSxehFWRG7gUycAu6Xw/sZW7oDt/kYfSX8wN+rvGjN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx69C48A5bxoTbBcKif9gOs6r6hkwgS+w6lmg2tQ0gY1wMRygR/
	zmArhzcumTkjNDzcLYAPnINhmJPq9zbxe6pjK16uEd2fy9yUtWuFf/5EZmtFgVBk4lXNN8uHMnH
	Zmtp4IQevMafAF9vFJt+zVc/E5kyR3lk1aZ1N93UHkg==
X-Gm-Gg: ATEYQzzhBqS5F5L6B3Drf5lk0AoVfSVuRbIIjL2P3HIcBQbRajCyKJAhxd6M/6SY3DK
	/abCCCXPLd0srDBgty2RxkewvsuUK8Sn9qIFKpC7vyj9SKa0qzsRcvWv0M6OXi3AZcxTrEE7gV0
	MtNxtrm+a4JTf149IbJsGlSYg+GnOfn7jcfu2tOUKoVk2qfb5IAexSDx4l3Q+bruQhSQqLeTGRu
	/CRbYN8e89Lz1jF/pAMBI28/5SACHIQTfDazwihDRsbc+5pdYAkLtD9KTpk7W732STttUUtwsf3
	l3tWyohiVTrqGB5+i2teKg5mk2BD2PWxMtUHRw==
X-Received: by 2002:a05:6402:3486:b0:662:e094:8dcd with SMTP id
 4fb4d7f45d1cf-663bb3d3be3mr643429a12.27.1773362043907; Thu, 12 Mar 2026
 17:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-8-dmatlack@google.com>
 <20260226160353.6f3371bc@shazbot.org> <20260303210733.GG972761@nvidia.com>
In-Reply-To: <20260303210733.GG972761@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 12 Mar 2026 20:33:27 -0400
X-Gm-Features: AaiRm50W9P4A7h3ayFJS5r_ZVIe8OM2EYEDEiGqBav5AUONhmByKJOVge3skGH0
Message-ID: <CA+CK2bDADhFcMVGoJew9RoJ-DsVhYhiZJGJVwfzTBZdGX++8Ng@mail.gmail.com>
Subject: Re: [PATCH v2 07/22] vfio/pci: Notify PCI subsystem about devices
 preserved across Live Update
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 4:07=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Thu, Feb 26, 2026 at 04:03:53PM -0700, Alex Williamson wrote:
> > > @@ -203,5 +225,6 @@ void vfio_pci_liveupdate_cleanup(void)
> > >     if (!liveupdate_enabled())
> > >             return;
> > >
> > > +   WARN_ON_ONCE(pci_liveupdate_unregister_fh(&vfio_pci_liveupdate_fh=
));
> >
> > This is propagation of a poor API choice in liveupdate, the unregister
> > should return void, it shouldn't be allowed to fail, IMO.  Thanks,
>
> +1
>
> "destroy" functions that fail are evil. :)

Generally, I agree that unregister, free, or destroy functions
shouldn't return errors. However, this situation is tricky because the
state is controlled by user space. The only relavent scenario where
this function fails is:

"-EBUSY if the live update session is active and cannot be quiesced."

If there are active sessions (incoming or outgoing) with preserved
data, how can we safely unregister while they are in-flight? It is a
rare condition, but since the user can cause it, they need to be
notified that unloading the module right now is not a good idea.

Pasha

>
> Jason
