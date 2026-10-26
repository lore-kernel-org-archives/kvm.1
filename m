Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.212
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793040901;
	b=iiBamDnUELOVpLZqhXOx78Rp3hUkt3Np9eIEHKPzT50MYD+qEMDfHnEj2tPa2OsGVE4v
	 2jeG3B+sMUGm6A2OVknf7Iy5y/+lTTvnXp2NGF5bOLuxFRmz4D280PlkcFpcSgNsoX7JT
	 +9U1l/NhyN7NSv4rEvPfYuuO6R7ILSJwKggYf4QuzJ2uTRcFotBfk2PVHuDXNtg/oTLk+
	 QS/uJ2VmW2XzfoopG5zNGu+jtVPsdUS+NyAtNNkwnrxCAM9eM784nroN9TKWmuKWscYxB
	 cd14cg7m76d/0bulSt3jhr1iCBa0XLh8yC5EtKIPrXoyyCsP/GTPf4jxsYxhBkD7QKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793040901;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=tmyLomRU3odEzGMBEnqER8cvULIdSR4sKslKh+g3oUA=;
	b=zs9Af0QJhrVbxYc0qfUba+ZdEohZevO4WdRM/C8D7Jv6z1eUohBEqR7tbG760IjNSkHU
	 v8bQ9hdXUXHg7+Yi9GzXuojlWnow0352sEcxwQ+4VMUWTwlG0zKF8GjbWut9mlIh/VpDv
	 i/UgpYXc9uBlC4/XdlhuqD3vCF23SBeD3yccdn/Su2L/aUhtZ/HY3Fm6ltW+CCzH2I2iJ
	 ymzcvgenpiYSqWvpPJ1sCb020n9hVVrxd3Ju81AHCXxtRWKs9n+K58Q1OSm4cOuN9TwCb
	 Qc1xol9Ng3AfA7/5IHtLSuJRROwI5BH0JtDZSABibax0O7PO5/DmI0XapQzJamdJBwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IWPDWWVK;
	arc=none smtp.remote-ip=95.215.58.212
Received: from mta1.migadu.com (out-212.mta1.migadu.com [95.215.58.212])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1657606A31D
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 18:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1657606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=IWPDWWVK
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MoHfFpJAFkB5Xy3qYToV+bmZRv6HdYN4+v8GE4amOTE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793040897; v=1; x=1793645697;
 b=IWPDWWVKr3kSRPqljCWlcb6/UuNeN3bcGNlx6iMKMnCl3CzLQG0T2L4Mm572TRIrUeIJLDFr
 U0ENwaZBHEL24J4Oc1uBNNfWuRb/TT7+bQtA2JJPiK+EXIilN29iQPNoH8XMdFLispsQfl9fAWe
 gug2XTf5c3DK8JxpuW50LhA0=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 87c336f88ca2ff91;
	Mon, 26 Oct 2026 18:54:57 +0000
X-Mizu-Trace-ID: 87c336f88ca2ff91
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5bcbb378fc9so1720e87.0
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 11:54:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy+xOw548QX9ENBX7Rr2td1fywEo20PugrWoMdDD9D8IRQiaWlBHghBla9MLyh1OzPSdGE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJlrAW4iz4ijgN9XbejMAp/3WlYF2F8QaN6YXEnUXOd2VSsCuT7
	MA2vyPlYlgUxZvSeOI+91c+trEYMgiYcJLXZeu1jLM3W+He3BKvz+SsUeEdANebQ5bKi51Sm+x8
	dNhJBo7FLt7NSDV33Jfsgq/v212OPGPwNOpqDzrux
X-Received: by 2002:a05:6512:691:b0:5bf:a5c1:d20 with SMTP id
 2adb3069b0e04-5bfb7a0c36bmr234023e87.16.1793040892816; Mon, 26 Oct 2026
 11:54:52 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025075138.2919734-1-fuad.tabba@linux.dev>
 <20261025075138.2919734-4-fuad.tabba@linux.dev> <4066f726-310c-4168-bc06-1502740703db@app.fastmail.com>
In-Reply-To: <4066f726-310c-4168-bc06-1502740703db@app.fastmail.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 26 Oct 2026 18:54:16 +0000
X-Gmail-Original-Message-ID: <CA+EHjTx8Yy0eYQauYX7CYR1TFbJXLFJBssNfWtr72s=azLFY0g@mail.gmail.com>
X-Gm-Features: AclHuK__ZiaYmPESVb1fdiC9S92LDB2sGT2vZe3GOgGEAspZkMFDfe1sVpLPpQk
Message-ID: <CA+EHjTx8Yy0eYQauYX7CYR1TFbJXLFJBssNfWtr72s=azLFY0g@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] KVM: arm64: Add context-switch of ACCDATA_EL1
To: Arnd Bergmann <arnd@arndb.de>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Zhou Wang <wangzhou1@hisilicon.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Oct 2026 at 17:33, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sun, Oct 25, 2026, at 08:51, Fuad Tabba wrote:
> >       return kvm_has_sctlr2(kern_hyp_va(vcpu->kvm));
> >  }
> >
> > +static inline bool ctxt_has_accdata(struct kvm_cpu_context *ctxt)
> > +{
> > +     struct kvm_vcpu *vcpu;
> > +
> > +     /* The host never uses ACCDATA_EL1 */
> > +     if (!cpus_have_final_cap(ARM64_HAS_LS64_ACCDATA) ||
> > !ctxt_is_guest(ctxt))
> > +             return false;
>
> Maybe add a wrapper for this as we have for other features?

Thanks Arnd. Makes sense, I'll do this if I respin.

Cheers,
/fuad
