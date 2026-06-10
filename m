Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7444335E950
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096368; cv=none; b=hr3hhwU0sgzGLbvPFQK58G7AU6+Gxvdc4a8ERhmsFoIvdv10TH0qu6W6hoqZj59+zWmu6ENWGS44JMuhS/83JsTbPaCdUM7PlrFSQ2A37b9dfOzX0HGXODLMvZ6C70lSzcBsPo4qNq2uS4DwWlSMg7MYXEZQWLDJpbUhDNDMwks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096368; c=relaxed/simple;
	bh=TgmksmNVC96bTT2ieffY2phr04R1TTArIkyOtGoC9zk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MISmX8ziNVMCxjQOnsvKe0hnnJTgsP4zLlgojrBKZja1qQKdxU85gbKJsvmpneyGUQalJFPgqLtBP+Ip7jE3e7RmmRxw3kAzWIWO6ixHOd4Rry4IYPw8em+qzm4ppGpboaPDwUSKPI9nJoerT84NkzEno84oHZW23iaPExWhjVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v/ZEEvdF; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v/ZEEvdF"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8423efdbe6fso4342399b3a.0
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 05:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781096367; x=1781701167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1NbKBk0OFMtK3aDv+gUztpO8HwlNLStu40uQDPANIdU=;
        b=v/ZEEvdFY9YoRNnZIRIX6GKTDxeCoSA0oyTdT4uSslWB2ZG6Ht27dObcPPNmrYkMCF
         kTol3CtW2ndSNOITHCNt6rUwX6mBeOJ51NZMnKLHB4bCEdX9+F7W2lLfS2YSeM/bbZuj
         VH1ULyP3Qx/jpb2h2g+w+ivnu8YpcLnVflyKbnytHbpEbFGgoEjiqX9H9eAL4elmPAW2
         KXaxWaoCl/Q6a6+HATEyBZ1XFu5UxPa1mc1Ed3h/imtcYYTz5MeI2ednkFUdJ0aYOLD1
         CJ5Jm5JfhOM2psBsJ4/jHqol5nYSKLO41/5ywXZtvB/J/uuFoLBgg5sSzfZ42n1Z1iST
         /paA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781096367; x=1781701167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1NbKBk0OFMtK3aDv+gUztpO8HwlNLStu40uQDPANIdU=;
        b=SVoPE4oUZM/gHiXsdcMuEbPDaeb6ljaI1y3HGZy4spY6DdVlCBywTUrHp2huh1YpoB
         RF9qg2eDskgnrqnKjiwt3EeoaURRDH20PwhmNKzxoYPxRpiYYtgrFCvKhfa5ZS6Yo/x7
         k+/IrRaxaSJKN4RXVzZnNlBw4l3oxBlnR9FCoo39Ixq3aghGVtnEu4QQIKahPhlwheFc
         uKNJ6TX5xsZqtUDhPH1iqniOYG6Wn8wtSfozeJR+mMOs58ZculWvnsaOEnoVGoYCsf2r
         bsY/MhgpbeVWR+IL4pC3k0ydGGMs5KBg9cWCwB5qbyoSvok3wFKMtKbuC36AenLIXCEp
         lHdQ==
X-Gm-Message-State: AOJu0YwQxs6pzSxu+jepWgizSaZUqBoNriNS5q9ZTGxwdWdh3DD3Eg3D
	J6O7w+1imRKz9+iGD6RWkCK0I+FMH8s4GV29F0VMtKPS4OaVqVfQzjgEyi8wmEb49vBV2CcWXIo
	cE/UbcQ==
X-Received: from pfrg6.prod.google.com ([2002:aa7:9f06:0:b0:83f:1941:b9bc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c85:b0:842:48ae:1d56
 with SMTP id d2e1a72fcca58-8430a742437mr8863146b3a.35.1781096366425; Wed, 10
 Jun 2026 05:59:26 -0700 (PDT)
Date: Wed, 10 Jun 2026 05:59:25 -0700
In-Reply-To: <2d2c46be7f051c7f1c645afaec67f57067d37a81.1781093720.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1781093720.git.ritesh.list@gmail.com> <2d2c46be7f051c7f1c645afaec67f57067d37a81.1781093720.git.ritesh.list@gmail.com>
Message-ID: <ailfrWKNI9SfBNRh@google.com>
Subject: Re: [PATCH v3 RESEND 05/10] KVM: selftests: Print the vcpu_id when
 KVM_CREATE_VCPU ioctl fails
From: Sean Christopherson <seanjc@google.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 10, 2026, Ritesh Harjani (IBM) wrote:
> Print the vcpu_id and errno when the KVM_CREATE_VCPU ioctl fails, for
> debug purposes.
> This helped in debugging an issue with KVM on PowerVM, where KVM_CREATE_VCPU
> only supports max 2048 vcpus, because the PAPR_HCALL H_GUEST_CREATE_VCPU
> ("Documentation/arch/powerpc/kvm-nested.rst") supports only up to 0-2047
> vcpu_id. However KVM_CAP_MAX_VCPUS capability extension always reports max_vcpus
> as NR_CPUS of the host.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index e00a25f59416..6319e2037882 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1354,6 +1354,13 @@ struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
>  	vcpu->vm = vm;
>  	vcpu->id = vcpu_id;
>  	vcpu->fd = __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)(unsigned long)vcpu_id);
> +	if (vcpu->fd < 0) {
> +		int saved_errno = errno;
> +
> +		pr_info("Failed KVM_CREATE_VCPU for vcpu_id %u with errno %d\n",
> +			vcpu_id, saved_errno);
> +		errno = saved_errno;

Sorry, but NAK.  There are myriad failures where printing extra information can
help debug a failure/assert, I don't want to create a slippery slope where the
codebase is littered with extra print statements that someone found useful at
some point.
