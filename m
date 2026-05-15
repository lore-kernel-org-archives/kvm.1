Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB013346E71
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778806806; cv=none; b=bKdzASK+R8bRFyRyHmobMI9GcsveOnZiuLWCVmS4/0HSHjNiBx2KoVLGjKcMZOqfD0zCjI6vgQLkI7bPHy94SxwipddLEaSPO3sxmnqR0vB0Tu0O0uEqE5XXWtv7+DrvxqZ24zO76kEUwP/bUtO30Zek+M093N6JPBo2q2W9lkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778806806; c=relaxed/simple;
	bh=LcnsrtLPY7Umz+f+X1aBIbzHI+WeZIJ2/4UquLGJxhQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xq5G5SJs/lEQuXwr2tJJoR3aP24fMLonrjW/UPoXyasn6gO0lkCp/c38DduyRhlDXLOaBiLY/FpsaFgTGliQPaf0GPx212yNskOW/437fyC8piLlKJpse5rcb47t++/FzLrppbh/uNG/o5uPar0vo4L7w79K/DsMI696/XPz3H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q3aCtbLz; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q3aCtbLz"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fd55bf6cdso5521731b3a.3
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 18:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778806804; x=1779411604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qIZzPqy3RYu0JMLDYEt/vmWbE4E/VO/Dvm2rxXplSJI=;
        b=q3aCtbLzJROLXQEIW4UE+evTzrJTBN4FARLBUJXoVYHtQTvPtGqYWB56J4sz6fKQzs
         cCb30d5qVLO0qDYQONiYcQBuzq9DLeCVljOBHCqdUZx87oOtM3scdLqzDIvpMoZXkPwc
         mRGPpa+BxQQj3jwi3dV+wHhiLKy5DU5TZ4NnSe5HdN2qnoxwAXF95RX3SGcQZgKkBpGk
         wXTQDcvTQ6HPln0xXPBrcTx0aoNrGjDuKQLNVysa5sGecZCX2dxQwlMZJ+vPRwon7lC1
         izXVHnXYQx7JkoRKh64TSTnLBxdMBGsjdykhgEHTI8wRS2rw/KkoE0lIJSLe5xp66NIJ
         3Uqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778806804; x=1779411604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qIZzPqy3RYu0JMLDYEt/vmWbE4E/VO/Dvm2rxXplSJI=;
        b=IauGSy9PjUYHHoncuzr3wrr5Y9frlKedPQ9zSHjsy4jaeZiaQZOZuYJCAi91KJUz7N
         0KpuacFQMKpVE6X79dsCCD/89uTBaiDrkGz/u1sHn7BC4RZudFMCr9lcsu0jgm72mPWB
         DBjZuYkP6+dg6Z2x3ANhRn0iodFSlEqQg6co7GKdjugpG7UUE0a0pp1MdNu6cAbvuKzl
         WWYZz4cqpitBZ1YeCXEjdDa3xtFGa3MMRtwhCnNA0MmFPGcQ2ajEbePJ2wL9lzHN0WsM
         ogJVsI9tv6U4SuDFGPfo4YcM+EIrS8AOnM1qBH/giXWIo5qqtt+10nLR+fjO/7UNfkZR
         kLsA==
X-Forwarded-Encrypted: i=1; AFNElJ+IL+K/w3/ofYqkyoL9kJUoM7dElk5uWMqCmsgm7MLZ9K3JiK/RTJTOQaAnRaG6dVSoGO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbi1LhD68nS0OKgIeKwsBFB2ROTHV30oguEV/J7AXKxyjlLxYy
	D+i+8P6OngdPgCAgye2UUbICQ/WAudSbjCXKai1GPF8ZybNe7ykqIwcEUkmpx079MEAWDreBe3b
	M109Rvw==
X-Received: from pfhh12.prod.google.com ([2002:a05:6a00:230c:b0:838:1469:2431])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3490:b0:838:6d43:9486
 with SMTP id d2e1a72fcca58-83f33c54166mr1790917b3a.10.1778806803862; Thu, 14
 May 2026 18:00:03 -0700 (PDT)
Date: Thu, 14 May 2026 18:00:03 -0700
In-Reply-To: <agZt4V4Ur8cQgikY@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260107235724.28101-1-aidan@aktech.ai> <20260107235724.28101-2-aidan@aktech.ai>
 <agUgeO5QNenQM9pT@google.com> <agZt4V4Ur8cQgikY@google.com>
Message-ID: <agZwE6kX_94AjCQ-@google.com>
Subject: Re: [PATCH v1 1/1] KVM: x86: Merge pending debug causes when
 vectoring #DB
From: Sean Christopherson <seanjc@google.com>
To: Aidan Khoury <aidan@aktech.ai>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Aidan Khoury <aidan@revers.engineering>, 
	Nick Peterson <everdox@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, May 14, 2026, Sean Christopherson wrote:
> On Wed, May 13, 2026, Sean Christopherson wrote:
> > On Wed, Jan 07, 2026, Aidan Khoury wrote:
> > So while I don't exactly love the idea, I think this?  Compile tested only at
> > this point, I'll try to properly test it tomorrow.
> 
> Confirmed the below works, once I remembered how to configure debug breakpoints.
> I'll plan on sending a v2 on your behalf, along with a KVM-Unit-Test testcase.

Ugh, and of course the test fails on AMD.  I'll still send the KVM patch, but
I'll hold off on the KUT mini-series until I've done at least a little digging
through the APM (I'm not exactly brimming with confidence that SVM can handle
this correctly).
