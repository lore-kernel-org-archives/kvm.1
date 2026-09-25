Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65330509EEB
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790376331; cv=none; b=XQooFm4kynzVIzFcQ8Gnvy9kEr/XU99a1B92WquWKXUce6niUjGpP0DzrYg0t4CE7mOTNfyBZDzXGamKYE6dsTQwBUvXngfEW2w+4jdyhH8rsFod9LLtD78vOp37herbVsvkWp+AiKn2eifmUw3BuDHyU3qRSEW2KO7L6hT0qTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790376331; c=relaxed/simple;
	bh=6cKteXVKQNu6j1iDV0IrXiC/q2L8FWS9DWXUxR+6VcU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OSC9vODU+L8Qck+1j7U7khkijQC0yZQESjaSUngi0eNzuNgta1qJV+nD18YhXrKuj7actJbDbAHsyOMOFcXUIcUFhRnCUuUKBVikK4lGGBfhSNxpZRnidr7PRuH3SkOTxIhuwIX8EAELNZG4eZuRSrgOxID24G6zylh5WOckTAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S3q2HhWy; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S3q2HhWy"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3968bb86fb7so1466126a91.2
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 15:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790376330; x=1790981130; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QpJAaRA5oPU+jEqf0QTawQo0EHVqddCOijLczxIlXSo=;
        b=S3q2HhWypjxSMI+Nacan1yzPyUTeKJtc6lZDU7+Z2OePnMmG0Mf12f+Ym2B8WOa//F
         HBYmSatpvgfoUDEztspL4gv7AxlL5ohD2K/M/yrqZZPo2Qk1YUp25DX/tUKCYuxYCm8e
         42DgbrWML+hf+QBxggo61WHaTY3QYASBddYv5UxlShvuOii4qulycH5PfqjjciQ+NKk8
         ZB19qcYWYCZ60qt24F9sPKUTP7uWaIBMOyPseaC1rqZke+1NLC1O3eoKSOQQuTxrADQX
         MZ+DbOjPgiYVF4YD0C/Th2khMgoTRwEy1tFqmdtjAg43u1CV5DtRHRDwnmQzPNd2YjzW
         dd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790376330; x=1790981130;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QpJAaRA5oPU+jEqf0QTawQo0EHVqddCOijLczxIlXSo=;
        b=dvfk11l1G33pSEVJkGqZZXpmiVYqcc9SHJfD92xO45nQiIgvugnsWtEGBGzfBMaSu/
         fktvZjxNOS/cmsm5CJUKp8UqqQEFlsSspmz4UP6O7rNEbumi9KEiGJLmCOMDpToVecrG
         zgcSTNFKvZa++vd8+rWr6nDnw9YGM3Q/zpnrVRqmQ+G7XLDP7GuBvpBUMqAiN3oDpJ3W
         XrZcTVdq7I3j1cR+yro5wFFnY2Q17re5Fx4oqMPOudYXzXxPK+NjPb50JsUW4wpvEYnu
         DrIaNlX4brt/LcQKNhWl3MUybkBpe2t2dUWzB/UwgBq+lr8QDKyYLYJrzpOCyMdu6u1F
         Ml/g==
X-Forwarded-Encrypted: i=1; AKwUvBxSd9fQNQAuti0Xcv6cKw1tI2kzf8l7jTMvSVvTBHEMPeCJW6q0vyrgdlVu7HRCjol530c=@vger.kernel.org
X-Gm-Message-State: AFuF++lZlr1PJNnOEfV8y+eD1rciVIX+5OISkpWIQ/Y+P7ehhH07vLTW
	GNLelsEE32DvDYx4rVJlr3qdEEL2sF91PaYRGx790BEPs8LcS65IAGbBYRfqvE0Zv5Rk20oSfg6
	qxTQWAA==
X-Received: from pgut8.prod.google.com ([2002:a65:6088:0:b0:cc7:6c9d:d39])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:510a:b0:3a0:9640:802e
 with SMTP id 98e67ed59e1d1-3a0986ec975mr6144420a91.8.1790376329481; Fri, 25
 Sep 2026 15:45:29 -0700 (PDT)
Date: Fri, 25 Sep 2026 15:44:57 -0700
In-Reply-To: <20260512210847.3039048-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512210847.3039048-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179037625346.2353373.17509444671245229087.b4-ty@b4>
Subject: Re: [PATCH kvm-unit-tests] taskswitch: add test for ICEBP delivery
 via taskgate
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: dwmw@amazon.co.uk
Content-Type: text/plain; charset="utf-8"

On Tue, 12 May 2026 23:08:47 +0200, Paolo Bonzini wrote:
> ICEBP (INT1, opcode 0xF1) generates #DB as a trap, and this
> triggers a corner case in SVM.
> 
> When you get TASK_SWITCH (which always has fault semantics), you look at
> the vectoring event type to decide whether it was logically caused by a
> trap, and therefore whether to move %rip forwards before entering the
> new task.
> 
> [...]

Applied to kvm-x86 next, thanks!

[1/1] taskswitch: add test for ICEBP delivery via taskgate
      https://github.com/kvm-x86/kvm-unit-tests/commit/2245e28da7f7

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
