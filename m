Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792751909;
	b=Qniy+7yvZH5+lOVWWHBAJEQD8BQ15VhqjSCfBdyjItwRY7oYAXxioj3B4TRGkAxuLNJy
	 kWaWMj82ASc9LNY0R5TOgu6OOH3TR/Cb66MQAklKd2lS3V+uucggrEk2lJimWF+Kz9gFD
	 u93vccNzKCSm/uYllBGakRA+SwBv6UAVajVGrLLOU6fwCJLzOMFt00ve9ock+yve1UWaT
	 m+Ff5NP1pqnyG6K+rJyb1qnyf+8Dy6D1OJ7U6CZqdO1qH2k4je6bIhK/9YrO2j1weDsKj
	 1SBDKD0VRhEXsLNYkbVJKrtoPUwFssE0/WkTkExwXQsFCfD1/LJI0dkJCpwoVjQDZBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792751909;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=cLLRVkOcST0DyQ8J/JKflZi0Zz/mIu85uAsHsW1TVFg=;
	b=5Lk+veLPLNWNGl7PpaL0sjMYn5CZ7TuQAClFNgQoWiHXicgJcxPOCk0pTfEO0p33BWCT
	 ZP1XslkpIRu4VcBvAGXuJ/RLs/PYO6AwUbPD5GnfpD4IL/0YcbsJIIp5Nse5Xaoi7X/qn
	 XH9uhqH9f2uBw2a2k59ITXskeJwezSVFJvcuvxGwhyS/ZKmeyhqo0cD616PeGlq7DbLru
	 wm3gIdBijDeDRQpox89jxgWf002ef0rfT76kaqwdCCT3IlJAE3uC2ptFo3uctKoCpe383
	 bk7+8HTkCiWvow/lSRApyBagNa7z5Rx2jqFK2YIOPv0RF8p6Bq7lkKG8h85KTbnmXfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vfClfbAy;
	arc=none smtp.remote-ip=95.215.58.69
Received: from mta1.migadu.com (out-69.mta1.migadu.com [95.215.58.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AFE606A31B
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 10:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95AFE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vfClfbAy
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cLLRVkOcST0DyQ8J/JKflZi0Zz/mIu85uAsHsW1TVFg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792751905; v=1; x=1793356705;
 b=vfClfbAyy9W87INmPAnQRLdM7z9pEaINPiM00p1v2g0GLj9r6L0GQpWJqxVXwZS/0RGLvLJ9
 sEJERkcBQ/Pz5i08ZdfzIHlsMTNCsqw3Nn295gHeRd92clsIhEipEMAdh4OJnysnDPPgKmhN38t
 RzcLV0+K9oNUXatYiIrgR4K8=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 854281266f8ae093;
	Fri, 23 Oct 2026 10:38:25 +0000
X-Mizu-Trace-ID: 854281266f8ae093
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5bcbb378fc9so6903e87.0
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 03:38:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzLndC4d2U9ZUr3+swJngevcVVkbx3MOnNNvOWrt0i8DJIxhzsKN4wAnkO+eeNyboAoeGs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBKNboXpawBnER9T1F9t/H+xFWvCE5w5xhpIyhEAYCQ4TDa4ka
	m95jxGVawjuNP4UCksIZWMW9LOXXRqURbdqJ+YF9hTitwfVU+0GaR6wGDs7ZmMeivTQfJ/66zO0
	zHpv6ClO2sDSc698SsLrnCh6m1DA5Zbkbg9/QvVAr
X-Received: by 2002:a05:6512:3e26:b0:5bc:fbf6:2352 with SMTP id
 2adb3069b0e04-5bfb06d38a0mr119014e87.9.1792751904240; Fri, 23 Oct 2026
 03:38:24 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023070110.1833446-1-fuad.tabba@linux.dev>
 <20261023070110.1833446-2-fuad.tabba@linux.dev> <86fqxwzul7.wl-maz@kernel.org>
 <CA+EHjTw08SZC_3Uodt6ew6vXVH-doW-8G41fVCF-rmaKsv+0fQ@mail.gmail.com> <86ecdgzp6m.wl-maz@kernel.org>
In-Reply-To: <86ecdgzp6m.wl-maz@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Fri, 23 Oct 2026 11:37:47 +0100
X-Gmail-Original-Message-ID: <CA+EHjTy0jpY3sdVCENJRj_kfRDwbZ6TpkCAHQ2xUO-7ZuErpcA@mail.gmail.com>
X-Gm-Features: AclHuK-Z7-qsjF596RnJ21sZzB7mzj2vXd60dbcKuOxyJq8KgdnvpDHBkQR87RQ
Message-ID: <CA+EHjTy0jpY3sdVCENJRj_kfRDwbZ6TpkCAHQ2xUO-7ZuErpcA@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: arm64: Hide FEAT_LS64_ACCDATA from guests
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Zhou Wang <wangzhou1@hisilicon.com>, 
	Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Fri, 23 Oct 2026 11:28:17 +0100, Marc Zyngier <maz@kernel.org> wrote:
[...]
> No, I want this fixed by enabling ACCDATA support by default, which is
> what we have *already* promised to userspace, and see the fireworks.
> You can add an arm64.nols64 kernel option if you want, which is
> consistent with what we do for CNTPOFF, NV3, and other extensions that
> depend on FW enabling them.

Will do. v2 will have your patches 3 and 4 from [1] rebased, EnAS0 set
when the guest has LS64_ACCDATA, and an arm64.nols64 option.

Cheers,
/fuad

[1] https://lore.kernel.org/all/20240815125959.2097734-1-maz@kernel.org/
