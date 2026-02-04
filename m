Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECF3182D0
	for <kvm@vger.kernel.org>; Wed,  4 Feb 2026 00:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770163877; cv=none; b=SeMox+VxQXAoLofs/oKlyZZPP2WcMWNgTn3Z37UuQcL+4pCQ92AeZoPROlbmgSU2uJ+Ah4+4M2TVxnaf/wcddNvNAy5ZhD371y6ixlZHwchJMUxf3FYM74fJaBRg2CrWawEO/kzoVj91Af2tmslM/6FTbszHsnta/DLzPEfmPlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770163877; c=relaxed/simple;
	bh=oJqYO2EpvUnL+4pZp9pCw07L8lSCQPZzfX60ev6bwO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t364qGzEaiyTGW1haFrGMTLiw92f0FoXDNkfEHJv17XYIvO+/ZD8vthOSmgj+7T8N9CWBANDXiQsPfaFT+aQiaR9iAXDHGQkCncqNffnwRM7aCJ5fAxcLvk/3uZetwbO+I9RtPNJyFWKoDlpBygNDNrKMn4kI/j6SpjVB3dLeT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oTCkq0j5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oTCkq0j5"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-353c9d644b0so4860106a91.2
        for <kvm@vger.kernel.org>; Tue, 03 Feb 2026 16:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770163875; x=1770768675; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=soNKEbp247hLHtsNOH8fLPBtxTA4TpmArRJrCjslLIA=;
        b=oTCkq0j5ggybMPI8PrNnlX2shgEscDI6Fq0YNjihRjh/f70lMLC7sZYE6TmuDpoJdA
         JHBKVeH8mlvyjVPzL6/021srZkYmuAAE4WBsw/FsI8Gm0igOR4BZJD22NrPybHfmAnFS
         DVriammH9nMNI47gmwqsfdLAFmnKHhOuxzI64vlA2ZP4uT96Qu1W36fLVFJBtzdX3gaO
         hAUPRRvt5hyGcl2ipBu6SKpp13cfCr4B/A32U9ZNaBBNrGkGWgwPbQ1SNoWcGYrEzWVM
         h5bw2/yflUJct70qnRLQeQZ8zKwuA8lIV93lJecQz3ZAEYD5KvDgL1autD3Ctn1MAHv9
         Recg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770163875; x=1770768675;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=soNKEbp247hLHtsNOH8fLPBtxTA4TpmArRJrCjslLIA=;
        b=usCWFUpd1CNl3mIlJ15ctbnLVWIN6XcEBTkjfhRkp7Srjv8LlnqzwwQh2XVzNh0E+6
         TwXxX4F1YIl6FNx3m9n9FBBBdutz+SAXOoeAZV+x6JWaehBA4EXUJQhvW16O5oc5kRfq
         ZRKE1U04ebttl4h20DK70tcD3rPFVxkof4AINUQ1qAVUcWDqQWtIoQPMo+okjfk2QLNU
         Xfrs2jt25n6/XUiRwGGwyufvkMoSE7FZdYuJN/phz/JwKDiTbtqKTRPI9V0sOL/sS5mI
         yhxOvN0xWCK+bhZe6FH+2pNimjshW+MxwhZ3Bdqsi7scYenSlISbMgAA7AFGdXAMcUJm
         HGjw==
X-Gm-Message-State: AOJu0YyXrysZKbTehaea7giFPZ8b0+3H/6VKKPfSqUb2mWOI2azeCLoG
	EW6rGMxTEA/Us8N26KPpO7BV+jIjRBn6yAsk0LZbOm4cRNS36rMWt+vr0k8Z5wr087YCTBt0zEX
	JErJNdw==
X-Received: from pllj6.prod.google.com ([2002:a17:902:7586:b0:2a7:8bdb:7877])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:191:b0:2a7:8bf3:5677
 with SMTP id d9443c01a7336-2a9341371b8mr9638795ad.59.1770163875046; Tue, 03
 Feb 2026 16:11:15 -0800 (PST)
Date: Tue,  3 Feb 2026 16:10:29 -0800
In-Reply-To: <20260115173427.716021-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115173427.716021-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <177016226753.561649.856634993293627748.b4-ty@google.com>
Subject: Re: [PATCH v4 0/4] KVM: nVMX: Disallow access to vmcs12 fields that
 aren't supported by "hardware"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Chao Gao <chao.gao@intel.com>, Xin Li <xin@zytor.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"

On Thu, 15 Jan 2026 09:34:23 -0800, Sean Christopherson wrote:
> Disallow accesses to vmcs12 fields that are defined by KVM, but are unsupported
> in the current incarnation of KVM, e.g. due to lack of hardware support for the
> underlying VMCS fields.
> 
> The primary motivation is to avoid having to carry the same logic for shadowed
> VMCS fields, which can't play nice with unsupported fields since VMREAD/VMWRITE
> will fail when attempting to transfer state between vmcs12 and the shadow VMCS.
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/4] KVM: nVMX: Setup VMX MSRs on loading CPU during nested_vmx_hardware_setup()
      https://github.com/kvm-x86/linux/commit/26304e0e694f
[2/4] KVM: VMX: Add a wrapper around ROL16() to get a vmcs12 from a field encoding
      https://github.com/kvm-x86/linux/commit/c68feb605cc4
[3/4] KVM: nVMX: Disallow access to vmcs12 fields that aren't supported by "hardware"
      https://github.com/kvm-x86/linux/commit/5fdf86e7353c
[4/4] KVM: nVMX: Remove explicit filtering of GUEST_INTR_STATUS from shadow VMCS fields
      https://github.com/kvm-x86/linux/commit/1dc643205953

--
https://github.com/kvm-x86/linux/tree/next
