Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF19372071
	for <kvm@vger.kernel.org>; Mon,  7 Sep 2026 06:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763636; cv=none; b=tRXrFkAkR3Aei3K/4ujak4IFI8fQQf6YJgpwYzN16JXPBm85wti3v7PFhh0y/DlxUsbtym99pPp/RMVurCgX8NzGWQgo3W8pJ0FktEADy/2ZE8wssgVkLupT69JKICMsaOQ/Vd6ZZC/oAo2+ypMUbKKiT9oHcbKJ+lSkK9nZoQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763636; c=relaxed/simple;
	bh=ypSBdx0/ZJoQDu3KaWToc0YjCCVeuM7q6GDKo+u0fJI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sUSaRkiU4BZVX64ywPTHqMMYOabWVv247XQQc7pJ06ciOJxzEIvewseditktV8E4QJQPS2M1vXfLd/hxb/weuusfOleWZRbaUA1vNgIVGKVEukTx8anXkf5tPulNcyAmq0ecHLLr5Kv23TNckM8ffMEpUdxVkzQ598sdDcXt7L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL7tJ9H4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL7tJ9H4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8068E1F00A3A;
	Mon,  7 Sep 2026 06:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788763634;
	bh=HUrugGruu8JC7RdEw9gaM5xYO6jMOFYDwxSbROVyB08=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JL7tJ9H4noUp5chXVNPO18POZoDCeeMAqqBDIOfBUHNUcJ4MKprrcbmVIqtcBEM8F
	 NTmHKllpvro9avVPyGeKJxnXhhHQstpWsLfe+RajrWpVO3iFPw9XusIRxE3IMB1wzW
	 WlKFH2DlM22nyeM6hiD9OPx/sZBD9jlUhIMwvF6gtaldJaqFnb3WMRaRdZxXD/m6Lo
	 wDdEWeL2XUGflAifg0tnbVELslqePRwKiJVL4S2bpAfoSxQSFJbnbWnmw9dAT/HHI4
	 mpNEDx2jog7tjhQTVI3eMY/a1CvZg/IFNrlGnSXoVNwCtMEdzlytUNMBpHkNCrDPzt
	 AgDHG2JXaSoZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/8] x86/cpufeatures: Add Page modification logging
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikunj A Dadhania" <nikunj@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260907063906.1964557-7-nikunj@amd.com>
References: <20260907063906.1964557-1-nikunj@amd.com>
 <20260907063906.1964557-7-nikunj@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 06:47:14 +0000
Message-Id: <20260907064714.8068E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing synchronization of tools/arch/x86/include/asm/cpufeatures.h=
 with arch/x86/include/asm/cpufeatures.h.
--

commit 86e9807958bbcad0cbcf6a0ae079d6e8a75e8935
Author: Nikunj A Dadhania <nikunj@amd.com>

x86/cpufeatures: Add Page modification logging

Page modification logging(PML) is a hardware feature designed to track
guest modified memory pages. The feature is advertised via CPUID leaf
0x8000000A ECX[4] bit.

> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cp=
ufeatures.h
> index f70ee74b5f921..cbfcc66a18e9b 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -238,6 +238,7 @@
>  // free: was #define X86_FEATURE_PVUNLOCK               ( 8*32+20) /* PV=
 unlock function */
>  #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* PV vcpu_is_preempted func=
tion */
>  #define X86_FEATURE_TDX_GUEST		( 8*32+22) /* "tdx_guest" Intel Trust Dom=
ain Extensions Guest */
> +#define X86_FEATURE_PML			( 8*32+23) /* AMD Page Modification logging */

[Severity: Low]
Does this new feature flag also need to be added to
tools/arch/x86/include/asm/cpufeatures.h to keep the tools header in sync
with the main kernel header?

Without this synchronization, will building kernel tools trigger 'Kernel ABI
header differences' warnings during tools/perf/check-headers.sh, potentially
breaking builds configured with WERROR?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907063906.1964=
557-1-nikunj@amd.com?part=3D6
