Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20B84418E4;
	Tue, 15 Sep 2026 06:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789452322; cv=none; b=kGCx7ur0qetQp6NwIoqrtJDu8vcrFz1oCDKALv2fZ++3wyBukvXedScq2zlFWkbpZ79nmMpfVW/1HJ+IGSZlMMmIsW5Lr0TXR0u+zatFHqgeIfCMXzTHDQCeuZ1vdCCz3QvI0MC/7W4E+xM96VR91V9zVj+n3i7JWu1TZxGwb2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789452322; c=relaxed/simple;
	bh=6Nt6m2Qz0cVYm7G7zMH/eNhNXyxSiiVOC/rcCL//w+Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=XL+qvhdmDK47I3fOK3DqVkPowCsVVelyQRMFQ3BfOO9ddnybd/LWaQv5dB5m2gWMDb+i78wTKVk620XNCNphB8XPTFv2wjcVRxF9Zx7VMhxZdg1uuUn74IGVJ5g3QxwuYsI5s4C/AWlBceDeaRaTvWPaTNlZBE1saj7/iwm55Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=aoU71I/d; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="aoU71I/d"
Received: from smtpclient.apple (c-24-130-165-117.hsd1.ca.comcast.net [24.130.165.117])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 68F645cT1083902
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 14 Sep 2026 23:04:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 68F645cT1083902
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026082801; t=1789452247;
	bh=kMbNlcyr2runurKlfcpyMm8L91tCFL2wOIlEwpghqJY=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=aoU71I/dDFZGyvRpBTaC+mihM5jqQFw1luhdtJkJ0/7ZZQhMsBgsLOrWq5WxE6x7g
	 yC+C/0WJ58YNr0ZszrdgausAk5B6yEpxq8eMjcMwCUmi5QyZcAUlPIfy1kvNmInrEr
	 CypFSLQXNk+KVNPyB302QG3lnV66s3Q1QF7DhJQsytupxJvPpIUZ9j89QVcYipRBAO
	 Oa1gX72z/2vNoo9Lds1dMmEh2rTb8sTkF+N9+Q+izKt78W9qVHAAs3+OBZPb3zsQZ/
	 ibOhsnQCRQmoJSrTg4V8rHW8IfzoDF/x9ojrY3whZvkB8BR7eJJbzuqZhWA8SFY9Hy
	 wZhP1xczogyrA==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH v10 00/28] KVM: Enable FRED support with KVM VMX
From: Xin Li <xin@zytor.com>
In-Reply-To: <20260911213659.2025974-1-sohil.mehta@intel.com>
Date: Mon, 14 Sep 2026 23:03:54 -0700
Cc: kvm@vger.kernel.org, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Shivansh Dhiman <shivansh.dhiman@amd.com>,
        David Woodhouse <dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>,
        Binbin Wu <binbin.wu@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>,
        Yosry Ahmed <yosry@kernel.org>, David Matlack <dmatlack@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E7D55C5F-91DF-45AC-BCC8-BD2759CEE0C4@zytor.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)


> On Sep 11, 2026, at 2:36=E2=80=AFPM, Sohil Mehta =
<sohil.mehta@intel.com> wrote:
>=20
> I mainly rebased the patches to the latest kvm-x86/next branch and =
fixed
> a handful of issues reported during internal testing and basic AI
> reviews. I've avoided making any major code changes or commit message
> updates as this is the first iteration that I am posting.=20

Thanks a lot for taking care of the patch series.

>=20
> Going forward, based on the feedback, I'll rework the patches as =
needed.
> I've listed a few opens below that need additional discussion or
> clarification. I'm relatively new to the KVM subsystem, so please feel
> free to provide suggestions on the series structure, code organization
> as well as commit log clarity to smoothen the review process.

I=E2=80=99ve been thinking about an optimization: because FRED drops =
most of the old   =20
syscall MSRs (IA32_LSTAR/IA32_CSTAR/IA32_SFMASK), we should be able to =
omit    =20
them from KVM's uret MSR tracking entirely as if host enables FRED (no =
matter  =20
whether a guest uses FRED).

Thanks!
Xin=
