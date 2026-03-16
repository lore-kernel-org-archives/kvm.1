Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687B63D16F4
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684714; cv=pass; b=OrZtF4WbuiO5iJHsWrDdjgpjfUdICmNP31hRNJrXyPYCIA4/4R3BFjZgZySGcigLesMsgPYJKMnCjOE2TT/EI6UKNe/rW6dIX0/NelOVlJu1wWwEaPW0FJRb0IbtK3/jSTtlTbub4F5o0rD1e8ssZe8Ihbw51s/7lJL7RPchLd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684714; c=relaxed/simple;
	bh=m7+JQVttlm8dL3EZ1N+mfhiI+GNnG3dsJzvTlqZYD9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqlqqWf6pRBVnzOjMF6gparylbfh8CmmoRW+40MdAbXT6WnSp/wdXO8v0IMzxLDN2+WfXJIsxzkdm4J3i6kFYHaHB5HY73p+LJO+1lgVVzfRuY74s7z7Xb6DUddTgKUEAud5vfXDQyHUHZdlRj5bxwjoiui2lDKwROAtIEr/bO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cQt6+eQD; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQt6+eQD"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a1273de95aso7330589e87.0
        for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 11:11:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773684712; cv=none;
        d=google.com; s=arc-20240605;
        b=X9T3+aFxXNm+EBd3IjT6luUaQc4Lz/VtwmLfP0x8Gb42en9wO1vvyPmHqZ3rmj5jaO
         WD7iHIskgAKeE6KpDqR8VmA5Ezkw5o5MlHMh9Vq6cKotmr7wHZ3ICypZ8rbviUOcZb3d
         UiIE+exKyd303TSO4Nt1b8dI5/YeF2UkVbN+OA3KySzMbyloO7s0e0TAOXvN1URPtd5l
         7YDZz1bXrPVqqSW4F7d7XijfVRdJ5yEvbcLnW5HsEi/vg/z0V2Ce49w19kNf56tsMgUV
         03B84wrhzDaRsoMkcuY8Gdf+qF2CVnrnDyHSuL/lACWQpBs/h4yycnKdm0zaAiOFcTN0
         4SuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hacBXTanIx+HGRz6G551slI/wF3dk8INyCTw5fzLvmE=;
        fh=9SKcYKPf4lwE0EmcCvgYK0VhcOvjOCt3I2OiCUbY/24=;
        b=hbqSlo8UGl2/3e8F1ammZfS9PIUVIhJXZ/t6hSamVaNQNkdHqJWlAl/EDJricWRQq5
         pYuky0depb33I26jwKQZEUnpsp8IBZ9oc9Zye97461+f69/tvyi2q/HCbFUVZJSmW5Zw
         xq4zT5dilPc/bJDLk2WYSmSKFOQdkh5M8E3DGF3WpHxEAYsf6UVh+5esGd1Mx2+n/uOI
         tAg5pnSXAm/NeaPgMCRm/FLzCw/WJBZrC+Bb2fJmq1EdN44i0UjtYSullNVjplxxtGPU
         NqPcUuyULCGlQp3K7O6sp8U2ZH6Xk5U3u7kI9r01rVhP1fknwwiui9BzB1BgHZr6N91B
         RMeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773684712; x=1774289512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hacBXTanIx+HGRz6G551slI/wF3dk8INyCTw5fzLvmE=;
        b=cQt6+eQDwIR5b9b3BeE4rk0iv0uO+8kW3YJcjm5smuBNn0vwCgH83jbHVCDHaqhNJV
         OAMuZ8UI1lg+tA2ikB5mrby965zWgqovf85fv3gSu2bTyIBz2l042Jj1oHo+07t7BlPl
         YEnWEV1HnDGVfPgQ+Q+u43YxUjzmXI0UMglnc7NK3wrMxKckSoKBSVUw4kVJ6u7zU/Dt
         5Zarv3V4FjAu4PNHtWYuChR8bGGhFjT00Ns8UZZbHmGF6GArw/mlUtLe+rwIJ1UvtgcC
         Q7qbVPuC4HK9paJLudrtB3Eqm4XwyNfOxtl3HjrhRU0iLXg6Fcvq0oa+c1ljtAgQnwc8
         U4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773684712; x=1774289512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hacBXTanIx+HGRz6G551slI/wF3dk8INyCTw5fzLvmE=;
        b=pIDfY+FLLu/bvgTigOXExC04eOjEjQRC+H3rBnm4uDORpVuArewq/TYTqtWgMiXT5Z
         07JHfGMi8XaODikWVQsfqXBf/becduBH8CkY1jfVrZkOGJzyYnLmtBJR1Yu3nx1xdYvn
         rohOnkN76BMiKaF7XW4YWtJBxK0T+y2ayfIOTwBVQ+nUJ/SoE3IJq3plZXaamHDUVPk1
         i2Uazhuh7UExUEeF5zfG2kwcE83kft5ziF4hlPWJ5HGas/mKKnhJllvIN7nlOJigP5Py
         CgX9r5TghSqCQGfhM14okaHIb6a3e9/9KsjgUgKKhTN54PBnKVO5opNrZ8shQPWT0ZVP
         6V7A==
X-Forwarded-Encrypted: i=1; AJvYcCW6CC2xdzj3V8EWnFxr8kMnGMjy+sKQ+AReUWxfw6mAPWQYQUzjoJkhyXvkocJowq/Xv4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX1CTSSuvOStqopjb24aRurE1/dWOxHGbIN6iERb9zMfFZePpP
	diKKc5IMmFnrcXqZ59gOnWlhkdufERuHL+kxLbRSnT3ckEP930LpF91ZJoD/FLIegH0z8TMwEbZ
	YQI0vjcUI7F5OLjCEeBmpWTx3AmnjUW8Wplju7Z7w
X-Gm-Gg: ATEYQzyl268pFhNb+6fQMjmOd2Be+ErAbg9ZS8HZNtIsKFoVp3EVevHOHdP96/T2Y8N
	IIfiyYYAnTT0wN+aXxficydOKpI2FirvwyqFqFvQYhylGdKWRZeBwejngZhmrsDlz9+94tbDLFf
	kODFOHfb11/Mn0ux/VbV2197fuommw7EkZ+4AK33X+5P3sVxQsdKHsMR5xaPz7F/ayMi4uFKZ2y
	zuigiZS35OiYlzvAqhaWsaEU8GMFlLfdAJXsxO2NUPNh9QiNZiRzZnjrnblCYEkfhVsF4ZokxIM
	qdv4Yj6M
X-Received: by 2002:a05:6512:24db:b0:5a1:44d3:7601 with SMTP id
 2adb3069b0e04-5a162afb717mr3098120e87.20.1773684710999; Mon, 16 Mar 2026
 11:11:50 -0700 (PDT)
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
 <abNOwcOTXqxCxNzt@google.com> <20260313083918.00005731@linux.microsoft.com>
In-Reply-To: <20260313083918.00005731@linux.microsoft.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Mar 2026 11:11:20 -0700
X-Gm-Features: AaiRm52c977M5CVgCJmgqL9NIwQ1v_KtuafdRnOMJexlLUpZndu_UH9phsJ7tcA
Message-ID: <CALzav=eGLpo5nrsHq5L8bUTC=FWZ-SgrTE1FoScrWB4p+NDgnA@mail.gmail.com>
Subject: Re: [PATCH v2 10/22] vfio/pci: Skip reset of preserved device after
 Live Update
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 8:39=E2=80=AFAM Jacob Pan <jacob.pan@linux.microsof=
t.com> wrote:
> On Thu, 12 Mar 2026 23:39:45 +0000
> David Matlack <dmatlack@google.com> wrote:

> > +config VFIO_PCI_LIVEUPDATE
> > +       bool "VFIO PCI support for Live Update (EXPERIMENTAL)"
> > +       depends on LIVEUPDATE && VFIO_PCI
> > +       help
> > +         Support for preserving devices bound to vfio-pci across a
> > Live
> > +         Update. The eventual goal is that preserved devices can run
> > +         uninterrupted during a Live Update, including DMA to
> > preserved
> > +         memory buffers and P2P. However there are many steps still
> > needed to
> > +         achieve this, including:
> > +
> > +          - Preservation of iommufd files
> > +          - Preservation of IOMMU driver state
> In the interim, what do you think about moving forward with noiommu
> mode without preserving IOMMU driver state?

I haven't gotten a chance to look at your noiommu patches yet, but I
do think noiommu will probably be a good way to develop the VFIO and
PCI support for Live Update without blocking on IOMMU driver support.

> I=E2=80=99ve tested your
> vfio_pci_liveupdate_kexec_test with the noiommu cdev, and it works as
> expected.

Would you be able to send patches to add noiommu support to VFIO
selftests? That would be very helpful toward allowing us to develop
and test Live Update support with noiommu.
