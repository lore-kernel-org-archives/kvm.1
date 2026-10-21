Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792608694;
	b=0UfoAiftg3BvDh89L5uDmnG6wxFCBN71O4qBuvuq8T7ZJFmPRgLupzEQ2hRpCNZuTOei
	 Y1m9cicI2EICBsbDfFrpGEhNaYoEJJlu+YcfTRtx3DD0doGJBpfYD7pXhQF7g4QNzVO3K
	 XT5jSCEc3zzn3Fmlmu+hBbNvKTAitJfq78v1IHwPmuqHRLaNiH4m2SjCE8FXHLniZ8jSZ
	 ezeorhQI6akMULShVq9wf6Hfihgf1GKUZE6VCU0wafh++RN0riMm9416cq6C2cLamEk3r
	 +Kaoj2gE3l3PVBM/e4vlkTA2CyLP9m0BVNccutjcwIq605DBEyKfI7B+U5pHGxf741A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608694;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=V2oW+YxRWdAsPD4uJs1XKcHYT7T/4QzyNKf44tXuYtg=;
	b=o4KVDUQBFqm8c06jS+IFQZO0BkPs/mb+5V9UddWWIEIOl0AHMuRUYFV0apadHlaiOuK9
	 OlBm4eBuu+EtiIEHuyMJwTjotmb6nwuf1mzIwfmyzomXlN1jksjPTfgEcH1KM7LwmFnnh
	 5fQLgxZprEcBYnqVSpIseMuVNaQAIUWszsI0AwsLdk9gS2kvsG0ikTjsITR0CveslqRVP
	 z/DY6Ww7kUA9Ru8Wh/boq1hu3QWoEkhn9M5boEHePDEvpxKUmEI2QD1lSX8VP68u+zqwf
	 BMuz01h3QKFm27qUvsOmIMmYa0HZSPWQKtk9YWG7euSNMyT0I3DuvWO7ghPVy1EYnmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=HlE8O8AN;
	arc=fail smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1118606A31D
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 18:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1118606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=HlE8O8AN
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6ae14eecc64so1465392a12.1
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 11:51:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792608692; cv=none;
        d=google.com; s=arc-20260327;
        b=W3PNHlfg5L1YjZaKcYP5Bpk1wxVQpOdTOul/y59yGw1WipPIjvN2RMGoKYyDH8D7Cm
         pM8yjLGz8w1fLNk5s6zfoVvPIIuMePFy/SzlUBnCyo3Z6hZOQs+/ou3huMQTW+jKc4vy
         d6ZIEdDR15DWlmWHPr28MfIHmafd4xldwp0RjkuZQrj8im8XRC5lWCBBCLBdK5GY6nRo
         drjFoamsRP9T30fbiJlERSZfAtXAXyad/nY4dAP40a6jRDZxMEXQd+OmMTSWHiRjTDDB
         Xs9UBylS0S2LTVSq+ULwJgphuTSvpQDTAlJNpSXbUv2RphDZNYuu4BH7np1W6abu4MZI
         /fIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V2oW+YxRWdAsPD4uJs1XKcHYT7T/4QzyNKf44tXuYtg=;
        fh=E3gNrEmzuXnBSSTVYGaX6PBwRQ2pPBfxg4zFuYSg6oE=;
        b=SAPKeOaAnuUcMaqsaT9hEQsYZwAG1rdQNF0p93wbNpTETSGKWYmVw0X0e4NGXZIdu4
         JNVg1hQ8nI4j1k92OowOLUQ4cZfep4u65pm3sEStP1k+UK8G7Ct6sQDgVqaX1F/VsJAh
         oKiTQPMzy2tzDGegx71GosTVrZlALug0xuFKjYvF+nczGLMnEcpXaThzOiMBubm1a6Mc
         lzCeXuswIHFq8gIu6iz+XGH2ZOqV/pGx+a/hIZJUL/wS5qR7icmWBLh44EXzMLpcvHwh
         VUP16gsw0vOCUB3JydkOah6LKTkW/FIphAKAPJQxitKbofChYOiLQ9aDXaneO0/qXEwC
         WRXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792608692; x=1793213492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V2oW+YxRWdAsPD4uJs1XKcHYT7T/4QzyNKf44tXuYtg=;
        b=HlE8O8ANX0EKpSe16g+iBaKuq+PflNI/nF8nfZx6q4OaNXjnD3WcfTP3ZxUZ6C5yww
         AQBlVf8uKRAHdsAZlJ3nOI2KRDtgeKEzjh6KweWDxu1SToMmLpwutL5+Lhr+woZoPbMT
         N1VnHlS+CynNKAT7F1IUt5thcgbaiveM8ggBR3Nw16XMDjcQGNRcVcNo5SDcaGJ27VgC
         SQZcks2KlihqbrkzWQ6XLWFtJ/xz9Gpgi9JXe2qQ02aMC2CNEezI26fvbSwiRyYprEUe
         g6GxU5sGPGr92AGt2GfoO7lQG5xEts7k+b+8LB52OVC6Pn4O+EIbicTODb4yWZNAA2oj
         0ngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792608692; x=1793213492;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V2oW+YxRWdAsPD4uJs1XKcHYT7T/4QzyNKf44tXuYtg=;
        b=U1nwPT9e/VaJSTKgsGdcOXQ+6EIdYSUwQwxq7N6gBxAT+uL+ONAbB+ybq50lfQh2/C
         nIMd9Yu7cWg99iit9FX6sv8xl64FY0zaawuAvRfx8Ra2ZjuuGdgdzuoyesBM076DCjW/
         qUz5PcoXIIfwDUFKNQ1vvmpk7jHHiDnpqrr9qcJjuvLjU7uscyaFT2LdUNxHMxXvoUJr
         fBlPUHxBQnLiVaxYWbhuXm+H7CgDYdWttsenM4TJ2qX5HGfo3CbcC/w4vMjKiPmcSUZ0
         svh1n9W1mZt+JgjQJn1LnGSHwfc4WWzbgAabqpqgjiY28tfG7gTV/OuJ8O8sR4da3xNI
         PocA==
X-Forwarded-Encrypted: i=1; AKwUvBxlo+8uN2tyop0lvs+WT97RIXMMp2KIZVMR5pGCeIdQUda/QyezwrtynFsYvwzmABThapw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKpeEqztxsi/b46kG58bAmCdyIKl9T+Us+S/HUOyElUKAUwYu1e
	cTo7kSj+ltbPbnS7Vb3b+xNWvn7CYe9lP+Ka7AxTjQlymogAyXzbklTfyOIuBMDS8FutOac9uHK
	uri9KX3CYwkECcsjD0AEMjvx5QuM9WHC9McXCG/x54w==
X-Gm-Gg: AYBFou1GD5r0AuTaC/y7WwLTcgM5xXKt3zdXyshCnA9nFBowBc9fcODai0X7T/m7ZoI
	7/a+yu0m+2gikf8cFuRSJe8CpHD3t6reN6he47U1IUt/bNkleYcG5Sgj3saDaLDHOm0jGqTe56S
	szMIX6wXzRFhT6JnTVU95xpfv/2AMXZ5CH3uiA6dvR14aP0LYsCtDh5OCwRTHvJvgSW8g02FQjd
	QMeaTTXMNgblkttDbrmSXPuqNW7Kbwgn9vgyNokJdlxoenT5EBDe04W+3m+ci4T565GzJPqr2s/
	n7sy9UYGz3UftXC+jIcVy7fP/BNlxbiumLp55HdkYaQONFxM1tAFgpUwNp6VI+Bva6XDQweO2fA
	6nrAMaESspPTXAXkTY7sdsV6+m0HkNaPb0y1/7yaM+sYC6A2x1nCSPisP6u5xd34g8mQ=
X-Received: by 2002:a05:6402:241a:b0:6b4:1df2:244e with SMTP id
 4fb4d7f45d1cf-6b41df242e6mr53870a12.38.1792608691873; Wed, 21 Oct 2026
 11:51:31 -0700 (PDT)
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
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com>
 <9huzecdi6go0.fsf@tarunix.c.googlers.com> <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
In-Reply-To: <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 14:50:54 -0400
X-Gm-Features: AclHuK9td__2XcAMViewCe_NhDoA_TjTC8gr4y8u3SANqGewpEKZoTgIKv6iXME
Message-ID: <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: David Matlack <dmatlack@google.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 2:47=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Wed, Oct 21, 2026 at 11:40=E2=80=AFAM <tarunsahu@google.com> wrote:
> >
> > Pasha Tatashin <pasha.tatashin@soleen.com> writes:
> >
> > > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@google=
.com> wrote:
> > >>
> > >> LUO and its file handlers validate handed-over state with monolithic
> > >> compatibility strings ("luo-v5", "memfd-v2"). Any change to a serial=
ized
> > >> structure, even an optional additive one, must bump the string, whic=
h
> > >> breaks live update between adjacent kernels. Replace the string in
> > >> struct luo_ser with a feature header, so that the target kernel can
> > >> accept or reject the source kernel state per feature.
> > >>
> > >> struct luo_feature_hdr is a fixed 128-byte header: the serialized
> > >
> > > This patch is all wrong; 128 bytes is far too large. For every _ser
> > > struct, we only need 8 bytes instead.
> >
> > NOO, It is not. It is intended to avoid complex mess with unnecessary
> > over-engineering.

128-byte per serialized struct is not starter.

> >
> > >
> > > The first 4 bytes are the size, and the next 4 bytes are flags (i.e.,
> > > 30 feature flags + 2 reserved bits for flags extension). The last two
> > > bits of the flags indicate whether an extended flags field is present=
.
> > > Each extended flags field is 8 bytes, and its last two bits indicate
> > > that yet another extended flags field follows.
> >
> > If we will have dynamic extension of flags, Think about this.
>
> To support dynamic extensions in a backward compatible way you want
> something like this:
>
> struct luo_feature_hdr {
>    size
>    flags

__u32 size
__u32 flags

>    extensions  // offset of first luo_feature_extensions (or 0)

__u64 extensions[0]  --> but the size should be specificed in
declaration macro that I showed in the next patch.

> }
>
> struct luo_feature_extentions {
>     flags
>     extensions // offset of next luo_feature_extensions (or 0)
> }
>
> And then an example serialization struct would be:
>
> struct foo_ser {
>     struct luo_feature_hdr header;
>     ... fields ...
>     struct luo_feature_extension extensions1;
>     ... fields ...
>     struct luo_feature_extension extensions2;
> }
