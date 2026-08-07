Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC938F65C
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119947; cv=none; b=lt+X1l3QFZeZ9VuaG38j/vXZOQYLMtx9XMnAFpCgKogZ+mRYfchjlK+Bxrj8tV+GCjllue6sWflaWwGJ+3PVDTpYf4YGxDuuDqNo7q8ACrUUUe6SSayBJocoNLb1cu2NQjBR4fFv19ayi8lk3WPMD5U+/mhzrvNY/pytPLRx2lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119947; c=relaxed/simple;
	bh=wokdtZFwv1O+8K0dT14dhNo6bFiGIoZFgO9rRJxRDhc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P3+fRQEM+JyEyIvHw363EhhEep+WqEgxE/UHPU/FpUCBnVltZncfMUpKhTLhW/lKkQ45ud2nVPyA4wT6eeN6UyykxMK2WKm76n0kd1EFuomLNjYtC2hEypGKlB2FFBhtdUP9CSk377XNr7VIMe9xJmJ7WckluCSui0930h0frn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z4fgoQqj; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z4fgoQqj"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb835525b13so4216810a12.1
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 09:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786119946; x=1786724746; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V56oUIIu6VzkwUTKOA+t9IfMjOR0NdHo/09oAqD7TkU=;
        b=Z4fgoQqj6q9SVICGxvn/sPtRS670OCeZgk0FkhmmtH2ypgN6wIvitYwjqdYvR8pDgd
         g/dkyxv754ALmeq13y4dJfA/cH26Ka3KdXQgjSXy9bl3+pXvUSamP0IP8TmEi2xTE2ys
         U3uqd3FDBWhB9lYrTQxVKyBJFINNaTC8+7RhF/EwyK83G4CGqoVD391Byi3hai9iy45v
         L86sCHQV8PvwDtDVH500slNqqsjQVxn9HgaxyUxx7C/l3iSfrlgLbyoXMM2GIvO+8iUM
         YSmg1Ey+VZS6gnEzXq1Gi1lJJkKL4XucYDntqbgb9EixpXGjX2woQY1K/HPqueDal+QG
         PXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786119946; x=1786724746;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V56oUIIu6VzkwUTKOA+t9IfMjOR0NdHo/09oAqD7TkU=;
        b=ZBNfs+guGwifZaaGWUNt0ZODgPnPSyX4xY2F/v1ofqQKJkwIf+WBchzpcMNg8/LWal
         1dJm8k5xQrzO0JDVjl3HPvc9C7LGEdXAd4XjcWBEKGT+XFCD+Rb5qX1UZYZdzJZNiecA
         Y0qdOIk6SguA2f41+qYi6sJnFVcJrgyy2iQSpEPGUQG2FoRchIa6GXgjq4O+GBm7CRm7
         iL4z+CPtfXRRIjuczN0wLjKgPelUQB9BvTOHhBGxmpkodD0Ii6RPYSGpP3zfVR/uLPqe
         /UMsiH71E/YM0eVFT9DzdRO4z/7+UaR+p1/wnaf+lbb6B4oFvsrzwgTtkPwTV4oUoxGs
         HXdQ==
X-Forwarded-Encrypted: i=1; AHgh+Rre5Yzinytopp01lE4zlKGXKLdQXnGTdy4AbWI8fQRBTyNRCL43vNNMDhZavtSVyqN37/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9xew+h7U2je6/6+HNm4Y53c2nrtspbUbHkJsPDXHlfCmVUONv
	tnq/3uU+wdxm9/TMLcEFT+1Zy3k25xzFaTnNtzih6jcNI1lnpY7dceamPfX8zNL5soyoflwT0Ze
	AiTtW3A==
X-Received: from pglr15.prod.google.com ([2002:a63:514f:0:b0:c9a:7d72:c316])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e212:b0:3c3:875d:c538
 with SMTP id adf61e73a8af0-3cbce6cb229mr1717985637.8.1786119945574; Fri, 07
 Aug 2026 09:25:45 -0700 (PDT)
Date: Fri,  7 Aug 2026 09:25:23 -0700
In-Reply-To: <20260625090155.6326-1-likexu@tencent.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625090155.6326-1-likexu@tencent.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <178611942092.345606.2838239310066339524.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86/pmu: Clean up vPMU comments and stray blank lines
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Like Xu <like.xu.linux@gmail.com>
Cc: jmattson@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 25 Jun 2026 17:01:55 +0800, Like Xu wrote:
> Tidy up the x86 vPMU emulation code and its selftests by fixing comments
> that no longer reflect the code along with assorted spelling and grammar
> mistakes, and by dropping redundant blank lines reported by checkpatch.
> 
> No functional change intended.
> 
> 
> [...]

Applied to kvm-x86 misc, thanks!  Note, to avoid a potential conflict (I think
git's handling of code movement depends on the exact git config), I squashed
one of the selftest comment fixes into f6e01d4fa1e8 ("KVM: selftests: Create
one VM with many vCPUs for each major PMU counters test") that's sitting in the
selftests2 branch.

[1/1] KVM: x86/pmu: Clean up vPMU comments and stray blank lines
      https://github.com/kvm-x86/linux/commit/66ee8f155657

--
https://github.com/kvm-x86/linux/tree/next
