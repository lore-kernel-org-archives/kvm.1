Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99B3397E9A
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 21:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286889; cv=none; b=evC6K6zP1KZ+QzQyO8MVCPKr5op8Ug/XJIxHjhUMugSiWqG6CVyHXC0uHLILYN1Wfo7UnJsfN5u3Gam38z1++bLoLz0tZlgbd6U679lXicrzxzLr173neG/jcgkfAPdIoRzro/2A0l9atymZqzGRtKobqhfFfWZMnAQ+DUJD2wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286889; c=relaxed/simple;
	bh=+iz/qUQS3BYLz0YmbGG2HcxYcjxGg4hNl4MhPBnFET4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=senYsj3MHhVW8GAeEksDc1JCi9wU2FINP54L1WOnH9T/EqoCL8eCbfcEV35gtmj5ml8RKjCw9lPbdNEHvMdgSRCtc18fFNmhjNBNdvxWiAsaFpA9UYFErX8ikKZa78ZScZ79PSjbycWyG/cZSMxgxlJ0zUrCqCLLQ52Trfz8pD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J4QlYbEg; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J4QlYbEg"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-396901263b6so277784a91.2
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 14:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790286888; x=1790891688; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ls/WIqLZ9h1Yk/ZfyOfON5RY+uFXSZy1PRrGAAaFYz4=;
        b=J4QlYbEgrw13Bt8a13hvTUyo61LSQGOLjsLja/5OqYmknfEm0ds7tkzgvd4IDZYMzd
         XlrutZ2IZ9aK3ZPwfUtr4yaJezG8XXpNgl6knK/5WsgRJNn9ikuADKADYiVG0JY854ua
         +0CoXoWDUoa2lg4SCEKq279OjJP9ps5HMBItXNxO3RrQGFSt1KAGvSyCUiHO3+RHhXZl
         gw7ku0MlXb8TRMV1wyN3Tlq2UYF50ygZSyE6y1fac6pwfEzxMuHOVO75EBfMEu9ii3y/
         Cx9KBeAFbsHCs2Fp6ZZRvD0sQ9LgBSsUwX/awQue0t5FcpIH5uK4S+OdPTydzCL9vk1a
         aevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790286888; x=1790891688;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ls/WIqLZ9h1Yk/ZfyOfON5RY+uFXSZy1PRrGAAaFYz4=;
        b=ISEtXxS6w66T+TqcY14RRJWgNytTuNX2Gw92VL/gDmlo3fiAHGjQZLjJxtZ1P4p16h
         0SrW2tpUdKClSw+3ni8x5IwaZna4LuXj/XN5k0YfoNmuk+yoOiTlrGU/apS5UR11y+mA
         ZdDulFsotjmkK4VNbsWnjT3LUdkVx7rAI8RMxiFvPF4mB8fuO+f8U9pryTnELxWPYWp/
         b0PTUYJSJ8ahUpTQz9qPh4k/ov87LzIDFSlKWGwdKYW32bimEUTagxNZQdXmDi887GTm
         dxP7ydn+HfrZjcaacMSPf331v5lVyoDJKFyQLdzwImGNpkdqWrjhTLJZ0hyopvxlx6V0
         iQZA==
X-Gm-Message-State: AFuF++nveh9C238Ix+gKVXNQdzAroPS9ItB10fA6FaLxZ6+WxyZ95tLT
	fAIL4xmCwsTsBMz2ZqBettVm3Jz8r/GVeN98zMrICQ1kZ0/qjEfuavzE+ROOlut+TMpO1jMIdjt
	v9kYjgw==
X-Received: from plaq19.prod.google.com ([2002:a17:903:2053:b0:2dd:2d81:c97])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce8f:b0:2dd:ad73:5b71
 with SMTP id d9443c01a7336-2df7dbbc22amr32887625ad.33.1790286887686; Thu, 24
 Sep 2026 14:54:47 -0700 (PDT)
Date: Thu, 24 Sep 2026 14:51:59 -0700
In-Reply-To: <20260915175335.138547-1-davimaba.v@proton.me>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260915175335.138547-1-davimaba.v@proton.me>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179028303710.1997669.4762091811625597120.b4-ty@b4>
Subject: Re: [PATCH v4 0/3] KVM: Fix and account mem_attr_array reservations
 abandoned on ENOMEM
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, 
	David Ballesteros <davimaba.v@proton.me>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 15 Sep 2026 17:53:40 +0000, David Ballesteros wrote:
> Three small fixes to KVM's per-page memory attributes: release the xarray
> reservations that KVM_SET_MEMORY_ATTRIBUTES abandons when it fails partway
> through (1/3), make kvm_range_has_memory_attributes() agree with itself
> about what such a reservation means (2/3), and charge the xa_nodes to the
> caller's memcg as the code already intended (3/3).
> 
>   1/3  Release the reservations abandoned on ENOMEM.  This is a plain bug:
>        xa_reserve() materializes entries GFN-by-GFN before the store phase,
>        and on failure the loop bails without releasing what it reserved.  A
>        later clear covering them does erase them, but nothing obliges
>        userspace to issue one; absent that, the reclaim path is
>        kvm_destroy_vm().  The retained entries are not inert -- an
>        abandoned reservation is an XA_ZERO_ENTRY, which
>        kvm_range_has_memory_attributes()'s !attrs fast path counts as
>        present (raw xas_find()) while kvm_get_memory_attributes() treats
>        it as absent, so a straddling hugepage over such an entry is marked
>        mixed and KVM stops using a hugepage for a range whose attributes
>        are uniform.  xa_release() erases only entries still reserved,
>        leaving pre-existing value entries untouched.
> 
> [...]

Applied patch 3, with a heavily modified changelog, to kvm-x86 fixes.  For the
reservation behavior, I went with Zeng Chi's fix to have KVM treat ZERO values
as "no attributes".  Having dangling reservations is a-ok, the memcg accounting
really needs to do the right thing there.

In the future, please don't have AI directly write changelogs.  It's fine to
let AI generate a rough draft, for me at least, AI tends to be far too verbose
and uses terminology that isn't common in Linux/upstream.  In other words, AI
tends to write changelogs (and bug reports) that require far too much effort
to understand.

I apologize in advance if you wrote the changelogs, i.e. if I am falsely
accusing you of being a robot.  If AI didn't write the changelogs, well, you
do one heck of a job of imitating some of my newfound "friends" :-)

Gripes about AI aside, than you very much for the fixes!

[1/3] KVM: Release memory-attribute reservations abandoned on ENOMEM
      [SKIP]
[2/3] KVM: Make kvm_range_has_memory_attributes() consistent about reservations
      [SKIP]
[3/3] KVM: Account mem_attr_array nodes to the caller's memcg
      https://github.com/kvm-x86/linux/commit/382e5d514b6f

--
https://github.com/kvm-x86/linux/tree/next
