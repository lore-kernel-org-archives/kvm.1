Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED3838D401
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217628; cv=pass; b=XIpswLkH7PtRP54ctOtUCcfyi2Z3Xc2B/4l5RnQbnBJ5WASnvSY9xEAPfc6TuEH0fCROfZqvmF7FHrECRdvPBo6q1srmjy7tmt0VOj1QWAl7sDQMZ6sNuOvit5P4pAzdIhjsz8c1zr7OSt0LPzDppskyhzwlTUYljhYRnEGjSS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217628; c=relaxed/simple;
	bh=mCKwif1IQ/lLee7i1tlpkED0sCq1sTR3RlYMoWGxaM4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHPj5Ix+V4R29mstEIHWzu5zf6xX2LdWBTd22O2CbBqKU2DkJwX+wSkCjw8ZkbKZxPuxxX7YijmJtasbj8RH97RxHUuIXoGgnE6px3SPqxHW2QKMx2ysbY4llKbXVOs8K0UfF1msl1AhL+JsRIF5Y3Zx4NPBtAJf/XstSea7wyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hnSZeTrN; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hnSZeTrN"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c928bf172so13334211cf.3
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 02:20:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787217626; cv=none;
        d=google.com; s=arc-20260327;
        b=E7BirIk8/gjByAkukfuyPU9wE1xH4nxKkY5GpHCaU6KdjDV0uKMVL2c7BZlrTe4hhe
         VTb8COuh4hbdY4CRZyn1YBHoy0/golHJVeRMC1KuJ4qY01sbt6Xb/dSzplhLkOSfwXYA
         68+QUDqykzWyvMycVyhwrv5qePlvon9A0esIgqT4jHklWTkAMynZ/IE9SPOrdcKard5F
         g3npZPWma1U0POSql2fWSQyYFQcmKknONKQrTSc4OCeNfFCD5+Y0SevLLW4n4V5PXEHs
         7m907HaysXp1x6M0LBQu3xuFUrGCTu4JCmEybA77GN2uhrv1bQZDX3pNqD1zBt/qBs1j
         MgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=btEJqH3glvcBsRJbKg2L7KXKgyRtz4hJgj5UscNKC5A=;
        fh=btiCwtsrx85dcTlmBzYuxuSBTt5KZQbZFWQFp4ufoHQ=;
        b=p0WinghR1OEKJ0Pxk+opQRRhPpPQTq8GSS1KAGiOStYne4+UVPBV5SdlnZgCpL9lvB
         YO1tP0ZwRob9w3sTcdxxKj61QydfvTFrzRhcwbjfPcgKyRh6GYp9vxPZNZGsBCU2Y0n0
         Wi8yEKj9oUF80KufjUyuPTReLBVXzhWLxwyEeD+OucX8zmm1gUg5IpZoZE9lAJvoFInN
         vdqlrLs24pYbscP1cmssQOZgYEXa7fHTL103Ss+smdnS+ZgsAIi1StuY4MuP+6XZxh7f
         xQmjWH4QzdYT6GzB5YmiCyHeqXa64lB43C6UaF1Q4nrdYBx4m21VLfjDjITwrL4ywrYd
         TS2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787217626; x=1787822426; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=btEJqH3glvcBsRJbKg2L7KXKgyRtz4hJgj5UscNKC5A=;
        b=hnSZeTrN+HhvA0QAlGSdviuBlyWrAbuQ0tHh6c8y8GyTtw8QTr9CrL/b3Oij82vp4J
         iPJVn+faXMFyCkOmoXsKcgHkcjKUXdiz5yaYScK0bt/oPyhzI6mj5Trg2ITCjCRGoTWT
         MQ8LFXc6xXu4ShClg9thu7sQu7SIUz/URjIUcKyiSiTydiICyFKxrDkGo+sdNO0IeJ7f
         X10QSxPpgyS+qs7IuJp3G0RcSQ0N4207U+aG8uiOJ8TpvQbi4+16KHn8wys0CK1u9mvC
         yz5BHEm+hdhJ7oJGbgtgIzgd8ugzFdo6FKcRBpIow/0T6Ii84hVXvB2/dQZPc1p9cVl2
         jRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787217626; x=1787822426;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=btEJqH3glvcBsRJbKg2L7KXKgyRtz4hJgj5UscNKC5A=;
        b=SCNu348Gn1l95wyWrgQjf2Mr0Ltae9CcT/x6SLoCOopEZM5O4cIYRPmktg/9tdkhQ4
         euGzFOylf4v4Qw+NDrDG+mMF96SSKjA/+CLXroQnpmtcC6uFnEYyFRQEU+iCgONR0BoX
         hQ7QcfU8pdNjzWPeJYMi9jxR5qJayYfgF/n/e1TnhzHp75yOkE6OPLhYyEhbdGramy4U
         TV+ogjAzQD8+wtnx+CsyHEOBw2tFv0s92SlQWsn1POYmJKZou4n/qb/c5kPg+opGsgkN
         h2iM1Wone4/mrNzIKv4+MGe+ipaj7roaoQgpAgC55EdxXHswOUFVBv8vO8yozd4bitYs
         l3qg==
X-Forwarded-Encrypted: i=1; AHgh+Rqs6MbPGnM3tLdQFnJYBvg0ixtzID66EK0vS0jscPMOjHB/pJvxfjobHkujt96PR/wKyo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+WAf3U9Mhj57y/i3CTCuE9/qRWpbNGqQsfb9Alu+qdCsdSm4A
	iMDpphkDLC5do7wmexG1/sK+5FTPzajMfukqpN+SAjrodJxc8R1k43IyoBbcO8fl94OXCK0N0qo
	1Ah+l/RdTbzhuSQn095GlywBwPZMrc8jUxtg+IoYN
X-Gm-Gg: AR+sD108whHceRjTZHzzJY65xW59YOWJcyBX0HA9vbcTPqsyuBcd2rCPmky6arJm/Ku
	4XcSri4UzsRNHocEZr95bhOrl13wlP6kUAelwYWkhcUWgZw9sniU2YL/4csav7rgeCHCkPrGT2T
	hb3DqASoKYJP0CVHfTHz4LWs/4DTXNBx3BH96kspvriBagcPFGqEMFxSJsUd2UO/HCzlfB2v1Pe
	YF7rt585aIjYd4Ay26ogBaCImgnM6U9HERldppSoloZEiqTgesaoQt9XvZjy/dJZ0OUWImQ9Rd/
	lMobvLq6qaH6ZJwcaR+onTgJo+vErHn9Lo8PBKpPQjIpgKgrhxFyLZyIvwFi+NT6PG7nme1ytjF
	2
X-Received: by 2002:a05:622a:5148:b0:516:d955:ea6 with SMTP id
 d75a77b69052e-52dd58d3483mr104538721cf.14.1787217625625; Thu, 20 Aug 2026
 02:20:25 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 02:20:25 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 02:20:24 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260818092717.3F4871F000E9@smtp.kernel.org>
References: <20260818-gmem-no-return-page-v2-0-5298f42d49bb@google.com>
 <20260818-gmem-no-return-page-v2-3-5298f42d49bb@google.com> <20260818092717.3F4871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 02:20:24 -0700
X-Gm-Features: AcwNN1VYoQ5shf82DtyHbf0xd5d-e2E9t-61o0yco6Y-2RGI9BPKRpGen-uy2Zw
Message-ID: <CAEvNRgHEVxO+1Mkoc3-c2+qSrKWnD+BDe04NBvuwGU6BL0amzA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] KVM: SEV: Drop page refcount early in VMSA reload
To: sashiko-reviews@lists.linux.dev
Cc: Oliver Upton <oupton@kernel.org>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Critical] A preexisting vulnerability in `sev_gmem_make_shared` allows=
 a malicious SEV-SNP guest to cause a host kernel panic by transitioning a =
`guest_memfd` page to VMSA state. When the page is subsequently freed, KVM =
fails to reclaim it and returns the still-firmware-owned page to the host p=
age allocator.
> --
>
> --- Patch [3]: [PATCH v2 3/4] KVM: SEV: Drop page refcount early in VMSA =
reload ---
> commit 597ff1c52e82911967f2122ff1d77aa79a4a2d9b
> Author: Ackerley Tng <ackerleytng@google.com>
>
> KVM: SEV: Drop page refcount early in VMSA reload
>
> This commit modifies the guest VMSA reload path for SEV-SNP vCPUs to drop
> the page reference immediately after retrieving the PFN from guest_memfd.
> This avoids holding the reference across MMU lock acquisition and prepare=
s
> for future changes. The page's presence remains governed by KVM's MMU
> invalidation protocol.
>
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index b34b11d7f8fad..d3d620bc04dce 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -4062,6 +4062,7 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu =
*vcpu, gpa_t gpa)
>>  	 */
>>  	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
>>  		return;
>> +	kvm_release_page_clean(page);
>>
>>  	read_lock(&kvm->mmu_lock);
>>  	/*
>> @@ -4076,8 +4077,6 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu =
*vcpu, gpa_t gpa)
>>  	else
>>  		svm->vmcb->control.vmsa_pa =3D pfn_to_hpa(pfn);
>>  	read_unlock(&kvm->mmu_lock);
>> -
>> -	kvm_release_page_clean(page);
>>  }
>
> [Severity: Critical]
> This is a pre-existing issue, but can this allow a malicious guest to
> cause a host kernel panic?
>
> Looking at sev_gmem_make_shared() in arch/x86/kvm/svm/sev.c:
>
> arch/x86/kvm/svm/sev.c:sev_gmem_make_shared() {
>     ...
> 		rc =3D rmp_make_shared(pfn, use_2m_update ? PG_LEVEL_2M : PG_LEVEL_4K);
> 		if (WARN_ONCE(rc, "SEV: Failed to update RMP entry for PFN 0x%llx error=
 %d\n",
> 			      pfn, rc))
> 			goto next_pfn;
>     ...
> }
>
> If an untrusted SEV-SNP guest modifies a guest_memfd page state to VMSA
> using RMPADJUST, and the page is subsequently freed, rmp_make_shared()
> will architecturally fail on the VMSA page.
>

I need some help with this one.

For the initial VMSA page, IIUC snp_safe_alloc_page() gets a
non-guest_memfd page. This won't ever go through sev_gmem_make_shared(),
so we're good. snp_leak_pages() doesn't actually leak pages, it just
tracks leaked pages, but __free_page() is skipped so the page is really
leaked.

> Because the error is bypassed without calling snp_leak_pages(), the
> firmware-owned page is returned to the host page allocator.
>

For guest-provided VMSA pages, those can be guest_memfd pages. The
refcount taken is the one guest_memfd holds. Without considering
conversions, just considering truncation, sev_gmem_make_shared() is
called from kvm_gmem_free_folio(). Sashiko is saying that
rmp_make_shared() will fail, and the folio is freed.

Sounds like this would be a problem if the folio is used elsewhere...?

> Could this lead to an RMP violation and a host kernel panic when the host
> later attempts to access the freed page?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-gmem-no-=
return-page-v2-0-5298f42d49bb@google.com?part=3D3
