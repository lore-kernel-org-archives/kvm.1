Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485E42CCC5
	for <kvm@vger.kernel.org>; Wed,  4 Feb 2026 00:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770163852; cv=none; b=TbEdFl3g7Js/idXEAHLXUVAfZzF/8KYLf1omiTN6i9pZhgM0LcNsiTkpzPXZpAANpAZjASiwM3YIFhoGQKxcc5flxW9PSqgjfGWeqOcLilreefYNqZSdZpq9zXxxFt0gBmq2xvd58oqyBRJMn+FwTKcfn94ykEIew3Pt0qu+tfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770163852; c=relaxed/simple;
	bh=Se2ckoESQqPLtHx+e4PmyFhyJyPJ4dCCN4JpBxoq26M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I2G9s/jVWf84ucm1Pvs2cw970gjvhPyAfjvCAurReVs2ciyrRTc/B9w9PP6Ub0Iu4cKf/aMwP7sPC7XQyV2CGaF/kg4DdLdRasYmQNfkGb1Svbdq3w9jeQi+nESbT0YifAQxA2A7AgqnErhhkPTVbGKMpRxLT2rFoWJ7kB4D398=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bUuWTXG0; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bUuWTXG0"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a377e15716so165504475ad.3
        for <kvm@vger.kernel.org>; Tue, 03 Feb 2026 16:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770163851; x=1770768651; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zFDaHdZKtlBHeVLyP8CNfbQVtd3Q3C4eMNNypYakq/Q=;
        b=bUuWTXG0IhxhPoJZI4sQobVnNRMJHZvKDgTpAVOlIrIBE+jqpSjpwqx4tzDUPHqJhF
         2ezGJWTJKDnxXeQVEyEZ3Qw7NZN0DYWXgYEHIJIfWjiOOLZIOaWBET/lVvlNP8xUDdWj
         KZ0pWAKgCZ+Lx1BMVgCGEogB3eoy7694jOhgyDaEEx5AgpVyhJJdp2d93QSSLNsW1bhR
         JbtiRZb1FFOHVYH6i9jnPqOw7h5hRuYuabbEHs2Nbx1MNvFCVlBRhrUrSk/K3RSuSTeq
         LMQpJ91j/pYqt1dqP4xx3nfjELpL4gpWIf9K4C+cagXF3wU8Bgi4KTSzmOlWFbP8PT77
         5p9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770163851; x=1770768651;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFDaHdZKtlBHeVLyP8CNfbQVtd3Q3C4eMNNypYakq/Q=;
        b=h9KviDZgTb35/c5hIz3GryugW99tI0GErCJGug29RagNn+2nNyWDNCeLz3601P69Ff
         G7dVV7p+UcnYN/d1kkGbk7f3MLB5bhrEi1NS8ezH+/ND0nz1N2ofia3aIs7z/5aoROWp
         fkZOiNveIMa63ogMA4Ab5wj/EekwyUSiPdMaayrl0EfzMhUlFeAK3jAkfDFza47MHKwE
         iXmN5M7bIZZHWG4PSzmLVucmSLBgEfKaFjFHgH9B6Id52+wtDOEhdlbqRF7DgTemyV2e
         vr8YWfE38jz7RolvYjL9W5OKGJB1u76UkQxacKyZlJxSi/AVJ0jNyIxNcKQeDFUJried
         pnBg==
X-Gm-Message-State: AOJu0YytF0Dd8ha8BhMVoDbbwaETRvrYmib8RZqQWtWE98gamCjTf8cE
	ZIaP+WoZBNghxms/Y7fVGYQe63aBi4oqrbuVNs72YSi9rC8ysvwcMIcnArA6eAtpEzBZ7uzDeoX
	ogyE3HQ==
X-Received: from pgbda6.prod.google.com ([2002:a05:6a02:2386:b0:c61:87c1:531e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:938f:b0:389:7d32:c8a6
 with SMTP id adf61e73a8af0-393721259f9mr1123362637.27.1770163850695; Tue, 03
 Feb 2026 16:10:50 -0800 (PST)
Date: Tue,  3 Feb 2026 16:10:21 -0800
In-Reply-To: <20260128014310.3255561-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260128014310.3255561-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <177016325730.569059.4869595783649901022.b4-ty@google.com>
Subject: Re: [PATCH v2 0/3] KVM: x86: CET vs. nVMX fix and hardening
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mathias Krause <minipli@grsecurity.net>, John Allen <john.allen@amd.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 27 Jan 2026 17:43:07 -0800, Sean Christopherson wrote:
> Fix a bug where KVM will clear IBT and SHSTK bits after nested VMX MSRs
> have been configured, e.g. if the kernel is built with CONFIG_X86_CET=y
> but CONFIG_X86_KERNEL_IBT=n.  The late clearing results in kvm-intel.ko
> refusing to load as the CPU compatible checks generate their VMCS configs
> with IBT=n and SHSTK=n, ultimately causing a mismatch on the CET entry
> and exit controls.
> 
> [...]

This got a bit messy, as I want to get the immediate fix into 6.19 (hopefully
I wasn't too late), and at that point there was no reason to shove the VMCS
patch in with the kvm_cpu_caps hardening.

Applied patch 1 to "fixes", patch 2 to "misc", and patch 3 to "vmx.

[1/3] KVM: x86: Explicitly configure supported XSS from {svm,vmx}_set_cpu_caps()
      https://github.com/kvm-x86/linux/commit/f8ade833b733
[2/3] KVM: x86: Harden against unexpected adjustments to kvm_cpu_caps
      https://github.com/kvm-x86/linux/commit/3f2757dbf32a
[3/3] KVM: VMX: Print out "bad" offsets+value on VMCS config mismatch
      https://github.com/kvm-x86/linux/commit/c0d6b8bbbced

--
https://github.com/kvm-x86/linux/tree/next
