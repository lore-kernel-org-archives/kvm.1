Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E1A3B47CD
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673403; cv=none; b=SGGnWCBKXzq3hOrN1H5sP0nLvmoEDBhK2NTffDX+mrjbt38Fhrze3lGiFf+Hq6Y1UFpidr5wZyVbIOu7baUeyFXJgUMRkVnZfGKthtH1R2nlC+W5a3MMjny1Mdiaq3usBU9WVabwMaB2JMiXUAhEY/ZT5YOECjlu9V+IopJLyj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673403; c=relaxed/simple;
	bh=tHjG9vQi2IrBN0TTfmCXHotbCB+m4BkQnD2fcTAFqgI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hCXQVLz1kF9lIyB5eVsYhs7uFgM+9SIBYyR6JawzARXICtyYxceAoGmRoHQSOPfyDDMRY3IU6C+Yv12XxiwA1Fr47XYDRMmjS8J2uFzeWpiI2w2TPQaxBCVUr1/+kA/Dv7EurRT9DdFIMa05yUMjPD4xgA/7V+4Jjc7J5vXHXY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FYzj62zW; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FYzj62zW"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39de4a68f7cso50279a91.1
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 12:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789673401; x=1790278201; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1mrjzrdKauTI1kt3ea3M47lmxrEOAZpZ0W0oj81G6CQ=;
        b=FYzj62zWMtbqYzOn4X1Kpuzzyq2hyh4fYY89MSmAzGaqcuiy25IyUKdEOs3eMfQvdd
         Qz5S6SZtvZ6odp96LJPtpCKmuOPOLKOe+fshtpfcKdGn8cDfo5aibL1xwAL0N96mmrmw
         1vZu4vgbqfqBbiRbK5WXgtrTTV1Axj2z7DwUxAHayMLVhxB/9b0f52q7JvO19+Hqy8eV
         ul7OOczaVsoeAHS9H5CbRC668UGFZYj4webKoFcOEUlH1YLtIyjFe+Xwb0pn/r1AJG71
         VzGXd5TK3+dT3OmVwIVW2i2rWr3y6PwVKnq9O9Z+uNo9B9GK4WCoNbqFsV4Cn8A+f+2j
         yNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789673401; x=1790278201;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1mrjzrdKauTI1kt3ea3M47lmxrEOAZpZ0W0oj81G6CQ=;
        b=1NNDEqo7H2gDfU/NgZWKQdkDgAkUVImb5SXIy+TI0yr/rQ80ROZIijiL2DTnSoOSj9
         QAWXOQJlE3rBhhQpP07MY8k+inoiG/YlgJE2Z5mBJSqnFuthxfdByc66bXrhQHZ0s2NY
         oheK9bCxhO3SxrHVxWa0LxhFsOKR3Wp7y2cXXHBUrKHVzBfStNN2bx74yJLFUhsaBiCs
         WhbBOnOhUX6Dq7iWSipOTwbi3P0NA4bYJx7Y2Fu94zVSFbmFMav91BXDnxF9meenRyI1
         eT1CW+5fTzMXX3+3HChFIGX5o5rGHvQdDhnRliwee2N4Q/vUo2s0Lggu9SH1VsBk9jOr
         XolA==
X-Forwarded-Encrypted: i=1; AKwUvBwAG0EOjjcKXgxWbJv27B2x9dZE+/dLhwrhF0BnMCXXREikp63NnzFcdQrGf3Ly+peUjBM=@vger.kernel.org
X-Gm-Message-State: AFuF++k5nm+g0imdLzJVSCOqxHrmuPIyj7Ec1Q7OvvcshewvVCG5L8ZC
	wcllyTqVZpDRDUBtta3PATuE3LRykLZh+b/kz1cx7n9UKX4mVGRzYD8vnJA7INxA9mccjh5WbCf
	eIzs3yg==
X-Received: from pjwo24.prod.google.com ([2002:a17:90a:d258:b0:39d:93fb:c298])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b82:b0:39d:f06f:79be
 with SMTP id 98e67ed59e1d1-39e5502546cmr549736a91.15.1789673400989; Thu, 17
 Sep 2026 12:30:00 -0700 (PDT)
Date: Thu, 17 Sep 2026 12:30:00 -0700
In-Reply-To: <CAEvNRgGW_VHmT82q+bUqHh_5G2Z9sUF1jJOTiVN4Z8_cA9A50g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <b91dbfae-20f1-4b9f-a25b-4397afae80f9@kernel.org>
 <16ffff40-4ef0-4312-a700-348603f05c0c@kernel.org> <CAEvNRgGW_VHmT82q+bUqHh_5G2Z9sUF1jJOTiVN4Z8_cA9A50g@mail.gmail.com>
Message-ID: <aqw_uBIYig_uo5Eq@google.com>
Subject: Re: [Invitation] bi-weekly guest_memfd upstream call on 2026-09-17
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	KVM <kvm@vger.kernel.org>, amit@infradead.org, aneeshkumar.kizhakeveetil@arm.com, 
	ashish.kalra@amd.com, dwmw2@infradead.org, eberman@quicinc.com, 
	fvdl@google.com, gshan@redhat.com, jackmanb@google.com, jackyli@google.com, 
	jthoughton@google.com, kalyazin@amazon.com, kas@kernel.org, 
	kevinloughlin@google.com, liruxin@google.com, michael.day@amd.com, 
	michael.roth@amd.com, mike.rapoport@gmail.com, mvaralar@redhat.com, 
	pankaj.gupta@amd.com, papaluri@amd.com, patrick.roy@linux.dev, 
	Peter Xu <peterx@redhat.com>, pheragu@quicinc.com, pkondeti@qti.qualcomm.com, 
	prty@google.com, psalian@google.com, qinkun@google.com, shan.gavin@gmail.com, 
	shivankg@amd.com, sidtelang@google.com, suzuki.poulose@arm.com, 
	tabba@google.com, tatashin@google.com, vannapurve@google.com, vbabka@suse.com, 
	wyihan@google.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 17, 2026, Ackerley Tng wrote:
> At the call Sean suggested mirroring the RMM's tracking in KVM, but that
> sounds quite arch-specific and it's like doing arch-specific validation
> within KVM.

I suggested "mirroring" the tracking in KVM arm64, not in guest_memfd.

E.g. put a structure in arm64's kvm_vcpu_arch with a list_head object, then insert
into a per-VM list store in kvm_arch on a conversion request.  But before inserting,
walk the list to see if there are conflicting requests, and if so, reject the new
request.

Then on KVM_RUN, if a vCPU has an outstanding request, verify the gmem page exists,
is in the correct state, and is mapped into the guest (or at least, is known to the
RMM?).  If any steps fail, exit to userspace with -EFAULT + KVM_EXIT_MEMORY_FAULT.

The downside to such a simplistic implementation is that it'll require a per-VM
lock to serialize the requests.  If the contention ends up being too painful, e.g.
because there are usage patterns where guests due batched conversions across many
vCPUs, then KVM could use a more sophisticated approach as needed.  E.g. shard the
tracking+locking at 1GiB or something?

> p.s. Fuad, for pKVM you also mentioned that you'll need to check if the
> guest had requested for conversion first? This might be the same/similar
> problem.
