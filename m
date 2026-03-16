Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C94C3B52FC
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681535; cv=pass; b=u/mcRcf9jfTCL+49pbPtjioySxt87DO4nJbnp4eDwtyMRN9S01zvmlBI3J8OnlJXFDeuOmdWccCl5y54TTCDYEQPDg2K41gfoeLTvnk0VPRLwmMXEcp+5xKwB2tsQdox59A3WLR+1O48hfPh9sLf0CwB77fE2kid9T4iiiMC3D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681535; c=relaxed/simple;
	bh=0Jl1H4VRajEElLJx6lQQ4elVW/zvvj1c6yvcKK9sD7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DTxQyLNpndA2/y8JmnaMuH0hg8xACpWcAiR0EdQC72hlS7j7+//yBAI828LYLGKSe8HgWi8l9sXwl0TiYFpBjEIC1tqDnmys0Qh0iffSO/3nze/Pc3wRpJAGWzzdZcX6nSfSN7GZO5loT0k8uv2VurpxvfMGDFHUKwaLFhViRkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWnRpn8s; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWnRpn8s"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5ffe6887e21so1100318137.2
        for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 10:18:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773681533; cv=none;
        d=google.com; s=arc-20240605;
        b=fJSFggwAhP0FNkn+CeuDSZ7TKPu3C2F4rIN28kxzW0TejHwYi8mfkKTyIkXL6iyhYe
         jJ6AxL72mYVs2dDjUvd170aODPvp6O9ZjKYtxq6cnqUBppZSqdaA8GcyhhbqnwxCxUzr
         1pmfrBjeIvm++HUIT0XLIbYkm8Ijrv3W8STNkQP5vZb+h240FNp2hRoijhp+uFW58RiJ
         FKH3LdwyPEA5OD7uAXdUTrmM/bqhVtGTbXep4z+SD8NF2XsEiDfnBwt3fmrNSuNQzjch
         nDjTSJO635+NHEXZLw7uYnaQHts/8vPSbkWzg3Uxdappdf1MJ4/y11rFqmm+MzVGBoBu
         899w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jK2scyfYwBMU55V+xfenTzy10C1cc5BhbFAgTj9RHSs=;
        fh=MFDXVBrMnkoNAE4sqw24kOYW4qLTcdiEl8upkFiYOmU=;
        b=IhJ9r62n6V+EhjeRHYsKwT7MB2WxZL46mnNJ4U3REMnXgqVTc1VxlJLXE56g8ohqHr
         RlMoLGKG8lq4fL9FHE2qk7i09TEdQQIMwrP3/O7FON9egsHGL7XEO58NTc/aoQf/CEDY
         PDhGz+l9MLQ+dYwM7swiXpVszrVFwNQ3LXLwT1uATNNZagEC4YRYVtnRHS7oNfa+lXzV
         Ldn1TeEwJuoW20HgfsiDEDgQN1ydKlaXOaWt8qKhHKtA03VMZaRI/2HVnuUUB1Y9cLn8
         N1Heqc2j/IMExm7gEl35Rq3I8sw01dyOOCaOFlXMh5n9s/uCLezSkBORkZxMbIfHMBXn
         tXCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773681533; x=1774286333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jK2scyfYwBMU55V+xfenTzy10C1cc5BhbFAgTj9RHSs=;
        b=lWnRpn8sPsmYuL/qKxXUBQyFgK8y9+MKBBOs/ieA6uJUiCJHbftHMniA44yNHqt4pd
         hIjDcYAZ6kTMtfBp+Bd+rLOr7/8mW+bO8+G0HfwVAUusjRj9oxbmK6YtujguOdRNklE7
         KElyDzQSSjdnBsXp9s3dBen7lTDU2GXDcJMKxYsR/6seO4ffAKk+bzqJRpOEEA6YhQ8z
         N2C9XeRgAhv5VSxR9/D9ms4RTk5uFeWSG3JPDUyxo8VvOBVoE12B+z8flL3zSJQg6ULk
         qUBFoWeUZuP2S/WGzR+nDdoNvx7frMPW+s11dsletmXmfxVeVZEVcLJUXmkyUJJWdjGe
         01rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681533; x=1774286333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jK2scyfYwBMU55V+xfenTzy10C1cc5BhbFAgTj9RHSs=;
        b=n/uYflc9HJm8cMI4zNruZKotDhDUNwNg+vG73WzExdQ4/jg1SkJqjMM5JyuSKM4q7t
         yWdf8vUfSDR5zBG9t7qq82+CXsziF7Apm1+mvnomI9Y+2a+P35rCBF/8aOeHAmSbGsYq
         IOpR12Y3MzaIlFOJY4z8CQQERiVU2Ey22wK6LUdrdIz8pQ9oHhyg/qbGkww8AJ9HMSkB
         1DqhOEEBzj1i8TGz4kqtHlhLTfSoarWXUU5FOGJ1mU9PK7ZkqY0g2iKWAK8KkZ49gCwE
         eJh+QCy4wVEkEwWSd31bi39vCGIUnwiwe3zy4/mYeyA8uDRBovCeYnK8SjUa1Y2dCjiw
         I5kg==
X-Forwarded-Encrypted: i=1; AJvYcCUeJe6XQ/sTm8ELMeIT0YWOHrtxkRpbMGC2YjwuGaeGub3wYbCn/vI8FlQ/MRtQTPEJZpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9XkY2+Cos3gOQPQH0Gv233ptoJsn3lACl+wfYyJgl4T3fY9JM
	CCUcFWOZSXLR5E7p0grcmtbpisdCfQfQEC82+BMXsftQZu+G3dl8WbdmMWtrmud/a9AIRI3Fko9
	WtEnh2HAx8OPNUZsu5TxG1qsYxqG0gZw6nCu1NOC6
X-Gm-Gg: ATEYQzx6orL3tPbpH/hIYWMy7MqpIEY9I9wW7vfc1OpTWuifuftz6aI4uI0da1IUHXE
	hZxA+F2WPbgklD9FdiMRCLDJStj68LOInWo9chyrY8wYyQYSwdJF4AGRzv1/DH7LrXEhXHF3OPH
	AUOb/l5Ml/ru/LCaUMHpoFbdAtPzDC8RvLGtGd1GIfZs3Me6XKrVHWRnvcoWdB495gM/TdMnU7P
	TR9Vo7Wl5xaoh716xwwLctWvWQszCCZ7ilbSAg5iXR2yeX5AzzNIhGVr23YfLvjdyL7XYzgHWah
	jhj2S32T
X-Received: by 2002:a05:6102:d87:b0:601:f3b6:f2ce with SMTP id
 ada2fe7eead31-6020e27c32bmr5393489137.12.1773681532920; Mon, 16 Mar 2026
 10:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-11-dmatlack@google.com>
 <20260226170030.5a938c74@shazbot.org> <aaDqhjdLyf1qSTSh@google.com>
 <20260227084658.3767d801@shazbot.org> <CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
 <20260227105720.522ca97f@shazbot.org> <CALzav=fjRPa_ZbXu7iFXyemcf_8Kq_dZTWT6c-A0bc6czF_Rdw@mail.gmail.com>
 <abNOwcOTXqxCxNzt@google.com> <20260316160759.GA1767448.vipinsh@google.com>
In-Reply-To: <20260316160759.GA1767448.vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Mar 2026 10:18:22 -0700
X-Gm-Features: AaiRm50L1lnLwO1eCIJNJtk4Bw53fGwzF8hjQ-eN_1dFmVAntzs-kWI2tT0ZbZU
Message-ID: <CALzav=cskxLZtZ5-uRa0+aV+1Kb3fwQQJ5dS=Yes4GAHrS6GpQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
To: Vipin Sharma <vipinsh@google.com>
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
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 9:22=E2=80=AFAM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On Thu, Mar 12, 2026 at 11:39:45PM +0000, David Matlack wrote:
> > On 2026-03-09 10:32 AM, David Matlack wrote:
> > > On Fri, Feb 27, 2026 at 9:57=E2=80=AFAM Alex Williamson <alex@shazbot=
.org> wrote:
> >
> > > > Sorry if I don't have the whole model in my head yet, but is exposi=
ng
> > > > the restriction to the vfio user of the device sufficient to manage=
 the
> > > > liveupdate orchestration?  For example, a VFIO_DEVICE_INFO_CAP push=
es
> > > > the knowledge to QEMU... what does QEMU do with that knowledge?  Wh=
o
> > > > imposes the policy decision to decide what support is sufficient?
> > >
> > > Hm.. good questions. I don't think we want userspace inspecting bits
> > > exposed by the kernel and trying to infer exactly what's being
> > > preserved and whether it's "good enough" to use. And such a UAPI woul=
d
> > > become tech debt once we finish development, I suspect.
> > >
> > > A better approach would be to hide this support from userspace until
> > > we decide it is ready for production use-cases.
> > >
> > > To enable development and testing, we can add an opt-in mechanism
> >
> > Here is what I am trending towards sending in v3 as the opt-in mechanis=
m:
> >
> > diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> > index 1e82b44bda1a..770231554221 100644
> > --- a/drivers/vfio/pci/Kconfig
> > +++ b/drivers/vfio/pci/Kconfig
> > @@ -58,6 +58,27 @@ config VFIO_PCI_ZDEV_KVM
> >  config VFIO_PCI_DMABUF
> >         def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
> >
> > +config VFIO_PCI_LIVEUPDATE
> > +       bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> > +       depends on LIVEUPDATE && VFIO_PCI
> > +       help
> > +         Support for preserving devices bound to vfio-pci across a Liv=
e
> > +         Update. The eventual goal is that preserved devices can run
> > +         uninterrupted during a Live Update, including DMA to preserve=
d
> > +         memory buffers and P2P. However there are many steps still ne=
eded to
> > +         achieve this, including:
> > +
> > +          - Preservation of iommufd files
> > +          - Preservation of IOMMU driver state
> > +          - Preservation of PCI state (BAR resources, device state, ..=
.)
> > +          - Preservation of vfio-pci driver state
> > +
> > +         This option should only be enabled by developers working on
> > +         implementing this support. Once enough support has landed in =
the
> > +         kernel, this option will no longer be marked EXPERIMENTAL.
> > +
> > +         If you don't know what to do here, say N.
> > +
>
> To use VFIO liveupdate, user has to do at least two things:
> 1. Enable CONFIG_LIVEUPDATE
> 2. Pass VFIO FD to a live update session.
>
> This means someone using it has to know what live update is and
> intentionally pass the VFIO FDs. Isn't act of doing this itself an
> opt-in mechanism?

If it is, then I can leave this out. Alex?

My thinking was: Distros are free to enable LIVEUPDATE and use it. The
support it enables today is all fully functional (albeit new).
vfio-cdev, OTOH, is not. A separate Kconfig can help express that
difference.

Consider that LIVEUPDATE could be enabled by default in a future
release, but vfio-cdev support might not be ready yet at that point.

> I am not sure providing VFIO_PCI_LIVEUPDATE alleviate Alex's concern
> about how userspace will know that sufficient VFIO support exists.

I was thinking we can flip VFIO_PCI_LIVEUPDATE to be enabled by
default (if LIVEUPDATE and VFIO_PCI are enabled), and drop
"(EXPERIMENTAL)" from the option title. That would be how distros and
downstream users of the kernel know that sufficient support exists to
enable VFIO_PCI_LIVEUPDATE.

> May be write in liveupdate documentation (PATCH 11 of this series) that
> support is experimental?

The documentation in patch 11 includes largely the same text that I
put under VFIO_PCI_LIVEU"PDATE. But I can explicitly mention
"experimental" as well if that's what you're asking.
