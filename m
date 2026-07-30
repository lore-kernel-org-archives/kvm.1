Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D283D891B
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450671; cv=pass; b=SOe571zY+WwpDsekSdcc3ZZJ0GDR2zNnIDFgQ2LNp0z1ub3wfePA+GsiLwemkRQu/3NVP5P4FBGeHneCpXIU0z5O9Wbt203CUCT/auLirW9BiC6HJM0XlyIh5m7nzHvlrVZ4ZJJRS3MKo4ZXuMbxTd3p7OnW9XrXz57ivWISFxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450671; c=relaxed/simple;
	bh=RFb9jxFt+SB050uUN4iOEqSU+hhGaZfWAlwTqxcdY2s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdiuhupdRhAmxVjcQy39wuXTJzrQ5h88m0HZcRbMjqFUdVgQBIEUOZs4mq3+VccwelIKNftz3BfPeVXEBaY+SO+/cVx1eWOhD4sGeHghEaaFhG+ywmrSXRfKgMSmBmirMKtVJFdCv9M3zISOl6a2e3LX1OVhfABEW/KEgLPQ/S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iyX8ta1o; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iyX8ta1o"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso429382a91.2
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 15:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785450669; cv=none;
        d=google.com; s=arc-20260327;
        b=RDXZUSX14MJvB/fZGdjvt2JKEDvsp+zaRlvaj4B1C+dBh7sBBzJ/o8uZCZje8HDQEz
         XgyM9t2WmUtnls/pdLJGSg2CUUhnDV0pd0nSbUbc5aFEWhvAbx9pPMnGpY88neD8HJ9u
         3OpzFhQsPlJboDnQzCdOCjL7HUX2D9O19IWqBfB/Iw9hByGVIoNHswdIJueRobeYHwKe
         S9rmWcN39iBWt6iYVfW0/a0xSWh4dS8c31kcjvUFSmn4RQW4C3fANVhVXXsUS5tz52Qf
         v92zSnqoPmfvhA0y+daMM4L+BYTPik4Un5iopAr/AApguJRj1dRlpzKLT7AcrtsYkMy2
         NlYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=NT7QpFfx9ePxD+EfhDliJc1nWKGrZODd+FSZ20/4RHU=;
        fh=EU4AzIIRBJ2ngivreOQBh3QCxHs9TIYUX3YVcsmwOUg=;
        b=o5immUJpcfPINRfdOi6JHlKvCys+ClhPmgNZ3EycpPlCE1hxVJ2xSA69xAu/JCocBL
         uoqQmm3NLSE4jUw0kAAHE3ZIu/4/IQXN5YhNgyXuW+oUWldpxWb2JlNeZ6LfqXFbotVe
         7wEW+CPSYb2nEapIm23Ek5mJjEYjBQAkK7iIGEOIdfpFgYeoMxjD7MArzqiOn70mcggs
         V96tY7TndMicGg02Mrww9EbG5bjFvtATjJliuJEUdLOe5TVrWJwrbPyrn+wgI8eNGMr4
         5zCeLka2DGAt2ewtblL1uHApLPiWEeY6SNN77bsBwFDWQMQOrEuYpoUn4ebpBRYoKY+p
         aoKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785450669; x=1786055469; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NT7QpFfx9ePxD+EfhDliJc1nWKGrZODd+FSZ20/4RHU=;
        b=iyX8ta1oIXwTHeAbpQ9turwrD41nAuMnhWMV4eirv2p0xKFz/MQSM4n3C5TQm/1mow
         rImFsx2dMqgyRj8q9VpXQUyMoSiEDCDojWmqvMlzzO/na9zMRvemi8prn/dxivQ1QVMk
         LVZuPVBpUTYtxvVP7piuI1cQBARqDGrZHQgYQ0cLjjZKR6mnZ61yWzYHTD81C8u/GSUw
         rJOWb20U4q4G9HbgX+Y0kCM2ziLBG7EyssUbKsY2xyqR7wKLA7yxhVtLZc5VIeg/lPT1
         31OSNEjnMoCwIPxCeGs5DfrvnTqagmDPi02jt7IlsXbcgyyDp75AYtDjbE9k+L4M94c4
         f7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785450669; x=1786055469;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NT7QpFfx9ePxD+EfhDliJc1nWKGrZODd+FSZ20/4RHU=;
        b=kMWvDsKznda8cyysnbd9u8XmGt8OQXinWpXp7bBTVeNSgKCyDjZnbkWHUyw44plS5X
         +MQIbUN0bWU5WUFdHIDEzt6CFK3xGBSgBsUJcE+tBt7fUmx4lz7GS7S5HBPi53hXWeKd
         KyIt+86YIXXiq+ihiutr6lqkStwPPKnAQOpTR6wyu2uOSzoQFCcIgsd4SnPnViPdPkxD
         Ku2RzHl14gU1Mn3x3wx69FTAtTcnYYkMqNUWvW63EY/2XKUxCK/grBMC5U4pGIwb2hfk
         1OTa1+uX4omVtIuSoh5fVo8R/hpRBFvTWcXtAtK9kE3WXK4lLuooIkYehdbqBdibvglE
         6WzA==
X-Gm-Message-State: AOJu0Yy+1fvtOLTKpaJYKgdHW7M+SNWoQlNmNSpVG4WQJ+ZM2yaSMert
	lha+jYpDdhFU7b1lewh47mwZ5UYXH9NWzb1BO4vGVInm7Vg1w10+jD1aUuQap0SvigLx5smV2N8
	k5OQ8HJDRTeML3j9fXcqzlBK7Mpt7ZBxXVrL+zeTJ
X-Gm-Gg: AR+sD10JQOWPOlaaGEIvXChcKxODDnHpi3qqmqs85zF+NVEomB4o+c834L9YXA3UXMd
	4cs9LVfvUQpc6gLWkzzuJlccGjCWDKcbSMeltXapqvSnaqNbrih5XNMEZeDv7CSEmOD2lG+5GzW
	tIMNyC+/ykYRhy9ZV1sCXheCiThsy4QIlucKFOroV0dqfGJzvXcVcihLPcpsJ3EqTPLiAE2uN2R
	D9srVz3B5fvrRVUFg7nGkPdSQbfcNgkuiDo7HeZJlAA12wFEuX/oW7CJkUr7RW2dO8Ia1RfKRQW
	SjSutyWL+u1OgZ3vfQOJb1YJ0S4X8Sm2i2AmU1bSnT7VTILO5GPZ8naxukU8aeutmz1ZFn9DKZ7
	pmrwPV2gNdqPJlSJMZHrscZ+qFGh8EtkHm58tKG2U8UqXMoM=
X-Received: by 2002:a17:90b:3c88:b0:38e:3fdc:62e5 with SMTP id
 98e67ed59e1d1-38f9bdb3885mr3385917a91.19.1785450668084; Thu, 30 Jul 2026
 15:31:08 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 15:31:07 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 15:31:06 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260728-gmem-inplace-conversion-v9-13-35f9aec2aed2@google.com>
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com> <20260728-gmem-inplace-conversion-v9-13-35f9aec2aed2@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 15:31:06 -0700
X-Gm-Features: AUfX_mwSrnPTxdnd5yQR4dz6uVJVHdsuk5_VpYazXm1_NpOUC6lIlEZN5j_ISHs
Message-ID: <CAEvNRgEscmPoW2f4UWHnPub_ycDg_QHRR-cCU5yL9HXu=G-OFQ@mail.gmail.com>
Subject: Re: [PATCH v9 13/41] KVM: guest_memfd: Return early if range already
 has requested attributes
To: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
writes:

> From: Ackerley Tng <ackerleytng@google.com>
>
> Extract a helper out of kvm_gmem_range_is_private() that checks that a
> range has given attributes.
>

This should have been

  Extract out a helper that checks that a range has given attributes.

kvm_gmem_range_is_private() was renamed to kvm_range_is_private() in
some earlier patch. Thanks Fuad!

> Optimize setting memory attributes by returning early if all pages in the
> requested range already has the requested attributes.
>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Tested-by: Shivank Garg <shivankg@amd.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>
> [...snip...]
>
