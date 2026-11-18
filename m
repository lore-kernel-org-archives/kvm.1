Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795034123;
	b=IfkAF9mYqVemEbVJNcmF0vgMtJPlQixq/YHDQ7vJz3An8438zcsqqjykB8OdPv9/X3HZ
	 hTugqURG1lyA8ukSSX/MuMlY/XwWwlTAVaXqUYsxpgTXZDzggK/LisuLcgG1Xi8eDc1Zd
	 GwPjQldg+dGRNcL8+jKcg88TNdyzq1emyO29xHNFRTLCacd43pM1FCt6EZBiT00b8jq4T
	 1JyGxG7uwCdOQDPyim7i+UnwEVkm4Gcbyk/cdYmY9ehCBmrYcyni1Supi78sgGBi3iesq
	 3dHY3XUNFXxrGYPA6QWQX3+1Bhj/HDWAJhnxzvCqu71ZAP13cfS6M0KqX4Q++bQ7H8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795034123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=U1/r8Tac5IXDtWrYYG3dpfT9UXio9UGAzrSbVmuM17k=;
	b=j3gikxQkwVMMJhV+MAN6+Pf3eky4LEflGHfNWckay0HbbUVbhvCp2brT6W9k3Qdmk+6a
	 Rs8TE+h8djE79hEOvCUvs5UIW8iUnTxEfq3vOxihihtzQuzv6zrEHGl3pmeo3d7nI/Q2K
	 WjsTkV82cZc2StLjpF9Ob+aVzK/D8bo8nCutbvLnGbw1fUgPBXrwkuWbiwqClb/BwzNWu
	 uNZGwt7wYjp6IMFanXkr0/OoAgpSXk1zQGdm/A9RPaj8yEpfH8sQSNvX+hR5f5cvwNzv/
	 emnoxp6UCmN1RJyn/MhUEVL+TxAU+bwLLA3QQCp7hXRH8B8NG2XIjBkxUTKVzJvV/OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KGyGY7Ng;
	arc=none smtp.remote-ip=209.85.160.71
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA6F606A31C
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 20:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EA6F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KGyGY7Ng
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-4ae40674bd0so1049740fac.2
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 12:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795034122; x=1795638922; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U1/r8Tac5IXDtWrYYG3dpfT9UXio9UGAzrSbVmuM17k=;
        b=KGyGY7NgHD+M9L9D6556nDD9aFaMrIq9UYx17UtCTQIxrDJehYLXk9BTuTRDOT7XCV
         sCtOouzs71UmKBjnlAjTy+jMGJsRWPw2clssW7fbljC/SJ0IegRWULA0ujf4nLUzA6+S
         sngUEC1aqvilCRpAYGh5/iUk4faxEXwqAkfwn3yxdwnhlnJDsQbWGxAmdrwFdztH+Gon
         rgfrESmgepqXPDVtYMvy1mnGEomxy59tmzux/MPKNN+ihvDYKFhad8VvGuRFHdoijWOB
         6YOYlSMWs3Rq2462wbNj/kEGizMRcj/IUf2JXGT944Evo3zlnsJegTjf82EgkKp85bO8
         YyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795034122; x=1795638922;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U1/r8Tac5IXDtWrYYG3dpfT9UXio9UGAzrSbVmuM17k=;
        b=NKW4FZI97VEuwSf9U/SKgWrH9nswQ53lwvGI34duUiSf4BJYC7UbHduJcjG+OKi3kV
         iRDxg2amZO9jkG/u6dQQUoVZK6cLCJs4zAyWKU+EtFWBekjWsloj7NXmjx3xuwtV28eP
         qlmI/k/Wem4+rEDHjoL+1zyRXCksDqvPqxRe3Cb5WLJCOm35UHwf9PND5HDlxxi61jPx
         z2ruorNXY3YNmTldk2kTx4DDbYz9It6mQ3YXQrxyIo1tZsjwmLF3D+1KCS4wVJVF1qF6
         29Hfj2NeVUdIlQofMLNPrwTgVElrQEg6F0HTbsh5Co3UV/RJALVVj0J3/40JC992y7kS
         Ieog==
X-Forwarded-Encrypted: i=1; AL+hErEqFUdwsZ9lr4UTHpx8kkl2uBam2G2FqD1tHh4Q5c3H8ZIpdDO0p/ypDXukjQSLACJa5Wk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/bZfC+wjInRA/3e7ekuyh7HKdZXEyDK3pLusLB12NHYWMOaOmz
	7c6s/JPN0zg6faFHKWdC+AoMvSOkWkbnrqn7OGRmw8g4/m0rvRYP1U9PRtmP4J8gDM5+4YzsjHh
	xArzkTtK+aNOtLDMP+YcrOd7V0w==
X-Received: from jacnj16-n1.prod.google.com ([2002:a05:6639:290:10b0:61c:b6b7:f372])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:5088:b0:567:cbf5:bb95 with SMTP id 5614622812f47-5773db242camr4395212b6e.7.1795034122012;
 Wed, 18 Nov 2026 12:35:22 -0800 (PST)
Date: Wed, 18 Nov 2026 20:35:21 +0000
In-Reply-To: <86a4n61m7s.wl-maz@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117204535.4036191-1-coltonlewis@google.com>
 <20261117204535.4036191-2-coltonlewis@google.com> <avzZUyu9EhxAWtbd@kernel.org>
 <86a4n61m7s.wl-maz@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118203521.740501-1-coltonlewis@google.com>
Subject: Re: [PATCH v2 1/2] KVM: arm64: Fix inverted E2H0 check for HCR_EL2.NV1
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Colton Lewis <coltonlewis@google.com>, Leonardo Bras <leo.bras@arm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Marc Zyngier <maz@kernel.org> writes:

> I really wonder why I bothered describing this, introducing a bug in
> the process. There is no known universe where we can deal with NV1 not
> being RES0, and this helper is purely academic (and therefore wrong).
>
> My personal take on this particular problem is as follows.
>
> -	NEEDS_FEAT(HCR_EL2_NV1, feat_nv2_e2h0_ni), /* Missing from JSON */
> +	NEEDS_FEAT_FLAG(HCR_EL2_NV1, FORCE_RESx), /* Missing from JSON, RES0 as an IMPDEF choice */

Makes sense. KVM never exposes a configuration where HCR_EL2.NV1 can be
non-RES0 anyway (either E2H0=NI_NV1 with VHE, where E2H0 is not
userspace-writable, or E2H0=IMP without FEAT_VHE/FEAT_NV).

I will adopt your simplification in v3 (with Suggested-by) and drop the
helper entirely, which also eliminates the confusing NI feature check
Oliver flagged.

-- Colton
