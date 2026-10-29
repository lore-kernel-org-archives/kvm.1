Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793304091;
	b=EEot3OcE5doyIjj0FDGE/Yuvf1NoUtBIZyDj2abclvtfrocEs3gaJKgQBIc4sWMHU50V
	 QwByOrk9JOQmtYlPXNkJUO2q41NX0owAg9JXnI43IhhfBieQ8zHl+MCPd5MnAbYuw2T2w
	 PMUf1I7+pSBfnBD24nki1wNkztkNhoY1Vk3uyyMeGCZ9ZrP0hmt6DBLCn+iwpbf77hgop
	 ps57Qh1tb1k8M6dSTxMZ6YBs1ET4SpM2BBCHydF4o5lxuTCX0qY+ZRqW9NcjOyCuAJ1cY
	 ouwYP9p6xegSkHLR7rhg9VYF2PHf+vnAGf4Q4vJPBmfCIYVtNPB7dnW3hLkXdwfEYvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=41rEEZJHQ1b0lZW5NZ/hL5Z21i+HuFKPEi+1JbBpXGc=;
	b=upAT/1waEypzcoTVsWiX214Gxq1F6qeLlBhhMxIgFdZe1NuvZPkZGR7gQWoAgsuTm+I1
	 xhLSvKc/6tvhFNMxG5AvHCdFP2jpyKJWWVRGIO+wR5gpbRE6L2KJtQFjVeYcpeOA2xTsq
	 AIVoeeoj71bG960mYuIYckbGqtlHZfCNosh8ygN6WVeS3fO3UnNSiH9M0yg3XgsTOzHMY
	 GPrqsjtjPqLf0r1aXjlhuj4p8F/AmSEjzyss9Kup0zTjRrK/DCBO8iXqCAqxtWuzwiWCX
	 AYSiXK3JMB0oO9ZCel2QzDTMj63FiVVycmyknQSW6tFIC5ydUmP1tadPpLe0RN6E0Tg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WzkVwYzI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED69606A31D
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 20:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DED69606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WzkVwYzI
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93f22a8515eso217346585a.2
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 13:01:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793304090; cv=none;
        d=google.com; s=arc-20260327;
        b=mXQWUm+fhgQtLxMrLvZmTEQo46Bb//vApcm3fLas6asdGAnnTDrEjQh0Knfxc7r/8L
         wdPe6c0JnZt1pWMmr67xHUMkr+b7rUWUguFgtDV9Wphgg100KuYJ2E7uCKepO4EQPRw0
         IiTs9XKT0esnOhxmR3lhTakJZh0hWnwsg9ZcOFtCCvPba63hIrF2GBZ/imDxR0UPUpS7
         VCVN/bqxVjnArQIHlWamW9/9wboicgofKpJp8tnOwP4lBcNmDKLPPeemEujBH72WOEoP
         72B3nXZX5JFWaxfn9ZAb8mQa48YvNkZ/8LRyqews/Z/NIQw+HxrJEvRYVbM4pcK5NUw7
         Ligw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=41rEEZJHQ1b0lZW5NZ/hL5Z21i+HuFKPEi+1JbBpXGc=;
        fh=u4Eddgn2fEuYtFIGkfKtRv18fqfchx8ErAS2Ea0FdrQ=;
        b=JkIfqss+UuZk+fbJIBCIU8fZ58dgef5GDjxFyXZS5YcqSHvFALrxO3pDcQcP5D6K01
         RoAgHbwSeEkh+/l1nRBDHbzTZZZFHcnYhHiX0PrQMZjTv7/xhjpuhxFZdbHaVlPRKMGR
         76s8x7P8cmg2QIRJaNhQ6lXo5UibKHxEf6tD0y01a9kV95YZSxW4Tq3e9V5WdFJViKgU
         zQ0M/UP8YrjK18xAzWkBy3a0NqgFaB/NuBFYHSK89WClnjxmBLmx4sjNsCX1rwvECjDB
         Y8qiHZXhZeswCGrYCf1/x9ZujpV2thF7LAaSDMMeaJ4cNXz4bWm/csd4pHQMNSfzHg/2
         GrfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793304090; x=1793908890; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=41rEEZJHQ1b0lZW5NZ/hL5Z21i+HuFKPEi+1JbBpXGc=;
        b=WzkVwYzIEvlUD4jouGSIwB6FRlfF8hxTgPyyNpqGmkTWIQg0Ole0rsRJIpCMSLmcYo
         xny2WIjTKOduGBsjO3M3Hy3Y5Gpxav5pAEQ+dey/WDXOYqqnfW/4s9rt/5qtlD0o1JQD
         qgNWqEb/ESz1VmMIS/1NOS99QXo6xUINV4qKkkXEUdhm9m1VegHsAvLzUItKmZOIN1QJ
         iIqXI//Wxc9ozlcrU7fWVky9rHoQfM3GQHS/Ns3ot/06EY6+UkCJJuj9LxgFC9LLrk2R
         hMe7EXKbU+My2iqLUjxXv7+wewDozb/5zzK2zqO63rDc2gOPzlMplP5cO5XTnsm8pZwT
         JcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793304090; x=1793908890;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=41rEEZJHQ1b0lZW5NZ/hL5Z21i+HuFKPEi+1JbBpXGc=;
        b=SpApj+GqAv9YleDQN9qB++KN1GeAcmud8EzCKNnKKjkd4nDQ01vEkjJnVTfIA3T1L4
         JJhdY2thVOPn+junP0uqWSlQcBIaQn9NpaZpXC38hhNXmARsMBq6fUH5d2s1yMCimf6C
         sQLC093Gi1EuIE3QaPFhmfCdQhNRFBi9UM6hdrNNeg1dX3GK5EXfb6yr/+bMaAWCAMab
         pTpSgt1UucSJQfNyUtJPhUN5efNQdesVN9lGcXTPYl4DT9OkA1CT6fN4uANUOoqNAx5w
         lO38jxBA7YhzJV3T1R9scq7ZxLShBBG032wYXIL8Tpk8/yD8275L5yMLpabnEA3CswAL
         9/SA==
X-Forwarded-Encrypted: i=1; AKwUvByRF1NAfbzwc6kQ3Bp3AzyCbXxIh4tbkK1UuOjWWUvRerfUv+yAw/+b2fR8tb2LPoUFF30=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCzFm6LjUTyE3oJ+L307aBOJRe+ABsoqMog/iHiN+BuNPZtoMZ
	LYUGY4MEiIwdGT9y7T7AcRCo8Za1e8gjMWeH3H4dwbPRTt9qgUtkPxxz8Gw6cVOEHEnOJvrVC39
	Q+kw/s6mF8wkX7oAp0CieoK+x7zhdIS+7qcOD3jA9
X-Gm-Gg: AYBFou0CcrpenNd3wd2wD8WaBwaIpJtAw4JpPLanS56vUiXSrczhnCtzPC/LPjWMovh
	CEzd+MSOC4nxni/7vywbVKkFDh3OyLE1fUTSjK+RRwpdCRPeb06pA1vhhJ7VuQUY2FrfD2d/Fnf
	u34rjQd4b2NhykkwXz97LQxubcWilx3jXsnYXQbsjlvyZgnL5h7hE+kzHBxnxu+/4BzjwqCq76U
	iKtR+xNgodaQ6wDTLirtjIGyN4gs5JUxf+0g87m0R8iL6qpFd/dzVyE+CNnT04E1x77ra+KHgGe
	1UN1C0kbYnkPe69GalVKA2SGAGZ/JtyVI2I4tW8L2O2+OozZp/hvc0QAKgrdmGOZah01jqlHmFC
	QRNm6m37K1zPU4WsAeCeNrLBxxiITSjobPNgIkvOBRXV/mU6q5grVQY+S+Hy9XTSAJVYugPRCAw
	2uv/xVvq+gJz5Q0p2TTZo8Q6Q=
X-Received: by 2002:a05:620a:439b:b0:93c:b6db:8c with SMTP id
 af79cd13be357-94421400aaemr54046085a.0.1793304088692; Thu, 29 Oct 2026
 13:01:28 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 13:01:27 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261026064424.3003536-1-gongtao@google.com>
References: <20261026064424.3003536-1-gongtao@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 29 Oct 2026 13:01:27 -0700
X-Gm-Features: AclHuK8yWAvbtrHc6IRHr91-GPti5braQ_xMkumtHHr_gZTK1th84mOiXH74nIU
Message-ID: <CAEvNRgFtgAFg_nBLXwvXv69zrCQDKRSvLC6DwYPAw30N+BEoeg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/5] KVM: guest_memfd: Add KVM_LINK_GUEST_MEMFD ioctl
To: Tao Gong <gongtao@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: David Hildenbrand <david@kernel.org>, Ryan Afranji <afranji@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, Sagi Shahar <sagis@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, aneesh.kumar@kernel.org, 
	Fred Griffoul <fgriffo@amazon.co.uk>, David Woodhouse <dwmw2@infradead.org>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, John Hubbard <jhubbard@nvidia.com>, 
	pankaj.gupta@amd.com, "Alain Gefflaut (HE/HIM)" <agefflaut@microsoft.com>, michael.roth@amd.com, 
	Samiullah Khawaja <skhawaja@google.com>, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"

Tao Gong <gongtao@google.com> writes:

Adding a few more people to Cc after today's discussion at guest_memfd
biweekly.

Sean mentioned the link ioctl as the line of sight to sharing memory,
would like people's thoughts on this. Captured some of today's
discussion below.

> [...snip...]
>
> Use cases
> ---------
>
> 1. Intra-host migration of VMs with private memory, where the
>    destination VM takes over the source VM's guest memory in place:
>
>    a. Userspace passes the source VM's guest_memfd fd to the destination
>       VM, e.g. over a Unix socket.
>    b. The destination VM calls KVM_LINK_GUEST_MEMFD to get a new fd for
>       the same inode, bound to the destination VM.
>    c. The destination VM binds the new fd to its memslots with
>       KVM_SET_USER_MEMORY_REGION2, at the same offsets as the source.
>    d. The remaining VM state is moved with KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM
>       (SEV only today; generalized by the follow-up series) and the
>       destination VM is run as normal.
>
>    Linking does not revoke the source VM's access; the source simply
>    stops using the memory, so every private page keeps a single owner.
>
> 2. Sharing guest memory between non-confidential VMs. Both VMs bind the
>    same inode at the same time, each through its own file, and the
>    memory keeps its guest_memfd properties: neither VMM needs a
>    userspace mapping of it, and inode-level operations such as a hole
>    punch apply to every linked VM.
>
>    A related use raised in discussion is Nitro Enclaves-style memory
>    donation, where a guest gives part of its memory to a sibling VM on
>    the same host ("nesting without real nesting").
>

We discussed Fred's "aliased" attribute that was going to be passed to
guest_memfd through .get_pfn(). "aliased" was going to indicate that
this memory is shared between two users of the same memory range.

> Alternatives considered
> -----------------------
>
> [...snip...]
>
> * Keeping the memory and its attributes in a "memory provider" and
>   creating two independent guest_memfd instances on top of it. The
>   guest_memfd inode already plays that role today (page cache,
>   attributes and the list of files), so linking gets the same result
>   without a new abstraction. If guest_memfd grows a provider layer,
>   linking could be expressed on top of it.
>

Sean pointed out that we need to take into account that at some point
there CoCo protected memory might need sharing, where protected
indicates protected for a given guest (and let encryption be orthogonal
to protection).

Then, we'd need to know which struct kvm the memory belongs to, to
determine whether to share or not, and for that, guest_memfd would be
the natural choke point that understands memory, which kvm owns it, and
shared/private state, and hence memory sharing should be handled via
guest_memfd rather than directly through the provider.

>
>
> [...snip...]
>
