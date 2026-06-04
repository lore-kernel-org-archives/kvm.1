Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA91835DA75
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780593834; cv=none; b=tDXUgl/RBGZ5tJQOuT8zmT+NUMYW/XEmToDdpdG6sSBvAMPQxl6TYmBOjCWB5PYI2uJNKI6/Q392pZMhxJFUti9HWq3cZjpmUc81m4LaxiDno4K4b10SwPcZywu/vW0l4OO4VuEiN3BX5jaPSg5sG5frGPFRUaNLBJPBdzGSQnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780593834; c=relaxed/simple;
	bh=LjLYVnR9m7bUQZQ3s8/GLfSPHl3AEWIEcB8mhwiUZi4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qGcZAzUyzfkL5cKDtKJ2SRsyko6pQNmg78DWjFad+R5XzI0Kqy5ushn+GugJGz4JCogQcjMBAPNk5OY6mI+g0uEFxcCEVlECBO4nJj6g6IdnZzNqVwqc8hD4NE1hBbxF3JTWtgLxXOmZnqs27bni0XOEi51vQgSvOSYwy+5O9cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xw29Ie2U; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xw29Ie2U"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c85798977dcso696686a12.0
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 10:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780593830; x=1781198630; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X2GFo4mV5KPCKDAcv8VIIj/ikLydd1CezVJZsdaGFEo=;
        b=Xw29Ie2UYrptQgk+g7ianQeRzz0qDxhWR6upPUO/tiZWMNXB2B5lPa3qwHGQCpbmgf
         ZzqTu6CgG3KZRVr/RxLpylF+lsoZin5iOwRFxmFjd9E1wD31ql0ULAZTLao64CvjvMqQ
         YdIw1d7Mat8QZpHCaEEZd+4WMXnqdnRoN1mT6+U4l8EhtsER6VMNa6o/XfgEP3LEAW7T
         LGLz65nleTQrQZuq7/J7CNL93TduoFpeu4NVFRlohxGZ5JOK4GeKyGVhjWAyUCS5tJnx
         LpMGW49cOPiCKp+8u2YcHu4niC5dd+vlfYm11Ae8v/ILfv+zFxZ8O+DrbDbxBe0J33le
         f+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780593830; x=1781198630;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X2GFo4mV5KPCKDAcv8VIIj/ikLydd1CezVJZsdaGFEo=;
        b=PEBr7xbqHGsb25LUKBS+9jtOzd6adgcmIW9HA+QhpDmw+pgHPphV89IVIZ0Pmg3zC0
         S/dXvfO7CRWY9f+BP2Vf7KT/fNKQs41WdqEd1rfV7FR8FHUoWlJpTQM1Fn4bJRfOkjKL
         ON1gdaEfRyLGPYAede6nOUIlNs2art7rWICE4b/9nhRIAkDzGJkAi5peoWPWbwslOYDq
         7Z7tccuHHBQGCOT9rXNSSXa+NtQ+wnWa7FV7BxFWqpqvVT+mU4Gqd++DS+i+95BXZhLA
         NKS1MO48EXcL7RYgftRphtBwmB0z+HtXFxRNc1iTwiLYpHI9TLW1IvuSXFa82jOtpUca
         XaEw==
X-Forwarded-Encrypted: i=1; AFNElJ9wu3uTQMqwTgakk6KeHWrIC52B8r8WWKwzgJUqO0EhWQDHgng753qNj6KWDMCnLEjlpAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJl3PICm3IXRrYlJVZDaSlXdW81V4Jn88HRx22ScKEHjnQ575k
	T3KDFylPaKn21JhWijH+u4bkRRzPiA+5iDklwfq0Y+r6Z1Ab0niOzD8ub/JxcHTV9OQ+/aF8h8r
	rwGNQxw==
X-Received: from pfco2.prod.google.com ([2002:a05:6a00:b902:b0:842:492e:19cb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e89:b0:842:3be7:4d55
 with SMTP id d2e1a72fcca58-84284e21c0cmr8923708b3a.11.1780593829857; Thu, 04
 Jun 2026 10:23:49 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:23:49 -0700
In-Reply-To: <20260604020143.748245-17-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com> <20260604020143.748245-17-jrhilke@google.com>
Message-ID: <aiG0pYJhZVnR4X2R@google.com>
Subject: Re: [PATCH v5 16/21] KVM: selftests: Add kvm_sched_getaffinity()
 wrapper and convert users
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 04, 2026, Josh Hilke wrote:
> Add a KVM wrapper for the sched_getaffinity syscall named
> kvm_sched_getaffinity(). Convert existing users of sched_getaffinity to
> use the new wrapper.
> 
> This helper will be used in a future change in the KVM IRQ test to
> migrate vCPU threads.
> 
> No functional changes intended.

There are most definitely functional changes, because not all existing callers
assert success.  They obviously require success, but adding the assert *is* a
functional change.
