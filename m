Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D2137EFFD;
	Sun, 27 Sep 2026 06:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790489600; cv=none; b=T2uNAsYB+T/T7qB5lcmPyZL/WdVuDastRvGr2NS12Sg15GAQn/QQC96jokUdet2KcGbxKRtdq4F78y3FRWmT/efIw25oX7h0QbM3AFn7wg2awTpIT/mgEEh0gof08pywucwV72FDgWksMtCKUp222vy6a06FiG9j2TNrRzQzyjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790489600; c=relaxed/simple;
	bh=kdin6L0IVJjrk+QOsk1dPyg8rF3qB1OP0mS63CgSzCc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9yuBJN+mY3c9fbELYn0HjRmx4PPeGiLg6LiRF+DB1hKawPWOtxf1TKtybGzA7v0O1Zsmbr7Su2fysyMICEwS+t4ig/QnSNE+bEs8YmP+/z2wMcnNU1qexuFwyQ6wFaMs+ywuRgt7qenqb5Roso8Itvd/CtMHh/aYiGyDaOpLkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=mbapcwrm; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="mbapcwrm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1790489592; x=1790748792;
	bh=JZdBH5RBcOxyj1ZZYidO9SxOgrHbVHCuiLvkH6A15Dg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=mbapcwrmZw63dw8ABgcc9K4QT6f9qfgUy78MrM0KoP+7KnHzxpGhaYeT+DQwElfPL
	 PeHww4Gk9XtZDKUwjndRtsnhVYiYqlVf47cBaeBwV8Rjaixfm9TXy4XKDMDOV05V/M
	 mB9UFc46yqz+H5327bFrjrcvPO1MtXnnJ5KRIxb3OZ06QMhIONy1xEH4f6YBk9S5dK
	 TN151etAgeYWXVEzocwMEW1l712PyZPS2iEfoTmqM/WJ2Kq907z2i8Aa2SAIGNg6n1
	 7X9p8TNWBstUqGuPvHZbn9YZyQ0Pspt5wmnNgVDhrGI3CiMScmyRmkrUJDSpSceyhV
	 8kSVxjJxWf7Lw==
Date: Sun, 27 Sep 2026 06:13:08 +0000
To: Sean Christopherson <seanjc@google.com>
From: David Ballesteros <davimaba.v@proton.me>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] KVM: Fix and account mem_attr_array reservations abandoned on ENOMEM
Message-ID: <shvokigIdaYF83vU8rik51QxCt-IWzK_vNIV72voXL13vdzqLnE4pdpMT-le6GLd7K8VWiWRTn7lpzJDzLBGYxPIhgdbr5MfPwnUY9lc1ME=@proton.me>
In-Reply-To: <179028303710.1997669.4762091811625597120.b4-ty@b4>
References: <20260915175335.138547-1-davimaba.v@proton.me> <179028303710.1997669.4762091811625597120.b4-ty@b4>
Feedback-ID: 219068424:user:proton
X-Pm-Message-ID: 844c56fc53ee4a4ce873b2a65ac00800158fd6b7
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Haha, I didn't even realize using AI would make me sound like a bot
until now...

Jokes aside, I truly appreciate your kindness. I have to admit that
even though I tried to review everything as thoroughly as possible,
this was my very first patch submission, which is why I found it a bit tric=
ky to follow all the conventions (though that's no excuse). I definitely le=
aned too heavily on AI for the write-up. With that said, I understand the e=
xtra work it causes and I am truly sorry. If there's a next time, I'll writ=
e it myself -- AI at most for a rough first pass, but the words that reach =
the list in general will be mine. Best regards, and thanks for the guidance=
 and patience.

David Ballesteros

On 24/09/26 16:54, Sean Christopherson wrote:
> In the future, please don't have AI directly write changelogs.  It's
> fine to let AI generate a rough draft, for me at least, AI tends to
> be far too verbose and uses terminology that isn't common in
> Linux/upstream.  In other words, AI tends to write changelogs (and
> bug reports) that require far too much effort to understand.
>
> Gripes about AI aside, than you very much for the fixes!

