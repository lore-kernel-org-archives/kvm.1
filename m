Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF60453A36
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 23:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788995203; cv=pass; b=qL/v7XGx+kBsd2Sj+8PeSL0b4eb1yv2iKOqa3ruEW/CQ5yPzuwn6lu0snZMu5JRi5PvfWK76PiIgLFARPIfOVDVO3QAXDkxnYpSQdBCtqgRq51UhE9h6hLTntmiiUNxDPEYQ1PEuCd1Un7fsXOAHreeI4L9OYK/0S0PGioFtcZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788995203; c=relaxed/simple;
	bh=PXA3kKi7Ee0Zay0UBDPdPvhhxpS6LS3uNwKL28OZOJo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yzj4DqqS2CBLVHM+BUhaZZOedZ74VpxKADuq7CWd/NUVjQf9z9i5ds8ojKuwoRtSRd94ucn75GDcioetypYwGJxtX7eM4od8ypupSF4kXUM1umWGJDBuV2W4MzvvlrnnxJh+ZxRcGSYJjt3ce9baixcfU+2mfCx+RXjJVs7bwkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r/GEuVUA; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/GEuVUA"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-90cd1012479so3376746d6.1
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 16:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788995196; cv=none;
        d=google.com; s=arc-20260327;
        b=k03U5fVKFKYJkM/LXnrThLsQbKydyxlWFcZudZgRATjmoWG+4A8Nt6cb8OlUohjKCc
         xYQp+d0iiVLwV0nY/PDU71BSZQCejGPON6D8si7CH8od8+9+kGgMpyH+Ujx0Ess4YteF
         6rzaIbP3CiMugJIoY4z7OQgl0aKrQurQU8THZ4xLLe9IuqsBdJggkCKYW2kcoA7dgFy3
         tusQSOjiRn7QtkyJ+fE/Ig0fdXF7KKhP4ch1AHXjghpLN+hD0FDy/QWsqZzfl4BgpTJg
         rlp9Xql/juYgxAf0PqHUp3oXcXPHmy7AuM/2kWZWL9x73DCdzPRiM71jq55avlBAMBzJ
         5xMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=6a2nFlX8sSERnHuhM1FnkE0uqEMFgM8nC5+cN37xiVE=;
        fh=DHABnFZlTkG+J+FiNLWWngVCVb4okTtd9XY1vWFJOMQ=;
        b=qgohXEs/I6rLGBEhjNfQ30NsAs5vlOBbhcSnmF3m3FKqU34zyhBYLbl8Hzwm4872RS
         uBOwMCa6GFyYvCHO5hVOYD3Yo03iMtojjg7B1ltT8A6noQMaoLB6GzYjXlUSxlNCJcVa
         c3bTc93TuuSews2ajmYpz/3mPHCEjwqBJd7ZXZeggGjF2I2gK/GTvOcadtBh0YK8P5Sb
         SdEQXDTmiphzrG/k917KRidq/EDGzvs44Nz/feaflhUF0tRve9Ig/gprmKyBSX8qfXZx
         E/PJTjRna7AiSte7JPw+G0kveNU/4Aft+BS9SUEXV+OKY9+1c8PCGMHjMKffc7+bQP4E
         XECQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788995196; x=1789599996; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6a2nFlX8sSERnHuhM1FnkE0uqEMFgM8nC5+cN37xiVE=;
        b=r/GEuVUAJ1TarwZb5GzWSDbacd43dpFp2R5hAvpZ40Avc+qpOvbZNj1fIueV2bME41
         bHA/4XrWvfSnnkbFJwS/7sEfyxlPskdrGky3IT6t9T36wRciBWef1bb/y2MvAmfGf8pX
         +b5YhFtCVydNWI0CJNr1LuAcS2oJuRdRKU1ToUsT9zT/v2Vzr6INVHmgUQQKpzrXPolt
         Fys0VPNzPxusy0fvncTW+i0knMHb5BS66MyCeJ5vgkqgbDhGwdwMWqJuOcxxfTHiIpVO
         4Y+R+ot26mq9XrGldrQVHWzlCpghsZ8X2hDkgXmZIDfP0xwjSf325bfVlu8yza1beXoW
         +g7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788995196; x=1789599996;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6a2nFlX8sSERnHuhM1FnkE0uqEMFgM8nC5+cN37xiVE=;
        b=RwZyCj5IM2MrTG/8EVdw+BXXuP55bGHAPs5b82oyhHGFW3VUnP2jqtnIRIsbTKyijy
         VEHsKXMBraGuzhylIFAlIjUJBysQ2ezMCXn25J6f06HPtsQiYWgVzEyA/Mho7dOwtPY0
         bcAv9YI1UI2BhZdFfVyvV99tkwoiFSvU7FNbRrxbqtH1FHzVcltVAh9UsPzCr3NcujYh
         QpsKQ9RPMasg0gmwAxWlLPJ95RVRWLHQZOpJvglb5tUvvs46UmAqG4zirCoiKgRV9EsR
         dTkKBXQ5YSWwaKIa0h2UDOnIZKcptRDvaloVa573JhYtqvRicgze9HeO6dwFSpSOaTOR
         l9mg==
X-Forwarded-Encrypted: i=1; AKwUvBzyD4Z2/ve3uougfGtx0QZCv09VxkAmx3drL7X9XcYfqvQKDBdFycGR7Kg8gWMIouQ7HXo=@vger.kernel.org
X-Gm-Message-State: AFuF++nmxQIxtrDQsDNSibiaY3cqEEdYMWd7e/+1HhkCAXabKFqZuQ/5
	DWFZUZrBjUZq2gru8Y9WPnJTihl4xeuIicrqhE4o0WCL2mZC7NEG14+iZw12/ia8LRhiRFUOIZq
	xkP6hpqLPKAsyiAXpmXV07pkk7slpVeeYSSNWcgx7
X-Gm-Gg: AYBFou1APwJrnuFwpmITODtkp9vKKZ6xBpZ8oK+ei7Tcml9vTZLTpVfZ+DHzwLEm/BJ
	etwXyAfdqy/u2VAEIHAEdSQlZCqbydoeeHAhxATiu2c9o3KqVEnJkjcqbnEy9Um374myrttaJnv
	Nm13o+fevv2ZS5tAVZx6H2A3EZkLOmwx1DV49DIzIrEf/8zsDZPKhGI3CivMFUbYULuMO6YL/FJ
	N/AgiPkeID7qEvX57Blj/Fg9RJ+4P1IuTec/kxtfzb+nuGVbsz0jQqhEm+ryHPJQY7FeYZzlrdr
	UCwi0GcFN7zQERE4Bo5bPN9TUwl51mGR+xWzApEzaMamP/bkDZ95fSUZ2E1J1lmYmr2FK1TbFQX
	QPkU5rBU/Eb9H+FLf0VoYfOBjrhiRTON/tM5hqLUG
X-Received: by 2002:a05:6214:4002:b0:910:3923:cc74 with SMTP id
 6a1803df08f44-912029a8b04mr22676616d6.29.1788995194918; Wed, 09 Sep 2026
 16:06:34 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 16:06:34 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 16:06:34 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260904004342.3162959-5-seanjc@google.com>
References: <20260904004342.3162959-1-seanjc@google.com> <20260904004342.3162959-5-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 9 Sep 2026 16:06:34 -0700
X-Gm-Features: AcwNN1VviVuN_OjkC5re9vfGxQgnvDMtDDCsUCi2bL8B0gLdA6pRCDS1jYp_JNo
Message-ID: <CAEvNRgHx8OJ4vJboy_zzwnLQA53AFKt-ehyeZRfYnvv9riMcoQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] KVM: guest_memfd: Drop superfluous WRITE_ONCE()
 when binding a memslot
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Dennis Tighe <dtighe@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Drop the superfluous WRITE_ONCE() when setting a memslot's guest_memfd file
> during initial binding, as the memslot *must* be inactive and unreachable.
> The superfluous WRITE_ONCE() was added by commit 67b43038ce14 ("KVM:
> guest_memfd: Remove RCU-protected attribute from slot->gmem.file") to
> maintain rough "parity" with the existing rcu_assign_pointer(), not
> realizing that the only reason rcu_assign_pointer() was used was to make
> sparse and other checkers happy.
>
> Cc: Yan Zhao <yan.y.zhao@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  virt/kvm/guest_memfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 0b48e9a775aa..6c8df67382fc 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -653,7 +653,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	 * kvm_gmem_bind() must occur on a new memslot.  Because the memslot
>  	 * is not visible yet, kvm_gmem_get_pfn() is guaranteed to see the file.
>  	 */
> -	WRITE_ONCE(slot->gmem.file, file);
> +	slot->gmem.file = file;
>  	slot->gmem.pgoff = start;
>  	if (kvm_gmem_supports_mmap(inode))
>  		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
> --
> 2.55.0.979.g7e5102b832-goog

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
