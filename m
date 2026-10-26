Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.40
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793034632;
	b=pKkx/AkhELsi6biOCcPArtGfoMOY9+Zj43YZ4GUaIRy4sDL+PGa5djeYa3oQYQUmBJ3D
	 FYsIguGsBqrkc7FJDyt1Qso9MtEjTt+DUVigNRIgpjlL5WF9MX8T5/m5yD6daIFPnwnD+
	 d2wHRBWhz9ASCnep2hPp1Wdj3fgh+MBKQ+kpAyrP3wZ47+fbq7P2EGaBEzD+UvDRZtPtX
	 CptkZg3RPhs/+LdHiwzyNPoJicbpm+bvkyV7PgDq5+dis1xDoDSKXIpnyGwR0CN1trsUj
	 oj0lkX91zZlQ16ohWBTo5Jlz1QZBVNU1e3M1GYT2C1F7ERkMGf/7vHvabIMDOKpCMzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793034632;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=PYgl4/AlR9E7qD/6t01/AqAhjtHt2uKRS8XnGrG05+A=;
	b=1nObu2KGPUuHnHcaR6h5QtV0v7PBZssYku3sBVy3ylpaly5bUYx4e4G0b3m2FZDamFhU
	 0K6eCzIqk/tEi7bLcX05fFW/tpyKI2pVMCWfUFpJmzfYwM0H7alHEU2qai433KItEOEO4
	 Ea77w1YHuq20viCeAIuMpW+C/tiFsG8fUxHXNQ8Mbgbhs8vSxuzENmCv6YlRdLLAgsFgp
	 YHQhE5sH2Wd5cqZx9mD5M8EIlci69r1wQdPUUVFSiGpW3tPGqsdoMZE3q+OpA47v/+yyI
	 fk3TqyQ4aDn/Vmzop/gntT9QkL9GN3iOPk0NDLMERf3xzIjgWIHC2Qnjt0/I+Xkl8TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=95.215.58.40
Received: from mta1.migadu.com (out-40.mta1.migadu.com [95.215.58.40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A354606A320
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 17:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A354606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pcthy6ORiWzW3EmGLV8zsnkU+qv48Vriy9rB5HlVHlU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793034629; v=1; x=1793639429;
 b=IvwcoIFUwnmW6X8wZFE90I/ZGEzZdt3lwnKHTcY0+9LG9Mtcg7nt7cEoqLCdMBmRRfD0LhWM
 JVLhwl5jKMKRCSYivSEJwdUT/jyAuzwbyolm8peKQwGdCOLlGRjVz+wcQUY1x8mEmWJ/B+cRdG6
 H2w+V2lRGYQSeRzRfQNIHgbk=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7f4bfbe0b0577edb;
	Mon, 26 Oct 2026 17:10:28 +0000
X-Mizu-Trace-ID: 7f4bfbe0b0577edb
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5be58ad9600so457e87.0
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 10:10:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy7v1DFUzz+lsVc9SeI8UQjx/BvU+eTdf6mIuCtuIIMh73rwkkSRYNW3UyFHXELM8QR+fM=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5K3aSzAtpzVDBZL3BVgdUfR8YHdPmvSDmRhvVfD3vsWG5kjok
	ZZieCLwS/tKJMtDrPKgig1DSnj0mnas176635xtTfpNb6FCraEXVS+x2j/fYbPtDVA6t28cC97A
	PTz+qqqXcCwZavNq94wy4p89zhqPuRxA9tXWKo7Pf
X-Received: by 2002:a05:6512:130c:b0:5bf:c1d8:b44b with SMTP id
 2adb3069b0e04-5bfc1d8b53amr122078e87.14.1793034623586; Mon, 26 Oct 2026
 10:10:23 -0700 (PDT)
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
 <20261025075138.2919734-4-fuad.tabba@linux.dev> <a86348e5-a55a-4a99-a3c6-24b3213ed3d1@arm.com>
In-Reply-To: <a86348e5-a55a-4a99-a3c6-24b3213ed3d1@arm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 26 Oct 2026 17:09:47 +0000
X-Gmail-Original-Message-ID: <CA+EHjTxyenZzByhAckimWUSgG5fMFVBwyB8bsC15xaoaU1RPVQ@mail.gmail.com>
X-Gm-Features: AclHuK-pKf8gC2S2-5qJFUs5PfEVBnKKd1_HAZS3RuQB33ufSZ6ApBNWFpRYh6w
Message-ID: <CA+EHjTxyenZzByhAckimWUSgG5fMFVBwyB8bsC15xaoaU1RPVQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] KVM: arm64: Add context-switch of ACCDATA_EL1
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Joey Gouly <joey.gouly@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Zhou Wang <wangzhou1@hisilicon.com>, 
	Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Oct 2026 at 15:41, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
[...]
> > +static inline bool ctxt_has_accdata(struct kvm_cpu_context *ctxt)
> > +{
> > +     struct kvm_vcpu *vcpu;
> > +
> > +     /* The host never uses ACCDATA_EL1 */
> > +     if (!cpus_have_final_cap(ARM64_HAS_LS64_ACCDATA) || !ctxt_is_guest(ctxt))
> > +             return false;
> > +
> > +     vcpu = ctxt_to_vcpu(ctxt);
> > +     return kvm_has_feat(kern_hyp_va(vcpu->kvm), ID_AA64ISAR1_EL1, LS64, LS64_ACCDATA);
>
> minor nit: Aligning with the other kvm_has_feat() usecsaes, should we
> wrap this under kvm_has_accdata() (with moving the cpus_have_final_cap()
> to the wrapper ?)

Thanks Suzuki. I'll do this change if I respin.

Cheers,
/fuad
