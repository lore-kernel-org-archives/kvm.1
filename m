Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5955625E6
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888939; cv=pass; b=buo4O8CU3SI0ti2R6kE0sMtSPTD2yT5wPrqkZ1THiDvps+QSAFezMqWGyRb8OSlVZpFD+78vUHhRzV6Qih0goSO7jfPuzymYpw4N7QOHb4OomoFKMAq4XPCZtxvlStrKVZj4LY9kNPlnuxC2IPgEjGjNDs2PtfOmP1FEaNyH1Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888939; c=relaxed/simple;
	bh=24Lw3GJPsJbT9oeWCVSvPsBKcq5jkT3c/KWBCCdcUwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXM7XZSuABjt/8t7JcAe+zGDioZk2azJEDhbJne9TxE9zMpVA+AT+JgGYToS05SEWrF/yBid1BknC0Wh9KFNmJ0ZXGG59FwY/roDGXz8htjYVsnixr0MIHA8QGavY7wLhmQwwME8kywW2V2lJ9woKuiY2Kuqql//UjBI291gXfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fNk247IM; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fNk247IM"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15e592da74so597257266b.1
        for <kvm@vger.kernel.org>; Tue, 08 Sep 2026 10:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788888934; cv=none;
        d=google.com; s=arc-20260327;
        b=PEw1QbPFPhedJ8tzctUBriZ0R9bwmQxZsGvinO5RF+HAS0vPGuu5Eq4NV+AHaYfaGN
         IGBXAFlGs2PPVpMkG8LFWl57tLn5YBtcFrlFB6F5DTdDvtGlrhwlLZdTbJ8pg00u+xEV
         bsIfDXSPBqHtOHXg2+IuKC9WlbGmldWrIR9wpbF7qiU3EfxVrQ5sWGxMMbe+Zhcqx85k
         W/JD1R4RYzE61f5l3gIQYajf13dyhmuRRev2aGDoADT6HpPI5WlerUYeUD1SnOPneFyg
         Qbg9YAfn54wbZCZv/vLSER0K1COXc0VacEcnng2XLPJS+XAmaYiGeohAH3lRvMiDETz3
         gQkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qv8kpOJ+gruMgjflclenRxoAx/cflMIqU2HH0kj8vVE=;
        fh=pjgqPnofRtWrqVB9Ao2ofe8V0OUAUkn9SqzhBEJhnFg=;
        b=VBLIL8BJjiCRAbkKl2Cht/ojXiwPBCFw2YjFlREZdA6WKsDFelTmP0rR8gwo7sN8af
         vOo1/jCj9Ktp6P1mE8kp1Htp19aXNH/BmcdDVoaU4kF7udJoeyxsLH1iO6QhBj/7ZS5t
         9vdSPu5r8cShsZ1h48esCh8gQ+AsTHHntCA2YU2Ax2Vn/VWG8im7nbYuZQR7Z59Nh9AT
         U0eXhAxlGJKTCiGrZCszxDC+ZJ5peSKajszMrClxIWnid7lnYs/TP/E/T9V8k6Z3sgJw
         HBTrVeBP9melnEua7RobrQv12IiKRoeRDMyXcYE155w2Orthb5/Bjn8Kr4NlDMretP6F
         dZYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788888934; x=1789493734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qv8kpOJ+gruMgjflclenRxoAx/cflMIqU2HH0kj8vVE=;
        b=fNk247IMBveoGpGa9KXNQwbiENytvrXHqT/1Y9qzF1v/xMVTuxFGzOppZZmfwXY3CY
         tLLnUya+rzqOPICTByepSB/gGWGOpm8VUn8RSZ/JzdwBJ5s5vwgeHoO7GNhkd0mpQGhS
         MK27M8rr6xTeonR1ZInAnFZJFWmkCt+hexeEuS1U5n0PXiuO0r+Z6nwF6bWbBMrn26YW
         0rCgQ1WtvEq/fuwIRgpwvV1AqdOFHeldhJIGaa5yj9NK3+q/9KijPYKHmaHAoHy7cYAS
         82olgWyiH8T/RWyDxuIHJIOTQ3XWEG4StNBNmVRKYF4JjQWpn1BxZhGSZb+Uq0mLVotd
         y7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788888934; x=1789493734;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qv8kpOJ+gruMgjflclenRxoAx/cflMIqU2HH0kj8vVE=;
        b=EtblyUyOR1ECvA6J92jYTU/HjbWavFEpYrhfS6A8SoWBnxbYPOEAVmdMjMpEJh0rqs
         IhDhA5Xh9KpfpGkhs4f5w++TZBoQxdgZdqjpI2IQbNY0Ih+d1rR6oDe+H8jNf6NbJ42Q
         mPmLGh7+ItojuPfju5tdQhrd4SvLlpuYh8PG2wuraY1AiBwZMrtGN4DJd3CEi8+CgM77
         KGsXQFIuo8sp/rg9gVW/81l/BjGg4mrWKkxhdE031fQ5XpqId42/9cgBMBonvtwP7b8j
         QbXjIYFxeptnoJSLxga9u2QDy6pomXmkrGMNegAlyd8tUORof1RwJJsAa1wqOcpZuvyb
         w28w==
X-Forwarded-Encrypted: i=1; AKwUvByR2MMXMfrQiMNR5vTLhRrxTvxsQGWuFQ5iJE5FZOZjK8OwB2uRSxs26YL7vWw9Pia+jKM=@vger.kernel.org
X-Gm-Message-State: AFuF++mFGav1L5GOUgbPnQYe+swRXzGP1F062zuFhoo0A/P61oCvAnJY
	ej7AkWgZEoTSc18mjXUlmmmchvNZmnl5D54/TClOLt4lR5O+XT/i1rMBDzhngws9OwYCk6KbAjU
	maq85PlU+goqebTYmZWdjZWoqqJXqn61M/iOO9RUn
X-Gm-Gg: AYBFou3d1wo3KZficce0gTyQVJOq2kvDQo3ewINUt1EvWeyzGVXWuMvS0MQIjWyBnWt
	HNqP2up2vCBJkj7JfY0pU+nCw+QFpzLZy4bLsNbFdA6Bz373BO7Gg6CWDsShN2YI7umJ/i84FzJ
	cRM8dIeMdD6ggrUUvXkExK1NP19WaCx+Y/8f0/JI2/lxHgnbuCCsizD9nUav+0muG0ZA6nzxGU0
	WmT38wSDAAWKU1LKs0Vao+OFTchfNtqyXvsGAbubfyXrbfA43NJVGjjTVJXNDQX9FpNddyCLNSK
	ZrAKMkHC7REb6WQ/YLC9VAVVlYEQ6Ia5o8uSlYfI4+cPsMZTkE+GufpE7fkJNqfZHKK0nUW0Qy8
	j/UPqm8DNqhB9te8uY3+1w30atKyWjfeDje4I9Y4A9VMCJcc3JKXjVDa/YcDanUmOfJPch1XmzS
	wzuKdj0LmbHQUJNyN/4B4gPzE=
X-Received: by 2002:a17:907:6ea7:b0:c25:ee92:2d0d with SMTP id
 a640c23a62f3a-c260c7aaa74mr1073835866b.9.1788888933689; Tue, 08 Sep 2026
 10:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908132838.2116068-1-jmattson@google.com>
In-Reply-To: <20260908132838.2116068-1-jmattson@google.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 8 Sep 2026 10:34:56 -0700
X-Gm-Features: AcwNN1Ve1KZrSiuBb6ANCAR-3Emy-6ijikQlC1aPkqvjf2tI8agssARUGoJDI7A
Message-ID: <CADrL8HW3Q=8eBf-=h6BAPdUN_X1Z_-KG=i5a5rA2kF+V4JURww@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Don't flush shadow VMCS12 to guest memory
 during vCPU teardown
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 6:54=E2=80=AFAM Jim Mattson <jmattson@google.com> wr=
ote:
>
> When a vCPU is destroyed while L2 is active, KVM synthesizes a nested
> VM-Exit, which flushes the cached shadow VMCS12 back to guest memory:
>
>   vmx_vcpu_free()
>   |-> nested_vmx_free_vcpu()
>       |-> vmx_leave_nested()
>           |-> nested_vmx_vmexit(vcpu, -1, 0, 0)
>               |-> nested_flush_cached_shadow_vmcs12()
>                   |-> kvm_write_guest_cached()
>                       |-> __copy_to_user(ghc->hva, ...)
>
> During process exit, do_exit() calls exit_mm() before closing file
> descriptors, so vCPU destruction runs with current->mm =3D=3D NULL on a
> borrowed lazy TLB active_mm. If the borrowed address space has a writable
> mapping at ghc->hva, __copy_to_user() corrupts an unrelated task's memory=
.
>
> Skip the flush when KVM synthesizes a VM-exit with vm_exit_reason =3D=3D =
-1
> (e.g. during vCPU teardown or SMM entry). In these paths, KVM forces the
> vCPU out of guest mode internally--no architectural VM-exit is delivered
> to L1.
>
> Fixes: 61ada7488ffd ("KVM: nVMX: Cache shadow vmcs12 on VMEntry and flush=
 to memory on VMExit")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jim Mattson <jmattson@google.com>

Hi Jim,

This patch looks good for a stable backport, but I feel this kind of
bug could easily happen again with the current API.

One simple thing that would have prevented this would be to:
1. Change kvm_write_guest_cached() (and related) to take the vcpu
instead of the kvm, and
2. Check that vcpu->mm =3D=3D current->mm before doing the uaccess.

This wouldn't be as suitable for a backport, but I think it's better
for preventing similar classes of bugs. I'm sure you (and
Paolo/Sean/others) will have better ideas. What do you think?

Thank you very much for debugging this. :)
