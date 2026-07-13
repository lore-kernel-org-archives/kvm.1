Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C695E13DBA0
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966196; cv=none; b=cY0oclH134IbibAZg4Krk+i18WXnrPAxjVRUaeu6+0Ze6A/s/mPqWC1N0O49leZjU0hZmZDAPgDBk69njIqjolrfv26HTIsHzvxGsuhG9ts1jcX0APiEXnYMQ/q0ijPIAAghUZg5uDaBaIy0NGyqn43fRbyjqKhB0tDoLzWUg6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966196; c=relaxed/simple;
	bh=AjgIWghdFYFTReALUR4dxHultO6p0oNeQVTcDBCXUS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZsXJscQUtF55z9tFKpVySH4tHtzS35Fj9NkQVkb+mNmR+KiM9KMLScq5GekgAjVkjRoBm/b3gWJ8PqkGm7uXPBBjec9X65k3WBx/wWZT2UND1OuSFW3z1arQ3hSTFL0ZtslU57NL7X42XZbLucI0B2sbkl96mQvfPw/QMtAOwvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoUiroz5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoUiroz5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25D71F000E9
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 18:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783966195;
	bh=AjgIWghdFYFTReALUR4dxHultO6p0oNeQVTcDBCXUS4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eoUiroz5YNAKl0+zUVJM9l94tJfBzgqNLcB/VvHzuYLbsRqrqXoBYw5JXYxBOZEEd
	 up7iFH4uAck8y9rwo3SjO7ni6Kn8Cvs7odcK1jOtN+Cryr+2DeZwJth7zoAOlTnoQN
	 cyX29ypGs0lMj3yME+RveE4btqPKYnh+JlNxIk4TPCECItX/MDfI613LrNK5qLV08Z
	 hiMJVoG0Kf3t7iKP9KfsZb7Um7d24F78uG8pEYDH2Jm4uL0LCWEp4DvOMMKI6lHWNL
	 FCfzFCFDb7aiO2ZSAiAEV+W5tgd+61K/dvHg0EK6s82/5Kpg0lSl5cNjrIfWAPwbDN
	 pV3vSBndRtqlA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1600d040e4so22873366b.1
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:09:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq1e/94XRs8ZHA75Lv2Yrw44kemKOys3pKee6OvzZYeZrTBgOFYcXDYo8Zze4zAkOGQvWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSAXU5ZIszOFQWmBV/upsOm73iXHBFr3v+z5X77FreayhWQmp4
	IPK1wKdELI9ORi9+02xm8I8QXoAUARLQXY00kmgmevAzNGlDLynY2QXQF34xbHT+EknJcixdYOW
	DxjFMklT/RERnsWEO1+OAGHPGpwlpvuM=
X-Received: by 2002:a17:907:3e92:b0:beb:d461:7b09 with SMTP id
 a640c23a62f3a-c161e89f210mr540204166b.11.1783966194573; Mon, 13 Jul 2026
 11:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713180153.2728382-1-yosry@kernel.org> <20260713180153.2728382-2-yosry@kernel.org>
In-Reply-To: <20260713180153.2728382-2-yosry@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 13 Jul 2026 11:09:42 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPhmLNdVgyXib-P+Ge_KSp=a8gA3mLDcpjJ5br-eXpj8w@mail.gmail.com>
X-Gm-Features: AVVi8CfA0knMptWzDciEPgOB08A5RKL7bIyn0rifQCDim0HLfgvv18cOw7GIMYw
Message-ID: <CAO9r8zPhmLNdVgyXib-P+Ge_KSp=a8gA3mLDcpjJ5br-eXpj8w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] KVM: x86: Check EFER validity on KVM_SET_SREGS*
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 11:02=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> When handling userspace SREGS writes, check the validity of EFER (i.e.
> allowed bits) before writing the new value of EFER through the
> per-vendor set_efer callbacks. This prevents userspace from writing
> bogus values (e.g. EFER.SVME=3D1 with nested=3D0).
>
> Note: on KVM_SET_MSRS, KVM only checks EFER validity in terms of KVM
> caps, not guest caps, so it is possible to set EFER bits that are
> supported by KVM but not by the guest CPUID. Potentially allowing
> userspace to set msrs before CPUID.
>
> However, for KVM_SET_SREGS*, check the validity of the set bits against
> both KVM and guest caps. This is consistent with other validity checks
> (e.g. for CR4) that check validity against guest caps, which already
> imposes the need to set CPUID before SREGS.
>
> Cc: stable@vger.kernel.org
> Change-Id: I45701ec440e4fdd8f086eb70db0c0845fb0ed509

Forgot to drop these, sorry :/
