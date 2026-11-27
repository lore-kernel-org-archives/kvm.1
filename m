Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795789394;
	b=NnjgyZJAYu7x0DVVynGBpQ4mfiFX/pkiTgh5AOs5vgxur6iMJFJzbjb0q88Nb432WDgM
	 OWGFYqHnMDp8YJnwwetobKkYxqJOIyjpObBDw2VP1Y8c3xrF2ICRvB0IIOuzJj8lFS8ge
	 /SHjQ/mNqrrTrhTLWh3o0PKwNrXCIZKOxz/x5O3f3OulpLoPb8UwV/9EOvDUswOk+RjWL
	 wXc2SJt4q/+nf+zOp1lc1geP+TmS5znBMyOc7pxddUpSYEARR4/ezrOvq+LoOazCvep0U
	 pynOwGeW1VuVRixEwsW2Kn/pNmcGBgOt0UG7WCDAofhvQ6t+9/i70fgiLF+4VQW5hvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789394;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding;
	bh=lwfKW9uIZCzzl52VRu/ZTxERvgGAgWRWYeLITZx7GFg=;
	b=ZMh+cVQaKii6IHnBX7QE9Z8ImKCtgXbK8haVqZF5siXic6FdCAggOVtn2pHd+kiKQInx
	 6vp+24/YsnPVPGCcWmxywUhmYy4cBUEP1KGOXOnRhZcGBQA0Gr1fMuN7My1tHuSGSsYgG
	 LZbhSdrA9heirVqbmYIf7g5sTgnZAw2+JKirXNDP2mPVIwz4PtKlnqPbkKYXHWlVMpyQ2
	 8eM2koKJQBcsT889ZvBBrFaFwcxsI2bNE6qyje4mi3qAaTXtq73caBs+sekIhZUOCJQrY
	 z32gViPpz99aKwiRCY1kFu0HG4aVKz9zexgJEI1E8CEhCLs9Yokp3C70e+q+NEQoIig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eFi9qMOO;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=W+yFe3wg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25436606A31E
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 14:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25436606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eFi9qMOO;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=W+yFe3wg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795789393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwfKW9uIZCzzl52VRu/ZTxERvgGAgWRWYeLITZx7GFg=;
	b=eFi9qMOOHepypNn8pUstHIDBVFubtL/EOJRC01IC6GDA5XiXPMdEJPf+M+917UT5+YB0zE
	c1vLIYJ1OQmedIk2AK2VqIeWwHG7S9+Rz9wmy809ik5GQhojcBEm6vc62dCB40GYpVrZYM
	CL+CtclX9d33O+WjdvdGQTganqgJAkA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-JU-5XcRGPM2fEN1SEZY1Bg-1; Fri, 27 Nov 2026 14:23:11 +0000
X-MC-Unique: JU-5XcRGPM2fEN1SEZY1Bg-1
X-Mimecast-MFC-AGG-ID: JU-5XcRGPM2fEN1SEZY1Bg_1795789390
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1cdfb337eso4728868a12.0
        for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 06:23:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795789390; cv=none;
        d=google.com; s=arc-20260327;
        b=sKOr0SVHeH+AuGkFx5v5CNYrg8xYUlbcQAE+WLRwguWg81M58SoNUmgVMzjsgSiFH5
         HKL2MnXi5UVgwXzJKzV4mLiH7Lgjcng7AI+bepZREEGd/YCArmsNhOM9za7XGjZHyJyA
         0C4IsoBVurR5BiulNK8J8KU/d4bNHT5jbQJwx3ndjYmvLWie+8K3++1lW4DmzNgC7GdA
         ov62HtRxqIOyttVa3PkmqpD9txCuMVbelsgZ8Q4hs5X6D16EuD2JkK3iCxvzbEypzhRf
         8VeJHXRudXjsj8LH50XrVRzggKiRX0yW36tKPg8jwKh/h/XolDwnfaIZcM4Iq5D/6vi3
         lN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lwfKW9uIZCzzl52VRu/ZTxERvgGAgWRWYeLITZx7GFg=;
        fh=idbmOs7qEh8hcbS0JrDV2EpUuhHSfCRstyOiPTV+Afo=;
        b=b/IsRJZZE4xcIBATzsnTqbduMNWJ29owbgzFMQpuRg6APWPPU6o7ZOU/Z2qcsnLaxb
         QMLhVdYv6gx2cz6shhAvWmr0QI2UXReu5cE+2pFYnPc0Oue/J5yfw1x9dBNxpjNLgOlu
         ZKmsF82pXupSUSnfIdLXsXNbgG0Ze2wyPy0kjHpYsTRmha7rHbKJkgetJXIU49gaBNXb
         yFNp08SY4cbBder03IABVjuxiwRCp8OIPeT21RtuaDautRy1cXDqlwv9wTqWi1XjGU0k
         NG5QQ1ffqEmKjf3Xx6p0X6iyAF2W9GZqn0dXugr29+9nHkXjjm4uaHRM7gug52uNaGz7
         ugGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795789390; x=1796394190; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lwfKW9uIZCzzl52VRu/ZTxERvgGAgWRWYeLITZx7GFg=;
        b=W+yFe3wghzpmiXQwQ/9R+HqUrMqLso5A5z6G3yToB+6Wl1i4dCxc0ciMBTPKoDU+ln
         0CQE2mXnlCgQ53Gwm83HZpZxv4mZb6mjFxmlTmih6RIW/PhgLxS+miNNbqJASvAyjyok
         kVst65cYfhxTz06UikDWAIU2R/tAT2wliohkl30pGkmRdlKGf3rnzEZ/tS3lTgTg6frp
         /m6H917oJaMgC3l+o7hWcm8QfFulcpVBM8oGB9WTqr5ygB7WGwutPBPJbOHvzyxl0Im+
         4FewCBgW/UtnRUxqpLdOV6g1fa0H8q1QZ1kmuPSxrFncLpcPKXeAM8wuqZcHpaGGVOGj
         oWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795789390; x=1796394190;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lwfKW9uIZCzzl52VRu/ZTxERvgGAgWRWYeLITZx7GFg=;
        b=Ta1jgInTY33ZjPwOTfxSTZeMxMIyHQWbvGFBJfclTml54mBKo54jry8f7bx6/HJ2yU
         rSRGP9QtsQorbzqB7LL9XiAw00kkOvw/vZr8PDm2R/huv8tQrZHXasOx/4o3kCEOE6UL
         ZLdbRjgF7Hb1s+fr+TMTEtpm2A9RITaG2I8r7mR1yXXoZIFxCn0xxwDgeUrKEGM2FFrW
         YnLeX73AJjFT71AyYm8qTESsmDaQ3W5rs4rhK1N0ViymWl/GVTTzwjKx7/Fp1xGgye/U
         P1Kfm9TqKSMrv8zEfTE7/cEeFtHAMxwvmEBoJXcZy7QlDdHz8rK5kRjziEY+oQ/VrCqA
         RV0Q==
X-Gm-Message-State: APuU4Z8lm990xuTBYdZI8ZWlyTfv/SH77xgTm+b2xHOKb4ZNu71mrYxN
	pWpGki2RMBT2fxg4Xr37e7fEClodlsMIdLfT2Vp5Lod1r8KntV83zc6WmlOdSPNWQ0E4n2FPcMU
	gDx8W76fJMBfUlPBuN+2AE7dxmY3Ge/kvjJFPCDo6qBPpCccFwb+e3X3tjAOiihjwUYcZ4RhkKt
	XHeQH1d8bD3zaaSdKHvF0tFxV16K/3
X-Gm-Gg: AZFdTZcTn4UGzayliXi1sASY9ctgz19j9EdSURUcmxVO/WPCQ5ZeNg0xycO0dDFl9ZA
	HGtdE8uS6Fe9B7Ksd1/tQmLLMAgDOXH1Ez4Qa3jjHCT144HaI4LjUYyz8NI+Qn+ViPtdIxI7dQw
	1+Eaw/ZPtTWy3FjLJCdGCgjJOcW14XMV4o6wxyEwRsByP218M8jCkbHOw2yjNcA6xfa3LFaTM6d
	lw3UYauHW136LtLfJwhxvTQALGz77Ua82B/VJF7wX0wteTWjKu7o24A74WmIi2sRGl5NQxfZj/f
	/99FfJn9csbdZ57CZsbn
X-Received: by 2002:a05:6a21:6e97:b0:3e0:da23:874a with SMTP id adf61e73a8af0-4014c7587f3mr27857313637.18.1795789390036;
        Fri, 27 Nov 2026 06:23:10 -0800 (PST)
X-Received: by 2002:a05:6a21:6e97:b0:3e0:da23:874a with SMTP id
 adf61e73a8af0-4014c7587f3mr27857268637.18.1795789389479; Fri, 27 Nov 2026
 06:23:09 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119235656.70315-1-seanjc@google.com>
In-Reply-To: <20261119235656.70315-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Nov 2026 15:22:58 +0100
X-Gm-Features: Aa3M54qEhn7Wxct5w0YjpNlbCnASCX_MaorLcQ7GroB_soduAQi7LzpHLQ2-zN4
Message-ID: <CABgObfaZzr7UyW6j1iaz5nx_WJ2TOso+HgQkt_XC38R_UquiDA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] KVM: Send reschedule IPIs for non-waiting requests
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Satish Kharat <satishkh@cisco.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 12:57=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> My apologies to the s390 folks for dragging you into KVM's mess.  Y'all a=
re
> Cc'd because I want to use smp_send_reschedule() to fix a KVM bug, and KV=
M
> can be built as a module on s390.  I'm hoping to get an Ack on patch 1,
> definitely feel free to ignore the rest.
>
> For the KVM changes, fix two bugs with using the SMP function call framew=
ork,
> by switching to smp_send_reschedule() for non-waiting requests:

Applied to kvm/next because s390 actually needs this for their Arm work.

Thanks!

Paolo

>  1. Making SMP function calls with IRQs disable can lead to deadlock.
>  2. Batching IPIs for SMP function calls using the per-CPU cpumask can co=
rrupt
>     the mask if KVM kicks CPUs from hard IRQ context, as arm64 does when
>     handling KVM_IRQFD signals.
>
> Sean Christopherson (6):
>   s390/smp: Export arch_smp_send_reschedule() for KVM
>   KVM: Add struct and helpers to handle kicking multiple (v)CPUs
>   KVM: Add dedicated flag to track if multi-vCPU request needs at least
>     one kick
>   KVM: Don't kick offline CPUs when making a multi-vCPU request
>   KVM: Send reschedule IPIs instead of SMP function calls for
>     non-waiting requests
>   KVM: Extract and dedup the kick code to check if a CPU needs an IPI
>
>  arch/s390/kernel/smp.c |   1 +
>  virt/kvm/kvm_main.c    | 101 ++++++++++++++++++++++++-----------------
>  2 files changed, 61 insertions(+), 41 deletions(-)
>
>
> base-commit: d21eef2084a9af87ac2a783bc7c2b175ba114e4e
> --
> 2.56.1.708.g77570a6a1d-goog
>
