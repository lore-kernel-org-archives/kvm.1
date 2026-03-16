Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55506367F2C
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 22:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773699290; cv=pass; b=YdVaKrqS9Z8pf5rTQglQ+/0HCip7mVlG7rqgqKRvr/6nqu0FSp8q6hr4Bb5ZQcDjcNvKO3ZM5WXeeJWTHNaLrgme6DYTV+a4y6y0YOcta7YeTVwjLo7W49HMPIpvnxWdE0RYNPcianMD6WR94Z+hX2nWBfKyZDwrgcu+2AnFr5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773699290; c=relaxed/simple;
	bh=rtrnZeqQl+lqOePojv3lREDvLjSPymz2Gx9AF8DWaII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVAu7lRIkktEZSA/J/bvhvLXJDa/8XqOl35pisZ0tVZ4V2fk0ySUnjyNjlqgekxqCyjws152Ho1DRh6k7+XNjRAuEHbB+TluI1/UuNXVbjyZB/kxEE6L0EnRxSIISEctF8ky55aCiNBWKRUTtVTsjY/OkWmg8E91wG90e2D4OT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UPLTGcl1; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UPLTGcl1"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a12c310e8aso5287386e87.3
        for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 15:14:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773699287; cv=none;
        d=google.com; s=arc-20240605;
        b=YqPst6gLhbFSwHsfOxBGh1PzGx1TKZ/rao6V+TRD/EwnrYIHED56YQmjF4tbx15L0w
         OKCJTl4eiHzw1yzMYdfvYUTjJuMdEYMrZarQZZRnwQrAoMWScg1zuzAZ8y9Rg2JESz7A
         fFjvliJ4+VJ65BfZUJTs37ZtbIyJsQj52XzoJvT3IuGq5rOtzxX+c2gux/fAbLUCucHN
         oBuJm0eQhoPQVeQvFQU61V+bIaT3j0w+/xxM98i9PPZAPy/cEscUw1msPmrM8cjHz5XV
         XpboWF5jJP+Hs1uI0UjAFkYx3MZGeEqS33+zxxnvh9QwA9PuqyYkumYOO/bD/Ov68g6i
         kihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/1TI05GxVOzwi8Lp4rr2cTv/CbMBWmj36+RO6nniHqE=;
        fh=JbxUsq0nBLf9Qx6+HxPwy3SKPmvFZ008QYq2p5+7OMI=;
        b=IXlzvY4DygmzrcWFemsd0G9XpHxAOqLqSjkp3IvU57Nk5U2zVAmxOzowy3w1yDMzNh
         p5jyFbf3MbDv+7D6pujKiT4o6IQb0/mwpyJyhq9tvzCjPXeAlzOG9WYcdaFTB7wtH6zk
         2ts99l+dELshEvmNzIsj9oX5Du5Ff6E2aDAGADu9JGoEyXFN+LHIQgnT6ClfeMMVuGWS
         D9kAuP0LIPcOWFIsUk9BC/d+Q1vQHGef+Jy5sp0kl5q1bepfXAevVAx6E8ryDs7Ffnbu
         G9mjOFQZB7943v6hPXrRLZTZyN0T98GpRqi517Lh4WkrEo+/IFjfzF5Q/CnOyRsf4HQN
         tHBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773699287; x=1774304087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1TI05GxVOzwi8Lp4rr2cTv/CbMBWmj36+RO6nniHqE=;
        b=UPLTGcl1cOU3YiSSYkpqlSCu0xdvEjofWmv4bZ0wE+Y8UadAIfyYg9Yd73JHraxTJK
         GBnTY2WqD0/KUeWE92s3s1IZMWbLsVQ+flHuD38f7VZ5SqgKWTj2io4PvwRsgZWW1DxJ
         RT0xCAU+qc/iEV715wHgte6sw+A43fLFajD38h+T7gXh6JmcNsOo7IMmKln/4z20e1q7
         VBP3UTC+U55bVc7Mpd8sOZsmgj+UBgORwBU5cwLTK2FCcm2X5jw0445LjK6fMs0aKWMy
         WNOWwsb5Al920rWZiHjSMh72UwCvEdlKIhwB+NNDIzg2/BMCnIZmYgHHF3sFg/L2y/Kt
         de2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773699287; x=1774304087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/1TI05GxVOzwi8Lp4rr2cTv/CbMBWmj36+RO6nniHqE=;
        b=bPYpd/LYQLUReiPHTnSyG285BqD7xyMmtCeUp/Vtu+1zF0xUQVH/kKCTnVkfDMlCh2
         vL9Du3eG9n2CNcYOmB7OgEmniXAqeAKOpmy1jQEbOAzjKvuQ3M4tdnDQFooUUqqy0/Gm
         9TnVLgInhro4f/kbP3gu98h65Wel4OoWXC5ZIxJujDblGW5STDo10mHCIz41pENuQbli
         WBcaILGFwA6IVCv8KTRuhduJb+69dZgs+TMlK3I+8CP3ee+bA+AYJvTDH2xDzBstsfhD
         fHHQ7vMIohvyeiBc8NWxMEQcmKs8duoj8K0+PzFXDrhREssA6//HYxzmAaOAbSSHZZ0z
         IIAw==
X-Forwarded-Encrypted: i=1; AJvYcCUOfWjWcZS9A+02Qpe415Xc5RvGPTrOdndhzNSPeGzrPtLObak7bz2H8bptGUn3PzmFcLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5qI5UXv5g6n+KpwyyEt4xJqtM+SCRXCj4ajanksTAj0crXsOP
	B72XBCth8XIt2Gvsr2RUx0X7RDrlIGFR4NT/tGx5P15O7OmArwpGIqEjACY4YQF9n1t7BQaZJcB
	HYk03ScxtBSa5EW1z/FhxhFPhmLKBKr25OESPaBuE
X-Gm-Gg: ATEYQzxyBx8mLGbQFrYFfDkfyHxEsmdv5efK8yWmgKllSwrxiXg6xWgsKFkcUGt7EuH
	ZTul1AWSIGa8iekojSVybuDfaxXTyO39xxNBmMKqBp4k116V+LCLG5vzPsv5LDUZmpX20W6gp43
	AOETX1gYVs9E5NReRE3KSgd0cEp4E8pFkDbWOMPIPCw/3I0vxpyIEqdMf9rAM+duRVVvGIxQJOH
	0ARSS7LDm33Jz3ciqXRgTvpOTkg3HXZPPUQZI0/cW2WbC7JtOXUjRWlBsFza5/2JJ9W+xEFBLuJ
	F+0gBKm/80Uv56Qkbqo=
X-Received: by 2002:a05:6512:208e:b0:5a1:34d2:b6da with SMTP id
 2adb3069b0e04-5a162b0a440mr3032307e87.31.1773699285744; Mon, 16 Mar 2026
 15:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-11-dmatlack@google.com> <20260226170030.5a938c74@shazbot.org>
 <aaDqhjdLyf1qSTSh@google.com> <20260227084658.3767d801@shazbot.org>
 <CALzav=fHy23RAzhgkdaL+JA5T2tL9FT6aPgRfXUh7i9zvYCGPA@mail.gmail.com>
 <20260227105720.522ca97f@shazbot.org> <CALzav=fjRPa_ZbXu7iFXyemcf_8Kq_dZTWT6c-A0bc6czF_Rdw@mail.gmail.com>
 <abNOwcOTXqxCxNzt@google.com> <20260316160759.GA1767448.vipinsh@google.com>
 <CALzav=cskxLZtZ5-uRa0+aV+1Kb3fwQQJ5dS=Yes4GAHrS6GpQ@mail.gmail.com> <20260316214055.GB1846904.vipinsh@google.com>
In-Reply-To: <20260316214055.GB1846904.vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Mar 2026 15:14:18 -0700
X-Gm-Features: AaiRm50S3PNCrqX_TvZ1JiMZN8vQiYVbYC7Ez3YpAEpqzQo0lUEJ7c1xPn8zOqk
Message-ID: <CALzav=df8K0R0gJyQ=ifoznp_CMRRtyrWchbNvcw2-wpkdaBaQ@mail.gmail.com>
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

On Mon, Mar 16, 2026 at 2:49=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On Mon, Mar 16, 2026 at 10:18:22AM -0700, David Matlack wrote:
> > On Mon, Mar 16, 2026 at 9:22=E2=80=AFAM Vipin Sharma <vipinsh@google.co=
m> wrote:
> > >
> > > On Thu, Mar 12, 2026 at 11:39:45PM +0000, David Matlack wrote:
> > > > On 2026-03-09 10:32 AM, David Matlack wrote:
> > > > > On Fri, Feb 27, 2026 at 9:57=E2=80=AFAM Alex Williamson <alex@sha=
zbot.org> wrote:
> > > >
> > > > > > Sorry if I don't have the whole model in my head yet, but is ex=
posing
> > > > > > the restriction to the vfio user of the device sufficient to ma=
nage the
> > > > > > liveupdate orchestration?  For example, a VFIO_DEVICE_INFO_CAP =
pushes
> > > > > > the knowledge to QEMU... what does QEMU do with that knowledge?=
  Who
> > > > > > imposes the policy decision to decide what support is sufficien=
t?
> > > > >
> > > > > Hm.. good questions. I don't think we want userspace inspecting b=
its
> > > > > exposed by the kernel and trying to infer exactly what's being
> > > > > preserved and whether it's "good enough" to use. And such a UAPI =
would
> > > > > become tech debt once we finish development, I suspect.
> > > > >
> > > > > A better approach would be to hide this support from userspace un=
til
> > > > > we decide it is ready for production use-cases.
> > > > >
> > > > > To enable development and testing, we can add an opt-in mechanism
> > > >
> > > > Here is what I am trending towards sending in v3 as the opt-in mech=
anism:
> > > >
> > > > diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> > > > index 1e82b44bda1a..770231554221 100644
> > > > --- a/drivers/vfio/pci/Kconfig
> > > > +++ b/drivers/vfio/pci/Kconfig
> > > > @@ -58,6 +58,27 @@ config VFIO_PCI_ZDEV_KVM
> > > >  config VFIO_PCI_DMABUF
> > > >         def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUF=
FER
> > > >
> > > > +config VFIO_PCI_LIVEUPDATE
> > > > +       bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> > > > +       depends on LIVEUPDATE && VFIO_PCI
> > > > +       help
> > > > +         Support for preserving devices bound to vfio-pci across a=
 Live
> > > > +         Update. The eventual goal is that preserved devices can r=
un
> > > > +         uninterrupted during a Live Update, including DMA to pres=
erved
> > > > +         memory buffers and P2P. However there are many steps stil=
l needed to
> > > > +         achieve this, including:
> > > > +
> > > > +          - Preservation of iommufd files
> > > > +          - Preservation of IOMMU driver state
> > > > +          - Preservation of PCI state (BAR resources, device state=
, ...)
> > > > +          - Preservation of vfio-pci driver state
> > > > +
> > > > +         This option should only be enabled by developers working =
on
> > > > +         implementing this support. Once enough support has landed=
 in the
> > > > +         kernel, this option will no longer be marked EXPERIMENTAL=
.
> > > > +
> > > > +         If you don't know what to do here, say N.
> > > > +
> > >
> > > To use VFIO liveupdate, user has to do at least two things:
> > > 1. Enable CONFIG_LIVEUPDATE
> > > 2. Pass VFIO FD to a live update session.
> > >
> > > This means someone using it has to know what live update is and
> > > intentionally pass the VFIO FDs. Isn't act of doing this itself an
> > > opt-in mechanism?
> >
> > If it is, then I can leave this out. Alex?
> >
> > My thinking was: Distros are free to enable LIVEUPDATE and use it. The
> > support it enables today is all fully functional (albeit new).
> > vfio-cdev, OTOH, is not. A separate Kconfig can help express that
> > difference.
> >
> > Consider that LIVEUPDATE could be enabled by default in a future
> > release, but vfio-cdev support might not be ready yet at that point.
>
> But that also requires point 2 above i.e. userspace explicitly passing
> VFIO FD to liveupdate. Unless there is a capability mechanism like KVM
> then userspace cannot know what is exactly supported.

Yes that is why I propose not exposing the support to userspace at all
until it is ready, by compiling it out of kernel via new Kconfig. This
way it does not get accidentally enabled in distros or downstream
kernels before it is ready.

> Also, users who
> are using these APIs will already be advanced users and have to know
> many details about what liveupdate supports or not.

VMMs will be the ones preserving VFIO cdev files. I think you are
suggesting they should know what versions of Linux support what kind
of preservation? Like QEMU would know that Linux 7.1-7.4 supports
partial VFIO preservation and 7.5+ supports fully? That does not sound
like a good situation to be in.

I think it's much better to hide the support behind Kconfig until its
ready. That way the PRESERVE_FD ioctl just fails on kernels that do
not fully support (because VFIO_PCI_LIVEUPDATE is not enabled), and
succeeds on kernels that do fully support.

If someone wants to enable and use VFIO_PCI_LIVEUPDATE while it is
still marked experimental, they're on their own.

> > > I am not sure providing VFIO_PCI_LIVEUPDATE alleviate Alex's concern
> > > about how userspace will know that sufficient VFIO support exists.
> >
> > I was thinking we can flip VFIO_PCI_LIVEUPDATE to be enabled by
> > default (if LIVEUPDATE and VFIO_PCI are enabled), and drop
> > "(EXPERIMENTAL)" from the option title. That would be how distros and
> > downstream users of the kernel know that sufficient support exists to
> > enable VFIO_PCI_LIVEUPDATE.
> >
> > > May be write in liveupdate documentation (PATCH 11 of this series) th=
at
> > > support is experimental?
> >
> > The documentation in patch 11 includes largely the same text that I
> > put under VFIO_PCI_LIVEU"PDATE. But I can explicitly mention
> > "experimental" as well if that's what you're asking.
>
> Yeah, even though documentation do get stale but I think there is no
> better way in this scenario.

Ok will do.
