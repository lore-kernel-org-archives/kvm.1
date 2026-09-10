Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093CF2D7DC6
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 00:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789000046; cv=none; b=cZfHgcFP9DhS8YwjccRtm81Jds/lhVenktdak0Bqn9PUxPajFe4R5JL5OF6Qw8Cy2+oPiNNADwqv216ABqLDPjw30+RaeBliXXujEN2YXuCWb2U9sTzgWzyi0aCHEqOkeGCB96Yzf2SDqGFTYUEZKijcYvRbc5nx1snX6qHoEDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789000046; c=relaxed/simple;
	bh=W/cQoJNpCMvhT/b6a6u/tSJdTecPVVcp+05IoAxGuKA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cfOzBl1OjWHFFnZUvIojjprfjN8AwZa44e0KeqKzVogiEc8DKat9f6D2EysAheavyBoZYgr8PqWajmRjdser1LVMCBx0lDGJUQyEHKSLhV8fqPOOP28IoLPFs2+VHRJMlGsOPnGD6gNeP40aeGYDsO/39F5DTstk5INVicv3B+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PbUnAEEx; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PbUnAEEx"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ccb6823efcso66473675ad.0
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 17:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789000044; x=1789604844; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p8JHNVACgZQItEORarLzV/z1PEss/g3cX3jzovh/lk8=;
        b=PbUnAEExmovGEajL6NhjjxfLfji05OgqzSc4vwM92DyZXyWvWjVNVAkffB0H2zsKLK
         OSwJDFrw2p+lyq5hIpz65AV9fT2WLLU1kXWepTW1DaEtfgfoLb6Vyglkz3axBIJ4XSdS
         C0UwmRiwLGy4aaNv9XN41f3nRBxfJ9rLqDukC045kjnXl3FkRmk05xIHPPFG5BS3qaw+
         Citka/2OGOaGef6QPdstHPoqv1+0Ons31adlCGyB43M9We2Vm9RsN2ZazdbKLBGLymaD
         JUl5ftx4Ych04vcPilxrwjD5GMRel7sN1ym9QXZ25DsqWRSG8LgjNcqNKH0CAj3dwbwC
         wQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789000044; x=1789604844;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p8JHNVACgZQItEORarLzV/z1PEss/g3cX3jzovh/lk8=;
        b=S8UF/lPWEHQlNqcbMSVxLSC6NJ759vK/zMVu8ePBqL75WHjptLhHDu3/ZLKG5V6CB0
         oLaGgm1oB+ySZ3WoBX8C3HOhGr/P3IWYz6rj3Xsh6gKtLScBmJWhFngF+zZMkmD7Y+A/
         5DKmswKKVFP9+qRdUXETceXpMWKhZII04IJZXnwIEMftOyhhRFD0kaZo6Hr/mWKTgRFV
         4T6G4wCPmIg9iHku/Fxx1H1F9ky4ulq9QmxJubO1och+bqJwG7lkTT4OViVItEkSFfBm
         U6yBno3LPq2dc3ruOOnxXvKarO+CyfJzVVJmzGzDehkc/S5TTBMGiCNldnFWQlTSUizn
         yOhw==
X-Forwarded-Encrypted: i=1; AKwUvBxxRw3tSU0gtY2MxVxzXA8pexKDwkFeNpm+m6y4KlOvy52fVb5i9YUrGj7b7v216/zPLco=@vger.kernel.org
X-Gm-Message-State: AFuF++kkhoeXppaDWhD3mbr2cPrCyIbCS/vJvGZnbcmLQKP/UuWYqt8U
	iddT9eOkKj8t1+DzrK1G/5THx8eGBqOikXa/6VBPi+9+GRZ6kl1BQ8qnBnbnGA7NSB2dUff3qrk
	6PWjjmA==
X-Received: from pjqo21.prod.google.com ([2002:a17:90a:ac15:b0:39b:7935:6c42])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d87:b0:380:540:d499
 with SMTP id 98e67ed59e1d1-39b26100bfdmr51740780a91.6.1789000043798; Wed, 09
 Sep 2026 17:27:23 -0700 (PDT)
Date: Wed, 9 Sep 2026 17:27:23 -0700
In-Reply-To: <20260908160426.6547-2-tharitt97@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260908160426.6547-1-tharitt97@gmail.com> <20260908160426.6547-2-tharitt97@gmail.com>
Message-ID: <aqH5azSkQJVXg3ef@google.com>
Subject: Re: [PATCH v1 1/2] KVM: x86: Reject reserved CR8 bits in KVM_SET_SREGS
From: Sean Christopherson <seanjc@google.com>
To: Tharit Tangkijwanichakul <tharitt97@gmail.com>
Cc: pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, shuah@kernel.org, hpa@zytor.com, 
	binbin.wu@linux.intel.com, kai.huang@intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, 
	me@brighamcampbell.com, jkoolstra@xs4all.nl
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 08, 2026, Tharit Tangkijwanichakul wrote:
> kvm_is_valid_sregs() validates the incoming CR0, CR4, and efer values but
> never checks CR8.
> 
> When userspace passes a CR8 value with any of the
> reserved bits [63:4] set, __set_sregs_common() forwards it to
> kvm_set_cr8(), which rejects the reserved bits and returns early. That
> return value is not checked, so the ioctl reports success while the
> requested value is silently dropped. A subsequent KVM_GET_SREGS then
> returns a CR8 different from the one userspace believed it had written.
> 
> Factor the reserved-bit check out into kvm_is_valid_cr8() and use it both
> in kvm_set_cr8() and in kvm_is_valid_sregs().
> 
> Fixes: 2f5bb3fe5835 ("KVM: x86: Move the bulk of register specific code from x86.c to regs.c")

Heh, this goes back much further than just moving code around, all the way to:

  6aa8b732ca01 ("[PATCH] kvm: userspace interface")

which did this in kvm_vcpu_ioctl_set_sregs():

  6aa8b732ca01 (Avi Kivity         2006-12-10 02:21:36 -0800 2109)        vcpu->cr8 = sregs->cr8;

I suppose one could argue that:

  Fixes: 7017fc3d1a12 ("KVM: Define and use cr8 access functions")

is more appropriate, since this specific behavior was introduced then.  I'll
probably just shove both in there and massage the changelog to explain the history.

No need for a v2, I'll fixup when applying.  Thanks!
