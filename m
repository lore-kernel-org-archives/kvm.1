Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.161.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793147019;
	b=aASt2DZf12P8CwywX9iH5Fqr9WmdqjxNM58prMJFID54/7YPX8S2NNe8iA6N49g2t0/B
	 Am5oRgKu3msdmM/7vyPQcscWdKvkOiuE8kuVqu9nBOc2/ggCHOW/rx2LuCNuS9d8ZunpQ
	 2QgGkCnkHMagVotJeFKxAsiR8B+CiABoWCHfGBztCyCGOnYobSdCR8lOhS48czf37V6h6
	 CXILrBzcvgX+msWE9Q0eYurNBzAPV0UBO1r+37zN0XfYdKd2TIS2rl8E9iby33VNGBSdw
	 eGtex4Qu1H1ob31kVVgx3fXqjrN/IQCl8R2Sc5ly+Q3uT91i+1ElHF2d3FzNJOuGSJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793147019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=q+kS/Y2rR6fuaKmpLXLUb9l2wfeJNFpsSAfgHh9ud6I=;
	b=ocPoTkde0vo6v4D4SWBP/T4hPfI1BX+bWcQNqy+6PlZcVAp4bPFGZ7I4YiRjzJjj8fmF
	 j+aljMcM2TVSOAE8liBoDFnbkbxH05kHCW2ovkhyLiDF+e7bcW1qYDIK99JPL7yw07VF8
	 I8heqdS5IgJieiH0wa8YoFJSTAn23q7oP9af93YMYFUC5dTNOcOK2sIDiPD/P7ZvRGfNZ
	 J6djZrRXBkkt7Sw0LsrAfNWwHhJCG6iQU5yYj3Q1BfeG2PEqAp5tfsA/iuUFL39OlkOMj
	 I+g0pi0z9ugzBOtt7IKymZxu8wXoqsyeoAehLPLh4OOma9QGcNGf3OrYTiNkwhy62VA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UZdHgaFB;
	arc=fail smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F14606A31D
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 00:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95F14606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UZdHgaFB
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-705cb6ceebaso321782eaf.3
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 17:23:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793147017; cv=none;
        d=google.com; s=arc-20260327;
        b=BbnD5hljN7/PFl+iDQnUk0k/hkgVMWDr1aRgrmbW4QTsguAxv26ci6oi5hcmbhbbl7
         A331btF2zQt5sT1gCEbOKQnRAGE/BIP2s2QsTMuFGr7ffzOr/H3SrNf0P10ZyPIFgggU
         s59P1dhApapw+ZpjKchHskDXR0OcRJT5EPWvfypXO47w2tjSG1Qg+Ddmrd7COvd7Okxc
         /bS00zlHGBdS4DnRRNNAmL4s0e0gbCfyg9CqbSlE+pQWkjIhUGMIj4j46XZg9EP9QqPQ
         snntn+gIaPNWNX9noP1wAH24gaut67cKxpq7yAxezH0Ki5C+oTFk+SSxY4gzxDlvTi9T
         21SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q+kS/Y2rR6fuaKmpLXLUb9l2wfeJNFpsSAfgHh9ud6I=;
        fh=dlejUmqRCjEre4mbWSk4bHrZuSGq6Txf8MJVRVBW55A=;
        b=P7lWLxz/ydpARftzKngTu9IsACMAS1QkF5IQCXiI3/A03zJX2DPJi/4m/261rTd6/G
         KdR5jf8JMhe/L0nM82B9dzTJL2MVKRuDnaOH29Pfjm8NV/K/z/yZOrpWxFxFTgxVXlbk
         tUMV0Sb87Xz/02JYxauyYytX9LusgHZH5HexXM0W4FA1eeDKwxS2DDgnuFs3IjLpgJ/5
         dv9JDk2lZNcz2h0OrQTI0vVe2frppt+/z9Tt+3E8efJwzwLJ7b+PPmhRBLhWLv9MFLe7
         tIbAswtzM0ToB80Hrr+4oLFS1ZkrZpltWLPfRIeq17A1GDKJ0ChiYFAJODcEI3ZZdztd
         6FXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793147017; x=1793751817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q+kS/Y2rR6fuaKmpLXLUb9l2wfeJNFpsSAfgHh9ud6I=;
        b=UZdHgaFBEqku8HdYlRJ6qbXEIg7YyzvhQZMaCBWicTqzFZGCBQipinLkWMuZ6jbCff
         /FBFimeCjWZPIY4Po4eU80ab95WbA5Y5v5OR+4846cKmu4rhKmOVa0uMLcGC/t5yVQyv
         nkyr/bYL9WJea96dNa/RPEuA48caxicvXIveMVHgMbhh2mwQVB96GDhIRqels5LtLhdF
         QqEDp/0Qnvk2tqtN8THw5tp+gomI8qJ+rbA/5cTLz2QVdfwa5VY5POItjZqXCbFgoCRq
         AJYDr3WTjD38A7BKGcOZ4Wvy+oa4tOkGQBfmp4T2P+f6mTGFPlK0TyjcvsYBtJs4uQGE
         DSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793147017; x=1793751817;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q+kS/Y2rR6fuaKmpLXLUb9l2wfeJNFpsSAfgHh9ud6I=;
        b=IDhK3Scl83rK3DsngnWErQCYLu2KdVEnrxOEtRB8fWk+9fFbEe0hOp1gS20CVNugJt
         xmeoPFlHEElZJ/XrpJX6TtQHCDpHEv2MXMhT8MfK5PpMID1SXtCo4rEuLMnnCQR8SMLw
         SBW0ye68lsGW55LGSV+hsOW1wQy/4X+nBnKGunq34zB8EIl6qHcJ/0vf0y/VExNc5IPF
         QXOR2sOCecengju6iOR3k33bhH8uAfAQwkg3GGGctILz6stWmJl0zVXPXqrHA6MJNl4r
         gch2PiTGAx178uqs6OWD3gi3g9tJSn5Z3T4TclFUOAk9xybcZIspKBS6mViE6WejFhMK
         jN+w==
X-Forwarded-Encrypted: i=1; AKwUvBxBv0wHqYpcrke+ZTDBO276aY/vGO/ZFxTws4tMSL9c0fc+wygMhCXK5ijU4Lson6AtdZU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKE4ZMKlLUjJfSHCjuvjuV5S91rcXGKL5ZvvJRVm3gHRYolUDe8
	DSZRKRZCgNJx1CMtAhL2qLkbZ2eu/ZN9VMG9jWezsvq3Szn7I23d10loUUXrs+cP7ApgQS18XW8
	40sT6O+JyPfbjhjM3MmumFj0Ste2+oady0kzNB7+N
X-Gm-Gg: AYBFou1U2FlIcyNtBz/h8hQFVvBXivi7MMS1gLNET+DlIuBIaUIAV940E/OgzIu9Zwp
	1BNlRxHHkhmGcrDx9roHzqVpZ88SWGEUEJNsncJMKokY6OVhDCgmONF7ayYmc3zg5tNxeD6yDN4
	C/cG+iI88nZLsJO/rR0yodq/N0TmdiXws4PwnZFrnT0npg/l35cRdes0md3zvYpZHpoIrq+ZCnX
	9T+g3kYoQ51zuUvIwgPn6O/uU2aQERRxrIA9SfSGnQlu5xxhGVqYQrWt9gs0xPDPN4kWMxouQ8a
	+5E14m4+AODhWnnCI9HEBv8+9GmeL3GMZUnpUvM9RRWxpkvAooo8gUeFLmgHvHdz9lm7t5YgyG4
	nAYzvh2Kqp2Ynwe/dERgUHstUfd8w0xGQPsL5I2h5xpNM9k6x+Qzov1ovt7Iv97vRfj+P2Yvnj2
	AsEuyGLtFUYb8btNOdVKy6UmSkzW71iW4zqsmu7CfsXNEmhu1Hf8tehl7LBOQd++s8Gh8LFW/nQ
	3rTl2hyXw==
X-Received: by 2002:a05:6820:f02a:b0:709:d804:88c4 with SMTP id
 006d021491bc7-713f05d151fmr475759eaf.89.1793147017029; Tue, 27 Oct 2026
 17:23:37 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027221209.1560865-1-seanjc@google.com> <20261027221209.1560865-10-seanjc@google.com>
In-Reply-To: <20261027221209.1560865-10-seanjc@google.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 27 Oct 2026 17:22:58 -0700
X-Gm-Features: AclHuK8RRqKY_lCjk0ArS-oHYaPKalWvy9KfBfqSoDe2ANJo4dTrcc5mcvnFu40
Message-ID: <CADrL8HXL0HCHbp_vLgcDGR8F462qT_DN5A3CvVBZW06xxE1gmw@mail.gmail.com>
Subject: Re: [PATCH v3 09/15] KVM: Pre-check uaccesses in KVM's APIs to
 read/write guest memory
To: Sean Christopherson <seanjc@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 3:12=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Add a check on whether or not doing a user access is ok in KVM's APIs for
> accessing guest memory, *before* doing memslot lookup/validation, so that
> buggy KVM accesses to guest memory more likely to fail noisily.  Because

"to guest memory [are] more likely"

> KVM installs dummy/empty memslots early in VM destruction, bugs in the VM
> teardown path will fail on the memslot checks without getting to the WARN=
s
> buried in kvm_copy_{to,from}_user() and friends.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

One somewhat minor comment below. Feel free to add:

Reviewed-by: James Houghton <jthoughton@google.com>

> ---
>  virt/kvm/kvm_main.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 1058b864d427..d8b914b76f90 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3298,6 +3298,11 @@ static int next_segment(unsigned long len, int off=
set)
>                 return len;
>  }
>
> +static bool kvm_is_guest_access_ok(struct kvm *kvm, int offset, int len,=
 int size)

Hrm... I think you at least want `len` and `size` to be `unsigned
long`, and you probably want `offset` to be `unsigned int` or
`unsigned long`. The *_cached() functions are the interesting ones in
this case; I've left a note below at the first callsite.

> +{
> +       return kvm_can_do_uaccess(kvm) && !WARN_ON_ONCE(offset + len > si=
ze);
> +}
> +
>  /* Copy @len bytes from guest memory at '(@gfn * PAGE_SIZE) + @offset' t=
o @data */
>  static int __kvm_read_guest_page(struct kvm *kvm, struct kvm_memory_slot=
 *slot,
>                                  gfn_t gfn, void *data, int offset, int l=
en)
> @@ -3305,7 +3310,7 @@ static int __kvm_read_guest_page(struct kvm *kvm, s=
truct kvm_memory_slot *slot,
>         int r;
>         unsigned long addr;
>
> -       if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
> +       if (!kvm_is_guest_access_ok(kvm, offset, len, PAGE_SIZE))
>                 return -EFAULT;
>
>         addr =3D gfn_to_hva_memslot_prot(slot, gfn, NULL);
> @@ -3381,7 +3386,7 @@ static int __kvm_read_guest_atomic(struct kvm *kvm,=
 struct kvm_memory_slot *slot
>         int r;
>         unsigned long addr;
>
> -       if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
> +       if (!kvm_is_guest_access_ok(kvm, offset, len, PAGE_SIZE))
>                 return -EFAULT;
>
>         addr =3D gfn_to_hva_memslot_prot(slot, gfn, NULL);
> @@ -3414,7 +3419,7 @@ static int __kvm_write_guest_page(struct kvm *kvm,
>         int r;
>         unsigned long addr;
>
> -       if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
> +       if (!kvm_is_guest_access_ok(kvm, offset, len, PAGE_SIZE))
>                 return -EFAULT;
>
>         addr =3D gfn_to_hva_memslot(memslot, gfn);
> @@ -3544,7 +3549,7 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, =
struct gfn_to_hva_cache *ghc,
>         int r;
>         gpa_t gpa =3D ghc->gpa + offset;
>
> -       if (WARN_ON_ONCE(len + offset > ghc->len))
> +       if (!kvm_is_guest_access_ok(kvm, offset, len, ghc->len))

Currently, this truncates `len` and `ghc->len` from `unsigned long` to
`int`, and it will change `offset` from `unsigned int` to `int`.


>                 return -EINVAL;
>
>         if (slots->generation !=3D ghc->generation) {
> @@ -3582,7 +3587,7 @@ int kvm_read_guest_offset_cached(struct kvm *kvm, s=
truct gfn_to_hva_cache *ghc,
>         int r;
>         gpa_t gpa =3D ghc->gpa + offset;
>
> -       if (WARN_ON_ONCE(len + offset > ghc->len))
> +       if (!kvm_is_guest_access_ok(kvm, offset, len, ghc->len))
>                 return -EINVAL;
>
>         if (slots->generation !=3D ghc->generation) {
> --
> 2.56.0.307.g5fe7bd680c-goog
>
