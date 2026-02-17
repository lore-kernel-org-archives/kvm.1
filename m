Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AD336C0C8
	for <kvm@vger.kernel.org>; Tue, 17 Feb 2026 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771342626; cv=none; b=owVNeSlHAmpWcx21OPMVIGMBpCsyisPvyO9gf5jHd9+MVy3D/nPd1ZIoX3POGG4nC0ZaTKnt8vh9JoAelzrm8+l38+5bsNy+YxDhxWg67f91PrOadpzMPPY773CjpgCKRnGovJgPQjZq+iMFHUi8vri5NQR9/e2lsL6wez+G39I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771342626; c=relaxed/simple;
	bh=TphFOmg5HX47PxcNF0aXXEWkqBDunsNyhd0Q+qPBanw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pzajXvBKcBj14usEFTKjmLv0uUqoL4uvYBWY2XYqc8VDUfYoadKbouXOkcuoi8yNk53YC0KrUFiw3xgVrAh0BBreJJm2OCmbujvMtvGPGxrppesQSasaP7BwP0bIaOGJEBm+8sxr//ur2O+QJqVj1jJz8DgLlJyE4q0RRrK88EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R+oT34JJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R+oT34JJ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35449510446so4177684a91.0
        for <kvm@vger.kernel.org>; Tue, 17 Feb 2026 07:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771342625; x=1771947425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WTxcxfGLHAARjNrp3hq8o4WxaX/qmkiZ+kEfmNnUDlY=;
        b=R+oT34JJ8+26th6EN6YO/RzQry07+uSnZfEI3LqHol5B4zzrNVScqYOuLW0MwX4Njv
         30xMQKsSFC0g+cZggH9xsDkFgMmMrzaFIqYQ7VOcYbIjC679eU1EBApuWVUkkY26z7zU
         jXUQwgdl3vQpd+Io//Dhjw4Ud40PTmvPXZIdzveW8u+1HgcYOZgyAzxxFyv0gfkScub4
         tSNhTGi64vYTuVpwAOU/lvW13KzIlye/91zyQXB/A3OCiFkdj1okps3tUVdU0NnwLUmC
         Hsw+dAT7NXAbkR91EoTR2NOjk4zfverLyjhxLUUGv1NJtpUERblVt7vRQZGd66r3hJiA
         VDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771342625; x=1771947425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTxcxfGLHAARjNrp3hq8o4WxaX/qmkiZ+kEfmNnUDlY=;
        b=O89RyCmQto3SmNarP44+Z36lwSpscucr8q4oAVAt1B9Uz1i9hSlEqCIQvBziIHUOdJ
         aaBeK8EMFvvI3xCbSN6vmjY6E/5012CL+IeVwJuFdiYL5UrVdsxQNCDzpNDzxwzUWPhZ
         4H7Hlp1FbDApZI97n+CsBrkdIHXxGn2/cASe006L+Jyo9gTcZ40FLpOyP1CQcXAWospa
         851jOhLCIRWcY9MDFs2ZKN+LW7qZDKY2FMzmtLCqBluzksCmY62rUrw2YLS/WwdpeXOZ
         aedEDBqMPY/FEyVEdJ1TxpjKD+WR1wuv8xd0VSLy+5ViQCyfW65WhcRK/Ta5dNUMf4xv
         wZAw==
X-Forwarded-Encrypted: i=1; AJvYcCXKRu42Ao0lnKOL4PML/8xqp+D5CqgVp54An6zujn8yg1vmdkex9kRGAoo4pk1P9+AwmBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4HfNeXfxX//9VpAdvrrdKtTobDpWlowZEkuDPTvz4rXWx0DNG
	I41b+6lFZLP2HU2c/Pmm0LWFS0Pw3rbhntyIjbtkjY43xMRFdoskZgOfCVH17nd1uVmrhe28fKO
	OBjK3Ig==
X-Received: from pjbjz3.prod.google.com ([2002:a17:90b:14c3:b0:353:d0b3:8611])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d60c:b0:33b:bed8:891c
 with SMTP id 98e67ed59e1d1-356aad70cc4mr12681639a91.23.1771342624794; Tue, 17
 Feb 2026 07:37:04 -0800 (PST)
Date: Tue, 17 Feb 2026 07:37:03 -0800
In-Reply-To: <tencent_606610DBCF4CC9C810B0694110E12E135C05@qq.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260215140402.24659-1-76824143@qq.com> <tencent_606610DBCF4CC9C810B0694110E12E135C05@qq.com>
Message-ID: <aZSLHyMp7WQ_HxeD@google.com>
Subject: Re: [PATCH 1/3] KVM: x86: Enhance kvm_vcpu_eligible_for_directed_yield
 to detect golden targets
From: Sean Christopherson <seanjc@google.com>
To: 76824143@qq.com
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, zhanghao <zhanghao1@kylinos.cn>
Content-Type: text/plain; charset="us-ascii"

On Sun, Feb 15, 2026, 76824143@qq.com wrote:
> From: zhanghao <zhanghao1@kylinos.cn>
> 
> Detect "golden targets" - vCPUs that are preempted and ready.
> These are ideal yield targets as they can be immediately scheduled.
> 
> This check reduces unnecessary yield attempts to vCPUs that are
> unlikely to benefit from directed yield.
> 
> Signed-off-by: zhanghao <zhanghao1@kylinos.cn>
> ---
>  virt/kvm/kvm_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 61dca8d37abc..476ecdb18bdd 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3927,6 +3927,9 @@ static bool kvm_vcpu_eligible_for_directed_yield(struct kvm_vcpu *vcpu)
>  #ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
>  	bool eligible;
>  
> +	if (READ_ONCE(vcpu->preempted) && READ_ONCE(vcpu->mode) == IN_GUEST_MODE)

This is nonsensical.  It should be impossible for a vCPU to be preempted while
IN_GUEST_MODE is true.  Even if a host IRQ arrives while the guest is active,
KVM should set vcpu->mode back to OUTSIDE_GUEST_MODE prior to servicing the IRQ.

Even more confusing, the next patch explicitly rejects IN_GUEST_MODE vCPUs from
kvm_vcpu_on_spin().

> +		return true;
> +
>  	eligible = !vcpu->spin_loop.in_spin_loop ||
>  		    vcpu->spin_loop.dy_eligible;
>  
> -- 
> 2.39.2
> 
