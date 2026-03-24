Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEE1346E6D
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774375535; cv=none; b=OqjyujbrkRktG31pnPTaipsuqRq9VrLeEBdQtC7/eZA2lJwfDN9meX+xFgEuunTyortKpMb77KP/PtQEbn5ReYLEfq3u4DzDFa+SjnbttI5ZxWaGkvrsd4MqA772zVOuIuB96toz7059N8GxxlFuOJRTF0R5PHHXfu6/NBuqesE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774375535; c=relaxed/simple;
	bh=ICfADf8EA93Py0iNdanu6h6AqUh78uNvjjd1+my2EaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgOv2zl5zfhRoBWgEv3JAwmhFfKCBlxHW1fiX7uFRiu9sENCPEkF2EHsx3M1j8dTgjwN8khgED1WeR5PbPtM8aQ306cVENKe5wAgetos1IurwQIFcSKBFIrPPPjdcpysC1WXz+hESPs/i0HbGpdp9uTI1JDr+sWP2xK5tBA3ETY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PDXf08SK reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PDXf08SK"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6F16F40E01B5;
	Tue, 24 Mar 2026 18:05:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id A7y9luZ2IOGG; Tue, 24 Mar 2026 18:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774375518; bh=Ay64Ya23KAIdcQpOOr0ZVcAUYB4ws3UL6quLCrgGG+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PDXf08SKvj6haP2QG3feJJH/+phRCwLbigY5XmYA1srpsxiSIg6DmDDELbR6f0Zx9
	 RnCyn67FNjH2w+gDAKZ28FMhT+ZO2JfbuWimyaPv5SFx4+Nq7SUK6+3hAVivM/6mic
	 8XeLc7NPqYhF8F9I+e8iuvlzU0//kh16vg9/2nxaEmAX+rda2WlfKlCifSSRnvUCVY
	 pOy7D3AFJB8nT8Ztm8MLDAwvFufW/KxY28lqaJmXC9e9icQVfSTNo85kRWO9T9jvfq
	 Qj3WtPLn2binKI2QcKVbH4CZFQlqLkTT18cRgf5lHuT2U5NK6FnOKVh0VcsN3od0dB
	 Ego9zRTKW3OePFDLqd2lAu9ptg0u5W1RnZ2h8zmGosSFrSxBbfNEs8ncvFrc1jdgbi
	 btaPgrY3fphluSayqzsCqZ9jsEkU2tz3y0XRU7vosEO6nCxnm0qko6BmN4DQa+WIrM
	 CMujNu+XcaN2cyaLvdrk9iNaYKa7S3U5EmfOoJ5J9BombnrjuTExYrehgCWbAenDwx
	 4sV8lea0S4uhC0bfqJ6inozAmddW0gWXsxsKUwJQ1oLI3PBUIz/Y40MmgY627QUsw9
	 Sk2aQBMZKPWHD0SVWCtWRCfcqTizfkbvgeg8BvK/5mpByTqBNnRS2Wyrb/ENUH0d45
	 jwAZUgF2h3E7Uc6uCVnjbTBU=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id B188D40E0163;
	Tue, 24 Mar 2026 18:05:06 +0000 (UTC)
Date: Tue, 24 Mar 2026 19:04:59 +0100
From: Borislav Petkov <bp@alien8.de>
To: Manali Shukla <manali.shukla@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, mingo@redhat.com,
	kvm@vger.kernel.org, x86@kernel.org, nikunj.dadhania@amd.com,
	Naveen.Rao@amd.com, ravi.bangoria@amd.com, peterz@infradead.org,
	dave.hansen@linux.intel.com, tglx@kernel.org
Subject: Re: [RFC PATCH v1] x86/split_lock: Provide KVM helper to log guest
 bus lock exits
Message-ID: <20260324180449.GMacLSQUJepcHGCjTX@fat_crate.local>
References: <20260324124002.7670-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260324124002.7670-1-manali.shukla@amd.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 12:40:02PM +0000, Manali Shukla wrote:
> Bus locks monopolize the memory bus for thousands of cycles, stalling
> all CPUs and degrading system performance for every workload on the
> system. Cloud providers running multiple VMs need a way to identify
> which guest is responsible, so the offending VM can be flagged.
>=20
> Bus lock VMEXITs on AMD are fault-style, i.e. the vCPU's RIP points to
> the offending instruction at the time of the exit. Log guest's linear
> RIP and vCPU info to give operators the data needed to attribute the bu=
s
> lock to a specific VM and instruction. Keep policy enforcement to
> userspace via KVM_EXIT_X86_BUS_LOCK and let userspace implement
> throttling or other mitigations.
>=20
> Reuse current->reported_split_lock to limit the warning to the once per

s/ to the once/ to once/

> vCPU thread. Note that, current->reported_split_lock tracks the vCPU
> thread, not the individual guest process, i.e. the warning fires once
> per vCPU for the lifetime of thread regardless of how many distinct

"... for the lifetime of the thread... "

> guest processes trigger bus locks on that vCPU.

I guess that's fine since you're ratelimited.

>=20
> ----

What's that "----" supposed to denote here?

> The intent is purely observational =E2=80=94 give hypervisor owners
> visibility into which guest is generating bus locks so they can act
> accordingly. No policy enforcement is done in the kernel. Suggestions
> on the approach are welcome.

Oh, sounds like you want this paragraph to be...

>=20
> Suggested-by: Nikunj A Dadhania <nikunj@amd.com>
> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> ---

<--- ... here, after the SOB block and above the diffstat.

>  arch/x86/include/asm/cpu.h     |  2 ++
>  arch/x86/kernel/cpu/bus_lock.c | 19 +++++++++++++++++++
>  arch/x86/kvm/svm/svm.c         |  1 +
>  3 files changed, 22 insertions(+)
>=20
> diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
> index ad235dda1ded..4ac5011e10b2 100644
> --- a/arch/x86/include/asm/cpu.h
> +++ b/arch/x86/include/asm/cpu.h
> @@ -29,6 +29,7 @@ unsigned int x86_stepping(unsigned int sig);
>  extern void __init sld_setup(struct cpuinfo_x86 *c);
>  extern bool handle_user_split_lock(struct pt_regs *regs, long error_co=
de);
>  extern bool handle_guest_split_lock(unsigned long ip);
> +extern void handle_guest_bus_lock(unsigned long ip);
>  extern void handle_bus_lock(struct pt_regs *regs);
>  void split_lock_init(void);
>  void bus_lock_init(void);
> @@ -44,6 +45,7 @@ static inline bool handle_guest_split_lock(unsigned l=
ong ip)
>  	return false;
>  }
> =20
> +static inline void handle_guest_bus_lock(unsigned long ip) {}
>  static inline void handle_bus_lock(struct pt_regs *regs) {}
>  static inline void split_lock_init(void) {}
>  static inline void bus_lock_init(void) {}
> diff --git a/arch/x86/kernel/cpu/bus_lock.c b/arch/x86/kernel/cpu/bus_l=
ock.c
> index fb166662bc0d..a6d231410535 100644
> --- a/arch/x86/kernel/cpu/bus_lock.c
> +++ b/arch/x86/kernel/cpu/bus_lock.c
> @@ -292,6 +292,25 @@ bool handle_guest_split_lock(unsigned long ip)
>  }
>  EXPORT_SYMBOL_FOR_KVM(handle_guest_split_lock);
> =20
> +void handle_guest_bus_lock(unsigned long ip)

Exported function better have a prefix:

bus_lock_guest_handle() or so.

But, the only reason this function is here is because you need sld_state.

So, instead of doing that, you can add a helper called

sld_enabled()

or so, which is exported and then you can put the guest-specific handling=
 in
svm.c in case you want to expand it in the future and there you use
sld_enabled(), etc...

> +{
> +	/*
> +	 * Log bus lock exit when called from KVM exit handlers. Policy
> +	 * enforcement is delegated to userspace via KVM_EXIT_X86_BUS_LOCK.
> +	 * Let userspace implement throttling or other mitigations.
> +	 *
> +	 * Only log when split lock detection is active to respect system-wid=
e
> +	 * bus lock detection policy. Use the reported_split_lock flag to
> +	 * prevent log spam from the same vCPU.
> +	 */
> +	if (sld_state !=3D sld_off && !current->reported_split_lock) {
> +		pr_warn_ratelimited("%s/%d buslock at rip: 0x%lx\n",
> +				    current->comm, current->pid, ip);
> +		current->reported_split_lock =3D 1;
> +	}
> +}
> +EXPORT_SYMBOL_FOR_KVM(handle_guest_bus_lock);

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
