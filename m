Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3084D3A641B
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792103284; cv=none; b=MvnB6LjvYe98EoJ5FLlHuKTnaNCCdHkX6zTGOrwSXvxhZoS4YmG9mIr//AGuR0yZ7APpmafvZp9in2fSe6sP4l460Jhwz2l132zSqsxDY/YI1g2p/j3YRRffAqtiAKVJP1AwYwxIaFeR9diXVDAb94eAqOPfVGuxOctnC5NKYWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792103284; c=relaxed/simple;
	bh=z52xkpXbzQ1vnhmTzhfHs3B1+lTsbX6VtcStepi2cU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcR6/zr0bdGZv634TE6Fr58Rsluc3Opje1IgZAiAMmZuFwwhmDfPOvFVxOhtiTmNCyo4UC8hah9xWCCkwf9HnAJnHUgSHXx9HDIusLnwEeLs3LL3cLp2gO3k2rn3CL81UATWovdCTD5dWsdGDhW9iluk611BxvCJGM6bEJ+AYNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0C7m9nb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0C7m9nb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A424D1F000C6
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 22:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792103282;
	bh=ChM6vFdBwc9E1qUfGLxr+avpPsZ9ryaGETVPJr3T6IQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=T0C7m9nb7OBGaYNPbvUrvWBqfTXFEQDfdPwtn0VOyWPAHyDR3Vl9x7onFQMBK+8VM
	 UuTGLb5gfY69C1zMGflMWuKhy+/5/pJ3ytTiTpUFSf8j1xZVvoK8Lw5QO4QzVzf0GH
	 o8aapAHttOH+e0D2JWyTwX5z5sEgu3ydHv97woJShR+wJleSF8VbQfrqgjK0PLRRTv
	 736nwKgZml70G6MdTtfdOyhyXt8nMM8+YzSQ7qtrCrAH+H8TPG2PyNKwcadpK1Scil
	 /NwZ9zY+R7gcTNw8VwJOaeWmKYzodD6lS99zh6a5aDPcVSj8sWEKKDJc/JI+sgIUkh
	 uxbkOaLmnQ+Vw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c2e8c710847so730031266b.0
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:28:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzZg6cPsj8mAEQnkCsvZ6oDCVxmukMvJyHSZXLMVPBUH3oOVycTW2OQ4ptIRCEkBMSqZdU=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9BCoToheDPoZ1oI0RLrw1UYXV6UB0H/XGcTAe6IGt3/Oosa6R
	RIzILOZDqwl0/rnxmHdmzkFfEB9alma8G0ClQrmqB76Ddd03a0SU3ZdXd7UkyL8OhaB+ZKdwmVb
	OzRHlQu9jbGiR3gkchqtHxrCNizrexWc=
X-Received: by 2002:a17:907:7213:b0:c2d:d408:5da6 with SMTP id
 a640c23a62f3a-c31aa02805amr1855139366b.49.1792103281310; Thu, 15 Oct 2026
 15:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-14-yosry@kernel.org>
 <CALMp9eSV0ikZ8CDoah_vCKYFXEm5syYh_sCMQ8wXhGB0+E=vcg@mail.gmail.com>
 <CAO9r8zOUjXMvhmK7TBmgKkbs+JjFMEmcLgW589_N_smC6k-hrw@mail.gmail.com> <CALMp9eQ_RJV4-+FKewTFdFacY=LJbn7Pd2T-ET_cDU+-HXHd7g@mail.gmail.com>
In-Reply-To: <CALMp9eQ_RJV4-+FKewTFdFacY=LJbn7Pd2T-ET_cDU+-HXHd7g@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 15 Oct 2026 15:27:49 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMyHenA1DLfs==fsmnztaSWPr0s_v4JoTYkkSbrA16LWw@mail.gmail.com>
X-Gm-Features: AclHuK-6tMbZOYJ3-5QXnquHKM-Sp93SMRanOLxzB5GfkXzNyT8WXbFetoA1WP0
Message-ID: <CAO9r8zMyHenA1DLfs==fsmnztaSWPr0s_v4JoTYkkSbrA16LWw@mail.gmail.com>
Subject: Re: [PATCH v3 13/27] KVM: nSVM: Add a placeholder ASID for L2
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > > index bfb297b7d71ab..780132725bb79 100644
> > > > --- a/arch/x86/kvm/svm/nested.c
> > > > +++ b/arch/x86/kvm/svm/nested.c
> > > > @@ -701,7 +701,6 @@ static void nested_svm_transition_tlb_flush(struct kvm_vcpu *vcpu)
> > > >          *  - Honor L1's request to flush an ASID on nested VMRUN
> > > >          *  - Sync nested NPT MMU on VMRUN that flushes L2's ASID[*]
> > > >          *  - Don't crush a pending TLB flush in vmcb02 on nested VMRUN
> > > > -        *  - Flush L1's ASID on KVM_REQ_TLB_FLUSH_GUEST
> > >
> > > Um...How does this patch either do this TODO or render it moot?
> >
> > L1 now has a separate ASID from L2, and it's the one we're already
> > flushing with KVM_REQ_TLB_FLUSH_GUEST. It's kinda already moot because
> > we already flush L1's ASID on KVM_REQ_TLB_FLUSH_GUEST.. or maybe it's
> > actually *wrong* because KVM_REQ_TLB_FLUSH_GUEST needs to flush the
> > current ASID, not always L1's ASID.
> >
> > I can drop it separately if that helps.
>
> You could just explain it in the commit message.

Will do.
