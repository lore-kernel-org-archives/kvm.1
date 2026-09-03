Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4284F6462
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788457993; cv=none; b=KO1I7C1gqLtIxh+Sgza7zik9JF7IIBTRhmgE1ZvE6SpwhPu8rODauWGEblIacl7mZ0ZLwvCjvlwVIgfH295XT0NpjsFsOfsINjwTm9WOgvgyNthlwV3imSiPWyu3W0S6a5uB2I5iz8PastbJs/jo5fptkDs96Hn6Uxe+gk11aKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788457993; c=relaxed/simple;
	bh=qmvSYOj93Rj2lnHMFkCIXw86uphqZdKfuXvnifx9U18=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=skUPBvOOQLFEzQ13duFyzWEulsYGhRJakHOy5o0EtWf4GSf5VLAFEPoezGiZXbUn79hTzoWLCt1Y0w9VlkkTfj/8U9bMgQBkt1GyIBfHL6OtaJepI7u2ptp6ZoMzdw3BBy6hKznYdv6KjkmbIINIVg8EOJe5jBmE0ej5F6osXd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qTM+IwDx; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qTM+IwDx"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ca6bd8a190cso282841a12.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 10:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788457991; x=1789062791; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yf858VmSM4H/VduQMmnZj+hAnDJWsph1+mnhHN8bJIA=;
        b=qTM+IwDxIFtHENT38wDp+pA4vqOdC1VkZa/cas/dmTiveoHy0J6z21H7wggBOmgWW1
         6lvARyTkVh/oUsaHcDCIwL7HowUVVbpGQPHxgJ6LNuZxP79qxQUKx9OwZBEpaVufxlPI
         C+OLJI2zlR8Jl/kNqyUqwjtmoGw87QsSX7cqqL6zkhtECH7qb2Yj0mcQ9w34JzAKCVLF
         czPsBoua4T4YCbfKhLD/UqqZrTZkEPBfv69D9NphvyxZiSdhoWvm4sI6QtXqSNH25ag0
         t2noWDX2gJ4gP1aSJOyHp97zahUXM9BGxKVjHrlr4aOMnPc1+K7wbOkE7Z0eAFfz2LD0
         f0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788457991; x=1789062791;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yf858VmSM4H/VduQMmnZj+hAnDJWsph1+mnhHN8bJIA=;
        b=YSqhfQZu1Tm6Riodbi94aNv41Z8AQbvRoW2oSstjT6g38ckS7YT6LORkbLXIFQVco2
         A8HRqi/EUWbIs7qLoxCWQ0P2owZQvc3lxN8hzO5LH/+lRMIzvgX4rKxtI8J92mzBJLuj
         4ZrM3z2LAyxuUwUZ1lR+KG9gg0een+vdH/aMB0Jqdxneh9lWGMqbTh+8WIOeh+zBZH0s
         tkhC2wb4MP6WbyMhmdohFcLyblQFduSaeDfhFmY4aZK0e0awuXFQ+zLncO661fFRlPnC
         9BtqCaFySggly0Gnht/nKQUZ7BwNpVQiSbSxMivtPOXnwbXENzlDJBxpsGGAyKhX4Buo
         jK6w==
X-Forwarded-Encrypted: i=1; AKwUvByGRwAdU1yXY47QNi8O9b0Yni4tJMrViCBaml2WhCQIiPpOv1Mk1Npv9jccq0TqeuolnQI=@vger.kernel.org
X-Gm-Message-State: AFuF++menEs11V1dEnugzgpJnxS/by9U9LezZl8b894U0mJtXkxtWfGI
	VpSUngKKF/GCfGshW/YcZepzZCGy7dGdmDkrhAWch6xjdR12qk90Tswr8ol/VAqLNxC/SAFPP1u
	QB5iGzg==
X-Received: from pfbeq4.prod.google.com ([2002:a05:6a00:37c4:b0:848:487e:d23c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2c97:b0:857:7337:5db9
 with SMTP id d2e1a72fcca58-8616af6486fmr919512b3a.23.1788457991212; Thu, 03
 Sep 2026 10:53:11 -0700 (PDT)
Date: Thu, 3 Sep 2026 10:53:10 -0700
In-Reply-To: <202609030248.b516759d-lkp@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <202609030248.b516759d-lkp@intel.com>
Message-ID: <apm0BpPvMZZWYthw@google.com>
Subject: Re: [sean-jc:x86/evmcs_vmptrldst] [KVM]  7fecb27e8d: bunch of
 kselftests.kvm failures
From: Sean Christopherson <seanjc@google.com>
To: kernel test robot <yi1.lai@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Yosry Ahmed <yosry@kernel.org>, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 03, 2026, kernel test robot wrote:
> kernel test robot noticed "kselftests.kvm.hyperv_evmcs.fail" on:
> 
> commit: 7fecb27e8d353adda91989eb01b3ae200b846a42 ("KVM: selftests: Always assert that vmwrite() succeeds") https://github.com/sean-jc/linux x86/evmcs_vmptrldst
> 
> in testcase: kselftests
> version: kselftests-x86_64-f5098b6bae76-1_20260727
> with following parameters:
> 
> 	group: kvm
> 
> config: x86_64-rhel-9.4-kselftests
> compiler: gcc-14
> test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <yi1.lai@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202609030248.b516759d-lkp@intel.com
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20260903/202609030248.b516759d-lkp@intel.com
> 
> Detailed log:
> # selftests: kvm: evmcs_smm_controls_test
> # Random seed: 0x7ad5b4f9
> # 
> # ==== Test Assertion Failure ====
> #   include/x86/vmx.h:434: __vmwrite(encoding, value)
> #   pid=5240 tid=5240 errno=4 - Interrupted system call
> #      1	0x0000000000412f61: assert_on_unhandled_exception at processor.c:781
> #      2	0x0000000000406f86: _vcpu_run at kvm_util.c:1687
> #      3	 (inlined by) vcpu_run at kvm_util.c:1698
> #      4	0x0000000000402cc6: main at evmcs_smm_controls_test.c:93
> #      5	0x00007f0a85d39ca7: ?? ??:0
> #      6	0x00007f0a85d39d64: ?? ??:0
> #      7	0x00000000004030c0: _start at ??:?
> #   vmwrite[0x0] = 0x0 hit VM-Fail

/facepalm

I managed to *repeatedly* not update the repository I was using to build selftests.
Thank you friendly kernel test robot for saving me from major embarassment!
