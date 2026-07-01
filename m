Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EE1431E58
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 20:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936790; cv=pass; b=o0/pGxRMvfgPdObj3d+bj6/DWlnTpWeRfgGGzAOjrj2Uo9AsoXTJwmTXg1xDV8BFJ5ba59Y4vR/yQnAm74WTG3WUKuCwmVMzNHlh/6l+R3PTZ393BqZ/uQcfZN79B4b9xPwjfVOlmk3EWxRK7OeVWqT3sHKYpFqsiy5GIKLRjBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936790; c=relaxed/simple;
	bh=QYLv0iYYfI+40T1vZSVNdGPEoBHxmTYvYlLcxP2K7oY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kz6Waaz8vid7ZrGseJvq0aPP0yWFXWURM6pmYWy0TegcLHV9QIfxH29lrcAGUz4Q+FZ6tUTZqVZYlV9YgGD2CFOM8pnLJjEnuxm10VG2zTV3YqpORh81Fi3dgYr2kiF/MB8RrTeBan9ocWR2mp9sNGD+OB2YtnemRcS6Y2+n240=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mSxCAqek; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mSxCAqek"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c9c1779fc8so5621535ad.3
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 13:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782936788; cv=none;
        d=google.com; s=arc-20260327;
        b=ltvUkuU4a2Rq+U+f09ACv0MrxEhoUEVYoWmDDBVdqEb2c5Xn+bYAZrqB1/OUNElgBx
         4mYAQsdd3av6p3xSwhm0DRrFH+bVfZnXjGFpmT7vp/xKh3qpl/DKgis6zzRb40D+bEf8
         RAKNZV9I8vUeG414Xkh8t3UhTux+IGGCaK3QwfSprolczHecOr4dqgdPasPPeI07X7xW
         mg1h6YM8y3X7XqjLO2LWhxbN6saul3hG5GBS8kRT/V9KDJb+BMeqLLqOFLKKPFFDe5lE
         D6yxmI7oDD1HWiU2e20VLj6Upf3Dc1UDKBZ5PcZDlZHSouKL8RTG3ZBzSWuT3LE8mxs3
         3miA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=3AXD0+6ClJl4llB0fCYUWomrqQGyd9hq9aZAvk5puJQ=;
        fh=n/xVjRsPLSx48DK0mlLV8S98n4Bay9rv1xBpMnS6M6Y=;
        b=m8ljF6NHNF1Bc8dCquitYBBd+yxDDjGkIgSoOwP/DR0KwAnAg5w03QtYf60VooqeAz
         PXOALl4fbtmOukrF7ax7zz/r1k1tXMeK5rDuD36xjPxQxHoCZEpOpJ7myuc+OJtBzjmz
         6xXYPgBpjR5uQ8hl/fAxPQ7QYyKGavgmqWik33pQD64PydxyNR9jnY+ToRyDEfd+YJ+V
         UGt8niOX1nCwgzpJsg3StIsFx1idlXbeuEzZaP1KPgBlKMvwO12dJf2WhQyqyBoHsdaq
         sedf0I8i0Eo8LNbS2jTl6Q3Gklkq993pLgmZx/xMEpaD08P7y2AY6l7uY4rcAN9ebDjn
         l6+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782936788; x=1783541588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AXD0+6ClJl4llB0fCYUWomrqQGyd9hq9aZAvk5puJQ=;
        b=mSxCAqekI1XrjJHrzoP8eSC9O+R0N6GXqVABv0wyFdK/+szhf/d2mHQ7pOokHIMXya
         w4PNJtyfQ5fgLBFs1BpET3PXVowsfVs3O0LN2893F8E6+kuLPx9G+y6Tw512cU5tUj8F
         7e1H/W4stjrGVbKYX8+m8RmJ9eqD25/PpLKMNo7nqygzdIALs9tId12G0oD8u8EQfd9t
         A9MupTeRpczebwbM74almVtJq1b09NlzQBC4O6RfniXD3R2YU7HcS7L+LrKfI8oHYH6Z
         r8Hbh8fEOgAuTYXDs2h2E4Ycoh4daHeHn8GG3VSQlUr6X/v+ReL0rvjCkbCl9JZCmbLo
         95uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782936788; x=1783541588;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3AXD0+6ClJl4llB0fCYUWomrqQGyd9hq9aZAvk5puJQ=;
        b=Pl5qtweLYK/hIu/viRtcXAib5NkC3wjstrmTIGA1ZHFksofAwUy0I6eYr/eS9EAbw1
         HgPOlo2HomjwHuHetzPEI0AFKbshDvzRR76RKCn3hoQ+IAvHbyuc0PHWT/3d+qJv5LtH
         dRr9XfIk1W4L5tT0kntBUwSSTuTaDT3omUhKBnge8LUGVTeOFtaNZXDWIgpjCIoTlatC
         IRSlD1zapAS/66k+VHSjUO94o8dsePn644sttABlSS5PdaC0BehC5/0J7eK5XszQ0esu
         6DK2dprVbR4dEdW4peXfOAXuNW9Zz2+x/bRb7CmqJoI6j/CCAFcfH5tXfDJgSJe/0p5g
         vKBQ==
X-Gm-Message-State: AOJu0Yy/as2nGOEcha0Of0zWFANL7TN3Xx8fWeydx0+NsS6P2iPeMHxC
	Vbo9C89QVGMz2zs3EZlo4UEclpfI5rqbjmw4uh7jO2q4QHD56H5K3Sc0WlnTFGpS/MJiA2vxioi
	G/sDIInxrbtm4WyhrtDp+lIesT3TwcokaO1JGUCMP
X-Gm-Gg: AfdE7cmMrt9ntOzXs6gHEEAH15CE8B6QvRC1fAxyE0+Wqeh3Fp4xwTO6ewiat0+tu/u
	oNebkdgWUfo4u/l/mzb794pdA7tNvIgxQ/SOd2ojCZsQQvMAtGMHz9CPACdiEFx8ufvujVuBSZZ
	QouAYyZArPkQQUBI5hs2aDTxbfTYsBKD9P2Yv075nsr9mHMgzhih2UtyRDJysBXignqj2hxP6Ny
	ArneoXvy4RGEVSVfu3F46jepCYUPRfebgF4+DHqIyl19qa/U/9iE/HTGF8IGKMd7s65IxppnaqX
	xK5UHGNd/Iz/HLbjiivSp5DWebZ/YYgbfAtDCel7iGhU1ywbNKi9DaL0kLU+I0Hac+tGaA==
X-Received: by 2002:a17:903:4587:b0:2c9:cb6f:9015 with SMTP id
 d9443c01a7336-2ca7e8dc783mr36005365ad.23.1782936787655; Wed, 01 Jul 2026
 13:13:07 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Jul 2026 13:13:06 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Jul 2026 13:13:06 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260630214952.98C851F000E9@smtp.kernel.org>
References: <20260630213711.479692-1-seanjc@google.com> <20260630213711.479692-3-seanjc@google.com>
 <20260630214952.98C851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 1 Jul 2026 13:13:06 -0700
X-Gm-Features: AVVi8CfKCFCsyWj4WpGKcapP9PT26PoMuulY8DcRLm30JnBcfaWZumZ43V66etU
Message-ID: <CAEvNRgHt1F28iDegRxtYDfy95iQysLkFW=7YPruwky_stf5TLA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] KVM: TDX: Return EINVAL, not EOPNOTSUPP, for NULL
 INIT_MEM_REGION source
To: sashiko-reviews@lists.linux.dev, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] The `region.nr_pages << PAGE_SHIFT` calculation can overflow a 6=
4-bit integer, bypassing GPA boundary validation and leading to a host deni=
al of service.
> --
>
> commit a54da29c3e4be3226e4ebf9df2f4182c350df998
> Author: Sean Christopherson <seanjc@google.com>
>
> KVM: TDX: Return EINVAL, not EOPNOTSUPP, for NULL INIT_MEM_REGION source
>
> Return EINVAL instead of EOPNOTSUPP if userspace attempts to pass a NULL
> pointer for the source page of INIT_MEM_REGION, so that KVM's ABI is
> consistent between TDX and SNP.
>
>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>> index ffe9d0db58c59..b0ec054732b90 100644
>> --- a/arch/x86/kvm/vmx/tdx.c
>> +++ b/arch/x86/kvm/vmx/tdx.c
>
> [ ... ]
>
>> @@ -3247,8 +3244,8 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcp=
u *vcpu, struct kvm_tdx_cmd *c
>>  	if (copy_from_user(&region, u64_to_user_ptr(cmd->data), sizeof(region)=
))
>>  		return -EFAULT;
>>
>> -	if (!PAGE_ALIGNED(region.source_addr) || !PAGE_ALIGNED(region.gpa) ||
>> -	    !region.nr_pages ||
>> +	if (!PAGE_ALIGNED(region.source_addr) || !region.source_addr ||

Since we're changing this, how about separating/grouping conditions so
that adding validation is clearly different from alignment changes?
Perhaps like

    if (!region.source_addr)
	return -EINVAL;

    if (!PAGE_ALIGNED(region.source_addr) || !PAGE_ALIGNED(region.gpa))
	return -EINVAL;

And this one might need more code if we're fixing the issue Sashiko
pointed out.

    if (overflow)
	return -EINVAL;

>> +	    !PAGE_ALIGNED(region.gpa) || !region.nr_pages ||

Looking at this again, why should region.nr_pages =3D=3D 0 be -EINVAL? Why
not do an early exit and return 0?

>>  	    region.gpa + (region.nr_pages << PAGE_SHIFT) <=3D region.gpa ||
>>  	    !vt_is_tdx_private_gpa(kvm, region.gpa) ||
>>  	    !vt_is_tdx_private_gpa(kvm, region.gpa + (region.nr_pages << PAGE_=
SHIFT) - 1))
>
> [Severity: High]
> This is a pre-existing issue, but in tdx_vcpu_init_mem_region(), does the
> calculation region.nr_pages << PAGE_SHIFT overflow a 64-bit integer?
>

From what I can tell I think this won't cause much damage outside of
this guest, and since INIT_MEM_REGION is called at the start, this
overflow is probably just busywork by the potential attacker, but I
think it's still worth adding an overflow check in case more code gets
added that could actually cause issues in future.

> If userspace calls KVM_TDX_INIT_MEM_REGION with region.nr_pages set to a
> value where the top 12 bits are non-zero (e.g., (1ULL << 52) + 1), the le=
ft
> shift by PAGE_SHIFT discards the top 12 bits, evaluating to a small value=
.
>
> Does this allow a malicious host userspace to bypass the overflow check
> region.gpa + (region.nr_pages << PAGE_SHIFT) <=3D region.gpa and the
> vt_is_tdx_private_gpa bounds check?
>
> If bypassed, the while loop would then iterate based on the large un-shif=
ted
> region.nr_pages value. If a guest_memfd is mapped at a shared GPA and
> initialization is started just before it, the loop could incrementally wa=
lk
> into the shared GPA space.
>
> Since KVM invokes tdh_mr_extend on that shared GPA, which the TDX module
> rejects, could this trigger KVM's TDX_BUG_ON_2 and cause a host denial of
> service?

TDX_BUG_ON_2 is not a BUG_ON and won't take down the host.

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630213711.47=
9692-1-seanjc@google.com?part=3D2

Not a huge deal if we just go ahead with this change, thanks for moving
this check up front ahead of calling kvm_gmem_populate()!

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
