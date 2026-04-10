Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766313932ED
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 23:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775865519; cv=none; b=PZnPD1D37+GGn4rTpSUfZ/FNG1lNt2c5jc075Zm/M7Fb2t5q37lkvhMuBafHEOIpTUkg+/8uw83I1wQICgDAma06VFL43kYsSwDNcSDwDbc0rD+Rf7FFN6ITTc0mMjJsxUzQHiUw3Ppm7tY+uDjYMwxb9HrCjoFtNkDviRJ9q+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775865519; c=relaxed/simple;
	bh=5BNjonrhY5Jj2YwVRRD8rRS2Uxl6M7hAECkLvSNOs6Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JPbrLjxCeySfHIwS2vzMcvhbxrNtWfib4h4lZj5YybR0V3iu+RWbF01j+PrQAJRKndElCQ8gMdlAcnPFCTbDQjDKMYw8vOqPXEtPoEVqbBdEOzK+A6/HgDMLEfIH3hNSPXL8c7S4qPUgyXHuXXPxNw/jy5wbz8S6VGnVJYENaYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wlfq+4yO; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wlfq+4yO"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c76bb22a8ceso2850721a12.2
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 16:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775865518; x=1776470318; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ojgydLaQuzXw5pSKPS8lWhc5zn5aHnYIVZ00YkiCoQI=;
        b=Wlfq+4yOPSyZkvEZmxW/vtq052e9jRN72OTbmgR1jblbt6e9/KTBrMrvlid/p1EuSt
         xBsPmSJAQ4Bsjo4fhYNA07BYIafS3p1RBky27DAJo21FYQUYI3b7WhRd+Sh41F/NUqtC
         ArLh2ambLqDUZ9v0i3dWTX8/cpV3Ly8RRzf0Xl+lnzNS9g9nzXoux4OlMltmrXzLeA9o
         wMwkk7fSKr/3mGd56RXrX7LiCNzUuV4nb+IxSPtjIK49SGMHHlS6LAPo7dP+iTUj1tIk
         Z+C5zJd9muaidaHukvkLfJofWCKK0q/TsvIbDCd6UxWIK9PpPmVeKipsI+WLu53y4t4n
         S9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775865518; x=1776470318;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojgydLaQuzXw5pSKPS8lWhc5zn5aHnYIVZ00YkiCoQI=;
        b=G4TWr/CE3q2oF3WAeNaEJvLPnNODwEqVCX4kKRTCp8mQ4ofBkq6qLUrInNpzEH7Lh6
         3zLIR5qWvt+nx+PDQKYjgTzsQZ0X84pYNkSv2zS7BDeosenp+KPP3uws07vvWnuykOv6
         IWjYqYcfs9nXoGSCyDnI4a0lArvu19ZpWig7zMVD8yovA2k7B+JPEWWSZJWbLViFicKf
         aquy4PhlFm7/BVui7glRoQxmHwYIqpi2Eu61FV178lDyaeBr2DHW6eizgNC62AxE2FOR
         7fH8AuH9DJmjBFnKjwVf+65+YtfCloaKh5FyKjTXGnQsOia13aaThTVcwMR8GyXoxsag
         oH+w==
X-Gm-Message-State: AOJu0YxuEqavMEs4315vHrpVqNmWo9Hr37Knw7zFaQS+7lKI5kdNp0CK
	KvLRFKjrdScM+cx9+nEE8UoJkWOABh/RqSIfFBpOAWsVsjz9hgPLziUiHd9bN0aXeyC5vGvbtQy
	SvczqVg==
X-Received: from pfbhx7.prod.google.com ([2002:a05:6a00:8987:b0:82c:e328:c322])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:98e:b0:82f:111:61d3
 with SMTP id d2e1a72fcca58-82f0c2c44e9mr5304021b3a.44.1775865517600; Fri, 10
 Apr 2026 16:58:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 10 Apr 2026 16:58:20 -0700
In-Reply-To: <20260410235832.2312342-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410235832.2312342-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410235832.2312342-2-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: A lonely fix for 7.1
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Please pull a single fix for 7.1 that I tossed in a "fixes" branch with the
intent of sending it along for 7.0, and then promptly forgot about.

The following changes since commit d2ea4ff1ce50787a98a3900b3fb1636f3620b7cf:

  KVM: selftests: Verify SEV+ guests can read and write EFER, CR0, CR4, and CR8 (2026-03-12 17:31:53 +0100)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-7.1

for you to fetch changes up to 2619da73bb2f10d88f7e1087125c40144fdf0987:

  KVM: x86: Use __DECLARE_FLEX_ARRAY() for UAPI structures with VLAs (2026-03-12 10:56:10 -0700)

----------------------------------------------------------------
KVM x86 fixes for 7.1

Declare flexible arrays in uAPI structures using __DECLARE_FLEX_ARRAY() so
that KVM's uAPI headers can be included in C++ projects.

----------------------------------------------------------------
David Woodhouse (1):
      KVM: x86: Use __DECLARE_FLEX_ARRAY() for UAPI structures with VLAs

 arch/x86/include/uapi/asm/kvm.h | 12 ++++++------
 include/uapi/linux/kvm.h        | 11 ++++++-----
 2 files changed, 12 insertions(+), 11 deletions(-)
