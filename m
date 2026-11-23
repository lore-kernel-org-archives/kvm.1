Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464733;
	b=zHpIwCTIL1UPvrcHN11Vcub2VoXf+UqCMMGe6hJBttvAM/eOD/rQdo41QaOpPv6gb97O
	 oIX8KBjqvZlZ+KCyWNv/aNToaR98qS339oDZYE02XqJrJzc51vEosiClyjoSRuitv2RYJ
	 rCwyIZTozo2HmhA/miFc87byU9/xqMJ/lyHM7cIqDfkIAYDgHGyC6wTB2FKGNbLQNBPcD
	 OQLEExyJORT1pxOEKDQaNh1ZZpBZTrZSIEXSatryLdN2qnAa9bY3jwBzJS8cCeS8fz1H+
	 Ktoqm0yyHWqRUoLG+aKs94U8nJIPD92EnGSfcrv8Kzz/tsQQNpVzha6CS8zjP+xzPAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464733;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=p9GjRkDbyeFLjmCTR3HgXfh5+QYEICACuiJ0UKaOX9I=;
	b=WRFrAuFMcDJ448ybPKpnEyL5l8g/78CdZs7Ytd/XTMftZ4Nlg+lsitPaj2wc7tapkcXf
	 68DU8tPKmhtFU4awqlBiVIbHVENyZrqkZpQo/P+EXMtXVOl5Dn5oGYxGT0eoGSFpCJB+5
	 bt2fYbcf3ubC+GOUjlVX40Zcu9iwYyKUADQbd2OFuaem9a6lz9pP/elLtii7Nq2LyMsZb
	 sBW3k8iPV1fxOsuTNoEA3OL1DZJgKTkBkBdPK160a2aRk7l232Tf9NCdz3Oty/hsTxXAt
	 w+vkl68UpeFs+2jC4IfClpikcGn1d0GrPiHCGHSDdwvbOgeYRA28C0QnQhYZESLSQWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAEM38V0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839A9606A31E
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 20:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAEM38V0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF5F1F000CF
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 20:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795464733;
	bh=p9GjRkDbyeFLjmCTR3HgXfh5+QYEICACuiJ0UKaOX9I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aAEM38V0SdWRa6RzQQGWSa+DFlprlEM9H1dbbRVzL3vVlzlha0nG31uDI5X3bHQDC
	 jKJij0VxY3UuSm/2eXjKKnJZ2Jel8Gj0bxQS/2ynxihcufoxhTTQH3eobSf72LbJBf
	 l51lLkSIsZ9xsq3U0ux2bIfIhJw9XwBo7SdnSLzqOolhfOVqlxoH66jUaxi0N8O2jj
	 /dcUmMKWAKzfQ98SCmOhUccEOWdCN98QTqtM2q20lpBj5ghqXvSxxvDOq4owichCQH
	 6LYbgpXvFgGNs+aTd7Pj/7vOMNaEB0Ivb9oWXEeq2CGuCh8DMvi+J0ATc407gh2Yqh
	 1BNAH1QMkBlnA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so614810266b.3
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 12:12:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF9/PzD9neU5HiEwJNPgX2eQEJK+u8MK6UcIHlpKl0vW+HGU2JCULwA6PyHpJc6f/wt/Co=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TRuYwzR1tQNrxYDjXPnXlKWF6EhT0F/ZmlrB7ypznq22CWXu5
	DPfUAg+rVvK7cMy+wmD4/YriVrtxkvGmJbr3UbWQojzqh5jUIv4BfacanW9n8m+dTf63mDQhCOl
	0vOxeyVPBwu2skGqGQ9NFNTOPB1hWqIo=
X-Received: by 2002:a17:906:9555:b0:c50:52b5:e17 with SMTP id
 a640c23a62f3a-c513a5e1d53mr869861466b.13.1795464732153; Mon, 23 Nov 2026
 12:12:12 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260428133524.3628482-1-imammedo@redhat.com> <20260428133524.3628482-3-imammedo@redhat.com>
 <asSgCLgeSCKh33_n@google.com>
In-Reply-To: <asSgCLgeSCKh33_n@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 23 Nov 2026 12:12:00 -0800
X-Gmail-Original-Message-ID: <CAO9r8zN_6afHGXu0rN4zZVuwn63eH=tbsnsKu1+CG8mUrRQeNA@mail.gmail.com>
X-Gm-Features: Aa3M54pUGXQWvVOGsAAatrCCjQMcySJzHD-CrDFpFyPR__zxvbf77SKMx3Ktg6c
Message-ID: <CAO9r8zN_6afHGXu0rN4zZVuwn63eH=tbsnsKu1+CG8mUrRQeNA@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH 2/2] x86/apic: add retry logic to test_apic_change_mode
To: Sean Christopherson <seanjc@google.com>
Cc: Igor Mammedov <imammedo@redhat.com>, kvm@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 12:15=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Apr 28, 2026, Igor Mammedov wrote:
> > The APIC timer runs at wall clock time under KVM. If vCPU is stalled fo=
r
> > long enough, timer can expire before the guest reads TMCCT or tick well
> > past expected values, causing various false test failures [1].
> >
> > Add retry attempts with increasing timer period (10ms, 60ms, 700ms)
> > if any test fails, to handle spurious failures due to vCPU stalls.
> >
> > 1) Failures we sometimes observe in CI are:
> >   "FAIL: TMCCT should have a non-zero value"
> >   "FAIL: TMCCT should be reset to the initial-count"
> >   "FAIL: TMCCT should not be reset to TMICT value"
> > Seen on both Intel and AMD hosts.
> >
> > PS:
> > on most test runs, test completes fine on the 1st iteration.
> > The patch would affect only failure path which will be slowed down
> > due to retries but still fail if there is a bug with benefit of
> > getting rid of false positives caused by vCPU stalls.
> >
> > PS2:
> > Number of tries and tmict delta comes from analyzing vcpu stalls
> > on heavily overcommited Haswell host with test being bounced between
> > 2 sockets.
> > Typically 2nd iteration (60ms) is enough to get rid of
> > false positives.
>
> Blech.  I would rather rework the testcases to simply not be flaky.  I do=
n't see
> any value in waiting for the TMCCT to be half of TMICT; just validate tha=
t it
> counts down across switches, and that it can wrap in PERIODIC but not in =
ONESHOT.
> We have a KVM selftest to validate the timer counts at the correct rate, =
so just
> validate the core functionality here.
>
> E.g. roughly something like this?

Igor/Sean, do you intend to send a new version? I am running into the
same problem when running the test in a VM (i.e. nested).
