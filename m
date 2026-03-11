Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FDE28469A
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 02:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194645; cv=none; b=Jd3YUCIQwRyGZu3LeDqxLu0lzrnYzVdHqWaeISX6CL+/C6CuGWSNQ509FYmenpZRGX6M48PI6p7/+EmraaxotPY/+7p/oTtdg3kzBk6OyXmHtcmhsKCelTQPNc8O4zNQ1mdM3mL3aze8FSDD8FyK0REKLK9SA+GjMOrxcUWXuwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194645; c=relaxed/simple;
	bh=PPErToIQW3sWxAd1STr1jsqwiscRK1JDHqYlV2RxXEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xw/UgFZxKytRjExzRe2IXv5qhbKdIV2VtXHgiqFt/I5Fzzu4TmW3GIWYVz56A5wGtrMgaiBoChjwNK/UpIQrH07YFW9DO9BerxFAJxs4MhzVg6ha+w2CoLuGPgPBd978PUMxvji8y5ZMa47H4xp+skJBIjP2YXRMtJTg7V1LUl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MD4bS3iB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MD4bS3iB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7C2C2BCB2
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 02:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773194645;
	bh=PPErToIQW3sWxAd1STr1jsqwiscRK1JDHqYlV2RxXEw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MD4bS3iBtcgWieB3asBVkN1MOGU1gD5yDC/TzMVPWq4bOx/kQdL46HpKVgd4XMUNq
	 Ulrd8QDJdo95s9mNVLJ1eEwUO9QJJd+8gtBLeWAZ6+O8ewm9GmjOyRNOGftKn+zJzH
	 OLyChipIlL098KhgSFmig6DqdyTTpgd+LY5RJMjoYvmpDuv9gcKnSdLZKRq26nx64W
	 up9ZDNxVH33DK15Plngvsovs3vK/rm+TxcMkKR1NmySNMY1tIOzVOs0QmYNJd309mu
	 UOPM6lAdiCVqcqtGdKQujn6AX+zMWdfgd8HfE8pKl1Sz6q9D6oU4gUWgg3J92ooCs5
	 fzhw5npi/IH+w==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b943b75dc42so761640766b.3
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 19:04:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUT1cKRAwrflf1VpSnRxEXifbfsQG4ppyy6rx+DDpf2R2u99hEPM05V8nnQkEf9QzqyQ6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YywUe0nrFQjWxde0jHejr2cC9QCfVAZ0asFNtnjwkPEF98vcnAe
	9c2LHsi/LWXZpHV0w659n9gHnBw5tjP0O77rnVb+2MvGBf/SqUg/WsdG+LuVQl2+FYHMh6Db7b4
	h5HuUwPXeUs9nDQY2tx7D76lyYfJ4DcE=
X-Received: by 2002:a17:907:a088:b0:b8a:f7ec:d995 with SMTP id
 a640c23a62f3a-b972e167afbmr38189666b.9.1773194644316; Tue, 10 Mar 2026
 19:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311003346.2626238-1-seanjc@google.com> <20260311003346.2626238-5-seanjc@google.com>
In-Reply-To: <20260311003346.2626238-5-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 10 Mar 2026 19:03:53 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNBEOJrxbx8ob2KRLRKkd_aZjz8tyXGqXxs0=TJq4fU6Q@mail.gmail.com>
X-Gm-Features: AaiRm53EpaamTGlu_jPI-y69DhSfy2spGK0sYTQIJ2IkTVwh7LQIU9EaVnAaL2g
Message-ID: <CAO9r8zNBEOJrxbx8ob2KRLRKkd_aZjz8tyXGqXxs0=TJq4fU6Q@mail.gmail.com>
Subject: Re: [PATCH 4/7] KVM: x86: Add wrapper APIs to reset dirty/available
 register masks
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, kvm@vger.kernel.org, 
	x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"Chang S . Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 5:34=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Add wrappers for setting regs_{avail,dirty} in anticipation of turning th=
e
> fields into proper bitmaps, at which point direct writes won't work so
> well.
>
> Deliberately leave the initialization in kvm_arch_vcpu_create() as-is,
> because the regs_avail logic in particular is special in that it's the on=
e
> and only place where KVM marks eagerly synchronized registers as availabl=
e.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/kvm_cache_regs.h | 19 +++++++++++++++++++
>  arch/x86/kvm/svm/svm.c        |  4 ++--
>  arch/x86/kvm/vmx/nested.c     |  4 ++--
>  arch/x86/kvm/vmx/tdx.c        |  2 +-
>  arch/x86/kvm/vmx/vmx.c        |  4 ++--
>  5 files changed, 26 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.=
h
> index ac1f9867a234..94e31cf38cb8 100644
> --- a/arch/x86/kvm/kvm_cache_regs.h
> +++ b/arch/x86/kvm/kvm_cache_regs.h
> @@ -105,6 +105,25 @@ static __always_inline bool kvm_register_test_and_ma=
rk_available(struct kvm_vcpu
>         return arch___test_and_set_bit(reg, (unsigned long *)&vcpu->arch.=
regs_avail);
>  }
>
> +static __always_inline void kvm_reset_available_registers(struct kvm_vcp=
u *vcpu,
> +                                                         u32 available_m=
ask)

Not closely following this series and don't know this code well, but
this API is very confusing for me tbh. Especially in comparison with
kvm_reset_dirty_registers().

Maybe rename this to kvm_clear_available_registers(), and pass in a
"clear_mask", then reverse the polarity:

vcpu->arch.regs_avail &=3D ~clear_mask;

Most callers are already passing in an inverse of a mask, so might as
well pass the mask as-is and invert it here, and it helps make the
name clear, we're passing in a bitmask to clear from regs_avail.

> +{
> +       /*
> +        * Note the bitwise-AND!  In practice, a straight write would als=
o work
> +        * as KVM initializes the mask to all ones and never clears regis=
ters
> +        * that are eagerly synchronized.  Using a bitwise-AND adds a bit=
 of
> +        * sanity checking as incorrectly marking an eagerly sync'd regis=
ter
> +        * unavailable will generate a WARN due to an unexpected cache re=
quest.
> +        */
> +       vcpu->arch.regs_avail &=3D available_mask;
> +}
> +
> +static __always_inline void kvm_reset_dirty_registers(struct kvm_vcpu *v=
cpu,
> +                                                     u32 dirty_mask)
> +{
> +       vcpu->arch.regs_dirty =3D dirty_mask;
> +}
> +
>  /*
>   * The "raw" register helpers are only for cases where the full 64 bits =
of a
>   * register are read/written irrespective of current vCPU mode.  In othe=
r words,
