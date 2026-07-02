Received: from outbound.st.icloud.com (p-east2-cluster4-host8-snip4-10.eps.apple.com [57.103.78.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622F82E8DEA
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995928; cv=none; b=A2Ja6rZ8FItddN4H9CGrlQbulLjziaR5LGc9Owu5nio5iW1wHfzMEXB1BXdKD5HOhor1p2Y29ypTDBeopY75QOaqf5oog+2U2XnxJ10OzbuIHE5r5+tAQs8wxYoWXytABYJUlBygq7wRDd16qx0bwezoXJGrITT9IyhCcne4qIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995928; c=relaxed/simple;
	bh=A++uywB8a9Lp9iFIsTMiY0E6a2bJ1FWU15PZ23B9ff4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ReHWiK6kFaG22hl46tgqeHPfBlQWblIz2w+yqFLfpJuBjbv7Xmgz5leUeUMadlVUrEnupnnKOmmmd5357pcsd9bAALbIICqd+WyH61SoO3Lh/n4WfhcwPPmtZhHR6Y42TUHeqm5n5z8ocMWKFTRIIUfAy5r16IAuqC9/mNa7cw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unpredictable.fr; spf=pass smtp.mailfrom=unpredictable.fr; dkim=pass (2048-bit key) header.d=unpredictable.fr header.i=@unpredictable.fr header.b=Fuf2ND6I; arc=none smtp.client-ip=57.103.78.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unpredictable.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unpredictable.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unpredictable.fr header.i=@unpredictable.fr header.b="Fuf2ND6I"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPS id 3688018014E1;
	Thu, 02 Jul 2026 12:38:38 +0000 (UTC)
X-ICL-RepId: 019f22d6-a0a1-70ac-ab80-24d6ef9e9cff
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0ITRMFUgddTVYNRw9YHlwUFwtHQ14IXh9MHB0OWAYSAE0KDjYGWQVeCVYDQwU2EhRdRUYDRxlXFFAbRwxVB1deXwoTAF4PD0wPO3EoBih3MxQ+CysORgZIAT4eVAIuBl0MSgBacVt0R3hKAF93HlwASx1XBFQfUxJVHR0LRVUSBEAIVlBUHkEEVhVsCVgGUxlX
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr; s=sig1; t=1782995923; x=1785587923; bh=Ut/JLvsd42eKREb5T24DtBg7CjVhiI3+3Gvlq6kEPkY=; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme; b=Fuf2ND6I/pVWxFWP3Gn92mCHGDcBOkfO4vZAQnre60RSFloWoYrimKxQ6PcCK0A5RZlFkmoPWMF2sr2lVkCcX7xEzZf7fNW8ARu6t4K6hgHmX2JApmaBCvpWiaWonNo6FfS6893/XyxDEhOdHMiHQSYSuDJYCMtjmu+apomzlJfdqk26GcBXZXmOLNtWowvWfZZmedPp5TauOU/PQvY+m9ZJUoiAcfFJNQNHhFGe1hbFHBgf3anM7WmcxYzYfxQjmWlrjLzE+z0ZtKjbtm976mooJTGszGPvpuI3yGF552Ig5sz8kYEmSFrUlwXm9D59m/B+N+NVTMM1tWrg4FAo+Q==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPSA id 5BC8418005B4;
	Thu, 02 Jul 2026 12:38:36 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3893.100.7.1.1\))
Subject: Re: [PATCH 16/34] target/i386/mshv: migrate LAPIC state
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CABgObfZhNwXLG9ip=CnEiVb=p24etvxeodbjG5=Di4hOKvYF8Q@mail.gmail.com>
Date: Thu, 2 Jul 2026 14:38:24 +0200
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 kvm <kvm@vger.kernel.org>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <wei.liu@kernel.org>,
 Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6CBE1CEC-F8F9-488F-95E4-5237F0F7A232@unpredictable.fr>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-17-magnuskulke@linux.microsoft.com>
 <CABgObfbgqcSYekjGkuDCUibQc8j4iyGPbajU_-VdPsGkLZgiLQ@mail.gmail.com>
 <akUyiNahX3LnFPhn@example.com>
 <CABgObfbQTUOaiMYApABTettYa0D3WasGs1NjQrWvo4tmAZpazg@mail.gmail.com>
 <akY0Gpd/GHj3Pdun@example.com>
 <CABgObfZhNwXLG9ip=CnEiVb=p24etvxeodbjG5=Di4hOKvYF8Q@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3893.100.7.1.1)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzMiBTYWx0ZWRfX3BULtrD4gNcF
 gZiT2r5JqCm1Vb2jPvWQK3+GMK1Z8SW87nIpOEg86R116KFF+SbQIyPCkM2ytU/yZr8C1gbn+TA
 nekLkfW0n+04Ts8AnyzdTylxGIx4bDiASCUMFvW9QM2PodfOHynva4/1lFKeSPZFixGZiF8JwcD
 NW8d+P9BZUOSfAArYYPpLHsAXIvlABJHGDiDt7AZ6/HyZ4+tztRZnunf+t+83AY0emdp17WTVJ3
 jf6UQjftPjFX0lbTuzH9KbS7sSavtuTq15BIWpM7cJn1/J2u955PjQ2YkrMPi+GvKijg9Bgfs4Y
 9eJ/4pU2rN4q5rSdaxN
X-Proofpoint-ORIG-GUID: QIVq9sUMfUUpgZbOb-uMYKalLzzRA4bY
X-Proofpoint-GUID: QIVq9sUMfUUpgZbOb-uMYKalLzzRA4bY



> On 2. Jul 2026, at 13:47, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
>=20
>=20
> Il gio 2 lug 2026, 11:49 Magnus Kulke =
<magnuskulke@linux.microsoft.com> ha scritto:
> On Thu, Jul 02, 2026 at 10:51:35AM +0200, Paolo Bonzini wrote:
>=20
> > What are the additional fields that aren't covered (i.e. cannot be =
copied
> > from hv_lapic_state to the struct and back) by the common APIC =
state?
> >
>=20
> that would be those:
>=20
>     uint32_t apic_version;
>     uint32_t apic_lvt_lint0;
>     uint32_t apic_lvt_lint1;
>     uint32_t apic_lvt_cmci;
>     uint32_t apic_error_status;
>     uint32_t apic_counter_value;
>     uint32_t apic_remote_read;
>=20
> Reference struct is this: hv_local_interrupt_controller_state
>=20
> =
https://gitlab.com/qemu/qemu/-/blob/master/include/hw/hyperv/hvgdk_mini.h
>=20
> For anything that's new but part of the standard APIC you can place =
them in common APIC state, just making migration state part of a =
subsection.
>=20
> Notably we have to do this for lvt_lint0+1. We cannot use the =
respective
> fields in the common APIC state, because writing to those has a side =
effect
> in QEMU: If unmasked, it will trigger a chain of events,
>=20
> pic_irq_request() =3D> apic_accept_pic_intr() =3D> =
apic_deliver_pic_intr()
>=20
> For MSHV (and WHPX afaiu) we're currently not able to trigger legacy
> interrupts from userspace in this fashion.
>=20
> What is the issue? The interrupt won't be triggered either if you use =
a separate field, or if you use the normal one.

Hi,

For injecting LINT0, it=E2=80=99s possible on modern WHPX when using the =
hw irqchip
 - starting from Server 2022/Windows 11 only - not before that point.

How it=E2=80=99s done is though cancelling the vCPU execution, wait =
until the vm exits
as a result, set an interrupt window, run the vCPU again and then when =
it exits
Manually injecting an event=E2=80=A6

That=E2=80=99s unlike non-legacy interrupts where the request interrupts =
path actually
works on Hyper-V.

>=20
> For LINT1, can you not inject an NMI either?

The request interrupt path works at least to some extent on LINT1/NMIs =
unlike LINT0
but didn=E2=80=99t dig deeper to see if it has more issues=E2=80=A6

I=E2=80=99m convinced that an Hyper-V specific structure is the wrong =
idea for this though...

>=20
> Thanks,
>=20
> Paolo
>=20
> Hence we roundtrip
> lint0/lint1 in a dedicated mshv struct.
>=20
> best,
>=20
> magnus
>=20

