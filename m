Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2B33FFAC6
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511492; cv=none; b=dmwFI/OtYw7Z8AgDWOUcPTXUDRoIjJjH6ES2fhCu+F8jUY7xCtz+8hD9OBLA5UF6FgCt/0RUB5ICz/AbKHwOO3FdTZmwSn1Qufko6djfKGrw65m4cm8YmGX4yLFdwKkPndhwQDi71vbbvHCgCuMZtWpL/lmT6qpkumbkEnXx8yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511492; c=relaxed/simple;
	bh=HyctA9ruJdLXQrNgXC3tYUZI/xC2gvKU0L16p9xW3Qw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TpV2DN1IDDOoE3ILdRFGe2BwIYRAWf94RfxmvWAtjRPQrKdsitwn6GvX8NzrHM8OuXOVCZ7/JD7IFLmNKPVUJX4q+Mgj3BYkD11tLaVwOu5vabPJvI9Yyy2RC0YqyTNQC32ErRDpAwY3VV26nkGHzdLKqHSyYAe4cOLJTcm2ipk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kia6gF8i; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kia6gF8i"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c82751074c8so2318830a12.0
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 07:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778511491; x=1779116291; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Fy1wa5nHs9JHTWKOBvA60eVfLFvSI4Hq1+Dct5OtgI=;
        b=Kia6gF8iX7QKfuStbqtQfUbwBXn6ZQN4jWhWDDY2bQc+jdDnTXmuMU/CK4M2XHb5+z
         l+5YBx7aixOrN6w9HWzG3nIx0kUIMpOjlgBjaRSctbA9Z1EN8a2e5yzmJZCp+kmL8I/q
         +IxxrlUwz1PIvuAk5Z/VNGmLpSniz0LM5xR0xIm7b0WII5RNiz3D4kqm92KaA58p8/CD
         m/P4C81tuajTxvJozYMk6DlKKS9UiRJ5kAoWL/56fpWwfyVDD3/L1V/cx643sb7pdtYq
         kTFJDFZ4xWdDskr2Rq/cV+Xc9eq7Ls24A583oOGM9cQZeCHTTXjFSMwo0e4yvb8KKKfB
         YrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778511491; x=1779116291;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Fy1wa5nHs9JHTWKOBvA60eVfLFvSI4Hq1+Dct5OtgI=;
        b=UfvwRNUUnxbTJo6GIuHSqnd5+TsjQkQ60rOBOtudantZ1ifeSThuIrJWcXzJPaDnqZ
         RFg5MrguzU1fb2q6r2JG0JBMfmkaWHbi6JcnBNaCznh2WDSiZn+ikcs+2yADXW1yHhYv
         QvwubCY1s9wlb3CNkieh66q2ZDZidcer5GxdYdiZvtZ3dZNYwS4cMEgT3b8ZVlFasHnr
         lmMleJ17fNOECbpIwZfFz/5a81yAQQ88dJYa0J5UdsJKutl2U/bj5X7iFrHFwBoKt3B2
         ls9RqHvRvSdjLa9LuxI9knD9HzhdYZkZnTu6bMEYn2VIURhUcFd0SkNayvoMZF4XAPyh
         z3mg==
X-Forwarded-Encrypted: i=1; AFNElJ/H4AqkkYq57Bow7vSd1PVKBD+Pln+L4FvBTHhy2z01Qw5/H+5c4b9SK0qdPwqfeawuj9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0DbJPZpuKlEDrgEFq/dScbwN8yikll2tKRm6aOfXK2LsYavcJ
	q+dpZ7dK7mmxt/6M5rFreIGV79sxWymglsqkM39aon6bksj46X4GfCZA8aVQEredkz0RLBclYXw
	4L0xSsw==
X-Received: from pfbdu7.prod.google.com ([2002:a05:6a00:2b47:b0:82f:7242:4cb9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1989:b0:837:db4e:a35d
 with SMTP id d2e1a72fcca58-83e3afd78dbmr9504363b3a.23.1778511490544; Mon, 11
 May 2026 07:58:10 -0700 (PDT)
Date: Mon, 11 May 2026 07:58:09 -0700
In-Reply-To: <20260511113759.610924-3-tabba@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511113759.610924-1-tabba@google.com> <20260511113759.610924-3-tabba@google.com>
Message-ID: <agHugdIrptaXZW-2@google.com>
Subject: Re: [PATCH 2/2] KVM: selftests: Fix FD double-close in kvm_vm_release()
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Will Deacon <will@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, May 11, 2026, Fuad Tabba wrote:
> kvm_vm_release() closes vmp->fd and vmp->kvm_fd unconditionally, and
> kvm_vm_free() calls kvm_vm_release() at teardown.  A test that calls
> kvm_vm_release() and then kvm_vm_free() without a
> vm_recreate_with_one_vcpu() in between double-closes both FDs.

That's a test bug, no?
