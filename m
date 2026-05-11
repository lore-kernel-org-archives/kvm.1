Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DEE3DA7E5
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511598; cv=none; b=mgfOSMjdFenJo9acbbKlP39JjiH6mB1Xy+8yBruG5E25APjgtURgyoedjG5NnR25QJ5sYOMJppp4OC40QsOVCCq93jXr3CUB9Vuuh+414T3/FI4xaWkfgUhwDjgWvv/EDBSntcKHQZwHIlr72i+98GoYWMjb7RvNGWlH8eJUWbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511598; c=relaxed/simple;
	bh=ZMLJorGRDLuLGDQaifkVphFcd2Gm4O18yI8qmtudl20=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hrpVSRSlzfl02cZW31+DMI4z3WBNeYR3eHmV4kz1c5OQBEuGPfd8buD6a4j6QnpmplmItvu0xNWjhHd/Qa8jptyepaR0CC7w/5OAf3eXUcKDnT6BrxG9CVnyB3gCsoM3acF7f093V36DTt161lGtcod3RFgR8iLFRN2e8XnEtr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o/hTYTM7; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o/hTYTM7"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-836d0184333so4278793b3a.0
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 07:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778511596; x=1779116396; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D1G5BQDNCElQMhRaqBFDq8nj6aplN+o28Im2m1TUiS0=;
        b=o/hTYTM7iDB0eysqilcKdKexvGqPK1VSMeVvLHf2vB/PrA5zpkJbeTg0hf4JbLIzvD
         ZLdGdq/TXRmVSv4nuwcNNjIMoR+B2V/dJwGTE+FrMseG33bruNoq0C8IQoW9OsHWX8/J
         lQ7E5oD0KwmLISMSN+Jcx4Y+fIDG8F1o73s25VmNqs/A8/bFbBxNUwm0oVbyGIFSX61C
         D0KfYRYFJPm3tHYJRtjPx2JhgkDxgXjtSf2Z/nqBNsH+J3WL00XyWDqFwy85MnU3gRTX
         FNqtuGj4CWIOr733ZKDSAUmxNp4TUfV54xHIEqexmHzrMP9xdqFmclSPpGCbiLnPcSCr
         m3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778511596; x=1779116396;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1G5BQDNCElQMhRaqBFDq8nj6aplN+o28Im2m1TUiS0=;
        b=jH/Mcs2eD67fBMgiL8P2Ll70e9Fnf27pWj4zRFIjebLzP0LDkeZ0E8X7SrP5Vh6gOm
         51jMM+5tt+ZSptjlgU3Iu72+qTsNdph7qx+j0nUqTwmfk09eVeGApFA/fWAoAnYR6iPz
         YFUOYHg07rKJ4UscfNfkx/gbPLI3+DNWI8yLJRggV1g8XoPi8EZ6OErcue6pR8gf+RnF
         DcXfVv2TPHFKI/rerhMCUzkG7n+C3dDSI6ywuQ8nQsd5I+/FmC8VLU/qdt3vgJDfs5q0
         zdh9JEkDjOXgldQ/S7oj+kO8VGbherVwKGKMCW8hY5puCBDLlJCyYfLbRThYsZ1TPW8U
         /hdA==
X-Forwarded-Encrypted: i=1; AFNElJ8pofwCoHjRhbP3ucDMDKMsgmBSKiRZ7X8YIEPUcEUsx9TiEyXxlypbCS/ebmmR7kw7P5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyijZylStUWYI3iHD+/5iVvQlw1PwntEIL44rHBpEbdJL6plMG0
	JQBle8DgsXid9fwAu6ez2eVgC6DjmwR8kuwsYPKlCYehHslZAKGiFi692HP1VQCj7DwYxKV3PXI
	tZHQTTg==
X-Received: from pfbmd16.prod.google.com ([2002:a05:6a00:7710:b0:82f:c134:e67c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:198f:b0:838:1ece:9716
 with SMTP id d2e1a72fcca58-83a5c5bd45cmr24637410b3a.22.1778511596079; Mon, 11
 May 2026 07:59:56 -0700 (PDT)
Date: Mon, 11 May 2026 07:59:55 -0700
In-Reply-To: <20260511113759.610924-2-tabba@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511113759.610924-1-tabba@google.com> <20260511113759.610924-2-tabba@google.com>
Message-ID: <agHu666UaLA3PxVe@google.com>
Subject: Re: [PATCH 1/2] KVM: selftests: Fix MADV_COLLAPSE build failure on
 older toolchains
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Will Deacon <will@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, May 11, 2026, Fuad Tabba wrote:
> guest_memfd_test.c uses MADV_COLLAPSE unconditionally, but the
> constant was only exposed in glibc 2.37. Distros still on older glibc
> (e.g. Debian Bookworm, glibc 2.36) cannot build the test.
> 
> Add a compile-time fallback that defines MADV_COLLAPSE to its
> kernel-ABI value when the libc header does not, matching the
> established selftest pattern for sometimes-missing libc constants
> (see selftests/bpf/uprobe_multi.c, selftests/mm/hugetlb-soft-offline.c).
> 
> Fixes: 9830209b4ae8 ("KVM: selftests: Test MADV_COLLAPSE on guest_memfd")
> Signed-off-by: Fuad Tabba <tabba@google.com>
> ---
>  tools/testing/selftests/kvm/guest_memfd_test.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
> index d6528c6f5e03..45990ae5f1e5 100644
> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
> @@ -23,6 +23,10 @@
>  #include "test_util.h"
>  #include "ucall_common.h"
>  
> +#ifndef MADV_COLLAPSE
> +#define MADV_COLLAPSE	25
> +#endif

Fixed by:

  https://lore.kernel.org/all/20260428012503.1213654-1-seanjc@google.com

I'll get that applied and on its way to Paolo this week.
