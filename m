Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ACD42EEA0;
	Tue, 20 Jan 2026 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932684; cv=none; b=W3qEdgTAKa9r0UUeBpZbemd5MCaQIWsHQbv6s0wlQCbN2e8lyiBZ6XK0UGNN6/xI3lsllOAS7k/TJ3PsvPwITru+/+BXcJNq8yBtYUUzi9HLNk851XeKS+PEiNwQQI4O43pCJCij7bMJIUl2wDesTiAspkm98X9U3WXf0Ek6+Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932684; c=relaxed/simple;
	bh=31CmkHnI4qUbLaiumqbwGxKzO9/BfZ2vOZAKFnVZMdI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=e4R4u14Ob+lUx8JixLHwugFODtHxByYxCIAhEDYnOaJEY2SyVuuTn2baQzw7Vg+BKgHRC2lO/S38etzjXGA6TEhexhuuwBrPKICyUyfVQqrpuWwCR5UlPp3bQ6x5gdwvaLDXYJsAAur1h2hGAMWHhO7n0v3HeYMpv4En+vCF5sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=DGfB5hiY; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DGfB5hiY"
Received: from smtpclient.apple (c-24-130-165-117.hsd1.ca.comcast.net [24.130.165.117])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 60KIAmd13819567
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 20 Jan 2026 10:10:48 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 60KIAmd13819567
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025122301; t=1768932649;
	bh=8M3R17nO7V8nc/BUHch3zYz20ey7zMOEUc1KgvaQewA=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=DGfB5hiYeOLbqHVaRE8LiLDqON0VpJZeq4fIudglza148x1/KxabRGJS+XT6xxtWk
	 Wdbs4ktLnKsE+zH3o5XMB93+MMR5pOySg5RFDbvFSlkPgWBEDwDJcr+Rg2XkgRCZZU
	 XiFMc7UTNEpeh3UAXPzKWBqn3SHVvlBAYc4k+niePb9mo+24HN+LWPNt6QvdmmZBUj
	 QHph926LdYfJE/ZCVldEE+6eJC07VvAGATdTj60VSlkc3x8jmb2CxP+hD2ROjeBmjs
	 VyuB3i713rNiQ2o3hxeFPVB5sNokX2wla9mjYqmVQuZPcLxVjyU1VkQyIPZR/iJEK7
	 NE43cNjVB6/Lg==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v9 19/22] KVM: nVMX: Handle FRED VMCS fields in nested VMX
 context
From: Xin Li <xin@zytor.com>
In-Reply-To: <32096607-8426-4743-9d56-3ebf27d278cf@intel.com>
Date: Tue, 20 Jan 2026 10:10:38 -0800
Cc: Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org, pbonzini@redhat.com,
        seanjc@google.com, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, luto@kernel.org, peterz@infradead.org,
        andrew.cooper3@citrix.com, hch@infradead.org, sohil.mehta@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <92CC125E-E778-447F-A2A8-25EE74F0B299@zytor.com>
References: <20251026201911.505204-1-xin@zytor.com>
 <20251026201911.505204-20-xin@zytor.com> <aS6H/vIdKA/rLOxu@intel.com>
 <3F71014C-5692-4180-BC6B-CCD7D2A827BB@zytor.com>
 <32096607-8426-4743-9d56-3ebf27d278cf@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)


> On Jan 20, 2026, at 8:07=E2=80=AFAM, Dave Hansen =
<dave.hansen@intel.com> wrote:
>=20
> On 1/19/26 22:30, Xin Li wrote:
>>> On Dec 1, 2025, at 10:32=E2=80=AFPM, Chao Gao <chao.gao@intel.com> =
wrote:
>>>> + nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, =
msr_bitmap_l0,
>>>> +  MSR_IA32_FRED_RSP0, MSR_TYPE_RW);
>>> Why is only this specific MSR handled? What about other FRED MSRs?
>> Peter just gave a good explanation:
>>=20
>> =
https://lore.kernel.org/lkml/f0768546-a767-4d74-956e-b40128272a09@zytor.co=
m/
>=20
> Yup! It would be great to get some of that content into the changelogs
> and comments.

Sure, I will do it with Peter :)

And we already have a document file: =
Documentation/arch/x86/x86_64/fred.rst.

I think the comment is more for native, right?


