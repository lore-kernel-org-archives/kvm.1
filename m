Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66E2331EAB
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781276161; cv=none; b=dXU69/uktkAjpmHtDXaM/bIgBIaDppar4V4HEaHW2YD41GYHlPyGRgkU72uo+iNtQQuOBsfh2c9ERfOeGURJ7Pdb19lvrkMvZKhFfNi7QkKxD88djbajm3rhWXI6Tc2HP3lkNNZo3HqIHsqmWXVCnJzZqd3CiDR4dADk2R2Kei4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781276161; c=relaxed/simple;
	bh=v1lHfOwRkHhOZ74JM+AK6rXRxpvgdAXu8zRNFh1u12w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z4ctz9t7XwY26J0KjXMQqp0v9YTJSToAT3b/8qemgQL5J+RSmAj8LJ/G4bOWeE3nYLUet8lS+Bb2piDAodta/s2TCTrNwz6hd2LEdkS5R/IRHwgLfAwMf7RdE4f+xR/BpFwD6yowscsZiT99+Pvqg3CVQoj8TxzI/ZWclDo/wYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eSPpMIn7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eSPpMIn7"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3772b6b31b4so796444a91.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 07:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781276160; x=1781880960; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WNcpHwpm6/26X/fcZOebiiBTkHhzzv3iZNMUq4LAPaI=;
        b=eSPpMIn7fB1flf2KJCxbLgsTD5YV5Wo4ZyiUFsDSmZj5p0QlPgUgQ5gx7WHwxxuLsf
         waZXqBqtBVI9T0tlAHsL/v8nwWPfL7YyUCfaQJ/hb2UA6TIz8xtO9cgO+uLBLRvjBXQc
         CP+wLEjMfxlFu0YDV27Xk84edKwcko5Fz6aGsVRVNYV4dV0JdVhHZ2BX2+5n3PHbxPkM
         6hud5bFuqJ2KByudZijB10JABFguUzE97c9uZzoil0cP7IZxm1IEiKK0y4VM37T3I21G
         VCySb02QNbbG8RPuPSZeKq1R/pzluFBUWl1zjbMpQZo8ybvEZKEHVclq3okiS39nE/Gh
         YL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781276160; x=1781880960;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNcpHwpm6/26X/fcZOebiiBTkHhzzv3iZNMUq4LAPaI=;
        b=CTjVesxAjP+YaQCtX82nNulWofLUUW9VIIanGgE0vqxyAH22276zY0XwuYrb2PhCjo
         l/nEjk+6M8aO+dnK6Mg1sdBFZdgNg2XbvNH0Jcxigudes/ADm3k6rD4lJlSO1kw23uRv
         LMPWdt8pa4UC1jLd1kEWWOa3JlOgCP8e+YrKIkSqL4w5TuG0Td+S13Ev0glFeyUE5Ded
         QYpBo/xk/Da6dhIN9zvbI+lOwQ4+U6g0zJ+ZBvUzSifWuzTCcwpSCeEC+Spe5Ap6AxSX
         UpnjgLo8QxX6kBsAbe9MSHWZy7mPSIfVgTs1agBrfm+J/OinaYD5o710MPhn7ZNPPFbu
         1Pow==
X-Gm-Message-State: AOJu0Yyp2xOKzJvgS9g0DioE7mYscUdH8fpljaNsar3mUL6Oy8WGJxm8
	TrW0aVGjQK/Gs3ZO0aeM7efbpe20dWg6WvLmcWLQCyqkC8MG4qfFzDMj92L7KBNmG3EJNrKYwZK
	4/Yybfg==
X-Received: from pjbaz15.prod.google.com ([2002:a17:90b:28f:b0:36a:9fc9:2f25])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b87:b0:369:c5f4:9681
 with SMTP id 98e67ed59e1d1-37a041b0151mr3710931a91.22.1781276159772; Fri, 12
 Jun 2026 07:55:59 -0700 (PDT)
Date: Fri, 12 Jun 2026 07:55:59 -0700
In-Reply-To: <ik7nexem.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1781093720.git.ritesh.list@gmail.com> <ed1d75f27a3b02897a8f54721d9f7f21bb163d9c.1781093720.git.ritesh.list@gmail.com>
 <aiml9iB_vUASRRQV@google.com> <ik7nexem.ritesh.list@gmail.com>
Message-ID: <aiwd_8Jj34IH-pFH@google.com>
Subject: Re: [PATCH v3 RESEND 04/10] KVM: PPC: selftests: powerpc enable
 kvm_create_max_vcpus test
From: Sean Christopherson <seanjc@google.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 12, 2026, Ritesh Harjani wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Wed, Jun 10, 2026, Ritesh Harjani (IBM) wrote:
> >> From: Nicholas Piggin <npiggin@gmail.com>
> >> 
> >> powerpc's maximum permitted vCPU ID depends on the VM's SMT mode, and
> >> the maximum reported by KVM_CAP_MAX_VCPU_ID exceeds a simple non-SMT
> >> VM's limit.
> >> 
> >> The powerpc KVM selftest port uses non-SMT VMs, so add a workaround
> >> to the kvm_create_max_vcpus test case to limit vCPU IDs to
> >> KVM_CAP_MAX_VCPUS on powerpc.
> >
> > How is this not a KVM bug?  Literally the reason this test exists is to validate
> > KVM's advertised KVM_CAP_MAX_VCPU_ID and KVM_CAP_MAX_VCPUS.
> 
> It's not a KVM bug, it's expected on PowerPC. On PowerPC, vCPU ID encodes SMT topology, e.g. on P9,
> vcpu id = core * stride + thread,
>   .. where the stride is same as kvm->arch.emul_smt_mode (VM's emulated SMT mode)
> 
> So the vcpu ID space can be sparse, however KVM_CAP_MAX_VCPU_ID is the
> absolute ceil value (MAX_SMT_THREADS * KVM_MAX_VCORES) i.e. the value
> with the maximum stride / SMT value.
> 
> Since default selftest VM uses stride 1, so it rejects IDS >= max_vcpus.
> 
> e.g.
> static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
> ...
> 		if (id >= (KVM_MAX_VCPUS * kvm->arch.emul_smt_mode)) {
> 			pr_devel("KVM: VCPU ID too high\n");
> 			core = KVM_MAX_VCORES;              /* rejected case */
> 		} else {
> 
> So, it's expected on PowerPC. vcpus with higher IDs can be created but
> for that we need to set KVM_CAP_PPC_SMT and use strided (sparse) IDs.
> But since the test as of now is not doing that - that's the reason why
> the patch only allows to test max vcpu IDs upto max vcpus.
> 
> But I guess you must be hating the #ifdef __powerpc__ there. I agree I
> don't like it either.. maybe we can do it this way?

I don't love the #ifdef, but it's more that I didn't want to effectively skip a
test because KVM was reporting bad information.  But after peeking at KVM_CAP_PPC_SMT,
I 100% agree we don't want to deal with that here.

> -#ifdef __powerpc64__
>         /*
> -        * powerpc has a particular format for the vcpu ID that depends on
> -        * the guest SMT mode, and the max ID cap is too large for non-SMT
> -        * modes, where the maximum ID is the same as the maximum vCPUs.
> +        * Some architectures (e.g. powerpc) encode topology into the vCPU ID,
> +        * so a default VM can't necessarily use the full advertised ID range.
> +        * Let the arch limit the highest ID this test will create.
>          */
> -       kvm_max_vcpu_id = kvm_max_vcpus;
> -#endif
> +       kvm_max_vcpu_id = kvm_arch_vcpu_id_limit(kvm_max_vcpus, kvm_max_vcpu_id);
> 
> 
> And then in kvm_util.c -
> +
> +__weak int kvm_arch_vcpu_id_limit(int nr_vcpus, int vcpu_id_max)
> +{
> +       return vcpu_id_max;
> +}

What if we do this?  We're going to be bleeding PPC details into the test no
matter what, adding an arch hooks just seems like extra cruft and an unnecessary
layer of indirection.

	/*
	 * Skip the vCPU ID test when running on PowerPC with SMT support, in
	 * which case system topology is encoded into the vCPU ID, and so a VM
	 * can't use the full advertised vCPU ID range without crafting a valid
	 * platform specific topology.
	 */
	if (kvm_max_vcpu_id > kvm_max_vcpus && !kvm_check_cap(KVM_CAP_PPC_SMT))
		test_vcpu_creation(
			kvm_max_vcpu_id - kvm_max_vcpus, kvm_max_vcpus);
