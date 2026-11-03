Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667301;
	b=Fx5sDGOxCMnK9GwWRiYD2V6JkxRYMNxkl9L0iZCAXrbU0ntDcPOnDx/WdxTMkd6a0jKv
	 LBD4C+8eRR15ouKv2GwxUFJ3WScjOUsl7HLQYvpr+xcuG5V44jKlzNN7D/gphhzLLZeYW
	 ay1abrhRVF6WaE0pwt8bIW79yMlEs93MytoQwS/46IQMm+TlcqOVT7AaB4TOK3lG33O3x
	 wATnd6BrprYNlvPcc5vpfztgRJ45Z6mp8cnBlwFVWjHmeywwa6yQuA5Gc6Lj9V27fzlP5
	 CmxT8gert5ezCITQR/K3pSl2HXNMMAILUZJc81RLpjmBdLQfvQGECwNWnmwL6OO3Ztg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667301;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=utYETJ5rHiqNuCeYbazrvQTxJbHnffVJ+WGLRhPpEcM=;
	b=FIV18EY0mbcasH2mqSb2YLhbkROzSXsPwE0/JMUpvYdGuJ9wk7TwnBnbtbJtFe1f8sFA
	 sDWvIReh9iolOBHe94Opv/NEsdKT0JeLeXcOASlk66Ev8caczApNP5K14dOi8HyyhlwVv
	 E0XM5KIvSER9x1xpG4n2B2HMbiRMtpPIFsmcuO1gExWsMk8j7rknSJpG7S4Z9N3OQ090T
	 XURhrXztbPz+AAwhlr94E9BMU7ByDBRhDsOaDS3ClwjULRAXvREU6yz/13lrk1x0U3tt5
	 IJC7w8FHeNctBpHdsUefsZUs7vEQovnotsv/y+Gyn1YDvZStqBrshHjUeUK622zZYWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mDxlUQbx;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D54D606A324
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 00:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D54D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mDxlUQbx
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso22021165ad.0
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 16:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793667300; x=1794272100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=utYETJ5rHiqNuCeYbazrvQTxJbHnffVJ+WGLRhPpEcM=;
        b=mDxlUQbxsLKooZ1+O0OFTCvjBlA/exBlT61vu6XWQY1i3FoERgcSmYgmy00W3bs2u/
         6dSQ8IiE95puZ8l8pLfIrbjxqjzd78CsCOdANjsHRM0OZqR0v9JOv6eNGpNU98Jy1iuz
         Bb/2MJDQ873SPx8Dwfe8nWB5yjj1xaNXu4JIERwXrqyAHAEWrnqLUulatudPktTbo49z
         BK+BI1UrrjDzEZg2vIBqcJDsyJ3duvRoVG21c95GEuf2Ufy620sh49g7YRlPnDhxXDWA
         jaqrW42hNowdcuRQGBr+VpZexu0XpuSxc3gQf5ts/Ss6FV2vte2g7oJ7KInhTI3NGNNc
         iqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793667300; x=1794272100;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=utYETJ5rHiqNuCeYbazrvQTxJbHnffVJ+WGLRhPpEcM=;
        b=J3Ed0h6HSoKKOEey6/qJCqYJCLdpUVBL1H+KYn/rlwahgsbZ0nxxoxphRfaDU6yCAy
         UL53Eq9EaJmtv5+OEqCifOv03mr3gmc8Gqzf2EvcdSnfbdXVwovzCzYy+3SxRQI6mGA3
         DNLOfuGRofQU5lsNl7TqeBZeILeZiBRXE7mzBJgJyBYiSwB8PG2nkOedzLxASIbO8Kcl
         eTcCbAOXbEjQCvo1bbyU6tDtbaYOzyBTk4UEynaHpajnyHf7kI6ryWF2zxLRo1E05Xl2
         WAfXMJnTSzT9p8yTbb8g7x635z03VvP5V/o+f6P/lDph42wZPaWpuLExfrqWcB+QmZDG
         vIqQ==
X-Forwarded-Encrypted: i=1; AKwUvBy3inYYknX319hxz/7rU4/mq2forTYA/aSIQpIPnCxXt9q90W32Y5TLbepcr3GJ4uHlSnQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8VflUzlagtJbuMyIU1DDDYpNvTDBhkxPLqEEDoTcHF0dlRM2D5
	XMyynFIW0itMjT0YcG0Yj5c+dyTOC9n/x36kjbMqFqPFcZUoEyBCh2FeVw+WB1FEvg==
X-Gm-Gg: AYBFou1Pv61vkO8ci0xNF6iIOB3gORobfq32B3wFD5LYKmXfRasQeegDyXFb6JBg9By
	uhLeewHzSVz+OvI4ursrpoEWNPFkn8SyCsQ5qhkOgJ39EIAc+eioO9T47cx+pAujup1YUTTSAAg
	LmytwmNzpro0nVbFHDYC0RM+/c9wTBjWsUXnI4B1/cjrTPzo8IJvaNnmzWoMzQhqY2mh0Q9LCh5
	EE9i/jGfAEKBqUgS+FkMUGksG0f1i0WozOwLRSh2ZSaO3VtZoLjEoY9paYjwpAi2PBOH+fKPGO5
	+9RqxzVVZnyugymr/8JqVQTgeBH87wEUgoukDn0rtKKhmytPxBh64ZLwKsAkMDbUs21aGLQYoPf
	Df3rDSqMsiis7Y0JXAbK49jKluZMkBD+Ro8OEujv5gzNAgfaeSMeG796XTBrQKaQ3J9MOmsPJhz
	ZkdbF4kWmmQsIdIkU2kTJ2eTHstk6ebCMoUPcGx6fYd9cXAEEM9iiL6Dd4Rbji1XHQ/2Q3sh7kc
	tWnn5CHFsalKO6KA/ru3pTxqeM3CKhR4fnPxF+NpMcjwBrJAwBC5vXeXyFulFuux1qOZWHAUxi3
	EGB97Sgw4fKvjxE5WeZ/1kMyar52hdphYCh3Bl1ySFyt9HG1j5UPOSYeXHLe0Dit
X-Received: by 2002:a17:90b:4b12:b0:3a8:5fd6:cb6 with SMTP id 98e67ed59e1d1-3ae89173bedmr9255823a91.0.1793667299847;
        Mon, 02 Nov 2026 16:54:59 -0800 (PST)
Received: from google.com (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87fc548fsm10138264a91.4.2026.11.02.16.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 16:54:59 -0800 (PST)
Date: Tue, 3 Nov 2026 00:54:54 +0000
From: David Matlack <dmatlack@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson <alex@shazbot.org>,
	Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Vipin Sharma <vipinsh@google.com>, Alex Mastro <amastro@fb.com>,
	Matt Evans <matt@ozlabs.org>
Subject: Re: [PATCH v3 3/3] vfio: selftests: Test BAR write faults after
 clear_refs
Message-ID: <aukw3s0IR689RYYG@google.com>
References: <20261102230445.3993629-1-almasrymina@google.com>
 <20261102230445.3993629-4-almasrymina@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102230445.3993629-4-almasrymina@google.com>

On 2026-11-02 11:04 PM, Mina Almasry wrote:
> Add a regression test in vfio_pci_device_test to verify that huge_fault
> on writable MAP_SHARED VFIO PCI BAR mappings handles write faults after
> soft-dirty tracking clears VM_SOFTDIRTY and downgrades vma->vm_page_prot
> to read-only via /proc/self/clear_refs ("4").
> 
> Use vfio_pci_find_mem_bar() to locate a memory-backed BAR of at least
> 2 MiB that is safe to read and write, and zap existing BAR mappings via
> PCI_COMMAND_MEMORY before each sub-test to verify both:
> 
> 1. Read-then-write fault sequence after clear_refs, exercising in-place
>    huge PMD/PUD write-protection upgrade via wp_huge_pmd()/wp_huge_pud().
> 2. Direct initial write fault on an unpopulated BAR VMA after clear_refs,
>    exercising vmf_insert_pfn_pmd()/vmf_insert_pfn_pud() with
>    FAULT_FLAG_WRITE set.
> 
> Skip gracefully when the device has no known memory-backed BAR >= 2 MiB
> or when /proc/self/clear_refs soft-dirty tracking (CONFIG_MEM_SOFT_DIRTY)
> is unavailable.
> 
> Suggested-by: Alex Williamson <alex@shazbot.org>
> Cc: David Matlack <dmatlack@google.com>
> Cc: Matt Evans <matt@ozlabs.org>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: David Matlack <dmatlack@google.com>
