Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793924047;
	b=gPhfL72kHDlFwLaIyZHWgCVCePEN5vyNUk4wzJh3uDXl5HAWomZwOzbTXaCz8mgA+ahu
	 31t3BmXr4PqFipCneA3uG0/DRwrchXJhYbo7wlzTJU8QTKV7yoZgJBiQg85zZIoLgWnsb
	 WzyxjI1Dqu+Yjxp2nLohN2qllXdDXXOLIlpR2p3OpjWj/zz0kKvj6rtCOqDCRsAI6Em+C
	 kl6nHaiQAeNpaekh1LJV5YHrOZDdWzy6nSrlk01EG/+DdHlxg7/xZS1Nu9bJfRRlkexUK
	 cYr4eHZay4WaRh6aB53j8lGfBGJskilB0KD0UTUNBsOdlDaIIc7DUlJJYUaXW6wF8wg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793924047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5HSH5LgRGtDfWuKTkX6T6F82xf1/4IsWwMXwRPJbvHU=;
	b=luTAqVV9maRgII+zZNMjGdMXOy/k8kFfV0zQe0/Q/RpU7FKHNBUm+VOcTAO2CtjKQi2P
	 tO6b33DpwbhltONFLntU2skwAnDyAo0rsLRB3dw/0RESvDTlg4Ec9PGVEFQVMf1CN54QB
	 qf3zVnyi/xnpmnZs+noly7jxZ6IgAsatt3ZyzBrKhiKAT+axKjqjVFUuBCWMwWnhkUsO9
	 iWenwJ7dH9kU0japejgNUQfJiUBBYby9ChXeAoiZieURyAHhaGcov1+yJ3isMvWl8c/lZ
	 B/PJ1gs0zxnWTCTm9yVKydQ2WfzmEaa7sGCQJ7S1Q4HrsnrganBy2oZ0KfY6J57aJHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=K8Jg6DwL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333EB606A31B
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 00:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 333EB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=K8Jg6DwL
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5383c97c8cfso2191cf.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 16:14:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793924045; cv=none;
        d=google.com; s=arc-20260327;
        b=EO2vXqiOKqlyMrtoQhpSNR5/6N9HJ5A93ZOoUIYz1gg1D62nDntYtd3ClMHu3X6uVx
         Ly5e6r4EIHf7cZW1zp58Wsrl4THLzKJVWfELfkf7PiZBOZpfuzFp0WuKCHwmSageKcom
         K2b5oQ006MoODF76Y7SE9A4hLFWfx1E9juozWWqWXXgtAWmj4WJn6MvmvcAKqBj1+ofP
         KOei4dZc5/bXrquH8zdR6GFqOjpdBgPihsqkyim9UDRfe+oPpbVdJaQIEd0Rj+H9bQZJ
         toNh82FNcw7a3PLbkvEAX0hsRsui0ixeJOCi7tp4+KKYLoPkr9LMf/BUURSFGd3MbiQS
         yl4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5HSH5LgRGtDfWuKTkX6T6F82xf1/4IsWwMXwRPJbvHU=;
        fh=n+UBBNUVn1ECsIFbOOjTJN5ZKFxGWxdH985cNa+erGY=;
        b=fy4hw655+tJTnD8NOVPRn4Pd0LQR5ah7ud8k/E7OswgotD8ONqN76FKBEvnFHaB2QX
         bSsriXeHmu2UDZjZiWq12cBvrMGoWDu6yDvt0v8AYIrXdyLsz71Vdpn9FQjsJqPybfmA
         JVHtF845AtqeVlZdxDj7AsBrSBWJeQKWSuIvykImEpccOphp5u+5+0CS5Kro0Bx4Bozx
         AxZxrwA0emLu5vg44m0EOsJUQCZ+WiUbMuF0cm+Z5mCA9yGOnYoPO6JuZcFZ8o8cJMCh
         qlhWD7E5CnJX03/0zfloGp/GDpO+tOHDpGOtEVZmrw9L+l3RhJsBHtcoFpyaixxdPlPP
         mvhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793924045; x=1794528845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5HSH5LgRGtDfWuKTkX6T6F82xf1/4IsWwMXwRPJbvHU=;
        b=K8Jg6DwLwPK9iS0PnGbSkzL6dTJoprL+4OjSJVTfsvG274hBnmlTtAV8cEJhQR+5qJ
         Kk/7GabI82rIp3iVodmL/F9XkmsHeKsGOdSn9TdO6t2kPd4EOKYQUKOfsvlN5684Doni
         fdfSVgb5fAIlzRSI8Q6LCioosx28NSJMksmmQtLtFcdZr8rJWMBgCQnNrQKBPc8efgSK
         uB80a8b6ZeVOVEFncldoHjol+sW0IMj24/mLhuiCNY1zlzoFw3m+VMvGWQteTU091C6i
         ++Kvt0MXXblHZKMiO0QA/HSB5uMJaNcJb0Rle7KjN4/SQsYqiLSmzd5DNlVLEm+cjIVJ
         m3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793924045; x=1794528845;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5HSH5LgRGtDfWuKTkX6T6F82xf1/4IsWwMXwRPJbvHU=;
        b=EKgEkrbfuVCHauegmioYrAanuNQT1qWp663q9DXkyhWrdom1/2ZSjNtjiXJl30ycZb
         MO8r7Du60HhGGGmdeSLm+Hx9QPJqss69eQJDyuQz2X6Rj2ZWOU2Ccf8n2Snwl/PI/v2/
         nQj0I9LZizcadHdrTD3J05p0CaOcmGy+l+Ghm7bbZNd3Bf6RBHrwS/bReyBQ3JbZ6j+w
         qsKgOeZCZWDqVtFz09ySj11Ef5a/jZvQf13gX3LOGTywMzGIc33nxkkxS47r2McihKgO
         uH4XinOAoxJYTIuY56uYeM1QqOIhfWKFD1MgP7CCkYYExB57H4Ai+suhFhqriL0+oupC
         Cypw==
X-Forwarded-Encrypted: i=1; AKwUvBwhTTc23lFWTJhmO3BZ24rb5ymb27Y7m3yXZINm5gIpL/4C3Pc/v46mhXxSacrg7CGBcho=@vger.kernel.org
X-Gm-Message-State: APuU4Z+RIGubt5+18LQKaZgy2x5IOhvGPBYiLyrgqZDLq8TEfaP3NK5N
	OZ7YyR3lhSE8k+xRaKDkGZtIccxr7m88c0Auk/ntqjZCx+bvLMiv/h5DCQVB/e+s3NrIuacfY6a
	j2mqRWu+VrQ+B6l3+FNw4fmu+eSU1glKBucACr2EY
X-Gm-Gg: AYBFou30LkP2rAG7YBNQ63vvN08bDUaxCaFTCmfGIlm261nNkV0yhW5BVqHYG3XeOHS
	vUrd/pYchIjpOl4UzuV2kNQXJowG2Ajym5Q2C1OnQrBJ3FIwGyA0aR7buWvL+VbCUsKI3sjZ12N
	z7j0GH7eZk0umItMAfj4Wsq3VHQPdMAsjUGIBx9nqnbaOALERKBrc7RVCnCjeT076vmYNgjRsLx
	vNAI3YvBtGjBSFsfwC1sJ5Dmj4ZiyU2wjXmHsQXb0bJOk6cV/A0WzrvAvB7QAtnUZ6s781CjKDP
	pjTq/nwiUtRQ1Aj84q8nqNNUH/cw76ooNe92Ur3cZsXK/ECaFPU/tJGmzIT5rC7JfbJPGoN9OdH
	ioQqeBENGMQP4HIEjrWDIv5miaE32NUUtF/P6Q3OW8AdmF/zASgcUMxvC0OdgtdwpC5uQDH7uMM
	lpuO+TWjmwonJ4OjCsoRnEVEa0
X-Received: by 2002:a05:622a:c0c:b0:532:9220:a9ae with SMTP id
 d75a77b69052e-54e1da391d2mr6789121cf.6.1793924044478; Thu, 05 Nov 2026
 16:14:04 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930210750.1487547-1-chang.seok.bae@intel.com> <20260930210750.1487547-4-chang.seok.bae@intel.com>
In-Reply-To: <20260930210750.1487547-4-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 5 Nov 2026 16:13:48 -0800
X-Gm-Features: AclHuK-y7AfK1l37ewnQHyjADh5Ww02bIackLJ6-4n8osIXv467OcMoYr9G2rK4
Message-ID: <CALMp9eT1Wza=7s53Pu7ODcBRkYSbpv4A_y58xJNEhQeaJ6r1Rg@mail.gmail.com>
Subject: Re: [PATCH v8 03/20] KVM: x86: Support APX state for XSAVE ABI
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 4:02=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> Introduce a facility to copy APX state between the VCPU cache and the
> userspace buffer as the VCPU cache is the single source of truth.
>
> The existing fpstate copy functions historically sync all XSTATEs in
> between userspace and kernel buffers [1]. In this regard, any additional
> state handling logic should be consistent with them -- i.e. validation of
> XSTATE_BV against the supported XCR0 mask.
>
> Now with the two copy paths, their invocations require to take care of
> these facts:
>
>   * When exporting to userspace, the fpstate function should run first
>     since it zeros out the area of components either not present or
>     inactive. Then the VCPU cache function ensures copying APX state.
>
>   * On the opposite way, both will copy the state to both storages. This
>     duplication is avoidable by tweaking either the generic function or
>     XSTATE_BV/XCR0. But the optimization while at a slow path looks to
>     rather add complication. So keep the implementation simple.
>
> [1] Except for PKRU state, as stored in struct thread_struct.
>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> ---

[ ... ]

> +static int kvm_copy_uabi_to_vcpu_regs(struct kvm_vcpu *vcpu, void *buf, =
u64 supported_xcr0)
> +{
> +       union fpregs_state *xstate =3D (union fpregs_state *)buf;
> +
> +       if (!(xstate->xsave.header.xfeatures & XFEATURE_MASK_APX))
> +               return 0;
> +
> +       if (!(supported_xcr0 & XFEATURE_MASK_APX))
> +               return -EINVAL;

Sashiko is right that this early return leaves stale values in R16-R31 when
XSTATE_BV[19] is 0.

In your reply to Sashiko, you wrote:

  This matches the existing XSAVE uABI semantics. XSTATE_BV specifies
  which state components are being updated. If userspace wants to zero
  the APX state, it must include the APX bit in XSTATE_BV; omitting the
  bit means "leave this component unchanged", just like the generic
  XSAVE copy path.

That is not how XRSTOR or KVM_SET_XSAVE works. In the XSAVE architecture,
XSTATE_BV[i] =3D 0 indicates that state component i is in its initial
configuration (typically zeros), not that it should be left unchanged. In
copy_uabi_to_xstate(), clearing bit i in xsave->header.xfeatures causes the
subsequent XRSTOR[S] in restore_fpregs_from_fpstate() to re-initialize
component i to its hardware INIT state. As the comment in
fpu_copy_uabi_to_guest_fpstate() notes, PKRU is the *only* exception to
this rule, for historical reasons:

    /*
     * Nullify @vpkru to preserve its current value if PKRU's bit isn't set
     * in the header.  KVM's odd ABI is to leave PKRU untouched in this
     * case (all other components are eventually re-initialized).
     */

Because R16-R31 are loaded into hardware from vcpu->arch.regs rather than
from guest_fpu via XRSTOR[S], kvm_copy_uabi_to_vcpu_regs() must explicitly
zero vcpu->arch.regs[VCPU_REGS_R16..VCPU_REGS_R31] when XFEATURE_MASK_APX
is clear in xstate->xsave.header.xfeatures.

[ ... ]

> @@ -3189,6 +3240,16 @@ static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm=
_vcpu *vcpu,
>          */
>         xstate->xsave.header.xfeatures &=3D ~vcpu->arch.guest_fpu.fpstate=
->xfd;
>
> +       /*
> +        * This and the following copy functions copy APX state into each
> +        * storage. The VCPU cache is the single source of truth but avoi=
ding
> +        * this redundant copy tends to introduce special-case handling. =
Since
> +        * this lies in a slow path, keep the implementation simple.
> +        */
> +       err =3D kvm_copy_uabi_to_vcpu_regs(vcpu, guest_xsave->region, kvm=
_caps.supported_xcr0);
> +       if (err)
> +               return err;
> +
>         return fpu_copy_uabi_to_guest_fpstate(&vcpu->arch.guest_fpu,
>                                               guest_xsave->region,
>                                               kvm_caps.supported_xcr0,

If fpu_copy_uabi_to_guest_fpstate() fails, vcpu->arch.regs[R16..R31] will
have already been clobbered.

Moreover, if you call kvm_copy_uabi_to_vcpu_regs() *after*
fpu_copy_uabi_to_guest_fpstate() succeeds, you don't need to check
supported_xcr0 in kvm_copy_uabi_to_vcpu_regs(), since
fpu_copy_uabi_to_guest_fpstate() rejects any xfeatures bits not in
kvm_caps.supported_xcr0.
