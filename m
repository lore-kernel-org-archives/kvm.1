Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1238D32C937
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 00:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790643540; cv=none; b=cB7YIf6ldfAbeoEDyLhveOoRnUbgO5L6vCCKbQCXqBbcxcZXgya6dE/vxhg0a6bnkqdJ2DeEPl2ZK2dTGjnRy5Nu5HWhFuWalmmcMvbyRxNfZSMiOj7WTNNdKPKvD2+kW9MWs6WoczUdiTs0rTxBPtsQHVhf/hMG/d1/6+oBPVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790643540; c=relaxed/simple;
	bh=QmNge30+mb61r8mkp//EH7IPSYGFg+oxdlOC6/zFrAs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ArM408emDJvbqwtSMZ6AQe4OCfc+Jnh86rDCuguI7ZxFce5bFPi1TqWbX1xFwEZRefUvaZY6fgoB9ZS8egpsrlKnQRQiwq+SdWHS1dQze+6Jc7k1mYEn2w3cr6txruwORdlsqEFygw4V+uUET5ByRIjr091mL6xuIICBP2IChho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bBhWcl29; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bBhWcl29"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dbf293831so5522195a91.3
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 17:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790643538; x=1791248338; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2qcic7usam/SHffcGqMIC38VmM+lEsSPmwJ4C5RzOkA=;
        b=bBhWcl29+kW6i9fXLUhv30ehYNmX9QSiEvCWtkK1cbcaEqoW5zQEInkicFBQXX9eZY
         iEAWGgLU8jQEItPs2ZRIr03Oc3+59P9kiQb2ZqMe1Lmz3QwliwjYDpNNzWiqG5MzRJ2i
         S1lWELV2WLpWcjcCLzWeoj9SCcRCWhBKOG+DD9TLVvEPd4OhTENWDZGDBiHWU6UXIJ6t
         eli+OiM0Y6uR38WJYVduhlsQ3/cpWZ1Gl/RQ1YtwdvGPOJKiiltCNpxnhw6VmcTbdnQZ
         6//k+DhfuOjMS/3bBYo6jdl62aHIOUEoVdHonpZCucQWymGApcD00E23sjXkTBnD010V
         7ZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790643538; x=1791248338;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2qcic7usam/SHffcGqMIC38VmM+lEsSPmwJ4C5RzOkA=;
        b=te03ZKWMW0Mh9yAfmomt4PbyJ/8KI2ALvndMTVLnJCjy7ZdskyIN7M564zM38I9vai
         UO+I0gfTdPMM3ERaycfEpRtkWAIJwouIHcwm7bXCBVBVDgtumpv9BWxomB3l1D1uOkyC
         q+dX8U2WhZCQXhBi8mnBDFSnIX3A6dkuqqQTTkx2fhUiEnqZC3sR5Dx7Z/qxTeKKY7p6
         zWXW6TsjAffjbATLGGx1zbHsTer1zYCMJb92DYYz4b2NeItiXEEJaLtO90hCPGtrb/Fa
         C6d2TnXV2hBZxt7+r0Im4XH1x2Q6vMgbcz8IxVsGwMXAwf86b++LhxZAwbO2SADvn1L6
         vhBg==
X-Forwarded-Encrypted: i=1; AKwUvBzjr5ZQaZBBQEO5Su+FdzGdOvMhDFdilGk20aptZrDX4XMulQ25JZSuldNmzDmeGhd762I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMs7BKRJHHaElPjY8bKj8LqEdSxPCki98uw05QAq6A6MdcXTjL
	0GNR4ISSbT6wUDX//S5cNR49ahlQ2qfdh6fYvndbYIOq54cxB7FJwa5C3GvLHmAaUNQH6vADCAQ
	wG7V5uw==
X-Received: from pjth13.prod.google.com ([2002:a17:90a:c38d:b0:3a4:7cb3:b0be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48c9:b0:3a4:7730:33dd
 with SMTP id 98e67ed59e1d1-3a477304d8emr2885569a91.58.1790643537918; Mon, 28
 Sep 2026 17:58:57 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:58:57 -0700
In-Reply-To: <20260920022649.3145701-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260920022649.3145701-1-peng.fan@oss.nxp.com>
Message-ID: <arsNUfVv0NhKZ6zT@google.com>
Subject: Re: [PATCH] KVM: x86: use assign_bit() where applicable
From: Sean Christopherson <seanjc@google.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sun, Sep 20, 2026, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert open-coded if/else with set_bit/clear_bit and their
> non-atomic __set_bit/__clear_bit variants to the assign_bit/__assign_bit
> API.

...

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/x86/kvm/hyperv.c  | 12 ++++--------
>  arch/x86/kvm/svm/pmu.c |  6 ++----
>  arch/x86/kvm/x86.c     | 11 +++--------
>  3 files changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 8d2669d8ef34..c131d9a3c550 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -114,17 +114,13 @@ static void synic_update_vector(struct kvm_vcpu_hv_synic *synic,
>  	if (vector < HV_SYNIC_FIRST_VALID_VECTOR)
>  		return;
>  
> -	if (synic_has_vector_connected(synic, vector))
> -		__set_bit(vector, synic->vec_bitmap);
> -	else
> -		__clear_bit(vector, synic->vec_bitmap);
> +	__assign_bit(vector, synic->vec_bitmap,
> +		     synic_has_vector_connected(synic, vector));
>  
>  	auto_eoi_old = !bitmap_empty(synic->auto_eoi_bitmap, 256);
>  
> -	if (synic_has_vector_auto_eoi(synic, vector))
> -		__set_bit(vector, synic->auto_eoi_bitmap);
> -	else
> -		__clear_bit(vector, synic->auto_eoi_bitmap);
> +	__assign_bit(vector, synic->auto_eoi_bitmap,
> +		     synic_has_vector_auto_eoi(synic, vector));

Am I the only one that finds the assign_bit() code signficantly harder to follow?
Maybe it's just that I haven't seen assign_bit() much, but I've come back to this
patch several times, and I've had the same reaction every time.  IMO, this is a
solution looking for a problem.
