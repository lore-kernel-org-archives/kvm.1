Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6A4260592
	for <kvm@vger.kernel.org>; Fri, 23 Jan 2026 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769191434; cv=none; b=FriLihfNpa1xjIKGWYFUK1X9w2tswnt01rsirBaqk2dUv3lvdMQTwtka7s8ZcdlXY4EkvcdmtvC8hlNfWyhy1Epj+NuBWRdXuymg8iESEMMbfan86bCjUvO2+iJDuvvON6is0SjEgr4s6GX+1p3lY/FPpU6MYhyokasJWQWyKKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769191434; c=relaxed/simple;
	bh=csK3wY7bomyICAtsjZxPNjTHEv+oqWqGuHEZUYxiwGo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bq/uG08sj326lKyGw6B7WjBFqhj0iu4MQE9HuiGGVNsfWnzI99wXrPx04g5CJ428FRYzrG2goem02Ve9rdHv70qelyMge4dqJB+v7/VBOrF5rdum8iJUuU4lWIPnxAokbGFpEoPbk0H36NdVCtM4xVbcTQIlWjoxUsQbNLE6x8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iVGwNKZl; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iVGwNKZl"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c54e81eeab9so1546428a12.3
        for <kvm@vger.kernel.org>; Fri, 23 Jan 2026 10:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769191431; x=1769796231; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QG6tBJ7Idtw9yE2G4FRQD7GOi3h3G6wNLsDk6lYZf1I=;
        b=iVGwNKZlCCpNlCDMjxSjSpoVMIP5+01dE4MLutcvVRxYeT9IKQpwpANKAGJQg89xfz
         DzCDv7rkIZ5Jz0gAu6wJdRRpocz32a6MgYBICUQbzXbNRpanW9SbkFJNXXf1uzO7B1ox
         MOHthga9BDk29aBcBqWGJQEjxGjo0taY8Fl1/hI9Wt+wWhaMlnjmuZ35IsaJtM1q3nYr
         8i50zcW6VeGgHvYXQlJzg7dxVOh1VVxdX2Qx+FZ3YPBOB0cg3sWTIZqw2ZBcEWchuMMj
         H/E9ISu7jQ9iphm90g1yE+XnwHLcSkXlZljkQ3tqbGybgSWa6JQILy3P+aPVAD6CgJ+0
         7IcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769191431; x=1769796231;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QG6tBJ7Idtw9yE2G4FRQD7GOi3h3G6wNLsDk6lYZf1I=;
        b=H4DFhyN84RlAyeMaF/SxT/x5GzWvxHDsdo+E1l5wwg649c/0sW/i4VgBfkVBZeayhX
         vYTJsl047TzeQ/Hy+mqIoE4usvoe//naMHmUovWC4t7UbNl085gwvI5SqvVttQ0yrNPt
         ScO9Zf1IdrRxkZ1iTerkBX1fdQ7iTT/Azoa5J0c1+yN119vvOGWtxwfQrY2/vOzOhy78
         Bq8VfsvjP3xMeUmQ5LYrFzja6D2lrVXL9g0dKCn704WDBSNgShKdoYvHYuZz5g+fuBlC
         eCkEzk/jQgzYSLboCJ3kXiypVfX3gsbeUZ93qH2DUAYxEp5OoI8j9jFlATtpGuCD5XKL
         z3kA==
X-Forwarded-Encrypted: i=1; AJvYcCWm6t4gNZigA8lTkQPN/el7CB16VeYhg2BxgrqevO8+HIWHJxJJMXIksADyyzKq+F2pQgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdLJdIPhNyRz64TsvAeB+AGm13uPb94Sty8tu+b+EOiFhLMASj
	FOTnGvpmj8q1BhfR3ghHOukpRKH5XHir8PaVGjFYDkQE6wnUW4pcBUzUaVlhktCez20IGkecxma
	UXXQkEA==
X-Received: from plek6.prod.google.com ([2002:a17:903:4506:b0:29f:1c3a:7fed])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d485:b0:2a7:c340:4c3d
 with SMTP id d9443c01a7336-2a80ebd16dbmr18180395ad.13.1769191430597; Fri, 23
 Jan 2026 10:03:50 -0800 (PST)
Date: Fri, 23 Jan 2026 10:03:49 -0800
In-Reply-To: <20251120050720.931449-2-zhao1.liu@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120050720.931449-1-zhao1.liu@intel.com> <20251120050720.931449-2-zhao1.liu@intel.com>
Message-ID: <aXO4BVo9nVaK7Nx0@google.com>
Subject: Re: [PATCH 1/4] KVM: x86: Advertise MOVRS CPUID to userspace
From: Sean Christopherson <seanjc@google.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chao Gao <chao.gao@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 20, 2025, Zhao Liu wrote:
> Define and pass MOVRS CPUID through to userspace.

The feature isn't passed through, per KVM's terminology.  PASSTHROUGH_F() is
specifically for features where KVM deliberately ignores host kernel manipuation
and looks only at the raw CPUID output.

I'll tweak the wording when applying.
