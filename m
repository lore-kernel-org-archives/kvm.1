Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5014119FD
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338636; cv=pass; b=txlbuoSN456jswQ8yt8JfLKQiSjSIG7L4aeeLrlsYpoioOa1/hYWT2nsREzTJqJ76KAsZHWorgypCrnyCbUBzFj1dYEWOI3MBTlFjG1PudfNcBgvfQW764ubI5h7tF39R3q1zP5P/KZUWnBoeZ82UKutiuzdufsc+qlEXN1P3fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338636; c=relaxed/simple;
	bh=KvR+cddFigOMJS06ugQoH4iVC4ve1rtPkVOdtPRomp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUAcUocbHcSlegFj+yw7usbqy9WzWyklsnfBiFuVgmRjspoflTDbJ9LxKDWi1HvDPbTVpg8OEpNYjmOLor0KSJe1P12FwmYR0wePNURed/pekrEtg94ao13I40aCYy7w2AQX4uzzDPODHIsjn2v8N//d48VyAiHKlKhzabe9648=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e7c05ax6; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e7c05ax6"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c10ed63c0so315031cf.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 08:23:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785338634; cv=none;
        d=google.com; s=arc-20260327;
        b=jOzygKTyi89QEio9lwc0C67GSw5mZAWV9PXjBREW5/3IDsbNF3eXNSnjAu5+0mBaeY
         EyjsQ6a1+QXEgu5AlS93sF5EykNMcSPG7zWjyimU4ajUtmSNs+xwprspwEspeoGfUnrp
         EybTKrqCHwHQsEwKwwNFb3wNuUSjWukpXA18/zuTXqj0Tos5Hg0XJvJqBuO7mmnUYdPQ
         ZtZeHveaJidQ8KcNjfzaJih9ix4yHLtfgZorlP0ustPhtV2KzB0Oi5NT6NE2NYM4vXb6
         EZKeb2iwGtIK/fn/m/T8ER5evTuX+Bai+nW5+jNXdFlYOuQWe4I1sKt4Kqxf85jJAdKt
         hRtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=751kHf3xuWyu+wd3aooaxL29DUmLoKaYZairhF8FZOo=;
        fh=BRQnIwMGLkcpQ+2QdSRcox1I3PDDKiZ1PRqmI6mRnsw=;
        b=FwwnLDK4UZTSOD78zqARaGPsaE1hjGF6eGW6P2tweIc67w0wX5cU4x5+LemvI4et+2
         jO4ROw3zJHJcH8VJI0Mkz06Z/Hnp/ZM8rUr6J58yQPaHwab44SYDP6UkPDbQZ5spz1AZ
         BHmjooAahPrk+kWl1gLhgXZXuovpsGOBOj4/RFCJlpsYwrvm120V0c9SpyxTJeeX0Uow
         QyniPflDC6e1CFscsGZ5ZapuIrBgQf7qXzugsAWQzUPTU8UoIpDUdsLZtIthzjWeKEGb
         fkLp4RMf2WotyoZwDoeH7tSeqAFhEe8m9ZsNnFz39sqPEqbVplceM1RL2pWB0eFirRt3
         OoRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785338634; x=1785943434; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=751kHf3xuWyu+wd3aooaxL29DUmLoKaYZairhF8FZOo=;
        b=e7c05ax6I/+MsADuAdrWMWXAuZ8G60pjDexlj6Vd26TDgN5yZe6c81/hh9EqrQoiZv
         L/x/p2xQ3CAOty8jaBxFyEvtVhlRglpUoB5ed6pmoCSrW1E2Mks0gAjBnVZDDI7ShrQI
         L9S0ly8bt57RH9XZgf/0exVcegb7gloQjnZ27oUfJ2x/1/4Lnc4v8z+gXY5Ju6B+D0tB
         fURMCcJ51CrqzscogCEP9Lm87SMg/LoIwGG4k4I8i21N9AL4z6Mrrdh5vdJRLJAT61ZA
         3nhsCnB1MRY7gDYZwOnG4QNiHVCT0MMgU641wKjxdPBqyjeDIyyPCa3f/sc6mf6zN8Rh
         DjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785338634; x=1785943434;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=751kHf3xuWyu+wd3aooaxL29DUmLoKaYZairhF8FZOo=;
        b=ElE+e/moSLGDiu3NF+OAb/qdKnIbFr5dJGak3Gv9NZ0bIcJ+uBW/EbYlqAPU3YYM5w
         qUOC1GTJw3M57ZdOSq+NCaBCX8LyOLrnVd2g3Y+/XBofzuhWOSdNMscZU5HHC5/8N6rX
         pMMXGXWpKTe4Y0f2LzDMQDQHR5lidh5bM5LCTkN47jcwcHQmSEXWgLYs1MaD6HWS9//Z
         E2beTUgaj4S5sH4w7S6HgiMWIcaZnVT78efvrPHE+lu9171o7p/E+mwfnSaVmgJVdqSc
         EOaTlyM0dxkxdHC21J43zOAgBopE7xD8fnkvs+z/56AA6OXzeLRDNU2BxWM/YheiBR2B
         s3IA==
X-Forwarded-Encrypted: i=1; AHgh+RrOao4bsP+J2+AfNkw0YwvsSBquTLvWqr5nnYwYxsPjxcGBxvTaxESSNWWH++l9ypeKgPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ2ErVBYrfJwf4wkbYdQ+cQI3oFvYuqmix4Yz+GmRtsd1x2ffD
	y0bRCd21YDRF+8HWd/VcmEbcpVTlV/f30hKAbs+XvKkAi1TDQ1X3LHxr2T9RD4+hecaLLlmw61f
	hZzYkVgzyjbnc6fV16fML5w8Q6tCSGMvGApZD9Hxe
X-Gm-Gg: AR+sD11I0hV3scS/T6MNJvPcYvJyRG6AtjTL4Gbw4G4a+JZ/5iXh3BJiaAOnH3btPFz
	1IqG71Tu3/YkMdZpoW0pJ9nvC9aqCerZW7aWYB59lQjK6JpEonFjJ6SsnkL/zLnqCNoARQm2iKI
	mRCBNom7c+5xRkEXe2V7w+/j74VA6Xn7thr5OS1NFjWrkXi7Y4FJaclUF1sk3Eo1FnkyChbhiV0
	oZ2vQNSRbVNs2ri05tvPPo0vs3K18XjJDX+zhoKsJntKl4PV+N/RSSJ8/y/LsgN8aM9IQqLotx/
	eodYqyoxUeKVbAVMUJrSrzhFz7ZXq5PObFhERlbUJP6dZos6YonAmiYdWh07/Ee+bmHaKBQi2dM
	=
X-Received: by 2002:a05:622a:2610:b0:517:6dc0:698d with SMTP id
 d75a77b69052e-52b34ce6830mr1188171cf.0.1785338630160; Wed, 29 Jul 2026
 08:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-hybrid-v9-0-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp>
 <20260720-hybrid-v9-4-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp> <20260720060858.5AEB11F00A3E@smtp.kernel.org>
In-Reply-To: <20260720060858.5AEB11F00A3E@smtp.kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 29 Jul 2026 16:23:13 +0100
X-Gm-Features: AUfX_myAm_s5RN5CqoGtHGgWFh1C3i89D3rZXWu2TLWc1vxbN2Jerqq4ksz8e38
Message-ID: <CA+EHjTxsm6LorPDR9irVHL0gtmsUG6zUKQLBA2=8Ruy+V4UmBw@mail.gmail.com>
Subject: Re: [PATCH v9 04/16] KVM: arm64: selftests: Test SET_NR_COUNTERS
 after first run
To: sashiko-reviews@lists.linux.dev
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Jul 2026 at 07:09, <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The test ignores the guest's exit state and `ucall` status aft=
er executing `vcpu_run()`.

vcpu_run() does the check.

/fuad

> --
>
> --- Patch [4]: [PATCH v9 04/16] KVM: arm64: selftests: Test SET_NR_COUNTE=
RS after first run ---
> commit 0382d3a32df9349f988ca69c7b11c92e61c3d384
> Author: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
> KVM: arm64: selftests: Test SET_NR_COUNTERS after first run
>
> This commit adds a regression test that runs one vCPU and then tries to c=
hange
> the VM-scoped PMU counter count through an idle sibling to verify that
> SET_NR_COUNTERS fails with EBUSY once any vCPU has run.
>
> > diff --git a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c b/=
tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
> > index 22223395969e0..3b5bb421f401b 100644
> > --- a/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
> > +++ b/tools/testing/selftests/kvm/arm64/vpmu_counter_access.c
>
> [ ... ]
>
> > @@ -622,6 +627,37 @@ static bool kvm_supports_nr_counters_attr(void)
> >       return supported;
> >  }
> >
> > +static void test_set_nr_counters_after_vcpu_run(void)
> > +{
> > +     struct kvm_vcpu *running_vcpu, *stopped_vcpu;
> > +     unsigned int nr_counters =3D 0;
> > +     struct kvm_vcpu_init init;
> > +     struct kvm_vm *vm;
> > +     int ret;
> > +     u64 irq =3D 23;
> > +
> > +     vm =3D vm_create(2);
> > +     vm_ioctl(vm, KVM_ARM_PREFERRED_TARGET, &init);
> > +     init.features[0] |=3D BIT(KVM_ARM_VCPU_PMU_V3);
> > +     running_vcpu =3D aarch64_vcpu_add(vm, 0, &init, guest_code_done);
> > +     stopped_vcpu =3D aarch64_vcpu_add(vm, 1, &init, guest_code_done);
> > +     kvm_arch_vm_finalize_vcpus(vm);
> > +
> > +     vcpu_device_attr_set(running_vcpu, KVM_ARM_VCPU_PMU_V3_CTRL,
> > +                          KVM_ARM_VCPU_PMU_V3_IRQ, &irq);
> > +     vcpu_device_attr_set(running_vcpu, KVM_ARM_VCPU_PMU_V3_CTRL,
> > +                          KVM_ARM_VCPU_PMU_V3_INIT, NULL);
> > +     vcpu_run(running_vcpu);
>
> [Severity: Medium]
> Does this code need to check the guest's exit state and ucall payload?
>
> If the guest payload crashes or hits an unexpected exception, this will s=
ilently
> ignore the failure and proceed. Since the test only checks for an EBUSY e=
rror on
> the subsequent ioctl (which will still be returned because the vCPU has b=
een
> run), the test will pass despite the guest crash, potentially masking
> virtualization bugs.
>
> > +
> > +     ret =3D __vcpu_device_attr_set(stopped_vcpu, KVM_ARM_VCPU_PMU_V3_=
CTRL,
> > +                                  KVM_ARM_VCPU_PMU_V3_SET_NR_COUNTERS,
> > +                                  &nr_counters);
> > +     TEST_ASSERT(ret =3D=3D -1 && errno =3D=3D EBUSY,
> > +                 KVM_IOCTL_ERROR(KVM_SET_DEVICE_ATTR, ret));
> > +
> > +     kvm_vm_free(vm);
> > +}
> > +
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-hybrid-v=
9-0-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp?part=3D4
>
