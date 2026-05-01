Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B51835E952
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777662742; cv=pass; b=BANwXh9RQrdO9MUOtuCVX1CCGsVh64k/Yj9E8l41ap0NcFI1a2Fz21jQ2Y22XEY9x/s9VL/EHkHYr7dKaZeZEuh3agJVXTItc0nZzOR+SoTnyGW5Fl0H+aq+bnlXdSQPwJXEAyQ6R71tn7qnnk/UipBJLt+NJtFJGj80EQ6OZT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777662742; c=relaxed/simple;
	bh=hsgFMxSVpPKS2tYlhKBJWXt+iv4JfRbOTmCq+LCIYTE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0jYf26/Vjudtdn51wJMCp5b6YEWxDZlhnczdaLaQK5kzRXLA/xalqqwMPD2X61QV70MJPfqajKaxpPqXu+y4bXuJrzOL3ed45ApV0crFbb0+1c0SaVzmEwqow96xR0NhrypjLrL2zoFIMOD3kux6ody4gXGFfExJlXsV9Y55S8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ndZOySKx; arc=pass smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ndZOySKx"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-94e578a0fa5so1355605241.0
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 12:12:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777662740; cv=none;
        d=google.com; s=arc-20240605;
        b=DWX1jiLWPWWqECDEPTNuIDlr110wTCR083PZCnsypLj9MkjSI7HvFNG5dnjsuFZ0KN
         cDOTe0J9BW/bEcJaE8+6JIcoIdZceaTlylneOHAWw1XJd+cItMHjnoKOiUqu86jk1hU/
         dbzRNTPe9MRgKBp/+fPN6/fBQ91R4t/HYIAC5BzjqNPYEgFhMMUWJum2gU9SB5hAFQ5k
         9BTmM94PWx+HEci9VUxMDB0oP9gqtU6MSXEYSYFGVjV6eFjEWLSnkNxIPvMs+wuGeK/e
         KTJKDrKxuw102t0CdIon29xpU1NQtScjxZVgC4h1C43lMyeIa8YDFenXFgZRN4ndJSwE
         xQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=nm6005Bs28bikl/uf0zpE9w9BeJo6zdbBUk2D1gSfD0=;
        fh=foQNTHS7V9+bQgG6khXPPCLhj7lEL1/H/6wqIj1mH48=;
        b=Etqwl1RgvY4sbFGvxLTO2Iqn2A5cNyCe+lyqnEkH2KfW+yw/8svRlmxzU+8FwJL5G/
         szKWOarZPp4TWyGwQnswPvnKYCvt67vs5/Q1YBBsA0IIWbw9nSgc+IUWxUb3RQVOqs7c
         hfG/Zh3qXPFa+b0CY5HmGsRYK29mvvKGzn5ZfSpaYpiZbqbc75WwxybwiXmG/QlEhJ5Q
         KiihbK2oURULYKEGqnk+3LTyp/nnsNmF0pz9nDv50xEt0XSG2t+Bp14uiQoaCojKmOzw
         l38Pp6Ev82vL/TViyYWoivj9WnE/2gnF2onDSjp2rZSWRHCedRff53i/3O4VPCoHv7vw
         H2ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777662740; x=1778267540; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nm6005Bs28bikl/uf0zpE9w9BeJo6zdbBUk2D1gSfD0=;
        b=ndZOySKx4CFN4RTUl2aG7Y8f1wOJP1EEp+deLrF6SI7GbcpaVC+1kq31jUgyWIU8vZ
         lrRbgJYjVjJk2Pt+He3T/OPdU3AAXVNixGslVi1WJ/KZt6btbl5t26vfoTOeI8sK5AsW
         Be8+BtkjjB0KYu4lJUTqjbCDlswuW/JjitzeM8p+OcHkp8bmXiPcAeZuoTf1kHWE8sk6
         W0SJFm80URsB9EtGxUjGueNtmeupA69354K8DxVacyYI6WjzQHc7isJpOgVY/TsTvui+
         lw4XNajs5upZftABOkbwUSMHO2QPMvk53FNqCKV3Yh6gTp1zp6wOD2OMBX3KVl+eIEjX
         uQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777662740; x=1778267540;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nm6005Bs28bikl/uf0zpE9w9BeJo6zdbBUk2D1gSfD0=;
        b=HuIjCLT2kpuoI9wrvqG8t360fyBKCvTBCTnw8aJklW3FMBqz8z/0nJMFdDjVuF1Vs7
         dpn6MxQJTM0IcobmjhmBflqgoxJXq0FAbCokPO4ywpZk7LXOUlyx1ykpPCDtl/r1M114
         z7ejn2Y7yYzTyZzOj2j/n6Rcs/+4iE7nRPkpMKT4ueWOe1BmNSswpTX/jiyfha/1GV9p
         7moGHr0sxSLKcTQI1hTLHXXaSuMfRY7BKCVymDpiMzfSVsb4rWdJhDsCvYlJqs9X/6Tk
         RxRumZSKjQrF73ahRD7HeJVAEPdrGFdf6aPT+N1e+lNBuypjmFSlrKMEvr8Gi8NxbBu/
         mP0w==
X-Forwarded-Encrypted: i=1; AFNElJ+NTxaHhoHTA5R/ZXaUjfaYh88nhfrKjMvcoqHg+LAqzXkGznc20h2/BXXqXLKS+eA/FrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGTNGTtexgU676KsD/uVFopxMrJq4sid3Z8q960DESU+SVdRx/
	s4qMMTdlWtVJT6FAzZ7c2qk4akWJEF8a8PtCLFfrPCzcqlt6FU0oAXFE2s5XpGlY5sI8S3TgNvg
	Ks6pqx9pybQHc4bODn6r8yJVfl2S1eAutddcbNIAb
X-Gm-Gg: AeBDieurlmJiCMngLV8t4IvV71c2cTvA/lcS6a4Uut3vSgt/6u9zur+JTHvClKa915h
	4POviIVRteez7Uj7oE8y2STwyiGsoF31HoRRRg/NHj/OCFJ7ZlrLD5J1FWgf5uV374i1DF85/Ic
	76JqycLgWMyRLlB1dZuUmTCSPY6TLiCBec3jatkGo7RLQkJnsTpmUcOfIz3Mm7+kvLYEKMdZ/u/
	cZEFKhjVszKrYpspanyj5dWHa2mM0ZqnW4HPNdqaKNFh3+IhPfPxoWzqaNAkojHT0N/BPAnVaKn
	wjY6dWKmVI0lAjLP+Mt3zRlWtBijyB425NI90kvEcLO4fgF43MkbTO9ND832Qm8dlGFzFRHNfug
	UROY4K2CraU2Wz4s=
X-Received: by 2002:a05:6102:4489:b0:618:442a:9e76 with SMTP id
 ada2fe7eead31-62d8547deeemr417754137.10.1777662739743; Fri, 01 May 2026
 12:12:19 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 May 2026 12:12:18 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 May 2026 12:12:18 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <0c15142ecf6689ebe31a9c0f6f331398fc04f6d2.1775874970.git.ashish.kalra@amd.com>
References: <cover.1775874970.git.ashish.kalra@amd.com> <0c15142ecf6689ebe31a9c0f6f331398fc04f6d2.1775874970.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 1 May 2026 12:12:18 -0700
X-Gm-Features: AVHnY4IwCQzSJJS5oI5H0hf1wYJTfgd9UcwRH4ft9v8o5wccryGIDOCmRLQ2i0g
Message-ID: <CAEvNRgGP4ZHz9=MOGybGwe2A4XHkVF6nXnr_KdHavz1rR62U4w@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] KVM: SEV: Perform RMP optimizations on SNP guest shutdown
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, seanjc@google.com, 
	peterz@infradead.org, thomas.lendacky@amd.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, ardb@kernel.org
Cc: pbonzini@redhat.com, aik@amd.com, Michael.Roth@amd.com, 
	KPrateek.Nayak@amd.com, Tycho.Andersen@amd.com, Nathan.Fontenot@amd.com, 
	jackyli@google.com, pgonda@google.com, rientjes@google.com, 
	jacobhxu@google.com, xin@zytor.com, pawan.kumar.gupta@linux.intel.com, 
	babu.moger@amd.com, dyoung@redhat.com, nikunj@amd.com, john.allen@amd.com, 
	darwi@linutronix.de, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Ashish Kalra <Ashish.Kalra@amd.com> writes:

>
> [...snip...]
>
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 3f9c1aa39a0a..e0f4f8ebef68 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2942,6 +2942,8 @@ void sev_vm_destroy(struct kvm *kvm)
>  	if (sev_snp_guest(kvm)) {
>  		snp_guest_req_cleanup(kvm);
>
> +		snp_rmpopt_all_physmem();
> +

I see this is what you suggested in [1]. The time-based batching you
suggeested works because adding to the workqueue when there's already a
job just does nothing. Thanks!

I think optimizing when the VM is destroyed makes sense, in most cases
for SNP VMs, we don't expect large 1G blocks of memory to be shared
anyway, so even if we try to RMPOPT on every conversion to private, most
of those tries would be optimizing nothing.

I guess the remaining optimization would be to update based on only the
range of pfns where guest_memfd has private memory, but that could be
done in another patch series.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

[1] https://lore.kernel.org/all/31040bb7-653a-40f9-8899-40bc852f7e1f@amd.com/

>  		/*
>  		 * Decomission handles unbinding of the ASID. If it fails for
>  		 * some unexpected reason, just leak the ASID.
> --
> 2.43.0
