Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B90B352037
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 22:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792101735; cv=pass; b=E8bUtky4E7lHiJAbewyHeXJ5nqlIeaP9dP+gsPshAVq22vyzofyH1R49MBUK9fykhs+DmuqJXKCQ3eEJ0GzyrvzCGH6eU8mK28aXH3ceOzbc34n95nAbO75/XbrrwjlwiGY0r2lBiNbYZQXPD3rc8IvbIEDiYweZjfv+aH+slAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792101735; c=relaxed/simple;
	bh=lRIHYlKk/yaj4fJSnxFwMaWvZPIuM4vHwdBVA9DV4jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbP8ypAFlCfhGxOw47d6KF1GVLAUPWwfKa56JTCmdPQNZdCE8/EXGnNqohrLBtvHmWB6xiP4HNxWuoOiy40ovjYWjZEaczxDZWmncQYw4nNuE67GEtyUMEa338Hj36H38VT+XMQSVEn+7s1ij+C1XK8ZxbIb2GLlDTYmW8tVY48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fMlt0tgd; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fMlt0tgd"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so1665a12.1
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:02:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792101733; cv=none;
        d=google.com; s=arc-20260327;
        b=JGCkpqYXTdA1aEj8aYy0c2BfGXdnb3ZV//tsO4+5ezAuzdC+HItNRdwmr1jDZp3Tr6
         FNV3ef1XA+8dQozWIR+2b6ZSCu2EZH9FPgcw635ESekXwrwHhObMJFtlROy6yL1xvFSF
         RWck8Un705b2Npi0aJuh0c6rHzC8aNNM+bh6RON9jnkWsC6IVR4RilJFSrpR3dYbgu3K
         AFpvva5Q+pokCR4dBjnkCSUPzOAww3pSWXyalk2JbnG9RIckvkBH+kF96e8faJ9BOvuU
         x6MRPZ5Ow+vTrQrXzyCs81zylgbrYY4UfJIJCzr/DjLT4A8Iy/v7D2FHNpA0NSaAMF/h
         waog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lRIHYlKk/yaj4fJSnxFwMaWvZPIuM4vHwdBVA9DV4jg=;
        fh=vJ8mg6Epg5QrSk9AyYy2znQctzDm3HMUarUrLj7mTYk=;
        b=l1sh3jRjBGBwFYGhJTmFfU+oj/3TouvBRJ0iO4zHuB4Ar0YZmKc+3nscok9/smCtPX
         1WMXCKjM23+HD7GvVoPw+qAGD1cs/88tV6R0rDJupt4Fi9y8vmMJFx2NU60A2HkHDb/I
         EQaPXFGiqJsbX6ob6QGoJxU4tlELEzLpLbPZaGxlXPxAIsnOG1K+fE4NsZI++wQKZBS1
         TRrmzGbWwyX/xPfo3Rtd8GUBRPWyOFskZpo3qBWKsvK9LiKrHQDm3U1trXoDZV7jwimK
         hK/9eEbQsn6J3oWp2eB5nBiawpN9L9Njm8G8kDtXnoVCAOyElERCw1EyLPkaM9PdQd6d
         Km6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792101733; x=1792706533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lRIHYlKk/yaj4fJSnxFwMaWvZPIuM4vHwdBVA9DV4jg=;
        b=fMlt0tgdRUGLNOVVn7YxteYCIBgnvkXlfP/eyLx/rHLV4XtiavZRHeBXMod35Yg53f
         DAtQEaMrNBgq86GeVMd4BldWbC5FKR3X1Fywp3cf3zTDtkVZz3oOf5RHO+xa6vnxhOla
         EY8eOqLnhLBAjUnTHVqlrN5KtwX7t5aBBgQP2fVwUgtXOO4DgJQrjZSD8Ab33Bf+CEki
         3EBgc2+px/olZGUzKeDXC8xauM62IFxoKqf+HMgHroDX3BzKPfslepd8+GxS2zyyKmVh
         YM0bLCBmkz5tgzNQbFUfxV2hznMB/g3FlgieRMgvh+AAowdp6BvMGgJHeta94aZnq+Cz
         n2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792101733; x=1792706533;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lRIHYlKk/yaj4fJSnxFwMaWvZPIuM4vHwdBVA9DV4jg=;
        b=cX6T65nmXJjD2amMyzOS5OpyaZtCyk1NSgCa/UejPW1nfbaNEq5iP/4B2Hc3Z1RbOA
         IW1tKByODFC97/Yc1dl1P01qORxJiZqaKSF2OewoxMCCv/5IknaHP4ugMZbZqvpfZTdV
         1Nr3UPI0BLkaVReLuwjo/gBe6jBkDz8vb6zPg0BXxcjMYBh/WS32yNonPAEZNnbGrBnl
         AhbyuTAq87DAVnjt9D11pYx5DL3THTPqP+HbsgUoYhWpUjpj+kUZoIbnbOq3lx0Tf6Xz
         GGmDdc9il/gYLPTElW5xNOKREVlf55fQMwAAQasXhGhuhjbXLiLUbY8p1/cQ71gQiSyP
         6mQA==
X-Forwarded-Encrypted: i=1; AKwUvByK9b6XtGq0DQU2JdaTNp339kSXAkhWwZ7CWLwouWAULcv6+9EEgdC0kxEcs0TpqnFwQGU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7zyBzwYzhwWSwKIviSlwFj6TFJeBNwcQqf1lIt5CDSeeLGpS+
	/0Qj9/xdeKbcMFJEeCvv3428KN1xS8glLgZ+6DsfdIC+c/EgCDZ96FMQO7y4OIvO9Gofvzb3VWj
	o/LxQmh+DKCp4S1ACs72nTF7RzNgGZXsbHcxIv2jt
X-Gm-Gg: AYBFou2YN0b3PMPW9L2P550F2juyUZfGnRxttUK3pc4rwMymOO6sUJXEUdYCqHiH4vQ
	LhUf3+5b4CQPeniy+gPvGnEUSzP5duNep+CRTWEdcy/rTYyCscJ6iexSCZr6C+OLSKslPQxYIuK
	cV+eJD6s7UQcodTzf0O0TKm+wImeYJrLpI8DZggOe5MJYs4lR3LDML4HiCoZe0X0ln95A+fR9fK
	PBBaKuCeLHSTEvRqYatwwtmrsJKgeitgOOcmVw4c6O2qLpdbFOoJYhkMsWqCmwENTKzk7JhdNjA
	wSSPisl8d4kO7yHblIpMeg26eH4aN4YUy3bJ/Gg0ASESvmNmwNgJzcE=
X-Received: by 2002:a05:6402:512:b0:6b1:bc48:2238 with SMTP id
 4fb4d7f45d1cf-6b3894961d1mr21368a12.11.1792101732235; Thu, 15 Oct 2026
 15:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-16-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-16-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Oct 2026 15:02:00 -0700
X-Gm-Features: AclHuK-w8w-gun3Ara8xw4uWe-BO5jdjT5uR_3SEXdllXWIlVSRpcYuXf0FuzTo
Message-ID: <CALMp9eSoybGVairftaYg6uyCCoGHwvb9mE9p0V6gJLpm5bbrCw@mail.gmail.com>
Subject: Re: [PATCH v3 15/27] KVM: x86: hyper-v: Allow purging all TLB flush FIFOs
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> Refactor kvm_hv_purge_tlb_flush_fifo() to introduce an inner helper,
> __kvm_hv_purge_tlb_flush_fifo(), parameterized by an optional FIFO. If a
> FIFO is not passed in, all FIFOs are purged.
>
> Note that KVM_REQ_HV_TLB_FLUSH is consumed by
> __kvm_hv_purge_tlb_flush_fifo(), so a selective purge on one FIFO will
> render any subsequent non-selective purge useless. This is not a problem
> because purging TLB flush FIFOs is an optimization (and there are
> currently no users of the non-selective purges).
>
> No functional change intended as a FIFO is always being passed in now.
>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Jim Mattson <jmattson@google.com>
