Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59913D6CD5
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367761; cv=none; b=j8udzvbF8txG7phNmNTnpZYQ9Srwt/0Pmj6Qq0PKMCbTPVPoKsOOh+t5AZSiwKp9Evu3Bd6o9GTPFvEdLNOfhqDIvftQxpR3pJ6+l1N9LU97Rs1DXsFz3XShMk6a5FA6aUWmtquC7lb5SJmGz5EkPF+NI1j0aBI/3BbkVfGUPBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367761; c=relaxed/simple;
	bh=XU+Yh6jvhHTQ2a/3HxdMnwUDwPqj59NubIS9TFTIlO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KCmi4f2zTTrmsqeEGOUt9qiD2wslRBfEpUaAyVKe5DzikGjw4FCUazKRGmaGm8dpSBaJX9d2RtRGFdg5BZS2MvnCuFm1OGpshtQCeHgMXR1pXVigudskVujPJcofouUdf1rioykZOjhUhREF93mjy//LAuXCNYQaApjVBZ5Ixms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GFTsBg8e; arc=none smtp.client-ip=209.85.218.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFTsBg8e"
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c1c25c44d15so214448866b.1
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 06:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786367758; x=1786972558; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XU+Yh6jvhHTQ2a/3HxdMnwUDwPqj59NubIS9TFTIlO4=;
        b=GFTsBg8e5JqjVyVxIfQoJU/RBqO4kIluvSuEt97WBSw04286yjraGCDWwxU+Mse2pL
         CKeVb1jDRo3niDwFyWqa3LLchPBExcP13q/I3DXVJChQX8V6PwWP8406Vh8pFIRSNMgr
         wkZ8axmqGCVGF5qDkDbP3ynmIFGYZeO1dOEulEvP5wNTdVMLZs1nop0lQm0k1HdWx29w
         MPkI+OPJKg2SwZRF6FmNuKl4IbUjHG9QDDH5RvEv0dH82s9xEoipPH55C6QT+s6JDaiD
         VtVsujDfZNy5R1Q+3L7rAM7R45IBzEuIV92o9lFkqwP7hsdqqvsYa8FkRBsM389w0KwC
         Wc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786367758; x=1786972558;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XU+Yh6jvhHTQ2a/3HxdMnwUDwPqj59NubIS9TFTIlO4=;
        b=q9vC3OF6rYfbNj7+sLS5a6pjTdiNMnJWgc91GnAtIrCae0ljG5hKlaDMvddvNCh9Wf
         ACbYYcYqdb/BCad6063JOjbdJmZZTg4UB5z/D5cWRyoyeW6ylDqWsjYbx1C8L3IfgSey
         /B4UH254tAauH+ZIBiAIwm4sYBiU4tN05HjhgYgCA6Kv1DLS5LnwktsqLJk266shL8TG
         K5I8nYvD57x4iIdMyDbgkBpnMR21kKXZSO8G4s9If1blEqChHuGya8yNAS8xUZEbCH/d
         C8CkRkfHFdmyXu7/P5oV6aQggoKPVETrRie5oGUnN3n5nLJk8sxZhYytlBTm3c0BL1eN
         QdiA==
X-Forwarded-Encrypted: i=1; AHgh+RpYk80tGWOrKve7MvY00oZLcpBpdzYt1t1j+d+hkfN3AuXJ53osyouwqeLWokghiPfHRtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5wk1xZCcDPkp5szmDa00M+huFTqcNuJw3enOKYERnQC9EaiX1
	iKnJ8Ml7QK4TS6kPWRnd0zHh2a6r3wJtqekBIxYqIk3ntchn4Ug6RzqICJ601Ul+gI6mvDETRvb
	HsFzAzXA/HmwV1GiiRQ==
X-Received: from ejcww4.prod.google.com ([2002:a17:907:a904:b0:c19:52d4:dc8f])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:7955:b0:c1f:5f64:1912 with SMTP id a640c23a62f3a-c20c68b9233mr86192466b.7.1786367757496;
 Mon, 10 Aug 2026 06:15:57 -0700 (PDT)
Date: Mon, 10 Aug 2026 13:15:56 +0000
In-Reply-To: <CAEvNRgHvBTKaG4G5J=sMFGYepEnOFaeCBtjkzN6xmGtZ+o6XxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
 <20260728121138.1103610-8-tarunsahu@google.com> <CAEvNRgHvBTKaG4G5J=sMFGYepEnOFaeCBtjkzN6xmGtZ+o6XxA@mail.gmail.com>
Message-ID: <9huz4ih286b7.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 07/11] KVM: guest_memfd: Add support for freezing mappings
From: tarunsahu@google.com
To: Ackerley Tng <ackerleytng@google.com>, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, seanjc@google.com, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: linux-kselftest@vger.kernel.org, andre.przywara@arm.com, 
	michael.roth@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	will@kernel.org, vannapurve@google.com, maz@kernel.org, fvdl@google.com, 
	kvm@vger.kernel.org, oliver.upton@linux.dev, kvmarm@lists.linux.dev, 
	alexandru.elisei@arm.com, skhawaja@google.com, aneesh.kumar@kernel.org, 
	linux-doc@vger.kernel.org, David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, 
	kexec@lists.infradead.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

> Tarun Sahu <tarunsahu@google.com> writes:
>
>> Introduce kvm_gmem_freeze() to freeze a guest_memfd inode's mapping,
>> which prevents fallocate() operations and new page fault allocations
>> during preservation.
>>
>> Use a global SRCU (`kvm_gmem_freeze_srcu`) to synchronize freeze state
>> checkers without incurring per-fault locking overhead or risking per-CPU
>> memory exhaustion (as per-CPU structure not counted in cgroup) from
>> per-inode SRCU structures by faulty/compromised VMM.
>>
>
> I wonder if everything to do with freezing should be gated behind
> CONFIG_LIVEUPDATE_GUEST_MEMFD. What do people think?

Right now, Only liveupdate is the usecase. There was a discussion
around the future usecase when IOMMU FD can use few pages from
guest_memfd and will have to prevent punch_hole operation. But
that will also avoid new faults. So freezing is not the solution here.

A SEAL type solution like in memfd can be explored later. But this
is very far in future so Plenty of time to discuss more ideas.

On gating the freeze across CONFIG_LIVEUPDATE_GUEST_MEMFD sounds good
 Idea. As in future, there is a plan to remove the freeze at all from
the preservation path. Before LIVEUPDATE, there was no usecase and in
future, that usecase will also be gone. So gating it against the config
makes sense.

Would love to know what do people think?

~Tarun

>
>> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>>
>> [...snip...]
>>
