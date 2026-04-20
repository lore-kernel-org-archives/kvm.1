Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1CB3D090A
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776723562; cv=none; b=A/vU+Tx0NEDuH3pxRSInR4ClrNiHXYygUbV+LdFSXECQ2HEePRZXP9oqEoY9B37Y9U6fTD3Feabt4czRu4lQoVKpaQs/yz7gu84nJmJX1iGeSqLwuIUuZH5zgn8RLfP3WTG/WhzJC1iivXtlcZbTJfkFRQF3Uf7jsKMla1H4vqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776723562; c=relaxed/simple;
	bh=6F5uJhoHkgfD+UZiB2RroLXt1N+F5jRaeg5acAZ2M28=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NPXPNEU8F1kHkdKDHt+CXYQhA/zLsyN1hTGPza5sm9n5W618CyXtIXqMd7UTqHZYQT66Qd5ylmpL6yyeFkEW3WCpv/+YBv1I3Df5xx5OT8g+JxvB7H1Kfqu77SR0pNuI8xrJml0BFbZzRF5pRrVP5hsSxd6Iu9IEHEbH4YC73kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmUu6sFW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmUu6sFW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856BEC19425;
	Mon, 20 Apr 2026 22:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776723562;
	bh=6F5uJhoHkgfD+UZiB2RroLXt1N+F5jRaeg5acAZ2M28=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CmUu6sFWlskWDNBP0GEEOsJX1ef4T0Ihv7TV6rDfH44mBE4GYkhe1XI+VrsqFZfXj
	 c4qP/UWXwrv7fKKWnMGzQ2b2V92U2xoqjtz5Qu9ZcuwmagzNgtMyJ/ouLpD8tfvwa1
	 +XoFUHE6nTccmtoiQfyX7X+K/1JFikFrafp/bDXknB/j7L0RVtO7jM0bga2JeZp3Im
	 C4UeKqhZNYWBcCwQf5/T9r38Uv0l6EqUCRbvveqd9hFfhi8kxAq/sBhH6pwfMKxhzK
	 kGlSd5IHVxuK/0lUmIivnn1urDdAnAJK9bRlpZ5On90BSDWrsobzIAzaTeJmVoG0T3
	 rmpP6BKKS6dnA==
From: Thomas Gleixner <tglx@kernel.org>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>, "peterz@infradead.org"
 <peterz@infradead.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Edgecombe, Rick P"
 <rick.p.edgecombe@intel.com>, "Wu, Binbin" <binbin.wu@intel.com>,
 "x86@kernel.org" <x86@kernel.org>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
In-Reply-To: <bb07d5ee721f5fd4e3a168fdebad1b450eb6bee7.camel@intel.com>
References: <70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com>
 <87mryxekxy.ffs@tglx>
 <bb07d5ee721f5fd4e3a168fdebad1b450eb6bee7.camel@intel.com>
Date: Tue, 21 Apr 2026 00:19:18 +0200
Message-ID: <87se8pcm1l.ffs@tglx>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20 2026 at 20:57, Verma, Vishal L wrote:
> On Mon, 2026-04-20 at 17:00 +0200, Thomas Gleixner wrote:
>>=20
>> This code should never be reached with a rearm pending. Something else
>> went wrong earlier. So while the patch "works" it papers over the
>> underlying problem.
>>=20
>> Can you please do the following:
>>=20
>> =C2=A0=C2=A0=C2=A0 1) Apply the patch below
>>=20
>> =C2=A0=C2=A0=C2=A0 2) Enable function tracing and the hrtimer* trace eve=
nts
>>=20
>> =C2=A0=C2=A0=C2=A0 3) Enable tracing if it has been disabled already
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo 1 >/sys/kernel/tracing/tracing=
_on
>>=20
>> =C2=A0=C2=A0=C2=A0 4) Run the tests and wait for /sys/kernel/tracing/tra=
cing_on to
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 become 0, which means the problem t=
riggered.
>>=20
>> =C2=A0=C2=A0=C2=A0 5) Retrieve the trace from /sys/kernel/tracing/trace =
and provide it
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 somewhere to download from or send =
it to me compressed offlist.
>
> Hi Thomas,
>
> I've uploaded the trace here (~75MB compressed):
> https://drive.proton.me/urls/B9PY61XQ0C#07XwTVhE46eB
>
> As for:
>
> 1f5ffc672165 ("Fix mismerge of the arm64 / timer-core interrupt handling =
changes")
>
> I already had that commit in the branch that was tested and it didn't
> fix it.

Thanks for the update. Can you try to provide the information I asked
for above?

Thanks,

        tglx
