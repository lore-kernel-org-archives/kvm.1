Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0EB3CF676
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500261; cv=none; b=bwSlENk8D15N+o+0avtX9D1dhtskO4jTpnfPiUDGP3Lbv18JtmgIgTd0betlqsUWj/vdvBiYqRfehRYbsh2k3w5gM9+oyNhuefrNtqXoZUTuIXpp+ArY56DTr+61z13iV6Kw0VA16MrXR3OE0JWHtym7YMw7IunfTIJvAmdLOE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500261; c=relaxed/simple;
	bh=y2MzPoG0MBmV9/S2CGOi17yiKJyXbHXPrURfp3Atgkc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=jUpsUZV0USyU1/yFoU3zLlCiafNeYX38Dv9GyfZbeljzEr8WL77H40+zZt2QTbZ509P8nb5KHFrBnXEKRczSdQgw/eG/Mketwq7HQtTQuypopD5elu6wldgQiwD8Y3nK9pk8CYjAeNQG7fREQtQc+3jfFKDCuCpVe7U03uL1t5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n+ZSKX4Z; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+ZSKX4Z"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c858d69bde9so1991469a12.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 08:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780500259; x=1781105059; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=acwBnprFgwqGQFKcy6Zu5y1vKCe+2/zpivoZrYetfHk=;
        b=n+ZSKX4ZO6fXZWVJSLJCCrokYWO2iillfnIsrkhOqSFVlrdcKMjqoIe79+KCX+34bd
         8CUXsh9ne1F7TyOtZ+mZocplQ+K+GEvo/N3CdkxOWe486ftFobP8i+ccQckIzlnpMmIM
         mWO1IkO7n89CKudClVO1Uxackh7QON0sX3F3BhiYc5eJvXx4eXLI3xMkG8UMwUgFw6Oc
         8sfX8vJ4WqiXyz//Cy5iy/K4i/Ocgz+SB1Uske50mTjWHcW5NL8W0ZRJDVXPkk2y2FvN
         Y1gIfVWXa9MfHZnmWIbfHss0NFmIVo/TZpl4osk9azJhAjtlyAfdl38yJewkUI58rD2K
         37uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780500259; x=1781105059;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=acwBnprFgwqGQFKcy6Zu5y1vKCe+2/zpivoZrYetfHk=;
        b=Hr/f+yfI5f5xt8MzqL13kUxCJ5AAjlXfEPoUlBuQ47eJNy2BHRfYEToJQ9rmeyLazG
         IbRt5i1NSNnN28U7RjlpkQfvUMspr2it0QDSPgtygHx8ED61lWQyHhhD3SDLXVoebzlI
         34aJxsrtYtEfiB2b8u1BU/rsYtiBEP0p1+7yashoPU1UFTjwdczdBELVa2X327o6dKzd
         pBkvHPOb/sU9tBI1NdyD7aPlaZ72q4dIN85FnfSz63MNADZLOdRvouzwiJ3vbpyK8p3p
         vfkKnfOt2buYhwXn5znD2EH5zExBdL3t0ayeiTrB+iyWouA3tifk7OC8K5MdKNCP8GYe
         8xtQ==
X-Forwarded-Encrypted: i=1; AFNElJ/jXZX5NFvXtLole9w7NUMXMjE2gM5OduKNjwzYlfCACbGOqaakR57YNdxF6OiObziUpyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzExn0tmP2c5k27a8Zpv2uR4zvWD8qp87FTkVw4jMiuVNVxXH+B
	X4b7W2O82b74SAW9N34sw83EUQm4xzGp3zmLG9CoHer0PnTMvtnK3yHJbqh7KUo8
X-Gm-Gg: Acq92OEa/u8elGQxi25/cQt+DL2H6L663Dif2VlOW/bEDNNTwAKFXBhzfRHNh3M2jGB
	0L2xzTFA0kLiJm1+vZdMw6tALLsfDQYyPW5HSApcebRsCOeSkNWq3S9jhVOnqFVMoUh/51PBGm3
	nLF0DJfLmLWQy1R877Fc6rOOTcgt5Q38fBSgJNcaFNDle9uQiLrVy+7I0rf2dPWz7L7MXCTN3MC
	dEnDOkKUIBWGZxotpt7slHDiRsgijb9bnWp7kgaZtr53BkLsGX5Hce1B6u36Naj9cPW6+RBb8Hy
	psQfmlJiRg4GiXp8asaGgZt8eZCMdnQ69SpLrQZwdi8IFB1+9iSXuhqs7a/lIVOpqlqj55lQo5c
	+yWg4/UAsNb5WsjwEu46Evx4PDf1TR1SxJpEGkC3Iru3d2ephYtGCXAqCQqR0SWFf304y9xmwlJ
	c83oFDvePbzLorCeauoc4o0T0lYSeyv0EF
X-Received: by 2002:a05:6a21:691:b0:3a2:d68d:9e78 with SMTP id adf61e73a8af0-3b49732971emr4778730637.4.1780500258903;
        Wed, 03 Jun 2026 08:24:18 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df043ce0sm2671767a12.11.2026.06.03.08.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:24:18 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, kvm@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
In-Reply-To: <20260603141539.47620-1-amachhiw@linux.ibm.com>
Date: Wed, 03 Jun 2026 20:41:15 +0530
Message-ID: <pl278xrg.ritesh.list@gmail.com>
References: <20260603141539.47620-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> On IBM POWER systems, newer processor generations can operate in
> compatibility modes corresponding to earlier generations. This becomes
> relevant for nested virtualization, where nested KVM guests may need to
> run with a specific processor compatibility level.
>
> Currently, when running a nested KVM guest (L2) inside a Power11 pSeries
> logical partition (L1) booted in Power10 compatibility mode, the guest
> fails to boot while setting 'arch_compat'. This happens because the CPU
> class is derived from the hardware PVR (via mfspr()), which reflects the
> physical processor generation (Power11), rather than the effective
> compatibility mode (Power10).
>
> As a result, userspace may request a Power11 arch_compat for the L2
> guest. However, the L1 partition, running in Power10 compatibility, has
> only negotiated support up to Power10 with the Power Hypervisor (L0).
> When H_GUEST_SET_STATE is invoked with a Power11 Logical PVR, the
> hypervisor rejects the request, leading to a late guest boot failure:
>
>   KVM-NESTEDv2: couldn't set guest wide elements
>   [..KVM reg dump..]
>

Thanks! It make sense to return a proper error code to the user (VMM)
while the VM/VCPU are being initialized, rather then the guest failing
to boot with a weird error like this, at the time when kernel makes this
H_GUEST_SET_STATE hcall.

> This situation should be detected earlier. Rejecting unsupported
> 'arch_compat' values in 'kvmppc_set_arch_compat()' avoids issuing an
> invalid H_GUEST_SET_STATE hcall and provides a clearer failure mode.
>
> Add a check to reject Power11 'arch_compat' requests when the host is
> running in Power10 compatibility mode, returning -EINVAL early instead
> of deferring the failure to the hypervisor.
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Cc: <stable@vger.kernel.org> # v6.13+

Sure, v6.13 sounds fair as you pointed out.

> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> Changelog:
>
> * Moved this patch out of the v3 series [1] as discussed here [2]
> * Addressed below review comments from Ritesh:
>   - Based the PVR validation on cpu features
>   - Fixed hcall name typo
>   - Stable backport

The changes looks good to me. Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

