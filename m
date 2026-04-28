Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B36926B756
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 00:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777336503; cv=none; b=XQLNm2Q83IQ4CBzjjyuA8nM5DBH5F/NGqFqq5NFPzce0s9ZppzzvfXBZ03hyLDvMxxn2dnat/5dEeFsS3q83ikq4X6CeMpOU9Zqejg+JzDPT6WNPRVAsqFKoQqoj5s7EhZ1qYx+1TqmGRR373Z5OjFkdvQJbjRd2dF2gvKyJzAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777336503; c=relaxed/simple;
	bh=VU7gOJ+5wxhNR1OzHSJgq+tbEUT8+vrpRnrbXZ/o5f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/usNtIFXjxp5+eiAlO9gP6ayUPaZ3SOqzxwbK0Zz/p/t3neja8XtTZxvfcpWrhcI2msWBWCajTJjxV8dvjbDpdfpjMIBjBnSLWTesqJx1+ClNJpr4L8hOjk8GMXWCV9odZBTsqq+Uo2B9CE99VKEpyTcOVdQiNIK+2VYxBXLnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jk0BUro0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jk0BUro0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80667C2BCC6
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 00:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777336503;
	bh=VU7gOJ+5wxhNR1OzHSJgq+tbEUT8+vrpRnrbXZ/o5f0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jk0BUro0QTno6bVP3hIuG3fUtnwrDNOKFFDy7R5iLKlNylcHgjbwsEXv5cAHv0SBm
	 NVT1e3YlZrx/BNK8LUSVASyIWQM8eNBCsOJ+9hA5kdD2x8+sH7fpJvuPcLWZFYRqo/
	 Pw8JMSZHGpwxLDgsnDRCc9v3Ta+1KR4t0yfdGgSE644HqZSiMpb2QtBGmY7huRqW7j
	 VrEuQPAMEwZtS8kusqYTtyy/cPvGXY8jslzbSqUgF4vq0erimgFTs+Td1f2E4c3TlR
	 tWlxCBUvEinFcx97AtwMI6cj9toUtIfWOuxNb2+Pmyj3y7qcoo2RK6jIBtWT91EGMV
	 ofRdrr0c0ozLQ==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67845996252so8496374a12.3
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 17:35:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8VzaLyVAPrGEmynDwsWDTQEBQGSsmuL5A4Vg3+lDrHyKeqZhGCUjA/f3Acso5r1+ZIkSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnTkWGkBIeUNBj4Y3lrbyFWzkXwSInV+AX3iJ78HE2QtyRx01i
	iVkPYcMJniUJbJ9R2kVP9dPxXZcOG8ECN+Y8tJupCo+PFtg/SyHHYS9Yu5ynUh/MPEB6SWZ+k1M
	lfEcU4YOg7Ewx+cnGRQ+J1E2bZoU1yno=
X-Received: by 2002:a17:907:c48d:b0:bae:8112:e272 with SMTP id
 a640c23a62f3a-bb8048338fcmr47712366b.39.1777336502327; Mon, 27 Apr 2026
 17:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326031150.3774017-1-yosry@kernel.org> <20260326031150.3774017-4-yosry@kernel.org>
 <adReHbkVRDGOihb4@google.com> <aesRPt5Vpco29vAt@google.com>
 <ae-v3aGftsAQuG5E@google.com> <CAO9r8zNzyp4X8Pny7aFAjX8swSxpfmwu7GF9Ry7Kz9GSKpw+bw@mail.gmail.com>
 <ae_3BWwjHiYC3hzm@google.com>
In-Reply-To: <ae_3BWwjHiYC3hzm@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 27 Apr 2026 17:34:50 -0700
X-Gmail-Original-Message-ID: <CAO9r8zN-qru58rsBaTDae+5zGp=6eJRkYFDqdGhy7SYPwt9+pg@mail.gmail.com>
X-Gm-Features: AVHnY4Jaew01Ik-RAxch8XUsEcheMupOzs0tA2L5VYjiKnpMJqO2jlzUBmEnskk
Message-ID: <CAO9r8zN-qru58rsBaTDae+5zGp=6eJRkYFDqdGhy7SYPwt9+pg@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] KVM: x86/pmu: Disable counters based on
 Host-Only/Guest-Only bits in SVM
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 4:53=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, Apr 27, 2026, Yosry Ahmed wrote:
> > > We can have our cake and eat it too.  Add svm_pmu_handle_nested_trans=
ition(),
> > > but then also rename and rework reprogram_counters() to support both =
deferred and
> > > synchronous operation, e.g. something like so:
> > >
> > > ---
> > > static inline void __kvm_pmu_reprogram_counters(struct kvm_pmu *pmu, =
u64 diff,
> >
> > I don't like 'diff', I think just 'unsigned long *bitmap' and pass a
>
> Hard no.  I agree @diff is a weird name (I was literally just copy+pastin=
g the
> existing code), but I _really_ don't like passing a pointer, especially n=
ot to
> an unsigned long.  The bitmap usage throughout the PMU code is mostly int=
ernal
> implementation details.  But for what is reprogram_counters(), and what w=
ill be
> __kvm_pmu_reprogram_counters(), the "counters to reprogram" is very tight=
ly
> coupled to the architectural layout of PERF_GLOBAL_CTRL and PEBS_ENABLED.=
  And
> more broadly in the PMU, for the layout of GLOBAL_STATUS_BUFFER_OVF_BIT,
> MSR_CORE_PERF_GLOBAL_STATUS, and probably at least one other MSRs.  That =
all
> should be captured in the APIs.
>
> The other reason I don't want to pass a pointer is so that even when the =
source
> _is_ a PMU-internal bitmap, it's super duper obvious that the source bitm=
ap isn't
> modified, and that it's operating on a snapshot in time.

Sounds good, I will keep u64 (and maybe name it 'counters'), or maybe
s64 as that's what kvm_pmu_handle_event() uses (and what the atomic
helpers take).

>
> > bitmap in here like most PMU code?
>
> FWIW, AFAICT, passing a bitmap as a function argument isn't common at all=
.  I
> only see kvm_for_each_pmc() and kvm_pmu_trigger_event() taking a bitmap. =
 There
> is a lot of bitmap _usage_, but rarely does KVM pass around a bitmap as a=
 function
> argument.

We still need to pass a bitmap as an argument to the
reprogram_counters() callback that we'll add in
kvm_pmu_handle_event(), or would you rather we cast the bitmap to s64
here as well?
