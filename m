Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1FE1DDC2B
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 23:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779493540; cv=none; b=qLbou64rx+NJ67rUYhzcnMmfwAVC8HmRobuQiPwrNhCuCssDKd/815EHYVhaeiqpGBwKJHA0m3OXVVJ6pnaLUaNL+KlDcSF7yiUbIInHE/ffYskGDEoPsHwgPJQnD5ANOr6IiHJegF+aob3crrh0CZ7DAkkBjTdd8mHPnzXTGMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779493540; c=relaxed/simple;
	bh=YJ79jMzicc9PJ93aIqkSstkVOdjD45tbX6SAXdn1nKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eB5h13XKOep8jsExVSVh4n9UiXxKtZ70enOZbErBK4ColLb4rrIAno0rvlErnmu5e6gwIH01KMWJjYdFEPZmZ8Z0QoBAn/SOw6Hr6+oTGVgAIgMzVyObQ5Nxudy0s1uUKPqaML5aGRMPRoreOCEN1BRk9wryQlBnjqbiryKisdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdz9rVDP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdz9rVDP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627131F0155C
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 23:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779493537;
	bh=TFl+c8DKBiFH0Ig1DRl91nSYlyYcSq8n//DmnDcKxPk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cdz9rVDPQKEuPK9GAIQMRLT4Hss7v1sTFaPGRHq/N5thg3spGR66kDN6dI/0UU8iP
	 1q78sbe7IB2gMyafXfuGUUWgUXh62NnIP3AJs6E2xbZwosbVYQJDy0PgMR80YR7G5B
	 Mp+rgQiox6GyE939MPh4wqQGrKerFCWpvoMS8n6sm9ox74U3TxETAdbfutvYdAwvF0
	 iTnTR6uCgAoP+g97IVMbkMpAXZXce7pPL8JWGuxBrFMuUrY6S1TBDdaHQ/QnV5Z9Ef
	 PHHp7qrYoJuk9mVPf9OgkkScyElHSzGm3OBhUmhQGaLjEVKVF8+ZuR4GttAb1SBqRX
	 bOaRseLANvpqQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bd6460b0d11so1389013066b.1
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 16:45:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ98ETAIfgqqT2BWCyjMWk909qMFog5D5Thr6ca+9ok24QDn//rmS6XVTqhaHIkf5KZX6Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSXWSGqE/NieGjt7G7FR9IBX4pzTi9i1Xxd4t/4Ic5JAlLplD2
	rRf4ObbK7IytXgWnsMGVozCfonCKZVJ15dPDX/O+WPWAa02FpvrtxPytIiM8L3LnpqAV6nb5meA
	lOw1ru+LQS4mwBF/IA/CuhC6/jn8DQE4=
X-Received: by 2002:a17:907:1b29:b0:bdc:ca65:8a15 with SMTP id
 a640c23a62f3a-bdd2293a521mr349318766b.2.1779493536265; Fri, 22 May 2026
 16:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506015733.1671124-1-yosry@kernel.org> <20260506015733.1671124-2-yosry@kernel.org>
 <ahDidRRVYHD6x50P@google.com>
In-Reply-To: <ahDidRRVYHD6x50P@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 22 May 2026 16:45:24 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNOEYf7RzoDUjueTVaiFTFQ7sizBfpeCoCbCCTFavRDqw@mail.gmail.com>
X-Gm-Features: AVHnY4Js_TBXOssbYVxMsl2BguglTM8BjiFZo4im98_ZmuqWS5Oh9rwki8qHFKQ
Message-ID: <CAO9r8zNOEYf7RzoDUjueTVaiFTFQ7sizBfpeCoCbCCTFavRDqw@mail.gmail.com>
Subject: Re: [PATCH v6 01/16] KVM: nSVM: Stop leaking single-stepping on VMRUN
 into L2
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 4:10=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, May 06, 2026, Yosry Ahmed wrote:
> > According to the APM, TF on VMRUN causes a #DB after VMRUN completes on
> > the _host_ side. However, KVM injects a #DB in L2 context instead (or
> > exits to userspace if KVM_GUESTDBG_SINGLESTEP is set) in
> > kvm_skip_emulated_instruction().
> >
> > Introduce __kvm_skip_emulated_instruction(),
>
> Eh, just make svm_skip_emulated_instruction() visible via svm.h and call =
that
> directly.  No need to bring SVM's mess into common KVM.

Yeah I thought about doing that. The only reason I was hesitant is
that if [__]kvm_skip_emulated_instruction(), handling it here might be
missed. Also, there's only one direct caller of
svm/vmx_skip_emulated_instruction() (and it's TASK_SWITCH
interception, who cares).

So I think it's more consistent and future proof to refactor
kvm_skip_emulated_instruction() instead.

All that being said, I don't feel strongly, up to you.
