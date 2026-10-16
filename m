Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374C13C1097
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 19:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792179566; cv=pass; b=kkZv4vkLrgHogyejexR2l5IpnaAM5EMyOnnWtVoIKC6SpYIjNt5cxBHhktobkoyMFPayuydC5185ERk/oJmLzoyp+WsbXSjPN7AdTUHF1wxoUNaYWu5Zz3DzSDRkXMZpldhZpJcemgsJ008tEho63nYIwOjYbkyI+yo1pbvEc8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792179566; c=relaxed/simple;
	bh=5HperhJ6ndHDYOECzEf0f7rRkNIZtGc1zoTN7qOyyzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SfXx0qYtEFx9EEP97Mzb6DtptELhEg/mEan+4k5iQ9T5voOmvBcTZjuYaq7qD8RB3+Oc7ZkxwAEr/lx02FAhbJAutA1Gz5S4ANZt1SPtxgDhCAEdYrGEu+MLBG0BHwFN5Y4XTzIBJMwEpc3n2XBOd9D0f6ROVeBvimBOIVYgb+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y9kBYsU5; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y9kBYsU5"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-535f598d126so1741cf.1
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 12:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792179561; cv=none;
        d=google.com; s=arc-20260327;
        b=oe8cadJ3JHZVpJ6Cpw5DwcRsU2sZXteBF+cd4rq/Ep9vfhAfpM8bfX359rXhA+bjZL
         qcTP1RpFa5Ou/IYuk7zXZmMve7P2PYDbslBvJ8vRrYI4p2bC/mcAjg7LElgUIZ18SeGC
         SXhgggHHbimjrTTQ1SY32Xksx16JhAEGjzMWuHJ4Q8nbSQsaaooMBfSNBwkd1TPaoVz1
         rxHxXejw0+0bVbAxauhQmpUF34E4RwuWCyoxpI1cJGrRdS/+YoX2sSBsVk0nce5qMFgW
         M2AGsoIuuTHrysrdXzUCadwHDYeC+D60ovlWjrbBUT7KMGUz3qByCYbgtY0jom3nCuqG
         2o0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tYB+24gRvl6A6xyv52LeRn+X+82XyzZtyhvPLO+Wm1o=;
        fh=zG/c2bNSM0WLsqz3gs7rP8kr+CYDQwXlnAL5pkvZfa0=;
        b=SOIv4ikj6rn6h+88r+/nzWIde2j9dkQWjC42ZGXjWrxAGkSJUnzeCFSmBmnsdMl3Z8
         a++XvyBgza7inYloCImYuBcOWoKFIObLgmh6/7Cd2lvW1x8nBilogfpQGl8yggmWSzh8
         YR91X2LBJoIM/IIpTMG6nW587n+y6LbuIw/azW1bn9MisPpNlw/UM0NiD/cpvdKL3Ykh
         rE1kaZnX8G2wwduhRTT+Uqi7uOuMXgLZyQYQ9jd1vy4/G8svrbp0kWgUniwmi7TDv2JR
         4PRU6oP2a5GCcuoqPNM4AY5NBHdOH0Maj1eE2vX9adOj2yWjSGuom2Q6QGwGTu4J8AmI
         4Y3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792179561; x=1792784361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tYB+24gRvl6A6xyv52LeRn+X+82XyzZtyhvPLO+Wm1o=;
        b=Y9kBYsU5Ao5BiZpIW1bl0/pd6l/eLwUWjJCKlt3M2Z+1vK07KwwP/xZJLQ1SgbwQmX
         KqLu0chArQbVb5I6txnRFAU//FUb8qI9TAq1EDfoozKDPcS+7ZivBTNSkFNoBozodrCJ
         5zUZSisDc/O15DAS6dbDNx0Ue6kiHC3tPn6CjFaslCOfpMQpFH8OvwqcslpyKpQj52sA
         sPK197hAUI/W58nbKO3/w9UZEnXLJpFEKXOrGk0Ia6TPEhprDq5UUExS/JupKP8njSXm
         DWww7NXKerGoro+yu/qKsaCbQmjK/IRVEUoh6lmGaQJ7GHiJVW3ctCdQ4641A3M8ZZFM
         mr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792179561; x=1792784361;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tYB+24gRvl6A6xyv52LeRn+X+82XyzZtyhvPLO+Wm1o=;
        b=Xdb2ANe8pLEiCAsnWyJhl1Z3hjJ3lqM05OxuYxTFQMf9/YZVAuiNDyR5ywr80He0Fb
         +leh7a6Eatpe9/+j37ZEE5aPRxDJ+fW89wk2roMwHByEpcuWKmHC06pSUxTRu3xFUTK1
         mY6+aZW8YfS4YlkaTyvzfyR1mzmEPjVeSnqDJfLtkl4WRsl9I4ieHJMfvDs6vmMpC5Va
         rsn8csAeWUscRMRzf4XwPvM3/ZW42U52J4bTN7e7Pjpzb3VOwaWnZjoYxUjdgFP+t9BZ
         AMU4BzEyluRMWzbi5JTu7u+EYUU2okx1dhh3rGD+1DbMFOVA3AeQbbfLdzcepsTljUBz
         Vbnw==
X-Forwarded-Encrypted: i=1; AKwUvBxF47zfWxha1p6sJgcGXm40rbc9utFsnbcRUhbnsZWL8Mu9ReZ6x1Id85BuK53d47jkG0U=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjJh2YZJNvMIpE54TcwypSrCNi2HwZvdUp0GIVU+/fChhEQ4go
	NrynPxa/bUSPaUkpxgvo87QuY8MVjLhLl2yZaNwpc+qW6sqBN/roW7x4pwIb66qrJoDX7tNH3Dw
	9i76nikfhCPD/iZT9dZL5tl93wW53WTkUBA3ypWT7
X-Gm-Gg: AYBFou1bXajiCRP7dZBzWUq70oxQiVkifxxmrSVt8+oKpkyCjhr71ywWgsA+A8iFw6V
	ze5Njk8UobwEojCrT4Qpb1Cc3ev0x3H5ndjlmOqJfzCIODfokcu2xrVcsdqTR2qQrOhJ2ZPlAjf
	zUHS3XMn9IfGvBA9WblCXG+r9vgbdJSImuA9xwYMtJy6nvSLO6Es63mc5n5bsNPeIbnmprHM3Jj
	f6iFY+yl43OvL2KJgLTwwic/KUO8WGEFrpGm6suT6JLB4onFwJMYXdAia7MX82mKkW7NRp1nl/g
	fmE77zO74LRUNFpDnOsQjpPaBOQfeZ5BHqZrBPVDiVQPd7UsOYVg/73rZq5z2DBnlA==
X-Received: by 2002:a05:622a:1cc4:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-53649add080mr31861cf.0.1792179560138; Fri, 16 Oct 2026 12:39:20
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-20-yosry@kernel.org>
 <CALMp9eRd3COQijFU8AdcJKo+usr4A7dC6GOYT3YS93UBZ0yHRA@mail.gmail.com> <CAO9r8zNvcoXxDHxxZEWZM-Effav-Yb8piVuN5BsGanhR5dJmFw@mail.gmail.com>
In-Reply-To: <CAO9r8zNvcoXxDHxxZEWZM-Effav-Yb8piVuN5BsGanhR5dJmFw@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 16 Oct 2026 12:39:05 -0700
X-Gm-Features: AclHuK9GXq5IvU0yurc3OGJJuMNaC-vtMWVfUvmlQbKcygeI63kT7JK3WCbyRgg
Message-ID: <CALMp9eSQD0XJ_0y0ovdiHYXoRi-_FNHtrsraJOWSNafnWCm9sQ@mail.gmail.com>
Subject: Re: [PATCH v3 19/27] KVM: nSVM: Service local TLB flushes before
 nested transitions
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 3:35=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Thu, Oct 15, 2026 at 3:20=E2=80=AFPM Jim Mattson <jmattson@google.com>=
 wrote:
> >
> > On Mon, Oct 12, 2026 at 4:36=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > >
> > > Service pending TLB flushes for a specific context (L1 vs. L2) before
> > > entering/leaving guest mode, as KVM does not track TLB flush requests
> > > for L1 vs. L2. This is not currently required as KVM always flushes t=
he
> > > TLB on nested transitions, but it is a requirement to drop the
> > > unconditional flushes.
> > >
> > > TLB flushes are performed through the VMCB's TLB_CONTROL field, so
> > > service the flushes before every VMCB switch (except the precautionar=
y
> > > switch in svm_free_nested()). Servicing flushes may end up purging th=
e
> > > relevant HV TLB flush FIFO, which is based on guest_mode, so make sur=
e
> > > local TLB flushes are handled before calling {enter/leave}_guest_mode=
().
> > >
> > > This is conceptually similar to how nVMX calls
> > > kvm_service_local_tlb_flush_requests(), except that the VMX calls onl=
y
> > > have ordering requirements on {enter/leave}_guest_mode(), and not
> > > switching the VMCS, because VPID used for TLB flushes depends on
> > > guest_mode, and flushes are not VMCS-based.
> > >
> > > Note that nested_svm_{entry/exit}_tlb_flush() must be called after
> > > kvm_service_local_tlb_flush_requests(), otherwise the TLB flushes wil=
l
> > > be immediately applied on the outgoing VMCB rather than the incoming
> > > one.
> > >
> > > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > > ---
> > >  arch/x86/kvm/svm/nested.c | 22 ++++++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> >
> > [ ... ]
> >
> > > @@ -1549,6 +1567,8 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
> > >                 vcpu->arch.nested_run_pending =3D 0;
> > >                 svm->nested.vmcb12_gpa =3D INVALID_GPA;
> > >
> > > +               nested_svm_service_local_tlb_flushes(vcpu);
> > > +
> >
> > When called from svm_vcpu_free() during teardown,
> > kvm_service_local_tlb_flush_requests() will be called for a vCPU that
> > is being destroyed--and isn't loaded. By that point, the MMU has
> > already been unloaded. Is that safe?
>
> It should be, VMX already does it.
>
> I am assuming you are specifically asking about
> kvm_vcpu_flush_tlb_guest(), as it could end up syncing roots with TDP
> off. kvm_mmu_unload() should set all roots to INVALID_PAGE. Both
> kvm_mmu_sync_roots() and kvm_mmu_sync_prev_roots() will then
> gracefully skip.

I'm just paranoid about process teardown and borrowed MMs.
