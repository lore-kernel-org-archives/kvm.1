Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7447442FA5
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784910076; cv=none; b=ZPHcvLXAuaOoJZJCdm2tNHHNuqsaKp+OHybxuNGetFJXcUkZaQtiIue0sAp23X5LWJ6qpxsazBKJckLTqDvPM8y3lnSZKfyK0RoR0OMBtqGxJeJGDj/xBXYtlhFH/8iBUxeGwr3mgG9ZHlu1WVzh1DuW1dyEU2S0cM7LR/+IS30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784910076; c=relaxed/simple;
	bh=HTCIY2XLOrhrLuNElF1VMFG5Sb0g7Vv6s7fR/ZVg1AI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z461bAmL6ExoD/Wr74dxtlU/thqoS9dXsZz/fEMGsY5YXWvaEpFosXcbiSbo0OCDbTd7gadwuLaoNDAkuFSjClg4x0cB+OGoeoOLxfmFwt9OUJ+o79UTGz33fExkFKIkHI1kofxssCWlS/HWsmG25tCVsmC/p/m2rWJhsu3Nct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nm0TPlFP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nm0TPlFP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F65B1F00A3E
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 16:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784910072;
	bh=k4C/9YMvwCjbN2xiMjfB5jzQsd4HYWZv1hYNbZHAjKQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nm0TPlFPsidtMhXYL1UOTva4He5z3Hf1u54sQFqaLTzdw3oGOe0LdtAhhlicrzRw0
	 vzT0XhOXxP8BTtuDnLbZkQe4TbfO/mFejN2zhyJ3h1Qk2aILhCNMHOTaS5CdS4FHRX
	 xXnglEhtsSFXdtM4DFBbi/0157jZGZ/eSNLwN0MtNEzlw9l48OWnRIV34iYxC6f1Xi
	 i83Ov+k0Ga+myrfM/W64fB6XxYnUWpG4FXbydkVWZu4YLk1tdM2JvIdVmZ8yTV9Tyz
	 qFYx4PMiQAyG18QxDaMZGe7/S4llmhyhBEEuQgYoxnugyZbSuE8wu/jf+Kk6WKEwz7
	 NZ0LRn8z2L+OA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69c5f6f7a40so1074566a12.0
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 09:21:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr2aF8qnv3hJbM0bFcREfPBM6571ZkDz07Uin6/MWh6kIDRq4xD8tOe6kz+OPcaLLbVxK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC2TjIPthkWEHhC3FftjKElmDUfOjz6leMpKX9vLE9Vf4Upnsb
	S0hQcw0fRHS5ZqOX3PGOe7Uj3RTxL0EfoZnspeiBrdYBjjAEfnrczqNXSoq4yLu/U8wsv5Ii1o1
	s8knE9jtZ2H3VZ1uWJ7bsauyo8UA9YSI=
X-Received: by 2002:a17:907:d09:b0:c16:6301:c47c with SMTP id
 a640c23a62f3a-c1c5069a48dmr436277966b.6.1784910071462; Fri, 24 Jul 2026
 09:21:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629183746.699840-1-yosry@kernel.org> <20260629183746.699840-7-yosry@kernel.org>
 <amOGv2t9l9DpoW2a@google.com>
In-Reply-To: <amOGv2t9l9DpoW2a@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 24 Jul 2026 09:20:59 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNPCk6FpKF6LuZ-964uAB4hv9NRh7KuU98kiJjeM0pm=w@mail.gmail.com>
X-Gm-Features: AUfX_mxu1v4HEwZlwAkB70nBnx309VIne8FqO_DN0HGu-lC6Wnjg3obBosjMOUU
Message-ID: <CAO9r8zNPCk6FpKF6LuZ-964uAB4hv9NRh7KuU98kiJjeM0pm=w@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] KVM: selftests: Drop HORRIFIC_L2_UCALL_CLOBBER_HACK
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 8:37=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, Jun 29, 2026, Yosry Ahmed wrote:
> > Now that nVMX test codes preserves GPRs across nested VM-Exits
> > (specifically RBP, RDX, and RDI among others), drop the ucall-specific
> > hack to avoid clobbering these registers.
> >
> > Assisted-by: Gemini:gemini-3.1-pro
>
> Did Gemini really help you write this patch?  It's ok if it did, I just w=
ant to
> be precise with documenting how AI was used so that when I get a patch th=
at was
> indeed heavily helped by AI, I can actually key off the "AI was used" inf=
ormation
> for context when reviewing.

I am pretty sure I was just too lazy and prompted it to write it, even
though it's effectively a git revert.

>
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
