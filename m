Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448FB3242B5;
	Thu, 23 Apr 2026 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968835; cv=none; b=UDOOL3dY+5b3U3CAdcPE6X0cq3jDFTLf2f5qz9TI6TidxV1Bb+aX75aaQxwxu2INwHGoUfLHB1hyN2AcnKMRV4YCg/WkCr1WJhtc0+QfCbQI1OxzxPodHnxhfqHJs+HeL/KxV3zG3qYzjgEAZ5uc9jfySnr8TgoCF7OHfmRxB2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968835; c=relaxed/simple;
	bh=8Z017pm09Fdrc/A+yN7TpkFKEmDdbW2HLSHnsJBUjxk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BKtb2WbK3YCq2Cl1Lmfx+a+IuCxGjzSpb7oWeFEXO45UQG+pXzyjn8dbd3mvEvV5m6tKOYVup+GWXjG13t0uJmVo1tI0v0EuzX19fwnRf9XAcx7MSFDGXL0Z1fi5Kbk4c/Jkj1UiuNrmM+geK7vDamK9eQkbRfIOgaqCDYJsWgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=YhhbPw+i; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YhhbPw+i"
Received: from smtpclient.apple ([192.19.161.250])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 63NHskJ61332001
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 23 Apr 2026 10:54:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 63NHskJ61332001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026032601; t=1776966888;
	bh=L3LQ4TVAekCMBbaowZBtQV00ASOQDnEIocQxeIni4q0=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=YhhbPw+iIHI6ICRIEt8U5G1K57xfNOlf6wbbn0T8Rnt1LbxMNwLErhYAjRcm6mHeZ
	 1t6PoN4m6SyeDoIPpEjRTpB0/3fZ9x6xJ0bqxakzcTLd4/l46eUS88bpbZSxH/jRFC
	 zIW+3ev3+dN1GZqmOfkL3kCR6duSUgrcR8YxaY6Outp3k/Op5Q+Vk2IC+TLP3tC6GK
	 82920YG1ktZERXdsRgP5oJ78rxeghXubnw537NTIVRD7UyqPjrPDMxtixcAiVsIuhN
	 JxpHBdNpntdmEDCjrtc2pvmXtFn9JroQXeMQLahfCtyIKyEpGtPVsCZr/HHvaoDYte
	 LjeLnmWzWMpZA==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH 1/2] x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into x86
 core
From: Xin Li <xin@zytor.com>
In-Reply-To: <20260423155936.843498069@infradead.org>
Date: Thu, 23 Apr 2026 10:54:31 -0700
Cc: tglx@kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        Binbin Wu <binbin.wu@linux.intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
        Paolo Bonzini <bonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F54F290F-BB2A-455D-A5EC-7D4BA27DC0DD@zytor.com>
References: <20260423155611.216805954@infradead.org>
 <20260423155936.843498069@infradead.org>
To: Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3864.500.181)

Few nits below, but

Reviewed-by: Xin Li <xin@zytor.com <mailto:xin@zytor.com>>


> On Apr 23, 2026, at 8:56=E2=80=AFAM, Peter Zijlstra =
<peterz@infradead.org> wrote:
>=20
> Move the VMX interrupt dispatch magic into the x86 core code. This
> isolates KVM from the FRED/IDT decisions and reduces the amount of
> EXPORT_SYMBOL_FOR_KVM().
>=20
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: "Verma, Vishal L" <vishal.l.verma@intel.com>
> --- /dev/null
> +++ b/arch/x86/entry/common.c
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/entry-common.h>
> +#include <linux/kvm_types.h>
> +#include <asm/fred.h>
> +#include <asm/desc.h>

Swap the two header inclusion order?

> +
> +#if IS_ENABLED(CONFIG_KVM_INTEL)
> +/*
> + * On VMX, NMIs and IRQs (as configured by KVM) are acknowledge by =
hardware as
> + * part of the VM-Exit, i.e. the event itself is consumed as part the =
VM-Exit.
> + * x86_entry_from_kvm() is invoked by KVM to effectively forward NMIs =
and IRQs
> + * to the kernel for servicing.  On SVM, a.k.a. AMD, the NMI/IRQ =
VM-Exit is
> + * purely a signal that an NMI/IRQ is pending, i.e. the event that =
triggered
> + * the VM-Exit is held pending until it's unblocked in the host.
> + */
> +noinstr void x86_entry_from_kvm(unsigned int event_type, unsigned int =
vector)

Is u32 better than unsigned int as is close to hardware definition?

Currently, the event type and event vector are defined as 4-bit and =
8-bit
fields, respectively; and they can be readily expanded to 8 and 16 bits =
by
utilizing adjacent reserved bits.

> +{
> + if (event_type =3D=3D EVENT_TYPE_EXTINT) {
> +#ifdef CONFIG_X86_64
> + /*
> + * Use FRED dispatch, even when running IDT. The dispatch
> + * tables are kept in sync between FRED and IDT, and the FRED
> + * dispatch works well with CFI.
> + */
> + fred_entry_from_kvm(event_type, vector);

Then should we rename the =E2=80=9Cfred_=E2=80=9D prefix, say =
=E2=80=9Cx86_64_"?

Sorry naming is hard to me ;)=
