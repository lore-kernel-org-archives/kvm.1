Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95C23F54DD
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786989963; cv=none; b=FOK/h0PafPN1ek6KRrcOzxHaiksy+8R8sbpShHmm4T2zNDxqHrqXBsQzvBRqOgjkQRCnywVUYTjRFHJHsTk8ExTkny8XcP/3PsPUkRief/qwsZMcz2ImtML57o51KztwdWsoU5N10WUTQZ2R/9ju5nl4j2aXbcgr5pMvL29Q6A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786989963; c=relaxed/simple;
	bh=FGUMDOgcOkl98gJszN7Sm/3/hHjQkI7CnxUDvMb9QvU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QARxHYJWDAtxvp7VP/gGhIazvnHdKp36bwp/J0m8IoyTpwC43B230PruUgw5hQ7fKM13uZ7xQLVNCzQXq/67tg7IvBL44R4mkhTOhpVDglAQEFvH8bMOz2xlW3DRYY6nfvmpykjRhW0BkpBMAUsmhfABATBuuVv21udcEfDc5+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ephlr/P2; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ephlr/P2"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8484ba00601so3748514b3a.1
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 11:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786989961; x=1787594761; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3wgkmOaK7dMi31fjCigxw9/SOFHhN8te1ABKHYJcTbc=;
        b=Ephlr/P2slPGeOeBRs2MA6piBAKDVsfl/J/8xaKl0iTg/UaHpN64BCnkBTu5UZOdcn
         4G1lSvtL6YJjmgxCN/OT7cmT1HmTzvQ271JbNX8ZccmniMlw20cjEI5Z9t854Hq+jBN8
         stfGz9hPP+3Tg44a9v9OZHSoTqVKMaURmVmrAd1Xcqz7tmzTI5koIRxOzyyyaiucBhxS
         FMdvfhgyjS/kGha3T4CkelPYAFJMlDgMnYJznXrzP37vVMRO94UMJMXX5CmRSmPNGw8q
         ssb75ppdRspOaYXlWDojd7zAkKXXoiWJmbg5zRl7aH7vBZ9QhAqqG6GEi7nZE5HGgwz9
         88rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786989961; x=1787594761;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3wgkmOaK7dMi31fjCigxw9/SOFHhN8te1ABKHYJcTbc=;
        b=Cc/PvFN9HosLGhjC/gMtdfWTmzCfGSRha+rKTOZQ70YjTD/2/SEKkf4JJ+CFacFPnD
         ++6f+2+prc7tmfHUoeZfXTTYqOQymQ7G6acJIF3oKE/4U3ETVDCUfxegJdazUCvEl8nA
         wkBfqJoYs8Jffda2y/NaTTlqj6OE4AO2oot1lW5jdY+4ryUJ/v/3PgpJ1KhaXi9Ng0nt
         tOKy9219um8xa85nbZOW2N+sUwTgSJ0/hDcNp45P2fqOI1c0VxvcGWOZBSYHSHBPQloU
         Lgks6c+jIEmUh+jP8W2xZmls6gtFSe39n0B+AYDFBbMv7EyGzO8T/61A5vzu+4H7kWTf
         oR+Q==
X-Forwarded-Encrypted: i=1; AHgh+RpqhEdylnXUjeI+3H1XfdZwADTQijv6FLFn7U64j+qKLC+ME3rB2mhZTsqrD4G754WX9DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBFPZebmXnIgEC8ptmOmO/GLkOPWcdYXAWBGWYqT3LSOjk/Kaq
	v/1ikhQnWoTSgiGhv8qLbVYrb8Xl6iNoBXagok6Jc8pput45oXIGbb/YRdddqTGURHDRLIHIBNP
	m1W+eKQ==
X-Received: from pfwz3.prod.google.com ([2002:a05:6a00:1d83:b0:84a:6b32:7768])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:14ca:b0:84e:216d:7e4e
 with SMTP id d2e1a72fcca58-84fde14ffb3mr21192194b3a.1.1786989960782; Mon, 17
 Aug 2026 11:06:00 -0700 (PDT)
Date: Mon, 17 Aug 2026 11:06:00 -0700
In-Reply-To: <1dcbf1b2-dc89-4624-b98e-d34f40558cfb@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812080229.2481439-1-xiaoyao.li@intel.com>
 <20260812080229.2481439-5-xiaoyao.li@intel.com> <868c0d3c792d789347c767031612977c31cc227f.camel@intel.com>
 <1cf47118-2a19-44d5-ab74-b4c7ffa8890c@intel.com> <an3YFiDbjRs3PUwn@google.com>
 <77567574-d26c-4d2c-b5ce-5da28a7178d6@intel.com> <an84cenJjf7EqhVM@google.com>
 <1dcbf1b2-dc89-4624-b98e-d34f40558cfb@intel.com>
Message-ID: <aoNNiAbZUbkWoZ6t@google.com>
Subject: Re: [PATCH v3 4/4] KVM: TDX: Enable Bus Lock VM exit
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "kas@kernel.org" <kas@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nik.borisov@suse.com" <nik.borisov@suse.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, Aug 15, 2026, Xiaoyao Li wrote:
> On 8/14/2026 11:46 PM, Sean Christopherson wrote:
> > On Fri, Aug 14, 2026, Xiaoyao Li wrote:
> > > On 8/13/2026 10:43 PM, Sean Christopherson wrote:
> > > > On Thu, Aug 13, 2026, Xiaoyao Li wrote:
> > > > > On 8/13/2026 6:58 AM, Edgecombe, Rick P wrote:
> > 
> > ...
> > 
> > > > The more I look at this, the more I'm against shoving garbage into vt->exit_reasons.
> > > > With tdx_is_exit_reason_valid(), this is trivially easy to handle, *and* explicitly
> > > > captures the logic instead of subtly rerouting KVM away from meaningful handling.
> > > 
> > > tdx_is_exit_reason_valid() doesn't work unless we update the vp_enter_ret to
> > > one that isn't one of the status code with valid Exit Reason. See below.
> > 
> > Correct.
> > 
> > > About the idea, isn't the purpose of setting the Exit Reason to a synthesized
> > > one is to avoid the undefined Exit Reason causing false-positives when it
> > > happens to match one of the existing ones?
> > 
> > Yes.  The nuance is that I'm against clobbering the *full* exit reason.  I am
> > not against setting exit_reason.basic to something like EXIT_REASON_INVALID_STATE.
> 
> I'm not sure why you are not OK with setting the bit[31:16] to 0 ...

I'm all for that.  I'm against setting them to 1, which is what using -1u does.

Ah, I'm guessing my use of "clobbering" is confusing.  I was mentally viewing
setting them to '1' as clobbering, versus setting them to '0' as "doing the right
thing.

E.g. the VM-Exit (that didn't happen) wasn't due to a failed guest consistency
check; it certainly wasn't an SMI from VMX Root, nor was an MTF pending at the
time of the SMI that didn't happen; the guest wasn't in enclave mode; there was
no concident bus lock; all other bits are reserved to zero.

Sorry, I should have clarified that writing the full exit reason is ok, but setting
arbitrary bits in a way that isn't consistent with reality is not.
