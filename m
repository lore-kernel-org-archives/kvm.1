Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E0C3BE650
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781096705; cv=none; b=PD8mQ9cDAhj/LTPDYfCQCdwKVXY1gAdiVQSgLzRWWld/23fHxazXDu1OBhfv8SnLnxQ8OfloXOaNpVvK+I6qX6MOCkUA1bOB3vvl205EGbF5N6oG/lYIqcv78+zZvjhJSuriEBvWMpML1K/4gWEN5uv8zZjmzEUV9d2grmn99es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781096705; c=relaxed/simple;
	bh=cS5Vu2k8ew5BuHAbqb/2rJPrdcCho060bAVKmhfgWkE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Rq6zobFVotEHKU1Su9Cf2no9Gd/9yTUtY0HsnCoQQxc4ApxZ6lKi4R7pu4Hak8ojt2Sjc47oVHvE7Q45/zPqAYYkq6YZPGQVCQD3M4FhC60H1Fk0EIsu5W1sfpUfTZuYkmQuVAkdDABsmh+HJIDt3nYB/i8WTcE5QmWpF2t54yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EErBQvzI; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EErBQvzI"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36d5b11201aso4301664a91.2
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 06:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781096703; x=1781701503; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BhOF/rw2NLmHZ4tMIcOqKhkPNZ2ah5k2exN/z5Da1iM=;
        b=EErBQvzIqogZvMKh7Fra3t+cGdaDe5Xyi0SbB1EhQUdTD5vCEa7UzgXaMC0nXlyh+m
         Zix7ftQ/ZbIIPTpSTNdNP5gvWBGJCmmGNQC4qTHZAkzmXZxPmd39wMVAGXtGH1rAueql
         AKRdi56mHFMsmEP2fHOyD59n1ZwkKqyuqhCIUNReTLL18RR205OMqhczyLetbvUuDt+E
         KPx5JamcrqUzYrxhb739u8161FC9IpxVLoFAO8uXIsXuizKe/FLXq0yUdTeaiMXjuMvi
         +A5C7AyYXPaRP90It3gkq3hY4uK2/iAQbnpFz1yHF0pF83ZwcS4ccxnBIZANdsVV+pJC
         YhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781096703; x=1781701503;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BhOF/rw2NLmHZ4tMIcOqKhkPNZ2ah5k2exN/z5Da1iM=;
        b=RcTaqVwqVhpS26vEEJ4oQizdzpHHKSuhE1ZU/zr5b3akkFmx5PwtsX9dVxvmFcRprj
         XoSlekBN5VPDEdbIA8XI1/K+Fh0lxr2Qh08/6m8GadGR8KOqxpkveFefqio+wqkcOxHu
         6sBV33IqCTEMgM++u2JDvHvhXvRXPsSmCXFj6SDbbV1YuT9Z3JISL9SCFP17wXSTztHS
         nbAzS31DIQ3zyaBlgD/gYAuwkgPFaFnEvbal79gD+Ldq/L+N2LMQ9o+a525M/3CywjnQ
         rcw3DT6JNikuZ4xRvqLx5wCCs6Tfd93sQq1jXLcYpRLNF+5gs9brUnRckKsjj08YRVJW
         sJHQ==
X-Gm-Message-State: AOJu0Yz1Pyl6ltsGnXdajCVwAzVAnB3zCXkFoPgOENh0ovN+0Zy39scp
	cC6GcVENbARXpezXzPgMw04uH3Qd8s7S3BWmfuv1UtF7FJmMJxpE0dHk
X-Gm-Gg: Acq92OGnTLeOEhPsUQGDp60wNTVvDnew0/jzHP1I7DkLMGrmWS4ECKn9WWOPOm9Ar5Q
	qor4BrFDL2d9vZ/a2o+MPzHd2Us8+vWrhH55W8YLK/qWdS9sCr5nvPQ/zjbciv9NnIGXu2nm+rE
	FauouV/QOXA6abJ5LcZgxcHsF+p+POwEbccKRB8mNvXlEcUgzKA3jVWAtRk/77GR0aqTxLhsL+8
	96ao1AczNpj+w5U4DxmV0OvWp4XFcc9MLhbQQTLOWDhcCGYNaMHulfmyhW693dNFMsrY5o6Z+yr
	74Ra/U+qIJzdFMKM2uT1S7Q9P3Kelyq0g4XzCcfQY/7GZfK4I4uOOd51OL6KqcEKtxI7hgtsjj8
	ozCEIVv4gEvSO/NBw8fITEAM1P/8/wyCbD993i+w6wJ4TgwebnOC26+B2NaJILlzyV8A6WGn9i9
	WJ1L4uVAS67BBAIOoGd2ch1pjjmawdc4rP
X-Received: by 2002:a17:90b:54ce:b0:36a:a16b:5f6d with SMTP id 98e67ed59e1d1-370ee82fe77mr27086714a91.7.1781096703627;
        Wed, 10 Jun 2026 06:05:03 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37625ecfed4sm1493221a91.0.2026.06.10.06.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:05:02 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Ackerley Tng <ackerleytng@google.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v3 RESEND 00/10] KVM: selftests: add powerpc support
In-Reply-To: <aildxtZhqEFYygp2@google.com>
Date: Wed, 10 Jun 2026 18:23:48 +0530
Message-ID: <o6hieeub.ritesh.list@gmail.com>
References: <cover.1781093720.git.ritesh.list@gmail.com> <aildxtZhqEFYygp2@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Sean Christopherson <seanjc@google.com> writes:

> On Wed, Jun 10, 2026, Ritesh Harjani (IBM) wrote:
>> Nicholas Piggin (4):
>>   KVM: selftests: Move pgd_created check into virt_pgd_alloc
>>   KVM: selftests: Add aligned guest physical page allocator
>>   KVM: PPC: selftests: add support for powerpc
>>   KVM: PPC: selftests: powerpc enable kvm_create_max_vcpus test
>> 
>> Ritesh Harjani (IBM) (6):
>>   KVM: selftests: Print the vcpu_id when KVM_CREATE_VCPU ioctl fails
>>   KVM: PPC: selftests: Use u64 instead of uint64_t
>>   KVM: PPC: selftests: Use s64 instead of int64_t
>>   KVM: PPC: selftests: Use u32 instead of uint32_t
>>   KVM: PPC: selftests: Use u8 instead of uint8_t
>>   KVM: PPC: selftests: Replace u64 gpa, u64 gva|vaddr with gpa_t and
>>     gva_t
>
> Squash these typedef changes into the patch where the "bad" typedefs are used.
> Give yourself attribution for Co-developed-by if desired, but don't introduce
> code only to immediately fix it.

This was noticed only later in v2->v3, and I wanted to keep the original
patch from Nick the same. But no issues, I can squash this in the main
patch in the next revision.

However I was hoping if I can get some feedback on the overall patch
series as well especially the non-powerpc patches (1,2).
One other question - Should this go via powerpc tree or via kvm tree?

-ritesh

