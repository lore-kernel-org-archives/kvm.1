Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793925658;
	b=fjNccP3mPEqAQTFLxlr4Gwg+HvMxkkjivD043lOE7K1qTHUtkkHZbD6tFZQFjH0/Dhqt
	 YyvIXKghDo05RJoB8iZ4NJ5GshVPY4BORgN0nd9hxHYvKRzD402VNbg48apfQn3gjyYLA
	 5Pe04azXekIIvfemnGUIk1oSuK0RI5k3kQuDUe1gVdyqM00Cf+CxPSD+X0adnDvqg0QQl
	 tf65jHreG0NGaaatNQbc7ZfNnwId7rap4BQPFNlWqkiF2O6gbqXFU3fK3jIDSACx0acjH
	 3OcTzcwp/7P7YY3nPXRHSnEOqmXnNu3QfCEj90qwJUX7AqiRa64wroRK4shpNPoL4Ug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NWW6VWRvfnKcgFIlw1Yh6tcTkZ0ARdGpxylaeqJx8hg=;
	b=5chOWg5A4nzASE8S+btjVhgD7WPREvynwXJlBjLMv1yeZNHRziO8ILpNni8UgETzyEd+
	 Fgui4s+K6vkkMyXfbzxpsVurdyeQS4CfiS4/ainAhX9fUjYMKYr7AJfS1rBPI6WkHJk+T
	 p73YIHdeSeQb3/n/19n2IGU/823MS2VWZcmVnRdqjrDRdzN7yP+Vrok+DzFMQKA7MaNRP
	 eMqPZYHyLWn9NW5NKz8GtdScu03KC33LVBW1JKZV/f3pOsCm21nC5eFOvGGq7e59EoxF1
	 NzTeCUF5NP4w87Gp/WuiXL/2RuKVvTAiY67XlnvKBZGfVwXm2Ck/wCv0L2WOZNsnXag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fvdvi436;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02CF606A32E
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 00:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C02CF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fvdvi436
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b571a45a2aso381a12.0
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 16:40:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793925656; cv=none;
        d=google.com; s=arc-20260327;
        b=IkZxh8XRPHKu0J/J9LUHCNOSCPZJAV13CfxbpE4HE0JBJQIdVDLdj1RI9yDgRT74G4
         N3Ge8GAPjwqSEbeu/Otc41DNfNDZoKLZqblmndS7fqKmJRYcsjcBu34bEBhyJIeZPudv
         IF3aM3gUEh7Jzi5WpjHuxEGF3gLzxlcjXS4GcFr83UpV5UOCFX8TC3/3XkW6T/9mWzN2
         +bOT+oaGN2CZZKEiTtFn8BKv3ENV2r0P3q0XjxhupRqPX9BOCifvOQRxmwm0oWPX/Ti0
         HBa+zzjPEY3Kd7kvr+Eg466xwABNEC8KcQDu7aQ3O7uFbQWI5REcKu2exxt06v8iiWlj
         iamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NWW6VWRvfnKcgFIlw1Yh6tcTkZ0ARdGpxylaeqJx8hg=;
        fh=NhInO5QFh+7isPGaqV8Cbgv1y29flU2nAhHUZ/pcr6M=;
        b=bZATyN/9xpZGXGWM/qKFx6v9h1jPHFdwwX6bM1J8RD9JagANSNz93TVoKd0Myg9NMS
         mcV2du70aYjRElRfKOhUU7kpVudw+0umfDJOjR2nQaDv1+C5+eqwT1FDRczKMl9kvsMi
         MyE5s5seNpk2RoEMzrbg6KPYtUntN3HXaM9MR12r6s5h+ncelyw4z4PXs6AG10v/EfiV
         nUyoEyiPHGsSZUQfT0+gaIUjRMEunBjuVp/f8sIEWfp4JoVN9VegUeMLxWY4G1GLkF3U
         s+47VDkkIXTYxl9PJC0PENy89d19ayVqA6QOS7XdNCcVepM+uMdCqqfgampy+3WCa6b8
         k6aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925656; x=1794530456; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NWW6VWRvfnKcgFIlw1Yh6tcTkZ0ARdGpxylaeqJx8hg=;
        b=fvdvi436qEqauV2hnhDmQVirJAqbX7yiljRe9cOvyeMaPEVMh2eDz1lenbawGE2ZwD
         7nICz7zL7xJq1VNJn1KzBqi2RzRWUTUd5j23vxjqnME7d5n3JmCMRfK2Jz6cbPFUkHGW
         JJqreYxj0zMKkDnTYEVldHl+NH8VkdhA/wYXf0D9iDHGZoDGG5Xkt7+ic1X8Ne3jjyui
         Gr3LTLhA9G4Hjl+exYc1rSLykY5LzBpL9IPfRrd4Y7vynHORBNwb2OT/5T3HOqJFtcB2
         8b7bP4Op1s1KC19DSn3v3YbWpdC+cj7sbJHijwxKTvOSjyB5yvBKizjm8qr5htCtGNO6
         Vn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925656; x=1794530456;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NWW6VWRvfnKcgFIlw1Yh6tcTkZ0ARdGpxylaeqJx8hg=;
        b=1Kzr+9xccjmOrVdlG0CP2/v/+yoV3hwAu8EsIVcjmMPV9XxGjtx+WNslb49Upmk6vE
         7LaCfjKljTxaJvAjgdwp0/RfjL4OZak1+76Zv21BdBvcFsuW4UAYFRFvtcyrPY3MK6PJ
         QMqaBpBi/EeJ/+AYsKft2XxfUnc1QhQa0u1CK31lyXNyv87X28Ke1yO0UBak7/wJn5Ux
         FJzPWuzsfwyMSyF8iHLTq99dOv8FgUMZBfFR6tQYzbRtbRGyvqTOn7PLQh5kxPqReLh3
         drlomVVp+kuP8GWyyttOLsydG0pjuasmLXY4MLq1oZl3kKqdy2R/r/c6X14NwiRFvs8V
         Ac0A==
X-Forwarded-Encrypted: i=1; AKwUvBx/lG9o6OJzCQU0IC/xEQ9sb3MdiDI7gxuOKgl0t4Z1ejAJeHRnq7jV5Ym6JEivDvhZWw8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SGRu6OfhyREs4+ZNmLm6hLC5xB0NLBe6cMPs/XzJ7m9YKXMz/
	x6ryrmY0mop2OmzjON0kx2s97pyk7ZHPk+5deHAjaEwLLamyd7KBnk7uzjTDNVOEm1027ki8yLI
	irKJl1t4ghR+u9Xbamus1+tEZN0RLxxEfRKAK9/F6
X-Gm-Gg: AYBFou0U9XUVnbcX7RnplEUhOdkvIao/YrerkIJjUNPmynCQPlHVl6mr29HqlHMYgts
	ayePbreADCsJPnMDcTGMnfOUzpOufuOZSQZ7V97qymD03tI/i4ESf1Qbdg07Ix2RSZUCoN4wneW
	DCX61yVuB1MExuvP0LfZ0YqV6J7lR3Hj8cZ/X+DhnEF8rFwNKJFhBkeoxXzCqekPNwO/x/ChDpT
	z/LfffMt4sB6yq47fpN8l3Er9ABEPEtcq32U8fOTu2p9s9ZbkJ2Q+xSv+lGoLvEZe5g/CbLVx8y
	pGL7BrU1IvjYiEt61TTVjgp2RfN/BlCqWwQBZ+K04TltqIrGeQ02kLi9tfRmH6DQPcLD1M2m9F7
	UZbkjnr7uVoGtSwDto9ziQQJ5tJ+MzJph9b11SsSdnDNyQjMvs5oKESNustu5AsWCIZplJ0uY/2
	wjIPYvhCIAmCoxAUrQL53m1uNj8w==
X-Received: by 2002:a05:6402:1806:b0:6b4:629a:6352 with SMTP id
 4fb4d7f45d1cf-6b597833cb7mr35960a12.5.1793925655384; Thu, 05 Nov 2026
 16:40:55 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930210750.1487547-1-chang.seok.bae@intel.com> <20260930210750.1487547-9-chang.seok.bae@intel.com>
In-Reply-To: <20260930210750.1487547-9-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 5 Nov 2026 16:40:42 -0800
X-Gm-Features: AclHuK-4sGsbJMrfSl64kCcEOiMA7UjfuzawJTnrgKST2LlZsQ5qYXn3PXqPGmk
Message-ID: <CALMp9eTEd3jHNwh8M-xbtrTVD5-RgWuUDr=ZxRPWtL20_=WDQg@mail.gmail.com>
Subject: Re: [PATCH v8 08/20] KVM: VMX: Support instruction information extension
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 4:55=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> Define the VMCS field offset for the extended instruction information.
> Then, support 5-bit register indices retrieval from VMCS fields.
>
> Note the APX enumeration alone indicates the extension is available.
> For safety, do not assume that previously reserved bits were zero
> on older implementations.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Link: https://lore.kernel.org/aakEsXJgO-3m2xca@google.com
> ---
>
> Note for the review of extensions in following functions:
> +-------+------------------+------------------------------------+
> | Bits  | Field Name       | Related KVM Functions              |
> +=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> | 3:2   | ASIZE            | vmx_get_instr_info_addr_size()     |
> +-------+------------------+------------------------------------+
> | 4     | Mem/Reg (1=3D>reg) | vmx_get_instr_info_is_reg()        |
> +-------+------------------+------------------------------------+
> | 9:7   | Segment          | vmx_get_instr_info_seg_reg()       |
> +-------+------------------+------------------------------------+
> | 10    | IndexInvalid     | vmx_get_instr_info_base_reg()      |
> +-------+------------------+------------------------------------+
> | 11    | BaseInvalid      | vmx_get_instr_info_base_is_valid() |
> +-------+------------------+------------------------------------+
> | 20:16 | Reg1             | vmx_get_instr_info_reg()           |
> +-------+------------------+------------------------------------+
> | 28:24 | Index            | vmx_get_instr_info_index_reg()     |
> +-------+------------------+------------------------------------+
> | 36:32 | Base             | vmx_get_instr_info_base_reg()      |
> +-------+------------------+------------------------------------+
> | 44:40 | Reg2             | vmx_get_instr_info_reg2()          |
> +-------+------------------+------------------------------------+
>
> Reference:
>   APX Specification, Table 3.11 Extended Instruction-Information (EII)
>   VMCS Field
> ---
>  arch/x86/include/asm/vmx.h |  2 ++
>  arch/x86/kvm/vmx/vmx.h     | 42 +++++++++++++++++++++++++++-----------
>  2 files changed, 32 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> index f98e40df5004..0b1e2353db3b 100644
> --- a/arch/x86/include/asm/vmx.h
> +++ b/arch/x86/include/asm/vmx.h
> @@ -277,6 +277,8 @@ enum vmcs_field {
>         PID_POINTER_TABLE_HIGH          =3D 0x00002043,
>         GUEST_PHYSICAL_ADDRESS          =3D 0x00002400,
>         GUEST_PHYSICAL_ADDRESS_HIGH     =3D 0x00002401,
> +       EXTENDED_INSTRUCTION_INFO       =3D 0x00002406,
> +       EXTENDED_INSTRUCTION_INFO_HIGH  =3D 0x00002407,
>         VMCS_LINK_POINTER               =3D 0x00002800,
>         VMCS_LINK_POINTER_HIGH          =3D 0x00002801,
>         GUEST_IA32_DEBUGCTL             =3D 0x00002802,
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 863b08478544..4a76af613720 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -330,9 +330,18 @@ static __always_inline unsigned long vmx_get_exit_qu=
al(struct kvm_vcpu *vcpu)
>         return vt->exit_qualification;
>  }
>
> +/*
> + * The APX enumeration guarantees the presence of the extended fields.
> + * The host CPUID bit alone is sufficient to rely on it.
> + */
> +static inline bool vmx_instr_info_extended(void)
> +{
> +       return cpu_feature_enabled(X86_FEATURE_APX);
> +}

Sashiko is not wrong. When KVM runs on top of Hyper-V with eVMCS enabled,
vmcs_read64() becomes evmcs_read64(). Because eVMCS v1 does not define a
mapping for EXTENDED_INSTRUCTION_INFO (0x2406) in vmcs_field_to_evmcs_1[],
get_evmcs_offset() triggers a WARN_ONCE() and evmcs_read64() returns 0 on
every instruction exit that calls vmx_get_instr_info(), even when APX is
not enabled for the guest.

Until eVMCS supports EXTENDED_INSTRUCTION_INFO, vmx_instr_info_extended()
must be predicated on !kvm_is_using_evmcs().

Moreover, enable_apx should be forced off when kvm_is_using_evmcs() is true=
.
