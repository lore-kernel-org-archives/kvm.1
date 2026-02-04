Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E398E34CFCB
	for <kvm@vger.kernel.org>; Wed,  4 Feb 2026 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227257; cv=none; b=fJCpSU+Do2tZliRZJjH4yooabNEK5SascdtLUwp5T99C6zuwdtP27SnTL8tQphFW7pk7M5x0F3eKEx0FgfG5KYO47Q32p5TqBky+9mMERiB+SC+GwhjoHznDPXZZWAud4OZ2XxI9vaP5wPN3dbldq+W9c5ay6WAH55lATtfzIGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227257; c=relaxed/simple;
	bh=G/iz0gJnurETI72RPB+lyl2ADVfXCuht+vMuJzzI734=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dqBTHkX6zD4HXPw4RlIbbO2H2mtefe9DoMB0x+PVfbnAD52qbhDOCAKzSrFuqCAe30IH4hTA/pmJxEVXrtzXDJzndHAiFz8hzQpQTfvq0t5iQkvFxj4vSeabYJBZgywxjpxGN7c9G3+NAdQVX98VMAyRWlTW2VXZVB7+32kG41w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZZd1xe9L; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZZd1xe9L"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a7701b6353so701805ad.3
        for <kvm@vger.kernel.org>; Wed, 04 Feb 2026 09:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770227256; x=1770832056; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mKrgzt8z0pdvNrcNilJBEvk9edIYhX3TFjf0EOFgAkI=;
        b=ZZd1xe9LFm9rj+5AWN0dsEWIXZtv8+edio4duAhGfa0kdbiY2TSuYCuvGGPmv46yNy
         CGGvOPwE/3WIUMqQYJs4eQod+oBuj2ONkcHHnIBqANuUG7oyu9cVLlN2hh5wEfkHs64J
         /X9j9LEaS4BjRrlx65TfPlcbAWU+XcQc7T4NmbiPUyGTQxdP8syMkifz5F3gFaR2rOWM
         iguNVvk1Oqnh7VrsvuIO71gLiBNYX00KDNmQnlyUIlINOroMjE99gSiDzkJQH+f2bfov
         cLHKHjw22i3ES1IRXNQU61FkslD1SoaviWP/dVsTEDDGb2HxmYb6qKH43BQb2Rr1ScmI
         pewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770227256; x=1770832056;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKrgzt8z0pdvNrcNilJBEvk9edIYhX3TFjf0EOFgAkI=;
        b=wvHb0rCcxHx6gzU7CHWcMPMu/ZKMjUe0KT3hRsTePiXcZ0YR2nXCBKRpy/Gerccla0
         ncR1cUnzaL9Wi6QujP7ApYR4RhYmVbrw4hul6NcFPTqNQtpz3Qi2VXE3Bd0HrILPgBj8
         fuA0hwjoonpULpOYDt0+8JsRYBMM2WYFsa6SPjQHMOMmZcnUrT5K0mgNZA8lA+tvk9Ja
         7zIY9kV3zhg67lTgrxGV2zIP1KTe2f3S7AbRTrKvIMqb8fqtpWGCkK2mKWe5tiQ6ULBx
         y3EPdxxZUaD5d1u6cuNtKD+f48WvxMt0j8cT7navXdhqqGPI9o31kWtBX/WF1ctzeeYY
         CWzw==
X-Forwarded-Encrypted: i=1; AJvYcCUpfCPGUsmPCm/HwCUKiDg4eZc6TIHKYYXbXz3qbJg1kOftTNn2eTkb44QqAgK6Q9frjg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpfBEV7LBGogAGKvDgV8FScvywxUUAfghKWC74oHha0yLfH9e5
	FyAR1iqcZISlvG1K8PTDZb9Lc3LPEqtDKAoupec++wPQzU73e4F4xb/aKz1TZtjbH03th2ue7/Z
	NJpRU+g==
X-Received: from plsm6.prod.google.com ([2002:a17:902:bb86:b0:2a7:5b68:f493])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:24e:b0:2a1:1f28:d7ee
 with SMTP id d9443c01a7336-2a934129a86mr38780525ad.57.1770227256213; Wed, 04
 Feb 2026 09:47:36 -0800 (PST)
Date: Wed, 4 Feb 2026 09:47:34 -0800
In-Reply-To: <20260112182022.771276-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260112182022.771276-1-yosry.ahmed@linux.dev>
Message-ID: <aYOGNr6Tag6tU9HP@google.com>
Subject: Re: [PATCH 0/3] nSVM: Minor cleanups for intercepts code
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Cheng <chengkev@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 12, 2026, Yosry Ahmed wrote:
> A few minor cleanups for nested intercepts code, namely making
> recalc_intercepts() more readable and renaming it, and using
> vmcb12_is_intercept() instead of open-coding it.

I'll send a v2.  Fixing the vmcb_mark_dirty() bug yields a fairly different
overall sequence:

  KVM: SVM: Explicitly mark vmcb01 dirty after modifying VMCB intercepts
  KVM: SVM: Separate recalc_intercepts() into nested vs. non-nested parts
  KVM: nSVM: WARN and abort vmcb02 intercepts recalc if vmcb02 isn't active
  KVM: nSVM: Directly (re)calc vmcb02 intercepts from nested_vmcb02_prepare_control()
  KVM: nSVM: Use intuitive local variables in nested_vmcb02_recalc_intercepts()
  KVM: nSVM: Use vmcb12_is_intercept() in nested_sync_control_from_vmcb02()
