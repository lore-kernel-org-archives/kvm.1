Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80F03101B4
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 22:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773958190; cv=pass; b=eQHcYmKE+isITQsJEHvZxZothFTGsVTp8LW/k6Q5F/pjdzAYJZ3QLonTrJ+P/npRhWyeEbDFlilPRXyGvSJWC3+vVU5qP5nEXBNdgXMzWHSHUgpQ/iZmzXlxq87/vhbV7UHikytODm/sejGtXwXNa587NqfhLW6Dd53xDgfZjOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773958190; c=relaxed/simple;
	bh=7oOcuw602t0Hs62ASwAporxmUlW6f0Mxodgh2CLwYtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2SPAqbmWvcPYzvc1t+1aconxlST8ELCI6cdv/Xa8EBV9F3K21IORQzlotRjocj6crcgFvn9IF/VxdY7bGDfO5Ub4BZh/6VjVRD5/lCXS58nerK5O3pujvwLVbddZKF+rIc5hKV0QA6Y4cRkZtuP+0yUbj7rfKL/pJ3J79gTanY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F64ZwUsg; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F64ZwUsg"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a12c19affeso847101e87.1
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 15:09:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773958187; cv=none;
        d=google.com; s=arc-20240605;
        b=JFzuBCXhT+VcOojdcyUbb55u7QLZaXZfBiQSuV1j1kE7xzgqENhGwZOeZc3c5LYIV+
         bIsAhrtPn727zV6d8/1cFusc+9pqK3qH8gZZSVyqxKVOZRg71ZNqRFzFFoTeRXWWcKcX
         NEPp3kBXCgKxdlEei1XNT2+90uc+sLOwj7kIM68Xggut57Yn4Ym2e53xWQMpo62rG2hs
         PliqP9HmMOjS1p2wvQ8/TCyj7GtGtzh5wWYAZSRAUuub7mIo1qd3/o8efSAaDWtxpKcE
         UfxN1hJiE971UIk4oAp1TSOkwNXPmOLAdMGo1PIAozAEMpMLDG6hLsjIT9zdVXrsNCaR
         pOjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=svD4wMks8gwyXRL5XOV+qF8B6FaNKoBJNHk7PXgg3Q0=;
        fh=DUnsanBhIKclAxVaE+8TCRJNUN/RmyO9Mr0zZlf0KsA=;
        b=blVjwDZu0L2iEYtTYMKbsBu9dhc8RT6x4naj7IfUsWX4h9u8WZZZsPgA29OQE0owkb
         eHw3eTrffZpj/DwRs4o/2ET/8cLJdiC9mt3EzXTsHzFp2ojYPrRbll6WPAl5D5UmDc/7
         LN6E2qtzuWv41AP5XlxlQHmExK63L/Za0d0LIWWI+ZfVtuRS8uzJXgHCDSERGh4HsKx2
         3hicAlHQ1VDcBm7U0Hgd6ef6IkBskzbuU2BYxAEnXJ6FdWezBFtD0xkH3sHQMIpuw/5M
         K6czGadjfrG88rzqMLaVokLBAFajYlJ5cM1RSyZ/pc5B+oMtjUk0LCBOiTFXU4+jFajg
         8EfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773958187; x=1774562987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svD4wMks8gwyXRL5XOV+qF8B6FaNKoBJNHk7PXgg3Q0=;
        b=F64ZwUsggRvGf4oIJg5Pnpz/U5EPeC1NcxDs7F+x5V2FIoW4NMVVGcs/24x7SP8/1k
         v7dCerCmDCdDZcyzC6wkbd5LkmSGdwGtqCA35r25QrgjSIv2kivWsxb0wg+cwYffsvWF
         Pw50IEZPO7PQqP3m4bpQ17TvTqH3YlZgrD1z8pbMiPziV+6tP2lswRGU1QyXLt3U3Jpm
         fE5XjdNMNEpFPGnrMzsvzqLTNT+IqAF5j5wVBPPkH4EbTVqzigsAZMh1h/++MBvDYY5F
         01C5u3beOCIA5iMplFYqw495/j09gBcboHxHJNC1TSklD+udxxTBnWchD2geS7e2JAM8
         GRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773958187; x=1774562987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=svD4wMks8gwyXRL5XOV+qF8B6FaNKoBJNHk7PXgg3Q0=;
        b=OMscoc7YO6UDdKGac5vFwUfSjsE8CoI4a0w8m3oRVNaAfx2SKo008A7tTxJMvuDnBJ
         NytzcsrJindl+N140rtnn+SKTOsTodFZqwQ2gJq2XDHp4hZNXW1mwMiwqzE10aHbh+6p
         AtiZ5LfISLv+gQO9m3kLu/RvWPdgP60saPVOJUGf0xRAPikIKLXwNr2p3GuBxuH8KNul
         DiYcARJ0bodfky6Eaus73U+uio5ZmWWPV8dcUhA86vASpxhCw2E8wRJhntLh4vI11Jjy
         O8edxjAlgXocjDAY05iv/gctMSXvLyw6sEeyaxLERTcs7mDtmLqj7KK5sPQtGhIAZppi
         rXLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqZK4hXFZPYdKyAo1biWD/ns3OHkcOvxSm7KYeRkS/VqbbeWPSg9IeHYJko+IQYV/G0Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRdM0S85vMM0v+dFncrFJV/ydDz/Cmv8+j0Dw3jnP2Df30GU/e
	r9Bem+WntxryqtZMQnQZqM7K0vWq/CDPtfMed+sjmdBzqALq6A7WMxhFyVLivVUXAG26kpnic64
	/3L+gJnWbGIViKphXbquwmOCElhuF607uR56wEiey
X-Gm-Gg: ATEYQzy6ZTDmkLMAexUmZDrXeMfOMr1YvozOo5GefHQbPTXNadaVKdFzjLxnyvcMXXI
	qIBD/8rk+M0jQ6tgs+H4nKgDXmqXjpngOXA30kD7I50WN/f0O8IkkSdBxCHNBL3zQ603hBCEav+
	xyR5sJMnvgPQ1/IzWWdjnNshjtoUL54MeHXb/CYUfLyYKP3mKINEKfilWJnbZDfq0OV1bOQcyIo
	dY8QumbPQdng/HLUQ5MiRpqG+WWm0W3rsZj0BOHNe868G16sxu+Aw3MCZf3t9REg5npIFjiEGp9
	Y3OCJ8wp
X-Received: by 2002:a05:6512:3b22:b0:5a1:742d:277f with SMTP id
 2adb3069b0e04-5a27de01545mr1986403e87.11.1773958186394; Thu, 19 Mar 2026
 15:09:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-5-dmatlack@google.com>
 <20260225143328.35be89f6@shazbot.org> <aZ-CnywNgMnr6f1k@google.com> <CAAywjhR4Azqx8hXRap0eLUrwetYRiX8TALEM=b+1BorPc3eJdQ@mail.gmail.com>
In-Reply-To: <CAAywjhR4Azqx8hXRap0eLUrwetYRiX8TALEM=b+1BorPc3eJdQ@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 19 Mar 2026 15:09:18 -0700
X-Gm-Features: AaiRm51momKlFVcCV9Yk7taG4PZCOSiNfgaYNzeVE1MwV2qirg6S-TkURRRSfl8
Message-ID: <CALzav=cMEkenGKYvA=rNmTmVjpf_DW_92MCFx-2gxqKbrdG0Kg@mail.gmail.com>
Subject: Re: [PATCH v2 04/22] vfio/pci: Register a file handler with Live
 Update Orchestrator
To: Samiullah Khawaja <skhawaja@google.com>
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

On Wed, Feb 25, 2026 at 3:55=E2=80=AFPM Samiullah Khawaja <skhawaja@google.=
com> wrote:
>
> On Wed, Feb 25, 2026 at 3:15=E2=80=AFPM David Matlack <dmatlack@google.co=
m> wrote:
> >
> > On 2026-02-25 02:33 PM, Alex Williamson wrote:
> > > On Thu, 29 Jan 2026 21:24:51 +0000
> > > David Matlack <dmatlack@google.com> wrote:
> >
> > > > +int __init vfio_pci_liveupdate_init(void)
> > > > +{
> > > > +   if (!liveupdate_enabled())
> > > > +           return 0;
> > > > +
> > > > +   return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh=
);
> > > > +}
> > >
> > > liveupdate_register_file_handler() "pins" vfio-pci with a
> > > try_module_get().  Since this is done in our module_init function and
> > > unregister occurs in our module_exit function, rather than relative
> > > to any actual device binding or usage, this means vfio-pci CANNOT be
> > > unloaded.  That seems bad.  Thanks,
> >
> > Good point. So a better approach that would allow vfio-pci to be
> > unloaded would be to register the file handler when the number of
> > devices bound to vfio-pci goes from 0->1 and then unregister on 1->0.
>
> Yeah maybe a kref that gets inc/dec in probe/remove. I have a similar
> problem with iommufd preservation, but I think I can handle it based
> on the number of iommufd open.
>
> I am wondering whether this file handler registration kref stuff can
> be moved into LUO by adding it to LUO file_handler and the modules
> only call get/put?

Circling back here, the new plan is for LUO to not take a module
reference in liveupdate_register_file_handler():

  https://lore.kernel.org/lkml/20260318141637.1870220-13-pasha.tatashin@sol=
een.com/

In the next version of this series I am going to rebase on top of
Pasha's changes and keep the call to
liveupdate_register_file_handler() where it is.
