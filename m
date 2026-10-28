Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793209181;
	b=pG+jF9aUbRX70Ks7WfRj+U0mi/6R/f/ak2ZbXifquZlMinFkYdTt3kX/JYcvfhx1dvWl
	 deWID4wDt4WNo9xo0PPGFQfLFbs5IR2N7N+HO3gPCaL/9omyaA3mVumU8MTzHk9QRtBbH
	 Bb3TSFj/T/QKO21v6qTDcHqUH+fUaUcb+dBut2Xw98x/U+skWr2aYrA8VADNMg+1/ETon
	 NDwKu0ZLRuCdjbXqzuYtrJg+5TwSnlum6eq1pRYtlUeGUpRHScfsItbQ3mrhSeKHq9Ezv
	 Pu9oUYXnVAxsA1LSZJ859iuSBUPFD/hHYU7LBZ3Tnsg8OhvtrBuIyLHQDXaBV+yHSaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793209181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uEHTXMHdpGW92Te2ykl2wHLQjlCid9PVQybwnkt0bJE=;
	b=wYghJIGY8URIuYMLJPk/O3XF6KpYfOmfgVTRoA9T8ra+rWW/vPGcr019jbA8QqErvoby
	 EmRMVjWKc4xcP3GgOxahGOzhpocuo72jGLMqFxWxaDvAaTCG5OWYO1FjWl+zMXx/7bKwM
	 3Q3WDFDyNwjomOvyNso0Sx7WX5Jk+vm4mEf/UcAbENl8MLYhrl2ZGlhHpLuSf21pUpssR
	 j6baTKg4Q7YulSgXaJZmyKdKR5vEvvSG9Z0N+bJILmUeFCNfumEtNv3xvsl6T0yuQ1r97
	 g4fUlOuKZs16+ue3MosGWfVignKO1knxD6vKr7o1DP9BtQ7OO+XaGA4n64APZY1ATvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dBrQSCJH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E2A606A31D
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 17:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37E2A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dBrQSCJH
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso680a12.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 10:39:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793209180; cv=none;
        d=google.com; s=arc-20260327;
        b=WFzb1ce5gtFgVa8cRdTqkATPRuq71gV6ObUdwrIa7WgHfBRDRdrMY1P05N9RW5VFv0
         /7bcj0eyn9ZMsZFLNqJ/spJiSHLFM2sRPViMZSmkvlMV9OgBOkOCVZ9Jk0uZQp7q4/3m
         OwLhwU4D5BQ6NutE48DSFzF1iCVeK7V5/vM74VXADF8aEGrq8lz+vbmC7RnVflqB3QWc
         T0sGnqsvRbCZHEgyvmWde1QM9CGxxJCJORLejPMMgMAwIqCW1UmwYMuUNF5MxX7EEVYE
         Nu2+0U/rALmMjqB6bGla+kp0qad/pi698BRanDSD9Vm4tqhM7/Ny+28KJBNk5YksMJq0
         UGlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uEHTXMHdpGW92Te2ykl2wHLQjlCid9PVQybwnkt0bJE=;
        fh=XXJaPPG4cVPL8KyUTAA7pjbfXLr5IbygP0pdlvUTmlI=;
        b=XgMKD3Am5x68DQHslZlHHhFhrimNYMKtM3ZfzShW4vKGiiI7RYEZHCHHSOfRsIScwQ
         ckTsOZA0IR77+LUB7b8vrs3dYUR/GFM0XREHMj/L0kPsqUqcLxxWeQJ+bv23uxvr0xRk
         FPrIhrCcxVW/UIoonM/cIBLrh2IJfrBWlbiUd4vcLlg34tbRBRbw0AzBE6x8vf0aAnXg
         /AqNa99lWcM70VumcdlP3YbE40iOrA1RHWxhpqtIfV9Mna2rKhcWL4xvY0kGWoSwHO4r
         hq49h99drM10E2GQxKsZnp8aAbVrslmAeuoM+aOqGjLPdoYi3Ng//aVpNB6FFbuk7Trg
         k5TQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793209180; x=1793813980; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uEHTXMHdpGW92Te2ykl2wHLQjlCid9PVQybwnkt0bJE=;
        b=dBrQSCJHenLTS5rrxGOYQzI08ml/pfEGaUEXk5B6yiH4wZU72ilvhWWUKuniukX8O8
         2mN2I3E4cPP20nCDU1+kxBQFz/mpjhPiJJrj3JyJibG09wgx+OCNXT9lpQaoE+fPNbNS
         gZF5aIp9oej8f7T4qwLngy3xPBcu2lSeLBUDQ76mb11qduJ3Po6ByiftnVTxs21VaUzi
         qFxUS/7OgoO1KYCsJsXVn4T6JPXyjJCKYatBwV5WnS8n54gBpKnO9r7VrBuLHVYYHXBD
         1qf9+/l+Xa8YCCd+RjdIh+IlEFlAsBYxZDWf4xnBw9oai4GmMCH0n+J7znu02/vTQkmk
         q1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793209180; x=1793813980;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uEHTXMHdpGW92Te2ykl2wHLQjlCid9PVQybwnkt0bJE=;
        b=g3lUtSfR5tZkob66AmzDROpZA2jhzAKD/zgsyXjHWzM+kEhaYegO3dpyziu8TE/mAY
         NDnfIAVwXMB23XB/+ym5VJ41A0pjnG8WtKMDHtLPls0xULYyKYkRQwHbZe/NMOZjvOEZ
         4LH1rv+kY4yYp4XPiEJRUXZuXtBOguZ+LuLg6AVgdOvwF6LYCTYgVFAsYOD0jz9vWBkI
         KtyMsSqhArQ+iJ4G4D1xqGHvKq8pY3KrRLdootYPj8kmrQ35ecbfAunaVbkM+GDdkt0T
         V+qjEop4Vl4cZ03rhzYJsnlPCSASh0EOTS2cJ1FRcvfMDl4urs+zTcL/2Gk9DkpRDaTB
         Qs4A==
X-Forwarded-Encrypted: i=1; AKwUvByhAHYT6QEomofighTbXv9rqg5Mb83+/1h8NOc/Hlvv8FRXY2Gt+9Xy4PR5AtSnwPYriNw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDSPyUC9RJZhr2jvERDyPROXeMuv5UwL30mTXj59e5rFh1qD0R
	RgsWJf3t9ceGfDHdeWlxDkyQ+jJdSQM5pBQTYw5kjgfPmLF6E3Hv6grDKmSoVoRlBmZW1WOAw1b
	Na5LbcZMT68YIlpqXIRhknzCDKqcA1Mas0D04cBC/
X-Gm-Gg: AYBFou0CF85SuEelfaOv2h1xQ6TDqsKQC5u/Hr9e8k7sYFh6GHpV1PPXIDoNHHzvZ4E
	zAQt5YNVJNn8ryuWP0+IlXdjd2b8gC4dzWJC3y7nduosrfAhsTIa0ILQpPut+74Tq9SdaB1Y383
	CuTlJVrPWkwftAreCOUSC51gUWvpt7Fb53rmOXVAc9on23GfW7kSIo+rGCosloRLWYDm5/K2T+I
	Pl5BNviqNecbN0y5/lzu2sUAJraoNejsEkquYHGq39ygTDExN6EMNMIRf0ZtwMPYc3LriZYBK7D
	3VGCfocxkg3V/2MXUhkpV3JRHsrJmyRyfaBkj0fJAdEmTPD+Wqrl37Hs+x++AerhPwanuoxUiIA
	OshSRJM+eo+wb2yJ3V7BI7wUDsMVSsVfpR/JT
X-Received: by 2002:a05:6402:115a:b0:6a6:7dff:61ab with SMTP id
 4fb4d7f45d1cf-6b49c132c7dmr79948a12.15.1793209179030; Wed, 28 Oct 2026
 10:39:39 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260827223755.143247-1-zide.chen@intel.com> <20260827223755.143247-9-zide.chen@intel.com>
In-Reply-To: <20260827223755.143247-9-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 28 Oct 2026 10:39:25 -0700
X-Gm-Features: AclHuK8ySYeolJHo7pCBJUUKUCrPrGo9dyPRJSPDpGLXiM1VD-QYMD7CcoN58h4
Message-ID: <CALMp9eQnWPd2TmC3WgR27VTpFPf1T-4-jhDn6opn940JpFOcYA@mail.gmail.com>
Subject: Re: [PATCH v2 08/16] perf/x86: Plumb counter bitmap from x86_pmu to x86_pmu_cap
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 3:51=E2=80=AFPM Zide Chen <zide.chen@intel.com> wro=
te:
>
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> Intel PerfMon v5 introduced CPUID.0AH:ECX to support non-contiguous
> fixed counters and Architectural PerfMon Extension leaf (0x23) further
> supports non-contiguous general-purpose counters.
>
> num_counters_{gp,fixed} indicates the total number of GP or fixed
> counters, but cannot represent non-contiguous counters.
>
> Add cntr_mask and fixed_cntr_mask unions so that KVM can get the
> accurate counter availability directly from x86_pmu_cap. The u64
> alias is convenient for mask arithmetic, while the bitmap form works
> with for_each_set_bit() and friends.
>
> num_counters_{gp,fixed} in x86_pmu_capability will be removed once
> callers have been converted to the use of {,fixed_}cntr_mask.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
