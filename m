Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE8D3F0AB9
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778163902; cv=none; b=sis8y1Nc8o8UPJsbQFNJe2hPd9PCTU2HyMzUxhcQZLBWHGPKQMuirrTbNy6mf1B3nRVxFvkrznNUEkrmt76Mu/TlOU1048FQ2hCDDMg6HiJILPSmHgmmGOZ5XDU+9XGd8h0mFTuEp0NebkrMOxKN/VuxJ8hTzCv4lA1OR5IHZcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778163902; c=relaxed/simple;
	bh=nZesoX51eLCu95x6PFt0fOyOLMk/se8Or2rzUOjxC2o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LYYW/DloPLcUnYuAL575khdk433+KTxgxeeUyeS4iWHCkqsBCBhXFvODw9Ky8ksZxbA+nNT1fNTSg8YS1R/dt9EeNaXeV/ACsN3eXyP3uhRo4ix8DU5JMMTacjmKQL2CyX/EBkOSnHNvDQCiuaJqQu/N/14WqD+ObeGNKjerDks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vxRL+vIe; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vxRL+vIe"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3662e7756f0so265792a91.1
        for <kvm@vger.kernel.org>; Thu, 07 May 2026 07:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778163900; x=1778768700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+F8gFHfd0SizZ9ak5QQB4kjXBe2dj5mD3skrDr2/uBE=;
        b=vxRL+vIeUrX+71s3+/D3wUXTJqalQFhm2cICQwGLh7PeXzDf/yI0N4J8t5e1eJBYr+
         PKsLD1kh9mp6VVbTyw4JxU2DU0BQ02AMXc3FUalcfK17uZvpAKN0Vjfc3+jJAjs+1Wnu
         06mNsgnsh1mDivOe62FyqG7peKA7sJo+B8d/6yU9wB1w5qlpde0zbf1N5oU85ZGjgOjS
         e3aG9tJAID5DR44529vRrCowDP+5nsz9LoG9vrDsKc+njNwcY+4HuJDR4B2KTpU83F99
         wTfinEGkAo9Xi2oepkWrB3KfBAOlB/6HnHD+52aucDQbBdQp/e94HF13oGlO9Y6fHuSv
         8Wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778163900; x=1778768700;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+F8gFHfd0SizZ9ak5QQB4kjXBe2dj5mD3skrDr2/uBE=;
        b=eCOP4WqvmelDKj7NeBvvnJ8NZBczbdopkganCInCrkBlgnm4tPd3ncakKsImSjsDE2
         gNgxgHVUoRzIJrpUml4muyvBsulB3zgmEam3Li7VeP95uqOb+HoMvhnxLIuVaImlLqwm
         GhEQMXBjH6zD5udp6zL6PXZB7Dc+tkCPV9+RKxaWmzYr9j8xk3i+egdJN7YFKyCBmacF
         jrzDIFh1X/d9exSwRaljBHgaqHLGcPbg5+XVoE8Oxi2u6ldW3qXNd+dyJJikBTjPdUAq
         YM4QOoYzVW+Rdomf88Kw7H7mkcqRVMRU03D6mqYlD1lOyH9Fja0rWMluUxVl9vd52luu
         FVkA==
X-Forwarded-Encrypted: i=1; AFNElJ+pKRVx7hc0U8K0lEXy7Y9qib1lRs1G1avz7oGoO6+1GTTD0pyv02qeUKfdSbT51dYK6hs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj5BOaongNt8+imfmzzzKyxQhcaYn7vBrby3snsCujJr/xIHkv
	zYj9tsCEWMdlYZ3FzKcN9hTdXB0dhGnt6YOcQC8DCT9S/+ws0twF6bSZ5AFuvFfA6bhU4dBxzgR
	xEceByA==
X-Received: from pjbrm7.prod.google.com ([2002:a17:90b:3ec7:b0:365:c485:83d2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e18c:b0:361:45df:103
 with SMTP id 98e67ed59e1d1-365abae80cdmr8301469a91.12.1778163900247; Thu, 07
 May 2026 07:25:00 -0700 (PDT)
Date: Thu, 7 May 2026 07:24:59 -0700
In-Reply-To: <CAGtprH8kn_mOQuwpoTBgg6WQC==cKh8fuYOpNOih_PjUgcUeGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260505014118.3783476-1-vannapurve@google.com>
 <20260505014118.3783476-3-vannapurve@google.com> <afvIuEuSYuktmtA2@google.com>
 <3dc2300e50f655e261115099b416c6a1abbb9e9d.camel@intel.com> <CAGtprH8kn_mOQuwpoTBgg6WQC==cKh8fuYOpNOih_PjUgcUeGQ@mail.gmail.com>
Message-ID: <afygu67KZuyRql_M@google.com>
Subject: Re: [PATCH 2/2] KVM: TDX: Disable pmu virtualization for TDX VMs
From: Sean Christopherson <seanjc@google.com>
To: Vishal Annapurve <vannapurve@google.com>
Cc: Kai Huang <kai.huang@intel.com>, "jmattson@google.com" <jmattson@google.com>, 
	"mizhang@google.com" <mizhang@google.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2026, Vishal Annapurve wrote:
> On Wed, May 6, 2026 at 4:56=E2=80=AFPM Huang, Kai <kai.huang@intel.com> w=
rote:
> >
> > On Wed, 2026-05-06 at 16:03 -0700, Sean Christopherson wrote:
> > > The question then becomes, do we keep patch 1 and also clear enable_p=
mu in tdx.c,
> > > or do we keep the ordering and have kvm_arch_init_vm() consume has_pr=
otected_pmu?
> > > Neither one is particularly awesome :-/
> >
> > Maybe keeping patch 1 is slightly better?  This allows the vm_init() to=
 toggle
> > all the values and flags that the default ones don't fit.  If we go wit=
h latter,
> > when there's similar cases where we need more flags, then kvm_arch_init=
_vm()
> > needs to consume more flags.
>=20
> For now I have sent a v2 without moving around the default flags. It's
> definitely better to move them up as done in patch1,

Yes and no.  No matter what we do, we're subtly relying on ordering between
initialization in kvm_arch_init_vm() and kvm_x86_ops.vm_init().  I don't se=
e an
easy way around that.

For these fields:

	kvm->arch.default_tsc_khz =3D max_tsc_khz ? : tsc_khz;
	kvm->arch.apic_bus_cycle_ns =3D APIC_BUS_CYCLE_NS_DEFAULT;
	kvm->arch.guest_can_read_msr_platform_info =3D true;

and any other fields that KVM initializes with hardcoded values, from globa=
ls, or
from local variables (including @type), I 100% agree that they should be in=
itialized
before calling kvm_x86_ops.vm_init().

But with the proposed has_protected_pmu, I'm leaning towards keeping this:

	kvm->arch.enable_pmu =3D enable_pmu && !kvm->arch.has_protected_pmu;

which obviously means keeping it after kvm_x86_ops.vm_init().  Because if w=
e make
vendor code responsible for clearing kvm->arch.enable_pmu, then (a) we may =
end
up with duplicate code for SEV-ES+ (does SEV-ES/SNP allow for a virtual/emu=
lated
PMU?), and (b) the x86 code _looks_ wrong, because kvm_arch_init_vm() will =
ignore
kvm->arch.has_protected_pmu, while the KVM_CAP_PMU_CAPABILITY case-statemen=
t does
not.
