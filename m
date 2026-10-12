Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A3A3B83FE
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 20:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791835759; cv=none; b=OE3pfE5+sYH/662joxeM9csPc8VzPUoehzVs2ABdEHfh3EdWme5mJ8dzp/q05bDckTj61Sd0rKEqSBIHlEtC+rTatAXwlxeVqeOZejGIFpFFSg+FfyjR5TS8TwdexXzXa5x+KZl7eOjyeW31OTmw9QB/CktIyf7VJg1QEw3exFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791835759; c=relaxed/simple;
	bh=labewT2hV27LB5EpRULnoGnU1thrB4RMmBUKgDB18W8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gDG/tRfDqkfK1fHlM8/xdANOjTcVHWMU4fKgXYSfoZCmwG7LSU9I/76hIYTag/qHptgQDU0GYoyFHWUnV2YE6bl7XRmD44hAQHRGPJOPcIfUs+6yAYDfgWZS3PgeSHIPsWw1Rtq3FS2PQSfhd3eXlPCUe9LJ9w6fKDTpdL7nL64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sRHmF9JE; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sRHmF9JE"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e827b3a6b4so32925985ad.2
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 13:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791835757; x=1792440557; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0huG8WqQPQs/27VK7Fi+O9rqo6WXAIJK228EBYSdVtE=;
        b=sRHmF9JEJIqhi8rNrjSDAucB5pRjMmYyreRR0fJdsJUgZ2eD455WltOtwmiPaFqtoB
         fkazpDsIQsfx6PCDoklcp0+dVAYlY/r69qpAnY6+69+ZLGq8lpyNq9Vp5/WAwbrqfNJx
         rp2pOcJE1oOZ6Wv8bkRCp6HQsHiGMu3/A+V1y3cyEH2LI5vPGWFR3GLdRdFyBBXNAa7Q
         I+DYQEsHYgECY245ZyixiqZSylDOM1dIa2RYgLNwT4X/UL6pST6GN1o1N3xej6/trq4d
         F/tyE9wQCoNjvm4rAvW8SLR+qR/ysG8iSOBdx+Lm8Jh4/kCe+3x2Qs3zGDwtlEbIRfKL
         OzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791835757; x=1792440557;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0huG8WqQPQs/27VK7Fi+O9rqo6WXAIJK228EBYSdVtE=;
        b=lNEVEOY9yJWd9bq2d5RwGM1r6nYTMIaRSSZEVfWvth0y2vO7UUuLScQ4tbbhP0UabG
         Bxp9vCvUoBnE6K3Ue90GwJoEml2cMpiOY4a00TIpCE/SwEbOHbTsorTDet7b2TRbsIHY
         wKni6SJ28npEy3imDGqR5ZDPcwr/Dsg6jPCFCv8H/Ej6brjhxfaxG/r++/YeTIUbdmqD
         IvWmeksK1GDVCMzuwV+EbMgSM3AHXTS/dQ6gx8PVK/2KXQ/E6meONVACer5kf5j4tmqH
         rWh1FitX0CA2DK8M6gMVHAKmhA9Atg9hUcyo3jHMAhp+2K+ZLcqYfSQax/nGanLLkZ5l
         Dh/w==
X-Forwarded-Encrypted: i=1; AKwUvBxu6Did4bPsPvHiVHyn+jZ5f5vWV7iUD1EXYyBZ3i3bhhysxOWqoSlkGb/HEuaIOT1d4Vg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9WikYke1At/MWVqxXeKtZ+cxUWaSuz6l/pYHVfygFjsC9KeBn
	AFidXnptTGbnrdTAqyJXEbjZM3w61g//BnsLXq/4Ak2kBDqMqkM7i0DbLaCuvtrSnA+UHHBGoJp
	DdzDIPg==
X-Received: from pgdt2.prod.google.com ([2002:a05:6a02:3002:b0:cc8:4927:ea08])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef45:b0:2e8:2f7:4a60
 with SMTP id d9443c01a7336-2e842cd211emr83473025ad.51.1791835756613; Mon, 12
 Oct 2026 13:09:16 -0700 (PDT)
Date: Mon, 12 Oct 2026 13:09:15 -0700
In-Reply-To: <qyykjxnxek73ddhbdexwz7jabjso33hdqzpf4syhrbrlh4eo5q@f4hwiuluzvgi>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-13-15ad654a50db@google.com> <f7b3a63c-7a1d-445f-b062-4cea5343d266@intel.com>
 <asz8GKNO9aQANr5E@google.com> <as0FedYcvJvdOaq2@google.com> <qyykjxnxek73ddhbdexwz7jabjso33hdqzpf4syhrbrlh4eo5q@f4hwiuluzvgi>
Message-ID: <as0-ayBpM44YxOHo@google.com>
Subject: Re: [PATCH v14 13/22] KVM: selftests: Support guest_memfd in-place conversion
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Lisa Wang <wyihan@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Chao Gao <chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>, 
	Sagi Shahar <sagis@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 12, 2026, Michael Roth wrote:
> I don't have a reproducer for the specific ABBA in question though; I'm
> confused at why sev_ioctl_do_platform_status() / SEV_CMD_PLATFORM_STATUS
> would trigger a gmem fault (outside of malicious/intentional case) since
> it is just querying status on behalf of host userspace and storing the
> result in userspace buffer where there's no reason to use a guest/gmem
> page. Was this test specifically set up to do this or was this reachable
> from a normal path? Just trying to see if there are interactions I'm
> failing to consider here.

I was just running KVM selftests, although I was running all of them at once.

The condition doesn't require an actual gmem fault.  The uaccess APIs have a
__might_fault() to communicate that a page fault may occur, and lockdep is smart
enough to piece together the problematic chain of locks.

  -> #1 (&mm->mmap_lock){++++}-{4:4}:
         __might_fault+0x59/0x80  <===================
         _copy_to_user+0x23/0x60
         sev_ioctl_do_platform_status+0x50/0x80 [ccp]
         sev_ioctl+0x220/0x2b0 [ccp]
         __se_sys_ioctl+0x6d/0xb0
         do_syscall_64+0xfe/0x460
         entry_SYSCALL_64_after_hwframe+0x4b/0x53
