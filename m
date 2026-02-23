Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413D233B961;
	Mon, 23 Feb 2026 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771870458; cv=none; b=uipAZKt8LE2fLTib2y8dsroAnFk0NB3TmlxxI2Y0cF6OhdcYyMBaDPNFof353HvjgAW5vKcN/MJPxbfN7wCxBRLnEFz5fjDyH0RQuxZlvsNwe5N4kOInCoqGBbgg+hVnub1D5MAWm4wYrPJn3TCNEttWS9gTauoRyuKwx8e9Aa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771870458; c=relaxed/simple;
	bh=Ko32fvtk6bixsPt4HIta8+/b+k3DorDq8sDvEEsEea4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZJKHaPlknPe/fPN3b7frVFXbGbBK0N9aAzbIWSOHyZCxOUqD04OU1ElwjVAUQbXTeFOleaKibddR5HSqMXPEdSsm+PVfK6d8/+42vBsw9o6gH3FSYQy46jQQHFZ4YLsNTQ7wxWgzZnxWdUvYpGJ9+HWynCrBrJxrcVJ3HbQft18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=JOqCJZkl; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JOqCJZkl"
Received: from smtpclient.apple (c-24-130-165-117.hsd1.ca.comcast.net [24.130.165.117])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61NHucxE1192396
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 23 Feb 2026 09:56:38 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61NHucxE1192396
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1771869399;
	bh=UV96YJDSAQHhfhSHSBGJYnGRmXZYA4GrMJlSRNVtwT0=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=JOqCJZklLApkfkbiGjk/A1+vXEYsAraKpb5+o55SVCygM8fz/+wcu/Nl8q9vXqtJd
	 tK7mP/fDISsqFbR/J8cceyGu5T9c0TOgEQsHyH9aCSsEOhG79yT6kBWJVLedTNTGFm
	 gBQV3D/IzTZvm6bRCF13K+YL07eV8QjrNnJVZR5lokI7dNNZRetzSkM3eugIQRR59n
	 kBKRQO9Cgm7mQL9SlE4ipjAqO9ezexUavEmJ/U6TlvvpzxGTQBaTf+iUVRPT62xUe+
	 k94/IlhfHOsA2UEVlqTc7WMUako3Di60mkoC7JNQ665JYQiSXaJKvB0yJfMIrbp1Vv
	 RSBGbRbNskG8A==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v3 09/16] x86/msr: Use the alternatives mechanism for
 WRMSR
From: Xin Li <xin@zytor.com>
In-Reply-To: <542ff5d7-1cff-4ef9-af48-f0378aa2a05c@intel.com>
Date: Mon, 23 Feb 2026 09:56:28 -0800
Cc: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kvm@vger.kernel.org, llvm@lists.linux.dev,
        "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <14FE6A05-0864-4BD5-8331-0C2E6B8A28F8@zytor.com>
References: <20260218082133.400602-1-jgross@suse.com>
 <20260218082133.400602-10-jgross@suse.com> <aZYoUE7CmrLg3SVe@google.com>
 <e05a65a7-bf8e-420b-8a36-2d76e56b43b0@intel.com>
 <d622a318-f7f8-4cff-b540-38d159ca87f4@suse.com>
 <437EC937-24B7-4E69-B369-F9FAFC46F1B1@zytor.com>
 <542ff5d7-1cff-4ef9-af48-f0378aa2a05c@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
X-Mailer: Apple Mail (2.3864.400.21)


>>> I _really_ thought this was discussed upfront by Xin before he sent =
out his
>>> first version of the series.
>> I actually reached out to the Intel architects about this before I =
started
>> coding. Turns out, if the CPU supports WRMSRNS, you can use it across =
the
>> board.  The hardware is smart enough to perform a serialized write =
whenever
>> a non-serialized one isn't proper, so there=E2=80=99s no risk.
>=20
> Could we be a little more specific here, please?

Sorry as I=E2=80=99m no longer with Intel, I don=E2=80=99t have access =
to those emails.

Got to mention, also to reply to Sean=E2=80=99s challenge, as usual I =
didn=E2=80=99t get
detailed explanation about how would hardware implement WRMSRNS,
except it falls back to do a serialized write when it=E2=80=99s not =
*proper*.


>=20
> If it was universally safe to s/WRMSR/WRMSRNS/, then there wouldn't =
have
> been a need for WRMSRNS in the ISA.
>=20
> Even the WRMSRNS description in the SDM talks about some caveats with
> "performance-monitor events" MSRs. That sounds like it contradicts the
> idea that the "hardware is smart enough" universally to tolerate using
> WRMSRNS *EVERYWHERE*.
>=20
> It also says:
>=20
> Like WRMSR, WRMSRNS will ensure that all operations before it do
> not use the new MSR value and that all operations after the
> WRMSRNS do use the new value.
>=20
> Which is a handy guarantee for sure. But, it's far short of a fully
> serializing instruction.

