Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A0D448B9D
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185467; cv=pass; b=Zo4Rb6+y9yJieJQILdIWzu+044fjUbduGFEY7HBJhVuxL9BzpyXgh7r+7ReDitgEvKlcRY/1fRm1yJknLVNUe05Vd01+Ui6oxrDjJw+Io4A6rUpvONYrlpaxcaaSdJS3kEVkY+XILq51+wqMdVPsxla0RmOxmRdeDnSjwtOk/f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185467; c=relaxed/simple;
	bh=Xo4SuVAkwhUfmLEjXQw1rkMVGu6ZcsrZb6xQHUYm1Js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZrCr7va8nvWvwPlrN6OkGEjYebmGrgErrFUY/U8UM/Zzc4IjKNZ4tj9QgNET2KzdwlNCvRR6nMnu1na1L+VpF4NseCbEbYa1zKfwM434x7AjYgkjvrIFJwDURkx3FuYdsHqZEOeU3/Hdlp/BYefWbL/tn4Uwe3IrhQkgbREY6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ISVfacDC; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ISVfacDC"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so1402a12.1
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 14:17:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792185463; cv=none;
        d=google.com; s=arc-20260327;
        b=EsphIftju/SFQJdOCpAQT7BRWCie4OgpCZ398ys7Quo3z1RJU30nhKREvWhz7aOhL3
         C3YPtRCSwrC+A6dxzWidRSuTASChuw3kNDYRnUBsMzYWadU0YMUV0LQDPOy2gVAwDHVP
         w7OhnQBnwNBpfPlIozmvE+jqxupC+E3ZTuLDnT2+5QlRSbHZObXooUdQkqxcGOBOSFiG
         WbXcTV/MWJV6SMCYFVSGOeRCKq2DKHxy6r99DH0dTVVg7Ut9ipO84J4oucZea6fMz1sj
         mQD2qrSi5SFHnTYyYq5pPVNPCJBaEj8zpbgkYqbGEhuiYJl1e8jJZZQu3T1wYrhFljn6
         noSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yqwdcpJ3cGMcIcxOWOSXEb4Qi+fpKcEZP2GPtydVxR8=;
        fh=rbH7eR8/xyXPM2WL/AmIzYcp0k36Rj7NA1xSfe4/9EM=;
        b=g6hJADHO8ExJkw0rp2J3MIUHhCFirvmxBBa4ztLPxJMNLTeGcg6wbs7VFCwRJn+uM0
         +sVy5wKoe1lk4nBhrZ45MgqGscQjuossFKvhjHkzDhrOxaPFA4NzWJuUcaps898ITbbj
         KVX4e25WoZJwso/ZQHH/Z2CBfj+eo5no+WBwo3fpvEnyT92y6tDG6zD17YJTfD8XYGrV
         UPZu7cjUl+P3VxXHWLnk17F/H4mxBfTKuCi4bZFrNtyaz0B0zhcSm8bhvNfC++Hy1upE
         +T19rCXwxfiHf09/KSVZUbC9hSHq99dHGoU8ZvyUV6lWKJqf/WE23KxB+JSCfJMy8Hzn
         gwmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792185463; x=1792790263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yqwdcpJ3cGMcIcxOWOSXEb4Qi+fpKcEZP2GPtydVxR8=;
        b=ISVfacDCRAqHPqVylxrybLLPcmeYtQnjjqciEg6dxeFKh6+vqPKIomkt3yXGg0+hu7
         uDbAKhiklrKycpqwGFHeZJ16Lqk316HGU5PBz5HdASamYJDDXoGN1J+QMjXQJqbf4/yn
         sII1Z/brxx/U2dOoFGUBNJ+ryghugz7UX40LSka32RkzaPpGPRE9QhV7TbheG/9Q/B2/
         aTQguSA9099iFijptro2iBIWNvhhrPVvdpG4lFaex/at5S1oLvAM7gqFRSHXThjQFVtx
         eeQa4mTNBgrQ56cPAHoIOgwYbwFMUbLjaPks9wQRy0gzyZfFhEWuS3nYU8gao6NvZEM2
         c/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792185463; x=1792790263;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yqwdcpJ3cGMcIcxOWOSXEb4Qi+fpKcEZP2GPtydVxR8=;
        b=cIu0dTNSEky+Au2jlivaQQlGJ8DBY/SBYJ/DOMburAS0Ch/yVB3pY/4TeJz17aGutQ
         ZdwsX/LdJeRxvQZTVc5cvOzfqfnnweXif8x/7E9KX8vuWf60BnbIO8vV+F2o7lQiNkU3
         W1qMyu6BUUiiKkEee6of91EKFuJg5ZEhEg69J97Eu17TB0CZD28LGFNsW1s7ojWxQ/DB
         2uaWQTn42BitLJ7U99Eug3zZ4oXo/bol5HAklEOPQ2cI0NCh8oaGJQrGZ+9UoEtX00Cq
         DYJYqVQ36LZxMVgliiWTbjY+oICoJZz3YpRUR/4UaUwoBcTwSI/PRP19wehtOjyJ70+K
         0TIQ==
X-Forwarded-Encrypted: i=1; AKwUvByUV7iKE+7ycrNQaT9+PUqFZwsCBcG6UH0YdsbuP0h9fRwgM/AamKEECbQgPYoJvwdtj30=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBWGZSAwKtfjSmT7SZj4Wl+4qIBJzeTiH6EkcUW+wlFHeSohmC
	/LAhc2LhXJr6T4pvSqvZ3/SXLwY7Nb2t6gpj0SLPxW/hzPMG1A0tQg6xmuYLQbDohNy2hkSmZvG
	TcId3UO7/se+oZHve1VZOQAEFEZ+fa/yrT3xF708R
X-Gm-Gg: AYBFou25iCpzU47ouZXKkRtc4/6pxtK3E7FuJ7i9jowgpjivtPyDhJiqnNIMszTbbnc
	rIyMGBdHMm2aCIEjg5JRi+7ouT+ZYLgTmHLWZm6cSDp2ox5Ka0sQmm8S8WcPz4JjDybTB4qwQhs
	cyvNqR5lyh4Es5VoqoMbyiEy3u7kJJbheaqk7/BIWFp1/l/AdG6U5d+Sng4irUhbVZ758ERbGaU
	YV0RoNycFgGNM9XYsGM4ANnoe/CJN2g/wwciEbCkSXRfzvgzvZ7CqmJ3sQyCke2ft2iNWbvSlJ/
	ODrvq7JxHqRRO/ZzbS9VNilsAQyLQfql7qCoNf16+XeYIoW9EFy9WRqZjSr21KTeY5xKRgiXmG5
	8wux02yhcIb9wv/Em0CZs0kbPwKzB5w74tnnq
X-Received: by 2002:a05:6402:a58b:20b0:6b1:c3f3:225 with SMTP id
 4fb4d7f45d1cf-6b3a8697d78mr22141a12.0.1792185462133; Fri, 16 Oct 2026
 14:17:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-27-yosry@kernel.org>
In-Reply-To: <20261012233638.2546339-27-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 16 Oct 2026 14:17:30 -0700
X-Gm-Features: AclHuK9F3IRSQWq-rRd2sfxk5IrJhnxcD3qf_KqHgb_kMW3Lv1Eba5dVyLI-W-o
Message-ID: <CALMp9eS8KDozNGT9J_uN69W32QEvTbg2JrtRqN0ESi00b_uq=A@mail.gmail.com>
Subject: Re: [PATCH v3 26/27] KVM: nSVM: Use different ASIDs for L1 and L2
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:37=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> Now that TLB flushes are properly handled and tracked for L1 vs L2
> ASIDs, allocate a separate new ASID for L2 for each vCPU, similar to how
> VMX handles VPIDs. Drop the unconditional flushes and syncs on nested
> transitions.
>
> L1 and L2 can now only share an ASID in two cases:
> - KVM runs out of ASIDs and uses the fallback ASID for both L1 and L2.
> - SEV VMs always use the same ASID for SEV-specific requirements.
>
> WARN if the ASID is shared otherwise.
>
> Initialize last_asid to 0, such that the L2 ASID is always flushed on
> first nested VM-Enter after it's allocated.
>
> On SEV VM migration, free the L2 ASID on the destination vCPU (if nested
> was already initialized) before overwriting it with the SEV ASID.
>
> On a Turin CPU, this results in 8-15% performance boost in CPUID rate
> microbenchmark [1] and netperf TCP_RR latency/throughput.
>
> [1] https://lore.kernel.org/kvm/20231109180646.2963718-1-khorenko@virtuoz=
zo.com/
>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  arch/x86/kvm/svm/nested.c | 32 +++++++++++++++++++++++---------
>  arch/x86/kvm/svm/sev.c    |  6 ++++--
>  2 files changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 4ffc10bf9232e..6fe68f2ae282d 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -711,6 +711,10 @@ static void nested_svm_entry_tlb_flush(struct kvm_vc=
pu *vcpu)
>          * context is not tagged by the ASID, so the shadow NPTs cannot b=
e
>          * reused across different L2 ASIDs.
>          *
> +        * Note, last_asid is initialized as 0, so the first nested VM-En=
ter
> +        * after setting EFER.SVME will always flush the TLB to avoid usi=
ng
> +        * stale entries.
> +        *
>          * If L1 requested a full TLB flush for all ASIDs (including its =
own),
>          * L1's own ASID is also flushed on nested VM-Exit, before runnin=
g L1.
>          *
> @@ -727,12 +731,10 @@ static void nested_svm_entry_tlb_flush(struct kvm_v=
cpu *vcpu)
>          * If L1 and L2 share the same ASID in hardware (when using the f=
allback
>          * ASID for both, or for SEV guests), flush it on nested transiti=
ons.
>          */
> -       if (svm->asid =3D=3D svm->nested.asid02)
> +       if (svm->asid =3D=3D svm->nested.asid02) {
> +               WARN_ON_ONCE(svm->asid !=3D fallback_asid && !is_sev_gues=
t(vcpu));
>                 kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
> -
> -       /* TODO: optimize unconditional TLB flush/MMU sync */
> -       kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
> -       kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
> +       }

Per the APM, volume 2, Section 15.16.1, "TLB Flush":

> All TLB entries belonging to all ASIDs are flushed by SMI, RSM, MTRR modi=
fications, IORR modifications, and access to other system MSRs that affect =
address translation.

With two separate ASIDs and the unconditional flush removed, do we
flush both ASIDs in the above instances?

Moreover, does this change the semantics of PV TLB flush? In
record_steal_time(), we have:

if (st_preempted & KVM_VCPU_FLUSH_TLB)
        kvm_vcpu_flush_tlb_guest(vcpu);

IIUC, an idle vCPU that wakes into L2 will flush only L2's ASID. In
the past, with a shared ASID, L1's ASID was always flushed on emulated
VM-exit anyway. Now, L1's ASID will be unaffected. Though I can't find
any real documentation on PV TLB flush, it *seems* like the remote
vCPU would want L1's ASID to be flushed. OTOH, this change makes nSVM
behave just like nVMX.


Nit: with this change, the following stale comment in
svm_flush_tlb_asid() needs to be updated:

/*
* Flush only the current ASID even if the TLB flush was invoked via
* kvm_flush_remote_tlbs(). Although flushing remote TLBs requires all
* ASIDs to be flushed, KVM uses a single ASID for L1 and L2, and
* unconditionally does a TLB flush on both nested VM-Enter and nested
* VM-Exit (via kvm_mmu_reset_context()).
*/
