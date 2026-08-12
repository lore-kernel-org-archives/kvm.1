Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DC3305693
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 23:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577128; cv=none; b=P5g07vwX6vleswpgH8fPg04ImMZOCYy2BpO55ASJeiYCgskoN95gQfqV7a/AVQ3Zt+rZSa4t1CcZpyKVfYz+EBh3P50nplbrcXiYGKVCKnyYAeE1Gj8XnDuttacl0y6cLo61vnDJU37l6T3czcay5e0rcOVkVz9EByeUkweHaKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577128; c=relaxed/simple;
	bh=sgP3uZ33d+tGmQNkjALvQAksfc2Kdz+7QuQdBnhH5As=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oKLrBj17bZ6eF1g26qXQBW3Ij026Qha0BSa5uBOWQZ4vhSWqs3x5iU6d83iCO4N4bvT+ppJRCx9ezLsSZY0M1NEwPUDdPgv4RIYbALa2cjoHAfCebLpXXAI7FpOnqZQATCd+mboBC9fnlfrqEm4I8KGula+1sLAwFrDUONoPa4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F7E7Ayin; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F7E7Ayin"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb6cf425e86so251794a12.1
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 16:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786577127; x=1787181927; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kIcZB/igVhEjJgsGvPpm3GWcTXRX0i5DFm1etYRsT/g=;
        b=F7E7Ayin7FYlNx54KZ7Zs2/j5G7rl2Ht3r9o9pBt68qzR+kEtSQvRpncFj/BOEOivQ
         LB2bn1bhfL2mDbJJzY46R+9JJ2yiuGiC3leTciLTsmj+5kh3esz2dFO0poRnhZd9zN7p
         qOQi/x7UKJ4bVnWiwFH6O6H8fK7YRiqNv+dIWNzetqBoPTWKGj5ijr5DOSWgXlJ/P5cJ
         b5JIZl/DaZWvvhw921QyyuGSjUN39I+pqhtChYSks0xORAMG91CqX2qe6D+WTAy5bYlO
         svGrXn7xG/lNrtDefdGE3CpdeMBCVgSmqCYs9TNLRrado7mIKyUynrFEBuXY7zuJP+HK
         d7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577127; x=1787181927;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kIcZB/igVhEjJgsGvPpm3GWcTXRX0i5DFm1etYRsT/g=;
        b=Ja6tOGKdlzYPyoMIcaGzZsLUKSbskSgUl2yrm50ArP4tZEvPMNdcfYlHSh1SZAAr8d
         7dX1hyyLxAk3w1sT3m6Uloh3zNd+mO4WSgd6vzZWj629IZk74r9ZdF6QGo6AINwbEMHN
         k8N9F7lxQZZh8CAOeZHBMRB8kzrZ0rIkqlbDOkRabPiddvsDGPsE9XmHlXlXyLfvIZVd
         92wSMe6FF9+Rzi52fZWVKp/Jn4cxfnVaZ7IFPHapct0Thh9f3fv8Og7HLyqm0B5NM/em
         aS/1g0+szwTArNlPmA5FKHTmDZRZcyUPuytnCSmH+5H2OL1dToCXv0I4z2t2hZGxbs9K
         eWOA==
X-Forwarded-Encrypted: i=1; AHgh+RrQcNdZnymX+m5gW+bIT91S0YEHeJUpYgkzfx57OqjWvLlKJ1XhT/p3mosnkagsgxoYfRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwLTAV3aeh7Ya5dI0JDtOdtSw7ip3JHF7FO6zn9w0Se1NHxC60
	ncxQiZMyo1DZtOryCIM5Yk/iIj2FqmdBGhfWgopUVn9D2Iko8I3CeIfD4w7bUgftWebv8EYfBTC
	fCekEFQ==
X-Received: from pfoi24.prod.google.com ([2002:aa7:87d8:0:b0:847:98fd:5a98])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3285:b0:84f:5cd7:e3c6
 with SMTP id d2e1a72fcca58-84fc6ce9245mr1638976b3a.5.1786577126664; Wed, 12
 Aug 2026 16:25:26 -0700 (PDT)
Date: Wed, 12 Aug 2026 16:25:26 -0700
In-Reply-To: <b5f2e0a4-09c1-43d7-b700-c8760d70b195@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <77f1f310-d789-427e-8c10-bd6ac4836add@amd.com> <20260529063833.1660791-1-nikunj@amd.com>
 <b5f2e0a4-09c1-43d7-b700-c8760d70b195@amd.com>
Message-ID: <an0A5lql-rinvm-n@google.com>
Subject: Re: [PATCH v7.1] KVM: SVM: Add Page modification logging support
From: Sean Christopherson <seanjc@google.com>
To: "Nikunj A. Dadhania" <nikunj@amd.com>
Cc: pbonzini@redhat.com, bp@alien8.de, joao.m.martins@oracle.com, 
	kai.huang@intel.com, kvm@vger.kernel.org, thomas.lendacky@amd.com, 
	yosry@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jul 13, 2026, Nikunj A. Dadhania wrote:
> 
> 
> On 5/29/2026 12:08 PM, Nikunj A Dadhania wrote:
> > Currently, dirty logging relies on write protecting guest memory and
> > marking dirty GFNs during subsequent write faults. This method works but
> > incurs overhead due to additional write faults for each dirty GFN.
> > 
> > Implement support for the Page Modification Logging (PML) feature, a
> > hardware-assisted method for efficient dirty logging. PML automatically
> > logs dirty GPA[51:12] to a 4K buffer when the CPU sets NPT D-bits. Two new
> > VMCB fields are utilized: PML_ADDR and PML_INDEX. The PML_INDEX is
> > initialized to 511 (8 bytes per GPA entry), and the CPU decreases the
> > PML_INDEX after logging each GPA. When the PML buffer is full, a
> > VMEXIT(PML_FULL) with exit code 0x407 is generated.
> > 
> > Since PML_INDEX in the VMCB control area remains valid after an intercepted
> > SHUTDOWN, only initialize it on reset and leave it unchanged on INIT to
> > avoid discarding already-logged entries that haven't been flushed.
> > 
> > PML operates on guest physical addresses at the NPT level, tracking D-bit
> > updates in page tables rather than memory content. This allows it to work
> > identically for normal and confidential computing guests
> > (SEV/SEV-ES/SEV-SNP), enabling cpu_dirty_log_size to be set uniformly for
> > all AMD VMs without special-casing encrypted guests.
> > 
> > Use vmcb01 directly when updating PML controls to ensure L1's state
> > remains correct, as svm->vmcb points to vmcb02 when L2 is active.
> > 
> > PML is not enabled in hardware for nested guests; treat PML_FULL as
> > unexpected exits.
> > 
> > Add a new module parameter to enable/disable PML, and enable it by default
> > when supported.
> > 
> > Acked-by: Kai Huang <kai.huang@intel.com>
> > Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> > ---
> > 
> > Sending updated 7/7 patch here, rather than reposting the full series.
> > 
> > Sean, any remaining comments? Happy to send v8 if needed.
> 
> A gentle reminder

Sorry, I had moved this out of the TODO queue when I saw the "will fix in the
next version", and didn't pay attention to the updated patch or to this mail.
I.e. was waiting for v8.

Hold off on v8 for now, in case there's more to address (I'll move this back to
my queue).
