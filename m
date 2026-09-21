Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9674A3410
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999557; cv=none; b=F/HoaDiBZEyMX9Niqhykrwk+pHJHacmxgqc54Tum2wECekUealaI9tLKwrYjsKnIuIVBeJ69nHcPHpL3I1n3dhPJCGHXy9/7bgHRuQ+z2H9T2MMZDo2LTblkJwJiSa8JTseThHiu0UgMaP2Hn7pN9EudW6nJaWZ5KYtXZAq9or8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999557; c=relaxed/simple;
	bh=HYGgnNmi3QVtldKOycpSOnTBz70WPgmKQmW8PXNpJz4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ch+Q4mkDpIv34OrtL49POeF4zahPKxqlGEttoE5pUbo8ZfrQ3p23tp5YYYKJ4NewdG51CAwR7cVDyTRSBNC+crUFnIyBM4JQcIuoQc/fgrfWQUXxpk0aqKnJ9pmjYIe6jyLIwMRmvu2ZDkZ9x5c2iIZJIVbAirIQLSHYo72nUb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GK+w1l0u; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GK+w1l0u"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c89704da8c7so4094355a12.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789999555; x=1790604355; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kDaByuob3STQywTT3cAOlaBCTEAiWYMVBfjiNkGWQmQ=;
        b=GK+w1l0uJaNq+va4jdR5MAS9mbzn6Kwjt4hFQYHq4JSHngYoGKw+Z7nPd4QY3xbhir
         hQzTcyZviFv6qt+KHz+jYo4et0kAXU/b3CZmTWnji7anl6UvzlS3rW58bGch4uq1Gs75
         Kn2BajGgdEWlFeCXS+A6dHvdmpVwmEj0B3Of0YJ0J6PcnMK1fWeJzjihvEbyPdIkH5kD
         K9daCtqhlbzHIGJaWkahgTIB+cfR//zGVibVgUVGJqAzsAUgER+Ydl8zt/lcaa0Vm/K6
         PORUAHOK1cmr+E9OC6YR83f+joshUACvlBPemjsoyZPIQHtg6n59RjYw/+27vsIV0PSh
         aiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999555; x=1790604355;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kDaByuob3STQywTT3cAOlaBCTEAiWYMVBfjiNkGWQmQ=;
        b=Iaeys89mg7eAael3rfEnSqhBtagVealGtJ2JjB+yEMJbXf1BaTRYacu/LCHvbjIhwV
         k6onx65uLEx0Gxj4bvI/Jgl8SwYRrzknCfoS/3jSdQsdxHR9ECy89WUzGSAN4xWhxYgi
         3ccjMoNZ/KWxpywMK3oCczpOUIWmPJPLB6TFEUslH/6uho2Ua5+k37hNS7e33WMaycjP
         4r3Gv2bFT7IrGB6tuAUZHF5vst+qT8SBHEcfokAXQcns3Qu3gNh5Lkoir8jA3kphGUDH
         kuGfyBhiNWHYl1ZLOEMRd95Y90hPMOOPhyKkN/cGnVtrJobqIlLvgIEDmjM9aN6uIT2X
         MaRg==
X-Forwarded-Encrypted: i=1; AKwUvBzDWXiW2IVyrz44TXJwN5ZhHJ7f94p+5r6RDTarG+8Vf3XFcE/C0idY+KNpl+zJDLotY80=@vger.kernel.org
X-Gm-Message-State: AFuF++mlRcXolN/Qyf3Cwh/tPdjGkJmhUSstTX4wLo/X7VVTVqMWOYzZ
	SJ+nrrluIviOfKZv0HUhlsmiXuaFaHxzWFnBG8vbHLRbhrIrMHpyLaSSIC7jqU7Un0V8YfQL6+T
	KkWBa9Q==
X-Received: from pgdt6.prod.google.com ([2002:a05:6a02:3006:b0:cc4:e953:2e4b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d07:b0:3d3:aec2:4dcd
 with SMTP id adf61e73a8af0-3dd8c48ee7amr18530514637.25.1789999555175; Mon, 21
 Sep 2026 07:05:55 -0700 (PDT)
Date: Mon, 21 Sep 2026 07:05:02 -0700
In-Reply-To: <20260806214618.82180-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806214618.82180-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <178999694044.717318.4471496122366852907.b4-ty@google.com>
Subject: Re: [PATCH] KVM: Never clear KVM_REQ_VM_DEAD from a vCPU's requests
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 06 Aug 2026 14:46:18 -0700, Sean Christopherson wrote:
> Use kvm_test_request() instead of kvm_check_request() when querying
> KVM_REQ_VM_DEAD, i.e. don't clear KVM_REQ_VM_DEAD, as the entire purpose
> of KVM_REQ_VM_DEAD is to prevent the vCPU from enterring the guest ever
> again, even if userspace insists on redoing KVM_RUN.
> 
> Ensuring KVM_REQ_VM_DEAD is never cleared will allow relaxing KVM's rule
> that ioctls can't be invoked on dead VMs, to only disallow ioctls if the
> VM is bugged, i.e. if KVM hit a KVM_BUG_ON().
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: Never clear KVM_REQ_VM_DEAD from a vCPU's requests
      https://github.com/kvm-x86/linux/commit/8cd280282d12

--
https://github.com/kvm-x86/linux/tree/next
