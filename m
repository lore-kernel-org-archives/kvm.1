Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B27F392823
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 23:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775865517; cv=none; b=pIEWqacMGM/5PD8VjXAlvghMN1EzmGitWwQ+GXixyGg7x+pFCI9nB5hN46gK1ftwXmDBJ9/+UjhuBvinMgfhPVzZFj9MS9Rr4JYI6/FQUzCMLq/LyFSUdeMyGUMbHCksguOIMrDyCGGtPISkKVmgS7IG3y3SNiO4EN175T7PASE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775865517; c=relaxed/simple;
	bh=1MOKSAMPm6x30sr0qqDp+BjWEGIscNAAUZzfcWRnNAg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LT/pD0jzJWQi1nbXM1YFmrNoJoAYSgL5LnkNX8vjXNRQHc1GaSy4NnxMlALvZrId3ZJclMSgwRnIUY6K8B+6TZYylISpDEiP4ARKYpWRQWSIyzrly4CwlgwbO1wsWtj2He5Dv9qMnjTqChUYTCbcxk1y+aId72/rrgEYQmoWWuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q/YdWiFY; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/YdWiFY"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82cec239147so1605216b3a.1
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 16:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775865516; x=1776470316; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxwjf/AccMexmmG2JPBuy9XqLro5h/1RNCP8b2Jfgvk=;
        b=q/YdWiFY2I3f2M5pAhuTp/Nus5D3cK8kgc0+YoTpRj8LyxXcsRYBswtUSr2ZJ/SB92
         vfkdA73tv7ThoehNmUCcvIj6L/1MRgSFBrw5/Rg6MrKeje67bbioHqIuX5CT+5mmftAO
         k9JfIOuTZk4Ze4f4lJWnXMWknqsKjgL/+RdUPFNqs+fx76+hoNg+2HHW31BSsgG6qP2D
         jnQwIy0Dg+0uvEEVRABTqRC5fU7IpnyNTlx4i0EhJIRdGXcUVNwJ14qSayEvjoJPX69w
         JGBV25ANDs65Usmp6c5QXmIHLCUlfG++A/REJBHoHJ8PjZPiapeZ7Bux+PUhxywA75MX
         koIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775865516; x=1776470316;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxwjf/AccMexmmG2JPBuy9XqLro5h/1RNCP8b2Jfgvk=;
        b=MYHDPRcBVHii2eQ6y8lNZAYMyijcW32v3crFYQPY2QH66z9C+uG58DHEoKGlS2HJFj
         CI7M1gbaN2UN+jPxaReijtrEb5NsLVKZyQekP8kIxI3l4d3m7zsxsyC+1CCBfzlln8s9
         xMKr3YAK3TfuQZqbgZOTEPtVlDu8U16sXEOAUPzqIJ7pjizMSOCFMxWsYlke/3cnZwHN
         nU/uoe4zDXTuqtBvGQ2duncp5mnqx0IayHYo0EVtOQoh3XoLQnifpG8IIrrVWByL6q0y
         pNrw8mygrjlBO5HgI5IJwbiFuSpid99aSIvfk5G132XeHdGs3B4ARRsLopf518C/xfIP
         pp4w==
X-Gm-Message-State: AOJu0Yxn6o+PljT9T6v61qJR6pFkxnXg95ux0a7oRFcaXNhZKyEZNW7P
	y1V4CwqsLJ7FzPqbqwYD+bJdkNNwBqbb+Y1R+Sf0ZAjniO4UnjwQHWF1APbse3TcMAiPZPdouaC
	b5bofAw==
X-Received: from pfve19.prod.google.com ([2002:a05:6a00:1a93:b0:829:84db:97d8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c08:b0:7a9:d8a8:992a
 with SMTP id d2e1a72fcca58-82dd8a88f10mr8364794b3a.13.1775865515611; Fri, 10
 Apr 2026 16:58:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 10 Apr 2026 16:58:19 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410235832.2312342-1-seanjc@google.com>
Subject: [GIT PULL] KVM: x86 pull requests for 7.1
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

There are some "fun" conflicts this time around between the "nested" pull
request and kvm/master (RSM fixes, ugh), and a notable oddity: there are two
versions of the "svm" pull request: a full version that includes a large set
of SEV changes to fix locking bugs and then add a lockdep assertion to guard
against similar bugs, and a short version without the SEV changes.

I'm including the partial/short version as the SEV changes haven't gotten
much soak time in -next, and (AFAIK) haven't been reviewed by anyone.  I
squeezed them into the initial pull request because the fixes are urgent
enough to warrant inclusion in 7.1 no matter what, and the hardening changes
largely fall into the category of "these either work or don't".

I don't have a strong preference between taking the full version now versus
waiting a ~week to give people more time to tell me what I broke.  But I do
really want to land the hardening sooner than later, e.g. see the rash of SEV+
bugs we've had...
