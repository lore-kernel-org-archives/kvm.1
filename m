Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB25F368D73
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395747; cv=pass; b=ljBM2+NnCbRTYT8gD4KSSEAXFEh6EYZQzhnZ14TDRnA3doSEge80+D89eh/OBzHhny8a11kML4we+O233+VwByrOBcHZRTY6bZ0U78xIVSfg/G+72fyKLjbTb5FeqzPXmNP1sba2PokTd4wQdIFA7VqgmhJHQVPzA+jUQYk3Hk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395747; c=relaxed/simple;
	bh=gTs2P4GzAID4bhAr2SIwiMP+u1/EHGaiVI3xg2u1e54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qb7BKg49ijnN5BC2jA0SDQo+dmpSIwDiomUrvKbHfwTDRfyX/iqLJ4xgbd5k3uW9OJO6pBVfrA1XbHIncLFmyeYeiKyOxBWXDH5DH+A19ZmPGlRzcBCYscYQyiMBZ0BiWuDxVnGJ/TNDtfwlc/t56p3Y1vmOsxPTuEvEazsm9cE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f3uCN0Ez; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f3uCN0Ez"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c10e86e52so132691cf.1
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 00:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785395743; cv=none;
        d=google.com; s=arc-20260327;
        b=M2lpb1+dWpboIW3yIGc+vRE5+Ahc/PW6fb8VfgvJjrLT60ITBbFTkWqIr4USaWZjuM
         MCnLgKNOBzoz/9E+5Ivbg9KCaz9srd37rpbnP0IMhDLe7jLqezZ3ynU6sz8KkCyptpeo
         6e2Zz49XVSWEB6Ls7Jr9WczMZa36iiSwXPQLJBGrTZp24DrkFHsr7CbaYYNG3zdmwCkt
         FBCPdInL81y2+B5ty34KuXDOAxm6SjYhrE09dabkXl1ziLwNA54wj/qRLXZFrxng94qa
         x74PLmcy+4Aoug+A45wieNgjkgyFgIER2IbbZ7lJgXbDa0uWh6hA6E0Xw/IJk7rNIGaT
         /tEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rN9nZSu2sgF646io/oXLJaUoy1kgyKi5JGZhp0Svd0s=;
        fh=u9BG6fvmRsQ00rPsRMY86RFsJD2x+fJDzwafn59hj7o=;
        b=SWo70yl3MAofrk4cW2AvZwLcg0FHmjCyEcUaC4LM91tNJRTelb9s6tQVC4AR29h+6n
         wykhpEk3auad/nSydcy4E8kqSXx0/ooVnSGUdOU+S7OVRTqFDhwOh8Xfro0rifbOWzQo
         SvQBu9ATG45r8Cct995k3zOP2zjQ+myye9Tc+ITEush1oUjUc9wiYLt7TuWAdYFphCsn
         97ayAv/ljX5647sDZ8t0lmPQAW24NAoeL9eEkSM4OskFgoyKEim3p3sdltumCYDtWf80
         DUW33WVk1uuuXt3H+13j52d4bJkUwH/nTU+T5g7ey35LVzGkE/PeSLUFWeXMw3JOYCEV
         MfRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785395743; x=1786000543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rN9nZSu2sgF646io/oXLJaUoy1kgyKi5JGZhp0Svd0s=;
        b=f3uCN0EzZBpj9nX9dB0WVKyMb+joJeh2/Y5PEFgPVioRXD+y3QZJrD/ZfvSuRHEmdt
         BUTfd1EnsDvtcI+yHM5C6pxyslCTF1cPPYsSkQfPmj5jpYn+R9f7bKv5rdJ18iRdqhDq
         bkMbwirlNBiVIHQ/uOIbsWP5cXmpbPooaqOwLcjBluq73N9SlDu7oBcL9TxUnrHNjcGm
         Yq5Smldx70+F3XpyIoQkMJScpxcXkwtUmG9KkcsR+9L/9duqWUVa24Rf8iSNrP47JEZ8
         DwbePh3aX6IxBxnbAcN8a0HXKca3R2eSIxsJuB2f/WKUELZHV2ePa1zApclB0da869GU
         gZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785395743; x=1786000543;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rN9nZSu2sgF646io/oXLJaUoy1kgyKi5JGZhp0Svd0s=;
        b=VOnubYvkJBfwwrqXx4VLR7NF+TPhgLTaxDq5HeR5rrRhc7N4SvSSjz++2Jz8Njm06k
         H+Jt1cuG1SckhULBbiCgegySbJQAPaMGcuv9YoCkxGIKMXafqSwWcPsruaNlx0Bp0/uN
         itkoh+S1Ks+6D9y9z0HLrs20vCmaVXr6fyYwrnUssvgV0RZO4YCWdw3ogx+4seOXr+EB
         hyBxcWBSPLZDpgq7HsrHDCyYLgXW2QRm0uWUJWsrLo4ZOEjRdi7zsVoNrEVKXHeIc718
         5GCuT3itxUGANK3X+0nMo2QkNFDtG3Yc8IksgCV24+QVnx/Z2I8hROSNkIXYfihiFW5e
         1Kow==
X-Forwarded-Encrypted: i=1; AHgh+Rr4E+QDBewcbfdedjYKvMbwEga7PBNXB+EZFPz3Db3jUOU6skVHueirXmDTSm+3gTxPDx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPeBrHv346mDTJtekFJOwIfz96cjV/SUCBMRCQ9MnZYIu91Tcc
	hFR/AROtY0s7YnExhADZFKR/RpKe0XCpKQOACM2MO3M4MFbxzO0JfKpIKos6e02wmp2v1gVgBtO
	jVM4yu6guLpXa6erpasEwVMKnEs+GbgvzzUV7SU79
X-Gm-Gg: AR+sD12sKnq/U1nQM8JMMo13Vz2RjUizBDTPA3Pw4XXKZHdYWAwxtKWlG3WCNWZGvEs
	eDqg61U4tVg2I6seZGtzUIuRWYP+N5fobd/wf1vsXOCjDguHaA6uPR9Dot0OelXUYSUVkrcp++N
	r6lUxSq/NQuMiLdfDKz3bmp/WC6qlaz2vfHTTUhG+9mY6GnWDahynWkhn2TBSpej8bx+cJn1GSy
	8cVxGucnQD5s5qSigzWhuZKTf12iGIfA94P53XJO4JZX83YcGcI4+Ebw2IlmGcgtt9m0qJz54KP
	lA0GdpNpuPXJYIEdOx7PVDiifw4zcM2ppE3VK6XNveLI
X-Received: by 2002:a05:622a:4c0f:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-52b394ab403mr10203301cf.1.1785395742273; Thu, 30 Jul 2026
 00:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-hybrid-v9-0-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp>
 <20260720-hybrid-v9-4-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp>
 <20260720060858.5AEB11F00A3E@smtp.kernel.org> <CA+EHjTxsm6LorPDR9irVHL0gtmsUG6zUKQLBA2=8Ruy+V4UmBw@mail.gmail.com>
 <1e5e1a1f-51ce-4c0c-8690-b5472cc7bd2e@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <1e5e1a1f-51ce-4c0c-8690-b5472cc7bd2e@rsg.ci.i.u-tokyo.ac.jp>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 30 Jul 2026 08:15:05 +0100
X-Gm-Features: AUfX_mzT91a3nV9pfht0OxPLB6AnFlkwl7Cs0rin5LW0Nvy9x0kjFieO4FqmSfQ
Message-ID: <CA+EHjTyhOqMti7q+OB8S7K-F48iMr9_FntAmW-jvfZmOC5JEHA@mail.gmail.com>
Subject: Re: [PATCH v9 04/16] KVM: arm64: selftests: Test SET_NR_COUNTERS
 after first run
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Jul 2026 at 06:44, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/07/30 0:23, Fuad Tabba wrote:
> > On Mon, 20 Jul 2026 at 07:09, <sashiko-bot@kernel.org> wrote:
> >>
> >> Thank you for your contribution! Sashiko AI review found 1 potential i=
ssue(s) to consider:
> >> - [Medium] The test ignores the guest's exit state and `ucall` status =
after executing `vcpu_run()`.
> >
> > vcpu_run() does the check.
>
> vcpu_run() itself doesn't. run_vcpu() calls vcpu_run() and then performs
> the check (their names are so confusing here), but the new test bypasses
> run_vcpu() and therefore does not perform the check. I'm planning to
> rework the test to use run_vcpu() with the next version.

So Sashiko was right :) Fixing this would be good, thanks for pointing it o=
ut.

Cheers,
/fuad

>
> Regards,
> Akihiko Odaki
>
> >
> > /fuad
> >
> >> --
> >>
> >> --- Patch [4]: [PATCH v9 04/16] KVM: arm64: selftests: Test SET_NR_COU=
NTERS after first run ---
> >> commit 0382d3a32df9349f988ca69c7b11c92e61c3d384
> >> Author: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>
> >> KVM: arm64: selftests: Test SET_NR_COUNTERS after first run
> >>
> >> This commit adds a regression test that runs one vCPU and then tries t=
o change
> >> the VM-scoped PMU counter count through an idle sibling to verify that
> >> SET_NR_COUNTERS fails with EBUSY once any vCPU has run.
> >>
> >>> diff --git a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c =
b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
> >>> index 22223395969e0..3b5bb421f401b 100644
> >>> --- a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
> >>> +++ b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
> >>
> >> [ ... ]
> >>
> >>> @@ -622,6 +627,37 @@ static bool kvm_supports_nr_counters_attr(void)
> >>>        return supported;
> >>>   }
> >>>
> >>> +static void test_set_nr_counters_after_vcpu_run(void)
> >>> +{
> >>> +     struct kvm_vcpu *running_vcpu, *stopped_vcpu;
> >>> +     unsigned int nr_counters =3D 0;
> >>> +     struct kvm_vcpu_init init;
> >>> +     struct kvm_vm *vm;
> >>> +     int ret;
> >>> +     u64 irq =3D 23;
> >>> +
> >>> +     vm =3D vm_create(2);
> >>> +     vm_ioctl(vm, KVM_ARM_PREFERRED_TARGET, &init);
> >>> +     init.features[0] |=3D BIT(KVM_ARM_VCPU_PMU_V3);
> >>> +     running_vcpu =3D aarch64_vcpu_add(vm, 0, &init, guest_code_done=
);
> >>> +     stopped_vcpu =3D aarch64_vcpu_add(vm, 1, &init, guest_code_done=
);
> >>> +     kvm_arch_vm_finalize_vcpus(vm);
> >>> +
> >>> +     vcpu_device_attr_set(running_vcpu, KVM_ARM_VCPU_PMU_V3_CTRL,
> >>> +                          KVM_ARM_VCPU_PMU_V3_IRQ, &irq);
> >>> +     vcpu_device_attr_set(running_vcpu, KVM_ARM_VCPU_PMU_V3_CTRL,
> >>> +                          KVM_ARM_VCPU_PMU_V3_INIT, NULL);
> >>> +     vcpu_run(running_vcpu);
> >>
> >> [Severity: Medium]
> >> Does this code need to check the guest's exit state and ucall payload?
> >>
> >> If the guest payload crashes or hits an unexpected exception, this wil=
l silently
> >> ignore the failure and proceed. Since the test only checks for an EBUS=
Y error on
> >> the subsequent ioctl (which will still be returned because the vCPU ha=
s been
> >> run), the test will pass despite the guest crash, potentially masking
> >> virtualization bugs.
> >>
> >>> +
> >>> +     ret =3D __vcpu_device_attr_set(stopped_vcpu, KVM_ARM_VCPU_PMU_V=
3_CTRL,
> >>> +                                  KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTER=
S,
> >>> +                                  &nr_counters);
> >>> +     TEST_ASSERT(ret =3D=3D -1 && errno =3D=3D EBUSY,
> >>> +                 KVM_IOCTL_ERROR(KVM_SET_DEVICE_ATTR, ret));
> >>> +
> >>> +     kvm_vm_free(vm);
> >>> +}
> >>> +
> >>
> >> --
> >> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-hybri=
d-v9-0-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp?part=3D4
> >>
>
