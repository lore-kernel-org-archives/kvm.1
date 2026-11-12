Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794508630;
	b=GbtI/yN1XQAHQDmovcjNu7sPMKHUJQFqYdXkkY3A9CO+iu8kP67n9e2fn79B+PCsCFt5
	 6gq4Qxo0AMNviyH32IZ/dXCwbCt9LD1FDPbLYDLmZvilqyXgbMQ9tqwfFAA2EWYHraxUt
	 gekhbM3kp7LgxvjgKT1jbj8Q+bQPruGIV+OlUn4GpI+zxL9OWPxwjbc1L/0zeThvBt0ST
	 7rYfF9d2bvwmFos1HmNhnDsqokotz4L82sw77TzFTsWBgmURvE0/3YYyWtpMrIVfEVzlb
	 BK3shKNYvLEmsScyZ6uns2dme5duFdsdm/jDxoik5XJrIAvF//7cTl0d/yMVUvJ0UsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508630;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QwsnVdAdvSGrDGgG3+S9CYGhPqY+OBHsYH8Jxiu3UE4=;
	b=X+14HtaBKo0EEE4k1hqldq6GAj91c7SH7/cPvsgDlz8RL2Xmpcr1N1tS29KQ1COT165n
	 QyJcpdeIpzYtLhqPtDlT8ut3VAYexzCdnruPadIDnNNOSpECTdV48T9IOGXlSwltPVQi6
	 GlEPeMdtWY6u/TBkEL461U1EIr9ikbVHgXibceAGc43kiML9glGHKw/IhcP3uHw3VTDLA
	 qlqYQTdKKuxUxj2tE2eQ7WeylSU2OI5OjKAPfhbGT6C766XLL1vc3hojZVQ/+UD+LFuWv
	 CI2o12ML2sUE7mBxHMN8jXtx2axIbK6IgNtG77NYcqyGC09uIsmkURV+n6m/4gGwD9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=H4xaCjFy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA87606A335
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 18:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AA87606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=H4xaCjFy
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso1257a12.0
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 10:37:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794508628; cv=none;
        d=google.com; s=arc-20260327;
        b=N06p8lY7fH5JVtZ21mEbWWpatoDh6rJnDkv70KwE8IBx7UQ5XWJRbS75S1G+6WUvzV
         Ielii8cpxctYSmPMvPbzH85RuJJi1h0YrwEQtvkEpPiONZjf346RVxRokJSm1CBxpM0V
         Xzgb4rbSeWtfSyPZtSMuS22jVJgM0sjBQkqZwjM27/3t0LpTFX00L0SDf0tG45MzowBJ
         arDxWpsqy4iMLVV5vMAmUBHTRJk+OOdInRpN3PB/dYx18TOaUoPIprib4o5uWQJt9Mmi
         IusAZv9ZVS6LKYBJjtoA+a+ptpyVONKc6ruWrGHFp7NOydneUi/YQN+DRpcwa1t803l7
         SAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QwsnVdAdvSGrDGgG3+S9CYGhPqY+OBHsYH8Jxiu3UE4=;
        fh=acvzIEivQDhZuYTOlOtRmtcxRkb3XV+eoCLhGB6ZFU0=;
        b=D5DUnfpiwX/TxvkZ0RNj8lRfqZSTFHptgkw94ue/JzstW4k4PUWuZBh6WrpQ0Rj8tS
         nF3YS6b8uKxJz4BuMNW0O/Sj6/roUsxjkBBYZbluOvlvRFKydwTl5nbwb8j3kuYFqgsu
         YMjN+YHuX7Vt8YRHyLn+r2m72SJEkn5NShe9xHpTmxTaPLsCELtBDOxOpRNzpRRlOgfG
         TRy+BhSQ0my8ZYHFYuhic6SRTGPazyBPfgaH9bV6YKKIo35t77iOtkf/hVv9fz2Vyx0t
         IvmFhjX4GwRgEN8YZkpRHU+cjE2OiYaXXuNbURFm6ULxqJ+XT2A+yKEbRcQAL0qWWAmN
         711Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794508628; x=1795113428; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QwsnVdAdvSGrDGgG3+S9CYGhPqY+OBHsYH8Jxiu3UE4=;
        b=H4xaCjFyorNRMHu4JRUVL3kxyy5XCQ6rNk8FBb8UHfiwxPUXcNR+K7MS7C4x78naKL
         5MOv/s9oEhDu1SbMd3o/DJBUsa4W4ti+6tv8MmJicFNtOqjeLdI1JAbO/2qz4i4uFY0Q
         e3qymi10upruK+tneE8hA8/AKXVfGXeiKZtP+4JQ3HLhw6u+4akhqCrJAPURAKsCcspd
         4JWSzSv9H+mUj9EDxZYeAgjEKcgCJ8h3LTY4iAeiBIuTQGMR7EFE7TNqTzGX83KuRmQP
         hD1v8lUtxCOH3+4BqSRXL8g0ZFeDDHy4KvYqV7bstknRTq4Am4P2n+utcs4C7+i5tN/H
         yJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794508628; x=1795113428;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QwsnVdAdvSGrDGgG3+S9CYGhPqY+OBHsYH8Jxiu3UE4=;
        b=UC4c0Ma7/6kEh99+0N03nCKfRfoQHKlRKma4j8yuI65Mr6GLydZc4qy/8bohvNahBk
         4MZZBEwHYBN/2/KoI530uhpEis6ggXCuBbnEHD1SkDXwhnI8aztxqoNAF86DZ8HZj12m
         WW8GvuseSS8xJZreEaNI9zH+UiQZh7rW+9hlX5FvU3epzFA9VfC3oNH8N7WtNZf8IwZa
         uLsg6KOx6LZe0TPdvv5soICb7P0CH4cU5yDijyA96OyIN++p3XzgmT8juTSWW953wCxk
         Q3EoU6QwpyZdfN8VaNw4E1U9c258TAvEBL1hcaeSaHawqXnGbIQjA5Rb4qOa/rPgk8YE
         56Ag==
X-Forwarded-Encrypted: i=1; AL+hErEV3NeHFmAcl8AusAZmdrFuNu6meyhpx/cIljhCVckHnal0xINM5/tXzGwQGGw6pXyG7VQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9N/D8zHkb+6RyCl4B53hGGV5Rx8XPxtSM3V+1ZHGf2jM7sihOO
	DP+nvedoH2H0l1O8n0MRrucXnYP7NG8QXvwFUMHwGySUIy90aM7usE+AEGDayiSv3lAIUcv0bbm
	8OZ/hPXkUz3KgGfzaTzfQPsgnwdsvbfYyX7SuuPPn
X-Gm-Gg: AYBFou33OT1H5Dg6oXBNH10xkUR33GMvoBz596PeoWxC3DIM7nY775fEQJlEuEBH0iR
	elT2rteZIRM53eQECiEzwoiEVBE6jdaIMPaFI99xfWGbl/JH3LUg2UhzV3Tbyu6oI1aQwP8ttZA
	yA9+q//ZKJabnke4j+fTseg2LcN+2o21C704uvX4NG/iJLchC9iCNHdii++wvOoVPtNCQRm2ZrB
	PYzTKq7VGT5NGlIh8qWQmaJ6P9eytBAx14ggJXQCpsO0ZCS6FlJM6yzud/bWfsPqeSphLwDGrJ2
	TYZ3Hekgj/m7wFccMTH9EOIJ30p8IiUs9asydtx51bm4utGyHkRfeZ8RdO2u7oi93WUQHQASEe9
	9+WoB0xmfZZIzJX67GewlkjqReCNnpAO/a8IknrNMdc6PV7IZ2si2kNYoELZRAmEt0uaqbg19v4
	crA1yrD0ZDQ3D4Vep4nQ==
X-Received: by 2002:a05:6402:327:b0:6b1:a517:5bce with SMTP id
 4fb4d7f45d1cf-6b7a2ab087cmr87795a12.16.1794508627091; Thu, 12 Nov 2026
 10:37:07 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794374897.git.zack.rusin@broadcom.com> <4dca09deb85d2d5db157888ae4a2de7cbf6421d2.1794374897.git.zack.rusin@broadcom.com>
In-Reply-To: <4dca09deb85d2d5db157888ae4a2de7cbf6421d2.1794374897.git.zack.rusin@broadcom.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 12 Nov 2026 10:36:54 -0800
X-Gm-Features: AclHuK8rt1aN38OOO-5Oe9cWGgilUSsg7YZ6I-VfVfdCTw37NLQGQcQLM8ki98w
Message-ID: <CALMp9eSARNY=K-bXSoV6sBBaWoKQGHtym1VrjnHtBQhFvsb2gQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] KVM: selftests: Port VMware backdoor coverage
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Doug Covelli <doug.covelli@broadcom.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, Xin Li <xin@zytor.com>, 
	Francesco Lavra <flavra@baylibre.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	Liran Alon <liran.alon@oracle.com>, Arbel Moshe <arbel.moshe@oracle.com>, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 10:08=E2=80=AFPM Zack Rusin <zack.rusin@broadcom.co=
m> wrote:
>
> Add vmware_backdoor_test, adapted from KVM-unit-tests' vmware_backdoors
> test.  From CPL3, with CR4.PCE clear and no I/O permission bitmap in
> the TSS, read the VMware pseudo-PMCs with RDPMC and issue backdoor
> commands on the backdoor port with IN.  Verify that the pseudo-PMC
> reads succeed and the port accesses exit to userspace only when the
> backdoor is enabled and raise #GP otherwise, and that other PMC indices
> and ports always raise #GP.  Repeat the pseudo-PMC checks at CPL3 with
> CR4.PCE set and at CPL0, where RDPMC doesn't fault before KVM handles
> it.  Skip the pseudo-PMC checks if KVM doesn't virtualize a PMU, as KVM
> then injects #GP for every RDPMC.
>
> Run the checks for a VM that relies on the enable_vmware_backdoor
> default and for a VM that enables KVM_VMWARE_ENABLE_BACKDOOR, and
> verify that KVM_CAP_X86_VMWARE rejects every flag it doesn't report.
> KVM-unit-tests can only cover the module parameter, which applies to
> every VM, while the selftest also covers the per-VM capability.
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Link: https://lore.kernel.org/r/aIEoNpe-LFoH6LBm@google.com
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> ---

[ ... ]

> +static struct insn_result guest_inl(u16 port, u32 command)
> +{
> +       struct insn_result result;
> +       unsigned long rax =3D VMPORT_DEFAULT_RETVAL;

Shouldn't %rax be VMWARE_MAGIC?


> +       unsigned long rbx =3D VMPORT_DEFAULT_RETVAL;
> +       unsigned long rcx =3D command;
> +       unsigned long rdx =3D port;
> +       u64 error_code;
> +
> +       asm volatile(KVM_ASM_SAFE("inl %%dx, %%eax")
> +                    : "+a"(rax), "+b"(rbx), "+c"(rcx), "+d"(rdx),
> +                      KVM_ASM_SAFE_OUTPUTS(result.vector, error_code)
> +                    :
> +                    : KVM_ASM_SAFE_CLOBBERS);
> +       result.value =3D rbx;
> +       return result;
> +}
> +
