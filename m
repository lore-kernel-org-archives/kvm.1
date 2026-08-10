Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A4535836E
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786397426; cv=none; b=NRU/1exzt6rAvw9l+0t19EE8y8R1WaWguXjRkafwaHAoAQtyE2GcYgFirYbtxjXfROVysh9TldZULpQBUYSotlHxB4xCHRGFs6G1eNoUgzphJVMbIj/0cqFsYy5zi0ZIF4n9p0neOgTCqih++uuuivbk1m3szE8qR0gZxxRvnbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786397426; c=relaxed/simple;
	bh=CMi2mCw8OCyDbizhoDvuTgZOACWu9UYTt63KQGE/aC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAuvEBQO0GaWHUcQ1WZz3AuaGlixvG+PzFCex4KONH8vGPw0wR7Iq9zFuf1S/wdxzXaR7iaJJWFUwYOpfaUS5cf/6gfnuHNqTYdVh1OKBymosypoqvbHUiUDYXPHU3z1UejVYAfuARTVr7aXbfJVGe3HUtT46GpZJWb8fmxW7kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YseO44Eg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YseO44Eg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C131F00A3F
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 21:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786397425;
	bh=CMi2mCw8OCyDbizhoDvuTgZOACWu9UYTt63KQGE/aC8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YseO44Eg9HujouZJqCbH+kTOhXbEaeBrin1xEINHPQaQJRL3yxRH9wSQa8JCHoEkp
	 bxFeY/Ht67jB6dzEL2gv8KYitpe3dwt4ajhaE9bcoZ6YS8yYtdyj8nLaNOOYmCZWel
	 vV19Oe+79oDGNplHSg8DPN55zQVbho9T8iILGqf36pYuC1MGAR/c78HODVuGAuSo/J
	 3vy9dq2bIGBbrKU9QiTXOB9z5xg+2fEqiSGC7haxBeJjyilF9+MJixPI55rQ23hAx1
	 yHIKYGetDu986KVJxSIGBx5PwI4NNG57xGd/H5Hvr8wWNkZ198keylwBphbyf70FvN
	 gGkDr2tSz3qmA==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a20319d030so2518449a12.2
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 14:30:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqeOnzV4QzJo6UxlXV428mGCuVNmANigUUNx6LaidqSQuiUIiDeDOOyNKDoblwPdJm/zvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxdiL9nv84+4sBocFe8N4AJ3zLBJGpi/zKKLhAX3IgZwyAbYr5
	19foesKxbkUK9gw4Hd4bNXri+opwJtWNOit8PYvIlCR/JEOrx0/XBITd1KwT59yWmqXH7dzF/T4
	JM6q0dM3uRxH59YMFg3vZES/lSyJTPRk=
X-Received: by 2002:a17:907:97c1:b0:c20:83b1:396c with SMTP id
 a640c23a62f3a-c2087507854mr1153439366b.17.1786397424438; Mon, 10 Aug 2026
 14:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807135327.2629594-1-pbonzini@redhat.com> <anYQsMnpS2kpYoqA@google.com>
 <CABgObfak2WM10cj4eQ0DejFQPjsK1ftjS-y2Ygr_gcPs=KyChg@mail.gmail.com>
 <anZehP6yD66SRsNj@google.com> <CABgObfYqWf8WXNTZtz+W=CSK8yrGJhDruObp42LXkywhyK6=0Q@mail.gmail.com>
In-Reply-To: <CABgObfYqWf8WXNTZtz+W=CSK8yrGJhDruObp42LXkywhyK6=0Q@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 10 Aug 2026 14:30:12 -0700
X-Gmail-Original-Message-ID: <CAO9r8zP8=M9yx80SZhXXAThFbbH5wNRRnbZyy1tNF6A1JBy5FQ@mail.gmail.com>
X-Gm-Features: AUfX_mwVOpimYddd8A_AxwUbqyFGWD3aVX5A17szSMl-m_GkZwHHY5-QI4KGqGc
Message-ID: <CAO9r8zP8=M9yx80SZhXXAThFbbH5wNRRnbZyy1tNF6A1JBy5FQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM (mostly s390) fixes for Linux 7.2-rc7
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, 
	Tycho Andersen <tycho@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 10:43=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Il sab 8 ago 2026, 00:39 Sean Christopherson <seanjc@google.com> ha scrit=
to:
> > On Fri, Aug 07, 2026, Paolo Bonzini wrote:
> > > I consider two weeks of wait, on a review that so far had been
> > > exclusively about taste, to *be* an honest attempt to gather the next
> > > round of feedback (which never came).
> >
> > Heh, and I was waiting for a response to Yosry's thread:
> > https://lore.kernel.org/all/CAO9r8zODKgCcjTBK=3DP6BuXBBZRoOAFMeRJU8BmkW=
L-BCX2LoBw@mail.gmail.com
>
> Heh^2, "Pick your poison, I guess" was not really inviting a response.
> Overall the sense of my reply to you (that is: there are two callers
> so let's not overthink wrappers) applied just as much to his message;
> and checking AMD vs. Intel in common code is a total no-no so I kept
> the reply in one place.

Aside from the code itself, I was really hoping for a better
understanding of the problem, and answers from AMD/Hyper-V folks if
possible.

Basically:

(a) Is INVLPGA intended to be used with NPT enabled to flush GVA
translations on behalf of the guest?

I assume the answer is yes, and something is broken. But if the answer
is no, then we shouldn't be looking any further and the fix proposed
by you/Sean is correct regardless.

(b) Does Hyper-V use INVLPGA with NPT enabled to serve similar
paravirt TLB flushes?

If the answer is yes, I think it's likely there's a KVM bug and not a
hardware bug, as I assume the issue would have been caught on Windows
sooner. I don't know if we can realistically get an answer to this
from Hyper-V folks or who to ask, but I think an answer would help.

My goal is to make sure we are not papering over an existing bug in
KVM's Hyper-V code. The fact that hyperv_tlb_flush is flaky with NPT=3D0
makes me suspect there's a bug somewhere in this code, and it might be
manifesting differently for NPT=3D0/1.
