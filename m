Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9071A681E
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198645; cv=none; b=BqYDuYD1b+gcCYJGzCosEbZeYgw6ej+juKvMQ6SutBYNNhDxF2h2nHkdqXXo7wTvevpGmJWP70wxUOhx9Bf3G2HdJ/4iNyedxcjgf4+/RsFCiR8WaEtaPNh2NMn87FIs8UHRQ/9Ib3icgfNcbIAlltgrfYeU3iKq6zGmELl5DBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198645; c=relaxed/simple;
	bh=02UdFJUzOBD0DcgNSxbb3NWD8wC32zrFv3+d9H7FBkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vae8NmGl5dnmeNEz81E7nvIiezq2kA9OwrdnoiA9kRGUbCA0j7uOiLZfJ4M/iInWW5fKBpUq/rUPj15dQ6QwbFF6XArZRh9gggLXqGtDwpoMET2VDOvf03zzEcuSKkW4cX9RH2WpUkdlkcqcbHghPGq9MJcIx6DjGEqxSt47f4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0wZ0XLi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0wZ0XLi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1361F00A3A
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198643;
	bh=02UdFJUzOBD0DcgNSxbb3NWD8wC32zrFv3+d9H7FBkw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=U0wZ0XLiLbFos6JR0lgF+kgukcU26MIkYTYLyCB6e6b0kVvYtHQnRBDwMBktl3ck5
	 +nsfiKyRflpov/pt9OEqeVYdyidAtQysO49gPBPXqsrpMYDpOtOLP4Z5nhqk49y6Z4
	 B7UuRs96pgHS82G68rOuRd4ck1zEztWcCcKIhWvQNic/z02Yu2J1ddo6XoINxAMBMe
	 rMt7d2ZJPf27POQvIIe65l4wISAfccc/k9O/9wXyGJQsQhoApDoe1zGYwthVn4JWHb
	 Nrrjld2d2yTNi2pr9Q3TLYOcJiDmcVzhRTnoRrGQClEvN6Oh1SBw80vqVqsqiLRoXk
	 50+9r7REMhIUQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1c4c7ddaf6so481342366b.3
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 17:30:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YwpPuqg6L4uh6BCfuR1XCdSwoDXG4kc5RW8NaPXfa8/smeRpmSz
	XqUZWtyk89TAzrClB9IBcbKJNWU3IkUF4ZgkzMdkZkofa/Vk/QAEEIEMn+C9AOPO+CejZocDlHA
	i+T+Ed+F+tc3k0oaV1ifGoT5Jr2UmgTo=
X-Received: by 2002:a17:906:7313:b0:c05:b9db:68cc with SMTP id
 a640c23a62f3a-c1f71ae3828mr5540866b.0.1785198642505; Mon, 27 Jul 2026
 17:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727235228.1007324-1-yosry@kernel.org> <20260727235228.1007324-6-yosry@kernel.org>
 <20260728000537.205D81F000E9@smtp.kernel.org>
In-Reply-To: <20260728000537.205D81F000E9@smtp.kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 27 Jul 2026 17:30:30 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPoONUs=74=qOxrhvcSOGSZNNyfxN37gDiMsS4aFzGyeQ@mail.gmail.com>
X-Gm-Features: AUfX_mwIErzt4njmn0GHdzMgCd2j7IuTedlJhNnT1yO4XKj45wb4ZGyk82k9UTA
Message-ID: <CAO9r8zPoONUs=74=qOxrhvcSOGSZNNyfxN37gDiMsS4aFzGyeQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] KVM: selftests: Reuse GPR switching logic for nVMX
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 5:05=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The commit introduces a severe data race by switching VMX nest=
ed tests to use a global `guest_regs` structure for GPR switching, intentio=
nally breaking multi-vCPU tests.

Yes, this is known and documented in the changelog.
