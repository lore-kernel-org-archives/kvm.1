Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3A133B6CC
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813328; cv=none; b=hrGCLAAMmol0dn3AabJBAfn4oTe4fKaPmIwLmyb1UyimYSua+sbE1lESNtDtPHmAD7yr5B60o+RJ4/EDP1mH3FW7VhG+CdZkQ5ZniLHZebiR1UD4gNeMWezB8ug7TVB2+S+Q1lsWt7B0YyhsmhMzWopzsNXKF057C4ugs/q7Xzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813328; c=relaxed/simple;
	bh=/foAcyRbPhtlo0zvHRTqVHIGrBYvfobgoTE1vTtcw6c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QqpVQmgvIKCHGeIz2g03+aVfb/YG64CV30c1HqMwTN7nFXIXc+Ppnpe53x31jv2rzdjUI4LhAllX7lyWH7pXCiYo1ki2Qe7fMT112iGxNvXCeK25fF7fgRVeqAFIvnq8c4GJQoxgF8q1Fc9xbPG/sR3l/UtScxC3RX5w8lGgb5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RhlqNfef; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RhlqNfef"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f6b0a7164so6714214b3a.0
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776813326; x=1777418126; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wBkw5MFUES880nys/IZGP/M14ZZqVIt9D3WkhSnPKCk=;
        b=RhlqNfefZK3Cv0bqEC0v45Co9gXDo+8L0scynS60K8UNVnqIRa0h3xl/xJTUuDAyPM
         k3xDDR3wWGtsl9OXOthENtHkJ8sc6sBT7lxP0N/44wbvGY0fbn3kjEXGSxuNSb/V4N4D
         34hFU+tvB/QnpMLcxgooMb7M+THyMmX+h55oPu7T7+6VKQ2Z6rMe6QXpWHu3DY0B0wPI
         IIcOXOH9lqp2feRRoR5ZW+4J4xKG1jDeGWXKmAHaMSJPbnqU7CRxehdDAr9sKXhXxIsY
         BfdJCqNpErhjCxIMzphGK5zpRm6+sdDneXhXeW/+CIUNUjpOhht03pw2mJYEdLHB42m0
         aAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813326; x=1777418126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBkw5MFUES880nys/IZGP/M14ZZqVIt9D3WkhSnPKCk=;
        b=NXjSOcGQtiZIAIee/Zf52CgZ/VI74WmmbrV/tUV1WKYdgEBMBCFG7fheGjQ/i2lqrp
         TMLatxMV7XJzvsy6I0VzFvITx4hvK3Qx0lSLdM2Tx1C2Qj6GO7+SRrPd/mS4DEuhRhrD
         n7k7GgVqCMIbbKSJOaP5I/sNjv4txxR/BEjyBGCpSH9o6WaPbv+mMR6FatQgwRzfie/q
         +h/YD4iaHFRe/+XqMk0IE9b0XLKvGpjV6cZiJ1twPv4OOWOpkI84FH0ZxFlt0SPdmDR6
         IoGW+i2LN5mbbABKK74zaocfGbcsiJpUmROOVjto2k3aB8/zS4SURLaNOq1wz0Catq44
         CGag==
X-Forwarded-Encrypted: i=1; AFNElJ+JC+vVDBr2iVM/mpjIC6ZiSO98GXOMrPv2wI+qvf1jyzE4ckiP/I2/0ERDC9PerWnrU2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBOxkNPYE8HhC6/AcUpVPOtS+1vmi9d0dypp54TQHBLHRRHThp
	aQj184v6jOdLQ5JVUT9dqq/Iiz53W6b+aMxPeLvbhr+WaGopqI1TG/ZwX6wHRsXnvvNGj8OK0Ws
	VcLgYfg==
X-Received: from pfbhw5.prod.google.com ([2002:a05:6a00:8905:b0:82f:71fd:3094])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:928b:b0:82f:6dad:7b75
 with SMTP id d2e1a72fcca58-82f8c8ebc91mr22055925b3a.33.1776813326123; Tue, 21
 Apr 2026 16:15:26 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:15:24 -0700
In-Reply-To: <aegCKy-4wxRq2jou@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407063245.2755579-1-nikunj@amd.com> <20260407063245.2755579-8-nikunj@amd.com>
 <aegCKy-4wxRq2jou@google.com>
Message-ID: <aegFDBWMUvhR53c1@google.com>
Subject: Re: [PATCH v6 7/7] KVM: SVM: Add Page modification logging support
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Nikunj A Dadhania <nikunj@amd.com>, kvm@vger.kernel.org, pbonzini@redhat.com, 
	thomas.lendacky@amd.com, bp@alien8.de, joao.m.martins@oracle.com, 
	kai.huang@intel.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 21, 2026, Yosry Ahmed wrote:
> > @@ -3253,6 +3278,54 @@ static int bus_lock_exit(struct kvm_vcpu *vcpu)
> >  	return 0;
> >  }
> >  
> > +void svm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
> > +{
> > +	struct vcpu_svm *svm = to_svm(vcpu);
> > +
> > +	if (WARN_ON_ONCE(!vcpu->kvm->arch.cpu_dirty_log_size))
> > +		return;
> > +
> > +	guard(svm_vmcb01)(vcpu);
> 
> Why do we need this? Why not update vmcb01 directly below?

Yeah, I don't see the point of patch 6.  guard(svm_vmcb01) doesn't exist in the
current code base because it's not needed.

> IIUC VMX needs this because it updates the loaded VMCS, but the VMCB is
> just memory.

Yep.  If VMWRITE could target an arbitrary VMCS pointer, VMX wouldn't need the
helper either.
