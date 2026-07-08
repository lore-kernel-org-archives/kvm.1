Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2910437101
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783528834; cv=none; b=E0sLRtzB/jI4+Xz1UEjpKfqC1LFY3GtFH0YGehbz0jsfoWCbOePzYCetuOlT4YkNugrgivPcqJk81KV1ek/8HUHS+rLaTJvNHZT3SC6f2izQy0a0FEqQ56/mmVbYyXfb/VYzE1vZGlSpg5vsWyyd+G6KvGDdAvNH8mqO4F4ng1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783528834; c=relaxed/simple;
	bh=c/XEaNKYNrF1l/hWu7ALmwJ52AsqFo535mfE2TQPLXM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e6RzNQuc2q3UN7lye0g/yhyu0k3GmlT0U9SU13vZ+/7Y1NrVrpP2jVvdIgoRIY4y17BhnbuVotZ8E/up+iFD6yT2C0zrqX6kXBNdRP7GLfd5R8hLuj0iOSETQBVrVsD7y0UxS9A4S/N8XnS1HiKSMaqaY8aqFtS8C0b27UcFmR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bPEQ80D4; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bPEQ80D4"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c894c1c4aa9so1184565a12.0
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 09:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783528831; x=1784133631; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zFGoN9qGAHVZ4QAdcm49XPHorQEUZRxj5glJ1u7VDTg=;
        b=bPEQ80D4x2/kMzYcInPE1ZZ3/vm8Bh7JoCfvDDRUsfSF3FHF6+tYyUV8ncxkDukZ5e
         5EYmPfqSbBmo4HMsPzGvrgbPukkmh2+nhpmxuwrH2B5GQkHgUhMvPpzY2PxEx9jR7ssu
         0HHvbl+SESnmvTTgdRyUdi0QrVxpK9+URO39XbXV+dkjwlmrxJNTQ7fGaAfYAwiVnZMK
         W6GudAbYh0yGFLTQ3LKRWlL3O5W7CeIcJDVYgSX/l9M7ni0f+nSz+MFdNKWW67oOBd2g
         5PY2MEQG9TzPnBxK9Wkc1GCVNpfwywXw2rdeMtTxd/jt6VExGml/+1/6IAr21oU9nKe1
         2/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783528831; x=1784133631;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zFGoN9qGAHVZ4QAdcm49XPHorQEUZRxj5glJ1u7VDTg=;
        b=Q86YmYDTB8lr/taue+A+sCrrdVJxcW5Pl/ZU3yPw3H09qFD2aoYKDbw5TyK7T0UgQT
         PQkFIOtwX53nfiLHigJ9KU/q2wKs+/+tFVvjY82hv5olCSMqYcD2Ueta7kcxXSu3qATR
         AbJTCcQH0+/11O8C+WT2fr4CydgDRjp4x0sgK80ln1jM31HoBFcJvpy4eZpsPKM0tjj0
         +SdSvc5+LWbvdgLt7hu0XDSasYddeRQ/NXaNzqfn6ybpMJnrtEknbH6Xwc272f8N/n2j
         S9WeN6sSuNz1Ms3k0Wys3FZ4LZRMDHheBQyily/LSME/8dU0ZSRBCsb+bgRi/A6fa4ft
         b36g==
X-Forwarded-Encrypted: i=1; AHgh+RomUiQFQBp5ePrHwZT5akn9A0O7QyYCpkU7wk9K+lGBWOItc6Plbvh8rlSt5lgzjmtptaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUprZI/suowXOeOmofj2UN/SdvQgIAuRILj8jSRf+CfBlQ+Qp3
	ClRO9tfn/vQ98Vy3nuJ71ECxz2QRVOuViLob572xMzHn99UcctL46l7JAI0JkZPkOU0NygOpYVX
	0v/YGtQ==
X-Received: from pfbmy25-n1.prod.google.com ([2002:a05:6a00:6d59:10b0:847:9499:46c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9487:b0:848:4b27:36a3
 with SMTP id d2e1a72fcca58-8484b274223mr1645594b3a.72.1783528831076; Wed, 08
 Jul 2026 09:40:31 -0700 (PDT)
Date: Wed, 8 Jul 2026 09:40:30 -0700
In-Reply-To: <1782119051448443.14545.seg@mailgw.kylinos.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <1782119051448443.14545.seg@mailgw.kylinos.cn>
Message-ID: <ak59frQUBl9Gs3Qn@google.com>
Subject: Re: [PATCH] KVM: Nullify irqfd->producer when add_producer() fails
From: Sean Christopherson <seanjc@google.com>
To: leixiang <leixiang@kylinos.cn>
Cc: stable@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@ozlabs.org>, 
	Suresh Warrier <warrier@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 22, 2026, leixiang wrote:
> The x86 and powerpc add_producer() callbacks set irqfd->producer before the
> fallible setup and never clear it on error.  The bypass manager doesn't
> register a producer whose add_producer() failed -- producer->eventfd is
> left NULL, so the later unregister early-returns and del_producer() is
> never called -- so nothing ever drops the pointer.
> 
> For VFIO PCI the producer is embedded in struct vfio_pci_irq_ctx and freed
> when the vector is disabled, after which a routing update dereferences the
> dangling pointer via kvm_arch_update_irqfd_routing().
> 
> Nullify irqfd->producer on the error paths.
> 
> Fixes: 77e1b8332d1d ("KVM: x86: Decouple device assignment from IRQ bypass")
> Fixes: c57875f5f9be ("KVM: PPC: Book3S HV: Enable IRQ bypass")
> Cc: stable@vger.kernel.org
> Signed-off-by: leixiang <leixiang@kylinos.cn>

Please post the PPC patch as a separate patch.  x86 and PPC are separate maintainer
domains and the backports will likely need to go to different LTS kernels.

I'll grab/extract the x86 change from here (and I'll massage the changelog as
appropriate).

> ---
>  arch/powerpc/kvm/book3s_hv.c | 4 +++-
>  arch/x86/kvm/irq.c           | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3..14919b76fb32 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -6114,9 +6114,11 @@ static int kvmppc_irq_bypass_add_producer_hv(struct irq_bypass_consumer *cons,
>  	irqfd->producer = prod;
> 
>  	ret = kvmppc_set_passthru_irq(irqfd->kvm, prod->irq, irqfd->gsi);
> -	if (ret)
> +	if (ret) {
>  		pr_info("kvmppc_set_passthru_irq (irq %d, gsi %d) fails: %d\n",
>  			prod->irq, irqfd->gsi, ret);
> +		irqfd->producer = NULL;
> +	}

Unlike x86, AFAICT there's no need to set irqfd->producer before configuring
the passthru/bypass stuff.  So I think that fix could be this?

diff --git arch/powerpc/kvm/book3s_hv.c arch/powerpc/kvm/book3s_hv.c
index 61dbeea317f3..ff7b25629125 100644
--- arch/powerpc/kvm/book3s_hv.c
+++ arch/powerpc/kvm/book3s_hv.c
@@ -6111,12 +6111,12 @@ static int kvmppc_irq_bypass_add_producer_hv(struct irq_bypass_consumer *cons,
        struct kvm_kernel_irqfd *irqfd =
                container_of(cons, struct kvm_kernel_irqfd, consumer);
 
-       irqfd->producer = prod;
-
        ret = kvmppc_set_passthru_irq(irqfd->kvm, prod->irq, irqfd->gsi);
        if (ret)
                pr_info("kvmppc_set_passthru_irq (irq %d, gsi %d) fails: %d\n",
                        prod->irq, irqfd->gsi, ret);
+       else
+               irqfd->producer = prod;
 
        return ret;
 }
