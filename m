Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432F83546CC
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781701389; cv=none; b=r81iYaSq0RPH68ObOGGqW9Gr85K4yKzeTUjr9685XWEx0sXfyYJDfPmoXtCAkjigE8DtiRehT+lCGmtBqAleNRv5WpEjD+FolDCeoVV45+LuFkk2cGaK/UPaddN1UuVvu7rHnWQRWpzRPv+RufFk2FYDNeYWpbU3e62Mg4ZH4pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781701389; c=relaxed/simple;
	bh=Jgplr6cJMoMN6z/aXhWQHWzsS0EgW53NNDnD4vyPhZY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uGQebemSUtsXQLJz0ZoTBOZX+4qxFVJ3rQ3HH8I6qmYEzrh6VtXyvrIbPeV/3xf2CEx42Co01sqgBh+JyBUHf5sZgOvMVV4LDL5MXP9MwFrqdczjdnzk0BQ3WasUpVILBQm2xjUTswVQfKyTcPeMNuQEY/MoyunsgIweuSXJaWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OrNp4eKX; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OrNp4eKX"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c86487a8ce1so5917217a12.2
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 06:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781701388; x=1782306188; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EM28efTr5yjuE0SO3xRGbNYRHe4cnOYh7jH86+doO9k=;
        b=OrNp4eKXB9EJsmfg68i1osryWgFoBD/Tfv7QWmir3m1QMoMPjeC/Pc+9vniTvRUVEH
         7pHmCOC89T+SW+gk10PFwTn6QZkftpA61lKb74qqBRNpZG1VgAi6VFlqQ6TvyBuyapdJ
         mVNxWUBcd1xZ2Tdz30j5po2UghDpwOiukRDVouy1OcL6X5N3pGl48HrMdXKXb0c78Zdb
         ZUn1p3mILN1JMwc6zDQ/5px7Vk5nZLm8qHz0N5sm+XOMxjjTkCUZZocLE4/4IOaxDUng
         7Ue+Q7Pu+6qvMvHsLhbMN6q3gFSAwLWKSIokIgG8GzeAlyx7Ffvvu7fPB9VPT+15VIbr
         SFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781701388; x=1782306188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EM28efTr5yjuE0SO3xRGbNYRHe4cnOYh7jH86+doO9k=;
        b=LQTkQsUOFABI2UIyfGyDvi2g658bDmImcRYMIIkCE10EcJsm9Qu0SOpZ+Etg7Vm3rW
         AG4PVJsZwVymUPyLwnklLA7oFAWwDn508QqHGv0bM+eGXfNxX8gxRZ/SUVMnvbuU8AqL
         ++yCbw6WRjvGmKV4PjNn3V48nbt4I4OasqehEiaAv6bsjNt2Y/jaqzDL/kbkXJyHdf/X
         VFBgbZrBSkTPQAWTlKsbC6nKx0UIPo8Lnx/4Du8GnMrFKWolTLjvDeVyGH/J1fjCqEhk
         Kt1/6Ni0TsiRTiT1/pfH+WetysS42Ftr01jeDuwPgrSO0wPmwjWH0LhS/HSbOTyA7hb4
         T1Qw==
X-Forwarded-Encrypted: i=1; AFNElJ8IsdUyr6N5Y3UW+ANEmpJOsOH98B8Cr4cq082ivcUDsBRPat1KGYDBGp4qdMlCUVaEHXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnZ1Hwt+fW9m43wCNeT3LiTnvQl6elJ1+pMMAQuUWJR9Yz69pq
	wSP3+ux9xMn7YlJpXjJ3bmFKSN8EqFC91FoifvS+ar4OZRHPDuRvUnIlNkTdE1/UJP6z8Lj7q+c
	gCHDz0A==
X-Received: from pgdg15.prod.google.com ([2002:a05:6a02:51cf:b0:c82:2bb1:fdb0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748f:b0:3b2:b1ed:d1df
 with SMTP id adf61e73a8af0-3b8b72c6650mr4040175637.29.1781701387134; Wed, 17
 Jun 2026 06:03:07 -0700 (PDT)
Date: Wed, 17 Jun 2026 06:03:06 -0700
In-Reply-To: <5b5a0f3f21bba5d25410382a9e0170a17c952738.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616214652.2157032-1-yosry@kernel.org> <20260616214652.2157032-2-yosry@kernel.org>
 <5b5a0f3f21bba5d25410382a9e0170a17c952738.camel@intel.com>
Message-ID: <ajKbCii_1LpyQKjJ@google.com>
Subject: Re: [PATCH 1/3] KVM: nVMX: Always flush vpid02 on first use
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "yosry@kernel.org" <yosry@kernel.org>, "jmattson@google.com" <jmattson@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 17, 2026, Kai Huang wrote:
> On Tue, 2026-06-16 at 21:46 +0000, Yosry Ahmed wrote:
> > Make sure vpid02 is always flushed on first use by setting last_vpid=0
> > when allocating vpid02.  nested_vmx_transition_tlb_flush() will always
> > detect a VPID change on first VM-Enter after VMXON, because VPID=0 in
> > vmcb12 is not allowed if L1 enables VPID.
> 
> vmcs12 :-)
> 
> > 
> > This avoids using stale TLB entries from a previous lifetime of the
> > VPID, that might have been associated with a different vCPU (or a
> > completely different VM).
> > 
> > Note that last_vpid is already being initialized as 0 when the vCPU is
> > created, but it is not reset when vpid02 is freed on VMXOFF. Hence, the
> > problem can only occur if L1 does VMXOFF -> VMXON, runs an L2, and KVM
> > happens to reuse a VPID that has TLB entries on the physical CPU.
> 
> Not sure whether it's better to set it to 0 in free_nested(), which also resets
> some other nested fields to clean slate AFAICT?

It needs to be set on first use, for the same reason that kvm_mmu_load() flushes
the root:

	/*
	 * Flush any TLB entries for the new root, the provenance of the root
	 * is unknown.  Even if KVM ensures there are no stale TLB entries
	 * for a freed root, in theory another hypervisor could have left
	 * stale entries.  Flushing on alloc also allows KVM to skip the TLB
	 * flush when freeing a root (see kvm_tdp_mmu_put_root()).
	 */
	kvm_x86_call(flush_tlb_current)(vcpu);
