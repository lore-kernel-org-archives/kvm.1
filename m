Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792426243;
	b=Z0nDhrssp+3ynFuhXQuNV2UKKUzN4ak+uOby/U5UUUrsvc0/Y2sC+qETroik+lSuE72F
	 ZzLLgN+KF0mOs+om2xlU2wo6TMD0NH2HxIjWWEPKb+NBfhiHojJiE4yz9wDtgfv6LvAi+
	 oiTxSzAmGxnJ/RfvkNzus59+Zxgx4MuJnicvhQvofYhKZ/onsEEG8v7u5NjNhHLMjTAy2
	 3nt3NnH1KiXMYN3TZSqSGUmY3LGjA9gFf4WPlR2lN3lE3N4AVvcelObiqnS+qqArxtI76
	 txRBQXKe4K/3vUHcNiQCEO2UkPxXoDawXhYSOROOdROPo9KkAH/a1cFCRq08EGHtBeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792426243;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Kf+lbs9v+6E2jWFkaeqWJS3Ibz3SI0AKrIKdFU2DKIc=;
	b=T7jevO6v0Ab0yIFod68ouF7UdfRzMh4zLUPZVTHUV3C9m+z+lq7uLAVp3Z8GSrDkSU+K
	 Vq9neytWsE8gGP9STD7M9CJBn+rE2aIs6OSGG3UbPfdhL48qlxh+WE9sZOmljwmVgNQWK
	 pmwdK3sBAZXYgn+oS+q29fJVQ1lflwLvXSndVnlH0HnDnmD9EUZB0qKsv/BJvlI/B5Aha
	 LaoC30BNdHfoYwc1xl+6Y/yFwp3oCU0LiHYckSXFzrsDBkZsR/bGFOfM7QF6N9nbo9NSS
	 vRoPChnWO2IUHP+7dQxw/SD3hkSSDQNPHEfmbBMwrxkzG51RCuNNfzY9jFvYHaJwjHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="nwce7S/v";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6AC606A33E
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 16:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C6AC606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nwce7S/v
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac7c7b3a90so1082569a91.3
        for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 09:10:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792426242; cv=none;
        d=google.com; s=arc-20260327;
        b=HvF3/ynLcicQ4F5LhHAlafR27oez05hc5O77IoXfIuQiO0zwbtmYEq8/2GNpTLw5i7
         xzqUHQQerf3KnWVxV0t16eDs2PKpNfpyhkdeaq8wLKdlVfmiQ334IOHuEFmGHbNLMscF
         9pKtNYDzoLjmggizJBe7TKmQXM0wsgVYnsc7d+HM3iG31e1nk8NYx2gZsvBVqEu13v8O
         7Qo8ynoOn1LWgKwCsGswIZNob5Ol+mso1O8WSELRDGqZnFvzvPBu1KMt2R62CsB40ZWU
         7bQ3rEp9nInkum+xDhsNBwYnbeKoC8/iwEwssU8agUVaMnAmwXg1Ok50849tfi5vIbSK
         O41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kf+lbs9v+6E2jWFkaeqWJS3Ibz3SI0AKrIKdFU2DKIc=;
        fh=vbbMigChqbhXip1uEpRcwh25gFstmocjY96vH7jEEIs=;
        b=jhIYOvI3KEV+sumlbDI3Npo/uYcLl6twQ6d6TvigYnQsmBApzdI16Oz/JdGJuuUn8a
         yVG8mx8PRoilWj4jYS6ilSp1o5GB7GwQjpYxCBSxHoviORfm3SXOJJ07nAOr2hja6nVh
         ZIu40D4f6FFhT/qRbEFT2LrZ4BTOzzWeAcGiff+lW12sc2kH8UQq+QZUta9HBvP0vIx7
         IuUmBv1XNOixhxPkFZA071uytN1cwlKcbSfsFsAGSVb6C957VfCUdNkKm6Ibz2XoYYPE
         BDzwiNWW8te76AB7pXh/ikYYIzT96kU6snxgO7JzUPmZMyifdWPfkbU2yySTrgCLJNmF
         L/kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792426242; x=1793031042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kf+lbs9v+6E2jWFkaeqWJS3Ibz3SI0AKrIKdFU2DKIc=;
        b=nwce7S/vTMoqAwf5xtwZ968yrj96v05xwkxb+d9Y46U3mzPEw4km19kPH0dhCTAgYa
         mvEBSm7ZT1Qd73u0W/R/lgY4ohvJK2kJmlP2pDVYZ1dWnjRYo4odiEdm8yIQ9xd1zS2p
         ZQfy4TMY/8l35JpqV3IpDrguh/ZNLDbwOv+FocYxVqScWejzksmBbR6Vln2Bx9mOHGgy
         FO+h9DRY2ZZxAUcYA4MtTPYNl+LjRjZp1gcs91wHRgWSwy8y/D1nIUpP7Rnnx24UiiP2
         SXnWod24OTqySi12VIlVziSl/692SO1pN289VM9uZT95tHHcTwXQ8sv/YWgYqK/9LEKI
         RTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792426242; x=1793031042;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kf+lbs9v+6E2jWFkaeqWJS3Ibz3SI0AKrIKdFU2DKIc=;
        b=P+ugARuzzv25rWn5jV+MPZc3BYCygUIF5PvYAwk/LyiBeqsTIyTQI976mFkTeYnQJF
         KIFnUDol2xCsDiTwIir6iZUDpGJk7cNPZcMPL3zDdNBDCv2szh3DR9KTA7g0ooIdpbH6
         +Ex49XpUnElG3yLu0nGLw5BlfQO1FHegldpG+weuiZMr8sAIU06T7bW6NX97adIbzjj4
         f5TktEz0l26wecHkCZa2LYCqdpbUbWVes9idXigyboVPW5v72iSCnXBGcRnW16paGRku
         hmGMR0iLDttnLmv79K7/4UZSSOaNORp+9gxHbjRv5L4Tq9b0+uVxGhi7MNJWDRhYCxyI
         N2dA==
X-Forwarded-Encrypted: i=1; AKwUvBxg9fyAL5kPPHHyees07Nrx4i33/tZN7W9M+CITxOxSER9zP52NK4/ZoDGAxfY4kNhoyNk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIxk/NwNPJkHcf16LU2hSFY7EtjUMjHAM9RphyCM3/q8cKKCSh
	A9R94VExzfBvm4KbwJfFmNDPfGvlQb1gpP2cIas9eh/qegj5l82a3J9iOvEpkAATX6MgpqGv/7t
	xaZFB8vYiHHPZOF8pMpdFfCbtYAEEwVc=
X-Gm-Gg: AYBFou3Tr6uTTCVW9odnzX32nhi6MZDIiRCqYTsPJcHPNZswBZ6tDzgc/tujS5Kzu8s
	O0Zb4TVL7HhD5xZJbP8/p+8bks4gkt3zAnNAbfRAQRs2L3Sg1Un8XR2KogksoKJoQYM6LQ+Xlcv
	zlS/42XR9P26JCtc6sLsLfgmgNVuKGD7p6Qo3KJe7jHqF1Ji4KpXiBt7aVYDAa/P6fGNGhRMQE1
	MWg+IH5kljfDmRF/EAXvyM9+7nwDB/AHy8Cige85TCWMvUUtu/TgcBj9EvUj5hb3ssisGHPkrTZ
	jBBaBu0KT/0EwJ7QnuUyJeRsxuNVE0MplprF122ilrZA2GdOTu0SkAs4XI1O8a22IK03LaRW+8c
	1Ovsoa7ERTkYupuWNrQ==
X-Received: by 2002:a17:90b:5623:b0:3ac:9a54:e3ce with SMTP id
 98e67ed59e1d1-3acef6391ecmr7235023a91.63.1792426242489; Mon, 19 Oct 2026
 09:10:42 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015145053.3664509-1-jiri@resnulli.us> <20261016234354.GA664420@nvidia.com>
 <CANwfdvXFLJpC4Bc1PwRoUUP20fu2K8b+FHZ1JLLFXAikC-cBaw@mail.gmail.com>
 <20261017203407.GM13920@nvidia.com> <atPgqROZZxnihYfC@kernel.org>
 <20261017231007.GP13920@nvidia.com> <CANwfdvVJRv6++MJ8OCUnHSR_5nVD8Yv6eTmYxxqfzxEk0sNfpA@mail.gmail.com>
 <atX9fugGUsI0hGcA@FV6GYCPJ69>
In-Reply-To: <atX9fugGUsI0hGcA@FV6GYCPJ69>
From: Dionna Glaze <drdeeglaze@gmail.com>
Date: Mon, 19 Oct 2026 09:10:31 -0700
X-Gm-Features: AclHuK-94VeGPXxFeBfuxcNfO58AYvUbUlLP8AwazUPyHejofcyDyE2ymf8gT_k
Message-ID: <CANwfdvUhuQ6L+w+91iDZD=diMmaJ6_2ZsFKkcoiKWOmPMC1oKg@mail.gmail.com>
Subject: Re: [PATCH RFC 00/20] attestation: Add a common subsystem and TDX support
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jarkko Sakkinen <jarkko@kernel.org>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, david.quigley@intel.com, 
	lukas@wunner.de, ksinyuk@kernel.org, rodrigo.vivi@intel.com, 
	cedric.xing@intel.com, sameo@meta.com, James.Bottomley@hansenpartnership.com, 
	aik@amd.com, jpiotrowski@nvidia.com, qinkun@google.com, pgonda@google.com, 
	jic23@kernel.org, alistair.francis@wdc.com, ankita@nvidia.com, 
	suzuki.poulose@arm.com, kas@kernel.org, rick.p.edgecombe@intel.com, 
	elena.reshetova@intel.com, dave.hansen@linux.intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, peter.fang@intel.com, 
	roberto.sassu@huawei.com, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 5:08=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote=
:
>
> Yeah, I was thinking about this and went back and forth. In the end, the
> only reason for leaving it unbounded is to allow multiple independent
> users of the same register. For example, IMA and systemd could share a
> TDX RTMR. The systemd side would read the journal through the
> attestation device and the IMA side through securityfs, but both are
> views of the same journal. If one side truncated it, the other could no
> longer replay the RTMR. Isn't this the valid usecase? Do you see how to
> resolve this?
>

Bright minds have spent a significant amount of time working on this.

+Roberto Sassu, +Mimi Zohar
IMA logs and systemd logs are both system level concerns that are
relevant to the OS construction, not individual users,
so I would just say to reroute IMA to use ctlv using a kernel config
setting, then make systemd the new system manager of the holistic log.
The securityfs log contents can simply say, "log managed by ctlv" in
this setting, in the form of the template identifier.
For policy violations, only the 0... extend needs to go to ctlv.
IMA can still keep its violation log as a ring buffer when it's not a
1-to-1 violation to extension
https://www.youtube.com/watch?v=3DgyYUYbdiN_4
