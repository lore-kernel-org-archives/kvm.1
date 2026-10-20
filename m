Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792495304;
	b=BINQq5DUA3wPH4G2HyBpC0DJ3isddhaMnxvj+nMv7ZFNwqGW1UZDKXliZyQaBtzFiJjQ
	 RSWioQl/9rbatpGuu5KECoD8C7njrRl0jXzrfiBBs5dIMh8EaIvGvD2PkOpUrO6u6fiSK
	 XQLXec18LsIrr20T95SXdJevdCk0ND6yg9TpThNtG0zyZRLOB11V4VwZd3WktdLqAOKbQ
	 v7pOsFyrDTK28HGW4UKdNxOEkN50BuMqXNQFVJ+dNSbfC/PUmyu62NV4WtwGj8/qNUjEm
	 gQOHwcen2Zw9o4wbJeM8Y0T7ACwrjMtM8j6Tebxkru3c2WA592ys1KjfzHCfzCCju/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792495304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:User-Agent:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2/y6WVmeqG1OPwYNPz9215YT6b6rVbd6ecgXKvSOZTs=;
	b=DaBqS0qHaOOr44MqaP1BbGvdgZPdfItQdnFt+bHECmoiPPKJTXNTx1tulNgNI+oHjduT
	 oqdGKIlQDPqi2VGWCs44fAU9TVMSlExu/kuDf7u/P8Tz2rRojZVaOUwtJVSNeX5U+f5eD
	 tDsbQE4QNKDnu5RUWtOTGNIWPJ5k48pjqycnNK3ICO52Cm6ryrhw5PImfI9dL72zWU5au
	 Xp4ze0kIsjtZ4+M6CXRQ8rnRVtJKCXjIXgF+kYYEDsr5fmSzRp/WxO/KA5H/jiE19THyd
	 Sjckbw7RkjVwkA8lsa7ch2xcHKMc2V868F9j3oWF9l7W23ZFjYxQ6Atm1fFJNMe8RFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RiwJHvUV;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC41D606A319
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 11:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC41D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=RiwJHvUV
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1e477fe16so15519265e9.1
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 04:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792495302; x=1793100102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2/y6WVmeqG1OPwYNPz9215YT6b6rVbd6ecgXKvSOZTs=;
        b=RiwJHvUV335arP0w8a4uYXaRSGgJJ3NqJCtkkypxMh9I/USL00r7JjMyxqc3Yyariq
         012H2VDxqAlvIdfULqGGjY8z4bOgSYy0erHii68tJx2V4VsNE6iRT5gytWULEcjkgMbp
         MkempUjquas+Mp9sNClOQVIoWjg9ImHbOGp/uKwQnTtQZ2ugY3mRCabzqNjGwXiU0Iox
         YY7UslHIWjsmWYYTp0QiaBMd61Z1Hgt4NY7JRXDM3uf5M67UtZrfm2gNnJweSgm2xJyq
         3BZ0CfysWrBlinVHuHgTygQtDuXBMfwG6KKxb+QmFdV/96b4oSR72UA0TRjRYWniOB3v
         q5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792495302; x=1793100102;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2/y6WVmeqG1OPwYNPz9215YT6b6rVbd6ecgXKvSOZTs=;
        b=EQQhJIyxjZdxbLkyhCZRlwahN2xqE8U6xKM7kLnxchVQuvfCf6E1xah4KXLal2oRLW
         5VyPyQxXT1Puo+gJqooAaRaVNWDL90wa6LsBEEKlYeCJVka0m8iUz1VbuAfufVwjBqoq
         Aa7/dlaOPCFL9CBsJ2Ud810KA7Mz0/X9FwFComfi14EYpXeXcFz06w8hYtMZ4QqYvRxd
         DTEbc+XpRMJw/0jfrRId4H3X1Mv6qto63a34RnKTZ5iYlCMDtP1jEMxIYVS5yWeAr6FD
         y3kxnfCSxfHd+k/7qmTuo4bBt3vSUIk/AruaxtMdNoIe1N2RxshV+0KdF3MJr1g4lBEc
         KQQA==
X-Forwarded-Encrypted: i=1; AKwUvBzoDE0FroQ09rl4r/+JaIEr0SG+aF+E6zwlTK62a23NArDU2pWJ5tWFHk/yHVnnrjqro0w=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvuBE8dif4VF85gTll17H2CPAuYiZgZBL3Tv6iGHQddJvkpa5K
	OO0KlfTVJbMzRF7SYN3aCzxX1ApCIiROXQmDV3mNAHtAqDHGhrIoIN0M1Z780yeshks=
X-Gm-Gg: AYBFou2KBybG8vTMG1pbjLeixdWBsZMmrgfJb4tLPSyJtCQwoFxy5YsIwjh17oBzpTZ
	7IW95wOVPzvhXQdIuinglDZe6t9lRLGDk8gjNDib9ZjEXEZDlES2/bFR+LErCIj3SKRTJlDCI7J
	k9eWF9nD3/MEUJpyl3LuZCGnlycPTSrYIu9SPRFq8TfkgxXgYjBieaNeHRB9TPFvbbuULQB8syS
	HG6NEEzlt8HIdmypTeBT8MNs5UneLyYqZrGUJsqQrzbUNWMLMqKeVaL2OoAsb7/7nWCBwzb2Eup
	Ug04lKA9K0IUQ7QkORDzG9KVltrS3IJiEjXIbzKJ+378UKoFLN1uzg/LrRwExnFVeBA/3w3GW8X
	An/WbdKksp5IyhnAYQWTqquhvpW2KChmL85NsHmbCbwr4zRUjYLygIzYT/QVYltj++pQNFUbR0P
	pUf6nrC6mM25pdwMcQGNGjtaMlgUkHWIRfo49cJrP+ZNb6aNuzAypMsM3uCbsMOAS1LdwCOw==
X-Received: by 2002:a05:600c:c166:b0:4a1:f736:79f3 with SMTP id 5b1f17b1804b1-4a1f7367b83mr24851065e9.5.1792495302093;
        Tue, 20 Oct 2026 04:21:42 -0700 (PDT)
Received: from draig.lan ([185.124.0.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f8016c93sm29458585e9.5.2026.10.20.04.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 04:21:41 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 7919C5F8DC;
	Tue, 20 Oct 2026 12:21:40 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,
  Alistair Francis <alistair.francis@wdc.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>,  Paolo Bonzini <pbonzini@redhat.com>,
  Eric Farman <farman@linux.ibm.com>,  Song Gao <17746591750@163.com>,
  Harsh Prateek Bora <harshpb@linux.ibm.com>,  David Hildenbrand
 <david@kernel.org>,  Bernhard Beschow <shentey@gmail.com>,  Halil Pasic
 <pasic@linux.ibm.com>,  Nicholas Piggin <npiggin@gmail.com>,  Paul Durrant
 <paul@xen.org>,  =?utf-8?Q?Bj=C3=B6rn?= Walk <bwalk@linux.ibm.com>,  Jiaxun
 Yang
 <jiaxun.yang@flygoat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Palmer Dabbelt <palmer@dabbelt.com>,
  qemu-s390x@nongnu.org,  David Woodhouse <dwmw2@infradead.org>,  Liu
 Zhiwei <zhiwei_liu@linux.alibaba.com>,  qemu-ppc@nongnu.org,  Marcelo
 Tosatti <mtosatti@redhat.com>,  kvm@vger.kernel.org,  qemu-arm@nongnu.org,
  linux-edac@vger.kernel.org,  Glenn Miles <milesg@linux.ibm.com>,  Chao
 Liu <chao.liu@processmission.com>,  Cornelia Huck <cohuck@redhat.com>,
  Gautam Menghani <gautam@linux.ibm.com>,  Xianglai Li
 <lixianglai@loongson.cn>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Chinmay Rath <rathc@linux.ibm.com>,
  "Michael S. Tsirkin" <mst@redhat.com>,  Matthew Rosato
 <mjrosato@linux.ibm.com>,  Amit Machhiwal <amachhiw@linux.ibm.com>,  Zhao
 Liu <zhao1.liu@intel.com>,  Weiwei Li <liwei1518@gmail.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  qemu-riscv@nongnu.org
Subject: Re: [PATCH 00/23] kvm: introduce KVMCPUOps
In-Reply-To: <20261020104320.3686723-1-alex.bennee@linaro.org> ("Alex
	=?utf-8?Q?Benn=C3=A9e=22's?= message of "Tue, 20 Oct 2026 11:42:54 +0100")
References: <20261020104320.3686723-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Tue, 20 Oct 2026 12:21:40 +0100
Message-ID: <87se2039dn.fsf@draig.linaro.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> There is a world coming where we can have a KVM interface which
> supports multiple architectures. The old style approach of using
> linking to resolve per arch kvm_arch_foo handlers won't scale and is
> also slightly antithetical to the flexible not-quite object orientated
> way we do things in QEMU.

In case it's not obvious I intended the prefix to be RFC as it needs
discussion ;-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro
