Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966DE3B840F
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778794688; cv=none; b=DF7ccxbzL5ra7VhrcueJH6C4LeGtBDPkzczsKdlGdWIGQmPZWiSyQxF4MuDp41k4T4x63ygvq92qEMLzqty8NaDYnBOA9mzWqkEJV+Y6159sHKiJn+nj4WsEFRgBtbTPdvVCYOUugmQcq3tP/mA08EZalEOqcOaB/vskalgA3M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778794688; c=relaxed/simple;
	bh=BhtDoD82EsstFYlFd3Ho/OX9ol+Yd/PPLxlia6eLFBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u84HSXmL/baLCTY1/c2vzszFTTdn545H3zEngoh3UkNznl6hclhu2t8WHulbKH5pYer62/gemJzRsZb3W4rtVij5eAkA1CHW74BH4Vex+/xo/MLEUjirav8OoXw6xJDFzkzGC1bo/W+5cC9kABmFortu+3K/Qz9tqUnLcI/m/sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eX1OxO+7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eX1OxO+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36064C2BCB3
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778794688;
	bh=BhtDoD82EsstFYlFd3Ho/OX9ol+Yd/PPLxlia6eLFBs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eX1OxO+7XsDNOMjC3hUPxzT1daGNTJChvt9WWp3Ti1mVGtajpiFwtOVEH4DWJFhNj
	 ODNWoUky6yuhot/CFBfydhlNYME10fz1N5lem5XRfxvofYyxGfzT3tXKjIOFqWo6Ad
	 8LXCuVmZkYxYnwNtl1Jnpn3/BAaBD0HJvet8f2r6y+FzkGHHy6g5GGRisdMwpXDcYC
	 S4EQFzSZF/hc9t9JIsHx9HxRPCUubo84V22Zc1vphsxkVOsHujeSmDEuGSpIA4+0ZA
	 zUJ5OR/ZfBwzZ9Lrc39uzY15nQsVEqjxD+A8o/adu3FsqN6u+QyeYiucswFfULegyC
	 4/1I2s/cWZ+lw==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bccd251d622so897163966b.3
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:38:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/ddEozEPh/MepWzwT7xIgZgM9fGDKyyVpV9931heUdNFuV/vALXnHB1dVI80RjQsjFahs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJyek4uTW57x5EmJW93VrRJVh1qd3bHdrSMnERgxA0MgUIUenT
	qnlZSW7wcV2/kpepFrbRuhAogRHcAGRX9ulNlrjSCblNHr1tul+GQnSzUPV/Wawkbq+2/YxWB8k
	1mx3AWhLGd8HNRjBCXBEZ3tKiTqSRrD8=
X-Received: by 2002:a17:907:c248:b0:bcb:d9c7:c6f with SMTP id
 a640c23a62f3a-bd51780cf97mr62101966b.7.1778794687157; Thu, 14 May 2026
 14:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514200536.1603737-1-seanjc@google.com>
In-Reply-To: <20260514200536.1603737-1-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 14 May 2026 14:37:54 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMStovFvh9rEYJGopKNpe4zaS+33FpXtZUUTd0T+x+KQw@mail.gmail.com>
X-Gm-Features: AVHnY4JJ50c3yhabNUs8ezTiUVfbdQc3FycrCEQmBmEmjgKCIJtRwgzn4QDNQ6Y
Message-ID: <CAO9r8zMStovFvh9rEYJGopKNpe4zaS+33FpXtZUUTd0T+x+KQw@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH] x86: Disable PKU in vCPU model for vmx_pf_{vpid/no_vpid/invvpid}_test
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 1:05=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Run the vmx_pf_{vpid/no_vpid/invvpid}_test VMX tests with -pku, i.e. with
> Protection Keys disabled in the (v)CPU model, to reduce the number of
> testcases by an order of magnitude, which in turn reduces the runtime by
> roughly the same factor.  As is, even the 240 seconds timeout is
> insufficient, e.g. each test can take upwards of 300 seconds when run on
> Skylake-era hardware with a debug kernel.
>
> Simply disable PKU in the config as the purpose of the VMX #PF tests is
> primarily to validate #PF routing (to L1 vs. L0), and secondarily to
> validate alternative TLB flushing mechanisms, e.g. INVVPID.  The only
> novelty provided by PKU with respect to those goals is an additional
> flag in the #PF error code, and the odds of KVM botching _only the PKU
> flag when routing #PFs is very low.
>
> Disable PKU in the config, e.g. instead of passing a param from the test,
> so that the test can be run with PKU enabled simply by tweaking the QEMU
> command line, e.g. without recompiling.
>
> Reported-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>

Feel free to update the Reported-by email if you want it to match Reviewed-=
by.
