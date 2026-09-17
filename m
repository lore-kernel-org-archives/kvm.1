Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944944DA9CF
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789645927; cv=pass; b=T+wI+TEcOMqMpZlT9t5K5OjxrXT0Bj4kDsAALL+Qsfb8aI8rvhJTL4EtKP2wMNC1LGHQKsK1flxnOPoESGHRobr7/KRjG2YNF717+PtINlUkHoBmeL2HQABOGe944FPw0Mpl6KBM8qCE9GSUuTdlsgh3yVwSxJ0Yxp+D/5N9yWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789645927; c=relaxed/simple;
	bh=nOYhv3codkqkgw3J82tO/HjCMv9eP9bGCd7SuCfawsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KE0w4bS7hCRjwdWS2jkYQKCWmmIVRoV5xCf9WWaE1NmYsR4TFg/70n9w/8ojF+S0+flu3PmXF9gZ1obyHts34Fn/ovAPBcZW5rAnlL/diJplzirDeTFR4niNDA0WT+StDjA4Ibsu5O0jQxVilVXmfrcUv2xwTyPnfEAKUORf44w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DYjblt1m; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DYjblt1m"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b5e5aaf7deso1168e87.0
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 04:51:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789645909; cv=none;
        d=google.com; s=arc-20260327;
        b=aRPgvRo/NmkIzki9ufmGJEZPSupvlZxdqOfj2X+5BqBDD7JfZ1y+Oe53QUPkT5uplK
         SF6IDCJLSHTGW7t4iQQ95EXv//AAMK998ao4Sf2BHyhOl+59ilRwhqRec5MPPf8j3+sp
         UORWLVx/ORuozkfDNUKGU26XEj85AGdXuZsILHGfKYqozETrhlQlLMsaWbraxxWPbbrU
         8IAmmJnQM6ze3avjKQuNW3rlEtP0/LW1Je1tLT707tFKU/C392f05WnEuOMWI5N3uPmF
         f92M6v94IL70/O8aeem/cLCr4O1NLvv8LIqeAhM37tYLK14MtR+IdmFZ8r2Y22JzmLVd
         HbbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AdIwW+5qYXXR92NXdwAH/Idy+Qhx8FbslhR3tYZnWQg=;
        fh=Ez8NpNZlYpJMs5FsbI2d5a16stCZJhW3aTDCQxMMJyU=;
        b=LEUoxN5bbTWeT1Hv562Mg2FBK87glkhvmm08aXAxukPNaNOLZLOXY7lLNrs56X3KBo
         90oweheUOD1PCG573YlGKnQIfWRahUvkcbH08KCEFLWk0Rts1iGZ+ZbfhZg6HxR99V2Z
         C3ER5swcLWFoaZv0O5ctbVQ896zphikXY+U+p7Jx9itluKiaEWpCFMMhgrLSXRLcvfnp
         9oZ3pUcILl6N/qdiC+CFtmF6dBzjT7n0c3G5TcIsSOSkIwedYdXmsuUZRHEtlq0tcSUq
         eNzg5z8OpwYB6NXK6hjPwmXOgmgPL5zX/Q7UCzyZxfzZsfGt/C+NgJY1GIg7eKDwnkgU
         apdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789645909; x=1790250709; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AdIwW+5qYXXR92NXdwAH/Idy+Qhx8FbslhR3tYZnWQg=;
        b=DYjblt1mxHITRZPgDTK5tAknbFLiBRfrlKgn7iyL6XYzITysGm4r60lkJVSrmdDb2N
         G5XZ8+SgcOo8Nk/2uWZhRccqn6bWlW7cCL+HxOzOIRHVs2ZqndaPTZYyx6uitaDnQ7I8
         5mAypXm3agSscKAq5xUdX6/qci4nIk23xPpTWdTLtduSq385+ENfMboJsrQnSzPRaJnd
         VpkSVsgQGAt/WQQGKBL4WNnczq8vUXIAuLQMORX/ai6fjh2Y+Dkf4NgcNfs9mvCLFZAV
         MHuRz5CkVMnHBftLkFLmuNWGNvUQUbZwcg8vpTR5g/cqimQY9b6O3KZBmCgNN0vtJyxU
         y3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789645909; x=1790250709;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AdIwW+5qYXXR92NXdwAH/Idy+Qhx8FbslhR3tYZnWQg=;
        b=JRBQoii4/lEvQZuz8kPVUJCkcCC05D7EtFmS15Ye2KUGxHrtHdNjEz9aAq7i96+Pr1
         PcoLBMhVQ87BGHm0VkfqB3lETi0y1TXjHzV3sF7HtRmNznX78j/A9yVeTa1W+VJfvy5C
         f5Pp4TRc0FwGfaHL378q4B1tLqFfshY6fxzPKzwc2IcqgwRI64K0vpf51NxD3qDeB6SH
         /PfK1JhQvq9JWMgoUhZ9IGswqfHHu/GtC0z8MlDNQ21EGLcBAaNx/UxC/ubksmQcGwCG
         N4Mj6dT7VqAbSc+CpLttPwJ3SWb6OD2ciRuAaUd+LRI2PsrzG4tYaeaOjdJNBFUnLda6
         C2vQ==
X-Gm-Message-State: AFuF++nnpKBHdl9pg/YtwkD8cSH+XomKo995skmcM8H4t9SaNqUnXmEG
	sxIz4NGZ9R2qrWjXFceLn5r9+ms/Sw3Z4vvzNMwLrP2M3h9cXCmeydFxhnTTyXra0zSnHnNuUho
	W8iOmQFvejMrt2jP1JOV+SeHdnHlGsxfmw4/UOUEl
X-Gm-Gg: AYBFou3S4b7ZQKAcQHqDitZqcBemKvSDvnk1dppZ7VmXoRyP1xuPd6orNwS1UaVb+A3
	Vs3sQz/FjE/Tw9DnwfraweEjJd1ugKP1wO58YRIDJtPti9MB2tP+0M1pMcXfZyJ3wA5UXicEdeR
	tukuL+S9ZY+x7A/kxvkYKh+RNqDvX5myE4i3oMg9PE8oIF8J77WVBZYYwVbuR0NtzlTF7y9nI3S
	cG7sJh4lKXre4yeoG24154oHKa+tU/p9MrSqabUOijuju3JIQ53HOsAWxPf6/wmxSu5+d9w5sLA
	wt7s/Lyh4fvw/QfXCrjIuZshxR8pm9Nh3ddmISOfmB9m6Tv/PZUWHvoYWnPohopMG2lm74y1qgU
	SEvNxlSUS8PzqIw==
X-Received: by 2002:a05:6512:33d5:b0:5b1:5e30:ab4d with SMTP id
 2adb3069b0e04-5b8bff20394mr25749e87.5.1789645908458; Thu, 17 Sep 2026
 04:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915160141.3543048-1-suzuki.poulose@arm.com> <20260915160141.3543048-13-suzuki.poulose@arm.com>
In-Reply-To: <20260915160141.3543048-13-suzuki.poulose@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 17 Sep 2026 12:51:12 +0100
X-Gm-Features: AcwNN1X5WP4Na_O-dNFd8fWbgG-HeOkWBxaHeAYarJjcpr1hEP0fkdn3TrX09z4
Message-ID: <CA+EHjTxfbG6-LPjJVoErQ3iJk4vAvhVO=Qv6hjcxDXL0yByiQA@mail.gmail.com>
Subject: Re: [PATCH v18 12/23] KVM: arm64: Widen the scope of "protected" VMs
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, maz@kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, steven.price@arm.com, 
	aneesh.kumar@kernel.org, oupton@kernel.org, gshan@redhat.com, 
	joey.gouly@arm.com, yuzenghui@huawei.com, linux-coco@lists.linux.dev, 
	gankulkarni@os.amperecomputing.com, sdonthineni@nvidia.com, 
	alpergun@google.com, fj0570is@fujitsu.com, WeiLin.Chang@arm.com, 
	lpieralisi@kernel.org, enju.kohei@fujitsu.com
Content-Type: text/plain; charset="UTF-8"

Hi Suzuki,

On Tue, 15 Sep 2026 17:01:30 +0100, Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
[...]
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
[...]
> -#define kvm_vm_is_protected(kvm)        ((kvm)->arch.vm_flavor == VM_PROTECTED_PKVM)
> +#define kvm_vm_is_protected(kvm)        ((kvm)->arch.vm_flavor >= __VM_PROTECTED)
> +#define kvm_vm_is_protected_pkvm(kvm)        ((kvm)->arch.vm_flavor == VM_PROTECTED_PKVM)
>  #define kvm_vm_is_unprotected_pkvm(kvm)        ((kvm)->arch.vm_flavor == VM_PKVM)

Agree with Marc that this belongs in patch 5. When it moves, could you
add vcpu_is_protected_pkvm() next to vcpu_is_protected()? The pKVM
host-side series [1] has vcpu_is_protected() checks that are pKVM
mechanism (the vCPU feature allowlist, CPU_ON against the pKVM
power-off state, the ONE_REG rejection after the first run), and with
the wider predicate those have to carry a pKVM-specific name.

Cheers,
/fuad

[1] https://lore.kernel.org/all/20260914113338.159227-1-fuad.tabba@linux.dev/
