Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD83338F640
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773336169; cv=none; b=PzcAqV5YL9PnCh1e+PwixtzK8yQPkrZL3En3Fq/Cr4vdFZQL/d+aSxTNTKVrdvIeBu125IQQCcrarjLsvFOOvOpGTwZauNs7w1H8ugGmWdEShZwL7GSWj4zjjIuij18W0zyT72+qyxzzVMY3/5JDo0jEPNoSXN9n3/PjGbQbZ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773336169; c=relaxed/simple;
	bh=nd7ONKTxYvVFe/CHCPdA2U3pDtZKosduY+U4q2UjfkI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p4ULhicjf2F8muJK1xF0GU4FQX2+2y1e8DU9zX69u8oSIt9UeGvHhaB0Ec9RBBtnJuQ8aZXElS/oeBWX6gBNPWuPziSXNRTUpEsxChiwLKP2lchpQfo1WnA/zUa0+FyfDMwbVuKvS+jkJ4b6qawWGs9evFNJKoH/fVhmdMEjxy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CRgRK6UB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CRgRK6UB"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae65d5cc57so83000465ad.2
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 10:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773336168; x=1773940968; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xjxs8Q+Kle/OrI1yxJVZC1ywPVtcBD3YLyfouBHRVtA=;
        b=CRgRK6UBBh9b1sDpRTrL7tDi/yJQ7XwlKhCsADV//cw5LbaNWXMb5VT1FAaWNo0BAO
         YRD0i1Jrqrs3pccgXDLSgwcR+tLsWj/q52svzOmhKpeTV7tf4DSiUByqlvCM4fEJwec+
         eiOYGdEibsZ3zF9uCc0roDpMMQjPpfr0sLo+uvzl5QzsCcXAB56E6N+HYFtjchTl6cje
         E4d5y4YXniv0vL5JKXFkYJXhj1ZIPCYrHGBmVTu2XOOQcxGHK3htB4VAOcwjz09tde3T
         nIAO3uPU/PagiWikk2zzND2qCcegCXSCER09Hz+4HtSUO3e9rKR9k0d6nLrgAG5RUNfW
         ffUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773336168; x=1773940968;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xjxs8Q+Kle/OrI1yxJVZC1ywPVtcBD3YLyfouBHRVtA=;
        b=LeO8HYPEx/ddl8IXXRty8iygOy/nxclyycz+VlykjALLiUwqiVQhGaXjVW2R7pEDdu
         GvXMOyhiGh9WX5tJ7tydqaM1i8gixmt+gBHen1yT2qilogmCDWam84B56w5BdMqfHtqp
         XbB6KdOXQDdvbL44XJZyMtI4bq4Tmc+2hZAaug8AQfbSsl5ERtY9H7g0Ht64btxLwkoY
         CSlwW6+6oLkzVCNWXGRq5MI4SqzyE0YcN7sDT6kkokQ6JumSKhw/Uz0nq0vDl5VcxI3L
         JKKH5XVhbrw5XmVn1DgbiGdGT24ut66upM0O5KDgdqQwts+177L9TtwwtJLA6ys4JrQ3
         j/4A==
X-Forwarded-Encrypted: i=1; AJvYcCVhyPbq7VM6JF2RXOTjJqsB61Gy2uZ898h5ZEqIGNC455SOMgNMVUvt3g214wx+pUk+/bk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo5yHY4Kuc0v70nWMwzyS5tt6orykXX/k+Zpkf0mUWW+3CJOeM
	1PDOm6FYH9w4WLVG+O+uBPL+06g6oJapUwNpDYpryE9X3aEu/9o5N6ci5TLGxF/OCJBVjCRMcPk
	WD791zQ==
X-Received: from plbjx5.prod.google.com ([2002:a17:903:1385:b0:2ae:6338:73ca])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c947:b0:2ae:588a:f3e5
 with SMTP id d9443c01a7336-2aecaaacbddmr2432255ad.30.1773336167617; Thu, 12
 Mar 2026 10:22:47 -0700 (PDT)
Date: Thu, 12 Mar 2026 10:22:46 -0700
In-Reply-To: <abLy7cEDz7VlWtWS@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260123090304.32286-1-jiangshanlai@gmail.com>
 <20260123090304.32286-2-jiangshanlai@gmail.com> <abLy7cEDz7VlWtWS@google.com>
Message-ID: <abL2Zuy_gOQin-7w@google.com>
Subject: Re: [PATCH 2/2] KVM: x86/mmu: KVM: x86/mmu: Skip unsync when large
 pages are allowed
From: Sean Christopherson <seanjc@google.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 12, 2026, Sean Christopherson wrote:
> On Fri, Jan 23, 2026, Lai Jiangshan wrote:
> This is what I have locally, please holler if you object to landing the code
> after the write-tracked check.
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 363967a17069..3d0e0c1b5332 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2940,6 +2940,15 @@ int mmu_try_to_unsync_pages(struct kvm *kvm, const struct kvm_memory_slot *slot,
>         if (kvm_gfn_is_write_tracked(kvm, slot, gfn))
>                 return -EPERM;
>  
> +       /*
> +        * Only 4KiB mappings can become unsync, and KVM disallows hugepages
> +        * for unsync gfns.  Upper-level gPTEs (leaf or non-leaf) are always
> +        * write-protected (see above), thus if the gfn can be mapped with a
> +        * hugepage and isn't write-tracked, it can't be unsync.

Gah, I swapped the ordering of who is doing what.  The comment should be this:

	/*
	 * Only 4KiB mappings can become unsync, and KVM disallows hugepages
	 * when accounting 4KiB shadow pages.  Upper-level gPTEs are always
	 * write-protected (see above), thus if the gfn can be mapped with a
	 * hugepage and isn't write-tracked, it can't have a shadow page.
	 */
	if (!lpage_info_slot(gfn, slot, PG_LEVEL_2M)->disallow_lpage)
		return 0;

> +        */
> +       if (!lpage_info_slot(gfn, slot, PG_LEVEL_2M)->disallow_lpage)
> +               return 0;
> +
>         /*
>          * The page is not write-tracked, mark existing shadow pages unsync
>          * unless KVM is synchronizing an unsync SP.  In that case, KVM must
> 
> 
> >  	/*
> >  	 * Force write-protection if the page is being tracked.  Note, the page
> >  	 * track machinery is used to write-protect upper-level shadow pages,
> > -- 
> > 2.19.1.6.gb485710b
> > 
