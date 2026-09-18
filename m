Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F994E4C29
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789730870; cv=pass; b=hkA7qt9b/mhk0ZHEOpxeWLkEr5oPjhMwW1myY77hglDF9PTHzB8IJYP1S7CyyVlxYrex/yj6l1WlcFH+NOSUosIbQ5wIfuNhVY/QF6l7YYlZVq54WQhTNtrVyo2odSw9WSVIXOa+ilECQpYMlebKiPp0ChgbC9GgCFiOnb4Q5MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789730870; c=relaxed/simple;
	bh=1T4Ypx73b49lIoEeXBKDKWASxqKm0qUZYs1hZl9y4gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u66m0gEhirxPtjl6NuYS+vtcjKBN914cZ0PCWTsGxqfhobZb2OUvXyoUWlmf3qZa2h1AVS+NAVc8ga2bzKx/rjENmG94IliZ0CnW00yOG5aTicsMC2OfP8GcZO7DoslWtE0tRR7hBu6YvtTuDrnEQIK/IfHBlX4yElexl/gLRMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bnicj358; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bnicj358"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a5f9b036f9so5326a12.1
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 04:27:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789730866; cv=none;
        d=google.com; s=arc-20260327;
        b=qI4X9BfJo0DyqygQs06CMzLWbYyzbo97BuRm4y5x1I7VRVR5tSmV6hDZI8I7zqxpu9
         MUi2L1rDQQhypfa8rR8teI/kPor0n8ipY+InrvQ5++kcKqbaeu5weKEomV+xN/syLKz7
         t966DJbIBampyju7/zMbwFtPhRLZ830SV49XFDSWUuC75mQgLfEFHdnQLbvciSMUx/WE
         7GjYT5i209i77H8oc8PHp+h5d+Dh+0uFyJ2ZT5GB0AL6DiFQAtrLMRkEJS0X7mlDdi0r
         bO9luxqSLvFJzyGeoX/vn77+bJxVRanhh0dTTvjW3QIUsMMQmmfTFI6vXp2vHmDFc0jk
         hohQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2zkFlHoWQ2AWCYz/XBKFNT4MlZs4AcmAdTGygjovBbU=;
        fh=SZn1aRO0aPolAdhZiigxiFNmvQdemdtXxcfWUOwd3U4=;
        b=qVPJ1jC6Q/GU72y/l0YO7X5elhg6WbnFmuHIWkPrgxITnpmkc7ESRgR/vItfGgSPEU
         6p+nytwBhrKHVLJlLpwsOmAuIUXTewLvn5PgdeSUOZ2I9jsaOPkgIw65SJCI8Koq69Zz
         gu2WgC4PfFfvCtHzhBfrVvcqVr/y7S4GWrUbRqrwtxtQo0NmQB5fqk1L8VkHNaYUhIQ5
         8zFKQyMag7MhU7QUn1lmAIvCSsMoLtoOoUXRAf2jifCBTbGtYw1rvc2He37O87cMg/l1
         jgdrhOxzj1Da2FhCtxdVwi9EQSUnwkIam0Yma07Cwwonl+4jNoGAxXFoIom0TWxhNv/Y
         Gvqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789730866; x=1790335666; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2zkFlHoWQ2AWCYz/XBKFNT4MlZs4AcmAdTGygjovBbU=;
        b=bnicj358p8BvR+0cPsy7nSRI+syhPcD8q9t1kzH/MM7jD3Ex2AgecRNFRaIh2hoD12
         t69llh4Gd79xFNGgrtRQqTucY8HzpYZPkiePEQvpXaaU8L8B6vuctbaMv3j7t2O9Ulyg
         DiBifT7wFrrd8V7NIOZMz36SDefcD0ExuZmo5B6UeU6MQSLwhUINU0tQ03hQsFspBqPl
         cJ9yoiFMNZR7Soz591jRZzlMG4yr/651O4S2Bz3yZoTMWjRHQo0FbxuNxeXOteLlQZ37
         +7/+dO2nFfXN2gatJZt3WwO/AMmDtcVXhxc8N+bcdTHovBGad+zyhtC7YwAbu1P2BYKT
         K3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789730866; x=1790335666;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2zkFlHoWQ2AWCYz/XBKFNT4MlZs4AcmAdTGygjovBbU=;
        b=FfZEtYs7as2J0RTbpAoob8YuqUS52lNwFcNBvaHQ0jowRCHqxEMRTlcTFW4owgGf0q
         4sCdnPvVhyeeeXig6bY0OGPCoB8/WX4k0MTFOBdB01v9nvfMgGSBn/SEdBLyfKdtvKPD
         +v2WDwU+rKMlMKJUg3v7sAGPJVqRzdiEO5xoDFMexJLw0BW3o28OaWiI5Bb9NM5tyGkX
         2GDnJkP5PPdDLVXL1kNZbkEDB3gLdWJG7e9i7J7a9d9bUt705kzyqJw2fUX62g9/j0in
         DvEkZBc8q24vzE1iNVzrl5IdF677jh8hM+OlZYGBCOzQSEMsUpGezOXXUyL5tNFZnCNz
         4IdQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQ1NrGLMI0cH1Yc62GYWq4S9T3wh70yti5Crk4ADKCB2KyzR3crAtSnnkPZiHMBDye64Y=@vger.kernel.org
X-Gm-Message-State: AFuF++kNcpSRmDQNpxT68TPBvt0v/BoBXZUXfgIsTye6gwmLr41MDA/W
	rW7yCFrFCH4qRa97xs40BoKIJzfsgBTMJ501FuUgOaUIbOxEv/WpfIBcz8ptJzf52VSMeNwotPV
	w8294g155JYLpfDdQ5et0ySGfZE6va2ED0t2ECBjy
X-Gm-Gg: AYBFou0qUSNiXVGIBr99V0iNcnfH2j2i8fRSMT/sd69zL6xym/qN4M/OmoqSLZcWMTx
	BW8MnUsJPFYLjvzDHYFWTvMm5ufvMQ+AIVxmlDbbcHL0B9QYVrU38mSBAUEFJfOl1AcsE5433DT
	e83RpgVT07UXUDgPm7ncHqbNNF/JspNmlt+spUlgEtTSgihepxV/MmgS2WuSPGpzOXwsF565zCR
	R6QHgtuW0dVqpGA8kcaUm5ehQuDzEubzDVDYnX48AJyYt8PasvOfXHo8qiiv6vlzGQ+1oOfUzfS
	rEXuO7DmWAqi4R1URay3ACsBGToq2k91SM6Gp7ZaDvJP+dY94m/AChM=
X-Received: by 2002:a05:6402:a588:20b0:6a6:f2a5:1b4f with SMTP id
 4fb4d7f45d1cf-6aa4df2139bmr25284a12.4.1789730866074; Fri, 18 Sep 2026
 04:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789721173.git.zhang_wei@open-hieco.net> <2b30c180a7ec1fb22033cc1b89debc36c9f569d0.1789721173.git.zhang_wei@open-hieco.net>
In-Reply-To: <2b30c180a7ec1fb22033cc1b89debc36c9f569d0.1789721173.git.zhang_wei@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 18 Sep 2026 04:27:34 -0700
X-Gm-Features: AcwNN1XiB8HFa2Js9NBlTZk2TxW38UVMUVZNntIOccJ00GWuWntEdr41p3Y9JBA
Message-ID: <CALMp9eT0RjVUYbcHbhd-phmaXs1yPsh25j+qkfmizqp+DCV=fA@mail.gmail.com>
Subject: Re: [PATCH v7 2/8] KVM: nSVM: Synthesize DecodeAssists EXITINFO for
 emulated intercepts
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 1:56=E2=80=AFAM Tina Zhang <zhang_wei@open-hieco.ne=
t> wrote:
>
> When the x86 emulator encounters an instruction intercepted by L1,
> svm_check_intercept() synthesizes a nested VM-Exit without fresh hardware
> DecodeAssist state.  Populate the architectural EXITINFO1 field when
> DecodeAssists is exposed to L1.
>
> Provide the GPR number for MOV CR/DR, the interrupt vector for INTn, and
> the linear address for INVLPG.  Preserve the MOV-to-CR0 decode informatio=
n
> when a selective CR0 write intercept is triggered.  Leave EXITINFO1 clear
> for CLTS, LMSW, SMSW, and INVLPGA; the INVLPGA address remains in guest
> rAX.  Leave EXITINFO1 unchanged when DecodeAssists is not exposed, and
> leave unrelated intercepts unchanged.
>
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>

I think Sashiko is hallucinating.

Reviewed-by: Jim Mattson <jmattson@google.com>
