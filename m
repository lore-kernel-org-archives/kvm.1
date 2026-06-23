Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C413C0602
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782252152; cv=none; b=Bh4puPrvSCKJIRiv/BsG65nhKxontvftS5sU8k/MINi1xkEtjLlNLp9tc9UFcY6+th2mO2YJakMCxjOVpFqAH1s7NqtAs5Gph++xC/zAsj5Oa/H7cNuPKcCDdCOWi52dqpK5hiPdqNK75q/O3i12ofyRUR7sp4v5FZdYh3ysDBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782252152; c=relaxed/simple;
	bh=EcSLeDAkf+NYYlNPbaQDgJqvXTeoGd4kGIS3C758yv8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gb8nxv/9iRmH9U8EkMNovSfpQRxw6b4zEWwedIuTXYH1oWDQdaSaszPi+FS1xW2HzXVwFnoQL1ZVGiHQlzG0A3YLAxqqWJ+xqGeh7KTrFzyGbnJmPceiI1hHT2kRyHmQm0sg1HT2QOEF3KrV3u51h6hDVUegO1BYrgWa8aG6b4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vhl0kAXH; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhl0kAXH"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-842446a3851so233708b3a.0
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 15:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782252150; x=1782856950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRBVZcuKuww3Wq8UWokXWaW99P2Z0kQJ1V7bgh+4dKk=;
        b=vhl0kAXHULtfvtiJaCDzgx7n9ruvBYqAVa1G9edpg630PlxuljAce2Zk8ECMInBwqK
         mOXgIH6LrGBpNuaMowohRmBAy65d3jA2ZzYvPSUdatxmJTY5+80gwCJIZdPaE6i24+W/
         oDMybvSyjP+cNU1+9r5vLkq79ztjucUb+rchm1xYXSudSUnn0Vih072dL7sFPnHwnknk
         jol01Go4e0fRc8qOBlPv2tZqz/9LAIc591z4syHrq095dTlcz8Fsqw/GfUT/SIw759mX
         kMqcA00Kt2Vmzx4P+hqaOqQwH3Awg5Hl2X38N2kXihBSBN2EiWWWwd4BCuVNE/oRCmDm
         3ZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782252150; x=1782856950;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RRBVZcuKuww3Wq8UWokXWaW99P2Z0kQJ1V7bgh+4dKk=;
        b=pmTHpN/sr4jYtpg1I9ewHMwP/qVBxUEJsArotSD45PusEMJMYM37ZEQOfq3Bdv6UbS
         GrtE3oJjOIIXLPSJDaGwi2O6pRwHtcUjTfIzFYaCefemevd+VnaFp1sxWzxu41+bhfyV
         QJTZ4wLacAUVH4PUXWS+cnX3WXflvla2zS3eUyGinwpfb6ZekAnSsgfrrZVkI7Y5gfD/
         2v8m+iX77c4Dp45bcNCSHPh9iz4EfSmsjuv/OieS3lcof+gm8uxsayQgQ6lR9Xucz7ue
         gS23kF9t/QW8Gq79rKd05MhpQV/Kyu3gaVmXtCgeza2DvioAMdGY/p0boFqk5KAQfARn
         /8SQ==
X-Forwarded-Encrypted: i=1; AFNElJ8cC1KjbPbho45v5NsGmbmeTWXqR2UqfGwFGD4oE+AES+Rv+G82fnFvtZYpxp7X1b2Z1ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCZCh66upp181gOeWh2lGuszqtmau08YEFu/214V0gZUU689DO
	2rL5Kk/J0B9uG6YT+9qgBVnx/jIFPtXDh3SFDqSFHsaqUsa797YVX27Kbbci8n8TApP5xcOASZy
	Lo4apQw==
X-Received: from pfod4.prod.google.com ([2002:aa7:8684:0:b0:845:4210:eae4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1886:b0:842:3d8d:bab5
 with SMTP id d2e1a72fcca58-845a27b4293mr1064521b3a.37.1782252149754; Tue, 23
 Jun 2026 15:02:29 -0700 (PDT)
Date: Tue, 23 Jun 2026 15:02:29 -0700
In-Reply-To: <ada6c850-9390-4b91-8edd-c4b74bfe4269@fortanix.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ajJAYZAPxNrrsiYp@8bytes.org> <ajKadxZEMI253AoT@google.com>
 <ajKe-oboTRowcO_i@8bytes.org> <ajKjMIBb21qB46fh@google.com>
 <ajKnKeo1FV3zbjEt@8bytes.org> <ajqMvQLMGONiLn1S@google.com>
 <LV0PR21MB6859D1AEF99FB84228C23620CAEE2@LV0PR21MB6859.namprd21.prod.outlook.com>
 <0657500d-a8bd-4dec-80a5-807e857a4306@fortanix.com> <ajr-AigoW2cJY5k3@google.com>
 <ada6c850-9390-4b91-8edd-c4b74bfe4269@fortanix.com>
Message-ID: <ajsCdRhFEw2pcIXx@google.com>
Subject: Re: [EXTERNAL] Re: [PATCH 4/4] kvm: svm: Support KVM_SEV_SNP_PAGE_TYPE_VMSA
 at SNP_LAUNCH_UPDATE
From: Sean Christopherson <seanjc@google.com>
To: Jethro Beekman <jethro@fortanix.com>
Cc: Jon Lange <jlange@microsoft.com>, "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, "x86@kernel.org" <x86@kernel.org>, 
	"thomas.lendacky" <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"coconut-svsm@lists.linux.dev" <coconut-svsm@lists.linux.dev>, Joerg Roedel <joerg.roedel@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026, Jethro Beekman wrote:
> On 2026-06-23 23:43, Sean Christopherson wrote:
> > On Tue, Jun 23, 2026, Jethro Beekman wrote:
> >> On 2026-06-23 16:51, Jon Lange wrote:
> >>> On Tuesday, June 23, 2026 6:40 AM, Sean Christopherson wrote:
> >>>> On Wed, Jun 17, 2026, J=C3=B6rg R=C3=B6del wrote:
> >>>>> On Wed, Jun 17, 2026 at 06:37:52AM -0700, Sean Christopherson wrote=
:
> >>>>>> Ok, so it took us a few times to learn our lesson.  I still don't =
see that as a
> >>>>>> strong argument for new uAPI, especially not for VMSA pages.  I am=
 very firmly
> >>>>>> of the opinion that letting anything but the host kernel configure=
 the VMSA is
> >>>>>> beyond stupid, but unfortunately we're stuck with AP_CREATION.  Ex=
panding that
> >>>>>> surface has a very, very, VERY high bar to get over.
> >>>>>
> >>>>> The strongest argument in my view (and the main reason we are doing=
 this) is
> >>>>> actually the predictable launch measurement. On SEV-SNP this is a r=
equirement
> >>>>> to use platform VM-identity features like the ID Block.
> >>>>
> >>>> And I'm saying that unless KVM *can't* provide a predictable launch =
measurement,
> >>>> which AIUI isn't the case, then the launch measurement *must* be sta=
ble across
> >>>> kernels because it's part of KVM's ABI.  So as I see it, the issue i=
sn't that
> >>>> KVM is inherently unpredictable, it's that we lack tests to validate=
 a thorny,
> >>>> subtle piece of KVM's ABI.
> >>>
> >>> Joerg is suggesting that we need a launch measurement that is stable =
not
> >>> just across multiple launches on the same system, but across multiple
> >>> hypervisors.
> >>
> >> If this is now suddenly an acceptable argument, please also merge http=
s://lkml.org/lkml/2021/4/12/625
> >=20
> > No, that's not how this works.  Dave and Jarkko both have unanswered qu=
estions
> > regarding the use case.  Answer their questions, and I'm confident you'=
ll get
> > traction.
> >=20
> >  : I don't believe we necessarily *WANT* or need Linux to support "all
> >  : possible ECREATE, EADD, EEXTEND, EINIT sequences".  Yet, it's what i=
s
> >  : being used to justify this series without any other justification.
> >  :=20
> >  : It's going to be a different story if you bring me a real enclave th=
at
> >  : *REALLY* wants to do this for good reasons.
> >=20
> > and
> >=20
> >  : What specifically are you referring as the "rest of the world"?
> >  :=20
> >  : That would be mean that there is reviewable workload "out there".
> >=20
> > The start of that thread is *exactly* what's playing out here.  The big=
 difference,
> > and why this one's likely getting a different result, is that Jon provi=
ded a very
> > thorough explanation of exactly what use case Joerg and company want to=
 support.
> > The only "assumed knowledge" is why it's desirable for the measurement =
to be stable
> > across hypervisors, but I'm comfortable stitching that together on my o=
wn.
> >=20
> > In other words, they aren't asking KVM to support every possible way/ti=
me a VMSA
> > could be associated with a vCPU, they're asking to extend KVM to suppor=
t a concrete
> > use case, with meaningful real world impact.  In fact, I actually think=
 this series
> > is *too* narrowly focused on their use case.
> >=20
> > FWIW, KVM_TDX_INIT_MEM_REGION has almost the exact same ABI that SGX ha=
s: pages
> > contents are measured immediately after they're added.
>=20
> Sorry, the argument from Jon/Joerg is no different than the one we made y=
ears
> ago for SGX.
>=20
> It was previously made abundantly clear that it's the kernel maintainers'=
s
> stance that it's sufficient to offer a UAPI that allows the creation of a
> Linux-specific subset of enclaves with a stable measurement encompassing
> largely the enclave functionality available in the hardware. Or said anot=
her
> way: if you can take your enclave and modify it to work with Linux, albei=
t
> with a different measurement, that is acceptable. KVM-SNP is currently at
> that state: it is currently completely possible to load VMs that were
> designed with the current Linux VMSA in IGVM format.
>=20
> A UAPI that allows creation of all architecturally-valid enclaves for
> purposes of measurement portability was stated as an explicit non-goal. A=
s
> this is the only stated purpose of this patch set, it should also not be
> accepted.

No, the stated goals (thanks to the follow-up from Jon) are to (a) support =
VMSA
GPAs other than KVM's hardcoded, arbitrary 0xFFFFFFFFF000, and (b) to play =
nice
with multi-VMPL scenarios in the future.  If that happens to let userspace =
build
every architecturally possible VM, then yay!, we got lucky and probably won=
't
ever need to revisit this.  But "support every possibility" is not the goal=
.

Side topic, if someone is going to propose changes for TDX measurements rel=
ated
to IGVM, now would be a good time to mention them :-)
