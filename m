Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677DC47D937
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 23:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032762; cv=none; b=MWag/Ye0PiayKCbJwr2BoQkdJlyUs6S54cuVxfCd6BgxD7vv9Kekc3tIoR7Z0yxzhHYYsd8ufCG1nlMOlI42foCo2C2PWA4Eu1IXs6UsOScILPixBfKKRLLx8ta/+slFEkCVxJAzXcpw8DUeGRXkDVlTSVixe6U+p61tCx6AZI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032762; c=relaxed/simple;
	bh=STZzVz0pkaGk2shzn2nipksul0mqw99WH6U33bUJnZk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UBmUJTUY0fAugBQd7xeag3Bz0/FBG1gmh/X2Jm8REW9DyHVX6dxq4oQ/sc747CkBCZaA0Gp1DPU+gNwkw4aASWE/Tin7jwAVzsiXH1L1xs3bdYtQK/UCw90Mp2V5smUvygVXSWLvQsHKY/Lx7IN62WRbtG1QEf6W6tWdoB0SuTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iX6yruc0; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iX6yruc0"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2dd753a52bbso64535035ad.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 16:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790032759; x=1790637559; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vbq37V4/JM34UeUx42zs7YQRnWr7XXAPtc3qiTGZy/c=;
        b=iX6yruc0/Zunx4yMp7cKlak5KQF8MueDY21XlK1grgAqsI9NZ935xA4dXD8P67MhxO
         R7sMv+/IXLkjZfvag5etjRn/YD1B1Cqexpjw3wFrOpNg2XM+ImfvzpUuXuJq9tL0Pzd1
         cfyBpd7MPtqEqnzqB8o6gqsMM7kvA2w/9zevlS/c63Ay9qZoC8CWw0sp8+Nr9ZQRK+CQ
         hUvWxoKoPrmynE5oAXo7Ab8zL41Xw6mtZ0E4WwDGcgG7l7UL7O/35d0DTY6soZ5wwatJ
         UIxA5nzSiRsEhLPE2Ixid/OryMkQfyYSVdTXDHqG08bxeuSav1GWAI8SQ2xJ+FuUaytI
         awxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790032759; x=1790637559;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vbq37V4/JM34UeUx42zs7YQRnWr7XXAPtc3qiTGZy/c=;
        b=nNkaWDJS+Cz5UQjyJJDcfAGHTXvbnnSVa00BGRLRR86N+o7dEINAAi5F3KvhOELOOd
         t5i3uT00Wb5PMlsH5w7TRFYj/Syv2SjVS8ZzBPEVCNpyohQpiKxcZjgbdGQGpoq+j+gb
         vaWdK+VbvTVwAAPmCrlioyF5pdHIz0Jz8NDSXBR1sHLD1jRabpJAfApLBjHQeDwj5sb/
         8Jo/12qtNA3NGwUSdoWrqbDp/WKn/V9Yo6HwBOxl0eS7LkWphH7NSAChOBBGzYPD1Lsf
         IMk/00opdx50qGsGbj++oMKe09plQf1iGv9Ylf447HHNmy8Nqaio3bpMzTxI11cWK5LP
         rU+w==
X-Forwarded-Encrypted: i=1; AKwUvBzQsjiHw6TK3SDTi5912s5V3LqssCaVQKKHyUhgoDPuVHQmreTYALnrjDyYTUVWkkEAoZM=@vger.kernel.org
X-Gm-Message-State: AFuF++laXgB1SqtHxi41YDNuobMzej7vd3HR0NBi6eT6yFB8j2wpdbdj
	5PpaMqxs1HN/Dc0g8A8GC8S6xCV7mju83ZJQH05wAY3byvshHCJwFp5GYJjPBDxh40cSFE59ya3
	lnNNOBQ==
X-Received: from plbg17.prod.google.com ([2002:a17:902:d1d1:b0:2dd:684b:bcd5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc84:b0:2dd:c053:a6f3
 with SMTP id d9443c01a7336-2ddc053a789mr125601235ad.37.1790032758700; Mon, 21
 Sep 2026 16:19:18 -0700 (PDT)
Date: Mon, 21 Sep 2026 16:19:17 -0700
In-Reply-To: <de659c43-4121-483b-acbd-e1c4f89e4e80@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aqvtG90zWq6SkU8L@google.com> <3f97caf660cbe460b8bbaf3f2a72e4b6a3ea83d9.camel@intel.com>
 <aqxGN2Zc8sOl2RKx@google.com> <906d0cb6515b396f4e9d74f1d546c902ea3ce49a.camel@intel.com>
 <aqyAED5ZK48eEZtq@google.com> <56a61983c03806120e607dfd1e1b7c9046c1f54b.camel@intel.com>
 <aq048KmPN5WPQ4sQ@google.com> <7d40bcd97e01390a345ce1dbe26264e7b064a619.camel@intel.com>
 <aq2t5wJGLtsltMza@google.com> <de659c43-4121-483b-acbd-e1c4f89e4e80@intel.com>
Message-ID: <arG7delLjerkKbYQ@google.com>
Subject: Re: TDG quote analysis
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, Yilun Xu <yilun.xu@intel.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, Binbin Wu <binbin.wu@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, "kas@kernel.org" <kas@kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Peter Fang <peter.fang@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 21, 2026, Dave Hansen wrote:
> On 9/18/26 14:32, Sean Christopherson wrote:
> > By creating these system-wide thread pools, TDX has effectively created a bizarre
> > M:N scheduling problem, *and* introduced a completely avoidable noisy-neighbor
> > problem.
> 
> To be honest, I just want to chop all of the complexity out of this.
> 
> I want to assume that the TDX module can do one quote at a time. If that
> quote takes too long, software kills it and lets the next guy do a quote.
> 
> I don't even want to know that the TDX module *can* have 1 or 10 or 100
> quoting threads. I just want one which I can make sane rules around
> because 1 is *FINE*.

I'm not remotely convinced one per system is fine.  I'm all for one per VM, but
I'm pretty sure the SEAMCALL alone will have a measurable performance impact,
especially when factoring in that it will require a VMCS shootdown to do VMCLEAR
on the previous pCPU.  Mix in a few (tens of?) thousand more cycles, and any use
case that's trying to boot a decent number of TDX guests in parallel will be sad.
