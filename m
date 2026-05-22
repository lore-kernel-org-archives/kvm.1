Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1548C283FEF
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 23:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779493563; cv=none; b=TpprwnFdtq4dOOtI7K/0R9Sd3oA11GwmMMChnCFnDziOpo+mcAXiA+49SqO3W7Ew3nmZwxUn6TCxPCIQNsdn3H8rk3srasmAjlzXgFJcgUK9AO3CO607Pb8qdXzfDQhsxm8gO9WzvA5bzYoMq91lzxrhuy9Tm2E9T9+7OhTAIYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779493563; c=relaxed/simple;
	bh=vPYmztw+vY9Ys+6h0nLiSBpO2wyyn7ZRhGiMaxBUuxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmnfNOJH1s+8VogKautxY/29e/WSwawH9OCoe1UZr/uTHLBC6PgF+pbHotBxnpU9Q9VhtwTgNPIagFvN9uHThUYlGT5P/ZuA0YzZbsmvFf1uvo1UXvwvdNzhsarsUkw3Gh0KktoodUfNTlWsWdT9sDWKfkVg5HYop1RHLNxgnxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cnrzc+mk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cnrzc+mk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A6D1F00A3D
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 23:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779493562;
	bh=ymQN01urVf5ARUbqYUvHus+gN9Insr9RrCZH4u1pzjY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Cnrzc+mkgrKG460xsQme7C2AIVqFo2LslaFm227muXDAUjFJECkxvhXNyFhSRqV+o
	 iD98JzZJfPcwr36ieB/Z3dJEY6K+i3D2PUN7KPk2JKRp7krNULRbOIH7YzkyhhmPJU
	 dOelIyCmDKBcngkRhVfy/7e9J8xw3r8yv1HlVEfnfcw7T87rloUN+tf1LreJT4Pg1Y
	 LnLKAL8ShWxaaf9z0NAJ5Zt/GnubyS3sDZugBBmoRPI5hkc+kdouyH3RP4W3Ci/m/9
	 C5pLMgjVmPYH0UBU2mGvbv8Kjv0FgNDXrU78NULZvj465gD1fC7mxIt9q+mP+YmeLb
	 Bcw7xIpx2P0Ow==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bd2087858c4so1521886266b.0
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 16:46:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9KKzHXtbIVO9pDEpRIf2oZpOgGLdXuDFaNOa+eCLglk+xkLuNgWsEmhqe7SipVHtXLCz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmtSahflHAtETpW3CKSlXQIHmZmTXI7lJh71PXNjnw9HIwj9ny
	uNDq0TSVBqo+LYApLwNnEciEiRKvgySNMSLnjQY5FG6Ru45Mer7DEBIGzTAjqDNZFrNpihWLEsZ
	dIgr8D+NXqJv3iKLNLOVGvhYnpNA7C/g=
X-Received: by 2002:a17:906:4594:b0:b9d:e301:20db with SMTP id
 a640c23a62f3a-bdd274c9a91mr277901566b.25.1779493560894; Fri, 22 May 2026
 16:46:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506015733.1671124-1-yosry@kernel.org> <20260506015733.1671124-2-yosry@kernel.org>
 <ahDidRRVYHD6x50P@google.com> <CAO9r8zNOEYf7RzoDUjueTVaiFTFQ7sizBfpeCoCbCCTFavRDqw@mail.gmail.com>
In-Reply-To: <CAO9r8zNOEYf7RzoDUjueTVaiFTFQ7sizBfpeCoCbCCTFavRDqw@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 22 May 2026 16:45:48 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMuhJpeBwY-tod4mr522hXhHRrkK8UhnxgpMi0SQ0vyMg@mail.gmail.com>
X-Gm-Features: AVHnY4K4DB-igTmbQ9GDdoJ_W6CI3CnlibkcJC949xBzpjYhsOOdE8BkB-KTYew
Message-ID: <CAO9r8zMuhJpeBwY-tod4mr522hXhHRrkK8UhnxgpMi0SQ0vyMg@mail.gmail.com>
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

On Fri, May 22, 2026 at 4:45=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Fri, May 22, 2026 at 4:10=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Wed, May 06, 2026, Yosry Ahmed wrote:
> > > According to the APM, TF on VMRUN causes a #DB after VMRUN completes =
on
> > > the _host_ side. However, KVM injects a #DB in L2 context instead (or
> > > exits to userspace if KVM_GUESTDBG_SINGLESTEP is set) in
> > > kvm_skip_emulated_instruction().
> > >
> > > Introduce __kvm_skip_emulated_instruction(),
> >
> > Eh, just make svm_skip_emulated_instruction() visible via svm.h and cal=
l that
> > directly.  No need to bring SVM's mess into common KVM.
>
> Yeah I thought about doing that. The only reason I was hesitant is
> that if [__]kvm_skip_emulated_instruction(),

if [__]kvm_skip_emulated_instruction() gains new logic*

> handling it here might be
> missed. Also, there's only one direct caller of
> svm/vmx_skip_emulated_instruction() (and it's TASK_SWITCH
> interception, who cares).
>
> So I think it's more consistent and future proof to refactor
> kvm_skip_emulated_instruction() instead.
>
> All that being said, I don't feel strongly, up to you.
