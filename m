Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01033914ED
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489368; cv=none; b=PdO832Gii2v1MFvrLOWegIpjLTyFYYwLpD3TqBnZ/0SjD4au/G9I8lm31EIl4mFr2eXar+d/U9H9/1raSeKLNPn2rBTppE1jTThbs1fzAm19dSzmQUcXs3clJ8ykr2JhoC9zEJdWqyj4v0xtT7m3R41IO8SmuThIfKBybU5Uy4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489368; c=relaxed/simple;
	bh=4gB5QrpdL2UTfMGZ8RXrpR9t0zndWPiybfUxIK/+mZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Js88wEUK8sgJEqMvfUtZj88Y2pqfg/u8R12jvJ22PfvjymVqiACVx3v+s0/Lv2O4Nr8tI8AGufbFy3N57PbHqJEgmE3dCnFjk54nKUiPlWcMc50zRwpB0tfHrtZFAD2H4bMfQSsx05h29fMVXrAwBt0olTnhpO293Ej1TKtgkzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GclYIgsL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GclYIgsL"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ba115ab6bbso81983655ad.3
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 15:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779489366; x=1780094166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ue/hm1rBfEbUp2/n8dc+CxfKXz8qZfVomiraMGmJm/s=;
        b=GclYIgsL/BTyaMgmK0+MIKt1NFNydfDazfCOTEGPqC+s1OPjoVXaMuU7S+noMFGGB7
         5z8q65K8D0xA7SGXaxcTfAbWRyBPgepg0Z2p4axo/Vx9bFosUEx8w1fJoXmUOOScZllz
         lXreujX6nryaKmJZ4HiA6Lm79tiBeqy78zb8oJ3etS+6x+hp+WgvFb3xWxqLkV1K/95E
         bGKlhgHqqhKCNTL6sThtktIsiIcpeLth7QoxCoWgkSD/baObhkdTS13F58+HetvkFg3e
         6+y48BiPp6UD0eF+i6LIuZz0WPhUlW+F7MZzkeODcF5Q/JTUgILoNhp3MdwrDYFIyD05
         1/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779489366; x=1780094166;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ue/hm1rBfEbUp2/n8dc+CxfKXz8qZfVomiraMGmJm/s=;
        b=jQ05MMJxcqROXUDDPFWPyqgloBZuMaJWhvYPocnP47IhvfEYUY+lRB3QhX7EHDaXsO
         6PZ9LEY8a67xOFV3q5oaHhfKGWqGbNJdRqoBWl2+26YW/4GTufTx90m7xibIgEpAEdHD
         BndSeUa3DK/HvHDqkZBJ+EaGWz70GLpMvWu+5N9kdoTS2ivSDbsA4QXZdxJ1DeIMFpDw
         KIqykRZ2Fw1rDxRoXp3HUKRmu985IrNsGJtkGY2yIZZPOlFPIRZQWqy1eTRnrwwkBjoK
         shpmlJtmf6SsxVuH3C4OnfT+QJoTlh8aO8IB5yG052aOvYSfsvzom6XpJzzy1qFrH5YQ
         sQ6A==
X-Gm-Message-State: AOJu0YxsR3LxXbu7jmKMviHzI8zYEpcp+J+eFMFCqMtNMO/9U/Xy9M3V
	lNaoBzg1b2LbI5HDDMN6qr6+GmUB62rfSh5iPrFhMRab5cc5CB8LxeWVbjqIrRztKV4gFeZvL3o
	0ahtwhA==
X-Received: from plhd8.prod.google.com ([2002:a17:903:2308:b0:2b0:4f86:510])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a70:b0:2ba:73c4:4a77
 with SMTP id d9443c01a7336-2beb06bdce0mr60245515ad.9.1779489365703; Fri, 22
 May 2026 15:36:05 -0700 (PDT)
Date: Fri, 22 May 2026 15:36:04 -0700
In-Reply-To: <20260326145035.119519-9-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326145035.119519-1-pbonzini@redhat.com> <20260326145035.119519-9-pbonzini@redhat.com>
Message-ID: <ahDaVBXIt-xpArKg@google.com>
Subject: Re: [PATCH kvm-unit-tests 8/9] x86/vmx: run EPT tests with MBEC
 enabled when available
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Jon Kohler <jon@nutanix.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Amit Shah <amit.shah@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 26, 2026, Paolo Bonzini wrote:
> Check that the XS bit does not allow execution of user-mode pages
> when MBEC is available (and enabled); this requires tweaking
> the guest page tables to set U=0 for OP_EXEC.  Update the unit test
> configuration to include a specific test case for MBEC.
> 
> Co-authored-by: Jon Kohler <jon@nutanix.com>
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  x86/unittests.cfg | 12 +++++-
>  x86/vmx.h         |  5 ++-
>  x86/vmx_tests.c   | 98 ++++++++++++++++++++++++++++++++++++++---------
>  3 files changed, 94 insertions(+), 21 deletions(-)
> 
> diff --git a/x86/unittests.cfg b/x86/unittests.cfg
> index b82bbc4e..022ea52c 100644
> --- a/x86/unittests.cfg
> +++ b/x86/unittests.cfg
> @@ -336,7 +336,17 @@ groups = vmx
>  [ept]
>  file = vmx.flat
>  test_args = "ept_access*"
> -qemu_params = -cpu max,host-phys-bits,+vmx -m 2560
> +qemu_params = -cpu max,host-phys-bits,+vmx,-vmx-mbec -m 2560

This effectively breaks the test on version of QEMU without vmx-mbec:

SKIP ept (qemu: Property 'max-x86_64-cpu.vmx-mbec' not found)

> +arch = x86_64
> +groups = vmx
> +
> +# EPT is a generic test; however, mode-based execute control aka MBEC
> +# is only available on Skylake and above, be specific about the CPU
> +# model and test it directly.
> +[ept-mbec]
> +file = vmx.flat
> +test_args = "ept_access*"
> +qemu_params = -cpu Skylake-Server,host-phys-bits,+vmx,+vmx-mbec -m 2560
>  arch = x86_64
>  groups = vmx
