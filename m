Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640A3489FD8
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999589; cv=none; b=NY3s+qRauT5zHPRW7pZ+SYRH6AxTS+YHsWvK0U47GZkgggLWKYGatTWIU2XArmJ4znVsUoMgt70HHpd+Yxg3jU79k85twBCBKLiqnvMqoU8WQg6IUf5/kKLBXRIAOITeKBQoOTtkMRKpJuDivA/6PcBnxJuG+/x6FGBOP/ARj/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999589; c=relaxed/simple;
	bh=6TAqMjHBoHUiFi3wkvnVQ728BuUL5Y5HLzESWYJT0lg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KC7hNkm5eIzMhsCfvLL5hIMlZP/lLnqBusD/eN5glOEBqdj6j6rO6Tp9mAt8h/OkHvJQmkZ6v7UQn2ybfI2Btb6dbx6xkxLGUXQxIKFhXABvfGZpQ5Cv2MZ/Eh7VHsa30Dg0A7PmBio0mCdG75cDjv/hYmsrd7HYQMpJyPUXaAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qRRgmWLn; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qRRgmWLn"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2db87f759c5so59445075ad.1
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789999588; x=1790604388; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BZ2htXcpEf0yscnHPHdzpPSyyISdV3JRkU5aSKroXnM=;
        b=qRRgmWLn2U4RCXlmJQxASHXyrd8nczReal2WwwBIKB7uMXipjTZDg+kUqDe7N2U+LY
         0aBxLGvRGVeWYMwbJ5BXTcapNhD6j5rm85EqenQrVN5FwjHtmMe3fWSmX3AGBpA0+0My
         +k841tLwZt0Tl+l8o4qG1Iqz7OwIuzxiXwAfZdieX7F+TJDb78rxB7a4zf3ck7OqxHCL
         j4zz73umdRVFR6rXQoj1a7ooZ3j319VBCX3k5H+WcilZogVBXM+eqQ+m/QZTn8L53y4G
         YoGlzbSFOFqBb59i8BfC0l16dsWccCSvSSrXCK2QGfqFfz5XY8JKGtnTwtcyQPDGzVvz
         Z8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999588; x=1790604388;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BZ2htXcpEf0yscnHPHdzpPSyyISdV3JRkU5aSKroXnM=;
        b=X135yz+AEoCWBAwoXwwA5/KkVj5I0//ZYuTUdsQcizGV8eagamSdO/+I0RxTB2Vf0A
         KBol5RWb0NVghcSuSdF1D86gJ8TPyOcc2+Zx+jgtRtCNrj2+w/vLwcyYPT6LmdZgk6kf
         xjypVGP0X3namdo/tjmCWYUioeRTA8pAf8A5Ugtf+ipQkCaCFiNKzLlztwwssQmniYHU
         dcdYXUvo8TLbFiJYYWYevUgVb9Lv6/J5VRxJ1S8Ly1f31EPZaYnPHPivzSWdQ0t+bhRv
         VbzGrxJyF8smEXlwJ3wgeLqwFGtW1tNxIo7ecqJKmLtDIjmch905d0vftqzxlpDkudXo
         4/Fg==
X-Gm-Message-State: AFuF++lHfNYSrp1YxGmcfAzZ4+5qBGvfRxSvfwYvHsT9g8/miWrh6uhA
	6W7lPylmKWXH+y3bYoV/nn5agJ2SRT1/yBLnodoU2IolHggCXRo/x8EDwHxTAIxKTMKql9aCwta
	vi4aX1A==
X-Received: from pleo1.prod.google.com ([2002:a17:903:2101:b0:2df:4883:3fc3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3803:b0:2dd:c100:b2d2
 with SMTP id d9443c01a7336-2ddc100b3b1mr113461315ad.61.1789999587464; Mon, 21
 Sep 2026 07:06:27 -0700 (PDT)
Date: Mon, 21 Sep 2026 07:05:14 -0700
In-Reply-To: <20260902230932.2760127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902230932.2760127-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <178999888361.743033.9908769455046597723.b4-ty@google.com>
Subject: Re: [PATCH v3 0/3] KVM: VMX: Explicitly track TDX VMs' root level
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 02 Sep 2026 16:09:29 -0700, Sean Christopherson wrote:
> Fix a bug where a misbehaving (or niave?) userspace can configure guest CPUID
> such that KVM will use the "wrong" root level for its mirror EPTs and trip the
> KVM_BUG_ON() in tdx_load_mmu_pgd().
> 
> v3:
>  - Use kvm_mmu_get_max_tdp_level() in __kvm_mmu_create() to avoid what is
>    effectively a false positive WARN. [Sashiko]
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/3] KVM: x86/mmu: Use KVM's max TDP level to determine need for 32-bit TDP root
      https://github.com/kvm-x86/linux/commit/7ed619909773
[2/3] KVM: VMX: Explicitly track TDX VMs' root level instead of guessing it from CPUID
      https://github.com/kvm-x86/linux/commit/cc8a8f2a90b4
[3/3] KVM: VMX: Drop TDX_SHARED_BIT_PWL_{4,5} and dedup related code
      https://github.com/kvm-x86/linux/commit/37e3197c50c8

--
https://github.com/kvm-x86/linux/tree/next
