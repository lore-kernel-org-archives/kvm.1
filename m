Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411303C1083
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787948051; cv=none; b=uN+PXYfiu5IWnfuXfmY652S2PqPoF+aPS8rPwz3kB4YvPZr27BC3CrJA8bAmVQCgsm6iPH87BcLHR0WQVeGFi9bp1gP3LJ3RKKnpLJTlDA6iZMs6pyr/GBWwHafBZVOM5XMh9TqNWCXRoHTjEwRRmzzGg+ifioiep0umkSUWUE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787948051; c=relaxed/simple;
	bh=RrlgIjKQtS2iaNVqkTRdRTy02FrfZJ1ASwUAxdnue2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WigLn+my+7YuegiFpPPfSLGbQisRQ9ceUp7F1I4zqDTzHxWaPYvHqeNPrnXy/GeVc5NtmRPyG3wHAIlHe4r4BHRIhRLYQenQ4YGQ3y5xVstBeeNoTkTZA2uIKpqySHD6CSDw8Yywz9JYaBVb+vk8lMYTUCk9jmK59iAy0nonbPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xy7jaMC3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xy7jaMC3"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ccdf36f63dso23785ad.0
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 13:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787948049; x=1788552849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1W99GsbYdan7e4eL7ZVdhDx98mSTGYMmyZJimSzUaX0=;
        b=Xy7jaMC3s/Mz4S8vdPPGXaHr2smRZE+dx1unqDZbo/sGMkQm59ENDpCVo2uXJRBKel
         5v+IVKyMB+7pzlLkyOqXNO9j/s5YvHmTG1UwrVvzTrpIvQbEdoGQktExhdBDOad96jkq
         gTAVSzYJ+qlOv5dD4Jc+4sPqRMjRmk/OOASlCykzhWf1gI1XwCQwMnjD3L1sJqVAPBp+
         LsPyJzR9IhABjN3x3zdsc0Z8+sRPHdnH4y7KD6OhMODs1nfxr9rl0FX3bfHF9uMNQY/G
         KRAGnenn49k94sOQFqwnrlCA9Mat5xpnRNU+1D35pI2Hugmic/mCk5HH+Xqae1KmoFwH
         nM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787948049; x=1788552849;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1W99GsbYdan7e4eL7ZVdhDx98mSTGYMmyZJimSzUaX0=;
        b=QxOFNar5Z7tHtsBvdzI8ZpK+Djp4cyun/9DQ3rp+7lz+greo6IOkP3dMh2WGXwHF5K
         b1p4snVSOFNhnP8Rd01S9kxIrpRs0qRpYnFtKHFBxxs+TlXR0LwLqDfc5mbQaSD6e3Sf
         0KaTVIpNAgrFgfu5cZiWMr5UQ9HHeV3vnDxD27CtVwV22v7pNRvCXGocHvXuBayIQ3Ta
         zcPE9J8ovtigJL9XjspYkT+OzphjnZjV4ITiuaBntzI2slL1Wrk1J81Z0PQ2SOe7S4DC
         jV7m/QL0DJRiHRarAA6GFJ7ifgiZxudwPKUnzNj9apkkuMAMpL0NMvbYhtxw5huubbvn
         xw0w==
X-Forwarded-Encrypted: i=1; AKwUvBzMqlvXQrI4bnZ5hPXEd10St/oQHz9wTJW+oaNlKWehpMqy+Gm1UCxvCXeiD8GhCC6OjSk=@vger.kernel.org
X-Gm-Message-State: AFuF++kCCjOlicrTtrhA7/R1DO8t6YB2F7lqDNSvItfcvNUYRVGm9Zhd
	DbcQfF07oMFs4DWuGHd4RxWPXXOn8KzLXgWgzNbNaQUDoQ5qM+/NjKcAf66qN/vsuA==
X-Gm-Gg: AYBFou3eJY8srlxs2PSy9euiwUNTIidGaivkKvSNnchg+D/9pdSEg2WykTx0+/6Xv9A
	g70BlmNyaYFDj63ovtO7xapIRn5jkjjz16bj3f1/Rrj/bHmw8+Db5qtEGj4e035EM4zFgMJE/qK
	id6SC6FLIkRGQaE5flUMbDwX1/WDe128ohRyXPNFhZ+WioNLvH8+y8UD+qsYyEDtPWBBNEXvVfQ
	OZp+YbsIzQAiR671ykaMh+hhpp9Le1o0UmYdxO1iA8RapfNrGGxj2pUzbNX3P9Tsrk3R/b+nrlY
	SqZESqcpLq4Qdpuc+p2r+074+bpwKWIQg2jP+vnw5d6pdud+ZmzO679bi8Hk7xktNx/mlKX5iqX
	vrfZl9XfVK6Lg+d7ypslpCTU18K7HD+rchdNIov6T938uh0do/+V+Xd+4EHlL+LjhPc86Rfd1z1
	+BYi5+iSrkN21wHLVm+pI1rhzc1SG7exFthEnqH8JKqBw84nO3ongeI92YN4jLC71I360Rbl3x1
	I8Exeo4Re5IFLDqqEmvq9fX
X-Received: by 2002:a17:902:f642:b0:2d5:db38:800f with SMTP id d9443c01a7336-2d8df554483mr1432235ad.14.1787948049010;
        Fri, 28 Aug 2026 13:14:09 -0700 (PDT)
Received: from google.com (139.58.247.35.bc.googleusercontent.com. [35.247.58.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d759869cfdsm8784715ad.51.2026.08.28.13.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 13:14:08 -0700 (PDT)
Date: Fri, 28 Aug 2026 20:14:04 +0000
From: Lisa Wang <wyihan@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Fang <peter.fang@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Chao Gao <chao.gao@intel.com>,
	Chenyi Qiang <chenyi.qiang@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Erdem Aktas <erdemaktas@google.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>, linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Roger Wang <runanwang@google.com>,
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>,
	Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>,
	Oliver Upton <oupton@kernel.org>,
	Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v14 10/22] KVM: selftests: Set up TDX boot code region
Message-ID: <apHsDCRHG-QIYZuL@google.com>
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
 <20260722-tdx-selftests-v14-10-15ad654a50db@google.com>
 <20260824192702.GA3694338@pedri>
 <aoyi4nhWkhFrlIfs@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoyi4nhWkhFrlIfs@google.com>

On Mon, Aug 24, 2026 at 01:00:34PM -0700, Sean Christopherson wrote:
> > 
> > There shouldn't be a need to "pad reset_vector to its full size of 16
> > bytes" as stated in v8 [1]. The exported "reset_vector" symbol in v8,
> > plus the boot code start & end markers, should be enough to help
> > tdx_vm_setup_boot_code_region() put this boot blob in the right place.
> 
> Ya, looking at this with fresh eyes, AFAICT there's no reason to handcode anything,
> it's just basic arithmetic.
> 
> Side topic, this series doesn't compile for me, so the below isn't even properly
> compile-tested (I hacked in arbitrary literals to get past the undefined references).
> 
> /usr/bin/x86_64-linux-gnu-ld.bfd: tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:26:(.text+0xf): undefined reference to `TD_BOOT_PARAMETERS_PER_VCPU'
> /usr/bin/x86_64-linux-gnu-ld.bfd: tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:30:(.text+0x17): undefined reference to `TD_PER_VCPU_PARAMETERS_ESP_GVA'
> /usr/bin/x86_64-linux-gnu-ld.bfd: tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:33:(.text+0x1d): undefined reference to `TD_BOOT_PARAMETERS_GDT'
> /usr/bin/x86_64-linux-gnu-ld.bfd: tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:37:(.text+0x26): undefined reference to `TD_BOOT_PARAMETERS_IDT'
> /usr/bin/x86_64-linux-gnu-ld.bfd: tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:44:(.text+0x2f): undefined reference to `TD_BOOT_PARAMETERS_CR4'
> /usr/bin/x86_64-linux-gnu-ld.bfd: tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:46:(.text+0x38): undefined reference to `TD_BOOT_PARAMETERS_CR3'
> /usr/bin/x86_64-linux-gnu-ld.bfd: tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:48:(.text+0x41): undefined reference to `TD_BOOT_PARAMETERS_CR0'
> /usr/bin/x86_64-linux-gnu-ld.bfd: tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S:54:(.text+0x51): undefined reference to `TD_PER_VCPU_PARAMETERS_GUEST_CODE'
The patch series posted here on the mailing list is correct,
but I made a one-line mistake when pushing the code to the
GitHub branch. I have just force-pushed the fix to the branch.
It should compile correctly now. Please let me know if you
run into any further compilation issues.

I will test this change on my side. Thanks!

Lisa
