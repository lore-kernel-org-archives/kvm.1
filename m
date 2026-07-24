Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A5348381E
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 23:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784937062; cv=none; b=mph4w2LBRyQ9PslkjOmeLDHDond5w7HVJ5aWfRXEve0F2otg6I3wjDRao/hNLkqug1cQ2G07Rgml+4MYJa33ANrX6G41KRJTdCPQYjlDtQgyMkcVRnWdRnQCTXwJdoznSITsIUXyRvkffkqrE+B6B1e0Teq/FNJ+oImbSWNJnVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784937062; c=relaxed/simple;
	bh=0yhKEvcABImILaML5hPpaUlXQ/XTg6t0VugpVVscyzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czsnfZiAbTsX1oXvxOesLcVpIE/WMvksOpF/F+rng3j/f2Rd6v4AzRH1Kh0qnNcJL+BLIBRCSut5mQoOJJ7E8sXfrFevYqt3tlUyMmdip7XL/q4fFMB4Z6I6owEGp1YAsYNdAZHAJgdmV0Ueq5S2TJdIAVL995GMqot2OxsbLBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsRMiknv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsRMiknv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4621F000E9
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 23:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784937060;
	bh=KtE9VLSNvuEREWRPqv7QEz3fPBljpV8zGdiVoL1JcRY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JsRMiknvC+8CuFaQVl2Pq/LK2OCOPFfxHbe/PRNq2NZEnh8DENKOOW/oKtvrSDwzh
	 dWtN/xF6lQ7n1JeKy9ZUhVITH5wGlHJGUEqF8jLdhkKVzGPuiDwAFgGFlwQcbsuXIq
	 M8UI297SSmY4OX1Zi8PQh+BXB0toamYDRwLhuby8Vc5CgERr8RU84TR+nsroQjnsHq
	 UXckslVuzBFXn+1p78AWEkbkJDPdQfamKdjNHDE3EWYDL7DOsa8+oFQ3Ne8ApKFw8o
	 mC+s+KwSbTzBB9FQ/CZ6B92kewqL1lx5i4WBIBPkjRO5Gv4OMuILyGxnmNozIXs6SU
	 I3iyKC3mV0kcg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1c50c1e29bso146031166b.3
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 16:51:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrmbP3j9DmUZkgaWjVXCPcyiuN3p4aYS/5hrr2vKvT9ieQn1XOo9I+bAiSzQqjss9fLSZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG8PnaHGpKMek5lGY4258PQd6xGYsTdgzDSXU5OEXBLhrl/9zW
	mF/duuKdTbYH7+n1WydZdxihSQKGhSKz3gVfZweJ9fvDVF8cl6Q7n5EVXTqTl9ff27mqnd1HIXe
	wFuVJ/fxfMFkFesdyyCqWB99fVwtKCRk=
X-Received: by 2002:a17:907:72cb:b0:c16:26c7:6ba8 with SMTP id
 a640c23a62f3a-c1f1ea08253mr14987666b.6.1784937059431; Fri, 24 Jul 2026
 16:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723094419.630204-1-pbonzini@redhat.com> <CAO9r8zM=Mb=eTEFGF0G-POvwwbSr7e8SN6zcDp=GstzKtBKcow@mail.gmail.com>
In-Reply-To: <CAO9r8zM=Mb=eTEFGF0G-POvwwbSr7e8SN6zcDp=GstzKtBKcow@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 24 Jul 2026 16:50:48 -0700
X-Gmail-Original-Message-ID: <CAO9r8zODKgCcjTBK=P6BuXBBZRoOAFMeRJU8BmkWL-BCX2LoBw@mail.gmail.com>
X-Gm-Features: AUfX_mzwlgwnPAYJMS2YqXH5qth-U64mcL7WzQZMw4IPiz8nbuZyfHH-hwxbfU8
Message-ID: <CAO9r8zODKgCcjTBK=P6BuXBBZRoOAFMeRJU8BmkWL-BCX2LoBw@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: make svm_flush_tlb_gva do a full asid flush if
 NPT enabled
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Alexander Lougovski <alougovsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"

> I also love Sean's idea, I think it's good to harden against this by
> nullifying flush_tlb_gva, and maybe add a helper that does the
> fallback:
>
> static void kvm_vcpu_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva)
> {
>        if (kvm_x86_ops.flush_tlb_gva)
>               kvm_x86_call(flush_tlb_gva)(vcpu, addr);
>        else
>               kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
> }
>
> Hmm actually we check KVM_REQ_TLB_FLUSH_GUEST before
> KVM_REQ_HV_TLB_FLUSH, so maybe just call kvm_vcpu_flush_tlb_guest()
> directly for the fallback:
>
> static void kvm_vcpu_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva)
> {
>        if (kvm_x86_ops.flush_tlb_gva)
>               kvm_x86_call(flush_tlb_gva)(vcpu, addr);
>        else
>               kvm_vcpu_flush_tlb_guest(vcpu);
> }
>
> And if we go this route, I think we can key off the presence of
> flush_tlb_gva in kvm_hv_vcpu_flush_tlb() instead of checking for an
> AMD CPU. We can probably break it down into a stable-friendly fix that
> just jumps to out_flush_all on AMD CPUs, then the hardening on top.

Although it could be less crud if we just made svm_flush_tlb_gva() do
the fallback. kvm_hv_vcpu_flush_tlb() would need to key-off AMD CPU
though instead of the presence of flush_tlb_gva. Pick your poison, I
guess.
