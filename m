Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9A74FE2E3
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 23:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107476; cv=pass; b=lIcLPBe0fmX31XKsSwBTqiDvJVC7wG29GXlLZYAzFl4qTrT5X/i49RgL4BZOmP7P65DgFYZLXmjuJT9CWXYhzHDORlYML2XfBoHAFiapilh8ekzlbkawlty3YUwynaATrnkH02cSX/DIfLh0C7xHQiQbYZKlTwWdxLbp96/KPy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107476; c=relaxed/simple;
	bh=xIFoMaaNswqnpXgTLUDVougpBQuDS+FqH832wyMXIgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJzaNudZWHxV6W63/D4n8YAPpCj5OdXkbY36mYPDIh511F6/2KAI/XBS4HzH/cDlOi9CNxw8v3AvMD7YOdMv7MEjwmNWvaX6tGF9ycG0xjzjHrrNrzxXuzd8a0Av+KAeGfqhRbH48nXTMq0NZHNeEgkLLp1TtSfrWjU53IGK98M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LAFsp3l/; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LAFsp3l/"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso2559a12.1
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 16:37:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792107472; cv=none;
        d=google.com; s=arc-20260327;
        b=E4HLtEkyZQJbN8Rui2G+QIpNVZQlXhqjE+wJlW1yAUZpq/bKxUILwrYn6qxuzgL/OJ
         3QTA2Oh/v1awSuqWvV5lTe4yH1V2Dq/aCaad5obszu9RieCaHeLmtk7CYg4xaRIPL5ec
         MogPGAb9S0UmrPED6Icyit/8Mxb0UjrXErhfb/wJDOQoTG+XHJzsVVfxlTyACCeMaS69
         b/vZ0nCkqVaYyifZvjZyXcw36xEPUiFZibDxCiLH33Rq5CtF0c7jL94BaazHOpMhtcVU
         5qAZLNDrMuLJpitgdl+BvxgCPWX3qQKGpQuJOvb1MwoipWt70/gi00dqtSyKJANQXU1P
         Wr6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qup/0fTJuqrpqVHOUf96Jn9uaZoh3joUToRTUOcNqDk=;
        fh=0yV4DB5uZFiib1oaHeQwqeuT5+Vz/1dbIi95SVjh3rM=;
        b=cZvSS+Hb6iJi3LcXehfR5xmQQ9nxHH8ivmgsne6RdcRLUmf8yn48pWBNnVLGGy4gkK
         GIyZftbJWE5hiZIv4NGJI6KkNqq8kewks7QvKId8nc8M9Kir83dFmXMUBgoBxXRY5qsg
         o9+kVohmAc+2E0jVv3kdB9H+Va9THMyHpp+pJ5qXq4wtMXg21aI/N5QQxpwyz6oD+Xml
         rHXwytrdRDRbejIr3PlKLErdyFJPgUUHZHIcfv3AuthqEQ+DtjmGfxPr2vrBIaxyc1Ni
         Y/QOSZkgDEZGvDNJ7lzb4Jncf5vdg9Ge71k9bFiUaJKkKbXq/6P7p+XXUSFlP7rbPTrj
         o9TQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792107472; x=1792712272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qup/0fTJuqrpqVHOUf96Jn9uaZoh3joUToRTUOcNqDk=;
        b=LAFsp3l/d5qiEhbZ6Rrw53SM7RMxjuJ0UVchSLUa0uso9lyW8h4uET2rNsS/llYOoH
         P61DaKs3qx6HOBSMLF16WoaYj41v0iGzJwrw7+HEslkqtZZ5MNuQ3jtmXHPShCr665jV
         IEP2GA/zVk/rl+jA4s+k5JY4XO6nuY9K2AMql2c/rTGzgzx0vPeM5AOFdnVOFn2pHurd
         oCiNa5QHMKBntkv/Mc2rQqgeYeP+ZOlEW2WP4HOAra0WYQab6lR9LMQCQde/o2cDEx9n
         rQAe3dNx6xSmg+b85MdFD/+Ex/XARNryZQRAAL6McP+e/sWnxnJq2wWUdtPQxIld5gpq
         V1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792107472; x=1792712272;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qup/0fTJuqrpqVHOUf96Jn9uaZoh3joUToRTUOcNqDk=;
        b=a6bqkUNwo/Z8qwLuftjXBBezyOxNJSRTo++qXH8mXmT0A5bjf785NxNcG8U2aT3bSX
         xRhhqFNLqyXElv8yHZV6VEM9rUI3x/mhQfv6d0o/G69AoURglXExqYZEPM55NiOSiiZJ
         8u4Enj3LULrBGCQwWRtmEKr2SCmrcqVCUBiPlpmxy10KFcM80oPe0CjPxgTZNTZN0qUk
         BbsDlh/w5Yecsn4EKG+tzkW+v4XQ4Skwsuh8HJ5ebPdYqaZtWikqc3axtGn9psrkop4R
         Sqt+i6r5Pb3vQOagRMb8iphsTxHA+Vy4yDYF3d3fmL5tAFfyEEeFwqgqWOVrWg33PmVq
         6Zig==
X-Forwarded-Encrypted: i=1; AKwUvBw8XkpDWyI7jxqLl4nxCChAE6YNjoWxMoOo5i4UuD+DExWwF2Uxhas730CIw4twNFhbCq0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDDCO/hAhiD6muYDIQ4+zhmckCPDS62IxpDg1VnIQyAEuBaLnN
	4e7yYcU5XBFdFBw6TCtY0Z9GGa4VICtE9Hq5JdHtRXrxqiPEoeoMtmFNezy3PS/pyG2qU0uSnAB
	ZdTpvNBM87MU4Cx7O4r0ew6L7XoiBWfXnQsZQco5a
X-Gm-Gg: AYBFou32szWetv4MRsGZH+H2W3uem2Gb8SdI6YkGkNswrAEwxnvXrHRGW2ec37vTEYn
	4CQNpYgnnP7h71/WLhRWEc6bSxob8VnsNv4P6wQ2Bh6Box5FRInvtmOhbrRJ8EV3gnWJXGsooUD
	esbyF+BslagITsn+f53yCK3DGz57etMYso+VyQ3uSPJM0bqNk4pMxMsUMRQ17JrzGcQvGMTbPC+
	mEEfD+Ltw3xJL2lu6aLhowCTvWiXZ1zeEIscLEvBeODzotc6PH9a8kbVjz7SEZwVUDL6cBUyxay
	AOH/k5AHtMyoDCj+3pmedFnnkVtOwpS9F1EvYn5vxOLehzRtiSGYJWY=
X-Received: by 2002:a05:6402:c2c6:b0:6ac:bdfe:116 with SMTP id
 4fb4d7f45d1cf-6b38cb93ca2mr15455a12.16.1792107471458; Thu, 15 Oct 2026
 16:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-25-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-25-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 15 Oct 2026 16:37:38 -0700
X-Gm-Features: AclHuK86u5zcGsIApnIwF4pcu-XWk7tXnz1x_tVliVjHmElNhctYwMRE1ok5HnU
Message-ID: <CALMp9eRb3ExsQ0g24YQyo85sV1fnHZadh33hBChUY=ZGUaT7jA@mail.gmail.com>
Subject: Re: [PATCH v3 24/27] KVM: nSVM: Flush L2's ASID when emulating INVLPGA
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> KVM currently handles INVLPGA in the same way as INVLPG, flushing L1's
> own ASID. This is currently correct because L1 and L2 share an ASID, but
> it doesn't work once they have separate ASIDs.
>
> If L1 is flushing a different L2 ASID than the one KVM is tracking, do
> nothing, as KVM will flush L2's ASID in hardware (and sync the MMU if
> needed) when L1 switches to the target ASID.
>
> If L1 is flushing the tracked L2 ASID, flush the L2 ASID in hardware
> using INVLPGA if running on the same CPU as L2. If not, fallback to a
> VMCB-based ASID flush. Note that if L2 then runs on a different CPU KVM
> will flush the ASID anyway.
>
> If NPT is disabled, also free L2's roots, as they may have stale
> translations for the flushed address. Do not try to sync the mappings
> for the flushed address as it involves walking L2's shadow page tables
> with L1's MMU context. This is similar to INVVPID handling in with nVMX.

Nit: s/in with/with/

>
> Note: If L1 is flushing its own ASID, it remains handled the same way as
> INVLPG. Additionally, if INVLPGA is executed by L2 (and not intercepted
> by L1), also handle it like INVLPG. Technically, L2 could be flushing an
> untracked ASID, in which case KVM doesn't need to do anything. However,
> kvm_mmu_free_guest_mode_roots() does not handle being invoked in guest
> mode, so using kvm_mmu_invlpg() in guest mode side-steps this, and
> should not happen with a well-behaved L1 anyway.
>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  arch/x86/kvm/svm/svm.c | 48 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 46 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 8f2542357e78d..436d13f106369 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2468,17 +2468,61 @@ static int clgi_interception(struct kvm_vcpu *vcp=
u)
>
>  static int invlpga_interception(struct kvm_vcpu *vcpu)
>  {
> +       struct vcpu_svm *svm =3D to_svm(vcpu);
>         /* FIXME: Handle an address size prefix. */
>         gva_t gva =3D kvm_rax_read(vcpu);
>         u32 asid =3D kvm_ecx_read(vcpu);
> +       int cpu;
>
>         if (nested_svm_check_permissions(vcpu))
>                 return 1;
>
>         trace_kvm_invlpga(to_svm(vcpu)->vmcb->save.rip, asid, gva);
>
> -       /* Let's treat INVLPGA the same as INVLPG (can be optimized!) */
> -       kvm_mmu_invlpg(vcpu, gva);
> +       /*
> +        * INVLPG on a non-canonical address is a NOP according to the SD=
M,
> +        * assume the same behavior from INVLPGA since the APM doesn't sp=
ecify.
> +        */
> +       if (is_noncanonical_invlpg_address(gva, vcpu))
> +               return kvm_skip_emulated_instruction(vcpu);

If L1 is in 32-bit mode with junk in RAX[63:32] (e.g. bits left over
from long mode), the full 64-bit value may not be canonical. Should
the kvm_rax_read(vcpu) above be kvm_register_read(vcpu,
VCPU_REGS_RAX)?
