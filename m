Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5D443F4B9
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 22:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784759992; cv=pass; b=VTsKhIMoJNiV4/PKzF6QjDQ72Hxjd9iIISN1A4X/z9wl7dK9gFMaGMJ1ltKmPpsfNQsPf6t6REfzg+kpqULqTkcXjeIOihWZ/uH6+ScSO0IkLf+oQTKeAdxK1peu6csaIWY2DgjKS6gY6rMbK2bTWfpHyy2xlhy/wOdJBa3Qj20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784759992; c=relaxed/simple;
	bh=NUVtR6oLiqbMv011PJGxsr7p8RuOHEkFhONN8rzhZFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4xCyJIhxcnZFCsVDk9jnIuVr7LAl6TS1iOd/Vay7qCjRx1SNofTd5aGO2YlSSDZqKpPO1a1uAKyASec2MX7L8sb5Y7u+WD/DuLkpMqR0giZYYVTUR1jOEaR9g/L5hSJMrrfowgbEDQ0qFl2gt1mM+5zJjJ4KjmUqR6zmdvn7nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y7fntrTs; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y7fntrTs"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-698411099d6so3688a12.0
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 15:39:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784759989; cv=none;
        d=google.com; s=arc-20260327;
        b=aLvI70yGA0KPIrJ/ZgaVoCIrNJh/NrB0C5w5Hgktpz16Gi1A/li00LwHbG3I7l09Iq
         KM1hlv8x95tpLYnweM19YR0CBJuEzbSJhdlMDKSQMO4rOzlCAsFAfzDueLgGbMdwAGRv
         BPHy6wMv4UR7Y/24NDu/AtfR2raAHIPcUeBw4g2LGbfx0EL50sFEXg4CIXC3/Qyi0+pd
         lH4H+QsqIUJx8DSAPfsnBw9IVp55/TOUBK9JDEvW8L04TKkrpaT8KkwSfpuvdVjHMd1H
         8Rw67OK8UIEX6I36Q3crqWd1gmZq/sBZbWXbdkEJI2tvE0srNlBXpBx9mkGTH1YWOj7d
         3KvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=67VankUU07L+hYpL8u5F7hoQyz9z0B3ePv3ZojbcAGs=;
        fh=qcbMT4joAdFN9KEqqJg2rlBc8O7Z5R3zpuO0fF00hRA=;
        b=MAcm0rIi8TL8rQWeb+SD6mLrZON1W70GxzbQPxAL8lqrCMg44+bJChFSJGIMbPWl0A
         E4sbdBpE/b6ojzVxqqJgHCzp9hqzQ3tlgOLCTXTfyfgzobKqDPdqRcCsFw098sYcCxvh
         2X5losS2seuYKh5DiMiHiPNIa+8B+Mb46kZF8xzZlL996BaiGo/HV8d9rpDrSa232Cnt
         +TmhM6TllmQPCo9C3Nx8+ChGOeKBD7XKcr2P2uV6lkYonJLcseeLiPMiArnlhJiWR3cx
         mU0as93WwLPP3y4GtB2WEDPH1zLSx9u8E4YXy2cr6s0TXzKqsqgBOa9a6mw/0yotY45l
         dLKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784759989; x=1785364789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=67VankUU07L+hYpL8u5F7hoQyz9z0B3ePv3ZojbcAGs=;
        b=Y7fntrTseggu4KQlhRX5hBu1987v6J10Gf46k++7m856V0S+s6Acgw8d3TFjISi36W
         3l5BjNBiDSLBcKtIY3aRmK4G/Nc6s2DUU/AksY+AyS2WLuTJm1ZChFyj4+ryJiA/nUV6
         YgCNPB6LCyh29FUYFykoLL0myV4Y5zMUgMZGfdA9leiYJpQfJA76p1EmXZ2jIMZeOGLb
         sx+r80CJTfqU/vcfgnDC1gfsOKp4WCq+wlxykjVw5WAex+pvFe0EM75kj6RHaogkFo4z
         LbvvIILXONs6bXQVcxTjy+RooCB8V9BZsRXJ+cP/U3xDlOHAIrqgrJv/y+flQR5jtiTz
         PukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784759989; x=1785364789;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=67VankUU07L+hYpL8u5F7hoQyz9z0B3ePv3ZojbcAGs=;
        b=UVp7UjZK6uhccx9ofOE/78/zX8Q5FUy1lCyg0SausEKt7u4Ifut8A9DpuAfak3ya1R
         kfyXLg8sskQguLj/dur+ZeUlJpvt3Ed1O3NPX2lAzgqDgoonuqevUvZFEfxYrlQNjIya
         SFWZHPBGMXeP84rgqZvrMt85tGZ4ticUD1tMi8vBucewvwK9v8TklFaddcz4N9MgGWMr
         I0fIk6D3UoJnyDdqH/J4QjSxzH5woGh9F5QueJtDL5zB0Rj+VSp9NLh98qRmAw+ymrSr
         xadY2YkApE4m5/r9DaPcPRI2ewAnztienEQ8wqZ2VWi15AqmcACg32W75wsRlQkbCYvp
         Eelw==
X-Forwarded-Encrypted: i=1; AHgh+Rpxr3qcqeFIabmU34kTxOsZPHCkbyvRnY6zuB318dIdprdXcZTEzuk433rhN6jz5/z8TnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySSplRCzT73mzHuo/8FxHoKA7CeE9Rapc6ukqVqLHUxs3+H1XL
	Sr31r+qVD4uS1h0Q6LXALnimKnadvQydaj7sDupdh2UncWZygRQSI6bGuXeoCTkZ29GHmAJ3++b
	Nzr13qH5ZDpkNmxw9Ijei52aCfwiz9MrAv43jy+Ou
X-Gm-Gg: AR+sD10ZxNDQTJVfFthjdCEvxbm6BHpPnkpRiyMTLcBvS4Al/QJU32k8PsZPMS1UntX
	ULV+j9J5sIsRcME7TkMkE/nci9snVYHxGV1qm73xfSzkC044Moenrj3yAz4P6OIEVmkZ2ClXThO
	yQSDI/+EKiLzA7Y1EltaKRnz06C8tiRBmoFdlfva/fQhSk8CU0FAHg9YJBPmZzC/Qlx45IqpKI1
	LX0ZJkhNw35fEiRS/xDKhkklGtzCQ8SFM/xvZwQksNL9x4gBsu7tKo+mqrpbg==
X-Received: by 2002:aa7:d552:0:b0:697:7f69:48e3 with SMTP id
 4fb4d7f45d1cf-69f60efc2bemr19773a12.10.1784759988897; Wed, 22 Jul 2026
 15:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-3-yosry@kernel.org>
 <CAO9r8zPnXM1rypG8=YVsb7bir3J084Sza-0onnNX3s=uPK-JWg@mail.gmail.com>
 <CALMp9eT2W-oPtMpFdHZi1=F5MwVpx1YWKTh4n+O=STz7N=F_qg@mail.gmail.com>
 <CAO9r8zNso+8iKgiHc_VnCnTLKor-mGsFEV1U1N=RVLdn=FPNUQ@mail.gmail.com>
 <albJNb-akQJ97Yor@google.com> <CALMp9eRGx=K+UBp76A=dZ=bD_Txonq7j8pSn9HVczdtyyuAs3Q@mail.gmail.com>
 <amE_nPDem-imSfqF@google.com>
In-Reply-To: <amE_nPDem-imSfqF@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 22 Jul 2026 15:39:36 -0700
X-Gm-Features: AUfX_mw2448vDanCp0JpGtZzAoOCYEK2pjcZPynQtAfGrdDwjCakoF3WFSKCnB0
Message-ID: <CALMp9eQL7y5chFEDCrqMR9CbJgiJxXN1hVzxVzojsr92AWnqrA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/25] KVM: SVM: Passthrough the number of
 supported ASIDs
To: Sean Christopherson <seanjc@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 3:09=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Jul 14, 2026, Jim Mattson wrote:
> > On Tue, Jul 14, 2026 at 4:41=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> >
> > > What complications?  Advertise the lowest common feature set for the =
pool, just
> > > like userspace has to do for literally every other feature.
> >
> > The problem with passing through the number of host ASIDs to the guest
> > is what to do when the combined host plus guest usage exceeds the
> > number of available ASIDs, particularly when FlushByASID is not
> > available.
>
> But that doesn't have anything to do with the number of ASIDs that KVM en=
umerates
> to L1.  As of this series, the number ASIDs KVM will consume in hardware =
is a
> property of the total number of vCPUs in the system (one ASID per vCPU, p=
lus one
> more for nested usage).  E.g. if KVM advertises 10000 ASIDs to L1, all 10=
000
> (10001, if ASID=3D0 counts?) of the those ASIDs will map to svm->nested.a=
sid02.

That's not the only conceivable implementation. KVM could advertise 64
ASIDs to L1 and reserve the corresponding non-zero ASIDs for L2 VMs
(i.e. the first L1 ASID is 64). Then, vmcb02.asid =3D vmcb12.asid &
0x3f.

> Of course, that completely undermines my statement about suboptimal perfo=
rmance:
>
>   And potentially suboptimal for performance.  There might be a legitimat=
e reason
>   why a CPU generation advertises X instead of Y.
>
> My bogus assertion about performance notwithstanding, I still think adver=
tising
> what hardware supports is the simple, sane approach.  Because at the end =
of the
> day it's just that: advertising.  Userspace can do whatever it wants, inc=
luding
> peeking at raw CPUID.  E.g. if we want to pull a stupid and emulate the b=
ehavior
> of ignoring "unsupported" ASIDs, then we'd need to do that based on users=
pace's
> defined CPUID model, not KVM's advertised support.

But you could refuse a userspace CPUID model that claims more ASIDs
than KVM supports.

And __nested_copy_vmcb_control_to_cache() already ignores a bunch of
unsupported bits. I don't see how this is any different. That's how
the hardware is implemented. Intel likes to fail VM-entry. AMD prefers
to just ignore hypervisor stupidity and move on.
