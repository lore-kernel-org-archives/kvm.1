Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575D6399011
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360294; cv=pass; b=IRCLRHgWr32gzEjYf4SE0ta5fM6PTLwXt+AbFuxQr/HO1CKayYqn5Q8rWmY31YVzBwPS7kI0KPR4xcxNhQWPWaCsrPBPk3YN1LTnNNRmPElSqp/ntx0EBoih6lrgDPdAB/901xu4x2FamFcei+xr2R0LAx7TduOlo1uagKqtljw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360294; c=relaxed/simple;
	bh=icgG7YTkiAlTbWT0zedfNn/vE0n+ee9wL92SJ9sqIwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqcsU94ua9hFzFb4OzHDk74WIbS02ISoBqEvpmxUOLTR8yl1uc/RRPAwgVuCUolCIOKcEwvN9qQn3dos9y5RVBycGisWuzMIeDVhWAwgOFmnP/7+aDlEArgZSx9erK7+GfClpYxSSdIvIR3g4qJVQs3wZ9Ouy0XqvyLfWucitCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2+Qi3Is; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2+Qi3Is"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so5937819a12.1
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 10:51:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783360292; cv=none;
        d=google.com; s=arc-20260327;
        b=odx4GPejJpLjgl3d2StZco/fJDpwtTeWOE0tXSSi22m/GCaRYL9vzhRuBfqBCinIvE
         ZVse9vGziIUpJ8jUxrrB85PFhyN6rnc8uWPi/8jdC+16on76ayCvZ92nQisyymdZ27CK
         R1GpJf7AeT2vGPva3+o/qRsC1KPk4jL2qJKHtcP+LdIafzn8ig2e6Nr3bq20sW3SyzRe
         FwkgBZCLsbCYsdZSZchpiRXwgrNJN1hIkZ3N3Ys1Q7xMHO2TzKox30+BSOQV2vYpsyFB
         E7sRbpqyc0Xr1k47qnn3e1U9Z8N6rT8EgUNne+x7P9u1n/UwwJmEfOUc+uGXqMVvgGxU
         d4FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w/UCTeJpz3Hxc4fJTOCG7N9B0h0C1MP1143PW7wuY/s=;
        fh=hb5Ua2rXfsW6ocUbE7VQHQB8ULFLxMkgJ2MX15T3NFE=;
        b=byQZzo5H/XUekAKd5RUumCYvI7/rmdzpcc3Ql40aE1CEHTOMKpg0RmsvqI+zVEaAVA
         5yOxz2/HSNIUXrL8zJDcqoFS82RbtOwVc5bddJVKJQwU3KgN9h5lq28vCpHaHzqelCBT
         bSj7er9EDVZYrHMLqNWE8IiXHwqNaTy37ahKBxya4NNYabbS9XA33aLptc7VOfhesDhd
         BxFAff7fC5jrrz/6DoJdJV16V/TwwSCS8ZDf4UrRswFRoKJAT3zvYM7COkxrKAjF0FeF
         +0atUHyDauhkSo5Nx3+nWezJbRAPgP0L4XUYLpfB+ZcmpASk/qmYLEamBqIzdmGloQse
         0xmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783360292; x=1783965092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w/UCTeJpz3Hxc4fJTOCG7N9B0h0C1MP1143PW7wuY/s=;
        b=k2+Qi3IsTKgxZ/3zz/MXrEZc0SG4TxIEMMDI4UoAZFZ3yACTU5AEQZAuKIo7ku12P3
         kgYMiSuH3GDoGZBkF3zaZUl4Mef1wSjvOWB+ix+aHN7g7oIsw3p6gtcJSmVAbEFhxr9l
         aZi5twN8N8uLmB5ba7RyWSAXbaka6Du53TAGuRzZqlw7KFDIJQeNf3JXknpesjgCQz+S
         ecULn85La69FizpVEDDWzd+c2h+VZ7Rp2v8Zh0vXqDG2RVi9lsxaQbTnxjvFBRBQ5dDi
         Q1q632EIgprlp4wnrL0SM3VIh1RsHEKElERbIbtiUcmatPuYhmsYrrirVFPteqaLfzys
         COnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783360292; x=1783965092;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w/UCTeJpz3Hxc4fJTOCG7N9B0h0C1MP1143PW7wuY/s=;
        b=MOL/5BrAADc9drHS95GcZUvvSfEcp42HgALe6AiNH9O3kEBW5rolITn9WyoAY+TNlw
         37yYXeGlhYKmarvvQE5rkngAuTt6/RTtew0xE+6/PaknkX1kUS7BkAiCc+75yna4G9ib
         PwIVhL+1MPwfJglsxmRVo63qLTaOUCrMSPmjwCPtApi8PpzRNJzKoUVHMnDvakDnm+xz
         6sPd/FcEvYZgDLL7q8+I5ak7fmWhurtfyRTbHQZXdokP6fvYDq9kiHJzg533tlzWCJBS
         m+Mrgk4MowBac6UgmVOny3QlCk5v8wkjBApe0siC8T8JjEIyu5Q8KVmbBWHaaUL0Acd6
         gazA==
X-Forwarded-Encrypted: i=1; AHgh+Rph78jYQgIJN/sn8kwAUSus1F6i4dJUjwTn85E3IfiMBA104c4BHpyyccuiZLcEu0EcgAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQWlOWu7JdIWE8/juUoHHDwDczolS5atZg6D6adCT0f9hTuAtK
	6PcFX6D3Z4hcCjNooUjYXdiNs0F7gPuK6d0GvIBjHn8eqqrpL8EeQEPQJt+DiEQZ1ai5GTJG5j+
	m0Y7zjk/Mf0p9YMSz9SQd3lKgDdtE820=
X-Gm-Gg: AfdE7ckxxbSXkh7DTqtAqq4qNLDDFDMR7pTKscLBpA1LdoVor0V4/tDqFqcjL2CynM4
	EWphGkt4MKBsdCNZGUGFdRSvAYDZEDYDohOMUy3U6DmC3ycebKPwwRO5h5oe7224/mJNd0onJ1N
	+xoGmAB43ybodRJOhDq8sgsajfAGlsjsN0NRWJeTK8+HNY0kjZm9rtU3f6Cq5iHa3R3DiBRB26H
	w5GidScdaOi46rTGSRTIPd9rXvs8pcNhYrirKZxQLtgkz8MDLu3Hd1O1SG6pxS19oKlz39KTwdt
	aO6/x7ZrXd4W/jjVJgANNYmJC5po
X-Received: by 2002:a17:907:948a:b0:c12:34ed:e0fc with SMTP id
 a640c23a62f3a-c15a686c2fcmr101961266b.58.1783360291351; Mon, 06 Jul 2026
 10:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705050443.1331662-1-bestswngs@gmail.com> <f654b630538d27d05ebf09a5b7ff07cee1fed773.camel@intel.com>
In-Reply-To: <f654b630538d27d05ebf09a5b7ff07cee1fed773.camel@intel.com>
From: Weiming Shi <bestswngs@gmail.com>
Date: Tue, 7 Jul 2026 01:50:52 +0800
X-Gm-Features: AVVi8CdnSzvMgtMYL98L2UrRau1L0QmRmzvD294dfk6Jf1Z08Ea0_atZ4vzz3jI
Message-ID: <CANgPUi2c3Y7ckXSCVmRmAmQiS54y18_PggjWj=vderVL6KrPZw@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/ioapic: Cancel eoi_inject work before destroying vCPUs
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "seanjc@google.com" <seanjc@google.com>, 
	"Wang, Zhong" <wangzhong.c0ss4ck@bytedance.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"shixuanqing.11@bytedance.com" <shixuanqing.11@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Huang, Kai <kai.huang@intel.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=886=E6=97=A5=
=E5=91=A8=E4=B8=80 17:09=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, 2026-07-05 at 13:04 +0800, Weiming Shi wrote:
> > kvm_ioapic_eoi_inject_work() re-delivers a throttled level-triggered
> > interrupt via kvm_irq_delivery_to_apic(), which walks kvm->arch.apic_ma=
p
> > and dereferences the destination vCPU's APIC.  The work is cancelled on=
ly
> > in kvm_ioapic_destroy(), which runs after kvm_destroy_vcpus() has freed
> > the vCPUs and their APICs.  kvm_free_lapic() does not rebuild apic_map,=
 so
> > the map is left with dangling pointers, and a work item that fires duri=
ng
> > that window reads freed memory:
> >
> >  BUG: KASAN: slab-use-after-free in __kvm_irq_delivery_to_apic_fast (ar=
ch/x86/kvm/lapic.c:1248)
> >  Read of size 8 by task kworker/3:1
> >  Workqueue: events kvm_ioapic_eoi_inject_work
> >   __kvm_irq_delivery_to_apic_fast (arch/x86/kvm/lapic.c:1248)
> >   __kvm_irq_delivery_to_apic (arch/x86/kvm/lapic.c:1343)
> >   ioapic_service (arch/x86/kvm/ioapic.c:492)
> >   kvm_ioapic_eoi_inject_work (arch/x86/kvm/ioapic.c:525)
> >   process_one_work
> >
> >  Freed by task 153:
> >   kvm_arch_vcpu_destroy (arch/x86/kvm/x86.c:12871)
> >   kvm_destroy_vcpus (virt/kvm/kvm_main.c:489)
> >   kvm_arch_destroy_vm (arch/x86/kvm/x86.c:13402)
> >   kvm_destroy_vm (virt/kvm/kvm_main.c:1302)
> >   kvm_vm_release (virt/kvm/kvm_main.c:1363)
> >
> > A guest arms the work by EOIing a level-triggered pin 10000 times in a
> > row, so the window is reachable from guest ring 0 whenever its VM is to=
rn
> > down soon after.
> >
> > Add kvm_ioapic_pre_destroy() and call it from kvm_arch_pre_destroy_vm()=
,
> > which already stops the PIT and the kvmclock/MMU workers before vCPUs a=
re
> > freed for the same reason.
>
> I am wondering whether we can just move kvm_ioapic_destroy() (and
> kvm_pic_destroy()) to kvm_arch_pre_destroy_vm().  I guess the concern is =
we want
> to make sure vIOAPIC is destroyed _after_ kvm_free_irq_routing() is done?
>

Yeah, moving them is cleaner than a helper, will do that in v2.

> Btw, one odd thing I saw is all KVM IO buses are actually destroyed right=
 after
> kvm_free_irq_routing(), but yet kvm_ioapic_destroy() tries to unregister =
it from
> the KVM_MMIO_BUS (ditto for kvm_pic_destroy).
