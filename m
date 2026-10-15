Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48BE44A409
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 21:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792100694; cv=pass; b=bWpmBdXhDh+0mrT3Um+GXujeNyR1d+fo9gBTAmdY3Z8XqVMv9bwxuWfzKOWJps4Cu+hmor0apZywSut4uYMLnh9T+UMVdbLdHklDN0rrj+ZtwyOh8v4tjPaVCxL3pOy+GSOIYo0H7c21DqiXY4nMYnF9/lWk0qYs/0bwtM4ggTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792100694; c=relaxed/simple;
	bh=VulLeIoBX7+WvSRBYrLJb/oaYRWw1efO4iiCwh0SFJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6c6BeV0AiHsfaVXYcCXkKj94GtKrGM4pQsGiVmj0VeNZToCLkK/T0IS+DaC6Ew7/OQU9jYWbl4EhxGdwhKfO9DJGeKVODLrbN+ZlGKEFFC+fg3pZNTyaP5ovq2sT6tL7cZPhwJeTnjThDFoMwl+dGzt9a1/AeX7W6wCdyoBpQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jzXCWKWy; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jzXCWKWy"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso4183a12.0
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 14:44:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792100691; cv=none;
        d=google.com; s=arc-20260327;
        b=EQEXDzqJUTzmTI8D4Oo4oa+iZoZQEycu/65cnRuRJYveoIuAzc4euPMC3Wz+LlUJwz
         8i0Tylg0jw/UfyVhpEzBrE+9jYQx5CsZxqiJwbDBi3sAzqYYgvLUvk0g/ivPI6Fnw6gg
         hpIbf6vP8RfH/CJps6Kq87OL5143F0W2+HK77+rMZmUcU9otq0nCD71Kkp4dQMDAAe5d
         DevYxsqOh4aKxy0Ayt8rbfGqQAzZG/0ecFpei5FBdhRKYX59sl4wyLVtlGVhSJc8/XKY
         uhkZzLRudvOkKMu4bntBt1URCyU//1AF7fSDjCfEti0xgwI1wpl7/bCTwfDrlfqlus/L
         dVgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J2tauij8/FIv+ZF83BeJIOnsdUbtSr9TFwP9qp1j+qc=;
        fh=48HywEkt/Gxz3izWgdMuVXDNetQ/2slISV6XRln/MSs=;
        b=dqNE8fr5snSSWzpauAX2c0BM8M3tMF0NvbYHppw7CoKkDVsDEnzS/5/SJ6x5sf9LpZ
         eSbPjgT/TxcsT9t6w6BjORTqyB/In/9R41TtV94X2huU9kR2hAEtc8lMfKxKV+MTvgr1
         96nYdAAgVffQaU2Dm18n/QnZTshGZFWkX54VWGY+OTCEQLpveh20YcGClJpHhlqXd7+Y
         0yYAiNU8DZnzDZuniGasguoH9y7+rQgXRDsi1pZ+258khbo/lwMfRE+u8t25taWMTtdG
         7sgRwzKumROj/xZcp5NQpSQE5X3bV1zMv1B+mEBm65v/X85UWRidB9DN/AOq6UrwJAdI
         DZ5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792100691; x=1792705491; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J2tauij8/FIv+ZF83BeJIOnsdUbtSr9TFwP9qp1j+qc=;
        b=jzXCWKWyaDFlRuMMnhI3ZqqdAquVIdxYPkoqnQk869dEpzvCEZorU7aJoFtUZ5Rkmz
         4MnHAoEc2CJpb8OT3tbpDndbqhq6FAHw9Meev3IMCJ3vTySTz9uDOX9QdyJHdymTrL3U
         6PTtb09H4VYi5sJtx0ru8WnhyXxpESGdebxtOk93YVkrAMVG6/NqJqUQPOi7C3hgG0nr
         jX5haikwzcrgoxE6B3WYnymKGx7Dt+7a6oRjRJ+36eTOBCmbZ4tYKpXU4Y0Jd+2ETsd0
         DZkLYD+AktD8bHn48kwr8X8N+sXGcP39HTI+3D9BiDPT/10o5//oufK9fejj3kUs487s
         Y/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792100691; x=1792705491;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J2tauij8/FIv+ZF83BeJIOnsdUbtSr9TFwP9qp1j+qc=;
        b=fwyqn+6DY3YCzCklY+vH74kLWammQSAK8EOG90UIGIctT1GUdp7Zin1wml02UIPSEO
         X+CLrvLhduwT5ukzDCieAkD6CI34pk9HvJHYSSXr7hu/NJrXsZKEYxhMKGClC6MhK8pr
         7MjRAa+mFjqgyrd9oJDWW+RHK3jWSQr+iit2pfJn2LYpcPRND5tR998EWxwUGAXE7DxB
         Tm6lvdutf6gI5LCQwWZHdPxtxhfr4eQ/8mW0dfXl3iIVGhABifPioeLyAIHPCYZ3oGTu
         u/dW5GcJ9Jg3o5HCggs1wd1WhmvQnltaXHzYuGhqtyugJQo2GWuuJV4rc5krSY8JtI2b
         e6qQ==
X-Forwarded-Encrypted: i=1; AKwUvBy9T+2LoELNTKi9GBT1Ag2qnfSJQU6Ufh+1VmnAb+3LOr633l/AtQh0p6bLqlGMXttzQuI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIo/B9RlsfT7uSspI1iT8CHnTHBwdj2ULg9G22sRlMC4sBua8a7
	hk9YL61SFAuY20OzCgwSg9GozL7daQolI+sEVUilHXjgDOK8yMNzAENhuOtSLM0c5NOFZINy0HZ
	6BeEmdwIUv6YdcyLGsOwmgFQuCSjAzoPqGYkQy9m0
X-Gm-Gg: AYBFou3xSa6FmldJIDwZGDzbdbb/PlVNjGTYTkwEZ6LjLPCbx71OH914OzTJmbNM7pl
	/GGaqXb7N9M9KoIK/09hAcZrNq3eA40vs+tJHF7b/cUKwzgvH5saUuuVKKF2+s16DHghEmAuWqq
	oB3RyjTInpAgOVxsVbW5Fb3ft9sxmVitbYRHL9tSaa+2ZchxTMnDSSec0AZcET0/wlzZjKi51nw
	jRT5I8TCwSRfzk4twQbh6XbubZipPTPtCzM/NRpvef/qETM9MPEzMkQc7PTfM0SzB1Xt0gwYFv+
	PIGkVJksmYCBtMUQHC0H0wGCnjeWfG+sc+/9tRjaPq5jk2Ukgz1F47I=
X-Received: by 2002:a05:6402:512:b0:6b1:bc48:2238 with SMTP id
 4fb4d7f45d1cf-6b3894961d1mr19975a12.11.1792100690504; Thu, 15 Oct 2026
 14:44:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-12-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-12-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Oct 2026 14:44:38 -0700
X-Gm-Features: AclHuK8Uq8sH_z4Z0am-zDBj0JfGwxILB64drxWhh9TWDwz6VRj3Ca40Gs607RU
Message-ID: <CALMp9eThakVB_zqPQX=fQLrKh13BR33jmGg__rncOLDa2ZkXWw@mail.gmail.com>
Subject: Re: [PATCH v3 11/27] KVM: SVM: Only flush the fallback ASID when used
 by a different vCPU
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> Instead of always flushing the fallback ASID on every vCPU run, only
> flush it if the last vCPU that used it on the pCPU changes. This avoids
> constant TLB flushing on a vCPU using the fallback ASID if no other
> vCPUs that use the same ASID ran on the same pCPU.
>
> Note that checking (and flushing) the current ASID on vCPU load is not
> sufficient, as it is possible that a vCPU is using the fallback ASID
> only for L1 or only for L2. To do this correctly on vCPU load, both L1
> and L2 ASIDs would need to be checked, and the respective VMCB would
> need to be flushed. This would not be much simpler, and would perform
> unnecessary flushes in some cases (e.g.  loading a vCPU that uses the
> fallback ASID for L2, but L2 doesn't actually run until the vCPU is
> unloaded).
>
> Another alternative is always flushing on vCPU load if the current ASID
> is the fallback ASID, and flushing on nested transitions if the new ASID
> is the fallback ASID. Again, this is not much simpler and also incurs
> unnecessary flushes in some cases.
>
> Do the logical thing and track the vCPU using the fallback ASID instead.

Wouldn't it be simpler to track the VMCB associated with the fallback
ASID on each pCPU? Then, you avoid any confusion regarding whether L1,
L2, or both have been assigned the fallback ASID.
