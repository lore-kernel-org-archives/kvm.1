Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B2B3B71D2
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787212390; cv=pass; b=k2pUUQcV5eGdXipQvqQfoLD7y5CXTw889fbF1HBzQfqd+n7TGnbc+TPTrfh4io69X+tI1FIk8EkK9f24hFQsEG/ISW/V53rssFxMbn0II8gh9RpwQE9a+I7lQulvESOFtMmvdPnKCQ5D1ftTjyGugfzX7hBGj+UlZOHKbrHQPgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787212390; c=relaxed/simple;
	bh=3ux/9MYCmRGaVF+WTBt5CVZosKYLKPfKOqqlr1ELLVA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAMRnC33UAWVocBNkjF3u/RVTQfLXH83kNuSGZnXUar5DrbZxcoWPxS/ALXz/0uDFwUlLLjvk2PLxDpWzCNI5cWUSGvO1jW1Lbi2+4c9iLOQvArQ85tRe3+fqXyzMlOlbKKgXAnl5erYp8eKFd2JdpLMC3j21+QZ0XmyzmK8XME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NjN0O+TT; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NjN0O+TT"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8eeadbc5e21so13164366d6.3
        for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 00:53:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787212388; cv=none;
        d=google.com; s=arc-20260327;
        b=Fakc4l1WS38hGIJULI3etYPysi2G7I2bRfcQt7S3H8HRV9SPTtcpazPN4gUhD+Rxzr
         7SY1bvTngHscDs5bX0ny5uzfJuk9a9blpc9l3SOnyWgDgIz002USzhF6NMguDGGPcUtO
         2KWst/sOgPI8BvR1kVOZtMnU2V1iDis/0w3Ce0DCZtzNy/JZhbIUo+y4F12mvOu+dpGc
         WpJgqsfx3Ecv9hxb8IW8idBnCnY+2hu1KiYy1UK/CHdrEl9lJ911K1TysySjUpggIt72
         2cfXBCrhPGN15VxYJvejoO8OsBQYOT5POcdkyQrNlho1kfEg1pwpEBTGL3UtEj63JyrV
         DCCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=o51BoL0uW8eYgVaNnvAPkhpysbo2+k4CgPomgwBCyNM=;
        fh=FaR8uonaqQfItsbsoAqPoAk4hogGVantJEjby+kDpjI=;
        b=FfyyfxDArQHYgoKmPnXDJ2C2GSO7JuUzGdKd7OqnrW27U3GpBJMVTVfMBJBRYFzBy8
         q/+UlyGxh/ajQvu9b0QaGlKIieHfZepbrvzD+Oa/bBiRvzk2Sx48ld7LeUvP4uGxPrK0
         gmTaYJNFpyC0uQDEwCo0Nd4BS4ego8kraNRPDG5/tDLNVPQKprXioO2FZTYNqT+1tm4q
         B6G0GVkdTdivezCwMXaHIHE7bMhg1N1tDi1kz0Ur5VLYul/K3UNsyHyrasA5p8qFpQry
         s2D5CocM8qr6d4shbThNWTCzBSKLc68dbZYYRjLNz/DqV89cApAtXZHTs/3VNKYuO4ku
         rzhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787212388; x=1787817188; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o51BoL0uW8eYgVaNnvAPkhpysbo2+k4CgPomgwBCyNM=;
        b=NjN0O+TTEDTJ0PGGlUZ02xxf+U4Bq6oQJTXELM//aGsLJtUt48wdCJi+TEwLI7syZr
         +ApzIzptQet6YxOvzJdql7GdDFBSk07z4ssEFKY8uJ+J9L+v5RMyfS45M9k2+rpAEWjY
         lEhlGubez/kHJcYMgL6T3STkeswGlJDcai26fBRizI1VN52TPdDfdZIl7Gs5RmtXqSQf
         fbiWmkqVyF0iHGNWQfC/Jb+Cyl6tWklLfzF9tr41fVF3q/ljCdtZFNrk3YYvtDONsYUp
         RUMPIaW2Y9NAEOBXEUvFpntpWXr3jl3LomvD/9CTfZ60FVzDhsOFLDPueaz2+xgRTflh
         KcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787212388; x=1787817188;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o51BoL0uW8eYgVaNnvAPkhpysbo2+k4CgPomgwBCyNM=;
        b=Gfb/EusQTKqGpkQuanzUky4pMaXSCwrxGd0c7YPYbrb2G0Wfwa5Vitc5Ezbzwios2m
         nxBtZsk7jMNkXhzHUlETt5PijFAtzGRkKz0dYA4/dB11X/KBMXjYJRNrIXtZXptwTO6d
         zJwgX1ndqXD/aXCxBbgI+5mnoOA0TVUlNdm5qtgXSv57uYc/9JW7iVFgIuLFE5NuT4fQ
         ZAe7aUP+oa3+ZX76ySmyeOA29ac50UAcLsmdnOWzRL7cf5kKMHTc04PDnGISmm/OvoDB
         NOHbBUaCfw1st2v8/J2CDZ44sjak5e/v5LpQ+xA3p1CCltucDVrzv767sCd7YTWUo5de
         nuCw==
X-Forwarded-Encrypted: i=1; AHgh+RqLyGLaHjW8jOolewWeDPS4tBcC8NEP/HpZ/ym8toFwwa6C12Wuc2PiR2Hht/JPp8g08+o=@vger.kernel.org
X-Gm-Message-State: AFuF++lIiKvwmUM8L2Hkys5W1ZHxajUJahSsHgJov977yNbFY2OQVSrg
	vAuXhrbl51WufpOpn8rzmAvnGE72B7sHuMp+h1bhZsjKvn80muMuJ0IwE5gOy8XN89QOLi2Cqdz
	aOx5gnOz+PLG6U3xK7oEy3sep2SLjFcIm2iSD7dEp
X-Gm-Gg: AR+sD11P6UwEVrpZHPJJ6V60D3LBADlRzKqeQRl0+/cWYzRGguqenVv8MBTX5OOyJRy
	eSpKVgdOK6XLFurGsPfe1ku8iUyLnJmUeJ/uowk8pzqzr4wtXDUWUGRQZO0q5UqL4opivWzchyj
	7Pulk2nwGC7cHA4MCzYTpwFcZ3Tft4vzVSuZGRly5chHZdsolPGnft1V6QRsoYNVcSgBTtlEikE
	zrWDjkLXHHzH5jM1yuXb/dCf2KD+L6zplBtQrOfPcDfzvifPTTG9KVBOUSd+/CecdXOiSV2+OXD
	dSeX27NmsEKIHyAcjHO5nVNa4XGeOxemLh27x05sdBHpGRfoOCiiWjmLYPanFBrA2oXnuCMtS5N
	56GwDMws35W/V1gF5F2XmiFCSKHUac77Eglp9FW8PmA==
X-Received: by 2002:a05:6214:4014:b0:90a:804c:325a with SMTP id
 6a1803df08f44-90c5e984419mr106287766d6.13.1787212386932; Thu, 20 Aug 2026
 00:53:06 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 00:53:06 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Aug 2026 00:53:06 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260818092909.DBA151F00A3D@smtp.kernel.org>
References: <20260818-gmem-no-return-page-v2-0-5298f42d49bb@google.com>
 <20260818-gmem-no-return-page-v2-2-5298f42d49bb@google.com> <20260818092909.DBA151F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 20 Aug 2026 00:53:06 -0700
X-Gm-Features: AcwNN1WB-tnpCZT-uPr4BO2Hn9hueJ3F68Yv8vagfQAHyYOSy_v0o3BPhF3IvDw
Message-ID: <CAEvNRgGFy39FmmVQGLc0SZkOGuYg5rXhKd2Ah+FhaSwc13zQVg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] KVM: SEV: Drop page refcount early during RMP
 fault handling
To: sashiko-reviews@lists.linux.dev
Cc: kvmarm@lists.linux.dev, Oliver Upton <oupton@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Dropping the page refcount early introduces a race condition w=
here a concurrent `guest_memfd` invalidation can trigger a false-positive '=
Unexpected RMP fault' kernel warning.
> --
>
> --- Patch [2]: [PATCH v2 2/4] KVM: SEV: Drop page refcount early during R=
MP fault handling ---
> commit 7d0f356d8592ce1804052b0fdb61fccf3a11ecaa
> Author: Sean Christopherson <seanjc@google.com>
>
> KVM: SEV: Drop page refcount early during RMP fault handling
>
> When handling an RMP fault, KVM retrieves the PFN for a private GPA from
> guest_memfd. This patch drops the page reference immediately after retrie=
ving
> the PFN instead of holding it across the entire handler, and adopts the M=
MU
> invalidation protocol to guard committing anything based on the PFN.
>
>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>> index b2738362a928b..b34b11d7f8fad 100644
>> --- a/arch/x86/kvm/svm/sev.c
>> +++ b/arch/x86/kvm/svm/sev.c
>
> [ ... ]
>
>> @@ -5030,18 +5031,22 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu,=
 gpa_t gpa, u64 error_code)
>>  		return;
>>  	}
>>
>> +	mmu_seq =3D kvm->mmu_invalidate_seq;
>> +	smp_rmb();
>> +
>>  	ret =3D kvm_gmem_get_pfn(kvm, slot, gfn, &pfn, &page, &order);
>>  	if (ret) {
>>  		pr_warn_ratelimited("SEV: Unexpected RMP fault, no backing page for p=
rivate GPA 0x%llx\n",
>>  				    gpa);
>>  		return;
>>  	}
>> +	kvm_release_page_unused(page);
>>
>>  	ret =3D snp_lookup_rmpentry(pfn, &assigned, &rmp_level);
>>  	if (ret || !assigned) {
>>  		pr_warn_ratelimited("SEV: Unexpected RMP fault, no assigned RMP entry=
 found for GPA 0x%llx PFN 0x%llx error %d\n",
>>  				    gpa, pfn, ret);
>> -		goto out_no_trace;
>> +		return;
>>  	}
>
> [Severity: Medium]
> Since the page reference is dropped before this lookup in
> sev_handle_rmp_fault(), could a concurrent guest_memfd hole-punch drop
> the file's reference to the page and free it?
>
> If the page is freed, the RMP entry would transition to shared/unassigned=
.
> Could this then cause snp_lookup_rmpentry() to see the page as unassigned
> and incorrectly emit this warning before the mmu_invalidate_retry_gfn()
> check happens?
>

Yes, this can happen. I'll also check for invalidations before
warning in the next revision.

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-gmem-no-=
return-page-v2-0-5298f42d49bb@google.com?part=3D2
