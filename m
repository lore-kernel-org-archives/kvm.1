Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7245731E850
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 23:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779924705; cv=pass; b=JLaSUrE+CkL3CSkWB3drrS3aUXtCwXYVYzV9W+QUyvRBUtVUScDj4oN7CkrIy4YqzeCTfoDbQviI7FJHOYak6dj+h9LaTC6iY4EEDL6hG/6nTXzYVZBLh3v/zsaPPmO1iRmb/98eQWkPUv6XCUq6lBIyfZJKvPLrcukUfUXX3Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779924705; c=relaxed/simple;
	bh=FY5kRXN4HxQf8uvWx/WNrgDa70/IQkpHxs2C5AfvEZA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iqWlHszWQTj/mkIPPNl416yk8nZmNJgX+gledh0m4r0ALQdHjxV9mICsZtt7C/5lLqIMIPSDf3YPmiS/CLO7X46G7YaWdAqPY5rDUUE022O2EFcWC1GQ58E7cvekeHER1q5zON2Kxz4rAVp0WJIFWvZ36nrXgoVV6ienyPvqR9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KcfT8xG0; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KcfT8xG0"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1334825de43so10857501c88.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 16:31:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779924704; cv=none;
        d=google.com; s=arc-20240605;
        b=YWF7Cj8YHZqtg4LisZP8o6Oa6S1c5f8GHzceKP49J141Hu8A5nvovvW1Ty5UismCIL
         TxhXTnMWT4EYo0xAskX3pbPXVNna1PbSkPl64QfAlXEr+0rqy3WcZsB8Lg+cXdqJqQox
         5u/q/bfwCAUSjtdlZhqT9YnONBHevQB8oL49Dcu7sKxASCADGvLgcq4918le95Izn54e
         3WuLBNcNV7xmoh/c8JG/FBHYa4DZNbilG7uJBrqF5C131I2KT6BA3CXokMdqoVUTQ2tm
         5ZHDsFS8+0FufKiHKfUH7RzfAXQMwqfWWYnqWgfiHwyR8j/nlW6mtMelH9Tj+qrWbgeN
         LfKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=Obtu6u3O3o/o4dgX8LFuxYSOq09LDgKPPUPR2GIgz6M=;
        fh=KVy4+j+TE0qJlGnL1oxDtQvAs+ZlkPteDJwxhHS2piY=;
        b=KphiJc2BVkEqb0Ks8fLaoveYwWVSxJ8m21u+lfH/2UeDSbV3zAOeuoAfzQOd5wzeNB
         0Lb3jsQq8NDT9ZXYM6pEH/h73iFQqKiZnP57svLF8TtEC5vqhOHOq6X/A1HyCfw5flMz
         Uzc5b3qNeQk11eLhkgBJbRlNCDrPQlqQzSMKk9anvh5tBVh/JZUphfW+itJO+Lv1iGdF
         iXg4eoBrEFW3SaleW0wFQMFGR3NkMAjmibCH9b2ClOqmVjNgLTsjHeVTwmZvxZ2d6SMH
         jEnOcNx3MWFhCQ8IYL3GG+gf/zHZ6No1yaHidLYG4aTKr4BHSFvsbsz3Jfrnq1CVZm23
         sn4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779924704; x=1780529504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Obtu6u3O3o/o4dgX8LFuxYSOq09LDgKPPUPR2GIgz6M=;
        b=KcfT8xG0Npxjt3pj6p8A9699Q7rplgme6gios85yfh6+s8qBtXILxoEVGgWWPS2bvo
         yQCZJU4LUc3OKdA7ELvza707f57LsKFp/o65N8QnSLcA8l09zrhC+lAqvk50/NMLk0sq
         9hm/DSkzWodoISGcbrMG1BKmHYUWONdk4U+kJgLpUKv8DTMHO6VJHBfd8NTMJr9EgfEp
         b7+HdWH3eaLWYtRUTVbG6KMnTPQCr8WcNwz07yS2WRKJGGLuav4i8rUrVDlPFAT5ZfXd
         L0k6h5slc9FMAwMdXAJ+Fuiq61YfGj/5/8Tcd7vWM+YvMQSs7dGfNLFk+6PouXC7DEO7
         nM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779924704; x=1780529504;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Obtu6u3O3o/o4dgX8LFuxYSOq09LDgKPPUPR2GIgz6M=;
        b=RgbqTL73Ygo86a/XSovkB+kkMi5fYeVdjAWf8SUE4u/QE/nOP6JjipNTKu5SEsoSRk
         nvtN5k8G1n/Y4S9xXwDZqtdxQgMgzk8+a5O6vDOAL2JzjqVzjHERr31msopYrgoWiEfH
         O5GOyjFNgxPMhN6vCP+Xe+/JMd+WYHAU88YxmtFNb5WltgBt+SVQRgLxaGY09/8zx2sY
         PkAU6a5icY1tzhjQ0vrlWfuP6iVZ4iu1pKRattAh2F5gRs1KEvp4H/D14+OSD1fR5t4d
         f8ECOLOBzwS+I7UBFjQIdxLxb3pozSiRnmv9f7unjqwaFSlWkpKMOoHFV8wmA2+7EpM3
         txXQ==
X-Gm-Message-State: AOJu0YweMBq07jO4WjUErKCxKZNvogglqv4wWpb1yDMxFgxTqAWrVoM4
	cMobx+Y9dUW2B0+Q04F9sRQBjre9FZc+1lrvKlmWPb05dTCiDexCMXPQAmHp9Cj7M+LJDmUPLfI
	lV3uCYc6A8jP83lBYFX6nTLHVXlgDDXks5Ro05I8NX4hyXHIkzBd27lZ0umw=
X-Gm-Gg: Acq92OEvKgzjw74RL2oFEILqy7OwuUT9xALgHubvGm6kUtwZV9FDiWkS352spJr9i8y
	eoIPx+h8AuLudjXJDnjKkE9AkY6XmF4p7dyyfFa+mYgAPDIUb3VwKkucjoyJkKcEvEp/4DLqN1J
	AJwInCXDrW7qS/B4Ln77qag7WqhfijgKxJRr4gRfCc/vjboBeR+fimxBM7C34YVLzMCRnaBGGTF
	ZRXqt/1XpxbKpt39o02eV8XMWVGbBsiAhzpUcIck35g7mvZJBBl388Pxxo51B9ZpBafgMHzv1Hd
	E7N2Cp4X1iJgSHeXpgSFkwkqc1sF/JR3k8syxNMtRzl1tdec2aVl3FoHio/MHuZdL9v0noPYeIO
	8h+c=
X-Received: by 2002:a05:701b:2612:b0:130:73ed:208 with SMTP id
 a92af1059eb24-1365f5f3689mr4745492c88.9.1779924702943; Wed, 27 May 2026
 16:31:42 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 16:31:42 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 May 2026 16:31:42 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260523005532.4D0DE1F000E9@smtp.kernel.org>
References: <20260522-gmem-inplace-conversion-v7-20-2f0fae496530@google.com> <20260523005532.4D0DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 May 2026 16:31:42 -0700
X-Gm-Features: AVHnY4IbNlZ1RTod9euztnDIZ2uULN1-OWvv6seFfFHUYB_hs4gByAgHjLh9_vw
Message-ID: <CAEvNRgH_=OYjJzk9__7nXWvxJS9wZYwy_T+jD9KOYocP_s21Ug@mail.gmail.com>
Subject: Re: [PATCH v7 20/42] KVM: SEV: Make 'uaddr' parameter optional for KVM_SEV_SNP_LAUNCH_UPDATE
To: sashiko-reviews@lists.linux.dev, 
	Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Critical] Missing FOLL_WRITE pin allows unprivileged users to overwrit=
e arbitrary read-only memory globally (Dirty COW style vulnerability) in th=
e CPUID error path.
> - [High] Strict LIFO ordering violation when unmapping local pages via ku=
nmap_local() in sev_gmem_post_populate().
> --
>
> commit feb1b4a1de59f0eb64cbf36005ae06dfcdb9b8de
> Author: Michael Roth <michael.roth@amd.com>
>
> KVM: SEV: Make 'uaddr' parameter optional for KVM_SEV_SNP_LAUNCH_UPDATE
>
> This commit updates KVM_SEV_SNP_LAUNCH_UPDATE to make the uaddr parameter
> optional when vm_memory_attributes=3D0, allowing guest memory to be
> initialized directly from userspace. It enforces non-NULL for
> vm_memory_attributes=3D1 cases and updates the relevant documentation.
>
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index 940b97d4a8523..107c6ee60472c 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>> @@ -2390,7 +2398,7 @@ static int sev_gmem_post_populate(struct kvm *kvm,=
 gfn_t gfn, kvm_pfn_t pfn,
>>  	 */
>>  	if (ret && !snp_page_reclaim(kvm, pfn) &&
>>  	    sev_populate_args->type =3D=3D KVM_SEV_SNP_PAGE_TYPE_CPUID &&
>> -	    sev_populate_args->fw_error =3D=3D SEV_RET_INVALID_PARAM) {
>> +	    sev_populate_args->fw_error =3D=3D SEV_RET_INVALID_PARAM && src_pa=
ge) {
>>  		void *src_vaddr =3D kmap_local_page(src_page);
>>  		void *dst_vaddr =3D kmap_local_pfn(pfn);
>
> [Severity: Critical]
> This is a pre-existing issue, but does this write to the source page allo=
w
> unprivileged users to overwrite arbitrary read-only memory globally?
>
> kvm_gmem_populate() calls get_user_pages_fast(uaddr, 1, 0, &src_page) wit=
h
> gup_flags =3D 0, which explicitly does not request FOLL_WRITE.  This mean=
s an
> attacker can pin read-only mapped memory, such as the system global zero
> page or a read-only shared file like /etc/passwd.
>
> If the SEV firmware rejects a CPUID page (SEV_RET_INVALID_PARAM), KVM wil=
l
> attempt to write the expected CPUID values back to the user-provided page=
:
>
> 	void *src_vaddr =3D kmap_local_page(src_page);
> 	void *dst_vaddr =3D kmap_local_pfn(pfn);
>
> 	memcpy(src_vaddr, dst_vaddr, PAGE_SIZE);
>
> Because kmap_local_page() creates a direct or fixmap mapping, it is
> inherently writable and bypasses user-level read-only permissions.  Could
> this allow an unprivileged attacker to map a read-only file, pass it as
> uaddr, intentionally trigger a CPUID validation error, and cause KVM to
> overwrite the physical page globally?
>

Fixed in https://lore.kernel.org/all/20260522-fix-sev-gmem-post-populate-v2=
-1-3f196bfad5a1@google.com/

> [Severity: High]
> This is a pre-existing issue, but is the unmapping order here violating t=
he
> strict LIFO requirement for local page mappings?
>
> The kmap_local_page() and kmap_local_pfn() mappings are created in this
> order:
>
> 	void *src_vaddr =3D kmap_local_page(src_page);
> 	void *dst_vaddr =3D kmap_local_pfn(pfn);
>
> But they are unmapped in the same order:
>
> 	kunmap_local(src_vaddr);
> 	kunmap_local(dst_vaddr);
>
> Unmapping the older mapping (src_vaddr) first causes kmap_local_idx_pop()
> to incorrectly decrement the kmap stack pointer.  This leaves the newer
> mapping active but marks its index as free, which could allow an interrup=
t
> handler to overwrite the active PTE.  Could this also trigger a
> WARN_ON_ONCE in debug builds and crash the kernel if panic_on_warn is
> enabled?
>

Fixed in https://lore.kernel.org/all/20260522-fix-sev-gmem-post-populate-v2=
-4-3f196bfad5a1@google.com/

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522-gmem-inp=
lace-conversion-v7-0-2f0fae496530@google.com?part=3D20
