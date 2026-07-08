Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2B5379C2A
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517924; cv=none; b=dKx0PVXDBgda/uHgra5bXLYRo72XCNho5DZieY7ASEOkU66rK1BVCVXUzQCInisGVJCE+mdgFqgASK81uHNkj4O4vs5D+1TFNzYQzyjfQcyzkZjgmalHPR54qI+zZ1gozZCEaJuQvttkmj3PZXrXMSSZhufMh11bDflcbxaqiXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517924; c=relaxed/simple;
	bh=XMqR7Vt7Zu1rEVb/wo+OI6Zz2nFEcyiLoyMkLEqY1cA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FTpIN+jUuaSJMKh8e5QlqltVSliBt/ciokp9+fVubLgRzO/kYZOmjcDOXisHfnIdU8rWdKXzcIgw8KfBbNb209fqhY2EmkCjwL1WHcpOWHWF2ZCX1qZ91oIGjh3wXe0VbSLB/UtPeWhvLEG0Xg5IrH3gOdHgNsvlJe50Q+snYHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PUnqEhkz; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PUnqEhkz"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c88da04b719so692441a12.2
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 06:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783517923; x=1784122723; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U+G9o1zSTCJcxxAOl2khdNwOmpU0MLiiAaN/I8VPs28=;
        b=PUnqEhkzGN+zT+RoVF4bYlbA0WH3Z1eC4hkwIN/LjatGD97NLnjuzRWmeZTNyc633n
         wRVPJMnhmu4GckwIys8YMBLfVQOqoG8oKmD4spKeBXFolEe6byteKfRpSdfxBxK+V2E4
         ywtr4TqLy/rsG6t1I9LeI+lpF2jxNv2Ud5kYOcdhPkhdfRG8iX4ZKl4GV9ZhQvymMqoX
         e78ZgGutk2p4jH2/Gc/196k4zk1ZZwIRKrWo9Fo6AXL6Iqv54cg+jMpOiMh3aIGRvfB6
         kn71n8qXrSwtGFJa7CL0dp9jhH+CCf5W2r2tU+eS6TVIZpYEKQmuCjRVxmU3YFdoFTEr
         44sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783517923; x=1784122723;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U+G9o1zSTCJcxxAOl2khdNwOmpU0MLiiAaN/I8VPs28=;
        b=dYZKS9OCd1WFSv/U3e9TTgBFG3UjFp2KDKM/0YtssmNmibhJExAXKyhztoqxxpTtMU
         rkmTn2HC3+KdtIRQEo8+eUGu+F0ykU1Xcw2JPBaT4NbUU9QIvt7OCNVm/oDdkiogLT78
         8XvXU+yJ3+ktfuQNC1syG6j0Yc35RDndozFGEkb/lhMezvz7pVQ6zxWn6zDHm4oD8DP+
         U+wZOZ5Ic0lhO/FXmpTAiU0N3Uy26J2Yeabj8EULu+9SQ/76dvmPD3Wk56eBBN02Ly5O
         F/Oxp0IHb9cTcSDCIlXqxMdUmcIa0xcbk376nNO1OsB8oI/ZlJ2slH8jZdBnCORSX7Ww
         vA1w==
X-Forwarded-Encrypted: i=1; AHgh+RrwD+0CjPD5EpHAXydzsULLFKiDU1QHkFr1dV/Bm3mKM+RZLSYA3phH41TlASWJaap5V20=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAPIAGZ7QTFj9PmcyshSqbfs1rtjiYgb4dDlzuL28LOZr8aboJ
	hlod0lLZxYVEngimed863F9Of9dhIDP7SfGdsU13DPh+NU3tNtWa6XoldJgyQzF1649300/2Kso
	UyAkEGQ==
X-Received: from pgbe18.prod.google.com ([2002:a63:5012:0:b0:c8b:2f5f:81a4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4591:b0:3bf:6f9f:3381
 with SMTP id adf61e73a8af0-3c0bc9c00b3mr3154704637.33.1783517922783; Wed, 08
 Jul 2026 06:38:42 -0700 (PDT)
Date: Wed, 8 Jul 2026 06:38:42 -0700
In-Reply-To: <20260708091408.12106-5-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708091408.12106-1-sarunkod@amd.com> <20260708091408.12106-5-sarunkod@amd.com>
Message-ID: <ak5S4hKoGxEb-4fP@google.com>
Subject: Re: [RFC PATCH v2 4/5] kvm/svm: Update the per-CPU wakeup-list during
 vCPU load and unload
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Robin Murphy <robin.murphy@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@kernel.org>, 
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

KVM: SVM:

And this shortlog+changelog is woefully inadequate.  For all intents and purposes
this patch adds KVM support for GAPPI.  So, state that in the shortlog, explain
what GAPPI is (and spell out the acronym), how it works, what KVM's scheme is,
and so on and so forth.  I'm not even going to try to review the code without that.

On Wed, Jul 08, 2026, Sairaj Kodilkar wrote:
> When a vCPU is unloaded from a physical CPU enqueue it on that CPU's
> GAPPI wakeup list. Remove the vCPU from the wakeup list when it is loaded
> on to a CPU again.
> 
> Also enqueue from avic_pi_update_irte() when vCPU is not running and
> ir_list is still empty.  This handles the condition where vCPU load skips
> the per-CPU wakeup-list update when ir_list is empty.
> 
> The GAPPI wakeup handler walks this CPU's list and wakes vCPUs that still
> have a pending IRR.  Install it with kvm_set_posted_intr_wakeup_handler()
> so deliveries on POSTED_INTR_WAKEUP_VECTOR invoke it.
