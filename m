Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795043262;
	b=LnwrGsEKX31zDBwaA/hYk/wZbPP+uR1T95ksUTf6JAkzkAEIwpOF28t5+a4yXH8fI/zj
	 jmgYGVf7uPzpu6rjcPiHDOi6r/xL7CtyOAQtIU7VkkADfZqiz4YmnL4MDwu1tR1CaoxbQ
	 ymW+bXcTiNdnczylJujYXdL2kVytWR8LiHRhnn4gZF2F5LrHUS4IiFXx0jCpmwlB/7mKH
	 5mY2/C2cZVti17dthkVmcEE22RpTKzTX7R45hESEXUJ59utnH+nnrDhtvxOC//4yUmgRC
	 JEAwAVYmVUX5YZlsQCOvki7jS7C6gU+sJ6QI55+xRnYLPZe85PvI9UlG7bhrGBaxflQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795043262;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZsnteUiE7AoucgdCezy+Beh13ePnYxj5QpSFFRjAmOQ=;
	b=a7lv1BUO86zRAscl8OEUUhPt+r/xnyBA36My2L1jmniGgVQJqvh50Xo1f2pAUbG5yc9o
	 MTIpn0eqtVGt2kdcWSzsHGBo6za48dMOWejBsJOHmpI5Xi+p5Cx9IORs2ooyLBdvOCcAm
	 EPreG0SBJskN51HWvAYhVy5CWH8TV49lmJVi+HBvYNHu3NfzyfH0FGekIXWKBPbVRGyaM
	 pUEn/2JdWsrXq9/smhghMrfWnmYhwK+i0sbaPMmleExVAiKAZnysmZ34JyMC3TZTeN8rC
	 tSoaQPPvJlSCBIxPKy783JWhZ5l+rGvNMwg4yJbcyHRssyxvdF26r6ovNTmT7aMdsqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FVHXOilW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D44606A325
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 23:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2D44606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FVHXOilW
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso5833a12.0
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 15:07:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795043260; cv=none;
        d=google.com; s=arc-20260327;
        b=V+FtgXfKE1Cmj4np53yuVMlcxIYM9K4vDxF29Z7PnuNK5+H/+JxO/6cQON6/XeZvmy
         v/6gvrlSbOmDNFPVVFF8vj4kE0IwVijjLSIkgMlZtyKEovitsaaQAb4ofkltpNOxi+vn
         lOcm7q1qKHkQLDmPVq2K0MvsnlN72NdPndHN+0GZysV9LWLqMZhtpx8qIM3zkp812Bea
         CBjhdw1PIS65PVaUCal9sMZrpe+IGLohef3TjaneI4h/LX//WYh9Sw9ski3osa5ZwhDr
         lU9d3LAHK/3tAuouxqvr0BAdtk2DeGKnQA/EmyxmewhJp+fa5x4j1YHHOnN2OEfXf8LF
         6zLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZsnteUiE7AoucgdCezy+Beh13ePnYxj5QpSFFRjAmOQ=;
        fh=aiqfIDSpYB24jYSqWkQ4vREFF/4+A+LrVdmIqIsOnAs=;
        b=YQGOtcbzz7jY9oeZYpJCItmUkYXGPJAFaPFACjOw9phLYXIDX+Qa7VAEUkLWFw/hD6
         /OyQnupLZpmr8c0+LMK+V6QU4BZDmIP3t963lSmRlVeZSCV7Xfh6VKKY4h97mnGuLPoz
         hrKaLzpOUZ9Qtee2IINX4dj2rx2l+VodYv7iBOO/qt42A0oK4xczrjN8Gj1zX5fHB7B7
         ynFPt8H8sh/44B2DOeesd0wCroMirq0vzMLzhgUR8FYaVSxDwvgpQOVSritHrFX0TmwB
         m4A3AgUbFePLcoWyQDYCpdcfPD3v8fsGy+UqROOQFOjkHAkxsdHNfRu8dkmu64WeyS3M
         wwVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795043260; x=1795648060; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZsnteUiE7AoucgdCezy+Beh13ePnYxj5QpSFFRjAmOQ=;
        b=FVHXOilWQOUOss8ZcPkgYMn1GXdWVSFzFp9SyplOR0RgbX0DTboMjWArQiDhVd+ieS
         YK4HR+AA+hla4eQJj0sjylxCf+2UJTTMc3zaYKc3xMKO7LgM+jGGMuk8fuCJruxqU7L3
         VfvfkBKhfvUrpnWU4SZNL0ZEhv2q6XADFUgTGd6PStOCdGV7xG+vHUvr8a9Pd4nDynj7
         aEcC1/ui62LgGFWiayTiHryboeGUZPZLKuWpPubJiFABRP7nFBta+Ry93OaJ2gc1MxEe
         /J7TV7i5L3hKQrm8DT34NfmXYPb9vy2t29GgZIHIQYHvqV3fv5OnVjDEj8FYr0h/+r3l
         mSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795043260; x=1795648060;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZsnteUiE7AoucgdCezy+Beh13ePnYxj5QpSFFRjAmOQ=;
        b=cmhTQKot081hwQuh3pusa9w1Oy/4JPAoOIgxga63FOcr1F6PSDK/IbiQd0mdQ0km3l
         RtyJ5S0jfRraYMwXmBjJMpeBxtgzRC0YtV0h3DGmWOghVoCs5Xy0Te28GZchizCmdxQ0
         Yh95NjCaORdgRFpP5A3agszgZhwVDIkp6BEMvCTi1S3cxbgrJsV7tR+UvRz03xlo50HC
         UOJEA3X670ZxjebiCPSzmsxZFN+lqgtx1wW7w9yDsGadVsMnb9Fbek0ZsjoOWjfjQBxm
         W6ei9IPqFYXm8GpDud3oc1+9nIKPvJDKA87yEhTvUu89DtyFyC9QYKyXWtBznqLIbV+z
         IVvw==
X-Forwarded-Encrypted: i=1; AL+hErH5KPmHu5svbrRcDF/L5aCIXo4rDrqoQeP4g5PiYspMArhHwLINtSUMBJC36x0Jo2e0XEQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9pw7BjPFOttFq+HsFuOiqZMTy++tucpS3xoLfihb3v49fHaPo+
	d6TorRP6DVtd1xPpCRlo+C1e/iTTf3bhnWygk3y+z6H+fiilCm1ObYIgCk6jZjb5xEgdnwrfUij
	Ud/yu9O3iEdeiww7QCfA5ahkWASNa+kQFIhVK0zTz
X-Gm-Gg: AYBFou0egiRHuh93s40lwArflBQXJNNZZQBLxf7tCWnfxNpjV6Rk5IhenVE7UmpftNX
	1M9lLAGtb3Cz4P6ntjHGAs8kuuoY92PcfRWWI18hDE3OgfZNobnOiY9N4qlbBrGKmNalM9e17I7
	uOcx/a+cKxWGDb2Pqqvn6LxhiLlzxrBS4XmdSvOaKh68E8eY9s5r0r3QAV8K131xE5Z8OhR0BAo
	ZLm3NaOnSmLoycjqJIbCGSIMmnOsjH0d4+JtgkwzGgiK+xPNfbskEh4M/ZROETpcSX+4Lg4LL+o
	0+l/6FK8yfKqSKhgoySzSfKcHLRHeqAzPKMI3abByQHRT3SUPA6GwBJbYMShIAg7VYFiIuvTZIu
	NqtPcPymQgG1env+88DH3Q0/pKYmphCqOkH/bWCWOzMzEvbljT+hxyqCyX7D/0wbXvA6prQAbNJ
	VZo2yWUlCvEWhjVe1Jihms2+D+aVXgdrxVxNKFSUwGU/p0kwbgDz3LsPO2AqLPkTp0923U+mUlk
	C8=
X-Received: by 2002:aa7:c598:0:b0:6a6:8513:7e14 with SMTP id
 4fb4d7f45d1cf-6ba0f58f665mr15291a12.9.1795043259812; Wed, 18 Nov 2026
 15:07:39 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117180310.921701-1-chang.seok.bae@intel.com> <20261117180310.921701-19-chang.seok.bae@intel.com>
In-Reply-To: <20261117180310.921701-19-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 18 Nov 2026 15:07:27 -0800
X-Gm-Features: AclHuK9Y5haQGqCxgaY0FAibvG9o4C1UdoD_Y-vPoZh50C837-aPXzswcUDXWeg
Message-ID: <CALMp9eRgPwHLWzO1UVnw30pvSvy5VYj=rwuMHMNadPLv=8V4xg@mail.gmail.com>
Subject: Re: [PATCH v9 18/20] KVM: x86: Expose APX feature to userspace
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 10:32=E2=80=AFAM Chang S. Bae <chang.seok.bae@intel=
.com> wrote:
>
> Expose the APX feature and its sub-features to userspace. Add support for
> CPUID leaf 0x29, sub-leaf 0, to enumerate the APX sub-features.
>
> On SVM or when using eVMCS, do not advertise APX, as EGPR support is not
> implemented yet.
>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
