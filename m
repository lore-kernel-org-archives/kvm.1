Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3D5390985
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237045; cv=pass; b=mgF9zsVZzvuUThQ7doJXhTa3hznpNslRRzdRkRiN/hksmNYgNaWa7nKYqcwHoF9gA13bKbC/IB+op5vvqoBe/qZKu9iNuLivZq/cDndX2gfcPj1qOF9fYI1f5gRdW9Q4x9nQ9Fb7gAdBNW52Hgxjmaqb7i6M7j29u166B921DvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237045; c=relaxed/simple;
	bh=ao/gjLtwrPN9EkIIj1OlYbo6h/r99kzcN9bKH22zQDQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3wW6zsO5pOsVpN3mkbnmP0+G5zNYjw5hMEI2OE1Ib5BtQOXUvxTR6wiAZB+wtHGQWd5jPU5kbwGZGdv/iTbPKk8r7F5/WwUVQZ7qb5cZc2QQMal8Iny/9M70dg/ELLKP/bA9EWfJfALp5AnND9YK5ehEV4Epm5i3Qj8eRw52N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i6bLY+y4; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i6bLY+y4"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1384ebe7a10so235794c88.1
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 10:50:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782237044; cv=none;
        d=google.com; s=arc-20240605;
        b=iF5uMxkbLqwGYTg7w5lkvF/eZylrhlNh3f6idutSk+MUSyJekL25PKxgWkL5CiSWji
         ppAk2u00k3xhPHq4SYbiKOtr9wBZGflKt7a8sj0qq4M2KTN3qzzibjR1464r28/wmP+M
         lKERA9NbnL3pXtkIp8NrzsN12Ju0hHFGtrCgj/fF7EY3+8kX/Wrl+hDo09K5AgbD0sZQ
         4GpUmNolGWm3Twsa6vn40A1mgi20Xvo1pXrxZLm0W+31jqwnnbbHPgRvVz/ePJHh+ZVh
         zYHgqrbR75ClalxQHkbKfyfBQLgnboLRjTfbMU0qyqVscu8L9fuL3IIa45e+KFbDzeN6
         sosA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=iaH6OIuh4aHHZqieJze8syUo2Z1c4+x2P2tU6UVJVNo=;
        fh=iwZicRdIhd/NIdoyKJQk0rU4LK+/gkZ99VYRzb32iG0=;
        b=QH5pH17Y5QH5DGVux07kPCUb2lO42oQrEDSz4D1HGRDzUKr3jY7Q+mdAXtyggLRVRB
         VJTpwdJSMFjqgvoDWp0XB2cLZG0YeYAHlR8klzA1aQ2eXCxopPRPH32HWjJDL3CNnsdI
         wgOWmCj8Om+2VMF8q9whsOW+avIG1V5+4TSBQIiGZ07J9/4qhSwXfl/7xuTYACiU7rKx
         AIJpyqYvR3/gqrgBe6+zN4NcFuVw3ZjJlgvtkV88WXgW+ujsvQkJ4XAYoyTRjCUi1fis
         Zezy29RuQn3jk14+6DAmJ+ouxT2ReiLfjKxy4aEHSzkwvfpnakkPQAePMmcinP1eSeo6
         NAAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782237044; x=1782841844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaH6OIuh4aHHZqieJze8syUo2Z1c4+x2P2tU6UVJVNo=;
        b=i6bLY+y4fheSs6q75OLzzsOqa9l01NWekCcBaj6vDWzRrNf73Wu4MLKQ8hmiwJfnGc
         T5L0BT/mAWOekSBW6iurWAgNjou+8CLxl62vfTA1iwQn+VsyLh6Vm69w9wJt8mFjNZHW
         65H9iGefXXfZta6mAi4Ir1iT4F0qMd34X59g/aHqqiMIWrnqLQxotAzq1Ca7wtIrfxjk
         kWfKyDQYzse3LFxaRXDz+JBSoLstq4q4ckKtWXUh/tJjNdjuMl7Ya4Cbv+WRHv0875rS
         j68iL8JOvYnKfj7/n8WU+gE4kxuu85V7FbV3MrWbOTdTNPlHy2w2lZ8d27Y1fhEf2D5b
         D9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237044; x=1782841844;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iaH6OIuh4aHHZqieJze8syUo2Z1c4+x2P2tU6UVJVNo=;
        b=EkCzxhxMDkaNZtPdRn5y4TF+JMRa3FSjZa8ulYF6/1n9oZf8UKl8EhcCNcGORDodZg
         jRtyEOYF/0KB0EGZXmUtK52+3jQOWtmrVBvC9vQqGRzfB1CoLe8w8JW5zCjRLUnEdXia
         VF0Fo+Qj2Qz57uQZq9prVvMOTyFQBZAV7CLbu4n5P7A10VZnaXZ6dPeYGSJT1PRV2ddQ
         LCR9sKRHvNKWzVWkX+2l7e9GpXEbztdM3v99VTjdj9T5l1MgThbCyp5IuvkgiddzBSgv
         l+hM7mRCU4NsQGlV7+G7+sOub5mm9YcyLRBCuJUZWDI975lmnZ3R/6hdhdRH0tf44zKd
         C8MA==
X-Forwarded-Encrypted: i=1; AFNElJ+VbewJguEH+uJWesTcwLviw1sq2rZ9G1JpojOnjwM2m2hlBwmlggDbvxla2iJ4TimG/vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG51w7sux6zcs7Sh9NJTZAjXbfdB749nnqdeMnUt84zBT9qPlU
	HSP9VqhEc5kiR5PX42SliUlN5PW37PChE/R77965qACgy2y8s+2ACwUvczPMi3IQQYZMqEPwXPy
	B+P6fEtBEXrCO/7XHOCNH0t65j0Lq+5QFtfBXBzBR
X-Gm-Gg: AfdE7clOEdY6tBFzDsjdZF+LIgZPHeK5sew5Uzxg6vcmsobWUPb3ck7OE1pgHnZWgJm
	ueBQP25XpeFcuyxCP1qYTKsRIXcMgB74B+Mm1AJXnBIeIv8mS6SXG5D9xqlhM7GUk9gfNLBHPWf
	BA2gqbqeXiAlOTBLMgymjgIEa8Kp4TccOPKjLbRxqSF8BJUGdgpWZ44vqoOXuzmBOVq6YKF+Guq
	g+EdJuRcNaYFvogSCeUx9vAIy7qqiJXU85zY96S2Rn11Vem7DMOiZQn5IiwyeVbYjUFavdWRhi8
	RghMlCup63S6BPMwI+1FDwqk/lHgCW+FiNUU7dk2txt7yBpKRTLXruBm+5o=
X-Received: by 2002:a05:7023:b0d:b0:12d:ea4f:99de with SMTP id
 a92af1059eb24-139c5b9d56amr3139260c88.0.1782237043068; Tue, 23 Jun 2026
 10:50:43 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 10:50:42 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 10:50:42 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <8c5f4082-e3a5-4f65-b058-33938a7ee324@amd.com>
References: <cover.1781419998.git.ashish.kalra@amd.com> <de274c2fb3f794ff1f19f0c96184ee50d04d1282.1781419998.git.ashish.kalra@amd.com>
 <0fa0bc95-ff31-40c5-b083-3c885d09d0ab@amd.com> <8c5f4082-e3a5-4f65-b058-33938a7ee324@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Jun 2026 10:50:42 -0700
X-Gm-Features: AVVi8CdyhQZDa5lioZ66r0smztGw-BoY8xCcu3T1y7FPhbFJD_2pARoB-P2VDng
Message-ID: <CAEvNRgHPbb0ARYS-E4N=fM1eG5fNshKHSwdWj74gZdzjgwm4Rg@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] x86/sev: Add support to perform RMP optimizations asynchronously
To: "Kalra, Ashish" <ashish.kalra@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, seanjc@google.com, peterz@infradead.org, 
	thomas.lendacky@amd.com, herbert@gondor.apana.org.au, davem@davemloft.net, 
	ardb@kernel.org
Cc: pbonzini@redhat.com, aik@amd.com, Michael.Roth@amd.com, 
	Tycho.Andersen@amd.com, Nathan.Fontenot@amd.com, jackyli@google.com, 
	pgonda@google.com, rientjes@google.com, jacobhxu@google.com, xin@zytor.com, 
	pawan.kumar.gupta@linux.intel.com, babu.moger@amd.com, dyoung@redhat.com, 
	nikunj@amd.com, john.allen@amd.com, darwi@linutronix.de, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kvm@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"Kalra, Ashish" <ashish.kalra@amd.com> writes:

>
> [...snip...]
>
>
> Yes, a simpler implementation will be like this:
> ...
>
>  	if (!alloc_cpumask_var(&follower_mask, GFP_KERNEL))

Perhaps have a WARN_ON_ONCE() here so we know rmpopt was not performed?
Not a huge deal without though.

>                 return;
>
>  	cpumask_copy(follower_mask, &rmpopt_cpumask);
>
>         /*
>          * The current CPU's core always has RMPOPT_BASE programmed
>          * (snp_prepare() required all CPUs online at setup and CPU hotpl=
ug
>          * is disabled while SNP is active), so it can always be the lead=
er.
>          * RMPOPT_BASE is per-core; exclude this core from the followers.
>          */
>         migrate_disable();
>         cpumask_andnot(follower_mask, follower_mask,
>                        topology_sibling_cpumask(smp_processor_id()));
>
>         for (pa =3D rmpopt_pa_start; pa < rmpopt_pa_end; pa +=3D SZ_1G) {
>                 rmpopt(pa);
>                 cond_resched();
>         }
>         migrate_enable();
>
>         cpus_read_lock();
>         for (pa =3D rmpopt_pa_start; pa < rmpopt_pa_end; pa +=3D SZ_1G) {
>                 on_each_cpu_mask(follower_mask, rmpopt_smp, (void *)pa, t=
rue);
>                 cond_resched();
>         }
>         cpus_read_unlock();
>
>         free_cpumask_var(follower_mask);
>
>

Definitely better than the version in the original patch :) Thanks!

>  Here, the leader exclusion must use the sibling mask, not clear_cpu(this=
_cpu). That's why my collapsed version uses:
>
>         cpumask_andnot(follower_mask, follower_mask,
>                        topology_sibling_cpumask(smp_processor_id()));
>
>   - If this_cpu is a primary: its sibling mask contains itself (the prima=
ry) -> andnot removes this core's primary from the followers.
>
>   - If this_cpu is a secondary: it isn't in follower_mask at all, but its=
 sibling mask contains its primary, which is in
>   follower_mask -> andnot still removes this core's primary.
>
>   So either way the current core is dropped from the followers. (The old =
code needed two branches because case #1 used
>   clear_cpu(this_cpu) =E2=80=94 only correct when this_cpu is the primary=
 =E2=80=94 while case #2 used the sibling andnot. The single andnot works f=
or
>   both cases).
>
> Thanks,
> Ashish
>
>>> +		goto followers;
>>> +	}
>>> +
>>> +	migrate_enable();
>>> +
