Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468662D2488
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905458; cv=none; b=hnGuQo6Q0ta8QEVYvxigzavgGQV8xMbVJlOD4HPtQR14+/P7uQhE7WOf/060sfyBDqFRKs6HsQ/Jo13YP64L74cWxB6g/XREaMyH9TAMd+SwP2wUBeAWQ/rNg4TySUOmbfum/AKTZijZENpn9CN7ecS1qCdZTe3c8UGRl0lP6x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905458; c=relaxed/simple;
	bh=y3QkC6NdVsxhUNUmyWze1KxlYqZA3u3QqoJ/TOXmHok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ny6fJNwfhYP6yWhFCyJlBtU2q7e872oWYHzBO4krJzEs+vnP2IkuY9iA8gtf0dDQN/Y+xb7r9L4EItBzsd4dgm3+t9OVHKskzV8ktyg08nN0MGPRR6hVk0AFNS2UBzqcooN6RRRaCu2tAXs3ud1OEIjfyq7jw/Rb5wLF+kAW2s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D9eqeu2n; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D9eqeu2n"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8271fb43d0so6798304a12.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779905457; x=1780510257; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m5Df/rMk56MT9bj31CG3XuXdS2MrN2pmxaqkkM7MR/k=;
        b=D9eqeu2nbmOACFEJ40G0MGbHzp97It0S2oAjAGh+0gC5D5O8XTzcl7akztZ0spZY1G
         G+L52i/SCFM+KmbNwf6BjHGhEldaq/FGbt1YjFp2pb5TgYwvjF92DOtoXMQ8kCXKXEje
         OSsqpN2e1XIMTEIQ+Xiz6fPStgSkgooYwww95qgAOs5sgp2VMswASbvUAZnxmtrpDW+c
         EdTt5PeGMmV1l7xZN3tGufCzfhTWwy06/patnl+7dh4PY5IE9kmZpbd4rQtyWdTOrqtn
         4r8aKzDN/8PxlFmVWCMuQ3zFoPVpFfvMO7s+A8DFbybXkKzAwEvTayh1zJFnIKQWRfK0
         FxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905457; x=1780510257;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5Df/rMk56MT9bj31CG3XuXdS2MrN2pmxaqkkM7MR/k=;
        b=q2PMQ+6PYeQjIP3Wm9YLX+d8V3zxTosmZtKay35ftzlMDfWyc7eftZa4VxO6mkhaoi
         cLURn6zEMRwVSe9zDtj9gXA8sMmRviLWPOcMh6lTNPUoNcnrNiGa7Vii4kYbtGVHi9PG
         RT+EOVACNw5ajQCxZENl8g/gymAUIEQZSc6r1lJYxsgbx2MahT5MbIVWUX5xak8cGSVR
         IpTFW/1aw7VJaKCdEaH0b7jXtyK26jE8A7TqSqV9amyIr3JYpldjjiboN996pOBqHsRn
         TruEAuVdO0yJzL5kTbuhMDr56OvCwPqe0pBn+J4udNBwmuf0IQxHLoydaB/8Lp5pgOVG
         POpg==
X-Gm-Message-State: AOJu0YxdPAERkKzd57VT6FX3GJWPXYQtjW9BZ32BhBr9tJP7mB7a0fMX
	ZUihHGKf0TMmntsvVi6cYtwhFUcaro/+NwGOyijDi4o86PnVBbYr+mUNKE3evZUl5GcF27PURMk
	xRpxykg==
X-Received: from pgkn21.prod.google.com ([2002:a63:ee55:0:b0:c85:a9c:435f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:cc0e:b0:3b3:bfb7:c0b1
 with SMTP id adf61e73a8af0-3b3bfb7c122mr7486593637.52.1779905456438; Wed, 27
 May 2026 11:10:56 -0700 (PDT)
Date: Wed, 27 May 2026 11:10:08 -0700
In-Reply-To: <20260522232701.3671446-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522232701.3671446-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <177990516610.4120256.7155571176318781442.b4-ty@google.com>
Subject: Re: [PATCH v4 0/5] KVM: X86: Fix nested TDP error code info
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 22 May 2026 16:26:56 -0700, Sean Christopherson wrote:
> Kevin's series to fix how KVM populates error information when injecting
> nested page faults (NPF on SVM, EPT violations on VMX) to L1 during
> instruction emulation.
> 
> See v3 for the full cover letter.
> 
> v4:
>  - Pass @from_hardware directly instead of stuff a flag in x86_exception.
>  - Use the bits in @access (thanks to MBEC+GMET) to get the fault stage.
>  - Check the entire PFEC/EXIT_QUAL in the selftest.
>  - Use hardware _or_ KVM information, never merge the two.
>  - Name the selftest nested_tdp_fault_test.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/5] KVM: x86: Widen x86_exception's error_code to 64 bits
      https://github.com/kvm-x86/linux/commit/bb24edbb673f
[2/5] KVM: x86: Tell ->inject_page_fault() whether or a fault came from hardware
      https://github.com/kvm-x86/linux/commit/fe0b872d7500
[3/5] KVM: SVM: Fix nested NPF injection of PFERR_GUEST_{PAGE,FINAL}_MASK bits
      https://github.com/kvm-x86/linux/commit/297c2fe249db
[4/5] KVM: VMX: Synthesize nested EPT violation GVA_IS_VALID/GVA_TRANSLATED bits
      https://github.com/kvm-x86/linux/commit/96b067b59ad9
[5/5] KVM: selftests: Add nested page fault injection test
      https://github.com/kvm-x86/linux/commit/0de1020f7bbb

--
https://github.com/kvm-x86/linux/tree/next
