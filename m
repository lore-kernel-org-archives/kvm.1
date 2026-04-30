Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E513933374F
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 18:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777572303; cv=none; b=Hu8DnJ8GBUMksp+IA0DRWFhct6SQa/TYHxXi0veUBOdmRCXzZa3zBAnNi/QvoQfXlMESNPy2Md0prYB3s4dJjGWixkKaCHRXBY7VF4+awbhNwfay1HICre04haROUNC8ICZDBTieoiXtaQFNzurB6j7sownqnxJXndVzZBRP1KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777572303; c=relaxed/simple;
	bh=0jyakFSOwcrlsI3bihlbsbMEQRRTZqmFvYR2ZvD0L4o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VAo7GIa3XQtsLW3KJLhbwCmzHof6adPuYVCFsUVaiGPCgvwrc8A9iR5lk/6+eJXFYNO76NOPVMJfY87LwLH6kzmKFkVkCFvqlUyht+ntD8im3JBgQA3c+F01Cq6pf1g/qgiif+z+c7iWRwPZwQWRYEMdItrILZtQI5uu18QUrS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nvT6ZK3O; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nvT6ZK3O"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f8bbb4045so738608b3a.2
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 11:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777572301; x=1778177101; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nh6SF4JLNSjAgzZteQloYKD+0xB5PbyFLeDfh+8tIAo=;
        b=nvT6ZK3OVlyvrQ8fNWrSypsOMAjiGGJt04U6FyWznMOQWPLSFh9XssI72hF/DO2H4V
         ybxcOdhMtJVZLS7uEYNSni+tjXO7MdmjKUYE89pctHUThCMg+Q38W8zMkyM3+J8NbtvM
         d1dxryto3u6aFa07cuquTo2rcVzVLj4wGWS1JjPJ6TlHEAB6E29yYH8nKHRD9OTm4USZ
         LbU8otvyZG5ZDLRsn57cwJDHCA55MhIGQ6rIhB2J16pfIaYvwxQ6Q8agLwDFhoAmRXRh
         F2m4d+2wrG8wL7w7NfFD2oPiCKoODypR45hq9DrUcscG99eRBJgzCl2yPxIuXI+j5yE0
         bYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777572301; x=1778177101;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nh6SF4JLNSjAgzZteQloYKD+0xB5PbyFLeDfh+8tIAo=;
        b=EQ+krTITg1iQO8Dt4g6IyNBEeEi76+HNDjN5fC06VxgMhkJ6Sw9+SFLZaq45i9kTR9
         w6zfcmQzKXWVb7VLpsudfnpbjLG+4U3VcbMktualikOGjpo6/USrTaE5EL895GimXr+p
         EjT3NIXngs9Ypp18dD9RL2XAm+PTSciSgu1U30XoII+0kQUlZVbGadEumj0OnHvWm76c
         rhaFg1GJJbrneqbUbNLuBFkmaNDdOdCVsl3JgGzyXsUHnX+xaPIVL+rc9gSWDg1eGvPr
         DkiGMqkgPhxBpTji09LEb2QL5Yg6qB5jN8COqOlaG9pixvpcJkrDp01nafdNfidvTy8n
         lhNw==
X-Forwarded-Encrypted: i=1; AFNElJ9n6yuDqWeEZ2Gheux47BtWwQGXVgwXUIlfkDPi0/vegYOAgF4cr1Y5GOEmkEFViW+5+nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww9hI4a1yzm8MZ32ZBjsg+4eUM/7v31UC/otXpx0mLo9BorL/e
	84H4Sq96WpasXRH8q4joDUGkf98RBexdiZGL+R42/8sq/NcvM1W8mo3GEhLLsiI2NwLWhAOedyE
	bI1fYfQ==
X-Received: from pfbjw26.prod.google.com ([2002:a05:6a00:929a:b0:82f:ba4a:d050])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:f8d:b0:82a:7893:e14b
 with SMTP id d2e1a72fcca58-834fdd3f090mr5019262b3a.38.1777572301059; Thu, 30
 Apr 2026 11:05:01 -0700 (PDT)
Date: Thu, 30 Apr 2026 11:04:59 -0700
In-Reply-To: <20260430150747.76749-4-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430150747.76749-1-pbonzini@redhat.com> <20260430150747.76749-4-pbonzini@redhat.com>
Message-ID: <afOZy-c8FwysG5oz@google.com>
Subject: Re: [PATCH 03/28] KVM: x86/mmu: free up bit 10 of PTEs in preparation
 for MBEC
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, d.riley@proxmox.com, 
	jon@nutanix.com, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 30, 2026, Paolo Bonzini wrote:
> From: Jon Kohler <jon@nutanix.com>
> 
> Update SPTE_MMIO_ALLOWED_MASK to allow EPT user executable (bit 10) to
> be treated like EPT RWX bit2:0, as when mode-based execute control is
> enabled, bit 10 can act like a "present" bit.
 
For posterity, this matters because MMIO SPTEs for TDX need to be RWX=0 in order
to generate #VEs on any access (hardware never reflects EPT Misconfigs as #VEs).
Arguably we could delay this until the TDX-Module enables MBEC (or maybe that's
already in the works?), because even though KVM enables MBEC, that only matters
for non-TDX guests.

But I don't see any point in delaying the inevitable.
