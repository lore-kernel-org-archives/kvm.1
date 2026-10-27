Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793123787;
	b=ExJv03VW4j+JYLc/Qe2D3DPamFhMyknR7VS90qnMZ9Kczp8DekK2hIVPWui57wDt3+Os
	 AhmnLt9skJNbMfSz+4Bwb81+GJGJGqe1sfZcHgHhNcrR+Nh1tLvJ5ofh62dtK5kue3mrB
	 396OH9VsUoV+Uj49kSHGtswYYPhH3uplo/loFQyMYcy4X8AxgsCq5AJwc4UPJvjXZjOuI
	 uj3xD1HZ5bqF0ji7yhin58Ek8ErVkziJnYIHXMLHQnrAV6i41l8A11CJ3D1ZhQAKvMnHD
	 TZADXANnMOXpDF5sqWTmxn5BeuCqwHS1l1LCauBc0uPcnX4gkBhph/NwTPSyKJdj+jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123787;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Q7mwPyRYYbvgtpCr60Q7T+YMbXSs5veHKoppqZdUka0=;
	b=dAWi5IFPkLydHwsVICPx8pHcLbF0CpEIHHqa+/OlI/09GCTSSX2ZKyPXJb7a7oCH8a/F
	 b3wB617HycaaIfr5Zr34A+tFy/ac8GFO+bMP95PBzD0eia12BboApEiTMZd52pXNT91LC
	 WSjdkONmTiHLL3tNSb16DVY7o8OltDa28m9Qj7bzaaQ7am6npYQWXExtL1ClWcN5ReLfY
	 2lhf2Njc45cZGkYtigPZA8AEbYpDifWJG+VpY3RzFKJSBJ7wXQ1E0Ayl/s78zH11ED1XO
	 v0hp8ZCBVNSLrF+4Vi6R7tz68wj76acuHgBJsJM0QL2GlLQL2fSC9JjAJsOYzVFcYuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cr7ZnfTa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF05F606A322
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cr7ZnfTa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460D01F01825
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 17:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793123786;
	bh=Q7mwPyRYYbvgtpCr60Q7T+YMbXSs5veHKoppqZdUka0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cr7ZnfTaqNWGO6K9bAI+oSzOldqiVBbKntKVnqpjv3bAzWJCAo69vUjkx5Chf0Shi
	 4A2JunKQMV3hKjKkdzXweuGaCKZjcXxURN+C9Agge8K9aAVzGh0sW04QuFqIY2/vHd
	 R1VaYB7AWbMMTYICwgc0ZKnsA2+y7LsmIUCwrzY3wVHOSgXTMNNGsWyGXBWO6LXka+
	 oJEx5/4uLBnlEmOFqWBRNqeNRVOFAcAkET/E1jLHnAhyo6LlY8BtTcTqjr7MXVVwM+
	 Z5s7nf8Gh03P4eqdPDWgFfuhZ8r0bhAzFvscPUQBsWnut155r2BJDzTZZkZGBVL8kW
	 SohLos2XrxFKg==
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93f560af6aeso6135985a.0
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 10:56:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx3iX/uNMrssz09xYMcMqtRGPy/DnRYqBbF5t4LL/T08ImPbaoECqIxy5YavvupVR3wQB0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLabc8HKPKR58+Y/htSvQ7DfxI7CYABrncb30Bejlis5xAF+0Ds
	aEV/g8Q0kKPEnudy0bn8Fe6AgoWjtWDlaaaVufeMpJIBQaasqehd/UAt1Y4hJwEVrvQZUJHO51Y
	j4PYfUU120yujfCGtT2Hd+hH4BchORrE=
X-Received: by 2002:a05:620a:410e:b0:93f:3120:6c84 with SMTP id
 af79cd13be357-940ef8cf39bmr1517681985a.36.1793123785656; Tue, 27 Oct 2026
 10:56:25 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-27-yosry@kernel.org>
 <CALMp9eS8KDozNGT9J_uN69W32QEvTbg2JrtRqN0ESi00b_uq=A@mail.gmail.com>
 <atqRyeqSXViiNIk6@google.com> <CAO9r8zMqiW=3t7zRo_WAhKJfpYsDwuG3e=nK14GXhrq+foYnOw@mail.gmail.com>
 <at-O8-tzgezj2du-@google.com> <CAO9r8zO8ViSqCBer4rV5qBQGcDKA_60Aj_KEVQx2obd9zU7-Hg@mail.gmail.com>
 <auDkX94UTjrLNmqp@google.com>
In-Reply-To: <auDkX94UTjrLNmqp@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 27 Oct 2026 10:56:12 -0700
X-Gmail-Original-Message-ID: <CAO9r8zP5rom7VpA3-BsuB-H_+G5r-OC-Bfz=iTMbhQrWB4RYbA@mail.gmail.com>
X-Gm-Features: AclHuK-k6y80ZiwPfhFZdinBjgmMB612AkS5NrA46EEDOGyFzwnr8rX2cHZ8_cg
Message-ID: <CAO9r8zP5rom7VpA3-BsuB-H_+G5r-OC-Bfz=iTMbhQrWB4RYbA@mail.gmail.com>
Subject: Re: [PATCH v3 26/27] KVM: nSVM: Use different ASIDs for L1 and L2
To: Sean Christopherson <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 10:50=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Mon, Oct 26, 2026, Yosry Ahmed wrote:
> > On Mon, Oct 26, 2026 at 10:33=E2=80=AFAM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> > >
> > > On Thu, Oct 22, 2026, Yosry Ahmed wrote:
> > > > On Thu, Oct 22, 2026 at 3:44=E2=80=AFPM Sean Christopherson <seanjc=
@google.com> wrote:
> > > > >
> > > > > On Fri, Oct 16, 2026, Jim Mattson wrote:
> > > > > > On Mon, Oct 12, 2026 at 4:37=E2=80=AFPM Yosry Ahmed <yosry@kern=
el.org> wrote:
> > > > > > Moreover, does this change the semantics of PV TLB flush? In
> > > > > > record_steal_time(), we have:
> > > > > >
> > > > > > if (st_preempted & KVM_VCPU_FLUSH_TLB)
> > > > > >         kvm_vcpu_flush_tlb_guest(vcpu);
> > > > > >
> > > > > > IIUC, an idle vCPU that wakes into L2 will flush only L2's ASID=
. In
> > > > > > the past, with a shared ASID, L1's ASID was always flushed on e=
mulated
> > > > > > VM-exit anyway. Now, L1's ASID will be unaffected. Though I can=
't find
> > > > > > any real documentation on PV TLB flush, it *seems* like the rem=
ote
> > > > > > vCPU would want L1's ASID to be flushed. OTOH, this change make=
s nSVM
> > > > > > behave just like nVMX.
> > > > >
> > > > > That's a bug that absolutely needs to be fixed, probably relative=
ly urgently.  We
> > > > > should also document that passing through the steal_time shared i=
nformation to L2
> > > > > to utilize PV TLB flushes for L2 is explicitly not supported.
> > > > >
> > > > > I hate to re-introduce deferred actions for L2 =3D> L1 things, bu=
t that seems like
> > > > > the only sane way to handle this, because handling the !tdp_enabl=
ed case, where
> > > > > KVM needs to sync the current root, requires knowing what MMU is =
going to be in
> > > > > use when L1 regains control.  Yuck.
> > > >
> > > > Are you implying that *you* will be re-introducing deferred actions=
? :P
> > >
> > > Heh, probably not this calendar year.
> >
> > Are you opposed to this series landing before that is fixed, keeping
> > in mind that it will expose nSVM to the pre-existing bug?
>
> Nah, though I should just fix the damn bug.  It's not hard, I just don't =
want to
> do it because I don't want to reintroduce a deferred request.  Untested, =
but I
> think this is all that's needed.

Makes sense to the untrained eye, although I do wonder sometimes if
requests more generally need a way to key off guest mode. I am sure
you don't want to open this can of worms :)

>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 0378577d9d8b..696aae38f619 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -879,6 +879,7 @@ struct kvm_vcpu_arch {
>
>         struct {
>                 u8 preempted;
> +               bool flush_tlb_pending;
>                 u64 msr_val;
>                 u64 last_steal;
>                 struct gfn_to_hva_cache cache;
> diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
> index 97c17b120a57..efa54f9f9e9a 100644
> --- a/arch/x86/kvm/regs.h
> +++ b/arch/x86/kvm/regs.h
> @@ -469,6 +469,11 @@ static inline void leave_guest_mode(struct kvm_vcpu =
*vcpu)
>                 kvm_make_request(KVM_REQ_LOAD_EOI_EXITMAP, vcpu);
>         }
>
> +       if (vcpu->arch.st.flush_tlb_pending) {
> +               kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
> +               vcpu->arch.st.flush_tlb_pending =3D false;
> +       }
> +
>         vcpu->stat.guest_mode =3D 0;
>  }
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 32563a91fba9..15eb033b8e17 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2117,8 +2117,12 @@ static void record_steal_time(struct kvm_vcpu *vcp=
u)
>
>                 trace_kvm_pv_tlb_flush(vcpu->vcpu_id,
>                                        st_preempted & KVM_VCPU_FLUSH_TLB)=
;
> -               if (st_preempted & KVM_VCPU_FLUSH_TLB)
> -                       kvm_vcpu_flush_tlb_guest(vcpu);
> +               if (st_preempted & KVM_VCPU_FLUSH_TLB) {
> +                       if (!is_guest_mode(vcpu))
> +                               kvm_vcpu_flush_tlb_guest(vcpu);
> +                       else
> +                               vcpu->arch.st.flush_tlb_pending =3D true;
> +               }
>
>                 if (!user_access_begin(st, sizeof(*st)))
>                         goto dirty;
