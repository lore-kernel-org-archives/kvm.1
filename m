Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017BE3FDC06
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437580; cv=pass; b=RfpnuzqzTuojtmokrIhKPRyBez03E76s7aVq6JQtVOr1/8iAxVGXcvaV850m9Rlz3li0huYTFkSDs7unQ69/xuSNVhZnu6OdR9V9VrHONfud/ntMsSyz7OjPveT2Xd2+YOM5Jca+3psdyW9b8ao2umUWMjcOaYMIgF41QTT9Pyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437580; c=relaxed/simple;
	bh=ACNA/Q8YZ4S0/IDVCd742R/sW2YbtzHlXkas+97+kCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmFjs6/FOqoIwPlNHcNFG6i1+2oEAJoosf55+Jevd7mJubDbo0DUKKgnGfEjjjEmqJu05tT8cn4wAYDt/RxSme1Arw4FMQF2GoVmwlrIYL2qFDi/kNnd+Fg1OCASmtBIbsU/bCxS9Fu/CGoqaRCunrBFI2mMPGu9JBGb/jcsPcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l2Z32lUE; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2Z32lUE"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69a45011a92so10942a12.0
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 08:19:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783437575; cv=none;
        d=google.com; s=arc-20260327;
        b=WucvDMgSC/A/WLCLj9k1HICECj7EeasmIxAHGQOrDd2Z1XMJoE73WwJpXk62XRdEmG
         E75LR5iBiNCiqz+ot+frxsSKN/e3uDBpU28QNV0UeobirJczyNa4eAwGebZlQCZ2iUHy
         GWofLtArrScPjBKiwX3imiIElggfIVTWC3a9vISwpuump0ZnYvkUhKxkenwYsW8BCzGJ
         Qb9hrOd02mUqC/XBJ6RwWHy2puY50HfsOMK+Yx737Ir+2F4nUartgFgw6xMHRGWdDWs+
         t5j12xA9r7MavJiR6wqfj29hlGMrRTE3m0cP2tM+I7o5O5dSThB0Bj5tCWnr98A0FZVy
         p5PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ACNA/Q8YZ4S0/IDVCd742R/sW2YbtzHlXkas+97+kCY=;
        fh=/4fnRduMIYoz2EFWyB80cDvrIqdOmDjmirFIuOERaic=;
        b=GPSX5r6JPUyr/uFzj244UlJyTCR34xHLzLmiEHCO0z2WgKfKwf22+mB0zFx1FRa5K3
         cd0IR8frqi96UME86yBMzI0HZcct9hOVG6I6AShh1WmCs/Xlw+hpzSWCr7pHCXMTv6qP
         6FOvsJGXYK4oe2cnicLlaHes7k+srqPp5Fzq8c7ZlPkelQZVQlMU/4cpr2Vlg39ZzM87
         XNNq7IzWwbmmCSlGjLLEEQKgSywzE6l5q/Pc3Sk3MTE6nb8zXggaZ2jtF+r3q/llJ0Hr
         MZpTFibbp5jP867TmY66NjoDp3MIozoi18jslnhUIrmccRzfH6sfONDoN8v4YoVIRXbZ
         RpIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783437575; x=1784042375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ACNA/Q8YZ4S0/IDVCd742R/sW2YbtzHlXkas+97+kCY=;
        b=l2Z32lUEirl5oc5VLsJtPqcgJ37pIdzlNt/PM/aDIWfKRosA5+dKWZ3aCSdi47zVIM
         J4j+Qw6lNAQXANqnm/plMqdgpn13vTQ+SJNCyok1H99rpnrLzNkWiZX0Z+SAh2O/dvfr
         3QSrCNCx2ewpK38FkzjqpkrDH3UKODpPPl29k19QHGYsU5ZdNyMGcTbMq/qfmkSlc/U4
         GOxYg8q9FbbCn69KAsJ8V7HX/CtcOxdhHKWsWVp4kpmyroqXu/XSWRGTl/EFvKvSpuYg
         HLcRfqAu127tHZe5CndM731FF8v6qzCh5xFa1YuT4zuZMak9qLFnB75TBtN8Pu+/ux8G
         +rEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783437575; x=1784042375;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ACNA/Q8YZ4S0/IDVCd742R/sW2YbtzHlXkas+97+kCY=;
        b=iSlyjQIFZYWV9jdOXlUaoV1c71o9eyohuUHMJDpJZQ4T6mzPpmZ23VkZ+aL7T9NxNZ
         DdJuR4tHijdFVjNqpIPtZIbT2/UArD4tJFi9PSrAiQ4FmozXTl12w7klnQhhUwdvLzSV
         qpWhfbgAf5E1VwG1PiBETzaMM/yd3NRb0a026T/weDXdiTCaddSkJc4xRjhi7eJ0Y0om
         J4hZYEWmlOl3scJZvj8Q7uH/rtYdA5IuWuZoICT/Aqi1ucFm4fd/bzrIaKVuagmUURH2
         xktzNsFa6Iq1868dZQRx3MSnxTK6ov9BNezuFgiCSUSOZnXUz+a84jcbu/XqJcp5xiPj
         BdMg==
X-Forwarded-Encrypted: i=1; AHgh+Rp6Bmp+3qcv7eoWQFoFgz7dIfXQ5/j99m8Z0As7ea1lGOldGrH6t3hjqCV1nL2CASrYVJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzVh4S7kwExW8U4HQuZjBA03H/Fj6Vc5H5QhrMqDT4848Au3k7
	nTxoCpQ3voykX4QN7PpElU7cmiv2B2f45XlU8JerVI/1qqBA2nnonbj66nf+gJUYJ0IeHkFB3Rx
	zTgvFRqLsp6sbBZLTkjW9wJIFh7TuToPnoe7BEbUM
X-Gm-Gg: AfdE7cnDIhx7uDT4vxDXbEaTTWwg9AOPVyH8egErSszB2rvpE4ZoUNR7OBbDTCMx2vs
	SAArY+4TrZNYSQd9OsadQ9AMOcVX2k4tGSka3dpM/7tOs1/jNGyJzNm7+UfyLI3GmwuNkDqWghH
	y70G7Au9yJ5JyqrREZVhasMSARVDsjIM8RVzgvmAsH8wOSJXtEy/sJKD6RBixM5mjb7zNlzelAp
	ypJSPfkkDwIqk7gzjqiIIMkekwlLZYRae/phVr2jHBibbWqGL9f0K0Fg77wYNovKz8mL7UH
X-Received: by 2002:a50:8dc6:0:b0:697:5678:bc77 with SMTP id
 4fb4d7f45d1cf-69a913a7174mr40955a12.9.1783437574125; Tue, 07 Jul 2026
 08:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629125205.52394-1-zhang_wei@open-hieco.net>
 <CALMp9eSLH7pT7X22es+AotxhRMQ1VyziWWELQu6_ZRsyuQ=xzw@mail.gmail.com>
 <0e576fd8d8cd2ed1739cee36eba393fea7745506.camel@redhat.com>
 <f70b4a3b-1ac1-4269-ab7c-0ed1fb42c357@open-hieco.net> <CALMp9eR5jVLGeQck89kro1ocEX5aZcovdGMK+fuzXjqK1NR7kQ@mail.gmail.com>
 <d5645a47-c346-4e63-a5c6-c88bb39a3ee1@open-hieco.net> <akxwt1mX6blSnkxI@google.com>
 <CALMp9eTr0iJ5QgbZJ0YtOZg89XVFSesbyoGGdtkz+f8c60DcDA@mail.gmail.com>
 <CALMp9eQXGYevLQJnEV+Kx6hvp84vPQ=2U8AfZHiZrZj=CVM2hQ@mail.gmail.com> <ak0QYnYvchKTnwxS@google.com>
In-Reply-To: <ak0QYnYvchKTnwxS@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 7 Jul 2026 08:19:22 -0700
X-Gm-Features: AVVi8Cc6lIIBt5CRHwGeZ2r-_zLxB-gN4Cuzj750XAPKtpyteKuQgIRdSaJTEL0
Message-ID: <CALMp9eTK-Dg24geFN6tnkoD3rc4ct6eZcHCBv3EvPYOhBvaFaw@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM: nSVM: Expose DecodeAssists to L1
To: Sean Christopherson <seanjc@google.com>
Cc: Tina Zhang <zhang_wei@open-hieco.net>, mlevitsk@redhat.com, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 7:42=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Mon, Jul 06, 2026, Jim Mattson wrote:
> > On Mon, Jul 6, 2026 at 8:25=E2=80=AFPM Jim Mattson <jmattson@google.com=
> wrote:
> > >
> > > On Mon, Jul 6, 2026 at 8:21=E2=80=AFPM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> > > >
> > > > On Tue, Jul 07, 2026, Tina Zhang wrote:
> > > > >
> > > > >
> > > > > On 7/7/2026 9:32 AM, Jim Mattson wrote:
> > > > > > On Mon, Jul 6, 2026 at 5:02=E2=80=AFPM Tina Zhang <zhang_wei@op=
en-hieco.net> wrote:
> > > > > >
> > > > > > > I will take another look for the next version and try to hand=
le the
> > > > > > > remaining pieces properly, while also making sure we don't ex=
pose stale
> > > > > > > or incorrectly synthesized decode-assist state for emulated e=
xits.
> > > > > >
> > > > > > Naples erratum 1096 seems to imply that the instruction bytes s=
tored
> > > > > > in the VMCB are not necessarily the same instruction bytes that=
 were
> > > > > > fetched and decoded to lead to the #PF/#NPF. Hence, in the case=
 of
> > > > > > emulation, it might be sufficient to read the instruction bytes=
 quite
> > > > > > late in nested_svm_vmexit(). That would certainly simplify the
> > > > > > plumbing.
> > > >
> > > > The plumbing doesn't seem all that complex though.
> >
> > What about the case of a userspace-injected #PF while running L2, when
> > L1 intercepts #PF?
>
> That can/will be handled by the fallback logic of reading the code stream=
 on-demand?

Could be, but I would prefer consistency.
