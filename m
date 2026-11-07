Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018389;
	b=gM5C8M5vsY2vNMZdJAmfxHspCQZykUnbpkof35J2TLDhMf9zF6+PDjd8Z/AiTDUzdjGC
	 lNc6kqd2Vnm9AvRtvebCf0PfZX6ySDj9AHYGvCJDwLAWuHx3yEBQe0jOZAMQVjn0urDcT
	 sFCI6/+KNpJu+8ZJMUM+RDVPdZ4feUUJJF+sXgopy6DFh/YnjuCVTzvNZCASNUFrUIOGJ
	 +V3RB8LqKz/pUs12wIYe4wr9lu9TKkQGuTIv21wB/HkdLlqMc9mdpsoJGbPSHVcXYquGp
	 zlinviq9oo1/bp8V13dLCXB/GKnw5fE4/FTX1sry1Gu9MxPvz+KD9y15Lo2o30cdDHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018389;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=J65rKF/UOcwg3jpA5K8U2letQdeUIFDe8iCEa4fMeH0=;
	b=GWZXv5ZyE7hiblniV+uVh41wwhxODJ2Ic4WbNCwbZv+92yxWvuf78HwTT5fxq5kZ9hFr
	 eWNaW/AhEL+U//ousaM9ZQFVaYZNInw4tc9Er5VtOV7/Qe9oVdC2NbpftsLxIg9fA5hrh
	 d1sCCiVHqjlsdvoRw4DjUYwECGXG8IxDyyqsjYswOWRjzhGzSx9dtQNId0RnzT6heLjF2
	 wK51eBbnRaqzY9p60hUJQ0WfySDrqx+r6sLcoxmgtYg7Q2QJwjJCt80XFhjYNsY/lOBqY
	 gf2bzjY/irMXMVRNMkqQEdVy8pK7VCmL8cmL61VLsyrdbqSG8IqjJtY/EXbm9/dxnqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJ59CTmO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C87606A326
	for <kvm@vger.kernel.org>; Sat,  7 Nov 2026 02:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJ59CTmO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7AB1F008A3
	for <kvm@vger.kernel.org>; Sat,  7 Nov 2026 02:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794018389;
	bh=J65rKF/UOcwg3jpA5K8U2letQdeUIFDe8iCEa4fMeH0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FJ59CTmOXSmqgLLS/kwuI0LyNuL1ug3aODUJzy6dHvjSoRVrBC+47wbLp7l7tuic4
	 PDQPeQDka5PgyRspNd6yHYdNVhFBdRMgIBr8CEbxuIEmkzHb+IJ5PYYIw430lgrzCO
	 M40z9Nw2SlavO31sTsIVVzmrH+520H7MlDY4BrAZ86JutwqVrgzX/6vcf0Go+b5Ogt
	 HQ7fY7j2DLp35Wjhkl4yNCNtmBPXVTWDf35eMxutV6L6soBSyZje9mV5rNVv/ZYymi
	 bOADekEiHsi28GtuilwZMekioKybReIx3wb3LtTgaMOfZtEgslZjrdU8awFuHfnjGF
	 p5HhASsAe3aTw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c34bff61551so200266766b.2
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 18:26:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGKq/dPUVljsKmuAbCLQzzGnNfbjGXv2NS8gqOZJQ8ARo6Eg+0/Of7bCkSgzQ7Z5+mi9qo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dfWwHV/JU5GJogpUqk7wPk0Y2CN7ptuPIjJu6lpagIVdRCmJl
	OhAaFL/nabSsHmoajGg0XKpnkvTsXMWKG0joQd83IQMyfBpyk5XogD0EyjoG7fNvPTkTdncXoGY
	2l9gJEnrZWlgjHHJ3Qfedhz85P9UdHM8=
X-Received: by 2002:a17:907:3d8f:b0:c46:ba33:1f0a with SMTP id
 a640c23a62f3a-c4d34cf8aa6mr324118966b.31.1794018387786; Fri, 06 Nov 2026
 18:26:27 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106013927.166209-1-zide.chen@intel.com> <20261106013927.166209-6-zide.chen@intel.com>
 <au4pSeg5AcHEbfDv@google.com> <CALMp9eQZQ7-cGgmssAn5xd5hd7Yqi7fzFJVrTawJpdxZBS4Btg@mail.gmail.com>
In-Reply-To: <CALMp9eQZQ7-cGgmssAn5xd5hd7Yqi7fzFJVrTawJpdxZBS4Btg@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 6 Nov 2026 18:26:15 -0800
X-Gmail-Original-Message-ID: <CAO9r8zPQNzzrT6yqzb5d+vbG7XXM5Puvf8fBmZyHTyLkm1hiLw@mail.gmail.com>
X-Gm-Features: AclHuK-MYTf64hMea9vMNls7vvuOHZctaNDXb9LUURTJYCBAEdZIN49V8gl__rQ
Message-ID: <CAO9r8zPQNzzrT6yqzb5d+vbG7XXM5Puvf8fBmZyHTyLkm1hiLw@mail.gmail.com>
Subject: Re: [PATCH v3 05/18] KVM: x86/pmu: Drop nr_arch_{gp,fixed}_counters
 from kvm_pmu
To: Jim Mattson <jmattson@google.com>
Cc: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 4:42=E2=80=AFPM Jim Mattson <jmattson@google.com> wr=
ote:
>
> On Fri, Nov 6, 2026 at 11:34=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > > @@ -979,8 +979,6 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
> > >       kvm_pmu_reset(vcpu);
> > >
> > >       pmu->version =3D 0;
> > > -     pmu->nr_arch_gp_counters =3D 0;
> > > -     pmu->nr_arch_fixed_counters =3D 0;
> > >       pmu->counter_bitmask[KVM_PMC_GP] =3D 0;
> > >       pmu->counter_bitmask[KVM_PMC_FIXED] =3D 0;
> > >       /*
> > > @@ -1008,16 +1006,12 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
> > >        * in the global controls).  Emulate that behavior when refresh=
ing the
> > >        * PMU so that userspace doesn't need to manually set PERF_GLOB=
AL_CTRL.
> > >        */
> > > -     if (pmu->nr_arch_gp_counters &&
> > > +     if (kvm_gp_pmc_mask(pmu) &&
> > >           (kvm_pmu_has_perf_global_ctrl(pmu) || kvm_vcpu_has_mediated=
_pmu(vcpu)))
> > > -             pmu->global_ctrl =3D GENMASK_ULL(pmu->nr_arch_gp_counte=
rs - 1, 0);
> > > +             pmu->global_ctrl =3D kvm_gp_pmc_mask(pmu);
> > >
> > >       if (kvm_vcpu_has_mediated_pmu(vcpu))
> > >               kvm_pmu_call(write_global_ctrl)(pmu->global_ctrl);
> > > -
> > > -     bitmap_set(pmu->pmc_exists, 0, pmu->nr_arch_gp_counters);
> > > -     bitmap_set(pmu->pmc_exists, KVM_FIXED_PMC_BASE_IDX,
> > > -                pmu->nr_arch_fixed_counters);
> >
> > I understand the vendor modules are responsible of initializing this
> > now, but should we clear it before calling into the vendors like other
> > fields above?
>
> pmc_exists is zeroed further up in kvm_pmu_refresh. See patch 02/18.

Duh, sorry I missed this.
