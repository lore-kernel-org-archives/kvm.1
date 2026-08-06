Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647BC2EA749
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041085; cv=pass; b=escGZeYEbT5FRecQHU/8czGo0jLI3Y4T0DdO+R0vqD6dNh7HuTf35cMW5KmhQWqTm+eGK8dqg8VF8Vs+F9tRFtLuSisZ/6XPQsGIgwZg3cwbnTeZ4YapfSIUoQSqaJ3ZS5DDotdr7dwzGSvKAefkkBSYju5tstVN33LQyJQ6ZZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041085; c=relaxed/simple;
	bh=MUMKaH5B/0wTxN60O7Ebg1BFw53Ty/p49FheQnRDlHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klRA70uKZq1rx7OodGyrMJvh4o9G/TspWy43ljVWxgo8R8N5GAl8I1pVD02y8QW42JE1VRnPQ0Qhe1YKWvV0T/qf/jc7JXeI3GmsfrOeko/K5t+V6n2HgeWQgRg0NF3z7G2BIyLonedp7KhNjby+lMIw062IY6jJQUzpjYLGk4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F87ONqBX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NaGVDbp4; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F87ONqBX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NaGVDbp4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786041082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NJf5Xyp9OLGlTUUoVnnMaMmtMsOWHjQExeMp2qs4eNs=;
	b=F87ONqBX/mKLgA0xZHym7ii/f3k6HX1tOqEErBv2oUarJZoHibA7KCWlSFP7PqC7mbPXDW
	I1Hu8OW0NWluOdiGXTBMa0TLGUEiU21CV60bwgoYgm4o1+87km3H1Ce5KAvdE/i2z4Uy1f
	33zzoBVYV4FgqNkEWwY4cSJNJSX1LdI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-WTVNIFskM96N0T4LGcdfrw-1; Thu, 06 Aug 2026 14:31:18 -0400
X-MC-Unique: WTVNIFskM96N0T4LGcdfrw-1
X-Mimecast-MFC-AGG-ID: WTVNIFskM96N0T4LGcdfrw_1786041077
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49955a9dbcdso6466455e9.1
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 11:31:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786041077; cv=none;
        d=google.com; s=arc-20260327;
        b=RNPkshrVL/KvGun3plyIaYc095J7waP/KFHcFXkCOyyR07bv8rsdxADTBizEaV0Tp1
         Cf8eNvtZwoZjzOmhjfviCVx5+cvQAnQzgHkpOBt3q4Qet8q28NIyPViOE64Fj9hLQl/4
         /hxfJSdY6Gp/KmNtPmHcT6N2vfqLScphh/BTaW9Qr/0ISdMKFJ+Y3ZDaRf6MHuXrP7q2
         VRFnInp5qIgMTNI2ujM7+8zj4QwN1Jvu8hMqwauO6QlsMx+78SZeShY+i5s+7PZH2TT3
         62dyW4B7jDKbs1Fp4yMBp12j26jwQS2CTILTUVbX9tfrGxl9skRV6PvaS0myqpkLGCYc
         O6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NJf5Xyp9OLGlTUUoVnnMaMmtMsOWHjQExeMp2qs4eNs=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=UuRo51xbb97zYRchjVKscIlIvYP7MdsV/2OY+VyltkR1Y0/C2TvqwIrwQBr8G2u1/L
         IGj+gYQpwAWEub176VQ23rwl750dlQCe4eIilP6YTLIX5MGpiBZT85/VIo8+pRFhVgNn
         EeEiRQrRkc+CQ4i858ekp8o97acQs4QUSIcMECqcTStsM7BlFziyx/sJG6S3a1K2cJ37
         ei+9b8T7XSDuDRPnUQ95GfU8Q4BEObrj/fMunckqJGzkgWfYaTTOhxOlmy7qft1GJVyp
         C0tTteazG1GkMjXm6lLIw+kCeysuCmVNgzLeFQ3TGdDqkHp/MSeurdvqkFXtDapR+kAq
         Wxjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786041077; x=1786645877; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NJf5Xyp9OLGlTUUoVnnMaMmtMsOWHjQExeMp2qs4eNs=;
        b=NaGVDbp46/5qeSrcgKlrkUwRmVWkgiDIrUfcvUk1VdJT9KlR+k3cil50n/RYoMCPuz
         4eRx0ZSdo/R5dPoEBzjaNztv58/DSLzU0KFShbGt35paSSertkWdfBSdj1UOWTrCjf8g
         JpkSLGAYBX3zm5NlgNTFW01JDiVcg6WPJPFHA2mNClXTufcOcNGAcBeSDubkAObpzINB
         uI676tiuFzbtcBY/IjVrUl6flHgJSjhQ30IhjGoV/qjDkSli22K9ikP7uBVvcGu/MDNb
         7qefh+6NSCAjYA0oMsBMJSto6JBCxVSNa5g2/7LG0ML5PksILY/BD5OSFFfVGwpcEcv7
         cZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786041077; x=1786645877;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NJf5Xyp9OLGlTUUoVnnMaMmtMsOWHjQExeMp2qs4eNs=;
        b=i34Y8Hyveh8KENtHJSoLJquOlAvQDQ03SdlWn6rq5XYDlOyJLQXqc49IxpdvTervbG
         X6XgWTBe/+GXTNALEkhHv2PXGQgY2IYfR/o8ytSmGMjjvnN/fy3XJQyk/1/aNGUpM4Cy
         uq0jHozzXLlky8EYC++Mzp5ZIGc3U0QoDkhPMvqW3us95yYR8D8tjj8Co+W+flbFgQHz
         qRHkO0TmIl3xHOfhoyFDTVpYAIKKeo6p4ez+8gIBYzPrS0s79hAX/DqHOtYPwiGXzYVd
         B5PPlpSilaQrql0NOJVo7a/gRud2Wlf+Q8dXXHBOyoi3UBP7pYbJdVBxEs+s7xS3Cwby
         6EOA==
X-Gm-Message-State: AOJu0Yxv/JPBf5IiktFlgxrl0rq1mNNtrxnATcjn1txioDsPU7NAXoLC
	f4nbZkp+le4EWHcj2vsSNcLbMUrMN55BMn88MVXk1lU1TtT4jLc9x9mzqwwsPR+Wfr7z3VLS8kw
	LCybdvNPW5T2GAFatW5VwLGfdfZHsIA72Y0vnSb40bbw30YyxN/UtjbYcaF4gLcCVoHVT2fYg3U
	g0FjsYPs2v3o3t/oL7t03V+NWyT6/D
X-Gm-Gg: AR+sD10mnbiULlXnprUzk8tYJwBMZb+p9xpDeHr9ScV2zr48WkQEH5hoBrt/L/L4L82
	eI6tJiPyo6uK0jyVZ2ZsgNb8nN2/3TCQFRZ0p9dCuK0bNvJtrdK+o2C09kwMrzGWLAvdlWphLrH
	9Xnl6703UadOg/eeslVbWDUZ/GFyyybZX1Z8/U9Vt6kQASm/kugi6PoWVFUo5h0fexHPLYwO00S
	Of/N6YnqJfddjlu2XzgTg1/Z/uAApQpKxw403vevwdXCNkzmot3b+Sc4OE=
X-Received: by 2002:a05:600c:1d23:b0:499:516b:83d5 with SMTP id 5b1f17b1804b1-499516b83d9mr140325085e9.11.1786041077473;
        Thu, 06 Aug 2026 11:31:17 -0700 (PDT)
X-Received: by 2002:a05:600c:1d23:b0:499:516b:83d5 with SMTP id
 5b1f17b1804b1-499516b83d9mr140324845e9.11.1786041077100; Thu, 06 Aug 2026
 11:31:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806171400.4119301-1-seanjc@google.com>
In-Reply-To: <20260806171400.4119301-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 6 Aug 2026 20:31:05 +0200
X-Gm-Features: AUfX_mzyY1GmBVRg2TszjqzDwxYECN9k7cXylkzOqH2McVL5AxKv45jnem21eXo
Message-ID: <CABgObfaKokt=R08jBSaTh4xm5Z9tEtiYG1x6x4vii70SfFKLOw@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: Track kvm_vcpu_arch.pending_ioapic_eoi as a
 u8 to drop dead BUG_ON()
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 7:14=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Track the vector associated with KVM_EXIT_IOAPIC_EOI as a u8, as the vect=
or
> is zero-initialized and is only ever set to a legal vector.  I.e. unlike
> many of the other vector variables in KVM, it can't be -1 (and can't be
> greater than 255, though that should hold true for all vectors in KVM).
>
> Drop the now fully dead BUG_ON(), which aside from being completely
> unnecessary, was also useless, as it wouldn't guard against a negative
> value, i.e. wouldn't detect KVM's magic -1 value.
>
> For all intents and purposes, no functional change intended.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>
> v2: Use a u8 to make it impossible for the test to be out-of-bounds. [Pao=
lo]
>
> v1: https://lore.kernel.org/all/20260618185515.2021642-1-seanjc@google.co=
m
>
>  arch/x86/include/asm/kvm_host.h | 2 +-
>  arch/x86/kvm/lapic.c            | 4 ++--
>  arch/x86/kvm/lapic.h            | 2 +-
>  arch/x86/kvm/vmx/vmx.c          | 3 +--
>  arch/x86/kvm/x86.c              | 1 -
>  5 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 283847619ff8..9614314fd237 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -973,7 +973,7 @@ struct kvm_vcpu_arch {
>                 bool pv_unhalted;
>         } pv;
>
> -       int pending_ioapic_eoi;
> +       u8 pending_ioapic_eoi;
>         int pending_external_vector;
>         int highest_stale_pending_ioapic_eoi;
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 586a5cee29e1..87bb8e5f4ca1 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1552,7 +1552,7 @@ static bool kvm_ioapic_handles_vector(struct kvm_la=
pic *apic, int vector)
>         return test_bit(vector, apic->vcpu->arch.ioapic_handled_vectors);
>  }
>
> -static void kvm_ioapic_send_eoi(struct kvm_lapic *apic, int vector)
> +static void kvm_ioapic_send_eoi(struct kvm_lapic *apic, u8 vector)
>  {
>         int __maybe_unused trigger_mode;
>
> @@ -1622,7 +1622,7 @@ static int apic_set_eoi(struct kvm_lapic *apic)
>   * this interface assumes a trap-like exit, which has already finished
>   * desired side effect including vISR and vPPR update.
>   */
> -void kvm_apic_set_eoi_accelerated(struct kvm_vcpu *vcpu, int vector)
> +void kvm_apic_set_eoi_accelerated(struct kvm_vcpu *vcpu, u8 vector)
>  {
>         struct kvm_lapic *apic =3D vcpu->arch.apic;
>
> diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
> index bd1098c89d99..db071d0b172d 100644
> --- a/arch/x86/kvm/lapic.h
> +++ b/arch/x86/kvm/lapic.h
> @@ -177,7 +177,7 @@ u64 kvm_get_lapic_tscdeadline_msr(struct kvm_vcpu *vc=
pu);
>  void kvm_set_lapic_tscdeadline_msr(struct kvm_vcpu *vcpu, u64 data);
>
>  void kvm_apic_write_nodecode(struct kvm_vcpu *vcpu, u32 offset);
> -void kvm_apic_set_eoi_accelerated(struct kvm_vcpu *vcpu, int vector);
> +void kvm_apic_set_eoi_accelerated(struct kvm_vcpu *vcpu, u8 vector);
>
>  int kvm_lapic_set_vapic_addr(struct kvm_vcpu *vcpu, gpa_t vapic_addr);
>  void kvm_lapic_sync_from_vapic(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index e3bfe6aca1a0..c1fdfccd20fa 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5886,10 +5886,9 @@ static int handle_apic_access(struct kvm_vcpu *vcp=
u)
>  static int handle_apic_eoi_induced(struct kvm_vcpu *vcpu)
>  {
>         unsigned long exit_qualification =3D vmx_get_exit_qual(vcpu);
> -       int vector =3D exit_qualification & 0xff;
>
>         /* EOI-induced VM exit is trap-like and thus no need to adjust IP=
 */
> -       kvm_apic_set_eoi_accelerated(vcpu, vector);
> +       kvm_apic_set_eoi_accelerated(vcpu, exit_qualification & 0xff);
>         return 1;
>  }
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d94b59140c45..8b23f342a1fa 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8151,7 +8151,6 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>                 if (kvm_check_request(KVM_REQ_NMI, vcpu))
>                         process_nmi(vcpu);
>                 if (kvm_check_request(KVM_REQ_IOAPIC_EOI_EXIT, vcpu)) {
> -                       BUG_ON(vcpu->arch.pending_ioapic_eoi > 255);
>                         if (test_bit(vcpu->arch.pending_ioapic_eoi,
>                                      vcpu->arch.ioapic_handled_vectors)) =
{
>                                 vcpu->run->exit_reason =3D KVM_EXIT_IOAPI=
C_EOI;
>
> base-commit: a806d364ef288a6443a1337820ea8410a7ccc6b3
> --
> 2.55.0.679.g6767b8d81c-goog
>

