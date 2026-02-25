Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B54538756B
	for <kvm@vger.kernel.org>; Wed, 25 Feb 2026 23:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772063703; cv=pass; b=gnXf9XTP+iNiRVWybUDSY2ufSGH6m3Goi4Fo8EyFTlaT+pFH+4NPqaWoP4Arl2vPoXHRSuYqtLDjfG7uaPaZAucDkuhFiMLNUtFF/VZ9J62XRAbPelsPZHKywnsResDcA9IyQzXmFx5EWHlb7FTkwbX6gMuyurJircqC/0vvnxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772063703; c=relaxed/simple;
	bh=cHKbWLM0axLoVNaLpqGFg3zanhbcwqXxf0qoCpGOoI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bS7UXj1JkYyR+fHZjw4XLgBtOnVaSZzdfMiKG20X7rauXeHalpqvLA+4fsqjdP3rWudmQz476DxiSlDVEqHBN4pyKac8IH5+KUNXzdwYqTE2NCZzzskQMDRbILI4QX+omiBksznqFFfBKqHcMF6CaoFotHlF2GViX8OR8fMiLE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=woN/zIFu; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="woN/zIFu"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506a355aedfso157121cf.0
        for <kvm@vger.kernel.org>; Wed, 25 Feb 2026 15:55:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772063700; cv=none;
        d=google.com; s=arc-20240605;
        b=PHkDi+1WXXLKD/gi7eG3a1nOU3Jz+XDjKxycyaHhOTBylwysDvkCnCAAHuhsaNLZ4I
         o5sVYqXBVS2E0i23V2ve7c3jFFdg3q8fUzv6SMUdG0pspf/l9AkIpKSQUi4C42tPiUst
         dtoYEJfxZUge+IMvxkdyqgI7Ee6ofZ+rrCP+p27B+HZUnWPoiXXXMRoGXNfJBpd5QDQ6
         nOCLWX7x3hZfb9yOYAa5UU7wCysb50nCYKitBnFTkpsS+8wzz5yYVhL3s+PCED4g1w66
         d2M9BjK9dg2wuAAiMpStI4Y7FPLt6Xl9UYnfG6fAbXT4J7aOFJ5ydo9ylRa5Xk3bNbg7
         UhSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/+d/kouLLf9iKHdyjkzWOU+gVjFz9R5tJbv1KqoUtQs=;
        fh=dQF0U3t7g+mkUvm1d9Y6WJlehyun5Xvlw+6yGEdu7uE=;
        b=TVxEit7vpHrjmnUA4O7qpYJK1pSgmLCwFPXrn5vE9b5ZT1/zov9YNimkT+4y6qjiAL
         IQNhUYgXNixSKRuBMrEn9xn7+f/F5nUjvsDYVMT7DndvpnbZazpHtcmC+hDSL8ahW79X
         fK7muECetlmOob7dtbZBft5ainRV/RmJ+UDssM0us6La3p2xva+MDtymLc2wj3L81T4d
         lH8Pkepzj/J/7h0KL9rJAq6k4zZHdQHUjrk2vxqUYpvUS7HO7aL04SPDD+0bwTUSKl/5
         eATNI9eLWMHOidGhQF4rODf/gDOO3AP6D1QWjN2OiWvTr0TrG1gvWlgPVNZxPPxZ+Iii
         CkkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772063700; x=1772668500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+d/kouLLf9iKHdyjkzWOU+gVjFz9R5tJbv1KqoUtQs=;
        b=woN/zIFu6BKihA15yC78RP29swvjyWELyfFC7nCXXjDp0MOYz9MeqkJAX7NZQgR8lr
         Q6jkd7crlbvBi6GHsRTr3yoQSm2ujmV+ZhBoLcjyGSGsmTM8gKVN0R0f+0jkKtwzIOLw
         UDkRV/IyBCd/7Oe4Jdj8DarsdRyaf4TOwiNfQOPJ/sUOz2m6p/8DAv8R/qEVBBxyrHDb
         8Hmz6XcJNmZud90aKSuqwDfE9JJQvgnrsw3+1maq7lPpkCXy2pgyH6X3XtN2pdlvbJ6e
         uG1jocZ16krKPFLckMlHcZ6Xv0qQ+NW3yR0d3FSAPtIZApnFPXupXpYF3IOLnBNdAJf3
         vIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772063700; x=1772668500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/+d/kouLLf9iKHdyjkzWOU+gVjFz9R5tJbv1KqoUtQs=;
        b=lHCo5c35L8W7jE+kIY8MyywnvzC4ROzeIQMbmQ6FcFsOTANMcBvuZaX8i6rknFY9F1
         niepdujzJiNKuIKhuahS3H5np18BxdlCAlG5vAmAGpaFLRD9iAwmrmH+NKtShuiYHK14
         kuk8KKj5LQm7Gl/9gqRrYbk0XGBa+aw8i7JflLDbNRs5DkXFlrLFOA0sCsYh3WL7kFcq
         SJN4UUzd+TfNMs5ECAppx08evsZFc0R7rju4pDh2zp17OGjGeREQ2sCeWC0H934aVKVp
         uVFctKBlnMWYOoGH5dBIk8SbQSQV5BVy2yNep5o97hGlkD4Un+8h1rEfG2fP2sPDEdja
         zmrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmHUvtEpRZFELBARi+l6ZbMvEt7sqoE1WNdvxJQLyi9nlqmvkSadRZoqd4yWuDp8OJWuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqnyXMpvWeRhnPACEpQmfVUIUX6huD5xBmsVfkk6ihQbsfndWx
	zeemEW36967FcsWg7CdFiX/9fPCXCRom12uH7TxbJEhvU39/aM4N/Hm08fmiAImUkM2H5VqNbSx
	eWBnoyBENJz4zZuGcu9tsYObnGeMz0dFFYLOQGx2W
X-Gm-Gg: ATEYQzyOVlL7v7EFaxkTRlCBwGDVVZxtQA40+ZehwsyKc3d8ATGuWQi00kfaBS7DsTC
	1w7q4dW3KcuN6QshGYwuYebTIHD9Bo+g18AoTmLigzOKRmvmuiRpmC4s3AiPkezS/YZOWn5CC88
	SP4SUCF8vXdQZ4UCEZX18xtOEdly8hLUPdnQDtuWVBvFZdoFPICLGuVKlIbg/PffZShcSTUI/yu
	H52WPyGxD0dhhH+6KKFEJRL6IC9KTTyR6uFpGWwVzp/w1JDXAANdA/4zbKPDjlsP4wHWe4E/lzT
	JYDUVBJ34T1OU+IzpD70PLKjKN2VFfQutRiNLeagjg==
X-Received: by 2002:a05:622a:4c:b0:4ff:cb25:998b with SMTP id
 d75a77b69052e-507441e2d95mr4895751cf.12.1772063699005; Wed, 25 Feb 2026
 15:54:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-5-dmatlack@google.com>
 <20260225143328.35be89f6@shazbot.org> <aZ-CnywNgMnr6f1k@google.com>
In-Reply-To: <aZ-CnywNgMnr6f1k@google.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 25 Feb 2026 15:54:47 -0800
X-Gm-Features: AaiRm51g4hX409PKMap5bNDNnG0XAykqCRndojsQbHHI9mzip6hP9-Z2S9ohyZI
Message-ID: <CAAywjhR4Azqx8hXRap0eLUrwetYRiX8TALEM=b+1BorPc3eJdQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/22] vfio/pci: Register a file handler with Live
 Update Orchestrator
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 3:15=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-02-25 02:33 PM, Alex Williamson wrote:
> > On Thu, 29 Jan 2026 21:24:51 +0000
> > David Matlack <dmatlack@google.com> wrote:
>
> > > +int __init vfio_pci_liveupdate_init(void)
> > > +{
> > > +   if (!liveupdate_enabled())
> > > +           return 0;
> > > +
> > > +   return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> > > +}
> >
> > liveupdate_register_file_handler() "pins" vfio-pci with a
> > try_module_get().  Since this is done in our module_init function and
> > unregister occurs in our module_exit function, rather than relative
> > to any actual device binding or usage, this means vfio-pci CANNOT be
> > unloaded.  That seems bad.  Thanks,
>
> Good point. So a better approach that would allow vfio-pci to be
> unloaded would be to register the file handler when the number of
> devices bound to vfio-pci goes from 0->1 and then unregister on 1->0.

Yeah maybe a kref that gets inc/dec in probe/remove. I have a similar
problem with iommufd preservation, but I think I can handle it based
on the number of iommufd open.

I am wondering whether this file handler registration kref stuff can
be moved into LUO by adding it to LUO file_handler and the modules
only call get/put?
