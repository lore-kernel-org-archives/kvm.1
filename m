Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C942E30E83A;
	Wed, 13 May 2026 02:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778639598; cv=none; b=s33burwovBmk+kOAolTywAuTHwN3OtpcOj8HMG/v8P9e7ghnbVXl4Ex3NTiMkma/cEkeu/AC5QPcn3A1VxQmqEZ64rhF/b7YgVmWprvDslRwTLAKSrKOb6nh9bv+EhdCshmlocw8UnWsAxV/BfzCJ2xAcuGPKF6enaPJ3j9dbhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778639598; c=relaxed/simple;
	bh=5rwRPdwdw+5c8103OEv6cJytI0j5QotILTCou1Uoqms=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=jzMpo2fDeA6r0bBczaKZCxjfOZivvBTsGiD6XXV+VbuVW3MHmtIa1He78vsZv87tpF979ahyxh+8A0G1DpaFK6nrfvmDM2q4AsDEQljJ0ZnoqvHkjd2FkzAB32SYhVEPQsKHRnlNhoh7yZeEfcit6V81ofM0GLr9Kff9vlPvw2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=g8/NOsd3; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="g8/NOsd3"
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 64D2WX151490435
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 12 May 2026 19:32:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 64D2WX151490435
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026042601; t=1778639555;
	bh=7iD/As2nHQY3YCluABKiPCH2yvbwQEpTycVStfrIUF4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=g8/NOsd3eysK9SPPpkpwQCr0dZmN9CK8KJzu+ZKUCHBoJA+HzchukfZQaE5zXwxne
	 LqUvnOB00x5OmdVIUy1EE62e/S7BfCIZQhOHaNwKbvPxQ0qcxhESl7cVe+VEd6Xgbq
	 eqQvsOE+05V1rTSa+t+LC706WM5PnvVb8F1UHSuT3/tMdqd4oh2AfnmDfQGbCpWm3/
	 Q8iSklkDYDNXZfvWGvol/6WSuw647Ol8AO9nMckFsb9GRxeIotV8huICeS9M45zKcI
	 nP67vcrJBChsEwS+M3ltvUxr58BG86OkI2DHOQMuj93lywVs/+dGxG4dcN+uM1WwpW
	 VwT8qvkkxJyPg==
Date: Tue, 12 May 2026 19:32:28 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Dave Hansen <dave.hansen@intel.com>,
        "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
CC: Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>,
        linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
        kvm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/tdx: Fix zero-extension for 32-bit port I/O
User-Agent: K-9 Mail for Android
In-Reply-To: <bf92ebbf-8d70-406a-aea1-c11ca576de90@intel.com>
References: <20260428125632.129770-1-kas@kernel.org> <20260428125632.129770-3-kas@kernel.org> <bf92ebbf-8d70-406a-aea1-c11ca576de90@intel.com>
Message-ID: <B8D6B43E-4C3D-4E1F-BD07-5632E1BBECEA@zytor.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 12, 2026 6:14:13 PM PDT, Dave Hansen <dave=2Ehansen@intel=2Ecom> wro=
te:
>On 4/28/26 05:56, Kiryl Shutsemau (Meta) wrote:
>> +	if (size =3D=3D 4)
>> +		regs->ax =3D 0;
>> +	else
>> +		regs->ax &=3D ~mask;
>
>I haven't thought about this _that_ much, but this feels wrong=2E Why is
>is 4 so special cased?
>
>Also, what _are_ the limits on the registers that 'in' can be used on?
>
>RAX - n/a, no 64-bit I/O
>EAX - size=3D4
>AX  - size=3D2
>AH  - n/a no encoding for inb
>AL  - size=3D1
>
>I'd find this much easier to grasp if there was a nice table of what the
>registers, sizes, and masks ended up being usable=2E As usual, x86 is
>"fun" here=2E

Because zero extension only applies to dwords=2E

x86-64 has three subregisters per GPR:

Bits 7-0
Bits 15-8
Bits 63-16
