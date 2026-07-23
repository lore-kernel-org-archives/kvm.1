Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A1B37F329
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822271; cv=pass; b=r7zEGLwbc0QQhqBlHYzSuOSRL0SZi0BWaWqnQoKbhQrffmE6M7H6uuJCRrDsRyg6JsusCuamddjNkYfLmJixhXoTCBKtXrKOv/TSjkLJdSUhWmfzCh2M8pCm5vW60T/TnQYthe5mVNx7mv9omdYOgDVfeEecYXNqRf+VKMAgVPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822271; c=relaxed/simple;
	bh=4ZmdLRAwRhVA3ItwNfEmhlTcL+6V4/NZawCrqGpdiAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQ4pzSeZ1p3gsBLPgjwfGxwiAJoXy1U/mqH1yNwmPVmCyjcyKbSkOIxVRF6bQ3cvcpdbQMdyWUiGHD/0oPOsRnWIIs/6BzL5K0QyYuWV5JrWgdhYbTULQmh14RFsNIe/N+JQ0NIYj+3hpJRGpdQiprxPLTAF78KhaSB9G1PVmMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LbyhNCL6; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LbyhNCL6"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso11216a12.1
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 08:57:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784822268; cv=none;
        d=google.com; s=arc-20260327;
        b=IZ8s8PIdAuwohIOZDLJyiLVJGhmciNgxFpDSIhAw9I4D3kFC7zswI/XqE9553Jdzg0
         PIY5o/CdbxeA1t4cUOqOlQdZU6x2Jw2in64lmM/lG2vEW7bU3wleDGqz/Ts1mP3aYunm
         J+RYTvLXPyZnoJbFoAhoZryStwxGBfFVSolgOtfVP2BTGw+bgx2oruNS1txU1+IV6Qk2
         5s5ckU4xwtCP43FrURfZTwBTCQP/yFzRXTzUIoHNBv1pculiafHYcronpZfvnlp90DZc
         8hs1TG+Qa4854gXfJRh2XRiB3Vng2CTzb6XpeUm4mKTMGoAooJ6P00cOkdmAmrHSmorL
         wl3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9neiLWUPMueZ0VDmhCVTuptxRjCKWXnkm12Yzd60Guo=;
        fh=smwrDf2GnEXKPf1LqCG04ByhUIhMWXwQfkNuqRIpHgM=;
        b=r2y2ZN/EZcWrjhZdQfkUgI7ouAcLBLmagTf/MSWftOTwZR2vHyTGJcAK9/Oo1nfPKb
         ajLrryyqAm4/bs9sBUh/uB6CwcsHXkBZlP7aEDZbBl6DMXeZo+fwG6z/hjoCU4PJZ6Kh
         gkLK/fgpYuyJSxRKJ6F2ABXoBJQRCiBuaKjTIekJCMdSdtvQc2Lej9/6/oupTV9amSfB
         GFuthW69K0MwcB2zI0HahMv4VQRlccxP9wbMYNBn26iax0yRPtooMdPJIxeByoPAXUqw
         ySNweuAkKNqSiMb8i74P419L6CJp4N1qyqvHajslmexioejDP0izs051mThhjULAqFv1
         ClSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784822268; x=1785427068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9neiLWUPMueZ0VDmhCVTuptxRjCKWXnkm12Yzd60Guo=;
        b=LbyhNCL6sCpFB2uBLM9Jtp559lRAY2IHJL+zZlBGwVPIv9oq78G2mfReMpMaWduHwD
         Cn/WGVJN5zLZ/m5mi1NJxtRgA6AsEBZan50bhLlUx25IQzeDJuCXgdtEQgs7aHjokw4q
         /aKGZWqfwbEmId9DfTvsvSE60GQ/HeZ3AvJDXJLutfHhrqlAFt/znnz7jfLJverPfajZ
         d37d3e9UWYdUn0DX6F0uJ1X3m31VIraGbTBfD6af2NvvNnQFytQdvzlE6grF/QDFULzX
         wV+0yuaqm5VqcUrzJBGIF1xai1yt6eFbdziCvT/4onjeqjRDwPpGlKIoyGzt0RVGVigb
         EL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784822268; x=1785427068;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9neiLWUPMueZ0VDmhCVTuptxRjCKWXnkm12Yzd60Guo=;
        b=GV3ySB3gmQw03OH0nGaoVWMdSB8mJsCZGiAD/XrNH3RyUJXYlaMOQ/RAkKEKK2kCEq
         T8t3hQDMdRYbGtrsdhYeVScJ9aRGVoRrVl1XrxRkOV1qEGMI+lluTPavs3r0lTmsh5NK
         hXs2Q2W8XlWJwbu+hYYLNcTnQFD5Vy5NNXr+YnSajqMT1KcVnUAXZBMomuEhdfqtMYab
         fqDxB2kpDS7Z1aEtJVk8VA/mUlhaAe6yGx+bPzNIUnuZjHe/2zETpPvDWgxJZG84nk1M
         fNrmm/nvSPDtYfvRo/kAb9o0JgWEOWspG7cvBepr1bIc/i3giQxWAg54lWXE4mRX0Wu3
         nkcA==
X-Forwarded-Encrypted: i=1; AHgh+RpClMQdTnx8t3Qlgqlqbt5xltAOvyPkcLkBAu1RnNm0rcIZQ5WKQXfrba9v7GMxx87uDvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNd7zm8dswRTq1wUvdNVik6TA6OTSSZ9El8x5S4PJhOo43qd5/
	O7vtwr+VvrzH9tDZigQYywLC75entWqYJHEroF4mDexk6St/4ikBLAccA84BoSkP2FzeybhYaDB
	GlXe6LRcKJvCSdWv6wg9rpBsy+sWv4tRVfHY2+sLC
X-Gm-Gg: AR+sD11Rk1jCFfBUBe0kIsLBFKUfwxzZWXvMxvhUuB5duZTXnaLFuVipYMNGrApeVkt
	FP/hvrVXn7tWUuPDMqd8lS2FmlpDDGf/ChhpPTMFNA+yY/3EZtmELjff0GoL50L7J2Brpfj6S4T
	6muRK4YrSwzyWp1OeuA8pDWiFiNQjQmOVV+XsO7yWFpEv1v7rLKC1rNTUdDyfNZvbpwzbPzMnmt
	y+fOi2QZUeBIgH5N/SyLqIk29UFHT53JraTUP93pIEq04lnVlx8ZqrRNXMhgQ==
X-Received: by 2002:a05:6402:a584:20b0:67b:7d05:60b8 with SMTP id
 4fb4d7f45d1cf-69f60f176d6mr68653a12.10.1784822267892; Thu, 23 Jul 2026
 08:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9r8zPnXM1rypG8=YVsb7bir3J084Sza-0onnNX3s=uPK-JWg@mail.gmail.com>
 <CALMp9eT2W-oPtMpFdHZi1=F5MwVpx1YWKTh4n+O=STz7N=F_qg@mail.gmail.com>
 <CAO9r8zNso+8iKgiHc_VnCnTLKor-mGsFEV1U1N=RVLdn=FPNUQ@mail.gmail.com>
 <albJNb-akQJ97Yor@google.com> <CALMp9eRGx=K+UBp76A=dZ=bD_Txonq7j8pSn9HVczdtyyuAs3Q@mail.gmail.com>
 <amE_nPDem-imSfqF@google.com> <CALMp9eQL7y5chFEDCrqMR9CbJgiJxXN1hVzxVzojsr92AWnqrA@mail.gmail.com>
 <amFf5MAhc8sUqeYV@google.com> <CALMp9eSssBCuTTWdr1qT2c4Nto2PQO-QOBnobcx2kTnuQaOB1g@mail.gmail.com>
 <CALMp9eQi=604LVn=ZMnzoUy55LVb1qorKzPKm5HVK_ACsPuP_A@mail.gmail.com> <amIgLeMCAH2vB4ot@google.com>
In-Reply-To: <amIgLeMCAH2vB4ot@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 23 Jul 2026 08:57:34 -0700
X-Gm-Features: AUfX_mxX6mX8j3LGYEsZzVKrTJdHB5_M9HWyEB4jy4wsexAM7oWFTT-fi8Y06-s
Message-ID: <CALMp9eSgfL8C7SU+j6+c5s64end-n4uHh=uXtTpDVJ7RcvLQgw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/25] KVM: SVM: Passthrough the number of
 supported ASIDs
To: Sean Christopherson <seanjc@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 7:07=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Jul 23, 2026, Jim Mattson wrote:
> > However, since KVM completely ignores NASID, it would be sad if
> > migration were blocked because the target has a lower NASID value than
> > the source.
> >
> > That's an argument against changing it without some kind of userspace
> > opt-in. Increasing it seems safe, but if userspace just reflects the
> > value into KVM_SET_CPUID2, then an increase would block kernel
> > rollback.
> >
> > In any case, I think the new value should be a constant so it doesn't
> > imply a migration constraint. Perhaps we should adopt the highest
> > value reported on a physical CPU to date? I think that would be
> > Bulldozer's 0x10000.
>
> Or keep KVM's enumeration at 8, then find somewhere in KVM's documentatio=
n to
> describe KVM's behavior and provide guidance for userspace, but otherwise=
 make
> it userspace's problem to solve?  I'd be a-ok with that.

That sounds best to me. Document that KVM ignores the guest NASID and
commits to always supporting 2^32 ASIDs. Advise userspace to populate
NASID with a power of 2, and perhaps mention that hardware has only
reported three different values over the last 20 years: 0x40, 0x10000,
and 0x8000.
