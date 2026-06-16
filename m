Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C964329C57
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616219; cv=none; b=rgUZFQyYZ1AcrPZ9Zav1PRm+CEkytnjcMjFGOzrea6M1EG2eOFGloQQK3LRAyEJ/rYJPzQiiW1Wh7VMU3ZGaQfkl9s1bleBXCkxeOnsbDdYlNbwv1R6SoGY3GYfus8Rqm8usJ9IfZmE2gmp6W7EQ3RcCxbOtAvDNV0impe/yr4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616219; c=relaxed/simple;
	bh=guMWy7wf98B65PfVClETVri2NzA1ofjmGgJWY8rzEb4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=nuIx5qjSCCsdwdT7r3rQ61ULJOOsVIvDdgsCfg89yRhSWvRprL4DNO1Q/nQoG7ZJ7QaaswYJQKVsPEvbVxEwKxOmbx7is/e3pw5qsouZgpLhHqbDl1ifRI8W5kC0ZTbnNA02AvytNJa/Gucknh1Q/hRxSuisBAiZSURmwO8om9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeS9FKln; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeS9FKln"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-37c5b9d42efso229019a91.1
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 06:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781616216; x=1782221016; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i2eQVWR69DVBll8DZTLTpPBD8LsUE2YsnnLAZbM4NLE=;
        b=JeS9FKlnZWX6vOmsRq815yzvCmadjACpNiIdJjmdx2tKQfvPw/Va6P4hYzAaHjj8R8
         VvfZf6LHKKAc0b46wgdxM7yxHn8XijamyY323Jd2aAgZ6HWUsp32pafusdS0ccPqX194
         LD0XcpAFnejk3WEmf7FJKlIku7l6WhDAbM/uYyQ1y+Xu+JNjwcVD6q4diY3xpOeiU9vw
         o3tuCWW5DB7xEcCXejildWIb2Go0ouFB7f5NMF3pxs7cLKjJ7d0Q2U0rBvr/VMtIty1A
         Pv6BAS9DPj5fmEdl3HXr0xWAruVm9wV1xn/Vn9YhEKguGTlzRvHanMJLTeyTuXJqC15E
         I9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781616216; x=1782221016;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2eQVWR69DVBll8DZTLTpPBD8LsUE2YsnnLAZbM4NLE=;
        b=rq6A2LUTITX66NM4p82XEgsV+4zsZEUKGtcc0rUieqGOOOvZv07KMCuatq2zbz5pz1
         B5UHxTGLlHi9U33l2ujLmEZeYsk4yvToYQoZBruYcnBrlTfSNlcQPovVaCl86RfNUUGB
         n7rmynLMXGZg4++Cyz5o8xUXmXydtWi3HmJOMxHYdaP2nkf8u6vmcKjYCdV+Gm4IZVWh
         9Wso75LBRJaN9YewZokdZxM4iZ/boA3L/VMWU7R+0JI3XD98A9UOmey0xct92QJJAR/u
         6amaKhWiCgs3QGmIBxkTZKtgPSHsswM1ZTIufMu9XVqI7BIFeFmQOQ7GULBAnYill2D8
         GiZg==
X-Forwarded-Encrypted: i=1; AFNElJ9viW1rIoo21Oul++vNZRQzZfoWFkBxUfxzS/y/PylqxG0CMXbhM0f/6rUSx8/7ltxTPxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3+21prgWQLGkjqn+WaW6gslcGCTuq68UJ1BHBKSl3EwjLPkPJ
	cohWe5P7wfzeYfaPBp0Z6EbTrQD9VQfsM9kwnfDAq/TKhuk3D9Au44JU
X-Gm-Gg: Acq92OGscP17EuLnj1hm6YdBHCzpBDb97mnroC9wwkSYPy8Lpt7irFfp2QqaeGx3TmY
	8rkVuf6H1e5YtGRDLM/gOk4P7jdFZQpKCI5BVI5vTV7tVeF3g//YddAASH6xl6NzSNK4UreDH/H
	va52FcKvH2w0rDRHnGbWhPl/Rg2uN7gMcqZToQqKJziVAErw6a3qMRAobhXXc2qhbRefwVW1+/i
	UlkmPGy1syOwiCTIXBUiR581y+G4Y6Lu12xr5byknrgp23Uj8pt4DMRJrmNfinlDhk0CRmuSQcw
	FbOZKa1i3i5+iMgHfVDNI67R6nXmGwtjsceY5dOCvcRqC0xqnqYlfG9iHuXXq09tFDZ8xP+3DWc
	qMMTzwtQ1DJYDauMVvbuOCfPJCPtQwtodC1spiZavLtTpCO9EIxb3wwdkCtzq2f5mt+qtSBjqy2
	uKJpCJeXwfC4luU9u6+4VAE65gUQ==
X-Received: by 2002:a17:90b:1d51:b0:368:65d1:893 with SMTP id 98e67ed59e1d1-37c5235adeamr3228415a91.5.1781616215829;
        Tue, 16 Jun 2026 06:23:35 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c866518677dsm11704475a12.19.2026.06.16.06.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:23:35 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
In-Reply-To: <20260616182627.2ebf3cfc-3a-amachhiw@linux.ibm.com>
Date: Tue, 16 Jun 2026 18:39:11 +0530
Message-ID: <8q8eeio8.ritesh.list@gmail.com>
References: <20260609053327.61563-1-amachhiw@linux.ibm.com> <cxxqerzk.ritesh.list@gmail.com> <20260616161011.835c90f0-38-amachhiw@linux.ibm.com> <a4suelh6.ritesh.list@gmail.com> <20260616182627.2ebf3cfc-3a-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> On 2026/06/16 05:38 PM, Ritesh Harjani wrote:
>> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
>> 
>> >> > diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
>> >> > index 3449dd2b577d..7472b9522f71 100644
>> >> > --- a/arch/powerpc/include/asm/reg.h
>> >> > +++ b/arch/powerpc/include/asm/reg.h
>> >> > @@ -1356,6 +1356,7 @@
>> >> >  #define PVR_ARCH_300	0x0f000005
>> >> >  #define PVR_ARCH_31	0x0f000006
>> >> >  #define PVR_ARCH_31_P11	0x0f000007
>> >> > +#define PVR_ARCH_INVALID	0xffffffff
>> >> 
>> >> Logical processor version is defined as part of the PAPR spec. We should
>> >> ensure that this invalid PVR is also documented in the PAPR spec.
>> >> 
>> >> If you have already taken care of that, then please confirm and feel free to add:
>> >
>> > Regarding the PAPR specification documentation: The PAPR spec documents
>> > the valid Processor Version Register (PVR) values for each processor
>> > generation (POWER8, POWER9, POWER10, POWER11, etc.). However, the
>> > PVR_ARCH_INVALID value (0xffffffff) introduced in this patch series is a
>> > KVM implementation detail used internally to mark invalid compatibility
>> > mode requests - it's not an architectural value that would be defined in
>> > PAPR itself.
>> >
>> > The validation logic and the use of PVR_ARCH_INVALID as a sentinel value
>> > are documented in the kernel code and commit message.
>> >
>> 
>> But that still worries me on what if PAPR wants to re-use this value for
>> some other purpose in future. 
>
> This is a valid concern about potential future conflicts with PAPR.
> However, I'd like to point out that PAPR explicitly specifies:
>
>   "The first byte of the logical processor version value shall be 0x0F."
>
> Since PVR_ARCH_INVALID (0xffffffff) has a first byte of 0xFF, it's
> explicitly outside the valid PAPR-defined range for logical PVR values.
> This means there shouldn't be any risk of future conflict with PAPR
> specifications.
>

aah ok.. That make sense. Thanks for confirming that.
Can we please update a small comment in the code and log this info,
maybe something like:

/*
 * PAPR specifies that the first byte of a valid logical PVR value is
 * 0x0f. 0xffffffff therefore lies permanently outside the PAPR-defined
 * range and is safe to repurpose as a kernel-internal sentinel. KVM
 * stores it in vc->arch_compat when userspace requests an unsupported
 * compatibility mode (e.g. Power11 on a Power10 compat host);
 * kvmppc_sanity_check() detects this and prevents the vCPU from running
 * until a valid arch_compat is set.
 */
#define PVR_ARCH_INVALID      0xffffffff


-ritesh

