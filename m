Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D561B6CE9
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 01:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194017; cv=none; b=XSBDlDKroi5+nBVCS9YaDYpWsbwK3r3LrqTqZ2mhrF2S7j5x/DyBkcMojzhAiQr6UWNbtU4qxRpI5e/rP2cYh+YEZCDT9uMOdwNST10f4W+7z0UNeCrI8EXTjJaP4QJhr5GsM3Vak3mQykibHRmYCtn9ZSrDhyXDBuVoWOhCsa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194017; c=relaxed/simple;
	bh=Cn3FAzbpIDaEdwOckVcpV2MlJjKKbKv0DWwiqp7cx2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pb0HHzRpgnjwVPin+I3qK9ldR2bE1VIcw6COy56lI91PUKaoRhxQFNGSYHNxMJ8l63RwsEQ37Y6D2KH45vg+cBaBL+unANT+g0s++2Xar2FMWA0i9AUnVwxTDOOJSFf0xl/qcMdfbPOoZML+jaEF5MMA/j5mH+zqRe8dekpB+4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7k4xJHJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7k4xJHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC90C2BC87
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 01:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773194016;
	bh=Cn3FAzbpIDaEdwOckVcpV2MlJjKKbKv0DWwiqp7cx2Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I7k4xJHJqHzVLaodyKGgxztkJWEiZq/qq/xkvK1awJYo8qRH2qyskNNJJl2St7n06
	 87Dg7lpWZT0UttrsJOhiKmduKQFG83BpDN/9iMdrxAxexYoRdDebp72pgg0CwRJgjH
	 jcIchzX9ZXQpmapYSi7ZO0E0gKdN7wW1j2rgAne4VXT14piVkq0Y6rWI8ikPvvKT0+
	 D+9FDKKGRPAvpE/Q6MpOd6AasNV7sp/WuFPnjy3031xxylV+NCvUio0zUNghBjqrPa
	 RqNb0a43HXE8XeX0NBTn7gCU74D6V8P7G1gWvI2xkCwY8C2GEK9a5zz84Qy98Z94O0
	 K5aP/KsRjq0LQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b942b36de08so89662466b.1
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 18:53:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZK/TBMSmshNZ8Fuw2L+lpdBzXmRQ7AzbxvpSmsRfAZpUJyGg5WqjIMhOi5AaOJaUtKpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhYfixAGRkaHED0rp54OTR0qqVZTyvNWt5jfmwzKQ08hlPhp7Y
	OXSCCe7cXXUjrPXsRc7/2ivQZ5xVvKs60cIUKm4CAWNGdqpNI4Oy5wafNu4rgG1TSSRWKF73j0J
	Jz9KA95bKeQD5x4979KwTFMfmn/g6s6k=
X-Received: by 2002:a17:907:3d56:b0:b88:5b72:ec39 with SMTP id
 a640c23a62f3a-b9711851e14mr304701066b.5.1773194015482; Tue, 10 Mar 2026
 18:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310224546.2582118-1-seanjc@google.com> <20260310224546.2582118-3-seanjc@google.com>
In-Reply-To: <20260310224546.2582118-3-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 10 Mar 2026 18:53:23 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMTEi++JvAfKbMd2676Z8cTPQKcWA+mydzXGYPenUrG6g@mail.gmail.com>
X-Gm-Features: AaiRm51pmrNdHHIzOZbiqmxJUGlE63kp9bQlWh35VVzffsJJrzBBFfIrz7aWIMU
Message-ID: <CAO9r8zMTEi++JvAfKbMd2676Z8cTPQKcWA+mydzXGYPenUrG6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: x86: Suppress WARNs on nested_run_pending after
 userspace exit
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 879cdeb6adde..cad16c83dcff 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -12090,6 +12090,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>         if (r <= 0)
>                 goto out;
>
> +       /*
> +        * If userspace may have modified vCPU state, mark nested_run_pending
> +        * as "untrusted" to avoid triggering false-positive WARNs.
> +        */
> +       if (vcpu->arch.nested_run_pending == KVM_NESTED_RUN_PENDING)
> +               vcpu->arch.nested_run_pending = KVM_NESTED_RUN_PENDING_UNTRUSTED;
> +

Why not inside kvm_x86_vcpu_pre_run()?
