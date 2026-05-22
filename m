Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DEE277026
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779476652; cv=pass; b=JS8K0sJGfydFCavucJp+X2GaHq6KQnT0j4KxcGkyrcOOqaQA5HLmvpHruwFm5cTatKa81AuBjlUo1hSNbu50Pg2KAMysWl6JCr/TAiJVZWc74fKqpNrsgsCcakC9kuGLiymAit2deXkAOz8Z/h80u9hhW5t2m4jU+SXs5M4txL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779476652; c=relaxed/simple;
	bh=8girElLKDDbdH3u3t1ra9Bb+bSVC/vxxK1ijFpwESFU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNakU/EGRVFKuyKHUlhx7kgSU+SNw7MYPt5X7jZuV6zphnL6fCxQ/wYDrFxsxh2MqrJCRZyC2yq53PIB2D7zUp/R1/2G3ZsHJf08mxc2G3wXJLVNuV6fhuzleCrpSnDr/cKcQPI5X92/7WB1+c8eK/y8fHB8kaXr+Jwix2mx0kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gfU5ulXa; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gfU5ulXa"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-94e2ad66abcso2441479241.1
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 12:04:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779476649; cv=none;
        d=google.com; s=arc-20240605;
        b=iqUZta6qYaDnsJ7qBQ4NDSyHo5aI2CtTCPlFcd9DPO2fn8AOorUIXccsK/WT+2WkBo
         HSWgVldptclajM4eV6k3PxaVa72SzZU25ka2kiUM4nS2mPyiDShctMsmZikOfryoiKI7
         8Tn6L5pcyjcDniiGK9Qxzz08Yg2K5kq8yQzawtM3oAw60TIczNQJtiibYIpBLD0dQKIA
         EuCGOnTT9Zome0f8kEYlRSO03onCCaNIHUvZ39STZbAcEv+dCJ5zxgJb4U2/Q5JXsjt5
         a3h68mfzvsUtzf2YVPFTFIxfThca6+hW1cn0coMog0N8hHA8212yln+IBnVY+9Q/1xPV
         DAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=brW7UeKFZ/7/NrcHA0OD14WL8ph3oRlKy3KH21ODKrQ=;
        fh=n/xVjRsPLSx48DK0mlLV8S98n4Bay9rv1xBpMnS6M6Y=;
        b=gY3lPkCW5/WfrtXiB1JfjUtjGXRWzgiPkPIQMCj/3fqI/MZqFA1YC17FteVR1gv6CI
         1gWsB+d89RwYoyHhRwHGMSddsBGkjhORmeud8rzyNNM1Gc5jQ8k1rD6zBcw/m6GON+gW
         GMXIVkuBBpCXePVyUQ+zu7WW0cm03c+Jd5WWmgawwmF+HRZuOtFqaoy/3r3GrsolpQyB
         dXtu+2qa9G7aDvhW80eq6M9BBGpHTAk6aYqJCxItxqnAHNg5v7U14Whhl6uFGm4bDfwd
         gXlAWs/QJ6BKLkqSwN+c/lEMJn0syf84Yi+GuWffLP+M4wRwG8LndZ5zBvhjNOUFO774
         PQMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779476649; x=1780081449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brW7UeKFZ/7/NrcHA0OD14WL8ph3oRlKy3KH21ODKrQ=;
        b=gfU5ulXaoERP18bqC7I20+P6wgl0IumWG5nVTE0KcW1J7Z2sh6/UDDsJireaBB9h+A
         BQNLsNeTk1SnpwhTAInyUx/SHVTwWA87MVcydn1rWa2htl5t97J7XCClcw8fhVrZ7MDc
         q21uxKPvNQuV1KFp32JY2XnEgDOtk4sKIwnolzOC6E4d+kXAr/qKNNr/42PTYcgap021
         0qiK3l/3MtVZp99pO1TA8KZJqif+5hinZzNcg8pROrNZ+x3ec6nR9mrYd62b9zha0Lz3
         JXUWrB+FYB2EKWa6gHhoGqOa/LWzI8lOBlM56tUdpdI0S7XwmPjRg1BMfFjsb/9HAdxW
         x+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779476649; x=1780081449;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=brW7UeKFZ/7/NrcHA0OD14WL8ph3oRlKy3KH21ODKrQ=;
        b=iXL6ZAoAlQR+++dQg+AiY82W2XsvqAZ6n4Jan+OlEI4vy3M5NsrzsmA+uy27Q/Ufs0
         2lHbqW3WSAojnqL5JGt6AjuSzNEppMA5ysr0ZYHEnbiA5bioehJiJOsvD3NkQRQjZnXa
         WsHL0hAtz6bd/hp28lxIiEcg01U0K0Sjx0Wh/HSvKBWkmwZIO4y+8LuI3inaHg/gR+He
         PxnLFBdmYIQEiM76XBLLCK2jp1xFBOd+4UPZ5ynohYvdeX/pcpjF3LEBK3uKweTUu7U1
         LnxN8vK/BHf6foIHcIW/AzK+0Or6pVOpfLAbtGnaFxh17+rl799k4sYlDqsHijYnVoY0
         bEbA==
X-Gm-Message-State: AOJu0Yz0/ymP5bdccxuQkE9XCOAW4l+d+fVEMhQnjp/3ZT9yBiCreWUx
	g1vVHs/kpTCKKd0nX4BS4to5dskjymH7pZcDKxchXBKti9mxXTL4gZYQcKLvpnxtnT3sdmj1ZF4
	Z5D5vTS1wnd5Btsp69Ik7KE62bl6sMl77TDdEAEmHi5j9Ad3U1poXDaoty6E=
X-Gm-Gg: Acq92OESDLwcsngKkfHtTLz5/iesm+8otXNR9lXUvEktnrA91YO3xluWMK36vLzKsLr
	XRPA1AYFAQ7Lmth2pjMd1AExzL0uY2b5dBIDBFJ1dCqyNaB/C3JQGTx1xjQ4DTEt4ahwWnCV0t0
	OILrfPqlGSKt+jba1bAW/nyh663xCW1OXfgUTVRW2+5f+FPFSkA3VeZeMPkb8xZYESvpl5h5AyF
	RnSoAMXQbDX4uYv05a7+MnZ8wDTDrNgPXvWa+nOVncOk/CIsu9aWhmvDIjEaj1hZO6kWI/H4Hgp
	ftFoh7TWD1m290sAk200rmHBYv9iq31RUWP5mWq1YfoZZ+RPslZkCM1gAmjh37D3OGUGx006eiq
	y/cuK
X-Received: by 2002:a05:6102:3f08:b0:631:4d87:ba5f with SMTP id
 ada2fe7eead31-67c7490af39mr2616867137.3.1779476648412; Fri, 22 May 2026
 12:04:08 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 May 2026 12:04:07 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 May 2026 12:04:07 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260522180530.EE9101F00A3E@smtp.kernel.org>
References: <20260522172151.3530267-2-seanjc@google.com> <20260522180530.EE9101F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 22 May 2026 12:04:07 -0700
X-Gm-Features: AVHnY4Lmf_9WM9qkGgAhMkcUeOb04XWn-O2dClUcD1FrCa5bUWoqHcEIUbU0eT0
Message-ID: <CAEvNRgGZBrTjgVg1Xk-5mhxMnUWbS79FjdGc+O6NTQyJeEVtyg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] KVM: guest_memfd: Return -EEXIST for overlapping bindings
To: sashiko-reviews@lists.linux.dev, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] The return value of xa_store_range() is ignored in kvm_gmem_bind=
(), masking memory allocation failures and leading to a Use-After-Free vuln=
erability.
> - [High] A signed integer overflow in the file size bounds check inside k=
vm_gmem_bind() allows userspace to map memslots beyond the allocated size o=
f the guest_memfd.
> --
>
> commit 7edaac3f2255cc17c741557ce1e44f51d4cece29
> Author: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>
>
> KVM: guest_memfd: Return -EEXIST for overlapping bindings
>
> This patch updates the KVM_SET_USER_MEMORY_REGION2 ioctl to return -EEXIS=
T
> instead of -EINVAL when a guest_memfd range overlaps an existing binding.
> This aligns the error reporting with overlapping GPA memslots.
>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index 69c9d6d546b28..46727539d08ac 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -675,6 +675,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory=
_slot *slot,
>>
>>  	if (!xa_empty(&f->bindings) &&
>>  	    xa_find(&f->bindings, &start, end - 1, XA_PRESENT)) {
>> +		r =3D -EEXIST;
>
> [Severity: High]
> This isn't a bug introduced by this patch, but looking at the bounds chec=
k
> earlier in kvm_gmem_bind():
>
>     if (offset < 0 || !PAGE_ALIGNED(offset) ||
>         offset + size > i_size_read(inode))
>         goto err;
>
> Are these variables susceptible to a signed integer overflow?
>
> Both offset and size are evaluated as loff_t values. If userspace provide=
s an
> offset close to the signed 64-bit maximum, adding size could wrap around =
to a
> negative value.
>
> Would this cause the offset + size > i_size_read(inode) condition to bypa=
ss
> the file size limits and allow the guest to map memslots beyond the alloc=
ated
> size?
>

This was also discussed in [1]. I'll send Sean's suggested fix for this.

[1] https://lore.kernel.org/all/ag8BmtzxTlcuA_zy@google.com/

>
> [Severity: High]
> This is also a pre-existing issue, but I noticed the return value of
> xa_store_range() isn't checked later in kvm_gmem_bind():
>
>     xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
>     filemap_invalidate_unlock(inode->i_mapping);
>
> If memory allocation fails and xa_store_range() returns an error pointer,
> does the memslot get omitted from f->bindings while kvm_gmem_bind() still
> proceeds as if it was successful?
>

Will send a fix for this too.

> When the guest_memfd is closed, kvm_gmem_release() nullifies active bindi=
ngs
> but would miss this omitted slot, leaving slot->gmem.file set while the V=
FS
> frees the underlying file.
>
> Later, when the VM is destroyed, could kvm_gmem_unbind() attempting to
> access the memslot's file via get_file_active() trigger a use-after-free?
>
>>  		filemap_invalidate_unlock(inode->i_mapping);
>>  		goto err;
>>  	}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522172151.35=
30267-1-seanjc@google.com?part=3D1
