Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E985B290D81;
	Thu, 22 Jan 2026 00:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769042848; cv=none; b=Uvw+h0UxDb+F/FG4u9kcT5BHRG6dcFi69C9Ap8ze0cDC6mjQvxBAOCwhnWRCB2Eb5ulnQOvMCXwClSCse+wIe3mkMCUZpDc5m7GeChoSd1VG/78U/mAEVyu9OYCzmH4i4ex9oZuhEeYZy8jiVRirUwY/WXDYb/R5m7Jpn+ZTnOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769042848; c=relaxed/simple;
	bh=N2xP6KUJmkMZLeWioXcdg35K94T8ZBwbdanXSZ5fixs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ous+NykQP9/fw6MDSbkFEA4d7RytaQDJyz79C27lDXgT8DeHHGC6ToxLC/xh34bc6SUwbwiRfth+Ye4b8Y6sCoE6j06onmQRSh+i1hz/233PtK2t607NQ8DyEtioBpFNSxNIBBXke1EwYxdQJ+tijKKyh5lDHHoH2X0UJNAeqo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=LwF9xtUv; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LwF9xtUv"
Received: from smtpclient.apple (c-24-130-165-117.hsd1.ca.comcast.net [24.130.165.117])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 60M0jW4L2677546
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 21 Jan 2026 16:45:33 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 60M0jW4L2677546
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025122301; t=1769042734;
	bh=gMd/j23jxUftJoE3BU7jv5A6dzONw2jQ0KVJSKYr330=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=LwF9xtUvW/4gIhLaoTVw/+wJFm5fNc2CAyd3Ol4K+n+u/IfhNncAT5Ke0NF6UoCsN
	 yx8TzuSFmrFixA4pdbCDG277PH6yVgnYa6qDi2TU5TIEbcNIOlTosc54Q6jCvyPCYt
	 v1i7bih80mI3+y6F6+aFtSKbIdSRsgtD0TxFzwqUaL8RKtznRVprNQ7GGYZsuKiuoL
	 4T80pAfEJbhAoiQdKmb+tyyTfXaD5nEupNiIr8IGgsExUkBKD8N524TcZlpX2B0z3S
	 aY2orsr8GiMSqnGv4sckzeZLtjgXqEuIKxhB7Fljs1LV05A57tuZE1nTt0htOFGomo
	 +B2B+h2nRJ7iw==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v9 07/22] KVM: VMX: Initialize VMCS FRED fields
From: Xin Li <xin@zytor.com>
In-Reply-To: <9F630202-905B-43D7-9DBF-6E4551BAF082@zytor.com>
Date: Wed, 21 Jan 2026 16:45:22 -0800
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, pbonzini@redhat.com, seanjc@google.com,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, andrew.cooper3@citrix.com,
        chao.gao@intel.com, hch@infradead.org, sohil.mehta@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B01C8160-4999-43B9-B89C-45913E94DA55@zytor.com>
References: <20251026201911.505204-1-xin@zytor.com>
 <20251026201911.505204-8-xin@zytor.com>
 <8731e234-22b8-4ccf-89ef-63feed09e9c5@linux.intel.com>
 <9F630202-905B-43D7-9DBF-6E4551BAF082@zytor.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)



> On Jan 21, 2026, at 10:14=E2=80=AFAM, Xin Li <xin@zytor.com> wrote:
>=20
>=20
>=20
>> On Jan 20, 2026, at 10:44=E2=80=AFPM, Binbin Wu =
<binbin.wu@linux.intel.com> wrote:
>>=20
>>> +#ifdef CONFIG_X86_64
>>=20
>> Nit:
>>=20
>> Is this needed?
>>=20
>> FRED is initialized by X86_64_F(), if CONFIG_X86_64 is not enabled, =
this
>> path is not reachable.
>> There should be no compilation issue without #ifdef CONFIG_X86_64 / =
#endif.
>>=20
>> There are several similar patterns in this patch, using  #ifdef =
CONFIG_X86_64 /=20
>> #endif or not seems not consistent. E.g. __vmx_vcpu_reset() and =
init_vmcs()
>> doesn't check the config, but here does.
>=20
>=20
> I tried removing all such #ifdef, and it turned out that I had to keep =
this
> per the last round of build checks.
>=20
> Anyway, I will do another build check on x86_32.
>=20


The trouble comes from __this_cpu_ist_top_va():

arch/x86/kvm/vmx/vmx.c: In function =E2=80=98vmx_vcpu_load_vmcs=E2=80=99:
arch/x86/kvm/vmx/vmx.c:1608:59: error: implicit declaration of function =
=E2=80=98__this_cpu_ist_top_va=E2=80=99 =
[-Werror=3Dimplicit-function-declaration]
 1608 |                         vmcs_write64(HOST_IA32_FRED_RSP1, =
__this_cpu_ist_top_va(ESTACK_DB));
      |                                                           =
^~~~~~~~~~~~~~~~~~~~~
arch/x86/kvm/vmx/vmx.c:1608:81: error: =E2=80=98ESTACK_DB=E2=80=99 =
undeclared (first use in this function)
 1608 |                         vmcs_write64(HOST_IA32_FRED_RSP1, =
__this_cpu_ist_top_va(ESTACK_DB));
      |                                                                  =
               ^~~~~~~~~
arch/x86/kvm/vmx/vmx.c:1608:81: note: each undeclared identifier is =
reported only once for each function it appears in
  CC [M]  crypto/md4.o
  CC      lib/crypto/sha512.o
arch/x86/kvm/vmx/vmx.c:1609:81: error: =E2=80=98ESTACK_NMI=E2=80=99 =
undeclared (first use in this function)
 1609 |                         vmcs_write64(HOST_IA32_FRED_RSP2, =
__this_cpu_ist_top_va(ESTACK_NMI));
      |                                                                  =
               ^~~~~~~~~~
arch/x86/kvm/vmx/vmx.c:1610:81: error: =E2=80=98ESTACK_DF=E2=80=99 =
undeclared (first use in this function)
 1610 |                         vmcs_write64(HOST_IA32_FRED_RSP3, =
__this_cpu_ist_top_va(ESTACK_DF));
      |                                                                  =
               ^~~~~~~~~

