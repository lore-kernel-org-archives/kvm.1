Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1359330D5E;
	Tue, 24 Feb 2026 21:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771969264; cv=none; b=oHAPZ3WoIAcz1ARdJZVCJW/Q0r0Ifq/qFAiokbe46ICtUquPKIXEoLfGPsdv20EX6YriKCZkrldnO9XxQvuoh7pmjDBcDuWKZP5zg/SckNF56VOUiXY9DnFPxMAVdrk3Yr9Hx5NRyssMmrrlVTS5rHxvFhqLYOWN/qCgQFYUWv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771969264; c=relaxed/simple;
	bh=+HSICUHFLvHnBFAoTDKXR2zMyLREOjt65Qz6kpcM9Gw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=l+8HLZPlqYL7AiRqX3UX/mX7Olc4Xjn3/o2+0jhxk5uWvi9l5W2+21D+2/73DD/DGudYKHx9NvD52VZOSFMEThyk0afgl+4AKRZzjVmK5yDg7lZMU9haDDbb6kB44zc7qn0GgjZjzV64Nf7AodHdLLmc4ra7zY3w3EOU+1QhT1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NMSMY7jD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NMSMY7jD"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BB14440E00DA;
	Tue, 24 Feb 2026 21:41:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id q5CoELQlXxnA; Tue, 24 Feb 2026 21:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1771969256; bh=vAU0bo7eUhVFomxVI2D4gQZiONaHqP7dsPgBM4WoGxo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=NMSMY7jD1XSyL7pLlfZG7kEEhDhh5n2EEn+L/YjeIBE/HcKuaDlpOL1ikrAWCUjgC
	 HpI3pPJQuGsTVdJcRf1x2KhsKVfr1FDRUFRR1yUsVaTjWfCsDRhaTX8xwsxoOtLn2N
	 /kd3QWl7/UelTw57+W71uTdxvXBOoi3HwT2qx1Tc7apUGL3Q3O0f73JuRhwL04daj8
	 Z8nBHaAuRr6zkogA84MO3kSFSpnpIbp27SKIl0X0Fi3NPB8/XMCwSK5LcqPKV8MlYo
	 lOQH629eJPlrHRj2Rq34SVul/t12ws9ymxgvTb3AgwMxEh2i+mGtihq8T4fWYBCijt
	 bBs4l0lP3VQ2VRt6hzTY3KSjY35FfloUQw5TS8d+svENIFTRhMUPGZsyozlnIZqGsq
	 W/WQksxnn02zJViDpGCfs55TDGBhNVKQSXtLiXImnSC+lIOhk400CgoN9xUE0ijZsV
	 x+9vgpyBVk7RTLUEj6L+y8ausT5xlvNCSNJM6RF8LA3LeAJjyNbEGc/ME/Cpuj7AMR
	 XjotVpctIsrVKr78B7NejSj/NsVXIDD/yN+YPVR0WrEQnX4qfPeREon0XcIsYKwwuQ
	 hzQ+sHGWzG/Kgdq550joQaM2F9Iz2niOY+cutPgZ252uU0B/a0dqqH9oecSVABaiuB
	 rXAN/KnimdEKObkEryIROyXI=
Received: from ehlo.thunderbird.net (unknown [IPv6:2a02:3035:662:6ae7:d92b:d96d:181a:344f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7A4F740E00DE;
	Tue, 24 Feb 2026 21:40:38 +0000 (UTC)
Date: Tue, 24 Feb 2026 21:40:28 +0000
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>, Kim Phillips <kim.phillips@amd.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, x86@kernel.org
CC: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>,
 Borislav Petkov <borislav.petkov@amd.com>, Naveen Rao <naveen.rao@amd.com>,
 David Kaplan <david.kaplan@amd.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, stable@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/3=5D_cpu/bugs=3A_Fix_selectin?=
 =?US-ASCII?Q?g_Automatic_IBRS_using_spectre=5Fv2=3Deibrs?=
User-Agent: K-9 Mail for Android
In-Reply-To: <6b3b0c86-99eb-406d-b88d-3d71613bef9e@intel.com>
References: <20260224180157.725159-1-kim.phillips@amd.com> <20260224180157.725159-2-kim.phillips@amd.com> <6b3b0c86-99eb-406d-b88d-3d71613bef9e@intel.com>
Message-ID: <E9013CF4-D30E-4366-A8C4-8C249ECF395C@alien8.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 24, 2026 6:22:36 PM UTC, Dave Hansen <dave=2Ehansen@intel=2Ecom=
> wrote:
>On 2/24/26 10:01, Kim Phillips wrote:
>> @@ -2136,7 +2136,8 @@ static void __init spectre_v2_select_mitigation(v=
oid)
>>  	if ((spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_EIBRS ||
>>  	     spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_EIBRS_LFENCE ||
>>  	     spectre_v2_cmd =3D=3D SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
>> -	    !boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
>> +	    !(boot_cpu_has(X86_FEATURE_IBRS_ENHANCED) ||
>> +	      boot_cpu_has(X86_FEATURE_AUTOIBRS))) {
>>  		pr_err("EIBRS selected but CPU doesn't have Enhanced or Automatic IB=
RS=2E Switching to AUTO select\n");
>>  		spectre_v2_cmd =3D SPECTRE_V2_CMD_AUTO;
>>  	}
>
>Didn't we agree to just use the "Intel feature" name? See this existing
>code:
>
>>         /*
>>          * AMD's AutoIBRS is equivalent to Intel's eIBRS - use the Inte=
l feature
>>          * flag and protect from vendor-specific bugs via the whitelist=
=2E
>>          *
>>          * Don't use AutoIBRS when SNP is enabled because it degrades h=
ost
>>          * userspace indirect branch performance=2E
>>          */
>>         if ((x86_arch_cap_msr & ARCH_CAP_IBRS_ALL) ||
>>             (cpu_has(c, X86_FEATURE_AUTOIBRS) &&
>>              !cpu_feature_enabled(X86_FEATURE_SEV_SNP))) {
>>                 setup_force_cpu_cap(X86_FEATURE_IBRS_ENHANCED);
>>                 if (!cpu_matches(cpu_vuln_whitelist, NO_EIBRS_PBRSB) &&
>>                     !(x86_arch_cap_msr & ARCH_CAP_PBRSB_NO))
>>                         setup_force_cpu_bug(X86_BUG_EIBRS_PBRSB);
>>         }
>
>You're probably not seeing X86_FEATURE_IBRS_ENHANCED because it doesn't
>get forced under SNP=2E

Set the Intel flag somewhere in the SNP init path=2E=2E=2E?
--=20
Small device=2E Typos and formatting crap
