Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE3C4483AB
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786138903; cv=pass; b=I4Vytxwx8wjacCxl7bmYuw+Ievm+TuqUKoc52CqxFop5/DWX588yHRPEisTRmFi47plH6wZDNbzNbmo3Z0yqkTukM67KGyfI+W9/OKXd3OKdeDe/+9l17JsgGfdZfkXqq/DDrZ+iYJ0tJEzdLEkxbZKViDWk+NHH1s/4TNvkuuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786138903; c=relaxed/simple;
	bh=YF4ENqgh02cdiQ0TrlFOm2HioxPEX423EDx1wxvyxSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbKwWCrOWPOKRy3Meveard87iEM2k7UkMOUMDJJY0eSb6pTWalR9GCB2SmlzkdIkj0Wgkt/077U3+UPSkvb0iiZ34I67A0joPc4Kkqdx1F+0VuMfB7vWrc4eXflaFZnDMSdg9syiScPxzlSzk1G+FyOLDk0rSRbxR4efxulUwu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfGM5RmA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=prtSXJmH; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfGM5RmA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="prtSXJmH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786138900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=poHNCFVAUnTfBbNRkHgPupZhpjqXlJdoVP2r/kOeEUY=;
	b=AfGM5RmAWsan8KxPwg17o8SlnH6mAiMoIuT6CHbKH9N33boHaIqK/cS2/dX4ncoDfNUSMt
	i9wMZsT3301scyikmyxbmEACLVkmbdqO28UCVpf7fR/arIJ0slDX+zk9H0o9YcIXx7+YeB
	cBChwxcY2mz95xSaH7l5uRQ4QPdWPmU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-1QzBHPH_MvyVf08fYYuJmw-1; Fri, 07 Aug 2026 17:41:39 -0400
X-MC-Unique: 1QzBHPH_MvyVf08fYYuJmw-1
X-Mimecast-MFC-AGG-ID: 1QzBHPH_MvyVf08fYYuJmw_1786138898
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f7039fa59so2986210f8f.1
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 14:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786138898; cv=none;
        d=google.com; s=arc-20260327;
        b=YSntlbdoRH7/4Bb2SA0yCjloISUtlZEIqhcrYxEKZh/hCMM3Iu3NuzxHvTsIviGlVK
         V6Oy+gkooxM6ztfkw6+0i2PbvcMFKeajm5LmsAeu24C5FAtCUgccFGKU6WlrBrkzIO6o
         5JFKOjkgXyKJ06L+54taBH6WREjk15ck4ZU6/ecUn9m20KElhyORIZRCjGSd/V6CCOQ4
         8ey2fuF+dukT3DIAWWXXAjcbaPBU7siVzHeowu5ct+6HzJwFGQHhCXNuybHytLIjsUCK
         W16/XJ5LC3EyJ7+G871LKXZCvewzt15rLdswjOMUDPvZassK9sCLkoCF6aq+OAZsySg/
         5eCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=poHNCFVAUnTfBbNRkHgPupZhpjqXlJdoVP2r/kOeEUY=;
        fh=R+3UpP2VTGUU3HvYIvHKMIRO0UQwKfZ4tCTZDAunuxI=;
        b=X/lIju2+yun6cpH4BoJvpQvG0ftAz4u5E5LS08KTNTxd4ZLLVoBc6Rl9yT1fGgH7Hp
         sQrDySvyUYMgXD1GEESyIRCH69ppUx8BGz7l3v6L2it5YJQTXDwew49JrgkZ3jQWkMMO
         LJoALVm66hw9gII+k2bc7tSJ2y5u3v/zzqfdFH9tidTazh48t0q7FuwTbCqFoWASdY8l
         sOA8vKXCLq/tGWdjqF7b0oFnPOMiCKYGOMuupc/71Y29mkaOW16PTKlqMb3M08+uug6D
         cAw/jnGzL2Mq+cAwGjkm4/+KUnr4hqz4/KSR6S2UKgmNLHBuNS8nzHLifBG0kT2ee4z0
         qS6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786138898; x=1786743698; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=poHNCFVAUnTfBbNRkHgPupZhpjqXlJdoVP2r/kOeEUY=;
        b=prtSXJmHduauisMMJ39QCr6D/QromSxZP73DObfk6TEsnXxwyvYKJmL9VCBQVUL4aK
         lkVOEm2tD4iAfskMmi/y2fnrCVkD6x/OSmkm0YvSe6WwoXrvfG2w7YZSB4TE5KaGPMCE
         2dnpyeytqAJqAz0mS4fS+u+m5ASLs9RsMLmcafwQfKvtM3ktI1qKGhj2YuD0zUN64UHL
         2wXtdijGTbMswGnzOBoqfejKu0jKwwqhbEMaxud7wc6s/lmlxT6EvSjnOG0AXAb5vMor
         XVZe974y7PKZxAIYzEIaWt3XjUIC+Tjb9UU3n5fCxdPJ8DwUhoBWtYL6VwUyGKk78N/r
         zVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786138898; x=1786743698;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=poHNCFVAUnTfBbNRkHgPupZhpjqXlJdoVP2r/kOeEUY=;
        b=FtHmVqtrhXI2eH35f+JkU+f03nUNo5vAb6pU7xqAYRgEmrV9MN0oq6R8gpOOhjepdb
         cw0FGgGlR58zSLzDY4scgINcq1+lbS5tgO7qTcfeNP3+fvhzwYaat0DYofMOtuukCGU3
         +NaYRzy8ynXxe+LZezo7cfTmEQJMc6QAHZO4Z/1wvNzogRCO8LD22/IE/4yRs8am/Md3
         iZ4fyeg8T9tVRG5LyZ/P5pCYaMeIJt6TFuXbwXKKyetbxLpvKj89fp0KqI2Fhaa1bbom
         L88JIso7RrddrC+Ie+nJfxtCemLr0Cce+k6rHh27jTCQnTIyRnHK+diX3wm2gvJOyRz0
         xW1g==
X-Forwarded-Encrypted: i=1; AHgh+RoGoSnC2IGL43i8tpYBpwDdMeyOw43LxqeevGzMJHR/Lm7kBzPgnbsQntUjbvvR+QgKvrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXy6Yowu+3zrfiNG0xmSUdpDio4lrZMZHkWHbIJYTQNsnEuKsN
	2nMPeAG/YglUxCkRc9TLgFBXUPJw9V70aBOdr4+UGoWBhDiMCgxsxNNC7y77Bo5kqKDC23HmnwZ
	RVaPWyhPHW7ZkCJjab7No1zg1xX1z2+TT69VfDH94w1M0f0fDPCtFezQxP2aPrvgxiaP8O23ziN
	3H+gof4b4wPPSgv3BzDtiLzgsg8+cWityTHVoO
X-Gm-Gg: AR+sD13acFSRVGdtEPXknqlTZIU1HU2euLTYkw3C49wL8toux88QKQ+KNFeM5yBUERs
	IKKkWppcg+G5Lq2uv1r3hvW5Lan/VOb0XO2lz9p6tPHP+LZek8wPq7IqCbsRYfWAVgGRa+5XahD
	KzpZKbJM++vpBjk8RRW9c+FAVYn4qxfj9BXHthnPD+tFDbUreYqAI5FYc+2pHusGIuD2uMVY1Ra
	9q3KJRbWhr2/SbhNE8WA+Mhug/G/ijX/jPdCud1aJBEid0Q3E6qiqkvEqc=
X-Received: by 2002:a5d:4c89:0:b0:47f:86af:8fe7 with SMTP id ffacd0b85a97d-47fec6283d0mr31155626f8f.22.1786138898168;
        Fri, 07 Aug 2026 14:41:38 -0700 (PDT)
X-Received: by 2002:a5d:4c89:0:b0:47f:86af:8fe7 with SMTP id
 ffacd0b85a97d-47fec6283d0mr31155604f8f.22.1786138897829; Fri, 07 Aug 2026
 14:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807135327.2629594-1-pbonzini@redhat.com> <anYQsMnpS2kpYoqA@google.com>
In-Reply-To: <anYQsMnpS2kpYoqA@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 7 Aug 2026 23:41:25 +0200
X-Gm-Features: AUfX_mzCIi8IxDjupvaqynso0GuvqHaUAxbxIMUoB_zmt_dkX2K7kmyBztm9vFc
Message-ID: <CABgObfak2WM10cj4eQ0DejFQPjsK1ftjS-y2Ygr_gcPs=KyChg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM (mostly s390) fixes for Linux 7.2-rc7
To: Sean Christopherson <seanjc@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Il ven 7 ago 2026, 19:07 Sean Christopherson <seanjc@google.com> ha scritto:
> On Fri, Aug 07, 2026, Paolo Bonzini wrote:
> > - disable use of INVLPGA when NPT is enabled, because it doesn't seem
> >   to flush TLBs correctly
> >
> > Paolo Bonzini (3):
> >       KVM: SVM: make svm_flush_tlb_gva do a full asid flush if NPT enabled
>
> Why did this get rushed in?

I waited two weeks with the patch on the mailing list. It didn't (and
doesn't) seem like rushing in?

>   There was quite a bit of discussion, both on the
> code itself[1][2] and on the assessment that this appears to be hardware issue[3].
> IMO, neither of those discussions was resolved enough to merge the patch as-is.
>
> I can appreciate wanting to get a fix into stable ASAP, but we could have gone
> with a *much* simpler fix for stable@.  The bulk of this change is a performance
> optimization masquerading as a bug fix, and I'm not convinced it's actually
> optimizing anything meaningful, because SVM only queues the TLB flush, and that
> is super cheap.  E.g. the "we don't know why this is failing, let's smack it with
> a hammer" patch could have been:

It is true that the patch below is smaller and pretty much the same
for all practical purposes. I don't even think it's a matter for
stable vs. mainline, the patch is totally fine in both; maybe with a
comment about the performance being totally fine, since that is
different on Intel vs. AMD, but that's it.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 3057ca7051db..58bc4a1cb7a4 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4237,7 +4237,15 @@ static void svm_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva)
>  {
>         struct vcpu_svm *svm = to_svm(vcpu);
>
> -       invlpga(gva, svm->vmcb->control.asid);
> +       if (!npt_enabled) {
> +               invlpga(gva, svm->vmcb->control.asid);
> +               return;
> +       }
> +
> +       if (static_cpu_has(X86_FEATURE_FLUSHBYASID))
> +               svm->vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
> +       else
> +               svm->current_vmcb->asid_generation--;
>  }
>
>  static void svm_flush_tlb_guest(struct kvm_vcpu *vcpu)
>
> I don't care _that_ much about the code itself, though I still think the out-param
> is all kinds of ugly. I'm not at all ok with doing so silently
>
> and without what I would consider an honest attempt to address review feedback.

Sorry about that, but again - I waited two weeks and got no reply to
https://lore.kernel.org/all/CABgObfbDE+=ir_phPC+9sVYnNXur6dFx6oAfEGSnCbrOqFoyVA@mail.gmail.com/.
I consider two weeks of wait, on a review that so far had been
exclusively about taste, to *be* an honest attempt to gather the next
round of feedback (which never came).

If you had proposed the above small patch, for example, it would have
been a completely different thing. I would have taken your suggestion
immediately.

Paolo

>
> [1] https://lore.kernel.org/all/amPo-XdhFGIZquES@google.com
> [2] https://lore.kernel.org/all/CAO9r8zM=Mb=eTEFGF0G-POvwwbSr7e8SN6zcDp=GstzKtBKcow@mail.gmail.com
> [3] https://lore.kernel.org/all/CAO9r8zMopB=YKXs5pkQmPf9uHKE0P0XORcNbc60AWXTusuY3tg@mail.gmail.com
>

