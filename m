Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B173B42D2
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167402; cv=none; b=rdxPnIsAaBRdkZxiD6YHQmmttp/aZo5CbF2LYFLDnJ6pncwQE9D3yG0N4spDRfN67Oc7+a03p8Z1aykifMjWXXi7bHPOKeycelPCHDRhefAJ9YrwFCHVk9IArPI1QGUPHR7IEYmifzEWPMGymWEgtjheePT9HWBRK4oi+gHvqOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167402; c=relaxed/simple;
	bh=kjXqeOW0+gdSc+ye8otJxNKTTrfR6JbKkIR0UBM34l8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAcjWEMqjssO+q5YPctn8HKUR8hXmGiKoyUxib8OyIxGiyZcg4y53ie+HQdW5y+HojgM6Slwd7CGUDIa00OmPCZeN7gORsBLluzpquL8qRv2bqg8tZvgFRx+PXUrxk5txZx6h/gR34//wRgODaD6t5VJAUTDy1VbQpGdEyIM2Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjXMTM6Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjXMTM6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02591F00A3D
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 15:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785167400;
	bh=ikkAM54BZ9Eb2as204ramsxMIUmDlrBa5j3pKGObtp4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JjXMTM6YcrFpJKOnAbKy4ns7MBItYRV7uovrhBIEy+e2QkffvwuizDhQtzfZrHsC6
	 UNhrqRqMjoP4h5M7/DIS3Hde24TRYPcAKoanGV07z255vb9Rujnl688Q6sqfutH/Y4
	 iCgVpwUpFBPqWChDoVRaIDJGl3gKXkA+HDVJrafFcO60EDYYBKzwHM6C9n6m+EEvnW
	 iPR8FIiG2Xlh1LYMcOkolrJEF0KFVfn7VG66KC4yO6BwXAMYV9Ku7eA0hLbfqFFVpt
	 l67R2c+N9hzqm9fHVESLvsv6QZkDZpv8ZdQro5AxdLYAAMAZuKt+vb36Wqtw69XYrG
	 /ZsC9Mj8qbFOg==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a01b8959e7so704012a12.1
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 08:50:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoGVnNrOX35rko3SEX2jcb+88ACU+4+L8NHnwP7A19OZuXofXzvuLy+6RE2iQGaRYuiErM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH1XkzRwmHbyqV52sB3Z1RPrPi4iFC9CB/YgYkfhWu+QbIMhkm
	icPRIGu5eAUR8KR4pPrAo1YVv5YJqQC2GMhqgebQvuV/gTaErn3+2j/MvmrOiFS/S+bFlqWPwFr
	bowLjvoIxyaPoulWUpyMtaHldW5RsYik=
X-Received: by 2002:a17:907:961f:b0:c12:6f47:1d30 with SMTP id
 a640c23a62f3a-c1f1f19837fmr402289466b.65.1785167399181; Mon, 27 Jul 2026
 08:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629183746.699840-1-yosry@kernel.org> <20260629183746.699840-11-yosry@kernel.org>
 <amOl8kczWlZP_ftH@google.com> <CAO9r8zOy3qyW11ByE4o+VWn92rZJN_kbF3XJTt7qf3TnqXXuWg@mail.gmail.com>
 <amOuALTiqI9u4tFh@google.com> <CAO9r8zO15oLHXVhyE8rR7bOMM4Ks+qzRAsz=5W8kXMwKU5gbnA@mail.gmail.com>
 <amPL4b7x3cBxA_y_@google.com>
In-Reply-To: <amPL4b7x3cBxA_y_@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 27 Jul 2026 08:49:47 -0700
X-Gmail-Original-Message-ID: <CAO9r8zN9O=0cgO-ia1FtDQ-JvOau7fGUZ27wKP-WY7HmmKs9dw@mail.gmail.com>
X-Gm-Features: AUfX_mxG0Z_iUMNktd9_IxANmVr1PH-hdg1r3udW9OdcnmU6t2G7Y3mY8Vtawe4
Message-ID: <CAO9r8zN9O=0cgO-ia1FtDQ-JvOau7fGUZ27wKP-WY7HmmKs9dw@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] KVM: selftests: Trigger L2->L1 exits stress
 save+restore and #PF test
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > As I mentioned above, I prefer taking a dependency on
> > KVM_CAP_EXCEPTION_PAYLOAD rather than varying coverage. At least for
> > the nested case, I think I can move the TEST_REQUIRE() into the
> > 'nested' case, but then it's probably better to leave it as an arg to
> > allow for meaningfully running the test in L0.
>
> The problem is that TEST_REQUIRE() skips the whole test, regardless of when it's
> called.  I.e. if you go that route, passes for the non-nested case will show up
> as skips.  TEST_REQUIRE() really is intended to be used when something is a hard
> requirement.
>
> > Actually, what if we just skip the nested case completely if
> > KVM_CAP_EXCEPTION_PAYLOAD isn't available?
>
> Can you use KVM_NMI instead of KVM_SET_VCPU_EVENTS to effect the nested #VMEXIT?
> That ioctl is so ancient that I'm a-ok skipping any CAP check for it.

Hmm actually I just realized I missed a CAP check for
KVM_CAP_NESTED_STATE here. I don't think it's worth looking into
dropping KVM_CAP_EXCEPTION_PAYLOAD, because we will need a CAP check
anyway, and both of these were introduced very close in time (4.19 and
4.20, both 8 years ago).

So I think the simplest thing to do here is just run the nested test
cases if both CAPs are available and skip it otherwise. Practically, I
doubt there will be a lot of people running upstream selftests on
<4.20 kernels for this to actually matter.

>
> > >         int inject_ud;
> > >
> > >         /*
> > >          * Big comment here, explaining both the CAP dependency and the need to
> > >          * check for nested before querying guest state.
> > >          */
> > >         inject_ud = nested && kvm_has_cap(KVM_CAP_EXCEPTION_PAYLOAD);
> >
> > Either way yeah I think we should document why checking 'nested' is needed.
> >
> > Or.. what if we just check state->nested.size inside
> > kvm_x86_state_is_guest_mode()? or explicitly clear state->nested in
> > vcpu_save_state() if nested_size == 0?
>
> I like both of those ideas.  If you do the former, definitely make
> kvm_x86_state_is_guest_mode() a "public" API.

Will do that.
