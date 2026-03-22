Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A4A366553
	for <kvm@vger.kernel.org>; Sun, 22 Mar 2026 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774192138; cv=pass; b=aK7wt/TuU2q9qXX4ak4gxBg+3KnqBqVqpx7szH33Hyjo2t3MGzoNGn2+peJe0l0eTZaG0YAwnxTpZfi34IjPLciKQYfCy7kpBfme/4yECm+L1Sn3XCmzxFQXgIGEKhsfPPR/qSLHUUMFU2K+/NpXdK0tvMP8mAfdOH36CLC6Q5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774192138; c=relaxed/simple;
	bh=pwF6ptSCRSiMSzl4UxDpSHb2w4DQkBrR++7isbAPc1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXaHlyT6pMYQhOhwhjFC7Rxcfy+aWg1mA/cG57MyJrxvCGf0WcaCv25WpUk4TwBqLZDw2RuS6xSC1GtbwTofuUZB/AXfzScQF8fnEcmpIi9/kHMnYWXa0r6Vp/gF5FDCS1OrPiDsYmsZbaYp2hZFdvutP4R+PNUrUKq8C8ZtFbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mZ7YgGoI; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mZ7YgGoI"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-509069a7a7fso790001cf.0
        for <kvm@vger.kernel.org>; Sun, 22 Mar 2026 08:08:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774192136; cv=none;
        d=google.com; s=arc-20240605;
        b=VLW1PwhDkvbhkdvfJkFZK9NqbtB3DXjaZYrNlsDzNUBkChCUVlNFmihvtssUOlDG+L
         XrXNw/8yHl4LI74BIf4dYW1G14rOqZmvhH4vJkJpP+VF7FQslQN/dXb2EwWPeOq5qrTq
         OlL3zqLuwAoUpWcN8lZJI29MbyV0rtHpDpOdHGUIej1t/7Yolq0qJnF9hEfhT+IK9z8N
         1RXZ95Cvr8tLIJ1buRB7hB+7zPL+Wl6Ig2T78yYus6Z5jNYGKD/ma6xBB/c28a1uo1Nl
         HsUE9SaGya3Kk5GjAoLE+Lhy4cd5Jd4KpJxZ4NEc5evEtZWc4rbMJE+l3bd0GgqpMaLt
         HGwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TR5RyAMW7afQqyguOMIyPaHLXgPGUcb/ZSGixWj0Ook=;
        fh=Qp5umBR9vNVAHkc22JjGWqqcYvGtHCqQqLHkWAKxhLA=;
        b=Xr9U7xSb4Y2aiQna0Xx9zbbj63GZzBQUPZcuum2jdocp1Z+lmb8TRe+C5lDhJClBwH
         /nTbDrAhhpEZOemv4WZVaId4vqpGJ8TlNDNWIEwB4XUWqZOgknJQS0WUjEpSQV4gBFHS
         F8UISQBiqkSSZEPIeRVbB+Xeodb6UR8h/t1ms1DrINOnOL6Azu0cUJAwiskF4WAprTaV
         oOzfwK4MkSUloHlySMgQHedeBg6LczNdHN7a9sPUdpgf/EcNd3mk5YNsLVBWGaWhWevQ
         GD+sXuRbfcVS2ftG1Srdg3SjxZcu/6jz8uj8cNM80n84SumJyL1gUc8xCYOZg4SrW08s
         Xduw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774192136; x=1774796936; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TR5RyAMW7afQqyguOMIyPaHLXgPGUcb/ZSGixWj0Ook=;
        b=mZ7YgGoIUsGNQLzYh+DJfXg2zr2v6volLg7err+sTaNPLo4cjQAcSlU/4OOonSiJWS
         s/v/gVdkC7ILTiofwRRPd2oRawlYsy1gx1McFBJyO2rZGnB5A60OkH6173jBYiwArpAU
         eT+iMwM1vYHPO/isTHI0r1ocySS3jr/r49dycDAmJYDbCuY6AfwFDSaLtorsbjEOxaqe
         3zbO/lRMvEGUyS5/U8fnNzbYi1d/OW+zH4sK11l389V4XdBywfcTB8MYtnCvPGCcfsoe
         HIZ3HfoCNegDlkn+2v6xzkhp1tNeV2kL08lgwaFY19ZQwHzOZSE9mBvQhIYMr0gQD2Ny
         MwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774192136; x=1774796936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TR5RyAMW7afQqyguOMIyPaHLXgPGUcb/ZSGixWj0Ook=;
        b=gBh7rt9Dax70aWrlSiQSG1+rKbhgO1Z1x+4GWUOGaDLmzhOdQJbPYJLiRgphRFtauW
         0kmo4CA0VXR3BgC7VPnalVyD9O9TiaEU6oCoGk6HRrz6UghlqEAwrveEwzPq+nqh8a6y
         2v2BD9GleXzY4fl7/9eWwz68WfXFD21x1dJpiiwfmP1NsZbRDjD5wUyYcWSSd+ycToxF
         nH53A7T1H6jn2bnV/IyY0acWiMBbMrko2/YqKnv00vaTH7/hCwZoagrl859ubmXR8wLn
         D8EbmiHAs9YSZIrintbwyyy+TFQuh/nbTXrWVNHXL7BfJRpmy4SgUYdsFXIvffro4gLR
         NFBg==
X-Forwarded-Encrypted: i=1; AJvYcCVlVkaHYuCSD8oVRXH002ViA8B4h99Krg3WHNvJ9koSJRbHYxAtPwQHgBzR3n/ydzo5CS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyRTJMz0sLdeKiVaBzMJsFd5OTdcrTu1o0MdDjETdi3haeVWyb
	2/eB91dZNOXm7j8NmnBowXMZKihz1kCF5x+oTSoaTODmF6wQUXBnLLQxGf5Wt0zCoYi1BHaELON
	oibxQonZsmgV5EieOqkQP9jXBczXy5igkmNUg2k0x
X-Gm-Gg: ATEYQzxjoLSQFDkyLIb8o+JoxOfnP/ahAn/nsIibWpaxrXxuh6Bc8ExFD6ARsHL3qhw
	G3s4SeCo4r9jb7xdh05KHmVE8jB/FBqJ6nG0jKw4tY74/7dIwi7jQ2mlQJRSTYjFAH49iXBGJu1
	4gU0g0XSsoGr0TimmhGKQFP6Tkgza2HrfQWbqqE2NaqwvsKyWEe4B1BsSPgflbuO+ks+g+rCojZ
	AfYPussPbD3JI9JyM0AjDxr5w4okL9ebTqoDBW8ofZoErgZV85VwhJOVCzRP/4I+cOEwi5uk4Eb
	CdAX3I2+
X-Received: by 2002:a05:622a:4a8f:b0:509:cd7:aa18 with SMTP id
 d75a77b69052e-50b46cd0bbamr20546021cf.10.1774192135946; Sun, 22 Mar 2026
 08:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321212419.2803972-1-maz@kernel.org> <20260321212419.2803972-2-maz@kernel.org>
In-Reply-To: <20260321212419.2803972-2-maz@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Sun, 22 Mar 2026 15:08:19 +0000
X-Gm-Features: AQROBzChkGh3Y5_KqgUzXigR7VJuZFDR7yUQIpecNEvPXr0n70MRqp06E-mDBgE
Message-ID: <CA+EHjTzkB9TXxjbSmWPW1T2HS=4tk5L=y-DLNv0hUFzqh7m7aQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] KVM: arm64: pkvm: Move error handling to the end of kvm_hyp_cpu_entry
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Will Deacon <will@kernel.org>, 
	Mostafa Saleh <smostafa@google.com>, Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 21 Mar 2026 at 21:24, Marc Zyngier <maz@kernel.org> wrote:
>
> We currently handle CPUs having booted at EL1 in the middle of
> the kvm_hyp_cpu_entry function. Not only this adversely affects
> readability, but this is also at a bizarre spot should more
> error handling be added (which we're about to do).
>
> Move the WFE/WFI loop to the end of the function and fix a comment.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  arch/arm64/kvm/hyp/nvhe/hyp-init.S | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> index 0d42eedc7167c..5d00bde092010 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> @@ -201,14 +201,9 @@ SYM_CODE_START_LOCAL(__kvm_hyp_init_cpu)
>         /* Check that the core was booted in EL2. */
>         mrs     x0, CurrentEL
>         cmp     x0, #CurrentEL_EL2
> -       b.eq    2f
> -
> -       /* The core booted in EL1. KVM cannot be initialized on it. */
> -1:     wfe
> -       wfi
> -       b       1b
> +       b.ne    1f
>
> -2:     msr     SPsel, #1                       // We want to use SP_EL{1,2}
> +       msr     SPsel, #1                       // We want to use SP_EL2
>
>         init_el2_hcr    0
>
> @@ -222,6 +217,11 @@ SYM_CODE_START_LOCAL(__kvm_hyp_init_cpu)
>         mov     x0, x29
>         ldr     x1, =kvm_host_psci_cpu_entry
>         br      x1
> +
> +       // The core booted in EL1. KVM cannot be initialized on it.
> +1:     wfe
> +       wfi
> +       b       1b
>  SYM_CODE_END(__kvm_hyp_init_cpu)
>
>  SYM_CODE_START(__kvm_handle_stub_hvc)
> --
> 2.47.3
>
