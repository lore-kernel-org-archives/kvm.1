Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3A81494A8
	for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784986664; cv=pass; b=aYaGQUDttXphJfeSY8lkR/RLL7WCBcxlMFvl9+HNq1r/e8I9gREOozjwOMQRXUt1mv/8fklxoq6ChboMF+A9ZZV/mplALsJ6wK9dUbhCftaQLDIHHmgTExpgquglQomIWB+o5w3u+4muks1SFnV/WHxIjcaUb5IZsUUoc1sMJrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784986664; c=relaxed/simple;
	bh=BsvhhqxL5vhvqwqZmxlvoAQzeJIJK90cfeH3mS23/es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bR7QX6P6B/9fOjdyjr0M2P3Nol+BHeeHART3Nf6WBMuc4BKtb/mPi0f0QNqq+fegTRTpU3ckdcv0fBiJA5zpMsYMCif1MiWafbpiErQiJw2li+gJfTY118Yf93SpLHo9KcTiMK28yk043L1XY0g+WfpfUSq7PsFZjDCkttrTUEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YpWHg7KQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dR7TS/1c; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpWHg7KQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dR7TS/1c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784986661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PfROqW7ENHj0xbZUvDclv4I/zlzBXp0mv08uNl2cYq4=;
	b=YpWHg7KQPb8xyLS0z20Cxd7mlTaE28/g9XCZzn3y1mA7f8jfZza7RvdQ2+7/P4lqJ0MvNT
	eNKTquz8Bi+gnuJNJX54TjyUhumrAGFmF3LkZAdoOu4vBUJ9zJ+AasTMNySWdr1VPs1p5r
	aihu3TL0xuxGdIZFoOZy3rRfzhK5ECg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-vHz5vhbjN0uBSEALS7_VIA-1; Sat, 25 Jul 2026 09:37:40 -0400
X-MC-Unique: vHz5vhbjN0uBSEALS7_VIA-1
X-Mimecast-MFC-AGG-ID: vHz5vhbjN0uBSEALS7_VIA_1784986659
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f83a59e5aso1221695f8f.0
        for <kvm@vger.kernel.org>; Sat, 25 Jul 2026 06:37:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784986659; cv=none;
        d=google.com; s=arc-20260327;
        b=Amm2rzPi/JoDdKDHHeBjA5Noc6FddN7M/L7cWLfKKVXwTVKfJbU9IpKXuNaRe26LCR
         MInXfYuTG90NO2+wrFqr/nlsCxgG//Z7f61/d3wGFtofjI00VyO8Y2xK3WMt4WZfGA/9
         bnOeRYhltSuNz3OesVEa/WHmDV5taPr6ZoSvGvskq4BH8Z2j4cEQhJUdNUgT7M1ulYU/
         /Hf2rTOW7LlRpxbcGseCBDhhY8UxvkGx79LvOjT4KmhIaJ5a55WHfH1lR+MduY+qNw0H
         vKK0YtnwRpcqU7jf/IijR4dK2wOuTPnwXA72O0ZEUhA9RBe0Ecp0HO0UpN3TmNnJVIyK
         Q7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PfROqW7ENHj0xbZUvDclv4I/zlzBXp0mv08uNl2cYq4=;
        fh=id16H15gTmnUM0dqTlW8wnbejglnqFdx2/37xV/6jHU=;
        b=BUQ4rKESxsigcRfPivQALL2G4cEJhUc8JTWbDcKlp7OKXMaivHCpIM7SPyV01c2ngR
         keFpVlSHdJI9g4kVPZsWEetnrWS8k0R1JUXde9QncDqqpp/3DNjFdRnqUANk6J2Lea0+
         zvOuFWg1BuuSVNxwxSguvXYjGZkk1AfgsOnQZeIyDx5Rj+2p2n3m2Q7w3NuJW/IpG9OR
         a1IfkoSvDlyj8GAGy021xI6S48GcW44rvOdgrAdsPBcNlAFvquqTIdSBHEBO9vCGdQds
         zfpbjiiZgtZ2k4m3jKhy47kBvFhES1qnlOoM57gTrWMs28p8oWNivBqIt8rkfz+P4Dle
         eUrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784986659; x=1785591459; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PfROqW7ENHj0xbZUvDclv4I/zlzBXp0mv08uNl2cYq4=;
        b=dR7TS/1cR6MEhtJsEFjypxTD8EqgioEIny1iSoqSe+RoUkHdXOKpqgHdJMtHjt37iG
         2jmmq+wNpSNyj4nxpgqguOLZssu+9CNEmJ2B/ZxSMR9S1gaY3IGpO2FKWRYHWLz+FtOB
         kChY3xC4ICja710pS7D4rTuaA7OsiARUCb20eSzl/47tvwj1hY2gkMR5s48x/wlvEbqW
         UlD11kYWWe6SeKOhmP1UqlX7SGHUiwN6EYYLFJtPnRyPPg7NTRnNmLFBHji1sbgcf0fw
         4EToUnJzX8jtf3BU+97yZ9dnjYfKEZFL7/hYNmVxyJN2Hjy0Vw7Y5m0c6s9zjLPQ+LzS
         6Tsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784986659; x=1785591459;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PfROqW7ENHj0xbZUvDclv4I/zlzBXp0mv08uNl2cYq4=;
        b=DviNZYYGQpT+P39xvB3h6DYTmCwnqkhGpDq/sZyzNQSVGUP0RdQKlb5VXTHSgzyyls
         FgWGkVgBt0ZZwm68pWYNH9O+CaKJjQt/Ssp0JuXDAfcvOlrPIrDE7wFHsMfDdksCHhaa
         B3Nqa59MQLmtOusOzmNUijyDNThguU9HjdvnHwzjTriPP2iEGc9s9PcyVtpd7z4XcuTZ
         iN9vYAf3LV9g1cQFYXCER3WW/dZNoR9Rk4qk4SMUXkHQo/NgbDxu9kA0QvUL6xCbTiCf
         ydKRMyHDZEXqdYSMev/tCWYDCTqpJdfJ0VsLkw/YCW1QrAo1SEEXXMSk02mCyRsmwdVX
         Mygw==
X-Forwarded-Encrypted: i=1; AHgh+RqF5bwPpFEFmciO+SCOtUNkbeifKDiiIE242MSiFVCbg1YhqkxufqXLObGpb/NisxqXpH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJlF8Qlz2gJGz6gqNSWTePe/ghGT6Ei966QIC6ilylX7msg1vT
	gAtDEben3tqUGAl+LIEEGrD1SXzQKUaYIMhMpt3kxINsZMnWW6Ux0qqg2iOOg7mxL+x0mrJDJPf
	b0NnQCROTcEuCNutzdK2sI6XFITpQw5OzinRqkQU8MPNzG3l2FWU+nN00kXzXD5snnqJlF14cIM
	Nu0jt8metWRfOfFHIuCXmjzwIXxTOR
X-Gm-Gg: AR+sD12fMdBmB4iMJmOBFS+fggOkWJpnm8oSnbFcmz4hUCobTspxacxLR5NYsmrDuUD
	av4Mk1Paxu9uIKCM8YfVhHrtDuJEnClF2ceA7XdO+3PoXDZCYjLmUMBjbdNzaBDehS9xm6hlc8y
	7Ab8/FoNNySpzEDGutdoFS+8Y+BxnDugsFJObrVf9sztwdggKXChjqL0EMAA+499omHCya55Dxe
	3BPsfshr312HMjYuR+M05uI+Oeo1YZv/7WNhys7g4bKLXYPfmj4lo7hz7KS
X-Received: by 2002:a05:6000:2313:b0:47f:91eb:342 with SMTP id ffacd0b85a97d-47f9fc8840bmr2740144f8f.13.1784986658736;
        Sat, 25 Jul 2026 06:37:38 -0700 (PDT)
X-Received: by 2002:a05:6000:2313:b0:47f:91eb:342 with SMTP id
 ffacd0b85a97d-47f9fc8840bmr2740125f8f.13.1784986658320; Sat, 25 Jul 2026
 06:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723094419.630204-1-pbonzini@redhat.com> <amPo-XdhFGIZquES@google.com>
In-Reply-To: <amPo-XdhFGIZquES@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 25 Jul 2026 15:37:26 +0200
X-Gm-Features: AUfX_mxAO7Xcg9OR8xi2P6xj-sPsYTW9O02p3OhaCy5nVilXjhWsFJdX137nDr4
Message-ID: <CABgObfbDE+=ir_phPC+9sVYnNXur6dFx6oAfEGSnCbrOqFoyVA@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: make svm_flush_tlb_gva do a full asid flush if
 NPT enabled
To: Sean Christopherson <seanjc@google.com>
Cc: "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Alexander Lougovski <alougovsk@redhat.com>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Il sab 25 lug 2026, 00:36 Sean Christopherson <seanjc@google.com> ha scritto:
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index b517257a6315..eca04d4b974e 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -1751,7 +1751,7 @@ struct kvm_x86_ops {
> >        * Can potentially get non-canonical addresses through INVLPGs, which
> >        * the implementation may choose to ignore if appropriate.
> >        */
> > -     void (*flush_tlb_gva)(struct kvm_vcpu *vcpu, gva_t addr);
> > +     void (*flush_tlb_gva)(struct kvm_vcpu *vcpu, gva_t addr, bool *full);
>
> LOL, why on earth are you using an out-param?  If we do this at runtime, just
> return a bool, at least that way we don't have to churn every call-site.

To be precise the churn is only one call site out of two, and in fact
it's the one which is mangled even more by your proposal below. :)
More seriously, I used an out parameter because returning 0/1 or
false/true is impenetrable for the Hyper-V call site, while
0/-EOPNOTSUPP (i.e. do not flush at all on NPT) would force changes in
kvm_mmu_invalidate_addr().

So, instead of making things good for one call site at the expense of
the other, the optional out param is more self documenting in svm.c
and is either good or bearable for the callers: Hyper-V doesn't care
either way (it doesn't e.g. need the return value within an "if" or
"while"), and kvm_mmu_invalidate_addr() just gets an extra NULL
argument.

Overall it's a matter of taste, I understand if you're not convinced
but I can say it wasn't out of a whim. In your defense maybe I should
have put this argument in the commit message somewhere? AI also
complained, but I shelved it because "Sean surely has better taste
than the AI"... :)

> But I would much rather handle this by nuking .flush_tlb_gva at setup, e.g.
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index f0144ae8d891..bf16119640dc 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -6555,7 +6555,10 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
>                 if (is_noncanonical_invlpg_address(addr, vcpu))
>                         return;
>
> -               kvm_x86_call(flush_tlb_gva)(vcpu, addr);
> +               if (kvm_x86_ops.flush_tlb_gva)
> +                       kvm_x86_call(flush_tlb_gva)(vcpu, addr);
> +               else
> +                       kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
>         }
>
>         if (!mmu->sync_spte)

This is a variation on the -EOPNOTSUPP convention, for which I didn't
like having this "else" in the caller that doesn't already have a
full-flush fallback. If you insist, I guess I would be fine with
adding a kvm_flush_tlb_gva() wrapper, use it in mmu.c, and check for
NULL in hyperv.c... but in the end is it really better than the out
param version?

In fact I am not even sure it is better than returning -EOPNOTSUPP.
From the svm.c point of view it certainly is very clean, but for
everyone else it's super easy to forget about checking the callback;
and you don't even have __must_check to save you.

Paolo

