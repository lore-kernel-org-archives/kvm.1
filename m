Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E5232E6BA
	for <kvm@vger.kernel.org>; Tue, 17 Feb 2026 23:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771371845; cv=none; b=GVpKkpntXDtK8lGhzqUT9CRfBOtI+yfLndDVLlT+BtwaZz/bP9ufUt+LS5r2/bM7cTVCFdHqSJOgGuAZ9P9tUZc1bnAhHHwx6A4YnHqeREIYkg9XxNBoLckBXfq3by75KlABVB9zA/GM00TdBJdGVH0rX1jSKx/iyFObGygeGi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771371845; c=relaxed/simple;
	bh=zgHp0rCJ6ISdDX7RasZjHOO2v40C+WfBpA3AMbfkTow=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FiVHfRs9ATA/zC3eHpuLYKpn2n0sOPzLQDl6YFs9TvHRRxjf51zrXXKlqGu4eWrhFOmNBxTAL6wL4vvvRnDza3MNrxiyWOqydicnfTA4BGUB2JYcZEZWUsKI7PdzGbdjKXIdWdKIbAuv+zx+ssIN+4pxvYuNNuLdFG/wSu5LAhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VmuYPTsg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VmuYPTsg"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a92a3f5de9so32401155ad.2
        for <kvm@vger.kernel.org>; Tue, 17 Feb 2026 15:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771371842; x=1771976642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5/aCNMwBAkSYiwoiX/QbH+a9MRbUxIDZiaFVfDQafN4=;
        b=VmuYPTsgPoDS86sxPc3UaNVd/ivXr+HUYf1uiRRtMu05iUZOSC+U0O1DEIQSSEX1nb
         yotX1ihBska6ouMLPewnKkCsY7jafTMI13v516OR+/adrOKEsq1U6Qfz9gZIXy0tOTYb
         0o4k/ck8SijTHZASzpF9+ZmRudkysYnNafSx2lfMh5PQnQFGkz0h/F6ZhbBJCEvtT8D7
         W7mgakuDqjNhSj2bPuKscjjJ87+KVDrRbbEfuFT63dL8N5FrvKWyCvtDKh7Ml3yrESKK
         sTa7F3+gbLv7dJGTwWREgBYQDgJOY2iaonzuD4C8bhUHKUFsNpwXPzyFIjR/OLAzyJRW
         Zkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771371842; x=1771976642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5/aCNMwBAkSYiwoiX/QbH+a9MRbUxIDZiaFVfDQafN4=;
        b=h+vFUNucDPu3GNMd3EPZcBI19/ai2WkReeMv4ePaWsXFT4wgPiqRaS0xUikGOvudFM
         sVHP075j96lPhmoScZldSqsc1iRbCkz/AkRMvS1jXiQW/hxSsDdyMJnWV4gInaqiQ+xh
         FHdFnq0Tk8wi4+no6++1B3iBXv4pgTYdVMEWz9myWOz/32qXaWmnXUkxbteOxQ5q6tKA
         Ai8mV/XJTGBklsZHvpL52zweANwbAIsL6ZxEJYB6tc/CVOJ5ZpVPvIrT5dl74fdANe8H
         3hPQgb9Y0iatshMf85UNFsdsBHm6ILZYReF+KnZhqVDyqPO1un39xmR5iF2tK0DZdyCZ
         Ei2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrx7txHwZwH5N6weuEllk5/81Dwa1guPgeUD25Id+EIpfaFmB1FvrbDkVfxGSag+Nnh0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBVX5qJXSy2oMWjO9R4zPduWvrOmbXSqqLOBMmh9LQ+fzTH52T
	O5IeMxpi4L6b6bVqDSwWRIcrcxLVMcnZYQz3XLXX4N8oG886X0xQ8J3RCoU/Hdgn+KT+9HCx6ta
	WGSVpdw==
X-Received: from plsm8.prod.google.com ([2002:a17:902:bb88:b0:2a1:36d4:7f2f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1ace:b0:2a9:62e6:ab11
 with SMTP id d9443c01a7336-2ad50ff301fmr202985ad.59.1771371842202; Tue, 17
 Feb 2026 15:44:02 -0800 (PST)
Date: Tue, 17 Feb 2026 15:44:01 -0800
In-Reply-To: <tpqwkctcbv47rxd2kutz3wk52klf332nnrf5bgtrpsaysfjpva@sj4blucyaftv>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260212155905.3448571-1-jmattson@google.com> <20260212155905.3448571-5-jmattson@google.com>
 <gqj4y6awen5dfxy32lbskcxw6xdv4xiiouycyftjacndjinhvp@7p4dtgdh6tjw>
 <aY9BPKhzgxo4UuHB@google.com> <CALMp9eR4ayj_gwsDQVH8pQvzqgEYVB6ExWp3aFgJXRWikLEikw@mail.gmail.com>
 <aY-jViitsLQm9B83@google.com> <CALMp9eTnXW9=0=+RxQjeXfA++UP3MX0LzXo5qwUP-dCCQjOLVQ@mail.gmail.com>
 <aZT5eldlkLpRm7OD@google.com> <tpqwkctcbv47rxd2kutz3wk52klf332nnrf5bgtrpsaysfjpva@sj4blucyaftv>
Message-ID: <aZT9QaJ6s2sSE3QR@google.com>
Subject: Re: [PATCH v4 4/8] KVM: x86: nSVM: Redirect IA32_PAT accesses to
 either hPAT or gPAT
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Feb 17, 2026, Yosry Ahmed wrote:
> > @@ -2838,16 +2876,7 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >  		msr_info->data = svm->msr_decfg;
> >  		break;
> >  	case MSR_IA32_CR_PAT:
> > -		/*
> > -		 * When nested NPT is enabled, L2 has a separate PAT from
> > -		 * L1.  Guest accesses to IA32_PAT while running L2 target
> > -		 * L2's gPAT; host-initiated accesses always target L1's
> > -		 * hPAT for backward and forward KVM_GET_MSRS compatibility
> > -		 * with older kernels.
> > -		 */
> > -		WARN_ON_ONCE(msr_info->host_initiated && vcpu->wants_to_run);
> > -		if (!msr_info->host_initiated && is_guest_mode(vcpu) &&
> > -		    nested_npt_enabled(svm))
> > +		if (svm_is_access_to_gpat(vcpu, msr_info->host_initiated))
> >  			msr_info->data = svm->nested.save.g_pat;
> >  		else
> >  			msr_info->data = vcpu->arch.pat;
> 
> I'd go a step further here and add svm_get_pat(), then this just
> becomes:
> 
> 	msr_info->data = svm_get_pat(vcpu, msr_info->host_initiated);
> 
> It's more consistent with svm_set_msr(), and completely abstracts the L1
> vs. L2 PAT logic with the helpers.

Either way works for me.
