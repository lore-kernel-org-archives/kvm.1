Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EDE432E65
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789730529; cv=pass; b=XCwwwXZZ7Is5aMn9Ts5uxkCkssYRscGdxxFptRnUzTUAwv+sfy9ZEQA0zR8FBMV28469LvC5ousa/1sPDBV7FOKEiEgzPEkHUi2Z1QB7HDBVVP8JV5qxtQqmXnO+4Ew0TZXQrhHMBhMZijGRWDp73FxBN4S85pbAFMw0Vzxkh7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789730529; c=relaxed/simple;
	bh=/H+f8rE4cmCyRd97Qlb5sVoBG09cTXloUz/HII+jJZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcRpxwsGBaln0N6oR/PBgV0Rt+AVWBcIzpXzu1EO+jA9n0eva4YckpGfMjBF1I0QSwZvuYz6YEmMq7EMpm+ai67lfWoy6lFUmK8LvRXoiN8Nn0fLW84ubFLvFV3s0dwtyfvgvjyERLnmS5F5l1+qICUsot3woxNmZ/Ii59KUl80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ny43O8F4; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ny43O8F4"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6aa13d8d9d0so6536a12.0
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 04:22:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789730526; cv=none;
        d=google.com; s=arc-20260327;
        b=Zm64K+h/ci/OmVYv+LEgTB6r+IJ/PiW86X5NNijZjjZQ+rw0UZQliRGjvlaM23/7IT
         ZjSspSuuVs8i4t4yot8ZOYvdYCL/iUvyonV0J3Wu2VSV8xuAEwcPV6J4sagElifJ7wNP
         f+DDqzvolxvBJMFu8PtDJ7hqEGmWwpQje48++DpSRCFQWEBk5lCKZFiQ9MLvZgtM6QS/
         HbyCiNnntVWN5EOgxVUFmuDYqA+7Nxo0Yrzwital20Jo0MaQ/d6oWIpdd/+JzLTwEXbI
         hINA00UYI8q74qGU09Gahs8p40JIyVcym+tre9c1InkZjiZnyf2M1dgT6iZfxnsl+Iz6
         sSkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bfl80AgR13deu44SG/KPKuN/OYJwn1enWYpfQyfJCUU=;
        fh=pwJYwy953AW44E3e8WhRP5fsmlg1tsZ3ahU2K3sHbfM=;
        b=WGw4jj/i2R9+xNRmryhnybzxdgkBwnaRimGicpqLABqLvMV8u+4mOKjnxEYu77Bz7A
         tLRsYvGvXmYksIixv+0oHlljgrpfgNYrMhkcUW0fHjAIy3Wzk4P9ikzfughz6IMlgA02
         uM3mXjMKbLungn/YF0gJ2JBq1kEd+2iX4Q9IGaVMFHAHjCcfFjyXeGcIY+DkH1NKe4Vi
         YKaCo2id6e16sPhHW0MzwxwIAAKSRYYT9UiYH8ihyDoQKg6Y81tjWHptu0jIaIKaQeZd
         exTejkEdzIyT/Jb2ampFFTHYsR9kk1h6tVnkr2D1ajRYRw/+jy/H4Ji9+wgBh0/pZoN4
         +A3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789730526; x=1790335326; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bfl80AgR13deu44SG/KPKuN/OYJwn1enWYpfQyfJCUU=;
        b=Ny43O8F4P4vxQ7/zMrkI32A43lJHFbDxxSUXs/taJpDHGhIPuIY1CJAnTbTE2IhATj
         3zS4g567bNVkMQFL4SEQJBq4w4vBGQGg0dKBNyu/jlihVksHi2CSOF0JOFLZSQ0mnRbP
         D4aGtilA9rfBoZFqg2o8ZCi9bGrM/potcjJ42lelmumgR6/j4IKmZ3gjNw1EugTPfKLm
         a9snYCFql1wnmPaOQl9awVMRyMnGPbHdwBt+1J7uFDXJI/9k4Z0cH7GNRKK+skcnoMOI
         Yz3FDCL26Wl6qftpL2B61xiTouSOzym87VZZst8aBkb1wj76c0ytBWZT91RS1/pBzLVj
         eesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789730526; x=1790335326;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bfl80AgR13deu44SG/KPKuN/OYJwn1enWYpfQyfJCUU=;
        b=yJD7j4N+vA3O2TmzxGfAwG5DsFSPpUhR+vNa+3gSj59mCzcSZeaz4narqZWMiymKjv
         tl8GFojTdN6LgyyrlQohQbLQ7CbkURwB7Gb4TOJUjpVLHb8Dz3nVX4h+DYLNKKt2T5AD
         pkBJDw/u2RFb3Dymg2B4Ytji+s06e2ovZZpwUgGUk88t3jNEN14yPGJgLboA7NU7VIMI
         DsvzY+KSCv81Ua+YSGlV7oR69sub8PmMn11xOjKoXBLijLo9VgJYpuO21+VvbT4zgSli
         MCeJbkUwxr7rHAVS7nS/zH5DoecoeH/jHLJUqGXWL65wsg0KeRwdNokStX2xl14FMXO1
         o4kQ==
X-Forwarded-Encrypted: i=1; AKwUvBxTxuaJtGsyekfJtQSkBpgIO1q/A/JzqAViGamdNn9fEqM9COou84991+jXvXD2tW4aris=@vger.kernel.org
X-Gm-Message-State: AFuF++kC3USakdos8/9Lxb6zra9VGTesfZpGVP46foATEJN4KslDS6vT
	LoIko042enl7gz9GlVkIbwUzaGh+qz813QR9EV/CTTLqz1tX63F1smVSRa5/OjAzn6XJsUCOJXj
	AR55tNRHoT2zQTomkLLgPMPDH1AnoWvGUK73Ygy8/BZTsPU/TPxNRLSsynX8=
X-Gm-Gg: AYBFou17RoaadagBAG4pU+IzIeWjuXwALTVLSlj9Bdgc58+ROVn3QvfiGdeI9IKCWuw
	xby3U9JrbcDsi5LYi2dzJHslD5PaLPf8XHU3LsToAfngYhreHLd6vWKtRc4SIfWmTmNBwNxwAi7
	TEg24BGY2kXHAHQOYlwtVkSv0tXOai1AMah2mQ6o4LHXRchIMVj4ulivMHolFGhlAs7URjgm+qT
	kfVRPsF3vCGpwUcKxU6JQN1XYqfdl69OzvUm60YlmzRhNL0KhdlPAluy9MNZDCVv0aHLGo08zKx
	E6OwNun9O69gQPxAROCwHqa99IOa253ONloA7Q8ZkzaCoxc2vQmUhsE=
X-Received: by 2002:a05:6402:c318:b0:6a7:ef71:28e0 with SMTP id
 4fb4d7f45d1cf-6aa4de2f154mr26925a12.0.1789730525581; Fri, 18 Sep 2026
 04:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789721173.git.zhang_wei@open-hieco.net> <95301258748704c6b63664015ea18d3632739256.1789721173.git.zhang_wei@open-hieco.net>
In-Reply-To: <95301258748704c6b63664015ea18d3632739256.1789721173.git.zhang_wei@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 18 Sep 2026 04:21:52 -0700
X-Gm-Features: AcwNN1We1S9kRVzuD3jSj8IbJp1M4rVqZ6TcYDxFKtZsWvmaACGzUXedXxtLuy0
Message-ID: <CALMp9eTme_QbkN8fuc-JkE9M-VLri30sqR7vxqjeU8xX5iHQgg@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] KVM: nSVM: Use emulator bytes for synthesized
 nested #NPF
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 1:56=E2=80=AFAM Tina Zhang <zhang_wei@open-hieco.ne=
t> wrote:
>
> Preserve the bytes used by the emulator when synthesizing a data #NPF.
> Reuse the fetch cache only when the fault is the current emulator
> exception, identified by fault =3D=3D &ctxt->exception.
>
> Add an emulator accessor to copy cached instruction bytes, checking
> the RIP and cache bounds.  These checks alone do not establish that
> the cache belongs to the current emulation.
>
> Write the cached bytes directly to VMCB02 and fetch any missing tail
> through the instruction-fetch helper.  If the tail cannot be read,
> report only the bytes already available.  For SEV guests, retain only
> the cached bytes because KVM cannot fetch plaintext guest instructions.
>
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> Reviewed-by: Jim Mattson <jmattson@gmail.com>

Oops. My bad.

Reviewed-by: Jim Mattson <jmattson@google.com>
