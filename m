Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599164;
	b=RmLMnLqB7ZSXk/v2iSToRsMRg5V7trDeMpHWO0fZjBYOpVRCaTntXkFH3bJYrP0VQxlg
	 XpCWXtkEOj0Sk5U5pRzyHGpGFuAFNrBWcTK8+6tuOgsHJVfGsyJRyOabpPJgbdjGCBilM
	 mH0Qc4BAwhOcflZZLpAIwuo5WTz0pvLT2XYc+35oZ1S9ZnKEOYW/5Kp4m3XyR36d+kOeE
	 XGEWgdo07oHObgcVTHre2RMH/7ibLXOGdsSrbfG900Mr9l0IeeuddOxMhLEEsDB0jUdgC
	 rLgxkpQ5cYK84AK/NW2K3ztFJ8TU858jJhC8QHlY75w/ST9qKKecJ9Gz2I7E8EijX4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599164;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=vz6xI/WxixrEpdd3ywwOb3jpy1gOGMCFJ8JE8A5AwCg=;
	b=4DQhoFNopXfQx+q1RxnJ7yLMxDMYLJqEz2mgp7E6wFyfeV/mnkVHL0SocEwkxUNkSuG3
	 Bx/NnMv5+sIV4pz3r9cyiIRMc9kwjyKjMMHCr9HrcfG1BZgKeYquOwnI9luvEBpAARj2Y
	 s/EpuXfMl7VPWNj/ATCcIzdIfGHcq9ur/y0+tLMyTZZ3ePvuPx3dmrdJ78eXb3SVLx7UF
	 H4YCI7ff1xo+2ekWEVBsIL7lZK+BC86JYOGFBH0gqr2lPRZbvigBDwozotZsKuRIG08L1
	 r6o0CFa3yymtw28TIjccyn91ojsf8YH3sVIgPLU4Zk3KE39kAa9YGCmLSSxJ1kyuNkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=AqWEO8Cw;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B078606A32C
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 09:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B078606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=AqWEO8Cw
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso43544785e9.0
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 01:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795599162; x=1796203962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vz6xI/WxixrEpdd3ywwOb3jpy1gOGMCFJ8JE8A5AwCg=;
        b=AqWEO8CwQkTMHtVYcIOLuHqCHa8uPTdR6xogLnmlooFf70UL6doHQoMWgb+TBbtYm8
         +/kTYzofe6h8tAPEA/By5779kp9X1qykliRXQc75+CRg/neatW43jeGrV/QCG6b4nksZ
         ITNPn+N4wGapg7eibENnYvHVgERO0nVHReG/IXYyV5dcbrjZkpwDs4MjpTKd2aE7VLI2
         zMh4u6j1TwDt1abI13SFwlyWM73qP4XsPOxo+zUm0GWE8FWosugaVzTkv38puBYs6Uwu
         YS2QSEBXOOIpfQWSaKG25ZIjvlUYLNmRLr8XawyzKXPtytjX+w0sSzLfY13c0BTd8aj9
         2N9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795599162; x=1796203962;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vz6xI/WxixrEpdd3ywwOb3jpy1gOGMCFJ8JE8A5AwCg=;
        b=QJlunYKmsd84wNkzp6vr36cbT5sa5keliHsHg3dEubejbQFO9/sWkUpyGWCZkxThg1
         TAMmEFn2u6wLlXt1d7qJyANfkwlgLUSDGwG4wwr8ldM1A2UZbikxUrq5XHAaWfaBXzY5
         Pgqnh6njMvJ+NPiEMN/FFItMeA5ztrO52v32f56JqiFxC+3y2kJtv9ab0eSD3kq8dSna
         7ZbhOI1ItD0AWsXd23Mf+PdTbjMa0X+oLfWtYQ9K+TpUJRFW85KHyi+ebhasfznEupkn
         lmDk0dT71Fdnaceac9+GFB/KJZDyF0RduUCm/nFgoSfKaZY1mR9DnjwGH6y8oQR017Ch
         T79A==
X-Forwarded-Encrypted: i=1; AL+hErFuGHseHik3I5OxW0aL/m5hTMEW/UsAOdcVxlS4agX+CrDRXhcPV28HqDM2ta6hHehh7bA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1NwlpO4lgOeLloU9CnrnJEyb7NYxA3ArVe/wS4TuFdki13hMh
	WLuHunh0I/C4XDcy2441LnbG1gZZCBTk41gHW6nb+Fa5PDjO91fS0Fwu8X9dMcNL4Iw=
X-Gm-Gg: AZFdTZf4H4Z9rr9AxGk3xaaqxbSdkixGc9+kq+zhF4bCrHU2dKhV9WXbHOlyxlDMlgY
	/b394jFOqpgYo/4cuy74UCJSqUp/i9e7ffxCOxYPzbMdL3j55S3i/4Zt1w3MlWoHoKnyEstdyIL
	60zVcuUmyffrTJmdnpguVaWgqV+NAJ6hgdP8pwsS8xzbsNvARUD+WzZW3FUUhcq4fMQyn93AJs3
	iB/Oj+99zw9ooF2pZP2afrtpfTqPSPI7NcivDQu/H2AMHsncPQH/Bx4tOHh0CTXx9hO4AJIXs0L
	/xX9CeleDccLSUzzGJko0FLeucw7dCWJM7TpycSHEjSQMhBNSZ8WqJHnJyfnTn8Hid/xhve8BIx
	1Djv2uUSlslnxKb0hodXrfjg0OCnOlbSWNfpn/AcrW57w3uRPZrI9PitfFILngYlMovQ8Wf+8u3
	dfXS3YE4Xa77VblXD1KJHR9dC/a4BJzyo6aVnPmWVc0sBlO6I9fxm590yQ9wOoBJTPlrw8WLFcW
	D/Jj/EF1IJKH15gDttAoeSsXNfTqtVY/LO6tf/K/hupFO8aqw6WC57hpU7IVYpwwM6szXiCbBaX
	ZEBdUcG9M+WPlbEYZcM=
X-Received: by 2002:a05:600c:1c28:b0:4bb:867b:f0f0 with SMTP id 5b1f17b1804b1-4bb88810708mr406437605e9.15.1795599162309;
        Wed, 25 Nov 2026 01:32:42 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bba6a0d65fsm32122755e9.3.2026.11.25.01.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:32:41 -0800 (PST)
Date: Wed, 25 Nov 2026 12:32:38 +0300
From: Dan Carpenter <dan@pereq.eu>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Christoffer Dall <c.dall@virtualopensystems.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Sebastian Ott <sebott@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	James Morse <james.morse@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>, Karthik Bhargavan <karthik@pereq.eu>,
	=?iso-8859-1?Q?Cl=E9ment?= Blaudeau <clement@cryspen.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/8] KVM: arm64: Reset SP_EL1, ELR_EL1 and SPSR_EL1
 when resetting a vcpu
Message-ID: <awarNqNt6Kec5G0M@stanley.mountain>
References: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
 <20261125-double_exception-v2-2-224689d8a764@pereq.eu>
 <0c7c59df-69cd-40fe-830f-60c0f3cedafa@arm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c7c59df-69cd-40fe-830f-60c0f3cedafa@arm.com>

On Wed, Nov 25, 2026 at 09:08:36AM +0000, Suzuki K Poulose wrote:
> On 25/11/2026 06:56, Dan Carpenter wrote:
> > Resetting a vcpu keeps the old values of SP_EL1, ELR_EL1 and SPSR_EL1.
> > Commit e47c2055c68e ("KVM: arm64: Make struct kvm_regs userspace-only")
> > changed the reset to only clear the general purpose registers, SP, PC
> > and PSTATE, and later commits moved these three registers to the system
> > register array without a reset value.  Commit 85d703746154 ("KVM: arm64:
> > Fully zero the vcpu state on reset") fixed the FP registers and the
> > 32-bit SPSRs the same commit missed, but not these three.
> > 
> > The impact is that the guest that boots next can read the previous
> > kernel's stack pointer and exception return address.  KVM_GET_ONE_REG
> > also returns the old values to userspace, and a rebooted VM doesn't
> > start in the same state as a new one.
> > 
> > Zero them in kvm_reset_vcpu().
> > 
> > Fixes: e47c2055c68e ("KVM: arm64: Make struct kvm_regs userspace-only")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dan Carpenter <dan@pereq.eu>
> > ---
> >   arch/arm64/kvm/reset.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> > index 26081d273408..9c1b42890c96 100644
> > --- a/arch/arm64/kvm/reset.c
> > +++ b/arch/arm64/kvm/reset.c
> > @@ -199,6 +199,9 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
> >   	/* Reset core registers */
> >   	kvm_reset_vcpu_core(vcpu);
> > +	__vcpu_assign_sys_reg(vcpu, SP_EL1, 0);
> > +	__vcpu_assign_sys_reg(vcpu, ELR_EL1, 0);
> > +	__vcpu_assign_sys_reg(vcpu, SPSR_EL1, 0);
> 
> nit: Please could we move these into kvm_reset_vcpu_core() where we
> reset other registers ?

Will do, thanks!

regards,
dan carpenter

