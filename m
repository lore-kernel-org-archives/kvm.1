Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795193962;
	b=Pe16ccIf9CqtHvzwnwc4bj+mivdKxL/xdJ8DFB5NSIzVSHE6kAPVW+vpIt46GEYzlhKg
	 PKnrsWFO0XzUM9QeLJN5z4+wGfq5GLjyNWWiXV68YXEbzUzJcnaeHVtKOP+I5EkKpe76n
	 9NsxIVG5GcnX2cldz+mvTTw/7zdeo5agFeNb7eX+hyBb7ILbYLDG/qxVEORk/cAKLZUi/
	 WmWKbjiDBLIql4QCcd4LdA8ZQmchWiJ/UbTwJC6Qfl2E9pS53TujgUH75FEh022RJZdbn
	 8IMdlRKjfepHedWgDDOnk5yQ5IzXSWsUyB5haX/8IAozWj4S5i0m2lzlfM9ZPuqQU+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193962;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=tz0CrLjUTOyxyesRuNdOwJNQHNZ4AUMRE7F50QFI7Eo=;
	b=FGpoPSPj57a00NhP7jWE5zfCxPQ+UuTx9yaTW9ETsHa9R2fBBlWXALKetvX2A/3x9jWl
	 5QsMM78Wn6R6IWqCMReFDI9Ukx2La0eh9DO9Ot5sIg54+q8nQkgeB2tqKTMg/czmKgolz
	 7ZWFcEFahpNPui/hkqPlF4RcmUimyk5Gy/CvV/4WOyTXXYa4YZPkW2028IV0sNkbnVi3X
	 qeppXn96dxD6t5vYwy5x2SLi7GKhmxnx4z4N6KYnQYEGpz7gqDUlW5Lr3kOH/cAFGSqU1
	 ffaodhsVeREXVlNJQBoTPCvvgQQ84Xb6dGVfH8X46pV40kT/iok5SceamXSKrHaV1SA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZqlyzIl0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAEB60A2603
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 16:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FAEB60A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZqlyzIl0
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-55be673e029so295051cf.1
        for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 08:59:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795193956; cv=none;
        d=google.com; s=arc-20260327;
        b=NlZJK6UfUrTsGkVJu+8aoHxd4dLjrxNZLDmakPYmQFTsMXZXL+1Ga12oE6AkQdiyZk
         u4aUfU4VzVGkmsoLe1tW7NJIXyJfETyGNabKomEPoV9JSRz2mNavwkZIyAHGAnPG3rh+
         Ivoca30Ybe7OsL1MJ1aSXD8XSz2PtnqT4BbgdEM/ZwSpKjr01UdZPRepoWSmlOuIQMbv
         vXLMOOBrwDg2UsYYUh0PjI/RvUle5f/N7V0xSFg0XcRUJDwCbIwLMgCwltm2mBh6QTdw
         G/BlfB1+2KnNCyWn2HRsvtTKIcILw+0iJTs+B+AeFU1w3jGZoAoEk20bnjbh2s/IfWee
         3sKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tz0CrLjUTOyxyesRuNdOwJNQHNZ4AUMRE7F50QFI7Eo=;
        fh=m3bqy6UIDoWB5gz4Lb6f+xsAl5/VRRvuAVXH1NE8nTE=;
        b=LzGk9IaMJ5Ct1Q+0jTAZzS6syguTwIR4HWIp6HnH2U1QivMR8PktD/1b7LV+AkJTNx
         Cm9Gwj1hTJI+F0ip7y25KnKX+7eQpBtzAbfDGlAXLtmSKsC3Wvl8mAzydbmI6Ll5yJ2z
         PO4ao4UIY30bXVlBXOBeWXSa2jyDiUQR/jO419eFKOxHnpBUPYayAqXqWfKw4AmCqZga
         yd25V6ssE3FniOt71q5fMQa7zDN5fXCslFFCjuBlICXzVyqs8juY6LNaOHjmN0fcKcB8
         FuB3JmH4SvGSP04Ua4Dcnnp+CfEG0Huz4IVq5BL5EYMXdxUW2JM0e6UvmRiDIcYWfatL
         z9ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795193956; x=1795798756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tz0CrLjUTOyxyesRuNdOwJNQHNZ4AUMRE7F50QFI7Eo=;
        b=ZqlyzIl0zIKYKdbMSAxxTM6MTqpALPxKJAlP1zNgM4QeQO9tRmsv9iVPmFyoEhWkgc
         SAgLqZbnKOtFuxbyLWiTTFtbIO65fU1VAYmkZv0nshfh5KrrG3D8kyUhRkwlDvbvEj1t
         onm6Lx42LbA3kJ3/fNlsjKG/TJIIWwad/yyWj9hYWRKTK8ohyIXHiyZGcITYZZfZtUXp
         kAbsR+eUQKvEriaEJz4A1sJWdHsqg944t2WFVWz6ANU3bEJD/pj8FGU7hTKhxXx9iqWN
         N/XT46cav2K2mwh8CUDzajSUCf4LS4xNSlsm4v+TFOABTpCWJbvQqlC7PQj/zqAdN2tL
         gm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193956; x=1795798756;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tz0CrLjUTOyxyesRuNdOwJNQHNZ4AUMRE7F50QFI7Eo=;
        b=1dbKEMsQan1oJRjkdosNf5gjhYQDKRMKyOIRQiV7FG+7Xml6uhz1YT+fstTwoQyS1P
         wJzLUt7uIKD8G6v9yfPK7mU+ywIyALnx+g5V3DrA8WmlZL4t3SDmGMJJ8gEUuHVbkDVE
         zKWo5024gOkEkLmmo9waL69n5bKn85ik+vB0DPxUD+8m9Dt9HCr2sVRh7dPx3f/4cfLc
         cCoROZ8aVm1P30MUEez6LONNSbSUqa0JH12MyMHZpOe8yU3S6HFoxu0jkrlotXAbUYMF
         KAmQN7d/5SBzZNSJpyNFECmyYZcFiEEIQQoVwuwiWarte4AGS6kFC+HkPnSsex17B9iG
         61yA==
X-Gm-Message-State: APuU4Z82weM1BHh5mBJbIt7T3CNQvWXV8zsmPNuHg1Iqq2/fjvlLpAme
	SHH5zdXy7Eyo1MTJ4vqGjJXFLC0FVwfHmYWNtJ1qK53vP+XPONsthsbpHrxY+nnRcAzOvXad8YJ
	EUKD+tB/E/AWcQNbb1Ztve4BzsurCiLqgjIz0Xmjh
X-Gm-Gg: AZFdTZd3RV3Btc2O+KhtDTZmZUFDW8/XQnfEf6cnasL7d+YH7GLJ5hTj/qzoe9wuICx
	YyEq+6hwrDoXC7UG2RQHajDOAoKu/PP8CV3pn5O3Atx0+6gLorCHIwKJMxRa7GwSX92zfWSSa4D
	zZqlADMNpp7+FWJFuPNo82g/8iwLAXua2dGHXWC58oYFdqaQccaMbRvwceertAyWMlFPLuP80YT
	PcC1mRtMiPWM3m0xXvJdyuDi1rTx/rk+gMFn27Xu7HCub27YYY/dypRejqVT5Lu7/OrA1BoxRf+
	FHeQrYZ1vXVWx+oZv7NksVLYWEFzi8fgjzHZ+UvrF6sq6SPhfcqrAOWnKgj+HzTllXw0TRNmnlJ
	d5Mrd1lfG3ALrTpDVJb0TXKwxgWcEuX0NXVHa
X-Received: by 2002:a05:622a:4d0e:b0:535:bb33:6351 with SMTP id
 d75a77b69052e-55d78e2a158mr20346661cf.1.1795193955835; Fri, 20 Nov 2026
 08:59:15 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119185659.889654-1-aaronlewis@google.com> <20261119202713.GU2245175@nvidia.com>
In-Reply-To: <20261119202713.GU2245175@nvidia.com>
From: Aaron Lewis <aaronlewis@google.com>
Date: Fri, 20 Nov 2026 08:59:04 -0800
X-Gm-Features: Aa3M54qtvS7ud_PiMcu5KCcR1AI6N7Z7lU3zC0VKB2cFia5JslwlaVB0f4On73k
Message-ID: <CAAAPnDH=qUXK+Lv75=Ra3XJ-KO++9XX+VYNjxHSQA=qM1d9_Mg@mail.gmail.com>
Subject: Re: [PATCH 0/3] vfio/type1: Fix pin leaks for reserved GUP-pinned pages
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org, dmatlack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 12:27=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> On Thu, Nov 19, 2026 at 06:56:56PM +0000, Aaron Lewis wrote:
> > vfio/type1 uses PageReserved(), via is_invalid_reserved_pfn(), to guess
> > whether a pfn was GUP-pinned or came from a VM_PFNMAP mapping. Reserved
> > pfns are assumed to be PFNMAP, so they are not accounted in locked_vm
> > and are never unpinned.
>
> Please just use iommufd if you are running into real cases where this
> doesn't work right :\
>
> Jason

Is there any appetite to at least take patches 1 & 2? Patch 2 fixes a
real problem with DMA mapping/unmapping where DevDax pages are properly
refcounted during DMA mapping, but leaked during DMA unmapping. It
fixes that by tracking whether pages were GUP-pinned or PFNMAP'd, so
unmapping has the context to do the right thing rather than relying on
a heuristic that makes its best guess.

 - Aaron
