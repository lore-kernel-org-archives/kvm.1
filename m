Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFDB3C585C
	for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787301843; cv=pass; b=IwiD3dJTc3kqMpgeBQ+LvtIH6lryAFV4MCq/R/ZxucziQ23zHRLuN/zK6o3dipPr1+BiwXxUmWETsaJdZTiKgvLxFyF4SJjWG9r4NaEUpZITjw9SfALRtSawfw5QhxtHZ6XRopHML7svLzVf/RohzB3Wa98X/00UCkjfLVKHXJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787301843; c=relaxed/simple;
	bh=Dk3uUFhv3dR/gphHYnJDcqos93iURHifKDqKE2F8I4Q=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IEqsbdkD0bmxQD9YLjTM7f6U93mWHJQvQaW7af/5q6LYUIF490hZcbQ2IOY0vbnmWCPSED4ilQwOv9PyaqHKfS1co9QhRi0RsJDxwSXd+bij376eMIaFSCPeSqBmy6bcUv5FD5ZwgK1gcLPJClT3ne2tS0v2nNusptgCDhEk5+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pdNrvVM3; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pdNrvVM3"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ef1dc934d1so4354106d6.0
        for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 01:44:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787301840; cv=none;
        d=google.com; s=arc-20260327;
        b=Ji150Iw2eemSPkgWn5+J8FSkbr64KGNgsgxNhxBID7nYAzgoWpqi8q9PrAO7rxI0Lm
         XzYEjb7WnE23WLUaCbWIGWeErcla35SGpJdoBV/wBwe9vhVUZJH2+tXXGj1JuZa+SxAd
         rwVUZzTRUR61unxHuTaOcM+4HCctzwvIFdIHp/bj15l9JeAwVf7CyFIrpOWtwvkoluec
         pgB2EtK3TbBsApNcKEYAVyaH3lomOsoinX1H00UDwRfmr130Hi4Tv5eRxtct+qSaZCiF
         bYy+5jhzHBwegbdpWz0f2PAqfbmnZigU+c7ONXiEFG8f3NTOlRx8dm3FRHybDYq8Io9d
         Q3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=JndCtY/VWXV/rVe0GCCvV63VgHFnqs0KqY0XSxvfZ0s=;
        fh=XIDoCNHFdIDeFUwerKSipFQKr87uoZ+GEWpXa9yNbZI=;
        b=JlRVWE69W8X3yrUkEdudozwKxyPWAFX1TFZj2lYvnl/dT0fU+1hcAhi9STOk716tMF
         CdV3I7L/DHsUkmnsBKsYk2PPyOz/YH4nSA3UElEe3zsA6nmptUTxV+/BE8WsV8F/fulk
         7t35zWzZhyXty2mkg2d9MxQ+AmO5v9SEba6rTDnBP1zkZruwrP4+A7YTNqVaU3lWhlZS
         oxpAk1rIzPt8IbJzwOqJx8a18YAK3C5BTmhGKc0USYRvJ3kJH2MGD7PJiD+JG5JyYnnf
         Domo1yfVOsDjQep18mgXFO4eGZUssdyXxbogrvG2bh69+87v75ZlNjGFpB0iNsJqVM1w
         De8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787301840; x=1787906640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JndCtY/VWXV/rVe0GCCvV63VgHFnqs0KqY0XSxvfZ0s=;
        b=pdNrvVM3Hx1VxUYvG4gunIhdRPLigK9q1VVrETYZb59nO3m+Cac4Tjf83V5etjS1Ux
         uo1Z0DGbUkYxgRbALjt7a5CkZRaFd8/5bU3MNtPslMxpkaSK4WtbykZC96EX/3wPE4Oe
         1tfhet9BvEt0F8RQrIPidCjDpalwTIH2BApNIQ8vAWUgQF7C0U6fs6y6OqeGifu/kN/w
         OE2Ct14NNdiAVnoTLtYq2nnAtY3ok/TqVhfO9QzXyBYFieIRbsUWrCpd05WoPWjFuFFi
         Wu8gWgnpXKs8Rfj7u9LgCWkUIgzvh6FunwVrWjghF+uPchYSUzs95MsEkcCCwb0jBMLw
         5xDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787301840; x=1787906640;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JndCtY/VWXV/rVe0GCCvV63VgHFnqs0KqY0XSxvfZ0s=;
        b=Rx0l5Xt8PbOzUuSbn/05zzqBa74wv/c5NC3cgky1s+1Kf+GdbVbf8u9HOq27445eUw
         yvT6he85EWyfSoU4EkzzuLmS6Jw6JWR5E1fJp8+733eGseHmYO0OQcgoFKP4069cESl0
         ij+EczsnyLwFPnEBxn/EZYpw5x8nj3iHz6kLs77TBBnkC3rJh337FdCrWLcf+i5CcdDO
         a4Fz0PLfeitRUcIEN+Amhh7DmbFdUfnn6/81hWcid9Avejkv8QGdgM9af3Mnw/jP2zLF
         Y4WqT8H/Sa3+aKLbSsWijohA2bXe+H9GY5QWqfttqQH640RNHXKLCdxTH3CkOejbwkha
         vW8A==
X-Forwarded-Encrypted: i=1; AHgh+RoB4EKAOzRJy+61OiEF66WDRYK7ztApXw+dhqnE3+hvAwsnVXtR0jJKkx15ewYWyX+rnAA=@vger.kernel.org
X-Gm-Message-State: AFuF++lLAP6BFv8rMEzb6wbxSOM4CKVBE5qpQsf+rMEJ473KPC1nGVTe
	06iBFyuJwjqwHcfEYD5VYDhpHdhLDvKxrBqSVZEElbMMFMWxi5+FAjErdDdbYFXH697Z7Jj2rjh
	xSeCw42SOnoxsBuj6uR47JkYqqRYv0Y46fAkiIiVd89LsLpt0xhrh4NZx
X-Gm-Gg: AR+sD12ofVctDKjVn6QkSDvYPhetWGQH5J0/OkfJZLeymGJ/w/VG/CHeEWGftlkc+Wr
	wcWf7a6NQvac6elOyoNnrPmIrmeee4uFADN6NaYWHeHjE4XUNKyaONmzPDkYzkSi+ZNPTSu3qPn
	Pr55ABtj15bw4uthSp4NB6/7sTYabU9mj23iIJzp9uhPc/MXU+UbB2WkdXVbaUGAOvIfTDHBcyE
	2WLO+1l+xyiIJ/+5izmtrijabj5uKtNeekmrUVGRQiFLz0iau97tEbWXv++k2Lr8sJYPcP5nwuZ
	n2EA8RrmjPbPB7KJgJnvUtrOi5NgYNiLE8EXuAj7Ajx+RIPdnSP6Bt8zaPu8pX3r/w4vXPZSFEG
	atA==
X-Received: by 2002:a05:6214:390f:b0:8fd:b96d:195b with SMTP id
 6a1803df08f44-90c6abef274mr145111756d6.15.1787301839792; Fri, 21 Aug 2026
 01:43:59 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Aug 2026 01:43:59 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Aug 2026 01:43:59 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CAEvNRgHEVxO+1Mkoc3-c2+qSrKWnD+BDe04NBvuwGU6BL0amzA@mail.gmail.com>
References: <20260818-gmem-no-return-page-v2-0-5298f42d49bb@google.com>
 <20260818-gmem-no-return-page-v2-3-5298f42d49bb@google.com>
 <20260818092717.3F4871F000E9@smtp.kernel.org> <CAEvNRgHEVxO+1Mkoc3-c2+qSrKWnD+BDe04NBvuwGU6BL0amzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Aug 2026 01:43:59 -0700
X-Gm-Features: AcwNN1XQ66q23bW9XbZkGc0EqSHIasNxwr4vfpz_tu-1DEmLtY18ZBr72_AUUzI
Message-ID: <CAEvNRgHX-NebA7z3twusis35E_grJNTrbse7aUZ6+D=qpQn14A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] KVM: SEV: Drop page refcount early in VMSA reload
To: sashiko-reviews@lists.linux.dev
Cc: Oliver Upton <oupton@kernel.org>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ackerley Tng <ackerleytng@google.com> writes:

> sashiko-bot@kernel.org writes:
>
>> Thank you for your contribution! Sashiko AI review found 1 potential iss=
ue(s) to consider:
>>
>> Pre-existing issues:
>> - [Critical] A preexisting vulnerability in `sev_gmem_make_shared` allow=
s a malicious SEV-SNP guest to cause a host kernel panic by transitioning a=
 `guest_memfd` page to VMSA state. When the page is subsequently freed, KVM=
 fails to reclaim it and returns the still-firmware-owned page to the host =
page allocator.
>> --
>>
>> --- Patch [3]: [PATCH v2 3/4] KVM: SEV: Drop page refcount early in VMSA=
 reload ---
>> commit 597ff1c52e82911967f2122ff1d77aa79a4a2d9b
>> Author: Ackerley Tng <ackerleytng@google.com>
>>
>> KVM: SEV: Drop page refcount early in VMSA reload
>>
>> This commit modifies the guest VMSA reload path for SEV-SNP vCPUs to dro=
p
>> the page reference immediately after retrieving the PFN from guest_memfd=
.
>> This avoids holding the reference across MMU lock acquisition and prepar=
es
>> for future changes. The page's presence remains governed by KVM's MMU
>> invalidation protocol.
>>
>>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>>> index b34b11d7f8fad..d3d620bc04dce 100644
>>> --- a/arch/x86/kvm/svm/sev.c
>>> +++ b/arch/x86/kvm/svm/sev.c
>>> @@ -4062,6 +4062,7 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu=
 *vcpu, gpa_t gpa)
>>>  	 */
>>>  	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
>>>  		return;
>>> +	kvm_release_page_clean(page);
>>>
>>>  	read_lock(&kvm->mmu_lock);
>>>  	/*
>>> @@ -4076,8 +4077,6 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu=
 *vcpu, gpa_t gpa)
>>>  	else
>>>  		svm->vmcb->control.vmsa_pa =3D pfn_to_hpa(pfn);
>>>  	read_unlock(&kvm->mmu_lock);
>>> -
>>> -	kvm_release_page_clean(page);
>>>  }
>>
>> [Severity: Critical]
>> This is a pre-existing issue, but can this allow a malicious guest to
>> cause a host kernel panic?
>>
>> Looking at sev_gmem_make_shared() in arch/x86/kvm/svm/sev.c:
>>
>> arch/x86/kvm/svm/sev.c:sev_gmem_make_shared() {
>>     ...
>> 		rc =3D rmp_make_shared(pfn, use_2m_update ? PG_LEVEL_2M : PG_LEVEL_4K)=
;
>> 		if (WARN_ONCE(rc, "SEV: Failed to update RMP entry for PFN 0x%llx erro=
r %d\n",
>> 			      pfn, rc))
>> 			goto next_pfn;
>>     ...
>> }
>>
>> If an untrusted SEV-SNP guest modifies a guest_memfd page state to VMSA
>> using RMPADJUST, and the page is subsequently freed, rmp_make_shared()
>> will architecturally fail on the VMSA page.
>>
>
> I need some help with this one.
>
> For the initial VMSA page, IIUC snp_safe_alloc_page() gets a
> non-guest_memfd page. This won't ever go through sev_gmem_make_shared(),
> so we're good. snp_leak_pages() doesn't actually leak pages, it just
> tracks leaked pages, but __free_page() is skipped so the page is really
> leaked.
>
>> Because the error is bypassed without calling snp_leak_pages(), the
>> firmware-owned page is returned to the host page allocator.
>>
>
> For guest-provided VMSA pages, those can be guest_memfd pages. The
> refcount taken is the one guest_memfd holds. Without considering
> conversions, just considering truncation, sev_gmem_make_shared() is
> called from kvm_gmem_free_folio(). Sashiko is saying that
> rmp_make_shared() will fail, and the folio is freed.
>
> Sounds like this would be a problem if the folio is used elsewhere...?
>

I looked closer, "15.36.12 Running SNP-Active Virtual Machines" in APM
Vol2 says "After a successful VMRUN, the VMCB page, as well as any AVIC
Backing Page and VMSA Page are marked as in-use by hardware, and any
attempt to modify the RMP entries for these pages via instructions like
RMPUPDATE will result in a FAIL_INUSE response. The in-use marking is
automatically cleared by hardware after a #VMEXIT event".

So it's not true that rmp_make_shared() will always fail on a VMSA page,
it's only true if the guest vCPU is running.

RMPADJUST sets up the VMSA page, and telling the host using
SVM_VMGEXIT_AP_CREATE is how the VMSA is set up to be usable. Then, the
other vCPU needs to be started and running, and then:

If the host truncates the VMSA page or host closes the guest_memfd file
containing some other vCPU's VMSA page, sev_gmem_make_shared() on the
VMSA page should fail, but the page is released anyway and we have a
problem.

An unsolicited shared->private conversion is fine since the VMSA page is
already private.

sev_gmem_make_shared() would fail on an unsolicited private->shared
conversion. The RMP entry would still indicate private, and guest_memfd
would track it as shared...? Bad.

I've been trying to write a mini reproducer like a selftest but I've
still not gotten it to work yet. If someone knows there's no issue here
please let me know!

>> Could this lead to an RMP violation and a host kernel panic when the hos=
t
>> later attempts to access the freed page?
>>
>> --
>> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-gmem-no=
-return-page-v2-0-5298f42d49bb@google.com?part=3D3
