Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C601184
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 00:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786580088; cv=none; b=Wn5pcQZJtLlIxanLl9H4ABGO6FNbBmwSxJO59iClIW85/NT+9q23hwgcxmkW5fUmV3gI9AbsYd8oHSkN2To+iSXCq21PrRO4D/Y6WOXzp1Za4Q3/pzOQIdvWyQWcX5anY9GH9tzlM/7RgXinFsGJugAiASYP5a1wJLyubWqNlYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786580088; c=relaxed/simple;
	bh=OZjj7SWGU1Ekx4pavCx66iB/CiMgJpABLIy0OyPCF1g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GR4jf2k2/K7YFYdvs67myRBcyghw6yYdxZ/xWf6Q3hhWLER7oeQfhY0wilQWlzKAFR7pNcqs8FichUkM1VpcCcOiU4vuhV2iZsfcNr0BoFlyFh+Ik6axlB1S+b8R7GhddymZoOEZ+Ogy3DhuD2KUtAu9LUKe2s+kFDlVEo4OKFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JKjJ7Giv; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JKjJ7Giv"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8488ac68185so228794b3a.2
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 17:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786580086; x=1787184886; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GAm9CE86Y5LnZb71GqWeHyDQ4XOCTPq/X6e2OTsWPAs=;
        b=JKjJ7GivBz3b8fz3eUzHV7ryHdGbjiLJnmU2fnHMl/ktI5CAIqFMV1S5l0/9fGge+C
         kX7bB2Dv5vxQo2KJvMDir6wssH/byGDBozcyh/G2RENHqm9sXHbCYE/CFRKHlcXSdxS8
         eN92O76al1IxsedkbEcj+uTJtbstv6aCJiL/u9PykNzbSLfXaGC4qi10qJYdXEFs9N0t
         hcOm5EogA6RsqdpDY+r57u9YaJ2Yha6sttEb8SAQBlS70pxSljL6EMCEoLSKLnUKa22b
         w0dln2wcdiU6RUz0z9KuScRP68BbOl1ms39ScL79CUCiVgFpPMMebB67YI3iYwnbQHGc
         6mYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786580086; x=1787184886;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GAm9CE86Y5LnZb71GqWeHyDQ4XOCTPq/X6e2OTsWPAs=;
        b=a/UBw8XwTRglapNN3WSBZr2qUIKl8iRDUWUL8XIvYbKOQtASUDoHGCWFXKjdR787IF
         PHAX1RI/yvLsJN0r1nli/YqsHy1ass0hcVSn5ToRH4Cv2S0LFmT2cN3HxNePy5IGfTOd
         eOFN/rBrQyBdlTQuU2UfN+TAg/GjKN2fdjdNpqKo3CnCHHPR9ogaHXSuOWeQnSYmDA78
         seXeyr8vdURz4jxzzTXrTiR3RPtcXP0HYv3P41giWV2tNo4H8xLhDDDL3mddVnmbIir/
         7X3s2qhY7Ebue7gS+u9GpKKD0UDJ1YjJOC1TU1sSmjQZFRACEFe09/6VMVEmPVhyNA6p
         Gb2g==
X-Forwarded-Encrypted: i=1; AHgh+Ro8VkZPy/kgZ3ed9dsvc6UQnAPmoBXOnEjVXBlh5OZV1l6498TkcSwCRbWp0rrRsr5tZmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWE2UjtQofMtAWvIwTOuuykZirXqqEyHaN+Zk2B6dbEHtCvY11
	xcBKNN7uQ4r3LH5obJNP8lmT4KhvGND20/6yc+4rZVlNiHDuLFKgiSilSDQ8+0mRDWR+jdU7IKJ
	mXsIKpQ==
X-Received: from pfnv20.prod.google.com ([2002:aa7:8514:0:b0:84b:57b7:60c5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6017:b0:848:30c3:45d6
 with SMTP id d2e1a72fcca58-84fc74f9107mr1811925b3a.14.1786580086327; Wed, 12
 Aug 2026 17:14:46 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:14:45 -0700
In-Reply-To: <8b05ead1-ef2c-472f-a613-bcd1a65b64e1@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812080229.2481439-1-xiaoyao.li@intel.com>
 <20260812080229.2481439-4-xiaoyao.li@intel.com> <20260812082306.11E8B1F000E9@smtp.kernel.org>
 <8b05ead1-ef2c-472f-a613-bcd1a65b64e1@intel.com>
Message-ID: <an0MdQKMHclUjW9r@google.com>
Subject: Re: [PATCH v3 3/4] KVM: TDX: Don't assume exit_reason[31:16] as all-0
 in tdx_to_vmx_exit_reason()
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: sashiko-reviews@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 12, 2026, Xiaoyao Li wrote:
> On 8/12/2026 4:23 PM, sashiko-bot@kernel.org wrote:
> > > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> > When the basic exit reason is set to TDX_INVALID_EXIT_REASON here, but upper
> > bits like Bus Lock are preserved in exit_reason.full, does this break
> > tdx_get_exit_info()?
> > 
> > In tdx_get_exit_info(), it evaluates against the full 32-bit exit reason:
> > 
> >      *reason = tdx->vt.exit_reason.full;
> >      if (*reason != TDX_INVALID_EXIT_REASON) {
> >          *info1 = vmx_get_exit_qual(vcpu);
> >          ...
> > 
> > Since TDX_INVALID_EXIT_REASON is the 16-bit 0xFFFF, this check will pass if
> > any upper bits are set, even if the basic reason was marked invalid,
> > incorrectly exposing meaningless hardware state.
> 
> Oh, I should have called it out it's intentional to check the full 32 bits
> Exit Reason instead of checking the lower 16 bits .basic field as what it
> did in the v2.

Please wait for discussion to die down before sending new versions.  You sent
this version literally the same day you responded to some of my comments on v2.
Now the discussion is spread across different mail threads and I'm having to
piece the converation together.

In short, spamming versions makes it harder to review, and thus slows the process
down; it doesn't speed things up.
