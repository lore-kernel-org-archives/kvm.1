Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501740;
	b=TM+4QqeEGwlPs61nn5zQmxFnAi1aO5e9WxAyOoHd5ZHxQcdMp52T8uEPLiOnMa1LuR0b
	 qeOBF58vL/9Q8048xJ92G92Nhn1sH5BCmbqTu750oq8pBRhlQxTK24pQOjboyy7TX/GJP
	 yetboRAtSIZSwJI5/eww+2g1fnxnQppKbhaT5/q+zb9C4QkrMCWIlB/rJqcI5xtHZsVji
	 6D6jP29nTXH+TMfrGfG3AyErzF0LH6oZyo+VGpsyKBx55nB8KSp1LWMmFzeGdFC2sqwOq
	 /sk5Es/Gv2G9KN6/s4upwVSb7w9kHhIEKt5K8xdK3C2btKJ2vARyA/5dyuWYxwd/cXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=AkbVykVZBQUYEeZ40x+qwIRW7yVXsi+IgJgibQddBlo=;
	b=JG5HvQK6smq5Hk18NCCwavh90HnRjn9WUYCu8dfmCvdHfKM0LyID6+sfApMxmadqHvVs
	 JDQiA+hIom1Mwg8YEyrfeLONXlFlJ1LoivlDqiKuCpeX7d+uAMv3WrDo1cjFt55551GJx
	 narr3zBDOBKHWGVHciF2+kpm5suYMegA7jT9c9tKcIFzIk8gKAuVTb7XDQLZzQXKk/Xat
	 3B3QYMTE4L6S//7z2by3lVz2hxGNVE7JoBh1rP+PCK5goSepzxdy9r55lypP6D/ygeh79
	 oQNLoObtEFSYYz2j4UZcD6EyRejE2VR58w/pynMhz6F9eQ/3wqnSeTwTZ6AyMnqoioA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aB3+nL0V;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6166606A323
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 16:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6166606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aB3+nL0V
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b175a69ab8so3509046a91.1
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 08:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794501739; x=1795106539; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AkbVykVZBQUYEeZ40x+qwIRW7yVXsi+IgJgibQddBlo=;
        b=aB3+nL0Vpmj4XFDgWJSKQKvxYnbg79IDNhcDs0nk38jbc1dAXpuH5svptkXfW8GD5l
         PkfWWqAFbqnOjNHb92RvPZXYuOwa6IIfSvKk3KFM3DFM6/AnQa7d+h8LkF9SSR4ckvNI
         ReNFEtwKj7pbFi3XQR2Iz3PlKQREBqCQsJ86mx/s40WLmiwtkn2LvLJOOjo67pSyVR5N
         u3GH9JSjb65155nUjAAqWLpu9OPwZUjdpkyF55v0vayjq93fsiKz5eadTHzW5Qi09rlf
         g/KZiq2sa86dUWwTK/OKRODR1YDcEtMZ/jBsL3DvTMC6PY/Jt+mC/gUkW+ljhvJbgeut
         IoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501739; x=1795106539;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AkbVykVZBQUYEeZ40x+qwIRW7yVXsi+IgJgibQddBlo=;
        b=yTvmx+FwrmZ2JgDTPCdgU3psPBFUecC2IrpQmyAty09Dl4+XBJ7pLOQ0duluiUzIku
         VLKyhNomMxvTozgCHIaYYRL/MvLr5WZPo2MUWZMtYHzyOTrzvp5fNHepobWI3fV9eIGV
         NVRRrRnsQVk7JjzkmQ2gzx9t8RhkK19JhBe7/Fic38xw0GpPVFs5FrmkBTczqyhkHwpu
         Nu0UVTP3tfm5nvzyKerdMfa79dhn65jD6fAeLUtEyE4dTA6nQSKi63/fctANVLXF8Ics
         fMusJ9mGvkik/TDcVYFE8eB7JosHo/xf7Fe3cirWg05/xCPj+vd4ot2onnuxuUr2bRfM
         KUjw==
X-Forwarded-Encrypted: i=1; AL+hErEOUy2w2xLmv4xuZ1doldUHoNLxIcYYHv/6LKkXWcs2lYEyzSMSfaKZ78JcyRKgwO1JYLI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9J+271HGzOf9ogBlRYgfugn6d6rgswwF7sFLVsDKgMMjK8m3w2
	ZSqUZeDPA1TCxUWMcWvKW+gUpoelrsy8W8cYkWM0a4x4762goiLfFCzTALzEIlt1bEl58j8fu2v
	1ts8Vwg==
X-Received: from pjuw13.prod.google.com ([2002:a17:90a:d60d:b0:3ab:133b:49b6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5584:b0:3ac:8fff:5a1b
 with SMTP id 98e67ed59e1d1-3b182edd001mr5732914a91.34.1794501738408; Thu, 12
 Nov 2026 08:42:18 -0800 (PST)
Date: Thu, 12 Nov 2026 08:42:16 -0800
In-Reply-To: <sashiko-outbox-210535@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <57324d544da1e92cf3b30ff7c40595dfbca1933d.1794465097.git.priyankamani2100@gmail.com>
 <sashiko-outbox-210535@kernel.org>
Message-ID: <avXsaIGjGotdeJiR@google.com>
Subject: Re: [PATCH] KVM: nSVM: Check full nested state size before writing to
 user buffer
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Priyanka Mani <priyankamani2100@gmail.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 12, 2026, sashiko-bot@kernel.org wrote:
> [Severity: High]
> This problem wasn't introduced by this patch, but in the paired setter
> svm_set_nested_state() [1], does a failed nested_svm_load_cr3()
> leave the vCPU in guest mode with an active nested MMU context?
> 
> arch/x86/kvm/svm/nested.c:svm_set_nested_state() {
>     ...
> 	nested_vmcb02_prepare_control(svm);
>     ...
> 	ret = nested_svm_load_cr3(&svm->vcpu, vcpu->arch.cr3,
> 				  nested_npt_enabled(svm), false);
> 	if (ret)
> 		goto out_free;
>     ...
> }
> 
> nested_vmcb02_prepare_control() enters guest mode and initializes the
> nested MMU context, but the out_free error path only frees save and ctl
> without calling leave_guest_mode() or nested_svm_uninit_mmu_context().
> If userspace passes an invalid guest CR3 and then continues running the
> vCPU after KVM_SET_NESTED_STATE fails, the vCPU runs with a corrupted
> nested state and leaked MMU state.

Ya, I have this locally, just need to write a changelog and get it posted:

diff --git arch/x86/kvm/svm/nested.c arch/x86/kvm/svm/nested.c
index 07554089ec05..4b1cdc7798bb 100644
--- arch/x86/kvm/svm/nested.c
+++ arch/x86/kvm/svm/nested.c
@@ -2114,8 +2114,10 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
         */
        ret = nested_svm_load_cr3(&svm->vcpu, vcpu->arch.cr3,
                                  nested_npt_enabled(svm), false);
-       if (ret)
+       if (ret) {
+               svm_leave_nested(vcpu);
                goto out_free;
+       }
 
        svm->nested.force_msr_bitmap_recalc = true;
