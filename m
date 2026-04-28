Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6219E1E8320
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 00:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777336572; cv=none; b=fE7KcC2z2y6voJ8GSgozPWeK4w00AiCLHRZywo7Xt0yRu6dsWAp7wdhAXDqgcN7UnZyZRJVlAHpL2XseoypGGqO+Pu1YvweSRhb0+/GPqiajc/9YHoq2YsLLYahVLhXdR2tSd3qiaICp3Ona9yQhowRS4Zkg/3HtJdVE26Z+WnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777336572; c=relaxed/simple;
	bh=siKJ/HHZDslVtoIORhZ83xDbnBJRH8uqn6JA+VvkV4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e084fd0rKawazMphhTOQUIJLp/tZhnrTDNlwcp5Dkgydhacfj/qaI9ol0FZ1SgEM7y66AT0kdmo+RfTXjSJPUJv+marVMHyWoG54FQAaZsp2EU9gefPREOUyPKmxX09l6iKKbKR3U5jAF19fMmH0hdAnXHFB+IvtwRIXocli2TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKudtY0P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKudtY0P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF88C2BCB7
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 00:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777336572;
	bh=siKJ/HHZDslVtoIORhZ83xDbnBJRH8uqn6JA+VvkV4k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lKudtY0PhosQKqou+DbV7hzryg/mEf4uMXrDfzrB7ktjo6LmGow9PrM4NMdS0IWgq
	 gz1JWOFuvJe6IHbRXxNUXqKwZf3eFrqv04SRl6Wrqr6fGGESgfzdnFhlRFgp5K8Q7j
	 PvmvTiWZZkMh5kk6CNxtmv2Dtgxif3eM5JlZB9cXTfhazyqsUu8K5467NDkycNNEpz
	 TvAUlwb3IwxcJxnnI25QJhL07hNBA8RH3exv/UBlZqOau0haV21WAe/XKQL6sG2XET
	 UKuW2duRm7liyKst60PdHuvOpwLq9BLzKc9U+8FIWKA0hsfa0Ivga+M0G4ewlleiGH
	 ZJDu7UggiSQaw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ba3115fe0d5so1910466966b.1
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 17:36:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/uwDCozUALocwtMk7vachLpdGik+v7HQacBOeAx4/AwOF5C/EwFm59bH9YFG8V6JKauCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvyLlhtE9BNPZgcgHVvuf/uOltIGeO/wP3YgECiDE1bjwD/f8x
	QruJfS+HgAXTATIREhaqBBL78Vceit9sWnpMNWLjTlkPCwzqgry7z8ETYa+BBr0zsQWQdMcEXpq
	0UwCR39zYMtNGl+qDHenYgYplk1X7w1o=
X-Received: by 2002:a17:907:3e1e:b0:b90:4838:46ff with SMTP id
 a640c23a62f3a-bb848120ef3mr6716666b.21.1777336570910; Mon, 27 Apr 2026
 17:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326031150.3774017-1-yosry@kernel.org> <20260326031150.3774017-4-yosry@kernel.org>
 <adReHbkVRDGOihb4@google.com> <aesRPt5Vpco29vAt@google.com>
 <ae-v3aGftsAQuG5E@google.com> <CAO9r8zNzyp4X8Pny7aFAjX8swSxpfmwu7GF9Ry7Kz9GSKpw+bw@mail.gmail.com>
 <ae_3BWwjHiYC3hzm@google.com> <CAO9r8zN-qru58rsBaTDae+5zGp=6eJRkYFDqdGhy7SYPwt9+pg@mail.gmail.com>
In-Reply-To: <CAO9r8zN-qru58rsBaTDae+5zGp=6eJRkYFDqdGhy7SYPwt9+pg@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 27 Apr 2026 17:35:59 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPdnMK7oqjz_6i_0=Bh5hyw96BLY=x71emTNCwLtqyoww@mail.gmail.com>
X-Gm-Features: AVHnY4L-9tOioWYV3I2bmvxb3G9NfcMrlwtNrZf8WVqZccVwit9D6nNlNLUy2QU
Message-ID: <CAO9r8zPdnMK7oqjz_6i_0=Bh5hyw96BLY=x71emTNCwLtqyoww@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] KVM: x86/pmu: Disable counters based on
 Host-Only/Guest-Only bits in SVM
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 5:34=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Mon, Apr 27, 2026 at 4:53=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Mon, Apr 27, 2026, Yosry Ahmed wrote:
> > > > We can have our cake and eat it too.  Add svm_pmu_handle_nested_tra=
nsition(),
> > > > but then also rename and rework reprogram_counters() to support bot=
h deferred and
> > > > synchronous operation, e.g. something like so:
> > > >
> > > > ---
> > > > static inline void __kvm_pmu_reprogram_counters(struct kvm_pmu *pmu=
, u64 diff,
> > >
> > > I don't like 'diff', I think just 'unsigned long *bitmap' and pass a
> >
> > Hard no.  I agree @diff is a weird name (I was literally just copy+past=
ing the
> > existing code), but I _really_ don't like passing a pointer, especially=
 not to
> > an unsigned long.  The bitmap usage throughout the PMU code is mostly i=
nternal
> > implementation details.  But for what is reprogram_counters(), and what=
 will be
> > __kvm_pmu_reprogram_counters(), the "counters to reprogram" is very tig=
htly
> > coupled to the architectural layout of PERF_GLOBAL_CTRL and PEBS_ENABLE=
D.  And
> > more broadly in the PMU, for the layout of GLOBAL_STATUS_BUFFER_OVF_BIT=
,
> > MSR_CORE_PERF_GLOBAL_STATUS, and probably at least one other MSRs.  Tha=
t all
> > should be captured in the APIs.
> >
> > The other reason I don't want to pass a pointer is so that even when th=
e source
> > _is_ a PMU-internal bitmap, it's super duper obvious that the source bi=
tmap isn't
> > modified, and that it's operating on a snapshot in time.
>
> Sounds good, I will keep u64 (and maybe name it 'counters'), or maybe
> s64 as that's what kvm_pmu_handle_event() uses (and what the atomic
> helpers take).
>
> >
> > > bitmap in here like most PMU code?
> >
> > FWIW, AFAICT, passing a bitmap as a function argument isn't common at a=
ll.  I
> > only see kvm_for_each_pmc() and kvm_pmu_trigger_event() taking a bitmap=
.  There
> > is a lot of bitmap _usage_, but rarely does KVM pass around a bitmap as=
 a function
> > argument.
>
> We still need to pass a bitmap as an argument to the
> reprogram_counters() callback that we'll add in
> kvm_pmu_handle_event(), or would you rather we cast the bitmap to s64
> here as well?

Hmm I think we should pass the bitmap as-is, otherwise we'll cast it
back when calling kvm_for_each_pmc().
