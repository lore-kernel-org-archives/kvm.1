Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9787338E100
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926698; cv=pass; b=ild15IP+OABaiJNabPfv2q8V3WF7VgVeRRuLS9XXxNnq9pkxNvxTcqlqL8LEy2X/9yMcIFpZ0vt3QhO4Cg5y4wC4gWYRlMwMADD4gpuYQIGemuW8d6Uqbss7OOy+l1uahuHEOfRpeY38Xp2tBOuxF45uKzrmYVMH4deGq4ZT108=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926698; c=relaxed/simple;
	bh=nW6pcbXAhBt0stazWFve4XZkgje0pUMWdBxj4dneZ/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7nAwMPgSGqd1RcZDdBf2u9LeFe3dIAn2rOoFvbrRwSUizgCESdd/i1qo+SWUJxIdqKtqZSLbBSehjn15oh+EGuihrgQmFN+rrKFu/qoNMx2wyprxRC1/asmT2LI8QnEMTBiQWCZp3ONjmRAU/fwwGpZTY/DCC37k1oJG3n6sMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FV0JE+hZ; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FV0JE+hZ"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6607048fa62so4231527d50.1
        for <kvm@vger.kernel.org>; Mon, 08 Jun 2026 06:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780926696; cv=none;
        d=google.com; s=arc-20240605;
        b=Pa4zvk7dG2rMXvw8yG/a0gTfUK/nGrRPVLtSTxUADuq0QqJsCR78fY5kT9wb/+VXQl
         fDgMskZfKOWs0nnoFZZf250XUL+DamuoDJc7m22efTdBkPgD5oXJIuqB9EF6SMUNJ19E
         NEnUrcRRCZ9PzQ4y6oVKWlltBvhWobb3B4XvaURX/sqXMjRSa7Bh+cBujkuJjNPIJOC8
         E0dX6gUNKL/HDrAYSMsKogBsUXOvAnuR5brmE8Pqv77XxdWskoyFQCGzsPLXanjLBKdb
         NojIo1O7Q2L9itgFFY4Pf0MnRwJ245yj/Z3qizTX4rBoX/uoGi0NuxFSC5PkL2d2BVi9
         4e+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bKUj751TeY4nkEZpPo0FTWcTQnR2+/cwe6ZT7/QhNuQ=;
        fh=lHNisCFACRn0+l2Oc5UxmlenRVm7BVWDz8y/yxM/2P8=;
        b=a8hBWOxCCIn9lY9hdceVpaIN1hgID8IICpYEZYBy8H/CWNJCkMhKD452yF4gk48u0X
         g8dG8EAq4S0+qfaBrGhoZ6KE7OKfaw2skmElxoiAjlQYBEonvK+ZixbvpRg/WXq9fKz/
         v+28vA800pW0Jx/5JLpYElcO2j//uPnBZ91mjtFmqjtejWQon1LkydYJ+pknFqulBvkC
         AFeTS0lJlRlaTW6pWst1+HltUW3u6klg5xrI72N4/6h5SP7IzCdyyhK+KdvRVQTQpVTh
         3YhDU8IjrOgHSjU4muVyOyFsBzNecHwcIkqzE+M49oct0+ld9fJCmxyvFPt1Jg021ihW
         RGKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780926696; x=1781531496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKUj751TeY4nkEZpPo0FTWcTQnR2+/cwe6ZT7/QhNuQ=;
        b=FV0JE+hZlBpw+WrvEPC+bAPsMPCL/Ry2L2MDMhyYEplZk3THbiM5BxDc/LDjBEYXoL
         A9bMIO07r3D+DN+8aGBYDVfDf8YMkLaruGfqVrCFZpNAatVneHT1R/Ze1JgkXendCMo0
         XqWkFEnve7FACi08pjICTBzdyIjERPzRXk+mYSUA9JGEFq1sY332sSY6ViwKDMkkYsQE
         42etHZurGeohRsX0AsxAwhnxuWwtEphvkCf17EjaCMjD4P2WnJ6hS87a6nzXdWG4cFuZ
         LAXarAE4SJy28JXLH2cOcd1XqK3fb98g5HGwFazLSfpmWJA1FTM+IvsZsXOoXbc4iBF/
         PSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780926696; x=1781531496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bKUj751TeY4nkEZpPo0FTWcTQnR2+/cwe6ZT7/QhNuQ=;
        b=cMtVZU8FBH78ufB4QfnpthQW5Dga2nYXmU3EIpb3UuB7TUpXcok+34Eb9qrtrLjINO
         PbEobasISRKsuJm1oYPAbyclMauE1CINQNPPoBqF40v/+UiwGgfr/wRzmbW6bczW0cK/
         NT9v2SkYCrMDdKTYK5cUfUs5oPXLPnNOIYPsqEwlpSpJQHxQ8dQhD/hQvBhTRKTBX0Jp
         WV4agSoV111+fSGEYczKTsprHh+sD7S6z5ZOG/+rcmFcGK4wR66SUuYLfsz/t2WQmC/D
         kKBmrV+8RUaeWkxBvM247GTp80j79Bv3MetvirEgqNXPM1LGwXFhSzh7BULrx1fTkO4H
         jxtw==
X-Forwarded-Encrypted: i=1; AFNElJ/GW1BppUM2v+hzaL/b8c4jo6/lX1wzTVxuEKMpaoxno12NpcyP4kU5vJ5DPyQ/1TdWLI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvBbL6S4czO7Bfz6gZTXRvd3i/pFOoTVNQvFu85Re0524NpnmO
	HXMC5wT4veiKrjEf5I+tMj0tHxZLIshVG8uRYOrtOCDboPZXusn2fbSfOAzUJwAO5XJsApqL/4E
	6tfK2oLwEZvI8daAXmVQQWepQkWKqh24FxqkXiRiXsMtQt/yWdCdn
X-Gm-Gg: Acq92OFf7AiJbVnRl2ianKyvCShUGqVILMK+GjZYZUh1s4rmDCuUp/KriYNfiIM7I8w
	Wg0ZsrmpIzs3+O2l8zoJLAv8Bl+wOwDPbxozpbhLSq8HWYHbNYDuoGEx0CMeRMOb8CKja1aiRUS
	HD3HXUErRTe9mTVvlS7lSdY8Tw2R689s0w+oWmO1+B+Ay21dYnyGhx9P+SZBnrv704Ao/w5VQjC
	hZ0UI3mWybnvUKs9TJjdYsOnSC+pVcNcejJ95+zWIg1poewyfLCcxUu3tRtzr7oBUv6JEmBDa7X
	DfWhlf5NBt86lmtEgeNhJ59ch8UhAMFgbMWe/8ve/q8ISm6JNRtBr970q7FRGGKvK5flNJC71cw
	pZg==
X-Received: by 2002:a53:ac87:0:b0:661:1307:3d49 with SMTP id
 956f58d0204a3-66113074155mr12044887d50.7.1780926696345; Mon, 08 Jun 2026
 06:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529082948.363931-1-alex.bennee@linaro.org>
In-Reply-To: <20260529082948.363931-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 14:51:24 +0100
X-Gm-Features: AVVi8CfELuu63-8QEYfJ12bzRvsrYJpzmkWaV0Rztq1EKICzbROxPC3RaYFy1rw
Message-ID: <CAFEAcA94+mh_pigFDi+tEPRJ416fSWfxsQ1Lj8Byemug9kBp6w@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] target/arm: fully model WFxT instructions for A-profile
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexander Graf <agraf@csgraf.de>, Mohamed Mediouni <mohamed@unpredictable.fr>, 
	Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 29 May 2026 at 09:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> This series fully models the behaviour of WFxT instructions. We
> already had support for WFE for M-profile but we left off A-profile as
> it has more potential sources of wake-ups. The main one is the event
> stream which includes events from significant bits of the timer
> ticking over.
>
> The refactoring from the previous iterations of the patch have now
> been merged.
>
> I've dropped trying to fully model the global monitor in favour of
> taking advantage of the architectural flexibility to have an IMPDEF
> event wake up for any reason. We treat the setting of exclusive_addr
> as such a reason because it indicates the current vCPU is in a ldstx
> exclusive region and we don't want the guest to deadlock. This does mean
> the system won't sleep on WFE enabled locks but people shouldn't be
> relying on QEMU to model real world sleep patterns anyway given the
> efficiency of emulation compared to real HW.
>
> I've written a test case using kvm-unit-tests:
>
>   Message-ID: <20260527111822.1563679-1-alex.bennee@linaro.org>
>   Date: Wed, 27 May 2026 12:18:21 +0100
>   Subject: [kvm-unit-tests PATCH v2] arm: add wfx test case
>   From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.org>
>
> All patches are now reviewed.



Applied to target-arm.next, thanks.

-- PMM
