Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F96411A04
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420609; cv=pass; b=bOMgQlaJkAxoI/3wxJ6WXV4yQhvfM+jdZH15tb4hMkjegjFr4fX5uc/3gG5EZbe1zb/8XDhmV4fmcLx8Emn453jp8Mcv63P97r1iBV1Q4bYNZ93O92pVTMG7WFLKtS+lZ6GouwV63WhGE/aV2LIXhnmWB1uX2GNpwX8s791YB+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420609; c=relaxed/simple;
	bh=n31Ma7+KWLGZ53xfxdD4huj/g6IficrcnEKN22gWA4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRG9y0IxROc7jk0cSoVPVxwVfIh1EOgEPdfuI8zBttqkDJAuhvAVKgZn4tBcDB0YJfQStKAyCOckOPrHC/cfW3F1odb4vGKSZU0eRYqujsrnRVzabTh0GqXmd3nmpP2qX6a+AlGohZdMSGlI4E5GSOOTVqtBTT64JNYvRQEBnP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jjj9zdAz; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jjj9zdAz"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6141a61c0so13a12.1
        for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 14:16:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789420605; cv=none;
        d=google.com; s=arc-20260327;
        b=i29juX64jEdxk9rLZDaZFaupsr9J9mZdKMHr7x/xIy5xheDE3jcoTv1U1bWNCb1YYh
         igOWd9hJbVQGLIVY/BLvtaxCfJcl2fZzJaCUNe7XhG181MI3TWPmQYmVS8ZXN7QdGo9R
         cjO5OhBUV24W7Tw8Dx6KT9ag/1S1r/ypDp5kBfx045QfI5HJaGZxA9pYnjk1TZdayIoR
         QToTXG9dV+1RNFQwr6VOyLXqU+VMaftHwV1iLdyzLBBIupmQQ5rnpTaQi3PmESc5DYd7
         Y49+cFEVTVLgtB9UyTi4wlw8eAhhQV5f2S2IyAcTuo57wwXoYsi8mqYJiB9NsP9p0g4t
         GtpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eeC6WkjWwzuT32tJiZ9pB1qr6n1OgtKzG5VypeJxifs=;
        fh=SYXsNSMweIj8CwHt7UOqgDyn771Kix2uPjy6p+ywscs=;
        b=Hg/5nSg5FwR3GtrbxWwLm9+mI1SRUbnRylDkeObOVxwh/K9cInPbk8A9OyGwGwDENM
         /8yq3wuOuy+ohd+55iG6aDlcZuumROih+HvUo1307KLNH/SUQ+dL+Al1G/rsPmfAVM5x
         pUT5jYLOoKkmoMGnjxewm0sMujDjej2msRqL3QspkkR4jgpERBLfqWndTvUeYQ5jyK5S
         pBIbAK/E6ihhgnCHpsFmZao/iuEsjRYb4jPcL4imnzXpjkIuIcuUWWt3LgpGnkEe1bce
         yJBcawi2H5Bsjexc0LVfjCYNwiF5SK+UDOQcnXxWvuDBfbztdYO3Zs7rwdtQaONYz5bw
         Ahgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789420605; x=1790025405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eeC6WkjWwzuT32tJiZ9pB1qr6n1OgtKzG5VypeJxifs=;
        b=Jjj9zdAz7vweOTPprgbw1+Z0kEPbH3M7/yxmrHZgCwWIB9VH48LIHUANhLIFlXrCro
         21jawGFS9rk0MD4wlM+018RtGidYd+2wgffYRuM0uKcGZc8L0T/rakq61b8b/TW15gKq
         QaJgvYeWd13PX+g/rXqvJbFu+LVnfXG8g7G1ymAdT26n8fng+rQ1BQyMce2IJIZcLVRh
         /TzCfLCezpIUCmhykZ+yxH16RGqR/uuikHfAWvjZYZryWahjeTfnJJYY1C4Bvv+zi1su
         rO71KBhb2YA7VCFwNqLID+EvHJB3qybTVyd+yGEs3LxDE/HyCfiXHekn9bY9YOB5asap
         SaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789420605; x=1790025405;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eeC6WkjWwzuT32tJiZ9pB1qr6n1OgtKzG5VypeJxifs=;
        b=RMW9RjyvQC4gN1xVmajfYOyhghxQx/pEf7Rk/vKTV+T3XzdJelob4c9hwXj+WACEm+
         DQy4gCqSjwBTVhAEIGUSs+E5Ofs7yYCJ3BeTxa1xY99cCVGgD9yfwlL7bvIGxXUAL16B
         MjDFWDqq7L/5wsBcKFlKePQBjJsgHt7mAmowo/7RECXI7b1s3LJnXJCzeiKSVGK+Y/75
         M8HpXNdvnjfcTRZAAFmVTp92dTTLfyezh9Kd39I5oYMGAE/Ob0pVv7B/+7MTTxtWHo5A
         Kj8OxhOvAB2kUo5mQJL8eNZBIXqLNCBnDWhbsOUBVGgpLaNvaJEcmDeRg8DVy2N5GLUd
         9tAA==
X-Forwarded-Encrypted: i=1; AKwUvBz1/Y03VQ0LqUuUDLjfflF+FDihpH/ZEEy/6fWlzRqFm9I1KpcP6/bgSN6e+8eW8Xni6YE=@vger.kernel.org
X-Gm-Message-State: AFuF++ltuqpGjt5lLdgYw9FuUckna+h7DSKJmmG5912f1MU5ySvGs2F9
	gTfdYx1f1LcUbXSg0SE476xJ32mJZHQZ9yKaq41YURSkSLiM8l4xzNrLvk0QdkND4LWS9jGDp1i
	Xqykh/inSXaBtDbh+UCHStZxUrciDBDVYLYmG+lAQ
X-Gm-Gg: AYBFou2Kl7p4ffVxlXqnBb3r4jT4Sy7arLE96OP6BhpcAtaPxu+ZR0A6imkuleNN1s+
	thTmq8LRuW2XBqh25axUIync6I3Q7Pg7kpm9Azk43tORGe9ssQfj/xKSXhC125Ggau6y/pftPz1
	6qcV4t3xVmNqIUyr7ArHJiMKu/uW8zCeUNDJN8eWwKAdBC177hi5qxYwOUoNm4ojyZETI5ZNY6U
	VdQ5n5tKp8eNfr71cnmfmv+poXtYiuRM0Fo/LtZXe1IcEwSYkuqybVZgZzXLnKfth31uTxjqOuW
	xwGbAY23L53/RSfkdPtbl6wne97pacbnuGJ/Pp42zPdmrGiC/53P4co=
X-Received: by 2002:aa7:c38f:0:b0:6a7:453c:a166 with SMTP id
 4fb4d7f45d1cf-6aa0749c8f5mr7106a12.1.1789420604685; Mon, 14 Sep 2026 14:16:44
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789281096.git.zhang_wei@open-hieco.net> <2cb3eb8fa88f2992b895b68010874fa3261c3a37.1789281096.git.zhang_wei@open-hieco.net>
In-Reply-To: <2cb3eb8fa88f2992b895b68010874fa3261c3a37.1789281096.git.zhang_wei@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 14 Sep 2026 14:16:31 -0700
X-Gm-Features: AcwNN1XV3bxP1cVuBoSTgK_SyNWJVjXdXiEEXWOxJWPehr9GBRjFNWmcolwNHHI
Message-ID: <CALMp9eSSiQWq+ZLaF3mJ5=NmTxXYxsYudC3umr5hL7HQQgq36Q@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] KVM: nSVM: Fetch DecodeAssist bytes for
 synthesized faults
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 11:44=E2=80=AFPM Tina Zhang <zhang_wei@open-hieco.n=
et> wrote:
>
> Hardware-reflected #NPF and #PF VM-Exits can propagate instruction bytes
> from VMCB02, but KVM-synthesized exits have no hardware-provided state fo=
r
> the current exit.
>
> Add kvm_fetch_guest_virt() as a wrapper around the generic guest virtual
> memory helper that applies instruction-fetch permissions.  When a
> synthesized data #NPF or #PF has no valid VMCB02 instruction bytes, fetch
> up to 15 bytes from L2's RIP while constructing VMCB12.  Preserve the byt=
es
> already read if a subsequent read cannot be completed.
>
> Limit each read to the current page so that linear address boundaries can
> be checked before continuing.  Outside 64-bit mode, truncate each address
> to 32 bits and limit the window at the code-segment limit.  In 64-bit mod=
e,
> stop at a non-canonical address.
>
> Do not attempt the fallback for SEV guests, as KVM cannot read encrypted
> guest memory directly.
>
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> ---
>  arch/x86/kvm/svm/nested.c | 64 +++++++++++++++++++++++++++++++++++++--
>  arch/x86/kvm/x86.c        | 23 +++++++++++---
>  arch/x86/kvm/x86.h        |  3 ++
>  3 files changed, 83 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index fba230058870..5cb6a9d6907b 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -78,22 +78,80 @@ static void nested_svm_invalidate_vmcb02_insn_bytes(s=
truct vcpu_svm *svm)
>         svm->nested.vmcb02_insn_bytes_valid =3D false;
>  }
>
> +static u8 nested_svm_get_insn_bytes_len(struct kvm_vcpu *vcpu, u8 max_by=
tes)
> +{
> +       if (!is_64_bit_mode(vcpu)) {
> +               u32 eip =3D kvm_rip_read(vcpu);
> +               u32 limit =3D to_svm(vcpu)->vmcb->save.cs.limit;
> +
> +               if (eip > limit)
> +                       return 0;
> +               max_bytes =3D min_t(u64, max_bytes, (u64)limit - eip + 1)=
;
> +       }
> +
> +       return max_bytes;
> +}
> +
> +static u8 nested_svm_fetch_insn_bytes(struct kvm_vcpu *vcpu, u8 *bytes,
> +                                     u8 max_bytes)
> +{
> +       struct x86_exception e;
> +       gva_t rip =3D kvm_get_linear_rip(vcpu);
> +       u8 count =3D 0;
> +
> +       max_bytes =3D nested_svm_get_insn_bytes_len(vcpu, max_bytes);
> +
> +       while (count < max_bytes) {
> +               gva_t addr =3D rip + count;
> +               u8 chunk;
> +
> +               if (!is_64_bit_mode(vcpu))
> +                       addr =3D (u32)addr;
> +               else if (is_noncanonical_address(addr, vcpu, 0))
> +                       break;
> +
> +               /*
> +                * Read one page at a time to recheck the linear address =
at each
> +                * boundary.
> +                */
> +               chunk =3D min_t(unsigned int, max_bytes - count,
> +                             PAGE_SIZE - offset_in_page(addr));
> +               if (kvm_fetch_guest_virt(vcpu, addr, bytes + count,
> +                                        chunk, &e) !=3D X86EMUL_CONTINUE=
)
> +                       break;
> +               count +=3D chunk;
> +       }
> +
> +       return count;
> +}

Hmmm...You added the wrapper I suggested, but you still have the loop
I don't like. See my comments on the wrapper, below.


>  static void nested_svm_update_vmcb12_insn_bytes(struct kvm_vcpu *vcpu,
>                                                 struct vmcb *vmcb12,
>                                                 const struct vmcb *vmcb02=
)
>  {
>         struct vcpu_svm *svm =3D to_svm(vcpu);
> +       const u8 max_bytes =3D sizeof(vmcb12->control.insn_bytes);
>
>         if (!guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS))
>                 goto out;
>
> -       if (!nested_svm_vmexit_supports_insn_bytes(vmcb02) ||
> -           !svm->nested.vmcb02_insn_bytes_valid) {
> +       if (!nested_svm_vmexit_supports_insn_bytes(vmcb02)) {
>                 nested_svm_invalidate_insn_bytes(vmcb12);
>                 goto out;
>         }
>
> -       nested_svm_copy_insn_bytes(vmcb12, vmcb02);
> +       if (svm->nested.vmcb02_insn_bytes_valid) {
> +               nested_svm_copy_insn_bytes(vmcb12, vmcb02);
> +               goto out;
> +       }
> +
> +       if (!is_sev_guest(vcpu))
> +               vmcb12->control.insn_len =3D
> +                       nested_svm_fetch_insn_bytes(vcpu,
> +                                                   vmcb12->control.insn_=
bytes,
> +                                                   max_bytes);
> +       else
> +               nested_svm_invalidate_insn_bytes(vmcb12);
>
>  out:
>         svm->nested.vmcb02_insn_bytes_valid =3D false;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 4b3681796c75..735b67781d55 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4848,9 +4848,24 @@ static int kvm_read_guest_virt_helper(gva_t addr, =
void *val, unsigned int bytes,
>  }
>
>  /* used for instruction fetching */
> -static int kvm_fetch_guest_virt(struct x86_emulate_ctxt *ctxt,
> -                               gva_t addr, void *val, unsigned int bytes=
,
> -                               struct x86_exception *exception)
> +int kvm_fetch_guest_virt(struct kvm_vcpu *vcpu, gva_t addr, void *val,
> +                        unsigned int bytes, struct x86_exception *except=
ion)
> +{
> +       u64 access =3D PFERR_FETCH_MASK;
> +
> +       if (kvm_x86_call(get_cpl)(vcpu) =3D=3D 3)
> +               access |=3D PFERR_USER_MASK;
> +
> +       memset(exception, 0, sizeof(*exception));
> +       return kvm_read_guest_virt_helper(addr, val, bytes, vcpu, access,
> +                                         exception);
> +}
> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_fetch_guest_virt);

To make this work the way I envisioned it, you need to add an out
variable, unsigned int *bytes_read, to kvm_read_guest_virt_helper():

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4818,7 +4818,8 @@ gpa_t kvm_mmu_gva_to_gpa_system(struct kvm_vcpu
*vcpu, gva_t gva,

 static int kvm_read_guest_virt_helper(gva_t addr, void *val, unsigned
int bytes,
                                      struct kvm_vcpu *vcpu, u64 access,
-                                     struct x86_exception *exception)
+                                     struct x86_exception *exception,
+                                     unsigned int *bytes_read)
 {
        struct kvm_pagewalk *gva_walk =3D &vcpu->arch.gva_walk;
        void *data =3D val;
@@ -4830,8 +4831,10 @@ static int kvm_read_guest_virt_helper(gva_t
addr, void *val, unsigned int bytes,
                unsigned toread =3D min(bytes, (unsigned)PAGE_SIZE - offset=
);
                int ret;

-               if (gpa =3D=3D INVALID_GPA)
-                       return X86EMUL_PROPAGATE_FAULT;
+               if (gpa =3D=3D INVALID_GPA) {
+                       r =3D X86EMUL_PROPAGATE_FAULT;
+                       goto out;
+               }
                ret =3D kvm_vcpu_read_guest_page(vcpu, gpa >> PAGE_SHIFT, d=
ata,
                                               offset, toread);
                if (ret < 0) {
@@ -4844,6 +4847,8 @@ static int kvm_read_guest_virt_helper(gva_t
addr, void *val, unsigned int bytes,
                addr +=3D toread;
        }
 out:
+       if (bytes_read)
+               *bytes_read =3D data - val;
        return r;
 }

Then, kvm_fetch_guest_virt() should return the number of bytes read
rather than an X86_EMUL_* code.

That should allow you to eliminate the loop in nested_svm_fetch_insn_bytes(=
).



> +static int emulator_fetch_guest_virt(struct x86_emulate_ctxt *ctxt,
> +                                    gva_t addr, void *val,
> +                                    unsigned int bytes,
> +                                    struct x86_exception *exception)
>  {
>         struct kvm_vcpu *vcpu =3D emul_to_vcpu(ctxt);
>         struct kvm_pagewalk *gva_walk =3D &vcpu->arch.gva_walk;
> @@ -5817,7 +5832,7 @@ static const struct x86_emulate_ops emulate_ops =3D=
 {
>         .write_gpr           =3D emulator_write_gpr,
>         .read_std            =3D emulator_read_std,
>         .write_std           =3D emulator_write_std,
> -       .fetch               =3D kvm_fetch_guest_virt,
> +       .fetch               =3D emulator_fetch_guest_virt,
>         .read_emulated       =3D emulator_read_emulated,
>         .write_emulated      =3D emulator_write_emulated,
>         .cmpxchg_emulated    =3D emulator_cmpxchg_emulated,
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 0f5919b092e4..f03419a79a11 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -356,6 +356,9 @@ static inline void adjust_tsc_offset_host(struct kvm_=
vcpu *vcpu, s64 adjustment)
>  int kvm_read_guest_virt(struct kvm_vcpu *vcpu,
>         gva_t addr, void *val, unsigned int bytes,
>         struct x86_exception *exception);
> +int kvm_fetch_guest_virt(struct kvm_vcpu *vcpu, gva_t addr, void *val,
> +                        unsigned int bytes,
> +                        struct x86_exception *exception);
>
>  int kvm_write_guest_virt_system(struct kvm_vcpu *vcpu,
>         gva_t addr, void *val, unsigned int bytes,
> --
> 2.43.7
>
