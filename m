Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7A2377A85
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054623; cv=none; b=lbGm/MuWqGXnR02t4kyCEBJ/yEgPPH1ZUyZbj09nwtL9cKUbDjUOemWGswbVP1CLbAXye3XnI7S7YMrExQCDN5Qo6ybroW/07qAzBeAgensNfv46BlPXkEBtGHB/wNuUkL3EXa5zHYvFucn76TIOy2+fSvljqo+vDuWMZ2mOau0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054623; c=relaxed/simple;
	bh=0Cxt8qE06Or/jQL8clXHIMUHQkQVbLUBxaPpYh+HO6w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cEr1CRqH66EBPZL0elYIp5g17mmIwV7N7PYK/0s5gcHsOYbbaz+hfQzb4kjtWfGDTk3kB03l0Xm6Gh8t3XJwX3ohwAqdJAdn/M14oARXL6j0DV2TwKINGTm1K5OYz/Ror6vFrakM4uj6m1R5ti7N/L87jcQG9tsvhPaPObSihHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DMUDT1ov; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DMUDT1ov"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84877b362f6so7613186b3a.2
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 11:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784054615; x=1784659415; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rFM73Nl0bWyUMJUomM5RdFpNF5aybZxuz1pkz9xV3sw=;
        b=DMUDT1ovU2EeL+NddwKYGRCPCweeER39Iu9QEfk0M1UzJHwT85hdhiTSoOq5FV73de
         vUoHeld5mZZ/zhrWmk4e39o/JyVS6Zjs5wPFFnaU6NaIK7LurEwP6MJGR9b0IQ6qK/Q2
         ErVkTTraghHEGl1qMbIyWv9gUtd6DfoGrTJjp0nwv8cSleIZSOVgHXyLYYGoh27viJpq
         ElWZNGoWaoRH9Q4f56gcNNRyXWvu8VQ+O+m1sXqZ8x9cq9WMMDG/r0XGPQScz1IBu9y8
         vxQOae3pKbYGKt3ynLd/FxUcd6+Vu+sTq+FzWGKHPmNPGA7BXOiRZyF4GEq9UmX+he3E
         os6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784054615; x=1784659415;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rFM73Nl0bWyUMJUomM5RdFpNF5aybZxuz1pkz9xV3sw=;
        b=aUWsN6X/2fyTy77fE1dtS9WYWoIqn+z0ndrLmOdmBJu3O0+Rjz7bzHbSOBh3AieVVL
         cgDqJ57o8nsrzuLE07bTiI7gZJn/M0E5Nngfmd60pl56CO9dqBJ9ASg2W7eUY91GYrvl
         XnblWEXP4ctGDfAYIotw+FEudSGKKPLdR2njp5vAsk9HoDuJLtPI2Em3i3Is/YIFljoT
         RDW8IJOJTP3vS3WHHb9035IuV237zG6/dXx0JxNQVfvEBMUBS19D6cEXYDMNhaIiSS6l
         afjeyB3kiTAHmaMGdHA8ZYiNcLCvimsckHu10h4h2gczbwMYUaR9nYnjk/sP5Ai75E/K
         ZHZw==
X-Forwarded-Encrypted: i=1; AHgh+Rrt8gGSukq+gly/AOkKNxLhJGu3HDEyNWBcr76oMU6/PIh6qdCirgoLOM6N69zeN+uiTBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi7X1YVSRbGJUrUahU4X1m4enKeb0U1DMcF7+jG4otTtZJeqi2
	VG+6VWBSEpo10g1WVIOaOOfpJr23zpUcGHXGSGCSCNU+9wIX8AinNE1Bytmc+c0Zbdjxm9Usy02
	o82QtHA==
X-Received: from pfnw16.prod.google.com ([2002:aa7:8590:0:b0:848:57f0:bf20])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d55:b0:845:4fec:3f8f
 with SMTP id d2e1a72fcca58-84a55894653mr3684533b3a.40.1784054614662; Tue, 14
 Jul 2026 11:43:34 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:41:09 -0700
In-Reply-To: <1782119051448443.14545.seg@mailgw.kylinos.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <1782119051448443.14545.seg@mailgw.kylinos.cn>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <178405354318.3120836.11122335012620649935.b4-ty@google.com>
Subject: Re: [PATCH] KVM: Nullify irqfd->producer when add_producer() fails
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, leixiang <leixiang@kylinos.cn>
Cc: stable@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@ozlabs.org>, 
	Suresh Warrier <warrier@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 22 Jun 2026 15:51:01 +0800, leixiang wrote:
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
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: Nullify irqfd->producer when add_producer() fails
      https://github.com/kvm-x86/linux/commit/ed446e8aa894

--
https://github.com/kvm-x86/linux/tree/next
