Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C214DD6F5
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 21:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286895; cv=none; b=XoZzS7hpeK/wHZNBO7YVJUm7kbW7bINLwjjNU0gxUHVsL1YPMHhtZV02wtFjmEfDNsYFdmxkhdK/TSYJ4VMwuepnL0cxZXBxryBX6TvmcOwHx1RpuDnGydzN40YHg0x51tbVHAA+nZ1FcFwDVcHCGvjTvUVBxb9i+mW30PBXJtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286895; c=relaxed/simple;
	bh=OQX9CvPDhGR2shu/TIA+wjRgAwE7A9IPpcBu1ixJB7I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M2p8SZxxRcud0HyStZbOwtZWSywhIZOFaFS6E9DJjaw+OqZtTvj3GiL2I1411BtR2jAccgU9zQjuqoqzxrehNI76XSjR1Aq5gfjr34/nA3QmvlqqPW5liK2jnPN+CuF9VUUER5agvzliCfJb3pfUGRsdHGAEwQrG3O+DDURZQmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WLvbMIDu; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WLvbMIDu"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so119621a12.0
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 14:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790286893; x=1790891693; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sUjYBLPEX7UvUbeFt5DBnQoHHGDwCpPBBsqlU3yK4EA=;
        b=WLvbMIDuNrO05fvEyJvr+A6st/+3F0Iv0fJUDc57B6aNPGGiWjgnbeUTpYOe0NjGyl
         9nNFqUEnDEdyo4cH2F7zFjSU8q7lgfKCu8RE5QLA3HzTDPqXvRvb6IAcUrf2fme9GzMz
         iLSuujICPOKJZoTCfWK6k5WASXZlg+kxVRERegZ+Vva/zV2t/0Lug48HW4xdG/Fwv0+u
         AYiV60//xkBE+DiqaGyH4Q/8JulGM2ee7snSQ3l9+swk//VOuOgRKmD4rXVBiag1x6e4
         tFczUPIsSCXFXUB5nYZbmGH7GosZRjEaSo01qNDXmATtidKGptGvXjbZgw1Yexp+nVJR
         KqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790286893; x=1790891693;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sUjYBLPEX7UvUbeFt5DBnQoHHGDwCpPBBsqlU3yK4EA=;
        b=QEc6zxXiRB3TPvfpt86DOTvE/tMgf4JGjjmkfM0Knl6ArR1QUr4bDep0zq40mTRR+w
         iQLAXJyKG3kpvZzvK2k0cEZVDcRig8UNxEdtXtJ/gPHpVLj4uHHO2pC2KjqYjhVNmY2C
         boMbLseQyHunh8YrF299oew6ZqNAzsNXvFaCUxhHz2PKHpSSBGpKAuw7+wTHwei+vcQM
         6vYF7ee87aKST2hNXFRv2UpIP1qNmS4pjS6Pepfm2gGLudWZAB9yyjORL0BVfApNn7tg
         YDji8taRAkePEUlt8SMtoGcuZVPJ3jdVtvcMtSQ/y55p9b4SlLwprBe7cRMx4j4rgooS
         XFew==
X-Gm-Message-State: AFuF++l7WMUABPdSbZBP3SBfFNVWreToyKdRbi3mkW45ItrLCoz6edJn
	TrOjhL0Xx5galZ0EmmakpU+U1Kh+n1AtvoA8BqXjTAgyME9H3lwZGzfjWLQGXkk/BgCIjFxn4Oz
	fP1pjDA==
X-Received: from pgbcq2.prod.google.com ([2002:a05:6a02:4082:b0:cc1:5705:ff3b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a28:b0:3cc:f280:ebc6
 with SMTP id adf61e73a8af0-3de0e70bac6mr3731054637.5.1790286892996; Thu, 24
 Sep 2026 14:54:52 -0700 (PDT)
Date: Thu, 24 Sep 2026 14:52:01 -0700
In-Reply-To: <20260921211608.1030158-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921211608.1030158-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179028361655.2004564.18333703645554243194.b4-ty@b4>
Subject: Re: [PATCH v2 0/2] KVM: x86: Ensure userspace can't run L2 with stale PFNs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jinwoo Lee <rkskek9254@gmail.com>, Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="utf-8"

On Mon, 21 Sep 2026 14:16:06 -0700, Sean Christopherson wrote:
> Fix a class of bugs where KVM (a) lets userspace run L2 with potentially stale
> PFNs and (b) fails to set kvm_run appropriately and so could unintentionally
> cause a well-behaved VMM to run afoul of (a).
> 
> v2:
>  - Re-pend KVM_REQ_GET_NESTED_STATE_PAGES in the common vcpu_enter_guest()
>    path.
>  - Fix the kvm_run bug(s).
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/2] KVM: x86: Re-pend GET_NESTED_STATE_PAGES if getting said pages fails
      https://github.com/kvm-x86/linux/commit/10180a277549
[2/2] KVM: x86: Fill kvm_run exit fields in common get_nested_state_pages() error paths
      https://github.com/kvm-x86/linux/commit/c1214f293d77

--
https://github.com/kvm-x86/linux/tree/next
