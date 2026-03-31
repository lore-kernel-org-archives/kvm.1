Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72A199D8;
	Tue, 31 Mar 2026 23:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774999321; cv=none; b=NqR4RuA7k/rjuZGg+E2Pu2uusxX/ns/95fLbWPOBp7NFv6OkcMvo1XbG5uWbPB4UoPM5eyHB4phkXwjBhcNnbqoN69WbQraPbcpSxzIKtKotkiNiq5J1O8mbB2ezsR8Efzkurw1Ix1ercR2j4zTEW3EZxrUYMzQlzePOhDJp8NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774999321; c=relaxed/simple;
	bh=jwRtq2vulzWQDdfbN3/eFGApt7bVHBTpANIg8ZeIR5c=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Mkbz3u+xI535aEeBN7jEfT2DiKNJznWa4A1PKsVNHveXeLpzTAW/4JRnK3kXoD2TebFjGZcSur4wEFbvQ0Lpax9kkPDGMKMLlgcDPu45fMv/dLciTg7V2QJLjZ07BHfWwaSi9z0631lRDiACZRbTUPfvCNT2zzK4Un7DfhU52NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IFw+dOsI; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IFw+dOsI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Content-Type:From:Mime-Version:Subject:Date:
	Message-Id:To; bh=xl1EKG4pCevLqe5iacLgtuioFR0JlXNF6YuvQrm8tZk=;
	b=IFw+dOsIaY+QjkZudLXTpD1LvBeY+Rg2mk8Pw33qhJNlEoHyt708iDVnt3Ijnm
	RrC5U3VOGcBG5TXkHUCcolGFlzV+KM7TbFz9ojHvp5yOKgDvsZZzaZsQ4Osnquhn
	jscklqlUGp1qf7CyCqxp35TCz8/BDC4lAqKEWXG4kgU+4=
Received: from smtpclient.apple (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD333beVsxp3DxyCg--.54778S2;
	Wed, 01 Apr 2026 07:21:03 +0800 (CST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: zhaogezhang <18341265598@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] vmx/nested: Set the SGX feature flag only when hardware supported.
Date: Wed, 1 Apr 2026 07:20:51 +0800
Message-Id: <06C8A09D-CBED-40F2-9B15-9FBBD138768E@163.com>
References: <8fbedc9183f61400c772b36562963cfc8c3a8797.camel@intel.com>
Cc: seanjc@google.com, weixq1@chinatelecom.cn, zhangzg12@chinatelecom.cn,
 dave.hansen@linux.intel.com, bp@alien8.de, hanht2@chinatelecom.cn,
 hpa@zytor.com, mingo@redhat.com, linux-kernel@vger.kernel.org, tglx@kernel.org,
 pbonzini@redhat.com, kvm@vger.kernel.org
In-Reply-To: <8fbedc9183f61400c772b36562963cfc8c3a8797.camel@intel.com>
To: Kai Huang <kai.huang@intel.com>
X-Mailer: iPhone Mail (23D127)
X-CM-TRANSID:_____wD333beVsxp3DxyCg--.54778S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFWkGF47ur4rJFy3ZFy7KFg_yoW5WryDpr
	yfGFyDtr4vgFySyw4SvF1UXFyava1kJrWvgr1jka4jgFnIqr97Jr1xtwn5uFyUWrWxu34S
	vw4jqFya9wnxA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jsb18UUUUU=
X-CM-SenderInfo: jpryjkyrswkkmzybiqqrwthudrp/xtbC5h9aVmnMVt88QAAA3l

Thanks to all the maintainers for your timely feedback and correction. Much a=
ppreciated!


> =E5=9C=A8 2026=E5=B9=B44=E6=9C=881=E6=97=A5=EF=BC=8C05:07=EF=BC=8CHuang, K=
ai <kai.huang@intel.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> =EF=BB=BFOn Tue, 2026-03-31 at 09:30 -0700, Sean Christopherson wrote:
>>> On Tue, Mar 24, 2026, Kai Huang wrote:
>>> On Tue, 2026-03-24 at 11:27 +0800, 18341265598@163.com wrote:
>>>> From: "zhaoge.zhang" <zhangzg12@chinatelecom.cn>
>>>>=20
>>>> If the hardware does not support the SGX feature and we set the
>>>> corresponding flag, when the L1 hypervisor enables the corresponding
>>>> feature in VMCS12, the VM entry will fail.
>>>>=20
>>>> Reported-by: wei xiaoqiong <weixq1@chinatelecom.cn>
>>>> Signed-off-by: zhaoge.zhang <zhangzg12@chinatelecom.cn>
>>>> Reviewed-by: Huaitong Han <hanht2@chinatelecom.cn>
>>>> ---
>>>> arch/x86/kvm/vmx/nested.c |  2 +-
>>>> arch/x86/kvm/vmx/vmx.c    | 11 -----------
>>>> arch/x86/kvm/vmx/vmx.h    | 11 +++++++++++
>>>> 3 files changed, 12 insertions(+), 12 deletions(-)
>>>>=20
>>>> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
>>>> index 937aeb4..396ac07 100644
>>>> --- a/arch/x86/kvm/vmx/nested.c
>>>> +++ b/arch/x86/kvm/vmx/nested.c
>>>> @@ -7278,7 +7278,7 @@ static void nested_vmx_setup_secondary_ctls(u32 e=
pt_caps,
>>>>        msrs->secondary_ctls_high |=3D
>>>>            SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES;
>>>>=20
>>>> -    if (enable_sgx)
>>>> +    if (enable_sgx && cpu_has_sgx())
>>>>        msrs->secondary_ctls_high |=3D SECONDARY_EXEC_ENCLS_EXITING;
>>>> }
>>>=20
>>> Are you seeing the case where enable_sgx is true but cpu_has_sgx() repor=
ts
>>> false?
>>>=20
>>> It's quite strange because during KVM load, if cpu_has_sgx() is false,
>>> enable_sgx is guaranteed to be false.
>>>=20
>>> The only case that I can think of is after KVM loads somehow machine che=
ck
>>> happens, which "soft disables" SGX (CPUID reports SGX1 as 0).
>>>=20
>>> Is this the case you are meeting?
>>=20
>> It's a moot point (unless I'm getting -ENOCOFFEE, which is very possible a=
t the
>> moment), because "enable_sgx" is cleared if ENCLS-exiting isn't supported=
.
>>=20
>>    if (!cpu_has_vmx_encls_vmexit())
>>        enable_sgx =3D false;
>>=20
>> Where cpu_has_vmx_encls_vmexit() is peeking at vmcs_config.cpu_based_2nd_=
exec_ctrl:
>>=20
>>  static inline bool cpu_has_vmx_encls_vmexit(void)
>>  {
>>    return vmcs_config.cpu_based_2nd_exec_ctrl &
>>        SECONDARY_EXEC_ENCLS_EXITING;
>>  }
>>=20
>> And thus already incorporates this code:
>>=20
>>    if (!cpu_has_sgx())
>>        _cpu_based_2nd_exec_control &=3D ~SECONDARY_EXEC_ENCLS_EXITING;
>>=20
>>=20
>> I suppose the #MC could happen between setup_vmcs_config() and
>> nested_vmx_setup_ctls_msrs(), but at that point, KVM is hosed no matter w=
hat.
>=20
> Exactly.  I think we can ignore this unless we can get more info from the
> author :-)

