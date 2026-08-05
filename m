Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8ED3E00B4
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942148; cv=none; b=uigJJLgMDa0OZWXF0iaL4V1k+0rMgIYkjGvBOLu7dJe3HNzJU75KGFKl6N5ShJkR9azPG62H2ZCdoNsRtxolk50c3TMcNzew/EZ5K8WkVAdJD18KUKjWIJW6zkkkvjnSzsKMdyjvb79usXBiopJjWiREnmY0ECmnvwLYsHp/sl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942148; c=relaxed/simple;
	bh=8LMT5bU0zQEOYfpuxQllNsPHFyfqkRQIq/eWwPqpts0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aT/RcxMzqfsvgMcwsQHaq7eWpWRQtnJIxSsZ99BQ7iR8YDR9dJqw3zhguScgA14iCP50txpaZJnwexyxF/U6pQ/YvavWiWUTiptssQq8Fp38oSk4ztCo7+m+lKpeUbNaE/0NaKd4n8LZf2xQXTDb1+r0YnbEob29nn1wYWyb6PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AhCrC0bl; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AhCrC0bl"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so1241620a91.1
        for <kvm@vger.kernel.org>; Wed, 05 Aug 2026 08:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785942146; x=1786546946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VjfqoR3w5axB8x7Z39XZV2zZhI8umK3vx0Q0ZTY5HpI=;
        b=AhCrC0blkBQV530YNcOWubte1v2wYV4LdgnYjyqf/EHQK8UTkD/KHwGMbfXxYk/2g+
         8aipBFirIRk2/d1lrgkfEcwAiKDCNuS5EDNlNeaDlxSJe1Sly+86CHdM+uYtV0lnMKPx
         /VJhh4L/wTGJYXmyLG01+fETu5wC5EFAwrvlqdMcsKWFc3600jdXgEb7RFcVDcvq64/j
         6d17iEaDwnltelT5GqBZmO0DM2CXjRr4XfM4ppBl/VTi8rhsjT/BdkQ5jphAe7mgV+pO
         p8heMZJ54lstta3gzHM61YPdvPfU/UiGpWy7KsrIT0ooLM37VZ6ZUiW2U55WOwcpJatr
         Q6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785942146; x=1786546946;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VjfqoR3w5axB8x7Z39XZV2zZhI8umK3vx0Q0ZTY5HpI=;
        b=KO+UEn9nReZWVAUqq4GMJXCqiEmAPxdXCzahflTwUflsdEfDfo/fcEOL84Djgq3m7m
         6c6w7yQysQlIhfWO5rA4eK1YF72kR++uXTwYcey7e4LZCvGgdV9oNwRNI26vEJr8V0ts
         BkD3EFyt+2HKWqgAfwh9X97DST1H/8EndLnp4cfoHsvVA1PiSkmgdH3m9TinoHfBVGl0
         FOKxw7qvWCw8XCx70mDrspRc8OKCZ+VN/IOz/9ynXI3sXy+Y5VOgqW8TCZfGhAJCFJDe
         7mtUClBDy9m2uqgR6kgvqSIPGqbg7jeJ1bC/e1xHytNO6QJoXEU2HS0fNCd6+TNbwznK
         2egQ==
X-Gm-Message-State: AOJu0YwD8HfoUt9x+0BDZ5qDKA5jIC9R5LnOIwY0V8a6RMoW9uFboh4Z
	WwF7/+VB/o1Wh3Tu6AACyPENcKo0FZ79/yNszKJHFEwAYDHHS5OKj2zKqfGhNI4CLXhC2v0ATFK
	i9tlBCQ==
X-Received: from pjboo14.prod.google.com ([2002:a17:90b:1c8e:b0:38f:a3cc:f600])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17c6:b0:38f:1a2e:6e56
 with SMTP id 98e67ed59e1d1-3903c59330amr7021405a91.9.1785942145048; Wed, 05
 Aug 2026 08:02:25 -0700 (PDT)
Date: Wed, 5 Aug 2026 08:02:24 -0700
In-Reply-To: <88a9c8a0ccd2268216b9ac7af708cd2d7ad1a986.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260805000640.827BF1F00A3A@smtp.kernel.org> <88a9c8a0ccd2268216b9ac7af708cd2d7ad1a986.camel@infradead.org>
Message-ID: <anNQgDSbZmgOuPRD@google.com>
Subject: Re: [PATCH v8 04/17] KVM: x86: Activate master clock immediately on
 vCPU creation
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, sashiko-reviews@lists.linux.dev, pbonzini@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2026, David Woodhouse wrote:
> On Wed, 2026-08-05 at 00:06 +0000, sashiko-bot@kernel.org wrote:
> > [Severity: High]
> > Instead of checking the boolean use_master_clock, should this check and
> > consume the pending KVM_REQ_MASTERCLOCK_UPDATE request via kvm_check_re=
quest?
>=20
> Oh, all right then :)

LOL.

> Sean suggested exactly that in a previous round=C2=B9 and I said I though=
t
> I'd tried it and the request wasn't set. Having paged back in some of
> that context... the thing which didn't work was a different variant =E2=
=80=94
> deferring with a bare kvm_make_request()=C2=B2, which fails because
> KVM_GET_CLOCK doesn't process vCPU requests, so calling it before the
> first KVM_RUN still didn't work. That isn't what's being suggested
> here.
>=20
> With the code as it stands in this series, the first vCPU's
> kvm_synchronize_tsc() reliably queues KVM_REQ_MASTERCLOCK_UPDATE via
> the use_master_clock toggle in kvm_track_tsc_matching(). So
>=20
> 	if (kvm_check_request(KVM_REQ_MASTERCLOCK_UPDATE, vcpu))
> 		kvm_update_masterclock(vcpu->kvm);
>=20
> should work, and is better than checking the boolean: it avoids the
> repeated masterclock update that Sashiko is whining about, while still
> honouring the case where a mismatched new vCPU should *disable* the
> master clock.

Roger that, I'll update for v9.

> By the end of my full series, this call gets removed entirely in favour
> of setting up the whole clock epoch from kvm_arch_init_vm()=C2=B3, which =
is
> why I didn't care much before. But that's now on the far side of the
> part 1 / part 2 split, so it's worth fixing here.
>=20
> =C2=B9 https://lore.kernel.org/all/amPW1eAPpUuxLoj_@google.com/
> =C2=B2 https://lore.kernel.org/all/58c5a521b94e8d90e101602cfe160d1fb128a5=
dd.camel@infradead.org/
> =C2=B3 https://lore.kernel.org/all/20260728144954.355376-29-dwmw2@infrade=
ad.org/


