Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792586913;
	b=UIKCSVx9vdW+z7tot4DhbrP8CzSYVuMtI1q/truUUNKHHZ7MRnj8uD0AA6WKmOvCXyUw
	 MH1pj59H4w3hqFkdnksPemBPXclPJh6z/GqAZ5Nq/Nm0alJ0/wxL8n8+qiblYnJbyHkL/
	 ttJKHUQm69bz5oLDjFfYhGu0Kk4FECW1qMTxUrG9qLwZKLxxEHQlsC+C1lUnWcNt4aDhc
	 Xz2Nm9g4MY8RTwI7xI0t2KrMgTK2mJt/0S/SF9zsLY3zGskrbp/ZZIQ849wziWDuIznw1
	 BsGOcEpT4w9T4nCrIzWj/Ur7onlUG7MNBHhbHci4GYhzg0+ojyVhlFYYJIQoF3UBAHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586913;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=jUm/2BR6ze1rcECKH1J15rNzpuOX+gPscXt8OLTMYMc=;
	b=lXsqe6y2/JIQFPwm2RT067legWcCggGwxTafp0qQSW3OtffqeLXldOfm05FSLC95qqd1
	 YRwEgjeuphL1nA/ExhRFcWW7ii3OT/EbXLTv5hTjmU6YDuU+wbGUxhvydHhoqnX2FK/Vo
	 D+w/iahSo6HEZhNQPQPUHGf85RHp0t2aLdcBnx8GwPOeACue8gkor+4NiyFodgsK+sIYl
	 TNg9vtx80jsX9PRPOD4cVJd64WBKl1rjqQBUklNZ8gshDciwET0o+MJ6lJZBMV0hbieD7
	 UL9nKr+DfdcZPVSjP4I5yfvhDKZKEe/QAChquk4Rjmig7QQyf0J9eZeJlxBvoCKsJ1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Soe0+LCc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418B9606A328
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 12:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 418B9606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Soe0+LCc
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91bbce8b00cso17286076d6.1
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 05:48:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792586912; cv=none;
        d=google.com; s=arc-20260327;
        b=ejErjtNGNcrZfdYm2RXKK6tm9qmxDAQNCoec+NFwG5f8SopSprAy3r80I1kjhqW/C6
         93LvsXj89kfzlOjcW4XrJvwrsBj0BchmchSYsyEES8v2hKZbb6W+P17n4KLj8mTQq8fo
         SKnCarBxr2mLOA4h4ALCvqMagQDqHtXWcWOZXtp2v+6SeKpihESmelCTlcrSoTEIPv77
         2ZXkH2mcwn4DOTJHieBR0dVz97I0B5ICcfdxlL/TgFpAnnKG9DdT4+XRCOLwyfX1TAGZ
         Bdt/dDdIOUTcvgNR4RBSdq08ohd+/35Q9XdmIP5O09WYTiww9mDr/cw5uBDeyuDOvnzs
         jUMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=jUm/2BR6ze1rcECKH1J15rNzpuOX+gPscXt8OLTMYMc=;
        fh=vTtzhXOmQ7p4RCKWsSZ6qIzZPYOalAlrfQbzG+Gyoo8=;
        b=iiKnhdm5BqfrtSG4p3r0H29xC75tvmd0ijyPUMIzfWU8ifIZh6rGDjbX5lGDxs2Ba6
         gcAMZSZw1TUsg6IAp/fCd/ICG46D45GTuNAkdwHXv5dF7YolxEXavrkvHvOaUCVCmGSD
         8DJ3sOLA/XX+HvMHOBBFDjj0eN0AcjmucVX7Sf9ud0Ps4EiD++/j6qswjxHIhE/E2jpV
         P7I+wWjquUcIHa5oWj0RPGDZG6qOS84unjDB+bYQhxsN8KsT1DAWVlYnIAi++ibitzoV
         QzQPzQp5tY3Lrdp5kiCzwiJ/j0HPxVK0Q85im3R3BqMm5fdVtViR0qleQzMLDDCJVu61
         MK9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792586912; x=1793191712; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jUm/2BR6ze1rcECKH1J15rNzpuOX+gPscXt8OLTMYMc=;
        b=Soe0+LCco3Pw35ipiXqjfCaEI3OPNtN4FImHef2F4TBwHhHt1OPZLaIGg2oLlYR0eX
         GHQYL+ORtH1KKwLeh6zCvzlwOX2ELQEGGfy5PuLOMAvVbYCqUIjAMuy7L/9Q8tnyEGaw
         gcmE9FN2C3ZwkuQVXLnfKLHMPz0c93IoHmQ69SG9F28TB3qxKkD2t7ilDLZjDA77OZmG
         Y4pgvbIN7ULCF7fh3NUZ0hFwmLz0TK7F2FtLXhef+UuUadT46HoDgugfl0binsR+a7Fd
         ATe/jpzKWMldv/C3mpEm8CRURgo906zNu4VbGhwNUkXLmravANdGrJqJ6Mw419nbOkZR
         NTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792586912; x=1793191712;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jUm/2BR6ze1rcECKH1J15rNzpuOX+gPscXt8OLTMYMc=;
        b=EN8sDdIFHqnJ0opCDs8D0ue7Tp4b+WTBAIHHuRHnrgYHQPJIirVMLhXL/sieA5az/D
         iRsZyNSmWxqU0n2dxNL7P1UoxeiSdSg9NLDcXoDQJM3sZkSFhR0WPLaMutxuElUtRyD+
         i29ULYmwKj79I/603Ra7shY0CKzR0K2I+MsQCRaUiVN6Oq1mjE7NMMJfU46kzryyDwrF
         ReMQu/tiUH6qSUm53o+TrodxygbM6vb9OC9QaaE/S7hBVnqozpLcx2yEbPuZCHKggQBJ
         2X7vxlt9Aw305JxvYENADisSl2s8P07X2FsAjP0rJu2K20H3sMZ/u5wBjvvtNnVj1NuO
         fuJQ==
X-Forwarded-Encrypted: i=1; AKwUvByD8Xpi3M0puEutHBSqN7CmRgVI3msfxDK6bAcAth9vaUj0gfaffPL9jt5Lqm6tSAt/HjY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLaiBJUrBIqhP2AqX+oKxBOzu27BlkeoPQReyMKIHclQQNl9Cwy
	MO8TR4LpOAFD1ZG7fSVR6jnszsq4hqkp7PLI/GWkIbcFqPtzGF91eEsHr9JrImNzDlmVDDEhPXW
	FMFZ02RrsvUelZQgPQ5/4IC2GwjNLUrC9rOpLTRak
X-Gm-Gg: AYBFou3Ynu4kb4wSu8O3OAwPUl4+zWc9vpMZHH6xzV+Xxp4bNz+GUbUIPr+oF4S2qk0
	FWU6ezD4UpPr2ylhuzNrvUVgqBgvMjQy0BOOQocBPZ7MgPvTQjnTfq6Fdjf3bNWFWjTSlptZJa6
	OF12I5nyjiRvD6g+bsh+KnbyWIo71WUvodS7YCI+PjkE96hofcw1LN7gsLRR9HQw5dGPOruqEE5
	+kFLeClWgecT3KxW1e0UEkclzddPHKdvjXZ9S7TbABqCD1D95DUEwow/k+/63Iq5TOV/uBh/0NU
	njpyiVvGiHxzirh8Hz22+0gADNp2J3FECc7qlJomXgGsGCjYnG+1UwfGgFE5tqCYrsu/qz2scZ/
	nPC/iV64/heRCnoWVCMP2gaKx3PDBpAGbFQ4RKF+tZfrTAD6VwDnx+CXU6bLGRIkdiuInYns14L
	HWiA22rQ4Mrvj+
X-Received: by 2002:a05:6214:4589:b0:917:a1d0:890c with SMTP id
 6a1803df08f44-91c056b270amr87924726d6.17.1792586911258; Wed, 21 Oct 2026
 05:48:31 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 05:48:30 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 05:48:30 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261020131447.122096-2-pbonzini@redhat.com>
References: <20261020131447.122096-1-pbonzini@redhat.com> <20261020131447.122096-2-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 21 Oct 2026 05:48:30 -0700
X-Gm-Features: AclHuK_Dm1J20mdRZ_zyhTFrFUGVGiUQEI63SZVUaH4uZSxjd5cCfTtyvwhdhPw
Message-ID: <CAEvNRgF89=xb2t1xAOLZJAE68CuSDW0asYh4n3karuffsnrfdg@mail.gmail.com>
Subject: Re: [PATCH 1/3] KVM: split CONFIG_KVM_PRIVATE_MEMATTR_VM out of KVM_VM_MEMORY_ATTRIBUTES
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Fuad Tabba <tabba@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Shivank Garg <shivankg@amd.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Paolo Bonzini <pbonzini@redhat.com> writes:

> With Linux 7.4 the "private" memory attribute was moved from the VM
> to the individual guest_memfd file descriptor.  The old semantics are
> available for backwards compatibility via CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
>
> However, this ties support for VM memory attributes entirely to
> a backwards compatibility symbol, which is a problem when adding
> VM memory attributes other than PRIVATE.  Thus, make
> CONFIG_KVM_VM_MEMORY_ATTRIBUTES the equivalent of the old
> CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES, and use a more descriptive name
> for the private memory attribute.

I see this fits into your other work on adding other VM attributes. I
thought the plan was to do something like this when the other VM
attributes get added back.

> Do this now, instead of waiting
> for more attributes to come, before distros start adjusting
> their build configuration.

This is a good point though.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> [...snip...]
>
