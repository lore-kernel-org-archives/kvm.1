Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2E71B7910
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 20:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777581501; cv=none; b=mtDe2tJHprsNhr47weDX7gVOxXRRgzc0gghqLkOxNOmKJIFa2QBqzmZJHqPOWHhrI+i8IcWZocBrqVLF4cPJ2Nel789u18cWIJeo2XPLCIEjxHD8bnb7s3JBnAIbB8foK5yyLWLbEwWfOS92BJPtLNxoe5lGj4lJ32nCaIWOCas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777581501; c=relaxed/simple;
	bh=CJ1np4ZOVBIR+p2sC001tc+yUxM5fco7DnkShjJvPIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WB0ehMi/xH/PWFhQ+1OHycCyJnW104MXbCOhNM308h2VPeEJRzzJByHy3nkhlhuyy1sBaWSfaBUylyrD49rwJeLoHGvAe8EyUrtCWFtLTgJKRRMWCF0aK1tzBhS/6DgpvNccs77VQ/avT8pyIfR5XfW60SZidCPq7cW9W5HkM64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJ1jTxeG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJ1jTxeG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FC0C2BCF5
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 20:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777581500;
	bh=CJ1np4ZOVBIR+p2sC001tc+yUxM5fco7DnkShjJvPIA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cJ1jTxeGOqChoztCc8xxoWzNNjgmPddgXOF+2T0TM8DULZQRr14dK6BEukFbXJAQw
	 fzX8qZFJfeaTKx0L2/PKSoQGcwPFV50HGHUGPJY8KB82EHbkmYpDrp7c2AhVrUb9K1
	 sKfgO8fpaBswPBZLhzHpK9w25lH/r0F/67/R5J57PdwNV3bAkeon+iZSmM4ded23mO
	 7aPFtyBfjVgxeXuuYOP6m9usYVp+Mpvvnh5g+uwGEbCQ2HBT8Jh+sYKh5CoxTCpec6
	 aVfPzbrIM06jQE85j/A4PKSwgsgUGCpSThhTmdmVTJDHRuB7iMQwtRh7p7qmAwXrFa
	 +c96fORMk/N1A==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9c9d03524cso183981166b.3
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 13:38:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/k8J9FQjMIKZ6vpcdGZj5R0ULlUcq61r69cTIcFrigEnWZFuTKeeKMCCgWjs3XVBW7CR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBLJUUZ5G4gYsghB47l59DWEw/RACSwm3aLh+6u9IiatvburKS
	yYFiThh+X0HmNkNVsOWvWTcCHlAGVOgIY9X+uJ6oQN3sJl1kLdIcQPnXGTYoAtZK4ERh1pfqDcr
	5eKp4plJ9VDx+TYYXFoQHsNrbkQj8mtw=
X-Received: by 2002:a17:907:a286:b0:bb8:b536:55dd with SMTP id
 a640c23a62f3a-bbac788f9fdmr337785766b.41.1777581499569; Thu, 30 Apr 2026
 13:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430202750.3924147-1-yosry@kernel.org>
In-Reply-To: <20260430202750.3924147-1-yosry@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 30 Apr 2026 13:38:07 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNewmovAEECpoVXXOMtgo2xDeeMoA6LYe-5Tz5MG0r8BQ@mail.gmail.com>
X-Gm-Features: AVHnY4Jv3HrNifb9LIkdGnwnqzrMaD48MUaWxKdcz0y6I9g1knXJiPna6HQuCR4
Message-ID: <CAO9r8zNewmovAEECpoVXXOMtgo2xDeeMoA6LYe-5Tz5MG0r8BQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/13] KVM: x86/pmu: Add support for AMD
 Host-Only/Guest-Only bits
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 1:27=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> v5 of Jim and myself's series adding support for AMD's Host-Only and
> Guest-Only performance counter eventsel bits in KVM's mediated PMU
> passthrough implementation.
>
> These bits allow an nSVM-enabled guest to configure performance counters
> that count only during L1 execution (Host-Only) or only during L2 executi=
on
> (Guest-Only).
>
> KVM updates the hardware event selector ENABLE bit at nested transitions
> and EFER.SVME changes such that counters only count in the appropriate
> mode.
>
> The series grew significantly since v4, as it now includes semi-related
> nSVM fixups and selftests cleanups needed for the series. I think parts
> of this series can land independently (patches 1-6 and patches 10-12),
> but then the remaining series would depend on both.
>
> v4 -> v5:
> - Dropped moving leave_guest_mode() and enter_guest_mode() definitions,
>   since the calls to update the vPMU no longer happen within these
>   functions.
> - Add PMU helpers refactoring to facilitate SVM usage.
> - Added nested SVM fixups to count VMRUN correctly in guest mode when
>   Host-Only/Guest-Only support is enabled [Jim/Sean].
> - Update the vPMU synchronously on nested VM-Enter/VM-Exit and EFER.SVME
>   changes, such that counter enablement is reevaluated before the
>   instructions are counted, as the vPMU counts based on the vCPU state
>   at instruction retirement (e.g. using new EFER value when EFER.SVME
>   changes) [Jim/Sean].
> - Keep deferring vPMU updates using KVM_REQ_PMU in the
>   svm_leave_nested() path to avoid KVM potentially consuming stale
>   state [Sean].
> - Use a single PMU callback for reprogramming counters instead of a
>   per-counter callback [Sean].
> - Move the bitmap tracking counters into SVM code. The generic vPMU code
>   now only exposes an API to reprogram counters, and an SVM wrapper uses
>   it on nested transitions [Sean].
> - Drop the manual stack-alignment fixes in the vPMU selftest, instead
>   rework L2 stack setup in all nested selftests to reuse the allocation
>   and alignment logic used by L1, and completely drop L1-provided stacks
>   for L2 [Sean].

Forgot to mention, I also added a couple of test cases for:
- Changing HG bits on an existing counter after it's enabled.
- Event filtering.
