Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9865C20459A
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 00:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784766302; cv=pass; b=hqewkD7ggM2QExt0RVdvPjueqX5c363NbMApijXyblh0Brl8vRVlCVgZEqvWTfYCAiRtBiPXHYTslr5wZeG8wilDPz8Jc1dSN/UEA8ZCBtrmyfOtD623qSQDF21pIvKMigsWbayNjfQ6/GYvnKjFwTRCeaFTh9oY875Kr25sttE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784766302; c=relaxed/simple;
	bh=kWEc23GO5qIxiQrzPxnHHaclfVo15f3n3UsjCeW8qhI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BLAwmyxDWD4FVboC5gPHDxUfm34qyHfs5uYSE5fOhf96nOLbTL2Ie8m6JkhFap+2aIDkY4KEz3GDEMZ8VaqgxAFsLJhU5I7NYj3Tn7JLzkNJ+LuqlWJqAz4LIDbpFUVCq9FqwXR0g/RbORvO1DJSjESCRFRnxBIr/yTEPN5jN2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oun6Zcv5; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oun6Zcv5"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-382ef647e20so54051a91.1
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 17:25:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784766300; cv=none;
        d=google.com; s=arc-20260327;
        b=jbCrNyAoAhh2hS2019r5Eozjnz1AHDvmtZPhMNsU+xQKWybK1XGa0nNBlP3IRIkJ5k
         pHlZWTGRn17vmZh+bV8/cSvBPDgpFhoHtdP9TMtZf0I4LbEGtAvDm6IZ6/WtQZ+AQCi8
         4M6ciOk3BEqcwaagmbvlApVpsRsBZuZ+SLWUEMhkafX7lNF5cWAQ9vNKXbDMmEaatCAw
         Cfvj7bCPWKYZ3URUKXODsaHgwMFxtb621HOYjOY8/jxdX00XT3/ed1iZfto5Cfp6eVbL
         trPf+MHSqSlYAh8q4ulrkTBIebfyD5Ej7u9tAiaEpu9F5j9UqkFTbdOKie32+JFDWwHA
         TT5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=QK6NTIZ7U7u2uxukmeUbpT6BYUSoQRmwBsUnN+HFDzo=;
        fh=XtYsH8P5WKIbfNVV5HBlPtryF6qxkeGzHzzP6mEq8WI=;
        b=Lh658kAtAJHY4Gke9MAqybt2tCm9kdpt0QvDovl/xe7LHCXdenfLfXpnOokpSuEWIZ
         dnW4neKhHRJ1xyvgoG/IJjk2FaRbk2cic+NveRa7GuMDy1kzfK1GdIFRgIucXzSZbwTm
         g8LLWHCbccte5dKIbMRA+JpRYwoFhL8PW0oMBYqP1sd8Yidt0pfdLytm1FiEZ3ixUTwn
         TKCSuAFICXPhsSYvjukrage47KlvTPv3Io4rozOnq1ea+dqEB+iunVlkIyJupADVEAhi
         x04UuvujjR3shMjoo/h/bCQT8ezd8//wxwIHcbtOvMGI/q95Vvixr8i/4t+ntkZHD2eN
         w/lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784766300; x=1785371100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QK6NTIZ7U7u2uxukmeUbpT6BYUSoQRmwBsUnN+HFDzo=;
        b=oun6Zcv5grp7EeniF7UUhMaLICNreZo8CbbWa0CsCUwKl8jahpOtGKIgiV7SzXWrHj
         OzMH0pckHuVqYSWq+ZTWV7nKkLUWQ/Gve+KmJYzR6tN3vJ2R6vqsL8slfTjqNANjNeUl
         hZzVlqN6I3nAlA6X/FMj+EYZL4GxAbqtPTiaUNcUYz32FaL7b18c8axc/iY4erLE80cC
         1iDhg62fKxdnGrwaQvazPXx10enxBUyBjJYiME4GVSVgcgnx3t7sjwaZHcZ7pe/7Yip+
         xSi5Br9ABIhH+4fFObiEiLfXP8q8xklfqqpY5zh7Ha+Y2mvdvOs/Lu8Dax6bngiSDYwP
         qMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784766300; x=1785371100;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QK6NTIZ7U7u2uxukmeUbpT6BYUSoQRmwBsUnN+HFDzo=;
        b=WDwS7yuoNy/Cd0S1xO6FmTHYtZqEZLPRfsOrTctuQHz4TyMiqyNWE5ExHp4Vp7ryss
         CLE2w4l5BBRnm7f1odIL9JVZy5ktyxju2+xX5hQuWPvmV4B1KJ2nmK2+XdV5sl8tRzcD
         pDp7QFwuo7Zl5+NaBm/H24k0zu3CnpYCxC98QWLYWoyU6obqQ9ErzfJtUlrMIzGgo5XS
         snsG9KtRoqdO8boc0A59pZBsBWGuCNWvx1ON5YnjLXIOakWzuuAL3nM/uPC6JvbfUqut
         nRl5+3qr05VQcIXm73dtTs2lc2t3RadMTivLvjsyMq0hgy0GlEUj6rDKzY+g+xWz4iI5
         9pZQ==
X-Forwarded-Encrypted: i=1; AHgh+RqkNQf8YihvcxAeen6ArmZ+hOQsDMq54YrTKLokGrDHbg39xieiFZS2RqwDy1HyIwPj1uk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf62rGIyVgeys7rj6Af5tW0hjAW19h1ivr2Xzy/YZAgLJCypkU
	o+8g7RPtr0eeqMAxvot6Z9JT98pbEUduMnAdZM3K9kUgixGDArzV2vZWVlvpgcCOUCC0BP/cB/A
	F9whKQBF8IZHZ0OF0Y+qSUiTgi21MvO5uo5On98/D
X-Gm-Gg: AR+sD12SRhjMpfVSb8RI8Rz9xmm0TcBGGuHbPPYc21NWbqfeaBtxNcrOcUdtDqgji+4
	ev+jVUMBDssRJ+5f72KNmOe4DnTPUonUyyEAjBAGmChcJw0FCOFk92VklayRciDexztkLqW4CCD
	5+E9JwFqB2MYtFcR9ktnzlYYSYvmHGiVPYZlbnF5WX+qumvCz0OqfAUwsaqYB+1ue6oM4u0Q/G6
	KRzxTynMikYCGcvtinPQ227VNekH2mtMnPDh9GBLqSyB++mKv4JQDjZExUp7XDcdzDdMkJPJMWf
	cVSj2D6ndwndGjXoAil+8QGOjp4jiS36U0Y0YuSRlywvEtp1
X-Received: by 2002:a17:90b:4c10:b0:381:5bd6:eb19 with SMTP id
 98e67ed59e1d1-38ec652509dmr815476a91.18.1784766299151; Wed, 22 Jul 2026
 17:24:59 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Jul 2026 17:24:58 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Jul 2026 17:24:58 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260720111259.122911-1-dwmw2@infradead.org>
References: <20260720111259.122911-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 Jul 2026 17:24:58 -0700
X-Gm-Features: AUfX_mwUpcRZcR396JGdaH8WFVBtAEhVFxsR1fJihR2mu_ygz-fygFCraN7fXhg
Message-ID: <CAEvNRgG-K2HOJoMmdMSH0gEuLNhgX2tqUAakoRqEx6noNyU3vg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/11] KVM: Allow alternative providers of
 guest_memfd backed by PFNMAP memory
To: David Woodhouse <dwmw2@infradead.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Tycho Andersen <tycho@kernel.org>, Kees Cook <kees@kernel.org>, 
	Ashish Kalra <ashish.kalra@amd.com>, Connor Williamson <connordw@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Zhou Yuhang <zhouyuhang@kylinos.cn>, 
	Zi Li <zi.li@linux.dev>, Dan Williams <djbw@kernel.org>, Eric Biggers <ebiggers@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, connordw@amazon.co.uk, graf@amazon.de, 
	fgriffo@amazon.co.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

David Woodhouse <dwmw2@infradead.org> writes:

> For dedicated hosting environments, there are a few reasons to prefer
> using external PFNMAP memory for guests, rather than kernel-managed
> memory:
>
>  =E2=80=A2 No struct page overheads
>
>  =E2=80=A2 Easily managed in 1GiB pages (or larger chunks); no fragmentat=
ion/THP
>
>  =E2=80=A2 Faster kexec/KHO live update (every millisecond spent faffing =
around
>    with memory management is an extra millisecond of steal time taken
>    from guests)
>

Also, no need to split/merge pages when converting from private to
shared if the host mappings can't depend on the refcounts in struct
pages :).

> Today, there is only one implementation of guest_memfd: the internal
> shmem-based page cache in virt/kvm/guest_memfd.c. This series allows
> for other code to provide "a guest_memfd". This is an early path-
> finding proof of concept tested with AMD SEV-SNP as well as non-CoCo
> guests on x86 and arm64. I'm planning to build a memory-based file
> system which gives files for both guest_memfd as well as memory-based
> storage to allow things like userspace VM and orchestrator state
> to be passed over KHO/kexec.
>

Thanks for raising this, good to know that there is more interest!

Vishal and I have been working on guest_memfd with HugeTLB for a while
now. I'll be restarting upstream work on HugeTLB after the conversions
series merges.

Vishal, Frank and I brought up having guest_memfd with HugeTLB with
VM_PFNMAP mappings at a guest_memfd biweekly meeting a while ago. The
consensus was that guest_memfd HugeTLB must support GUP and so VM_PFNMAP
can't be the only way that guest_memfd supports HugeTLB.

Your proposal is true non-page-struct memory, which has been on the
discussion guest_memfd biweekly discussion backlog for a while
now. Google is definitely also interested in this.

Frank also described some use cases [1] other than HugeTLB and the
regular PAGE_SIZE pages from the buddy that is currently supported.

I submitted a proposal for LPC 2026 to discuss the interface. What I had
in mind was to have the KVM_GUEST_MEMFD_CREATE ioctl take a "template"
fd. guest_memfd will then read off what it needs from the "template" fd
(ops, like you have here), and the "template" fd could be VFIO [2] or
HugeTLB.

You have a provider_fd =3D open("/dev/gmem_provider"), how about passing
that provider_fd to guest_memfd, where /dev/gmem_provider could
represent the page-less memory, like:

  ioctl(kvm_fd, KVM_GUEST_MEMFD_CREATE, provider_fd);

It would be cool if the fallback could be set up flexibly, like:

  ioctl(kvm_fd, KVM_GUEST_MEMFD_CREATE,
        [provider_fd, fallback_provider_fd, ...]);

I think guest_memfd should be the wrapper around other memory providers
because then the CoCo shared/private logic and special page table
handling for both host and stage 2 page tables is centralized in
guest_memfd, and also, KVM doesn't have to understand other, different
kinds of fds other than guest_memfd.

[1] https://lore.kernel.org/all/CAPTztWajm_JLpp9BjRcX=3Dh72r25ELrXeGkOXVach=
ybBxLJGS=3Dg@mail.gmail.com/
[2] https://lore.kernel.org/all/CAEvNRgFpJWQ5M5sQhGpQUV3GbBq9N+MQhhaxdxa=3D=
D8ky94SCsw@mail.gmail.com/

> This series lifts guest_memfd's operations into a small ops struct and
> converts KVM's own gmem to use it, so it becomes one implementation
> among peers rather than the only game in town.  It also adapts the
> SEV-SNP fast paths to page-less operation, plumbs iommufd to map a
> guest_memfd-backing dma-buf as CPU RAM (not MMIO), and adds the
> provider->KVM revocation primitive that makes overcommit-style reclaim
> possible.
>
> It's largely AI-built at the moment. My main design concerns are around
> how we tell that a given file is "a guest_memfd", and how we plug into
> IOMMUFD. Presenting a dma-buf was the less intrusive choice because that
> path already has support for taking pages away, but I'm less convinced
> that it's the cleaner choice in the long term.
>

IIUC from this series, you're creating a dmabuf fd out of a guest_memfd,
what does "taking pages away" mean, in this case, from where/who?

>
> [...snip...]
>
