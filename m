Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981D039EF0F
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370024; cv=pass; b=K8SmGWC9ii3Wdu4piB3JjgHTZ19Ninmrq4Tfp4RcNxW2kchQtM0IK5FsNK/AhtPqBBw4ClS0ta+hd369FcHySrf45RoUWvZWXdEMezLljItRT9vdyzwX2OObhtFwMRlWJJn0yhzj9o3phQHWhA7TR7Oph5HWpYCyKaE8ZTHguCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370024; c=relaxed/simple;
	bh=KyZccWfRZPRCXyH3JPYtLHqoTnA1c/Yv1X7rEaPg17A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scG0rkuU5+7Ug5NTM4GVxeubutWP2pljURM9I2UjFwozXV4Rp3RHamQuGow6l2fY0r1fClpfNODJcEbUU9wx8Un+zik5+8g3vkFH7lRFgtYUGwujAFafOuEIUZKhWEJOJh8N1bW7ufq1umifRIlu2RZVcc5QlmLaKhbql0cGhwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HW6Q9NWL; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HW6Q9NWL"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a12c310e8aso4294784e87.3
        for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 09:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774370021; cv=none;
        d=google.com; s=arc-20240605;
        b=BrwgDDdD6PftMEaPE2a3nTqnaUlVc/rZ5DeEg/bRLX92LiJaQc8Rj02i77jaIcFwnN
         nvY5vpq6iusHHG8vyPyX24uG6hIZ5BIpdAyFVBUI8z3FKbe5OM+X1DGT+oBWAej9EJiv
         zFwRLwHcfEuLDrQ8kmBznmjngkyKLoKPELtt7uOg2sYb6ha4/GZ4ALGTEE26RoxlPljE
         ZWX8mk5OUT4QP6EImlU4A6jZnbH9zgj43g4d4tXBqpC/Vo0kqi4K308is0aAcefPmPV6
         JUCKAbhTIhomdIQitR2IJpu372UjZ1dXrZOTCLca2UItnaeTrqNzS/omWD5LDfSmfyJT
         YHJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f++PU3wwkpbB0N6cii11zfED2xylkHlgqhKc/U2ncVo=;
        fh=o+CJUWdegYtqJ/5fGFAuxmEv/Q9MzhirGss4w5wSi6M=;
        b=KMsPoX392yVmNhW6p1k7UF+CH1lCJ+edLXJ+F0CcQnkR+qmTfh/XiR6/dliIDeqqgX
         oexKdSMoBtuNNFPKcD7P8y1K4iamUkjZZ8RlC25plLe1SsqqtkobRzPg0tj9HfCj5kEG
         DBJzoZqaatMZ/V9d10ZlCBYvVIpG65GnScb5+BFi2U4nQHqMSJj07GzwxCJeN6xDPsb1
         M4cNre62hnlRH9L6ZKE6MyLSyRukGCi9GaYja3fzs8YaJKxTJ8ipUmF1z4NvQNzsG3tX
         pn1YY6yPNlmU5S8pvbqjY4GGpj+/zxQCD0lBCSKMSJ2zOdTXdjJ+o7z5iWLBPatrpv8N
         nfSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774370021; x=1774974821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f++PU3wwkpbB0N6cii11zfED2xylkHlgqhKc/U2ncVo=;
        b=HW6Q9NWLycxYs8C8OOQKDxwRZAuJuQI9wdKwP6+z6AcgPywU01ml6PpY55p34Zdi1z
         xwwbe9uS568Mz3uM+ZUTpdl4x8sIZV3+5Xq0wiiZtI5mlflMpQLOP4d7CtoB6BPuukiU
         fZxn4j+WFmsZRFNUGas7J47gd9YQNXgYlZ97JH6kk3lVfdGiEiH4CygTGrkkB/ngLfRH
         q7muSWLsaGO2EqKJDYVHsVSl52GjCMhUbRNY2Xbd1qDKLL8/vESy4wESEkqSxtf5oL3w
         ibHgdDgJWGH8NY7mxCGKFzII/YX2lS3BAQFV/j9ZoJKuXTnRttyweZrCBuf7uekiLjUm
         FIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774370021; x=1774974821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f++PU3wwkpbB0N6cii11zfED2xylkHlgqhKc/U2ncVo=;
        b=FXW/I1Q6u34GOq0Y/XbXbOwqL4l6hlTfX+3Pv8YTSfyI+X0dQu+XyO3aGb0hT9KmlZ
         wchgPUbZZkLGgZr8NZ0YXiVryjOVwWzBEl6ErQzpoYYp2+e4Gspjk9GNkYwDpiiE9XjV
         ILNcVIwyZN9Fyk+pXScpDH+v2d76jnO0/8MzHGBithbiYCzS4EOd/F4PZv5oeRmnbd9C
         mjTCjhufNvTgLn9QelWh/EFumqw4+DiaiViiJ32hHOzi9d4Pa1aNKhTPes0HHaUFmou9
         uKNPAI17bZoYglHthcqdzW80MvMmJPgDl7Az5k/Gy57bzIkJlWoygDyU9xeRxsoaB2gC
         rzjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwfL9qzqTMRg8gkmh2DHJQ820YZ1QRgpB70sEYOPpMR1rwIyvg4UAQsUrwOxNnTUcBdaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwILW+Ws3E56+v+rQZsOEaCnJ5TXzIud3+x1bHMjWAKIQjzl24b
	cIxRKKtVLrhSTb4+7qhlmoZtRjaRA9Q1PZ0HCPgA4pi2TXjGThgoyObKqJaeca0ojYbasUycZwG
	6Pe1mrWVHslbEpm2FIVhAWJ6WSiLwnYkvPNujc4te
X-Gm-Gg: ATEYQzzTDGKBdJz4rpr0s8utGYWTVVRBpyXlK2KPeq4iz5E+eCaZfMhWh9HlF4YcpXs
	QwpAYsxAWsrhFkuS7CbpnDbJfeYF9Iji7fjjS5SkiyQ5ylJgTBM4jfBSt/ufecLoM0vgrQuRc28
	MMs3YYWorAQV+mxtHmgfP2zEzRzljqnfERf1E7RzH770n0VO9ysaEzBRvHeuQe1madMD1BG9Ivh
	fFn7KN4SL8clxZjFBGkEhNY26HarUy1sILTmkINkVdvVYuHF1cl9PWfMzFceD+1ICZUZiIGwq4G
	6vxJbeEU
X-Received: by 2002:a05:6512:3044:b0:5a1:1899:a0cb with SMTP id
 2adb3069b0e04-5a29b9a1efbmr55664e87.34.1774370018671; Tue, 24 Mar 2026
 09:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com> <20260323235817.1960573-7-dmatlack@google.com>
 <0d2eedec-01c1-41c9-bc74-0133ae6ebb04@intel.com>
In-Reply-To: <0d2eedec-01c1-41c9-bc74-0133ae6ebb04@intel.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 24 Mar 2026 09:33:10 -0700
X-Gm-Features: AaiRm530aoKtDDdSXYb9CaNnVHDZa0HeKfsko4zWVykFU0w66CUzojlEOk9szPI
Message-ID: <CALzav=d65Z1Va14rmoRcx5WrK1GfRvuHmrqK16wJJeTiq28eCA@mail.gmail.com>
Subject: Re: [PATCH v3 06/24] vfio/pci: Register a file handler with Live
 Update Orchestrator
To: Yi Liu <yi.l.liu@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Rientjes <rientjes@google.com>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Li RongQing <lirongqing@baidu.com>, 
	Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 6:00=E2=80=AFAM Yi Liu <yi.l.liu@intel.com> wrote:
> On 3/24/26 07:57, David Matlack wrote:

> > --- a/drivers/vfio/pci/vfio_pci.c
> > +++ b/drivers/vfio/pci/vfio_pci.c
> > @@ -170,6 +170,7 @@ static int vfio_pci_probe(struct pci_dev *pdev, con=
st struct pci_device_id *id)
> >       ret =3D vfio_pci_core_register_device(vdev);
> >       if (ret)
> >               goto out_put_vdev;
> > +
>
> a meaningless line here.

Will fix in v4, thanks.

> > --- /dev/null
> > +++ b/include/linux/kho/abi/vfio_pci.h
> > @@ -0,0 +1,28 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * Copyright (c) 2025, Google LLC.
>
> would be nice to update 2025 to 2026 now. :)

Oops, missed this one, thanks. Will fix in v4.
