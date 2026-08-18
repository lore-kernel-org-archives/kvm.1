Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E720847B413
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070473; cv=none; b=B9KQ0GRPiD6fbaXDPajhQF7zzkmLcqJyLpzddVr/d7jYc2F/YSr4kevGPtgx2PEQ27AiR50iB6uu+IVmieQc1XQGKKr/vmm+fUTPaU87lI1SGCRDxk70NsEbPPkunHJTx2Qug07I8BAtiE7uKwRc7r9ITg8nqwjWUvLBCJS/gKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070473; c=relaxed/simple;
	bh=XiZDdwxdghUmr9SIr01cBJWYzhA9RXek8KYVaap4MN4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uiyoItOwihI61lxb93hunjn9I6O7YDYwhMacuFw0Onkn5GTUIrCZsY18bfCXd1g8h837Uuh7Kya/h/1lTT8NUQ7M6c6rrVJIIYGZPgLokpZ3cLvzRZWrbONvfbrxYkv7vNFc4HzzOiWwnYZkEUM57AyT7Iyqi9TOJE5epZdJRFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pIsd84Po; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pIsd84Po"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccb6823efcso315075ad.0
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 09:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787070471; x=1787675271; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nmr600BUwpqEtuz+Dx2wuthgVpiG96H1E6Ankz5Sdqc=;
        b=pIsd84PolIAWNBI2+z5NfC+FxoPTPBromw08HbgE5D8RPwqcFadVPQyeXFpuxhHh6t
         Hno+DdmgbHkN9XHDq7G3FI2IJX4pOIc4g4uhfg7mSNHRXr7pNd5c9j8Qk7hdyDkOm80Z
         ZCdnzrfWEa1hr4u9CT25zcgOzVO7qHcuCJDj5Dv9riPGwjAY/qjvkkseMhpQTbyvdcqC
         Ay8w0C9YtBdllhYUbPEAqbP39Q2iZKEsU/GwGEknYQFhfqpEFbnt7WDzqY7maCBWGfiW
         MUkxouFNpzSmNRA2s/V5x7Zk+0EegLWlCac6iDHf7GHa5RTxmbH27hTAbF2IpnWf90EQ
         1K2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787070471; x=1787675271;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nmr600BUwpqEtuz+Dx2wuthgVpiG96H1E6Ankz5Sdqc=;
        b=jG9/HCvidNHUgIHK2hPsDDpEUKIJbn1xdpUOlW8znDcC7s0chMtUe54yRXYA4F6kpY
         UU2p4uj6tJxVDWrye+GpgrbkiWbo0monecOZxkdGWcubQrOgsxndZ54AsxCGK9mAS2qH
         vC9Jz2ug0elvJi1dHf7ljCHcWL4k+NphHhzdD/RhsaSCVRTX+ZfM8jioiyUknuvsv9Fp
         H6qH/Kwsmuh3tPca2xCVDfMZdltGIO5FkIuFxtDkHigxjgLTu4zy08/Y0k+34t4TQqte
         QZQb6rJmTTjwn5406UnHBpv73CNIjQnNqhviBm7hfEB8PVZ6m4KELVPgXqd55+PM1uQl
         rHEQ==
X-Gm-Message-State: AOJu0YyniNvQ+LpPn9IJn5LuIudI/R9iulktjz/3omCvVdjNr2XgPLUz
	h2bmQ2z0WPI23N5b9oeqyUUNFPFJTtSAtU8VMLvIz47bkzcC2yMilyCMnvR/zsLvhQpGAmE03wu
	7wnZxRQ==
X-Received: from pldd1.prod.google.com ([2002:a17:902:c181:b0:2ce:fa2c:7de3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e943:b0:2d5:d9c2:bbe0
 with SMTP id d9443c01a7336-2d5d9c2d7c1mr101010605ad.4.1787070471132; Tue, 18
 Aug 2026 09:27:51 -0700 (PDT)
Date: Tue, 18 Aug 2026 09:27:50 -0700
In-Reply-To: <8d069fe1-a5b6-4a86-9604-26aebe2dc243@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260803170825.925561-4-hisamshar@gmail.com> <20260817220457.554823-3-hisamshar@gmail.com>
 <aoOKMeua-cNeTxXT@google.com> <8d069fe1-a5b6-4a86-9604-26aebe2dc243@gmail.com>
Message-ID: <aoSIBnFfy4osa6wt@google.com>
Subject: Re: [PATCH v2] KVM: selftests: Replace ulong with unsigned long
From: Sean Christopherson <seanjc@google.com>
To: Hisam Mehboob <hisamshar@gmail.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 18, 2026, Hisam Mehboob wrote:
> On 8/18/26 03:24, Sean Christopherson wrote:
> > On Tue, Aug 18, 2026, Hisam Mehboob wrote:
> > > Gentle ping on this patch; it has been on the list since Aug 3 without
> > > any comments.
> > 
> > Patience, please.  This is on my list of things to grab for 7.4.  You posted right
> > at the end of a cycle, shortly before the merge window, and the code in question
> > has existed for years, i.e. it didn't seem urgent enough to squeeze into 7.3.
> > 
> > If this is the very last thing needed to unblock musl builds of KVM selftests,
> > than that changes things, but IIRC there are other "fix selftests builds with musl"
> > patches floating around.
> 
> No, this isn't the last blocker. I verified with musl-gcc on x86_64:
> with only this patch applied, the build still fails in steal_time.c on
> pthread_attr_setaffinity_np() -- it also needs your task-pinning fix
> ("KVM: selftests: Use KVM's task pinning APIs in steal_time", which I
> resent). With both applied, the musl build passes.

Oh, so on top of "https://github.com/kvm-x86/linux.git next", this *is* the last
blocker?  If so, then I'll grab this for 7.3.
