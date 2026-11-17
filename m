Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955536;
	b=qtM+ngFHL0MuslmHf+cFySuSjRmTdf9QkT8wgxWk76UlFM5GIEtDi8HEaBwVJb2W3xxN
	 v8BaW0QemmhBR7FK2LjD1ouELddLPoYOrMtetTT10SBtUsJyrlk8shu6TNfWPNlkOjs9W
	 4O51oujdaLsudV6JWCiRrVOnSOOEepU6woeiXHb1+GmUkcQYnn0Qzi/9dgKRXO2k/eiKF
	 o/u73nO9EpvcsYss/eiO5K0gQ0Ya7qJwNlfVA7xS0brjYlvcovvEB7j3nexk5Ixy6n5p3
	 6cpd/6oo+KF6Pvq7EmHSHw0Knr7W4deJvSjWaxpRoQdcW33bxGVR82QwpdvQKAo1SWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955536;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=D2P+Z6Nq3yquQJWC9H3k46WKTq8eWiVaNcaMaB/1PPg=;
	b=03gatJrw0Ve3gjMEZK5zjwx44JhNIIDua55LvZ1CF9nM5/diTPw9DEbyV0wDomNCq0bJ
	 Ibqd9s2sy9WkxKr7mggT7gVjv7eAlSdZcazzTFvhYeSNnTI54PxPxfc9XuCNTnBCd26Py
	 iYf2w5yEfjUrbCf9tJA63WVKEenfpqa26/OK7TGbUq5eyakCxpO9IJh0QE7jl4j5/LIab
	 xJC9wh161Uc8YmmOoHzgcvD6X8mSMFFZM0RBjAYSMlIMFuoyEgqIzTazxvN3fXCIyVp27
	 exCUUbjfLzvJFIuArQ2qfaVqfZvkKJGZUOMLcGnw/bY3m6+b7REmXu6a8kP1DWU/VBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S8jiIVNv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AFE606A32A
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 22:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S8jiIVNv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962D51F000C4;
	Tue, 17 Nov 2026 22:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794955535;
	bh=D2P+Z6Nq3yquQJWC9H3k46WKTq8eWiVaNcaMaB/1PPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S8jiIVNvmIUfxEj//BPYfvW6xO01ax9Fh0SUOeAOGTxB/2AFeJRILexfmdqsGdjoO
	 6BYXXom2mi27edyBdyaE0kYWu4nzFWgZwnNy1O43sO/kzNswGIA/9f/3T91eoXHcvN
	 aAIm3pt/842YkXkBCgPwC25p3EUSdYIdzaCkQXmF1X7sl7Av10pGQ3JV/u2eTpY/c9
	 dMeQvtXlT1kNooHocPYZYpe94avAO0iYp5wHP30BcmjyNQbUsloU894/p4PL0a5BW1
	 XgBWNhsytkemo/b8xSjbN3TV3sZDstsAhQVvwHlQJtfj1FTFWgA0KOLuXGqKlkWfcp
	 8+ZLncdXTzotQ==
Message-ID: <sashiko-outbox-219764@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] x86/sev: Report distinct termination reasons for
 generic requests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kim Phillips" <kim.phillips@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261117223257.748178-2-kim.phillips@amd.com>
References: <20261117223257.748178-1-kim.phillips@amd.com>
 <20261117223257.748178-2-kim.phillips@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 22:45:34 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] x86/sev: redundant GHCB_TERM_NEGOTIATE reason code in
  setup_ghcb()
--

commit 91d9fc8e8c2597bdeaa888f419992440ce36ac9a
Author: Kim Phillips <kim.phillips@amd.com>

x86/sev: Report distinct termination reasons for generic requests

This commit replaces generic (SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ)
guest termination calls with specific Linux termination reason codes.

[ ... ]

> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index cc292d7c6fd1e..12152f2fe8c9e 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -1108,7 +1108,7 @@ void setup_ghcb(void)
>  	 * This gets called only in the BSP boot phase.
>  	 */
>  	if (!sev_es_negotiate_protocol())
> -		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
> +		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NEGOTIATE);
> =20
>  	/*
>  	 * Clear the boot_ghcb. The first exception comes in before the bss

[ ... ]

> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev=
-common.h
> index 01a6e4dbe4235..3717796c46737 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -209,6 +209,9 @@ struct snp_psc_desc {
>  #define GHCB_TERM_SECURE_TSC		10	/* Secure TSC initialization failed */
>  #define GHCB_TERM_SVSM_CA_REMAP_FAIL	11	/* SVSM is present but CA could =
not be remapped */
>  #define GHCB_TERM_SAVIC_FAIL		12	/* Secure AVIC-specific failure */
> +#define GHCB_TERM_VC_FAIL		13	/* #VC exception handling failure */
> +#define GHCB_TERM_GHCB_SETUP		14	/* GHCB setup/mapping failure */
> +#define GHCB_TERM_NEGOTIATE		15	/* HV GHCB protocol negotiation failure =
*/

[Severity: Low]
Should setup_ghcb() use (SEV_TERM_SET_GEN, GHCB_SEV_ES_PROT_UNSUPPORTED)
instead of introducing GHCB_TERM_NEGOTIATE?

Reason set 0 already defines GHCB_SEV_ES_PROT_UNSUPPORTED for GHCB
protocol negotiation failures, and sev_enable() in
arch/x86/boot/compressed/sev.c uses that pair when the same
sev_es_negotiate_protocol() helper fails.  Using GHCB_TERM_NEGOTIATE here
reports two different termination codes for the same protocol negotiation
failure depending on whether it occurs in the decompressor or the core
kernel.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117223257.7481=
78-1-kim.phillips@amd.com?part=3D1
