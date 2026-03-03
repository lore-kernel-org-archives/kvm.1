Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D901F14EC73
	for <kvm@vger.kernel.org>; Tue,  3 Mar 2026 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496599; cv=none; b=TyqEoUPylKNALWZalEA9ak1mehlMxfRxlo7jVTvVA9rM2ev3BxGCJyxrgJDyeyTNH5bjpwaYWZHPLTjcPJEc1mDVwVlZ8my/Ia83rjzhIt4QvfhkcryH3AB5JJHgUWeveHtwu6PzgHTf8nhMxFrsrZPC/iW7UNOgdhO/2WDkn2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496599; c=relaxed/simple;
	bh=tDCx+wrVcW7oxDITeHDBDVpGFNi3v8MH29hT9SE3gu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwgFHnAdQqsHn0FHCPT6APdr3s0dWfkj/2shO0lvwx3zvFl8LZaucJjj3dv7+5wp10TpaCwc0udfZa6H1AMmDhScDgHR/F2E5w5enZHyCOK1Yb50QsGNofpEJBNu9RQxyVKiYpoQnYIwzXS00Rq2HOIn95MvVU7ZqYuPV4S7qgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6nGsYu7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6nGsYu7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD22C2BCAF
	for <kvm@vger.kernel.org>; Tue,  3 Mar 2026 00:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772496599;
	bh=tDCx+wrVcW7oxDITeHDBDVpGFNi3v8MH29hT9SE3gu0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V6nGsYu7YI33DpbzmtE+LPx1azL7p/MN6tjWZfonJEAhHlSXPqeRtmDrT00LaYHsy
	 ZyBH6252GmFyTfhsZm++v+Z1z0hn+UZNRR17Lqx37yJV9LjfzL3hyrp1ZpE8rXgOpr
	 jdDAv2t6J2ViM6rqZj6TcmbawwwI5ggWxrrX74Mn8s0iNy/im2Lh7NZcImdxG53y43
	 sYVtofs8Y09wzhUCKok86MEwCNZfAp23n0iDoKeqwNt+WC1Fj1w3Q0RBCp5Q1Jjtqx
	 +4vQUqow9Ejh3yQjUBkK/VcbRumuiYNpXUNn1i8wfL7beAQKBiD1dHchSAE7VSXzIR
	 2ofaZ8tg4bXbw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b936331787bso811472966b.3
        for <kvm@vger.kernel.org>; Mon, 02 Mar 2026 16:09:59 -0800 (PST)
X-Gm-Message-State: AOJu0YwMrM6UNtzWuv8gI4R/qbDjlsaR2dvZBHXPO42MqU6gqZcNtxHw
	8+gieDDwZV2bWjHU+ryjRgKbP9r0O7v5Q5KGKfmJqvfSPjjElf7oWDGaq8v52BTGkqL5Nsq5smX
	mel3ftRlyYkw5DKBcV+OmXkK7PiPLfbM=
X-Received: by 2002:a17:907:9349:b0:b88:5957:2d65 with SMTP id
 a640c23a62f3a-b93764d4404mr812643166b.37.1772496598373; Mon, 02 Mar 2026
 16:09:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227213849.3653331-1-jmattson@google.com> <CAO9r8zNzhK90=+Pezqbea0aihMEp-dGidcJuXqZQKnmsM2JTDA@mail.gmail.com>
 <CALMp9eRP7-u+6r8-RoVru6PLSPr6fu+EuRgtsNLJE_1EpMJq8Q@mail.gmail.com>
In-Reply-To: <CALMp9eRP7-u+6r8-RoVru6PLSPr6fu+EuRgtsNLJE_1EpMJq8Q@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 2 Mar 2026 16:09:47 -0800
X-Gmail-Original-Message-ID: <CAO9r8zNe9_vhspg4T=zswZ3Hr31XJGPz8=aDbqVvL1Wa9_mrAQ@mail.gmail.com>
X-Gm-Features: AaiRm53Gu2sZPwWAS41BfOVw_wz49tiZkwawaVz7QWPr4iNzWuel1QFSSrB_wgw
Message-ID: <CAO9r8zNe9_vhspg4T=zswZ3Hr31XJGPz8=aDbqVvL1Wa9_mrAQ@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH] x86: nVMX: Add retry loop to advanced RTM
 debugging subtest
To: Jim Mattson <jmattson@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 4:08=E2=80=AFPM Jim Mattson <jmattson@google.com> wr=
ote:
>
> On Fri, Feb 27, 2026 at 4:55=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > On Fri, Feb 27, 2026 at 1:39=E2=80=AFPM Jim Mattson <jmattson@google.co=
m> wrote:
> > > +#define RTM_RETRIES 30
> > > +#define ONE_BILLION 1000000000ul
> >
> > I think the name would be more descriptive as RTM_DELAY_CYCLES or sth,
> RTM_RETRY_DELAY?

SG.

>
> > IIUC this will be in the order of 100s of milliseconds. Do we need to
> > wait that long between retries? If the CPU is in a state where it will
> > always abort RTM, 30 retries will end up taking seconds or 10s of
> > seconds, right?
>
> I tried reducing the delay by a factor of 10. At 200 retries, I still
> see a 2% skip rate on a Skylake Xeon E5 @ 2GHz. I'd like to get the
> skip rate under 1%. But, maybe others don't care as much?
>
> Yes, 30 billion cycles is going to be on the order of 10 seconds.

I personally care more about the test time than the fact that it won't
test RTM 2% of the time, but my opinion doesn't really matter :P
