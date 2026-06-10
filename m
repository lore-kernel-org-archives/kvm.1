Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2586B25FA29
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 22:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781129004; cv=none; b=fhqNdKc9uhdK1gPIY9ZpZFnX3pqb0pQTBrL7oGfc8N4TEQJ5HeGWPHPhq1fysR0vmSwWErf/7aZ6E8b9hOI5zJeSBJEHgnJWnzZ7lLkVOghyCrumNkntpsZS69cnT/dasxh4xiGKbKFTViSIetE5BU3ZDkORsPloe7ZbXFHLVfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781129004; c=relaxed/simple;
	bh=nheBNGaw97TpzI1zmdruqm7Ipd6DcbencB45iFMYYMk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fLuwn6n7SEy294YSmKalXhp/fbpk+UmoXxDFYCY3w9n4sryB2xXjBMTGDB9GeVF1bXgs4q9RBC5taqRNdnzZqBZ8F0+eREs29PPrguAGxDzUBuxDoRaHiW6gPGiPhQESUM7NQMGaxGO7lBDFOfxFsF9JA6h4mmiPnmHjKlwzXUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wH4s+ZCG; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wH4s+ZCG"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf30576aa3so51966885ad.3
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 15:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781129002; x=1781733802; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3psOLoL3icBiF1QAROgsPjuG1TPfVpq+Adw8QKSf5l0=;
        b=wH4s+ZCG4wp0MCA8bKdHf6aJHFnch4/rbUFVdDiHjEj5DWvdl78APSlGSfphzpUris
         5z8D16ZdW+YnZ6Tj4EMxAhilFMzABlbfRyNxloWqGfJzhfESxW+V0Cz2Ax1bGRwLYpYm
         LyUR2z+q1jDJTlE2eEdxlv2ZbAXzNlRPBJvkakAxmG3vme7dYtdv5SnIa83mvrLOwJfl
         a8SgnH9wpqrOvlnKsqLkt6IT+pbM0/fPMc600/I6VVqGSdaox2ToxgkKGZ0KyH4DaH/9
         Mes4wiE8ogcB7v3zNdYgC5XWFtSwSGoRlZUIn8XXV6+Jmmh3+EK6DYxZLNPfxDWqY8uU
         1B+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781129002; x=1781733802;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3psOLoL3icBiF1QAROgsPjuG1TPfVpq+Adw8QKSf5l0=;
        b=C2LMZQUSGrNurvJnaYr1J34wO8/a+Bwa40qUg87VpF+spJ57K5iLjRM4e/VgZ2xrj9
         C4EipoU+pfJwwQwjfwCbUTOs0Qm1tZcFK7k1c5E0B/9b70pPqsl6ylZg3CkwKHl0832k
         k/7MlVEP8vjitM8din88ROEKRHOrAMRMSL5JK5vkGVyP+RQ/um+U9bV3javbtGA1i7A2
         1WhoQqGraxWPXrfUCfwFNpRINIkIDx7bUsOmh+GydYmPkXLahHg+604o0y+UHx9N4+MY
         QBdXFlGDHXIFkxXe3WPZ5/Is8x3yew6dM9IMrz9u4o9IkKFcQXocngm8ZVLRSTznLm00
         iHvg==
X-Forwarded-Encrypted: i=1; AFNElJ+9XIWAVTQNx5Hywo1l7TUWv3ReJLzEp8DDIR9g1x4WcnDE6GUSJDUusTC9jI8WDeN+rwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9SXlo3N0hMwzqRE2lwdi3jtuh28hrvw7LezlqgeNY6BNkLBTW
	eyOUvZ/sqtf1oaMQO+NUWadDL+w9sc0GzIl4Hw2vZ6b+B3nZ4m7RYWd5No4PcT0Q10Gd4g2Z0Pf
	twQTcBg==
X-Received: from plk18.prod.google.com ([2002:a17:902:e9d2:b0:2ba:36eb:2f7c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2381:b0:2c2:27be:39a7
 with SMTP id d9443c01a7336-2c2a1c9ac2emr111544175ad.29.1781129002326; Wed, 10
 Jun 2026 15:03:22 -0700 (PDT)
Date: Wed, 10 Jun 2026 15:03:21 -0700
In-Reply-To: <20260423174639.56149-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423174639.56149-1-zide.chen@intel.com>
Message-ID: <ainfKdOgKp9i2qDP@google.com>
Subject: Re: [PATCH V2 0/4] KVM: x86/pmu: Add hardware Topdown metrics support
From: Sean Christopherson <seanjc@google.com>
To: Zide Chen <zide.chen@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 23, 2026, Zide Chen wrote:
> The Top-Down Microarchitecture Analysis (TMA) method is a structured
> approach for identifying performance bottlenecks in out-of-order
> processors.
> 
> Currently, guests support the TMA method by collecting Topdown events
> using GP counters, which may trigger multiplexing.  To free up scarce
> GP counters, eliminate multiplexing-induced skew, and obtain coherent
> Topdown metric ratios, it is desirable to expose fixed counter 3 and
> the IA32_PERF_METRICS MSR to guests.
> 
> Several attempts have been made to virtualize this under the legacy
> vPMU model [1][2][3], but they were unsuccessful.  With the new mediated
> vPMU, enabling TMA support in guests becomes much simpler.  It avoids
> invasive changes to the perf core, eliminates CPU pinning and
> fixed-counter affinity issues, and reduces the latge overhead of
> trapping and emulating MSR accesses.

Please submit a new version of this to address Dapeng's feedback, rebase on the
latest kvm-x86/next, and perhaps most importantly, to let Sashiko take a crack
at it.

Thanks!
