Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FA33A7580
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696771; cv=pass; b=ra13vbwuHlNIDP7vvq8K1COXVlXmzjXARGSKGRX6W5cNro4Gp1ou0GXz9f1ZyS5PXAGAvmY5N/NaDZPvMrPJXsPV7MOZiPHvSloNryuhc34n3SCAWH5OSFzIM834vr1+JlUSp6652j8rB3lIWRIeUwaMCpZuf8S5p0e5fYpYo9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696771; c=relaxed/simple;
	bh=bOQ2be8fkGeTMC2f/z+7+JkbBQdoeMHHpb43YTxSNbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkS9zeEmVDmB8bkfeOOtpwRA4pitl+nMJbF6K15MiHkv/I2KOnLVP/R0RB9ZRFx5Kz1ZcHfVEReAfdLjEoqznoAQ6lyVlaYKZ9jXWNbfSdxUA8+M+I3/dg26LC/P/SntEI0hAR8FSy6KURTmZsheFqE1MSgcLuaVgyaOQ3/+hv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LJk/E68/; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LJk/E68/"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50d864c23bdso25911cf.1
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 11:26:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778696769; cv=none;
        d=google.com; s=arc-20240605;
        b=FPB/zQcL0+K94ZBY/y1kwzsLfEXya30pfZUdxjz0S/8Nw0iBAjYn1XkQmKBokSyI0I
         JmzgNQPMOBfKl/tmHe9z/3sUtsWqKO45hRIsvbXDfpEFYPtSp4+a/wI5l68rfMUikRTy
         YMApFflsGmLbvvSklcOwiZgvj0r5hiYRCXbP987ZqvkfpGJt+LlP5mIhAVoAWqLhkkyt
         glclNlXztweek97uJotXZ7G3wj9RLBJWOK4KFW3r9EI5IzN0kWbnFw/Yfks9uppG9YsK
         DPPNG/CvZok75tkS358FI3nazHfoxVzELzvokYm17hNAhpye4gkMh9Ng2rWvlD7Z8Nyd
         mx+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DMg8Xr7ID4ZghjoDyYMxZT52uWzZZhVb6ew/isp6U0w=;
        fh=MrG47Zlqw/GLttGgFZN7SOl71EaT8mjKKsEc+RW/SrE=;
        b=XxbW5I/9rrJ98IwnJR3OlVuijud/SAkf1p89Ey/dBhO1S/m7LWB89KXC7KU/Ee9F/e
         y2cyBQ4b54j524zlSwps1TcQVXFx5XZSR2Alfaaeh433YDUkbq51vtPbgMMPoumJCchv
         z7uWZArcCu7jYg9i4B1ZAyMgiu+1WBVRUGfw15RMpsUCDV4u220MaYqhWrnoA2oCeIbP
         FMnmnnd4tAQgJgDit/Mz5AzVr/LGLG0Ds9mv9jdlTFak51gP5BQfJky7zDgdsE6rAGCO
         R25hZZSphwoX0K5AVKffa2Hjr2lVyZt0DdBHmPVGop3qcliFyeOGJNQwqOqjTh50EP40
         zEvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778696769; x=1779301569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMg8Xr7ID4ZghjoDyYMxZT52uWzZZhVb6ew/isp6U0w=;
        b=LJk/E68/LhaHe/KpQSZAHAoZBD9DPTaPVzH1j7WKqv3aebe8Zqn+k1OTJJqD6EVfa0
         7CBB5ou1ro5OpARBdiFINTKi0oWZY6FfXgjYP9e8tL6hoT9yHHqOjYwORh88DVVGU95W
         3cIY4Iyku5ejIyEgV5yZKhRuWaNbhgbNDMyEhmCG7Kj64U/E/kR8b+WgMWvGkvDoQ9+7
         j7fT4BCrKR9P2PkNm6Yge3xaaLmFttX1csz/iAnQOusmc0qRvPu1Sgm0bG3+2lkdQV2E
         1t9yoiScWG6YVOg4amTZib2WgDPdD1Bhuk///tyxIZCnG0rCKP2l11CYAehn1QwTC1R8
         8CYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778696769; x=1779301569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DMg8Xr7ID4ZghjoDyYMxZT52uWzZZhVb6ew/isp6U0w=;
        b=eiqA1ZOt0cTrD0x9//ktTCksk2GFZFT+MztKtE5r1ajZKTDgTihAoZ9vZtkUci3Df5
         yCmJ1iZR5a6CiP2AH5A5d7GSTuCwxuKbiWN+WP3/0CuZQWPXAnVF4Q8BwgBQhSQkFar5
         FJ4LxzXkKSftf+z2VfOF02X4vfzizm6rOxvMmyhh/JgLtBKdT+UXTgyS/xfIy0xtqKY5
         LPSya78Sk4FgUMsTpoiDO8on8uPMHrR2yNIqN64Rqp2CUMkfHqwx1sZsP3L9YbE69RWc
         y70Vr/fy6bDq0xRLIWjgTn3pBj96CYA2iwTAIa7jCpL9Iz3geeiXiu3/N/JBc+KU0DZp
         N/VQ==
X-Forwarded-Encrypted: i=1; AFNElJ+xHd4aMQor5nc+oYbJ5gGCI/5bB3mRg3Qhyrxtg1e7H9wtA/W77i88O9QG9AZNGPmlhAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg7zDpI+3axul6b4pAMmp5JrO8eUz/xizS+11UmTY7KHFR3ZKs
	aKHvuoCmHZ7gIAKjyaYmgbp8Q7+KYb7skDX/MnYpY7z5/ZBJWC0S7/W7DvB+UCPig01w5j9AXlT
	bFOG1m4agwp9w5Jvk4uR679qJUbnOWWHuUCqPkBbx
X-Gm-Gg: Acq92OFIuc+mgebqtG570SLTAR7ZTGr+S+XK8d/K4C8LUExAq/+qS5nmuo/Ln6+oquW
	PbBhTW7iQEr40WHXwbb1ZfPrgFiiTKHqX7olcEyLwNjHnFCCc1cjmLHaGxF+AVm85OUFXA7GlWl
	lqIbvTCJKt3WGJ40DRIqkhqZW0pofFbPfAI5BU3qzIfJodf+3lzaGeIOpID9Kk51RGZVbRdNoAy
	QxAwW8UKBFbv8gzIrQWkJ18ZijMJZmbeosiJvIKiIZ/XMYej7z8GjjtNRMruPldMXGpC1JOcVKi
	4sPy8Lgj2r5//4GBy681UfJFvGAsLvDXTn7ty3WWOs8SioQUbw==
X-Received: by 2002:ac8:490d:0:b0:516:3f51:81cb with SMTP id
 d75a77b69052e-516430080demr382411cf.13.1778696768595; Wed, 13 May 2026
 11:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505014118.3783476-1-vannapurve@google.com>
 <20260505014118.3783476-3-vannapurve@google.com> <afvIuEuSYuktmtA2@google.com>
 <3dc2300e50f655e261115099b416c6a1abbb9e9d.camel@intel.com>
 <CAGtprH8kn_mOQuwpoTBgg6WQC==cKh8fuYOpNOih_PjUgcUeGQ@mail.gmail.com> <afygu67KZuyRql_M@google.com>
In-Reply-To: <afygu67KZuyRql_M@google.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 13 May 2026 11:25:56 -0700
X-Gm-Features: AVHnY4KfkfUNd9f7re3wULZmLvPEsHjGwx-FOQlzDpULgQm8l1AnYY9zodO7e0Y
Message-ID: <CAGtprH-3+oLAf=cMfST4hVrHJWuDJ601K+TqzQ7y2RKnKkrQxA@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: TDX: Disable pmu virtualization for TDX VMs
To: Sean Christopherson <seanjc@google.com>, Michael Roth <michael.roth@amd.com>
Cc: Kai Huang <kai.huang@intel.com>, "jmattson@google.com" <jmattson@google.com>, 
	"mizhang@google.com" <mizhang@google.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 7:25=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Wed, May 06, 2026, Vishal Annapurve wrote:
> > On Wed, May 6, 2026 at 4:56=E2=80=AFPM Huang, Kai <kai.huang@intel.com>=
 wrote:
> > >
> > > On Wed, 2026-05-06 at 16:03 -0700, Sean Christopherson wrote:
> > > > The question then becomes, do we keep patch 1 and also clear enable=
_pmu in tdx.c,
> > > > or do we keep the ordering and have kvm_arch_init_vm() consume has_=
protected_pmu?
> > > > Neither one is particularly awesome :-/
> > >
> > > Maybe keeping patch 1 is slightly better?  This allows the vm_init() =
to toggle
> > > all the values and flags that the default ones don't fit.  If we go w=
ith latter,
> > > when there's similar cases where we need more flags, then kvm_arch_in=
it_vm()
> > > needs to consume more flags.
> >
> > For now I have sent a v2 without moving around the default flags. It's
> > definitely better to move them up as done in patch1,
>
> Yes and no.  No matter what we do, we're subtly relying on ordering betwe=
en
> initialization in kvm_arch_init_vm() and kvm_x86_ops.vm_init().  I don't =
see an
> easy way around that.
>
> For these fields:
>
>         kvm->arch.default_tsc_khz =3D max_tsc_khz ? : tsc_khz;
>         kvm->arch.apic_bus_cycle_ns =3D APIC_BUS_CYCLE_NS_DEFAULT;
>         kvm->arch.guest_can_read_msr_platform_info =3D true;
>
> and any other fields that KVM initializes with hardcoded values, from glo=
bals, or
> from local variables (including @type), I 100% agree that they should be =
initialized
> before calling kvm_x86_ops.vm_init().
>
> But with the proposed has_protected_pmu, I'm leaning towards keeping this=
:
>
>         kvm->arch.enable_pmu =3D enable_pmu && !kvm->arch.has_protected_p=
mu;
>
> which obviously means keeping it after kvm_x86_ops.vm_init().  Because if=
 we make
> vendor code responsible for clearing kvm->arch.enable_pmu, then (a) we ma=
y end
> up with duplicate code for SEV-ES+ (does SEV-ES/SNP allow for a virtual/e=
mulated

Michael,

I believe has_protected_pmu should be set for SNP VMs as well based on
my read of AMD SNP spec which suggests PMC virtualization managed by
hardware for SNP VMs and not by KVM.

> PMU?), and (b) the x86 code _looks_ wrong, because kvm_arch_init_vm() wil=
l ignore
> kvm->arch.has_protected_pmu, while the KVM_CAP_PMU_CAPABILITY case-statem=
ent does
> not.
